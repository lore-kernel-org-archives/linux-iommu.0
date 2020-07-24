Return-Path: <SRS0=ASoY=BD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBF7C433E4
	for <iommu@archiver.kernel.org>; Fri, 24 Jul 2020 16:20:05 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61030206EB
	for <iommu@archiver.kernel.org>; Fri, 24 Jul 2020 16:20:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xY5LsiQ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61030206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 075A088B57;
	Fri, 24 Jul 2020 16:20:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CcNh5-r02xwX; Fri, 24 Jul 2020 16:20:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4603488A81;
	Fri, 24 Jul 2020 16:20:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 27BFDC004E;
	Fri, 24 Jul 2020 16:20:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8DCA4C004C
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jul 2020 16:20:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 0C99087122
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jul 2020 16:19:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JGC4-mmtCYsA for <iommu@lists.linux-foundation.org>;
 Fri, 24 Jul 2020 16:19:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id AA1BE87106
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jul 2020 16:19:55 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id r4so5866416wrx.9
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jul 2020 09:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cn6mIcIhNrNjGLZLY/eqMcDuxtyycO8StVpDq6XMfg4=;
 b=xY5LsiQ9yZqTUPrlACwii7Rvx/e7Y7RsnLk7diTi9eQSzBurj4ppdVmON5hT0zTWZ+
 AxTwAD/StnDH/EtXLJcuULhgmramutlTRx5mwyKbC3fX2dR0HoxaSDsa8G0qnBU7WDSQ
 rWs6HIssfGwS5/ZfWSjyr24w65ZDHGaDg0g2zNlVnXSCQYj6cEErFBXhkzoKruiy2nJw
 p4O5cv87RSmIjkE7Cy1ypz70KFWaN1DDTtHGHLxpkGVUBn6DD3R006MpeDijBhPXWozi
 8wqpTCs4mr2Pw/eqpQI7HpWEmOxo4+oHEHh+uxeO1mL8/AaT3ybhbMinOal7LBWuVSGw
 G5eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cn6mIcIhNrNjGLZLY/eqMcDuxtyycO8StVpDq6XMfg4=;
 b=he5D2rul8cH9bdLbu10GEZBhBmI+wCNdUGt+9AFUWcKFG7Gf/CH87IQjSsKLR2qZOr
 qpZvLPbmoNCtNRHGJRfuZMwcinu2CCHvfyuKWXmMmaYdjv0RJ5VKuDr8tQEEC3ubDuCK
 06Sxs0Q+eGtUWcyO+mnai4AgQJ+11Ffw3xJ6iwbbR94AvjAimkFaaGER0z7AU1Pi1QGe
 yfYwi9HKg3HSbESCEF5fyOYX5c4Mev3JVSRA0k8TWAdMpgdJfpBKp7jqSbTEm5Qir5nz
 K5f6t6n1QL0P3uxBk6THkdBQ0HSt7q5d8ZrX8NFLnV6YMKziAYm8UBhwxYx8hYMYmxHh
 7avQ==
X-Gm-Message-State: AOAM530m3FiRLVrkZnDScU/IUwoI0LJXdcax20W1TiTqXFOJMwEjSGVj
 5d2kTtLKfb77hUckXTuzQn3gV0Zl0nouXOSkhGq8RA==
X-Google-Smtp-Source: ABdhPJyafoSdic4aXYtLTcXiuz6OGiyCfozJU0MCkFavQrWqNmc9MZxK44TRvda3nnDDgYO9d5zO8BxLY0SDE86xF3k=
X-Received: by 2002:adf:d84f:: with SMTP id k15mr8930588wrl.176.1595607594046; 
 Fri, 24 Jul 2020 09:19:54 -0700 (PDT)
MIME-Version: 1.0
References: <550b30a86c0785049d24c945e2c6628d491cee3a.camel@suse.de>
 <CAMi1Hd2V2pJjP=USS4r-Z3vK-aq7_aBy-jcVNk1GvbdEQAuzWg@mail.gmail.com>
 <011994f8a717a00dcd9ed7682a1ddeb421c2c43f.camel@suse.de>
 <CAMi1Hd0=ZsGhTkSy221EP9Vb3GMOcS0UMczX2u5X9qK37_ea1A@mail.gmail.com>
 <01831596e4a2a6c9c066138b23bd30435f8e5569.camel@suse.de>
 <CAMi1Hd3C6kh5E49EgytBAQ_2AE_jvnp+eSNsxBYaux+exSvdbg@mail.gmail.com>
 <6db722947546221ed99d3f473f78e1a6de65d7d6.camel@suse.de>
 <CAMi1Hd0Xz6kOJFpA5PEpi6RDDGOcz0RmQ7tTOkuXq4QneOO_vQ@mail.gmail.com>
 <0dc1e922bf87fa73790e7471b3974528dd261486.camel@suse.de>
 <CAMi1Hd3O2HHBsnt=sac7FdcW0-3=4S3g_F9f__2h5gTsudfirA@mail.gmail.com>
 <20200724134114.GA3152@lst.de>
In-Reply-To: <20200724134114.GA3152@lst.de>
From: Amit Pundir <amit.pundir@linaro.org>
Date: Fri, 24 Jul 2020 21:49:17 +0530
Message-ID: <CAMi1Hd2tmf0J78dXK_y_onJkPW=JSf6Ki5P+j1iYfwu3wb0V4w@mail.gmail.com>
Subject: Re: [PATCH] dma-pool: Do not allocate pool memory from CMA
To: Christoph Hellwig <hch@lst.de>
Cc: lkml <linux-kernel@vger.kernel.org>, jeremy.linton@arm.com,
 iommu@lists.linux-foundation.org, John Stultz <john.stultz@linaro.org>,
 linux-rpi-kernel@lists.infradead.org, David Rientjes <rientjes@google.com>,
 Robin Murphy <robin.murphy@arm.com>, Sumit Semwal <sumit.semwal@linaro.org>
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

On Fri, 24 Jul 2020 at 19:11, Christoph Hellwig <hch@lst.de> wrote:
>
> Yes, the iommu is an interesting case, and the current code is
> wrong for that.  Can you try the patch below?  It contains a modified
> version of Nicolas' patch to try CMA again for the expansion and a new
> (for now hackish) way to not apply the addressability check for dma-iommu
> allocations.

Thank you. The below patch worked on today's linux/master (f37e99aca03f).

Regards,
Amit Pundir

>
> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> index 6bc74a2d51273e..ec5e525d2b9309 100644
> --- a/kernel/dma/pool.c
> +++ b/kernel/dma/pool.c
> @@ -3,7 +3,9 @@
>   * Copyright (C) 2012 ARM Ltd.
>   * Copyright (C) 2020 Google LLC
>   */
> +#include <linux/cma.h>
>  #include <linux/debugfs.h>
> +#include <linux/dma-contiguous.h>
>  #include <linux/dma-direct.h>
>  #include <linux/dma-noncoherent.h>
>  #include <linux/init.h>
> @@ -55,6 +57,31 @@ static void dma_atomic_pool_size_add(gfp_t gfp, size_t size)
>                 pool_size_kernel += size;
>  }
>
> +static bool cma_in_zone(gfp_t gfp)
> +{
> +       phys_addr_t end;
> +       unsigned long size;
> +       struct cma *cma;
> +
> +       cma = dev_get_cma_area(NULL);
> +       if (!cma)
> +               return false;
> +
> +       size = cma_get_size(cma);
> +       if (!size)
> +               return false;
> +       end = cma_get_base(cma) - memblock_start_of_DRAM() + size - 1;
> +
> +       /* CMA can't cross zone boundaries, see cma_activate_area() */
> +       if (IS_ENABLED(CONFIG_ZONE_DMA) && (gfp & GFP_DMA) &&
> +           end <= DMA_BIT_MASK(zone_dma_bits))
> +               return true;
> +       if (IS_ENABLED(CONFIG_ZONE_DMA32) && (gfp & GFP_DMA32) &&
> +           end <= DMA_BIT_MASK(32))
> +               return true;
> +       return true;
> +}
> +
>  static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
>                               gfp_t gfp)
>  {
> @@ -68,7 +95,11 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
>
>         do {
>                 pool_size = 1 << (PAGE_SHIFT + order);
> -               page = alloc_pages(gfp, order);
> +               if (cma_in_zone(gfp))
> +                       page = dma_alloc_from_contiguous(NULL, 1 << order,
> +                                                        order, false);
> +               if (!page)
> +                       page = alloc_pages(gfp, order);
>         } while (!page && order-- > 0);
>         if (!page)
>                 goto out;
> @@ -251,7 +282,11 @@ void *dma_alloc_from_pool(struct device *dev, size_t size,
>                         continue;
>
>                 phys = gen_pool_virt_to_phys(pool, val);
> -               if (dma_coherent_ok(dev, phys, size))
> +               /*
> +                * Only apply the addressability check for dma-direct.
> +                * This is a nasty hack and won't work e.g. for arm.
> +                */
> +               if (get_dma_ops(dev) || dma_coherent_ok(dev, phys, size))
>                         break;
>
>                 gen_pool_free(pool, val, size);
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
