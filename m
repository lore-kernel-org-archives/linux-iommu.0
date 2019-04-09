Return-Path: <SRS0=aFDh=SL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4ABFC282DA
	for <iommu@archiver.kernel.org>; Tue,  9 Apr 2019 14:57:21 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEB63208C0
	for <iommu@archiver.kernel.org>; Tue,  9 Apr 2019 14:57:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEB63208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 7478510A8;
	Tue,  9 Apr 2019 14:57:21 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A6EE6108D
	for <iommu@lists.linux-foundation.org>;
	Tue,  9 Apr 2019 14:57:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 9DAF476D
	for <iommu@lists.linux-foundation.org>;
	Tue,  9 Apr 2019 14:57:19 +0000 (UTC)
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
	by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	09 Apr 2019 07:57:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,329,1549958400"; d="scan'208";a="132773295"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
	by orsmga008.jf.intel.com with ESMTP; 09 Apr 2019 07:57:14 -0700
Received: from andy by smile with local (Exim 4.92)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1hDsBU-0004UC-VC; Tue, 09 Apr 2019 17:57:12 +0300
Date: Tue, 9 Apr 2019 17:57:12 +0300
From: Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 18/18] iommu/vt-d: Add svm/sva invalidate function
Message-ID: <20190409145712.GR9224@smile.fi.intel.com>
References: <1554767973-30125-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1554767973-30125-19-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1554767973-30125-19-git-send-email-jacob.jun.pan@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Yi L <yi.l.liu@linux.intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
	Raj Ashok <ashok.raj@intel.com>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Liu@smile.fi.intel.com, David Woodhouse <dwmw2@infradead.org>
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
Message-ID: <20190409145712.rFC3NMOxgpIUtg4_WTsi7eZER8_NXCIfCoNW8nQ-cHc@z>

On Mon, Apr 08, 2019 at 04:59:33PM -0700, Jacob Pan wrote:
> When Shared Virtual Address (SVA) is enabled for a guest OS via
> vIOMMU, we need to provide invalidation support at IOMMU API and driver
> level. This patch adds Intel VT-d specific function to implement
> iommu passdown invalidate API for shared virtual address.
> 
> The use case is for supporting caching structure invalidation
> of assigned SVM capable devices. Emulated IOMMU exposes queue
> invalidation capability and passes down all descriptors from the guest
> to the physical IOMMU.
> 
> The assumption is that guest to host device ID mapping should be
> resolved prior to calling IOMMU driver. Based on the device handle,
> host IOMMU driver can replace certain fields before submit to the
> invalidation queue.

> +static int intel_iommu_sva_invalidate(struct iommu_domain *domain,
> +		struct device *dev, struct iommu_cache_invalidate_info *inv_info)
> +{
> +	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
> +	struct device_domain_info *info;
> +	struct intel_iommu *iommu;
> +	unsigned long flags;
> +	int cache_type;
> +	u8 bus, devfn;
> +	u16 did, sid;
> +	int ret = 0;
> +	u64 granu;
> +	u64 size;
> +
> +	if (!inv_info || !dmar_domain ||
> +		inv_info->version != IOMMU_CACHE_INVALIDATE_INFO_VERSION_1)
> +		return -EINVAL;
> +
> +	iommu = device_to_iommu(dev, &bus, &devfn);
> +	if (!iommu)
> +		return -ENODEV;
> +

> +	if (!dev || !dev_is_pci(dev))
> +		return -ENODEV;

How dev is used in above call? Can be dev NULL there optional and give non-NULL
iommu?

> +		switch (1 << cache_type) {

BIT() ?

> +		case IOMMU_CACHE_INV_TYPE_IOTLB:
> +			if (size && (inv_info->addr_info.addr & ((1 << (VTD_PAGE_SHIFT + size)) - 1))) {

BIT() ?

> +				pr_err("Address out of range, 0x%llx, size order %llu\n",
> +					inv_info->addr_info.addr, size);
> +				ret = -ERANGE;
> +				goto out_unlock;
> +			}
> +
> +			qi_flush_piotlb(iommu, did, mm_to_dma_pfn(inv_info->addr_info.addr),
> +					inv_info->addr_info.pasid,
> +					size, granu);
> +
> +			/*
> +			 * Always flush device IOTLB if ATS is enabled since guest
> +			 * vIOMMU exposes CM = 1, no device IOTLB flush will be passed
> +			 * down. REVISIT: cannot assume Linux guest
> +			 */
> +			if (info->ats_enabled) {
> +				qi_flush_dev_piotlb(iommu, sid, info->pfsid,
> +						inv_info->addr_info.pasid, info->ats_qdep,
> +						inv_info->addr_info.addr, size,
> +						granu);
> +			}
> +			break;
> +		case IOMMU_CACHE_INV_TYPE_DEV_IOTLB:
> +			if (info->ats_enabled) {
> +				qi_flush_dev_piotlb(iommu, sid, info->pfsid,
> +						inv_info->addr_info.pasid, info->ats_qdep,
> +						inv_info->addr_info.addr, size,
> +						granu);
> +			} else
> +				pr_warn("Passdown device IOTLB flush w/o ATS!\n");
> +
> +			break;
> +		case IOMMU_CACHE_INV_TYPE_PASID:
> +			qi_flush_pasid_cache(iommu, did, granu, inv_info->pasid);
> +
> +			break;
> +		default:
> +			dev_err(dev, "Unsupported IOMMU invalidation type %d\n",
> +				cache_type);
> +			ret = -EINVAL;
> +		}

> +out_unlock:
> +	spin_unlock(&iommu->lock);
> +	spin_unlock_irqrestore(&device_domain_lock, flags);
> +
> +	return ret;
> +}

-- 
With Best Regards,
Andy Shevchenko


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
