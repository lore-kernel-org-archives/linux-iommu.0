Return-Path: <SRS0=PRYs=65=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E86C433DF
	for <iommu@archiver.kernel.org>; Fri, 15 May 2020 15:42:37 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CA7A20758
	for <iommu@archiver.kernel.org>; Fri, 15 May 2020 15:42:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CA7A20758
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3004188D78;
	Fri, 15 May 2020 15:42:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JNo8tt7vZ1nK; Fri, 15 May 2020 15:42:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 382EB88D34;
	Fri, 15 May 2020 15:42:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1E436C0859;
	Fri, 15 May 2020 15:42:32 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A663CC016F
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 15:42:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9BBA187A77
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 15:42:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6DFUhOZodXRz for <iommu@lists.linux-foundation.org>;
 Fri, 15 May 2020 15:42:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8E44487A32
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 15:42:25 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BEA322F;
 Fri, 15 May 2020 08:42:24 -0700 (PDT)
Received: from [10.57.27.64] (unknown [10.57.27.64])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E26903F71E;
 Fri, 15 May 2020 08:42:23 -0700 (PDT)
Subject: Re: [PATCH] iommu: Implement deferred domain attachment
To: Joerg Roedel <joro@8bytes.org>
References: <20200515094519.20338-1-joro@8bytes.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <d4e1cd9e-fc83-d41a-49c0-8f14f44b2701@arm.com>
Date: Fri, 15 May 2020 16:42:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200515094519.20338-1-joro@8bytes.org>
Content-Language: en-GB
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

On 2020-05-15 10:45, Joerg Roedel wrote:
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

This raises a red flag, since iommu-dma already has explicit deferred 
attach handling where it should need it, immediately after this is 
called to retrieve the domain. The whole thing smells to me like we 
should have an explicit special-case in iommu_probe_device() rather than 
hooking __iommu_attach_device() in general then having to bodge around 
the fallout elsewhere.

Robin.

> +
> +	return domain;
>   }
>   
>   /*
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
