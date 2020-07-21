Return-Path: <SRS0=qNYd=BA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B90C433EB
	for <iommu@archiver.kernel.org>; Tue, 21 Jul 2020 08:55:07 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0833620720
	for <iommu@archiver.kernel.org>; Tue, 21 Jul 2020 08:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iVSGtGXm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0833620720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C342D87657;
	Tue, 21 Jul 2020 08:55:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FkA8IqJgikdw; Tue, 21 Jul 2020 08:55:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1EDE88764C;
	Tue, 21 Jul 2020 08:55:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 01837C089F;
	Tue, 21 Jul 2020 08:55:06 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BAC43C016F
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jul 2020 08:55:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A11DC8959F
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jul 2020 08:55:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1QkBlrJen3W2 for <iommu@lists.linux-foundation.org>;
 Tue, 21 Jul 2020 08:55:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 8742489596
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jul 2020 08:55:03 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id f18so2059252wml.3
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jul 2020 01:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4CTmtnmdZY9YRQRw2JoAj2R7ehpvx1UOd5wk1nRyAk4=;
 b=iVSGtGXmRhf4JUrMrWhpMV7KvM5JVFkx1ir5uEYCIl+mRjDfai5NBGmIY/3/4BaItf
 Df+M31NVTb61rKYwAglK2FlqsnF9uu/UwTwJPcJ54QyiGsKOI/86OpmYU8b7F8nZH7pK
 DMbOFA+IG6PEPQpB2glBphC6o8gScfrV0fUW80SQMQLpnIsKw0Y3mjY2vHtGHDUp8LHv
 DNoDMpOxTEX4jhpvro/YTATL9uDv5QKzo+U3VDzaQ03G56MBHn9HXQ0JuFI3Rp1FCURN
 vVlFBV8qtc/eUMOaAiHTlicehnLniLpCP3Hw2JtdBRkQY2+h/tLlzXuFV92AY/GnIhfs
 WGXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4CTmtnmdZY9YRQRw2JoAj2R7ehpvx1UOd5wk1nRyAk4=;
 b=OSA61/Yu3AG3HaTvzakmJBXqQPLYPplsuRKhV6+FvhQCCpWBISUvWenbcicvES286J
 1ZsRbCi9kQxQcHXvE6X+7hcZxqGe1XSqZUhXgn4EqQb31AFGdzARY0eqvdXlJvcZQKj0
 Z9Fu7AhtWCSttGDr/cHTk/ufkpNgZjG79PF8HcJyzm9Kv/JSIs/gfwBInow2l8iFJeHZ
 tGapsySc4NSdz2D+uf6VVxdpzh4CJHoQLxpSIG1iqZ0/PKLiHIdKVt1wRwpG7mMXlJNb
 u2j5UkTGm4dYmOZtfRF1AGizPzDBKpMD++YDIQzgdZl1temVp59gKqjAXTH2mhZ3u1Nk
 CV9w==
X-Gm-Message-State: AOAM530K+tl1ztrUnr9k2Wxmf5zbkXx/Nov7a83ZLdALJuCSzawz91uA
 /ZDYzdZm4K2UnX7SbxWtYYOo3nkIU4ZMLzGuldx5sg==
X-Google-Smtp-Source: ABdhPJyZqBx+5DxqL/B9eY3DTkJe+mB4GoZ8A1ocvar0p111bDPlN6UUFB9G2wacmGPdJi21kuc6Feck5gRaFsWuNmk=
X-Received: by 2002:a1c:dd09:: with SMTP id u9mr3023317wmg.70.1595321701764;
 Tue, 21 Jul 2020 01:55:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200708164936.9340-1-nsaenzjulienne@suse.de>
 <CAMi1Hd35tRM=cnmzwX=SDgu-OoXi1Xj+twFkoULaVZBbTpe6sw@mail.gmail.com>
 <550b30a86c0785049d24c945e2c6628d491cee3a.camel@suse.de>
In-Reply-To: <550b30a86c0785049d24c945e2c6628d491cee3a.camel@suse.de>
From: Amit Pundir <amit.pundir@linaro.org>
Date: Tue, 21 Jul 2020 14:24:25 +0530
Message-ID: <CAMi1Hd2V2pJjP=USS4r-Z3vK-aq7_aBy-jcVNk1GvbdEQAuzWg@mail.gmail.com>
Subject: Re: [PATCH] dma-pool: Do not allocate pool memory from CMA
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: lkml <linux-kernel@vger.kernel.org>, jeremy.linton@arm.com,
 Sumit Semwal <sumit.semwal@linaro.org>, iommu@lists.linux-foundation.org,
 John Stultz <john.stultz@linaro.org>, linux-rpi-kernel@lists.infradead.org,
 David Rientjes <rientjes@google.com>, Robin Murphy <robin.murphy@arm.com>,
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

On Tue, 21 Jul 2020 at 14:09, Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> Hi Amit,
>
> On Tue, 2020-07-21 at 12:51 +0530, Amit Pundir wrote:
> > On Wed, 8 Jul 2020 at 22:43, Nicolas Saenz Julienne
> > <nsaenzjulienne@suse.de> wrote:
> > > There is no guarantee to CMA's placement, so allocating a zone
> > > specific
> > > atomic pool from CMA might return memory from a completely
> > > different
> > > memory zone. So stop using it.
> > >
> > > Fixes: c84dc6e68a1d ("dma-pool: add additional coherent pools to
> > > map to gfp mask")
> >
> > Hi Nicolas,
> >
> > I see a boot regression with this commit d9765e41d8e9 "dma-pool:
> > Do not allocate pool memory from CMA" on my Xiaomi Poco F1
> > (Qcom sdm845) phone running v5.8-rc6. I can't boot past the
> > bootloader splash screen with this patch.
> >
> > Phone boots fine if I revert this patch. I carry only one out of tree
> > dts patch https://lkml.org/lkml/2020/6/25/52. And since this is a
> > stock
> > phone, I don't have access to serial/dmesg logs until I boot to AOSP
> > (adb) shell.
> >
> > Any thoughts as to what might be going wrong here? I'd be happy to
> > help debug things. For what it's worth, I don't see this regression
> > on
> > other two sdm845 devices (db845c and Pixel 3) I tested on.
>
> Can you provide a boot log (even if without my patch) and the device-
> tree files? It'd help a lot figuring things out.

Thank you for the prompt reply Nicolas.

Here is the boot log with the reverted patch
https://pastebin.ubuntu.com/p/BrhPf83nKF/

Here is my phone's dts
https://github.com/pundiramit/linux/commit/2a394c199deeaf4c91e0e008e8fba2a72f494d8c

And here is my kernel tree just in case
https://github.com/pundiramit/linux/commits/beryllium-mainline

Regards,
Amit Pundir


>
> Regards,
> Nicolas
>
> > Regards,
> > Amit Pundir
> >
> > > Reported-by: Jeremy Linton <jeremy.linton@arm.com>
> > > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > > ---
> > >
> > > An more costly alternative would be adding an option to
> > > dma_alloc_from_contiguous() so it fails when the allocation doesn't
> > > fall
> > > in a specific zone.
> > >
> > >  kernel/dma/pool.c | 11 ++---------
> > >  1 file changed, 2 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> > > index 8cfa01243ed2..4bc1c46ae6ef 100644
> > > --- a/kernel/dma/pool.c
> > > +++ b/kernel/dma/pool.c
> > > @@ -6,7 +6,6 @@
> > >  #include <linux/debugfs.h>
> > >  #include <linux/dma-direct.h>
> > >  #include <linux/dma-noncoherent.h>
> > > -#include <linux/dma-contiguous.h>
> > >  #include <linux/init.h>
> > >  #include <linux/genalloc.h>
> > >  #include <linux/set_memory.h>
> > > @@ -69,12 +68,7 @@ static int atomic_pool_expand(struct gen_pool
> > > *pool, size_t pool_size,
> > >
> > >         do {
> > >                 pool_size = 1 << (PAGE_SHIFT + order);
> > > -
> > > -               if (dev_get_cma_area(NULL))
> > > -                       page = dma_alloc_from_contiguous(NULL, 1 <<
> > > order,
> > > -                                                        order,
> > > false);
> > > -               else
> > > -                       page = alloc_pages(gfp, order);
> > > +               page = alloc_pages(gfp, order);
> > >         } while (!page && order-- > 0);
> > >         if (!page)
> > >                 goto out;
> > > @@ -118,8 +112,7 @@ static int atomic_pool_expand(struct gen_pool
> > > *pool, size_t pool_size,
> > >         dma_common_free_remap(addr, pool_size);
> > >  #endif
> > >  free_page: __maybe_unused
> > > -       if (!dma_release_from_contiguous(NULL, page, 1 << order))
> > > -               __free_pages(page, order);
> > > +       __free_pages(page, order);
> > >  out:
> > >         return ret;
> > >  }
> > > --
> > > 2.27.0
> > >
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
