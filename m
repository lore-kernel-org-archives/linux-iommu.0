Return-Path: <SRS0=OQvg=FN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69166C433FE
	for <iommu@archiver.kernel.org>; Wed,  9 Dec 2020 18:27:20 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF29A23BC6
	for <iommu@archiver.kernel.org>; Wed,  9 Dec 2020 18:27:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF29A23BC6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 519D7873E0;
	Wed,  9 Dec 2020 18:27:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yKnvWWoTfESH; Wed,  9 Dec 2020 18:27:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3D8E9873CF;
	Wed,  9 Dec 2020 18:27:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 21840C0FA7;
	Wed,  9 Dec 2020 18:27:18 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2DCCC013B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 18:27:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id EBAC886D4C
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 18:27:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1H9c6It0Jhsx for <iommu@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 18:27:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5F04486D29
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 18:27:15 +0000 (UTC)
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Crlr054H7z7Byc;
 Thu, 10 Dec 2020 02:26:40 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Thu, 10 Dec 2020 02:27:03 +0800
From: John Garry <john.garry@huawei.com>
To: <joro@8bytes.org>, <will@kernel.org>
Subject: [PATCH v4 1/3] iommu/iova: Add free_all_cpu_cached_iovas()
Date: Thu, 10 Dec 2020 02:23:07 +0800
Message-ID: <1607538189-237944-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1607538189-237944-1-git-send-email-john.garry@huawei.com>
References: <1607538189-237944-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Cc: linux-kernel@vger.kernel.org, linuxarm@huawei.com,
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

Add a helper function to free the CPU rcache for all online CPUs.

There also exists a function of the same name in
drivers/iommu/intel/iommu.c, but the parameters are different, and there
should be no conflict.

Signed-off-by: John Garry <john.garry@huawei.com>
Tested-by: Xiang Chen <chenxiang66@hisilicon.com>
Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/iova.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index f9c35852018d..cf1aacda2fe4 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -238,6 +238,14 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 	return -ENOMEM;
 }
 
+static void free_all_cpu_cached_iovas(struct iova_domain *iovad)
+{
+	unsigned int cpu;
+
+	for_each_online_cpu(cpu)
+		free_cpu_cached_iovas(cpu, iovad);
+}
+
 static struct kmem_cache *iova_cache;
 static unsigned int iova_cache_users;
 static DEFINE_MUTEX(iova_cache_mutex);
@@ -435,15 +443,12 @@ alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
 retry:
 	new_iova = alloc_iova(iovad, size, limit_pfn, true);
 	if (!new_iova) {
-		unsigned int cpu;
-
 		if (!flush_rcache)
 			return 0;
 
 		/* Try replenishing IOVAs by flushing rcache. */
 		flush_rcache = false;
-		for_each_online_cpu(cpu)
-			free_cpu_cached_iovas(cpu, iovad);
+		free_all_cpu_cached_iovas(iovad);
 		free_global_cached_iovas(iovad);
 		goto retry;
 	}
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
