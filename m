Return-Path: <SRS0=g0Sk=4O=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DEFAC4BA13
	for <iommu@archiver.kernel.org>; Wed, 26 Feb 2020 15:44:25 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B49662468D
	for <iommu@archiver.kernel.org>; Wed, 26 Feb 2020 15:44:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B49662468D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 81C8621F76;
	Wed, 26 Feb 2020 15:44:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gKZrUo5ZIOCs; Wed, 26 Feb 2020 15:44:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 752522157D;
	Wed, 26 Feb 2020 15:44:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B6ADC08A0;
	Wed, 26 Feb 2020 15:44:20 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AE250C0177
 for <iommu@lists.linux-foundation.org>; Wed, 26 Feb 2020 15:44:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 97FE487A15
 for <iommu@lists.linux-foundation.org>; Wed, 26 Feb 2020 15:44:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4JDOlEypPMZS for <iommu@lists.linux-foundation.org>;
 Wed, 26 Feb 2020 15:44:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [85.220.165.71])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 2C96385B1D
 for <iommu@lists.linux-foundation.org>; Wed, 26 Feb 2020 15:44:17 +0000 (UTC)
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.92)
 (envelope-from <l.stach@pengutronix.de>)
 id 1j6yr8-0008Ty-T1; Wed, 26 Feb 2020 16:44:14 +0100
Message-ID: <2608dfa05478d995586c9e477917349dc18618ac.camel@pengutronix.de>
Subject: Proper way to check for restricted DMA addressing from device driver
From: Lucas Stach <l.stach@pengutronix.de>
To: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Date: Wed, 26 Feb 2020 16:44:14 +0100
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: iommu@lists.linux-foundation.org
Cc: Christoph Hellwig <hch@lst.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

Hi all,

I'm currently struggling with how to properly check for restricted DMA
addressing from a device driver side. The basic issue I'm facing is
that I have a embedded GPU, which isn't able to address all system
memory due to interconnect being restricted to 32bit addressing. The
limits are properly described in the system device-tree and thus
SWIOTLB is working.

However graphics buffers are large and graphics drivers really like to
keep the dma mapping alive for performance reasons, which means I'm
running out of SWIOTLB space pretty easily, aside from the obvious
performance implications of SWIOTLB.

As 3 out of the maximum 4GB system memory are located in the DMA32 zone
and thus located in the GPU addressable space, I just want to avoid
allocating graphics buffers outside of the DMA32 zone.

To add the DMA32 restriction to my drivers allocations, I need a
reliable way from the device driver side to check if the GPU is in such
a restricted system. What I'm currently doing in my WIP patch is this:

 /*
  * If the GPU is part of a system with only 32bit bus addressing
  * capabilities, request pages for our SHM backend buffers from the
  * DMA32 zone to avoid performance killing SWIOTLB bounce buffering.
  */
 if (*gpu->dev->dma_mask < BIT_ULL(32) && !device_iommu_mapped(gpu->dev))
         priv->shm_gfp_mask |= GFP_DMA32;

However I'm not sure if there are edge cases where this check would
fool me. Is there any better way to check for DMA addressing
restrictions from the device driver side?

Regards,
Lucas

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
