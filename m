Return-Path: <SRS0=GV0T=MW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC32C4320A
	for <iommu@archiver.kernel.org>; Fri, 30 Jul 2021 09:28:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50D9C61054
	for <iommu@archiver.kernel.org>; Fri, 30 Jul 2021 09:28:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 50D9C61054
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1F5C560671;
	Fri, 30 Jul 2021 09:28:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OliKa4K8M9Xb; Fri, 30 Jul 2021 09:28:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F34A9605F6;
	Fri, 30 Jul 2021 09:28:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CD07AC001A;
	Fri, 30 Jul 2021 09:28:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 193A4C000E
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 09:28:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0FFBA6062C
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 09:28:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id myK6e1OFt2us for <iommu@lists.linux-foundation.org>;
 Fri, 30 Jul 2021 09:28:46 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 130E3605F6
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 09:28:45 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id j2so12193109edp.11
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 02:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=WxhlzYrYV28az1jXTH92aNSQMW4lNS5B9o0J3BKptsc=;
 b=RVTBKHUPkJGMHQr5TC6/sYRTWrnQgV3jEyRw4RI12fsX+efJSbQOhg3RVAAi0s0MmJ
 D+m9kebK87MkoNUf56TrmJECOkAiYn4jnIuQ0nCu8rGxKrbO0nLoWm+cSP67lKVlxLqJ
 HwbJTvz2w7/kBbdJUZ9sq93DTHT8/TqYPx7lLdYbnSke0ukvdHFP5F5YO1ghHVG/eRoF
 GLM4x2/TJ9VwtOmeVkOyA66sPajVF5QZtCxzYZjUsXALSiF8ByP5s+ThBviMql30Q77M
 fVHU7R1/0CL8c2FK/CBc/a0i4zbQHqM9FlGS82CbnuzBEejzJK+yLwr1Dz9yCxfmidhV
 1jdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=WxhlzYrYV28az1jXTH92aNSQMW4lNS5B9o0J3BKptsc=;
 b=BD3icH9f5pdl/h2N6hxcYojLtqlmCAsetO0EoLdAE8RZ/NB1Gfui3OIS8nA3vr9DgC
 ab3VXz4Gd9sB6DTZHx5hdcp21kKDkh3H6q2S38GLsKU7uZX8pKp7ZUi58/5NEcWGMzQp
 D8WOa402aKF7Eox/MLv6K+dlt+Nha8b3/EVWDJEQLxZE/0yBKxeKJfV60z20DuANwhek
 xqGATni/Zj+0H36tBFHeDa7kZLrIFXIcGqy0sR+TQYODQ8U9PkwTQCo5ab54GCWuE2cr
 cLNEKOC4dn+lJzJKj5v89Ybtvl1q2bY4zAKoyvVmVtVIR/qwN+kjT5dBVTLtrt9rJFjU
 UCow==
X-Gm-Message-State: AOAM533qDdV8uDB6nvXYja8wbeQFNRUAPjF9isms/xzpgJDOhVCezQHw
 3zyQnbaNUKv34MtogsVGw3PUZA==
X-Google-Smtp-Source: ABdhPJz7v59AkGLe4ncF8sDSsbs4m/88saDYcXaP0lDGk9+fMwno6QtbmMRD+lr3lYSTMH8XQi1Rcg==
X-Received: by 2002:aa7:dbc8:: with SMTP id v8mr1860784edt.242.1627637324222; 
 Fri, 30 Jul 2021 02:28:44 -0700 (PDT)
Received: from myrica (adsl-84-226-111-173.adslplus.ch. [84.226.111.173])
 by smtp.gmail.com with ESMTPSA id fr4sm367026ejc.42.2021.07.30.02.28.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jul 2021 02:28:43 -0700 (PDT)
Date: Fri, 30 Jul 2021 11:28:23 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 19/24] iommu: Expose DMA domain strictness via sysfs
Message-ID: <YQPGNxhgVEagZ28H@myrica>
References: <cover.1627468308.git.robin.murphy@arm.com>
 <dd26592103c7613ef9fdff703d0d2ed2df8305c2.1627468310.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <dd26592103c7613ef9fdff703d0d2ed2df8305c2.1627468310.git.robin.murphy@arm.com>
Cc: linux-kernel@vger.kernel.org, dianders@chromium.org,
 iommu@lists.linux-foundation.org, will@kernel.org,
 linux-arm-kernel@lists.infradead.org
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

On Wed, Jul 28, 2021 at 04:58:40PM +0100, Robin Murphy wrote:
> The sysfs interface for default domain types exists primarily so users
> can choose the performance/security tradeoff relevant to their own
> workload. As such, the choice between the policies for DMA domains fits
> perfectly as an additional point on that scale - downgrading a
> particular device from a strict default to non-strict may be enough to
> let it reach the desired level of performance, while still retaining
> more peace of mind than with a wide-open identity domain. Now that we've
> abstracted non-strict mode as a distinct type of DMA domain, allow it to
> be chosen through the user interface as well.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  Documentation/ABI/testing/sysfs-kernel-iommu_groups | 2 ++
>  drivers/iommu/iommu.c                               | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-kernel-iommu_groups b/Documentation/ABI/testing/sysfs-kernel-iommu_groups
> index eae2f1c1e11e..43ba764ba5b7 100644
> --- a/Documentation/ABI/testing/sysfs-kernel-iommu_groups
> +++ b/Documentation/ABI/testing/sysfs-kernel-iommu_groups
> @@ -42,6 +42,8 @@ Description:	/sys/kernel/iommu_groups/<grp_id>/type shows the type of default
>  		========  ======================================================
>  		DMA       All the DMA transactions from the device in this group
>  		          are translated by the iommu.
> +		DMA-FQ    As above, but using batched invalidation to lazily
> +		          remove translations after use.

It might be useful to desribe the security/performance tradeoff here as
well. I guess a normal user is more likely to look at the doc for this
sysfs knob than the kernel config or parameters.

Thanks,
Jean

>  		identity  All the DMA transactions from the device in this group
>  		          are not translated by the iommu.
>  		auto      Change to the type the device was booted with.
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index eecb5657de69..5a08e0806cbb 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -3265,6 +3265,8 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
>  		req_type = IOMMU_DOMAIN_IDENTITY;
>  	else if (sysfs_streq(buf, "DMA"))
>  		req_type = IOMMU_DOMAIN_DMA;
> +	else if (sysfs_streq(buf, "DMA-FQ"))
> +		req_type = IOMMU_DOMAIN_DMA_FQ;
>  	else if (sysfs_streq(buf, "auto"))
>  		req_type = 0;
>  	else
> -- 
> 2.25.1
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
