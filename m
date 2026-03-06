Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BEC37C0E0
	for <iommu@lists.linux.dev>; Fri,  6 Mar 2026 10:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772792214; cv=none; b=AyvAORHVpyg/+xguVM7v9wp9GAsoTFCSWiyl3ZNt6Y45ephIztDl2JGSLFmKobD+qBuD0NIFmN8I8No8PDCsKH5q29C4MocSyNh/ZPMvTzbonPMiXE/AiYkoYNxCO53JIVZFF2HPfxB5jK7Ccik74KzO6Mjc3WC4ru6y2RCWaa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772792214; c=relaxed/simple;
	bh=EENaRECDoNbzcmrccsB1APRoVqd0sxP46eglNjii21E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pd7nNzX/FxXjjPr/llkj5qbkwBQjfHzG6ucgqOORaHHyhZyU4RU2rYlvLdj/x2QXO+bmSTE0FozHfdL4u8x0O8WnmUcAFPETR+8O08aFdJQ9nEbJ4UdWCRO545eLQpUpw/Jnbxfm341eWXWP55S0JTEFuTW0pU/HCfqHM6MmkhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=B9z8jlOf; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="B9z8jlOf"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1772792195; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=8uTkBV0sBURMM8hN9qii8z0UBrQmE2GTSZqyhtbZa8A=;
	b=B9z8jlOfvJ/lb7JN91f1Y/fJLBDQZ+TH2UBkM51ILj4UeALJyfD2XU/wGbHaY2dQ65AuX5Ra6wXB9gtm75wj1gfaJVrFtQPF+RaToJYgvdfPXoNhde+MQBHOxV7tB0tFo0E8qv+Ef5OiGNdQR4oOS25Ta/VPIhLocCYIcDcDDPc=
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X-MyaBA_1772792116 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 06 Mar 2026 18:16:34 +0800
From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
To: baolu.lu@linux.intel.com,
	dwmw2@infradead.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] iommu/vt-d: fix intel iommu iotlb sync hardlockup and retry
Date: Fri,  6 Mar 2026 18:15:16 +0800
Message-ID: <20260306101516.3885775-1-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During the qi_check_fault process after an IOMMU ITE event,
requests at odd-numbered positions in the queue are set to
QI_ABORT, only satisfying single-request submissions. However,
qi_submit_sync now supports multiple simultaneous submissions,
and can't guarantee that the wait_desc will be at an odd-numbered
position. Therefore, if an item times out, IOMMU can't re-initiate
the request, resulting in an infinite polling wait.

This patch modifies the process by setting the status of all requests
already fetched by IOMMU and recorded as QI_IN_USE status (including
wait_desc requests) to QI_ABORT, thus enabling multiple requests to
be resubmitted.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/iommu/intel/dmar.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index d68c06025cac..69222dbd2af0 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1314,7 +1314,6 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
 	if (fault & DMA_FSTS_ITE) {
 		head = readl(iommu->reg + DMAR_IQH_REG);
 		head = ((head >> shift) - 1 + QI_LENGTH) % QI_LENGTH;
-		head |= 1;
 		tail = readl(iommu->reg + DMAR_IQT_REG);
 		tail = ((tail >> shift) - 1 + QI_LENGTH) % QI_LENGTH;
 
@@ -1331,7 +1330,7 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
 		do {
 			if (qi->desc_status[head] == QI_IN_USE)
 				qi->desc_status[head] = QI_ABORT;
-			head = (head - 2 + QI_LENGTH) % QI_LENGTH;
+			head = (head - 1 + QI_LENGTH) % QI_LENGTH;
 		} while (head != tail);
 
 		/*
-- 
2.43.7

