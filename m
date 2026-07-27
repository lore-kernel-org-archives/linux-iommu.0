Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BEB3BD62E
	for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 03:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785121344; cv=none; b=f1/qPnOEvpYN4cUKAuY3mQ7XEBHqXc2F+a9Rb3aQM0wu4fIygrChfFJvry6DjZYKG4BcDrGl1L0PyOK2Tdq6aEy0IfU2zajnRmHpHjnLP7N3Ic8j5g3UhzRxZFVDeXD4GmXIOedUnSl4cl9dQQuHKaGWcsWOqCyHcO/drYQNc4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785121344; c=relaxed/simple;
	bh=RUjVCufh8DNtD/XbA8ITwSZlqCIY3eXpqUdR6cgCDMo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sg5vOCLqesInOuN1dZXExYWQ8aLS8GiYw//BUTGymvT70buyC0mZWm4AjcQ2gUhl3h1/pd3k6yL4RaaULutE5gglOUj6igXn9NMDevGWavbN90eKhW+/oCoQmNdNfnP50LMKll7OkTExTTvHHqlQ7l8KB3v+Z6Ev78NW2vOjHKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=yOeH2hRS; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="yOeH2hRS"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1785121334; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=LxXIBDLLpab+C/qEPjDCIRPvwyjFSCaYrsQpDKOrf5k=;
	b=yOeH2hRSo17LiCCxHlWx9UEzdx3W1fQitKL9xDEeZQv3mS3Y7OuXvgZx/xI00tYupLVZPlOXfu4ff/LU52lnnDuDqN4KiPMyhALVo6FxRd1ya1ZIm4VFAjDQN9jTwGWFwJ55ICBZZrPDBobMaauAbgkL3/lmK0ZyJUJrIk+Tvkw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R411e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0X7ogeJH_1785121332;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X7ogeJH_1785121332 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 27 Jul 2026 11:02:13 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: joro@8bytes.org,
	suravee.suthikulpanit@amd.com,
	vasant.hegde@amd.com,
	will@kernel.org,
	robin.murphy@arm.com
Cc: bhelgaas@google.com,
	oliver.yang@linux.alibaba.com,
	zhuo.song@linux.alibaba.com,
	xueshuai@linux.alibaba.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/amd: Put PCI device after handling PPR faults
Date: Mon, 27 Jul 2026 11:02:12 +0800
Message-Id: <20260727030212.51759-1-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iommu_call_iopf_notifier() looks up the requester with
pci_get_domain_bus_and_slot(), which returns a PCI device with its
reference count incremented.

Neither the successful iommu_report_device_fault() path nor the abort
path drops that reference, so every handled PPR request leaks a PCI
device reference.

This is the same ownership rule that was fixed for the old iommu_v2
ppr_notifier() path by commit 6cf0981c2233 ("iommu/amd: Fix pci device
refcount leak in ppr_notifier()"), but iommu_call_iopf_notifier() was
added later as a separate PPR/IOPF notifier path.

Drop the PCI device reference after handling the PPR entry.

Fixes: 978d626b8f1a ("iommu/amd: Add IO page fault notifier handler")
Cc: stable@vger.kernel.org
Assisted-by: Qoder:Qwen-3.8-MAX-Preview
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/iommu/amd/ppr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/ppr.c b/drivers/iommu/amd/ppr.c
index 1f8d2823bea4..80369ca1e316 100644
--- a/drivers/iommu/amd/ppr.c
+++ b/drivers/iommu/amd/ppr.c
@@ -151,7 +151,7 @@ static void iommu_call_iopf_notifier(struct amd_iommu *iommu, u64 *raw)
 
 	/* Submit event */
 	iommu_report_device_fault(&pdev->dev, &event);
-
+	pci_dev_put(pdev);
 	return;
 
 out:
@@ -159,6 +159,7 @@ static void iommu_call_iopf_notifier(struct amd_iommu *iommu, u64 *raw)
 	amd_iommu_complete_ppr(&pdev->dev, PPR_PASID(raw[0]),
 			       IOMMU_PAGE_RESP_FAILURE,
 			       PPR_TAG(raw[0]) & 0x1FF);
+	pci_dev_put(pdev);
 }
 
 void amd_iommu_poll_ppr_log(struct amd_iommu *iommu)
-- 
2.39.3

