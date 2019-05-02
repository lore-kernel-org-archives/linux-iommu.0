Return-Path: <SRS0=NDwq=TC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98714C43219
	for <iommu@archiver.kernel.org>; Thu,  2 May 2019 13:27:06 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A3182075E
	for <iommu@archiver.kernel.org>; Thu,  2 May 2019 13:27:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A3182075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 3F7C63156;
	Thu,  2 May 2019 13:27:06 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 01CC32FF5
	for <iommu@lists.linux-foundation.org>;
	Thu,  2 May 2019 13:26:30 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 96E35879
	for <iommu@lists.linux-foundation.org>;
	Thu,  2 May 2019 13:26:29 +0000 (UTC)
Received: by newverein.lst.de (Postfix, from userid 2407)
	id ABBCA68AA6; Thu,  2 May 2019 15:26:10 +0200 (CEST)
Date: Thu, 2 May 2019 15:26:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v2 RFC/RFT 1/5] ARM: dma-mapping: Add fallback normal
	page allocations
Message-ID: <20190502132610.GA3107@lst.de>
References: <20190326230131.16275-1-nicoleotsuka@gmail.com>
	<20190326230131.16275-2-nicoleotsuka@gmail.com>
	<20190424150638.GA22191@lst.de>
	<20190424183310.GA6168@Asurada-Nvidia.nvidia.com>
	<20190424192652.GA29032@lst.de>
	<20190430152421.GE29799@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190430152421.GE29799@arrakis.emea.arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: tony@atomide.com, will.deacon@arm.com, linux@armlinux.org.uk,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	Nicolin Chen <nicoleotsuka@gmail.com>, robin.murphy@arm.com,
	Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org
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
Message-ID: <20190502132610.NSYaziH1A_hpBg-R3ws_JQ-wu2R387hYFrDWKcPN8Ac@z>

On Tue, Apr 30, 2019 at 04:24:21PM +0100, Catalin Marinas wrote:
> My reading of the arm32 __dma_alloc() is that if the conditions are
> right for the CMA allocator (allows blocking) and there is a default CMA
> area or a per-device one, the call ends up in cma_alloc() without any
> fallback if such allocation fails. Whether this is on purpose, I'm not
> entirely sure. There are a couple of arm32 SoCs which call
> dma_declare_contiguous() or dma_contiguous_reserve_area() and a few DT
> files describing a specific CMA range (e.g. arch/arm/boot/dts/sun5i.dtsi
> with a comment that address must be kept in the lower 256MB).
> 
> If ZONE_DMA is set up correctly so that cma_alloc() is (or can be made)
> interchangeable with alloc_pages(GFP_DMA) from a device DMA capability
> perspective , I think it should be fine to have such fallback.

Indeed.  I missed arm32 being different from everyone else, but we
already addresses that in another thread.  Sorry for misleading
everyone.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
