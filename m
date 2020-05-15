Return-Path: <SRS0=PRYs=65=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8D3C433DF
	for <iommu@archiver.kernel.org>; Fri, 15 May 2020 13:51:17 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 372CA20671
	for <iommu@archiver.kernel.org>; Fri, 15 May 2020 13:51:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 372CA20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 079E787D61;
	Fri, 15 May 2020 13:51:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x3jmKWFMV_Zy; Fri, 15 May 2020 13:51:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2561C87D5B;
	Fri, 15 May 2020 13:51:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D14BC0859;
	Fri, 15 May 2020 13:51:12 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BB3DCC016F
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 13:51:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A977A89A56
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 13:51:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E1JKbj-IeIBq for <iommu@lists.linux-foundation.org>;
 Fri, 15 May 2020 13:51:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 06DE489A4E
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 13:51:05 +0000 (UTC)
IronPort-SDR: 7uDOrz4AqipSskZhnYRjhXOP6nTLVoOraHA/qBNnbVEwvmScQ90WhlANWr609Ag+jrUYD3ijGH
 Pe1plkkPK6QA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2020 06:51:05 -0700
IronPort-SDR: HiRFDcklPJUOEKtJdITP/v5pcs/FB32XD6WuiHt534hfwqBnP30FDEEowsD0xUZlBDceKdBcVC
 8Rtsgl1YWUfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,395,1583222400"; d="scan'208";a="252383003"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.249.171.19])
 ([10.249.171.19])
 by fmsmga007.fm.intel.com with ESMTP; 15 May 2020 06:51:03 -0700
Subject: Re: [PATCH] iommu: Implement deferred domain attachment
To: Joerg Roedel <joro@8bytes.org>
References: <20200515094519.20338-1-joro@8bytes.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <8ce93a10-2ce0-e5a0-88a0-5d21d7003c0f@linux.intel.com>
Date: Fri, 15 May 2020 21:51:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200515094519.20338-1-joro@8bytes.org>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org, jroedel@suse.de,
 linux-kernel@vger.kernel.org, Tom Murphy <murphyt7@tcd.ie>
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

Hi Joerg,

On 2020/5/15 17:45, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> The IOMMU core code has support for deferring the attachment of a domain
> to a device. This is needed in kdump kernels where the new domain must
> not be attached to a device before the device driver takes it over.
> 
> But this needs support from the dma-ops code too, to actually do the
> late attachment when there are DMA-API calls for the device. This got
> lost in the AMD IOMMU driver after converting it to the dma-iommu code.
> 
> Do the late attachment in the dma-iommu code-path to fix the issue.
> 
> Cc: Jerry Snitselaar <jsnitsel@redhat.com>
> Cc: Tom Murphy <murphyt7@tcd.ie>
> Reported-by: Jerry Snitselaar <jsnitsel@redhat.com>
> Tested-by: Jerry Snitselaar <jsnitsel@redhat.com>
> Fixes: be62dbf554c5 ("iommu/amd: Convert AMD iommu driver to the dma-iommu api")
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>   drivers/iommu/iommu.c | 33 +++++++++++++++++++++++++++------
>   1 file changed, 27 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 4050569188be..f54ebb964271 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1889,13 +1889,19 @@ void iommu_domain_free(struct iommu_domain *domain)
>   }
>   EXPORT_SYMBOL_GPL(iommu_domain_free);
>   
> -static int __iommu_attach_device(struct iommu_domain *domain,
> -				 struct device *dev)
> +static bool __iommu_is_attach_deferred(struct iommu_domain *domain,
> +				       struct device *dev)
> +{
> +	if (!domain->ops->is_attach_deferred)
> +		return false;
> +
> +	return domain->ops->is_attach_deferred(domain, dev);
> +}
> +
> +static int __iommu_attach_device_no_defer(struct iommu_domain *domain,
> +					  struct device *dev)
>   {
>   	int ret;
> -	if ((domain->ops->is_attach_deferred != NULL) &&
> -	    domain->ops->is_attach_deferred(domain, dev))
> -		return 0;
>   
>   	if (unlikely(domain->ops->attach_dev == NULL))
>   		return -ENODEV;
> @@ -1903,9 +1909,19 @@ static int __iommu_attach_device(struct iommu_domain *domain,
>   	ret = domain->ops->attach_dev(domain, dev);
>   	if (!ret)
>   		trace_attach_device_to_domain(dev);
> +
>   	return ret;
>   }
>   
> +static int __iommu_attach_device(struct iommu_domain *domain,
> +				 struct device *dev)
> +{
> +	if (__iommu_is_attach_deferred(domain, dev))
> +		return 0;
> +
> +	return __iommu_attach_device_no_defer(domain, dev);
> +}
> +
>   int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
>   {
>   	struct iommu_group *group;
> @@ -2023,7 +2039,12 @@ EXPORT_SYMBOL_GPL(iommu_get_domain_for_dev);
>    */
>   struct iommu_domain *iommu_get_dma_domain(struct device *dev)
>   {
> -	return dev->iommu_group->default_domain;
> +	struct iommu_domain *domain = dev->iommu_group->default_domain;
> +
> +	if (__iommu_is_attach_deferred(domain, dev))
> +		__iommu_attach_device_no_defer(domain, dev);

It seems that the return value needs to be checked. The default domain
is invalid if attach() failed.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
