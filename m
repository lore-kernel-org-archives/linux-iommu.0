Return-Path: <SRS0=w+D4=T3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADF3C04AB3
	for <iommu@archiver.kernel.org>; Mon, 27 May 2019 10:57:00 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FA1E20859
	for <iommu@archiver.kernel.org>; Mon, 27 May 2019 10:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gy9EASSR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FA1E20859
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D3ADB1810;
	Mon, 27 May 2019 10:56:59 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 97D4D180C
	for <iommu@lists.linux-foundation.org>;
	Mon, 27 May 2019 10:56:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com
	[209.85.214.193])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 49019A9
	for <iommu@lists.linux-foundation.org>;
	Mon, 27 May 2019 10:56:44 +0000 (UTC)
Received: by mail-pl1-f193.google.com with SMTP id gn7so6904295plb.10
	for <iommu@lists.linux-foundation.org>;
	Mon, 27 May 2019 03:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=xQG94E91rcdUfSlkW1uYF9ApGj+jgzKgN0E+vtaKz6A=;
	b=Gy9EASSRYlr9i12Logn21TdN5ujim45QVkv2y2MggLHvc1zjqiO1HnQBLFMvdefKhV
	8EUvnRVO5xeo+ymGVEjsG02qBU4VBKJE1w07kzfdcqPRGvvU6qwS7CcKyUwBb43n6ctR
	GXh4BXEKOgL0SWJtNXegveEi3DU5WYLZJg+61DjGG2FPDXWGfylwfRNQeZlbtfrm0Ca+
	3h/DBbQC5pmXA6gRd0uHwD+EOUkhThBuDvV1Iai08L58GcavSub2+7rJ+l4x9dHUQrr6
	XJqz9SfLROkIZQU/3aNmTia9K5JyI8CzL9X7+4mJCGAJPvtRPfLc2cg1CoPnV0/ANVEJ
	kf8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=xQG94E91rcdUfSlkW1uYF9ApGj+jgzKgN0E+vtaKz6A=;
	b=kHbHMHmkrYgoC/gpuQSI2c/nbPawED+6+RHk5kxxpTGpuJnXs95ZbpF/brC65Zim/r
	r9s8KsrQvImiwtzUyS/cV1uIwJAuTgGmmebkRvVt2bgXreO6ouF28QlthNZu25wG2iPM
	RkWMtG6Xrp8SKcoJRtN6NeQC+wrS5NfOPQ6pkSPqh0j7Wd4dsR2fLcdamIPMb1RcC5YQ
	PG9IH5uMngaJIMhntaWc96swISiT1WZ/cJCOm8/0HEdvGbeoQyrtoY227j49Sdg8uXlh
	ALvetqgSLdqW1xeZ9sGnzF1H53t2raBJkOMzTHNnFH7n0kf+LLJWEJA5AZUTJIyReSOE
	1wzw==
X-Gm-Message-State: APjAAAU8lNL5jBcYRwyGu/AV38iGBqLh94qSJwYvEx/Qvc//WyNjc90n
	UZJqqHeZHysqavphT895d30=
X-Google-Smtp-Source: APXvYqwYifFGznpVmbp990JQuxYufhL5+M7CwwnvfxITZA/hhhnqSphHZcc/3LL1+bFx/1MWhz5Akw==
X-Received: by 2002:a17:902:28c9:: with SMTP id
	f67mr20202766plb.19.1558954603720; 
	Mon, 27 May 2019 03:56:43 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
	[216.228.112.22]) by smtp.gmail.com with ESMTPSA id
	x10sm14034629pfj.136.2019.05.27.03.56.42
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 27 May 2019 03:56:43 -0700 (PDT)
Date: Mon, 27 May 2019 03:55:29 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v3 2/2] dma-contiguous: Use fallback alloc_pages for
	single pages
Message-ID: <20190527105528.GA26916@Asurada-Nvidia.nvidia.com>
References: <20190524040633.16854-1-nicoleotsuka@gmail.com>
	<20190524040633.16854-3-nicoleotsuka@gmail.com>
	<20190524161618.GB23100@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190524161618.GB23100@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: tony@atomide.com, catalin.marinas@arm.com, will.deacon@arm.com,
	jcmvbkbc@gmail.com, hch@lst.de, sfr@canb.auug.org.au,
	dann.frazier@canonical.com, linux@armlinux.org.uk,
	treding@nvidia.com, linux-xtensa@linux-xtensa.org,
	keescook@chromium.org, akpm@linux-foundation.org,
	linux-arm-kernel@lists.infradead.org, chris@zankel.net,
	wsa+renesas@sang-engineering.com, robin.murphy@arm.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	iamjoonsoo.kim@lge.com, dwmw2@infradead.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi Ira,

On Fri, May 24, 2019 at 09:16:19AM -0700, Ira Weiny wrote:
> On Thu, May 23, 2019 at 09:06:33PM -0700, Nicolin Chen wrote:
> > The addresses within a single page are always contiguous, so it's
> > not so necessary to always allocate one single page from CMA area.
> > Since the CMA area has a limited predefined size of space, it may
> > run out of space in heavy use cases, where there might be quite a
> > lot CMA pages being allocated for single pages.
> > 
> > However, there is also a concern that a device might care where a
> > page comes from -- it might expect the page from CMA area and act
> > differently if the page doesn't.
> 
> How does a device know, after this call, if a CMA area was used?  From the
> patches I figured a device should not care.

A device doesn't know. But that doesn't mean a device won't care
at all. There was a concern from Robin and Christoph, as a corner
case that device might act differently if the memory isn't in its
own CMA region. That's why we let it still use its device specific
CMA area.

> > +	if (dev && dev->cma_area)
> > +		cma = dev->cma_area;
> > +	else if (count > 1)
> > +		cma = dma_contiguous_default_area;
> 
> Doesn't dev_get_dma_area() already do this?

Partially yes. But unwrapping it makes the program flow clear in
my opinion. Actually I should have mentioned that this patch was
suggested by Christoph also.

Otherwise, it would need an override like:
	cma = dev_get_dma_area();
	if (count > 1 && cma == dma_contiguous_default_area)
		cma = NULL;

Which doesn't look that bad though..

Thanks
Nicolin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
