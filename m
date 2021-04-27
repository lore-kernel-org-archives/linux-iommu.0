Return-Path: <SRS0=GIAn=JY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4125AC433B4
	for <iommu@archiver.kernel.org>; Tue, 27 Apr 2021 19:28:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0B9361153
	for <iommu@archiver.kernel.org>; Tue, 27 Apr 2021 19:28:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0B9361153
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A592A83D8F;
	Tue, 27 Apr 2021 19:28:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EFNi28xE496V; Tue, 27 Apr 2021 19:28:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 99DED83D8C;
	Tue, 27 Apr 2021 19:28:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 640F3C0023;
	Tue, 27 Apr 2021 19:28:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E9F6C001A
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 19:28:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 293A1605DA
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 19:28:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ziepe.ca
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RUWwlVYwVECZ for <iommu@lists.linux-foundation.org>;
 Tue, 27 Apr 2021 19:28:41 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4EB8E605AF
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 19:28:41 +0000 (UTC)
Received: by mail-io1-xd2e.google.com with SMTP id v123so9670749ioe.10
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 12:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=DYcG+6Y4wulABOgwFwb1rxhdjQCINJ8GzZ3NxIxoP+4=;
 b=d1W1Aqvy0WDQgLHfXd6KVJkwoZwwpQfM3q3r5Boe9IMOb1Ks78SGk5p7ivRqzqy7BA
 gSU82n1JTpmb9daPjD5Irwhh8B8KTsNa9G4UpI9HD9aQfAMHpjP5UnmkWK6P30EssgPr
 qJxOA1NOdKo9K00d+kPRugkI7hzjIwbR6beAJw47nAWJhCVUyqPECz8ykdHt9yMZoQDf
 ogK6wY42jY6a/WZjKm0cnc2nvFx8F0yTrlY8RDJ+yRE9tNcvkLbJZ6C9WY9hob38kSQH
 OkOHfjfKQxlSWxbGIOGwjc5CcjsPzLBsDhznnnN1CnbOGBl9wX3p6dSPxI4qPEJLDYmB
 oq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=DYcG+6Y4wulABOgwFwb1rxhdjQCINJ8GzZ3NxIxoP+4=;
 b=MK4eNRLp+OUKF4+6LFNTe9ea/3KNryFE0SHZasN8+4S4VRy7WL/pInAHcDpcpbGEcj
 b8MLYZNozj/JB0DgSZNgfW7cxkRItlgjQ7Jbud4elX8Qm9EcXV0rsSk1PmLouw4VnHCr
 YTd3yKrvlbOmThm7VEuqw1FTPs/qr19+xt5V69FvOYak0YU3dTUZZ8D73dsc8X/viiUF
 AkGMOVMGFCxbLx6FUG71MjjizD82iiOI9YhNZBjp92MeQlsMy3tQpsGfEMEY2MoSfMXd
 zgxi4YCpgSo4fpsH8F7IBvnOXcaU5MrSPiBpqaDV7fqFoN8Wtag6TMy6HZAsQ1tfEKPs
 Wgug==
X-Gm-Message-State: AOAM532svcd66VjQrTVk4bVooiVE9tCrlGTbAOrDukehHyS3Wz7CGeth
 yJ6xva7Ioqze69rIytjVqVcVsg==
X-Google-Smtp-Source: ABdhPJwQwDDELwuTsaB4Sx8qcFBGHVeacGfq4J3MKE4o16MniIdqkGIoAquFFRl+dmeSeAYT8wzXKQ==
X-Received: by 2002:a6b:3bcd:: with SMTP id
 i196mr20979811ioa.121.1619551720518; 
 Tue, 27 Apr 2021 12:28:40 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
 by smtp.gmail.com with ESMTPSA id d16sm1715512ils.48.2021.04.27.12.28.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Apr 2021 12:28:39 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1lbTNu-00DgsM-R2; Tue, 27 Apr 2021 16:28:38 -0300
Date: Tue, 27 Apr 2021 16:28:38 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH 00/16] Add new DMA mapping operation for P2PDMA
Message-ID: <20210427192838.GP2047089@ziepe.ca>
References: <20210408170123.8788-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210408170123.8788-1-logang@deltatee.com>
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

On Thu, Apr 08, 2021 at 11:01:07AM -0600, Logan Gunthorpe wrote:
> Hi,
> 
> This patchset continues my work to to add P2PDMA support to the common
> dma map operations. This allows for creating SGLs that have both P2PDMA
> and regular pages which is a necessary step to allowing P2PDMA pages in
> userspace.
> 
> The earlier RFC[1] generated a lot of great feedback and I heard no show
> stopping objections. Thus, I've incorporated all the feedback and have
> decided to post this as a proper patch series with hopes of eventually
> getting it in mainline.
>
> I'm happy to do a few more passes if anyone has any further feedback
> or better ideas.

For the user of the DMA API the idea seems reasonable enough, the next
steps to integrate with pin_user_pages() seem fairly straightfoward
too

Was there no feedback on this at all?

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
