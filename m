Return-Path: <SRS0=zShu=DV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A424DC433E7
	for <iommu@archiver.kernel.org>; Wed, 14 Oct 2020 12:24:10 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC05A20BED
	for <iommu@archiver.kernel.org>; Wed, 14 Oct 2020 12:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TMTgWqc2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC05A20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2EAF020412;
	Wed, 14 Oct 2020 12:24:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gpdGSPF4SM7P; Wed, 14 Oct 2020 12:24:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id E72DD2036C;
	Wed, 14 Oct 2020 12:24:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C9D39C0052;
	Wed, 14 Oct 2020 12:24:07 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C2122C0051
 for <iommu@lists.linux-foundation.org>; Wed, 14 Oct 2020 12:24:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id B464E20412
 for <iommu@lists.linux-foundation.org>; Wed, 14 Oct 2020 12:24:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B5mkxyRS-lFB for <iommu@lists.linux-foundation.org>;
 Wed, 14 Oct 2020 12:24:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 8941A2036C
 for <iommu@lists.linux-foundation.org>; Wed, 14 Oct 2020 12:24:05 +0000 (UTC)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com
 [209.85.210.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D644022203
 for <iommu@lists.linux-foundation.org>; Wed, 14 Oct 2020 12:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1602678245;
 bh=t0IBPBNo+yYO11jhv9fM4cJG+wfMTFGo8MY5tqsXG5U=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=TMTgWqc23Fp8S68g+EvPHtyVYNZmNP+z9x9jAytDBLk4QMUzqVyPKEIwZja6i1w/V
 ybqg/7GHRaA/08pwv902eetV+9kH5fhw/n5TFlL5PPESAYu1KwG0J/AEdYl6TPgSYb
 anMWS3fr1jbXFcPH9vs8yiRtnplOtBuDc621PUqI=
Received: by mail-ot1-f43.google.com with SMTP id f10so3214810otb.6
 for <iommu@lists.linux-foundation.org>; Wed, 14 Oct 2020 05:24:04 -0700 (PDT)
X-Gm-Message-State: AOAM5327vr9IbzaH++sPCehAYxVxm2c0d0jn2o1roQA8v+q7Q6dDsLl0
 MzLJi8MTkKpZcQrN5v29/1TW0wb/0nyq5PvuZg==
X-Google-Smtp-Source: ABdhPJy9xd9p7AIQ89atOIFtAtTvVkcZBoUqHoM2d76WPGxs9lK5Ru8GlYDbiDS8fYIzTNRaOfPecpecUgbDqkGL+7A=
X-Received: by 2002:a9d:5e14:: with SMTP id d20mr3002538oti.107.1602678244026; 
 Wed, 14 Oct 2020 05:24:04 -0700 (PDT)
MIME-Version: 1.0
References: <20201010151235.20585-1-nsaenzjulienne@suse.de>
 <20201010151235.20585-3-nsaenzjulienne@suse.de>
 <CAL_JsqL2cs+cko-UuTd37fnBKO_=3jQeyjB49USvm_VTBwcS8g@mail.gmail.com>
 <6740c49b73b11aaf1d74d216dc6e055e0a0ceac3.camel@suse.de>
In-Reply-To: <6740c49b73b11aaf1d74d216dc6e055e0a0ceac3.camel@suse.de>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 14 Oct 2020 07:23:53 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+cPQS7836YqVos=n-TFOvc8kXa8ZXGq5_=rZAzz8RLLQ@mail.gmail.com>
Message-ID: <CAL_Jsq+cPQS7836YqVos=n-TFOvc8kXa8ZXGq5_=rZAzz8RLLQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] of/address: Introduce of_dma_lower_bus_limit()
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jeremy Linton <jeremy.linton@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
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

On Wed, Oct 14, 2020 at 6:52 AM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> Hi Rob,
>
> On Mon, 2020-10-12 at 10:25 -0500, Rob Herring wrote:
> > On Sat, Oct 10, 2020 at 10:12 AM Nicolas Saenz Julienne
> > <nsaenzjulienne@suse.de> wrote:
> > > The function provides the CPU physical address addressable by the most
> > > constrained bus in the system. It might be useful in order to
> > > dynamically set up memory zones during boot.
> > >
> > > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > > ---
> > >  drivers/of/address.c | 34 ++++++++++++++++++++++++++++++++++
> > >  include/linux/of.h   |  7 +++++++
> > >  2 files changed, 41 insertions(+)
> > >
> > > diff --git a/drivers/of/address.c b/drivers/of/address.c
> > > index eb9ab4f1e80b..755e97b65096 100644
> > > --- a/drivers/of/address.c
> > > +++ b/drivers/of/address.c
> > > @@ -1024,6 +1024,40 @@ int of_dma_get_range(struct device_node *np, const struct bus_dma_region **map)
> > >  }
> > >  #endif /* CONFIG_HAS_DMA */
> > >
> > > +/**
> > > + * of_dma_safe_phys_limit - Get system wide DMA safe address space
> > > + *
> > > + * Gets the CPU physical address limit for safe DMA addressing system wide by
> > > + * searching for the most constraining dma-range. Otherwise it returns ~0ULL.
> > > + */
> > > +u64 __init of_dma_safe_phys_limit(void)
> > > +{
> > > +       struct device_node *np = NULL;
> > > +       struct of_range_parser parser;
> > > +       const __be32 *ranges = NULL;
> > > +       u64 phys_dma_limit = ~0ULL;
> > > +       struct of_range range;
> > > +       int len;
> > > +
> > > +       for_each_of_allnodes(np) {
> > > +               dma_addr_t cpu_end = 0;
> > > +
> > > +               ranges = of_get_property(np, "dma-ranges", &len);
> > > +               if (!ranges || !len)
> > > +                       continue;
> > > +
> > > +               of_dma_range_parser_init(&parser, np);
> > > +               for_each_of_range(&parser, &range)
> > > +                       if (range.cpu_addr + range.size > cpu_end)
> > > +                               cpu_end = range.cpu_addr + range.size;
> >
> > This doesn't work if you have more than one level of dma-ranges. The
> > address has to be translated first. It should be okay to do that on
> > the start or end address (if not, your DT is broken).
>
> for_each_of_range() calls of_pci_range_parser_one() which utimately populates
> range.cpu_addr with of_translate_dma_address() results. Isn't that good enough?

Indeed. I guess I was remembering the cases not using
for_each_of_range which forgot to do that...

Rob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
