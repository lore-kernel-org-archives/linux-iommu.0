Return-Path: <SRS0=qNYd=BA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4466C433E6
	for <iommu@archiver.kernel.org>; Tue, 21 Jul 2020 15:23:08 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 786862065F
	for <iommu@archiver.kernel.org>; Tue, 21 Jul 2020 15:23:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gw/h84t5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 786862065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2EE5C226AF;
	Tue, 21 Jul 2020 15:23:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f6SMp0SUG1K8; Tue, 21 Jul 2020 15:23:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 239BB203B9;
	Tue, 21 Jul 2020 15:23:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 19876C088E;
	Tue, 21 Jul 2020 15:23:05 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A1DA1C016F
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jul 2020 15:23:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 9BF71226AF
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jul 2020 15:23:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JUBicEfAzvJC for <iommu@lists.linux-foundation.org>;
 Tue, 21 Jul 2020 15:23:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 by silver.osuosl.org (Postfix) with ESMTPS id 4F40E22270
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jul 2020 15:23:02 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id a14so6753731wra.5
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jul 2020 08:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rjr3hOmDcg0k+YJ+y9Vtua3YshVZwwPlHwMwMv1uMsg=;
 b=gw/h84t5RF8NJH72MgGhtMzcUPSl1FhrUrxZuEUVe+HFrO/xYwk3WfJ/vOlKnLJkY7
 b4fTHfPO4xH0esscUx8Wg1xqeaR185DFKcMnj7eLHf7eXnbQ5S2zjcqCCMrNqXrg4uxa
 kT4X1yvYHYvfR945jIKeVPfiklyIwUG5TwbgaapycBoGncCf/OG6X5Co8pPeXJJq1GDF
 BZ29GRpQ0MdNJII58imEhBewYsjc+MACMoruSBon8h3eI0J2FPLJClOB8s422EOKPbUh
 Sd/Fgrj1yMGJIYdZZ88CUM/vABZ0Z6OW3ZCOYDIs6DS/2EoOiteHYS/s0p6lQw6tb3tN
 9KtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rjr3hOmDcg0k+YJ+y9Vtua3YshVZwwPlHwMwMv1uMsg=;
 b=Y5HnMr0GAGexH332qiyltA2gdCH2WJPBlV0J6UG6syl/dIoy47AE4eU5l9yo+cuoTi
 XqO+/xv9c1L40Z+g3Zbu6hkRSEeUC9M/LovEno/1IYM8WgP+Yn43J7V36Jk1OgdI1Pf/
 e+8J9gzFHLoSUr9yLD3cqBB1NNPNZo/9UmG5yhI5H6pzVGo1jU8/1dMIWCMFEG78SlrJ
 9dUvZ+Nk55ClK2+V+PrGB/WfhzEFN5SCD5knzVDLUFpgo21g4M/QtRih11GufJAmEaPS
 Dw42SpVYKi6YevIhHsVDsNc586uAwd26aDQbT/waUlqqUSt1RuTcQ/garcQNXAvDxGqw
 1xAg==
X-Gm-Message-State: AOAM532vvskrURCZuDpicXmZmUDvXh4GOnaxmQiHchjexZReSDyFOlvL
 BhoEno8tGJD3jqDKHtvI7pmexcr7On1YNIrYSlqjqg==
X-Google-Smtp-Source: ABdhPJyZ2CYgqXoWpElRrDtFpve+aiQv8d5QjtVAfAUkHJ/Bn2wBT3fAyyIyfFVyQZSWnsx2/lT6LwQYCsvPyqnIT4M=
X-Received: by 2002:adf:fc06:: with SMTP id i6mr8845332wrr.79.1595344980632;
 Tue, 21 Jul 2020 08:23:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200708164936.9340-1-nsaenzjulienne@suse.de>
 <CAMi1Hd35tRM=cnmzwX=SDgu-OoXi1Xj+twFkoULaVZBbTpe6sw@mail.gmail.com>
 <550b30a86c0785049d24c945e2c6628d491cee3a.camel@suse.de>
 <CAMi1Hd2V2pJjP=USS4r-Z3vK-aq7_aBy-jcVNk1GvbdEQAuzWg@mail.gmail.com>
 <011994f8a717a00dcd9ed7682a1ddeb421c2c43f.camel@suse.de>
 <CAMi1Hd0=ZsGhTkSy221EP9Vb3GMOcS0UMczX2u5X9qK37_ea1A@mail.gmail.com>
 <01831596e4a2a6c9c066138b23bd30435f8e5569.camel@suse.de>
In-Reply-To: <01831596e4a2a6c9c066138b23bd30435f8e5569.camel@suse.de>
From: Amit Pundir <amit.pundir@linaro.org>
Date: Tue, 21 Jul 2020 20:52:24 +0530
Message-ID: <CAMi1Hd3C6kh5E49EgytBAQ_2AE_jvnp+eSNsxBYaux+exSvdbg@mail.gmail.com>
Subject: Re: [PATCH] dma-pool: Do not allocate pool memory from CMA
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: lkml <linux-kernel@vger.kernel.org>, jeremy.linton@arm.com,
 Sumit Semwal <sumit.semwal@linaro.org>, iommu@lists.linux-foundation.org,
 John Stultz <john.stultz@linaro.org>, linux-rpi-kernel@lists.infradead.org,
 David Rientjes <rientjes@google.com>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>
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

On Tue, 21 Jul 2020 at 18:15, Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> On Tue, 2020-07-21 at 17:45 +0530, Amit Pundir wrote:
> > On Tue, 21 Jul 2020 at 16:45, Nicolas Saenz Julienne
> > <nsaenzjulienne@suse.de> wrote:
> > > On Tue, 2020-07-21 at 14:24 +0530, Amit Pundir wrote:
> > > > On Tue, 21 Jul 2020 at 14:09, Nicolas Saenz Julienne
> > > > <nsaenzjulienne@suse.de> wrote:
> > > > > Hi Amit,
> > > > > > Hi Nicolas,
> > > > > >
> > > > > > I see a boot regression with this commit d9765e41d8e9 "dma-
> > > > > > pool:
> > > > > > Do not allocate pool memory from CMA" on my Xiaomi Poco F1
> > > > > > (Qcom sdm845) phone running v5.8-rc6. I can't boot past the
> > > > > > bootloader splash screen with this patch.
> > > > > >
> > > > > > Phone boots fine if I revert this patch. I carry only one out
> > > > > > of
> > > > > > tree
> > > > > > dts patch https://lkml.org/lkml/2020/6/25/52. And since this
> > > > > > is a
> > > > > > stock
> > > > > > phone, I don't have access to serial/dmesg logs until I boot
> > > > > > to
> > > > > > AOSP
> > > > > > (adb) shell.
> > > > > >
> > > > > > Any thoughts as to what might be going wrong here? I'd be
> > > > > > happy
> > > > > > to
> > > > > > help debug things. For what it's worth, I don't see this
> > > > > > regression
> > > > > > on
> > > > > > other two sdm845 devices (db845c and Pixel 3) I tested on.
> > > > >
> > > > > Can you provide a boot log (even if without my patch) and the
> > > > > device-
> > > > > tree files? It'd help a lot figuring things out.
> > > >
> > > > Thank you for the prompt reply Nicolas.
> > > >
> > > > Here is the boot log with the reverted patch
> > > > https://pastebin.ubuntu.com/p/BrhPf83nKF/
> > > >
> > > > Here is my phone's dts
> > > > https://github.com/pundiramit/linux/commit/2a394c199deeaf4c91e0e008e8fba2a72f494d8c
> > >
> > > I'm at loss at what could be failing here. Your device should be
> > > able
> > > to address the whole 8GB memory space, which AFAIK is the max
> > > available
> > > on that smartphone family. But maybe the device-tree is lying, who
> > > knows...
> >
> > If it helps, my phone has 6GB memory space.
> >
> > > Can you try booting *without* my patch and this in the kernel
> > > command
> > > line: "cma=16M@0x100000000-0x200000000".
> >
> > It doesn't boot with this added kernel command line.
>
>
> For the record, this placed the CMA in the [4GB, 8GB] address space
> instead of you setup's default: [3GB, 4GB]. All atomic pools fall in
> that memory area without my patch, which makes me think some of the
> devices on your board might not like higher addresses.
>

Thank you Nicolas for the details. Though we don't set the CMA
alloc-ranges explicitly in upstream sdm845 dts, but I dug around and
found that CMA alloc-ranges in the downstream kernel are indeed in
lower address space.
https://github.com/MiCode/Xiaomi_Kernel_OpenSource/blob/dipper-q-oss/arch/arm64/boot/dts/qcom/sdm845.dtsi#L662

/* global autoconfigured region for contiguous allocations */
linux,cma {
        compatible = "shared-dma-pool";
        alloc-ranges = <0 0x00000000 0 0xffffffff>;
        reusable;
        alignment = <0 0x400000>;
        size = <0 0x2000000>;
        linux,cma-default;
};

> What happens if you boot with my troublesome patch with this in your
> device tree? (insert it at the bottom of sdm845-beryllium.dts)
>
> &soc {
>         dma-ranges = <0 0 0 0 0x1 0>;
> };
>

Device still doesn't boot up to adb shell.

Regards,
Amit Pundir

> Regards,
> Nicolas
>
> > Regards,
> > Amit Pundir
> >
> > > Regards,
> > > Nicolas
> > >
> > > And here is my kernel tree just in case
> > > > https://github.com/pundiramit/linux/commits/beryllium-mainline
> > > >
> > > > Regards,
> > > > Amit Pundir
> > > >
> > > >
> > > > > Regards,
> > > > > Nicolas
> > > > >
> > > > > > Regards,
> > > > > > Amit Pundir
> > > > > >
> > > > > > > Reported-by: Jeremy Linton <jeremy.linton@arm.com>
> > > > > > > Signed-off-by: Nicolas Saenz Julienne <
> > > > > > > nsaenzjulienne@suse.de>
> > > > > > > ---
> > > > > > >
> > > > > > > An more costly alternative would be adding an option to
> > > > > > > dma_alloc_from_contiguous() so it fails when the allocation
> > > > > > > doesn't
> > > > > > > fall
> > > > > > > in a specific zone.
> > > > > > >
> > > > > > >  kernel/dma/pool.c | 11 ++---------
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
