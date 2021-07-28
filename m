Return-Path: <SRS0=45t2=MU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4975C4320A
	for <iommu@archiver.kernel.org>; Wed, 28 Jul 2021 15:59:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B34976108C
	for <iommu@archiver.kernel.org>; Wed, 28 Jul 2021 15:59:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B34976108C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 93FBF6088D;
	Wed, 28 Jul 2021 15:59:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3kfutx2x5ioJ; Wed, 28 Jul 2021 15:59:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7677B6066B;
	Wed, 28 Jul 2021 15:59:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 614D0C001A;
	Wed, 28 Jul 2021 15:59:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 207CEC000E
 for <iommu@lists.linux-foundation.org>; Wed, 28 Jul 2021 15:59:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 010BF40270
 for <iommu@lists.linux-foundation.org>; Wed, 28 Jul 2021 15:59:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id US4L3zwlbUUi for <iommu@lists.linux-foundation.org>;
 Wed, 28 Jul 2021 15:59:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id E15CD4025D
 for <iommu@lists.linux-foundation.org>; Wed, 28 Jul 2021 15:59:27 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B0F1106F;
 Wed, 28 Jul 2021 08:59:27 -0700 (PDT)
Received: from 010265703453.arm.com (unknown [10.57.36.146])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C8F363F70D;
 Wed, 28 Jul 2021 08:59:25 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH v2 12/24] iommu/dma: Unexport IOVA cookie management
Date: Wed, 28 Jul 2021 16:58:33 +0100
Message-Id: <697a7c5da18c58e61e6b9a98b97775a2934a6358.1627468309.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1627468308.git.robin.murphy@arm.com>
References: <cover.1627468308.git.robin.murphy@arm.com>
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, dianders@chromium.org,
 iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
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

IOVA cookies are now got and put by core code, so we no longer need to
export these to modular drivers. The export for getting MSI cookies
stays, since VFIO can still be a module, but it was already relying on
someone else putting them, so that aspect is unaffected.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/dma-iommu.c | 7 -------
 drivers/iommu/iommu.c     | 3 +--
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 98ba927aee1a..10067fbc4309 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -98,9 +98,6 @@ static struct iommu_dma_cookie *cookie_alloc(enum iommu_dma_cookie_type type)
 /**
  * iommu_get_dma_cookie - Acquire DMA-API resources for a domain
  * @domain: IOMMU domain to prepare for DMA-API usage
- *
- * IOMMU drivers should normally call this from their domain_alloc
- * callback when domain->type == IOMMU_DOMAIN_DMA.
  */
 int iommu_get_dma_cookie(struct iommu_domain *domain)
 {
@@ -113,7 +110,6 @@ int iommu_get_dma_cookie(struct iommu_domain *domain)
 
 	return 0;
 }
-EXPORT_SYMBOL(iommu_get_dma_cookie);
 
 /**
  * iommu_get_msi_cookie - Acquire just MSI remapping resources
@@ -151,8 +147,6 @@ EXPORT_SYMBOL(iommu_get_msi_cookie);
  * iommu_put_dma_cookie - Release a domain's DMA mapping resources
  * @domain: IOMMU domain previously prepared by iommu_get_dma_cookie() or
  *          iommu_get_msi_cookie()
- *
- * IOMMU drivers should normally call this from their domain_free callback.
  */
 void iommu_put_dma_cookie(struct iommu_domain *domain)
 {
@@ -172,7 +166,6 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
 	kfree(cookie);
 	domain->iova_cookie = NULL;
 }
-EXPORT_SYMBOL(iommu_put_dma_cookie);
 
 /**
  * iommu_dma_get_resv_regions - Reserved region driver helper
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index ea5a9ea8d431..fa8109369f74 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1947,8 +1947,7 @@ static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
 	/* Assume all sizes by default; the driver may override this later */
 	domain->pgsize_bitmap  = bus->iommu_ops->pgsize_bitmap;
 
-	/* Temporarily ignore -EEXIST while drivers still get their own cookies */
-	if (type == IOMMU_DOMAIN_DMA && iommu_get_dma_cookie(domain) == -ENOMEM) {
+	if (type == IOMMU_DOMAIN_DMA && iommu_get_dma_cookie(domain)) {
 		iommu_domain_free(domain);
 		domain = NULL;
 	}
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
