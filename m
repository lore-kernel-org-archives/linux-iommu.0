Return-Path: <SRS0=GIAn=JY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECEBC433B4
	for <iommu@archiver.kernel.org>; Tue, 27 Apr 2021 20:49:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3F0861026
	for <iommu@archiver.kernel.org>; Tue, 27 Apr 2021 20:49:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3F0861026
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 89F424024E;
	Tue, 27 Apr 2021 20:49:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xE5B01sjMXl1; Tue, 27 Apr 2021 20:49:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 330DB40001;
	Tue, 27 Apr 2021 20:49:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 04290C001C;
	Tue, 27 Apr 2021 20:49:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7326EC0001
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 20:49:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 584FF60619
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 20:49:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UqDb8O4as4A5 for <iommu@lists.linux-foundation.org>;
 Tue, 27 Apr 2021 20:49:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2CA37605FD
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 20:49:05 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id e7so71491700edu.10
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 13:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GGoNFfJfVqo1Dt2wA+3xepQEKzGpUM+1CEyd/kxn9I4=;
 b=qEfkSh7MGE8PVxlqCWGjjSgsiEnsnVBnvrjRNNxqQEj5HU0k4aWay+siPtJdTOW5Xf
 zVOpXzCXY0HakOzD/zAOFn8Rvsn7R9MMypGaIbyqQ5mvyZd62oAMQzRju3r4ZZ6Dbh4Z
 PGwXTw7U7ke5bt4PusVhU/FjOe6PO8GyPwyQEOdOvEKEQO2whSN6EREZEHU4BumJ0tUN
 wYRqkBp8E0mktosAXmG+bLKjKBN+4yGMkELK1CaFKSqtKceOXNV5kbTOZ4Y9znDBNz7U
 OaKb8R39/BDxfS854M5MpP4bM8rl5sKWIpgUHtqb2i2Vtr8Gvv6JoSyU7i78Aj09c75j
 QnXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GGoNFfJfVqo1Dt2wA+3xepQEKzGpUM+1CEyd/kxn9I4=;
 b=Hs/oWPMnq0h243nzw4e3OEq4BVUJEzag2O4clgQ9Sjt+uvM6X/1SH4iY/6aiTvEslt
 8HH0crDvimxeOCG+4s39JXzucmzCLOK339xJPqu1HMuyCfCVLzsBElkZgfGv1xLKKuEG
 XswBZkdi1e+WQY4hEWQOampX4/cVtXcIXg5NV3WIkIIaYy+78iXMNx51H+eofxtV4ph+
 K4mPimc5buIRHk7MMJMxWg3fWWT1UaUXGfBbw7IEU5DVQj8QhPg0ztqSq4J+WJDQvvE2
 S4zxN1972QDEStrfT6eCQ4hI/qzikP01MEH035XLL3D4Dr1mowWcO2x3OsPpKWir/Gqv
 Xn/A==
X-Gm-Message-State: AOAM531144SVXf140C6i+58Lx9kIyd2IxrFIztOQHxYM/jZ51NB0z9NM
 tyWuxND/Wn1FkVlUAiRh1RWFy1gTEwkY63dxsYbA2w==
X-Google-Smtp-Source: ABdhPJyFMNunA2bOW/HTfw7I2Fxc07FXNBNlKOc55ZJx0surGmu20mPs7uTrsxToUeLXW66T1s7Gq8IAg4lX/ItiTU4=
X-Received: by 2002:aa7:cd52:: with SMTP id v18mr6553464edw.97.1619556543314; 
 Tue, 27 Apr 2021 13:49:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210427192838.GP2047089@ziepe.ca>
 <52f14602-94bc-fa98-0b97-5f4084d808a0@nvidia.com>
In-Reply-To: <52f14602-94bc-fa98-0b97-5f4084d808a0@nvidia.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 27 Apr 2021 13:48:58 -0700
Message-ID: <CAPcyv4h-YVLHTCnXhTy5DVbhXndWZnhcKerDdS=+wDjWzZc4Fg@mail.gmail.com>
Subject: Re: [PATCH 00/16] Add new DMA mapping operation for P2PDMA
To: John Hubbard <jhubbard@nvidia.com>
Cc: linux-pci@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-mm@kvack.org, Jason Ekstrand <jason@jlekstrand.net>,
 Ira Weiny <ira.weiny@intel.com>, Christoph Hellwig <hch@lst.de>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Bjorn Helgaas <helgaas@kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 linux-block@vger.kernel.org, Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Logan Gunthorpe <logang@deltatee.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

On Tue, Apr 27, 2021 at 1:22 PM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 4/27/21 12:28 PM, Jason Gunthorpe wrote:
> > On Thu, Apr 08, 2021 at 11:01:07AM -0600, Logan Gunthorpe wrote:
> >> Hi,
> >>
> >> This patchset continues my work to to add P2PDMA support to the common
> >> dma map operations. This allows for creating SGLs that have both P2PDMA
> >> and regular pages which is a necessary step to allowing P2PDMA pages in
> >> userspace.
> >>
> >> The earlier RFC[1] generated a lot of great feedback and I heard no show
> >> stopping objections. Thus, I've incorporated all the feedback and have
> >> decided to post this as a proper patch series with hopes of eventually
> >> getting it in mainline.
> >>
> >> I'm happy to do a few more passes if anyone has any further feedback
> >> or better ideas.
> >
> > For the user of the DMA API the idea seems reasonable enough, the next
> > steps to integrate with pin_user_pages() seem fairly straightfoward
> > too
> >
> > Was there no feedback on this at all?
> >
>
> oops, I meant to review this a lot sooner, because this whole p2pdma thing is
> actually very interesting and important...somehow it slipped but I'll take
> a look now.

Still in my queue as well behind Joao's memmap consolidation series,
and a recent copy_mc_to_iter() fix series from Al.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
