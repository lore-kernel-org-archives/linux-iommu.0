Return-Path: <SRS0=Ai5c=B2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2538BC433E1
	for <iommu@archiver.kernel.org>; Sun, 16 Aug 2020 12:01:20 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E51CC20716
	for <iommu@archiver.kernel.org>; Sun, 16 Aug 2020 12:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dcXPu5xC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E51CC20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CC97F862A9;
	Sun, 16 Aug 2020 12:01:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uJIagf1HKCPi; Sun, 16 Aug 2020 12:01:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 08F8B8609D;
	Sun, 16 Aug 2020 12:01:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E4C53C07FF;
	Sun, 16 Aug 2020 12:01:18 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D570FC0051
 for <iommu@lists.linux-foundation.org>; Sun, 16 Aug 2020 12:01:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id B680A20449
 for <iommu@lists.linux-foundation.org>; Sun, 16 Aug 2020 12:01:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uEKP1C9m0Lqr for <iommu@lists.linux-foundation.org>;
 Sun, 16 Aug 2020 12:01:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by silver.osuosl.org (Postfix) with ESMTPS id F013520434
 for <iommu@lists.linux-foundation.org>; Sun, 16 Aug 2020 12:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597579273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ksAEekms9m8D7GB2Y4X47go1iynsQ0sEnvHZpgyZDbQ=;
 b=dcXPu5xCZmW3NTBhf5L5cXqXy8Hzc7ER+DZ+KxVDUpP0RI0c9I745XLNTGXQ0HJHtwdohI
 OzR9Wzxu3de71AC4QTOEsmro53v5E0EFsf0XhF+H+6RT1oUn/ETIE0HBrbMS6eOcCZF7LL
 +sbbJDqzmCIQSWSaj0ZN3GVY0FZ61y8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-3swd7j7wMDOUMWr8sVuKRg-1; Sun, 16 Aug 2020 08:01:11 -0400
X-MC-Unique: 3swd7j7wMDOUMWr8sVuKRg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F7101DDE4;
 Sun, 16 Aug 2020 12:01:09 +0000 (UTC)
Received: from [10.36.113.93] (ovpn-113-93.ams2.redhat.com [10.36.113.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8246D757F3;
 Sun, 16 Aug 2020 12:01:05 +0000 (UTC)
Subject: Re: [PATCH v6 15/15] iommu/vt-d: Support reporting nesting capability
 info
To: Liu Yi L <yi.l.liu@intel.com>, alex.williamson@redhat.com,
 baolu.lu@linux.intel.com, joro@8bytes.org
References: <1595917664-33276-1-git-send-email-yi.l.liu@intel.com>
 <1595917664-33276-16-git-send-email-yi.l.liu@intel.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <7fe337fa-abbc-82be-c8e8-b9e2a6179b90@redhat.com>
Date: Sun, 16 Aug 2020 14:01:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1595917664-33276-16-git-send-email-yi.l.liu@intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: jean-philippe@linaro.org, kevin.tian@intel.com, ashok.raj@intel.com,
 kvm@vger.kernel.org, stefanha@gmail.com, jun.j.tian@intel.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 yi.y.sun@intel.com, hao.wu@intel.com
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

On 7/28/20 8:27 AM, Liu Yi L wrote:
> This patch reports nesting info, and only supports the case where all
> the physical iomms have the same CAP/ECAP MASKS.
s/iomms/iommus
> 
> Cc: Kevin Tian <kevin.tian@intel.com>
> CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
> v2 -> v3:
> *) remove cap/ecap_mask in iommu_nesting_info.
> ---
>  drivers/iommu/intel/iommu.c | 81 +++++++++++++++++++++++++++++++++++++++++++--
>  include/linux/intel-iommu.h | 16 +++++++++
>  2 files changed, 95 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 88f4647..0835804 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -5660,12 +5660,16 @@ static inline bool iommu_pasid_support(void)
>  static inline bool nested_mode_support(void)
>  {
>  	struct dmar_drhd_unit *drhd;
> -	struct intel_iommu *iommu;
> +	struct intel_iommu *iommu, *prev = NULL;
>  	bool ret = true;
>  
>  	rcu_read_lock();
>  	for_each_active_iommu(iommu, drhd) {
> -		if (!sm_supported(iommu) || !ecap_nest(iommu->ecap)) {
> +		if (!prev)
> +			prev = iommu;
> +		if (!sm_supported(iommu) || !ecap_nest(iommu->ecap) ||
> +		    (VTD_CAP_MASK & (iommu->cap ^ prev->cap)) ||
> +		    (VTD_ECAP_MASK & (iommu->ecap ^ prev->ecap))) {
>  			ret = false;
>  			break;
So this changes the behavior of DOMAIN_ATTR_NESTING. Shouldn't it have a
Fixes tag as well? And maybe add the capability getter in a separate patch?
>  		}
> @@ -6081,6 +6085,78 @@ intel_iommu_domain_set_attr(struct iommu_domain *domain,
>  	return ret;
>  }
>  
> +static int intel_iommu_get_nesting_info(struct iommu_domain *domain,
> +					struct iommu_nesting_info *info)
> +{
> +	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
> +	u64 cap = VTD_CAP_MASK, ecap = VTD_ECAP_MASK;
> +	struct device_domain_info *domain_info;
> +	struct iommu_nesting_info_vtd vtd;
> +	unsigned long flags;
> +	unsigned int size;
> +
> +	if (domain->type != IOMMU_DOMAIN_UNMANAGED ||
> +	    !(dmar_domain->flags & DOMAIN_FLAG_NESTING_MODE))
> +		return -ENODEV;
> +
> +	if (!info)
> +		return -EINVAL;
> +
> +	size = sizeof(struct iommu_nesting_info) +
> +		sizeof(struct iommu_nesting_info_vtd);
> +	/*
> +	 * if provided buffer size is smaller than expected, should
> +	 * return 0 and also the expected buffer size to caller.
> +	 */
> +	if (info->argsz < size) {
> +		info->argsz = size;
> +		return 0;
> +	}
> +
> +	spin_lock_irqsave(&device_domain_lock, flags);
> +	/*
> +	 * arbitrary select the first domain_info as all nesting
> +	 * related capabilities should be consistent across iommu
> +	 * units.
> +	 */
> +	domain_info = list_first_entry(&dmar_domain->devices,
> +				       struct device_domain_info, link);
> +	cap &= domain_info->iommu->cap;
> +	ecap &= domain_info->iommu->ecap;
> +	spin_unlock_irqrestore(&device_domain_lock, flags);
> +
> +	info->format = IOMMU_PASID_FORMAT_INTEL_VTD;
> +	info->features = IOMMU_NESTING_FEAT_SYSWIDE_PASID |
> +			 IOMMU_NESTING_FEAT_BIND_PGTBL |
> +			 IOMMU_NESTING_FEAT_CACHE_INVLD;
> +	info->addr_width = dmar_domain->gaw;
> +	info->pasid_bits = ilog2(intel_pasid_max_id);
> +	info->padding = 0;
> +	vtd.flags = 0;
> +	vtd.padding = 0;
> +	vtd.cap_reg = cap;
> +	vtd.ecap_reg = ecap;
> +
> +	memcpy(info->data, &vtd, sizeof(vtd));
> +	return 0;
> +}
> +
> +static int intel_iommu_domain_get_attr(struct iommu_domain *domain,
> +				       enum iommu_attr attr, void *data)
> +{
> +	switch (attr) {
> +	case DOMAIN_ATTR_NESTING:
> +	{
> +		struct iommu_nesting_info *info =
> +				(struct iommu_nesting_info *)data;

don't you need to hold a device_domain_lock earlier to make sure domain
attributes can't change behind your back (unmanaged type and nested mode)?
> +
> +		return intel_iommu_get_nesting_info(domain, info);
> +	}
> +	default:
> +		return -ENOENT;
> +	}
> +}
> +
>  /*
>   * Check that the device does not live on an external facing PCI port that is
>   * marked as untrusted. Such devices should not be able to apply quirks and
> @@ -6103,6 +6179,7 @@ const struct iommu_ops intel_iommu_ops = {
>  	.domain_alloc		= intel_iommu_domain_alloc,
>  	.domain_free		= intel_iommu_domain_free,
>  	.domain_set_attr	= intel_iommu_domain_set_attr,
> +	.domain_get_attr	= intel_iommu_domain_get_attr,
>  	.attach_dev		= intel_iommu_attach_device,
>  	.detach_dev		= intel_iommu_detach_device,
>  	.aux_attach_dev		= intel_iommu_aux_attach_device,
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index f98146b..5acf795 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -197,6 +197,22 @@
>  #define ecap_max_handle_mask(e) ((e >> 20) & 0xf)
>  #define ecap_sc_support(e)	((e >> 7) & 0x1) /* Snooping Control */
>  
> +/* Nesting Support Capability Alignment */
> +#define VTD_CAP_FL1GP		BIT_ULL(56)
> +#define VTD_CAP_FL5LP		BIT_ULL(60)
> +#define VTD_ECAP_PRS		BIT_ULL(29)
> +#define VTD_ECAP_ERS		BIT_ULL(30)
> +#define VTD_ECAP_SRS		BIT_ULL(31)
> +#define VTD_ECAP_EAFS		BIT_ULL(34)
> +#define VTD_ECAP_PASID		BIT_ULL(40)
> +
> +/* Only capabilities marked in below MASKs are reported */
> +#define VTD_CAP_MASK		(VTD_CAP_FL1GP | VTD_CAP_FL5LP)
> +
> +#define VTD_ECAP_MASK		(VTD_ECAP_PRS | VTD_ECAP_ERS | \
> +				 VTD_ECAP_SRS | VTD_ECAP_EAFS | \
> +				 VTD_ECAP_PASID)
> +
>  /* Virtual command interface capability */
>  #define vccap_pasid(v)		(((v) & DMA_VCS_PAS)) /* PASID allocation */
>  
> 
Thanks

Eric

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
