Return-Path: <SRS0=J3Yr=GZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B79C433E0
	for <iommu@archiver.kernel.org>; Fri, 22 Jan 2021 02:02:29 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48D0D239D4
	for <iommu@archiver.kernel.org>; Fri, 22 Jan 2021 02:02:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48D0D239D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id B413F86FA2;
	Fri, 22 Jan 2021 02:02:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cg1EpDH30ypV; Fri, 22 Jan 2021 02:02:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1AD6C86DAF;
	Fri, 22 Jan 2021 02:02:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0CEF5C08A1;
	Fri, 22 Jan 2021 02:02:28 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 28A98C013A
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 02:02:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1388686F92
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 02:02:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wur+LodN8IfO for <iommu@lists.linux-foundation.org>;
 Fri, 22 Jan 2021 02:02:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9CA0B86DAF
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 02:02:24 +0000 (UTC)
IronPort-SDR: Xl2aPODJguyjjfRsrHGtjYYb0hff+w7rSqnvHi5dbfNTl9rf/OSH8fWXR2sh3nJ0hET1huh6Yb
 lhdiId9z2erg==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="178601052"
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; d="scan'208";a="178601052"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2021 18:02:22 -0800
IronPort-SDR: Xbl5c/D865xh6OlMgMyL0U1IZOcNA6WvEvPrOI/eUbFuSdvCK6xN46A2PhCPSr8KiBbjTQoRZM
 DDbMHc3lOXNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; d="scan'208";a="467684968"
Received: from allen-box.sh.intel.com (HELO [10.239.159.28]) ([10.239.159.28])
 by fmsmga001.fm.intel.com with ESMTP; 21 Jan 2021 18:02:16 -0800
Subject: Re: [PATCH v10 04/10] iommu/vt-d: Support IOMMU_DEV_FEAT_IOPF
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, joro@8bytes.org,
 will@kernel.org
References: <20210121123623.2060416-1-jean-philippe@linaro.org>
 <20210121123623.2060416-5-jean-philippe@linaro.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <d834784c-2d96-a4be-8d9b-3a5d3939325d@linux.intel.com>
Date: Fri, 22 Jan 2021 09:54:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210121123623.2060416-5-jean-philippe@linaro.org>
Content-Language: en-US
Cc: vivek.gautam@arm.com, guohanjun@huawei.com, linux-acpi@vger.kernel.org,
 zhangfei.gao@linaro.org, lenb@kernel.org, devicetree@vger.kernel.org,
 kevin.tian@intel.com, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 robin.murphy@arm.com, rjw@rjwysocki.net, iommu@lists.linux-foundation.org,
 sudeep.holla@arm.com, David Woodhouse <dwmw2@infradead.org>,
 linux-accelerators@lists.ozlabs.org
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

Hi Jean,

On 1/21/21 8:36 PM, Jean-Philippe Brucker wrote:
> Allow drivers to query and enable IOMMU_DEV_FEAT_IOPF, which amounts to
> checking whether PRI is enabled.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> ---
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index f665322a0991..c777bd94df5d 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -5330,6 +5330,8 @@ static int siov_find_pci_dvsec(struct pci_dev *pdev)
>   static bool
>   intel_iommu_dev_has_feat(struct device *dev, enum iommu_dev_features feat)
>   {
> +	struct device_domain_info *info = get_domain_info(dev);
> +
>   	if (feat == IOMMU_DEV_FEAT_AUX) {
>   		int ret;
>   
> @@ -5344,13 +5346,13 @@ intel_iommu_dev_has_feat(struct device *dev, enum iommu_dev_features feat)
>   		return !!siov_find_pci_dvsec(to_pci_dev(dev));
>   	}
>   
> -	if (feat == IOMMU_DEV_FEAT_SVA) {
> -		struct device_domain_info *info = get_domain_info(dev);
> +	if (feat == IOMMU_DEV_FEAT_IOPF)
> +		return info && info->pri_supported;
>   
> +	if (feat == IOMMU_DEV_FEAT_SVA)
>   		return info && (info->iommu->flags & VTD_FLAG_SVM_CAPABLE) &&
>   			info->pasid_supported && info->pri_supported &&
>   			info->ats_supported;
> -	}
>   
>   	return false;
>   }
> @@ -5361,6 +5363,9 @@ intel_iommu_dev_enable_feat(struct device *dev, enum iommu_dev_features feat)
>   	if (feat == IOMMU_DEV_FEAT_AUX)
>   		return intel_iommu_enable_auxd(dev);
>   
> +	if (feat == IOMMU_DEV_FEAT_IOPF)
> +		return intel_iommu_dev_has_feat(dev, feat) ? 0 : -ENODEV;
> +
>   	if (feat == IOMMU_DEV_FEAT_SVA) {
>   		struct device_domain_info *info = get_domain_info(dev);
>   
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
