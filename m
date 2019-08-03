Return-Path: <SRS0=gcAa=V7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D0CC433FF
	for <iommu@archiver.kernel.org>; Sat,  3 Aug 2019 06:42:01 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DDA42073D
	for <iommu@archiver.kernel.org>; Sat,  3 Aug 2019 06:42:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DDA42073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 281801837;
	Sat,  3 Aug 2019 06:42:01 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 2B0071823
	for <iommu@lists.linux-foundation.org>;
	Sat,  3 Aug 2019 06:39:32 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B3F7D712
	for <iommu@lists.linux-foundation.org>;
	Sat,  3 Aug 2019 06:39:31 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id A49A368BFE; Sat,  3 Aug 2019 08:39:27 +0200 (CEST)
Date: Sat, 3 Aug 2019 08:39:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Gavin Li <gavinli@thegavinli.com>
Subject: Re: [PATCH v1] dma-mapping: normal memory for mmap() on coherent
	architectures
Message-ID: <20190803063927.GA29719@lst.de>
References: <20190802180758.9691-1-gavinli@thegavinli.com>
	<20190803062333.GC29348@lst.de>
	<CA+GxvY5EzTOXWSn_nKb2=v2Lzy6kKBvd+LfWpeNF5o2iD1E6Rg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+GxvY5EzTOXWSn_nKb2=v2Lzy6kKBvd+LfWpeNF5o2iD1E6Rg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Gavin Li <git@thegavinli.com>, iommu@lists.linux-foundation.org,
	Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

On Fri, Aug 02, 2019 at 11:35:48PM -0700, Gavin Li wrote:
> Ah, seems like it wasn't as simple of a fix as I thought :)

With our mess of dma flags nothing is ever as simple as it seems..

> I intended to use dma_mmap_coherent() in the usbfs driver
> (drivers/usb/core/devio.c) because its mmap() was broken on arm64 and
> all the other noncoherent DMA architectures.

Good to know, that is the right thing to do!

I'll try to expedite the fix to 5.3-rc + stable backports once we agree
on the details.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
