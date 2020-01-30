Return-Path: <SRS0=QAIZ=3T=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF2DC33C9E
	for <iommu@archiver.kernel.org>; Thu, 30 Jan 2020 07:55:07 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE12420702
	for <iommu@archiver.kernel.org>; Thu, 30 Jan 2020 07:55:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE12420702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 71ECE8773F;
	Thu, 30 Jan 2020 07:55:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qeWuk9YXPCc8; Thu, 30 Jan 2020 07:55:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B56E38772F;
	Thu, 30 Jan 2020 07:55:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8EDA2C0881;
	Thu, 30 Jan 2020 07:55:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0EAB9C0171
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jan 2020 07:55:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 0AF0D86248
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jan 2020 07:55:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0SyHdYNl78Fb for <iommu@lists.linux-foundation.org>;
 Thu, 30 Jan 2020 07:55:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4744A86031
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jan 2020 07:55:04 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 29 Jan 2020 23:55:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,381,1574150400"; d="scan'208";a="402244099"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.251.28.177])
 ([10.251.28.177])
 by orsmga005.jf.intel.com with ESMTP; 29 Jan 2020 23:54:50 -0800
Subject: Re: [PATCH V9 10/10] iommu/vt-d: Report PASID format as domain
 attribute
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
References: <1580277713-66934-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1580277713-66934-11-git-send-email-jacob.jun.pan@linux.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <45cacbf2-c326-847d-dc6e-949e3e8de78d@linux.intel.com>
Date: Thu, 30 Jan 2020 15:54:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1580277713-66934-11-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Jonathan Cameron <jic23@kernel.org>
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

On 2020/1/29 14:01, Jacob Pan wrote:
> Report the domain attribute of PASID table format. As multiple formats
> of PASID table entry are supported, it is important for the guest to
> know which format to use in virtual IOMMU. The result will be used for
> binding device with guest PASID.
> 
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>   drivers/iommu/intel-iommu.c | 22 ++++++++++++++++++++++
>   include/linux/iommu.h       |  1 +
>   2 files changed, 23 insertions(+)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 2f0bf7cc70ce..b3778e86dc32 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -6413,6 +6413,27 @@ intel_iommu_domain_set_attr(struct iommu_domain *domain,
>   	return ret;
>   }
>   
> +static int intel_iommu_domain_get_attr(struct iommu_domain *domain,
> +				       enum iommu_attr attr, void *data)
> +{
> +	/* Only used for guest */
> +	switch (domain->type) {
> +	case IOMMU_DOMAIN_DMA:
> +		return -ENODEV;
> +	case IOMMU_DOMAIN_UNMANAGED:
> +		switch (attr) {
> +		case DOMAIN_ATTR_PASID_FORMAT:
> +			*(int *)data = IOMMU_PASID_FORMAT_INTEL_VTD;
> +			return 0;
> +		default:
> +			return -ENODEV;
> +		}
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>   const struct iommu_ops intel_iommu_ops = {
>   	.capable		= intel_iommu_capable,
>   	.domain_alloc		= intel_iommu_domain_alloc,
> @@ -6432,6 +6453,7 @@ const struct iommu_ops intel_iommu_ops = {
>   	.put_resv_regions	= intel_iommu_put_resv_regions,
>   	.apply_resv_region	= intel_iommu_apply_resv_region,
>   	.device_group		= pci_device_group,
> +	.domain_get_attr	= intel_iommu_domain_get_attr,
>   	.dev_has_feat		= intel_iommu_dev_has_feat,
>   	.dev_feat_enabled	= intel_iommu_dev_feat_enabled,
>   	.dev_enable_feat	= intel_iommu_dev_enable_feat,
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index f2223cbb5fd5..9718c109ea0a 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -126,6 +126,7 @@ enum iommu_attr {
>   	DOMAIN_ATTR_FSL_PAMUV1,
>   	DOMAIN_ATTR_NESTING,	/* two stages of translation */
>   	DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE,
> +	DOMAIN_ATTR_PASID_FORMAT,
>   	DOMAIN_ATTR_MAX,
>   };

Need to separate the new domain attribution definition and the vt-d
implementation.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
