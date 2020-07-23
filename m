Return-Path: <SRS0=BMGV=BC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08EA3C433E0
	for <iommu@archiver.kernel.org>; Thu, 23 Jul 2020 06:01:24 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C08C1207F5
	for <iommu@archiver.kernel.org>; Thu, 23 Jul 2020 06:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICzl9lYX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C08C1207F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8A4378880C;
	Thu, 23 Jul 2020 06:01:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OgVr9W6pBxdZ; Thu, 23 Jul 2020 06:01:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 09AFE887F0;
	Thu, 23 Jul 2020 06:01:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 01911C004E;
	Thu, 23 Jul 2020 06:01:23 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 53D63C004C
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jul 2020 06:01:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 3F97C887BF
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jul 2020 06:01:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xH8M00QRyGrD for <iommu@lists.linux-foundation.org>;
 Thu, 23 Jul 2020 06:01:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
 [209.85.210.194])
 by hemlock.osuosl.org (Postfix) with ESMTPS id B71F488793
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jul 2020 06:01:21 +0000 (UTC)
Received: by mail-pf1-f194.google.com with SMTP id u5so2447820pfn.7
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jul 2020 23:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=gavqbcrgwcGpQgvScmzmRVwOwUMFwD22+EsX1OyiWXM=;
 b=ICzl9lYX/aS6sx0iO+qgwcoWMolNAovWVs/AZnETkfaiMWn3eKP/oa1SqHV27qxgaB
 FFkrCj/jhRc2aIl07LMAqhZTgh+ogAyB9GXg8JeiWe0G2GhZ7ruMhxgWMURrswNHlV2S
 e2uFrGV9dRkRTqBQTWnijc2j1rvy3CwgvUh/2wBKiY+tEitACk5PVcA6p5MA3AdAK14u
 tc4LcDiT3dgzvmqwXX9d96M0wUP8N6wfbOw7hX71fdNuET3k7tvAhEJ5LrXGKuAahb5C
 9Mneu+oWkltWyNXAVzsQX0CEq+obtHnX27hG/L5E6ejH6a7+hyHb/n2niI3fk6flHwX0
 TOAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=gavqbcrgwcGpQgvScmzmRVwOwUMFwD22+EsX1OyiWXM=;
 b=udd3aYhggFlAgGdYNpJWP3yv7AkZ8w1OIR1yoKHsaE2hV3fMYw6HfIdtE349hHN8BI
 RPsgcVRMgdoC3CIXMYwCnSvpFORqXzMvDfV0KR2jyUw0LpL2uNOVDibXvp6mYJcLKGoQ
 usD03Ge8pbmtFtMtGEup1OWsCR9QY9qdp9xY/FNSTkr5Bir31cT1tSVfrKNZBsYORVlA
 l/IkRixV1b7prWNr2+48LxdVHYVmw4TRI2jWVygzY0QRhlSe4BvAwRY0RZSMQ8+pbgYg
 q3tOuVE6rmKMEPnWXpCGhrK+6dHkZQ+8aqXD0R8dlk3OXa6x8f73ZP3sFjhrOQG2bhNJ
 qSXA==
X-Gm-Message-State: AOAM53065WgFfp7F+Ncu9IUeTLdQa9p2R/2mIqOU5kYUJ5OWTWLW/DRA
 nnau1U87HrGwgramzaIv/f/fH8cZuAI=
X-Google-Smtp-Source: ABdhPJxWFuhZzRe4Mv/FUcYCLLDKf50bWkuEWO3wK0Vi8hZYJZdWdJo+WsKy7GlaUE2IshPR7fH8kw==
X-Received: by 2002:a63:f254:: with SMTP id d20mr2890065pgk.119.1595484080929; 
 Wed, 22 Jul 2020 23:01:20 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
 by smtp.gmail.com with ESMTPSA id f207sm1539683pfa.107.2020.07.22.23.01.20
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 22 Jul 2020 23:01:20 -0700 (PDT)
Date: Wed, 22 Jul 2020 23:00:48 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] dma-contiguous: cleanup dma_alloc_contiguous
Message-ID: <20200723060047.GE5476@Asurada-Nvidia>
References: <20200722144307.30318-1-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200722144307.30318-1-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: iommu@lists.linux-foundation.org, robin.murphy@arm.com
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

On Wed, Jul 22, 2020 at 04:43:07PM +0200, Christoph Hellwig wrote:
> Split out a cma_alloc_aligned helper to deal with the "interesting"
> calling conventions for cma_alloc, which then allows to the main
> function to be written straight forward.  This also takes advantage
> of the fact that NULL dev arguments have been gone from the DMA API
> for a while.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  kernel/dma/contiguous.c | 31 ++++++++++++++-----------------
>  1 file changed, 14 insertions(+), 17 deletions(-)
> 
> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> index 15bc5026c485f2..f16b8d3f9932de 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -215,6 +215,13 @@ bool dma_release_from_contiguous(struct device *dev, struct page *pages,
>  	return cma_release(dev_get_cma_area(dev), pages, count);
>  }
>  
> +static struct page *cma_alloc_aligned(struct cma *cma, size_t size, gfp_t gfp)
> +{
> +	return cma_alloc(dma_contiguous_default_area, size >> PAGE_SHIFT,

Probably should be 'cma' here instead of 'dma_contiguous_default_area'?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
