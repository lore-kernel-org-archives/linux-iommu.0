Return-Path: <SRS0=GIAn=JY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1729BC433B4
	for <iommu@archiver.kernel.org>; Tue, 27 Apr 2021 19:32:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A21A6613FE
	for <iommu@archiver.kernel.org>; Tue, 27 Apr 2021 19:32:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A21A6613FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5B72483D0F;
	Tue, 27 Apr 2021 19:32:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k6LQF8o9M29m; Tue, 27 Apr 2021 19:32:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 38AB183D03;
	Tue, 27 Apr 2021 19:32:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0AF12C0023;
	Tue, 27 Apr 2021 19:32:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D9394C001A
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 19:32:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B0A4C40620
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 19:32:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ziepe.ca
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kOSrsV89jtHT for <iommu@lists.linux-foundation.org>;
 Tue, 27 Apr 2021 19:32:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 01D1140611
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 19:31:59 +0000 (UTC)
Received: by mail-io1-xd2e.google.com with SMTP id k25so17726543iob.6
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 12:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Z2dfVSyAhAt8vgpBqMWbMDHuRDstq7cheYx2I0gCKqA=;
 b=f+N9LA0t4CUwDpMHIjT1MaiOY0YP0yEI1fdCq6n/9G2sApcPu0kfC7g65PrZSCas0q
 et2NNQvtx3ytlLSajvn/g9dwQLy9IwqF1tmAC4Z2Wbb5I+Ch5gtBC1EMrWz4jvcK7cRt
 BzVK1SMsB3tJk0fk7jkLyb2kxQrjE4ZWpPcEIZ7o4pMgr6mhJqYb+dQUMgERAwDuQnuT
 HZjT+3IRZb6PI3RPSgOlfb2kyWKwrBOn3yf7eoc9FCkyAhJ/Wgl0HqJKfJ1IUrN5ptMx
 F66dcUTstJRLGIfvFqeC68gHCYIb4UfUh4NvcMqsFPQso8Hhnq5J0oEUDdR/Ozo03mHZ
 ak0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Z2dfVSyAhAt8vgpBqMWbMDHuRDstq7cheYx2I0gCKqA=;
 b=E0oJijY16yV+XHaHtRs/GlM7j32frvCXw5AiTxP8RmnfbJjDjFTI71YDZ77gN+uLfC
 IdQUiZRjghD/mbLDrgnbiRbWNa7hqV75DiM5/jorxMa8XInUJsuk37I0rd129pk1mHXE
 +xcAB9A6x/1Q7UkaVyXpfBO33FCBFjz5XmJ5ehJK5rr5KrdMcBqm9SdZKrgK2H6Hs5lv
 mJ0GsgfK1QwU++slwNNf7J821Qz/GZ0ru2qKctpAskz6nC/zMLqhP8JY8sK+GJ6fLeyh
 y6hDUIZ7oyntm1DAaZh8Q7C0bMLJpjQ9BZLM2Vil96dnXC46zgYKO4MRjxoKG7V+MDow
 /10Q==
X-Gm-Message-State: AOAM532mjkT9foJ/Geq9CbH0fbp7euGLuJrlVT0keGi+2wAxP2wetH7X
 7NXCHwUqZcsUdk+6NViMtg48VQ==
X-Google-Smtp-Source: ABdhPJz1PrEuptJElb3400TY97NuVzdikMTMhxSGmMRmyGUliOenKdPiL7SsLe1HAEp58UA3cwiqXQ==
X-Received: by 2002:a5d:84c5:: with SMTP id z5mr20535269ior.33.1619551919040; 
 Tue, 27 Apr 2021 12:31:59 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
 by smtp.gmail.com with ESMTPSA id d8sm340022iow.25.2021.04.27.12.31.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Apr 2021 12:31:58 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1lbTR7-00Dgv4-Ig; Tue, 27 Apr 2021 16:31:57 -0300
Date: Tue, 27 Apr 2021 16:31:57 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH 05/16] dma-mapping: Introduce dma_map_sg_p2pdma()
Message-ID: <20210427193157.GQ2047089@ziepe.ca>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-6-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210408170123.8788-6-logang@deltatee.com>
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

On Thu, Apr 08, 2021 at 11:01:12AM -0600, Logan Gunthorpe wrote:
> +/*
> + * dma_maps_sg_attrs returns 0 on error and > 0 on success.
> + * It should never return a value < 0.
> + */

Also it is weird a function that can't return 0 is returning an int type

> +int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int nents,
> +		enum dma_data_direction dir, unsigned long attrs)
> +{
> +	int ents;
> +
> +	ents = __dma_map_sg_attrs(dev, sg, nents, dir, attrs);
>  	BUG_ON(ents < 0);

if (WARN_ON(ents < 0))
     return 0;

instead of bug on?

Also, I see only 8 users of this function. How about just fix them all
to support negative returns and use this as the p2p API instead of
adding new API?

Add the opposite logic flag, 'DMA_ATTRS_NO_ERROR' and pass it through
the other api entry callers that can't handle it?

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
