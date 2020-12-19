Return-Path: <SRS0=TI1w=FX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB14AC4361B
	for <iommu@archiver.kernel.org>; Sat, 19 Dec 2020 06:52:34 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5522C23B86
	for <iommu@archiver.kernel.org>; Sat, 19 Dec 2020 06:52:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5522C23B86
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 066E387A9E;
	Sat, 19 Dec 2020 06:52:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jTnPKCrte2Xx; Sat, 19 Dec 2020 06:52:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1493C879B5;
	Sat, 19 Dec 2020 06:52:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0A689C1786;
	Sat, 19 Dec 2020 06:52:33 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D2962C0893
 for <iommu@lists.linux-foundation.org>; Sat, 19 Dec 2020 06:52:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id C5E80203F9
 for <iommu@lists.linux-foundation.org>; Sat, 19 Dec 2020 06:52:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ET5jWcQ9eLlf for <iommu@lists.linux-foundation.org>;
 Sat, 19 Dec 2020 06:52:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by silver.osuosl.org (Postfix) with ESMTPS id A5534203B2
 for <iommu@lists.linux-foundation.org>; Sat, 19 Dec 2020 06:52:30 +0000 (UTC)
IronPort-SDR: Sv4ThKfQ7mueQ2wY+fLkMFSavzsxoIfqiOoAmO8XRRfEMRGmCFSdNp+lIqrIozzqcAnl/Nt1mq
 yKvKIS4XDaXA==
X-IronPort-AV: E=McAfee;i="6000,8403,9839"; a="175697971"
X-IronPort-AV: E=Sophos;i="5.78,432,1599548400"; d="scan'208";a="175697971"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Dec 2020 22:52:30 -0800
IronPort-SDR: WVoot7ci2P6ggWtNFK6zz5gs5QIkJNy/bBaQ62TKj/SzWE9te6kRJNMKirGdCql/0TNC2t+r61
 4vDg/p0mybZA==
X-IronPort-AV: E=Sophos;i="5.78,432,1599548400"; d="scan'208";a="371015457"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.211.22])
 ([10.254.211.22])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Dec 2020 22:52:27 -0800
Subject: Re: [PATCH 2/3] iommu/vt-d: Track device aux-attach with
 subdevice_domain_info.
To: Liu Yi L <yi.l.liu@intel.com>, jacob.jun.pan@intel.com,
 xin.zeng@intel.com, Kaijie.Guo@intel.com, will@kernel.org, joro@8bytes.org
References: <20201220000352.183523-1-yi.l.liu@intel.com>
 <20201220000352.183523-3-yi.l.liu@intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <0a7c9540-5417-c446-01ef-41d95ae39753@linux.intel.com>
Date: Sat, 19 Dec 2020 14:52:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20201220000352.183523-3-yi.l.liu@intel.com>
Content-Language: en-US
Cc: ashok.raj@intel.com, kevin.tian@intel.com, jun.j.tian@intel.com,
 iommu@lists.linux-foundation.org
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
> In existing code, if wanting to loop all devices attached to a domain,
> current code can only loop the devices which are attached to the domain
> via normal manner. While for devices attached via auxiliary manner, this
> is subdevice, they are not tracked in the domain. This patch adds struct
> subdevice_domain_info which is created per domain attachment via auxiliary
> manner. So that such devices are also tracked in domain.
> 
> This was found by when I'm working on the belwo patch, There is no device
> in domain->devices, thus unable to get the cap and ecap of iommu unit. But
> this domain actually has one sub-device which is attached via aux-manner.
> This patch fixes the issue.
> 
> https://lore.kernel.org/kvm/1599734733-6431-17-git-send-email-yi.l.liu@intel.com/
> 
> But looks like, it doesn't affect me only. Such auxiliary track should be
> there for example if wanting to flush device_iotlb for a domain which has
> devices attached by auxiliray manner, then this fix is also necessary. This
> issue will also be fixed by another patch in this series with some additional
> changes based on the sudevice tracking framework introduced in this patch.
> 
> Co-developed-by: Xin Zeng <xin.zeng@intel.com>
> Signed-off-by: Xin Zeng <xin.zeng@intel.com>
> Co-developed-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Co-developed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Please remove my Signed-off-by. I need to review and test it.

Best regards,
baolu

> ---
>   drivers/iommu/intel/iommu.c | 92 ++++++++++++++++++++++++++++++++-----
>   include/linux/intel-iommu.h | 11 ++++-
>   2 files changed, 90 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index a49afa11673c..4274b4acc325 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1881,6 +1881,7 @@ static struct dmar_domain *alloc_domain(int flags)
>   		domain->flags |= DOMAIN_FLAG_USE_FIRST_LEVEL;
>   	domain->has_iotlb_device = false;
>   	INIT_LIST_HEAD(&domain->devices);
> +	INIT_LIST_HEAD(&domain->sub_devices);
>   
>   	return domain;
>   }
> @@ -5172,33 +5173,79 @@ is_aux_domain(struct device *dev, struct iommu_domain *domain)
>   			domain->type == IOMMU_DOMAIN_UNMANAGED;
>   }
>   
> +static inline
> +void _auxiliary_link_device(struct dmar_domain *domain,
> +			    struct subdevice_domain_info *subinfo,
> +			    struct device *dev)
> +{
> +	subinfo->users++;
> +}
> +
> +static inline
> +int _auxiliary_unlink_device(struct dmar_domain *domain,
> +			     struct subdevice_domain_info *subinfo,
> +			     struct device *dev)
> +{
> +	subinfo->users--;
> +	return subinfo->users;
> +}
> +
>   static void auxiliary_link_device(struct dmar_domain *domain,
>   				  struct device *dev)
>   {
>   	struct device_domain_info *info = get_domain_info(dev);
> +	struct subdevice_domain_info *subinfo;
>   
>   	assert_spin_locked(&device_domain_lock);
>   	if (WARN_ON(!info))
>   		return;
>   
> +	subinfo = kzalloc(sizeof(*subinfo), GFP_ATOMIC);
> +	if (!subinfo)
> +		return;
> +
> +	subinfo->domain = domain;
> +	subinfo->dev = dev;
> +	list_add(&subinfo->link_domain, &info->auxiliary_domains);
> +	list_add(&subinfo->link_phys, &domain->sub_devices);
> +	_auxiliary_link_device(domain, subinfo, dev);
>   	domain->auxd_refcnt++;
> -	list_add(&domain->auxd, &info->auxiliary_domains);
>   }
>   
> -static void auxiliary_unlink_device(struct dmar_domain *domain,
> -				    struct device *dev)
> +static struct subdevice_domain_info *
> +subdevice_domain_info_lookup(struct dmar_domain *domain, struct device *dev)
> +{
> +	struct subdevice_domain_info *subinfo;
> +
> +	assert_spin_locked(&device_domain_lock);
> +
> +	list_for_each_entry(subinfo, &domain->sub_devices, link_phys)
> +		if (subinfo->dev == dev)
> +			return subinfo;
> +
> +	return NULL;
> +}
> +
> +static int auxiliary_unlink_device(struct dmar_domain *domain,
> +				   struct subdevice_domain_info *subinfo,
> +				   struct device *dev)
>   {
>   	struct device_domain_info *info = get_domain_info(dev);
> +	int ret;
>   
>   	assert_spin_locked(&device_domain_lock);
>   	if (WARN_ON(!info))
> -		return;
> +		return -EINVAL;
>   
> -	list_del(&domain->auxd);
> +	ret = _auxiliary_unlink_device(domain, subinfo, dev);
> +	if (ret == 0) {
> +		list_del(&subinfo->link_domain);
> +		list_del(&subinfo->link_phys);
> +		kfree(subinfo);
> +	}
>   	domain->auxd_refcnt--;
>   
> -	if (!domain->auxd_refcnt && domain->default_pasid > 0)
> -		ioasid_free(domain->default_pasid);
> +	return ret;
>   }
>   
>   static int aux_domain_add_dev(struct dmar_domain *domain,
> @@ -5207,6 +5254,8 @@ static int aux_domain_add_dev(struct dmar_domain *domain,
>   	int ret;
>   	unsigned long flags;
>   	struct intel_iommu *iommu;
> +	struct device_domain_info *info = get_domain_info(dev);
> +	struct subdevice_domain_info *subinfo;
>   
>   	iommu = device_to_iommu(dev, NULL, NULL);
>   	if (!iommu)
> @@ -5227,6 +5276,12 @@ static int aux_domain_add_dev(struct dmar_domain *domain,
>   	}
>   
>   	spin_lock_irqsave(&device_domain_lock, flags);
> +	subinfo = subdevice_domain_info_lookup(domain, dev);
> +	if (subinfo) {
> +		_auxiliary_link_device(domain, subinfo, dev);
> +		spin_unlock_irqrestore(&device_domain_lock, flags);
> +		return 0;
> +	}
>   	/*
>   	 * iommu->lock must be held to attach domain to iommu and setup the
>   	 * pasid entry for second level translation.
> @@ -5270,6 +5325,7 @@ static void aux_domain_remove_dev(struct dmar_domain *domain,
>   	struct device_domain_info *info;
>   	struct intel_iommu *iommu;
>   	unsigned long flags;
> +	struct subdevice_domain_info *subinfo;
>   
>   	if (!is_aux_domain(dev, &domain->domain))
>   		return;
> @@ -5278,14 +5334,26 @@ static void aux_domain_remove_dev(struct dmar_domain *domain,
>   	info = get_domain_info(dev);
>   	iommu = info->iommu;
>   
> -	auxiliary_unlink_device(domain, dev);
> +	subinfo = subdevice_domain_info_lookup(domain, dev);
> +	if (!subinfo) {
> +		spin_unlock_irqrestore(&device_domain_lock, flags);
> +		return;
> +	}
>   
> -	spin_lock(&iommu->lock);
> -	intel_pasid_tear_down_entry(iommu, dev, domain->default_pasid, false);
> -	domain_detach_iommu(domain, iommu);
> -	spin_unlock(&iommu->lock);
> +	if (auxiliary_unlink_device(domain, subinfo, dev) == 0) {
> +		spin_lock(&iommu->lock);
> +		intel_pasid_tear_down_entry(iommu,
> +					    dev,
> +					    domain->default_pasid,
> +					    false);
> +		domain_detach_iommu(domain, iommu);
> +		spin_unlock(&iommu->lock);
> +	}
>   
>   	spin_unlock_irqrestore(&device_domain_lock, flags);
> +
> +	if (!domain->auxd_refcnt && domain->default_pasid > 0)
> +		ioasid_free(domain->default_pasid);
>   }
>   
>   static int prepare_domain_attach_device(struct iommu_domain *domain,
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 94522685a0d9..1fb3d6ab719a 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -537,7 +537,7 @@ struct dmar_domain {
>   
>   	bool has_iotlb_device;
>   	struct list_head devices;	/* all devices' list */
> -	struct list_head auxd;		/* link to device's auxiliary list */
> +	struct list_head sub_devices;	/* all devices' list attached via aux-attach */
>   	struct iova_domain iovad;	/* iova's that belong to this domain */
>   
>   	struct dma_pte	*pgd;		/* virtual address */
> @@ -636,6 +636,15 @@ struct device_domain_info {
>   	struct pasid_table *pasid_table; /* pasid table */
>   };
>   
> +/* Aux attach device domain info */
> +struct subdevice_domain_info {
> +	struct device *dev;
> +	struct dmar_domain *domain;
> +	struct list_head link_phys;	/* link to phys device siblings */
> +	struct list_head link_domain;	/* link to domain siblings */
> +	int users;
> +};
> +
>   static inline void __iommu_flush_cache(
>   	struct intel_iommu *iommu, void *addr, int size)
>   {
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
