Return-Path: <SRS0=A+5j=IY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1344C433E0
	for <iommu@archiver.kernel.org>; Fri, 26 Mar 2021 06:25:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35F8461A43
	for <iommu@archiver.kernel.org>; Fri, 26 Mar 2021 06:25:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35F8461A43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B208B84B8F;
	Fri, 26 Mar 2021 06:25:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Voz5m9EjcpX6; Fri, 26 Mar 2021 06:25:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id A8F6A84BA1;
	Fri, 26 Mar 2021 06:25:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6CBF4C0014;
	Fri, 26 Mar 2021 06:25:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 884D1C000A
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 06:25:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 84DA684183
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 06:25:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L7IibRN1_F_u for <iommu@lists.linux-foundation.org>;
 Fri, 26 Mar 2021 06:25:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AD64C83E9F
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 06:25:40 +0000 (UTC)
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F6Bjj4w3qznWsf;
 Fri, 26 Mar 2021 14:23:05 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.179.202) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Fri, 26 Mar 2021 14:25:31 +0800
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
Subject: [PATCH 5/8] iommu: fix a couple of spelling mistakes
Date: Fri, 26 Mar 2021 14:24:09 +0800
Message-ID: <20210326062412.1262-6-thunder.leizhen@huawei.com>
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
funcions ==> functions
distiguish ==> distinguish
detroyed ==> destroyed

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/iommu.c | 4 ++--
 drivers/iommu/iova.c  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d0b0a15dba8413c..0f4e9a6122ee58f 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1453,7 +1453,7 @@ struct iommu_group *pci_device_group(struct device *dev)
 
 	/*
 	 * Look for existing groups on non-isolated functions on the same
-	 * slot and aliases of those funcions, if any.  No need to clear
+	 * slot and aliases of those functions, if any.  No need to clear
 	 * the search bitmap, the tested devfns are still valid.
 	 */
 	group = get_pci_function_alias_group(pdev, (unsigned long *)devfns);
@@ -2267,7 +2267,7 @@ struct iommu_domain *iommu_get_dma_domain(struct device *dev)
  * iterating over the devices in a group.  Ideally we'd have a single
  * device which represents the requestor ID of the group, but we also
  * allow IOMMU drivers to create policy defined minimum sets, where
- * the physical hardware may be able to distiguish members, but we
+ * the physical hardware may be able to distinguish members, but we
  * wish to group them at a higher level (ex. untrusted multi-function
  * PCI devices).  Thus we attach each device.
  */
diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index e6e2fa85271c3f8..bf710b0a3713e21 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -524,7 +524,7 @@ static void fq_destroy_all_entries(struct iova_domain *iovad)
 	int cpu;
 
 	/*
-	 * This code runs when the iova_domain is being detroyed, so don't
+	 * This code runs when the iova_domain is being destroyed, so don't
 	 * bother to free iovas, just call the entry_dtor on all remaining
 	 * entries.
 	 */
-- 
1.8.3


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
