Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204A32853FD
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 19:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776196039; cv=none; b=cafaPyH3mDH0hLDEMuwbsbwiiqoeU2+9w5C6Z6C/LXqTFc3JzgTbemgpAXSNSpE/LQh8Egux1mXk//hO1acxY6zsXccQ8tS6JJXXnyKRm05Im+pkxMERI7zh6n9oa41pLo8ngH4QAinqwu2wCu2Bd3OfzR3+Jm/d7saduCBkdtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776196039; c=relaxed/simple;
	bh=xzz0r1/IEwgnPyxmFR1UoUQQP7OoInk7p4uHj32ywTU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=alHIQ8SwsWcxoIe0m0WkHS+s01zgL0nzl0sAtXZIka7zTOsSsaJ9rzcsyZ9J40UYYBQUI9ERU1xoWF8Vy+WzIQX+1cauHcd0oCFql1cb9rokyzLMwoEIL0BfO9ooe9nVpWW+bxuyA0vIwkyui+C6TTdsnN+QQ0nMGfQ15XKT3D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=REf3p1Oz; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="REf3p1Oz"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35845fcf0f5so6301336a91.0
        for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 12:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776196037; x=1776800837; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=k6d4vshoTc7Cn5aibS0swSzk6eoAREVEmFr3bw4AgkM=;
        b=REf3p1OziRpU/U5mkhaEfEgx5uq7d0c6mtXnagB9XP5cDZ1NzimUBphqhBa8uP1yr3
         2BR8oXMlmAnmvWsSuOLb1ATzeh0cmDAvqw7A7VAnUCnBvD0HKpye+tnjkoh8cprD6wZP
         4CKAgvoMly7yP2Fk36LZ0ZIwouc8i45K2Ttxvv3cC8I7qf3OLDEtY/FmDPuKc4339jsa
         TswXhIC0CGbn2rpk/bbDojygkPpQQgTP8sZrrqZkWIRZSe4eZp164lNhJCajj/i1H4R4
         3J8Wbk46LZkM34x0WsmlViwFZ8vv9YqIsRFvKBnyJC361AqpMdf29SeH1DHXgiz2k3LC
         cd9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776196037; x=1776800837;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k6d4vshoTc7Cn5aibS0swSzk6eoAREVEmFr3bw4AgkM=;
        b=E0TGi31M/pJn8vl5hWmKrtZZmHnjkLy+1M+WJCdrDgJFXNlOQx0bW18uJ8ICP6JCzv
         nnQwzA2XiT2C9IYGOgzXcVRb1hMIVpf9Qptyrwa8cw77mgGwCirWztEAUjONXclvieBX
         3QC15CVBJFwnAWtEDeaRV1aNBfJ1mXnxs33vi48mTO77dXdpAnnf3U/Gykq/OmlQ/bA9
         yZaPtbB3Ykz16uCxXq8TGCDfReoKouDvp1IxQ68r96g7viQoui1BGqWAa0vMiAgfemI3
         HGJX9oUmo9JsMxKZ6iloWbjyWuaBdqodmFGxynBrRl/wqDknlfCbgiWUrW+mPyoxxQ3J
         A0bg==
X-Gm-Message-State: AOJu0YyjPXMyNTOgnbTMO7RteZG6ff9N/qPgbV3d7xvc5HHFQVEx+hAs
	kU1la3ks7TpwK9VLipFLCZvincSMUll58T1I+5V8PYu+IIwVZHVG2IDi7ZZ3aiKPq3NQL2Ptg+i
	s39rau4GI2TLY/LQc3B3NOwBaoSfVilRQgG7RQsgn23A7LIvqb/+D40FM6SrnMUF298KNwqQj+Q
	GFZO9fQkJSXRqLOuKkz7E6V/hs1qeuQA==
X-Received: from pjbhl3.prod.google.com ([2002:a17:90b:1343:b0:35d:a369:bbea])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3f86:b0:35f:c493:cac5
 with SMTP id 98e67ed59e1d1-35fc493cfa7mr3816184a91.16.1776196037180; Tue, 14
 Apr 2026 12:47:17 -0700 (PDT)
Date: Tue, 14 Apr 2026 19:46:54 +0000
In-Reply-To: <20260414194702.1229094-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260414194702.1229094-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.rc0.605.g598a273b03-goog
Message-ID: <20260414194702.1229094-3-praan@google.com>
Subject: [PATCH v6 02/10] iommu/arm-smmu-v3: Add a helper to drain cmd queues
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Ashish Mhetre <amhetre@nvidia.com>, Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Before we suspend SMMU, we want to ensure that all commands (especially
ATC_INV) have been flushed by the CMDQ, i.e. the CMDQs are empty.
Add a helper function that polls till the queues are dained.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 34 +++++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  3 ++
 2 files changed, 37 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index a77e0472e5c0..088a7d1c002b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -993,6 +993,40 @@ static int arm_smmu_cmdq_batch_submit(struct arm_smmu_device *smmu,
 					   cmds->num, true);
 }
 
+int arm_smmu_queue_poll_until_empty(struct arm_smmu_device *smmu,
+				    struct arm_smmu_queue *q)
+{
+	struct arm_smmu_queue_poll qp;
+	struct arm_smmu_ll_queue *llq = &q->llq;
+	int ret = 0;
+
+	queue_poll_init(smmu, &qp);
+	do {
+		if (queue_empty(llq))
+			break;
+
+		ret = queue_poll(&qp);
+		WRITE_ONCE(llq->cons, readl_relaxed(q->cons_reg));
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
+	 * Since this is only called from the suspend callback where
+	 * exclusive access is ensured as CMDQ_PROD_STOP_FLAG blocks new
+	 * command submissions to the cmdq, we can skip the cmdq locking.
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
index ef42df4753ec..47799d58d10c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1098,6 +1098,9 @@ int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 int arm_smmu_cmdq_init(struct arm_smmu_device *smmu,
 		       struct arm_smmu_cmdq *cmdq);
 
+int arm_smmu_queue_poll_until_empty(struct arm_smmu_device *smmu,
+				    struct arm_smmu_queue *q);
+
 static inline bool arm_smmu_master_canwbs(struct arm_smmu_master *master)
 {
 	return dev_iommu_fwspec_get(master->dev)->flags &
-- 
2.54.0.rc0.605.g598a273b03-goog

