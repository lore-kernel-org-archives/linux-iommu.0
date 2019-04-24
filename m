From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2 2/9] PCI: use helper pci_dev_id
Date: Wed, 24 Apr 2019 21:12:45 +0200
Message-ID: <9cc03738-f664-3896-d8eb-48146772a655@gmail.com>
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
 drivers/pci/msi.c    |  6 +++---
 drivers/pci/search.c | 10 +++-------
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 73986825d..e039b740f 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1338,7 +1338,7 @@ irq_hw_number_t pci_msi_domain_calc_hwirq(struct pci_dev *dev,
 					  struct msi_desc *desc)
 {
 	return (irq_hw_number_t)desc->msi_attrib.entry_nr |
-		PCI_DEVID(dev->bus->number, dev->devfn) << 11 |
+		pci_dev_id(dev) << 11 |
 		(pci_domain_nr(dev->bus) & 0xFFFFFFFF) << 27;
 }
 
@@ -1508,7 +1508,7 @@ static int get_msi_id_cb(struct pci_dev *pdev, u16 alias, void *data)
 u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev)
 {
 	struct device_node *of_node;
-	u32 rid = PCI_DEVID(pdev->bus->number, pdev->devfn);
+	u32 rid = pci_dev_id(pdev);
 
 	pci_for_each_dma_alias(pdev, get_msi_id_cb, &rid);
 
@@ -1531,7 +1531,7 @@ u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev)
 struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev)
 {
 	struct irq_domain *dom;
-	u32 rid = PCI_DEVID(pdev->bus->number, pdev->devfn);
+	u32 rid = pci_dev_id(pdev);
 
 	pci_for_each_dma_alias(pdev, get_msi_id_cb, &rid);
 	dom = of_msi_map_get_device_domain(&pdev->dev, rid);
diff --git a/drivers/pci/search.c b/drivers/pci/search.c
index 2b5f72086..5c7922612 100644
--- a/drivers/pci/search.c
+++ b/drivers/pci/search.c
@@ -33,7 +33,7 @@ int pci_for_each_dma_alias(struct pci_dev *pdev,
 	struct pci_bus *bus;
 	int ret;
 
-	ret = fn(pdev, PCI_DEVID(pdev->bus->number, pdev->devfn), data);
+	ret = fn(pdev, pci_dev_id(pdev), data);
 	if (ret)
 		return ret;
 
@@ -88,9 +88,7 @@ int pci_for_each_dma_alias(struct pci_dev *pdev,
 					return ret;
 				continue;
 			case PCI_EXP_TYPE_PCIE_BRIDGE:
-				ret = fn(tmp,
-					 PCI_DEVID(tmp->bus->number,
-						   tmp->devfn), data);
+				ret = fn(tmp, pci_dev_id(tmp), data);
 				if (ret)
 					return ret;
 				continue;
@@ -101,9 +99,7 @@ int pci_for_each_dma_alias(struct pci_dev *pdev,
 					 PCI_DEVID(tmp->subordinate->number,
 						   PCI_DEVFN(0, 0)), data);
 			else
-				ret = fn(tmp,
-					 PCI_DEVID(tmp->bus->number,
-						   tmp->devfn), data);
+				ret = fn(tmp, pci_dev_id(tmp), data);
 			if (ret)
 				return ret;
 		}
-- 
2.21.0
