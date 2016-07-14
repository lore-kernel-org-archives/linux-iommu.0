From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/iova: validate iova_domain input to put_iova_domain
Date: Thu, 14 Jul 2016 11:36:53 +0100
Message-ID: <57876B45.6010206@arm.com>
References: <1468435772-27905-1-git-send-email-nwatters@codeaurora.org>
 <20160714083420.GR12639@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160714083420.GR12639@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, Nate Watterson <nwatters@codeaurora.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 14/07/16 09:34, Joerg Roedel wrote:
> On Wed, Jul 13, 2016 at 02:49:32PM -0400, Nate Watterson wrote:
>> Passing a NULL or uninitialized iova_domain into put_iova_domain
>> will currently crash the kernel when the unconfigured iova_domain
>> data members are accessed. To prevent this from occurring, this patch
>> adds a check to make sure that the domain is non-NULL and that the
>> domain granule is non-zero. The granule can be used to check if the
>> domain was properly initialized because calling init_iova_domain
>> with a granule of zero would have already triggered a BUG statement
>> crashing the kernel.
> 
> Have you seen real crashes happening because of this?

It _can_ happen via the iommu-dma code if something goes wrong
initialising a group - the IOVA domain gets allocated at the same time
as the default IOMMU domain, but isn't initialised until later once the
device in question gets ity dma ops set up. If adding the device to the
group fails, everything gets torn down again and iommu_put_dma_cookie()
ends up trying to take an uninitialised lock .

However, I think the appropriate fix for that particular situation would
be more like this:

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index ea5a9ebf0f78..d00d22930a6b 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -65,10 +65,11 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
 {
        struct iova_domain *iovad = domain->iova_cookie;

-       if (!iovad)
+       if (domain->type != IOMMU_DOMAIN_DMA || !iovad)
                return;

-       put_iova_domain(iovad);
+       if (iovad->granule)
+               put_iova_domain(iovad);
        kfree(iovad);
        domain->iova_cookie = NULL;
 }

(It probably should have been that way from the start; mea culpa)

Robin.
