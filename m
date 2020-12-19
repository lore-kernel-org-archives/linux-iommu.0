Return-Path: <SRS0=TI1w=FX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9839AC4361B
	for <iommu@archiver.kernel.org>; Sat, 19 Dec 2020 06:53:04 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46FB923B86
	for <iommu@archiver.kernel.org>; Sat, 19 Dec 2020 06:53:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46FB923B86
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id E43262042E;
	Sat, 19 Dec 2020 06:53:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CNtVL2Sma8r9; Sat, 19 Dec 2020 06:53:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 6492E203B2;
	Sat, 19 Dec 2020 06:53:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4A940C1786;
	Sat, 19 Dec 2020 06:53:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7D7B5C0893
 for <iommu@lists.linux-foundation.org>; Sat, 19 Dec 2020 06:53:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6B7AC87A99
 for <iommu@lists.linux-foundation.org>; Sat, 19 Dec 2020 06:53:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vyPnD5IpJoRx for <iommu@lists.linux-foundation.org>;
 Sat, 19 Dec 2020 06:53:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 9D8A5879B5
 for <iommu@lists.linux-foundation.org>; Sat, 19 Dec 2020 06:53:00 +0000 (UTC)
IronPort-SDR: 8YVCMaihrxnCrfd3Q52R1deNUUcFS+rBJ2VYZLwBJ2d0KvxoZeAhGTx+dwkzwwpMcTDSwa972U
 kPLKDDC0keaw==
X-IronPort-AV: E=McAfee;i="6000,8403,9839"; a="239642499"
X-IronPort-AV: E=Sophos;i="5.78,432,1599548400"; d="scan'208";a="239642499"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Dec 2020 22:52:59 -0800
IronPort-SDR: NKkzshF5Gfy4BVoozlFj8HJml/KKu8RsoEFjkIRXfATgkiwu9T4UsZdNwVrivAMEMdnGkvTyrQ
 b8xniu6vA+oA==
X-IronPort-AV: E=Sophos;i="5.78,432,1599548400"; d="scan'208";a="371015532"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.211.22])
 ([10.254.211.22])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Dec 2020 22:52:57 -0800
Subject: Re: [PATCH 3/3] iommu/vt-d: A fix to iommu_flush_dev_iotlb() for
 aux-domain
To: Liu Yi L <yi.l.liu@intel.com>, jacob.jun.pan@intel.com,
 xin.zeng@intel.com, Kaijie.Guo@intel.com, will@kernel.org, joro@8bytes.org
References: <20201220000352.183523-1-yi.l.liu@intel.com>
 <20201220000352.183523-4-yi.l.liu@intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <f6e34d8d-3e85-2a4e-3c6a-15ca66774475@linux.intel.com>
Date: Sat, 19 Dec 2020 14:52:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20201220000352.183523-4-yi.l.liu@intel.com>
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
> iommu_flush_dev_iotlb() is called to invalidate caches on device. It only
> loops the devices which are full-attached to the domain. For sub-devices,
> this is ineffective. This results in invalid caching entries left on the
> device. Fix it by adding loop for subdevices as well. Also, update the
> domain->has_iotlb_device for both device/subdevice attach/detach and
> ATS enabling/disabling.
> 
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

The same here.

Best regards,
baolu

> ---
>   drivers/iommu/intel/iommu.c | 90 +++++++++++++++++++++++++++++--------
>   1 file changed, 72 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 4274b4acc325..d9b6037b72b1 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1437,6 +1437,10 @@ static void __iommu_flush_iotlb(struct intel_iommu *iommu, u16 did,
>   			(unsigned long long)DMA_TLB_IAIG(val));
>   }
>   
> +/**
> + * For a given bus/devfn, fetch its device_domain_info if it supports
> + * device tlb. Only needs to loop devices attached in normal manner.
> + */
>   static struct device_domain_info *
>   iommu_support_dev_iotlb (struct dmar_domain *domain, struct intel_iommu *iommu,
>   			 u8 bus, u8 devfn)
> @@ -1459,6 +1463,18 @@ iommu_support_dev_iotlb (struct dmar_domain *domain, struct intel_iommu *iommu,
>   	return NULL;
>   }
>   
> +static bool dev_iotlb_enabled(struct device *dev)
> +{
> +	struct pci_dev *pdev;
> +
> +	if (!dev || !dev_is_pci(dev))
> +		return false;
> +
> +	pdev = to_pci_dev(dev);
> +
> +	return !!pdev->ats_enabled;
> +}
> +
>   static void domain_update_iotlb(struct dmar_domain *domain)
>   {
>   	struct device_domain_info *info;
> @@ -1467,21 +1483,37 @@ static void domain_update_iotlb(struct dmar_domain *domain)
>   	assert_spin_locked(&device_domain_lock);
>   
>   	list_for_each_entry(info, &domain->devices, link) {
> -		struct pci_dev *pdev;
> -
> -		if (!info->dev || !dev_is_pci(info->dev))
> -			continue;
> -
> -		pdev = to_pci_dev(info->dev);
> -		if (pdev->ats_enabled) {
> +		if (dev_iotlb_enabled(info->dev)) {
>   			has_iotlb_device = true;
>   			break;
>   		}
>   	}
>   
> +	if (!has_iotlb_device) {
> +		struct subdevice_domain_info *subinfo;
> +
> +		list_for_each_entry(subinfo, &domain->sub_devices, link_phys) {
> +			if (dev_iotlb_enabled(subinfo->dev)) {
> +				has_iotlb_device = true;
> +				break;
> +			}
> +		}
> +	}
>   	domain->has_iotlb_device = has_iotlb_device;
>   }
>   
> +static void dev_update_domain_iotlb(struct device_domain_info *info)
> +{
> +	struct subdevice_domain_info *subinfo;
> +
> +	assert_spin_locked(&device_domain_lock);
> +
> +	domain_update_iotlb(info->domain);
> +
> +	list_for_each_entry(subinfo, &info->auxiliary_domains, link_domain)
> +		domain_update_iotlb(subinfo->domain);
> +}
> +
>   static void iommu_enable_dev_iotlb(struct device_domain_info *info)
>   {
>   	struct pci_dev *pdev;
> @@ -1524,7 +1556,7 @@ static void iommu_enable_dev_iotlb(struct device_domain_info *info)
>   	if (info->ats_supported && pci_ats_page_aligned(pdev) &&
>   	    !pci_enable_ats(pdev, VTD_PAGE_SHIFT)) {
>   		info->ats_enabled = 1;
> -		domain_update_iotlb(info->domain);
> +		dev_update_domain_iotlb(info);
>   		info->ats_qdep = pci_ats_queue_depth(pdev);
>   	}
>   }
> @@ -1543,7 +1575,7 @@ static void iommu_disable_dev_iotlb(struct device_domain_info *info)
>   	if (info->ats_enabled) {
>   		pci_disable_ats(pdev);
>   		info->ats_enabled = 0;
> -		domain_update_iotlb(info->domain);
> +		dev_update_domain_iotlb(info);
>   	}
>   #ifdef CONFIG_INTEL_IOMMU_SVM
>   	if (info->pri_enabled) {
> @@ -1557,26 +1589,43 @@ static void iommu_disable_dev_iotlb(struct device_domain_info *info)
>   #endif
>   }
>   
> +static void __iommu_flush_dev_iotlb(struct device_domain_info *info,
> +				    u64 addr, unsigned mask)
> +{
> +	u16 sid, qdep;
> +
> +	if (!info || !info->ats_enabled)
> +		return;
> +
> +	sid = info->bus << 8 | info->devfn;
> +	qdep = info->ats_qdep;
> +	qi_flush_dev_iotlb(info->iommu, sid, info->pfsid,
> +			   qdep, addr, mask);
> +}
> +
>   static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
>   				  u64 addr, unsigned mask)
>   {
> -	u16 sid, qdep;
>   	unsigned long flags;
>   	struct device_domain_info *info;
> +	struct subdevice_domain_info *subinfo;
>   
>   	if (!domain->has_iotlb_device)
>   		return;
>   
>   	spin_lock_irqsave(&device_domain_lock, flags);
> -	list_for_each_entry(info, &domain->devices, link) {
> -		if (!info->ats_enabled)
> -			continue;
> +	list_for_each_entry(info, &domain->devices, link)
> +		__iommu_flush_dev_iotlb(info, addr, mask);
> +
> +	/*
> +	 * Besides looping all devices attached normally, also
> +	 * needs to loop all devices attached via auxiliary
> +	 * manner.
> +	 */
> +	list_for_each_entry(subinfo, &domain->sub_devices, link_phys)
> +		__iommu_flush_dev_iotlb(get_domain_info(subinfo->dev),
> +					addr, mask);
>   
> -		sid = info->bus << 8 | info->devfn;
> -		qdep = info->ats_qdep;
> -		qi_flush_dev_iotlb(info->iommu, sid, info->pfsid,
> -				qdep, addr, mask);
> -	}
>   	spin_unlock_irqrestore(&device_domain_lock, flags);
>   }
>   
> @@ -5208,6 +5257,9 @@ static void auxiliary_link_device(struct dmar_domain *domain,
>   	subinfo->dev = dev;
>   	list_add(&subinfo->link_domain, &info->auxiliary_domains);
>   	list_add(&subinfo->link_phys, &domain->sub_devices);
> +	if (dev_iotlb_enabled(dev))
> +		domain_update_iotlb(domain);
> +
>   	_auxiliary_link_device(domain, subinfo, dev);
>   	domain->auxd_refcnt++;
>   }
> @@ -5242,6 +5294,8 @@ static int auxiliary_unlink_device(struct dmar_domain *domain,
>   		list_del(&subinfo->link_domain);
>   		list_del(&subinfo->link_phys);
>   		kfree(subinfo);
> +		if (domain->has_iotlb_device)
> +			domain_update_iotlb(domain);
>   	}
>   	domain->auxd_refcnt--;
>   
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
