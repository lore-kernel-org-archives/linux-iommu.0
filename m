Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4963C6A39
	for <iommu@lists.linux.dev>; Wed, 27 May 2026 22:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779920059; cv=none; b=bxyDW9yDOxlOWd6ubNKiEqU8AAfwp6q5eK3pBoeGO/cTi76oH1aXDCQEbhOdDhvTefkF4kh6RvTdsBKiKAoYmCJWSkh05hYCusUGoqCG1pswsgLcd7dYv2pSZ1PYAw1EVzPHO2P7D/3//gzRm0Ofndlke65itin6DebY6iNqmTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779920059; c=relaxed/simple;
	bh=2FNAuL0lR6xIy/H8h+KxqXb9e6mUqS/LB7KFRa2dQeQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q6UbmW+hWCvOfDOE/1AOkin1hCxIGrJP1pn6eWhqtcPligWs9j37cQCKHq7wQvycOfbBpD2TfBoHc1V5G3EWOjxF2TnYOwhco+vjXrggz6iE0vtVQLHN/st3USAwQFfHKODr7weHKrvg53kqWfiJomnUw944VTucPC8zMkyonYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sW2dnSrj; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sW2dnSrj"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bf08c2a24bso432935ad.2
        for <iommu@lists.linux.dev>; Wed, 27 May 2026 15:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779920057; x=1780524857; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xmNwprPA7hV2w0Jkxb+Nz3U2pfABHSvhMemy7L2s74M=;
        b=sW2dnSrjvv5ndkQReHKm4MEEg+LbHM7BPS1GH3RPLNoOKKtCx8Z54yZ9paOXYFxOfO
         UqyAOvdgzd+3wtBj4ept0GG4sNlFX6z7K37vg/ggQk8zAs/cIM9QYHEj2GVYMEs/wf2K
         cWUdpBmtdLgf3jl5FmR8KWOGDKgmbUF7M93T9cmd5CGrVHI0tnm5qls3Zc8kTI3PBufe
         w6E335TGmsqyjlD6fzUoXxcLD2ajO84WwuQ6doGcOnVLAEEeU3Rl9KsaSWNpKaA56Tgt
         xsTuy4yVaNhrmR0VYBinDK2A4sqROnHdtrqXF6fvNS99ygqX4zTCU7/dkkEVjuOprtEd
         T2cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779920057; x=1780524857;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xmNwprPA7hV2w0Jkxb+Nz3U2pfABHSvhMemy7L2s74M=;
        b=irMhY5DFRhkeXRy5QNkhesYfKXuczrW0Q9k8yw+6UOb8uD5tECspEUgHPKgVKhfWel
         rULz95e6b9OOxmOjdqodqkpX2T9PA1lBX9iaYqNgzWObsuJnR3H75rsCSzkqTHo8yxAk
         /q8j4Mx5ST3AtbPirHHwxFQSiKm3oYreLcFNI6H2CFS+ybRYJCMWD2UUWVeukwtDgQ16
         smp87dV2vbz+UzY1/HHU6dTjwwu9mvwO3KGwernRbexE9SakqN7K88+CEq2N1dUHPTs8
         qk71GmWR84WDG13MQDufaTFb2xM5f5A48oASnNIWwuawzaPMbVHGCMlNpjvMEsm5zARP
         WpXA==
X-Gm-Message-State: AOJu0Yxekq/QmGypVQ8up3umm/IL28ZgEquPSL6mNL9ZBD7frTT39ZBg
	K2lj0Orfv2q767HOgE1QcCKdpF69zlwti+ndDIxVkTNTKlLBiNT1LExXEvakQ6tlQG1QO2BFuxG
	hIown6IL9XhY0Tl5xAEwNAiKT1kponedK+QEiMfDkofbdDR9BqWIBS1Z8m8CxZrZtzXROs9I2NC
	Pnj+RQH5QmK35WjEqb8UTdRR+4xsv/jg==
X-Received: from plbjw17.prod.google.com ([2002:a17:903:2791:b0:2bd:7970:c1cf])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f90:b0:2bd:ef15:9fce
 with SMTP id d9443c01a7336-2beb063227emr277408735ad.20.1779920056662; Wed, 27
 May 2026 15:14:16 -0700 (PDT)
Date: Wed, 27 May 2026 22:13:58 +0000
In-Reply-To: <20260527221407.1756491-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260527221407.1756491-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260527221407.1756491-3-praan@google.com>
Subject: [PATCH v7 02/11] iommu/arm-smmu-v3: Add a helper to drain cmd queues
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Ashish Mhetre <amhetre@nvidia.com>, linux-arm-kernel@lists.infradead.org, 
	Pranjal Shrivastava <praan@google.com>
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
index 3dad2c2d3283..0e77ef1e4523 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -884,6 +884,40 @@ static int arm_smmu_cmdq_batch_submit(struct arm_smmu_device *smmu,
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
index 16353596e08a..c855ab4962ed 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1165,6 +1165,9 @@ int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 int arm_smmu_cmdq_init(struct arm_smmu_device *smmu,
 		       struct arm_smmu_cmdq *cmdq);
 
+int arm_smmu_queue_poll_until_empty(struct arm_smmu_device *smmu,
+				    struct arm_smmu_queue *q);
+
 static inline bool arm_smmu_master_canwbs(struct arm_smmu_master *master)
 {
 	return dev_iommu_fwspec_get(master->dev)->flags &
-- 
2.54.0.794.g4f17f83d09-goog

