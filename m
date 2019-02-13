From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 15/32] powerpc/pci: remove the dma_set_mask pci_controller ops methods
Date: Wed, 13 Feb 2019 08:01:16 +0100
Message-ID: <20190213070133.11259-16-hch@lst.de>
References: <20190213070133.11259-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190213070133.11259-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Unused now.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/include/asm/pci-bridge.h | 2 --
 arch/powerpc/kernel/dma.c             | 7 -------
 2 files changed, 9 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 236a7460b6ec..98e8b46aff97 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -45,8 +45,6 @@ struct pci_controller_ops {
 	void		(*teardown_msi_irqs)(struct pci_dev *pdev);
 #endif
 
-	int             (*dma_set_mask)(struct pci_dev *pdev, u64 dma_mask);
-
 	void		(*shutdown)(struct pci_controller *hose);
 };
 
diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index 0d52107b90f0..5eca02315b2e 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -304,13 +304,6 @@ int dma_set_mask(struct device *dev, u64 dma_mask)
 	if (ppc_md.dma_set_mask)
 		return ppc_md.dma_set_mask(dev, dma_mask);
 
-	if (dev_is_pci(dev)) {
-		struct pci_dev *pdev = to_pci_dev(dev);
-		struct pci_controller *phb = pci_bus_to_host(pdev->bus);
-		if (phb->controller_ops.dma_set_mask)
-			return phb->controller_ops.dma_set_mask(pdev, dma_mask);
-	}
-
 	if (!dev->dma_mask || !dma_supported(dev, dma_mask))
 		return -EIO;
 	*dev->dma_mask = dma_mask;
-- 
2.20.1
