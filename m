Return-Path: <SRS0=IUlV=GR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FAC1C433E6
	for <iommu@archiver.kernel.org>; Thu, 14 Jan 2021 09:12:20 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CDF223A1D
	for <iommu@archiver.kernel.org>; Thu, 14 Jan 2021 09:12:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CDF223A1D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id C8B3E29C87;
	Thu, 14 Jan 2021 09:12:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3ZHaw2ZUy85L; Thu, 14 Jan 2021 09:12:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id DBA862047B;
	Thu, 14 Jan 2021 09:12:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CB756C088B;
	Thu, 14 Jan 2021 09:12:15 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 92AABC013A
 for <iommu@lists.linux-foundation.org>; Thu, 14 Jan 2021 09:12:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 8D64587234
 for <iommu@lists.linux-foundation.org>; Thu, 14 Jan 2021 09:12:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8d8YI5uge9xx for <iommu@lists.linux-foundation.org>;
 Thu, 14 Jan 2021 09:12:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by hemlock.osuosl.org (Postfix) with ESMTPS id EB22687165
 for <iommu@lists.linux-foundation.org>; Thu, 14 Jan 2021 09:12:13 +0000 (UTC)
Received: by mail-pf1-f173.google.com with SMTP id c79so2992349pfc.2
 for <iommu@lists.linux-foundation.org>; Thu, 14 Jan 2021 01:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=r2clGFKfMvWdEL24a/hrPW/SoKgcT/5YZOK8G2tupLA=;
 b=X7SGbsqsGRlUtP0PJCg54RJ4TAlmaAHUG3xPdqjVb0oScLVfStGatbndpS03GsNgnP
 Ay7KF7sGV28MuK8UBUQD50tmV7MICCg9iHgn3dDmdiN2V0+w2jb02zv0Fvhtiq/Aou7X
 FWO4E0ky5/69bheieFiKWNwRnHzuorBEbyewE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=r2clGFKfMvWdEL24a/hrPW/SoKgcT/5YZOK8G2tupLA=;
 b=OAvDdED+wD4Ngl1e+H5O3hE7uvyFeazWzff6FdhM09qzOYBrANcl1QfL9nD+GxjoXU
 R/NFmM3OwBqYC4xB9fXAaYwZHv0jc4mrKhBlt6H5CIlYjcaJOyxjk22+MxUiR/Ha38aC
 NuB4NVJ6N9dgTJyu5CAtPVznQytf9l3z4/iaTys06IzM/6UsBnZx4b/cIL2OciTgglMA
 pxJQX2/+5nrTWqLaaIucUWeBlxY6EwcWBgj7OG+2ZykUn9YXc/6lLVr4OJkjsC/9Xr8E
 ZsBkD84TKEpQlurXSHw5qw9++9LLPfe0QQzY9CTaosgLuTbshDd0Tcy53/5PWqViXczF
 WTNw==
X-Gm-Message-State: AOAM530bNL2OASSFRTRSBm9HVRF7iANKV9xZ5ZPQLQqkkZScZEA9F4TO
 k79ACMgdiE9XrgeAhpfA6xl74rNGtmej7w==
X-Google-Smtp-Source: ABdhPJzl8saIvgweeTg4nfcp5VubkxgaqOsnaqDtfhIsZ3X1s8eKFh2O0Hcl66xjVqqJz2Fq1aChQw==
X-Received: by 2002:a63:a506:: with SMTP id n6mr6595576pgf.397.1610615533341; 
 Thu, 14 Jan 2021 01:12:13 -0800 (PST)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com.
 [209.85.210.178])
 by smtp.gmail.com with ESMTPSA id b1sm4827751pjh.54.2021.01.14.01.12.12
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Jan 2021 01:12:13 -0800 (PST)
Received: by mail-pf1-f178.google.com with SMTP id x126so2969613pfc.7
 for <iommu@lists.linux-foundation.org>; Thu, 14 Jan 2021 01:12:12 -0800 (PST)
X-Received: by 2002:a92:ce8f:: with SMTP id r15mr4926327ilo.303.1610615178346; 
 Thu, 14 Jan 2021 01:06:18 -0800 (PST)
MIME-Version: 1.0
References: <20210106034124.30560-1-tientzu@chromium.org>
 <20210106034124.30560-3-tientzu@chromium.org>
 <20210113124209.GA1383@lst.de>
In-Reply-To: <20210113124209.GA1383@lst.de>
From: Claire Chang <tientzu@chromium.org>
Date: Thu, 14 Jan 2021 17:06:07 +0800
X-Gmail-Original-Message-ID: <CALiNf2-a6JpbeyfCoGdjFAbguxwW5kn1r_Oq6yr+k1rGum7O8Q@mail.gmail.com>
Message-ID: <CALiNf2-a6JpbeyfCoGdjFAbguxwW5kn1r_Oq6yr+k1rGum7O8Q@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/6] swiotlb: Add restricted DMA pool
To: Christoph Hellwig <hch@lst.de>
Cc: heikki.krogerus@linux.intel.com, peterz@infradead.org,
 benh@kernel.crashing.org, grant.likely@arm.com, paulus@samba.org,
 Frank Rowand <frowand.list@gmail.com>, mingo@kernel.org,
 sstabellini@kernel.org, Saravana Kannan <saravanak@google.com>,
 mpe@ellerman.id.au, rafael.j.wysocki@intel.com,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 xen-devel@lists.xenproject.org, Thierry Reding <treding@nvidia.com>,
 linux-devicetree <devicetree@vger.kernel.org>, will@kernel.org,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, dan.j.williams@intel.com,
 linuxppc-dev@lists.ozlabs.org, Rob Herring <robh+dt@kernel.org>,
 boris.ostrovsky@oracle.com,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, jgross@suse.com,
 Nicolas Boichat <drinkcat@chromium.org>, Greg KH <gregkh@linuxfoundation.org>,
 rdunlap@infradead.org, lkml <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 xypron.glpk@gmx.de, Robin Murphy <robin.murphy@arm.com>
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

On Wed, Jan 13, 2021 at 8:42 PM Christoph Hellwig <hch@lst.de> wrote:
>
> > +#ifdef CONFIG_SWIOTLB
> > +     struct io_tlb_mem       *dma_io_tlb_mem;
> >  #endif
>
> Please add a new config option for this code instead of always building
> it when swiotlb is enabled.
>
> > +static int swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
> > +                                size_t size)
>
> Can you split the refactoring in swiotlb.c into one or more prep
> patches?
>
> > +static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
> > +                                 struct device *dev)
> > +{
> > +     struct io_tlb_mem *mem = rmem->priv;
> > +     int ret;
> > +
> > +     if (dev->dma_io_tlb_mem)
> > +             return -EBUSY;
> > +
> > +     if (!mem) {
> > +             mem = kzalloc(sizeof(*mem), GFP_KERNEL);
> > +             if (!mem)
> > +                     return -ENOMEM;
>
> What is the calling convention here that allows for a NULL and non-NULL
> private data?

Since multiple devices can share the same pool, the private data,
io_tlb_mem struct, will be initialized by the first device attached to
it.
This is similar to rmem_dma_device_init() in kernel/dma/coherent.c.
I'll add a comment for it in next version.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
