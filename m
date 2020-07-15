Return-Path: <SRS0=xM8W=A2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F04AC433DF
	for <iommu@archiver.kernel.org>; Wed, 15 Jul 2020 03:48:55 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F074D2074B
	for <iommu@archiver.kernel.org>; Wed, 15 Jul 2020 03:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gXgfsJJ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F074D2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id BC8D021080;
	Wed, 15 Jul 2020 03:48:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E0r8QWvJwzyv; Wed, 15 Jul 2020 03:48:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 520C020456;
	Wed, 15 Jul 2020 03:48:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1AC56C0891;
	Wed, 15 Jul 2020 03:48:53 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2E6CFC0733
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jul 2020 03:48:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1B0158A1E7
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jul 2020 03:48:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J4SGKO0khh-A for <iommu@lists.linux-foundation.org>;
 Wed, 15 Jul 2020 03:48:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
 [209.85.215.193])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 2E7B68A01E
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jul 2020 03:48:51 +0000 (UTC)
Received: by mail-pg1-f193.google.com with SMTP id z5so1933692pgb.6
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 20:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=L1MZa7I2FUiTYOmy499OnTCIjSLBqRD31P7fdisA5IE=;
 b=gXgfsJJ4MdMmnwG64cIsG2YaNVG8hFB09bzTK7A8ECgTeHPHJAszwFZTdL2HmdNeKn
 /FQ/fkWjzPV54P4Hk0AEYpO5EJGVUEka4WxBI4ByQd9Hx3pE0Q2QI54lF8YpXBjj3N2V
 txcmu7iZy9WrLC9w2AjMl6lIngNd24pEUxvuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=L1MZa7I2FUiTYOmy499OnTCIjSLBqRD31P7fdisA5IE=;
 b=pAHCfoP2iYpk0jUUKKab0FORNjiQMJzTpqLlDa2Ww8z5TeFe9y/sKUX7chnRf/Xlkm
 yFGlGvnw8ATNZfLZAAFRBdSEdoZbgf2fbttlquvmIZBB/INsDfA5vwx9Nyd2hFfqSZQ/
 0xVljQ5h/ccfve6+rn9RWJOP70mDtOZlHP3xwMwnTtBTHdnr9iOt/T6nyEnxZxxcxgXz
 HVC9k6u/BtzLw3DOssessH8vIdkZn6R4jthFA0z+G12R5h9ZWcMeVNoyAcY2P452Cwrl
 K9FDECmwatsobVkYwASXIFKDvpmxrdeeeS8t+KnAS54wrCM4hBxBqUKvVbrLTmaxNpnt
 BzMg==
X-Gm-Message-State: AOAM532IRSk55Rm62j0f64rpV3UwNHHn0n/b/19CXvgt6s5kE/ew07K0
 BwUe/OECCaJOE7k3jTAK1ZHxPYc4VG0=
X-Google-Smtp-Source: ABdhPJyD8ELeyrD3o4EsjVXxahQzwqfyel40mjhZoKowEI3pQU4xrXkCOIqkgUPS18zEQsBdTSpasw==
X-Received: by 2002:a5d:8f98:: with SMTP id l24mr8060817iol.141.1594784625216; 
 Tue, 14 Jul 2020 20:43:45 -0700 (PDT)
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com.
 [209.85.166.177])
 by smtp.gmail.com with ESMTPSA id i11sm568046iow.19.2020.07.14.20.43.43
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2020 20:43:44 -0700 (PDT)
Received: by mail-il1-f177.google.com with SMTP id i18so750108ilk.10
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 20:43:43 -0700 (PDT)
X-Received: by 2002:a92:de42:: with SMTP id e2mr7643677ilr.189.1594784623009; 
 Tue, 14 Jul 2020 20:43:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200713091211.2183368-1-tientzu@chromium.org>
 <8a7ce34e-87c0-d224-3974-34f1877fbb0e@arm.com>
In-Reply-To: <8a7ce34e-87c0-d224-3974-34f1877fbb0e@arm.com>
From: Claire Chang <tientzu@chromium.org>
Date: Wed, 15 Jul 2020 11:43:31 +0800
X-Gmail-Original-Message-ID: <CALiNf2_GdC1RSLyYSu+LWXHGQZiAL69zNuW0sowuCDdRWw4HJg@mail.gmail.com>
Message-ID: <CALiNf2_GdC1RSLyYSu+LWXHGQZiAL69zNuW0sowuCDdRWw4HJg@mail.gmail.com>
Subject: Re: [PATCH 0/4] Bounced DMA support
To: Robin Murphy <robin.murphy@arm.com>
Cc: Nicolas Boichat <drinkcat@chromium.org>, devicetree@vger.kernel.org,
 heikki.krogerus@linux.intel.com, saravanak@google.com, suzuki.poulose@arm.com,
 Greg KH <gregkh@linuxfoundation.org>, lkml <linux-kernel@vger.kernel.org>,
 bgolaszewski@baylibre.com, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, dan.j.williams@intel.com, treding@nvidia.com,
 frowand.list@gmail.com, hch@lst.de
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

On Mon, Jul 13, 2020 at 7:40 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2020-07-13 10:12, Claire Chang wrote:
> > This series implements mitigations for lack of DMA access control on
> > systems without an IOMMU, which could result in the DMA accessing the
> > system memory at unexpected times and/or unexpected addresses, possibly
> > leading to data leakage or corruption.
> >
> > For example, we plan to use the PCI-e bus for Wi-Fi and that PCI-e bus
> > is not behind an IOMMU. As PCI-e, by design, gives the device full
> > access to system memory, a vulnerability in the Wi-Fi firmware could
> > easily escalate to a full system exploit (remote wifi exploits: [1a],
> > [1b] that shows a full chain of exploits; [2], [3]).
> >
> > To mitigate the security concerns, we introduce bounced DMA. The bounced
> > DMA ops provide an implementation of DMA ops that bounce streaming DMA
> > in and out of a specially allocated region. The feature on its own
> > provides a basic level of protection against the DMA overwriting buffer
> > contents at unexpected times. However, to protect against general data
> > leakage and system memory corruption, the system needs to provide a way
> > to restrict the DMA to a predefined memory region (this is usually done
> > at firmware level, e.g. in ATF on some ARM platforms).
>
> More to the point, this seems to need some fairly special interconnect
> hardware too. On typical systems that just stick a TZASC directly in
> front of the memory controller it would be hard to block DMA access
> without also blocking CPU access. With something like Arm TZC-400 I
> guess you could set up a "secure" region for most of DRAM that allows NS
> accesses by NSAID from the CPUs, then similar regions for the pools with
> NSAID access for both the respective device and the CPUs, but by that
> point you've probably used up most of the available regions before even
> considering what the firmware and TEE might want for actual Secure memory.
>
> In short, I don't foresee this being used by very many systems.
We're going to use this on MTK SoC with MPU (memory protection unit) to
restrict the DMA access for PCI-e Wi-Fi.
>
> That said,, although the motivation is different, it appears to end up
> being almost exactly the same end result as the POWER secure
> virtualisation thingy (essentially: constrain DMA to a specific portion
> of RAM). The more code can be shared with that, the better.
Could you share a bit more about the POWER secure virtualisation thingy?
>
> > Currently, 32-bit architectures are not supported because of the need to
> > handle HIGHMEM, which increases code complexity and adds more
> > performance penalty for such platforms. Also, bounced DMA can not be
> > enabled on devices behind an IOMMU, as those require an IOMMU-aware
> > implementation of DMA ops and do not require this kind of mitigation
> > anyway.
>
> Note that we do actually have the notion of bounced DMA with IOMMUs
> already (to avoid leakage of unrelated data in the same page). I think
> it's only implemented for intel-iommu so far, but shouldn't take much
> work to generalise to iommu-dma if anyone wanted to. That's already done
> a bunch of work to generalise the SWIOTLB routines to be more reusable,
> so building on top of that would be highly preferable.
Yes, I'm aware of that and I'll try to put this on top of SWIOTLB.
>
> Thirdly, the concept of device-private bounce buffers does in fact
> already exist to some degree too - there are various USB, crypto and
> other devices that can only DMA to a local SRAM buffer (not to mention
> subsystems doing their own bouncing for the sake of alignment/block
> merging/etc.). Again, a slightly more generalised solution that makes
> this a first-class notion for dma-direct itself and could help supplant
> some of those hacks would be really really good.
>
> Robin.
>
> > [1a] https://googleprojectzero.blogspot.com/2017/04/over-air-exploiting-broadcoms-wi-fi_4.html
> > [1b] https://googleprojectzero.blogspot.com/2017/04/over-air-exploiting-broadcoms-wi-fi_11.html
> > [2] https://blade.tencent.com/en/advisories/qualpwn/
> > [3] https://www.bleepingcomputer.com/news/security/vulnerabilities-found-in-highly-popular-firmware-for-wifi-chips/
> >
> >
> > Claire Chang (4):
> >    dma-mapping: Add bounced DMA ops
> >    dma-mapping: Add bounced DMA pool
> >    dt-bindings: of: Add plumbing for bounced DMA pool
> >    of: Add plumbing for bounced DMA pool
> >
> >   .../reserved-memory/reserved-memory.txt       |  36 +++
> >   drivers/of/address.c                          |  37 +++
> >   drivers/of/device.c                           |   3 +
> >   drivers/of/of_private.h                       |   6 +
> >   include/linux/device.h                        |   3 +
> >   include/linux/dma-mapping.h                   |   1 +
> >   kernel/dma/Kconfig                            |  17 +
> >   kernel/dma/Makefile                           |   1 +
> >   kernel/dma/bounced.c                          | 304 ++++++++++++++++++
> >   9 files changed, 408 insertions(+)
> >   create mode 100644 kernel/dma/bounced.c
> >
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
