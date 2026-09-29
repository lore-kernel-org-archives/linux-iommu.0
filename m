Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23B1430794
	for <iommu@lists.linux.dev>; Tue, 29 Sep 2026 03:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790653550; cv=none; b=r46zlhH+R06CiAS9Uhy7xOatcbEoUPf2ymuyl8ScFWut4W7tSDMy6bC97djARPAeU4MK3iplF/Eu4hyjSYOFxo4DiVO2/t+ZQZfRql2sn+mGK4Xu4PXRI3uBRu6jwcQ69Qo3fHnJKqD3i0IWkbI2j2SDsThMLoN/Fg87fr72ODI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790653550; c=relaxed/simple;
	bh=emN7DAxtSRLF415z6jBFS1BVT82Ombe4VPgOdgIfbVQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D45V8BZidmUM0446Y/wBQnqbvEFJKNOgGwFZN7VVvGjfg1kvfhQXhvuGmcDAm3WMIs+5CggZVXpr0gRytI2oDAT7qExigJcYOB9L50/WRVE3Ox8CSrtEGqWcY0NqXwtYFpAxvs/9vL+ZGdk2AlOCM+uj4tVLiDpXWhN88p5P/4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TjK7VLK2; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TjK7VLK2"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc79b966c51so1193259a12.0
        for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 20:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790653547; x=1791258347; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DJUc8W66LdXd5niQlho6vVTddWB/e8RRGn6UCJy7ACg=;
        b=TjK7VLK2j3nbvQRsjpt37Fe7nGHuPdbTlq2s5g96u8UrfbZpov3s1NReTOE16PZjvD
         TxEfehYjVFJnYUsSLJtqgmKmW/cNEokDbgt2OoU7eHMCOu4Vt9EOdgA+y1RLrP4QbwjJ
         n+YF8PPgJW1chc1qepNkJCICVzaKI5bNV1fs7FmxsBCS5BCNQyK3b95lykOkspHkcD8K
         nrR55dLsv5Gasw3KTLM8X7frBXC0J/gruUeeiufLS1pjMBFEYHWFMYzW6mZbWizmg7iN
         ck5vp7rQSg6uFBAasja1iJGBhzyddD5WNESJ1lI4yA0xMH0etsKUTpucyL7NBlGzuZyc
         KWsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790653547; x=1791258347;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DJUc8W66LdXd5niQlho6vVTddWB/e8RRGn6UCJy7ACg=;
        b=NQbTZB5m2xPvP5GSND6p9p7RmRIRUItC+5f43tC4RMjU5V0Yb2AzCN2KOr8PNut47/
         Gqa4Eq15kY+jdYzxVlLcXHM1SVFrl5QilCyfn5Zlv+848/DxLS2vzhfZcK3oDLstsipS
         fo9TlzEBRDCl361riHbxxlPv4aznc3cnHFOEOsdhlQAMf4Cuf9eBGFbjnDgV1IF987lD
         RUgEynmMTqqC4yyOehvy3Pp9esIkkijzuUPyqB35D4g081pQ3bFopu2iUH22eBBrwl2k
         OxsArUMmhHuw/B2OQkf9VYnkHpwUeAPvy43LP5clD1FwnYHIGcqTRsipoZb+7o9HWXJE
         aklg==
X-Gm-Message-State: AFuF++kDcHUTqnXrI2c3+gZTxcCfpanIRa9rbOoo730gHC1h8K7nnvzJ
	4Yp9jc9kf5SxRJQwA93gu6Z4CoJyn/AKyQI3la5jcmyR0sZC9h9ICywfIwGGgOMkavt2AjI8Etn
	feFSPjX4ZUvWaZnnGekkwblWUKStK4kr5hZwwtakdnfTtQtO76JGvpuCFuil8M6yzG9RxqiRBgV
	Uu3FUFaZvjyVRkxnEg5yhCHBozsP7M1A==
X-Received: from pgdf1.prod.google.com ([2002:a05:6a02:5141:b0:cc7:56f1:71ad])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6f06:b0:3d3:ae40:51e5
 with SMTP id adf61e73a8af0-3de0e750b0dmr13391618637.25.1790653546468; Mon, 28
 Sep 2026 20:45:46 -0700 (PDT)
Date: Tue, 29 Sep 2026 03:45:05 +0000
In-Reply-To: <20260929034510.2023173-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260929034510.2023173-1-praan@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260929034510.2023173-12-praan@google.com>
Subject: [PATCH v11 11/16] iommu/arm-smmu-v3: Add CMDQ_PROD_STOP_FLAG to gate
 CMDQ submissions
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Ashish Mhetre <amhetre@nvidia.com>, linux-arm-kernel@lists.infradead.org, 
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rafael@kernel.org, 
	Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev, 
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
index a123810fac57..7f89e2306942 100644
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
2.56.0.rc1.315.gc6ed9934b7-goog

