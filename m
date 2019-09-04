Return-Path: <SRS0=42j6=W7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C306C3A5AA
	for <iommu@archiver.kernel.org>; Wed,  4 Sep 2019 07:00:42 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EDFF22CED
	for <iommu@archiver.kernel.org>; Wed,  4 Sep 2019 07:00:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EDFF22CED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D11EA1061;
	Wed,  4 Sep 2019 07:00:41 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E9222105B
	for <iommu@lists.linux-foundation.org>;
	Wed,  4 Sep 2019 07:00:39 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 183E6709
	for <iommu@lists.linux-foundation.org>;
	Wed,  4 Sep 2019 07:00:37 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 57523227A8A; Wed,  4 Sep 2019 09:00:33 +0200 (CEST)
Date: Wed, 4 Sep 2019 09:00:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH 08/13] swiotlb-xen: always use dma-direct helpers to
	alloc coherent pages
Message-ID: <20190904070033.GA11643@lst.de>
References: <20190902130339.23163-1-hch@lst.de>
	<20190902130339.23163-9-hch@lst.de>
	<5799ca4b-7993-b1c5-73fa-396a560f58e8@oracle.com>
	<8a7f9e23-ef26-e83b-8d1e-dcd7d233642a@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8a7f9e23-ef26-e83b-8d1e-dcd7d233642a@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
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

On Tue, Sep 03, 2019 at 06:25:54PM -0400, Boris Ostrovsky wrote:
> > If I am reading __dma_direct_alloc_pages() correctly there is a path
> > that will force us to use GFP_DMA32 and as Juergen pointed out in
> > another message that may not be desirable.

Yes, it will add GFP_DMA32.  So I guess for now we'll just keep the
direct page allocator calls and resend.  I don't think this is the
right thing to do long term, but I'd really like to get this series
finished.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
