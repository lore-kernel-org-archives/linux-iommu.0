Return-Path: <SRS0=5yIV=F3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2F1C433E0
	for <iommu@archiver.kernel.org>; Wed, 23 Dec 2020 10:10:05 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1893F22473
	for <iommu@archiver.kernel.org>; Wed, 23 Dec 2020 10:10:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1893F22473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id B0D6287271;
	Wed, 23 Dec 2020 10:10:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oM3PQB6iqPN4; Wed, 23 Dec 2020 10:10:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id A2AA98723A;
	Wed, 23 Dec 2020 10:10:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6F4F1C1787;
	Wed, 23 Dec 2020 10:10:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 10507C0893
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 10:10:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 04DE685B9A
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 10:10:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GTqZ86FLbpQE for <iommu@lists.linux-foundation.org>;
 Wed, 23 Dec 2020 10:09:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id E33B380AC8
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 10:09:59 +0000 (UTC)
IronPort-SDR: wvTMEaMUa6QqB8gDAbycL2SXYh0y88Di4VCj+GbXQRkbfgHhQHM8wxlQ/onVP9DxS8cywmn29i
 6CHbrl39Y/cw==
X-IronPort-AV: E=McAfee;i="6000,8403,9843"; a="172484040"
X-IronPort-AV: E=Sophos;i="5.78,441,1599548400"; d="scan'208";a="172484040"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Dec 2020 02:09:59 -0800
IronPort-SDR: ZVdrO9nG7xzKLhM7QSvFAzVsLK1/FyPy8bPAawVG5tUoYDsKFYf9wyPsBvvzZJ6JkCrU8+Vr3v
 VXn0EiQdL2kg==
X-IronPort-AV: E=Sophos;i="5.78,441,1599548400"; d="scan'208";a="417147655"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.209.13])
 ([10.254.209.13])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Dec 2020 02:09:56 -0800
Subject: Re: [PATCH v2 3/3] iommu/vt-d: Fix ineffective devTLB invalidation
 for subdevices
To: Liu Yi L <yi.l.liu@intel.com>, joro@8bytes.org, will@kernel.org,
 jacob.jun.pan@linux.intel.com
References: <20201223062720.29364-1-yi.l.liu@intel.com>
 <20201223062720.29364-4-yi.l.liu@intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <176f7835-a5cf-e049-22b7-724636f74af0@linux.intel.com>
Date: Wed, 23 Dec 2020 18:09:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20201223062720.29364-4-yi.l.liu@intel.com>
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

On 2020/12/23 14:27, Liu Yi L wrote:
> iommu_flush_dev_iotlb() is called to invalidate caches on device. It only
> loops the devices which are full-attached to the domain. For sub-devices,
> this is ineffective. This results in invalid caching entries left on the
> device. Fix it by adding loop for subdevices as well. Also, the domain->
> has_iotlb_device needs to be updated when attaching to subdevices.
> 
> Fixes: 67b8e02b5e761 ("iommu/vt-d: Aux-domain specific domain attach/detach")
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 63 +++++++++++++++++++++++++++----------
>   1 file changed, 47 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index acfe0a5b955e..e97c5ac1d7fc 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -726,6 +726,8 @@ static int domain_update_device_node(struct dmar_domain *domain)
>   	return nid;
>   }
>   
> +static void domain_update_iotlb(struct dmar_domain *domain);
> +
>   /* Some capabilities may be different across iommus */
>   static void domain_update_iommu_cap(struct dmar_domain *domain)
>   {
> @@ -739,6 +741,8 @@ static void domain_update_iommu_cap(struct dmar_domain *domain)
>   	 */
>   	if (domain->nid == NUMA_NO_NODE)
>   		domain->nid = domain_update_device_node(domain);
> +
> +	domain_update_iotlb(domain);
>   }
>   
>   struct context_entry *iommu_context_addr(struct intel_iommu *iommu, u8 bus,
> @@ -1459,6 +1463,18 @@ iommu_support_dev_iotlb (struct dmar_domain *domain, struct intel_iommu *iommu,
>   	return NULL;
>   }
>   
> +static bool dev_iotlb_enabled(struct device_domain_info *info)
> +{
> +	struct pci_dev *pdev;
> +
> +	if (!info->dev || !dev_is_pci(info->dev))
> +		return false;
> +
> +	pdev = to_pci_dev(info->dev);
> +
> +	return !!pdev->ats_enabled;
> +}

I know this is just separated from below function. But isn't "(info &&
info->ats_enabled)" is enough?

> +
>   static void domain_update_iotlb(struct dmar_domain *domain)
>   {
>   	struct device_domain_info *info;
> @@ -1466,17 +1482,20 @@ static void domain_update_iotlb(struct dmar_domain *domain)
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
> +		if (dev_iotlb_enabled(info)) {
>   			has_iotlb_device = true;
>   			break;
>   		}
> +
> +	if (!has_iotlb_device) {
> +		struct subdev_domain_info *sinfo;
> +
> +		list_for_each_entry(sinfo, &domain->subdevices, link_domain)
> +			if (dev_iotlb_enabled(get_domain_info(sinfo->pdev))) {

Please make the code easier for reading by:

			info = get_domain_info(sinfo->pdev);
			if (dev_iotlb_enabled(info))
				....

Best regards,
baolu

> +				has_iotlb_device = true;
> +				break;
> +			}
>   	}
>   
>   	domain->has_iotlb_device = has_iotlb_device;
> @@ -1557,25 +1576,37 @@ static void iommu_disable_dev_iotlb(struct device_domain_info *info)
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
>   	spin_unlock_irqrestore(&device_domain_lock, flags);
>   }
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
