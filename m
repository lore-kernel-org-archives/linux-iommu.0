From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2 9/9] platform/chrome: chromeos_laptop: use helper
 pci_dev_id
Date: Wed, 24 Apr 2019 21:17:19 +0200
Message-ID: <e882f58b-0808-952e-d293-5e8cc3f04c97@gmail.com>
References: <2e1f9a57-6d08-d017-24da-3e6b97fa2449@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2e1f9a57-6d08-d017-24da-3e6b97fa2449@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Oded Gabbay <oded.gabbay@gmail.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Realtek linux nic maintainers <nic_swsd@realtek.com>, "David S. Miller" <davem@davemloft.net>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, Alexandre Torgue <alexandre.torgue@st.com>, Jose Abreu <joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, Benson Leung <bleung@chromium.org>
Cc: open list <linux-kernel@vger.kernel.org>, "open list:AMD KFD" <dri-devel@lists.freedesktop.org>, "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>, "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>, "open list:8169 10/100/1000 GIGABIT ETHERNET DRIVER" <netdev@vger.kernel.org>, "moderated list:ARM/STM32 ARCHITECTURE" <linux-stm32@st-md-mailman.stormreply.com>, "moderated list:ARM/STM32 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

Use new helper pci_dev_id() to simplify the code.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/platform/chrome/chromeos_laptop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/chromeos_laptop.c b/drivers/platform/chrome/chromeos_laptop.c
index 24326eecd..7abbb6167 100644
--- a/drivers/platform/chrome/chromeos_laptop.c
+++ b/drivers/platform/chrome/chromeos_laptop.c
@@ -125,7 +125,7 @@ static bool chromeos_laptop_match_adapter_devid(struct device *dev, u32 devid)
 		return false;
 
 	pdev = to_pci_dev(dev);
-	return devid == PCI_DEVID(pdev->bus->number, pdev->devfn);
+	return devid == pci_dev_id(pdev);
 }
 
 static void chromeos_laptop_check_adapter(struct i2c_adapter *adapter)
-- 
2.21.0
