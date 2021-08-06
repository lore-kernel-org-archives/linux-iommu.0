Return-Path: <SRS0=o7oR=M5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC4B7C432BE
	for <iommu@archiver.kernel.org>; Fri,  6 Aug 2021 11:41:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F62960EBB
	for <iommu@archiver.kernel.org>; Fri,  6 Aug 2021 11:41:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5F62960EBB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 27677405F5;
	Fri,  6 Aug 2021 11:41:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x-YEWZ_sjJnU; Fri,  6 Aug 2021 11:41:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 154FD405CC;
	Fri,  6 Aug 2021 11:41:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DD653C0010;
	Fri,  6 Aug 2021 11:41:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6A30CC000E
 for <iommu@lists.linux-foundation.org>; Fri,  6 Aug 2021 11:41:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 44C3D400F6
 for <iommu@lists.linux-foundation.org>; Fri,  6 Aug 2021 11:41:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5Dajbwu3D3wO for <iommu@lists.linux-foundation.org>;
 Fri,  6 Aug 2021 11:41:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7E307400CA
 for <iommu@lists.linux-foundation.org>; Fri,  6 Aug 2021 11:41:20 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id CA3E060E96;
 Fri,  6 Aug 2021 11:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628250080;
 bh=VFZN0rBpppBNLUjU4jzi8gHijERiKL8ZEpIblAjfEFI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kIbH3DRTq2Yh0J8aQC6p0lG3UyMCrFt0k7rpAiM0ndNHnjsYKHVTrN1zsXHLfmQS2
 7tVJj2nnPHe9jf1CTytZeqBuRtq0T00xT252KhG41zIFSJRL8qG8bEREUhbTuGoiKc
 r2KoAKBhRm+w7dcePHZ3sd/Ry03/rGFU7qNwA8V1OEI5c81LKutKxxCG0eNsuoaqqg
 4ULK7MibdtcRy/lzmvpSksKuvu1dyKKZ6lcK0HR95hRmftAbKWLyE3Bydq+Yb6MExK
 JxoGxAULAzi64wh5k4esUAFVXlw38EzFQDaAzX6uuzDhe+C6BOttTSldrDlsQmA4Di
 ztC0VPwcEPVBw==
Date: Fri, 6 Aug 2021 12:41:15 +0100
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] of: restricted dma: Don't fail device probe on rmem init
 failure
Message-ID: <20210806114114.GC2531@willie-the-truck>
References: <20210805094736.902-1-will@kernel.org>
 <af998e69-671c-6d13-bd9b-da71b389575c@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <af998e69-671c-6d13-bd9b-da71b389575c@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, Claire Chang <tientzu@chromium.org>,
 Christoph Hellwig <hch@lst.de>
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

On Thu, Aug 05, 2021 at 11:26:15AM +0100, Robin Murphy wrote:
> On 2021-08-05 10:47, Will Deacon wrote:
> > If CONFIG_DMA_RESTRICTED_POOL=n then probing a device with a reference
> > to a "restricted-dma-pool" will fail with a reasonably cryptic error:
> > 
> >    | pci-host-generic: probe of 10000.pci failed with error -22
> > 
> > Print a more helpful message in this case and try to continue probing
> > the device as we do if the kernel doesn't have the restricted DMA patches
> > applied or either CONFIG_OF_ADDRESS or CONFIG_HAS_DMA =n.
> 
> Makes sense to me;
> 
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Cheers.

> Although if we allow probe to succeed when a pool really was there for a
> reason, it may end up being much more fatal if the driver then tries to do a
> DMA transfer to any old memory and the device access causes an SError, or
> the VM to be killed, or whatever. That's not quite the same as the stubbed
> cases where the respective platforms couldn't have a genuine pool to parse
> either way, but as you say it is what could happen already if the user tried
> to use an older kernel, and I think the chance of
> of_reserved_mem_device_init_by_idx() failing without something being
> terminally wrong anyway - invalid DT, not enough RAM, etc. - is low enough
> that it's probably not a major concern. Plus I'd hope that the memory
> protection schemes people do actually implement don't take such such a
> zero-tolerance approach anyway - allowing a malicious or malfunctioning
> device to take down the system because it tried to make a rogue access which
> *was* already contained seems a bit silly.

There's also a case where swiotlb is forced (swiotlb=force) but restricted
DMA pools have been sized and allocated for individual devices in the DT.
In this case, having the guest fallback to the default shared swiotlb
buffer is better than failing the probe if CONFIG_DMA_RESTRICTED_POOL=n.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
