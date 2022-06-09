Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16085C433EF
	for <iommu@archiver.kernel.org>; Thu,  9 Jun 2022 19:01:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B042C8425B;
	Thu,  9 Jun 2022 19:01:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QN_1FK4Xdi9V; Thu,  9 Jun 2022 19:01:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 807E084245;
	Thu,  9 Jun 2022 19:01:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 55804C0039;
	Thu,  9 Jun 2022 19:01:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8744C002D
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jun 2022 19:01:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C0C2341CC7
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jun 2022 19:01:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tRaWrc03Stgm for <iommu@lists.linux-foundation.org>;
 Thu,  9 Jun 2022 19:01:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3797B41CBF
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jun 2022 19:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1654801267; x=1686337267;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=EmjwxxcIPjSKbVJyKUdZT+cLlENxHUYXqwB3T5Diz90=;
 b=GCN520h7bpzoh06DaMUy9U5RZ/wqDIXk3kwKRQa2qJ7dElA3uoxth92o
 /4ZKAV0MS5uRPX22O9XF7AuuLg7Zf9B6vUhm+xqc01GK073Bbsl0wJSls
 tTeIMfzAFb9eduqcY+7Uxuaibc0DtHN/Zm0HgztJhQL5K8+mfYWg0lLH5
 T9MBRdGMRPsOuM5AmvLOVZtcQqZvVT2T9g65Wfsmt8DsEDgwCnLBaOhWl
 DIZBN3JydApRJb+tsEHtiY3M18aZl+QyIzPeASstt/AEuouEN2QH/KnV8
 a1rpXqT7U71dtuPfJFM6FeQD52KR7/EKETFV03m6cpjoy4G+NeYXIZYMI A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="278193811"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; d="scan'208";a="278193811"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2022 12:01:03 -0700
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; d="scan'208";a="908473498"
Received: from araj-dh-work.jf.intel.com (HELO araj-dh-work) ([10.165.157.158])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2022 12:01:03 -0700
Date: Thu, 9 Jun 2022 19:01:02 +0000
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v8 02/11] iommu: Add max_pasids field in struct dev_iommu
Message-ID: <20220609190102.GC33363@araj-dh-work>
References: <20220607014942.3954894-1-baolu.lu@linux.intel.com>
 <20220607014942.3954894-3-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220607014942.3954894-3-baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Vinod Koul <vkoul@kernel.org>, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Tue, Jun 07, 2022 at 09:49:33AM +0800, Lu Baolu wrote:
> Use this field to save the number of PASIDs that a device is able to
> consume. It is a generic attribute of a device and lifting it into the
> per-device dev_iommu struct could help to avoid the boilerplate code
> in various IOMMU drivers.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/iommu.h |  2 ++
>  drivers/iommu/iommu.c | 26 ++++++++++++++++++++++++++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 03fbb1b71536..d50afb2c9a09 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -364,6 +364,7 @@ struct iommu_fault_param {
>   * @fwspec:	 IOMMU fwspec data
>   * @iommu_dev:	 IOMMU device this device is linked to
>   * @priv:	 IOMMU Driver private data
> + * @max_pasids:  number of PASIDs device can consume
>   *
>   * TODO: migrate other per device data pointers under iommu_dev_data, e.g.
>   *	struct iommu_group	*iommu_group;
> @@ -375,6 +376,7 @@ struct dev_iommu {
>  	struct iommu_fwspec		*fwspec;
>  	struct iommu_device		*iommu_dev;
>  	void				*priv;
> +	u32				max_pasids;
>  };
>  
>  int iommu_device_register(struct iommu_device *iommu,
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 847ad47a2dfd..adac85ccde73 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -20,6 +20,7 @@
>  #include <linux/idr.h>
>  #include <linux/err.h>
>  #include <linux/pci.h>
> +#include <linux/pci-ats.h>

Is this needed for this patch?

>  #include <linux/bitops.h>
>  #include <linux/property.h>
>  #include <linux/fsl/mc.h>
> @@ -218,6 +219,30 @@ static void dev_iommu_free(struct device *dev)
>  	kfree(param);
>  }
>  
> +static u32 dev_iommu_get_max_pasids(struct device *dev)
> +{
> +	u32 max_pasids = dev->iommu->iommu_dev->max_pasids;
> +	u32 num_bits;
> +	int ret;
> +
> +	if (!max_pasids)
> +		return 0;
> +
> +	if (dev_is_pci(dev)) {
> +		ret = pci_max_pasids(to_pci_dev(dev));
> +		if (ret < 0)
> +			return 0;
> +
> +		return min_t(u32, max_pasids, ret);

Ah.. that answers my other question to consider device pasid-max. I guess
if we need any enforcement of restricting devices that aren't supporting
the full PASID, that will be done by some higher layer?

too many returns in this function, maybe setup all returns to the end of
the function might be elegant?

> +	}
> +
> +	ret = device_property_read_u32(dev, "pasid-num-bits", &num_bits);
> +	if (ret)
> +		return 0;
> +
> +	return min_t(u32, max_pasids, 1UL << num_bits);
> +}
> +
>  static int __iommu_probe_device(struct device *dev, struct list_head *group_list)
>  {
>  	const struct iommu_ops *ops = dev->bus->iommu_ops;
> @@ -243,6 +268,7 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
>  	}
>  
>  	dev->iommu->iommu_dev = iommu_dev;
> +	dev->iommu->max_pasids = dev_iommu_get_max_pasids(dev);
>  
>  	group = iommu_group_get_for_dev(dev);
>  	if (IS_ERR(group)) {
> -- 
> 2.25.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
