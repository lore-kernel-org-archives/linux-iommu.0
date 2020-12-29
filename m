Return-Path: <SRS0=AIYf=GB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E588EC433E0
	for <iommu@archiver.kernel.org>; Tue, 29 Dec 2020 08:38:31 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66ECB208BA
	for <iommu@archiver.kernel.org>; Tue, 29 Dec 2020 08:38:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66ECB208BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B76222043E;
	Tue, 29 Dec 2020 08:38:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KOi4vvcRSVNf; Tue, 29 Dec 2020 08:38:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 6267320400;
	Tue, 29 Dec 2020 08:38:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2D0B4C088B;
	Tue, 29 Dec 2020 08:38:29 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A41DEC0174
 for <iommu@lists.linux-foundation.org>; Tue, 29 Dec 2020 08:38:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8924A86D2E
 for <iommu@lists.linux-foundation.org>; Tue, 29 Dec 2020 08:38:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id smxEM5m7K6qC for <iommu@lists.linux-foundation.org>;
 Tue, 29 Dec 2020 08:38:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B4ADA86D2C
 for <iommu@lists.linux-foundation.org>; Tue, 29 Dec 2020 08:38:25 +0000 (UTC)
IronPort-SDR: 00CufVTXbqZYR2fu/+RzqNg5xnxfRECpN1L851b3W9h8HK8kzqKW3GnBcWB0/duLVf90mIurBo
 cvJ//n1Os5uQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9848"; a="194960199"
X-IronPort-AV: E=Sophos;i="5.78,457,1599548400"; d="scan'208";a="194960199"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Dec 2020 00:38:25 -0800
IronPort-SDR: hksd2KKqzUHCpXnb34WnDJesjK9Qzkg8ylAiXT4oncDdIY5YI6FB950KJIoxJzy8O56m4Am6yP
 q7YGl4+5diSA==
X-IronPort-AV: E=Sophos;i="5.78,457,1599548400"; d="scan'208";a="375976751"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.213.128])
 ([10.254.213.128])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Dec 2020 00:38:22 -0800
Subject: Re: [PATCH v3 2/3] iommu/vt-d: Track device aux-attach with
 subdevice_domain_info
To: Liu Yi L <yi.l.liu@intel.com>, joro@8bytes.org, will@kernel.org
References: <20201229032513.486395-1-yi.l.liu@intel.com>
 <20201229032513.486395-3-yi.l.liu@intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <604d35d9-ef43-e57c-07e2-59d57d2b7ad1@linux.intel.com>
Date: Tue, 29 Dec 2020 16:38:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20201229032513.486395-3-yi.l.liu@intel.com>
Content-Language: en-US
Cc: kevin.tian@intel.com, ashok.raj@intel.com, jun.j.tian@intel.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 yi.y.sun@intel.com
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

Hi Yi,

On 2020/12/29 11:25, Liu Yi L wrote:
> In the existing code, loop all devices attached to a domain does not
> include sub-devices attached via iommu_aux_attach_device().
> 
> This was found by when I'm working on the belwo patch, There is no
                                             ^^^^^
below

> device in the domain->devices list, thus unable to get the cap and
> ecap of iommu unit. But this domain actually has subdevice which is
> attached via aux-manner. But it is tracked by domain. This patch is
> going to fix it.
> 
> https://lore.kernel.org/kvm/1599734733-6431-17-git-send-email-yi.l.liu@intel.com/
> 
> And this fix goes beyond the patch above, such sub-device tracking is
> necessary for other cases. For example, flushing device_iotlb for a
> domain which has sub-devices attached by auxiliary manner.
> 
> Co-developed-by: Xin Zeng <xin.zeng@intel.com>
> Signed-off-by: Xin Zeng <xin.zeng@intel.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>

Others look good to me.

Fixes: 67b8e02b5e761 ("iommu/vt-d: Aux-domain specific domain 
attach/detach")
Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> ---
>   drivers/iommu/intel/iommu.c | 95 +++++++++++++++++++++++++++----------
>   include/linux/intel-iommu.h | 16 +++++--
>   2 files changed, 82 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 788119c5b021..d7720a836268 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1877,6 +1877,7 @@ static struct dmar_domain *alloc_domain(int flags)
>   		domain->flags |= DOMAIN_FLAG_USE_FIRST_LEVEL;
>   	domain->has_iotlb_device = false;
>   	INIT_LIST_HEAD(&domain->devices);
> +	INIT_LIST_HEAD(&domain->subdevices);
>   
>   	return domain;
>   }
> @@ -2547,7 +2548,7 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
>   	info->iommu = iommu;
>   	info->pasid_table = NULL;
>   	info->auxd_enabled = 0;
> -	INIT_LIST_HEAD(&info->auxiliary_domains);
> +	INIT_LIST_HEAD(&info->subdevices);
>   
>   	if (dev && dev_is_pci(dev)) {
>   		struct pci_dev *pdev = to_pci_dev(info->dev);
> @@ -4475,33 +4476,61 @@ is_aux_domain(struct device *dev, struct iommu_domain *domain)
>   			domain->type == IOMMU_DOMAIN_UNMANAGED;
>   }
>   
> -static void auxiliary_link_device(struct dmar_domain *domain,
> -				  struct device *dev)
> +static inline struct subdev_domain_info *
> +lookup_subdev_info(struct dmar_domain *domain, struct device *dev)
> +{
> +	struct subdev_domain_info *sinfo;
> +
> +	if (!list_empty(&domain->subdevices)) {
> +		list_for_each_entry(sinfo, &domain->subdevices, link_domain) {
> +			if (sinfo->pdev == dev)
> +				return sinfo;
> +		}
> +	}
> +
> +	return NULL;
> +}
> +
> +static int auxiliary_link_device(struct dmar_domain *domain,
> +				 struct device *dev)
>   {
>   	struct device_domain_info *info = get_domain_info(dev);
> +	struct subdev_domain_info *sinfo = lookup_subdev_info(domain, dev);
>   
>   	assert_spin_locked(&device_domain_lock);
>   	if (WARN_ON(!info))
> -		return;
> +		return -EINVAL;
> +
> +	if (!sinfo) {
> +		sinfo = kzalloc(sizeof(*sinfo), GFP_ATOMIC);
> +		sinfo->domain = domain;
> +		sinfo->pdev = dev;
> +		list_add(&sinfo->link_phys, &info->subdevices);
> +		list_add(&sinfo->link_domain, &domain->subdevices);
> +	}
>   
> -	domain->auxd_refcnt++;
> -	list_add(&domain->auxd, &info->auxiliary_domains);
> +	return ++sinfo->users;
>   }
>   
> -static void auxiliary_unlink_device(struct dmar_domain *domain,
> -				    struct device *dev)
> +static int auxiliary_unlink_device(struct dmar_domain *domain,
> +				   struct device *dev)
>   {
>   	struct device_domain_info *info = get_domain_info(dev);
> +	struct subdev_domain_info *sinfo = lookup_subdev_info(domain, dev);
> +	int ret;
>   
>   	assert_spin_locked(&device_domain_lock);
> -	if (WARN_ON(!info))
> -		return;
> +	if (WARN_ON(!info || !sinfo || sinfo->users <= 0))
> +		return -EINVAL;
>   
> -	list_del(&domain->auxd);
> -	domain->auxd_refcnt--;
> +	ret = --sinfo->users;
> +	if (!ret) {
> +		list_del(&sinfo->link_phys);
> +		list_del(&sinfo->link_domain);
> +		kfree(sinfo);
> +	}
>   
> -	if (!domain->auxd_refcnt && domain->default_pasid > 0)
> -		ioasid_put(domain->default_pasid);
> +	return ret;
>   }
>   
>   static int aux_domain_add_dev(struct dmar_domain *domain,
> @@ -4530,6 +4559,19 @@ static int aux_domain_add_dev(struct dmar_domain *domain,
>   	}
>   
>   	spin_lock_irqsave(&device_domain_lock, flags);
> +	ret = auxiliary_link_device(domain, dev);
> +	if (ret <= 0)
> +		goto link_failed;
> +
> +	/*
> +	 * Subdevices from the same physical device can be attached to the
> +	 * same domain. For such cases, only the first subdevice attachment
> +	 * needs to go through the full steps in this function. So if ret >
> +	 * 1, just goto out.
> +	 */
> +	if (ret > 1)
> +		goto out;
> +
>   	/*
>   	 * iommu->lock must be held to attach domain to iommu and setup the
>   	 * pasid entry for second level translation.
> @@ -4548,10 +4590,9 @@ static int aux_domain_add_dev(struct dmar_domain *domain,
>   						     domain->default_pasid);
>   	if (ret)
>   		goto table_failed;
> -	spin_unlock(&iommu->lock);
> -
> -	auxiliary_link_device(domain, dev);
>   
> +	spin_unlock(&iommu->lock);
> +out:
>   	spin_unlock_irqrestore(&device_domain_lock, flags);
>   
>   	return 0;
> @@ -4560,8 +4601,10 @@ static int aux_domain_add_dev(struct dmar_domain *domain,
>   	domain_detach_iommu(domain, iommu);
>   attach_failed:
>   	spin_unlock(&iommu->lock);
> +	auxiliary_unlink_device(domain, dev);
> +link_failed:
>   	spin_unlock_irqrestore(&device_domain_lock, flags);
> -	if (!domain->auxd_refcnt && domain->default_pasid > 0)
> +	if (list_empty(&domain->subdevices) && domain->default_pasid > 0)
>   		ioasid_put(domain->default_pasid);
>   
>   	return ret;
> @@ -4581,14 +4624,18 @@ static void aux_domain_remove_dev(struct dmar_domain *domain,
>   	info = get_domain_info(dev);
>   	iommu = info->iommu;
>   
> -	auxiliary_unlink_device(domain, dev);
> -
> -	spin_lock(&iommu->lock);
> -	intel_pasid_tear_down_entry(iommu, dev, domain->default_pasid, false);
> -	domain_detach_iommu(domain, iommu);
> -	spin_unlock(&iommu->lock);
> +	if (!auxiliary_unlink_device(domain, dev)) {
> +		spin_lock(&iommu->lock);
> +		intel_pasid_tear_down_entry(iommu, dev,
> +					    domain->default_pasid, false);
> +		domain_detach_iommu(domain, iommu);
> +		spin_unlock(&iommu->lock);
> +	}
>   
>   	spin_unlock_irqrestore(&device_domain_lock, flags);
> +
> +	if (list_empty(&domain->subdevices) && domain->default_pasid > 0)
> +		ioasid_put(domain->default_pasid);
>   }
>   
>   static int prepare_domain_attach_device(struct iommu_domain *domain,
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 94522685a0d9..09c6a0bf3892 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -533,11 +533,10 @@ struct dmar_domain {
>   					/* Domain ids per IOMMU. Use u16 since
>   					 * domain ids are 16 bit wide according
>   					 * to VT-d spec, section 9.3 */
> -	unsigned int	auxd_refcnt;	/* Refcount of auxiliary attaching */
>   
>   	bool has_iotlb_device;
>   	struct list_head devices;	/* all devices' list */
> -	struct list_head auxd;		/* link to device's auxiliary list */
> +	struct list_head subdevices;	/* all subdevices' list */
>   	struct iova_domain iovad;	/* iova's that belong to this domain */
>   
>   	struct dma_pte	*pgd;		/* virtual address */
> @@ -610,14 +609,21 @@ struct intel_iommu {
>   	struct dmar_drhd_unit *drhd;
>   };
>   
> +/* Per subdevice private data */
> +struct subdev_domain_info {
> +	struct list_head link_phys;	/* link to phys device siblings */
> +	struct list_head link_domain;	/* link to domain siblings */
> +	struct device *pdev;		/* physical device derived from */
> +	struct dmar_domain *domain;	/* aux-domain */
> +	int users;			/* user count */
> +};
> +
>   /* PCI domain-device relationship */
>   struct device_domain_info {
>   	struct list_head link;	/* link to domain siblings */
>   	struct list_head global; /* link to global list */
>   	struct list_head table;	/* link to pasid table */
> -	struct list_head auxiliary_domains; /* auxiliary domains
> -					     * attached to this device
> -					     */
> +	struct list_head subdevices; /* subdevices sibling */
>   	u32 segment;		/* PCI segment number */
>   	u8 bus;			/* PCI bus number */
>   	u8 devfn;		/* PCI devfn number */
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
