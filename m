Return-Path: <SRS0=4FG6=EM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ABEAC55178
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 19:53:47 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A96E92072E
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 19:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="FudZRGzA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A96E92072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 276B086CD7;
	Fri,  6 Nov 2020 19:53:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dc76lOGkPQAA; Fri,  6 Nov 2020 19:53:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8058886CD1;
	Fri,  6 Nov 2020 19:53:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 652C9C088B;
	Fri,  6 Nov 2020 19:53:45 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5971EC0889
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 19:53:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4342186CD2
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 19:53:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cjCtAWCRNrjI for <iommu@lists.linux-foundation.org>;
 Fri,  6 Nov 2020 19:53:43 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com
 [209.85.160.195])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 876D986CD1
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 19:53:43 +0000 (UTC)
Received: by mail-qt1-f195.google.com with SMTP id t5so1639870qtp.2
 for <iommu@lists.linux-foundation.org>; Fri, 06 Nov 2020 11:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=sU45ASLE3qTNEeDnzXy0mWmjw/B5hdl1YB3C1dRGzkI=;
 b=FudZRGzAxEFk9lGKJUSPzsyZKArhHRwyzmRlvf+GFC+ATQPjzcBbVOeDLLB7moiVUf
 ObxxpnS/zZJpTm82iWz+fyi9jGs/I9YeNae0ROJk7xm4ksGu3vErOwXPC3998pjQlR5p
 4czYVsKEbRHoddebJV0noju3HQZREanU58l+vhPFj17Ta8rGMwytFISX8XsKNrHR+BX8
 lRJNDwJeHT2t31rpqbAdGGp0+akczI7HoAc6Ksjc1BT3ksZah6pY+y3OqCayYTmpzL+D
 Vcc6mEGa7A07b9rAWqQo7QjWrLXkk8WsSTWPLKnX0XjNAe7EuqN+sDQBd5I1lutR9Gx3
 kmvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=sU45ASLE3qTNEeDnzXy0mWmjw/B5hdl1YB3C1dRGzkI=;
 b=e8+r/9lLtTkRAwu/ZK6A75dBpn9+8FpzbflZ/wQhj3xaOQWX4MlJUMW0Qc2WTSACSk
 BP1z4ob1kK1iof7a3+Lq37zsp6+mW13Tn5zka62sM+l8q+98egsj8ibkfO2g9hSem1nj
 SYd/PNC8r4zenttj6+tgJF4vueM8JM6vrbNFW5TCbZ0nQcFJln95smHUqb8FDz26v8P1
 DYdo7u0AboqeKuUjIQEh0uecS/N/5WGMJQVkVS3a+VeSLywC4jsxIR4tfXcf8dY4YdSv
 1gn6Ddzs6VNb7xGQc0nuZLOhOcpUggOYQtNmFO665ySkHE2I/wilvSNKOajTZiQ0pyMg
 lBYQ==
X-Gm-Message-State: AOAM530HP9X7efgeBQIBOG34CQTHxegv6CuUTY4pEEJUx2fg0DgOXS0H
 69v6wpzJQ2FHwja3vYgUoY6QWQ==
X-Google-Smtp-Source: ABdhPJwcMytaU5RLKIBqp2abyuS1iVFiLHOqHqGF/QD5vN1zrtKnu5OM6Laul9BgJOP5lCmGBjWjKA==
X-Received: by 2002:aed:32c7:: with SMTP id z65mr3146052qtd.266.1604692422443; 
 Fri, 06 Nov 2020 11:53:42 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [156.34.48.30])
 by smtp.gmail.com with ESMTPSA id r41sm1239041qtj.23.2020.11.06.11.53.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2020 11:53:41 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1kb7np-0011j7-5m; Fri, 06 Nov 2020 15:53:41 -0400
Date: Fri, 6 Nov 2020 15:53:41 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [RFC PATCH 14/15] PCI/P2PDMA: Introduce pci_mmap_p2pmem()
Message-ID: <20201106195341.GA244516@ziepe.ca>
References: <20201106170036.18713-1-logang@deltatee.com>
 <20201106170036.18713-15-logang@deltatee.com>
 <20201106172206.GS36674@ziepe.ca>
 <b1e8dfce-d583-bed8-d04d-b7265a54c99f@deltatee.com>
 <20201106174223.GU36674@ziepe.ca>
 <2c2d2815-165e-2ef9-60d6-3ace7ff3aaa5@deltatee.com>
 <20201106180922.GV36674@ziepe.ca>
 <09885400-36f8-bc1d-27f0-a8adcf6104d4@deltatee.com>
 <20201106193024.GW36674@ziepe.ca>
 <03032637-0826-da76-aec2-121902b1c166@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <03032637-0826-da76-aec2-121902b1c166@deltatee.com>
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

On Fri, Nov 06, 2020 at 12:44:59PM -0700, Logan Gunthorpe wrote:
> 
> 
> On 2020-11-06 12:30 p.m., Jason Gunthorpe wrote:
> >> I certainly can't make decisions for code that isn't currently
> >> upstream.
> > 
> > The rdma drivers are all upstream, what are you thinking about?
> 
> Really? I feel like you should know what I mean here...
> 
> I mean upstream code that actually uses the APIs that I'd have to
> introduce. I can't say here's an API feature that no code uses but the
> already upstream rdma driver might use eventually. It's fairly easy to
> send patches that make the necessary changes when someone adds a use of
> those changes inside the rdma code.

Sure, but that doesn't mean you have to actively design things to be
unusable beyond this narrow case. The RDMA drivers are all there, all
upstream, if this work is accepted then the changes to insert P2P
pages into their existing mmap flows is a reasonable usecase to
consider at this point when building core code APIs.

You shouldn't add dead code, but at least have a design in mind for
what it needs to look like and some allowance.

> >> Ultimately, if you aren't using the genpool you will have to implement
> >> your own mmap operation that somehow allocates the pages and your own
> >> page_free hook. 
> > 
> > Sure, the mlx5 driver already has a specialized alloctor for it's BAR
> > pages.
> 
> So it *might* make sense to carve out a common helper to setup a VMA for
> P2PDMA to do the vm_flags check and set VM_MIXEDMAP... but besides that,
> there's no code that would be common to the two cases.

I think the whole insertion of P2PDMA pages into a VMA should be
similar to io_remap_pfn() so all the VM flags, pgprot_decrypted and
other subtle details are all in one place. (also it needs a
pgprot_decrypted before doing vmf_insert, I just learned that this
month)

> >> I also don't expect this to be going upstream in the near term so don't
> >> get too excited about using it.
> > 
> > I don't know, it is actually not that horrible, the GUP and IOMMU
> > related changes are simpler than I expected
> 
> I think the deal breaker is the SGL hack and the fact that there are
> important IOMMU implementations that won't have support.

Yes, that is pretty hacky, maybe someone will have a better idea

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
