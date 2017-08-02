import UIKit
import AudioToolbox

class ViewController: UIViewController {
    
    // 変数宣言と初期化
    var point: Int = 0
    var quizNumber: Int = 0
    var quizArray: [Quiz] = []
    var rand: Int = 0
    var count = 0
    var numberArray: [Int] = []
    var quizs: [Quiz] = []
    // Storyboard上のパーツについて宣言
    @IBOutlet var quizNumberLabel: UILabel!
    @IBOutlet var quizTextView: UITextView!
    @IBOutlet var option1Button: UIButton!
    @IBOutlet var option2Button: UIButton!
    @IBOutlet var option3Button: UIButton!
    @IBOutlet var option4Button: UIButton!
    
    
    // 画面起動時に呼ばれる
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // クイズのセットアップ
        setUpQuiz()
        
        // クイズ番号、クイズ、各選択肢の表示
        showQuiz()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // クイズのセットアップ
    func setUpQuiz() {
        let quiz1 = Quiz(text: "幻と言われる白色の西武線は何色？", option1: "青", option2: "白", option3: "緑",option4: "赤", answer: "白")
        let quiz2 = Quiz(text: "小平市の特産物は？", option1: "ブルーベリー", option2: "トウモロコシ", option3: "イチゴ", option4: "大根", answer: "ブルーベリー")
        let quiz3 = Quiz(text: "小平市は第何小学校まである？", option1: "3", option2: "6", option3: "15", option4: "18", answer: "15")
        let quiz4 = Quiz(text: "西武多摩湖線が通る駅はいくつ？", option1: "2", option2: "4", option3: "16", option4: "20", answer: "4")
        let quiz5 = Quiz(text: "署名運動が起きて廃止を阻止した路線はどこ？", option1: "西武国分寺線", option2: "西武多摩川線", option3: "西武多摩湖線", option4: "西武山口線", answer: "西武多摩湖線")
        let quiz6 = Quiz(text: "小平市のご当地ヒーローの名前は？", option1: "地域戦隊コダイラレンジャー", option2: "地域戦隊コダレンジャー", option3: "地域宣伝隊コダイラレンジャー",option4: "地域宣伝隊コダレンジャー", answer: "地域宣伝隊コダレンジャー")
        let quiz7 = Quiz(text: "小平市内に実在する子供達の憩いの場は？", option1: "群青公園", option2: "ワクワク公園", option3: "あかね公園", option4: "のびのび広場", answer: "のびのび広場")
        let quiz8 = Quiz(text: "萩山駅から新宿駅に向かう場合、乗り換え数は何回？", option1: "1", option2: "2", option3: "3", option4: "4", answer: "1")
        let quiz9 = Quiz(text: "合っている情報はどれ？", option1: "一橋学園駅は駅員が常に2人いる", option2: "一橋学園駅は改札を通った後に踏切を渡る", option3: "野良猫がいない", option4: "市内にローソンがない", answer: "一橋学園駅は改札を通った後に踏切を渡る")
        let quiz10 = Quiz(text: "合っている情報はどれ？", option1: "エド・はるみの出身地である", option2: "西武多摩湖線の終電は意外に長い", option3: "小平市は北海道に姉妹都市がある", option4: "小平市内には図書館が2つしかない", answer: "小平市は北海道に姉妹都市がある")
        
        
        quizs = [quiz1,quiz2,quiz3,quiz4,quiz5,quiz6,quiz7,quiz8,quiz9,quiz10]
        
        
        
        
        
        // quizArray配列に問題を追加
        
        numberArray = []
        quizArray = []
        while true {
            rand = Int(arc4random_uniform(10))
            if numberArray.contains(rand) {
                continue
            }
            else{
                numberArray.append(rand)
                if numberArray.count == 5{
                    break
                }
            }
        }
        
        for i in 0...4 {
            quizArray.append(quizs[numberArray[i]])
            print(numberArray[i])
        }
        /*quizArray.append(quiz1)
         quizArray.append(quiz2)
         quizArray.append(quiz3)
         quizArray.append(quiz4)
         quizArray.append(quiz5)
         */
        
        
        // quizArrayをシャッフルして、入れ直す
        quizArray = Quiz.shuffle(quizArray: quizArray)
    }
    
    
    // クイズを各パーツに表示
    func showQuiz() {
        // クイズ番号、クイズ、各選択肢の表示
        quizNumberLabel.text = String(quizNumber + 1) + "問目/"
        quizTextView.text = quizArray[quizNumber].text
        option1Button.setTitle(quizArray[quizNumber].option1, for: .normal)
        option2Button.setTitle(quizArray[quizNumber].option2, for: .normal)
        option3Button.setTitle(quizArray[quizNumber].option3, for: .normal)
        option4Button.setTitle(quizArray[quizNumber].option4, for: .normal)
    }
    
    // クイズの各データをリセット
    func resetQuiz() {
        numberArray = []
        quizArray = []
        while true {
            rand = Int(arc4random_uniform(10))
            if numberArray.contains(rand) {
                continue
            }
            else{
                numberArray.append(rand)
                if numberArray.count == 5{
                    break
                }
            }
        }
        
        for i in 0...4 {
            quizArray.append(quizs[numberArray[i]])
            print(numberArray[i])
        }
        
        point = 0
        quizNumber = 0
        //self.quizArray = Quiz.shuffle(quizArray: self.quizArray)
        self.showQuiz()
    }
    
    // クイズをアップデート
    func updateQuiz() {
        // 問題番号を更新
        quizNumber = quizNumber + 1
        
        // もし最終問題をとき終えたら、アラートを出すして結果表示
        if quizNumber == quizArray.count {
            let ud = UserDefaults.standard
            
            let scores = [Int(arc4random_uniform(60)+40),Int(arc4random_uniform(60)+40),Int(arc4random_uniform(60)+40),Int(arc4random_uniform(60)+40),Int(arc4random_uniform(60)+40)]
            ud.set(scores, forKey: "Scores")
            ud.synchronize()
            
            

            if quizArray.count == point {
                let alertText = "全問正解"
                var soundIdRing:SystemSoundID = 0
                if let soundUrl:NSURL = NSURL.fileURL(withPath: Bundle.main.path(forResource: "trumpet1", ofType:"mp3")!) as NSURL?{
                    AudioServicesCreateSystemSoundID(soundUrl, &soundIdRing)
                    AudioServicesPlaySystemSound(soundIdRing)
                }
                let alertController = UIAlertController(title: "結果", message: alertText, preferredStyle: .alert)
                let checkAction = UIAlertAction(title: "小平への適性度を確認", style: .default, handler: { (action) in
                self.resetQuiz()
                self.performSegue(withIdentifier: "toRadarChart", sender: nil)
                })
                let imageInstallAction = UIAlertAction(title: "特典ダウンロードページへ", style: .default, handler: { (action) in
                self.resetQuiz()
                self.performSegue(withIdentifier: "toImageInstall", sender: nil)
                })
                let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                    self.resetQuiz()
                })
                alertController.addAction(imageInstallAction)
                alertController.addAction(checkAction)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
        
            else {
                let ud = UserDefaults.standard
                let scores = [Int(arc4random_uniform(60)+40),Int(arc4random_uniform(60)+40),Int(arc4random_uniform(60)+40),Int(arc4random_uniform(60)+40),Int(arc4random_uniform(60)+40)]
                ud.set(scores, forKey: "Scores")
                ud.synchronize()
                let alertText = "\(quizArray.count)問中\(point)問正解"
                let alertController = UIAlertController(title: "結果", message: alertText, preferredStyle: .alert)
                let checkAction = UIAlertAction(title: "小平への適性度を確認", style: .default, handler: { (action) in
                    self.resetQuiz()
                    self.performSegue(withIdentifier: "toRadarChart", sender: nil)
                })
                let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                    self.resetQuiz()
                })
                alertController.addAction(checkAction)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
            else {
                // 最終問題以外では次の問題を表示
                showQuiz()
            }
        
    }
    
    // 選択肢1が押されたときの処理
    @IBAction func selectOption1() {
        // ボタン内の文言と、もともと設定していた答えが一致しているか確認
        if option1Button.titleLabel?.text == quizArray[quizNumber].answer {
            print("正解！")
            // 正解ポイント追加
            point = point + 1
        } else {
            print("不正解！")
        }
        
        // 次の問題へ
        updateQuiz()
    }
    
    // 選択肢2が押されたときの処理
    @IBAction func selectOption2() {
        // ボタン内の文言と、もともと設定していた答えが一致しているか確認
        if option2Button.titleLabel?.text == quizArray[quizNumber].answer {
            print("正解！")
            // 正解ポイント追加
            point = point + 1
        } else {
            print("不正解！")
        }
        
        // 次の問題へ
        updateQuiz()
    }
    
    // 選択肢3が押されたときの処理
    @IBAction func selectOption3() {
        // ボタン内の文言と、もともと設定していた答えが一致しているか確認
        if option3Button.titleLabel?.text == quizArray[quizNumber].answer {
            print("正解！")
            // 正解ポイント追加
            point = point + 1
        } else {
            print("不正解！")
        }
        // 次の問題へ
        updateQuiz()
    }
    
    @IBAction func selectOption4() {
        // ボタン内の文言と、もともと設定していた答えが一致しているか確認
        if option4Button.titleLabel?.text == quizArray[quizNumber].answer {
            print("正解！")
            // 正解ポイント追加
            point = point + 1
        } else {
            print("不正解！")
        }
        // 次の問題へ
        updateQuiz()
    }
    
}

