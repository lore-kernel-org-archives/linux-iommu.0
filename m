Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1166C3FCB1C
	for <iommu@lists.linux.dev>; Tue, 28 Jul 2026 21:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785272993; cv=none; b=I4Hhd+23ptYCFHWm4q6yZVIrJ5rAIwCXQctTRpMF8g8pBf+/Sm17TLe2GuYRwXdgzMTGPUAoBD2vEZgM4v8A480Q3zmsILWtFYYhfi5vbzHYS1X2dieM1rFHVlEeITUL2D5uRBfPlfvWdL1TcYRVKWDudLIADWytOH/yoGtj+l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785272993; c=relaxed/simple;
	bh=40Y+RoUgCGkj1Jax/OigdcakhF8PxXmjJ3+Q7EUojw0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rwPBnqVzYJiyq+I6nZQUiBovhmNFQUHmOtAi7mAICaHkypQk+B85v9fr5N2RbVkdACNtJjKznTVaDXcQ5+LIuQNvTueSjP7dOZBKCtz3/4ZoqZ8DzvxZl5YmRm7tJscD9Wl+ymoodg0t2W9KT2pNSx+2zvXTvhNh2CQHTOyC8tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qd+FCIWC; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qd+FCIWC"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cb5bdd8450dso148140a12.0
        for <iommu@lists.linux.dev>; Tue, 28 Jul 2026 14:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785272991; x=1785877791; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k+Gi9b31nCs7m8qDvq9onthmRDdD1MWH6Z3rOryIWho=;
        b=qd+FCIWC7wJu6DBGh+tvs+Y2T8CcsXL7s3TwLrH4xqkchKVZKXOhCy3jc66vUJd9pv
         Yc8dX1FZtKGG7uPiok0g/NtSXpNU/cUvP90dzJ+XR3Lg5fHeVVc8arkaXL5npxA3aqb1
         S1SqbYNIqEajT2v5Y/7ZBO/4/utYzeb/gSwlN/fs2NrQDfa97eTHHkqIwITdW2Hfdkka
         DNMs1bDIJYJ/2CWBOykrNlo4B7akwaZPkDIUvhzKnKan4pYMdkXueoeD7JBQmWgWq/OE
         GmCjtsi4a4LInjDJoR+cah6IRaRrJQKfZzWBQHepxmyfzNbKaUkywq+fya8JgS+paAjV
         hISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785272991; x=1785877791;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k+Gi9b31nCs7m8qDvq9onthmRDdD1MWH6Z3rOryIWho=;
        b=a/hn5zIx3APv1YPWsRnO91L3t361zTCgidXd+ULb9WNzo+JzZVffwlDortf/KnbCAx
         2YGz30OvxfUsex7BEHXVyRtjpwPWlZ758xHGMS8bcbSnd7E15pi92IEq6SokefCdHM5Z
         n3DyJ/aThcSNBfqKu2CUvYfn2clEn2DKVbDsBEyHqWQnnhpqcaRO0+2YGKGfZkX3zhey
         JTtGCITBNy7tH+WUNClYluP2s/1puF/SOFnJ6wvSVLeDlCAWpn37iGWWXqrsBqNHjzde
         3mI2EGyWfy1OA7w6TqNZlSID3kzWSGLPpCa+PuktThSB7Z18GwFHnyk5jDcNbOggd6Aq
         T19w==
X-Gm-Message-State: AOJu0YyEcagt28YxKlmB5FIkp/Wdfm0Y2DmSTzt8orELvJ0+AXX0r4By
	yOKgTPRfRlRVToRRvW2ca9HpR0no8xg8u9K17onBdEiSCTWgKxR01NnuvXe0oIfKDdCBjSFmEYa
	ZwRIWMq2V7jTwpQ339BGL+9X4/0FtxKIDbz2zC9mD3N+zHOAQVn6YxNxxYH8YUJB7hbEdzRdvVT
	aVkHvJMP0gMJI5lw63d2CbZY74Hbj87A==
X-Received: from pgbfu15.prod.google.com ([2002:a05:6a02:4a8f:b0:c8a:8cda:bd48])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9396:b0:3c0:9c19:b277
 with SMTP id adf61e73a8af0-3c8ba66a32emr5138162637.69.1785272991019; Tue, 28
 Jul 2026 14:09:51 -0700 (PDT)
Date: Tue, 28 Jul 2026 21:09:23 +0000
In-Reply-To: <20260728210928.1050849-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260728210928.1050849-1-praan@google.com>
X-Mailer: git-send-email 2.55.0.487.gaf234c4eb3-goog
Message-ID: <20260728210928.1050849-8-praan@google.com>
Subject: [PATCH v9 07/12] iommu/arm-smmu-v3: Add CMDQ_PROD_STOP_FLAG to gate
 CMDQ submissions
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	linux-arm-kernel@lists.infradead.org, Pranjal Shrivastava <praan@google.com>
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
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  5 +++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 2a976f210d9b..8809757ebee8 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -219,7 +219,8 @@ static int queue_sync_prod_in(struct arm_smmu_queue *q)
 static u32 queue_inc_prod_n(struct arm_smmu_ll_queue *q, int n)
 {
 	u32 prod = (Q_WRP(q, q->prod) | Q_IDX(q, q->prod)) + n;
-	return Q_OVF(q->prod) | Q_WRP(q, prod) | Q_IDX(q, prod);
+
+	return Q_OVF(q->prod) | Q_STOP(q->prod) | Q_WRP(q, prod) | Q_IDX(q, prod);
 }
 
 static void queue_poll_init(struct arm_smmu_device *smmu,
@@ -727,8 +728,25 @@ int __arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
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
index adfcbb654673..40b889998d5b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -389,6 +389,11 @@ static inline unsigned int arm_smmu_cdtab_l2_idx(unsigned int ssid)
 #define CMDQ_ERR_CERROR_ATC_INV_IDX	3
 
 #define CMDQ_PROD_OWNED_FLAG		Q_OVERFLOW_FLAG
+#define CMDQ_PROD_STOP_FLAG		(1U << 30)
+#define Q_STOP(p)			((p) & CMDQ_PROD_STOP_FLAG)
+
+/* Mask out software-only metadata flags to get the pure queue index/wrap bits */
+#define CMDQ_PROD_IDX_MASK		~(CMDQ_PROD_STOP_FLAG | CMDQ_PROD_OWNED_FLAG)
 
 struct arm_smmu_cmd {
 	u64 data[CMDQ_ENT_DWORDS];
-- 
2.55.0.487.gaf234c4eb3-goog

