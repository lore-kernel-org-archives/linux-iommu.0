Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E1237BE6F
	for <iommu@lists.linux.dev>; Mon,  1 Jun 2026 21:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780351169; cv=none; b=PZOM9FY9q4LIRstStyHWAW+kxC+thLJBKXXAUAhx1ArHFYkzun+0UpWw1NcXFdwiBmJAqANnqjuGxzmq4egrICBDr4DtFrL3JbWN827chJI2o8tBy2bPJGPKR9fED3aHE6i42o5YwYWbVY3Mr8DX0peONBwQs1i33FPCSqFCIVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780351169; c=relaxed/simple;
	bh=5Pof3nh7LCW/4O50a4+VCxVugz64i4p0e+SvGpiUGCA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Z/FF0aoHCVkOTI585mNfHjZ+abmGvCStXCo1KXhICI6O7WxE2lA2h0FUoG+HjFeP4seWOou0O3LE5BTMZNThKq1g+RI2cry6V60/MI/hmRUH6dLSsZekJWHuPetBGRP8IvGJ8wshAvImzoOXW5T8mDTcDE8cAWQ6/yZ7F9hdlFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SdcASL8K; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SdcASL8K"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8423970cb30so1355956b3a.2
        for <iommu@lists.linux.dev>; Mon, 01 Jun 2026 14:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780351167; x=1780955967; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LWOb+HolO8JcpaQsXLOMu+8Ojdlg6FqfnP4yGw0xQ0I=;
        b=SdcASL8KqTyGCZ18qWqeK5nRhmpEa8wlnMlgQbpbD/hFpyh7yV2eyuU/vTjrwZUGh3
         ASulhip463yU0EZqnioswU1ES7K0yn0l/50nRnq+DWfgsq5TxD46qMDqIYmDF0lsJsLh
         ENOeP1gZwQWbp7FsooqRvUlppijMCCpsQv0W4vcw3o1EVF3EgELNf5SH10Vj52lP2H+j
         3fO0v2OxXufqeR6f7Dz+U3CG1ipqhevjFqB4YMdCxBtBSQW0vPBFMSP0jKwVpQukbLT3
         V14WzNsQUNGKfPBQAdBqxuOezA9E4AgHIzmvFSPaPFnSCKHGFeA9Y8h0pZ93vbxo52Zr
         G+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780351167; x=1780955967;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LWOb+HolO8JcpaQsXLOMu+8Ojdlg6FqfnP4yGw0xQ0I=;
        b=XV+IqO2XOwgmwCyCftZk9B7sZKoSDQuvZt65QiAb5Dh0P3ehU7FxaygMKRHf6EffcU
         WQqpql0XVK1TOUwjC/v/0oq/L/+XLP6QcSHIeUuupu6CHTy1nl3mcqttIHXLCq2kqOZV
         s4Gv90kri2WnXYGUl+oVvfTFhGoA36++Sp4JG+DvEo33D5GWUq68AsTzFmZ+AFPfu1N3
         hxMy2TVJxOJqHzuprTCuPWXLqFCQIKDsJwJoBGZKs4CAYkMVXzZ63Lys0rH7OUYWUXGb
         JQoHSbdPjGq43ckQAWBfHIoZsh8DoSf6V5hzAWk4vfKYwUo51I6qKDYq3TmQ3oH2+JSX
         bgJw==
X-Gm-Message-State: AOJu0YwJeQRbnBLsZjsG1N4WkxCadoFZA9xErK4orhT3E8Ok6HLs/KrC
	pBHsSSu5vtrCeiyAJHuv4qZI/uoFeMhX3HREDAymKI7DD4YJmdmoycQvtF/lODeTK/S7USDgMxK
	xC2DIALkH7FZiYyrOEdI+ldwJec6nNLrwZ0gCLZQjOF9yKgoK41ojFO1IUdrMkao5vOntvtuZLV
	LcaGEFu4IdROjSPeH1jl56ec/86PuCmA==
X-Received: from pfaz8.prod.google.com ([2002:aa7:91c8:0:b0:842:4d1f:7750])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:908a:b0:837:e9cc:d46e
 with SMTP id d2e1a72fcca58-842253ed743mr11621319b3a.21.1780351166606; Mon, 01
 Jun 2026 14:59:26 -0700 (PDT)
Date: Mon,  1 Jun 2026 21:59:04 +0000
In-Reply-To: <20260601215909.3958732-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260601215909.3958732-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260601215909.3958732-8-praan@google.com>
Subject: [PATCH v8 07/12] iommu/arm-smmu-v3: Add CMDQ_PROD_STOP_FLAG to gate
 CMDQ submissions
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Ashish Mhetre <amhetre@nvidia.com>, linux-arm-kernel@lists.infradead.org, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce a new bit flag, CMDQ_PROD_STOP_FLAG (bit 30), in the command
queue's producer index to safely gate command submissions during device
suspension.

The flag embeds the suspend state directly into the existing global state
The flag checked in the cmpxchg loop in arm_smmu_cmdq_issue_cmdlist(),
which acts as a Point of Commitment, ensuring that no indices are
reserved or committed once the SMMU begins suspending.

This prevents a situation of "abandoned batches" where indices are
incremented but commands are never written, which would otherwise
lead to timeout during the drain poll.

Update queue_inc_prod_n() to preserve this flag during index
calculations, ensuring that any in-flight commands that successfully
passed the point of commitment can proceed to completion while the
flag remains set.

Suggested-by: Daniel Mentz <danielmentz@google.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 20 +++++++++++++++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  2 ++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 6c8631e2f153..c4315bdde7d5 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -210,7 +210,8 @@ static int queue_sync_prod_in(struct arm_smmu_queue *q)
 static u32 queue_inc_prod_n(struct arm_smmu_ll_queue *q, int n)
 {
 	u32 prod = (Q_WRP(q, q->prod) | Q_IDX(q, q->prod)) + n;
-	return Q_OVF(q->prod) | Q_WRP(q, prod) | Q_IDX(q, prod);
+
+	return Q_OVF(q->prod) | Q_STOP(q->prod) | Q_WRP(q, prod) | Q_IDX(q, prod);
 }
 
 static void queue_poll_init(struct arm_smmu_device *smmu,
@@ -718,8 +719,25 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 	do {
 		u64 old;
 
+		/*
+		 * If the SMMU is suspended/suspending, any new CMDs are elided.
+		 * This loop is the Point of Commitment. If we haven't cmpxchg'd
+		 * our new indices yet, we can safely bail. Once the indices are
+		 * committed, we MUST write valid commands to those slots to
+		 * avoid indefinite polling in the drain function.
+		 */
+		if (Q_STOP(llq.prod)) {
+			local_irq_restore(flags);
+			return 0;
+		}
+
 		while (!queue_has_space(&llq, n + sync)) {
 			local_irq_restore(flags);
+
+			/* Avoid waiting for space if the SMMU is suspending */
+			if (Q_STOP(READ_ONCE(cmdq->q.llq.prod)))
+				return 0;
+
 			if (arm_smmu_cmdq_poll_until_not_full(smmu, cmdq, &llq))
 				dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");
 			local_irq_save(flags);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 24d5e28eea88..a3c8417c87d8 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -389,6 +389,8 @@ static inline unsigned int arm_smmu_cdtab_l2_idx(unsigned int ssid)
 #define CMDQ_ERR_CERROR_ATC_INV_IDX	3
 
 #define CMDQ_PROD_OWNED_FLAG		Q_OVERFLOW_FLAG
+#define CMDQ_PROD_STOP_FLAG		(1U << 30)
+#define Q_STOP(p)			((p) & CMDQ_PROD_STOP_FLAG)
 
 struct arm_smmu_cmd {
 	u64 data[CMDQ_ENT_DWORDS];
-- 
2.54.0.1013.g208068f2d8-goog

