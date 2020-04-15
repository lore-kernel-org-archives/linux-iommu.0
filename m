Return-Path: <SRS0=YkH/=57=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A13C2BB55
	for <iommu@archiver.kernel.org>; Wed, 15 Apr 2020 11:37:00 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E8DB20768
	for <iommu@archiver.kernel.org>; Wed, 15 Apr 2020 11:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jNopdLB0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E8DB20768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 5AF4E20773;
	Wed, 15 Apr 2020 11:37:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 47uV2+1R8RD1; Wed, 15 Apr 2020 11:36:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 67B8E20524;
	Wed, 15 Apr 2020 11:36:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5F599C1D87;
	Wed, 15 Apr 2020 11:36:57 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 69CFCC0172
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 11:36:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5903985DE1
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 11:36:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UlJ2B0Wmp90j for <iommu@lists.linux-foundation.org>;
 Wed, 15 Apr 2020 11:36:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id CF3D485CFF
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 11:36:55 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C1A1321582;
 Wed, 15 Apr 2020 11:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1586950615;
 bh=Lh/aVkzRGiJf794rdAEn6bIXmrdHDr/0NaGaE+pi0Js=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jNopdLB0c3vCNfqass8jIKcY4/bhdeowJ29yCo4UGUOc1cWl05gbYU8CptZFceUpE
 iAcs3/pMMP0QZZOPcGhm2yxOR1eAMGp0J1QISXRhXJ+hk5mql0rGbQ8ubAl0RZx4GF
 kmPDaFte6FcyYjGDFVQAPFAoThOJYRJeJcPR81jI=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 108/129] iommu/vt-d: Add build dependency on IOASID
Date: Wed, 15 Apr 2020 07:34:23 -0400
Message-Id: <20200415113445.11881-108-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415113445.11881-1-sashal@kernel.org>
References: <20200415113445.11881-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Sasha Levin <sashal@kernel.org>, iommu@lists.linux-foundation.org,
 Joerg Roedel <jroedel@suse.de>
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

From: Jacob Pan <jacob.jun.pan@linux.intel.com>

[ Upstream commit 4a663dae47316ae8b97d5b77025fe7dfd9d3487f ]

IOASID code is needed by VT-d scalable mode for PASID allocation.
Add explicit dependency such that IOASID is built-in whenever Intel
IOMMU is enabled.
Otherwise, aux domain code will fail when IOMMU is built-in and IOASID
is compiled as a module.

Fixes: 59a623374dc38 ("iommu/vt-d: Replace Intel specific PASID allocator with IOASID")
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index d2fade9849997..25149544d57c9 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -188,6 +188,7 @@ config INTEL_IOMMU
 	select NEED_DMA_MAP_STATE
 	select DMAR_TABLE
 	select SWIOTLB
+	select IOASID
 	help
 	  DMA remapping (DMAR) devices support enables independent address
 	  translations for Direct Memory Access (DMA) from devices.
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
