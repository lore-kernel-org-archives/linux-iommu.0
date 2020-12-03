Return-Path: <SRS0=qXOr=FH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDD0C4361B
	for <iommu@archiver.kernel.org>; Thu,  3 Dec 2020 18:39:21 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0C9E207B6
	for <iommu@archiver.kernel.org>; Thu,  3 Dec 2020 18:39:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0C9E207B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4E8F1873F0;
	Thu,  3 Dec 2020 18:39:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OOjdMCvHhjCt; Thu,  3 Dec 2020 18:39:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9675887159;
	Thu,  3 Dec 2020 18:39:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 81335C0FA8;
	Thu,  3 Dec 2020 18:39:19 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5F68FC0FA7
 for <iommu@lists.linux-foundation.org>; Thu,  3 Dec 2020 18:39:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4BDE386932
 for <iommu@lists.linux-foundation.org>; Thu,  3 Dec 2020 18:39:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yKCKumkmUu47 for <iommu@lists.linux-foundation.org>;
 Thu,  3 Dec 2020 18:39:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 4DFC2870FE
 for <iommu@lists.linux-foundation.org>; Thu,  3 Dec 2020 18:39:13 +0000 (UTC)
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Cn4NW3qt0zkkVW;
 Fri,  4 Dec 2020 02:38:35 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Fri, 4 Dec 2020 02:39:02 +0800
From: John Garry <john.garry@huawei.com>
To: <joro@8bytes.org>, <will@kernel.org>
Subject: [PATCH 3/3] iommu: Stop exporting free_iova_mem()
Date: Fri, 4 Dec 2020 02:34:52 +0800
Message-ID: <1607020492-189471-4-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1607020492-189471-1-git-send-email-john.garry@huawei.com>
References: <1607020492-189471-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Cc: 0x7f454c46@gmail.com, linux-kernel@vger.kernel.org, linuxarm@huawei.com,
 iommu@lists.linux-foundation.org, robin.murphy@arm.com
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

It has no user outside iova.c

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/iommu/iova.c | 3 +--
 include/linux/iova.h | 5 -----
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 9fed0b040747..f68fe4c0df28 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -248,12 +248,11 @@ static struct iova *alloc_iova_mem(void)
 	return kmem_cache_zalloc(iova_cache, GFP_ATOMIC | __GFP_NOWARN);
 }
 
-void free_iova_mem(struct iova *iova)
+static void free_iova_mem(struct iova *iova)
 {
 	if (iova->pfn_lo != IOVA_ANCHOR)
 		kmem_cache_free(iova_cache, iova);
 }
-EXPORT_SYMBOL(free_iova_mem);
 
 int iova_cache_get(void)
 {
diff --git a/include/linux/iova.h b/include/linux/iova.h
index d8c011b6d4ed..76e16ae20729 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -136,7 +136,6 @@ static inline unsigned long iova_pfn(struct iova_domain *iovad, dma_addr_t iova)
 int iova_cache_get(void);
 void iova_cache_put(void);
 
-void free_iova_mem(struct iova *iova);
 void free_iova(struct iova_domain *iovad, unsigned long pfn);
 void __free_iova(struct iova_domain *iovad, struct iova *iova);
 struct iova *alloc_iova(struct iova_domain *iovad, unsigned long size,
@@ -170,10 +169,6 @@ static inline void iova_cache_put(void)
 {
 }
 
-static inline void free_iova_mem(struct iova *iova)
-{
-}
-
 static inline void free_iova(struct iova_domain *iovad, unsigned long pfn)
 {
 }
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
