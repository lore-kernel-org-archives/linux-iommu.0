Return-Path: <SRS0=BXsX=DM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD60C4363A
	for <iommu@archiver.kernel.org>; Mon,  5 Oct 2020 08:15:30 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 931B320781
	for <iommu@archiver.kernel.org>; Mon,  5 Oct 2020 08:15:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 931B320781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 437278531B;
	Mon,  5 Oct 2020 08:15:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xxjAP4k-3CLt; Mon,  5 Oct 2020 08:15:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1DAA584E23;
	Mon,  5 Oct 2020 08:15:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 09EA2C016F;
	Mon,  5 Oct 2020 08:15:28 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 05FB1C0051
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 08:15:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id E853120025
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 08:15:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CEy+4QcLl25L for <iommu@lists.linux-foundation.org>;
 Mon,  5 Oct 2020 08:15:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by silver.osuosl.org (Postfix) with ESMTPS id 7D0582000E
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 08:15:24 +0000 (UTC)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bhuna.collabora.co.uk (Postfix) with ESMTPSA id E7ECD299E6E;
 Mon,  5 Oct 2020 09:15:20 +0100 (BST)
Date: Mon, 5 Oct 2020 10:15:17 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Neil Armstrong <narmstrong@baylibre.com>, tomeu.vizoso@collabora.com
Subject: Re: [PATCH 3/3] arm64: dts: meson: Describe G12b GPU as coherent
Message-ID: <20201005101517.020c411a@collabora.com>
In-Reply-To: <e218b95e-39bc-e773-00fb-bcb5f1f835ea@baylibre.com>
References: <cover.1600213517.git.robin.murphy@arm.com>
 <ba61c76654349d3dfcd14c1e24c5aed39ebe3cf7.1600213517.git.robin.murphy@arm.com>
 <e218b95e-39bc-e773-00fb-bcb5f1f835ea@baylibre.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Cc: robh@kernel.org, khilman@baylibre.com, Robin Murphy <robin.murphy@arm.com>,
 dri-devel@lists.freedesktop.org, steven.price@arm.com,
 iommu@lists.linux-foundation.org, alyssa.rosenzweig@collabora.com,
 linux-amlogic@lists.infradead.org, will@kernel.org,
 linux-arm-kernel@lists.infradead.org, jbrunet@baylibre.com
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

Hi Robin, Neil,

On Wed, 16 Sep 2020 10:26:43 +0200
Neil Armstrong <narmstrong@baylibre.com> wrote:

> Hi Robin,
> 
> On 16/09/2020 01:51, Robin Murphy wrote:
> > According to a downstream commit I found in the Khadas vendor kernel,
> > the GPU on G12b is wired up for ACE-lite, so (now that Panfrost knows
> > how to handle this properly) we should describe it as such. Otherwise
> > the mismatch leads to all manner of fun with mismatched attributes and
> > inadvertently snooping stale data from caches, which would account for
> > at least some of the brokenness observed on this platform.
> > 
> > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> > ---
> >  arch/arm64/boot/dts/amlogic/meson-g12b.dtsi | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi
> > index 9b8548e5f6e5..ee8fcae9f9f0 100644
> > --- a/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi
> > +++ b/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi
> > @@ -135,3 +135,7 @@ map1 {
> >  		};
> >  	};
> >  };
> > +
> > +&mali {
> > +	dma-coherent;
> > +};
> >   
> 
> Thanks a lot for digging, I'll run a test to confirm it fixes the issue !

Sorry for the late reply. I triggered a dEQP run with this patch applied
and I see a bunch of "panfrost ffe40000.gpu: matching BO is not heap type"
errors (see below for a full backtrace). That doesn't seem to happen when
we drop this dma-coherent property.

[  690.945731] ------------[ cut here ]------------
[  690.950003] panfrost ffe40000.gpu: matching BO is not heap type (GPU VA = 319a000)
[  690.950051] WARNING: CPU: 0 PID: 120 at drivers/gpu/drm/panfrost/panfrost_mmu.c:465 panfrost_mmu_irq_handler_thread+0x47c/0x650
[  690.968854] Modules linked in:
[  690.971878] CPU: 0 PID: 120 Comm: irq/27-panfrost Tainted: G        W         5.9.0-rc5-02434-g7d8109ec5a42 #784
[  690.981964] Hardware name: Khadas VIM3 (DT)
[  690.986107] pstate: 60000005 (nZCv daif -PAN -UAO BTYPE=--)
[  690.991627] pc : panfrost_mmu_irq_handler_thread+0x47c/0x650
[  690.997232] lr : panfrost_mmu_irq_handler_thread+0x47c/0x650
[  691.002836] sp : ffff800011bcbcd0
[  691.006114] x29: ffff800011bcbcf0 x28: ffff0000f3fe3800 
[  691.011375] x27: ffff0000ceaf5350 x26: ffff0000ca5fc500 
[  691.016636] x25: ffff0000f32409c0 x24: 0000000000000001 
[  691.021897] x23: ffff0000f3240880 x22: ffff0000f3e3a800 
[  691.027159] x21: 0000000000000000 x20: 0000000000000000 
[  691.032420] x19: 0000000000010001 x18: 0000000000000020 
[  691.037681] x17: 0000000000000000 x16: 0000000000000000 
[  691.042942] x15: ffff0000f3fe3c70 x14: ffffffffffffffff 
[  691.048204] x13: ffff8000116c2428 x12: ffff8000116c2086 
[  691.053466] x11: ffff800011bcbcd0 x10: ffff800011bcbcd0 
[  691.058727] x9 : 00000000fffffffe x8 : 0000000000000000 
[  691.063988] x7 : 7420706165682074 x6 : ffff8000116c1816 
[  691.069249] x5 : 0000000000000000 x4 : 0000000000000000 
[  691.074510] x3 : 00000000ffffffff x2 : ffff8000e348c000 
[  691.079771] x1 : f1b91ff9af2df000 x0 : 0000000000000000 
[  691.085033] Call trace:
[  691.087452]  panfrost_mmu_irq_handler_thread+0x47c/0x650
[  691.092712]  irq_thread_fn+0x2c/0xa0
[  691.096246]  irq_thread+0x184/0x208
[  691.099699]  kthread+0x140/0x160
[  691.102890]  ret_from_fork+0x10/0x34
[  691.106424] ---[ end trace b5dd8c2dfada8236 ]---
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
