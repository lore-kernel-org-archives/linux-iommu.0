Return-Path: <SRS0=85So=MN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB556C12002
	for <iommu@archiver.kernel.org>; Wed, 21 Jul 2021 18:21:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A95F86121E
	for <iommu@archiver.kernel.org>; Wed, 21 Jul 2021 18:21:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A95F86121E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 878C240499;
	Wed, 21 Jul 2021 18:21:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5EZHJZCUwRRp; Wed, 21 Jul 2021 18:21:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2976E40375;
	Wed, 21 Jul 2021 18:21:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 12D3FC0010;
	Wed, 21 Jul 2021 18:21:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 263E1C0022
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 18:21:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 01996608B4
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 18:21:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QXBXIGy-DdOK for <iommu@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 18:21:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3DEC7608B6
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 18:21:10 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BEF8C11FB;
 Wed, 21 Jul 2021 11:21:09 -0700 (PDT)
Received: from 010265703453.arm.com (unknown [10.57.36.146])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4B93E3F694;
 Wed, 21 Jul 2021 11:21:08 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH 14/23] iommu: Introduce explicit type for non-strict DMA
 domains
Date: Wed, 21 Jul 2021 19:20:25 +0100
Message-Id: <25ff384e3d21e4973a95713ee00aed2a2c68ae7d.1626888445.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1626888444.git.robin.murphy@arm.com>
References: <cover.1626888444.git.robin.murphy@arm.com>
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

Promote the difference between strict and non-strict DMA domains from an
internal detail to a distinct domain feature and type, to pave the road
for exposing it through the sysfs default domain interface.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/dma-iommu.c | 2 +-
 drivers/iommu/iommu.c     | 6 +++++-
 include/linux/iommu.h     | 6 ++++++
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index e28396cea6eb..b1af1ff324c5 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1311,7 +1311,7 @@ void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 dma_limit)
 	 * The IOMMU core code allocates the default DMA domain, which the
 	 * underlying IOMMU driver needs to support via the dma-iommu layer.
 	 */
-	if (domain->type == IOMMU_DOMAIN_DMA) {
+	if (domain->type & __IOMMU_DOMAIN_DMA_API) {
 		if (iommu_dma_init_domain(domain, dma_base, dma_limit, dev))
 			goto out_err;
 		dev->dma_ops = &iommu_dma_ops;
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index e23d0c9be9db..8333c334891e 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -114,6 +114,7 @@ static const char *iommu_domain_type_str(unsigned int t)
 	case IOMMU_DOMAIN_UNMANAGED:
 		return "Unmanaged";
 	case IOMMU_DOMAIN_DMA:
+	case IOMMU_DOMAIN_DMA_FQ:
 		return "Translated";
 	default:
 		return "Unknown";
@@ -547,6 +548,9 @@ static ssize_t iommu_group_show_type(struct iommu_group *group,
 		case IOMMU_DOMAIN_DMA:
 			type = "DMA\n";
 			break;
+		case IOMMU_DOMAIN_DMA_FQ:
+			type = "DMA-FQ\n";
+			break;
 		}
 	}
 	mutex_unlock(&group->mutex);
@@ -1942,7 +1946,7 @@ static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
 	/* Assume all sizes by default; the driver may override this later */
 	domain->pgsize_bitmap  = bus->iommu_ops->pgsize_bitmap;
 
-	if (type == IOMMU_DOMAIN_DMA && iommu_get_dma_cookie(domain)) {
+	if ((type & __IOMMU_DOMAIN_DMA_API) && iommu_get_dma_cookie(domain)) {
 		iommu_domain_free(domain);
 		domain = NULL;
 	}
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 007662b65474..56519110d43f 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -61,6 +61,7 @@ struct iommu_domain_geometry {
 #define __IOMMU_DOMAIN_DMA_API	(1U << 1)  /* Domain for use in DMA-API
 					      implementation              */
 #define __IOMMU_DOMAIN_PT	(1U << 2)  /* Domain is identity mapped   */
+#define __IOMMU_DOMAIN_DMA_FQ	(1U << 3)  /* DMA-API uses flush queue    */
 
 /*
  * This are the possible domain-types
@@ -73,12 +74,17 @@ struct iommu_domain_geometry {
  *	IOMMU_DOMAIN_DMA	- Internally used for DMA-API implementations.
  *				  This flag allows IOMMU drivers to implement
  *				  certain optimizations for these domains
+ *	IOMMU_DOMAIN_DMA_FQ	- As above, but definitely using batched TLB
+ *				  invalidation.
  */
 #define IOMMU_DOMAIN_BLOCKED	(0U)
 #define IOMMU_DOMAIN_IDENTITY	(__IOMMU_DOMAIN_PT)
 #define IOMMU_DOMAIN_UNMANAGED	(__IOMMU_DOMAIN_PAGING)
 #define IOMMU_DOMAIN_DMA	(__IOMMU_DOMAIN_PAGING |	\
 				 __IOMMU_DOMAIN_DMA_API)
+#define IOMMU_DOMAIN_DMA_FQ	(__IOMMU_DOMAIN_PAGING |	\
+				 __IOMMU_DOMAIN_DMA_API |	\
+				 __IOMMU_DOMAIN_DMA_FQ)
 
 struct iommu_domain {
 	unsigned type;
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
