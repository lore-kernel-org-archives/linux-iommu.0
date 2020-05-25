Return-Path: <SRS0=eEOj=7H=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B60C433E0
	for <iommu@archiver.kernel.org>; Mon, 25 May 2020 13:03:02 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39E682073B
	for <iommu@archiver.kernel.org>; Mon, 25 May 2020 13:03:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39E682073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id C76DD87E23;
	Mon, 25 May 2020 13:03:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b7WuHPvyWZyb; Mon, 25 May 2020 13:03:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 44D2D87A5F;
	Mon, 25 May 2020 13:03:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 11C6FC0865;
	Mon, 25 May 2020 13:03:01 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 54330C016F
 for <iommu@lists.linux-foundation.org>; Mon, 25 May 2020 13:02:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3EB8086959
 for <iommu@lists.linux-foundation.org>; Mon, 25 May 2020 13:02:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id l53NilhFVvlm for <iommu@lists.linux-foundation.org>;
 Mon, 25 May 2020 13:02:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 565A186937
 for <iommu@lists.linux-foundation.org>; Mon, 25 May 2020 13:02:58 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 17DBFACDB;
 Mon, 25 May 2020 13:02:58 +0000 (UTC)
Date: Mon, 25 May 2020 15:02:53 +0200
From: Joerg Roedel <jroedel@suse.de>
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCH] iommu: Fix group refcount in iommu_alloc_default_domain()
Message-ID: <20200525130253.GH5075@suse.de>
References: <20200522130145.30067-1-saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200522130145.30067-1-saiprakash.ranjan@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 Evan Green <evgreen@chromium.org>, Douglas Anderson <dianders@chromium.org>,
 iommu@lists.linux-foundation.org, linux-arm-msm@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

Hi,

On Fri, May 22, 2020 at 06:31:45PM +0530, Sai Prakash Ranjan wrote:
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index a4c2f122eb8b..05f7b77c432f 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1491,6 +1491,7 @@ static int iommu_alloc_default_domain(struct device *dev)
>  {
>  	struct iommu_group *group;
>  	unsigned int type;
> +	int ret;
>  
>  	group = iommu_group_get(dev);
>  	if (!group)
> @@ -1501,7 +1502,11 @@ static int iommu_alloc_default_domain(struct device *dev)
>  
>  	type = iommu_get_def_domain_type(dev);
>  
> -	return iommu_group_alloc_default_domain(dev->bus, group, type);
> +	ret = iommu_group_alloc_default_domain(dev->bus, group, type);
> +
> +	iommu_group_put(group);
> +
> +	return ret;
>  }
>  
>  /**

Thanks for the report and the fix. I think it is better to fix this by
not taking a group reference in iommu_alloc_default_domain() at all and
pass group as a parameter. Please see the patch I just sent out.

Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
