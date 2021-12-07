Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC34C433F5
	for <iommu@archiver.kernel.org>; Tue,  7 Dec 2021 06:54:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7DBCC41C18;
	Tue,  7 Dec 2021 06:54:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iBwlqsqhiJqf; Tue,  7 Dec 2021 06:53:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3879041BE1;
	Tue,  7 Dec 2021 06:53:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 17C46C001E;
	Tue,  7 Dec 2021 06:53:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 85318C0012
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 06:53:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6EE2D80CDB
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 06:53:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cIJvnM6DxZI2 for <iommu@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 06:53:53 +0000 (UTC)
X-Greylist: delayed 00:15:53 by SQLgrey-1.8.0
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A462280CE1
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 06:53:53 +0000 (UTC)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.57])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4J7VsQ32TkzZdSk;
 Tue,  7 Dec 2021 14:35:06 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 7 Dec 2021 14:37:55 +0800
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Joerg
 Roedel <joro@8bytes.org>
Subject: [PATCH] Revert "iommu/arm-smmu-v3: Decrease the queue size of evtq
 and priq"
Date: Tue, 7 Dec 2021 14:32:48 +0800
Message-ID: <1638858768-9971-1-git-send-email-wangzhou1@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
Cc: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
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
From: Zhou Wang via iommu <iommu@lists.linux-foundation.org>
Reply-To: Zhou Wang <wangzhou1@hisilicon.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

The commit f115f3c0d5d8 ("iommu/arm-smmu-v3: Decrease the queue size of
evtq and priq") decreases evtq and priq, which may lead evtq/priq to be
full with fault events, e.g HiSilicon ZIP/SEC/HPRE have maximum 1024 queues
in one device, every queue could be binded with one process and trigger a
fault event. So let's revert f115f3c0d5d8.

In fact, if an implementation of SMMU really does not need so long evtq
and priq, value of IDR1_EVTQS and IDR1_PRIQS can be set to proper ones.

Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 4cb136f..cd48590 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -184,7 +184,6 @@
 #else
 #define Q_MAX_SZ_SHIFT			(PAGE_SHIFT + MAX_ORDER - 1)
 #endif
-#define Q_MIN_SZ_SHIFT			(PAGE_SHIFT)
 
 /*
  * Stream table.
@@ -374,7 +373,7 @@
 /* Event queue */
 #define EVTQ_ENT_SZ_SHIFT		5
 #define EVTQ_ENT_DWORDS			((1 << EVTQ_ENT_SZ_SHIFT) >> 3)
-#define EVTQ_MAX_SZ_SHIFT		(Q_MIN_SZ_SHIFT - EVTQ_ENT_SZ_SHIFT)
+#define EVTQ_MAX_SZ_SHIFT		(Q_MAX_SZ_SHIFT - EVTQ_ENT_SZ_SHIFT)
 
 #define EVTQ_0_ID			GENMASK_ULL(7, 0)
 
@@ -400,7 +399,7 @@
 /* PRI queue */
 #define PRIQ_ENT_SZ_SHIFT		4
 #define PRIQ_ENT_DWORDS			((1 << PRIQ_ENT_SZ_SHIFT) >> 3)
-#define PRIQ_MAX_SZ_SHIFT		(Q_MIN_SZ_SHIFT - PRIQ_ENT_SZ_SHIFT)
+#define PRIQ_MAX_SZ_SHIFT		(Q_MAX_SZ_SHIFT - PRIQ_ENT_SZ_SHIFT)
 
 #define PRIQ_0_SID			GENMASK_ULL(31, 0)
 #define PRIQ_0_SSID			GENMASK_ULL(51, 32)
-- 
2.8.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
