Return-Path: <SRS0=z3hi=EK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642EBC4741F
	for <iommu@archiver.kernel.org>; Wed,  4 Nov 2020 14:01:19 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75912205CB
	for <iommu@archiver.kernel.org>; Wed,  4 Nov 2020 14:01:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75912205CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id DB50486AEE;
	Wed,  4 Nov 2020 14:01:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iuiQQsQlUC-p; Wed,  4 Nov 2020 14:01:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id AF33C869EF;
	Wed,  4 Nov 2020 14:01:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 90F08C0889;
	Wed,  4 Nov 2020 14:01:16 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 235E6C0051
 for <iommu@lists.linux-foundation.org>; Wed,  4 Nov 2020 14:01:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1F78786AEE
 for <iommu@lists.linux-foundation.org>; Wed,  4 Nov 2020 14:01:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sc7TJfb2BQ-J for <iommu@lists.linux-foundation.org>;
 Wed,  4 Nov 2020 14:01:13 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 8DFF186AED
 for <iommu@lists.linux-foundation.org>; Wed,  4 Nov 2020 14:01:13 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 265B767373; Wed,  4 Nov 2020 15:01:09 +0100 (CET)
Date: Wed, 4 Nov 2020 15:01:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 2/5] RDMA/core: remove use of dma_virt_ops
Message-ID: <20201104140108.GA5674@lst.de>
References: <20201104095052.1222754-1-hch@lst.de>
 <20201104095052.1222754-3-hch@lst.de> <20201104134241.GP36674@ziepe.ca>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201104134241.GP36674@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 iommu@lists.linux-foundation.org, Bjorn Helgaas <bhelgaas@google.com>,
 Logan Gunthorpe <logang@deltatee.com>, Christoph Hellwig <hch@lst.de>
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

On Wed, Nov 04, 2020 at 09:42:41AM -0400, Jason Gunthorpe wrote:
> On Wed, Nov 04, 2020 at 10:50:49AM +0100, Christoph Hellwig wrote:
> 
> > +int ib_dma_virt_map_sg(struct ib_device *dev, struct scatterlist *sg, int nents)
> > +{
> > +	struct scatterlist *s;
> > +	int i;
> > +
> > +	for_each_sg(sg, s, nents, i) {
> > +		sg_dma_address(s) = (uintptr_t)sg_virt(s);
> > +		sg_dma_len(s) = s->length;
> 
> Hmm.. There is nothing ensuring the page is mapped here for this
> sg_virt(). Before maybe some of the kconfig stuff prevented highmem
> systems indirectly, I wonder if we should add something more direct to
> exclude highmem for these drivers?

I had actually noticed this earlier as well and then completely forgot
about it..

rdmavt depends on X86_64, so it can't be used with highmem, but for
rxe and siw there weren't any such dependencies so I think we were just
lucky.  Let me send a fix to add explicit depencies and then respin this
series on top of that..

> Sigh. I think the proper fix is to replace addr/length with a
> scatterlist pointer in the struct ib_sge, then have SW drivers
> directly use the page pointer properly.

The proper fix is to move the DMA mapping into the RDMA core, yes.
And as you said it will be hard.  But I don't think scatterlists
are the right interface.  IMHO we can keep re-use the existing
struct ib_sge:

struct ib_ge {
	u64     addr;
	u32     length;
	u32     lkey;
};

with the difference that if lkey is not a MR, addr is the physical
address of the memory, not a dma_addr_t or virtual address.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
