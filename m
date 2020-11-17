Return-Path: <SRS0=JfyE=EX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E563FC63777
	for <iommu@archiver.kernel.org>; Tue, 17 Nov 2020 10:30:08 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 498E9222E8
	for <iommu@archiver.kernel.org>; Tue, 17 Nov 2020 10:30:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 498E9222E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id C567587152;
	Tue, 17 Nov 2020 10:30:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v2RgAGG80Tf4; Tue, 17 Nov 2020 10:30:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0B60487153;
	Tue, 17 Nov 2020 10:30:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E438FC0FAA;
	Tue, 17 Nov 2020 10:30:05 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7BE34C07FF
 for <iommu@lists.linux-foundation.org>; Tue, 17 Nov 2020 10:30:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 77EBF8669A
 for <iommu@lists.linux-foundation.org>; Tue, 17 Nov 2020 10:30:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K+BnSlP3gXbT for <iommu@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 10:30:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B616086690
 for <iommu@lists.linux-foundation.org>; Tue, 17 Nov 2020 10:30:01 +0000 (UTC)
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Cb2Hw3kyFzhbgZ;
 Tue, 17 Nov 2020 18:29:48 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Tue, 17 Nov 2020 18:29:51 +0800
From: John Garry <john.garry@huawei.com>
To: <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>
Subject: [RESEND PATCH v3 2/4] iommu/iova: Avoid double-negatives in magazine
 helpers
Date: Tue, 17 Nov 2020 18:25:32 +0800
Message-ID: <1605608734-84416-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1605608734-84416-1-git-send-email-john.garry@huawei.com>
References: <1605608734-84416-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Cc: linuxarm@huawei.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, xiyou.wangcong@gmail.com
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
   ESR = 0x96000004
   EC = 0x25: DABT (current EL), IL = 32 bits
   SET = 0, FnV = 0
   EA = 0, S1PTW = 0
Data abort info:
   ISV = 0, ISS = 0x00000004
   CM = 0, WnR = 0
[0000000000000000] user address but active_mm is swapper
Internal error: Oops: 96000004 [#1] PREEMPT SMP
Modules linked in:
CPU: 11 PID: 696 Comm: irq/40-hisi_sas Not tainted 5.9.0-rc7-dirty #109
Hardware name: Huawei D06 /D06, BIOS Hisilicon D06 UEFI RC0 - V1.16.01 03/15/2019
Call trace:
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

Code: f9400060 f102001f 54000981 d4210000 (f9400043)

 ---[ end trace 4afcbdfc61b60467 ]---

The issue is that expression !iova_magazine_full(NULL) evaluates true; this
falls over in in __iova_rcache_insert() when we attempt to cache a mag
and cpu_rcache->loaded == NULL:

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
---
 drivers/iommu/iova.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 81b7399dd5e8..1f3f0f8b12e0 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -827,14 +827,18 @@ iova_magazine_free_pfns(struct iova_magazine *mag, struct iova_domain *iovad)
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
@@ -843,7 +847,7 @@ static unsigned long iova_magazine_pop(struct iova_magazine *mag,
 	int i;
 	unsigned long pfn;
 
-	BUG_ON(iova_magazine_empty(mag));
+	BUG_ON(!iova_magazine_has_pfns(mag));
 
 	/* Only fall back to the rbtree if we have no suitable pfns at all */
 	for (i = mag->size - 1; mag->pfns[i] > limit_pfn; i--)
@@ -859,7 +863,7 @@ static unsigned long iova_magazine_pop(struct iova_magazine *mag,
 
 static void iova_magazine_push(struct iova_magazine *mag, unsigned long pfn)
 {
-	BUG_ON(iova_magazine_full(mag));
+	BUG_ON(!iova_magazine_has_space(mag));
 
 	mag->pfns[mag->size++] = pfn;
 }
@@ -905,9 +909,9 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
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
@@ -916,8 +920,9 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
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
@@ -968,9 +973,9 @@ static unsigned long __iova_rcache_get(struct iova_rcache *rcache,
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
