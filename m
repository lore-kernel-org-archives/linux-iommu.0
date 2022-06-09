Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39426C433EF
	for <iommu@archiver.kernel.org>; Thu,  9 Jun 2022 17:25:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CB0CF40C71;
	Thu,  9 Jun 2022 17:25:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iC0OJoSQevQw; Thu,  9 Jun 2022 17:25:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 93AB0400A8;
	Thu,  9 Jun 2022 17:25:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 65288C0032;
	Thu,  9 Jun 2022 17:25:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62AD5C002D
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jun 2022 17:25:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4D38140C71
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jun 2022 17:25:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OZMqPLL0my4y for <iommu@lists.linux-foundation.org>;
 Thu,  9 Jun 2022 17:25:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4DAE3400A8
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jun 2022 17:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1654795545; x=1686331545;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=NM5pPibGbGNtxwzakbyoZcPV7UgqZOLcVDpUOgXosgQ=;
 b=jFrZZbFcfIDnVe+rzwxaJj6M8daeotU8Fw3Xo4z69Yn0xh6rwkFeOdRn
 mS3ERyyy1hMUmyt1r7C6dC2dUpeIZtFInz0zOYd9wu0UP6JXpVpgCJaou
 h4nHWwPaAXI/tvkwPEMPR4F5jzWXfAGC3DOfvQu6kUyP18+UncV6FgXgb
 AhJtgp6zTxoTlXFHZEUE8dKd7YJml5cFR9MEl+FbVkh3UWEWTV8kaAm1l
 e5itq3M0eFQoDzbu/5d0P0muckrNjgTmIWeN11L7vn2ga7cCwcZjn/pZQ
 TKUUmBm5pWNZtqwD7EQTfIl6MiDpnz7xe8Ce4kPXsy8HuqAzDpjYlW2+q Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="278168798"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; d="scan'208";a="278168798"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2022 10:25:43 -0700
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; d="scan'208";a="908432917"
Received: from araj-dh-work.jf.intel.com (HELO araj-dh-work) ([10.165.157.158])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2022 10:25:42 -0700
Date: Thu, 9 Jun 2022 17:25:42 +0000
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v8 01/11] iommu: Add max_pasids field in struct
 iommu_device
Message-ID: <20220609172542.GB33363@araj-dh-work>
References: <20220607014942.3954894-1-baolu.lu@linux.intel.com>
 <20220607014942.3954894-2-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220607014942.3954894-2-baolu.lu@linux.intel.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Kevin Tian <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
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


On Tue, Jun 07, 2022 at 09:49:32AM +0800, Lu Baolu wrote:
> Use this field to keep the number of supported PASIDs that an IOMMU
> hardware is able to support. This is a generic attribute of an IOMMU
> and lifting it into the per-IOMMU device structure makes it possible

There is also a per-device attribute that tells what width is supported on
each device. When a device enables SVM, for simplicity we were proposing to
disable SVM on devices that don't support the full width, since it adds
additional complexity on the allocation interface. Is that factored into
this?

> to allocate a PASID for device without calls into the IOMMU drivers.
> Any iommu driver which supports PASID related features should set this
> field before enabling them on the devices.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  include/linux/intel-iommu.h                 | 3 ++-
>  include/linux/iommu.h                       | 2 ++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 1 +
>  drivers/iommu/intel/dmar.c                  | 7 +++++++
>  4 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 4f29139bbfc3..e065cbe3c857 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -479,7 +479,6 @@ enum {
>  #define VTD_FLAG_IRQ_REMAP_PRE_ENABLED	(1 << 1)
>  #define VTD_FLAG_SVM_CAPABLE		(1 << 2)
>  
> -extern int intel_iommu_sm;
>  extern spinlock_t device_domain_lock;
>  
>  #define sm_supported(iommu)	(intel_iommu_sm && ecap_smts((iommu)->ecap))
> @@ -786,6 +785,7 @@ struct context_entry *iommu_context_addr(struct intel_iommu *iommu, u8 bus,
>  extern const struct iommu_ops intel_iommu_ops;
>  
>  #ifdef CONFIG_INTEL_IOMMU
> +extern int intel_iommu_sm;
>  extern int iommu_calculate_agaw(struct intel_iommu *iommu);
>  extern int iommu_calculate_max_sagaw(struct intel_iommu *iommu);
>  extern int dmar_disabled;
> @@ -802,6 +802,7 @@ static inline int iommu_calculate_max_sagaw(struct intel_iommu *iommu)
>  }
>  #define dmar_disabled	(1)
>  #define intel_iommu_enabled (0)
> +#define intel_iommu_sm (0)

Is the above part of this patch? Or should be moved up somewhere?
>  #endif
>  
>  static inline const char *decode_prq_descriptor(char *str, size_t size,
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 5e1afe169549..03fbb1b71536 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -318,12 +318,14 @@ struct iommu_domain_ops {
>   * @list: Used by the iommu-core to keep a list of registered iommus
>   * @ops: iommu-ops for talking to this iommu
>   * @dev: struct device for sysfs handling
> + * @max_pasids: number of supported PASIDs
>   */
>  struct iommu_device {
>  	struct list_head list;
>  	const struct iommu_ops *ops;
>  	struct fwnode_handle *fwnode;
>  	struct device *dev;
> +	u32 max_pasids;
>  };
>  
>  /**
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 88817a3376ef..ae8ec8df47c1 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -3546,6 +3546,7 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
>  	/* SID/SSID sizes */
>  	smmu->ssid_bits = FIELD_GET(IDR1_SSIDSIZE, reg);
>  	smmu->sid_bits = FIELD_GET(IDR1_SIDSIZE, reg);
> +	smmu->iommu.max_pasids = 1UL << smmu->ssid_bits;
>  
>  	/*
>  	 * If the SMMU supports fewer bits than would fill a single L2 stream
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index 592c1e1a5d4b..6c338888061a 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -1123,6 +1123,13 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
>  
>  	raw_spin_lock_init(&iommu->register_lock);
>  
> +	/*
> +	 * A value of N in PSS field of eCap register indicates hardware
> +	 * supports PASID field of N+1 bits.
> +	 */
> +	if (pasid_supported(iommu))
> +		iommu->iommu.max_pasids = 2UL << ecap_pss(iommu->ecap);
> +
>  	/*
>  	 * This is only for hotplug; at boot time intel_iommu_enabled won't
>  	 * be set yet. When intel_iommu_init() runs, it registers the units
> -- 
> 2.25.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
