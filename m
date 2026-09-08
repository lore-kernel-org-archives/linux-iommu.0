Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772385908DE
	for <iommu@lists.linux.dev>; Tue,  8 Sep 2026 17:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788887860; cv=none; b=tquBwHOIjdroNIZRwUZcxDZQO92kf21Y11jmFXQiZsaE2q2DbVlIvs6T+xKwyAwzXWRcYWqLX3qTuT7bgn2ld4yg+vtFB8treIj64ne+yOeBD1gYHRbp1EgvAu8TT8KEXdWuAA51OHGyj4huJmogUJ6RWOssB18gi2wpArSzs4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788887860; c=relaxed/simple;
	bh=3ks5V6Ofdruc8FIg084YSeYPdHUEOsTEhfR4gWyXmvs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T6mDOOa6bmdBf8LnlZ3UH6Eq52nG1RV8Lfc47PZL9pL0dvmKaCFpFixGaMSLiDDNT1csw7i8fr7tT0yDWQEX23JkUDnZid8RTfyTZKW6uJ+8SoH3BmgRoyBcV6+viXDayb3KjPsqKS/7gSgZ+SB0wXxF2RCekoYbHUXxURs+tWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TPopIQiK; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TPopIQiK"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-85f3a39f3beso6414161b3a.0
        for <iommu@lists.linux.dev>; Tue, 08 Sep 2026 10:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788887859; x=1789492659; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J/jv1ovVCNeCubLupVeuht7eNIRLVbkvYJqOaymhU6s=;
        b=TPopIQiKw4+R/tamrO9iwugtO2a5oQuf6W0LGA89Va5JmZ6sYL4tOaiGhByk3QmW7k
         GDXDMGiBSYaoP7ms3BD4fpJvhQSLZig7i6WDTY4CUzTJ+Dw5NhIkAili1Jc8aQVdveC0
         iiHcT0k1WmzDK7I2F6Vvju/x4eePLjkeNzBRztqguT6tmtdJZHM/0jh/qtcmutCCOkGq
         YuIUEvnkL5r9+vnq1wNNV17PS4ULlxavODTN4DvF9cStAa1PMNt5S4sK2P5fBoXBV0FZ
         Wc0+K9BPOtf3pT3fHaWsL2LxEJyIV7XCrh6X2t+Py1o1obY/HEaLZQrS+MXF2Eugaa3Z
         SWHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788887859; x=1789492659;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J/jv1ovVCNeCubLupVeuht7eNIRLVbkvYJqOaymhU6s=;
        b=PH3zEaIvgRgiEVwJWjz0FEjlsmDZavxFaitSkbQo9UPA3iIlbAb70s6rN5SEuG/GmY
         SZfK/Ab1z7SV65xbvW6Sn00JB2VDVUVlwxC+vwV6xC4HqgsFV/+w72RtgKi2nX5cUrVJ
         SGn0hoojIzjWYb/j/kOQVov2iyUvEIHyK9FP2xoeP6/FyjQopuoI1FI0PICbjIRLEKEx
         WoTubnZYTT8EJyGnMnYJJ6seCDglgDOHXDACrOPJKWun2wtjuQAJv0A+9mMRDQjAtouz
         8IwfoGOhM1FaFDsdi3XlndLLVKQm96X/Gfk4mZYmaFtEX/9IMhLmhwOCgDnz4yNNhEs4
         9OKQ==
X-Gm-Message-State: AFuF++m3cPK6HN2PGXx/Ey9hcPyZy0R1e7FaIMm0GMyX6QHI5rKS9FqR
	sOphyVYscIUgRtOaFnUobheUt3UtwSM65Qh7/uQGZuGJ+qHSh6aXVdwhNfddOjDCkHel0dkZYmq
	vgg2tFjOnog89i4HriKS6VaBudki3RJsRMm/ZyOIl42BQuud+MXCkgJJ9kpPfDFM+v6KgR8Fxdk
	A6f87R4xoSf63ONqjQwBHPwPYEGkl5Ww==
X-Received: from pfbce7.prod.google.com ([2002:a05:6a00:2a07:b0:866:a8ba:a59])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1950:b0:85c:3922:25d5
 with SMTP id d2e1a72fcca58-8616aa68194mr43353950b3a.21.1788887858247; Tue, 08
 Sep 2026 10:17:38 -0700 (PDT)
Date: Tue,  8 Sep 2026 17:17:06 +0000
In-Reply-To: <20260908171712.356645-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260908171712.356645-1-praan@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260908171712.356645-11-praan@google.com>
Subject: [PATCH v10 10/15] iommu/arm-smmu-v3: Add CMDQ_PROD_STOP_FLAG to gate
 CMDQ submissions
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Ashish Mhetre <amhetre@nvidia.com>, linux-arm-kernel@lists.infradead.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rafael@kernel.org, 
	Danilo Krummrich <dakr@kernel.org>, Thomas Gleixner <tglx@kernel.org>, driver-core@lists.linux.dev, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce a new bit flag, CMDQ_PROD_STOP_FLAG (bit 30), in the command
queue's producer index to safely gate command submissions during device
suspension.

The flag embeds the suspend state directly into the existing global state
The flag is checked in the cmpxchg loop in arm_smmu_cmdq_issue_cmdlist(),
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
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 35 +++++++++++++++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  5 +++
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 98af7c1fac94..65939a9b0619 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -218,7 +218,8 @@ static int queue_sync_prod_in(struct arm_smmu_queue *q)
 static u32 queue_inc_prod_n(struct arm_smmu_ll_queue *q, int n)
 {
 	u32 prod = Q_POS(q, q->prod) + n;
-	return Q_OVF(q->prod) | Q_POS(q, prod);
+
+	return Q_OVF(q->prod) | Q_STOP(q->prod) | Q_POS(q, prod);
 }
 
 static void queue_poll_init(struct arm_smmu_device *smmu,
@@ -726,13 +727,42 @@ int __arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
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
 		}
 
+		/*
+		 * If we exited the polling loop because the queue finally
+		 * has space, but the STOP_FLAG was set during the poll,
+		 * we must abort immediately. If we proceed, we will
+		 * commit new commands beyond the Point of Commitment while
+		 * the SMMU is suspending.
+		 */
+		if (Q_STOP(llq.prod)) {
+			local_irq_restore(flags);
+			return 0;
+		}
+
 		head.cons = llq.cons;
 		head.prod = queue_inc_prod_n(&llq, n + sync) |
 					     CMDQ_PROD_OWNED_FLAG;
@@ -779,7 +809,8 @@ int __arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 		/* b. Stop gathering work by clearing the owned flag */
 		prod = atomic_fetch_andnot_relaxed(CMDQ_PROD_OWNED_FLAG,
 						   &cmdq->q.llq.atomic.prod);
-		prod &= ~CMDQ_PROD_OWNED_FLAG;
+		/* Strip all metadata flags */
+		prod &= CMDQ_PROD_IDX_MASK;
 
 		/*
 		 * c. Wait for any gathered work to be written to the queue.
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index deefb17e31eb..794b258550dd 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -394,6 +394,11 @@ static inline unsigned int arm_smmu_cdtab_l2_idx(unsigned int ssid)
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
2.55.0.979.g7e5102b832-goog

