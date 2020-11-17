Return-Path: <SRS0=JfyE=EX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AAA7C63697
	for <iommu@archiver.kernel.org>; Tue, 17 Nov 2020 21:29:45 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A58224181
	for <iommu@archiver.kernel.org>; Tue, 17 Nov 2020 21:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VC75sZ0s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A58224181
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0B1BD86FC6;
	Tue, 17 Nov 2020 21:29:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ajcB-o3Fwx0S; Tue, 17 Nov 2020 21:29:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 195F486FBF;
	Tue, 17 Nov 2020 21:29:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 09F4BC0800;
	Tue, 17 Nov 2020 21:29:42 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B25F7C07FF
 for <iommu@lists.linux-foundation.org>; Tue, 17 Nov 2020 21:29:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9953485085
 for <iommu@lists.linux-foundation.org>; Tue, 17 Nov 2020 21:29:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jCDsnOq731Pe for <iommu@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 21:29:39 +0000 (UTC)
X-Greylist: delayed 00:08:04 by SQLgrey-1.7.6
Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com
 [209.85.167.193])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 7C90F85082
 for <iommu@lists.linux-foundation.org>; Tue, 17 Nov 2020 21:29:39 +0000 (UTC)
Received: by mail-oi1-f193.google.com with SMTP id t16so24175912oie.11
 for <iommu@lists.linux-foundation.org>; Tue, 17 Nov 2020 13:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qaFR/vbXEE/Fp6N4YA11Mip+TFc+3mxIxAGB0BrXskE=;
 b=VC75sZ0sI622cqRm8NQfeG/nHdIrHJG5hf4nb18w5Ezfn7dMY95pE7f6ymO6jyVG5b
 RHrNPQPAkIvmJQcyxl/7knSpyGi+tr36KXPjdVxT8PNSHF++jwPSbnADEtdQfMS8xGvM
 xybni7VT4JkWf5GIe8nK7+qGTJhJlnTpen1Hc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qaFR/vbXEE/Fp6N4YA11Mip+TFc+3mxIxAGB0BrXskE=;
 b=Wgkrf+/+pYrKAJhFJafjrq6GKFNvLYpCdrSUu/3IFKXua5nkAueG9rKLctTkMB6WaW
 v6dUr+0a8PKT4xwWchtFDYufmQELLOMV+SW8hfm2RoioU119JYBofRw07O9DXlEJDCzU
 AuglGbEDlWFoM3bzL3DfQiJYDIZ83BR2QFiCh+1Aes2LC0MonwbE1HUx8sVY4d+i6HMn
 WDQfDesAOIaGOn/gzGKZntz8W1a2WMDIsP9lZVVUK65tE+ifjOXbNvpXWper7hB6jXFT
 QPYXee5ZJ/57VZjkX55SRsJwUW7UL/6mbgAkS1qX3s806ANWos149kLg7S7tv/SHiDox
 aNwQ==
X-Gm-Message-State: AOAM530aNqw3u0p+6SWHOn8hqQx7IdjreoVfb4+jBDt8DdERzLLRIhMG
 7XTNQ9fyg0B1/9JauzPmja120ppghjeJQ7JP
X-Google-Smtp-Source: ABdhPJySVU2CmSPZ7EK7XwQu/p5gj3X3AGh7VJ9X0SPN7gjkBmBvQDVWfhCvCwt5pmsA+MvHvtqE7A==
X-Received: by 2002:aca:c311:: with SMTP id t17mr769481oif.46.1605648094443;
 Tue, 17 Nov 2020 13:21:34 -0800 (PST)
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com.
 [209.85.167.173])
 by smtp.gmail.com with ESMTPSA id q10sm6507112oih.56.2020.11.17.13.21.32
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2020 13:21:33 -0800 (PST)
Received: by mail-oi1-f173.google.com with SMTP id d9so24208604oib.3
 for <iommu@lists.linux-foundation.org>; Tue, 17 Nov 2020 13:21:32 -0800 (PST)
X-Received: by 2002:aca:7506:: with SMTP id q6mr742413oic.128.1605648092412;
 Tue, 17 Nov 2020 13:21:32 -0800 (PST)
MIME-Version: 1.0
References: <20200930160917.1234225-1-hch@lst.de>
 <20200930160917.1234225-9-hch@lst.de>
 <CAAFQd5CttttqMXb=iDPb+Z0WGUa2g=W6JwXJ-5HbhmrDyxP+cQ@mail.gmail.com>
 <CANiDSCtefXKw-xC3bskyggW-BzCmVPj6GGLvO=cCPZHbS1oTDA@mail.gmail.com>
 <20201110092506.GA24469@lst.de>
 <CANiDSCsBUBV1WA2To9x26Uhc5SU-4xuh3m4wUwXBcGwA6n8now@mail.gmail.com>
 <CAAFQd5CCOrp0OA_n_SHNO5RAhV-MQ2KuQJA+oWHQ76h_So=M2Q@mail.gmail.com>
 <20201110095747.GA26574@lst.de>
In-Reply-To: <20201110095747.GA26574@lst.de>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 17 Nov 2020 22:21:21 +0100
X-Gmail-Original-Message-ID: <CANiDSCtbZHe2pqKj+=DbEODBSNy1hrysTOAHYbTG4_DRBmH00A@mail.gmail.com>
Message-ID: <CANiDSCtbZHe2pqKj+=DbEODBSNy1hrysTOAHYbTG4_DRBmH00A@mail.gmail.com>
Subject: Re: [PATCH 8/8] WIP: add a dma_alloc_contiguous API
To: Christoph Hellwig <hch@lst.de>
Cc: Linux Media Mailing List <linux-media@vger.kernel.org>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
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

Hi Christoph

I have been testing with real hardware on arm64 your patchset. And uvc
performs 20 times better using Kieran's test

https://github.com/ribalda/linux/tree/uvc-noncontiguous

These are the result of running   yavta --capture=1000


dma_alloc_noncontiguous

frames:  999
packets: 999
empty:   0 (0 %)
errors:  0
invalid: 0
pts: 0 early, 0 initial, 999 ok
scr: 0 count ok, 0 diff ok
sof: 2048 <= sof <= 0, freq 0.000 kHz
bytes 78466000 : duration 33303
FPS: 29.99
URB: 418105/5000 uS/qty: 83.621 avg 98.783 std 17.396 min 1264.688 max (uS)
header: 100040/5000 uS/qty: 20.008 avg 19.458 std 2.969 min 454.167 max (uS)
latency: 347653/5000 uS/qty: 69.530 avg 98.937 std 9.114 min 1256.875 max (uS)
decode: 70452/5000 uS/qty: 14.090 avg 11.547 std 6.146 min 271.510 max (uS)
raw decode speed: 8.967 Gbits/s
raw URB handling speed: 1.501 Gbits/s
throughput: 18.848 Mbits/s
URB decode CPU usage 0.211500 %


usb_alloc_coherent

frames:  999
packets: 999
empty:   0 (0 %)
errors:  0
invalid: 0
pts: 0 early, 0 initial, 999 ok
scr: 0 count ok, 0 diff ok
sof: 2048 <= sof <= 0, freq 0.000 kHz
bytes 70501712 : duration 33319
FPS: 29.98
URB: 1854128/5000 uS/qty: 370.825 avg 417.133 std 14.539 min 2875.760 max (uS)
header: 98765/5000 uS/qty: 19.753 avg 30.714 std 1.042 min 573.463 max (uS)
latency: 453316/5000 uS/qty: 90.663 avg 114.987 std 4.065 min 860.795 max (uS)
decode: 1400811/5000 uS/qty: 280.162 avg 330.786 std 6.305 min 2758.202 max (uS)
raw decode speed: 402.866 Mbits/s
raw URB handling speed: 304.214 Mbits/s
throughput: 16.927 Mbits/s
URB decode CPU usage 4.204200 %


Best regards

On Tue, Nov 10, 2020 at 10:57 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Nov 10, 2020 at 06:50:32PM +0900, Tomasz Figa wrote:
> > In what terms it doesn't actually work? Last time I checked some
> > platforms actually defined CONFIG_DMA_NONCOHERENT, so those would
> > instead use the kmalloc() + dma_map() path. I don't have any
> > background on why that was added and whether it needs to be preserved,
> > though. Kieran, Laurent, do you have any insight?
>
> CONFIG_DMA_NONCOHERENT is set on sh and mips for platforms that may
> support non-coherent DMA at compile time (but at least for mips that
> doesn't actually means this gets used).  Using that ifdef to decide
> on using usb_alloc_coherent vs letting the usb layer map the data
> seems at best odd, and if we are unlucky papering over a bug somewhere.



-- 
Ricardo Ribalda
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
