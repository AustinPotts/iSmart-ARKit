//
//  ViewController.swift
//  iSmart
//
//  Created by Austin Potts on 7/8/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene(named: "A_Mysterious_Adventure_-_3D_Editor_Challenge copy.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let myTouch = touches.first else { return }
        let myResult = sceneView.hitTest(myTouch.location(in: sceneView), types: [ARHitTestResult.ResultType.featurePoint])
       guard let hitResult = myResult.last else {return}
        
        let hitTransform = SCNMatrix4.init(hitResult.worldTransform)
        
        let hitVector = SCNVector3Make(hitTransform.m41, hitTransform.m42, hitTransform.m43)
        
        createBall(position: hitVector)
        //create(position: hitVector)
    }
    
    func createBall(position: SCNVector3) {
        var ballShape = SCNSphere(radius: 0.1)
        var ballNode = SCNNode(geometry: ballShape)
        ballNode.position = position
        sceneView.scene.rootNode.addChildNode(ballNode)
        
    }
    
    func create(position: SCNVector3) {
        var shape = SCNText(string: "Hello", extrusionDepth: 1)
        var shapeNode = SCNNode(geometry: shape)
        shapeNode.position = position
        sceneView.scene.rootNode.addChildNode(shapeNode)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
