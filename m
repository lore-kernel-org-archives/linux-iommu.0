From: Baoquan He <bhe@redhat.com>
Subject: Re: [Patch v4 3/9] iommu/amd: Detect pre enabled translation
Date: Mon, 30 May 2016 11:24:07 +0800
Message-ID: <20160530032407.GB2488@x1.redhat.com>
References: <1464157735-8865-1-git-send-email-bhe@redhat.com>
 <1464157735-8865-4-git-send-email-bhe@redhat.com>
 <3371fab6-b3db-6f4a-a1a1-b272c3f8fdbe@iommu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3371fab6-b3db-6f4a-a1a1-b272c3f8fdbe@iommu.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wan Zongshun <vw@iommu.org>
Cc: joro@8bytes.org, linux-kernel@vger.kernel.org, vincent.wan@amd.com, iommu@lists.linux-foundation.org, dyoung@redhat.com
List-Id: iommu@lists.linux-foundation.org

On 05/28/16 at 08:49pm, Wan Zongshun wrote:
> 
> 
> -------- Original Message --------
> >@@ -1101,6 +1121,11 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h)
> >
> > 	iommu->int_enabled = false;
> >
> >+	init_translation_status(iommu);
> >+
> >+	if (translation_pre_enabled())
> >+		pr_warn("Translation is already enabled - trying to copy translation structures\n");
> >+
> 
> You missed this 'iommu' parameter here, even I saw you fixed it in
> another patch, but please keep each patch to be meaningful.

Hi Zongshun,

Thanks for reviewing this patchset and great comments, will remember and
update with change.

Yes, translation_pre_enabled() in this patchset need a parameter "struct
amd_iommu*". 

In fact I am still debugging and trying to figure out what need be done
further to stop the IO_PAGE_FAULT happened on ethernet network card. I
kept changing code and adjust the patches. Up to now seems I still
didn't figure out why. There must be something I didn't notice and
everything will be fine as soon as I close that valve. With my
understand pci bug scanning will detect each pci device and do the
initialization job like setting configuration space registers and
control registers. After that we can safely re-init the pci device and
re-install the new io-page tables, and this is how Joerg has done for
vt-d fix for kdump if my understanding is correct. And I tried to do
like that in this patchset, don't know why it doesn't work.

As you know in previous post I thought the final initialization of
device should be done when its related driver probe and do the mapping
job, I tried re-install io-page tables at this time. Seems it didn't
work too. So I left that way.

Sorry for this rough post, will pay attention and make a formal post if
there's new update.

Thanks
Baoquan
> 
> > 	ret = init_iommu_from_acpi(iommu, h);
> > 	if (ret)
> > 		return ret;
> >diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
> >index 9d32b20..01783cc 100644
> >--- a/drivers/iommu/amd_iommu_types.h
> >+++ b/drivers/iommu/amd_iommu_types.h
> >@@ -384,6 +384,7 @@ extern struct kmem_cache *amd_iommu_irq_cache;
> > #define APERTURE_PAGE_INDEX(a)	(((a) >> 21) & 0x3fULL)
> >
> >
> >+
> > /*
> >  * This struct is used to pass information about
> >  * incoming PPR faults around.
> >@@ -401,6 +402,8 @@ struct amd_iommu_fault {
> > struct iommu_domain;
> > struct irq_domain;
> >
> >+#define AMD_IOMMU_FLAG_TRANS_PRE_ENABLED      (1 << 0)
> >+
> > /*
> >  * This structure contains generic data for  IOMMU protection domains
> >  * independent of their use.
> >@@ -525,6 +528,7 @@ struct amd_iommu {
> > 	struct irq_domain *ir_domain;
> > 	struct irq_domain *msi_domain;
> > #endif
> >+	u32 flags;
> > };
> >
> > struct devid_map {
> >
