Return-Path: <SRS0=cNfX=L6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6E1C07E9E
	for <iommu@archiver.kernel.org>; Tue,  6 Jul 2021 16:21:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6192161A3E
	for <iommu@archiver.kernel.org>; Tue,  6 Jul 2021 16:21:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6192161A3E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2B1FC83372;
	Tue,  6 Jul 2021 16:21:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u-gHGDAbD6Y9; Tue,  6 Jul 2021 16:21:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 16C2F83300;
	Tue,  6 Jul 2021 16:21:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E17B7C001A;
	Tue,  6 Jul 2021 16:21:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 551B1C000E
 for <iommu@lists.linux-foundation.org>; Tue,  6 Jul 2021 16:21:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 32038608A9
 for <iommu@lists.linux-foundation.org>; Tue,  6 Jul 2021 16:21:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RYU1eEG_3rNT for <iommu@lists.linux-foundation.org>;
 Tue,  6 Jul 2021 16:21:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4D67660860
 for <iommu@lists.linux-foundation.org>; Tue,  6 Jul 2021 16:21:53 +0000 (UTC)
Received: from mail-ed1-f69.google.com ([209.85.208.69])
 by youngberry.canonical.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.93)
 (envelope-from <kai.heng.feng@canonical.com>) id 1m0npW-0003Ke-SF
 for iommu@lists.linux-foundation.org; Tue, 06 Jul 2021 16:21:50 +0000
Received: by mail-ed1-f69.google.com with SMTP id
 n13-20020a05640206cdb029039589a2a771so3148222edy.5
 for <iommu@lists.linux-foundation.org>; Tue, 06 Jul 2021 09:21:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kGlDPyrXklpe94l/MLiVRpqx1f3MJLKeH5USkerAr9A=;
 b=ezAYcvqURDugBoE4BMpDBNsDoEJgGop0tThRsB4EQaYjWfL1ypPX1BQN92KTK1V4Bq
 lW/uSIOYetBOfWoetMgV4CTNU3LPW3V4MpjtBXbWf5DP43b4uBU4keb3Znk2Y/igku0P
 rlvKsScPNW6hvsaZVI2rkERfPBh2txdSN/dR/jowCarfjo+QMz6xNV1laR3TOdXkrOJM
 Hy0Yl0d2I0S9YbfNxwHoKtX2mX63mnatfRD5gtnVRI4yPH4fWJs57NUwOohavBOjrhG8
 Idfa3vbXHfhD+5aS5MTtlAP+VjoUcMe/QTfel0bKAYlRauxC0aIdZIXVzsw9jFDHwPhG
 qOgQ==
X-Gm-Message-State: AOAM532krG7MR4gigvikrYgCaibrkNLiaiK0uPAYWVJkbgKj93YjnFXU
 2xuSlfpLRrVGAx1ZhU0ylgFTg8yiBVqEExuTTTPf1n40Q/indcUUtK2dfZ5WNfLPhS4qqS1FmAx
 uKn29to7qY18B1khtrIZPCR5I7wRNNODC/CTLGPZuGBgCYWwoDi8VwE0R4g+G17Q=
X-Received: by 2002:a17:907:3f0c:: with SMTP id
 hq12mr14665668ejc.117.1625588510494; 
 Tue, 06 Jul 2021 09:21:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGD3eqFpCnyFnDreBKI5Rw1aIANwcSZIzvSAN4eyQ84oiwI3eYBSEyhw/pWhN6pAr3clWkW2sWfpSN/oIjcDA=
X-Received: by 2002:a17:907:3f0c:: with SMTP id
 hq12mr14665646ejc.117.1625588510203; 
 Tue, 06 Jul 2021 09:21:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210706065106.271765-1-kai.heng.feng@canonical.com>
 <d9fa9a62-6522-7d26-0cca-16f6886136ec@arm.com>
In-Reply-To: <d9fa9a62-6522-7d26-0cca-16f6886136ec@arm.com>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Wed, 7 Jul 2021 00:21:38 +0800
Message-ID: <CAAd53p7ZXWkD8DiL0kMP8dZA5qFGRcdAMizv3THgo2XABPe25g@mail.gmail.com>
Subject: Re: [PATCH] iommu: Fallback to default setting when def_domain_type()
 callback returns 0
To: Robin Murphy <robin.murphy@arm.com>
Cc: will@kernel.org,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 open list <linux-kernel@vger.kernel.org>
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

On Tue, Jul 6, 2021 at 5:27 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-07-06 07:51, Kai-Heng Feng wrote:
> > Commit 28b41e2c6aeb ("iommu: Move def_domain type check for untrusted
> > device into core") not only moved the check for untrusted device to
> > IOMMU core, it also introduced a behavioral change by returning
> > def_domain_type() directly without checking its return value. That makes
> > many devices no longer use the default IOMMU setting.
> >
> > So revert back to the old behavior which defaults to
> > iommu_def_domain_type when driver callback returns 0.
> >
> > Fixes: 28b41e2c6aeb ("iommu: Move def_domain type check for untrusted device into core")
>
> Are you sure about that? From that same commit:
>
> @@ -1507,7 +1509,7 @@ static int iommu_alloc_default_domain(struct
> iommu_group *group,
>          if (group->default_domain)
>                  return 0;
>
> -       type = iommu_get_def_domain_type(dev);
> +       type = iommu_get_def_domain_type(dev) ? : iommu_def_domain_type;
>
>          return iommu_group_alloc_default_domain(dev->bus, group, type);
>   }
>
> AFAICS the other two callers should also handle 0 correctly. Have you
> seen a problem in practice?

Thanks for pointing out how the return value is being handled by the callers.
However, the same check is missing in probe_get_default_domain_type():
static int probe_get_default_domain_type(struct device *dev, void *data)
{
        struct __group_domain_type *gtype = data;
        unsigned int type = iommu_get_def_domain_type(dev);
...
}

I personally prefer the old way instead of open coding with ternary
operator, so I'll do that in v2.

In practice, this causes a kernel panic when probing Realtek WiFi.
Because of the bug, dma_ops isn't set by probe_finalize(),
dma_map_single() falls back to swiotlb which isn't set and caused a
kernel panic.
I didn't attach the panic log because the system simply is frozen at
that point so the message is not logged to the storage.
I'll see if I can find another way to collect the log and attach it in v2.

Kai-Heng

>
> Robin.
>
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> >   drivers/iommu/iommu.c | 5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index 5419c4b9f27a..faac4f795025 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -1507,14 +1507,15 @@ EXPORT_SYMBOL_GPL(fsl_mc_device_group);
> >   static int iommu_get_def_domain_type(struct device *dev)
> >   {
> >       const struct iommu_ops *ops = dev->bus->iommu_ops;
> > +     unsigned int type = 0;
> >
> >       if (dev_is_pci(dev) && to_pci_dev(dev)->untrusted)
> >               return IOMMU_DOMAIN_DMA;
> >
> >       if (ops->def_domain_type)
> > -             return ops->def_domain_type(dev);
> > +             type = ops->def_domain_type(dev);
> >
> > -     return 0;
> > +     return (type == 0) ? iommu_def_domain_type : type;
> >   }
> >
> >   static int iommu_group_alloc_default_domain(struct bus_type *bus,
> >
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
