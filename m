Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5EC3EF0C5
	for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 11:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772191621; cv=none; b=of4jnVN+vhRXSdgTxh1snCc5vXo8NFPT6ns1WN+hXVVukwKSdij70/2kyGM7851neTvvoE4gK6adVC/LHryFOHFGhr3Lrm0wFetRrGsE53QToYDUhG0E4lJ77D58JgMvS1BPU0Lnxt4EzeQE2+ex/Nw3/lGrTzkbBSFji60OjSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772191621; c=relaxed/simple;
	bh=gpMPMbasSK61+jjWHW8SpoJQo2GDlM2bsDGS+tXVBAE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fKcHli4ozIuAPZLlh+sx/DJmoMT7nq/60W0L6PTNV/EeLHsI/GZGQHHZbLJ0zK8Gqr5p1jdimzMd5qKv0W3GMWH9kmuRfqQq8bfRiThWQtYkwHaH5UxsvW8GT5s8qhaD55/NBLKn4+MQelaw+vzX0bOhTejp3vs/LyMD/pNAoWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rZT54d9s; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rZT54d9s"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1772191612; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=IDOIyRmT6KuqPEPamC/FBdwtm7Gf75eSBm41m3iY6UA=;
	b=rZT54d9s0As/u5YJsUmAu9fqvho+0sKL9ROHcFx4wv7moTsiuLvROBhnn69gtm3wFlUv6yeOy3DgA1Sif0eNM4ADrhGtNwJctKDM6+9BiX6vbUDtfb0Y7J9CZr41lRNnlSPGcGaphBv8Xka6T2zXbplIn4ncYkc7H2BPRgxAPk4=
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0WzuBAQN_1772191610 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 27 Feb 2026 19:26:51 +0800
From: fangyu.yu@linux.alibaba.com
To: tjeznach@rivosinc.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	andrew.jones@oss.qualcomm.com,
	baolu.lu@linux.intel.com,
	zong.li@sifive.com
Cc: guoren@kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Fangyu Yu <fangyu.yu@linux.alibaba.com>
Subject: [PATCH] iommu/riscv: Stop polling when CQCSR reports an error
Date: Fri, 27 Feb 2026 19:26:40 +0800
Message-Id: <20260227112640.20197-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fangyu Yu <fangyu.yu@linux.alibaba.com>

The cmdq wait loop busy-polls the consumer index until it advances
or the software timeout expires. If the IOMMU has already signaled
a command queue failure in CQCSR, continuing to poll for progress is
pointless.

Make riscv_iommu_queue_wait() also terminate the poll when any of these
CQCSR error bits are observed.

This helps the caller return earlier in failure cases and avoids
spinning until the full timeout interval when the hardware has already
reported an error. On single-core systems in particular, the current
busy-wait can delay servicing the command-timeout interrupt until the
software timeout expires (90s by default).

Fixes: 856c0cfe5c5f ("iommu/riscv: Command and fault queue support")
Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
 drivers/iommu/riscv/iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index fa2ebfd2f912..5d7e49ef7ebb 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -368,6 +368,8 @@ static int riscv_iommu_queue_wait(struct riscv_iommu_queue *queue,
 				  unsigned int timeout_us)
 {
 	unsigned int cons = atomic_read(&queue->head);
+	unsigned int flags = RISCV_IOMMU_CQCSR_CQMF | RISCV_IOMMU_CQCSR_CMD_TO |
+			     RISCV_IOMMU_CQCSR_CMD_ILL;
 
 	/* Already processed by the consumer */
 	if ((int)(cons - index) > 0)
@@ -375,6 +377,7 @@ static int riscv_iommu_queue_wait(struct riscv_iommu_queue *queue,
 
 	/* Monitor consumer index */
 	return readx_poll_timeout(riscv_iommu_queue_cons, queue, cons,
+				 (riscv_iommu_readl(queue->iommu, queue->qcr) & flags) ||
 				 (int)(cons - index) > 0, 0, timeout_us);
 }
 
-- 
2.50.1

