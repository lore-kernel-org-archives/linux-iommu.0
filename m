From: Jerry Snitselaar <jsnitsel@redhat.com>
Subject: Re: [PATCH] iommu: amd: call free_iova_fast with pfn in map_sg
Date: Sat, 19 Jan 2019 10:36:11 -0700
Message-ID: <20190119173611.reqzqxwgf2z22gby@cantor>
References: <20190117192902.15158-1-jsnitsel@redhat.com>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190117192902.15158-1-jsnitsel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
List-Id: iommu@lists.linux-foundation.org

On Thu Jan 17 19, Jerry Snitselaar wrote:
>In the error path of map_sg, free_iova_fast is being called with
>address instead of the pfn. This results in a bad value getting into
>the rcache, and can result in hitting a BUG_ON when
>iova_magazine_free_pfns is called.
>
>Cc: Joerg Roedel <joro@8bytes.org>
>Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
>---
> drivers/iommu/amd_iommu.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
>index 87ba23a75b38..418df8ff3e50 100644
>--- a/drivers/iommu/amd_iommu.c
>+++ b/drivers/iommu/amd_iommu.c
>@@ -2623,7 +2623,7 @@ static int map_sg(struct device *dev, struct scatterlist *sglist,
> 	}
>
> out_free_iova:
>-	free_iova_fast(&dma_dom->iovad, address, npages);
>+	free_iova_fast(&dma_dom->iovad, address >> PAGE_SHIFT, npages);
>
> out_err:
> 	return 0;
>-- 
>2.20.1.98.gecbdaf0899
>


I forgot to add the Fixes line.

Fixes: 80187fd39dcb ("iommu/amd: Optimize map_sg and unmap_sg")
