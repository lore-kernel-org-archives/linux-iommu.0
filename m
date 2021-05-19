Return-Path: <SRS0=NBt+=KO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68CC7C433ED
	for <iommu@archiver.kernel.org>; Wed, 19 May 2021 06:58:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D4EE61364
	for <iommu@archiver.kernel.org>; Wed, 19 May 2021 06:58:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D4EE61364
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CEBB66066E;
	Wed, 19 May 2021 06:58:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hAHlHJmbz_u3; Wed, 19 May 2021 06:58:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7D71960650;
	Wed, 19 May 2021 06:58:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 552DFC000D;
	Wed, 19 May 2021 06:58:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D1457C0001
 for <iommu@lists.linux-foundation.org>; Wed, 19 May 2021 03:56:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C5AE140E6C
 for <iommu@lists.linux-foundation.org>; Wed, 19 May 2021 03:56:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EdUxIIp8SJ11 for <iommu@lists.linux-foundation.org>;
 Wed, 19 May 2021 03:56:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BB7D240E6D
 for <iommu@lists.linux-foundation.org>; Wed, 19 May 2021 03:56:00 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 u25-20020a0568302319b02902ac3d54c25eso10643269ote.1
 for <iommu@lists.linux-foundation.org>; Tue, 18 May 2021 20:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HhI/6V9NfoJZk78Xj3HSIgGBenrGacrIrQhkazt2/Pg=;
 b=BDabwLgl6MZS4U8XrrFfu4+rhJeSJnpXyXKVfXeCBYYzg6RwPFuTQUgwemNDEpr1u5
 0MOMW4AxeFPbDMVv7pPJL90+WLZm0edmQl2boNfWalW9tn1lcBGFQxOGwJfRHSo2XFW5
 BrWESt0MqZgnRAE9FJShc8MbG9Qt8GnzeAaUQFGE7Qs+19jLWg2Wp9EC4VFfeE7ezmdG
 GV/fR0iVhT8T7+hT8+6DvdP7JkKyWmfHRQR50XuE0RHlnvbR0/s6fxeF5IXXGlfPN4vc
 fAr0KmaSIZCfhtexblbMFReAvS1w7z2uv5rwGnkHMZ7Kp25fYRuJvIZrsUaitszkaL8I
 wmZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HhI/6V9NfoJZk78Xj3HSIgGBenrGacrIrQhkazt2/Pg=;
 b=mDn2sYTO6HqkziVIqGJXhc788Uq/dUCPLivFqz7Ijqo6fcMIA/yQCmC+gM8nPKWU3V
 HyM+HvJ31rzUmfYRQODvX/s2238HWj47BfstzI+uDb7xJLZpQAslstxthPzgjriIo+iU
 akXJtcrxZDp0q5i1COJxM9t6QVZs3btQ+JzGlOci2Eld2da6IpHVELy7PGMXi8o8Wgzb
 +1hbFO1K/3In/wLe/5GlXigauP00lkaD+g6BloPj7/1/fTjrPMfG6sTOCJw6gGlDLg2L
 Y1CbB0Zx+ownKcwU8z/gBRb/nymngfW5JHGY0yJTcwmwGPt5l3rPaESVSHrxrv9KetGd
 xYQw==
X-Gm-Message-State: AOAM530mMqV82RaUv3ln/e6VQwg4rXQ7H+H1xicAu5VwKWSFe+g3scQk
 tA1pHvuE9cK3M+iV37Bw8Qt98mc40I8Kj4KemkU=
X-Google-Smtp-Source: ABdhPJynQ7/RGStOwc2agXrmWgyvoU6JpN55uvWTWxM567AKkz/5AStqjojczNtSZroC42xTdrkDxgQwaLArKPkNTco=
X-Received: by 2002:a9d:4115:: with SMTP id o21mr7143864ote.52.1621396559845; 
 Tue, 18 May 2021 20:55:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210518112857.1198415-1-aisheng.dong@nxp.com>
 <fe37a3d0-1360-77e8-f594-c9f32cc39cf2@arm.com>
In-Reply-To: <fe37a3d0-1360-77e8-f594-c9f32cc39cf2@arm.com>
From: Dong Aisheng <dongas86@gmail.com>
Date: Wed, 19 May 2021 11:54:56 +0800
Message-ID: <CAA+hA=RnEh8QG1vHSFBwMF2pwxv-J14m3za3yaqcNgqb=+xezA@mail.gmail.com>
Subject: Re: [PATCH 1/1] dma-contiguous: return early for dt case in
 dma_contiguous_reserve
To: Robin Murphy <robin.murphy@arm.com>
X-Mailman-Approved-At: Wed, 19 May 2021 06:58:22 +0000
Cc: Dong Aisheng <aisheng.dong@nxp.com>, iommu@lists.linux-foundation.org,
 open list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>
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

On Wed, May 19, 2021 at 2:51 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-05-18 12:28, Dong Aisheng wrote:
> > dma_contiguous_reserve() aims to support cmdline case for CMA memory
> > reserve. But if users define reserved memory in DT,
> > 'dma_contiguous_default_area' will not be 0, then it's meaningless
> > to continue to run dma_contiguous_reserve(). So we return early
> > if detect 'dma_contiguous_default_area' is unzero.
>
> But dma_contiguous_default_area *shouldn't* be set if the command-line
> argument is present - see the "if (size_cmdline != -1 && default_cma)"
> part of rmem_cma_setup(). Are you seeing something different in practice?
>

yes, you're right.

> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > ---
> >   kernel/dma/contiguous.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> > index 3d63d91cba5c..ebade9f43eff 100644
> > --- a/kernel/dma/contiguous.c
> > +++ b/kernel/dma/contiguous.c
> > @@ -171,6 +171,9 @@ void __init dma_contiguous_reserve(phys_addr_t limit)
> >       phys_addr_t selected_limit = limit;
> >       bool fixed = false;
> >
> > +     if (dma_contiguous_default_area)
> > +             return;
> > +
> >       pr_debug("%s(limit %08lx)\n", __func__, (unsigned long)limit);
> >
> >       if (size_cmdline != -1) {
> > @@ -191,7 +194,7 @@ void __init dma_contiguous_reserve(phys_addr_t limit)
> >   #endif
> >       }
> >
> > -     if (selected_size && !dma_contiguous_default_area) {
> > +     if (selected_size) {
>
> Either way, does skipping a handful of trivial calculations and a
> debugging message really matter even when it is redundant? I can't
> imagine it has any measurable effect on boot times...
>

I think it's not about performance.
It aims to improve the code readability as it's meaningless to continue to
execute cmdline CMA reserve logic once DT is used successfully which is
a bit confusing when people first read this part of code.
Does it make sense to you?

Regards
Aisheng

> Robin.
>
> >               pr_debug("%s: reserving %ld MiB for global area\n", __func__,
> >                        (unsigned long)selected_size / SZ_1M);
> >
> >
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
