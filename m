Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD9648E0E2
	for <iommu@lists.linux.dev>; Wed,  9 Sep 2026 09:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788947564; cv=none; b=gPwpEhBgjDBmxkuh930ignsRsHTvQCKtBHXVToiuWfo6LD0fML11U72b479iifXdIc+WlxkQgHVQgTPOSn8or6sOHId4WunNmTAHLO/5RBidWvtjVfOtIgWOCbrhi521OnknCLrhBGVuKMsUXMPHZAbSoJzJ5/DRpoFDhH8RWDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788947564; c=relaxed/simple;
	bh=tvkPM+qfQALyCdTqgnh5cRnagJYtrDvXEBAYQavN6dg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tvCNJ85DXQ+GO4zpw3rqsf7I6aekzepY5q8kqC3a+aX5XxylIxPpD8nI/QS5TLL5RgyQCvk91jO3YLRVlITl2R+nUf76ryM/by16NayvHyA6+O/h9q+TZQU7YzWctZVQedwOgrirGv1gD1N8fl1wzK2oUR7klBX8fYU/x576nTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7mI7wKN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7mI7wKN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD751F00A3D;
	Wed,  9 Sep 2026 09:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788947562;
	bh=xREhCCmQut5OqUhu2FonBsKEd9tAnwUS1SZjlRQn5Tk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N7mI7wKNI8Lsezgo7Fy51BngeurCTZzxsVxsVdi7RLvhKek5a0SKGz/QqKe03sfXZ
	 kmqZXnVOVKIHCLEQ0Z14/JKLX8tFChfcybXi8ybbviakFgfRyl9fpiRhLrjiz3IzVN
	 ux1+bx2ThKxVCWFEaHcZMiSrk861mJHMw29u/AABmNmqvsglJDcmW0zbXLhzTyTalF
	 saDZCgsp0QnixRmgDVPGWgobZWxhQcPt/Yqfl3FYMQi66JkaJDC7w0pL6UqZm0Oc+x
	 AOzyEFsIcLV35ungXcYHF+pV220pQeef5nQuhShaP0WQcjLRnkd0krvXVnXHNDxkP2
	 4daAFPM9h4Rmg==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.ams.internal (Postfix) with ESMTP id F3F621980050;
	Wed,  9 Sep 2026 05:52:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 09 Sep 2026 05:52:40 -0400
X-ME-Sender: <xms:ZiyhaiJ1YlF9a9F-NuOYqtgbEo_2Cm2cAXuoBvveq2onin9PlQ2v1w>
    <xme:ZiyhahHJY6iqH0e0faksVO9urlk0kvUb4dADFBa2GChmF4QxLuL-O42LkOtmnoq3l
    _eziuTvRP-DgJ_Iav2NReSI4Kdl61dSVv_56FMQFKcADqfpg2In4L3d>
X-ME-Received: <xmr:Ziyhanw0vSRha8SHZTNBPvp4LnRFjgtLTh0nwOXt6Ac-6BYPIlaO-zoOlrc>
X-ME-Proxy-Cause: dmFkZTFwytqU9uv+zciMa5eiBsRpKvX4YmxFZbte5QJE/5T/6q/HSSjzOFSNlPT7p9e1lE
    PTpgnqChmN3ZbKYH5UbWEuDv8kP6WobXh4X5TpTFdyxGfNaEzASUFSdB0DXqKbp4OIGNfq
    yJPDG8a7DW6hHbrdiX2lJ6EE068Q3CqPWAseh9kGGCl8d0YIl/umSHyM/XGd1r1u44Mi2i
    ydjHOJKozyF05s/P175LFkrCOjsBIGAMHr2SJYqGxHktLPF6GwxVb9Ig2s6x+/PsAX4txX
    AbtuJ6SRYJuN75XjzBaPIwlj/OUrzMbJ3O23dAJnQQynVKjIwTOeab2d7E0OHqSfreuLSj
    ajcSxHBAUbTpt6rf1wSYqKYHd49lR3TS+53Dj/Xyj5GscSwTkZJp25QCiwjkSmSUv7ZlJH
    dkyiwSF5HSv5TmDoRSxeMNIMX9Uuth3eLjdprACZT/DDUt0IPNd6XdVKqBS4lJWx1CMaza
    /jImr+e9YSXieyRkE3FVvXrSgfW8eToCZCmq+FF9YKdpwoptJisD0aDZBoXluifxAdMWBc
    z0aqYzh7M3snCtB39P9i83J82NriJZwW774lYFLTLftfwWgLILrkVtj5tNpjvLbIgL6mLz
    I68u3HEhT03mjl3NXlWMgIU6TRBPIto1hFamid8zzPglqbLG7Q1Z5xHT7fFg
X-ME-Proxy: <xmx:Ziyhauj4vLCLLafTNJRTimoS8w5R2_8rC3PSLVdhrVGpfmYBVgj7pQ>
    <xmx:ZiyhakJfVcgF_r8n6mfDI2UbmO64YggCG9JVt7nhAPC8X1pF-GpQUQ>
    <xmx:ZiyhapCymImHRIG16MBYuRSnABRIne2woxIDo3JH_wtrotBZODJFBg>
    <xmx:ZiyhatSvfXZS1MlLr8cBM2wHp_97zsDG2l35cMBrG3IEvYVmDSBeUA>
    <xmx:Ziyhaiqk7yr2zq4e9A2RQrQlbQ2BI4BJdjJa6LrKUUGnVx6IPSAlLvwi>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 05:52:37 -0400 (EDT)
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
To: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Nicolin Chen <nicolinc@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
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
Subject: [PATCH v6 2/2] iommu/arm-smmu-v3: Default queue depths to one page in a kdump kernel
Date: Wed,  9 Sep 2026 10:52:28 +0100
Message-ID: <20260909095228.2174031-3-kas@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260909095228.2174031-1-kas@kernel.org>
References: <20260909095228.2174031-1-kas@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All three queues are sized from the maxima the hardware advertises in IDR1
and allocated at probe, up to 4 MB each on a 4K-page kernel. The capture
kernel already disables two of them: arm_smmu_device_reset() drops
CR0_EVTQEN and CR0_PRIQEN. It still allocates both at full size.

A kdump capture kernel runs from a small crashkernel reservation, and every
SMMUv3 instance pays that cost again, up to 12 MB apiece. It goes to queues
that either serve the handful of devices used to save the dump or are
switched off outright, and it is memory the dump itself needs.

Default all three depths to one page worth of entries when
is_kdump_kernel(). The queues carry commands and fault records rather than
DMA data, so dump throughput is unaffected. A shallower command queue only
bounds how many commands may be in flight before a sync, which does not
matter for the few devices that save the dump.

An explicit cmdq_max_n_shift still wins, so a capture kernel that wants a
deeper command queue can ask for one on the command line.

Suggested-by: Kyle McMartin <jkkm@meta.com>
Assisted-by: LLM
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 36 +++++++++++++++++----
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 78618a9dfa8b..3a6de5e667e0 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4424,6 +4424,9 @@ static struct iommu_dirty_ops arm_smmu_dirty_ops = {
  * @ent_sz_shift: log2 of the queue entry size in bytes
  * @shift: log2 depth asked for, or zero for the default
  *
+ * The default is @ceiling, except in a kdump capture kernel, which defaults to
+ * one page worth of entries.
+ *
  * @shift is floored at one page, because coherent DMA is page granular: a
  * shallower queue occupies the same memory as one that fills the page, and
  * arm_smmu_init_one_queue() stops shrinking at a page too.
@@ -4432,10 +4435,30 @@ static u32 arm_smmu_queue_max_n_shift(u32 ceiling, u32 ent_sz_shift, u32 shift)
 {
 	u32 floor = PAGE_SHIFT - ent_sz_shift;
 
-	if (!shift)
+	if (shift)
+		shift = max(shift, floor);
+	else if (is_kdump_kernel())
+		shift = floor;
+	else
 		return ceiling;
 
-	return min(ceiling, max(shift, floor));
+	return min(ceiling, shift);
+}
+
+static inline u32 arm_smmu_evtq_max_n_shift(u32 ceiling)
+{
+	/* Capped to ensure natural alignment */
+	ceiling = min(EVTQ_MAX_SZ_SHIFT, ceiling);
+
+	return arm_smmu_queue_max_n_shift(ceiling, EVTQ_ENT_SZ_SHIFT, 0);
+}
+
+static inline u32 arm_smmu_priq_max_n_shift(u32 ceiling)
+{
+	/* Capped to ensure natural alignment */
+	ceiling = min(PRIQ_MAX_SZ_SHIFT, ceiling);
+
+	return arm_smmu_queue_max_n_shift(ceiling, PRIQ_ENT_SZ_SHIFT, 0);
 }
 
 /*
@@ -5194,7 +5217,6 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 	if (reg & IDR1_ATTR_TYPES_OVR)
 		smmu->features |= ARM_SMMU_FEAT_ATTR_TYPES_OVR;
 
-	/* Queue sizes, capped to ensure natural alignment */
 	smmu->cmdq.q.llq.max_n_shift =
 		arm_smmu_cmdq_max_n_shift(FIELD_GET(IDR1_CMDQS, reg));
 	if (smmu->cmdq.q.llq.max_n_shift <= ilog2(CMDQ_BATCH_ENTRIES)) {
@@ -5209,10 +5231,10 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 		return -ENXIO;
 	}
 
-	smmu->evtq.q.llq.max_n_shift = min_t(u32, EVTQ_MAX_SZ_SHIFT,
-					     FIELD_GET(IDR1_EVTQS, reg));
-	smmu->priq.q.llq.max_n_shift = min_t(u32, PRIQ_MAX_SZ_SHIFT,
-					     FIELD_GET(IDR1_PRIQS, reg));
+	smmu->evtq.q.llq.max_n_shift =
+		arm_smmu_evtq_max_n_shift(FIELD_GET(IDR1_EVTQS, reg));
+	smmu->priq.q.llq.max_n_shift =
+		arm_smmu_priq_max_n_shift(FIELD_GET(IDR1_PRIQS, reg));
 
 	/* SID/SSID sizes */
 	smmu->ssid_bits = FIELD_GET(IDR1_SSIDSIZE, reg);
-- 
2.54.0

