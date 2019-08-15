Return-Path: <SRS0=B4OP=WL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B84C32757
	for <iommu@archiver.kernel.org>; Thu, 15 Aug 2019 09:26:12 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2918021873
	for <iommu@archiver.kernel.org>; Thu, 15 Aug 2019 09:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="txS1ipMi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="OlWfXIG7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2918021873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 003C010F7;
	Thu, 15 Aug 2019 09:26:11 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 368B510F5
	for <iommu@lists.linux-foundation.org>;
	Thu, 15 Aug 2019 09:26:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com
	[66.63.167.143])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id DB35367F
	for <iommu@lists.linux-foundation.org>;
	Thu, 15 Aug 2019 09:26:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 8AEBC8EE1FB; 
	Thu, 15 Aug 2019 02:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
	s=20151216; t=1565861165;
	bh=ChiJO460CwqJr6bCz/k4RtKNXSI3O1ZZt8g3+Id8X0Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=txS1ipMiR7CUHSlUoHY7Yr340RD45sludbWwlFZbAST/wJTgB93X+NH4hXMHmM+sf
	fNgzpuZSnLQC7esRTxpsajyQxQCp08OzyfabL7vdCWupMwcui8U+xdDnveqEPNhWv9
	Z8o5cDslbreqbUwKWCvykOv3uCBIKZbKtc9/CFHc=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
	by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id xdeaREgeheqG; Thu, 15 Aug 2019 02:26:04 -0700 (PDT)
Received: from [192.168.1.74] (host31-48-63-146.range31-48.btcentralplus.com
	[31.48.63.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 68D8F8EE0BF;
	Thu, 15 Aug 2019 02:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
	s=20151216; t=1565861164;
	bh=ChiJO460CwqJr6bCz/k4RtKNXSI3O1ZZt8g3+Id8X0Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=OlWfXIG7zOd1sAz8WOHgBIsq+CjD6O6sa7mniwoVsb5xfY6YsyfecX180meWmNBEE
	AScnlELkp6geKt+seKwyCwqWGyxc9X+k5anMN1Vuga1ATt8Sq1gJxaFt33pFzZ4vBU
	rFECwrGGAhoFxx6qCn0IkP2mtfuU8za0Eta3XNl4=
Message-ID: <1565861152.2963.7.camel@HansenPartnership.com>
Subject: Re: [PATCH 7/8] parisc: don't set ARCH_NO_COHERENT_DMA_MMAP
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org, Marek
	Szyprowski <m.szyprowski@samsung.com>
Date: Thu, 15 Aug 2019 10:25:52 +0100
In-Reply-To: <20190808160005.10325-8-hch@lst.de>
References: <20190808160005.10325-1-hch@lst.de>
	<20190808160005.10325-8-hch@lst.de>
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Cc: linux-xtensa@linux-xtensa.org, Michal Simek <monstr@monstr.eu>,
	Vladimir Murzin <vladimir.murzin@arm.com>,
	linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>, linuxppc-dev@lists.ozlabs.org,
	Helge Deller <deller@gmx.de>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

On Thu, 2019-08-08 at 19:00 +0300, Christoph Hellwig wrote:
> parisc is the only architecture that sets ARCH_NO_COHERENT_DMA_MMAP
> when an MMU is enabled.  AFAIK this is because parisc CPUs use VIVT
> caches,

We're actually VIPT but the same principle applies.

>  which means exporting normally cachable memory to userspace is
> relatively dangrous due to cache aliasing.
> 
> But normally cachable memory is only allocated by dma_alloc_coherent
> on parisc when using the sba_iommu or ccio_iommu drivers, so just
> remove the .mmap implementation for them so that we don't have to set
> ARCH_NO_COHERENT_DMA_MMAP, which I plan to get rid of.

So I don't think this is quite right.  We have three architectural
variants essentially (hidden behind about 12 cpu types):

   1. pa70xx: These can't turn off page caching, so they were the non
      coherent problem case
   2. pa71xx: These can manufacture coherent memory simply by turning off
      the cache on a per page basis
   3. pa8xxx: these have a full cache flush coherence mechanism.

(I might have this slightly wrong: I vaguely remember the pa71xxlc
variants have some weird cache quirks for DMA as well)

So I think pa70xx we can't mmap.  pa71xx we can provided we mark the
page as uncached ... which should already have happened in the allocate
and pa8xxx which can always mmap dma memory without any special tricks.

James

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
