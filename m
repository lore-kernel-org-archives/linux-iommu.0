Return-Path: <SRS0=GIAn=JY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E7AC43462
	for <iommu@archiver.kernel.org>; Tue, 27 Apr 2021 19:43:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F2D5611F2
	for <iommu@archiver.kernel.org>; Tue, 27 Apr 2021 19:43:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F2D5611F2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0EEDB83D40;
	Tue, 27 Apr 2021 19:43:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5fd4oG_g8tw8; Tue, 27 Apr 2021 19:43:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 132E0839E7;
	Tue, 27 Apr 2021 19:43:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D7775C0022;
	Tue, 27 Apr 2021 19:43:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 91271C001C
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 19:43:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 71BD8401FC
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 19:43:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ziepe.ca
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wBy-p3SqwKQl for <iommu@lists.linux-foundation.org>;
 Tue, 27 Apr 2021 19:43:40 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 28DEC403DD
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 19:43:40 +0000 (UTC)
Received: by mail-qv1-xf35.google.com with SMTP id i11so24107267qvu.10
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 12:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=pMOFBLR9bPrFoZFV8TQo6qdI8xIDUT5QowoTJPAfwoI=;
 b=M20T+1aMae4u0P7fbin4a8R02TMD5t96H2aiOMf8qw2rTRAo2RugFe0ku6l9VPeevP
 xZtgBQRLaSsu9aYFKNdNDSiFe3aolwh10xjABQqThOUIndi0+s4d+Eo1XLPCXC3nfxUm
 lD1alvOMjEL0+ef6cYE7iSz2VLoq5w2e7VmYnhskgoJag9ZejVAXw548Sw3tJzTwQ1LK
 Hq28R0ucjVcFeEwJijDgtLouLoL1kPblKx+vhiQSapRdIiXAHGIAof9xt+quTVbA5Swo
 WJ9Cx6H5u7fywz1Osz6ow6XWlpeS1lNkpzj+0hZhr2dKqs99inl2pJxQ1Z2SVZi0WDJl
 pNzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=pMOFBLR9bPrFoZFV8TQo6qdI8xIDUT5QowoTJPAfwoI=;
 b=hEvvyiE54MUv1A1W5iHn43xrtE0a57DMXuxr9gNo39JWCAUjbWbLS4zyw6r2BYfGjr
 GrvF7bIcXoT5O/LShrQQtHj8lz0H4wfNjjEwK64H+d8e80ubbCyLNR6vcSGRKXB8fCNy
 did8m14Bjrac4f4C7/1LxJxrAv3W71CcrilUXZqqtAS5umwRko0GIWJqu151CziYsoVW
 95A4QwDfXl+a+0CvN1LoEKMzNB8cab4mTagNigZsxj3ydd20IiSOSi1h+8Tqcpza8Jj5
 Tx9FdALmm9yPMMn+JacVY+Tvr4eG/34XGIQ6xHsxFXde7cBa01F+3Ypcgbjj/mzS7IPC
 apdA==
X-Gm-Message-State: AOAM531brWAaP/BY6kk9Yf7ySaHlbahX0YT6GExibtKRw8jarlaqdO/d
 z8hzqkGH6PzpWxx/OGrSm5+pAw==
X-Google-Smtp-Source: ABdhPJzaHrq9X7iYnbBeG48woUZiUTHE+b/d9aEc9zMuai3hrX463cNK4Akxfstc2Wbz1Cy4s9UnAQ==
X-Received: by 2002:a0c:e8c4:: with SMTP id m4mr2551153qvo.21.1619552619024;
 Tue, 27 Apr 2021 12:43:39 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
 by smtp.gmail.com with ESMTPSA id y26sm688104qtf.66.2021.04.27.12.43.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Apr 2021 12:43:38 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1lbTcP-00Dh5j-HM; Tue, 27 Apr 2021 16:43:37 -0300
Date: Tue, 27 Apr 2021 16:43:37 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH 11/16] iommu/dma: Support PCI P2PDMA pages in dma-iommu
 map_sg
Message-ID: <20210427194337.GT2047089@ziepe.ca>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-12-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210408170123.8788-12-logang@deltatee.com>
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

On Thu, Apr 08, 2021 at 11:01:18AM -0600, Logan Gunthorpe wrote:
> When a PCI P2PDMA page is seen, set the IOVA length of the segment
> to zero so that it is not mapped into the IOVA. Then, in finalise_sg(),
> apply the appropriate bus address to the segment. The IOVA is not
> created if the scatterlist only consists of P2PDMA pages.

I expect P2P to work with systems that use ATS, so we'd want to see
those systems have the IOMMU programmed with the bus address.

Is it OK like this because the other logic prohibits all PCI cases
that would lean on the IOMMU, like ATS, hairpinning through the root
port, or transiting the root complex?

If yes, the code deserves a big comment explaining this is incomplete,
and I'd want to know we can finish this to include ATS at least based
on this series.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
