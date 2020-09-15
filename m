Return-Path: <SRS0=AdPL=CY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E69C433E2
	for <iommu@archiver.kernel.org>; Tue, 15 Sep 2020 23:51:19 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 038D020720
	for <iommu@archiver.kernel.org>; Tue, 15 Sep 2020 23:51:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 038D020720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id D60C2872C9;
	Tue, 15 Sep 2020 23:51:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KnVS3V9+nKkx; Tue, 15 Sep 2020 23:51:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id F2B17872AD;
	Tue, 15 Sep 2020 23:51:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB6DAC0864;
	Tue, 15 Sep 2020 23:51:17 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 183C3C0051
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 23:51:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 006DC86C70
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 23:51:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NXou91eCY7PR for <iommu@lists.linux-foundation.org>;
 Tue, 15 Sep 2020 23:51:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1B3BB86BC5
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 23:51:14 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34136101E;
 Tue, 15 Sep 2020 16:51:14 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com
 [10.1.196.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 936513F68F;
 Tue, 15 Sep 2020 16:51:12 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org, robh@kernel.org, tomeu.vizoso@collabora.com,
 steven.price@arm.com, alyssa.rosenzweig@collabora.com,
 khilman@baylibre.com, narmstrong@baylibre.com, jbrunet@baylibre.com
Subject: [PATCH 0/3] drm: panfrost: Coherency support
Date: Wed, 16 Sep 2020 00:51:04 +0100
Message-Id: <cover.1600213517.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
MIME-Version: 1.0
Cc: linux-amlogic@lists.infradead.org, iommu@lists.linux-foundation.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org
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

I polished up my original proof-of-concept a little while back, but now
that I've got my hands on my Juno again I've been able to actually test
it to my satisfaction, so here are proper patches!

It probably makes sense for patches #1 and #2 to stay together and both
go via drm-misc, provided Will's OK with that.

Robin.


Robin Murphy (3):
  iommu/io-pgtable-arm: Support coherency for Mali LPAE
  drm/panfrost: Support cache-coherent integrations
  arm64: dts: meson: Describe G12b GPU as coherent

 arch/arm64/boot/dts/amlogic/meson-g12b.dtsi | 4 ++++
 drivers/gpu/drm/panfrost/panfrost_device.h  | 1 +
 drivers/gpu/drm/panfrost/panfrost_drv.c     | 2 ++
 drivers/gpu/drm/panfrost/panfrost_gem.c     | 2 ++
 drivers/gpu/drm/panfrost/panfrost_mmu.c     | 1 +
 drivers/iommu/io-pgtable-arm.c              | 5 ++++-
 6 files changed, 14 insertions(+), 1 deletion(-)

-- 
2.28.0.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
