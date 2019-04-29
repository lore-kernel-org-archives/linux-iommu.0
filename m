Return-Path: <SRS0=wClR=S7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3458CC43219
	for <iommu@archiver.kernel.org>; Mon, 29 Apr 2019 22:39:17 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F308020673
	for <iommu@archiver.kernel.org>; Mon, 29 Apr 2019 22:39:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F308020673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id B87D8CD4;
	Mon, 29 Apr 2019 22:39:16 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 8FA56C7C
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Apr 2019 22:39:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B8F6A878
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Apr 2019 22:39:02 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	29 Apr 2019 15:39:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,411,1549958400"; d="scan'208";a="227875888"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
	by orsmga001.jf.intel.com with ESMTP; 29 Apr 2019 15:39:01 -0700
Date: Mon, 29 Apr 2019 15:41:46 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v2 19/19] iommu/vt-d: Add svm/sva invalidate function
Message-ID: <20190429154146.20e0c13c@jacob-builder>
In-Reply-To: <26398960-f484-d5dd-eff5-c44810528194@redhat.com>
References: <1556062279-64135-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1556062279-64135-20-git-send-email-jacob.jun.pan@linux.intel.com>
	<26398960-f484-d5dd-eff5-c44810528194@redhat.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Andriy Shevchenko <andriy.shevchenko@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Development issues for Linux IOMMU support
	<iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190429224146.jhG1xvqE6tGoh2EylhnOafErCSQ8DswZ28PldZUt1tg@z>

On Fri, 26 Apr 2019 19:23:03 +0200
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Jacob,
> On 4/24/19 1:31 AM, Jacob Pan wrote:
> > When Shared Virtual Address (SVA) is enabled for a guest OS via
> > vIOMMU, we need to provide invalidation support at IOMMU API and
> > driver level. This patch adds Intel VT-d specific function to
> > implement iommu passdown invalidate API for shared virtual address.
> > 
> > The use case is for supporting caching structure invalidation
> > of assigned SVM capable devices. Emulated IOMMU exposes queue
> > invalidation capability and passes down all descriptors from the
> > guest to the physical IOMMU.
> > 
> > The assumption is that guest to host device ID mapping should be
> > resolved prior to calling IOMMU driver. Based on the device handle,
> > host IOMMU driver can replace certain fields before submit to the
> > invalidation queue.
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> > Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> > ---
> >  drivers/iommu/intel-iommu.c | 159
> > ++++++++++++++++++++++++++++++++++++++++++++ 1 file changed, 159
> > insertions(+)
> > 
> > diff --git a/drivers/iommu/intel-iommu.c
> > b/drivers/iommu/intel-iommu.c index 89989b5..54a3d22 100644
> > --- a/drivers/iommu/intel-iommu.c
> > +++ b/drivers/iommu/intel-iommu.c
> > @@ -5338,6 +5338,164 @@ static void
> > intel_iommu_aux_detach_device(struct iommu_domain *domain,
> > aux_domain_remove_dev(to_dmar_domain(domain), dev); }
> >  
> > +/*
> > + * 2D array for converting and sanitizing IOMMU generic TLB
> > granularity to
> > + * VT-d granularity. Invalidation is typically included in the
> > unmap operation
> > + * as a result of DMA or VFIO unmap. However, for assigned device
> > where guest
> > + * could own the first level page tables without being shadowed by
> > QEMU. In
> > + * this case there is no pass down unmap to the host IOMMU as a
> > result of unmap
> > + * in the guest. Only invalidations are trapped and passed down.
> > + * In all cases, only first level TLB invalidation (request with
> > PASID) can be
> > + * passed down, therefore we do not include IOTLB granularity for
> > request
> > + * without PASID (second level).
> > + *
> > + * For an example, to find the VT-d granularity encoding for IOTLB
> > + * type and page selective granularity within PASID:
> > + * X: indexed by iommu cache type
> > + * Y: indexed by enum iommu_inv_granularity
> > + * [IOMMU_INV_TYPE_TLB][IOMMU_INV_GRANU_PAGE_PASID]
> > + *
> > + * Granu_map array indicates validity of the table. 1: valid, 0:
> > invalid
> > + *
> > + */
> > +const static int
> > inv_type_granu_map[NR_IOMMU_CACHE_TYPE][NR_IOMMU_CACHE_INVAL_GRANU]
> > = {  
> The size is frozen for a given uapi version so I guess you can
> hardcode the limits for a given version.
I guess I could, I just felt more readable this way.
> > +	/* PASID based IOTLB, support PASID selective and page
> > selective */
> > +	{0, 1, 1},
> > +	/* PASID based dev TLBs, only support all PASIDs or single
> > PASID */
> > +	{1, 1, 0},
> > +	/* PASID cache */
> > +	{1, 1, 0}
> > +};
> > +
> > +const static u64
> > inv_type_granu_table[NR_IOMMU_CACHE_TYPE][NR_IOMMU_CACHE_INVAL_GRANU]
> > = {
> > +	/* PASID based IOTLB */
> > +	{0, QI_GRAN_NONG_PASID, QI_GRAN_PSI_PASID},
> > +	/* PASID based dev TLBs */
> > +	{QI_DEV_IOTLB_GRAN_ALL, QI_DEV_IOTLB_GRAN_PASID_SEL, 0},
> > +	/* PASID cache */
> > +	{QI_PC_ALL_PASIDS, QI_PC_PASID_SEL, 0},
> > +};  
> Can't you use a single matrix instead, ie. inv_type_granu_table
> 
The reason i have an additional inv_type_granu_map[] matrix is that
some of fields can be 0 but still valid. A single matrix would not be
able to tell the difference between a valid 0 or invalid field.
> > +
> > +static inline int to_vtd_granularity(int type, int granu, u64
> > *vtd_granu) +{
> > +	if (type >= NR_IOMMU_CACHE_TYPE || granu >=
> > NR_IOMMU_CACHE_INVAL_GRANU ||
> > +		!inv_type_granu_map[type][granu])
> > +		return -EINVAL;
> > +
> > +	*vtd_granu = inv_type_granu_table[type][granu];
> > +
> > +	return 0;
> > +}
> > +
> > +static inline u64 to_vtd_size(u64 granu_size, u64 nr_granules)
> > +{
> > +	u64 nr_pages;  
> direct initialization?
will do, thanks
> > +	/* VT-d size is encoded as 2^size of 4K pages, 0 for 4k, 9
> > for 2MB, etc.
> > +	 * IOMMU cache invalidate API passes granu_size in bytes,
> > and number of
> > +	 * granu size in contiguous memory.
> > +	 */
> > +
> > +	nr_pages = (granu_size * nr_granules) >> VTD_PAGE_SHIFT;
> > +	return order_base_2(nr_pages);
> > +}
> > +
> > +static int intel_iommu_sva_invalidate(struct iommu_domain *domain,
> > +		struct device *dev, struct
> > iommu_cache_invalidate_info *inv_info) +{
> > +	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
> > +	struct device_domain_info *info;
> > +	struct intel_iommu *iommu;
> > +	unsigned long flags;
> > +	int cache_type;
> > +	u8 bus, devfn;
> > +	u16 did, sid;
> > +	int ret = 0;
> > +	u64 granu;
> > +	u64 size;
> > +
> > +	if (!inv_info || !dmar_domain ||
> > +		inv_info->version !=
> > IOMMU_CACHE_INVALIDATE_INFO_VERSION_1)
> > +		return -EINVAL;
> > +
> > +	if (!dev || !dev_is_pci(dev))
> > +		return -ENODEV;
> > +
> > +	iommu = device_to_iommu(dev, &bus, &devfn);
> > +	if (!iommu)
> > +		return -ENODEV;
> > +
> > +	spin_lock(&iommu->lock);
> > +	spin_lock_irqsave(&device_domain_lock, flags);  
> mix of _irqsave and non _irqsave looks suspicious to me.
It should be in reverse order. Any other concerns?
> > +	info = iommu_support_dev_iotlb(dmar_domain, iommu, bus,
> > devfn);
> > +	if (!info) {
> > +		ret = -EINVAL;
> > +		goto out_unlock;
> > +	}
> > +	did = dmar_domain->iommu_did[iommu->seq_id];
> > +	sid = PCI_DEVID(bus, devfn);
> > +	size = to_vtd_size(inv_info->addr_info.granule_size,
> > inv_info->addr_info.nb_granules); +
> > +	for_each_set_bit(cache_type, (unsigned long
> > *)&inv_info->cache, NR_IOMMU_CACHE_TYPE) { +
> > +		ret = to_vtd_granularity(cache_type,
> > inv_info->granularity, &granu);
> > +		if (ret) {
> > +			pr_err("Invalid range type %d, granu
> > %d\n", cache_type,  
> s/Invalid range type %d, granu %d/Invalid cache type/granu combination
> (%d/%d)
sounds good, indeed it is the combination that is invalid.
> > +				inv_info->granularity);
> > +			break;
> > +		}
> > +
> > +		switch (BIT(cache_type)) {
> > +		case IOMMU_CACHE_INV_TYPE_IOTLB:
> > +			if (size && (inv_info->addr_info.addr &
> > ((BIT(VTD_PAGE_SHIFT + size)) - 1))) {
> > +				pr_err("Address out of range,
> > 0x%llx, size order %llu\n",
> > +					inv_info->addr_info.addr,
> > size);
> > +				ret = -ERANGE;
> > +				goto out_unlock;
> > +			}
> > +
> > +			qi_flush_piotlb(iommu, did,
> > mm_to_dma_pfn(inv_info->addr_info.addr),
> > +					inv_info->addr_info.pasid,
> > +					size, granu);
> > +
> > +			/*
> > +			 * Always flush device IOTLB if ATS is
> > enabled since guest
> > +			 * vIOMMU exposes CM = 1, no device IOTLB
> > flush will be passed
> > +			 * down. REVISIT: cannot assume Linux guest
> > +			 */
> > +			if (info->ats_enabled) {
> > +				qi_flush_dev_piotlb(iommu, sid,
> > info->pfsid,
> > +
> > inv_info->addr_info.pasid, info->ats_qdep,
> > +
> > inv_info->addr_info.addr, size,
> > +						granu);
> > +			}
> > +			break;
> > +		case IOMMU_CACHE_INV_TYPE_DEV_IOTLB:
> > +			if (info->ats_enabled) {
> > +				qi_flush_dev_piotlb(iommu, sid,
> > info->pfsid,
> > +
> > inv_info->addr_info.pasid, info->ats_qdep,
> > +
> > inv_info->addr_info.addr, size,
> > +						granu);
> > +			} else
> > +				pr_warn("Passdown device IOTLB
> > flush w/o ATS!\n"); +
> > +			break;
> > +		case IOMMU_CACHE_INV_TYPE_PASID:
> > +			qi_flush_pasid_cache(iommu, did, granu,
> > inv_info->pasid); +
> > +			break;
> > +		default:
> > +			dev_err(dev, "Unsupported IOMMU
> > invalidation type %d\n",
> > +				cache_type);
> > +			ret = -EINVAL;
> > +		}
> > +	}
> > +out_unlock:
> > +	spin_unlock(&iommu->lock);
> > +	spin_unlock_irqrestore(&device_domain_lock, flags);  
> I would expect the opposite order
yes, i reversed in the lock order such that irq is disabled.
> > +
> > +	return ret;
> > +}
> > +
> >  static int intel_iommu_map(struct iommu_domain *domain,
> >  			   unsigned long iova, phys_addr_t hpa,
> >  			   size_t size, int iommu_prot)
> > @@ -5769,6 +5927,7 @@ const struct iommu_ops intel_iommu_ops = {
> >  	.dev_disable_feat	= intel_iommu_dev_disable_feat,
> >  	.pgsize_bitmap		= INTEL_IOMMU_PGSIZES,
> >  #ifdef CONFIG_INTEL_IOMMU_SVM
> > +	.cache_invalidate	= intel_iommu_sva_invalidate,
> >  	.sva_bind_gpasid	= intel_svm_bind_gpasid,
> >  	.sva_unbind_gpasid	= intel_svm_unbind_gpasid,
> >  #endif
> >   
> Thanks
> 
> Eric

Thank you so much for your review. I will roll up the next version
soon, hopefully this week.

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
