Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D130F3EDAAE;
	Thu,  2 Jul 2026 11:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782991712; cv=none; b=o9cV5QfwR0dg1I+qN63Ji7RT7fOKTE78OaDRR+uDigPC9mUnTXidSiDYumzPBs9ljAzluXOeqflaL5ybmsTAgeaM7JCZMoMaxNjuJiDgW+Uo4Nvgy1Z2QIo/1pwhcN+Va2RKWWrMmcjy7TuoKuMdObHVWSgg5pJzc3dob312LQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782991712; c=relaxed/simple;
	bh=fXBLWoxuATWQ8dca6CLjiiXPqZS+bx4cnqLlWkj/IMY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lrsVKzh5iTMEDKW88or+8hbnenwFgxs8FWJwQ6Kd3x7cIds5m0wdbiHCbWOGgqW8myKtLy4zsUYoSX+vpAwXQ4htD25TDDAIPcbC9z9vX95J8VvqItIKDJLD2bsW/MNlFbQVJ5d9/Co9fpv4x4kspNRj6RShLf2xKWgpQj1Oi+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VjmsCVaf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VjmsCVaf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 596381F00A3D;
	Thu,  2 Jul 2026 11:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782991711;
	bh=cEaUVNTt35/9gjndPgOFyykYqGHl4r842ag5IRhn4OA=;
	h=From:To:Cc:Subject:Date;
	b=VjmsCVafUVSCuPPbaQWJH92Up9ypMgTuf/N9dV9j60mvfdgIDSFGqQrzFtPVDxmk6
	 e2jYeFkG+a+nX3eSYUzlsFf1Yf7nEeV36yvbAXraixxxoHnH7yQgUtB0JD1SI7Qod/
	 pEG/SxEWvPh622TZ4CbglNyo7Wmpg83EI5aZH9eYYFOoFm8WgGBjgWUdRcr+biCPnc
	 ioP297OLRTfCFzjFjR7xMrxqEEx2ScRjMhnWwyR5Dla4Z3MSwFgu8FMYxwcxfFRiZV
	 07lEixErf5nmKoDXHVrxAISuT8tGUY+4s9V7eNU/w82y3vac4oQI5tAo6y8YuKiPOw
	 ntJY47fIL06kw==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 7B128F40068;
	Thu,  2 Jul 2026 07:28:30 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 02 Jul 2026 07:28:30 -0400
X-ME-Sender: <xms:XktGajNL0AgV96PdEXQfYq-prm6p1Bw1-SFsdKq7h38rrJQ6aQV3Qw>
    <xme:XktGamGoQpx8L75omiiC9aif2jsSMFBjJAY7iMLdSDiFpFsXXxFW4o_Ch0yicHWsN
    tp_ND3o6amFQG7YzB6MMGtmZqrDPsYdUrY6O1pP_6A29q0B_B6Msn8>
X-ME-Received: <xmr:XktGahzlrYyivlAidKANg0iCfSPeNIc1Ce_koBquTHCO_-C-Gmmb5q-fGXWrSQ>
X-ME-Proxy-Cause: dmFkZTGDz2TgXYD15RfQJl3C1/PFcHSD6jKh/svFZqpNhYXxBkJjR5Fny7ZMYPRtBRXty0
    O8Lh42t82Rp0MOZw771Vs+6UYgwEZ0aEm8GOYOT1Gf6b08MaOkgiPSj/PP7kufaV4rS25j
    SbuEtcm2NTfjlY+vJM/W6AmTncqiZbnT3xko8EfR+JGAgSDA3eFv2WyubKH5etbgxr9ydS
    u+ZlevPd78XVZ+3jmtHfvGuzvlxsPzFZx4lx5yMK7cLLkxfl2w1urjhK/ZkDbfPJguti0W
    Rg88IS3FM1KRDa8mMpUINhuTpGxXL7vi00izNm3lYNPMnmWxzvoDrhTNFjTd//decMf5cE
    8jl+Lvf1u5iVwiB/lWpGsfaqkFBWsMOdr9GiaJyPM2iNtzrlIhbkQzRxOTXg4agDCXcXxp
    676r3wOFHH9YKLkDy89zgz04wTkPUGSPEWscSF9FplXqIh1wVyRNDhHOI6V5pkzfxN54cc
    u+q507o2EM0ctxFB3wMb0mjzbI3am4m+BpMtUib4XTM+JYKqPkRGFvPLTnyf924OJXWSpb
    fFKBfC3iYCvteDVFEDqQV5+2Pr822eZi/KHhL321w3np4c2UVOGC1gf9+UAL//zypxrVSa
    Lzi1tf/Fl9uHJtWYQnTvLj8BV1NtzSwY+x3AwoMQvHXT0D78/a6fMj+3kBXQ
X-ME-Proxy: <xmx:XktGanozHPKmQEuV7DFmCke5iZ3GfEpuh59qRnym6_PqzjOJ0hyXcw>
    <xmx:XktGanmoqSnPSWUMiyxd_SGbZm2tPCFmNTn4SdmNV8_kp1E54cpTaA>
    <xmx:XktGahURk81tPf4P5nn1zqjyrF-57AYwDZBPEbMSRWs-L2atQ81thg>
    <xmx:XktGarouPTcWIXliYS42LQcI8KxLIkA4tDtV_XQXib0_7VU3Tg7I8Q>
    <xmx:XktGaiVNKupu9W6zZ0A1KTL1zob1ZcbPjJHqcVviTiML3xhMweySgcKz>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jul 2026 07:28:29 -0400 (EDT)
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
Subject: [PATCH v2] iommu/arm-smmu-v3: Shrink command/event/PRI queues in kdump kernel
Date: Thu,  2 Jul 2026 12:28:25 +0100
Message-ID: <20260702112825.781750-1-kas@kernel.org>
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
Reviewed-by: Breno Leitao <leitao@debian.org>
---
v2:
 - Use min() instead of min_t(); both operands are u32 so the cast was
   redundant (Jason Gunthorpe, Breno Leitao).
 - Add Reviewed-by from Breno.

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

