Return-Path: <SRS0=D+h4=F2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBFFC433E0
	for <iommu@archiver.kernel.org>; Tue, 22 Dec 2020 20:19:34 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EDCB229C5
	for <iommu@archiver.kernel.org>; Tue, 22 Dec 2020 20:19:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EDCB229C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id DF633867E2;
	Tue, 22 Dec 2020 20:19:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5MkvC-fNv0dO; Tue, 22 Dec 2020 20:19:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B5490868E2;
	Tue, 22 Dec 2020 20:19:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9386BC1825;
	Tue, 22 Dec 2020 20:19:32 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D3FF0C0893
 for <iommu@lists.linux-foundation.org>; Tue, 22 Dec 2020 20:19:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id B3CEB2725F
 for <iommu@lists.linux-foundation.org>; Tue, 22 Dec 2020 20:19:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z0EG7Zx3oAWr for <iommu@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 20:19:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by silver.osuosl.org (Postfix) with ESMTPS id 6312823492
 for <iommu@lists.linux-foundation.org>; Tue, 22 Dec 2020 20:19:29 +0000 (UTC)
IronPort-SDR: dzAekvMlgaqoF5ZgCWQ+eVA8CpcwUg0AX4swjn2SjyJeAJMIOfClizyVaxlzYUWk73Ggj1zcL0
 IXhaEXMa2wcg==
X-IronPort-AV: E=McAfee;i="6000,8403,9843"; a="237480919"
X-IronPort-AV: E=Sophos;i="5.78,440,1599548400"; d="scan'208";a="237480919"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Dec 2020 12:19:23 -0800
IronPort-SDR: T8xB+DjP6+ndmksCcWz5/zzjAJjN4m9x+3umEVpQukppRbr7XSPtyklCIvCbdKnN0eGpK2jrZX
 43Xe54Ofv1OA==
X-IronPort-AV: E=Sophos;i="5.78,440,1599548400"; d="scan'208";a="341852209"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Dec 2020 12:19:23 -0800
Date: Tue, 22 Dec 2020 12:21:28 -0800
From: Jacob Pan <jacob.jun.pan@intel.com>
To: Liu Yi L <yi.l.liu@intel.com>
Subject: Re: [PATCH 2/3] iommu/vt-d: Track device aux-attach with
 subdevice_domain_info.
Message-ID: <20201222122128.233d928d@jacob-builder>
In-Reply-To: <20201220000352.183523-3-yi.l.liu@intel.com>
References: <20201220000352.183523-1-yi.l.liu@intel.com>
 <20201220000352.183523-3-yi.l.liu@intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: kevin.tian@intel.com, Kaijie.Guo@intel.com, ashok.raj@intel.com,
 iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com, will@kernel.org,
 jun.j.tian@intel.com
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

Hi Yi,

On Sun, 20 Dec 2020 08:03:51 +0800, Liu Yi L <yi.l.liu@intel.com> wrote:

> In existing code, if wanting to loop all devices attached to a domain,
> current code can only loop the devices which are attached to the domain
> via normal manner. While for devices attached via auxiliary manner, this
> is subdevice, they are not tracked in the domain. This patch adds struct
How about "In the existing code, loop all devices attached to a domain does
not include sub-devices attached via iommu_aux_attach_device()."

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
> devices attached by auxiliray manner, then this fix is also necessary.
Perhaps:
This fix goes beyond the patch above, such sub-device tracking is
necessary for other cases. For example, flushing device_iotlb for a domain
which has sub-devices attached by auxiliary manner.

> This issue will also be fixed by another patch in this series with some
> additional changes based on the sudevice tracking framework introduced in
> this patch.
> 
> Co-developed-by: Xin Zeng <xin.zeng@intel.com>
> Signed-off-by: Xin Zeng <xin.zeng@intel.com>
> Co-developed-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Co-developed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 92 ++++++++++++++++++++++++++++++++-----
>  include/linux/intel-iommu.h | 11 ++++-
>  2 files changed, 90 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index a49afa11673c..4274b4acc325 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1881,6 +1881,7 @@ static struct dmar_domain *alloc_domain(int flags)
>  		domain->flags |= DOMAIN_FLAG_USE_FIRST_LEVEL;
>  	domain->has_iotlb_device = false;
>  	INIT_LIST_HEAD(&domain->devices);
> +	INIT_LIST_HEAD(&domain->sub_devices);
>  
>  	return domain;
>  }
> @@ -5172,33 +5173,79 @@ is_aux_domain(struct device *dev, struct
> iommu_domain *domain) domain->type == IOMMU_DOMAIN_UNMANAGED;
>  }
>  
> +static inline
> +void _auxiliary_link_device(struct dmar_domain *domain,
> +			    struct subdevice_domain_info *subinfo,
> +			    struct device *dev)
> +{
> +	subinfo->users++;
> +}
> +
why pass in more arguments than subinfo? the function name does not match
what it does, seems just refcount inc.

> +static inline
> +int _auxiliary_unlink_device(struct dmar_domain *domain,
> +			     struct subdevice_domain_info *subinfo,
> +			     struct device *dev)
> +{
> +	subinfo->users--;
> +	return subinfo->users;
ditto. why not just
 	return subinfo->users--;

> +}
> +
>  static void auxiliary_link_device(struct dmar_domain *domain,
>  				  struct device *dev)
>  {
>  	struct device_domain_info *info = get_domain_info(dev);
> +	struct subdevice_domain_info *subinfo;
>  
>  	assert_spin_locked(&device_domain_lock);
>  	if (WARN_ON(!info))
>  		return;
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
or just opencode subinfo->users++?
>  	domain->auxd_refcnt++;
> -	list_add(&domain->auxd, &info->auxiliary_domains);
>  }
>  
> -static void auxiliary_unlink_device(struct dmar_domain *domain,
> -				    struct device *dev)
> +static struct subdevice_domain_info *
> +subdevice_domain_info_lookup(struct dmar_domain *domain, struct device
> *dev) +{
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
>  {
>  	struct device_domain_info *info = get_domain_info(dev);
> +	int ret;
>  
>  	assert_spin_locked(&device_domain_lock);
>  	if (WARN_ON(!info))
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
>  	domain->auxd_refcnt--;
>  
> -	if (!domain->auxd_refcnt && domain->default_pasid > 0)
> -		ioasid_free(domain->default_pasid);
> +	return ret;
>  }
>  
>  static int aux_domain_add_dev(struct dmar_domain *domain,
> @@ -5207,6 +5254,8 @@ static int aux_domain_add_dev(struct dmar_domain
> *domain, int ret;
>  	unsigned long flags;
>  	struct intel_iommu *iommu;
> +	struct device_domain_info *info = get_domain_info(dev);
> +	struct subdevice_domain_info *subinfo;
>  
>  	iommu = device_to_iommu(dev, NULL, NULL);
>  	if (!iommu)
> @@ -5227,6 +5276,12 @@ static int aux_domain_add_dev(struct dmar_domain
> *domain, }
>  
>  	spin_lock_irqsave(&device_domain_lock, flags);
> +	subinfo = subdevice_domain_info_lookup(domain, dev);
> +	if (subinfo) {
> +		_auxiliary_link_device(domain, subinfo, dev);
> +		spin_unlock_irqrestore(&device_domain_lock, flags);
> +		return 0;
> +	}
>  	/*
>  	 * iommu->lock must be held to attach domain to iommu and setup
> the
>  	 * pasid entry for second level translation.
> @@ -5270,6 +5325,7 @@ static void aux_domain_remove_dev(struct
> dmar_domain *domain, struct device_domain_info *info;
>  	struct intel_iommu *iommu;
>  	unsigned long flags;
> +	struct subdevice_domain_info *subinfo;
>  
>  	if (!is_aux_domain(dev, &domain->domain))
>  		return;
> @@ -5278,14 +5334,26 @@ static void aux_domain_remove_dev(struct
> dmar_domain *domain, info = get_domain_info(dev);
>  	iommu = info->iommu;
>  
> -	auxiliary_unlink_device(domain, dev);
> +	subinfo = subdevice_domain_info_lookup(domain, dev);
> +	if (!subinfo) {
> +		spin_unlock_irqrestore(&device_domain_lock, flags);
> +		return;
> +	}
>  
> -	spin_lock(&iommu->lock);
> -	intel_pasid_tear_down_entry(iommu, dev, domain->default_pasid,
> false);
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
>  	spin_unlock_irqrestore(&device_domain_lock, flags);
> +
> +	if (!domain->auxd_refcnt && domain->default_pasid > 0)
> +		ioasid_free(domain->default_pasid);
>  }
>  
>  static int prepare_domain_attach_device(struct iommu_domain *domain,
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 94522685a0d9..1fb3d6ab719a 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -537,7 +537,7 @@ struct dmar_domain {
>  
>  	bool has_iotlb_device;
>  	struct list_head devices;	/* all devices' list */
> -	struct list_head auxd;		/* link to device's
> auxiliary list */
> +	struct list_head sub_devices;	/* all devices' list
> attached via aux-attach */ struct iova_domain iovad;	/* iova's
> that belong to this domain */ 
>  	struct dma_pte	*pgd;		/* virtual address */
> @@ -636,6 +636,15 @@ struct device_domain_info {
>  	struct pasid_table *pasid_table; /* pasid table */
>  };
>  
> +/* Aux attach device domain info */
> +struct subdevice_domain_info {
> +	struct device *dev;
> +	struct dmar_domain *domain;
> +	struct list_head link_phys;	/* link to phys device
> siblings */
> +	struct list_head link_domain;	/* link to domain siblings
> */
> +	int users;
> +};
> +
>  static inline void __iommu_flush_cache(
>  	struct intel_iommu *iommu, void *addr, int size)
>  {


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
