Return-Path: <SRS0=OQvg=FN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9552C4361B
	for <iommu@archiver.kernel.org>; Wed,  9 Dec 2020 15:54:21 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 091BF22B47
	for <iommu@archiver.kernel.org>; Wed,  9 Dec 2020 15:54:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 091BF22B47
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id A3AF1873C5;
	Wed,  9 Dec 2020 15:54:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k7uZm1xDCm4s; Wed,  9 Dec 2020 15:54:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 03F1987522;
	Wed,  9 Dec 2020 15:54:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DCEF4C0893;
	Wed,  9 Dec 2020 15:54:19 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E0917C013B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 15:54:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id CA4DD873E1
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 15:54:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4q9kKrbK7v76 for <iommu@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 15:54:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 3BD94873C5
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 15:54:17 +0000 (UTC)
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CrhRV3xxwz7Bpn;
 Wed,  9 Dec 2020 23:53:42 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Wed, 9 Dec 2020 23:54:06 +0800
From: John Garry <john.garry@huawei.com>
To: <joro@8bytes.org>, <will@kernel.org>
Subject: [PATCH 1/3] iova: Make has_iova_flush_queue() private
Date: Wed, 9 Dec 2020 23:50:17 +0800
Message-ID: <1607529019-229549-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1607529019-229549-1-git-send-email-john.garry@huawei.com>
References: <1607529019-229549-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Cc: iommu@lists.linux-foundation.org, robin.murphy@arm.com,
 linux-kernel@vger.kernel.org, linuxarm@huawei.com
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

Function has_iova_flush_queue() has no users outside iova.c, so make it
private.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/iommu/iova.c | 2 +-
 include/linux/iova.h | 6 ------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 4bb3293ae4d7..0a758ec2a1c4 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -55,7 +55,7 @@ init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 }
 EXPORT_SYMBOL_GPL(init_iova_domain);
 
-bool has_iova_flush_queue(struct iova_domain *iovad)
+static bool has_iova_flush_queue(struct iova_domain *iovad)
 {
 	return !!iovad->fq;
 }
diff --git a/include/linux/iova.h b/include/linux/iova.h
index 76e16ae20729..2b76e0be1c5b 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -153,7 +153,6 @@ struct iova *reserve_iova(struct iova_domain *iovad, unsigned long pfn_lo,
 void copy_reserved_iova(struct iova_domain *from, struct iova_domain *to);
 void init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 	unsigned long start_pfn);
-bool has_iova_flush_queue(struct iova_domain *iovad);
 int init_iova_flush_queue(struct iova_domain *iovad,
 			  iova_flush_cb flush_cb, iova_entry_dtor entry_dtor);
 struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn);
@@ -223,11 +222,6 @@ static inline void init_iova_domain(struct iova_domain *iovad,
 {
 }
 
-static inline bool has_iova_flush_queue(struct iova_domain *iovad)
-{
-	return false;
-}
-
 static inline int init_iova_flush_queue(struct iova_domain *iovad,
 					iova_flush_cb flush_cb,
 					iova_entry_dtor entry_dtor)
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
