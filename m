Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D983806DD
	for <iommu@lists.linux.dev>; Tue,  1 Sep 2026 13:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788269973; cv=none; b=lAR02Nz8RmkKPgebikHpLLSOocUZBk+owdWvEoenQ9trsHraYgmdgti/rI+nNz0+GZRKAs4Oh98bQGVA/+Xzh4JOhABKo1vXDaLbkLVBvh/2S/HZYam7Bsd4Qdysbv9bck/I3fLCCnTwexfL5WMYNRsZN/WqrufY4EeXOI0M5QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788269973; c=relaxed/simple;
	bh=6ZEVi/aOJyaJhuddMfCe08+BHazf/2XCD9aBzk4QniM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZynELLDFCtj9h08OmuDYKL8z/UYLFCqhHRwyejLoEK8tG02BOtXFytdL4A2d8JqBBpStcICTKz+o65LiJhrLWLgmhnXI9mjlKXIi0n47EEArxaWIn+ir6T9hfKe0WSJToxVCeQRTL1E/6M5QIhqaVK+GLmlSipXp42/BUSSqMJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jqdzBQnA; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jqdzBQnA"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788269967; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Zhv3H2+2w0gZKGeUibRr/8VGF24nes4VuRka42uR/+4=;
	b=jqdzBQnAW5zLQ/f07uzqoJ7+3MytExawkSvMuK5bn3tZASmMH3lB0RUh4x1EUyNhKr5ieGSKysdSjBh6W3L0Zk6R5KsP+4lu3fj/j/8vUT7ikf76NZtn7KGMPY/kuHWUsm64gKYVRIovtEd6Rem8O282EAKlLvzTleW04c7IQo0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0XA9NaYb_1788269964;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0XA9NaYb_1788269964 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 01 Sep 2026 21:39:25 +0800
From: fangyu.yu@linux.alibaba.com
To: tomasz.jeznach@linux.dev,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	baolu.lu@linux.intel.com,
	jroedel@suse.de,
	zong.li@sifive.com,
	andrew.jones@oss.qualcomm.com,
	anup@brainfault.org,
	jgg@nvidia.com,
	jgg@ziepe.ca
Cc: fangyu.yu@linux.alibaba.com,
	guoren@kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v2 1/3] iommu/riscv: Add command queue lock
Date: Tue,  1 Sep 2026 21:39:18 +0800
Message-Id: <20260901133920.14550-2-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260901133920.14550-1-fangyu.yu@linux.alibaba.com>
References: <20260901133920.14550-1-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fangyu Yu <fangyu.yu@linux.alibaba.com>

Add a raw spinlock to the RISC-V IOMMU queue state so command queue
publishing can be serialized by a later change.

Fixes: 856c0cfe5c5f ("iommu/riscv: Command and fault queue support")
Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
 drivers/iommu/riscv/iommu.c | 1 +
 drivers/iommu/riscv/iommu.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index cec3ddd7ab10..2c0dcc90cf85 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -1560,6 +1560,7 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
 	int rc;
 
 	RISCV_IOMMU_QUEUE_INIT(&iommu->cmdq, CQ);
+	raw_spin_lock_init(&iommu->cmdq.lock);
 	RISCV_IOMMU_QUEUE_INIT(&iommu->fltq, FQ);
 
 	rc = riscv_iommu_init_check(iommu);
diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
index 46df79dd5495..5676001548cc 100644
--- a/drivers/iommu/riscv/iommu.h
+++ b/drivers/iommu/riscv/iommu.h
@@ -12,6 +12,7 @@
 #define _RISCV_IOMMU_H_
 
 #include <linux/iommu.h>
+#include <linux/spinlock.h>
 #include <linux/types.h>
 #include <linux/iopoll.h>
 
@@ -23,6 +24,7 @@ struct riscv_iommu_queue {
 	atomic_t prod;				/* unbounded producer allocation index */
 	atomic_t head;				/* unbounded shadow ring buffer consumer index */
 	atomic_t tail;				/* unbounded shadow ring buffer producer index */
+	raw_spinlock_t lock;			/* serialize queue publishing */
 	unsigned int mask;			/* index mask, queue length - 1 */
 	unsigned int irq;			/* allocated interrupt number */
 	struct riscv_iommu_device *iommu;	/* iommu device handling the queue when active */
-- 
2.50.1

