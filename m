From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2 4/9] powerpc/powernv/npu: use helper pci_dev_id
Date: Wed, 24 Apr 2019 21:14:25 +0200
Message-ID: <8ed5b4ee-3226-6786-eb96-886826e180cd@gmail.com>
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
 arch/powerpc/platforms/powernv/npu-dma.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
index dc23d9d2a..495550432 100644
--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -1213,9 +1213,8 @@ int pnv_npu2_map_lpar_dev(struct pci_dev *gpdev, unsigned int lparid,
 	 * Currently we only support radix and non-zero LPCR only makes sense
 	 * for hash tables so skiboot expects the LPCR parameter to be a zero.
 	 */
-	ret = opal_npu_map_lpar(nphb->opal_id,
-			PCI_DEVID(gpdev->bus->number, gpdev->devfn), lparid,
-			0 /* LPCR bits */);
+	ret = opal_npu_map_lpar(nphb->opal_id, pci_dev_id(gpdev), lparid,
+				0 /* LPCR bits */);
 	if (ret) {
 		dev_err(&gpdev->dev, "Error %d mapping device to LPAR\n", ret);
 		return ret;
@@ -1224,7 +1223,7 @@ int pnv_npu2_map_lpar_dev(struct pci_dev *gpdev, unsigned int lparid,
 	dev_dbg(&gpdev->dev, "init context opalid=%llu msr=%lx\n",
 			nphb->opal_id, msr);
 	ret = opal_npu_init_context(nphb->opal_id, 0/*__unused*/, msr,
-			PCI_DEVID(gpdev->bus->number, gpdev->devfn));
+				    pci_dev_id(gpdev));
 	if (ret < 0)
 		dev_err(&gpdev->dev, "Failed to init context: %d\n", ret);
 	else
@@ -1258,7 +1257,7 @@ int pnv_npu2_unmap_lpar_dev(struct pci_dev *gpdev)
 	dev_dbg(&gpdev->dev, "destroy context opalid=%llu\n",
 			nphb->opal_id);
 	ret = opal_npu_destroy_context(nphb->opal_id, 0/*__unused*/,
-			PCI_DEVID(gpdev->bus->number, gpdev->devfn));
+				       pci_dev_id(gpdev));
 	if (ret < 0) {
 		dev_err(&gpdev->dev, "Failed to destroy context: %d\n", ret);
 		return ret;
@@ -1266,9 +1265,8 @@ int pnv_npu2_unmap_lpar_dev(struct pci_dev *gpdev)
 
 	/* Set LPID to 0 anyway, just to be safe */
 	dev_dbg(&gpdev->dev, "Map LPAR opalid=%llu lparid=0\n", nphb->opal_id);
-	ret = opal_npu_map_lpar(nphb->opal_id,
-			PCI_DEVID(gpdev->bus->number, gpdev->devfn), 0 /*LPID*/,
-			0 /* LPCR bits */);
+	ret = opal_npu_map_lpar(nphb->opal_id, pci_dev_id(gpdev), 0 /*LPID*/,
+				0 /* LPCR bits */);
 	if (ret)
 		dev_err(&gpdev->dev, "Error %d mapping device to LPAR\n", ret);
 
-- 
2.21.0
