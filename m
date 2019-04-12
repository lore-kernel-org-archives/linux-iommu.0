Return-Path: <SRS0=HOzV=SO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4457C10F13
	for <iommu@archiver.kernel.org>; Fri, 12 Apr 2019 01:43:07 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 920302084D
	for <iommu@archiver.kernel.org>; Fri, 12 Apr 2019 01:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPF8+tWm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 920302084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 3367628DB;
	Fri, 12 Apr 2019 01:43:07 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 45AD928D8
	for <iommu@lists.linux-foundation.org>;
	Fri, 12 Apr 2019 01:42:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com
	[209.85.215.194])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 3B78C76D
	for <iommu@lists.linux-foundation.org>;
	Fri, 12 Apr 2019 01:42:26 +0000 (UTC)
Received: by mail-pg1-f194.google.com with SMTP id j26so4372147pgl.5
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 18:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=N/edebl6fwLLCvT6cW+DiKHx2sceM3kGh4jqxQjEkRQ=;
	b=TPF8+tWm85yCzBzyq3kFmqis6qhr2R69M06/boCdIvBQV/AQP2laZNj/keZRQxa5Oj
	EMvV0aRkdnYEd7Z2Hl2Z7pAVL0p5uy6E1ecC8o+6r1NSJyp+j/Dono/dzHqfhNtTyjO/
	u7SF5YNq8tGtRbQToJVbmCTtrNEUD3Qiy4s5HXAEgo1cpkKd+Vx/BvUleasQRikSH+xx
	xqH/UYxeNGBqI2aUu2YKFiq/00PJWxYtCsl7e2NhP1rPrwGx5iqvuGCFexJ4sRZsfK2q
	6ZFs2uPyDIi4tYmtJ+uI0V5jN8tgY+BdHGfgvlnaGsjfBpzLSN9gUBBIa3TFksmmMBuR
	s3yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=N/edebl6fwLLCvT6cW+DiKHx2sceM3kGh4jqxQjEkRQ=;
	b=A707py0Aovn197unz28sKvjjXUyMl7+m6em9Xf5BQq3KBkvlI9IdhzkS1Aj9FVE96s
	KzSWHD6Y6CsyVqR3kvtUi+zmoyVQck8TIG3G3VIFtpGXKBYGHn91QrNzxkzlx2fDoT/G
	CggYNwH92t4o/I+eJnJtpq01mNPzx2mJg+mWGLIV/98TbjQ5OmcmRYBQpg7K3dHy82nU
	7sMor8fxxVkf9hBqllsdSg5wp9xukUW194PPf76W0lwWoCqfAFwWGA/g4N2nBcmnQUa/
	KM27VdIXQw9G3iBDbIA7ZNo2VcFBj5o10TW58UQ5vMCQ45eD10GMSGpa/qBIdTpE+n9Z
	aYVg==
X-Gm-Message-State: APjAAAXVKippZm3gd41syEv4Nn+ddwqgMQCfSXPstbCYADnX6fyYmvXj
	9xSqBAnE+FHBc24YeaGP9pw=
X-Google-Smtp-Source: APXvYqy1AnegI08/lGM0BS41FlNGFY7Gvt3haUovc/4KpbcDkitm6EjYA1SR2x8N8yzkeB6Xnz5PRQ==
X-Received: by 2002:a63:195e:: with SMTP id 30mr50141014pgz.312.1555033345244; 
	Thu, 11 Apr 2019 18:42:25 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
	[216.228.112.22]) by smtp.gmail.com with ESMTPSA id
	d69sm15533756pfg.24.2019.04.11.18.42.24
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 11 Apr 2019 18:42:24 -0700 (PDT)
Date: Thu, 11 Apr 2019 18:42:20 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: Do we always need to reserve an iova before iommu_map?
Message-ID: <20190412014219.GA23701@Asurada-Nvidia.nvidia.com>
References: <20190409224718.GA3281@Asurada-Nvidia.nvidia.com>
	<3916e00d-d3a9-11be-4107-73429f6dd8bf@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3916e00d-d3a9-11be-4107-73429f6dd8bf@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
	iommu@lists.linux-foundation.org,
	Bjorn Andersson <bjorn.andersson@linaro.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190412014220.Jwl9ZPBJEUYYiXmepTgWqMIhamb2n9Z6gexk1afje_c@z>

Thanks for the reply Robin.

On Wed, Apr 10, 2019 at 10:20:38AM +0100, Robin Murphy wrote:
> On 09/04/2019 23:47, Nicolin Chen wrote:
> > According to the routine of iommu_dma_alloc(), it allocates an iova
> > then does iommu_map() to map the iova to a physical address of new
> > allocated pages. However, in remoteproc_core.c, I see its code try
> > to iommu_map() without having an alloc_iova() or alloc_iova_fast().
> >
> > Is it safe to do so? If an iova range is not allocated but mapped,
> > would a later iommu_dma_alloc() happen to hit this iova range when
> > doing its alloc_iova() and then fail to map?
> > 
> > And I am not very familiar with remoteproc code, so if I am missing
> > something, please kindly educate me.
> 
> AFAICS that area of the remoteproc code is using its own IOMMU domain, so
> it's free to manage that domain's address space however it wants - the

I see. So it seems that it would be safe to map to an iova without
dealing with iova_domain, as long as the device is attached to a
separately allocated iommu_domain; for those who use DMA API would
need to go through iova management.

> generic IOVA allocator is a good option for the DMA API where the only
> constraint is that the address we get fits within a mask, but drivers with
> more specific requirements may well be better off using other allocation
> methods. See also various DRM drivers (Tegra/Rockchip/etc.) that do similar,
> using a drm_mm to manage the address space.

Yea, I am aware of DRM drivers that manage both iommu_domain and
iova_domain manually. But it feels a bit heavy for our use case:

We have a downstream driver using DMA API for iommu_dma_alloc().
And it is happy with the API because the same API works for both
IOMMU and non-IOMMU configurations. But it also has one single
allocation that requires (same as remoteproc) to iommu_map to a
hard coded iova. Although it's so far a downstream use case, we
want to seek for a solution that could be closer to the mainline.

The current solution seems to give up the API and add own IOMMU
domain and iova management like DRM drivers. Could there be any
way of reserving an IOVA without giving up the API?

Thank you
Nicolin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
