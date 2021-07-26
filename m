Return-Path: <SRS0=C8jr=MS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A4DC4338F
	for <iommu@archiver.kernel.org>; Mon, 26 Jul 2021 22:48:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45B05603E9
	for <iommu@archiver.kernel.org>; Mon, 26 Jul 2021 22:48:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 45B05603E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atishpatra.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0C0F8607BF;
	Mon, 26 Jul 2021 22:48:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0aqYYwNacK7q; Mon, 26 Jul 2021 22:48:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5710560654;
	Mon, 26 Jul 2021 22:48:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 28F8AC0010;
	Mon, 26 Jul 2021 22:48:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27075C000E
 for <iommu@lists.linux-foundation.org>; Mon, 26 Jul 2021 22:48:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0E24383474
 for <iommu@lists.linux-foundation.org>; Mon, 26 Jul 2021 22:48:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=atishpatra.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nx1j8fkgzpXF for <iommu@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 22:48:06 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 20A9A83438
 for <iommu@lists.linux-foundation.org>; Mon, 26 Jul 2021 22:48:06 +0000 (UTC)
Received: by mail-yb1-xb35.google.com with SMTP id d73so17437850ybc.10
 for <iommu@lists.linux-foundation.org>; Mon, 26 Jul 2021 15:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=atishpatra.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BvsqUUy/O01l4CBRzfrPE1Jc7wO/JNGVxsEuCcHSCWw=;
 b=Oj1mDz93drUb82Y4dwGcG6EgM1Z32HcAKJ4YfgJCNUqNIvF/kV3bQ3NHUCklnTy4SW
 1GD2cx3JJGrezXOK+L9wjvpJ96IV67qydn4ANvKcp7SDWJs80YFbIdORNMRlexi21vaX
 bIzr8ywtm1/QqdYt2jpgnb8HNzTEWOFg+DmXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BvsqUUy/O01l4CBRzfrPE1Jc7wO/JNGVxsEuCcHSCWw=;
 b=JyF1fABC+otqwuvNcxw/UHhkp+y/oTUneYmyEgqrqdFQjZLqy99QP7MYBTd+/U+kG8
 PIWDNUnWxvEnwWnjEiib4xpdvEZL+REp+ffQ9cES3jIKqrxdFRWEhQ2DpAhjqTFfs8Dw
 f85joi+G4pCv0csI19/eSlVcSesTTNQmZYqm7n2TFMBtbh7PdQ+F/tyabXjzoxFALAJW
 vvCrpBsHLijlawjSE/S26m5RznTytsSc3ZZN6dleMf5GY6kx9fAoDPmW4HI/6RfUOBIa
 QQHQBUezs7HcevO/ma9vH8tpzyrNPu3k195OMxXUFiuVGYpsTIjVuHHr5iMo2G6zap+P
 lAwQ==
X-Gm-Message-State: AOAM533k2WG7NwUzKIHAL65uW39XnU/RsdZckeXdGCVgO0H7TwsK33sk
 Drw5o7C8grotm6kCFq20+XLs8QU2gUQFT8VTGL8T
X-Google-Smtp-Source: ABdhPJz2EUkj2zAeJLmOGn6kDSu8McU02FKdlq3ZbpM5EcX89ffvE35I5g7gwLzw3lEJ0O8h/gzUiEZysEgj2Z7EPDA=
X-Received: by 2002:a25:3289:: with SMTP id y131mr5835871yby.317.1627339684970; 
 Mon, 26 Jul 2021 15:48:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210723214031.3251801-1-atish.patra@wdc.com>
 <20210723214031.3251801-4-atish.patra@wdc.com>
 <20210726070030.GB9035@lst.de>
In-Reply-To: <20210726070030.GB9035@lst.de>
From: Atish Patra <atishp@atishpatra.org>
Date: Mon, 26 Jul 2021 15:47:54 -0700
Message-ID: <CAOnJCU+qRznBTn9Mt6t_DE6UUz6_LuaBBuOmnURS2Yh3pmpjvg@mail.gmail.com>
Subject: Re: [RFC 3/5] dma-mapping: Enable global non-coherent pool support
 for RISC-V
To: Christoph Hellwig <hch@lst.de>
Cc: devicetree <devicetree@vger.kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
 Guo Ren <guoren@linux.alibaba.com>, Frank Rowand <frowand.list@gmail.com>,
 "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
 Atish Patra <atish.patra@wdc.com>, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Tobias Klauser <tklauser@distanz.ch>,
 Robin Murphy <robin.murphy@arm.com>,
 linux-riscv <linux-riscv@lists.infradead.org>,
 Dmitry Vyukov <dvyukov@google.com>
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

On Mon, Jul 26, 2021 at 12:00 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, Jul 23, 2021 at 02:40:29PM -0700, Atish Patra wrote:
> > Currently, linux,dma-default is used to reserve a global non-coherent pool
> > to allocate memory for dma operations. This can be useful for RISC-V as
> > well as the ISA specification doesn't specify a method to modify PMA
> > attributes or page table entries to define non-cacheable area yet.
> > A non-cacheable memory window is an alternate options for vendors to
> > support non-coherent devices.
>
> Please explain why you do not want to use the simply non-cachable
> window support using arch_dma_set_uncached as used by mips, niops2 and
> xtensa.
>

arch_dma_set_uncached works as well in this case. However, mips,
niops2 & xtensa uses a
fixed (via config) value for the offset. Similar approach can't be
used here because the platform specific
offset value has to be determined at runtime so that a single kernel
image can boot on all platforms.
That's why we need the following additional changes for RISC-V to make it work.

1. a new DT property so that arch specific code is aware of the
non-cacheable window offset.
    - either under /chosen node or a completely separate node with
multiple non-cacheable window support
   We also need to define how it is going to referenced from
individual device if a per-device non-cacheable
   window support is required in future. As of now, the beagleV memory
region lies in 0x10_0000_00000 - x17_FFFF_FFFF
   which is mapped to start of DRAM 0x80000000. All of the
non-coherent devices can do 32bit DMA only.

2. Use the dma-ranges and modify the arch_dma_set_uncached function to
pass the struct device as an argument.

Either way, we will need arch specific hook ups and additional changes
while the global non-coherent pool
provides a more elegant solution without any additional arch specific code.

If arch_dma_set_uncached is still preferred way to solve this problem,
I can revise the patch with either approach 1 or approach 2

> > +static int __dma_init_global_coherent(phys_addr_t phys_addr, dma_addr_t device_addr, size_t size)
>
>
>
>
> >  {
> >       struct dma_coherent_mem *mem;
> >
> > -     mem = dma_init_coherent_memory(phys_addr, phys_addr, size, true);
> > +     if (phys_addr == device_addr)
> > +             mem = dma_init_coherent_memory(phys_addr, device_addr, size, true);
> > +     else
> > +             mem = dma_init_coherent_memory(phys_addr, device_addr, size, false);
>
> Nak.  The phys_addr != device_addr support is goign away.  This needs

ok.

> to be filled in using dma-ranges property hanging of the struct device.

struct device is only accessible in rmem_dma_device_init. I couldn't
find a proper way to access it during
dma_reserved_default_memory setup under global pool.

Does that mean we should use a per-device memory pool instead of a
global non-coherent pool ?

> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu



-- 
Regards,
Atish
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
