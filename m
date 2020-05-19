Return-Path: <SRS0=kGUL=7B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A7E2C433DF
	for <iommu@archiver.kernel.org>; Tue, 19 May 2020 08:04:15 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C91DA207D8
	for <iommu@archiver.kernel.org>; Tue, 19 May 2020 08:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9mBEPMQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C91DA207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id A53FD882FB;
	Tue, 19 May 2020 08:04:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p4+4TkmmJA3u; Tue, 19 May 2020 08:04:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2F12E81B3D;
	Tue, 19 May 2020 08:04:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 255F5C0881;
	Tue, 19 May 2020 08:04:14 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5028EC0176
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 08:04:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3B8E185FD5
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 08:04:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W6weT0POhrOG for <iommu@lists.linux-foundation.org>;
 Tue, 19 May 2020 08:04:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
 [209.85.215.193])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 5382B84647
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 08:04:11 +0000 (UTC)
Received: by mail-pg1-f193.google.com with SMTP id c75so5022640pga.3
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 01:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=O2zoxhUyUqiWwrDiEGQZbkYeTI0CYRs6GAWetfHo0bg=;
 b=e9mBEPMQ0AUKXiVv6+8gNZ2aWsCuCjKVPBjqX6F5gwBw+h27EYog/x5NlQPfAiXYlI
 03roQ6Y7fY0Mr35Acfxhx+O5DqQZMhaFDvh3/MEzwRH48z/bGM9d+jECtBYGYIpJr8Rj
 XoXf5sqZwBgloS+gXi+C6vmOHKH5axCgDnaltURufW0wHuX5cX8Au5A5SNxMfWCPpJal
 0PBBuTv1qkJO/uqlelwkYS8PW648WYKV+h2NxEPKwNk5P6sByIsMat+lvhi3V1ME3isQ
 DQFl78EWOfeU/kK5klVhXDDb9IMr0A2kMvFwbqSPSJTyCbhiWwyCWbamAqJA4SNryXBn
 PHcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=O2zoxhUyUqiWwrDiEGQZbkYeTI0CYRs6GAWetfHo0bg=;
 b=c6VT1dZ6wv2gOUxRl5vYtbvA5FrXumGDnVQOEc4a80TPGnRKd/gTB0J7ZN/UvMmVqc
 x+tioN6qvzwDbnCX2/tjRrD4ORMYKLSWPAdDC5wdKZI7+5UtrDS7DytaGwTyR8ZYZemZ
 JP4u+ElcqY3k7iTZUqu/RxXQQdua7UVL65fZbvyvYrYWXlvK4ziTPTPGrunF8pU+Je1K
 K0nxlPImPFU7kOY0B0+Bjlxl0We8f/ak07pOh/Lc6AzXl/V+MyPHksISQOJO1u53NrGm
 1oNzKqlozkMLnLnANNYCRoEv0+4yJbylR0Eo4+4q6fg/WU/r2pIHAC9Ap/999n6UAwLq
 IV3Q==
X-Gm-Message-State: AOAM532PPAw8qKcXKOBzwV2jkAr6OAqCms8mUn7TK2rQvC9ym0anO0MV
 m5g47BF8asCBbWbQind7s9s=
X-Google-Smtp-Source: ABdhPJzBikFNZW3Se7/rIga3Nfq04GryxnXf1z1a0E8FsB6PR9y8xSqM/jy3KbjUkRk9UwqXUitMdw==
X-Received: by 2002:a62:3441:: with SMTP id b62mr12752428pfa.225.1589875450728; 
 Tue, 19 May 2020 01:04:10 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
 by smtp.gmail.com with ESMTPSA id v75sm1510501pjb.35.2020.05.19.01.04.10
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 19 May 2020 01:04:10 -0700 (PDT)
Date: Tue, 19 May 2020 01:04:08 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: robin.murphy@arm.com, m.szyprowski@samsung.com, hch@lst.de
Subject: Re: [RFC/RFT][PATCH v2] dma-mapping: set default
 segment_boundary_mask to ULONG_MAX
Message-ID: <20200519080408.GA15325@Asurada-Nvidia>
References: <20200406210643.20665-1-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200406210643.20665-1-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

Hi Robin/Christoph,

This v2 was sent a while ago. I know that we had a concern,
yet will we have a closure whether merging it or not?

Thanks!
Nic

On Mon, Apr 06, 2020 at 02:06:43PM -0700, Nicolin Chen wrote:
> The default segment_boundary_mask was set to DMA_BIT_MAKS(32)
> a decade ago by referencing SCSI/block subsystem, as a 32-bit
> mask was good enough for most of the devices.
> 
> Now more and more drivers set dma_masks above DMA_BIT_MAKS(32)
> while only a handful of them call dma_set_seg_boundary(). This
> means that most drivers have a 4GB segmention boundary because
> DMA API returns a 32-bit default value, though they might not
> really have such a limit.
> 
> The default segment_boundary_mask should mean "no limit" since
> the device doesn't explicitly set the mask. But a 32-bit mask
> certainly limits those devices capable of 32+ bits addressing.
> 
> So this patch sets default segment_boundary_mask to ULONG_MAX.
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
> Changelog:
> v1->v2
>  * Followed Robin's comments to revise the commit message by
>    dropping one paragraph of not-entirely-true justification
>    (no git-diff level change, so please ack if you tested v1)
> 
>  include/linux/dma-mapping.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 330ad58fbf4d..ff8cefe85f30 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -736,7 +736,7 @@ static inline unsigned long dma_get_seg_boundary(struct device *dev)
>  {
>  	if (dev->dma_parms && dev->dma_parms->segment_boundary_mask)
>  		return dev->dma_parms->segment_boundary_mask;
> -	return DMA_BIT_MASK(32);
> +	return ULONG_MAX;
>  }
>  
>  static inline int dma_set_seg_boundary(struct device *dev, unsigned long mask)
> -- 
> 2.17.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
