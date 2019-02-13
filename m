From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 01/32] net: pasemi: set a 64-bit DMA mask on the DMA device
Date: Wed, 13 Feb 2019 08:01:02 +0100
Message-ID: <20190213070133.11259-2-hch@lst.de>
References: <20190213070133.11259-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190213070133.11259-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Christian Zigotzky <chzigotzky@xenosoft.de>
List-Id: iommu@lists.linux-foundation.org

The pasemi driver never set a DMA mask, and given that the powerpc
DMA mapping routines never check it this worked ok so far.  But the
generic dma-direct code which I plan to switch on for powerpc checks
the DMA mask and fails unsupported mapping requests, so we need to
make sure the proper 64-bit mask is set.

Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>
---
 drivers/net/ethernet/pasemi/pasemi_mac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/pasemi/pasemi_mac.c b/drivers/net/ethernet/pasemi/pasemi_mac.c
index d21041554507..a5bf46310f60 100644
--- a/drivers/net/ethernet/pasemi/pasemi_mac.c
+++ b/drivers/net/ethernet/pasemi/pasemi_mac.c
@@ -1716,6 +1716,7 @@ pasemi_mac_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		err = -ENODEV;
 		goto out;
 	}
+	dma_set_mask(&mac->dma_pdev->dev, DMA_BIT_MASK(64));
 
 	mac->iob_pdev = pci_get_device(PCI_VENDOR_ID_PASEMI, 0xa001, NULL);
 	if (!mac->iob_pdev) {
-- 
2.20.1
