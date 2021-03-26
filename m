Return-Path: <SRS0=A+5j=IY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA27BC433DB
	for <iommu@archiver.kernel.org>; Fri, 26 Mar 2021 06:25:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F94761A42
	for <iommu@archiver.kernel.org>; Fri, 26 Mar 2021 06:25:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F94761A42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4BAA9405C8;
	Fri, 26 Mar 2021 06:25:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4tJrT5V3MVEx; Fri, 26 Mar 2021 06:25:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3CB6C40251;
	Fri, 26 Mar 2021 06:25:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EEC48C0014;
	Fri, 26 Mar 2021 06:25:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DF349C000A
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 06:25:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C035E41460
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 06:25:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nASzpWYzvVy4 for <iommu@lists.linux-foundation.org>;
 Fri, 26 Mar 2021 06:25:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A0A754035F
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 06:25:41 +0000 (UTC)
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F6Bjj5r0mznWsn;
 Fri, 26 Mar 2021 14:23:05 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.179.202) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Fri, 26 Mar 2021 14:25:32 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 "Joerg Roedel" <joro@8bytes.org>, linux-arm-kernel
 <linux-arm-kernel@lists.infradead.org>, iommu
 <iommu@lists.linux-foundation.org>, linux-kernel
 <linux-kernel@vger.kernel.org>, Yong Wu <yong.wu@mediatek.com>, "Matthias
 Brugger" <matthias.bgg@gmail.com>, linux-mediatek
 <linux-mediatek@lists.infradead.org>, Maxime Ripard <mripard@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@siol.net>,
 "David Woodhouse" <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 6/8] iommu/amd: fix a couple of spelling mistakes
Date: Fri, 26 Mar 2021 14:24:10 +0800
Message-ID: <20210326062412.1262-7-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20210326062412.1262-1-thunder.leizhen@huawei.com>
References: <20210326062412.1262-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.174.179.202]
X-CFilter-Loop: Reflected
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

There are several spelling mistakes, as follows:
alignement ==> alignment
programing ==> programming
implemtation ==> implementation
assignement ==> assignment

By the way, both "programing" and "programming" are acceptable, but the
latter seems more formal.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 2 +-
 drivers/iommu/amd/init.c            | 4 ++--
 drivers/iommu/amd/iommu.c           | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 6937e3674a16e26..dc1814c355cff77 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -446,7 +446,7 @@ struct irq_remap_table {
 /* Interrupt remapping feature used? */
 extern bool amd_iommu_irq_remap;
 
-/* kmem_cache to get tables with 128 byte alignement */
+/* kmem_cache to get tables with 128 byte alignment */
 extern struct kmem_cache *amd_iommu_irq_cache;
 
 /*
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 321f5906e6ed3a5..48799002b3571d1 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1734,7 +1734,7 @@ static void __init init_iommu_perf_ctr(struct amd_iommu *iommu)
 		goto pc_false;
 
 	/*
-	 * Disable power gating by programing the performance counter
+	 * Disable power gating by programming the performance counter
 	 * source to 20 (i.e. counts the reads and writes from/to IOMMU
 	 * Reserved Register [MMIO Offset 1FF8h] that are ignored.),
 	 * which never get incremented during this init phase.
@@ -2088,7 +2088,7 @@ static int intcapxt_irqdomain_activate(struct irq_domain *domain,
 	xt.destid_24_31 = cfg->dest_apicid >> 24;
 
 	/**
-	 * Current IOMMU implemtation uses the same IRQ for all
+	 * Current IOMMU implementation uses the same IRQ for all
 	 * 3 IOMMU interrupts.
 	 */
 	writeq(xt.capxt, iommu->mmio_base + MMIO_INTCAPXT_EVT_OFFSET);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index a69a8b573e40d00..d14e4698f507b89 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1865,7 +1865,7 @@ int __init amd_iommu_init_dma_ops(void)
  * The following functions belong to the exported interface of AMD IOMMU
  *
  * This interface allows access to lower level functions of the IOMMU
- * like protection domain handling and assignement of devices to domains
+ * like protection domain handling and assignment of devices to domains
  * which is not possible with the dma_ops interface.
  *
  *****************************************************************************/
-- 
1.8.3


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
