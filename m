From: Tushar Dave <tushar.n.dave@oracle.com>
Subject: intel-iommu: Is this a bug?
Date: Mon, 26 Mar 2018 18:09:02 -0700
Message-ID: <66db7b28-5749-1d13-b228-88b34087f3b6@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: dwmw2@infradead.org, joro@8bytes.org, iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi,

I am analyzing network performance with intel-iommu enabled.
And found that running with iommu=pt, for every dma map/unmap it
executes this code:

/*
          * At boot time, we don't yet know if devices will be 64-bit 
capable.
          * Assume that they will — if they turn out not to be, then we can
          * take them out of the 1:1 domain later.
          */
         if (!startup) {
                 /*
                  * If the device's dma_mask is less than the system's 
memory
                  * size then this is not a candidate for identity mapping.
                  */
                 u64 dma_mask = *dev->dma_mask;

                 if (dev->coherent_dma_mask &&
                     dev->coherent_dma_mask < dma_mask)
                         dma_mask = dev->coherent_dma_mask;

                 return dma_mask >= dma_get_required_mask(dev);
         }


Do we really need this check for every dma/unmap?
Considering it should be only during startup, shouldn't it be,

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 582fd01..3c8f14e 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2929,7 +2929,7 @@ static int iommu_should_identity_map(struct device 
*dev, int startup)
          * Assume that they will — if they turn out not to be, then we can
          * take them out of the 1:1 domain later.
          */
-       if (!startup) {
+       if (startup) {
                 /*
                  * If the device's dma_mask is less than the system's 
memory
                  * size then this is not a candidate for identity mapping.


Thanks.

-Tushar
