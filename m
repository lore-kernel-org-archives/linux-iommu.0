Return-Path: <SRS0=FZ/Z=M3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF4AC432BE
	for <iommu@archiver.kernel.org>; Wed,  4 Aug 2021 17:16:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 875CC608FC
	for <iommu@archiver.kernel.org>; Wed,  4 Aug 2021 17:16:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 875CC608FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5DF4983B60;
	Wed,  4 Aug 2021 17:16:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xJYJcoAQ_Xxj; Wed,  4 Aug 2021 17:16:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4008383B4F;
	Wed,  4 Aug 2021 17:16:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1A35CC0010;
	Wed,  4 Aug 2021 17:16:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C4FB3C000E
 for <iommu@lists.linux-foundation.org>; Wed,  4 Aug 2021 17:16:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A6368401AE
 for <iommu@lists.linux-foundation.org>; Wed,  4 Aug 2021 17:16:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7yf7rs50mvb3 for <iommu@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 17:16:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id A6B74400E5
 for <iommu@lists.linux-foundation.org>; Wed,  4 Aug 2021 17:16:11 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EED911063;
 Wed,  4 Aug 2021 10:16:10 -0700 (PDT)
Received: from 010265703453.arm.com (unknown [10.57.36.146])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 33CEF3F66F;
 Wed,  4 Aug 2021 10:16:08 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH v3 01/25] iommu: Pull IOVA cookie management into the core
Date: Wed,  4 Aug 2021 18:15:29 +0100
Message-Id: <46f4cda8215bd5f8a9f9fd5a4a6451805f75efa3.1628094600.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1628094600.git.robin.murphy@arm.com>
References: <cover.1628094600.git.robin.murphy@arm.com>
MIME-Version: 1.0
Cc: Maxime Ripard <mripard@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Heiko Stuebner <heiko@sntech.de>, Geert Uytterhoeven <geert+renesas@glider.be>,
 linux-kernel@vger.kernel.org, Chunyan Zhang <chunyan.zhang@unisoc.com>,
 dianders@chromium.org, iommu@lists.linux-foundation.org, rajatja@google.com,
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

Now that everyone has converged on iommu-dma for IOMMU_DOMAIN_DMA
support, we can abandon the notion of drivers being responsible for the
cookie type, and consolidate all the management into the core code.

CC: Marek Szyprowski <m.szyprowski@samsung.com>
CC: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
CC: Geert Uytterhoeven <geert+renesas@glider.be>
CC: Yong Wu <yong.wu@mediatek.com>
CC: Heiko Stuebner <heiko@sntech.de>
CC: Chunyan Zhang <chunyan.zhang@unisoc.com>
CC: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>

---

v3: Use a simpler temporary check instead of trying to be clever with
    the error code
---
 drivers/iommu/iommu.c | 7 +++++++
 include/linux/iommu.h | 3 ++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index f2cda9950bd5..b65fcc66ffa4 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -7,6 +7,7 @@
 #define pr_fmt(fmt)    "iommu: " fmt
 
 #include <linux/device.h>
+#include <linux/dma-iommu.h>
 #include <linux/kernel.h>
 #include <linux/bits.h>
 #include <linux/bug.h>
@@ -1946,6 +1947,11 @@ static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
 	/* Assume all sizes by default; the driver may override this later */
 	domain->pgsize_bitmap  = bus->iommu_ops->pgsize_bitmap;
 
+	/* Temporarily avoid -EEXIST while drivers still get their own cookies */
+	if (type == IOMMU_DOMAIN_DMA && !domain->iova_cookie && iommu_get_dma_cookie(domain)) {
+		iommu_domain_free(domain);
+		domain = NULL;
+	}
 	return domain;
 }
 
@@ -1957,6 +1963,7 @@ EXPORT_SYMBOL_GPL(iommu_domain_alloc);
 
 void iommu_domain_free(struct iommu_domain *domain)
 {
+	iommu_put_dma_cookie(domain);
 	domain->ops->domain_free(domain);
 }
 EXPORT_SYMBOL_GPL(iommu_domain_free);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 4997c78e2670..141779d76035 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -40,6 +40,7 @@ struct iommu_domain;
 struct notifier_block;
 struct iommu_sva;
 struct iommu_fault_event;
+struct iommu_dma_cookie;
 
 /* iommu fault flags */
 #define IOMMU_FAULT_READ	0x0
@@ -86,7 +87,7 @@ struct iommu_domain {
 	iommu_fault_handler_t handler;
 	void *handler_token;
 	struct iommu_domain_geometry geometry;
-	void *iova_cookie;
+	struct iommu_dma_cookie *iova_cookie;
 };
 
 enum iommu_cap {
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
