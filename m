Return-Path: <SRS0=AOw0=DX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF05C4363A
	for <iommu@archiver.kernel.org>; Fri, 16 Oct 2020 06:56:31 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 907F82080A
	for <iommu@archiver.kernel.org>; Fri, 16 Oct 2020 06:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kW25M9o0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 907F82080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id A9D6487402;
	Fri, 16 Oct 2020 06:56:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0oRihGVnmHX3; Fri, 16 Oct 2020 06:56:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2513F81E31;
	Fri, 16 Oct 2020 06:56:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0C693C07FF;
	Fri, 16 Oct 2020 06:56:29 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BDEF0C0051
 for <iommu@lists.linux-foundation.org>; Fri, 16 Oct 2020 06:56:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id ABB0088B43
 for <iommu@lists.linux-foundation.org>; Fri, 16 Oct 2020 06:56:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n1P4AXeOEUWm for <iommu@lists.linux-foundation.org>;
 Fri, 16 Oct 2020 06:56:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 0484F88AE4
 for <iommu@lists.linux-foundation.org>; Fri, 16 Oct 2020 06:56:27 +0000 (UTC)
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com
 [209.85.167.171])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6142F20848
 for <iommu@lists.linux-foundation.org>; Fri, 16 Oct 2020 06:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1602831386;
 bh=Qt5cK4GbMy1zYjzp9yoahcnNoGCra0PWF0mygx/BzDY=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=kW25M9o0mHtPxHMea8yV80oWEA7vsMtr2BnXS+nM5/3MQhqUaPvN+MhMXTh+FopX7
 uX5bRbMj4YsNF7JnVpLGJ8bkygcEu+ZEiqZ/YvRS766TMA7DF9cF/fcUls1f6GBkDC
 KZugE4D2A0tX8R0wG7oMBjzYLxgCNaiu0dmN+tRI=
Received: by mail-oi1-f171.google.com with SMTP id h10so1330231oie.5
 for <iommu@lists.linux-foundation.org>; Thu, 15 Oct 2020 23:56:26 -0700 (PDT)
X-Gm-Message-State: AOAM53041FSRLk2BftmrY5Nc78AyjYKt35XN/SzjxlwYd9Lts3VHk1te
 VTtKiRRQWIeuaNf/XDLUOXleubSV2PtI32k9NUw=
X-Google-Smtp-Source: ABdhPJz06rV6WAWm42aN14z1C+ajNWUQE5kD2qLfjxAdRc9MpB29T/PNIdoPGp5uO2oI3ZIgGfWCv7Dbtg/8qUfzXjc=
X-Received: by 2002:aca:d64f:: with SMTP id n76mr1596675oig.174.1602831385656; 
 Thu, 15 Oct 2020 23:56:25 -0700 (PDT)
MIME-Version: 1.0
References: <20201014191211.27029-1-nsaenzjulienne@suse.de>
 <20201014191211.27029-8-nsaenzjulienne@suse.de>
 <20201015103106.GA24739@e121166-lin.cambridge.arm.com>
In-Reply-To: <20201015103106.GA24739@e121166-lin.cambridge.arm.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 16 Oct 2020 08:56:14 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGRcP_8OMHAdjTLNod40N_8dzqrX9=F+s7pd0EXy8O6DQ@mail.gmail.com>
Message-ID: <CAMj1kXGRcP_8OMHAdjTLNod40N_8dzqrX9=F+s7pd0EXy8O6DQ@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] arm64: mm: Set ZONE_DMA size based on early IORT
 scan
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Will Deacon <will@kernel.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Sudeep Holla <sudeep.holla@arm.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Jeremy Linton <jeremy.linton@arm.com>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Rob Herring <robh+dt@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Hanjun Guo <guohanjun@huawei.com>, Len Brown <lenb@kernel.org>,
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

On Thu, 15 Oct 2020 at 12:31, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Wed, Oct 14, 2020 at 09:12:09PM +0200, Nicolas Saenz Julienne wrote:
>
> [...]
>
> > +unsigned int __init acpi_iort_get_zone_dma_size(void)
> > +{
> > +     struct acpi_table_iort *iort;
> > +     struct acpi_iort_node *node, *end;
> > +     acpi_status status;
> > +     u8 limit = 32;
> > +     int i;
> > +
> > +     if (acpi_disabled)
> > +             return limit;
> > +
> > +     status = acpi_get_table(ACPI_SIG_IORT, 0,
> > +                             (struct acpi_table_header **)&iort);
> > +     if (ACPI_FAILURE(status))
> > +             return limit;
> > +
> > +     node = ACPI_ADD_PTR(struct acpi_iort_node, iort, iort->node_offset);
> > +     end = ACPI_ADD_PTR(struct acpi_iort_node, iort, iort->header.length);
> > +
> > +     for (i = 0; i < iort->node_count; i++) {
> > +             if (node >= end)
> > +                     break;
> > +
> > +             switch (node->type) {
> > +                     struct acpi_iort_named_component *ncomp;
> > +                     struct acpi_iort_root_complex *rc;
> > +
> > +             case ACPI_IORT_NODE_NAMED_COMPONENT:
> > +                     ncomp = (struct acpi_iort_named_component *)node->node_data;
> > +                     if (ncomp->memory_address_limit)
> > +                             limit = min(limit, ncomp->memory_address_limit);
> > +                     break;
> > +
> > +             case ACPI_IORT_NODE_PCI_ROOT_COMPLEX:
> > +                     rc = (struct acpi_iort_root_complex *)node->node_data;
> > +                     if (rc->memory_address_limit)
>
> You need to add a node revision check here, see rc_dma_get_range() in
> drivers/acpi/arm64/iort.c, otherwise we may be reading junk data
> in older IORT tables - acpica structures are always referring to the
> latest specs.
>

Indeed - apologies for not mentioning that when handing over the patch.

Also, we could use min_not_zero() here instead of the if ()
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
