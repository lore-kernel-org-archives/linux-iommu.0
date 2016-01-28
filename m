From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC PATCH 4/6] iommu/arm-smmu: Add support for IOMMU_DOMAIN_DMA
 in SMMUv1/SMMUv2 driver
Date: Thu, 28 Jan 2016 17:48:59 +0000
Message-ID: <20160128174858.GU17123@leverpostej>
References: <1453872079-27140-1-git-send-email-anup.patel@broadcom.com>
 <1453872079-27140-5-git-send-email-anup.patel@broadcom.com>
 <56AA4FBE.6090702@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56AA4FBE.6090702@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Anup Patel <anup.patel@broadcom.com>, Catalin Marinas <catalin.marinas@arm.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>, Sricharan R <sricharan@codeaurora.org>, Linux IOMMU <iommu@lists.linux-foundation.org>, Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Device Tree <devicetree@vger.kernel.org>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Vikram Prakash <vikramp@broadcom.com>, Linux Kernel <linux-kernel@vger.kernel.org>, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jan 28, 2016 at 05:28:30PM +0000, Robin Murphy wrote:
> On 27/01/16 05:21, Anup Patel wrote:
> >To allow use of large memory (> 4Gb) with 32bit devices we need to use
> >some kind of iommu for such 32bit devices.
> >
> >This patch extends SMMUv1/SMMUv2 driver to support DMA domains which
> >in-turn will allows us to use iommu based DMA mappings for 32bit devices.
> >
> >Signed-off-by: Anup Patel <anup.patel@broadcom.com>
> >Reviewed-by: Ray Jui <rjui@broadcom.com>
> >Reviewed-by: Scott Branden <sbranden@broadcom.com>
> >---
> >  drivers/iommu/arm-smmu.c | 21 ++++++++++++++++++++-
> >  1 file changed, 20 insertions(+), 1 deletion(-)
> >
> >diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> >index 9bdf6b2..43424fe 100644
> >--- a/drivers/iommu/arm-smmu.c
> >+++ b/drivers/iommu/arm-smmu.c
> >@@ -29,6 +29,7 @@
> >  #define pr_fmt(fmt) "arm-smmu: " fmt
> >
> >  #include <linux/delay.h>
> >+#include <linux/dma-iommu.h>
> >  #include <linux/dma-mapping.h>
> >  #include <linux/err.h>
> >  #include <linux/interrupt.h>
> >@@ -967,7 +968,7 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
> >  {
> >  	struct arm_smmu_domain *smmu_domain;
> >
> >-	if (type != IOMMU_DOMAIN_UNMANAGED)
> >+	if (type != IOMMU_DOMAIN_UNMANAGED && type != IOMMU_DOMAIN_DMA)
> >  		return NULL;
> >  	/*
> >  	 * Allocate the domain and initialise some of its data structures.
> >@@ -978,6 +979,12 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
> >  	if (!smmu_domain)
> >  		return NULL;
> >
> >+	if (type == IOMMU_DOMAIN_DMA &&
> >+	    iommu_get_dma_cookie(&smmu_domain->domain)) {
> >+		kfree(smmu_domain);
> >+		return NULL;
> >+	}
> >+
> >  	mutex_init(&smmu_domain->init_mutex);
> >  	spin_lock_init(&smmu_domain->pgtbl_lock);
> >
> >@@ -992,6 +999,7 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
> >  	 * Free the domain resources. We assume that all devices have
> >  	 * already been detached.
> >  	 */
> >+	iommu_put_dma_cookie(domain);
> >  	arm_smmu_destroy_domain_context(domain);
> >  	kfree(smmu_domain);
> >  }
> >@@ -1361,6 +1369,16 @@ static int arm_smmu_init_platform_device(struct device *dev,
> >  	return 0;
> >  }
> >
> >+int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
> >+{
> >+	/*
> >+	 * Nothing to do here because SMMU is already aware of all
> >+	 * MMU masters and their stream IDs using mmu-master attibute
> >+	 * SMMU DT node.
> >+	 */
> 
> ...but on the same hand this will also never get called if there's
> no "iommus" property on the master. Maintaining support for existing
> users of the "mmu-masters" binding is one thing (namely the thing
> that's been slowing down my efforts to clean up the really hacky
> generic binding support I did all the DMA stuff with), but having
> _both_ bindings in a single DT is something I don't think anybody
> wants to see

Indeed. NAK to the mixed case.

Mark.
