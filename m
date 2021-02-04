Return-Path: <SRS0=5Yk+=HG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8412DC433DB
	for <iommu@archiver.kernel.org>; Thu,  4 Feb 2021 03:18:58 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E95D64F4D
	for <iommu@archiver.kernel.org>; Thu,  4 Feb 2021 03:18:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E95D64F4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id B6ECE84C53;
	Thu,  4 Feb 2021 03:18:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3t3chxVOad2D; Thu,  4 Feb 2021 03:18:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4F13184900;
	Thu,  4 Feb 2021 03:18:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 36E82C0174;
	Thu,  4 Feb 2021 03:18:57 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2B791C013A
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 03:18:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id EF80B273A9
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 03:18:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PeP5LW8iktep for <iommu@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 03:18:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com
 [209.85.166.42])
 by silver.osuosl.org (Postfix) with ESMTPS id 4B62027384
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 03:18:53 +0000 (UTC)
Received: by mail-io1-f42.google.com with SMTP id n201so1690133iod.12
 for <iommu@lists.linux-foundation.org>; Wed, 03 Feb 2021 19:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DZiFYdS72YXSF/YcGe+WmP/kvp/Q5JIvKaSw7pcHJWA=;
 b=hH6n317tODhtW1eRiw0q6H0BcGIlYcbBt8e4FRq2vp5JHlhLTnWrH82VZR7jnSXyA6
 5UOKoKnnfc5XEgNSJ3owPgQnppne7gFAnl8/8vs9jYRsdDyRjd/tt/iauK+6fSli3Dlp
 R9U0Bnggmj7z/QcLYisWXTMeYBRZCADdTygmtuXM9I9kDJm7UCGn3GCKZtRHFxWgXySl
 fd1RSPgWL2i3kRmFmckrXEnzdzU5oINDAlS5uNq1vV1sdKcgudsgMT+26ZjOIT/bxdPG
 F0tbP/0OUxgvtoTn7xCLJTwC5S8LGC5MUMo4tHWKdxhJGST7IJ9NRhb78pZ+ug5gVHty
 cMkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DZiFYdS72YXSF/YcGe+WmP/kvp/Q5JIvKaSw7pcHJWA=;
 b=jMI0M9WeQTH6oMoPrVeFgrkonVF9c6U4nINMGN3C0Rds1GuqA1KGk7gT2uL7lz9SPP
 sSgwLR6PeyUipAXwNWaonzIWS4EK4jmOABhoGQdGo3lav+81nuzevuIUJn6Zq6b7eDn1
 c8hU/JQARR6xT+oYNLBofx51OK6zxR0ymOm4qEGj1NF+BQu7Yh/BeKFU9kGfJ3ONOj/V
 eQix7XbNYxEGfoJWShjuQVeQdeNrcqsnmYcFTKUvNjpYtpqZsa/109ZjmtHkw36XeL7q
 NwLPbYWmFvb+V+jEIQZsnyJFjeDazw8FQNicyBEVDZYb4+Mr7xor6YTMEIXtuItG9bSN
 bq6w==
X-Gm-Message-State: AOAM5318PNBn0WFe/C2/7mEmMo/VIY6mubiPsxP9AKJzmdkG+hQQphe5
 j3NqsWB3IM+7UGDNiUNmx5Aoiv4xeO89rnEO7vw=
X-Google-Smtp-Source: ABdhPJxbxiBXBnRWIlSF2MVAG+Lc4eNFMSRSxXep/mfEYl/G3WZThA77PSJaoeG4ONXxqjQkCICKjiim+guzwid5Ng4=
X-Received: by 2002:a05:6638:35a3:: with SMTP id
 v35mr6064046jal.36.1612408732602; 
 Wed, 03 Feb 2021 19:18:52 -0800 (PST)
MIME-Version: 1.0
References: <20210203090727.789939-1-zhang.lyra@gmail.com>
 <20210203090727.789939-3-zhang.lyra@gmail.com>
 <eb55a1de-2816-9029-b642-b3067e311417@infradead.org>
In-Reply-To: <eb55a1de-2816-9029-b642-b3067e311417@infradead.org>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Thu, 4 Feb 2021 11:18:16 +0800
Message-ID: <CAAfSe-sKqzub08kBgYNimBwbaf5s-Ed=Ef3PcMvA_8YTYsDwUw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iommu: add Unisoc iommu basic driver
To: Randy Dunlap <rdunlap@infradead.org>
Cc: DTML <devicetree@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Chunyan Zhang <chunyan.zhang@unisoc.com>, Sheng Xu <sheng.xu@unisoc.com>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Rob Herring <robh+dt@kernel.org>, Baolin Wang <baolin.wang7@gmail.com>,
 Orson Zhai <orsonzhai@gmail.com>, Robin Murphy <robin.murphy@arm.com>
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

On Thu, 4 Feb 2021 at 01:44, Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 2/3/21 1:07 AM, Chunyan Zhang wrote:
> > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > index 192ef8f61310..99e7712f3903 100644
> > --- a/drivers/iommu/Kconfig
> > +++ b/drivers/iommu/Kconfig
> > @@ -408,4 +408,16 @@ config VIRTIO_IOMMU
> >
> >         Say Y here if you intend to run this kernel as a guest.
> >
> > +config SPRD_IOMMU
> > +     tristate "Unisoc IOMMU Support"
> > +     depends on ARCH_SPRD || COMPILE_TEST
> > +     select IOMMU_API
> > +     help
> > +       Support for IOMMU on Unisoc's SoCs, this iommu can be used by
>
>         s/iommu/IOMMU/ please

Sure, thanks.

Chunyan

>
> > +       Unisoc's multimedia devices, such as display, Image codec(jpeg)
> > +       and a few signal processors, including VSP(video), GSP(graphic),
> > +       ISP(image), and CPP(camera pixel processor), etc.
> > +
> > +       Say Y here if you want to use the multimedia devices listed above.
>
>
> --
> ~Randy
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
