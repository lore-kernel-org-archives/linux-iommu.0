Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E644A4854
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 14:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790345745; cv=none; b=XGrb9hMOtn7I+dfxNM1YddBI3yLxGWOvq8KUbXUOQpP9Lvk0evqTP1ox7kD3uVNEyuxOTYMDeBvqvLMRXiBS6cMhpMZqlkDcfneKHV46fnEM4X9k/I8Sd+KexJ9JJSb0DBb6SoSEOXkjY6E8sqCcGzi5REAYBPn6u7kw0cXSEbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790345745; c=relaxed/simple;
	bh=rjAyW73kANZYejHA2P8FKv5mgGBCwXIlpRSNuuQa0mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oS5CGtVJSKydTeSxvYdkl8ncUrQW9SFNuq53csDfmWIzOUFQXYTA9OGpp0B6lEJ9aA2fmeTxz5dCd2mqjnSpI0qhXdV1rJmsqiZrGdo7151rIhTZ/Ae7VnLyOELULs0Dmui1DzTtedPpIznlUdFWdcH1GPx5+lBJQxQolRLiamk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=UyZwljfN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BzeEOn+G; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="UyZwljfN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BzeEOn+G"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 7D1ADEC0248;
	Fri, 25 Sep 2026 10:15:41 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 25 Sep 2026 10:15:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1790345741; x=
	1790432141; bh=1ktQH64MdNmCJGeuXk6bCJk+uHJRmtrdtVuZp+kcp9Y=; b=U
	yZwljfNmmNsdB8n+hOXtnnChlP1wJjmQWJrYH7xUgC4pjMHpJvRmKtM1YznFptm4
	/5aU3qOkNDBCUR5Ekrzthjpk68pAFk8LRbNuMLsk4ja3L025TfI7xTKfEDkUEiuA
	uf7lbK2VeEQ5jQ2jZdviXCjfxwYPvEflGnzk/qsj4be9Nnaqm6D8SGVf7pfMe590
	ynWadFnE3O+hULnb1codqCIvhSNBVQLuhbcaz5uFKD1DKLWQAHEUmSJ+fuCfC+jM
	1jCpxfH65m40/QefFcQizi9HSAV476sWppyOus3YpG2sWd0u9NiE5C6pQj1/33Dk
	yRlQPdHT+Lhk9sINfEHjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1790345741; x=1790432141; bh=1
	ktQH64MdNmCJGeuXk6bCJk+uHJRmtrdtVuZp+kcp9Y=; b=BzeEOn+Gst4do58kA
	TSFumWtjcXH7cLsUUprgvYmUTTTsvTXLymG2lFyx6Ygda5lR+UG2nzT5w5/hYP3K
	7aWzUYt1hAGAqJRrz8sKJIK/bNVmeDgJlZW8R/HO5l+K1OQY5Sgj5AVCMKvnLMBs
	WLfNE0vFN47BUU4KjGrEtNjgum0csh8cJOz1DzbbNG/EaDYeE/F4WUggBOdEWgNw
	OwK/Mozij9v4eF87IMY4Wo61jKtvm8275mM1hy/VnUO2B9nlHqKU7fsRYWaoi6NO
	DcHqq8xCkSPLeUVhTvBJS9XqKJSH5z/y6R1mpAVp+YJBGXoEpG8fcp23IlKlJufN
	MsWWA==
X-ME-Sender: <xms:DYK2ah4wDOIL0ncOMtYJvCwOI2iXvmyskf42nSc5A-wvTI4mmQ6UKQ>
    <xme:DYK2amjpyolSubB5oLybzb7Wt7mUcBR2PkrpDlzSFk5jI7pXah43pAdqHPHsVTJMH
    1Z8QS5d_nCO7d72Jwy7lSzY4hqW69Gi30Ri3GOfFlWe8LJ5Pas05Q>
X-ME-Received: <xmr:DYK2aorYwWr_E8hH0jbaGmSlWYl-rqjS80vjqXsVuqRYX7UleYUQhuIVW4I>
X-ME-Proxy-Cause: dmFkZTGKDwwNiF627+asCW7qlOfbc3YO4/BWQQAIa1dD7j4y1/LpRsbneXz52sgooVW2NB
    3cVSkvlr4fQi4SwiDMxRaBoBRNO6zHRHeGXMGxJYTRHb1PBeh27/Q3VWbCGBZujoWHPoE6
    R+Qc/6k1bBYz+Haf5IzKmyGQxC9qTL+WrK7JzMZqDmDHuiASYj35os3WnrFE1SWLZ6a+qY
    bCW2glHxjWyrurmiVGB62MJKctiau11N+au9WzHHk3KgIfj2lfSeRdK+MffwyEB0gNSuDN
    eSmAis7xZg1iofNwJ76iNU49c75bqPHfinmsayTQbADoZ6F/gk68t7NA/yonOE6sVDH8F4
    GrbXyWpBbmuCShau1sGcJPX2ea641v6zI8ks6qcI5j3hSLjFADE7BuGhe0vuVlNoqzfY8t
    WVuJko3s4/EaAbKXVDlSiK/vwhT4qPpLZ/+FqCHRvsC759cyF0XW71AAukG71aEi2jZFUX
    pwpx0bqJYALapEWolycem0U3kP3vmzPOXIOj1Hub0si31e+psklr2msjxYj1zN/UVXnpR3
    l54NK6TZA0prmxnuN6kEtDxGXCwoSx6sH45l+gmQXXPvGs0pxRk1QybcpcNWwpDPhsWJ/l
    jG5nBYXAQTrGqcrJUAaYSwUdM5xAAh3hPP1A5kgnfim8niTKYziJK65pCqcg
X-ME-Proxy: <xmx:DYK2aiIUD08mhlDE03jsveuOomID1bn7Ku-EZr1ur_SJN7F8czqRvg>
    <xmx:DYK2alvF6wb860RiJDIve9M2vUUNME2XlBc9uxIYPFaNBaynhqDJow>
    <xmx:DYK2aitmkW16I2i5VH7ZZ9g7xgtj0V7A4p4vV8Xm3ouRe-3wCArdEg>
    <xmx:DYK2asUVqMTK9yfrWF-W160grerF-ZK3gjS8LZvTcMKV0cKgvw4CtQ>
    <xmx:DYK2am8iXCNCaceVrVVqorPITNemqmj7OAYbqmt_4THfCFLPL_erKtLW>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Sep 2026 10:15:40 -0400 (EDT)
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Breno Leitao <leitao@debian.org>
Cc: "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	Krishna Reddy <vdumpa@nvidia.com>,
	Pranjal Shrivastava <praan@google.com>,
	Mostafa Saleh <smostafa@google.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Yuanhe Shu <xiangzao@linux.alibaba.com>,
	Kyle McMartin <jkkm@meta.com>,
	Usama Arif <usama.arif@linux.dev>,
	kernel-team@meta.com,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 1/2] iommu/arm-smmu-v3: Add a cmdq_max_n_shift module parameter
Date: Fri, 25 Sep 2026 15:15:29 +0100
Message-ID: <20260925141532.1274962-2-kirill@shutemov.name>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260925141532.1274962-1-kirill@shutemov.name>
References: <20260925141532.1274962-1-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>

The command queue depth comes straight from the maximum the hardware
advertises in IDR1, which reaches megabytes of coherent DMA per queue.
A system with several SMMUv3 instances pays that per instance, and the
Tegra241 CMDQV pays it again for every VCMDQ it preallocates.

Queue depth only bounds how many commands may be in flight before a sync.
A machine driving a handful of devices, or one with a tight memory budget,
has no use for the maximum, and no way to say so.

Add cmdq_max_n_shift, a cap on the depth given as the log2 of the entry
count, the form the hardware itself takes in the LOG2SIZE field of
CMDQ_BASE. It defaults to the largest depth the driver allocates, so an
unset parameter changes nothing. Decide the depth in
arm_smmu_cmdq_max_n_shift(), which applies the parameter to the IDR1
value, so the queue is allocated at the requested size. The Tegra241 CMDQV
sizes its VCMDQs from IDR1 itself, so route that through the same helper.

Floor the request at one page worth of entries. Without the floor, a small
request trips the CMDQ_BATCH_ENTRIES check in arm_smmu_device_hw_probe()
and the SMMU fails to probe. The floor also costs nothing: coherent DMA is
page granular, so a shallower queue occupies the same memory as one that
fills the page.

Assisted-by: LLM
Reviewed-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 40 ++++++++++++++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  1 +
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    |  2 +-
 3 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 5732f3ba0122..810d3ce75089 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -40,6 +40,11 @@ module_param(disable_msipolling, bool, 0444);
 MODULE_PARM_DESC(disable_msipolling,
 	"Disable MSI-based polling for CMD_SYNC completion.");
 
+static unsigned int cmdq_max_n_shift = CMDQ_MAX_SZ_SHIFT;
+module_param(cmdq_max_n_shift, uint, 0444);
+MODULE_PARM_DESC(cmdq_max_n_shift,
+	"Cap on the command queue depth, as log2 of the number of entries. Defaults to the hardware maximum; the queue never shrinks below one page.");
+
 static const struct iommu_ops arm_smmu_ops;
 static struct iommu_dirty_ops arm_smmu_dirty_ops;
 
@@ -4412,6 +4417,37 @@ static struct iommu_dirty_ops arm_smmu_dirty_ops = {
 };
 
 /* Probing and initialisation functions */
+
+/**
+ * arm_smmu_queue_max_n_shift() - pick the log2 depth of a queue
+ * @hw_max_n_shift: log2 depth the hardware advertises in IDR1
+ * @ent_sz_shift: log2 of the queue entry size in bytes
+ * @limit_n_shift: log2 depth to cap the queue at
+ *
+ * @limit_n_shift is floored at one page, because coherent DMA is page
+ * granular: a shallower queue occupies the same memory as one that fills the
+ * page, and arm_smmu_init_one_queue() stops shrinking at a page too.
+ */
+static u32 arm_smmu_queue_max_n_shift(u32 hw_max_n_shift, u32 ent_sz_shift,
+				      u32 limit_n_shift)
+{
+	u32 floor_n_shift = PAGE_SHIFT - ent_sz_shift;
+
+	limit_n_shift = max(limit_n_shift, floor_n_shift);
+	return min(hw_max_n_shift, limit_n_shift);
+}
+
+/*
+ * Command queues are also allocated by the Tegra241 CMDQV for its VCMDQs, which
+ * need the same depth decision.
+ */
+u32 arm_smmu_cmdq_max_n_shift(u32 hw_max_n_shift)
+{
+	/* Capped to ensure natural alignment */
+	return arm_smmu_queue_max_n_shift(hw_max_n_shift, CMDQ_ENT_SZ_SHIFT,
+					  min(CMDQ_MAX_SZ_SHIFT, cmdq_max_n_shift));
+}
+
 int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 			    struct arm_smmu_queue *q, void __iomem *page,
 			    unsigned long prod_off, unsigned long cons_off,
@@ -5156,8 +5192,8 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 		smmu->features |= ARM_SMMU_FEAT_ATTR_TYPES_OVR;
 
 	/* Queue sizes, capped to ensure natural alignment */
-	smmu->cmdq.q.llq.max_n_shift = min_t(u32, CMDQ_MAX_SZ_SHIFT,
-					     FIELD_GET(IDR1_CMDQS, reg));
+	smmu->cmdq.q.llq.max_n_shift =
+		arm_smmu_cmdq_max_n_shift(FIELD_GET(IDR1_CMDQS, reg));
 	if (smmu->cmdq.q.llq.max_n_shift <= ilog2(CMDQ_BATCH_ENTRIES)) {
 		/*
 		 * We don't support splitting up batches, so one batch of
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 50f8321e979c..ea4c87bbe253 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1165,6 +1165,7 @@ static inline void arm_smmu_domain_inv(struct arm_smmu_domain *smmu_domain)
 
 void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
 			      struct arm_smmu_cmdq *cmdq);
+u32 arm_smmu_cmdq_max_n_shift(u32 hw_max_n_shift);
 int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 			    struct arm_smmu_queue *q, void __iomem *page,
 			    unsigned long prod_off, unsigned long cons_off,
diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index 6644075c1431..710a4c694b94 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -663,7 +663,7 @@ static int tegra241_vcmdq_alloc_smmu_cmdq(struct tegra241_vcmdq *vcmdq)
 	/* Cap queue size to SMMU's IDR1.CMDQS and ensure natural alignment */
 	regval = readl_relaxed(smmu->base + ARM_SMMU_IDR1);
 	q->llq.max_n_shift =
-		min_t(u32, CMDQ_MAX_SZ_SHIFT, FIELD_GET(IDR1_CMDQS, regval));
+		arm_smmu_cmdq_max_n_shift(FIELD_GET(IDR1_CMDQS, regval));
 
 	/* Use the common helper to init the VCMDQ, and then... */
 	ret = arm_smmu_init_one_queue(smmu, q, vcmdq->page0,
-- 
2.54.0

