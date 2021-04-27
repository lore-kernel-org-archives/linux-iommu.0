Return-Path: <SRS0=GIAn=JY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF35C43461
	for <iommu@archiver.kernel.org>; Tue, 27 Apr 2021 23:01:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C42761401
	for <iommu@archiver.kernel.org>; Tue, 27 Apr 2021 23:01:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C42761401
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 20FF860B72;
	Tue, 27 Apr 2021 23:01:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JI4V7lIJm7ib; Tue, 27 Apr 2021 23:01:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id E93E4605AF;
	Tue, 27 Apr 2021 23:01:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C7831C001C;
	Tue, 27 Apr 2021 23:01:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2F524C0001
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 23:01:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1D3CF605D9
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 23:01:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HL4_u-FnSgaP for <iommu@lists.linux-foundation.org>;
 Tue, 27 Apr 2021 23:01:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3D1A7605AF
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 23:01:16 +0000 (UTC)
Received: by mail-qk1-x729.google.com with SMTP id k127so6175749qkc.6
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 16:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Jxr5SslTLaxp6nme+gpuPJSYdMGk5MPmebdD3HwlPqc=;
 b=mWCFLORk/JSO5hvqnSM+Tr4f5WX2JQQfM5zw3lnOqv2hI8yuK2QY2VRA4xKcfW/BBW
 7+hygn+gIdSUDWbWnu44e9xclJztFIqbTsp/9qMdRnWE354rUiO+6MGPtD09gFGZBaIy
 IMQtx4otwgxXJNa3cuXWog1ddYlO1lhhAgdkSaV16Mkmlj4d+AO8D+3Vib+IKn1kpnJh
 zB2E3oZUgKt5cnT7CqrKn19BnZSeoH4IVay80i46FytArqMCxbMFWeL7/z8Zhyn6aK1Z
 E+x0lqdvTXIEAWW5guabHeXg9VXM3pblwMdsknuFsYDM3IU6oHqS3nkBUCZzVKmLg6Hk
 fKBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Jxr5SslTLaxp6nme+gpuPJSYdMGk5MPmebdD3HwlPqc=;
 b=tW8E8itt4svjqwfeXBMm9Il4QGveFiQxuEWWRe2iNCNRsiI/PFQO9cZxVhFwBOy9UL
 nMkAO9SRbOXnZqRPCtVU5WThXjKPuoEJI80b1p6e43m6Y9spVFiJBb04D7R0mbma9din
 QvS+B6B+lC59Cg7GbvyhA2X8eYV/tBNSLsC8USZrL8yGNM94WrkcCTry61zxNug2Dt1S
 GzkbqjxoKRBGpHUwwG8VPyEmOF8OiVpiZfr+NyyHiYpbEQkyr4VppooEGWPUnO5K/wye
 O6dzH5BpyJ54H6U2aZ5GrTrWNSi+wvbp887MHbwmxKU8dw+yxMD8VXTHJn955PvqbnqS
 iw6g==
X-Gm-Message-State: AOAM531cTCV/FotfNFBPk42GRi6ZPbYOVRmWxaJ82qjDPXb6STbE1ho0
 v4jQOQ6DxlF5rxao+66l0QliGQ==
X-Google-Smtp-Source: ABdhPJzddRKTQchhnx30/Xg2SkamnN6ck8rs0UJ921MDl2H1WKlMVuDanOHHUjSuQhUcGpmIX430Sg==
X-Received: by 2002:a37:a5cb:: with SMTP id
 o194mr13564100qke.303.1619564475032; 
 Tue, 27 Apr 2021 16:01:15 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
 by smtp.gmail.com with ESMTPSA id t23sm3730974qkg.61.2021.04.27.16.01.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Apr 2021 16:01:14 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1lbWhd-00Dl5Q-Jp; Tue, 27 Apr 2021 20:01:13 -0300
Date: Tue, 27 Apr 2021 20:01:13 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH 05/16] dma-mapping: Introduce dma_map_sg_p2pdma()
Message-ID: <20210427230113.GV2047089@ziepe.ca>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-6-logang@deltatee.com>
 <20210427193157.GQ2047089@ziepe.ca>
 <3c9ba6df-750a-3847-f1fc-8e41f533d1a2@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3c9ba6df-750a-3847-f1fc-8e41f533d1a2@deltatee.com>
Cc: linux-pci@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-mm@kvack.org, Jason Ekstrand <jason@jlekstrand.net>,
 Ira Weiny <ira.weiny@intel.com>, Christoph Hellwig <hch@lst.de>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Matthew Wilcox <willy@infradead.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, John Hubbard <jhubbard@nvidia.com>,
 linux-block@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
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

On Tue, Apr 27, 2021 at 04:55:45PM -0600, Logan Gunthorpe wrote:

> > Also, I see only 8 users of this function. How about just fix them all
> > to support negative returns and use this as the p2p API instead of
> > adding new API?
> 
> Well there might be 8 users of dma_map_sg_attrs() but there are a very
> large number of dma_map_sg(). Seems odd to me to single out the first as
> requiring these changes, but leave the latter.

At a high level I'm OK with it. dma_map_sg_attrs() is the extra
extended version of dma_map_sg(), it already has a different
signature, a different return code is not out of the question.

dma_map_sg() is just the simple easy to use interface that can't do
advanced stuff.

> I'm not that opposed to this. But it will make this series a fair bit
> longer to change the 8 map_sg_attrs() usages.

Yes, but the result seems much nicer to not grow the DMA API further.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
