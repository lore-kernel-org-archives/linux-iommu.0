Return-Path: <SRS0=4FG6=EM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F0EC55ABD
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 19:30:32 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FD1F20715
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 19:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="iJjd0Fsg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FD1F20715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id DE29986B14;
	Fri,  6 Nov 2020 19:30:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IagumVygXRB3; Fri,  6 Nov 2020 19:30:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id F166386CCC;
	Fri,  6 Nov 2020 19:30:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D72C9C088B;
	Fri,  6 Nov 2020 19:30:29 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84B0CC0889
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 19:30:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 7F07986A78
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 19:30:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I84GsEejWa_C for <iommu@lists.linux-foundation.org>;
 Fri,  6 Nov 2020 19:30:27 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com
 [209.85.222.195])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id C289386A6F
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 19:30:27 +0000 (UTC)
Received: by mail-qk1-f195.google.com with SMTP id c27so2128238qko.10
 for <iommu@lists.linux-foundation.org>; Fri, 06 Nov 2020 11:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=vFAruLUORQHUqfhAcqrK3kHFrju7FmZIpz+3LtddQik=;
 b=iJjd0FsgKSz4UMVJ0yEYuTXP+TTkCpe11X1VygTFEfMhBu4zVCI1R/v6juANR2qB4Q
 5Bels1w2oZzLmDsNDoThRLoK7kc/zdpwPO4UT6x6EAkceI8g/JOjAG91xGYl7kSFCQ/W
 ZbgarmDUY3PKv06eSLmj2WHCkLP1NnOHCZkgrx7CXQDuCJ/z7qt+/GjYjmsDayhhFmyK
 CViF4N4YOhwIP8BSr0EwEqNCdu9hb5mbPEEbp3iUTLeV3XnYywXW188JOM3kSYxEOLV5
 mfupyKsZCd/zGG/BUy47UXOrZMvD0veRq8OcWLdma8c/DrK5Km76/lwmXa36HDCDsiN4
 sXwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=vFAruLUORQHUqfhAcqrK3kHFrju7FmZIpz+3LtddQik=;
 b=mj8cDPFFgwmo0e0uB8PNZ1S6CO4ftVdas19GjJWOj2jboDygyg3OSZk82/kv5S0K+Q
 Op9evAKDjMg3VmjjZsRTbEra31gM/xbV69Boclwm1BQ33z0fKiFRgnnAOGIl+AMwpU3f
 uYbTDd7SutKb4TZ4ygkbVzQap9MXOoO2FtGWZdArugpex8WKa0wmESblpY6fprE1i8vt
 9ieensz4DtORnpaxHzSr5D+lUZXkimTReXpSYN8ggawKeiiEbQ/gSYDp4GjBuyEucNf+
 Lfwz3l0atGiM/AMAGn5hvyD7aiM7yrqqjyofzxgAHjXQG9cukYcOio3bvlXwwDoMOAPM
 Qg9g==
X-Gm-Message-State: AOAM533Tnn+cD7Znnil4O1rywU0Uin4rDZS71OGTIJFVgwqEgzeis8sp
 1gGAXWoGsvPlxtV0OemXnpmeJQ==
X-Google-Smtp-Source: ABdhPJze2F/Rq9sRVVe7Xk43RUxz3sel2lY1t652tRL/srA9lFIVY1sT0rqjvYUmBSCT+htfHCsU0Q==
X-Received: by 2002:a37:e40b:: with SMTP id y11mr3193612qkf.29.1604691026426; 
 Fri, 06 Nov 2020 11:30:26 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [156.34.48.30])
 by smtp.gmail.com with ESMTPSA id s2sm1115967qtw.44.2020.11.06.11.30.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2020 11:30:25 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1kb7RI-0011Hr-SE; Fri, 06 Nov 2020 15:30:24 -0400
Date: Fri, 6 Nov 2020 15:30:24 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [RFC PATCH 14/15] PCI/P2PDMA: Introduce pci_mmap_p2pmem()
Message-ID: <20201106193024.GW36674@ziepe.ca>
References: <20201106170036.18713-1-logang@deltatee.com>
 <20201106170036.18713-15-logang@deltatee.com>
 <20201106172206.GS36674@ziepe.ca>
 <b1e8dfce-d583-bed8-d04d-b7265a54c99f@deltatee.com>
 <20201106174223.GU36674@ziepe.ca>
 <2c2d2815-165e-2ef9-60d6-3ace7ff3aaa5@deltatee.com>
 <20201106180922.GV36674@ziepe.ca>
 <09885400-36f8-bc1d-27f0-a8adcf6104d4@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <09885400-36f8-bc1d-27f0-a8adcf6104d4@deltatee.com>
Cc: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 linux-pci@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Ira Weiny <iweiny@intel.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-block@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Matthew Wilcox <willy@infradead.org>,
 John Hubbard <jhubbard@nvidia.com>, Dan Williams <dan.j.williams@intel.com>,
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

On Fri, Nov 06, 2020 at 11:20:05AM -0700, Logan Gunthorpe wrote:
> 
> 
> On 2020-11-06 11:09 a.m., Jason Gunthorpe wrote:
> >> Ah, hmm, yes. I guess the pages have to be hooked and returned to the
> >> genalloc through free_devmap_managed_page(). 
> > 
> > That sounds about right, but in this case it doesn't need the VMA
> > operations.
> > 
> >> Seems like it might be doable... but it will complicate things for
> >> users that don't want to use the genpool (though no such users exist
> >> upstream).
> > 
> > I would like to use this stuff in RDMA pretty much immediately and the
> > genpool is harmful for those cases, so please don't make decisions
> > that are tying thing to genpool
> 
> I certainly can't make decisions for code that isn't currently
> upstream.

The rdma drivers are all upstream, what are you thinking about?

> Ultimately, if you aren't using the genpool you will have to implement
> your own mmap operation that somehow allocates the pages and your own
> page_free hook. 

Sure, the mlx5 driver already has a specialized alloctor for it's BAR
pages.

> I also don't expect this to be going upstream in the near term so don't
> get too excited about using it.

I don't know, it is actually not that horrible, the GUP and IOMMU
related changes are simpler than I expected

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
