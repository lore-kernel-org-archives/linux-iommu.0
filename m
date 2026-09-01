Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5103DA7E4
	for <iommu@lists.linux.dev>; Tue,  1 Sep 2026 13:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788269976; cv=none; b=hEbp6sK03m7OEeXI97jT3dl78PDDDDIpDMxuCpHcMzkl7SzT2vzGtFEKd8NXqF1/td1PzBXcB3fkb4dwu9PcMlSOx681ZkvzyZ+VcB9h8iasKZUuGTBY++RiA28OZN/UzXkajJSkDwSrV+Kde9NUp3hfrXS+476/qRhNZ43RVCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788269976; c=relaxed/simple;
	bh=ai20KLKiOYNguIr/aic80m0d2gkI0atucc+KfaGJgrc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T1zJ/l3+UWBqhVyMA3KITZDaE00MLOcKLGZgzkN7du6vI7aKqKxlEFcnlLzPveJPx6/fggg6rIoLQOEkPNCmh8qrst4H78zKsqfzF2ESt0Xty3W/u3EMDdlXxUkOrtMrKsq7OQOBErPdllkvH7ANQMsQol8M7b2Z7kUgNZ0GpaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Qo4vsBwu; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Qo4vsBwu"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788269970; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=XIEfra7Gk5GpAPhNqAO8Wx/0NjuLdwOdToBsoQSy4QA=;
	b=Qo4vsBwupYtn5L2kXcej+Wk2ptvHE/mdXOEtJsUrxinjdydqvRyGCv21ErBtnqMHVg8C6bGPnuJ12Af+ZfYc6OguhF6tbAbacUthBmZaaUW3lYeL65Ghqg6gCDo9ppmyjv4qKOJCuqjMYky5kv7ZTUQuhcHA0qQjP2pROyAzvtk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0XA9NaZW_1788269967;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0XA9NaZW_1788269967 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 01 Sep 2026 21:39:28 +0800
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
Subject: [PATCH v2 3/3] iommu/riscv: Avoid waiting on failed command enqueue
Date: Tue,  1 Sep 2026 21:39:20 +0800
Message-Id: <20260901133920.14550-4-fangyu.yu@linux.alibaba.com>
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

Do not wait for IOFENCE.C completion when the command failed to enter the
queue. The command was not published to hardware, so waiting for its
producer index can only report a misleading execution timeout.

Fixes: 856c0cfe5c5f ("iommu/riscv: Command and fault queue support")
Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
 drivers/iommu/riscv/iommu.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index e335beb70e42..fe8e6d0f8a23 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -419,8 +419,9 @@ static int riscv_iommu_queue_wait_for_space(struct riscv_iommu_queue *queue,
 }
 
 /* Enqueue an entry and publish it to the hardware queue. */
-static unsigned int riscv_iommu_queue_send(struct riscv_iommu_queue *queue,
-					   void *entry, size_t entry_size)
+static int riscv_iommu_queue_send(struct riscv_iommu_queue *queue,
+					  void *entry, size_t entry_size,
+					  unsigned int *out_prod)
 {
 	unsigned int prod;
 	unsigned int head;
@@ -462,14 +463,16 @@ static unsigned int riscv_iommu_queue_send(struct riscv_iommu_queue *queue,
 	atomic_set(&queue->tail, prod + 1);
 	atomic_set(&queue->prod, prod + 1);
 
-	raw_spin_unlock_irqrestore(&queue->lock, flags);
+	if (out_prod)
+		*out_prod = prod;
 
-	return prod;
+	raw_spin_unlock_irqrestore(&queue->lock, flags);
+	return 0;
 
 err_busy:
 	/* Report the failure and continue; full RAS recovery is not implemented. */
 	dev_err_once(queue->iommu->dev, "Hardware error: command enqueue failed\n");
-	return prod;
+	return ret;
 }
 
 /*
@@ -508,7 +511,7 @@ static irqreturn_t riscv_iommu_cmdq_process(int irq, void *data)
 static void riscv_iommu_cmd_send(struct riscv_iommu_device *iommu,
 				 struct riscv_iommu_command *cmd)
 {
-	riscv_iommu_queue_send(&iommu->cmdq, cmd, sizeof(*cmd));
+	riscv_iommu_queue_send(&iommu->cmdq, cmd, sizeof(*cmd), NULL);
 }
 
 /* Send IOFENCE.C command and wait for all scheduled commands to complete. */
@@ -517,9 +520,12 @@ static void riscv_iommu_cmd_sync(struct riscv_iommu_device *iommu,
 {
 	struct riscv_iommu_command cmd;
 	unsigned int prod;
+	int ret;
 
 	riscv_iommu_cmd_iofence(&cmd);
-	prod = riscv_iommu_queue_send(&iommu->cmdq, &cmd, sizeof(cmd));
+	ret = riscv_iommu_queue_send(&iommu->cmdq, &cmd, sizeof(cmd), &prod);
+	if (ret)
+		return;
 
 	if (!timeout_us)
 		return;
-- 
2.50.1

