Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720F1175A99
	for <iommu@lists.linux.dev>; Mon, 17 Aug 2026 14:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786976915; cv=none; b=clWmHzUNa1PofZB/j4Ml7b4pBfNCm5M6yyHjGE1zCVJ51WtciXZn0mWlg+Y+Kw12vQCjP9vxEtW1eeF/sh75pFkC2zc6v3Cs4r3nj3AeWt5qEpYDG3pLtwTtbTcV46f7vW0Uxk85ZSCZXKWnkcn7ScpoO1SJQ0gy9WC1Qn/KX6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786976915; c=relaxed/simple;
	bh=6ZEVi/aOJyaJhuddMfCe08+BHazf/2XCD9aBzk4QniM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hu5FFXqIXlwoCeqbijVv1H7k3hy51++ql/PMVgdTQMsSxwjzVu68omL/CgiUMJbHQR03sjLBMfRc0xcxTUbXEfE0je27SnpaQQYnZLJ8qDlrdobhHOTMs7o8s9NuYkmNuX8eSMGknVfFxwxGXF/5Dd69NKOvPvAd+os0LVYhe+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EHWAcjwl; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EHWAcjwl"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786976905; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Zhv3H2+2w0gZKGeUibRr/8VGF24nes4VuRka42uR/+4=;
	b=EHWAcjwlDrnzAPGiQjEwpmmDt0u+CsD1Bm/Nb7lcbF8+BwCurJMh6tweqKqJFqLLSHzQAo2cp2ZnCZWBqVusAuSbG74x51YM6MAepB+D7YyzjvBmoJsnilxH4H28XGSPYSGdmUuhEEKNYbr17mlR4EDObupCMZb1fmIN4PlMjhg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0X9A9H-f_1786976902;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X9A9H-f_1786976902 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 17 Aug 2026 22:28:23 +0800
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
	zong.li@sifive.com
Cc: fangyu.yu@linux.alibaba.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH 1/3] iommu/riscv: Add command queue lock
Date: Mon, 17 Aug 2026 22:27:26 +0800
Message-Id: <20260817142728.61783-2-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260817142728.61783-1-fangyu.yu@linux.alibaba.com>
References: <20260817142728.61783-1-fangyu.yu@linux.alibaba.com>
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

