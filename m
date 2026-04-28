Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C434779B3
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 13:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777382388; cv=none; b=L2Uk4wl6vJuoiAm8IjDbSFKLswjaMk2x0KRb/kI21JVR7fl+cTQ/Mfz+P9m4YHd+9DBEeqxrgjwyyFjNHRYspgga3hi7355+KbzJ9XLcGKHcwPT+i4aMXoJh1AZz3N9QyjbptuiSAGFvU+M8D5shadPzPmHLjqB4wehv2Fo8XSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777382388; c=relaxed/simple;
	bh=hOS96Apq9JzCXIC4USAb423oCppmaEpcM2qpGyF2GP0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tGmn9GQ/Nf8oMbqHQdqMgfB/c1mssZ/Aau8Q8724DDOKUeif014Nd2AvfbOajRof/+piFSpovkBy+3AlmXvWMJhF2hWo6BSlvqAtLqdZ3tubPw9HMiLgV0mBLduy4+tptpujmmQhDFupwdiz9xxuHPNm+pTge4teu5BB9qIw/os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=D1F9pOme; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="D1F9pOme"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1777382383; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=d/CJi0j31iQURubrtaBsC+TOdWT/tV2UED1jlPNtsn8=;
	b=D1F9pOme7HuzO3fKj/jjUrRdSuAQw8JAtRQRsAxujDkDa/O0rNVXVG3uUBQ/Gn0gkvFi5DVs04MzpdWx6S0/u91F+V2x1aT2+OQ3BmJxtc7JZWcL3qcLfoydxaT6PGpru8wTw8jy78b5SllpUXUL9ObFn/Qv3wctDl38Msm+wM8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0X1ubIGF_1777382064;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X1ubIGF_1777382064 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 28 Apr 2026 21:14:25 +0800
From: fangyu.yu@linux.alibaba.com
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	tjeznach@rivosinc.com,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com,
	vasant.hegde@amd.com,
	anup@brainfault.org,
	atish.patra@linux.dev,
	skhawaja@google.com,
	jgg@nvidia.com
Cc: guoren@kernel.org,
	kvm@vger.kernel.org,
	iommu@lists.linux.dev,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Fangyu Yu <fangyu.yu@linux.alibaba.com>
Subject: [RFC PATCH 07/11] iommupt: Don't preset D when RISC-V IOMMU dirty tracking on
Date: Tue, 28 Apr 2026 21:13:55 +0800
Message-Id: <20260428131359.34872-8-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260428131359.34872-1-fangyu.yu@linux.alibaba.com>
References: <20260428131359.34872-1-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fangyu Yu <fangyu.yu@linux.alibaba.com>

When mapping writable pages, the RISC-V format code currently
pre-sets the PTE D bit unconditionally.

If hardware dirty tracking is active (DC.tc.GADE set), the IOMMU
sets D autonomously on the first write. Pre-setting D makes every
new mapping appear dirty immediately and breaks dirty tracking.

Introduce PT_FEAT_RISCV_DIRTY_TRACKING_ACTIVE and, when set, leave
D cleared for new writable mappings so hardware can capture the
first write. Keep pre-setting D when dirty tracking is inactive.

Only meaningful for second-stage (iohgatp) page tables.

Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
 drivers/iommu/generic_pt/fmt/riscv.h | 13 +++++++++++--
 include/linux/generic_pt/common.h    |  8 ++++++++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/generic_pt/fmt/riscv.h b/drivers/iommu/generic_pt/fmt/riscv.h
index 4fe645e60375..0281356cfaf6 100644
--- a/drivers/iommu/generic_pt/fmt/riscv.h
+++ b/drivers/iommu/generic_pt/fmt/riscv.h
@@ -248,8 +248,17 @@ static inline int riscvpt_iommu_set_prot(struct pt_common *common,
 	u64 pte;
 
 	pte = RISCVPT_A | RISCVPT_U;
-	if (iommu_prot & IOMMU_WRITE)
-		pte |= RISCVPT_W | RISCVPT_R | RISCVPT_D;
+	if (iommu_prot & IOMMU_WRITE) {
+		pte |= RISCVPT_W | RISCVPT_R;
+		/*
+		 * When hardware dirty tracking is active (GADE set), the IOMMU
+		 * sets the D bit autonomously on the first write access.
+		 *
+		 */
+		if (!(common->features &
+		      BIT(PT_FEAT_RISCV_DIRTY_TRACKING_ACTIVE)))
+			pte |= RISCVPT_D;
+	}
 	if (iommu_prot & IOMMU_READ)
 		pte |= RISCVPT_R;
 	if (!(iommu_prot & IOMMU_NOEXEC))
diff --git a/include/linux/generic_pt/common.h b/include/linux/generic_pt/common.h
index e82dff33ece8..4606c7464c27 100644
--- a/include/linux/generic_pt/common.h
+++ b/include/linux/generic_pt/common.h
@@ -193,6 +193,14 @@ enum {
 	 * Support the 64k contiguous page size following the Svnapot extension.
 	 */
 	PT_FEAT_RISCV_SVNAPOT_64K = PT_FEAT_FMT_START,
+	/*
+	 * Hardware dirty tracking is currently active: DC.tc.GADE is set and
+	 * the IOMMU will set the D bit in PTEs autonomously on write access.
+	 * When this flag is set, new mappings must not pre-set the D bit so
+	 * that every write is correctly captured by hardware.
+	 * Only meaningful for second-stage (iohgatp) page tables.
+	 */
+	PT_FEAT_RISCV_DIRTY_TRACKING_ACTIVE,
 
 };
 
-- 
2.50.1

