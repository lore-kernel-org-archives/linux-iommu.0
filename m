Return-Path: <SRS0=Xpq5=OT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4EFC433F5
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 23:36:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85FCC615E5
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 23:36:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 85FCC615E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5F51483F5A;
	Wed, 29 Sep 2021 23:36:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xVRRsNfwNxMu; Wed, 29 Sep 2021 23:36:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2C16A83F53;
	Wed, 29 Sep 2021 23:36:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 116EBC0011;
	Wed, 29 Sep 2021 23:36:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E3A53C000D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 23:36:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D1AC483F5A
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 23:36:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T6Q0I4QkV0lP for <iommu@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 23:36:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2BE0F83F53
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 23:36:27 +0000 (UTC)
Received: by mail-qt1-x835.google.com with SMTP id b16so4000581qtt.7
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 16:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=p44CKw5NqI0dRYxuOA5K9AcDSEZdsWaIBA8jXRcCw5I=;
 b=BPbV7Ye4Bg5a1ZTPc0nR9KOXAhWl4vBzAsDP0t40qxFSH4OCK6/MQKoFgPTEuzSC9v
 9WzoiGlY1hhlhin2gZEWJVK42YbLrmi7f51aphr87IllDIDa/mW2TlwOq98Zvj0JRk6r
 inxpNiGI/a0tzZNBGtrfuGtkApxUXeOUvY5k07EjRTxe3FM8zYJRfjjEr2wiowyupIsP
 pguKaqLo4Vxp8H1+LxCZCv8O7UiZItzZkw/1xqVdmL+zc9QUl9vc75MtsgPZmJ4AEECN
 dBdxRWVA8aWYCV8FKdHpO9CE7a3VgpFt7E/hUggJ2cfyrdgPqy3taLCfKIMAeO9CnW6s
 e4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=p44CKw5NqI0dRYxuOA5K9AcDSEZdsWaIBA8jXRcCw5I=;
 b=D0tgVBse4TJLDfJzHYXXZPJmaJXOkrqqYm3B9cuYapUyqW/IHFYbM1bNo8eUdFDW4h
 w0dwHUWE5ApjVq02MW0NAXUshmna/oM9sn/OLEYl81VP6NQtrrgxqtEmPS+XboRrF7oo
 h6Hx0cHJr09bexOUmSc7w2HT/UaT6tGdw05mY5fKHzfHuECmKgWwc/ScKmLdyIHKwv0J
 ZOQ+3YrTNhIXk5NM1pr46rzZMnCqlaZJy9HPA5KNYOMfbIC0RYOi1+b7t9p8hAXh3RkA
 YuUvrs7QbdS5zjZ67MKVHTvYM3CMyuI8WdQhvQCqmlFxYW5ZNFCfqelHh6fxcwBxUMIJ
 H1Bg==
X-Gm-Message-State: AOAM531e4/dldh4jXRQX8t5MwoOMFWOZE6eP11nlBOjaknMhRCR5tvK/
 OUcvH13ExpEwzKYJyJJvjojOqA==
X-Google-Smtp-Source: ABdhPJyCMb0x8UTP251JMzz7qx/fZLPDIyTJit8sJRFPeoPnTFgHskOtgm8FIWQl2/TGWg7M25xovg==
X-Received: by 2002:a05:622a:492:: with SMTP id
 p18mr3159519qtx.282.1632958586146; 
 Wed, 29 Sep 2021 16:36:26 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.113.129])
 by smtp.gmail.com with ESMTPSA id f5sm706662qtp.44.2021.09.29.16.36.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Sep 2021 16:36:25 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1mVj7g-007iwP-Pe; Wed, 29 Sep 2021 20:36:24 -0300
Date: Wed, 29 Sep 2021 20:36:24 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v3 00/20] Userspace P2PDMA with O_DIRECT NVMe devices
Message-ID: <20210929233624.GG3544071@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210928200216.GW3544071@ziepe.ca>
 <06d75fcb-ce8b-30a5-db36-b6c108460d3d@deltatee.com>
 <20210929232147.GD3544071@ziepe.ca>
 <93f56919-03ee-8326-10ee-8fbd9078b8e0@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <93f56919-03ee-8326-10ee-8fbd9078b8e0@deltatee.com>
Cc: linux-pci@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-mm@kvack.org, Jason Ekstrand <jason@jlekstrand.net>,
 Ira Weiny <ira.weiny@intel.com>, Christoph Hellwig <hch@lst.de>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Matthew Wilcox <willy@infradead.org>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 John Hubbard <jhubbard@nvidia.com>, linux-block@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
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

On Wed, Sep 29, 2021 at 05:28:38PM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2021-09-29 5:21 p.m., Jason Gunthorpe wrote:
> > On Wed, Sep 29, 2021 at 03:50:02PM -0600, Logan Gunthorpe wrote:
> >>
> >>
> >> On 2021-09-28 2:02 p.m., Jason Gunthorpe wrote:
> >>> On Thu, Sep 16, 2021 at 05:40:40PM -0600, Logan Gunthorpe wrote:
> >>>> Hi,
> >>>>
> >>>> This patchset continues my work to add userspace P2PDMA access using
> >>>> O_DIRECT NVMe devices. My last posting[1] just included the first 13
> >>>> patches in this series, but the early P2PDMA cleanup and map_sg error
> >>>> changes from that series have been merged into v5.15-rc1. To address
> >>>> concerns that that series did not add any new functionality, I've added
> >>>> back the userspcae functionality from the original RFC[2] (but improved
> >>>> based on the original feedback).
> >>>
> >>> I really think this is the best series yet, it really looks nice
> >>> overall. I know the sg flag was a bit of a debate at the start, but it
> >>> serves an undeniable purpose and the resulting standard DMA APIs 'just
> >>> working' is really clean.
> >>
> >> Actually, so far, nobody has said anything negative about using the SG flag.
> >>
> >>> There is more possible here, we could also pass the new GUP flag in the
> >>> ib_umem code..
> >>
> >> Yes, that would be very useful.
> > 
> > You might actually prefer to do that then the bio changes to get the
> > infrastructur merged as it seems less "core"
> 
> I'm a little bit more concerned about my patch set growing too large.
> It's already at 20 patches and I think I'll need to add a couple more
> based on the feedback you've already provided. So I'm leaning toward
> pushing more functionality as future work.

I mean you could postpone the three block related patches and use a
single ib_umem patch instead as the consumer.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
