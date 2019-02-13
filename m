From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 05/32] powerpc/pseries: unwind dma_get_required_mask_pSeriesLP a bit
Date: Wed, 13 Feb 2019 08:01:06 +0100
Message-ID: <20190213070133.11259-6-hch@lst.de>
References: <20190213070133.11259-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190213070133.11259-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Call dma_get_required_mask_pSeriesLP directly instead of dma_iommu_ops
to simply the code a bit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/platforms/pseries/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 8fc8fe0b9848..9f7ac75c5687 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -1278,7 +1278,7 @@ static u64 dma_get_required_mask_pSeriesLP(struct device *dev)
 			return DMA_BIT_MASK(64);
 	}
 
-	return dma_iommu_ops.get_required_mask(dev);
+	return dma_iommu_get_required_mask(dev);
 }
 
 static int iommu_mem_notifier(struct notifier_block *nb, unsigned long action,
-- 
2.20.1
