Return-Path: <SRS0=gcAa=V7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FE3C433FF
	for <iommu@archiver.kernel.org>; Sat,  3 Aug 2019 10:33:05 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE7392166E
	for <iommu@archiver.kernel.org>; Sat,  3 Aug 2019 10:33:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE7392166E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 64F121AF3;
	Sat,  3 Aug 2019 10:33:04 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 8D45F1AF2
	for <iommu@lists.linux-foundation.org>;
	Sat,  3 Aug 2019 10:30:29 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id EAD67712
	for <iommu@lists.linux-foundation.org>;
	Sat,  3 Aug 2019 10:30:28 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4321A227A81; Sat,  3 Aug 2019 12:30:24 +0200 (CEST)
Date: Sat, 3 Aug 2019 12:30:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH 5/5] dma-mapping: remove ARCH_NO_COHERENT_DMA_MMAP
Message-ID: <20190803103024.GA32624@lst.de>
References: <20190725063401.29904-1-hch@lst.de>
	<20190725063401.29904-6-hch@lst.de>
	<20190802070354.GA8280@lst.de> <s5hh870rn4t.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <s5hh870rn4t.wl-tiwai@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: linux-xtensa@linux-xtensa.org, Michal Simek <monstr@monstr.eu>,
	linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	Robin Murphy <robin.murphy@arm.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Fri, Aug 02, 2019 at 10:24:02AM +0200, Takashi Iwai wrote:
> I wasn't careful enough to look at that change, sorry.
> 
> The code there tries to check whether dma_mmap_coherent() would always
> fail on some platforms.  Then the driver clears the mmap capability
> flag at the device open time and notifies user-space to fall back to
> the dumb read/write mode.
> 
> So I'm afraid that simply dropping the check would cause the behavior
> regression, e.g. on PARISC.
> 
> Is there any simple way to test whether dma_mmap_coherent() would work
> or not in general on the target platform?  It's not necessarily in an
> ifdef at all.

This isn't really a platform, but a per-device question.  I can add a
"bool dma_can_mmap(struct device *dev)" helper to check that.  But how
do I get at a suitable struct device in hw_support_mmap()?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
