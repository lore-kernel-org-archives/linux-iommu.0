Return-Path: <SRS0=REuq=G4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8EDC433DB
	for <iommu@archiver.kernel.org>; Mon, 25 Jan 2021 02:47:00 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BA1222AAA
	for <iommu@archiver.kernel.org>; Mon, 25 Jan 2021 02:47:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BA1222AAA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id E0D122043B;
	Mon, 25 Jan 2021 02:46:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2Ng7i5iHZ6CF; Mon, 25 Jan 2021 02:46:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 1D04920405;
	Mon, 25 Jan 2021 02:46:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DF108C0FA7;
	Mon, 25 Jan 2021 02:46:57 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 76F74C013A
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 02:46:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 649F486777
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 02:46:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mssnbhOfL6bL for <iommu@lists.linux-foundation.org>;
 Mon, 25 Jan 2021 02:46:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 533F28674A
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 02:46:54 +0000 (UTC)
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DPDkp1PRwzjBfN;
 Mon, 25 Jan 2021 10:45:54 +0800 (CST)
Received: from DESKTOP-5IS4806.china.huawei.com (10.174.184.42) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Mon, 25 Jan 2021 10:46:45 +0800
From: Keqian Zhu <zhukeqian1@huawei.com>
To: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <kvm@vger.kernel.org>, <kvmarm@lists.cs.columbia.edu>,
 <iommu@lists.linux-foundation.org>, Alex Williamson
 <alex.williamson@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 "Cornelia Huck" <cohuck@redhat.com>
Subject: [PATCH] vfio/iommu_type1: Mantainance a counter for non_pinned_groups
Date: Mon, 25 Jan 2021 10:46:42 +0800
Message-ID: <20210125024642.14604-1-zhukeqian1@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.174.184.42]
X-CFilter-Loop: Reflected
Cc: Mark Rutland <mark.rutland@arm.com>, jiangkunkun@huawei.com,
 Will Deacon <will@kernel.org>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Marc Zyngier <maz@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Alexios Zavras <alexios.zavras@intel.com>, James Morse <james.morse@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, wanghaibin.wang@huawei.com,
 Thomas Gleixner <tglx@linutronix.de>, Robin Murphy <robin.murphy@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Julien Thierry <julien.thierry.kdev@gmail.com>
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

With this counter, we never need to traverse all groups to update
pinned_scope of vfio_iommu.

Suggested-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
---
 drivers/vfio/vfio_iommu_type1.c | 40 +++++----------------------------
 1 file changed, 5 insertions(+), 35 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 0b4dedaa9128..bb4bbcc79101 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -73,7 +73,7 @@ struct vfio_iommu {
 	bool			v2;
 	bool			nesting;
 	bool			dirty_page_tracking;
-	bool			pinned_page_dirty_scope;
+	uint64_t		num_non_pinned_groups;
 };
 
 struct vfio_domain {
@@ -148,7 +148,6 @@ static int put_pfn(unsigned long pfn, int prot);
 static struct vfio_group *vfio_iommu_find_iommu_group(struct vfio_iommu *iommu,
 					       struct iommu_group *iommu_group);
 
-static void update_pinned_page_dirty_scope(struct vfio_iommu *iommu);
 /*
  * This code handles mapping and unmapping of user data buffers
  * into DMA'ble space using the IOMMU
@@ -714,7 +713,7 @@ static int vfio_iommu_type1_pin_pages(void *iommu_data,
 	group = vfio_iommu_find_iommu_group(iommu, iommu_group);
 	if (!group->pinned_page_dirty_scope) {
 		group->pinned_page_dirty_scope = true;
-		update_pinned_page_dirty_scope(iommu);
+		iommu->num_non_pinned_groups--;
 	}
 
 	goto pin_done;
@@ -991,7 +990,7 @@ static int update_user_bitmap(u64 __user *bitmap, struct vfio_iommu *iommu,
 	 * mark all pages dirty if any IOMMU capable device is not able
 	 * to report dirty pages and all pages are pinned and mapped.
 	 */
-	if (!iommu->pinned_page_dirty_scope && dma->iommu_mapped)
+	if (iommu->num_non_pinned_groups && dma->iommu_mapped)
 		bitmap_set(dma->bitmap, 0, nbits);
 
 	if (shift) {
@@ -1622,33 +1621,6 @@ static struct vfio_group *vfio_iommu_find_iommu_group(struct vfio_iommu *iommu,
 	return group;
 }
 
-static void update_pinned_page_dirty_scope(struct vfio_iommu *iommu)
-{
-	struct vfio_domain *domain;
-	struct vfio_group *group;
-
-	list_for_each_entry(domain, &iommu->domain_list, next) {
-		list_for_each_entry(group, &domain->group_list, next) {
-			if (!group->pinned_page_dirty_scope) {
-				iommu->pinned_page_dirty_scope = false;
-				return;
-			}
-		}
-	}
-
-	if (iommu->external_domain) {
-		domain = iommu->external_domain;
-		list_for_each_entry(group, &domain->group_list, next) {
-			if (!group->pinned_page_dirty_scope) {
-				iommu->pinned_page_dirty_scope = false;
-				return;
-			}
-		}
-	}
-
-	iommu->pinned_page_dirty_scope = true;
-}
-
 static bool vfio_iommu_has_sw_msi(struct list_head *group_resv_regions,
 				  phys_addr_t *base)
 {
@@ -2057,8 +2029,6 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 			 * addition of a dirty tracking group.
 			 */
 			group->pinned_page_dirty_scope = true;
-			if (!iommu->pinned_page_dirty_scope)
-				update_pinned_page_dirty_scope(iommu);
 			mutex_unlock(&iommu->lock);
 
 			return 0;
@@ -2188,7 +2158,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 	 * demotes the iommu scope until it declares itself dirty tracking
 	 * capable via the page pinning interface.
 	 */
-	iommu->pinned_page_dirty_scope = false;
+	iommu->num_non_pinned_groups++;
 	mutex_unlock(&iommu->lock);
 	vfio_iommu_resv_free(&group_resv_regions);
 
@@ -2416,7 +2386,7 @@ static void vfio_iommu_type1_detach_group(void *iommu_data,
 	 * to be promoted.
 	 */
 	if (update_dirty_scope)
-		update_pinned_page_dirty_scope(iommu);
+		iommu->num_non_pinned_groups--;
 	mutex_unlock(&iommu->lock);
 }
 
-- 
2.19.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
