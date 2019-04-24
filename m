Return-Path: <SRS0=cQN6=S2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81975C10F11
	for <iommu@archiver.kernel.org>; Wed, 24 Apr 2019 18:33:18 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D5B121773
	for <iommu@archiver.kernel.org>; Wed, 24 Apr 2019 18:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqLg0zPN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D5B121773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 1351C15D9;
	Wed, 24 Apr 2019 18:33:18 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B08A415D7
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 18:33:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
	[209.85.210.193])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 6156C82B
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 18:33:17 +0000 (UTC)
Received: by mail-pf1-f193.google.com with SMTP id w25so9739138pfi.9
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 11:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=8TEy0tx0jHylJx7e47yPJO+qgMm3AFlPvz5zMS1qhSY=;
	b=eqLg0zPNqnOMeNBKAwLI6PomFBg1//aO8UxynQI5ck9qKMhfU30AOHPk5LfJnq7R3w
	Z693bDoY5BcWklK0yQyMjTKsv7XI2oN9DVtSFLjkzaow2O/nmJVKJxdmbQYaeYrWAdgC
	MB9QCGPCFzweWL8xdNjUylzB+tT9HbflspBwpDho0ZmKLVzEB9nWwPQWn7RebXNaKkaX
	GZP8VlrMejBnji+h4jFl+qSeR1YKgNKytt1IzHUeXUELql2koND7HL3mAhJl3jmX1D9w
	6ui9v+KD0tbMtJRny4Ow8MocSqRIze3m6r07tQlXmp3wmuwkGH1kA2lEcLf5LVuZN3CS
	m6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=8TEy0tx0jHylJx7e47yPJO+qgMm3AFlPvz5zMS1qhSY=;
	b=f8WoUQoXDsf27RdaqOPhuRXtI/oKeQtzO8EtgjKZKOErf5NJ+jdkJ/2s6gQ2C1MMqc
	FAzZdbFy59U+esQJAQXlTumZaCtV5JHWbvkN/3IUzKxHxd+dyTkaOowmgSWZppSVkSF7
	QEzOZIZIHohe/1jPA4crA86XRx/cCP1UQlV1123bZ1AOftzyWOOyfP3yVNU+nEc2Yvtp
	2ZICizL9XYIvbdXvLaC5BffZi2h+Fwbz324+glBN+Xb3SRRjkOcZjDICKK5Q1cMoZsJK
	X0sAjgXvcMxs3g53igmmRPyotjh3GliaLgWyjwjMiekEJilgy5pNdVriuGgJhgvGxyxl
	n7wA==
X-Gm-Message-State: APjAAAU3bdRHLrNO7w+BBR4vn+DTTIKJNUNNoOG5/ZH1MXNpt5HG0kxR
	6BSeLw3XYFDN9vep/hiB1fA=
X-Google-Smtp-Source: APXvYqyY7PI6qWpkkSXcac3wixJyG1JL6PVz0l3idYqFErVnnnB1azTnKuYcgT6q0FkE26K1aXkecg==
X-Received: by 2002:a63:5a4b:: with SMTP id k11mr31878166pgm.119.1556130796862;
	Wed, 24 Apr 2019 11:33:16 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
	[216.228.112.22]) by smtp.gmail.com with ESMTPSA id
	c28sm9686899pgm.42.2019.04.24.11.33.15
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Apr 2019 11:33:16 -0700 (PDT)
Date: Wed, 24 Apr 2019 11:33:11 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 RFC/RFT 1/5] ARM: dma-mapping: Add fallback normal
	page allocations
Message-ID: <20190424183310.GA6168@Asurada-Nvidia.nvidia.com>
References: <20190326230131.16275-1-nicoleotsuka@gmail.com>
	<20190326230131.16275-2-nicoleotsuka@gmail.com>
	<20190424150638.GA22191@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190424150638.GA22191@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: tony@atomide.com, catalin.marinas@arm.com, will.deacon@arm.com,
	linux@armlinux.org.uk, iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org
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
Message-ID: <20190424183311.i2zYKvJAkRu7QupRPs672x1UVTIMPxmF8FWWmCFgG-g@z>

Hi Christoph,

On Wed, Apr 24, 2019 at 05:06:38PM +0200, Christoph Hellwig wrote:
> On Tue, Mar 26, 2019 at 04:01:27PM -0700, Nicolin Chen wrote:
> >  	page = dma_alloc_from_contiguous(dev, count, order, gfp & __GFP_NOWARN);
> > +	if (!page)
> > +		page = alloc_pages(gfp, order);
> 
> We have this fallback in most callers already.  And with me adding
> it to the dma-iommu code in one series, and you to arm here I think
> we really need to take a step back and think of a better way
> to handle this, and the general mess that dma_alloc_from_contiguous.
> 
> So what about:

Thanks for the suggestion!

>  (1) change the dma_alloc_from_contiguous prototype to be:
> 
> struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp);
> 
>      that is: calculate order and count internally, pass the full gfp_t
>      and mask it internally, and drop the pointless from in the name.
>      I'd also use the oppurtunity to forbid a NULL dev argument and
>      opencode those uses.
>  
>  (2) handle the alloc_pages fallback internally.  Note that we should
>      use alloc_pages_node as we do in dma-direct.

I feel it's similar to my previous set, which did most of these
internally except the renaming part. But Catalin had a concern
that some platforms might have limits on CMA range [1]. Will it
be still okay to do the fallback internally?

[1: https://www.spinics.net/lists/arm-kernel/msg714295.html ]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
