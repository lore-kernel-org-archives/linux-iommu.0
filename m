Return-Path: <SRS0=Kg+4=TA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B12C43219
	for <iommu@archiver.kernel.org>; Tue, 30 Apr 2019 15:19:25 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D15A520835
	for <iommu@archiver.kernel.org>; Tue, 30 Apr 2019 15:19:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D15A520835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 93BC71AA3;
	Tue, 30 Apr 2019 15:19:24 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 139781A01
	for <iommu@lists.linux-foundation.org>;
	Tue, 30 Apr 2019 15:18:54 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 7260687D
	for <iommu@lists.linux-foundation.org>;
	Tue, 30 Apr 2019 15:18:53 +0000 (UTC)
Received: by newverein.lst.de (Postfix, from userid 2407)
	id D457F67358; Tue, 30 Apr 2019 17:18:33 +0200 (CEST)
Date: Tue, 30 Apr 2019 17:18:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RFC/RFT PATCH 1/2] dma-contiguous: Simplify
	dma_*_from_contiguous() function calls
Message-ID: <20190430151833.GB25447@lst.de>
References: <20190430015521.27734-1-nicoleotsuka@gmail.com>
	<20190430015521.27734-2-nicoleotsuka@gmail.com>
	<20190430105640.GA20021@lst.de>
	<0e3e6d8b-de44-d23e-a039-8d11b578ec5c@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0e3e6d8b-de44-d23e-a039-8d11b578ec5c@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: tony@atomide.com, catalin.marinas@arm.com, will.deacon@arm.com,
	jcmvbkbc@gmail.com, Christoph Hellwig <hch@lst.de>,
	sfr@canb.auug.org.au, linux@armlinux.org.uk, treding@nvidia.com,
	linux-xtensa@linux-xtensa.org, keescook@chromium.org,
	Nicolin Chen <nicoleotsuka@gmail.com>, akpm@linux-foundation.org,
	linux-arm-kernel@lists.infradead.org, chris@zankel.net,
	wsa+renesas@sang-engineering.com, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, iamjoonsoo.kim@lge.com,
	dwmw2@infradead.org
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
Message-ID: <20190430151833.ZW1mJxB7WMaJDsi9Nqc4CDttqg5lizvv2YPYdJOlGTU@z>

On Tue, Apr 30, 2019 at 01:37:54PM +0100, Robin Murphy wrote:
> On 30/04/2019 11:56, Christoph Hellwig wrote:
>> So while I really, really like this cleanup it turns out it isn't
>> actually safe for arm :(  arm remaps the CMA allocation in place
>> instead of using a new mapping, which can be done because they don't
>> share PMDs with the kernel.
>>
>> So we'll probably need a __dma_alloc_from_contiguous version with
>> an additional bool fallback argument - everyone but arms uses
>> dma_alloc_from_contiguous as in your patch, just arm will get the
>> non-fallback one.
>
> Or we even just implement dma_{alloc,free}_contiguous() as a wrapper around 
> the existing APIs so that users can be thoroughly checked and converted 
> one-by-one.

Yeah.  Actually given all the contention I wonder if the easiest solution
for now is to just open code the cma_alloc/cma_free calls in dma-direct
and dma-iommu, with the hopes that everyone is going to migrate to those
implementations in the mid-term anyway and dma_alloc_from_contiguous /
dma_release_from_contiguous just go away..
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
