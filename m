Return-Path: <SRS0=Kg+4=TA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B86C43219
	for <iommu@archiver.kernel.org>; Tue, 30 Apr 2019 19:48:18 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11C922087B
	for <iommu@archiver.kernel.org>; Tue, 30 Apr 2019 19:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDkJwLgM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11C922087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id CA6401D99;
	Tue, 30 Apr 2019 19:48:17 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id DAECEF23
	for <iommu@lists.linux-foundation.org>;
	Tue, 30 Apr 2019 19:47:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com
	[209.85.215.194])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 82227608
	for <iommu@lists.linux-foundation.org>;
	Tue, 30 Apr 2019 19:47:51 +0000 (UTC)
Received: by mail-pg1-f194.google.com with SMTP id k19so7337034pgh.0
	for <iommu@lists.linux-foundation.org>;
	Tue, 30 Apr 2019 12:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=86GCSVrH9zo4gh156Oo5t8O2oP844A9QOA6J/OXOUxA=;
	b=RDkJwLgMXXBm7lJVQVTDnpEtriShEMPyVioxbhNW+zutYavuTMg0jbA7KIZU4ozWRa
	8IKC2EuvJi2rhxPjTUZf1t+gqmpJmc0a2yR3dcSEgC3NkAxERDqQkgahjcwvC4xbE/s/
	fkqW1OL++MlrDw6zQJ/HjWBnDv+IepQfzMfnf4gVq8buMVXCo0K6M29JIcQnC7woKwCD
	JlWH0/et3lm4jQE3SZXbnI2Oo5K+IbpTg3UuIYzsNpp7j2R16SRawvjYXnsLMOP+lM27
	rM0z3Ay7JsxNp4jcVY93LELKhAPfTqirUOfIR5/m9hA83EmsvwL4OoWKuXyfmjOIJ6oM
	SaxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=86GCSVrH9zo4gh156Oo5t8O2oP844A9QOA6J/OXOUxA=;
	b=iIe3GPlRJjfiJ731+YPB1X5goqjLBCTHd1asL9Wu8YLmrRK7a0elIhslLAEBNXVzuY
	n0O8RqeGBmLRp+RPoS4n7KgWVf1vIJYyknf+CPM6hjjiAUEaqW6bzfQyOeCfCFfpfa3k
	pRv8//baHjj17tXE3HEH4c73Cj0JZcugILZ1sRKh3Grzx9G5JTOE8ep77mKXRROz0zWF
	fd5Sw1xRkWR2ndelC2+56ZGDZ6dO5eye92mQW1Hhr2uAjAepQUUT6aAtjbnlY0V9Ur7D
	cNskDlnG/tRChL9npPFrYlwjXI+MjuA8p7oDatg8Ol/MNyLESJKHfYvia1eGgrpzzJ7w
	Az7Q==
X-Gm-Message-State: APjAAAVKVTOuJ4nq1xJC3rQQu+bos8hYuDk05DWvud8hIfDjS4xQDbfv
	0l20bNKusCxMLrKeXpP+fgo=
X-Google-Smtp-Source: APXvYqzFBvVULwHUiGXsDPHzgJbD3J/zaoDiLOXodZvC2mcsihPg9PVzKdT/PfoC4gUpNKvmhCjzaA==
X-Received: by 2002:a63:3fc1:: with SMTP id
	m184mr34699554pga.222.1556653670976; 
	Tue, 30 Apr 2019 12:47:50 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
	[216.228.112.22]) by smtp.gmail.com with ESMTPSA id
	g24sm5419285pfi.126.2019.04.30.12.47.49
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 30 Apr 2019 12:47:50 -0700 (PDT)
Date: Tue, 30 Apr 2019 12:46:13 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC/RFT PATCH 1/2] dma-contiguous: Simplify
	dma_*_from_contiguous() function calls
Message-ID: <20190430194612.GA31543@Asurada-Nvidia.nvidia.com>
References: <20190430015521.27734-1-nicoleotsuka@gmail.com>
	<20190430015521.27734-2-nicoleotsuka@gmail.com>
	<20190430105640.GA20021@lst.de>
	<0e3e6d8b-de44-d23e-a039-8d11b578ec5c@arm.com>
	<20190430151833.GB25447@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190430151833.GB25447@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: chris@zankel.net, linux-xtensa@linux-xtensa.org, keescook@chromium.org,
	sfr@canb.auug.org.au, tony@atomide.com, catalin.marinas@arm.com,
	will.deacon@arm.com, linux@armlinux.org.uk,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	jcmvbkbc@gmail.com, wsa+renesas@sang-engineering.com,
	akpm@linux-foundation.org, treding@nvidia.com,
	dwmw2@infradead.org, iamjoonsoo.kim@lge.com,
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
Message-ID: <20190430194613._OuTBWlIa2Vp_medLj1xyl9TAqz_AQ4murJgMiEEEs4@z>

On Tue, Apr 30, 2019 at 05:18:33PM +0200, Christoph Hellwig wrote:
> On Tue, Apr 30, 2019 at 01:37:54PM +0100, Robin Murphy wrote:
> > On 30/04/2019 11:56, Christoph Hellwig wrote:
> >> So while I really, really like this cleanup it turns out it isn't
> >> actually safe for arm :(  arm remaps the CMA allocation in place
> >> instead of using a new mapping, which can be done because they don't
> >> share PMDs with the kernel.
> >>
> >> So we'll probably need a __dma_alloc_from_contiguous version with
> >> an additional bool fallback argument - everyone but arms uses
> >> dma_alloc_from_contiguous as in your patch, just arm will get the
> >> non-fallback one.
> >
> > Or we even just implement dma_{alloc,free}_contiguous() as a wrapper around 
> > the existing APIs so that users can be thoroughly checked and converted 
> > one-by-one.
> 
> Yeah.  Actually given all the contention I wonder if the easiest solution
> for now is to just open code the cma_alloc/cma_free calls in dma-direct
> and dma-iommu, with the hopes that everyone is going to migrate to those
> implementations in the mid-term anyway and dma_alloc_from_contiguous /
> dma_release_from_contiguous just go away..

Thanks for the comments.

Listing all the solutions as a summary:
A) Add "bool fallback" to dma_{alloc,free}_contiguous, and let
   ARM use fallback=false.
B) Continue replacing "_from" with dma_{alloc,free}_contiguous
   but let callers like ARM use cma_alloc/free() directly.
C) Have both new dma_{alloc,free}_contiguous and "_from" funcs.
   Implement the new one to dma-direct only as an initial step
   and change others one-by-one in the future.

Combining the comments at alloc_pages_node(), I guess that the
Solution C would be a better (cleaner) one?

List of to-change callers for Solution C:
 kernel/dma/direct.c

List of to-exclude-for-now callers for Solution C:
 arch/arm64/mm/dma-mapping.c
 drivers/iommu/amd_iommu.c
 drivers/iommu/intel-iommu.c
 arch/arm/mm/dma-mapping.c
 arch/xtensa/kernel/pci-dma.c
 kernel/dma/remap.c
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
