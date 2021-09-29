Return-Path: <SRS0=Xpq5=OT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F47BC433EF
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 22:48:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACD90615E4
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 22:48:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ACD90615E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 539686133C;
	Wed, 29 Sep 2021 22:48:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 43r3aJu6DoBL; Wed, 29 Sep 2021 22:48:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4516B607BF;
	Wed, 29 Sep 2021 22:48:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 05FFEC000F;
	Wed, 29 Sep 2021 22:48:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9CC8EC000D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 22:48:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8BFC383FF2
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 22:48:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ziepe.ca
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6hU8Np19eZRH for <iommu@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 22:48:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9E16A80D90
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 22:48:34 +0000 (UTC)
Received: by mail-qk1-x735.google.com with SMTP id 138so3930646qko.10
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 15:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=B0sV1qVbbjrF0PysKkzPgbfO3+Me62Wpz2WIVsVwuoE=;
 b=P9N1xixIbU2CQZqPgthtCxabWVb1WaKJas+T5Bbtlr4fD7rztRWCIEl7HQ9hsYT8aF
 41wF7TSRaJ3f9seP9f0KrtpHt8gvV/9kf7XUzRs3fIottSWd5Jos1b7FSN+JKsFTdWUh
 cQmc0BxR1at5W66It0VtetEvP3kxr6TgFG71lefSWpCHrqHfP2E1T4XXYFzcdwOAnPpb
 WlKs8E3Ae/btD+bQUn9uA6WCV6uRLRFmutfEb0Vg/FCMMltR8qwOKBC/i/xs0Mi5ciI7
 QAuN+ydzCbvdhC6HuPboTTSd7wkOyLMNyDUAGQreZfH9ZakjqoboD9OYItawKLMdXBtS
 NwMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=B0sV1qVbbjrF0PysKkzPgbfO3+Me62Wpz2WIVsVwuoE=;
 b=oI6EuoVRNA1MLeID4joYBTzP+5TW7XTgd1KSXCV8kFHyvAh6pTc36GX09pXLdAzhLh
 dz6fNZXOCmUspXuzkMWtvJZVr/t8w9Jdr2Zp1bafBcJU66QpJ/9AiSBBZSQPhxLaxN6s
 jWFj1d2hsNcwcdDL4hKQlTcg+i7IAqIt1IMVaU4xsb3S25/ARdRQIDIFrhmLmN0wh2f3
 d5TJ3MhpEwsTqAExQOp2QUKJRBUA8pmhfJdFyNTy0Wn3mVc6a8GcGvJA3WS2OLqYFiGf
 y0gMnoSKkaZNCEzx7/LW3RAPJMztT5qpmp/eSg6mZRa81+5om47zu5CAZB0EMTapeb4U
 dZgw==
X-Gm-Message-State: AOAM530m/HAjHirCnZxzdyY+Dxm60SuhV3c/MvPIBc66F1vrPyr1IjOR
 31Wvo9D+qWYS+ZUUDn987xOPcQ==
X-Google-Smtp-Source: ABdhPJzspya2uDxnOQP6RHXKg0GJNOh86aMtX4Pki+BqPF0YRta2WtTuRpyPIif49H7Hs8Tu/MZ3xw==
X-Received: by 2002:a37:8ec6:: with SMTP id q189mr2083152qkd.145.1632955713476; 
 Wed, 29 Sep 2021 15:48:33 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.113.129])
 by smtp.gmail.com with ESMTPSA id q14sm748591qtw.82.2021.09.29.15.48.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Sep 2021 15:48:32 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1mViNL-007i7c-U2; Wed, 29 Sep 2021 19:48:31 -0300
Date: Wed, 29 Sep 2021 19:48:31 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v3 14/20] mm: introduce FOLL_PCI_P2PDMA to gate getting
 PCI P2PDMA pages
Message-ID: <20210929224831.GA3544071@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-15-logang@deltatee.com>
 <20210928194707.GU3544071@ziepe.ca>
 <9c40347c-f9a8-af86-71a5-2156359e15ce@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9c40347c-f9a8-af86-71a5-2156359e15ce@deltatee.com>
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

On Wed, Sep 29, 2021 at 03:34:22PM -0600, Logan Gunthorpe wrote:
> 
> 
> 
> On 2021-09-28 1:47 p.m., Jason Gunthorpe wrote:
> > On Thu, Sep 16, 2021 at 05:40:54PM -0600, Logan Gunthorpe wrote:
> >> Callers that expect PCI P2PDMA pages can now set FOLL_PCI_P2PDMA to
> >> allow obtaining P2PDMA pages. If a caller does not set this flag
> >> and tries to map P2PDMA pages it will fail.
> >>
> >> This is implemented by adding a flag and a check to get_dev_pagemap().
> > 
> > I would like to see the get_dev_pagemap() deleted from GUP in the
> > first place.
> > 
> > Why isn't this just a simple check of the page->pgmap type after
> > acquiring a valid page reference? See my prior note
> 
> It could be, but that will mean dereferencing the pgmap for every page
> to determine the type of page and then comparing with FOLL_PCI_P2PDMA.

It would be done under the pte devmap test and this is less expensive
than the xarray search.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
