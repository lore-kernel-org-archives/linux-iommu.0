Return-Path: <SRS0=qNYd=BA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70020C433E2
	for <iommu@archiver.kernel.org>; Tue, 21 Jul 2020 11:15:32 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4284E2077D
	for <iommu@archiver.kernel.org>; Tue, 21 Jul 2020 11:15:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4284E2077D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0CCE0874BC;
	Tue, 21 Jul 2020 11:15:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ba6U0z3YG-QN; Tue, 21 Jul 2020 11:15:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A52DF874B3;
	Tue, 21 Jul 2020 11:15:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8794EC088E;
	Tue, 21 Jul 2020 11:15:30 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 04CB3C016F
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jul 2020 11:15:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id D9456229A3
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jul 2020 11:15:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3-hR8LYFMzoe for <iommu@lists.linux-foundation.org>;
 Tue, 21 Jul 2020 11:15:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by silver.osuosl.org (Postfix) with ESMTPS id 5681523A18
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jul 2020 11:15:27 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 26D5EAD12;
 Tue, 21 Jul 2020 11:15:32 +0000 (UTC)
Message-ID: <011994f8a717a00dcd9ed7682a1ddeb421c2c43f.camel@suse.de>
Subject: Re: [PATCH] dma-pool: Do not allocate pool memory from CMA
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: Amit Pundir <amit.pundir@linaro.org>
Date: Tue, 21 Jul 2020 13:15:23 +0200
In-Reply-To: <CAMi1Hd2V2pJjP=USS4r-Z3vK-aq7_aBy-jcVNk1GvbdEQAuzWg@mail.gmail.com>
References: <20200708164936.9340-1-nsaenzjulienne@suse.de>
 <CAMi1Hd35tRM=cnmzwX=SDgu-OoXi1Xj+twFkoULaVZBbTpe6sw@mail.gmail.com>
 <550b30a86c0785049d24c945e2c6628d491cee3a.camel@suse.de>
 <CAMi1Hd2V2pJjP=USS4r-Z3vK-aq7_aBy-jcVNk1GvbdEQAuzWg@mail.gmail.com>
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
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

On Tue, 2020-07-21 at 14:24 +0530, Amit Pundir wrote:
> On Tue, 21 Jul 2020 at 14:09, Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de> wrote:
> > Hi Amit,
> > > Hi Nicolas,
> > > 
> > > I see a boot regression with this commit d9765e41d8e9 "dma-pool:
> > > Do not allocate pool memory from CMA" on my Xiaomi Poco F1
> > > (Qcom sdm845) phone running v5.8-rc6. I can't boot past the
> > > bootloader splash screen with this patch.
> > > 
> > > Phone boots fine if I revert this patch. I carry only one out of
> > > tree
> > > dts patch https://lkml.org/lkml/2020/6/25/52. And since this is a
> > > stock
> > > phone, I don't have access to serial/dmesg logs until I boot to
> > > AOSP
> > > (adb) shell.
> > > 
> > > Any thoughts as to what might be going wrong here? I'd be happy
> > > to
> > > help debug things. For what it's worth, I don't see this
> > > regression
> > > on
> > > other two sdm845 devices (db845c and Pixel 3) I tested on.
> > 
> > Can you provide a boot log (even if without my patch) and the
> > device-
> > tree files? It'd help a lot figuring things out.
> 
> Thank you for the prompt reply Nicolas.
> 
> Here is the boot log with the reverted patch
> https://pastebin.ubuntu.com/p/BrhPf83nKF/
> 
> Here is my phone's dts
> https://github.com/pundiramit/linux/commit/2a394c199deeaf4c91e0e008e8fba2a72f494d8c

I'm at loss at what could be failing here. Your device should be able
to address the whole 8GB memory space, which AFAIK is the max available
on that smartphone family. But maybe the device-tree is lying, who
knows...

Can you try booting *without* my patch and this in the kernel command
line: "cma=16M@0x100000000-0x200000000".

Regards,
Nicolas

And here is my kernel tree just in case
> https://github.com/pundiramit/linux/commits/beryllium-mainline
> 
> Regards,
> Amit Pundir
> 
> 
> > Regards,
> > Nicolas
> > 
> > > Regards,
> > > Amit Pundir
> > > 
> > > > Reported-by: Jeremy Linton <jeremy.linton@arm.com>
> > > > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > > > ---
> > > > 
> > > > An more costly alternative would be adding an option to
> > > > dma_alloc_from_contiguous() so it fails when the allocation
> > > > doesn't
> > > > fall
> > > > in a specific zone.
> > > > 
> > > >  kernel/dma/pool.c | 11 ++---------

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
