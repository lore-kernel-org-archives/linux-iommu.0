Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D842A190462
	for <iommu@lists.linux.dev>; Mon,  2 Feb 2026 02:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769998180; cv=none; b=cb1YZ/6iMXO7plv7FseBDwnv2cWPEaqfpqnn2M4BwS6FNMwGJYcop6yoOekHMMsNf1Kt0f2GQKl5ehddhcjlef+7JM7BTTWFMD/5M7tZP46/qA81/x0apoanlaVZFZ/ygU4dt6ewRAR6xSQwuCAcD9sJnV16DmS4aPnyfw4+Dj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769998180; c=relaxed/simple;
	bh=b+XteJUGn9IhKZ9H+jUQw9+mb9/FjKGUGGhXR8MOBOg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sCTWZwLbGAt1WGaYzns/LJMedDlevIUG9Ry38wVf7RrznDe57srhEN+ffd00uEo9Wb7uD0OOXT1zu0eKnkT6cjT08Xkim2I6gkiCPFF+gbHkTPpBocTSNiChYyScnd8u1xuDHnIBA7ltr8yU3+j/U+gjaVJD4icVidOSyUhT1m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tyLSUCv1; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tyLSUCv1"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769998170; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=HawuGLhwatkMIpUiPOjDwP9myJVSnszEA74ClxbzMeE=;
	b=tyLSUCv1gq+49TKVU60mNbrVCUzcyMSAv6r4iH8L6ut3pGSOY5MdaHCWOatDNgLuJvQR3YT1OV/6BOYq6llYZ+HXHlAGS035RL7p/HEpFq9sZn0Xd+tX63WPEQyypSI6wwHEhRfRZ33Fzv7xJGi30qwZjfk9SZlN4l+2xhUBMKs=
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0WyI6Ude_1769998160 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 02 Feb 2026 10:09:30 +0800
From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
To: dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: alikernel-developer@linux.alibaba.com
Subject: [PATCH] iommu/vt-d: fix intel iommu iotlb sync hardlockup & retry
Date: Mon,  2 Feb 2026 10:09:20 +0800
Message-ID: <20260202020920.3557883-1-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Device-TLB Invalidation Response Time-out (ITE) handling was added in
commit: 6ba6c3a4cacfd68bf970e3e04e2ff0d66fa0f695.

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
according to the 2009 commit: 6ba6c3a4cacfd68bf970e3e04e2ff0d66fa0f695,
that is, only one struct qi_desc is submitted at a time. A qi_desc request is
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
ITE occurs, avoiding hardlockup.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/iommu/intel/dmar.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index ec975c73cfe6..f31f0095f9a8 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1271,7 +1271,7 @@ static void qi_dump_fault(struct intel_iommu *iommu, u32 fault)
 static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
 {
 	u32 fault;
-	int head, tail;
+	int head;
 	struct device *dev;
 	u64 iqe_err, ite_sid;
 	struct q_inval *qi = iommu->qi;
@@ -1312,12 +1312,6 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
 	 * No new descriptors are fetched until the ITE is cleared.
 	 */
 	if (fault & DMA_FSTS_ITE) {
-		head = readl(iommu->reg + DMAR_IQH_REG);
-		head = ((head >> shift) - 1 + QI_LENGTH) % QI_LENGTH;
-		head |= 1;
-		tail = readl(iommu->reg + DMAR_IQT_REG);
-		tail = ((tail >> shift) - 1 + QI_LENGTH) % QI_LENGTH;
-
 		/*
 		 * SID field is valid only when the ITE field is Set in FSTS_REG
 		 * see Intel VT-d spec r4.1, section 11.4.9.9
@@ -1328,12 +1322,6 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
 		writel(DMA_FSTS_ITE, iommu->reg + DMAR_FSTS_REG);
 		pr_info("Invalidation Time-out Error (ITE) cleared\n");
 
-		do {
-			if (qi->desc_status[head] == QI_IN_USE)
-				qi->desc_status[head] = QI_ABORT;
-			head = (head - 2 + QI_LENGTH) % QI_LENGTH;
-		} while (head != tail);
-
 		/*
 		 * If device was released or isn't present, no need to retry
 		 * the ATS invalidate request anymore.
@@ -1347,8 +1335,8 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
 			    !pci_device_is_present(to_pci_dev(dev)))
 				return -ETIMEDOUT;
 		}
-		if (qi->desc_status[wait_index] == QI_ABORT)
-			return -EAGAIN;
+
+		return -EAGAIN;
 	}
 
 	if (fault & DMA_FSTS_ICE) {
-- 
2.43.7

