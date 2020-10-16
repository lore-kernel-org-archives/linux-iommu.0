Return-Path: <SRS0=AOw0=DX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F97C43467
	for <iommu@archiver.kernel.org>; Fri, 16 Oct 2020 06:55:13 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3A4820829
	for <iommu@archiver.kernel.org>; Fri, 16 Oct 2020 06:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OnEMUDtf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3A4820829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7E8C9882CB;
	Fri, 16 Oct 2020 06:55:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AKkIZSORMBb9; Fri, 16 Oct 2020 06:55:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C64B4882A7;
	Fri, 16 Oct 2020 06:55:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ADB00C07FF;
	Fri, 16 Oct 2020 06:55:11 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 53E33C0051
 for <iommu@lists.linux-foundation.org>; Fri, 16 Oct 2020 06:55:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4E509882C3
 for <iommu@lists.linux-foundation.org>; Fri, 16 Oct 2020 06:55:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jAx2r5YnZOVe for <iommu@lists.linux-foundation.org>;
 Fri, 16 Oct 2020 06:55:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 7D8FE882A7
 for <iommu@lists.linux-foundation.org>; Fri, 16 Oct 2020 06:55:09 +0000 (UTC)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com
 [209.85.210.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0D6DE212CC
 for <iommu@lists.linux-foundation.org>; Fri, 16 Oct 2020 06:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1602831309;
 bh=b3qDwjjAp5PHcyt8IPdk4OZdAwmA08qCD89V2qvJHaU=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=OnEMUDtfzK0gADScZPt2n5h2HkDxjKlzfLcIFiT2z0pNHcWCzFlaM+Gg9CdaS49Cm
 GGa4rRxzT6s4z6RPwHyrwBHNffZ87P0maEvRUvVl6a9/aOKYXpqaTL3rvmlz1Kr4M4
 OpYcEVUMGGBhILJAXeRULNbnv58Scz98UscOGpEM=
Received: by mail-ot1-f53.google.com with SMTP id d28so1548955ote.1
 for <iommu@lists.linux-foundation.org>; Thu, 15 Oct 2020 23:55:09 -0700 (PDT)
X-Gm-Message-State: AOAM532G/rrOBy0+N+qXg4k0TeeVfK3nrNve9Ps5HQPbP4oQXXeX0JYN
 5oS6BUzoYHvCzH4XsPaSmSRn59TA5N9SJpk1iKo=
X-Google-Smtp-Source: ABdhPJzFVaXBGl8dFNX52YrC8SMcHfjR/tZskK4YIqFusTZj+VMKn9rDGBEcRadGWaZ6KZRA07DaMJyrRkA2/apa6EA=
X-Received: by 2002:a9d:6a85:: with SMTP id l5mr1646843otq.77.1602831308155;
 Thu, 15 Oct 2020 23:55:08 -0700 (PDT)
MIME-Version: 1.0
References: <20201014191211.27029-1-nsaenzjulienne@suse.de>
 <20201014191211.27029-8-nsaenzjulienne@suse.de>
 <1a3df60a-4568-cb72-db62-36127d0ffb7e@huawei.com>
 <20201015180340.GB2624@gaia> <35faab1c-5c32-6cd3-0a14-77057dd223f5@huawei.com>
In-Reply-To: <35faab1c-5c32-6cd3-0a14-77057dd223f5@huawei.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 16 Oct 2020 08:54:56 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFzYbr_mYm-zhsio2XV+KGgDBjtgy_NWNYnanyfU-U-Nw@mail.gmail.com>
Message-ID: <CAMj1kXFzYbr_mYm-zhsio2XV+KGgDBjtgy_NWNYnanyfU-U-Nw@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] arm64: mm: Set ZONE_DMA size based on early IORT
 scan
To: Hanjun Guo <guohanjun@huawei.com>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Will Deacon <will@kernel.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Jeremy Linton <jeremy.linton@arm.com>, Linuxarm <linuxarm@huawei.com>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Rob Herring <robh+dt@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Sudeep Holla <sudeep.holla@arm.com>, Len Brown <lenb@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>
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

On Fri, 16 Oct 2020 at 08:51, Hanjun Guo <guohanjun@huawei.com> wrote:
>
> On 2020/10/16 2:03, Catalin Marinas wrote:
> > On Thu, Oct 15, 2020 at 10:26:18PM +0800, Hanjun Guo wrote:
> >> On 2020/10/15 3:12, Nicolas Saenz Julienne wrote:
> >>> From: Ard Biesheuvel <ardb@kernel.org>
> >>>
> >>> We recently introduced a 1 GB sized ZONE_DMA to cater for platforms
> >>> incorporating masters that can address less than 32 bits of DMA, in
> >>> particular the Raspberry Pi 4, which has 4 or 8 GB of DRAM, but has
> >>> peripherals that can only address up to 1 GB (and its PCIe host
> >>> bridge can only access the bottom 3 GB)
> >>>
> >>> Instructing the DMA layer about these limitations is straight-forward,
> >>> even though we had to fix some issues regarding memory limits set in
> >>> the IORT for named components, and regarding the handling of ACPI _DMA
> >>> methods. However, the DMA layer also needs to be able to allocate
> >>> memory that is guaranteed to meet those DMA constraints, for bounce
> >>> buffering as well as allocating the backing for consistent mappings.
> >>>
> >>> This is why the 1 GB ZONE_DMA was introduced recently. Unfortunately,
> >>> it turns out the having a 1 GB ZONE_DMA as well as a ZONE_DMA32 causes
> >>> problems with kdump, and potentially in other places where allocations
> >>> cannot cross zone boundaries. Therefore, we should avoid having two
> >>> separate DMA zones when possible.
> >>>
> >>> So let's do an early scan of the IORT, and only create the ZONE_DMA
> >>> if we encounter any devices that need it. This puts the burden on
> >>> the firmware to describe such limitations in the IORT, which may be
> >>> redundant (and less precise) if _DMA methods are also being provided.
> >>> However, it should be noted that this situation is highly unusual for
> >>> arm64 ACPI machines. Also, the DMA subsystem still gives precedence to
> >>> the _DMA method if implemented, and so we will not lose the ability to
> >>> perform streaming DMA outside the ZONE_DMA if the _DMA method permits
> >>> it.
> >>
> >> Sorry, I'm still a little bit confused. With this patch, if we have
> >> a device which set the right _DMA method (DMA size >= 32), but with the
> >> wrong DMA size in IORT, we still have the ZONE_DMA created which
> >> is actually not needed?
> >
> > With the current kernel, we get a ZONE_DMA already with an arbitrary
> > size of 1GB that matches what RPi4 needs. We are trying to eliminate
> > such unnecessary ZONE_DMA based on some heuristics (well, something that
> > looks "better" than a OEM ID based quirk). Now, if we learn that IORT
> > for platforms in the field is that broken as to describe few bits-wide
> > DMA masks, we may have to go back to the OEM ID quirk.
>
> Some platforms using 0 as the memory size limit, for example D05 [0] and
> D06 [1], I think we need to go back to the OEM ID quirk.
>
> For D05/D06, there are multi interrupt controllers named as mbigen,
> mbigen is using the named component to describe the mappings with
> the ITS controller, and mbigen is using 0 as the memory size limit.
>
> Also since the memory size limit for PCI RC was introduced by later
> IORT revision, so firmware people may think it's fine to set that
> as 0 because the system works without it.
>

Hello Hanjun,

The patch only takes the address limit field into account if its value > 0.

Also, before commit 7fb89e1d44cb6aec ("ACPI/IORT: take _DMA methods
into account for named components"), the _DMA method was not taken
into account for named components at all, and only the IORT limit was
used, so I do not anticipate any problems with that.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
