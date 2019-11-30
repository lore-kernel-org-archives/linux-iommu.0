Return-Path: <SRS0=OkX6=ZW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6D4C432C0
	for <iommu@archiver.kernel.org>; Sat, 30 Nov 2019 06:02:24 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9D7D2082E
	for <iommu@archiver.kernel.org>; Sat, 30 Nov 2019 06:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRlw7VAh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9D7D2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 862182047A;
	Sat, 30 Nov 2019 06:02:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AwhiuXl4FO6w; Sat, 30 Nov 2019 06:02:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 37F472041A;
	Sat, 30 Nov 2019 06:02:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1E833C1DD9;
	Sat, 30 Nov 2019 06:02:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 50F92C0881
 for <iommu@lists.linux-foundation.org>; Sat, 30 Nov 2019 06:02:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3B02087C42
 for <iommu@lists.linux-foundation.org>; Sat, 30 Nov 2019 06:02:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FOGvDGTADrNE for <iommu@lists.linux-foundation.org>;
 Sat, 30 Nov 2019 06:02:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
 [209.85.215.193])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B919487BFF
 for <iommu@lists.linux-foundation.org>; Sat, 30 Nov 2019 06:02:20 +0000 (UTC)
Received: by mail-pg1-f193.google.com with SMTP id x8so1769121pgk.8
 for <iommu@lists.linux-foundation.org>; Fri, 29 Nov 2019 22:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hCkQvVpA+xQBSnTmW523N5CEpD+qnerHkkfRy0+khQQ=;
 b=YRlw7VAh8iujb7Ncv63hBBkYJHJMFRqAYUcNCfa1cvrX7cBHSA4d7N+hBGVjpc90QD
 ff1rQJK1BrR0FdThU7OziQhZOcAPDL2XQ2fDZ5ncAz+fq5lKuXq8r/Bad6K63JPzHh8V
 KG9ZIbtq9BvbK2s8h0bMKL3JdsSaq3Ab+TGrgyUMu5e3hQ5UjtYPa+b2FFz6BmW3MRQp
 3eDtrBI0wLWlATOOZ9nOYnvgL2DTtVIONzYhnwxfwkr/BsVIXu6+P5eKbSsmBuFq07n4
 e8a4aE+FIJpnnmMd5C4k+hv9/jTyG/AJxpQx/hGLAg4vkP7/y5APHNpQ/WJC5NEsvvIt
 NV+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hCkQvVpA+xQBSnTmW523N5CEpD+qnerHkkfRy0+khQQ=;
 b=Z8NB8Q4t/5Obx96eGcKivNzEwlGGEH/tiATtchbri5a8L8PARh8M1fyuKIp+3nmc9O
 qwOZr66ApLsMQPi3Sr8qDdfQ58+cW6XlviAhIYt8M1xZtDGW0zobYCYfazZ52hYXIjZv
 XMQekQg4NMjCYEz9p5GcqKJNk5SycSq6Iw0RcJJVYT2144MeAaDr/HspxVAODIWH31Fn
 25/aGCiPP/regxzrRN6/asoVbIcEcHMeHQzfE5ThNW4r62P62OKgZWry7/cOhro3o1Fo
 dm+SRrGz5zucmYyWmj2yP65p4BLE4HLk5bntNgnSYYK8YHZnFrkDNG3Juga7tyn5U7YV
 ZcgQ==
X-Gm-Message-State: APjAAAUqBEhiMwF14VEEh4yWHnBAXJKZLVG9MIOI74oKc+qlAdB2Otjg
 qgFy0F7QhR8ivLtW5PjT+xpsHPnDvjAHv8UzO2s=
X-Google-Smtp-Source: APXvYqy8BWakF5Y2JarZ6sTaCRPFV3SoHmQntxhp/EsJ1Pd8C6oVwFtufzBlBSH7O4Xlgl1i2Ejs93KtBgKyCnqP9U0=
X-Received: by 2002:a63:e4e:: with SMTP id 14mr20530973pgo.237.1575093740272; 
 Fri, 29 Nov 2019 22:02:20 -0800 (PST)
MIME-Version: 1.0
References: <20191129004855.18506-1-xiyou.wangcong@gmail.com>
 <20191129004855.18506-3-xiyou.wangcong@gmail.com>
 <dc182be3-be98-9a8e-013c-16df0e529ed2@huawei.com>
In-Reply-To: <dc182be3-be98-9a8e-013c-16df0e529ed2@huawei.com>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Fri, 29 Nov 2019 22:02:08 -0800
Message-ID: <CAM_iQpX3MKoBRvxqc-bJ0HvASNeZmvVCYhbT53maMy-rqy4eiw@mail.gmail.com>
Subject: Re: [Patch v2 2/3] iommu: optimize iova_magazine_free_pfns()
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

On Fri, Nov 29, 2019 at 5:24 AM John Garry <john.garry@huawei.com> wrote:
>
> On 29/11/2019 00:48, Cong Wang wrote:
> > If the maganize is empty, iova_magazine_free_pfns() should
>
> magazine

Good catch!

>
> > be a nop, however it misses the case of mag->size==0. So we
> > should just call iova_magazine_empty().
> >
> > This should reduce the contention on iovad->iova_rbtree_lock
> > a little bit.
> >
> > Cc: Joerg Roedel <joro@8bytes.org>
> > Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
> > ---
> >   drivers/iommu/iova.c | 22 +++++++++++-----------
> >   1 file changed, 11 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> > index cb473ddce4cf..184d4c0e20b5 100644
> > --- a/drivers/iommu/iova.c
> > +++ b/drivers/iommu/iova.c
> > @@ -797,13 +797,23 @@ static void iova_magazine_free(struct iova_magazine *mag)
> >       kfree(mag);
> >   }
> >
> > +static bool iova_magazine_full(struct iova_magazine *mag)
> > +{
> > +     return (mag && mag->size == IOVA_MAG_SIZE);
> > +}
> > +
> > +static bool iova_magazine_empty(struct iova_magazine *mag)
> > +{
> > +     return (!mag || mag->size == 0);
> > +}
> > +
> >   static void
> >   iova_magazine_free_pfns(struct iova_magazine *mag, struct iova_domain *iovad)
> >   {
> >       unsigned long flags;
> >       int i;
> >
> > -     if (!mag)
> > +     if (iova_magazine_empty(mag))
>
> The only hot path we this call is
> __iova_rcache_insert()->iova_magazine_free_pfns(mag_to_free) and
> mag_to_free is full in this case, so I am sure how the additional check
> helps, right?

This is what I mean by "a little bit" in changelog, did you miss it or
misunderstand it? :)

Thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
