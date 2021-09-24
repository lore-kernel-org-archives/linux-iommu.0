Return-Path: <SRS0=LkSb=OO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BA2C433FE
	for <iommu@archiver.kernel.org>; Fri, 24 Sep 2021 10:07:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C47661164
	for <iommu@archiver.kernel.org>; Fri, 24 Sep 2021 10:07:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4C47661164
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2DF4D40794;
	Fri, 24 Sep 2021 10:07:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0wxbRomGRXcE; Fri, 24 Sep 2021 10:07:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A6F7E414C9;
	Fri, 24 Sep 2021 10:07:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8B85AC001C;
	Fri, 24 Sep 2021 10:07:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 18EABC000D;
 Fri, 24 Sep 2021 10:07:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6590641578;
 Fri, 24 Sep 2021 10:07:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4cR2H3qknfD8; Fri, 24 Sep 2021 10:07:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 84607415A4;
 Fri, 24 Sep 2021 10:07:21 +0000 (UTC)
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HG7171BvYz67fr9;
 Fri, 24 Sep 2021 18:04:27 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 24 Sep 2021 12:07:19 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 24 Sep 2021 11:07:15 +0100
From: John Garry <john.garry@huawei.com>
To: <joro@8bytes.org>, <will@kernel.org>, <mst@redhat.com>,
 <jasowang@redhat.com>, <robin.murphy@arm.com>
Subject: [PATCH 5/5] iommu/iova: Avoid double-negatives in magazine helpers
Date: Fri, 24 Sep 2021 18:01:57 +0800
Message-ID: <1632477717-5254-6-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1632477717-5254-1-git-send-email-john.garry@huawei.com>
References: <1632477717-5254-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: linuxarm@huawei.com, linux-kernel@vger.kernel.org, xieyongji@bytedance.com,
 iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org
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

A similar crash to the following could be observed if initial CPU rcache
magazine allocations fail in init_iova_rcaches():

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
Mem abort info:

  free_iova_fast+0xfc/0x280
  iommu_dma_free_iova+0x64/0x70
  __iommu_dma_unmap+0x9c/0xf8
  iommu_dma_unmap_sg+0xa8/0xc8
  dma_unmap_sg_attrs+0x28/0x50
  cq_thread_v3_hw+0x2dc/0x528
  irq_thread_fn+0x2c/0xa0
  irq_thread+0x130/0x1e0
  kthread+0x154/0x158
  ret_from_fork+0x10/0x34

The issue is that expression !iova_magazine_full(NULL) evaluates true; this
falls over in __iova_rcache_insert() when we attempt to cache a mag and
cpu_rcache->loaded == NULL:

if (!iova_magazine_full(cpu_rcache->loaded)) {
	can_insert = true;
...

if (can_insert)
	iova_magazine_push(cpu_rcache->loaded, iova_pfn);

As above, can_insert is evaluated true, which it shouldn't be, and we try
to insert pfns in a NULL mag, which is not safe.

To avoid this, stop using double-negatives, like !iova_magazine_full() and
!iova_magazine_empty(), and use positive tests, like
iova_magazine_has_space() and iova_magazine_has_pfns(), respectively; these
can safely deal with cpu_rcache->{loaded, prev} = NULL.

Signed-off-by: John Garry <john.garry@huawei.com>
Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/iova.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 30eb128b1581..978ff7921029 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -688,14 +688,18 @@ iova_magazine_free_pfns(struct iova_magazine *mag, struct iova_domain *iovad)
 	mag->size = 0;
 }
 
-static bool iova_magazine_full(struct iova_magazine *mag)
+static bool iova_magazine_has_space(struct iova_magazine *mag)
 {
-	return (mag && mag->size == IOVA_MAG_SIZE);
+	if (!mag)
+		return false;
+	return mag->size < IOVA_MAG_SIZE;
 }
 
-static bool iova_magazine_empty(struct iova_magazine *mag)
+static bool iova_magazine_has_pfns(struct iova_magazine *mag)
 {
-	return (!mag || mag->size == 0);
+	if (!mag)
+		return false;
+	return mag->size;
 }
 
 static unsigned long iova_magazine_pop(struct iova_magazine *mag,
@@ -704,7 +708,7 @@ static unsigned long iova_magazine_pop(struct iova_magazine *mag,
 	int i;
 	unsigned long pfn;
 
-	BUG_ON(iova_magazine_empty(mag));
+	BUG_ON(!iova_magazine_has_pfns(mag));
 
 	/* Only fall back to the rbtree if we have no suitable pfns at all */
 	for (i = mag->size - 1; mag->pfns[i] > limit_pfn; i--)
@@ -720,7 +724,7 @@ static unsigned long iova_magazine_pop(struct iova_magazine *mag,
 
 static void iova_magazine_push(struct iova_magazine *mag, unsigned long pfn)
 {
-	BUG_ON(iova_magazine_full(mag));
+	BUG_ON(!iova_magazine_has_space(mag));
 
 	mag->pfns[mag->size++] = pfn;
 }
@@ -772,9 +776,9 @@ static bool __iova_rcache_insert(struct iova_caching_domain *rcached,
 	cpu_rcache = raw_cpu_ptr(rcache->cpu_rcaches);
 	spin_lock_irqsave(&cpu_rcache->lock, flags);
 
-	if (!iova_magazine_full(cpu_rcache->loaded)) {
+	if (iova_magazine_has_space(cpu_rcache->loaded)) {
 		can_insert = true;
-	} else if (!iova_magazine_full(cpu_rcache->prev)) {
+	} else if (iova_magazine_has_space(cpu_rcache->prev)) {
 		swap(cpu_rcache->prev, cpu_rcache->loaded);
 		can_insert = true;
 	} else {
@@ -783,8 +787,9 @@ static bool __iova_rcache_insert(struct iova_caching_domain *rcached,
 		if (new_mag) {
 			spin_lock(&rcache->lock);
 			if (rcache->depot_size < MAX_GLOBAL_MAGS) {
-				rcache->depot[rcache->depot_size++] =
-						cpu_rcache->loaded;
+				if (cpu_rcache->loaded)
+					rcache->depot[rcache->depot_size++] =
+							cpu_rcache->loaded;
 			} else {
 				mag_to_free = cpu_rcache->loaded;
 			}
@@ -835,9 +840,9 @@ static unsigned long __iova_rcache_get(struct iova_rcache *rcache,
 	cpu_rcache = raw_cpu_ptr(rcache->cpu_rcaches);
 	spin_lock_irqsave(&cpu_rcache->lock, flags);
 
-	if (!iova_magazine_empty(cpu_rcache->loaded)) {
+	if (iova_magazine_has_pfns(cpu_rcache->loaded)) {
 		has_pfn = true;
-	} else if (!iova_magazine_empty(cpu_rcache->prev)) {
+	} else if (iova_magazine_has_pfns(cpu_rcache->prev)) {
 		swap(cpu_rcache->prev, cpu_rcache->loaded);
 		has_pfn = true;
 	} else {
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
