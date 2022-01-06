# Nezuko truy tìm kho báu
Trò chơi trắc nghiệm giải đố dành cho các bạn 7-8 tuổi, với một điểm khác biệt là mọi câu trả lời của bạn sẽ giúp bạn Nezuko tương tác trong ngục tối 3D. Hãy cùng giúp Nezuko đi tới nơi sâu nhất của ngục tối và đem về kho báu cho gia đình nào!

## Các tính năng nổi bật
- 2 màn chơi với các câu có độ khó ngẫu nhiên, tăng dần...
- Câu trả lời của bạn sẽ trực tiếp ảnh hưởng đến việc Nezuko có tìm được kho báu, hay đâm phải cạm bẫy hay không.
- Số điểm của bạn sẽ quyết định bạn có đi được đến phần tiếp theo và giành chiến thắng hay không.
- Phần thưởng bí mật trong game dành cho các bạn đạt điểm cao!

## Các tính năng (kỹ thuật)
- Hệ thống animation tự động hoá theo máy trạng thái và có tính ngẫu nhiên (7 trạng thái). Trong đó, animation đi kèm âm thanh, trigger các hàm automaton, gửi signal cho GUI
- Các texture được chọn lọc từ asset high poly + PBR, sau đó decimate thành low-poly và được bake rồi map normal để tăng độ chân thực, giảm tài nguyên sử dụng
- Các câu hỏi được trộn và chọn thành 1 bộ đề 10 câu ngẫu nhiên với mỗi chương
- Không gian map được thiết kế phi euclid, giúp vẫn giữ được độ liền mạch giữa các phân cảnh (node/scene) và còn giảm tài nguyên (RAM, CPU, GPU, dung lượng các map) tiêu thụ
- Các chức năng game: thời gian chơi, số câu trả lời đúng, số điểm, page phần thưởng cho điểm cao, âm thanh, toàn màn hình, tạm dừng, thoát game

## Công nghệ sử dụng

**Godot** - engine làm game tương đối mới và được nhiều nhóm làm game indie ưa chuộng trong thời gian gần đây

**Blender** - phần mềm làm 3D miễn phí mã nguồn mở cực kỳ mạnh mẽ

## Phân công công việc
- **Đào Quang Hiếu (nhóm trưởng):**
  - Đề xuất ý tưởng, sử dụng engine Godot.
  - Xây dựng logic game, logic tương tác GUI - scene 3D
  - Dựng cảnh 3D trên Godot: hiểu nôm na nghĩa là kết hợp các animation rời rạc giữa các nhân vật, âm thanh, môi trường thành 1 keyframe. Máy trạng thái kết hợp logic từ đó có thể chơi các keyframe đó
  - Rig và IK nhân vật chính (Nezuko). Nhưng sau đó không dùng mà chuyển sang dùng mixamo để tăng độ chân thực
  - Coder Godot chính. Code các thành phần giao diện trong game, máy trạng thái, logic tương tác giữa chúng (các node, 2D và 3D)

- **Đỗ Hồng Hà**
  - Tìm kiếm và xây dựng các model 3D cho scene bằng Blender
  - Dựng map trên Godot
  - Tìm kiếm nhạc nền (BGM) trên [musmus](https://musmus.main.jp/)
  - Coder Godot phụ. Code các hàm gọi chuyển động các nhân vật, cạm bẫy. Code góc nhìn, camera cho nhân vật chính

- **Nguyễn Văn Hoàn**
  - Trích xuất đáp án chương 14 (tương ứng phần 1 trong game) thành file ảnh (gõ lại, vẽ lại để tăng độ sắc nét), tạo file json chứa index đáp án
  - Tìm kiếm các animation phù hợp trong mixamo để Hà có thể sử dụng

- **Cao Thanh Hải**
  - Trích xuất đáp án chương 15 (tương ứng phần 2 trong game) thành file ảnh (gõ lại, vẽ lại để tăng độ sắc nét), tạo file json chứa index đáp án
  - Trích xuất âm thanh của nhân vật chính (Nezuko) từ trong phim

- **Nguyễn Quang Đại Dương**
  - Thiết kế giao diện GUI: ảnh nền, font, các nút, các panel. Làm bằng Photoshop và góp nhặt từ nhiều nguồn
  - Tìm kiếm, trích xuất file hiệu ứng âm thanh môi trường từ nhiều nguồn

Tất cả các thành viên trong nhóm đều đã thử làm game với Godot và có thể code, tạo scene trên này. Tuy nhiên do khối lượng công việc nhiều và có những phần công việc gối nhau cho nên phần code bọn em chỉ phân công cho 2 người làm. 

Phần gõ lại đáp án và vẽ lại hình cũng là một công việc tốn thời gian không kém so với bên code hay bên làm model.
## Video demo & hình ảnh