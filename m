Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79183C9890
	for <iommu@lists.linux.dev>; Wed, 27 May 2026 22:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779920071; cv=none; b=qZRLf/ftb515WxrtH6JDA2eydcGcepVBC0XHiJ3eBDVD0oDD13aYinJeOkrCoqDbU6TUkjr0zikxu0S2l3+G6gnVHBAcRPnwMscJMPNrSjH38j3OkPWKamu1BJHrP3qWgpbowq8wQHerxDKogBzNHxZu4g3hMUEy30ljm9ty/B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779920071; c=relaxed/simple;
	bh=6kZu63sehS6KCEA9gctV87GwPFFXZU+HsjuP0CnrcuM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y76BW1hwsUlNFkJE6Y1uy5YVLJAJvTpVyUBzEw96NHT7uCmhnV6TQpw7IkvFow8araaf/ZWK9R3Ma19sOa1SU6mN6na9vhzaEYeUd5tfDQFuU1GGoAKW8284oPHv+UE0/AP9zlyESHlYb35psfzdXbwqGGvt32awNXykjMaQc2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n3vFtLFg; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n3vFtLFg"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b2ecc96a9aso136664595ad.1
        for <iommu@lists.linux.dev>; Wed, 27 May 2026 15:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779920069; x=1780524869; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=A8/bA1XI9FWDfhx4EbmdfcGilvJQlSvMoglKBnMjsyo=;
        b=n3vFtLFgTH/1vH490v5JcdPC747rBbgk978ozgFoiiNruldFXuAY4XC3Wz6TJsDQSM
         4kyuEoe22YVhm/1Kn2WU3iW6Eo1t22T8PgNTlN5SN/yMQxnE9g7wu2pnZSW5SWNbttME
         Jz4OTc886GAdRCl5W78fWFYLW3FErlcEThO01AZFlFZ73wtOLtczADNkrTvjHQWueSeB
         k0tTl6SWnmHt/pSWvAkYo4+bg03Ob8ypugqNCwdr4yi7+lZN6sKRIFxKWdwhk+fIn3Kn
         wxj7XOkSbvwf6oSQfr9uiPgqVTcI6vtfmr/OFh23BbIcAF6pUVmAYSQoOFlwvJWDWmKJ
         cIdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779920069; x=1780524869;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A8/bA1XI9FWDfhx4EbmdfcGilvJQlSvMoglKBnMjsyo=;
        b=AaxPS1sQrOigVbSSderAYOaS6xy4w9UYO4MIoVek1qG/CMofbcY4y2v3kWAlIBb5LB
         cdd2VP5vPv+docSbH2JcWe50uVOVXxnRM24lnagnQpHZAl690o+/e7Hi8CZ4zG5VTOD9
         c9fpIQP98n+GA2jt9i0KxMBu3zldZwfNhdJDZmmV6KnM1lU1Ncg4LDeS6ngdv2Dhf4Fx
         zO5VL9SixAoE2PXOy+49AZkDFnV0eqfYRcI3WXEyya9uSyLWq+KgHnm+wesGrAUUm+eS
         Amu568lre+jAXfsc075qmSwNrVuXuWgNAvoN1f8oA3Q2Cw46gLE/OnTShbTn++RZMG26
         M+dA==
X-Gm-Message-State: AOJu0Yzbie3j/4D4pU0FuPdc19hr+E5j9EMUBztTJhjcX44PS7wkApVL
	anQeHRhyoiMNpsvfqz3rHkpXI6Iy+xGdKyFHlrE2mMrCIaGQLgnhedidReo2wL85355DgaqTA2n
	Fy0+yyT43KlRpZpC9TU3M9ekkSOJwpzGkUXKZx9ppfOP8P052/N1lwn+v/iRCCIvsKwIVfMJxnb
	/awBxKGKKg6XPXrqbdGKk5ohA7HQRubA==
X-Received: from pfh4.prod.google.com ([2002:a05:6a00:12c4:b0:837:aa2e:b191])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:7105:b0:3a0:c2b4:d976
 with SMTP id adf61e73a8af0-3b3293c0a32mr25162408637.44.1779920068760; Wed, 27
 May 2026 15:14:28 -0700 (PDT)
Date: Wed, 27 May 2026 22:14:03 +0000
In-Reply-To: <20260527221407.1756491-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260527221407.1756491-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260527221407.1756491-8-praan@google.com>
Subject: [PATCH v7 07/11] iommu/arm-smmu-v3: Add CMDQ_PROD_STOP_FLAG to gate
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
The flag checked in the compxchg loop in arm_smmu_cmdq_issue_cmdlist(),
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
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 20 +++++++++++++++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  2 ++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 191b5b5b805c..a28417108a8a 100644
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
2.54.0.794.g4f17f83d09-goog

