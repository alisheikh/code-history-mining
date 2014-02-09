package historystorage
import com.intellij.openapi.project.Project
import com.intellij.openapi.util.io.FileUtil
import util.Log
import util.Measure
import vcsaccess.HistoryGrabberConfig

class HistoryStorage {
	private final String basePath
	private final Log log
	private final Measure measure

	HistoryStorage(String basePath, Measure measure, Log log = null) {
		this.basePath = basePath
		this.measure = measure
		this.log = log
	}

	File[] filesWithCodeHistory() {
		new File(basePath).listFiles(new FileFilter() {
			@Override boolean accept(File pathName) { pathName.name.endsWith(".csv") }
		})
	}

	HistoryGrabberConfig loadGrabberConfigFor(Project project) {
		HistoryGrabberConfig.loadGrabberConfigFor(project, basePath) {
			def outputFilePath = "${basePath}/${project.name + "-file-events.csv"}"
			new HistoryGrabberConfig(new Date() - 300, new Date(), outputFilePath, false)
		}
	}

	def saveGrabberConfigFor(Project project, HistoryGrabberConfig config) {
		HistoryGrabberConfig.saveGrabberConfigOf(project, basePath, config)
	}

	boolean isValidName(String fileName) {
		fileName.length() > 0 && !new File("$basePath/$fileName").exists()
	}

	def rename(String fileName, String newFileName) {
		FileUtil.rename(new File("$basePath/$fileName"), new File("$basePath/$newFileName"))
	}

	def delete(String fileName) {
		FileUtil.delete(new File("$basePath/$fileName"))
	}

	def readAllEvents(String fileName, Closure<Void> checkIfCancelled) {
		measure.measure("Storage.readAllEvents"){
			new EventStorage("$basePath/$fileName").readAllEvents(checkIfCancelled){ line, e -> log?.failedToRead(line) }
		}
	}

	String guessProjectNameFrom(String fileName) {
		fileName.replace(".csv", "").replace("-file-events", "")
	}

	def eventStorageFor(String filePath) {
		new EventStorage(filePath)
	}
}