Return-Path: <SRS0=OkX6=ZW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CACBC43215
	for <iommu@archiver.kernel.org>; Sat, 30 Nov 2019 05:58:50 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 242382082E
	for <iommu@archiver.kernel.org>; Sat, 30 Nov 2019 05:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u1cB09Sg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 242382082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id C773E2046D;
	Sat, 30 Nov 2019 05:58:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UBIdNhEhX6Mq; Sat, 30 Nov 2019 05:58:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A17312041A;
	Sat, 30 Nov 2019 05:58:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7D955C1DD9;
	Sat, 30 Nov 2019 05:58:48 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2CA3CC0881
 for <iommu@lists.linux-foundation.org>; Sat, 30 Nov 2019 05:58:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 14A3C87B82
 for <iommu@lists.linux-foundation.org>; Sat, 30 Nov 2019 05:58:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X16ClIUIwrWd for <iommu@lists.linux-foundation.org>;
 Sat, 30 Nov 2019 05:58:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com
 [209.85.216.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id CE90887B61
 for <iommu@lists.linux-foundation.org>; Sat, 30 Nov 2019 05:58:45 +0000 (UTC)
Received: by mail-pj1-f65.google.com with SMTP id s8so14321736pji.2
 for <iommu@lists.linux-foundation.org>; Fri, 29 Nov 2019 21:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YU1p8ulCDRHuV/2STrjeEjC5+eZArWofUrYdxbS3oFg=;
 b=u1cB09Sgi9Q64BgW3XHkj/e9ZbsjnOEWQjcS0MPCmlTBQU0ox0O8Nyc6Vb3oQi/igB
 9kWIY7DM/S/dih7FVZal2XdGgPteNVsk+fFfxgjxsD1tkO/UO2bj9ZeoZc4OrdJ2px9S
 eAUEsNy5CA9BXyb3jgmnfCWbn9NSuoUrsRZ1yb7v/BpGKps+RenY3pJIcDeS/b8KZV5L
 oFzYi2ZdFzX48DlDKgKZsHelp/JCYOz9zP1M3o/s3hvH7oyfA5ujuCGKhrhc9OuaGT8e
 Z8xJQLehnxbUSvfuUCDXhG0uvGvrpL7aZayzEKRCL1dnS1endMu2lVfXuFBMKCb1W9AC
 x2FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YU1p8ulCDRHuV/2STrjeEjC5+eZArWofUrYdxbS3oFg=;
 b=cTyK8LqSo9Sofanpuho9HmiICp26GrQRiPjgMceoIU95FqBAcvrh7iG3VVBImqM6rl
 KPnol286MqG/fjU/pq1xveHZSGhdRPJZVPNEj7A9on3CKmcY8yg1RmzxKBALRt4jq2W1
 xUO26d0u+SA4X37f42X+XxTtCUZNqpodAlIPoCQrGGLrZGRTN+M1zXktvwtyKU5eEYW6
 hsNj0B1duSGPHNbJj/CBPEo+lDSYbL5Ur1BhG5pVBhJhLD6BRuZAx0OtczYC5F1Rpz5R
 mWxXKS0Y511wfM3pWQfPwhSc3PqclkzAV0+XLGz1NKtmzl2lOGQnrduYpIkc85vqe58u
 gWyQ==
X-Gm-Message-State: APjAAAXlc7Wg7Qe8GkGOK1Dm/Hywm0FyVSGTusoegQGRqtHA+2HuRzxD
 I2oZ5LP2R79Zl1jgCsAtml/tTsWInx+YNqE7Wm8=
X-Google-Smtp-Source: APXvYqyo+Y2thH/qpd/k7zH53eZOh8AWelNOLYZ33p9HcoLpX0JD5vrJ7B2++N364byeD4KQ+1RuUfz9ZiZAr7HjGiE=
X-Received: by 2002:a17:90a:850c:: with SMTP id
 l12mr23512535pjn.16.1575093525368; 
 Fri, 29 Nov 2019 21:58:45 -0800 (PST)
MIME-Version: 1.0
References: <20191129004855.18506-1-xiyou.wangcong@gmail.com>
 <20191129004855.18506-2-xiyou.wangcong@gmail.com>
 <d0f58734-0c1e-af9d-3437-31cf6c8a86f9@huawei.com>
In-Reply-To: <d0f58734-0c1e-af9d-3437-31cf6c8a86f9@huawei.com>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Fri, 29 Nov 2019 21:58:34 -0800
Message-ID: <CAM_iQpXAf8obF1-CRCGc3Fb_YmNBozcyoKQC5yuP6r9Akg6HBg@mail.gmail.com>
Subject: Re: [Patch v2 1/3] iommu: match the original algorithm
To: John Garry <john.garry@huawei.com>
Cc: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>
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

On Fri, Nov 29, 2019 at 6:43 AM John Garry <john.garry@huawei.com> wrote:
>
> On 29/11/2019 00:48, Cong Wang wrote:
> > The IOVA cache algorithm implemented in IOMMU code does not
> > exactly match the original algorithm described in the paper.
> >
>
> which paper?

It's in drivers/iommu/iova.c, from line 769:

 769 /*
 770  * Magazine caches for IOVA ranges.  For an introduction to magazines,
 771  * see the USENIX 2001 paper "Magazines and Vmem: Extending the Slab
 772  * Allocator to Many CPUs and Arbitrary Resources" by Bonwick and Adams.
 773  * For simplicity, we use a static magazine size and don't implement the
 774  * dynamic size tuning described in the paper.
 775  */


>
> > Particularly, it doesn't need to free the loaded empty magazine
> > when trying to put it back to global depot. To make it work, we
> > have to pre-allocate magazines in the depot and only recycle them
> > when all of them are full.
> >
> > Before this patch, rcache->depot[] contains either full or
> > freed entries, after this patch, it contains either full or
> > empty (but allocated) entries.
>
> I *quickly* tested this patch and got a small performance gain.

Thanks for testing! It requires a different workload to see bigger gain,
in our case, 24 memcache.parallel servers with 120 clients.


>
> >
> > Cc: Joerg Roedel <joro@8bytes.org>
> > Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
> > ---
> >   drivers/iommu/iova.c | 45 +++++++++++++++++++++++++++-----------------
> >   1 file changed, 28 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> > index 41c605b0058f..cb473ddce4cf 100644
> > --- a/drivers/iommu/iova.c
> > +++ b/drivers/iommu/iova.c
> > @@ -862,12 +862,16 @@ static void init_iova_rcaches(struct iova_domain *iovad)
> >       struct iova_cpu_rcache *cpu_rcache;
> >       struct iova_rcache *rcache;
> >       unsigned int cpu;
> > -     int i;
> > +     int i, j;
> >
> >       for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
> >               rcache = &iovad->rcaches[i];
> >               spin_lock_init(&rcache->lock);
> >               rcache->depot_size = 0;
> > +             for (j = 0; j < MAX_GLOBAL_MAGS; ++j) {
> > +                     rcache->depot[j] = iova_magazine_alloc(GFP_KERNEL);
> > +                     WARN_ON(!rcache->depot[j]);
> > +             }
> >               rcache->cpu_rcaches = __alloc_percpu(sizeof(*cpu_rcache), cache_line_size());
> >               if (WARN_ON(!rcache->cpu_rcaches))
> >                       continue;
> > @@ -900,24 +904,30 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
> >
> >       if (!iova_magazine_full(cpu_rcache->loaded)) {
> >               can_insert = true;
> > -     } else if (!iova_magazine_full(cpu_rcache->prev)) {
> > +     } else if (iova_magazine_empty(cpu_rcache->prev)) {
>
> is this change strictly necessary?

Yes, because it is what described in the paper. But it should be
functionally same because cpu_rcache->prev is either full or empty.



>
> >               swap(cpu_rcache->prev, cpu_rcache->loaded);
> >               can_insert = true;
> >       } else {
> > -             struct iova_magazine *new_mag = iova_magazine_alloc(GFP_ATOMIC);
> > +             spin_lock(&rcache->lock);
> > +             if (rcache->depot_size < MAX_GLOBAL_MAGS) {
> > +                     swap(rcache->depot[rcache->depot_size], cpu_rcache->prev);
> > +                     swap(cpu_rcache->prev, cpu_rcache->loaded);
> > +                     rcache->depot_size++;
> > +                     can_insert = true;
> > +             } else {
> > +                     mag_to_free = cpu_rcache->loaded;
> > +             }
> > +             spin_unlock(&rcache->lock);
> > +
> > +             if (mag_to_free) {
> > +                     struct iova_magazine *new_mag = iova_magazine_alloc(GFP_ATOMIC);
> >
> > -             if (new_mag) {
> > -                     spin_lock(&rcache->lock);
> > -                     if (rcache->depot_size < MAX_GLOBAL_MAGS) {
> > -                             rcache->depot[rcache->depot_size++] =
> > -                                             cpu_rcache->loaded;
> > +                     if (new_mag) {
> > +                             cpu_rcache->loaded = new_mag;
> > +                             can_insert = true;
> >                       } else {
> > -                             mag_to_free = cpu_rcache->loaded;
> > +                             mag_to_free = NULL;
> >                       }
> > -                     spin_unlock(&rcache->lock);
> > -
> > -                     cpu_rcache->loaded = new_mag;
> > -                     can_insert = true;
> >               }
> >       }
> >
> > @@ -963,14 +973,15 @@ static unsigned long __iova_rcache_get(struct iova_rcache *rcache,
> >
> >       if (!iova_magazine_empty(cpu_rcache->loaded)) {
> >               has_pfn = true;
> > -     } else if (!iova_magazine_empty(cpu_rcache->prev)) {
> > +     } else if (iova_magazine_full(cpu_rcache->prev)) {
> >               swap(cpu_rcache->prev, cpu_rcache->loaded);
> >               has_pfn = true;
> >       } else {
> >               spin_lock(&rcache->lock);
> >               if (rcache->depot_size > 0) {
> > -                     iova_magazine_free(cpu_rcache->loaded);
>
> it is good to remove this from under the lock, apart from this change
>
> > -                     cpu_rcache->loaded = rcache->depot[--rcache->depot_size];
> > +                     swap(rcache->depot[rcache->depot_size - 1], cpu_rcache->prev);
> > +                     swap(cpu_rcache->prev, cpu_rcache->loaded);
> > +                     rcache->depot_size--;
>
> I'm not sure how appropriate the name "depot_size" is any longer.

I think it is still okay, because empty ones don't count. However if you
have better names, I am open to your suggestion.

Thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
