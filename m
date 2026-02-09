Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F081433A005
	for <iommu@lists.linux.dev>; Mon,  9 Feb 2026 08:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770624004; cv=none; b=qwXTlR2IU2cIBL1zteR9JSvh3FkmRDxZRzELBWND+ahOgkAniH5o6edBqRt1TjPhpX5YQjglx/0Ukk6RhLYkRjL8HE1eM7zhLTGXBNgrBECzswDqAuWQKLNvrr6qV4oXDUitl25SevZgaUn6+Dh684UzO7n2fkK0yH4jpCkQ2ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770624004; c=relaxed/simple;
	bh=RDlxr3GtXjtCNZcI3mTx5m5/FgR4gJoOSIyObuCwLE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B8st412mZBLIA97WNAVPFj8mzzOPieuHceY9d4pc2lGE+a90+PZMl8bteCB2zIrQV1LMQZyBo/AD7hhwHMggNcz4R7sh+01DleBMQq9QchDXyQJEN+/azZlN7SNGtxsGuFYrz5Z++Q2KJKqdNp3VbNwUCiaMTEHDkCPH1QOIfbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JFJ3HOQ9; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JFJ3HOQ9"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1770624002; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=jeOalJL6nFxVhnFA2rn8CwIKrkwJ0jHzSQmbmzOw54M=;
	b=JFJ3HOQ9myI/lnEuzWUvZNnibAuQ82qpPHb6vqvbXHNAAOVjtOaZiToYfQzzbuh/VAVqY2oVRgbFCkUKGAF6Z6qi0FkRL6sudP9KblDR2XbvMa13X9/M0iWDE7mwTF2TQxRJBhFmCh5n9G51RN6WePpjIyxSO8nt1Jd3FZvIED4=
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0WypM5vD_1770623993 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 09 Feb 2026 16:00:01 +0800
From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
To: dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] iommu/vt-d: fix intel iommu iotlb sync hardlockup and retry
Date: Mon,  9 Feb 2026 15:59:53 +0800
Message-ID: <20260209075953.2253094-1-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <BN9PR11MB5276CF1CB3BB86987AAFBCAC8C65A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <BN9PR11MB5276CF1CB3BB86987AAFBCAC8C65A@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Device-TLB Invalidation Response Time-out (ITE) handling was added in
commit: 6ba6c3a4cacf.

When an ITE occurs, iommu will sets the ITE (Invalidation Time-out
Error) field in the Fault Status Register. No new descriptors are
fetched from the Invalidation Queue until software clears the ITE field
in the Fault Status Register. Tail pointer Register updates by software
while the ITE field is Set does not cause descriptor fetches by
hardware. At the time ITE field is Set, hardware aborts any
inv_wait_dsc commands pending in hardware and does not increment
the Invalidation Queue Head register. When software clears the
ITE field in the Fault Status Register, hardware fetches
descriptor pointed by the Invalidation Queue Head register.

But in the qi_check_fault process, it is implemented by default
according to the 2009 commit: 6ba6c3a4cacf, that is, only one
struct qi_desc is submitted at a time. A qi_desc request is
immediately followed by a wait_desc/QI_IWD_TYPE for
synchronization. Therefore, the IOMMU driver implementation
considers invalid queue entries at odd positions to be
wait_desc. After ITE is set, hardware aborts any pending
inv_wait_dsc commands in hardware. Therefore, qi_check_fault
iterates through odd-position as wait_desc entries and sets
desc_status to QI_ABORT. However, the current implementation
allows multiple struct qi_desc to be submitted simultaneously,
followed by one wait_desc, so it's no longer guaranteed that
odd-position entries will be wait_desc. When the number of submitted
struct qi_desc is even, wait_desc's desc_status will not be set to QI_ABORT,
qi_check_fault will return 0, and qi_submit_sync will then
execute in an infinite loop and cause a hard lockup when
interrupts are disabled and the PCIe device does not respond to
Device-TLB Invalidation requests.

Additionally, if the device remains online and an IOMMU ITE
occurs, simply returning -EAGAIN is sufficient. When processing
the -EAGAIN result, qi_submit_sync will automatically reclaim
all submitted struct qi_desc and resubmit the requests.

Through this modification:
1. Correctly triggers the resubmission of struct qi_desc when
an ITE occurs.
2. Prevents the IOMMU driver from disabling interrupts and
executing in an infinite loop within qi_submit_sync when an
3. Correctly handling simultaneous requests from multiple CPUs
and multiple contexts that result in timeouts.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/iommu/intel/dmar.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index ec975c73cfe6..6938800e9884 100644
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

