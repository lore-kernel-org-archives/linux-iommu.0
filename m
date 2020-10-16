Return-Path: <SRS0=AOw0=DX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4FFCC433DF
	for <iommu@archiver.kernel.org>; Fri, 16 Oct 2020 13:20:05 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5485920B1F
	for <iommu@archiver.kernel.org>; Fri, 16 Oct 2020 13:20:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KD55CXGu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5485920B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C6D3988833;
	Fri, 16 Oct 2020 13:20:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qKmHwLtMdAdL; Fri, 16 Oct 2020 13:20:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D31348867B;
	Fri, 16 Oct 2020 13:20:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A186AC0052;
	Fri, 16 Oct 2020 13:20:02 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C2506C0051
 for <iommu@lists.linux-foundation.org>; Fri, 16 Oct 2020 13:20:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id BA4038838C
 for <iommu@lists.linux-foundation.org>; Fri, 16 Oct 2020 13:20:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RPLTAv0Fnaly for <iommu@lists.linux-foundation.org>;
 Fri, 16 Oct 2020 13:20:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 2B77B8838B
 for <iommu@lists.linux-foundation.org>; Fri, 16 Oct 2020 13:20:00 +0000 (UTC)
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com
 [209.85.167.179])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9126320B1F
 for <iommu@lists.linux-foundation.org>; Fri, 16 Oct 2020 13:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1602854399;
 bh=rfvuV6Al+rLb9nUjAfzHGQK9DuIWt6YUWVj+UIEKlz8=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=KD55CXGuyZ12HyX0m/0olwjfr6HTDjY7uf1hHPOTIXPDMBkTlOqSdyRJvJniVYkKO
 Lie30rb7KlUHlIw0WLIWVhZFw4XOcpwDK45E+1tbtu3P6pA0zJcwTiu6i1ACdaFV4g
 jgAIZvyIzEkTNvn854dV6qoNzny0h7hJ8Jrocjq4=
Received: by mail-oi1-f179.google.com with SMTP id q136so2374040oic.8
 for <iommu@lists.linux-foundation.org>; Fri, 16 Oct 2020 06:19:59 -0700 (PDT)
X-Gm-Message-State: AOAM532MA76uMRwgX0+c3Thlrrrvi8qwcVpl77RF19r+eh4+7E7lb+0B
 IbIT6xKmA5XYATSqz9QFfX2hkjW7u5tuaMexsw==
X-Google-Smtp-Source: ABdhPJwxbMynzIU6zuNouBn+wKZ+/vyBd3EU7EY1Rlpcr59uCRZiPaTsqPTK2OQmhPBQ1tNjnBtuXZGHrNkXaL1AnJk=
X-Received: by 2002:aca:4c52:: with SMTP id z79mr2509589oia.147.1602854398739; 
 Fri, 16 Oct 2020 06:19:58 -0700 (PDT)
MIME-Version: 1.0
References: <20201014191211.27029-1-nsaenzjulienne@suse.de>
 <20201014191211.27029-4-nsaenzjulienne@suse.de>
 <20201015054244.GD12218@lst.de>
In-Reply-To: <20201015054244.GD12218@lst.de>
From: Rob Herring <robh+dt@kernel.org>
Date: Fri, 16 Oct 2020 08:19:47 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKyRby5tp2JS1COodYf7F7sB_DJivyAe7FqQivp4KM6OA@mail.gmail.com>
Message-ID: <CAL_JsqKyRby5tp2JS1COodYf7F7sB_DJivyAe7FqQivp4KM6OA@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] of/address: Introduce of_dma_get_max_cpu_address()
To: Christoph Hellwig <hch@lst.de>
Cc: devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jeremy Linton <jeremy.linton@arm.com>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Robin Murphy <robin.murphy@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
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

On Thu, Oct 15, 2020 at 12:42 AM Christoph Hellwig <hch@lst.de> wrote:
>
> > +phys_addr_t __init of_dma_get_max_cpu_address(struct device_node *np)
> > +{
> > +     phys_addr_t max_cpu_addr = PHYS_ADDR_MAX;
> > +     struct of_range_parser parser;
> > +     phys_addr_t subtree_max_addr;
> > +     struct device_node *child;
> > +     phys_addr_t cpu_end = 0;
> > +     struct of_range range;
> > +     const __be32 *ranges;
> > +     int len;
> > +
> > +     if (!np)
> > +             np = of_root;
>
> Requiring of_root to be passed explicitly would seem more natural
> to me than the magic NULL argument.  There doesn't seem to be any
> precedent for that kind of calling convention either.

I prefer that of_root is not more widely exposed and NULL regularly
means 'the whole tree'.

Rob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
