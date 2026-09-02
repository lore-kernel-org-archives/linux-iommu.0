Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006592BEC4E
	for <iommu@lists.linux.dev>; Wed,  2 Sep 2026 12:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788351504; cv=none; b=My4wMxP9zBrjoX3zeLHOVtRluvG9mDAAi1nUXqIfawPTJKAslLP40R9VslgiGx2yv7Xg2b9Ya84mJ6P79Dq+4P+TE5IaWWPW+m3bVpp8Gcl5qmtilnh+FY19Jdroh2NOm4dHU7+41kyT1QBo0tba5WKMVnAKw4jHeG2o/Jeifqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788351504; c=relaxed/simple;
	bh=HouCPCTkT5nyl4rDWQ6dca7fKgIePYauW7kPPeNnLpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mtkAoosqxEWhrvSqRo4Sf6ezo/Yt8TzHy6wiVdRU7v71Z4V4h6dTf9V8ggmowsvSZmXdpa2GAPhCReo5Z40a16MmRuqlLVocpREncQ8HTI+CQZOXy8v9i0WAkg5Ld5PNyCgkaJ+PCU94JqatYTYnSoZC5WyNzssNdEp+FqNNFu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GNw+72ld; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GNw+72ld"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA27E1F00A3A;
	Wed,  2 Sep 2026 12:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788351502;
	bh=3MOJSt0tbAYCoMv0mWlV9WfNHa0zoZMLaNSvXKsUlR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GNw+72ldJJlk1zhPlrmLm+jh057W+p8Vh2N7hOXVa3+9vclDG6oc45XQ6bvTTnWvT
	 ogNe/h5+F7tkfMlidRJlpi5nC0h62sV+8vV8PnfrRDwzrvFZfBsiFD7fbOTxA9RMFm
	 LVScXHcst5vdf/VfUvWQrLBWihljS/xQ9xmFxwau6uup8bQYYIrLdcez11mM9gH7Sm
	 puy+wsAVS++aOvkHGLLU9fgXCX5Knjsc4wesNJ9+tn7ZEfvvbhZSs/oBilFoYO6lC6
	 +sqX6eEJHe/siGTbgyLDHXiZoeExRUJY0mtXFmj3gvcziNn8Tp77oXQeSoUJ1uEK2r
	 27hxInc0ORnvw==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.ams.internal (Postfix) with ESMTP id 098E51980047;
	Wed,  2 Sep 2026 08:18:17 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 02 Sep 2026 08:18:19 -0400
X-ME-Sender: <xms:CRSYajN9fUD2uFLQroPQe6yqahQHNfhIOfkmZC5u0y6h6Y5ObR2Vbw>
    <xme:CRSYak5-0e3dRVAgGxLGKz_beknLOinqBDh8biPShnIV4am6D3IBKJY8dwmtWjWUP
    5-8yz4dlDeQaCQVZVl9OfNfZWzGLU7P179B9ay1NVhDF0WnrNnYJQ>
X-ME-Received: <xmr:CRSYanUthD9iyEn07JFU0tawpfwy3-AAQ61TfHost6r3rFTOFclBrVm0Mk0>
X-ME-Proxy-Cause: dmFkZTEXUpnCPuNV+2RXO89bJBzt4DT2UHlbCRCgM3H3femH/cw0lQ3qMUt20S/eAB+4J7
    iCaYJ5/K2JKOFbtN+ZbuperC7KlXF9+UEwTC9jegMZ9EKKwUKtedsborn38YXPNdlIFhn5
    8yR8pn5ZMAt7HfPjC9fJduXSS5GFb7KCir/ruu+hNM8Se2kuXS4kwTxk+QMNsiz+Iox9Fx
    Mv4zalhvjCm/q9/A7354UFOhJSCoU64B4kqmawSE3+O5l7rE5y4GJp7x4WQThnpB8pEDVG
    kdoS9tsZorczMO3BcsQTS31CT66MhUAezHkJ6n3d0Vd2ceKrMqxzcaAkir6ZUwSRiiCAo8
    YxFOUJix8sr2R/NhIrohmv1u0wUDXe0+Qq/P1h1f3FfQ9iLTY3/H9I2yv9v+Wkq7Vhyn6i
    vwbp7BHeTc9MDHe/bhvDLE1vw27v/SXFSR9/ISriWJgxq0IqkLovc1hAEy/7vJTfalCxaT
    4/KttY7KrDS/Sk0ZR0yOfOkiG0U9+JSRM76efCi8T2XeuxDtVZykA6f9MVBH4KALFZXCca
    kpRXcqGZjUx7bJ4vPtEGjp8kdFkFxmQ9J5S/eUYR0LwRRDecu0mjDuAvqmu8nYOMEz7qAH
    vvC9Z4cZij0h7fv7m9ZJ+rPn3TRbFr2LolZoOc7OQK0PLP8Jh2aW/JXB5jsg
X-ME-Proxy: <xmx:CRSYau2wsE5JFolNmGq016YIqfOz-dkfGCM4gwageMgLWOkYvW4BVw>
    <xmx:CRSYamM3C_sxHbhNkDlQL5kvCdYe7yfb7yI-EU2l0_alFfemSXflbg>
    <xmx:CRSYap1en10ewa2gKjvn36dBiEtsAdP5ixmp-SL4H3phkx2G7w5yPQ>
    <xmx:CRSYal2f5J1bam9lopW7NEuLvPSCQSA-MfbSECWBFto4c6-Y2wZn3Q>
    <xmx:CRSYan-3RA0tIkQu7axianU4kbWlHsfSY-AdB1ELxgSqCTJqPNkgNXag>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Sep 2026 08:18:16 -0400 (EDT)
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
Subject: [PATCH v4 2/2] iommu/arm-smmu-v3: Default queue depths to one page in a kdump kernel
Date: Wed,  2 Sep 2026 13:17:24 +0100
Message-ID: <20260902121724.3494954-3-kas@kernel.org>
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

All three queues are sized from the maxima the hardware advertises in IDR1
and allocated at probe, reaching megabytes of coherent DMA each. The
capture kernel already disables two of them: arm_smmu_device_reset() drops
CR0_EVTQEN and CR0_PRIQEN. It still allocates both at full size.

A kdump capture kernel runs from a small crashkernel reservation, and a
system with several SMMUv3 instances pays the full cost per instance. Tens
of megabytes go to queues that either serve the handful of devices used to
save the dump or are switched off outright, and that is memory the dump
itself needs.

Default all three depths to one page worth of entries when
is_kdump_kernel(). The queues carry commands and fault records rather than
DMA data, so dump throughput is unaffected. A shallower command queue only
bounds how many commands may be in flight before a sync, which does not
matter for the few devices that save the dump.

An explicit cmdq_entries still wins, so a capture kernel that wants a
deeper command queue can ask for one on the command line.

Suggested-by: Kyle McMartin <jkkm@meta.com>
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Assisted-by: Claude-Code:claude-opus-5
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 25 +++++++++++++++------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index b371e9ddbfcc..a786219f40ff 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4422,7 +4422,10 @@ static struct iommu_dirty_ops arm_smmu_dirty_ops = {
  * arm_smmu_queue_max_n_shift() - pick the log2 depth of a queue
  * @hw_shift: log2 depth the hardware allows, capped for natural alignment
  * @ent_sz_shift: log2 of the queue entry size in bytes
- * @want: number of entries asked for, or zero to use @hw_shift
+ * @want: number of entries asked for, or zero to use the default
+ *
+ * The default is @hw_shift, except in a kdump capture kernel, which defaults
+ * to one page worth of entries.
  *
  * @want is rounded down to a power of two. It never sizes a queue below one
  * page, because coherent DMA is page granular: a shallower queue occupies the
@@ -4432,11 +4435,16 @@ static struct iommu_dirty_ops arm_smmu_dirty_ops = {
 static u32 arm_smmu_queue_max_n_shift(u32 hw_shift, u32 ent_sz_shift, u32 want)
 {
 	u32 page_shift = PAGE_SHIFT - ent_sz_shift;
+	u32 want_shift;
 
-	if (!want)
+	if (want)
+		want_shift = max(ilog2(want), page_shift);
+	else if (is_kdump_kernel())
+		want_shift = page_shift;
+	else
 		return hw_shift;
 
-	return min(hw_shift, max(ilog2(want), page_shift));
+	return min(hw_shift, want_shift);
 }
 
 /*
@@ -5208,10 +5216,13 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 		return -ENXIO;
 	}
 
-	smmu->evtq.q.llq.max_n_shift = min_t(u32, EVTQ_MAX_SZ_SHIFT,
-					     FIELD_GET(IDR1_EVTQS, reg));
-	smmu->priq.q.llq.max_n_shift = min_t(u32, PRIQ_MAX_SZ_SHIFT,
-					     FIELD_GET(IDR1_PRIQS, reg));
+	hw_shift = min_t(u32, EVTQ_MAX_SZ_SHIFT, FIELD_GET(IDR1_EVTQS, reg));
+	smmu->evtq.q.llq.max_n_shift =
+		arm_smmu_queue_max_n_shift(hw_shift, EVTQ_ENT_SZ_SHIFT, 0);
+
+	hw_shift = min_t(u32, PRIQ_MAX_SZ_SHIFT, FIELD_GET(IDR1_PRIQS, reg));
+	smmu->priq.q.llq.max_n_shift =
+		arm_smmu_queue_max_n_shift(hw_shift, PRIQ_ENT_SZ_SHIFT, 0);
 
 	/* SID/SSID sizes */
 	smmu->ssid_bits = FIELD_GET(IDR1_SSIDSIZE, reg);
-- 
2.54.0

