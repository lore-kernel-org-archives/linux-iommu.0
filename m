Return-Path: <SRS0=TI1w=FX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5D2C4361B
	for <iommu@archiver.kernel.org>; Sat, 19 Dec 2020 06:50:20 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F16523A82
	for <iommu@archiver.kernel.org>; Sat, 19 Dec 2020 06:50:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F16523A82
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id C1404203FD;
	Sat, 19 Dec 2020 06:50:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S6ms-pCPYRBg; Sat, 19 Dec 2020 06:50:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A6899203EF;
	Sat, 19 Dec 2020 06:50:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 94CB9C1786;
	Sat, 19 Dec 2020 06:50:17 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 34053C0893
 for <iommu@lists.linux-foundation.org>; Sat, 19 Dec 2020 06:50:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 15AC7203F9
 for <iommu@lists.linux-foundation.org>; Sat, 19 Dec 2020 06:50:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MVsudMVv8XCH for <iommu@lists.linux-foundation.org>;
 Sat, 19 Dec 2020 06:50:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by silver.osuosl.org (Postfix) with ESMTPS id 30C15203EF
 for <iommu@lists.linux-foundation.org>; Sat, 19 Dec 2020 06:50:15 +0000 (UTC)
IronPort-SDR: TmDnN8WWkhlIewPfyBLWTxaNMEqwPYh+1QKUDYk0Rf/HliUSEo5P6DAgtfz+PD5sLpJ3Edeste
 3EWVDpp6xzQg==
X-IronPort-AV: E=McAfee;i="6000,8403,9839"; a="155350501"
X-IronPort-AV: E=Sophos;i="5.78,432,1599548400"; d="scan'208";a="155350501"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Dec 2020 22:50:14 -0800
IronPort-SDR: 2IL+r/UdxzPLvNyipmO0RVmOuZDU8Hxc+boa3wuPiGxSBr6F6ZgvP3JGua8HLgweXVE26lKX14
 FMr7JHMmIcIQ==
X-IronPort-AV: E=Sophos;i="5.78,432,1599548400"; d="scan'208";a="371015123"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.211.22])
 ([10.254.211.22])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Dec 2020 22:50:11 -0800
Subject: Re: [PATCH 1/3] iommu/vt-d: Move intel_iommu info from struct
 intel_svm to struct intel_svm_dev
To: Liu Yi L <yi.l.liu@intel.com>, jacob.jun.pan@intel.com,
 xin.zeng@intel.com, Kaijie.Guo@intel.com, will@kernel.org, joro@8bytes.org
References: <20201220000352.183523-1-yi.l.liu@intel.com>
 <20201220000352.183523-2-yi.l.liu@intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <e0761970-3151-ac82-51c4-94cdd2a43ce4@linux.intel.com>
Date: Sat, 19 Dec 2020 14:50:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20201220000352.183523-2-yi.l.liu@intel.com>
Content-Language: en-US
Cc: kevin.tian@intel.com, ashok.raj@intel.com, jun.j.tian@intel.com,
 iommu@lists.linux-foundation.org, David Woodhouse <dwmw2@infradead.org>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi,

On 2020/12/20 8:03, Liu Yi L wrote:
> Current struct intel_svm has a field to record the struct intel_iommu
> pointer for a PASID bind. And struct intel_svm will be shared by all
> the devices bind to the same process. The devices may be behind different
> DMAR units. As the iommu driver code uses the intel_iommu pointer stored
> in intel_svm struct to do cache invalidations, it may only flush the cache
> on a single DMAR unit, for others, the cache invalidation is missed.
> 
> As intel_svm struct already has a device list, this patch just moves the
> intel_iommu pointer to be a field of intel_svm_dev struct.
> 
> Fixes: 2f26e0a9c986 ("iommu/vt-d: Add basic SVM PASID support")
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Raj Ashok <ashok.raj@intel.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Reported-by: Guo Kaijie <Kaijie.Guo@intel.com>
> Reported-by: Xin Zeng <xin.zeng@intel.com>

Kaijie or Xin, can you please confirm whether this fix work for you?

Best regards,
baolu

> Signed-off-by: Guo Kaijie <Kaijie.Guo@intel.com>
> Signed-off-by: Xin Zeng <xin.zeng@intel.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> ---
>   drivers/iommu/intel/svm.c   | 9 +++++----
>   include/linux/intel-iommu.h | 2 +-
>   2 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index 3242ebd0bca3..4a10c9ff368c 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -142,7 +142,7 @@ static void intel_flush_svm_range_dev (struct intel_svm *svm, struct intel_svm_d
>   	}
>   	desc.qw2 = 0;
>   	desc.qw3 = 0;
> -	qi_submit_sync(svm->iommu, &desc, 1, 0);
> +	qi_submit_sync(sdev->iommu, &desc, 1, 0);
>   
>   	if (sdev->dev_iotlb) {
>   		desc.qw0 = QI_DEV_EIOTLB_PASID(svm->pasid) |
> @@ -166,7 +166,7 @@ static void intel_flush_svm_range_dev (struct intel_svm *svm, struct intel_svm_d
>   		}
>   		desc.qw2 = 0;
>   		desc.qw3 = 0;
> -		qi_submit_sync(svm->iommu, &desc, 1, 0);
> +		qi_submit_sync(sdev->iommu, &desc, 1, 0);
>   	}
>   }
>   
> @@ -211,7 +211,7 @@ static void intel_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
>   	 */
>   	rcu_read_lock();
>   	list_for_each_entry_rcu(sdev, &svm->devs, list)
> -		intel_pasid_tear_down_entry(svm->iommu, sdev->dev,
> +		intel_pasid_tear_down_entry(sdev->iommu, sdev->dev,
>   					    svm->pasid, true);
>   	rcu_read_unlock();
>   
> @@ -363,6 +363,7 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
>   	}
>   	sdev->dev = dev;
>   	sdev->sid = PCI_DEVID(info->bus, info->devfn);
> +	sdev->iommu = iommu;
>   
>   	/* Only count users if device has aux domains */
>   	if (iommu_dev_feature_enabled(dev, IOMMU_DEV_FEAT_AUX))
> @@ -546,6 +547,7 @@ intel_svm_bind_mm(struct device *dev, unsigned int flags,
>   		goto out;
>   	}
>   	sdev->dev = dev;
> +	sdev->iommu = iommu;
>   
>   	ret = intel_iommu_enable_pasid(iommu, dev);
>   	if (ret) {
> @@ -575,7 +577,6 @@ intel_svm_bind_mm(struct device *dev, unsigned int flags,
>   			kfree(sdev);
>   			goto out;
>   		}
> -		svm->iommu = iommu;
>   
>   		if (pasid_max > intel_pasid_max_id)
>   			pasid_max = intel_pasid_max_id;
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index d956987ed032..94522685a0d9 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -758,6 +758,7 @@ struct intel_svm_dev {
>   	struct list_head list;
>   	struct rcu_head rcu;
>   	struct device *dev;
> +	struct intel_iommu *iommu;
>   	struct svm_dev_ops *ops;
>   	struct iommu_sva sva;
>   	u32 pasid;
> @@ -771,7 +772,6 @@ struct intel_svm {
>   	struct mmu_notifier notifier;
>   	struct mm_struct *mm;
>   
> -	struct intel_iommu *iommu;
>   	unsigned int flags;
>   	u32 pasid;
>   	int gpasid; /* In case that guest PASID is different from host PASID */
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
