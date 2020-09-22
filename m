Return-Path: <SRS0=CZ1O=C7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EEC9C4363D
	for <iommu@archiver.kernel.org>; Tue, 22 Sep 2020 16:26:09 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 103A023A1E
	for <iommu@archiver.kernel.org>; Tue, 22 Sep 2020 16:26:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 103A023A1E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 649B087117;
	Tue, 22 Sep 2020 16:26:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0Pw-dBlqI8Ys; Tue, 22 Sep 2020 16:26:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8A4118710D;
	Tue, 22 Sep 2020 16:26:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 71353C0889;
	Tue, 22 Sep 2020 16:26:07 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 802C5C0051
 for <iommu@lists.linux-foundation.org>; Tue, 22 Sep 2020 16:26:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 64DB9848F4
 for <iommu@lists.linux-foundation.org>; Tue, 22 Sep 2020 16:26:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M9PgToIlxalT for <iommu@lists.linux-foundation.org>;
 Tue, 22 Sep 2020 16:26:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 771BB85B6F
 for <iommu@lists.linux-foundation.org>; Tue, 22 Sep 2020 16:26:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: alyssa) with ESMTPSA id 88251299052
Date: Tue, 22 Sep 2020 12:25:57 -0400
From: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 0/3] drm: panfrost: Coherency support
Message-ID: <20200922162557.GA2406@kevin>
References: <cover.1600780574.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1600780574.git.robin.murphy@arm.com>
Cc: robh@kernel.org, tomeu.vizoso@collabora.com, narmstrong@baylibre.com,
 khilman@baylibre.com, dri-devel@lists.freedesktop.org, steven.price@arm.com,
 iommu@lists.linux-foundation.org, linux-amlogic@lists.infradead.org,
 will@kernel.org, linux-arm-kernel@lists.infradead.org, jbrunet@baylibre.com
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

Series is:

	Acked-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>

On Tue, Sep 22, 2020 at 03:16:47PM +0100, Robin Murphy wrote:
> Hi all,
> 
> Here's a quick v2 with the tags so far picked up and some inline
> commentary about the shareability domains for the pagetable code.
> 
> Robin.
> 
> 
> Robin Murphy (3):
>   iommu/io-pgtable-arm: Support coherency for Mali LPAE
>   drm/panfrost: Support cache-coherent integrations
>   arm64: dts: meson: Describe G12b GPU as coherent
> 
>  arch/arm64/boot/dts/amlogic/meson-g12b.dtsi |  4 ++++
>  drivers/gpu/drm/panfrost/panfrost_device.h  |  1 +
>  drivers/gpu/drm/panfrost/panfrost_drv.c     |  2 ++
>  drivers/gpu/drm/panfrost/panfrost_gem.c     |  2 ++
>  drivers/gpu/drm/panfrost/panfrost_mmu.c     |  1 +
>  drivers/iommu/io-pgtable-arm.c              | 11 ++++++++++-
>  6 files changed, 20 insertions(+), 1 deletion(-)
> 
> -- 
> 2.28.0.dirty
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
