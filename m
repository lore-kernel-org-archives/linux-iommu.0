Return-Path: <SRS0=z3hi=EK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79668C2D0A3
	for <iommu@archiver.kernel.org>; Wed,  4 Nov 2020 18:09:49 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6847206CB
	for <iommu@archiver.kernel.org>; Wed,  4 Nov 2020 18:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="RqlA8/w8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6847206CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 863068675E;
	Wed,  4 Nov 2020 18:09:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UknNpDno4FOE; Wed,  4 Nov 2020 18:09:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id DF6BB86750;
	Wed,  4 Nov 2020 18:09:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C4DF7C088B;
	Wed,  4 Nov 2020 18:09:47 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 07D67C0051
 for <iommu@lists.linux-foundation.org>; Wed,  4 Nov 2020 18:09:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 038F784553
 for <iommu@lists.linux-foundation.org>; Wed,  4 Nov 2020 18:09:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bC5kxI5nJcyc for <iommu@lists.linux-foundation.org>;
 Wed,  4 Nov 2020 18:09:45 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qv1-f66.google.com (mail-qv1-f66.google.com
 [209.85.219.66])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 838FE8453B
 for <iommu@lists.linux-foundation.org>; Wed,  4 Nov 2020 18:09:15 +0000 (UTC)
Received: by mail-qv1-f66.google.com with SMTP id g13so10338150qvu.1
 for <iommu@lists.linux-foundation.org>; Wed, 04 Nov 2020 10:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=0hFi0TEBVUSWGO2K4tDK2RPW445ZDJNwZmLCkfQ4ceE=;
 b=RqlA8/w8ym+NosWRlENpZb00PKxQzhlipgpDQ2x8wUWKEek/AaN2hYf4xdsfgqzMyq
 r6fYqYkfOM2drdwoz5B8kBZ+Hb8ZWFL3KeINycNR3uCZjKB5d6GXpFfwE4l1nipygSBc
 7EqHGf7gtTdNprcR54xYK2b9Nx7s5Ksr2st0F37UXbn/V/F+H4Rm+vM5STjsbsINQJyA
 RNaNmXK7laH55H95YDJYikIvRIqPBPCCy8w5+UwY9CXescabd3RyPyHtIpPOe0LXlF+g
 8w7NUZ03Q9nSZYo9O1de6pJDDkfC3mThACnhX9a3cJSt47dHaUuAidpnSIAr8J6bY1SV
 g1ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=0hFi0TEBVUSWGO2K4tDK2RPW445ZDJNwZmLCkfQ4ceE=;
 b=Lof0zs6nCD/9odOHz3+9hysXE2411WyMuYOWgnt+LtDEUfvRCYnN2as1v6idnJpyvC
 luGZMBiQ1naB9uW53dEtQR0PGGRzLBbmO3XGlOciqN/1RldayapjsKX7CbrO8WHTTNb4
 lW0U2ksygPJ9NBg29DwoFH7ISsZdP3Fozktcxo+fnNwtyEUvgNyiS9O1fwJzJHulArf9
 0t3gO8NUVSd0C49j3sYhs4TOu3QWvs/Ozde/28VzvLs+6ZQ4dHphgr/7DiZe+pF/YmaD
 e+Gql2UCOOoO1CqFMNp+D37VXXPL2RSk6SFkEoVmfu8yifmiR4TlWDctFW0GyKn1GFUL
 Wh6w==
X-Gm-Message-State: AOAM5335PzMjEKxzb1Qf/s/hUVPs8bxT5q4VP2raIqOGzChhXSqUxlWE
 f0Ri1prof/tkk7uqWlepvr1UnQ==
X-Google-Smtp-Source: ABdhPJxPtfpuqqR8Rgm5jnzH160bIvcPShzueThP7abrgMAJGk2GTeyjhaFDKSLyJP0qsl8DAr8c7Q==
X-Received: by 2002:a05:6214:1249:: with SMTP id
 q9mr16729490qvv.0.1604513354401; 
 Wed, 04 Nov 2020 10:09:14 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [156.34.48.30])
 by smtp.gmail.com with ESMTPSA id 19sm3090113qkj.69.2020.11.04.10.09.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2020 10:09:13 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1kaNDc-00GaJ8-KP; Wed, 04 Nov 2020 14:09:12 -0400
Date: Wed, 4 Nov 2020 14:09:12 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/5] RDMA/core: remove use of dma_virt_ops
Message-ID: <20201104180912.GS36674@ziepe.ca>
References: <20201104095052.1222754-1-hch@lst.de>
 <20201104095052.1222754-3-hch@lst.de>
 <20201104134241.GP36674@ziepe.ca> <20201104140108.GA5674@lst.de>
 <20201104155255.GR36674@ziepe.ca> <20201104163135.GA15840@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201104163135.GA15840@lst.de>
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

On Wed, Nov 04, 2020 at 05:31:35PM +0100, Christoph Hellwig wrote:
> On Wed, Nov 04, 2020 at 11:52:55AM -0400, Jason Gunthorpe wrote:
> > It could work, I think a resonable ULP API would be to have some
> > 
> >  rdma_fill_ib_sge_from_sgl()
> >  rdma_map_sge_single()
> >  etc etc
> > 
> > ie instead of wrappering the DMA API as-is we have a new API that
> > directly builds the ib_sge. It always fills the local_dma_lkey from
> > the pd, so it knows it is doing DMA from local kernel memory.
> 
> Yeah.
> 
> > Logically SW devices then have a local_dma_lkey MR that has an IOVA of
> > the CPU physical address space, not the DMA address space as HW
> > devices have. The ib_sge builders can know this detail and fill in
> > addr from either a cpu phyical or a dma map.
> 
> I don't think the builders are the right place to do it - it really
> should to be in the low-level drivers for a bunch of reasons:

At this point we have little choice, the ULP is responsible for
map/unmap because the ULP owns the CQ and (batch) unmap is triggered
by some CQE.

Reworking all drivers to somehow keep track of unmaps a CQEs triggers
feels so hard at this point as to be impossible. It is why the
rdma_rw_ctx basically exists.

So we have to keep the current arrangment, when the ib_sge is built
the dma map must be conditionally done.

>  1) this avoids doing the dma_map when no DMA is performed, e.g. for
>     mlx5 when send data is in the extended WQE

At least in the kernel, the ULP has to be involved today in
IB_SEND_INLINE. Userspace does an auto-copy, but that is because it
doesn't have dma map/unmap. 

Without unmap tracking as above the caller must supply a specially
formed ib_sge when using IB_SEND_INLINE that specifies the CPU vaddr
so memcpy works.

But this all looks like dead code, no ULP sets IB_SEND_INLINE ??

>  2) to deal with the fact that dma mapping reduces the number of SGEs.
>     When the system uses a modern IOMMU we'll always end up with a
>     single IOVA range no matter how many pages were mapped originally.
>     This means any MR process can actually be consolidated to use
>     a single SGE with the local lkey.

Any place like rdma_rw_ctx_init() that decides dynamically between SGE
and MR becomes a mess. It would be manageable if rdma_rw_ctx_init()
was the only place doing this..

I haven't looked lately, but I wonder if it is feasible that all the
MR users would use this API?

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
