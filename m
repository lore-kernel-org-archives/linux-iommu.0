Return-Path: <SRS0=FZ/Z=M3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D1DC43214
	for <iommu@archiver.kernel.org>; Wed,  4 Aug 2021 17:16:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86CDD60200
	for <iommu@archiver.kernel.org>; Wed,  4 Aug 2021 17:16:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 86CDD60200
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 67D5E83B59;
	Wed,  4 Aug 2021 17:16:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L5iTnK6BFENx; Wed,  4 Aug 2021 17:16:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6724183B4F;
	Wed,  4 Aug 2021 17:16:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 515EEC0010;
	Wed,  4 Aug 2021 17:16:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8DC84C000E
 for <iommu@lists.linux-foundation.org>; Wed,  4 Aug 2021 17:16:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6F848405A2
 for <iommu@lists.linux-foundation.org>; Wed,  4 Aug 2021 17:16:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sDwXqzI24x73 for <iommu@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 17:16:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id CE39F4059A
 for <iommu@lists.linux-foundation.org>; Wed,  4 Aug 2021 17:16:13 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E71E711FB;
 Wed,  4 Aug 2021 10:16:12 -0700 (PDT)
Received: from 010265703453.arm.com (unknown [10.57.36.146])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3767F3F66F;
 Wed,  4 Aug 2021 10:16:11 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH v3 02/25] iommu/amd: Drop IOVA cookie management
Date: Wed,  4 Aug 2021 18:15:30 +0100
Message-Id: <ebc82f082d5fde58557efbec66f34b1be6a12599.1628094600.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1628094600.git.robin.murphy@arm.com>
References: <cover.1628094600.git.robin.murphy@arm.com>
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, dianders@chromium.org,
 iommu@lists.linux-foundation.org, rajatja@google.com,
 linux-arm-kernel@lists.infradead.org
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

The core code bakes its own cookies now.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>

---

v3: Also remove unneeded include
---
 drivers/iommu/amd/iommu.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 52fe2326042a..92f7cbe3d14a 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -20,7 +20,6 @@
 #include <linux/scatterlist.h>
 #include <linux/dma-map-ops.h>
 #include <linux/dma-direct.h>
-#include <linux/dma-iommu.h>
 #include <linux/iommu-helper.h>
 #include <linux/delay.h>
 #include <linux/amd-iommu.h>
@@ -1918,16 +1917,7 @@ static struct iommu_domain *amd_iommu_domain_alloc(unsigned type)
 	domain->domain.geometry.aperture_end   = ~0ULL;
 	domain->domain.geometry.force_aperture = true;
 
-	if (type == IOMMU_DOMAIN_DMA &&
-	    iommu_get_dma_cookie(&domain->domain) == -ENOMEM)
-		goto free_domain;
-
 	return &domain->domain;
-
-free_domain:
-	protection_domain_free(domain);
-
-	return NULL;
 }
 
 static void amd_iommu_domain_free(struct iommu_domain *dom)
@@ -1944,9 +1934,6 @@ static void amd_iommu_domain_free(struct iommu_domain *dom)
 	if (!dom)
 		return;
 
-	if (dom->type == IOMMU_DOMAIN_DMA)
-		iommu_put_dma_cookie(&domain->domain);
-
 	if (domain->flags & PD_IOMMUV2_MASK)
 		free_gcr3_table(domain);
 
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
