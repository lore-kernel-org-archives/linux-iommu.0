Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5E3414A08
	for <iommu@lists.linux.dev>; Tue, 28 Jul 2026 21:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785272981; cv=none; b=UvveU1o6E2/n6zyj1XblMqraB/s1ZznySXf+R1bSzypjm4du9q3kM/ZZsA2jznRL4niJd745HMAPXytvYWL5oVTKd/T/g0Yvs7CnZJNt96xs4J4gSKu/qtOFEBzJXYGigOWT50xO4uaxNPcxchSwR1s3ZkWQcJKFnnwPQpM5Org=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785272981; c=relaxed/simple;
	bh=rQgPntgjdMeIhZ4r1tvR5KTEvYpviqKl+uIteb9zKfw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MLIlp17z6C29Du/dYB/adeBhVd9OHwunuC28f9O9w4Y7L2xTnx1LXeFt+5tFRHWKJ+xcV8XvV3HTdeGPxPqOJ/QcBOqq7Z4Gr2X/9Ct9xiATU6NIF5rCa6wLKhfCJWUPnnD95boqCL0upzoqpCkvYg3MDA0DFom/EUwPtxBu8Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O54p4TEu; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O54p4TEu"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c9fe4c5eb39so120121a12.1
        for <iommu@lists.linux.dev>; Tue, 28 Jul 2026 14:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785272979; x=1785877779; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ItDdBz/OEznItt090HL1h2V9CWsYvmHYiIvcswmhcxs=;
        b=O54p4TEuzuw9zkgGiJllIyx/lI1eMpkO3inGi+vKupDoZvVkh0F65rm+FlGxOSLh0s
         27GDRN/07iz9x7oHuya5nIQslxXOWMko8azxa2Hqm9i6Yc8YMIqbtNQftbd6zg9n621i
         Ym6ll4wRCqcl1RXuFU0uWtFqYHqdLf+de5UvhGN2EgqIXKqPNU1v2brZcYylTirPHNt2
         IeR08x/lNfMRviQ9AU/NtikdTHmJWAdvgl1pQ2ZudZrEIZfckj6OhV5zw98yB7x/qF1+
         PUn2iBltIiDcVGJ5kEjdV3FGcCKZz3wAlZIxxs8stbr6Q7x0MFEYRtPHssHZKtt7ahwE
         gtdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785272979; x=1785877779;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ItDdBz/OEznItt090HL1h2V9CWsYvmHYiIvcswmhcxs=;
        b=JFTbjNAsIQL20JHQabwWVDHzBqto9kwPBmE+vHBVQK6hnwct7xNdjfRoJhBlOeV3Ye
         cRhhtigx1Ssb8UHSV2LHoBAnxYakQOgJOwUDLUXe4pkbgeR+1RxCvamycUVZGwexmVa4
         EeerGKAyxay6yTYeHx5GmFePDQgmBJd9auHk5Ik4JSU3KBiq4Lumh3PeukzU4C+S+NMz
         QroD4BjJzSWDw+mDB1JtZT0fuJ8MDp8BnzDQu7UITxbgWSPBX/h7DVJJn/sdbZ9J/nE7
         5NfWz5yhUx8XoEBo9hJTioXUPclgZG9+Webm+F90NY7xEi4w95qMNiM278UrPm/HTAhe
         oqsA==
X-Gm-Message-State: AOJu0YwPHuVALd9IrtZYy62SExVPp+I0mUKoUDs7nNn2EbORvrwgXHbp
	bdU+kI6pis3qlBnVCGQriQS/T4Ok1f9gRYaMmdvsz1xHH4VORBV59o670py6qELDLaTvLeH0hoA
	Lvdhqb1PjM2qi/xv9mmsMxkbKg/Y7mANbusDGQBc9YL4b2DcKdqReQv30kkA2no4p2anoSHPuyx
	SEyKLWjxKKIfIefzbzVger6cKts/ePMw==
X-Received: from pglf4.prod.google.com ([2002:a63:1004:0:b0:c88:b675:3609])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:7d03:b0:3b4:e4f6:4f15
 with SMTP id adf61e73a8af0-3c8aafa2ac3mr5229665637.5.1785272979218; Tue, 28
 Jul 2026 14:09:39 -0700 (PDT)
Date: Tue, 28 Jul 2026 21:09:18 +0000
In-Reply-To: <20260728210928.1050849-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260728210928.1050849-1-praan@google.com>
X-Mailer: git-send-email 2.55.0.487.gaf234c4eb3-goog
Message-ID: <20260728210928.1050849-3-praan@google.com>
Subject: [PATCH v9 02/12] iommu/arm-smmu-v3: Add a helper to drain cmd queues
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	linux-arm-kernel@lists.infradead.org, Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Before we suspend SMMU, we want to ensure that all commands (especially
ATC_INV) have been flushed by the CMDQ, i.e. the CMDQs are empty.
Add a helper function that polls till the queues are dained.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 45 +++++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  3 ++
 2 files changed, 48 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index a11f5bcbe77d..08b83f211ab3 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -949,6 +949,51 @@ static int arm_smmu_cmdq_batch_submit(struct arm_smmu_device *smmu,
 					   cmds->num, true);
 }
 
+/*
+ * Currently, only used for CMDQ.
+ * TODO: Update to handle PRIQ & EVTQ when PRI support is added
+ */
+int arm_smmu_queue_poll_until_empty(struct arm_smmu_device *smmu,
+				    struct arm_smmu_queue *q)
+{
+	struct arm_smmu_queue_poll qp;
+	struct arm_smmu_ll_queue *llq = &q->llq;
+	int ret = 0;
+
+	queue_poll_init(smmu, &qp);
+
+	/*
+	 * The events are only generated when CMDQ becomes non-full.
+	 * Thus, wfe can't be used here, mark it false explicitly.
+	 */
+	qp.wfe = false;
+
+	do {
+		WRITE_ONCE(llq->cons, readl_relaxed(q->cons_reg));
+		if (queue_empty(llq))
+			break;
+
+		ret = queue_poll(&qp);
+
+	} while (!ret);
+
+	return ret;
+}
+
+static int arm_smmu_drain_queues(struct arm_smmu_device *smmu)
+{
+	int ret;
+
+	/*
+	 * We skip the cmdq locking here since this helper is only called
+	 * from contexts (like suspend) where the caller has already
+	 * ensured that new command submissions are fully closed.
+	 */
+	ret = arm_smmu_queue_poll_until_empty(smmu, &smmu->cmdq.q);
+
+	return ret;
+}
+
 static void arm_smmu_page_response(struct device *dev, struct iopf_fault *unused,
 				   struct iommu_page_response *resp)
 {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 43f4d24e7847..00ad2e0c257b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1167,6 +1167,9 @@ int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 int arm_smmu_cmdq_init(struct arm_smmu_device *smmu,
 		       struct arm_smmu_cmdq *cmdq);
 
+int arm_smmu_queue_poll_until_empty(struct arm_smmu_device *smmu,
+				    struct arm_smmu_queue *q);
+
 static inline bool arm_smmu_master_canwbs(struct arm_smmu_master *master)
 {
 	return dev_iommu_fwspec_get(master->dev)->flags &
-- 
2.55.0.487.gaf234c4eb3-goog

