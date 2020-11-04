Return-Path: <SRS0=z3hi=EK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FB9C4742C
	for <iommu@archiver.kernel.org>; Wed,  4 Nov 2020 15:53:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E6A32074B
	for <iommu@archiver.kernel.org>; Wed,  4 Nov 2020 15:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="AUuOlw0K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E6A32074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id AFC1D8675E;
	Wed,  4 Nov 2020 15:53:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id taTL1UbQ4Epn; Wed,  4 Nov 2020 15:53:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7309B86744;
	Wed,  4 Nov 2020 15:53:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3D7A3C0889;
	Wed,  4 Nov 2020 15:53:00 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 00A47C0051
 for <iommu@lists.linux-foundation.org>; Wed,  4 Nov 2020 15:52:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A184A872A8
 for <iommu@lists.linux-foundation.org>; Wed,  4 Nov 2020 15:52:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yoo5-NK8bYTx for <iommu@lists.linux-foundation.org>;
 Wed,  4 Nov 2020 15:52:57 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qv1-f67.google.com (mail-qv1-f67.google.com
 [209.85.219.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id B2613872A3
 for <iommu@lists.linux-foundation.org>; Wed,  4 Nov 2020 15:52:57 +0000 (UTC)
Received: by mail-qv1-f67.google.com with SMTP id 63so10111072qva.7
 for <iommu@lists.linux-foundation.org>; Wed, 04 Nov 2020 07:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Ep7j19TFsqDMxPD3eWS2/2sPns1mbbjfPZKNVE69Xzw=;
 b=AUuOlw0KLAwiVQOesE52nchcwhD+3eTZAOQ2AgXJOWJ3XMaOIef+M5UvRSDII07R0g
 LA67cShD36nAgQV8XflNylXVuiA9sN1sxapH5hcvQBg8BMC7oJSDqlj0n+QWuYrsrnUO
 eYTDqWcZiNmGe8ZSYPR7o+mtkhMR+Am5r4Q5ogWcrniQAQcqWctDeHsw4sQs+XVqbj9W
 uy62bb+5tgNsFxaIO8R99eExOitp2+auF/LVKl/FJMf9gQLPgmbI+98DbDFpME61i+zO
 jScwkquASavS/MyIkGqJ+gnyoRkmEoldBWapXzelMv/l/RVZ2eoDAumCUlXO8B4T2AnK
 N0wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Ep7j19TFsqDMxPD3eWS2/2sPns1mbbjfPZKNVE69Xzw=;
 b=ALImf8I/pL4tXSiaDmoxOjTpbomVQbK/Itv871c+QlBWWof7U/F8730bfLh1B4W3Bn
 QXfyD555pqDCq/jNf/pyVIv3kbLwIkBLB4K6gphqA/kr/ieQUJDuHnqa2inuAbJtkRnk
 KtZAZ/ZbnGmrswGGRWiTr/l3keD7bEJJoO/A9Cwuh8t4RbdMWZiLFzrAVXwVgnAAdIzU
 xq6FljHqUQ/i5t1p6GSL40amIf7OEudkgujuMpX1Bi+B0K7W2FPiObJb76/kr+YwJFO/
 AjMSup2qGZaBXrFoyBwmKFr+AUn34wK7rkXq2vyvzgcAr8C6Wf07BbXiaoHvw1suEj6S
 mYkw==
X-Gm-Message-State: AOAM532e/5xuGCU+0JhFSw1xpDZFblV0oUaQt+ujca3mkJJpjk9KAfqd
 tqJNouBp8AtLjAIKgtKxnaRvXQ==
X-Google-Smtp-Source: ABdhPJzi13d279sLLPCgu3bz4PAOPkGt+vfZ6Vorvp9mdCFZYQThEQ6fs7tjNSin4TOsVJDc3qddIA==
X-Received: by 2002:a0c:d68d:: with SMTP id k13mr444150qvi.62.1604505176734;
 Wed, 04 Nov 2020 07:52:56 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [156.34.48.30])
 by smtp.gmail.com with ESMTPSA id w25sm2821725qkj.85.2020.11.04.07.52.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2020 07:52:55 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1kaL5j-00GY3P-95; Wed, 04 Nov 2020 11:52:55 -0400
Date: Wed, 4 Nov 2020 11:52:55 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/5] RDMA/core: remove use of dma_virt_ops
Message-ID: <20201104155255.GR36674@ziepe.ca>
References: <20201104095052.1222754-1-hch@lst.de>
 <20201104095052.1222754-3-hch@lst.de>
 <20201104134241.GP36674@ziepe.ca> <20201104140108.GA5674@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201104140108.GA5674@lst.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-rdma@vger.kernel.org,
 iommu@lists.linux-foundation.org, Logan Gunthorpe <logang@deltatee.com>,
 linux-pci@vger.kernel.org
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

On Wed, Nov 04, 2020 at 03:01:08PM +0100, Christoph Hellwig wrote:

> > Sigh. I think the proper fix is to replace addr/length with a
> > scatterlist pointer in the struct ib_sge, then have SW drivers
> > directly use the page pointer properly.
> 
> The proper fix is to move the DMA mapping into the RDMA core, yes.
> And as you said it will be hard.  But I don't think scatterlists
> are the right interface.  IMHO we can keep re-use the existing
> struct ib_sge:
> 
> struct ib_ge {
> 	u64     addr;
> 	u32     length;
> 	u32     lkey;
> };

Gah, right, this is all about local_dma_lkey..
 
> with the difference that if lkey is not a MR, addr is the physical
> address of the memory, not a dma_addr_t or virtual address.

It could work, I think a resonable ULP API would be to have some

 rdma_fill_ib_sge_from_sgl()
 rdma_map_sge_single()
 etc etc

ie instead of wrappering the DMA API as-is we have a new API that
directly builds the ib_sge. It always fills the local_dma_lkey from
the pd, so it knows it is doing DMA from local kernel memory.

Logically SW devices then have a local_dma_lkey MR that has an IOVA of
the CPU physical address space, not the DMA address space as HW
devices have. The ib_sge builders can know this detail and fill in
addr from either a cpu phyical or a dma map.

The SW device has to translate the addr/length in CPU space to
something else. It actually makes reasonable sense architecturally.

This is actually much less horrible than I thought..

Convert all ULPs to one of these new APIs, searching for
local_dma_lkey will find all places. This will replace a whole lot of
calls to ib DMA API wrapper functions. Searching for local_dma_lkey
will find all users. Drivers already work with sge.addr == CPU
address, so no driver change

Then to kill the dma_ops wrappers the remaining users should all be
connected to map_mr_sg. In this case we want a no-op dma map and fix
the three map_mr_sg's to use the page side of the sgl, not the DMA
side

Not as horrible as I imagined at first, actually..

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
