Return-Path: <SRS0=oIyp=GY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E22C433E0
	for <iommu@archiver.kernel.org>; Thu, 21 Jan 2021 07:43:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 297462396D
	for <iommu@archiver.kernel.org>; Thu, 21 Jan 2021 07:43:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 297462396D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id B78B885CD5;
	Thu, 21 Jan 2021 07:43:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MQbnkBw-UoNB; Thu, 21 Jan 2021 07:43:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 29CFA84F5C;
	Thu, 21 Jan 2021 07:43:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0C12CC088B;
	Thu, 21 Jan 2021 07:43:10 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B682CC013A
 for <iommu@lists.linux-foundation.org>; Thu, 21 Jan 2021 07:43:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B1B7086F8D
 for <iommu@lists.linux-foundation.org>; Thu, 21 Jan 2021 07:43:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bRgMzXGAspWP for <iommu@lists.linux-foundation.org>;
 Thu, 21 Jan 2021 07:43:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C845886ECC
 for <iommu@lists.linux-foundation.org>; Thu, 21 Jan 2021 07:43:07 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id 7so748684wrz.0
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 23:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kgam/JcAMv4/Hclb81fC+FVrhWIpAb1YZ0aXLXlhAoU=;
 b=tGcaXPu2LOMfxg2jDro99XXVO4QDl9TAdMXYImUZZpAzTfVfLuV+7+4TeKdjso38EZ
 ki/MN1Mbn6qQjl/+vdOiYLRcfAr6TZHUKRhcaecJehpzoYSXcwirGlaOSUK2faF4//7p
 O8zLHUbXiMrKyAPbN2pkwWS05Kl7AsGeAZdNK5v1Idh6D0FwYi+6zjeAg1kVHv7P4v4p
 Ti2M5kTAPCGSzfCqQi8knReYvvqdvVeHrE/Sm8M/jMDbHpIKAtNvZJanq5vL+4+dkzgB
 yXsoFRN2ZZbuK+zLKPNAYkcyOZWgw53p8BzUHcT6j62g6eLz76TTXMRpemvM4LcM4kvP
 LJeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kgam/JcAMv4/Hclb81fC+FVrhWIpAb1YZ0aXLXlhAoU=;
 b=JimmIgv8br+DtjKGgZWnl852dHhk53vfOnat43UInFLTRllsBUVYPAwnNTI+NMgkfN
 w1qP8VxoZAi6jdJDSg7BU+g+feciOSJIxuOsN6xqc7o+hcUIqCrfdr5THRJO0JQjAqau
 j8Q4jiHHnaD03IwJlV+u4mPlqfYEXkHZH8xb90uuaJt0IRaP+eiEXmhyUSrHTNgGV6gf
 8DjkixxEmSk8pTU/589iYbT3bdg+CYmChbupdwCed6fpsQzF36RHen7te4rvR5gY3dmQ
 pNHo0V84ncwGaCkHcyLcDzFyS0mj9QY7HGEx3D4fhCvW+nuqz5QPbAPcIsj3wiiw+cYm
 cSyQ==
X-Gm-Message-State: AOAM5305NUq21Md3Qr9N8r2AlodoUDEdVNNvwFJTGY3nFOMS+iFMekCn
 OFkxsTw8cYtAqn4QmHhzsMiV08tXNPGCcxiobcc=
X-Google-Smtp-Source: ABdhPJwzMl4PpyMqGnMviLbKnQbsLou+EJWi88QswY7xQEmVfHG1Cs+1CbAzbJ4rIlMeILSLe4VqP+/Abfquaw+c/vo=
X-Received: by 2002:adf:9427:: with SMTP id 36mr12828885wrq.271.1611214986136; 
 Wed, 20 Jan 2021 23:43:06 -0800 (PST)
MIME-Version: 1.0
References: <20210108113851.354947-1-zhang.lyra@gmail.com>
 <20210108113851.354947-3-zhang.lyra@gmail.com>
 <47f73502-15fe-5d65-6fc9-22eb078d7797@arm.com>
 <CAAfSe-vd5eRopOBZMuTi8vq1FqY1qAVSdMHscVuA+uHtL2H=gw@mail.gmail.com>
 <3a2561fc-65a6-4c68-fdb7-a5b670706f43@arm.com>
In-Reply-To: <3a2561fc-65a6-4c68-fdb7-a5b670706f43@arm.com>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Thu, 21 Jan 2021 15:42:30 +0800
Message-ID: <CAAfSe-tgyTp7BYwfhH7xevhdgj5riNET53A=+K6vKsGwrxtFDw@mail.gmail.com>
Subject: Re: [RFC PATCH V2 2/2] iommu: add Unisoc iommu basic driver
To: Robin Murphy <robin.murphy@arm.com>
Cc: DTML <devicetree@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Chunyan Zhang <chunyan.zhang@unisoc.com>, Sheng Xu <sheng.xu@unisoc.com>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 Kevin Tang <kevin.tang@unisoc.com>, Baolin Wang <baolin.wang7@gmail.com>,
 Orson Zhai <orsonzhai@gmail.com>
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

On Wed, 20 Jan 2021 at 20:29, Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-01-20 11:40, Chunyan Zhang wrote:
> [...]
> >>> +     pgt_base_iova = dom->pgt_va +
> >>> +             ((iova - mdata->iova_start) >> SPRD_IOMMU_PAGE_SHIFT);
> >>> +
> >>> +     spin_lock_irqsave(&dom->pgtlock, flags);
> >>> +     for (i = 0; i < page_num; i++) {
> >>> +             pgt_base_iova[i] = pabase >> SPRD_IOMMU_PAGE_SHIFT;
> >>
> >> Out of curiosity, is the pagetable walker cache-coherent, or is this
> >> currently managing to work by pure chance and natural cache churn?
> >
> > ->iotlb_sync_map() was implemented in this driver, I guess that has
> > done what you say here?
>
> No, sync_map only ensures that the previous (invalid) PTE isn't held in
> the IOMMU's TLB. If pgt_va is a regular page allocation then you're
> writing the new PTE to normal kernel memory, with nothing to guarantee
> that write goes any further than the CPU's L1 cache. Thus either the
> IOMMU has capable of snooping the CPU caches in order to see the updated
> PTE value (rather than refetching the stale value from DRAM), or you're
> just incredibly lucky that by the time the IOMMU *does* go to fetch the
> PTE for that address, that updated cache line has already been evicted
> out to DRAM naturally.
>

Got it, thanks for the detailed explanation.
In order to make clear why this code can work, I made a test, and
found that if I wrote more than 1024 PTEs, the value would be updated
to DRAM immediately, otherwise the cache line seems not updated even
if I wrote 1023 PTEs.

> This is not an issue if you use the proper DMA allocator, since that
> will ensure you get a non-cacheable buffer if you need one.
>

I will switch to use dma_alloc_coherent().

Thanks again.

Chunyan

> Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
