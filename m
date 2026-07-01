Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4702D5940
	for <iommu@lists.linux.dev>; Wed,  1 Jul 2026 15:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782920739; cv=none; b=rrw4CTdS2EaXPOeIJOWTe5i4cYSFSwPAyWX1pjDsujFOTe8QSiiCAajmVx93jDRJcUeGtCogG7ey10NDKa9QJE6GjkbjZcOYl+M/3GKmvDR2ysc0PNvr8Pfi8gvT3E1EdbM+bhxjQVUkAO6YK5wkQbhedFEzuzJXGgNnAxmccwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782920739; c=relaxed/simple;
	bh=vxY/m6qnJgWzE1WJ1plpqEDBLYUn6cgjmkQg1IdPymA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lX7AQOwoE7rsQJNuijhAh0r91YMSEd5zinCAAoiZAqVpG4LeO1KVKNZISlCXMyyCtNnO99UNMR7ivjgg8qgRLPjWwVygj7fhbRcw0l+U3lzb48944UokUJxZQXnJv21XK/9DngMDEG1Il0m12aWYijt7RZ4KiSwGAjuGjQivXyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WnWiJ+NP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WnWiJ+NP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F39781F00A3D;
	Wed,  1 Jul 2026 15:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782920737;
	bh=8uaKB+erLgoGRRliSGgNeAl6w8yoVZVFzLWho+NHNyA=;
	h=From:To:Cc:Subject:Date;
	b=WnWiJ+NP0SOka904WY52aACOyO2t2A0ssND3U7OY3dci5+oywsOOZG+XP+34PmaU2
	 6hOYOLiBjrqhoYpsUxdCRPk1sEbHQ3MkHtXWQ0EXFyUpFxm0DLfXPiZBGj5wfwf9ns
	 8na8+I4k76Jmmq27sKSkeBcX9BXGtEKm3fOHJwbYP9IAhV6kLEZWfm2ib54JNZF4aE
	 WYACK/vUJ2OoIBRzQET8nax8+IbG/Pb1epKNltQJKsfkBpm1XdTQxBkIvAbEWI6Ydv
	 rPolX0KA2kSrBGqPjBuS7D7H88INZ/TtWRW1Tdg+pOWGTbRoM4NjfV9fhsRzV51gAC
	 5yGvuJFzBeOEg==
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id 216EDF4006A;
	Wed,  1 Jul 2026 11:45:36 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 01 Jul 2026 11:45:36 -0400
X-ME-Sender: <xms:IDZFagfvseMWKSVeticHnUvvm3LkuxiAJDyhZ3lVxBNhohZTF6Rmrw>
    <xme:IDZFaqXh9WYDsZIVcGZsQAA5gq6o8qUoZ-zJ1YcdOBV0PeiYtRJQ7ufLUwUjb3_k_
    AK40wyFCNXBNRu3lTUgTFrid4_P5OZ791s84d_uxzZvo4nvmLsrLw>
X-ME-Received: <xmr:IDZFahBfIKOhDFlY9CMUqIqryA09rPxmeyYC2Ouy-0VJfmq774ZqDUtyWsOUFA>
X-ME-Proxy-Cause: dmFkZTFCe0Qg8LePbnO0tVViZYir7gYWYFiJi9FChNr/c+BoUiXMnAjJHzn194QSG8/hmE
    er9oQOSseZew0j1bWXWyBPXr67FVctHtt01gmE3489L1P+Gx2psn4JZ0E+oki4I/XmVSjv
    sab8pDNDBaBDmFMoKJOTZAhGMsFJhqmYcFrdjq35kCv78wFKzHVql2YMMAoOc7QejNctHl
    ndCOFPQRb+3ETTE2bACiBK1HKTklEgZfUaOEg7qEaLYL6SdMiXE5AiAJVzwWv+tOVsjPIj
    KefxDv54AyNdZFvrK5Lw6WxPOD/ohy38tR6PLST5NqEZERqlSE6w82lhlgi80Lm5+aordQ
    wr0rPQXwBNooBWHEILFP7z3nXEm0TppdHpyGb/q8PdoCG80/CGslcFma3K0Ztn+vLZSeg5
    0RSmZlxB+XGat748J1JC1Btf/yrM7usWj6kvXABDu6cJlcW6IH0IKrqGfOnlsCyXmtjbke
    +18SfuRawLi8YgFr/0hXZONT13KJRwvIPHznaJSa7sgLRIq6eXzccC23HvgG3ZsbwsPmxr
    T3qpDEdK1sWE7MbXeMTHsfpG1X1Q6Y8hQSNXlGUnJSNVDMc4Ku60ucAq2eN0km6phtQDvU
    /hR/zlhr4V+Xo9qF/rgo01n25IqQ7LsO99LI7S1fe2v6zkMo6tUzo73aEtKg
X-ME-Proxy: <xmx:IDZFal5YW1-CQ_lqZHgP0fDhCEcq-sXE-IWOV7vT7rfRSow22HiMkA>
    <xmx:IDZFao014SKzL0DVXmE6VsFKJU3Bd8CgOX_QNRa-p7Hr-4GIxUsbIQ>
    <xmx:IDZFapkaajlGfFVtiFThuEWrIVZHfc2u9h3d6pC2yFotyyiQpPSWMA>
    <xmx:IDZFau7TCJJgqonLF73HtJWaCad4iIJbzY3ov8POiw86331Ox5xmNA>
    <xmx:IDZFaklcPO15aUFndgnZJ7xXqu3Fau_1hwSe8owB4Ed82ha6gl0IfeJC>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 11:45:35 -0400 (EDT)
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
To: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Kyle McMartin <jkkm@meta.com>,
	Breno Leitao <leitao@debian.org>,
	Usama Arif <usama.arif@linux.dev>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>
Subject: [PATCH] iommu/arm-smmu-v3: Shrink command/event/PRI queues in kdump kernel
Date: Wed,  1 Jul 2026 16:45:28 +0100
Message-ID: <20260701154528.768976-1-kas@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The command, event and PRI queues are sized from the maxima the hardware
advertises in IDR1, which can be several megabytes each. On systems with
many SMMUv3 instances that cost is paid per instance and adds up to tens
of megabytes of coherent DMA in the capture kernel.

A kdump capture kernel runs from a small crashkernel reservation and only
has to drive the few devices used to save the dump, so deep queues serve
no purpose. The queues carry invalidation commands and fault records, not
DMA data, so dump throughput is unaffected; a shallower queue only bounds
how many commands may be in flight before a sync, which does not matter for
the capture kernel's small device count and modest I/O.

Clamp every queue to a single page when is_kdump_kernel() is true. Doing
it in arm_smmu_init_one_queue() covers the command, event and PRI queues
in one place. The command queue still holds at least one batch plus a sync
(256 entries on a 4K-page kernel, well above CMDQ_BATCH_ENTRIES), so
command batching keeps working.

Suggested-by: Kyle McMartin <jkkm@meta.com>
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index e8d7dbe495f0..6ec3ef5ee0da 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4414,6 +4414,20 @@ int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 {
 	size_t qsz;
 
+	/*
+	 * A kdump capture kernel runs from a small crashkernel reservation and
+	 * only has to drive the few devices used to save the dump, so there is
+	 * no point sizing the queues for the (multi-megabyte) maxima the
+	 * hardware advertises. Clamp each queue to a single page. ent_sz_shift
+	 * is the log2 of the entry size in bytes (dwords * 8).
+	 */
+	if (is_kdump_kernel()) {
+		u32 ent_sz_shift = ilog2(dwords) + 3;
+
+		q->llq.max_n_shift = min_t(u32, q->llq.max_n_shift,
+					   PAGE_SHIFT - ent_sz_shift);
+	}
+
 	do {
 		qsz = ((1 << q->llq.max_n_shift) * dwords) << 3;
 		q->base = dmam_alloc_coherent(smmu->dev, qsz, &q->base_dma,
-- 
2.54.0

