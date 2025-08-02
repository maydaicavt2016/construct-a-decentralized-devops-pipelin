import Foundation

// Define a protocol for pipeline tracker
protocol PipelineTracker {
    associatedtype PipelineIdentifier: Hashable
    var pipelineID: PipelineIdentifier { get }
    var stages: [Stage] { get set }
    func addStage(_ stage: Stage)
    func updateStage(_ stage: Stage, status: StageStatus)
    func getCurrentStage() -> Stage?
}

// Define a struct for Stage
struct Stage: Identifiable, Hashable {
    let id = UUID()
    var name: String
    var status: StageStatus
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Stage, rhs: Stage) -> Bool {
        lhs.id == rhs.id
    }
}

// Define an enum for StageStatus
enum StageStatus: String, CaseIterable {
    case pending, inProgress, completed, failed
}

// Define a class for DecentralizedPipelineTracker
class DecentralizedPipelineTracker: PipelineTracker {
    typealias PipelineIdentifier = String
    
    let pipelineID: PipelineIdentifier
    var stages: [Stage] = []
    
    init(pipelineID: PipelineIdentifier) {
        self.pipelineID = pipelineID
    }
    
    func addStage(_ stage: Stage) {
        stages.append(stage)
    }
    
    func updateStage(_ stage: Stage, status: StageStatus) {
        if let index = stages.firstIndex(of: stage) {
            stages[index].status = status
        }
    }
    
    func getCurrentStage() -> Stage? {
        return stages.first(where: { $0.status == .inProgress })
    }
}

// Define a class for Blockchain
class Blockchain {
    var pipelineTrackers: [DecentralizedPipelineTracker] = []
    
    func addPipelineTracker(_ tracker: DecentralizedPipelineTracker) {
        pipelineTrackers.append(tracker)
    }
    
    func updatePipelineTracker(_ tracker: DecentralizedPipelineTracker) {
        if let index = pipelineTrackers.firstIndex(where: { $0.pipelineID == tracker.pipelineID }) {
            pipelineTrackers[index] = tracker
        }
    }
}

// Define a function to create a decentralized DevOps pipeline tracker
func createDecentralizedPipelineTracker(pipelineID: String) -> DecentralizedPipelineTracker {
    return DecentralizedPipelineTracker(pipelineID: pipelineID)
}

// Define a function to add a stage to a pipeline tracker
func addStageToPipelineTracker(_ tracker: DecentralizedPipelineTracker, stage: Stage) {
    tracker.addStage(stage)
}

// Define a function to update a stage in a pipeline tracker
func updateStageInPipelineTracker(_ tracker: DecentralizedPipelineTracker, stage: Stage, status: StageStatus) {
    tracker.updateStage(stage, status: status)
}

// Define a function to get the current stage of a pipeline tracker
func getCurrentStageOfPipelineTracker(_ tracker: DecentralizedPipelineTracker) -> Stage? {
    return tracker.getCurrentStage()
}

// Define a function to add a pipeline tracker to a blockchain
func addPipelineTrackerToBlockchain(_ blockchain: Blockchain, _ tracker: DecentralizedPipelineTracker) {
    blockchain.addPipelineTracker(tracker)
}

// Define a function to update a pipeline tracker in a blockchain
func updatePipelineTrackerInBlockchain(_ blockchain: Blockchain, _ tracker: DecentralizedPipelineTracker) {
    blockchain.updatePipelineTracker(tracker)
}