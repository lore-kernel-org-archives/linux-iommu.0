Return-Path: <SRS0=Q5U9=VI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F58DC71142
	for <iommu@archiver.kernel.org>; Thu, 11 Jul 2019 17:30:15 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46E3720863
	for <iommu@archiver.kernel.org>; Thu, 11 Jul 2019 17:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NrqXsGi+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46E3720863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id B0A1454C1;
	Thu, 11 Jul 2019 17:28:57 +0000 (UTC)
Received: from smtp2.linuxfoundation.org (smtp2.linux-foundation.org
	[172.17.192.36])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 36A051E09
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Jul 2019 17:20:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp2.linuxfoundation.org (Postfix) with ESMTPS id DA6A51DCF0
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Jul 2019 17:20:25 +0000 (UTC)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
	[217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 530CC20863;
	Thu, 11 Jul 2019 17:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562865625;
	bh=73sEysttSNwzSpiMxnQD/BCR7dkoVafuHPJ7AMkEu9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NrqXsGi+uXc4uOXKBvJ6x4IZUnBZsVDqrpKHxPXhqGSGZTksClJWZwchINzBvmCRP
	/Yulg9klU9/SkbWNw/1/a/7/2afyAtdDSn/N1uW1BUvVQ4ei7DmjAAeqtLa0NTCpJD
	DUdeEG9pi57f1WRvVqRuFJ3d7IPTImqBf1Bpv5Oc=
From: Will Deacon <will@kernel.org>
To: iommu@lists.linux-foundation.org
Subject: [RFC PATCH v2 15/19] iommu/arm-smmu-v3: Drop unused 'q' argument from
	Q_OVF macro
Date: Thu, 11 Jul 2019 18:19:23 +0100
Message-Id: <20190711171927.28803-16-will@kernel.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190711171927.28803-1-will@kernel.org>
References: <20190711171927.28803-1-will@kernel.org>
Cc: Vijay Kilary <vkilari@codeaurora.org>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	Will Deacon <will@kernel.org>, Jan Glauber <jglauber@marvell.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
	Jon Masters <jcm@redhat.com>, Robin Murphy <robin.murphy@arm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

The Q_OVF macro doesn't need to access the arm_smmu_queue structure, so
drop the unused macro argument.

No functional change.

Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/iommu/arm-smmu-v3.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 2ffdf4b3ecf0..86a8487e5880 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -184,7 +184,7 @@
 #define Q_IDX(q, p)			((p) & ((1 << (q)->max_n_shift) - 1))
 #define Q_WRP(q, p)			((p) & (1 << (q)->max_n_shift))
 #define Q_OVERFLOW_FLAG			(1 << 31)
-#define Q_OVF(q, p)			((p) & Q_OVERFLOW_FLAG)
+#define Q_OVF(p)			((p) & Q_OVERFLOW_FLAG)
 #define Q_ENT(q, p)			((q)->base +			\
 					 Q_IDX(q, p) * (q)->ent_dwords)
 
@@ -709,7 +709,7 @@ static void queue_sync_cons_out(struct arm_smmu_queue *q)
 static void queue_inc_cons(struct arm_smmu_queue *q)
 {
 	u32 cons = (Q_WRP(q, q->cons) | Q_IDX(q, q->cons)) + 1;
-	q->cons = Q_OVF(q, q->cons) | Q_WRP(q, cons) | Q_IDX(q, cons);
+	q->cons = Q_OVF(q->cons) | Q_WRP(q, cons) | Q_IDX(q, cons);
 }
 
 static int queue_sync_prod_in(struct arm_smmu_queue *q)
@@ -717,7 +717,7 @@ static int queue_sync_prod_in(struct arm_smmu_queue *q)
 	int ret = 0;
 	u32 prod = readl_relaxed(q->prod_reg);
 
-	if (Q_OVF(q, prod) != Q_OVF(q, q->prod))
+	if (Q_OVF(prod) != Q_OVF(q->prod))
 		ret = -EOVERFLOW;
 
 	q->prod = prod;
@@ -732,7 +732,7 @@ static void queue_sync_prod_out(struct arm_smmu_queue *q)
 static void queue_inc_prod(struct arm_smmu_queue *q)
 {
 	u32 prod = (Q_WRP(q, q->prod) | Q_IDX(q, q->prod)) + 1;
-	q->prod = Q_OVF(q, q->prod) | Q_WRP(q, prod) | Q_IDX(q, prod);
+	q->prod = Q_OVF(q->prod) | Q_WRP(q, prod) | Q_IDX(q, prod);
 }
 
 /*
@@ -1328,7 +1328,7 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 	} while (!queue_empty(q));
 
 	/* Sync our overflow flag, as we believe we're up to speed */
-	q->cons = Q_OVF(q, q->prod) | Q_WRP(q, q->cons) | Q_IDX(q, q->cons);
+	q->cons = Q_OVF(q->prod) | Q_WRP(q, q->cons) | Q_IDX(q, q->cons);
 	return IRQ_HANDLED;
 }
 
@@ -1385,7 +1385,7 @@ static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
 	} while (!queue_empty(q));
 
 	/* Sync our overflow flag, as we believe we're up to speed */
-	q->cons = Q_OVF(q, q->prod) | Q_WRP(q, q->cons) | Q_IDX(q, q->cons);
+	q->cons = Q_OVF(q->prod) | Q_WRP(q, q->cons) | Q_IDX(q, q->cons);
 	writel(q->cons, q->cons_reg);
 	return IRQ_HANDLED;
 }
-- 
2.11.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
