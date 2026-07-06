Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A773F410E
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 08:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783327643; cv=none; b=VCBn0ichuQWFYL0gnprchWx4Ozryx/I3nWhLZeDbwpvevckdosKNzolqliRDmMGQbpqNUYlfbzSTZYGDatPaoQ8lInnw/lHTPsLl6NSK6Lbp0NTykD1D95IdP3SQB/FCzz2t7ep0BVEIhYmZ5/Xxw+3PruwKbytTxdDCD2AIJPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783327643; c=relaxed/simple;
	bh=kH6gAJ5PNvSmS0ibEasQVY/hXRYRiL9VBuNzqTlhNkA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kss4i78Ut+YyNKApUfZtPEH4OkCrKlJXXwOlk5+xYwstexQ0Mn2T3YS5k37cwxGjPTFbYMjdUstKPbkPTpWnrAC2OG9ii8JuwlfhyyELu5E7U4+CuUrhvGWZPEu7yUHjAD7QIHVDAru4QuMhOec+yxuInq0jP5tIi7zCRPCq+lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T5K4LDaT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T5K4LDaT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E811F00A3D;
	Mon,  6 Jul 2026 08:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783327634;
	bh=K1JM3iR83U/G0YDsw5gW97fJ9sEdX5VFtPwLyKf8wMA=;
	h=From:To:Cc:Subject:Date;
	b=T5K4LDaTnrTLInmxYLGFhXguJrdgMjUW0A9lkms0OMmpbpCHlvsMmu+R4JSqbmaFr
	 4LXRKG23mYEpyL1zLv0NXIAf8jE8vVbW0GR8GtrzkWjxLeDWTs/KUSr/sXt1WVahYp
	 JgCyggNjlKCeq+FPUnmAD7hMNn18DxA2bp4dcPcoUcbqVc+1j3ZI4yz9J5+PB7v4zh
	 GhYYfSc67sDMu+IvaIo0Au0+iYpRDcg9A1qq/mbiOFE+ojLCWGvWbY5z9Fy34LzRXF
	 keKR0t0B9K/AxR+pkZjKO2RBcx9LLEk6a58mqon2/t6PfsVUyW2tkEIwKtm1NWaQWA
	 lyasFhRtAtm1g==
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id 0556FF40069;
	Mon,  6 Jul 2026 04:47:13 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 06 Jul 2026 04:47:13 -0400
X-ME-Sender: <xms:kGtLapuqRIBO2s0WTzd7lweDFzYv8Ik_LePIrmSkKJdqvXGyYy3p9Q>
    <xme:kGtLavIxEg2dI37Nt_5rD_ofEBr1vqBjLxUZgpkzsBZnGKzWQcjeB0MJD-LfhLuot
    QYMchK5mxUDpu3PhcppiyYqRwMlCy0Tt2IVxmg9NijYwn1Ir9XivO2f>
X-ME-Received: <xmr:kGtLagqTpEpFNtP6jHzjcMRuxK7uzerWiBpbbo6ALvZImfw-k6_xQfBXAWLYjw>
X-ME-Proxy-Cause: dmFkZTFgLk5M9VxGft6rFuXGnGCOxsoVsLfH/QhMWdGsWlLYZ+tvZp1fr+XMDadXHgzDSl
    y6Q9gczpCt+E83q0zkJrtfwUsirjdQSNVdeURUQWhISVyyJ4XB/Y7Pyg9Hl7/mqlBl7Qcn
    qwlFvgz+uVlNLAiUHQQMtYxXqcFTn9MB5S+hZyCmdDngmC/3Ia+GlwR3CrsOCy/aWlfsUz
    zV54lUI+sNsGL3WP17ea0EMmkmiCyq/64WDRqlzED74cjLv/UBUIr24yghmQmxiaXp4xC5
    9zyCq9IDeqXQNDvjPod3FKqKBUnS2uLzL5XGYdbfrQ4O9oYFLYXUmlE8guOhUXF3e6pZbo
    FNCVgo6+FoYet0fxGa5N/bknHEQjATOo6auOEvli93NPdiztZguBZntImJ4QsA04v/j4JG
    92QiU0HND4/uQ7zJ7d1mq9u4c0d5kX8Waiydpy773aqR99TW5k2sHIsJl06F+RadfXTgVY
    0VLZUt2wErQ1BX1zgI6oARS3y3q+Drry6n2QAfTCpfslHDSnID88icpTCXwPwpC3hkUTVk
    UIbhObQFXnCFUqokK+rifqHyB5PrDpYvArl2VIBllJ7Dnk8VhFbfeXHj/q2Tw6Nn1fr54i
    Il5/sLo+IcM51e+x/KwqBlvIB6XlLXprGbVl2M81nsfhHezQ9+Rn3pnJEscQ
X-ME-Proxy: <xmx:kGtLaqWKK3tzlUX-X3zhMvyJkfZSJBwtpAxKK2z7irwA061-6KoiVw>
    <xmx:kGtLat2TrT2zg8axIIMLuTjh93ssPmvlSYJVLKDi5kVQXkpNZb6ibw>
    <xmx:kGtLapTK_FsSnoU5mi89Ti_4fa2Xd0ujN5fdD1huN6pLUZeXX3b__Q>
    <xmx:kGtLahTBfYC-cIoaKxyzqEhuIEyssCfPvuy_14nWnn4WyUEqG8rpwA>
    <xmx:kWtLaqVskaUZaBMHKxRhdpmq_E7k_bBrjYAV7nQWCi8g9EX8ZmN1e4Er>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 04:47:12 -0400 (EDT)
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
To: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Pranjal Shrivastava <praan@google.com>,
	Breno Leitao <leitao@debian.org>,
	Kyle McMartin <jkkm@meta.com>,
	Usama Arif <usama.arif@linux.dev>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>
Subject: [PATCH v3] iommu/arm-smmu-v3: Shrink command/event/PRI queues in kdump kernel
Date: Mon,  6 Jul 2026 09:47:08 +0100
Message-ID: <20260706084708.8072-1-kas@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All SMMU queues are sized from the maxima the hardware advertises in IDR1,
which can be several megabytes each, and are allocated at probe. The kdump
kernel already disables the event and PRI queues (arm_smmu_device_reset()
drops CR0_EVTQEN/CR0_PRIQEN) but still allocates them at full size. On
systems with many SMMUv3 instances that cost is paid per instance and adds
up to tens of megabytes of coherent DMA in the capture kernel.

A kdump capture kernel runs from a small crashkernel reservation and only
has to drive the few devices used to save the dump, so deep queues serve
no purpose. The queues are not on the DMA data path, so dump throughput is
unaffected; a shallower command queue only bounds how many commands may be
in flight before a sync, which does not matter for the capture kernel's
small device count and modest I/O.

Clamp every queue to a single page when is_kdump_kernel() is true. Doing
it in arm_smmu_init_one_queue() covers the command, event and PRI queues
in one place. The command queue still holds at least one batch plus a sync
(256 entries on a 4K-page kernel, well above CMDQ_BATCH_ENTRIES), so
command batching keeps working.

Suggested-by: Kyle McMartin <jkkm@meta.com>
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
---
v3:
 - Reword the commit message: all SMMU queues are sized from IDR1, and the
   event/PRI queues, though disabled in kdump, are still allocated
   (Pranjal Shrivastava).
 - Collect Reviewed-by from Pranjal, Jason and Nicolin; Tested-by from
   Nicolin.

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index e8d7dbe495f0..a4ec4a59e527 100644
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
+		q->llq.max_n_shift = min(q->llq.max_n_shift,
+					 PAGE_SHIFT - ent_sz_shift);
+	}
+
 	do {
 		qsz = ((1 << q->llq.max_n_shift) * dwords) << 3;
 		q->base = dmam_alloc_coherent(smmu->dev, qsz, &q->base_dma,
-- 
2.54.0

