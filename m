Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491AB3C9EE6
	for <iommu@lists.linux.dev>; Wed,  5 Aug 2026 04:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785903634; cv=none; b=Hw0zhxLqqOdrsiJaio31Z+3cfqZu9lAiLKhYX29249EkBjvkxcgXlPIYN8/LT+gSkd7PRiJftai84mIAkr2cxf3m6QsMzK90Ccc1VWG0lazd23ALUCOpmqbwCl8UQE+iywC8sjcwd/TqecFE8JhwKyZzY8nVUQ4QHOPWG5GzPyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785903634; c=relaxed/simple;
	bh=2mTxLEZZHRX66QWhlcyMv8CxW70Ble7AYSdF/5GnDSs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Enbppdjk0g8P9NB+AMavNosHFu4hJDHKFK5LUDLYlnvmhlkuQVO9Ut99SDOVYyHkclQvE3n9QEeMKA0V8D28F5YIaj+ggZ4R6FkNkKZ+kTYgknPssi69HG1VQqBcOeAQgiG6SY4DuCRbFPgW2okqNNE/CNtXTaOj546yBhvVKXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=socP7tjX; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="socP7tjX"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1785903621; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=6PbQk7Ljeu2Nh5gx4GLKOoas/XpSlt4pFhaaMaIb66I=;
	b=socP7tjXS46hERDTXeN2NmG/TvQepf5d8QMqRwb0U10Ec/egQxwhB4KSl3F6BSret6hcfqiE10VCy4NEqYrqpQJdikz9MCvUBDDou6DakSrgo8fF2iXVs5E1gmunoQM83+A1eL7Ktzf8+vcN0dYzKt5P4T57EJI0Vsoh+gsEw6Y=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R361e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0X8Q-Oda_1785903612;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X8Q-Oda_1785903612 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 05 Aug 2026 12:20:20 +0800
From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
To: dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/vt-d: Fix IQE handling to cover all descriptors in submission range
Date: Wed,  5 Aug 2026 12:20:12 +0800
Message-ID: <20260805042012.2363698-1-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, qi_check_fault() only handles IQE (Invalidation Queue Error)
when the faulting descriptor index exactly matches the first descriptor
of the current submission (head == index). This is too restrictive in
multi-descriptor submissions where the error could occur at any
descriptor within the batch.

If the IQE is triggered by a descriptor that belongs to the current
submission but is not at the starting index, the function returns 0
without clearing the IQE fault status. Since hardware stops fetching
new descriptors until IQE is cleared, this leads to an indefinite wait
on the wait descriptor completion - effectively a deadlock.

Fix this by expanding the IQE handling condition to cover all descriptors
within the circular range [index, wait_index]. Use explicit bounds
checking that properly handles the wrap-around case of the circular
queue.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Signed-off-by: bikuan.zbk <bikuan.zbk@alibaba-inc.com>
---
 drivers/iommu/intel/dmar.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 767ec092accd..8ae513593406 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1290,8 +1290,13 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
 	 * is cleared.
 	 */
 	if (fault & DMA_FSTS_IQE) {
+		int head_idx;
+
 		head = readl(iommu->reg + DMAR_IQH_REG);
-		if ((head >> shift) == index) {
+		head_idx = head >> shift;
+		if (index <= wait_index ?
+		    (head_idx >= index && head_idx <= wait_index) :
+		    (head_idx >= index || head_idx <= wait_index)) {
 			struct qi_desc *desc = qi->desc + head;
 
 			/*
-- 
2.43.7

