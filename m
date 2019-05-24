Return-Path: <SRS0=CTmu=TY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C85C46470
	for <iommu@archiver.kernel.org>; Fri, 24 May 2019 20:03:43 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDBC3217D7
	for <iommu@archiver.kernel.org>; Fri, 24 May 2019 20:03:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDBC3217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 5D5991157;
	Fri, 24 May 2019 20:03:42 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 3474A1151
	for <iommu@lists.linux-foundation.org>;
	Fri, 24 May 2019 20:03:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 93D0CF4
	for <iommu@lists.linux-foundation.org>;
	Fri, 24 May 2019 20:03:40 +0000 (UTC)
Received: from mail-ot1-f69.google.com ([209.85.210.69])
	by youngberry.canonical.com with esmtps
	(TLS1.0:RSA_AES_128_CBC_SHA1:16) (Exim 4.76)
	(envelope-from <dann.frazier@canonical.com>) id 1hUGPi-0007wj-8g
	for iommu@lists.linux-foundation.org; Fri, 24 May 2019 20:03:38 +0000
Received: by mail-ot1-f69.google.com with SMTP id a22so4985317otr.21
	for <iommu@lists.linux-foundation.org>;
	Fri, 24 May 2019 13:03:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=MdZgSrzvQrNvArhhMwV6uq98L6kGwXydzTCUTc3ed/4=;
	b=nxhHIl98oqklrA7YfJEoYWIjCR9d8VgaKrPTcmTTvalZVLxqfXJYY2hXUpu1avO9Xb
	Jblf7/US0lbnde5uhXgfDGljP4+uLr+9x26x86up9DhGpRhdmS/Yg2+mP/oJz8PYMTXM
	3n+mYlVphpBT5ZzPH6TS5Mkpn7ZBAJdPrCA/gd5yo6D3BVPod9DkuXPare4xcAne0igr
	z14Weg8Nf6tGVNggxj0cgfwGK12MZk6KxgiOu18oyMOoMlt/nxkxQhWKutLWQg+1zID2
	WZQs4Ty1PKHrHH1UnFZmQLxb2u59pYdK4GF2ZPXvCjb2tqGZbJZ8KocwY28rsrFJTZCT
	8qIg==
X-Gm-Message-State: APjAAAX762TP6PpYa0ukFZ1ECBPl56qoLjtJBxDb9+Vxf99xsP2DLTx8
	q1m+273jZ+anJvR8tAZHZ3woGv5jh1bvml45kcYh24ljBJ1Kp/m8woDue1MTyETy2HspX8lW8OV
	3g3Y3sxoA7klQig2Suz6aR5C7ppjcbV89of5u7aUjyXzWuK5dLErYq3h8eEmNPLY=
X-Received: by 2002:a05:6830:164d:: with SMTP id
	h13mr31758682otr.99.1558728217208; 
	Fri, 24 May 2019 13:03:37 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxoya9uYRsSIEv51UV91v8Z+LxDz8k4gGrzqqMySgCjbel8axNiXlhuqaT0Un+V+0ZUNeHLZgzLuTVB5rKzbzc=
X-Received: by 2002:a05:6830:164d:: with SMTP id
	h13mr31758663otr.99.1558728216929; 
	Fri, 24 May 2019 13:03:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190524040633.16854-1-nicoleotsuka@gmail.com>
In-Reply-To: <20190524040633.16854-1-nicoleotsuka@gmail.com>
From: dann frazier <dann.frazier@canonical.com>
Date: Fri, 24 May 2019 14:03:25 -0600
Message-ID: <CALdTtnu=WdYbqyq57EkB-=rsyz72SW-J8oyD7f6Xm-da2OgRgQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Optimize dma_*_from_contiguous calls
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: tony@atomide.com, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>, jcmvbkbc@gmail.com,
	Christoph Hellwig <hch@lst.de>, sfr@canb.auug.org.au,
	linux@armlinux.org.uk, treding@nvidia.com,
	linux-xtensa@linux-xtensa.org, keescook@chromium.org,
	akpm@linux-foundation.org,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	chris@zankel.net, wsa+renesas@sang-engineering.com,
	Robin Murphy <robin.murphy@arm.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	iamjoonsoo.kim@lge.com, dwmw2@infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Thu, May 23, 2019 at 10:08 PM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> [ Per discussion at v1, we decide to add two new functions and start
>   replacing callers one by one. For this series, it only touches the
>   dma-direct part. And instead of merging two PATCHes, I still keep
>   them separate so that we may easily revert PATCH-2 if anything bad
>   happens as last time -- PATCH-1 is supposed to be a safe cleanup. ]
>
> This series of patches try to optimize dma_*_from_contiguous calls:
> PATCH-1 abstracts two new functions and applies to dma-direct.c file.
> PATCH-2 saves single pages and reduce fragmentations from CMA area.
>
> Please check their commit messages for detail changelog.
>
> Nicolin Chen (2):
>   dma-contiguous: Abstract dma_{alloc,free}_contiguous()
>   dma-contiguous: Use fallback alloc_pages for single pages
>
>  include/linux/dma-contiguous.h | 11 +++++++
>  kernel/dma/contiguous.c        | 57 ++++++++++++++++++++++++++++++++++
>  kernel/dma/direct.c            | 24 +++-----------
>  3 files changed, 72 insertions(+), 20 deletions(-)

Thanks Nicolin. Tested on a HiSilicon D06 system.

Tested-by: dann frazier <dann.frazier@canonical.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
