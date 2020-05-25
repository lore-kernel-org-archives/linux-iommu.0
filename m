Return-Path: <SRS0=eEOj=7H=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BB4C433DF
	for <iommu@archiver.kernel.org>; Mon, 25 May 2020 13:25:03 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CAC32070A
	for <iommu@archiver.kernel.org>; Mon, 25 May 2020 13:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="GSjDys1w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CAC32070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5889687EAA;
	Mon, 25 May 2020 13:25:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gKxVud8Wx3HW; Mon, 25 May 2020 13:25:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C892687C66;
	Mon, 25 May 2020 13:25:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91492C088D;
	Mon, 25 May 2020 13:25:02 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 66114C016F
 for <iommu@lists.linux-foundation.org>; Mon, 25 May 2020 13:25:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 541648676A
 for <iommu@lists.linux-foundation.org>; Mon, 25 May 2020 13:25:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qZ90wpsqIP5R for <iommu@lists.linux-foundation.org>;
 Mon, 25 May 2020 13:25:00 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail27.static.mailgun.info (mail27.static.mailgun.info
 [104.130.122.27])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 3B4BC86761
 for <iommu@lists.linux-foundation.org>; Mon, 25 May 2020 13:24:58 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1590413100; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=Z6M6zOHgv5Mz3vquD9glzltuXPL2ESOK8Uo9Xh9Nvfc=;
 b=GSjDys1w6Kec6WxjmScZ4FMcrWPKPlwIof+/fRtZTUznmlZVdAmEQ5nB2eBSawVBufa/T9bo
 qWbxIRKtbTsyrj12i16N7OHaqo3Q+wEe9gZPFj4TQYBgMeekxC/41tgczl3IrDFt6uP2GEIC
 VByqSmf2a6V+xHYNP2hzsTId/ys=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5ecbc7122c5499847541b82d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 25 May 2020 13:24:34
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id CFACFC433C9; Mon, 25 May 2020 13:24:33 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 796AFC433C6;
 Mon, 25 May 2020 13:24:33 +0000 (UTC)
MIME-Version: 1.0
Date: Mon, 25 May 2020 18:54:33 +0530
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu: Don't take group reference in
 iommu_alloc_default_domain()
In-Reply-To: <20200525130122.380-1-joro@8bytes.org>
References: <20200525130122.380-1-joro@8bytes.org>
Message-ID: <4a9382b1a79ee7ac46abfe8b84601576@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Cc: iommu@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>,
 linux-kernel@vger.kernel.org
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

On 2020-05-25 18:31, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> The iommu_alloc_default_domain() function takes a reference to an IOMMU
> group without releasing it. This causes the group to never be released,
> with undefined side effects.
> 
> The function has only one call-site, which takes a group reference on
> its own, so to fix this leak, do not take another reference in
> iommu_alloc_default_domain() and pass the group as a function parameter
> instead.
> 
> Reference:
> https://lore.kernel.org/lkml/20200522130145.30067-1-saiprakash.ranjan@codeaurora.org/
> Reported-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> Cc: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> Fixes: 6e1aa2049154 ("iommu: Move default domain allocation to
> iommu_probe_device()")
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  drivers/iommu/iommu.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 374b34fd6fac..bf20674769e0 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -80,7 +80,8 @@ static bool iommu_cmd_line_dma_api(void)
>  	return !!(iommu_cmd_line & IOMMU_CMD_LINE_DMA_API);
>  }
> 
> -static int iommu_alloc_default_domain(struct device *dev);
> +static int iommu_alloc_default_domain(struct iommu_group *group,
> +				      struct device *dev);
>  static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
>  						 unsigned type);
>  static int __iommu_attach_device(struct iommu_domain *domain,
> @@ -251,17 +252,17 @@ int iommu_probe_device(struct device *dev)
>  	if (ret)
>  		goto err_out;
> 
> +	group = iommu_group_get(dev);
> +	if (!group)
> +		goto err_release;
> +
>  	/*
>  	 * Try to allocate a default domain - needs support from the
>  	 * IOMMU driver. There are still some drivers which don't
>  	 * support default domains, so the return value is not yet
>  	 * checked.
>  	 */
> -	iommu_alloc_default_domain(dev);
> -
> -	group = iommu_group_get(dev);
> -	if (!group)
> -		goto err_release;
> +	iommu_alloc_default_domain(group, dev);
> 
>  	if (group->default_domain)
>  		ret = __iommu_attach_device(group->default_domain, dev);
> @@ -1478,15 +1479,11 @@ static int
> iommu_group_alloc_default_domain(struct bus_type *bus,
>  	return 0;
>  }
> 
> -static int iommu_alloc_default_domain(struct device *dev)
> +static int iommu_alloc_default_domain(struct iommu_group *group,
> +				      struct device *dev)
>  {
> -	struct iommu_group *group;
>  	unsigned int type;
> 
> -	group = iommu_group_get(dev);
> -	if (!group)
> -		return -ENODEV;
> -
>  	if (group->default_domain)
>  		return 0;

Tested this out and it works for me.

Tested-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>

Thanks,
Sai
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
