Return-Path: <SRS0=zShu=DV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBE0C433E7
	for <iommu@archiver.kernel.org>; Wed, 14 Oct 2020 22:04:46 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5875221D81
	for <iommu@archiver.kernel.org>; Wed, 14 Oct 2020 22:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PL3xl9TE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5875221D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D6F6E88248;
	Wed, 14 Oct 2020 22:04:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id suu5rJs5dolc; Wed, 14 Oct 2020 22:04:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6A0AD88243;
	Wed, 14 Oct 2020 22:04:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 33BA8C07FF;
	Wed, 14 Oct 2020 22:04:45 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D6C9C0051
 for <iommu@lists.linux-foundation.org>; Wed, 14 Oct 2020 22:04:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8701488246
 for <iommu@lists.linux-foundation.org>; Wed, 14 Oct 2020 22:04:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gnEgxAgwEiJE for <iommu@lists.linux-foundation.org>;
 Wed, 14 Oct 2020 22:04:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id EAE1888243
 for <iommu@lists.linux-foundation.org>; Wed, 14 Oct 2020 22:04:42 +0000 (UTC)
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com
 [209.85.167.170])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5B1B922249
 for <iommu@lists.linux-foundation.org>; Wed, 14 Oct 2020 22:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1602713082;
 bh=2zxpdSUShETO8tOrEebuH3FEpgqr1/cYJUaqMy6YzLI=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=PL3xl9TEA4q0/1MEIx1Ikx+tz3HGIsT86wGyFex+TmWPGfJIfVtla5dKIbE2f9pjP
 biko9X5iDzNpabXOngSdhYPACa4jIGmnH2CVnSWaF3KOAUAQQdusZAqfEUNaUKlK2R
 HLso/M5B0NBXKRByqcy5R7syyu4y/9z9mgu6wzlU=
Received: by mail-oi1-f170.google.com with SMTP id 16so829001oix.9
 for <iommu@lists.linux-foundation.org>; Wed, 14 Oct 2020 15:04:42 -0700 (PDT)
X-Gm-Message-State: AOAM533WuwltemSg+AIPaiBWps+HTbY8O/Uw4QkVdH+mIfs8uToXof5i
 QRaEtiZX9k2UZm482addjbNgNww8noM7qBzT5A==
X-Google-Smtp-Source: ABdhPJzXFxZwWyGnc9TNmrtU0RSpAPz5wj+JC9I4DklEciLqy/06NwQfoIR1rLErg1OAmFLR4vmaArWnDM+vbUZxLsc=
X-Received: by 2002:a05:6808:10e:: with SMTP id
 b14mr190700oie.152.1602713081587; 
 Wed, 14 Oct 2020 15:04:41 -0700 (PDT)
MIME-Version: 1.0
References: <20201014191211.27029-1-nsaenzjulienne@suse.de>
 <20201014191211.27029-5-nsaenzjulienne@suse.de>
In-Reply-To: <20201014191211.27029-5-nsaenzjulienne@suse.de>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 14 Oct 2020 17:04:30 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLC5vAnPjCrr4H3ik_Gh_7vW6+uzyrnjd8WnDxtwypgyQ@mail.gmail.com>
Message-ID: <CAL_JsqLC5vAnPjCrr4H3ik_Gh_7vW6+uzyrnjd8WnDxtwypgyQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] of: unittest: Add test for
 of_dma_get_max_cpu_address()
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

On Wed, Oct 14, 2020 at 2:12 PM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> Introduce a test for of_dma_get_max_cup_address(), it uses the same DT
> data as the rest of dma-ranges unit tests.
>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>  drivers/of/unittest.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
> index 06cc988faf78..2cbf2a585c9f 100644
> --- a/drivers/of/unittest.c
> +++ b/drivers/of/unittest.c
> @@ -869,6 +869,25 @@ static void __init of_unittest_changeset(void)
>  #endif
>  }
>
> +static void __init of_unittest_dma_get_max_cpu_address(void)
> +{
> +#ifdef CONFIG_HAS_DMA

Can't the unittest run without this? I run the unittests under UML.

> +       struct device_node *np;
> +       phys_addr_t cpu_addr;
> +
> +       np = of_find_node_by_path("/testcase-data/address-tests");
> +       if (!np) {
> +               pr_err("missing testcase data\n");
> +               return;
> +       }
> +
> +       cpu_addr = of_dma_get_max_cpu_address(np);
> +       unittest(cpu_addr == 0x50000000ULL,
> +                "of_dma_get_max_cpu_address: wrong CPU addr %pad (expecting %llx)\n",
> +                &cpu_addr, 0x50000000ULL);
> +#endif
> +}
> +
>  static void __init of_unittest_dma_ranges_one(const char *path,
>                 u64 expect_dma_addr, u64 expect_paddr)
>  {
> @@ -3266,6 +3285,7 @@ static int __init of_unittest(void)
>         of_unittest_changeset();
>         of_unittest_parse_interrupts();
>         of_unittest_parse_interrupts_extended();
> +       of_unittest_dma_get_max_cpu_address();
>         of_unittest_parse_dma_ranges();
>         of_unittest_pci_dma_ranges();
>         of_unittest_match_node();
> --
> 2.28.0
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
