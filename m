Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BEB481FB7
	for <iommu@lists.linux.dev>; Wed,  2 Sep 2026 12:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788351501; cv=none; b=Sm6W+F9j1Ci/5H/o0sgOM6u5+b4+rDMfquE3HU7SpeZ8Bl7VPE/QhlI3H1bzJ/v6iKEQn8JjUzQ6R4Sah5GbqL+Kg0EhtYrKDXGmk1lqNLvMs2+rK1jT3ef5ju9neNeINDcOdPfimBD6J5c04xAJwPqfYA49Fs8ke027OhQgiao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788351501; c=relaxed/simple;
	bh=hGbqr9wJgePSde7VxUPv5KS9HDzT55JnKLhm7DIMnn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B2R4YK5NZjm/0i/gvxF3oqx2WidCcj0KtMRjPkVKRe2LkA0P0mkD+dQQJBkKE6X8VAEjDnZphiQYkJOACkJEsVcoIsaQ8ZjaZs3Nqp0B9XuvguvZzduX7Onn9dMPCNrdSGc140Jrb50EM4o2Y7JCW7IqlD5qEOW/QxyHQlDGWww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYSSdoQA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYSSdoQA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E88321F00A3F;
	Wed,  2 Sep 2026 12:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788351497;
	bh=IFh9YtmuRxf4eh9UDdIrcg+KHXLK5k10/OU6AZkVzew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FYSSdoQA8TnrhmnIv2QymPAVmc3FyaLRIB23stI/tSRjcbTPlzTw4opejRrRrgWeY
	 7qhfHNAHMfQhYtokhfvQ1/JfezTWqhuMbpWVxVicuRAF1aVI4y/9vuFiu2LnetI9Jn
	 9sflpPlONvMH/VUBCIXUiq193VpAMQtNwLijuNOxgoPM7vWJUjtAPASONfcNi1Rrj+
	 exwdXi5is6zrppZ3O9PFQOw52cUfnd9NyEm5RIxaFrbhiMWYsVyAaqGJ7s3UDHVM2+
	 rV+whUofbb1umPA7KaX+XQpyW0O14mDdFgud6djTG8QooBeBFQflDtQ+32BopH5gKJ
	 IW7wUMjCE/Yng==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.ams.internal (Postfix) with ESMTP id 36313198004A;
	Wed,  2 Sep 2026 08:18:14 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 02 Sep 2026 08:18:15 -0400
X-ME-Sender: <xms:BRSYakVGvdfKBZVx8nDh5jNSuuYUh5QhXo27le4r4FmmMRM_MbIkpQ>
    <xme:BRSYaqA7RDhRUAv75LW3yu8wWgYNndp-nBgDt70Xh8PeBraQr-VKQ8FTBkgwakjiv
    qrdQ_hXkrHTZ0blEKPk_-jNaX3RFeOGzteTxdiwFiJEooldzVwJ84k>
X-ME-Received: <xmr:BRSYajxb1R4qSyn92YRXnF_B19cwGdI8lFZSoaSprdDcBdfX7oqn_ublQAM>
X-ME-Proxy-Cause: dmFkZTEXUpnCPuNV+2RXO89bJBzt4DT2UHlbCRCgM3H3femH/cw0lQ3qMUt20S/eAB+4J7
    iCaYJ5/K2JKOFbtN+ZbuperC7KlXF9+UEwTC9jegMZ9EKKwUKtedsborn38YXPNdlIFhn5
    8yR8pn5ZMAt7HfPjC9fJduXSS5GFb7KCir/ruu+hNM8Se2kuXS4kwTxk+QMNsiz+Iox9Fx
    Mv4zalhvjCm/q9/A7354UFOhJSCoU64B4kqmawSE3+O5l7rE5y4GJp7x4WQThnpB8pEDVG
    kdoS9tsZorczMO3BcsQTS31CT66MhUAezHkJ6n3d0Vd2ceKrMqxzcaAkir6ZUwSRiiCAXT
    X5O4t6GQEG84cEuJR1O6/u0vHdGvcaTEdJsl3R6fleuQGjFAopm4n/DUORsny3kAxHS5WE
    YcpvpP0Z5XIlHZdSsBRx284k6U9xMYtZSYdcCX72OtrxiNShc7lwqc6Q7ufbb6pVWQyAgE
    NVi9qUzG8lADzZkro7IsbxbWhznfBHU5Ukhm8/pTzQwXBPBa51tBwAnfXalJV8Tqva5Omo
    NbZf6QGvx5opUIC0IroDVY5I7MllpUaJPEEsnv3YzFMl3nTcvaqRFBfk/AgfeQO/unS/Xk
    JImaoK5VMpoe+XntCM8jNP6fWoJVZ+8PgUQRX1R99GbLYVqwH+ji9uVc9xHg
X-ME-Proxy: <xmx:BRSYaga1fg5B7Sza_8TEG-2RPdoQq8qDEOMp_TsWRHWXomYM0WJGiQ>
    <xmx:BRSYagRP8JSJ6lEfwpVsnhcgqYTkv7qzylg6PvE90BdrHNkCo32eJQ>
    <xmx:BRSYajiFS9Rr33LP11sJcq7Ox7q8MK0LO-iFysFBflB1UGy6WgJk5w>
    <xmx:BRSYar5Xe3nsfU5GPRsr2vUnBC5VeYbSLzspvMOsc9DkQsGkmLfb1Q>
    <xmx:BRSYaun2lDpk6neIKvCunNwgC0zfDQnv3L5RYUnC_4kc9TwxI2yYNzjj>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Sep 2026 08:18:13 -0400 (EDT)
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
To: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Pranjal Shrivastava <praan@google.com>,
	Mostafa Saleh <smostafa@google.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Krishna Reddy <vdumpa@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Breno Leitao <leitao@debian.org>,
	Kyle McMartin <jkkm@meta.com>,
	Usama Arif <usama.arif@linux.dev>,
	kernel-team@meta.com,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>
Subject: [PATCH v4 1/2] iommu/arm-smmu-v3: Add a cmdq_entries module parameter
Date: Wed,  2 Sep 2026 13:17:23 +0100
Message-ID: <20260902121724.3494954-2-kas@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260902121724.3494954-1-kas@kernel.org>
References: <20260902121724.3494954-1-kas@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The command queue depth comes straight from the maximum the hardware
advertises in IDR1, which reaches megabytes of coherent DMA per queue.
A system with several SMMUv3 instances pays that per instance, and the
Tegra241 CMDQV pays it again for every VCMDQ it preallocates.

Queue depth only bounds how many commands may be in flight before a sync.
A machine driving a handful of devices, or one with a tight memory budget,
has no use for the maximum, and no way to say so.

Add cmdq_entries, an upper bound on the number of command queue entries.
Apply it where the depth is decided, alongside the IDR1 maxima in
arm_smmu_device_hw_probe(), so the queue is allocated at the requested
size rather than allocated large and trimmed afterwards. The Tegra241
CMDQV sizes its VCMDQs from IDR1 itself, so route that through the same
helper.

Round the request down to a power of two and floor it at one page worth of
entries. Coherent DMA is page granular, so a shallower queue occupies the
same memory as one that fills the page, and the retry loop in
arm_smmu_init_one_queue() already stops at a page. On every page size arm64
supports, that floor leaves the queue well above CMDQ_BATCH_ENTRIES, so
command batching keeps working whatever is asked for.

Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Assisted-by: Claude-Code:claude-opus-5
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 42 ++++++++++++++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  1 +
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    |  5 ++-
 3 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 5732f3ba0122..b371e9ddbfcc 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -40,6 +40,11 @@ module_param(disable_msipolling, bool, 0444);
 MODULE_PARM_DESC(disable_msipolling,
 	"Disable MSI-based polling for CMD_SYNC completion.");
 
+static unsigned int cmdq_entries;
+module_param(cmdq_entries, uint, 0444);
+MODULE_PARM_DESC(cmdq_entries,
+	"Upper bound on the number of command queue entries, rounded down to a power of two. Zero means the hardware maximum.");
+
 static const struct iommu_ops arm_smmu_ops;
 static struct iommu_dirty_ops arm_smmu_dirty_ops;
 
@@ -4412,6 +4417,38 @@ static struct iommu_dirty_ops arm_smmu_dirty_ops = {
 };
 
 /* Probing and initialisation functions */
+
+/**
+ * arm_smmu_queue_max_n_shift() - pick the log2 depth of a queue
+ * @hw_shift: log2 depth the hardware allows, capped for natural alignment
+ * @ent_sz_shift: log2 of the queue entry size in bytes
+ * @want: number of entries asked for, or zero to use @hw_shift
+ *
+ * @want is rounded down to a power of two. It never sizes a queue below one
+ * page, because coherent DMA is page granular: a shallower queue occupies the
+ * same memory as one that fills the page, and arm_smmu_init_one_queue() stops
+ * shrinking at a page too.
+ */
+static u32 arm_smmu_queue_max_n_shift(u32 hw_shift, u32 ent_sz_shift, u32 want)
+{
+	u32 page_shift = PAGE_SHIFT - ent_sz_shift;
+
+	if (!want)
+		return hw_shift;
+
+	return min(hw_shift, max(ilog2(want), page_shift));
+}
+
+/*
+ * Command queues are also allocated by the Tegra241 CMDQV for its VCMDQs, which
+ * need the same depth decision.
+ */
+u32 arm_smmu_cmdq_max_n_shift(u32 hw_shift)
+{
+	return arm_smmu_queue_max_n_shift(hw_shift, CMDQ_ENT_SZ_SHIFT,
+					  cmdq_entries);
+}
+
 int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 			    struct arm_smmu_queue *q, void __iomem *page,
 			    unsigned long prod_off, unsigned long cons_off,
@@ -5048,6 +5085,7 @@ static void arm_smmu_get_httu(struct arm_smmu_device *smmu, u32 reg)
 
 static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 {
+	u32 hw_shift;
 	u32 reg;
 	bool coherent = smmu->features & ARM_SMMU_FEAT_COHERENCY;
 
@@ -5156,8 +5194,8 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 		smmu->features |= ARM_SMMU_FEAT_ATTR_TYPES_OVR;
 
 	/* Queue sizes, capped to ensure natural alignment */
-	smmu->cmdq.q.llq.max_n_shift = min_t(u32, CMDQ_MAX_SZ_SHIFT,
-					     FIELD_GET(IDR1_CMDQS, reg));
+	hw_shift = min_t(u32, CMDQ_MAX_SZ_SHIFT, FIELD_GET(IDR1_CMDQS, reg));
+	smmu->cmdq.q.llq.max_n_shift = arm_smmu_cmdq_max_n_shift(hw_shift);
 	if (smmu->cmdq.q.llq.max_n_shift <= ilog2(CMDQ_BATCH_ENTRIES)) {
 		/*
 		 * We don't support splitting up batches, so one batch of
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 50f8321e979c..a8cb6a69f03b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1165,6 +1165,7 @@ static inline void arm_smmu_domain_inv(struct arm_smmu_domain *smmu_domain)
 
 void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
 			      struct arm_smmu_cmdq *cmdq);
+u32 arm_smmu_cmdq_max_n_shift(u32 hw_shift);
 int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 			    struct arm_smmu_queue *q, void __iomem *page,
 			    unsigned long prod_off, unsigned long cons_off,
diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index 6644075c1431..3fe1075a11a1 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -655,6 +655,7 @@ static int tegra241_vcmdq_alloc_smmu_cmdq(struct tegra241_vcmdq *vcmdq)
 	struct arm_smmu_cmdq *cmdq = &vcmdq->cmdq;
 	struct arm_smmu_queue *q = &cmdq->q;
 	char name[16];
+	u32 hw_shift;
 	u32 regval;
 	int ret;
 
@@ -662,8 +663,8 @@ static int tegra241_vcmdq_alloc_smmu_cmdq(struct tegra241_vcmdq *vcmdq)
 
 	/* Cap queue size to SMMU's IDR1.CMDQS and ensure natural alignment */
 	regval = readl_relaxed(smmu->base + ARM_SMMU_IDR1);
-	q->llq.max_n_shift =
-		min_t(u32, CMDQ_MAX_SZ_SHIFT, FIELD_GET(IDR1_CMDQS, regval));
+	hw_shift = min_t(u32, CMDQ_MAX_SZ_SHIFT, FIELD_GET(IDR1_CMDQS, regval));
+	q->llq.max_n_shift = arm_smmu_cmdq_max_n_shift(hw_shift);
 
 	/* Use the common helper to init the VCMDQ, and then... */
 	ret = arm_smmu_init_one_queue(smmu, q, vcmdq->page0,
-- 
2.54.0

