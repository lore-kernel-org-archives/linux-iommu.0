Return-Path: <SRS0=NhDI=NJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DA6C4338F
	for <iommu@archiver.kernel.org>; Wed, 18 Aug 2021 11:29:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4BF860EE0
	for <iommu@archiver.kernel.org>; Wed, 18 Aug 2021 11:29:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B4BF860EE0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7D1B7606D9;
	Wed, 18 Aug 2021 11:29:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vVQ3aB3dlxZa; Wed, 18 Aug 2021 11:29:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4F7946066D;
	Wed, 18 Aug 2021 11:29:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 20828C001A;
	Wed, 18 Aug 2021 11:29:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ABFAEC000E
 for <iommu@lists.linux-foundation.org>; Wed, 18 Aug 2021 11:29:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 887E060674
 for <iommu@lists.linux-foundation.org>; Wed, 18 Aug 2021 11:29:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QVIYVNO-iCRP for <iommu@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 11:29:36 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 538A86066D
 for <iommu@lists.linux-foundation.org>; Wed, 18 Aug 2021 11:29:35 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 39A6E24A; Wed, 18 Aug 2021 13:29:33 +0200 (CEST)
Date: Wed, 18 Aug 2021 13:29:31 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v4 00/24] iommu: Refactor DMA domain strictness
Message-ID: <YRzvGxTW8m+NUcSi@8bytes.org>
References: <cover.1628682048.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1628682048.git.robin.murphy@arm.com>
Cc: Maxime Ripard <mripard@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Heiko Stuebner <heiko@sntech.de>, Geert Uytterhoeven <geert+renesas@glider.be>,
 linux-kernel@vger.kernel.org, Chunyan Zhang <chunyan.zhang@unisoc.com>,
 dianders@chromium.org, iommu@lists.linux-foundation.org, rajatja@google.com,
 will@kernel.org, linux-arm-kernel@lists.infradead.org
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

On Wed, Aug 11, 2021 at 01:21:14PM +0100, Robin Murphy wrote:
> Robin Murphy (24):
>   iommu: Pull IOVA cookie management into the core
>   iommu/amd: Drop IOVA cookie management
>   iommu/arm-smmu: Drop IOVA cookie management
>   iommu/vt-d: Drop IOVA cookie management
>   iommu/exynos: Drop IOVA cookie management
>   iommu/ipmmu-vmsa: Drop IOVA cookie management
>   iommu/mtk: Drop IOVA cookie management
>   iommu/rockchip: Drop IOVA cookie management
>   iommu/sprd: Drop IOVA cookie management
>   iommu/sun50i: Drop IOVA cookie management
>   iommu/virtio: Drop IOVA cookie management
>   iommu/dma: Unexport IOVA cookie management
>   iommu/dma: Remove redundant "!dev" checks
>   iommu: Indicate queued flushes via gather data
>   iommu/io-pgtable: Remove non-strict quirk
>   iommu: Introduce explicit type for non-strict DMA domains
>   iommu/amd: Prepare for multiple DMA domain types
>   iommu/arm-smmu: Prepare for multiple DMA domain types
>   iommu/vt-d: Prepare for multiple DMA domain types
>   iommu: Express DMA strictness via the domain type
>   iommu: Expose DMA domain strictness via sysfs
>   iommu: Only log strictness for DMA domains
>   iommu: Merge strictness and domain type configs
>   iommu: Allow enabling non-strict mode dynamically

Applied all except patch 12. Please re-submit patch 12 together with the
APPLE DART fixups after v5.15-rc1 is out.

Thanks,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
