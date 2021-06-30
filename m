Return-Path: <SRS0=eogA=LY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D77C11F65
	for <iommu@archiver.kernel.org>; Wed, 30 Jun 2021 04:08:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71EE761D2B
	for <iommu@archiver.kernel.org>; Wed, 30 Jun 2021 04:08:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71EE761D2B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 395C0605E8;
	Wed, 30 Jun 2021 04:08:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YFCvcFtCQPG6; Wed, 30 Jun 2021 04:07:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1B73160594;
	Wed, 30 Jun 2021 04:07:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EBF39C001A;
	Wed, 30 Jun 2021 04:07:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 909A0C000E
 for <iommu@lists.linux-foundation.org>; Wed, 30 Jun 2021 04:07:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 70B6540608
 for <iommu@lists.linux-foundation.org>; Wed, 30 Jun 2021 04:07:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Zc7j_Ux7XqU8 for <iommu@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 04:07:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AE5F040605
 for <iommu@lists.linux-foundation.org>; Wed, 30 Jun 2021 04:07:53 +0000 (UTC)
Received: by mail-io1-xd2d.google.com with SMTP id b7so1482260ioq.12
 for <iommu@lists.linux-foundation.org>; Tue, 29 Jun 2021 21:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CihQJs+V2hzOjNrHEUutiYZNJeDLEZFfM+aC788Ls8Y=;
 b=hJf8jbdNdk8vtynuUvXJ5WOrCidPZV0ovCwVJiPYwT8VAp2CGtXqIImAWtyYArBKqS
 VGpM2s2BD09PWsOu5wPYUcfeExYjrVlwTEbifmekSaMQetnUaCjGZMDQp+yMXtFfbK8A
 ID3GlMsw+AcrU4wP0WdIEOG6w/0A4ocVeY0l4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CihQJs+V2hzOjNrHEUutiYZNJeDLEZFfM+aC788Ls8Y=;
 b=OLgkVLv9XFSq6E8t19gdmGVFddl3H5LnL6Ne9WXGD6SDnnBuyaltH5UlDrrjNJP8G/
 Jzyx5kSvch6IlJMH5dNDe18pLqi1bYGs931F1zx+fUbXUGWAspaUS8YhinuDzWxUi4zX
 zVJa0fIDjEMaguUsany5SGD+xSWG8eWh9mPwzG/NjRaJmflczsjRjlwMEi3v2+orkIMG
 Oj0MvnefItcld1lyKna3FxpfCRwdKwhUtV8MCJGRDyXgEfhZoF2vOfV/ZgRrshD1x1ok
 e1FIcR0x2wBJIHKmrl0moUccB7heCIa9KrVjWuB9ajIP30MmDgSUCtZjSQ1vNWFaSyo6
 Srow==
X-Gm-Message-State: AOAM530OXvI8Sn79QNdL1Uy/jAJhuCHn+L/DFDHbBwoqsTQyEaYEXUl4
 FU/pvgvwPpLtbzEcFQMaQVz9cREvS+dgjA==
X-Google-Smtp-Source: ABdhPJwF7umjN9iFG9MDa3q+QnZ77477SFOae9abQsiaPCzJJbRLwBN+nIdjSii6AOyFh7tB+NFS7w==
X-Received: by 2002:a05:6638:ecf:: with SMTP id
 q15mr7179897jas.18.1625026072352; 
 Tue, 29 Jun 2021 21:07:52 -0700 (PDT)
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com.
 [209.85.166.172])
 by smtp.gmail.com with ESMTPSA id r6sm2491401ila.88.2021.06.29.21.07.51
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Jun 2021 21:07:51 -0700 (PDT)
Received: by mail-il1-f172.google.com with SMTP id 3so1574375ilj.3
 for <iommu@lists.linux-foundation.org>; Tue, 29 Jun 2021 21:07:51 -0700 (PDT)
X-Received: by 2002:a05:6e02:1d10:: with SMTP id
 i16mr5467198ila.5.1625026071072; 
 Tue, 29 Jun 2021 21:07:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210629121625.3633999-1-tientzu@chromium.org>
 <7f544c68-721c-bbcc-3614-cbadce7261a9@arm.com>
In-Reply-To: <7f544c68-721c-bbcc-3614-cbadce7261a9@arm.com>
From: Claire Chang <tientzu@chromium.org>
Date: Wed, 30 Jun 2021 12:07:40 +0800
X-Gmail-Original-Message-ID: <CALiNf2-WcZo=fyaZqw2axyE-KTmGT0HRqvKiN0NZ5=VKmvA0bQ@mail.gmail.com>
Message-ID: <CALiNf2-WcZo=fyaZqw2axyE-KTmGT0HRqvKiN0NZ5=VKmvA0bQ@mail.gmail.com>
Subject: Re: [PATCH v2] swiotlb: fix implicit debugfs_create_dir declaration
To: Robin Murphy <robin.murphy@arm.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 kernel test robot <lkp@intel.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 lkml <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Nicolas Boichat <drinkcat@chromium.org>, Will Deacon <will@kernel.org>,
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

On Tue, Jun 29, 2021 at 8:52 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-06-29 13:16, Claire Chang wrote:
> > Remove the ifdef to fix implicit function declaration for other pools.
> >
> > Fixes: 1d9f94400a7a ("swiotlb: Refactor swiotlb_create_debugfs")
>
> There doesn't appear to be a problem with that commit - AFAICS it's
> 461021875c50 ("swiotlb: Add restricted DMA pool initialization") which
> introduces a reference to debugfs_create_dir() outside the existing
> #ifdef guards.
>
> FWIW (assuming it's the real problem) I'd be inclined to factor out the
> debugfs bits from rmem_swiotlb_device_init() into a separate
> rmem_swiotlb_debugfs_init() (or similar) function which can live
> alongside the others under the #ifdef and be stubbed out in an #else case.

v3 here: https://lore.kernel.org/patchwork/patch/1452807/

>
> Robin.
>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Claire Chang <tientzu@chromium.org>
> > ---
> >   kernel/dma/swiotlb.c | 5 -----
> >   1 file changed, 5 deletions(-)
> >
> > diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> > index 0ffbaae9fba2..8ae0bef392c3 100644
> > --- a/kernel/dma/swiotlb.c
> > +++ b/kernel/dma/swiotlb.c
> > @@ -36,9 +36,7 @@
> >   #include <linux/scatterlist.h>
> >   #include <linux/mem_encrypt.h>
> >   #include <linux/set_memory.h>
> > -#ifdef CONFIG_DEBUG_FS
> >   #include <linux/debugfs.h>
> > -#endif
> >   #ifdef CONFIG_DMA_RESTRICTED_POOL
> >   #include <linux/io.h>
> >   #include <linux/of.h>
> > @@ -686,7 +684,6 @@ bool is_swiotlb_active(struct device *dev)
> >   }
> >   EXPORT_SYMBOL_GPL(is_swiotlb_active);
> >
> > -#ifdef CONFIG_DEBUG_FS
> >   static struct dentry *debugfs_dir;
> >
> >   static void swiotlb_create_debugfs_files(struct io_tlb_mem *mem)
> > @@ -709,8 +706,6 @@ static int __init swiotlb_create_default_debugfs(void)
> >
> >   late_initcall(swiotlb_create_default_debugfs);
> >
> > -#endif
> > -
> >   #ifdef CONFIG_DMA_RESTRICTED_POOL
> >   struct page *swiotlb_alloc(struct device *dev, size_t size)
> >   {
> >
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
