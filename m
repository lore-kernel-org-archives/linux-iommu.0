Return-Path: <SRS0=AIYf=GB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1D3C433E0
	for <iommu@archiver.kernel.org>; Tue, 29 Dec 2020 08:41:42 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DF7E208BA
	for <iommu@archiver.kernel.org>; Tue, 29 Dec 2020 08:41:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DF7E208BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9A3228559B;
	Tue, 29 Dec 2020 08:41:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y_dyko3oy1m5; Tue, 29 Dec 2020 08:41:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DA68B85188;
	Tue, 29 Dec 2020 08:41:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B37D4C088B;
	Tue, 29 Dec 2020 08:41:40 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8EFFFC0174
 for <iommu@lists.linux-foundation.org>; Tue, 29 Dec 2020 08:41:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A0A5D2043E
 for <iommu@lists.linux-foundation.org>; Tue, 29 Dec 2020 08:41:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id enSAKVN8Ks9j for <iommu@lists.linux-foundation.org>;
 Tue, 29 Dec 2020 08:41:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by silver.osuosl.org (Postfix) with ESMTPS id 307742040B
 for <iommu@lists.linux-foundation.org>; Tue, 29 Dec 2020 08:41:36 +0000 (UTC)
IronPort-SDR: vew5WP2rjSA9I38TikhQ8gHcxAOGRcl4LMMjxBCIg3RfXQVX/2xCmRRrf+q4XPg+REMiy4OFFu
 Y7t9OpQUzD0w==
X-IronPort-AV: E=McAfee;i="6000,8403,9848"; a="155676701"
X-IronPort-AV: E=Sophos;i="5.78,457,1599548400"; d="scan'208";a="155676701"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Dec 2020 00:41:35 -0800
IronPort-SDR: Lr5VZeKrmI70xAdjYiNIdUs8pTXMa3RoOoed4mhyolDUiJ0GRapWqmqxA9A4NfuZTGRXhsCm3a
 K7JqplBwDsyA==
X-IronPort-AV: E=Sophos;i="5.78,457,1599548400"; d="scan'208";a="375977681"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.213.128])
 ([10.254.213.128])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Dec 2020 00:41:32 -0800
Subject: Re: [PATCH v3 3/3] iommu/vt-d: Fix ineffective devTLB invalidation
 for subdevices
To: Liu Yi L <yi.l.liu@intel.com>, joro@8bytes.org, will@kernel.org
References: <20201229032513.486395-1-yi.l.liu@intel.com>
 <20201229032513.486395-4-yi.l.liu@intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <c109eb64-2805-5e87-2283-b52c5704a31f@linux.intel.com>
Date: Tue, 29 Dec 2020 16:41:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20201229032513.486395-4-yi.l.liu@intel.com>
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
> iommu_flush_dev_iotlb() is called to invalidate caches on device. It only
> loops the devices which are full-attached to the domain. For sub-devices,
> this is ineffective. This results in invalid caching entries left on the
> device. Fix it by adding loop for subdevices as well. Also, the domain->
> has_iotlb_device needs to be updated when attaching to subdevices.
> 
> Fixes: 67b8e02b5e761 ("iommu/vt-d: Aux-domain specific domain attach/detach")
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 53 ++++++++++++++++++++++++++-----------
>   1 file changed, 37 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index d7720a836268..d48a60b61ba6 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -719,6 +719,8 @@ static int domain_update_device_node(struct dmar_domain *domain)
>   	return nid;
>   }
>   
> +static void domain_update_iotlb(struct dmar_domain *domain);
> +
>   /* Some capabilities may be different across iommus */
>   static void domain_update_iommu_cap(struct dmar_domain *domain)
>   {
> @@ -744,6 +746,8 @@ static void domain_update_iommu_cap(struct dmar_domain *domain)
>   		domain->domain.geometry.aperture_end = __DOMAIN_MAX_ADDR(domain->gaw - 1);
>   	else
>   		domain->domain.geometry.aperture_end = __DOMAIN_MAX_ADDR(domain->gaw);
> +
> +	domain_update_iotlb(domain);
>   }
>   
>   struct context_entry *iommu_context_addr(struct intel_iommu *iommu, u8 bus,
> @@ -1464,17 +1468,22 @@ static void domain_update_iotlb(struct dmar_domain *domain)
>   
>   	assert_spin_locked(&device_domain_lock);
>   
> -	list_for_each_entry(info, &domain->devices, link) {
> -		struct pci_dev *pdev;
> -
> -		if (!info->dev || !dev_is_pci(info->dev))
> -			continue;
> -
> -		pdev = to_pci_dev(info->dev);
> -		if (pdev->ats_enabled) {
> +	list_for_each_entry(info, &domain->devices, link)
> +		if (info && info->ats_enabled) {
>   			has_iotlb_device = true;
>   			break;
>   		}
> +
> +	if (!has_iotlb_device) {
> +		struct subdev_domain_info *sinfo;
> +
> +		list_for_each_entry(sinfo, &domain->subdevices, link_domain) {
> +			info = get_domain_info(sinfo->pdev);
> +			if (info && info->ats_enabled) {
> +				has_iotlb_device = true;
> +				break;
> +			}
> +		}
>   	}
>   
>   	domain->has_iotlb_device = has_iotlb_device;
> @@ -1555,25 +1564,37 @@ static void iommu_disable_dev_iotlb(struct device_domain_info *info)
>   #endif
>   }
>   
> +static void __iommu_flush_dev_iotlb(struct device_domain_info *info,
> +				    u64 addr, unsigned int mask)
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
> +	struct subdev_domain_info *sinfo;
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
>   
> -		sid = info->bus << 8 | info->devfn;
> -		qdep = info->ats_qdep;
> -		qi_flush_dev_iotlb(info->iommu, sid, info->pfsid,
> -				qdep, addr, mask);
> +	list_for_each_entry(sinfo, &domain->subdevices, link_domain) {
> +		__iommu_flush_dev_iotlb(get_domain_info(sinfo->pdev),
> +					addr, mask);
>   	}

Nit:
	list_for_each_entry(sinfo, &domain->subdevices, link_domain) {
		info = get_domain_info(sinfo->pdev);
		__iommu_flush_dev_iotlb(info, addr, mask);
	}

Others look good to me.

Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

>   	spin_unlock_irqrestore(&device_domain_lock, flags);
>   }
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
