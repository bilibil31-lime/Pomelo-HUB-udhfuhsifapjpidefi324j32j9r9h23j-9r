-- [[ Pomelo Byte : Key System ]] --
-- ตรงนี้คือส่วนที่คุณจะเขียนโค้ด UI หน้าต่างใส่คีย์ของคุณ

local correct_key = "PomeloTestKey_123" -- (ตัวอย่างคีย์)

-- สมมติฟังก์ชันเมื่อผู้ใช้กดปุ่ม "Submit/Login"
local function onSubmitKey(inputKey)
    if inputKey == correct_key then
        print("Key Correct! Welcome to Pomelo Byte.")
        
        -- ลบหน้าต่าง Key ทิ้งไปก่อน
        -- DestroyKeyUI() 
        
        -- โหลดหน้าต่าง Main UI ทันทีเมื่อคีย์ถูก
        loadstring(game:HttpGet("https://raw.githubusercontent.com/YOUR_GITHUB_NAME/PomeloByte_Project/main/Core/pomelo_main.lua"))()
    else
        print("Invalid Key! Please get a new key.")
        -- แจ้งเตือนผู้ใช้ว่าคีย์ผิด
    end
end

-- จำลองการทำงาน (ให้ลบบรรทัดนี้ออกตอนต่อกับ UI จริง)
onSubmitKey("PomeloTestKey_123")
