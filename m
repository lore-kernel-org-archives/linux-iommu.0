Return-Path: <SRS0=KfvE=G6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D310DC433DB
	for <iommu@archiver.kernel.org>; Wed, 27 Jan 2021 20:00:40 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D8C564DA4
	for <iommu@archiver.kernel.org>; Wed, 27 Jan 2021 20:00:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D8C564DA4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3BD5986C0F;
	Wed, 27 Jan 2021 20:00:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KRn2GlJ+JAJX; Wed, 27 Jan 2021 20:00:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1CCC586C0E;
	Wed, 27 Jan 2021 20:00:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 149B9C08A1;
	Wed, 27 Jan 2021 20:00:37 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 79E8EC013A
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 20:00:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 67E9B86C0E
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 20:00:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CqxrmkKNSPjE for <iommu@lists.linux-foundation.org>;
 Wed, 27 Jan 2021 20:00:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9D4BD86C1A
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 20:00:34 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id C838464DA4;
 Wed, 27 Jan 2021 20:00:33 +0000 (UTC)
Subject: [PATCH RFC 2/9] iommu: Add iova and size as parameters in
 iotlb_sync_map
From: Chuck Lever <chuck.lever@oracle.com>
To: baolu.lu@linux.intel.com
Date: Wed, 27 Jan 2021 15:00:32 -0500
Message-ID: <161177763296.1311.15197214300351076283.stgit@manet.1015granger.net>
In-Reply-To: <161177711359.1311.417185373365934204.stgit@manet.1015granger.net>
References: <161177711359.1311.417185373365934204.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Cc: isaacm@codeaurora.org, robin.murphy@arm.com,
 iommu@lists.linux-foundation.org, will@kernel.org
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

From: Yong Wu <yong.wu@mediatek.com>

iotlb_sync_map allow IOMMU drivers tlb sync after completing the whole
mapping. This patch adds iova and size as the parameters in it. then the
IOMMU driver could flush tlb with the whole range once after iova mapping
to improve performance.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 drivers/iommu/iommu.c      |    4 ++--
 drivers/iommu/tegra-gart.c |    7 +++++--
 include/linux/iommu.h      |    3 ++-
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index c304a6a30d42..3d099a31ddca 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2443,7 +2443,7 @@ static int _iommu_map(struct iommu_domain *domain, unsigned long iova,
 
 	ret = __iommu_map(domain, iova, paddr, size, prot, GFP_KERNEL);
 	if (ret == 0 && ops->iotlb_sync_map)
-		ops->iotlb_sync_map(domain);
+		ops->iotlb_sync_map(domain, iova, size);
 
 	return ret;
 }
@@ -2575,7 +2575,7 @@ static size_t __iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
 	}
 
 	if (ops->iotlb_sync_map)
-		ops->iotlb_sync_map(domain);
+		ops->iotlb_sync_map(domain, iova, mapped);
 	return mapped;
 
 out_err:
diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index fac720273889..05e8e19b8269 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -261,7 +261,8 @@ static int gart_iommu_of_xlate(struct device *dev,
 	return 0;
 }
 
-static void gart_iommu_sync_map(struct iommu_domain *domain)
+static void gart_iommu_sync_map(struct iommu_domain *domain, unsigned long iova,
+				size_t size)
 {
 	FLUSH_GART_REGS(gart_handle);
 }
@@ -269,7 +270,9 @@ static void gart_iommu_sync_map(struct iommu_domain *domain)
 static void gart_iommu_sync(struct iommu_domain *domain,
 			    struct iommu_iotlb_gather *gather)
 {
-	gart_iommu_sync_map(domain);
+	size_t length = gather->end - gather->start;
+
+	gart_iommu_sync_map(domain, gather->start, length);
 }
 
 static const struct iommu_ops gart_iommu_ops = {
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index b3f0e2018c62..9ce0aa9e236b 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -246,7 +246,8 @@ struct iommu_ops {
 	size_t (*unmap)(struct iommu_domain *domain, unsigned long iova,
 		     size_t size, struct iommu_iotlb_gather *iotlb_gather);
 	void (*flush_iotlb_all)(struct iommu_domain *domain);
-	void (*iotlb_sync_map)(struct iommu_domain *domain);
+	void (*iotlb_sync_map)(struct iommu_domain *domain, unsigned long iova,
+			       size_t size);
 	void (*iotlb_sync)(struct iommu_domain *domain,
 			   struct iommu_iotlb_gather *iotlb_gather);
 	phys_addr_t (*iova_to_phys)(struct iommu_domain *domain, dma_addr_t iova);


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
