Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D7C1C433EF
	for <iommu@archiver.kernel.org>; Tue, 29 Mar 2022 20:56:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 80CED41842;
	Tue, 29 Mar 2022 20:56:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L4y0rJPDHYF1; Tue, 29 Mar 2022 20:56:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0C25E41825;
	Tue, 29 Mar 2022 20:56:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BE81CC001D;
	Tue, 29 Mar 2022 20:56:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E0179C0012
 for <iommu@lists.linux-foundation.org>; Tue, 29 Mar 2022 20:56:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C6BDE41842
 for <iommu@lists.linux-foundation.org>; Tue, 29 Mar 2022 20:56:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YJiZ7vPxmcLv for <iommu@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 20:56:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AE8B341825
 for <iommu@lists.linux-foundation.org>; Tue, 29 Mar 2022 20:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1648587413; x=1680123413;
 h=date:from:to:cc:subject:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3wtsUueTaQsnYPOimkGDZTAP5s966o4NAmrSveLU4oE=;
 b=l9AKUNlJl5X1txKkvb0xZDM9CRe6S48qusivz1KFjmcMs4xVWW8YnH4a
 nOPp1hSH0pScznsC23+NCtJF8Xxt7V4aJ0tkek208rFswo6FsvgjviV64
 gTPtSk0ICdhPkRSD4fkD6mWIS6OtGyhJMP+N7LjFRrMx7si4mPL4uyltD
 zcuh6RzFSSFTSBYaQH5vrmzxK2EtEYxWKAH4wFjpmB3FgfqizAXB74SX6
 qsOH/XpSW1OzOdtcX9P+LE5oAFowzLhsxC3igIBJYuZ83CSCwZIz6FmbD
 JG1ozwOpK4BaVbyEtejeu/C8I58ydAvUiOJAlBbWrxRQbUFPMlRcH9S+Y Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="345807247"
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; d="scan'208";a="345807247"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2022 13:56:52 -0700
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; d="scan'208";a="503048703"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2022 13:56:52 -0700
Date: Tue, 29 Mar 2022 14:00:15 -0700
From: Jacob Pan <jacob.jun.pan@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH RFC v2 01/11] iommu: Add pasid_bits field in struct
 dev_iommu
Message-ID: <20220329140015.70c073b6@jacob-builder>
In-Reply-To: <20220329053800.3049561-2-baolu.lu@linux.intel.com>
References: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
 <20220329053800.3049561-2-baolu.lu@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com,
 Jason Gunthorpe <jgg@nvidia.com>, Will Deacon <will@kernel.org>
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

Hi BaoLu,

On Tue, 29 Mar 2022 13:37:50 +0800, Lu Baolu <baolu.lu@linux.intel.com>
wrote:

> Use this field to save the pasid/ssid bits that a device is able to
> support with its IOMMU hardware. It is a generic attribute of a device
> and lifting it into the per-device dev_iommu struct makes it possible
> to allocate a PASID for device without calls into the IOMMU drivers.
> Any iommu driver which suports PASID related features should set this
> field before features are enabled on the devices.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/iommu.h                       | 1 +
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 ++
>  drivers/iommu/intel/iommu.c                 | 5 ++++-
>  3 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 6ef2df258673..36f43af0af53 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -368,6 +368,7 @@ struct dev_iommu {
>  	struct iommu_fwspec		*fwspec;
>  	struct iommu_device		*iommu_dev;
>  	void				*priv;
> +	unsigned int			pasid_bits;
pasid_width?
PCI spec uses "Max PASID Width"

>  };
>  
>  int iommu_device_register(struct iommu_device *iommu,
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c index
> 627a3ed5ee8f..afc63fce6107 100644 ---
> a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c +++
> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c @@ -2681,6 +2681,8 @@
> static struct iommu_device *arm_smmu_probe_device(struct device *dev)
> smmu->features & ARM_SMMU_FEAT_STALL_FORCE) master->stall_enabled = true;
>  
> +	dev->iommu->pasid_bits = master->ssid_bits;
> +
>  	return &smmu->iommu;
>  
>  err_free_master:
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 6f7485c44a4b..c1b91bce1530 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4587,8 +4587,11 @@ static struct iommu_device
> *intel_iommu_probe_device(struct device *dev) if (pasid_supported(iommu))
> { int features = pci_pasid_features(pdev);
>  
> -				if (features >= 0)
> +				if (features >= 0) {
>  					info->pasid_supported = features
> | 1;
> +					dev->iommu->pasid_bits =
> +
> fls(pci_max_pasids(pdev)) - 1;
> +				}
>  			}
>  
>  			if (info->ats_supported && ecap_prs(iommu->ecap)
> &&


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
