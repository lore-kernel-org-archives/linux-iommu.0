Return-Path: <SRS0=qNYd=BA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFB4C433E1
	for <iommu@archiver.kernel.org>; Tue, 21 Jul 2020 16:27:31 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A398720792
	for <iommu@archiver.kernel.org>; Tue, 21 Jul 2020 16:27:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A398720792
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 55EE087C9F;
	Tue, 21 Jul 2020 16:27:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6E-ig60ht3f8; Tue, 21 Jul 2020 16:27:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8F3D3875A7;
	Tue, 21 Jul 2020 16:27:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6A926C089F;
	Tue, 21 Jul 2020 16:27:30 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BF298C016F
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jul 2020 16:27:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B487E864CB
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jul 2020 16:27:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wHMYiV1XJeUC for <iommu@lists.linux-foundation.org>;
 Tue, 21 Jul 2020 16:27:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D010284FAE
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jul 2020 16:27:28 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id CD59EAD79;
 Tue, 21 Jul 2020 16:27:33 +0000 (UTC)
Message-ID: <6db722947546221ed99d3f473f78e1a6de65d7d6.camel@suse.de>
Subject: Re: [PATCH] dma-pool: Do not allocate pool memory from CMA
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: Amit Pundir <amit.pundir@linaro.org>
Date: Tue, 21 Jul 2020 18:27:24 +0200
In-Reply-To: <CAMi1Hd3C6kh5E49EgytBAQ_2AE_jvnp+eSNsxBYaux+exSvdbg@mail.gmail.com>
References: <20200708164936.9340-1-nsaenzjulienne@suse.de>
 <CAMi1Hd35tRM=cnmzwX=SDgu-OoXi1Xj+twFkoULaVZBbTpe6sw@mail.gmail.com>
 <550b30a86c0785049d24c945e2c6628d491cee3a.camel@suse.de>
 <CAMi1Hd2V2pJjP=USS4r-Z3vK-aq7_aBy-jcVNk1GvbdEQAuzWg@mail.gmail.com>
 <011994f8a717a00dcd9ed7682a1ddeb421c2c43f.camel@suse.de>
 <CAMi1Hd0=ZsGhTkSy221EP9Vb3GMOcS0UMczX2u5X9qK37_ea1A@mail.gmail.com>
 <01831596e4a2a6c9c066138b23bd30435f8e5569.camel@suse.de>
 <CAMi1Hd3C6kh5E49EgytBAQ_2AE_jvnp+eSNsxBYaux+exSvdbg@mail.gmail.com>
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

On Tue, 2020-07-21 at 20:52 +0530, Amit Pundir wrote:

[...]

> > > > Can you try booting *without* my patch and this in the kernel
> > > > command
> > > > line: "cma=16M@0x100000000-0x200000000".
> > > 
> > > It doesn't boot with this added kernel command line.
> > 
> > For the record, this placed the CMA in the [4GB, 8GB] address space
> > instead of you setup's default: [3GB, 4GB]. All atomic pools fall
> > in
> > that memory area without my patch, which makes me think some of the
> > devices on your board might not like higher addresses.
> > 
> 
> Thank you Nicolas for the details. Though we don't set the CMA
> alloc-ranges explicitly in upstream sdm845 dts, but I dug around and
> found that CMA alloc-ranges in the downstream kernel are indeed in
> lower address space.
> https://github.com/MiCode/Xiaomi_Kernel_OpenSource/blob/dipper-q-oss/arch/arm64/boot/dts/qcom/sdm845.dtsi#L662
> 
> /* global autoconfigured region for contiguous allocations */
> linux,cma {
>         compatible = "shared-dma-pool";
>         alloc-ranges = <0 0x00000000 0 0xffffffff>;
>         reusable;
>         alignment = <0 0x400000>;
>         size = <0 0x2000000>;
>         linux,cma-default;
> };

Pretty standard, and similar to what it's being used upstream by
default.

> 
> > What happens if you boot with my troublesome patch with this in
> > your
> > device tree? (insert it at the bottom of sdm845-beryllium.dts)
> > 
> > &soc {
> >         dma-ranges = <0 0 0 0 0x1 0>;
> > };
> > 
> 
> Device still doesn't boot up to adb shell.

Let's get a bigger hammer, I'm just looking for clues here. Can you
apply this and provide the dmesg output.

diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 6bc74a2d5127..2160676bf488 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -268,6 +268,8 @@ void *dma_alloc_from_pool(struct device *dev, size_t size,
                        schedule_work(&atomic_pool_work);
        }
 
+       dev_info(dev, "%s: size %lx, phys addr %llx, flags 0x%x\n", __func__, size, phys, flags);
+
        return ptr;
 }
  

Regards,
Nicolas

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
