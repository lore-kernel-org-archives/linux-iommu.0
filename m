From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Subject: [PATCH] dma-direct: Fix return value of dma_direct_supported
Date: Wed, 03 Oct 2018 16:48:07 -0700
Message-ID: <20181003234746.3586.42014.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: benh@kernel.crashing.org, robin.murphy@arm.com, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, linuxppc-dev@lists.ozlabs.org, linux@roeck-us.net
List-Id: iommu@lists.linux-foundation.org

It appears that in commit 9d7a224b463e ("dma-direct: always allow dma mask
<= physiscal memory size") the logic of the test was changed from a "<" to
a ">=" however I don't see any reason for that change. I am assuming that
there was some additional change planned, specifically I suspect the logic
was intended to be reversed and possibly used for a return. Since that is
the case I have gone ahead and done that.

This addresses issues I had on my system that prevented me from booting
with the above mentioned commit applied on an x86_64 system w/ Intel IOMMU.

Fixes: 9d7a224b463e ("dma-direct: always allow dma mask <= physiscal memory size")
Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 kernel/dma/direct.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 5a0806b5351b..65872f6c2e93 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -301,9 +301,7 @@ int dma_direct_supported(struct device *dev, u64 mask)
 
 	min_mask = min_t(u64, min_mask, (max_pfn - 1) << PAGE_SHIFT);
 
-	if (mask >= phys_to_dma(dev, min_mask))
-		return 0;
-	return 1;
+	return mask >= phys_to_dma(dev, min_mask);
 }
 
 int dma_direct_mapping_error(struct device *dev, dma_addr_t dma_addr)
