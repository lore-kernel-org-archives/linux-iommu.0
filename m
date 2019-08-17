Return-Path: <SRS0=Kr6o=WN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C53C3A59B
	for <iommu@archiver.kernel.org>; Sat, 17 Aug 2019 06:50:18 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69C822077C
	for <iommu@archiver.kernel.org>; Sat, 17 Aug 2019 06:50:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69C822077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 299D1B8E;
	Sat, 17 Aug 2019 06:50:18 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E03A1B88
	for <iommu@lists.linux-foundation.org>;
	Sat, 17 Aug 2019 06:50:16 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 69D5963D
	for <iommu@lists.linux-foundation.org>;
	Sat, 17 Aug 2019 06:50:16 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 70BE768B05; Sat, 17 Aug 2019 08:50:12 +0200 (CEST)
Date: Sat, 17 Aug 2019 08:50:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: Julien Grall <julien.grall@arm.com>
Subject: Re: [Xen-devel] [PATCH 07/11] swiotlb-xen: provide a single
	page-coherent.h header
Message-ID: <20190817065011.GA18599@lst.de>
References: <20190816130013.31154-1-hch@lst.de>
	<20190816130013.31154-8-hch@lst.de>
	<9a3261c6-5d92-cf6b-1ae8-3a8e8b5ef0d4@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9a3261c6-5d92-cf6b-1ae8-3a8e8b5ef0d4@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Stefano Stabellini <sstabellini@kernel.org>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	xen-devel@lists.xenproject.org, Christoph Hellwig <hch@lst.de>,
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

On Fri, Aug 16, 2019 at 11:40:43PM +0100, Julien Grall wrote:
> I am not sure I agree with this rename. The implementation of the helpers 
> are very Arm specific as this is assuming Dom0 is 1:1 mapped.
>
> This was necessary due to the lack of IOMMU on Arm platforms back then.
> But this is now a pain to get rid of it on newer platform...

So if you look at the final version of the header after the whole
series, what assumes a 1:1 mapping?  It all just is

	if (pfn_valid())
		local cache sync;
	else
		call into the arch code;

are you concerned that the local cache sync might have to be split
up more for a non-1:1 map in that case?  We could just move
the xen_dma_* routines into the arch instead of __xen_dma, but it
really helps to have a common interface header.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
