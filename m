Return-Path: <SRS0=kzsj=LS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A5BC49EA6
	for <iommu@archiver.kernel.org>; Thu, 24 Jun 2021 16:00:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A176613EB
	for <iommu@archiver.kernel.org>; Thu, 24 Jun 2021 16:00:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A176613EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 569DB82CF1;
	Thu, 24 Jun 2021 16:00:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zMLKdl7dnhC8; Thu, 24 Jun 2021 16:00:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E073D81919;
	Thu, 24 Jun 2021 16:00:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B2C19C001A;
	Thu, 24 Jun 2021 16:00:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0FE34C000E
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 16:00:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8A4328248F
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 15:59:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lSyrA8aPH4h3 for <iommu@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 15:59:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8E2BC83C2A
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 15:59:21 +0000 (UTC)
Received: by mail-pg1-x534.google.com with SMTP id h4so5084791pgp.5
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 08:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OUC0E76X92PmzUvBM3M58z5qjgzPKxJvrlMYIlH3t/A=;
 b=V1DUMk4pWXUrJHEg/9Kd4ukoLxbJGeXfb8ZAhSFnF6RVbF8t2Z5J1ymG4niuoHNq4v
 lR13PRE87YP1jrN3LaPEaViS+9EA9qGG/k81iCPvzgmr34ySIt4SvvmFKyoWhdSPE98X
 KaxkIr3Pk6gTC5BkELMIeQJS2sWcVoDywrhkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OUC0E76X92PmzUvBM3M58z5qjgzPKxJvrlMYIlH3t/A=;
 b=A6+smnuQ3NfUy2MBt8t6+tH+SO1gnDULTgRJO5Xl6QqBJnt9dfyYRUnRGiTgaaXUGn
 MVKEExRJ7Su0AVRFSd8d5JPEdEzWeiS1nUHW9KHLi682/H3err2x1lp0RqUuiRrfReu0
 Z4IPBrcU518J+7xywOyRKMaNJQ4fL2oPJOwrVWfSUkaQDwe+P9JQMs54ATfCsp9+fBUk
 cFpX+cbfjuTD7yuzj7Q34TfkFVvz6fZrrvypJQ2mLkFxOIsMHXpbUY5ZFmCsr+Mm1JP4
 PUdWmQjXShj5GdoSAzv+zpVdSQ5KVHVjajZmyLH9dieBzA6NN1vU1Iqhn0KLFpWk71Qc
 JU0Q==
X-Gm-Message-State: AOAM530zAALkbF79npDyG0r92QqM0g5IMrKo4z1LhKMa5gcp5t5fQVp8
 r30ch85Pp2l6vxE1/j/YJvEHIKiR4eNdRg==
X-Google-Smtp-Source: ABdhPJxjLsnNKxGf06P7aDye9iYxr61KPoG4oWRRPRA7139n5H+H1znWGNLFMEwzsLmr3NEOfD4BkQ==
X-Received: by 2002:a63:4a4a:: with SMTP id j10mr5306889pgl.175.1624550360686; 
 Thu, 24 Jun 2021 08:59:20 -0700 (PDT)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com.
 [209.85.215.169])
 by smtp.gmail.com with ESMTPSA id e2sm2904963pgh.5.2021.06.24.08.59.19
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Jun 2021 08:59:20 -0700 (PDT)
Received: by mail-pg1-f169.google.com with SMTP id m2so5076343pgk.7
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 08:59:19 -0700 (PDT)
X-Received: by 2002:a92:9509:: with SMTP id y9mr4122371ilh.18.1624550347935;
 Thu, 24 Jun 2021 08:59:07 -0700 (PDT)
MIME-Version: 1.0
References: <76c3343d-72e5-9df3-8924-5474ee698ef4@quicinc.com>
 <20210623183736.GA472@willie-the-truck>
 <19d4c7a2-744d-21e0-289c-a576e1f0e6f3@quicinc.com>
 <20210624054315.GA25381@lst.de>
 <CALiNf288ZLMhY3E8E3N+z9rkwi1viWNLm1wwMEwT4rNwh3FfwQ@mail.gmail.com>
 <364e6715-eafd-fc4a-e0af-ce2a042756b4@arm.com>
 <20210624111855.GA1382@willie-the-truck>
 <452155d2-c98e-23f6-86d6-3a2ff2e74783@arm.com>
 <20210624114829.GB1382@willie-the-truck>
 <43ec9dd6-12c0-98ec-8d5d-b2904292721e@quicinc.com>
 <YNSq56zyJ7EYdTcI@char.us.oracle.com>
In-Reply-To: <YNSq56zyJ7EYdTcI@char.us.oracle.com>
From: Claire Chang <tientzu@chromium.org>
Date: Thu, 24 Jun 2021 23:58:57 +0800
X-Gmail-Original-Message-ID: <CALiNf2_WCVodEZJz9PaCTgk_c8LpOAcD4=YZTLDMVyorJs3ESQ@mail.gmail.com>
Message-ID: <CALiNf2_WCVodEZJz9PaCTgk_c8LpOAcD4=YZTLDMVyorJs3ESQ@mail.gmail.com>
Subject: Re: [PATCH v14 06/12] swiotlb: Use is_swiotlb_force_bounce for
 swiotlb data bouncing
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: heikki.krogerus@linux.intel.com,
 linux-devicetree <devicetree@vger.kernel.org>, peterz@infradead.org,
 benh@kernel.crashing.org, joonas.lahtinen@linux.intel.com,
 dri-devel@lists.freedesktop.org, chris@chris-wilson.co.uk,
 grant.likely@arm.com, paulus@samba.org, Frank Rowand <frowand.list@gmail.com>,
 mingo@kernel.org, Jianxiong Gao <jxgao@google.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Saravana Kannan <saravanak@google.com>, mpe@ellerman.id.au,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Christoph Hellwig <hch@lst.de>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, bskeggs@redhat.com,
 linux-pci@vger.kernel.org, xen-devel@lists.xenproject.org,
 Dan Williams <dan.j.williams@intel.com>, matthew.auld@intel.com,
 Nicolas Boichat <drinkcat@chromium.org>, thomas.hellstrom@linux.intel.com,
 Jim Quinlan <james.quinlan@broadcom.com>, Will Deacon <will@kernel.org>,
 intel-gfx@lists.freedesktop.org, maarten.lankhorst@linux.intel.com,
 jani.nikula@linux.intel.com, Rob Herring <robh+dt@kernel.org>,
 rodrigo.vivi@intel.com, Bjorn Helgaas <bhelgaas@google.com>,
 boris.ostrovsky@oracle.com,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, jgross@suse.com,
 airlied@linux.ie, Thierry Reding <treding@nvidia.com>,
 linuxppc-dev@lists.ozlabs.org, Randy Dunlap <rdunlap@infradead.org>,
 Qian Cai <quic_qiancai@quicinc.com>, Greg KH <gregkh@linuxfoundation.org>,
 lkml <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Daniel Vetter <daniel@ffwll.ch>, xypron.glpk@gmx.de,
 Tom Lendacky <thomas.lendacky@amd.com>, Robin Murphy <robin.murphy@arm.com>,
 bauerman@linux.ibm.com
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

On Thu, Jun 24, 2021 at 11:56 PM Konrad Rzeszutek Wilk
<konrad.wilk@oracle.com> wrote:
>
> On Thu, Jun 24, 2021 at 10:10:51AM -0400, Qian Cai wrote:
> >
> >
> > On 6/24/2021 7:48 AM, Will Deacon wrote:
> > > Ok, diff below which attempts to tackle the offset issue I mentioned as
> > > well. Qian Cai -- please can you try with these changes?
> >
> > This works fine.
>
> Cool. Let me squash this patch in #6 and rebase the rest of them.
>
> Claire, could you check the devel/for-linus-5.14 say by end of today to
> double check that I didn't mess anything up please?

I just submitted v15 here
(https://lore.kernel.org/patchwork/cover/1451322/) in case it's
helpful.
I'll double check of course. Thanks for the efforts!

>
> Will,
>
> Thank you for generating the fix! I am going to run it on x86 and Xen
> to make sure all is good (granted last time I ran devel/for-linus-5.14
> on that setup I didn't see any errors so I need to double check
> I didn't do something silly like run a wrong kernel).
>
>
> >
> > >
> > > Will
> > >
> > > --->8
> > >
> > > diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> > > index 175b6c113ed8..39284ff2a6cd 100644
> > > --- a/include/linux/swiotlb.h
> > > +++ b/include/linux/swiotlb.h
> > > @@ -116,7 +116,9 @@ static inline bool is_swiotlb_buffer(struct device *dev, phys_addr_t paddr)
> > >
> > >  static inline bool is_swiotlb_force_bounce(struct device *dev)
> > >  {
> > > -       return dev->dma_io_tlb_mem->force_bounce;
> > > +       struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
> > > +
> > > +       return mem && mem->force_bounce;
> > >  }
> > >
> > >  void __init swiotlb_exit(void);
> > > diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> > > index 44be8258e27b..0ffbaae9fba2 100644
> > > --- a/kernel/dma/swiotlb.c
> > > +++ b/kernel/dma/swiotlb.c
> > > @@ -449,6 +449,7 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
> > >                 dma_get_min_align_mask(dev) & ~(IO_TLB_SIZE - 1);
> > >         unsigned int nslots = nr_slots(alloc_size), stride;
> > >         unsigned int index, wrap, count = 0, i;
> > > +       unsigned int offset = swiotlb_align_offset(dev, orig_addr);
> > >         unsigned long flags;
> > >
> > >         BUG_ON(!nslots);
> > > @@ -497,7 +498,7 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
> > >         for (i = index; i < index + nslots; i++) {
> > >                 mem->slots[i].list = 0;
> > >                 mem->slots[i].alloc_size =
> > > -                       alloc_size - ((i - index) << IO_TLB_SHIFT);
> > > +                       alloc_size - (offset + ((i - index) << IO_TLB_SHIFT));
> > >         }
> > >         for (i = index - 1;
> > >              io_tlb_offset(i) != IO_TLB_SEGSIZE - 1 &&
> > >
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
