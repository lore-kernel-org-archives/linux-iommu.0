From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v8 10/13] iommu/amd: Allocate memory below 4G for dev
 table if translation pre-enabled
Date: Mon, 31 Jul 2017 18:15:30 +0800
Message-ID: <20170731101530.GB29157@x1>
References: <1500627551-12930-1-git-send-email-bhe@redhat.com>
 <1500627551-12930-11-git-send-email-bhe@redhat.com>
 <20170727155550.GO3610@suse.de>
 <20170728090619.GM24304@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170728090619.GM24304@x1>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <jroedel@suse.de>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

On 07/28/17 at 05:06pm, Baoquan He wrote:
> Hi Joerg,
> 
> On 07/27/17 at 05:55pm, Joerg Roedel wrote:
> > On Fri, Jul 21, 2017 at 04:59:08PM +0800, Baoquan He wrote:
> > > AMD pointed out it's unsafe to update the device-table while iommu
> > > is enabled. It turns out that device-table pointer update is split
> > > up into two 32bit writes in the IOMMU hardware. So updating it while
> > > the IOMMU is enabled could have some nasty side effects.
> > > 
> > > The only way to work around this is to allocate the device-table below
> > > 4GB if translation is pre-enabled in kdump kernel. If allocation failed,
> > > still use the old one.
> > 
> > Not only for the kdump kernel. The old device table must also be below
> > 4GB so that its pointer can be updated with a 32bit write.
> > 
> > If the old table is above 4GB you still need the second write to zero
> > the upper parts of the pointer in hardware.
> 
> Do you mean the allocation of amd_iommu_dev_table in
> early_amd_iommu_init() also need be addressed for 1st kernel? Seems we
> don't make sure that for 1st kernel, like adding GFP_DMA32 flag when
> allocate amd_iommu_dev_table in amd_iommu_dev_table
> early_amd_iommu_init().

I plan to add GFP_DMA32 when allocate amd_iommu_dev_table in
early_amd_iommu_init() as below. Then in kdump kernel we don't need to
worry if the old amd_iommu_dev_table could be above 4G, right? And might
not need to check if it's above 4G, right?

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 781a138..85d6445 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -2436,7 +2436,8 @@ static int __init early_amd_iommu_init(void)
 
 	/* Device table - directly used by all IOMMUs */
 	ret = -ENOMEM;
-	amd_iommu_dev_table = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
+	amd_iommu_dev_table = (void *)__get_free_pages(
+				      GFP_KERNEL | __GFP_ZERO | GFP_DMA32,
 				      get_order(dev_table_size));
 	if (amd_iommu_dev_table == NULL)
 		goto out;
-- 
2.9.4
