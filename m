Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191252F6565
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 02:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779935402; cv=none; b=jKALthsHQp9Tl0SUd9y2BNVDoiBtEiWSynRMbHeDLFJ4PPMeh+/ghaSSJJVIpW+ZkFAjMmeXjJIehBAFazDAUURsXd85XentxPf4iQ6P8F//26LbE2Pqw4p9FYLiybrHF2BNP7cUCVJL2FBED4Z7zj6/pIMSWkeupKBxpa43qz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779935402; c=relaxed/simple;
	bh=ygcRaXlb49jR0zxtMi9N2zyqcAIAzqJCLyn+bWo7K8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U6cNt/jybtctj5nONHZgAxGh5hFCBOU5MBGo9h9Fs5I8MW8H94DgBcqmzbOfoc2qzRPOuTIeFHh6N/0cSyiYdI7rrwCGLebdL7BnD6dXvzLckHmaqEkNNr0AU8uu60JhCqJ+BVt1P6NRRgmrCXkeLjO3tzsTT9MVLwYK/Q5sLwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kQI+JDbm; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kQI+JDbm"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779935395; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Xq9xeA3g32akOr+r1BH7kHCidZV0dALaaTLolW7zqCM=;
	b=kQI+JDbmVs1I6amJBBx1pFobTOSEfcmi+H1uDsgLjQmcHUyNSw4vAo1WFBFF04lZ8ncsFdojdV/dqDdXLQzMGFgEC/NPkhy90ub7VoDBygUGlF2TdILNGAfWzFNRSzjlAwN27e0m7MCsWJt4y8fnmr/ERqBa5wKnY3CretLAccM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0X3l1YsG_1779935383;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X3l1YsG_1779935383 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 28 May 2026 10:29:53 +0800
From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
To: dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: xlpang@linux.alibaba.com,
	oliver.yang@linux.alibaba.com
Subject: [PATCH v2] iommu/vt-d: improve IOMMU fault information
Date: Thu, 28 May 2026 10:29:43 +0800
Message-ID: <20260528022943.1697564-1-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <4adaa6b9-6dc0-4d78-8eeb-dbe9059e76a8@linux.alibaba.com>
References: <4adaa6b9-6dc0-4d78-8eeb-dbe9059e76a8@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In some environments, multiple PCIe segments exist, and PCIe device
information needs to be differentiated and identified based on the
segment. When an IOMMU fault event occurs, the IOMMU and device segment
information should be output in detail in dmar_fault_do_one.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/iommu/intel/dmar.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index d33c119a935e..767ec092accd 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1894,7 +1894,8 @@ static int dmar_fault_do_one(struct intel_iommu *iommu, int type,
 	reason = dmar_get_fault_reason(fault_reason, &fault_type);
 
 	if (fault_type == INTR_REMAP) {
-		pr_err("[INTR-REMAP] Request device [%02x:%02x.%d] fault index 0x%llx [fault reason 0x%02x] %s\n",
+		pr_err("[INTR-REMAP] Request device [%04x:%02x:%02x.%d] fault index 0x%llx [fault reason 0x%02x] %s\n",
+		       iommu->segment,
 		       source_id >> 8, PCI_SLOT(source_id & 0xFF),
 		       PCI_FUNC(source_id & 0xFF), addr >> 48,
 		       fault_reason, reason);
@@ -1903,14 +1904,16 @@ static int dmar_fault_do_one(struct intel_iommu *iommu, int type,
 	}
 
 	if (pasid == IOMMU_PASID_INVALID)
-		pr_err("[%s NO_PASID] Request device [%02x:%02x.%d] fault addr 0x%llx [fault reason 0x%02x] %s\n",
+		pr_err("[%s NO_PASID] Request device [%04x:%02x:%02x.%d] fault addr 0x%llx [fault reason 0x%02x] %s\n",
 		       type ? "DMA Read" : "DMA Write",
+		       iommu->segment,
 		       source_id >> 8, PCI_SLOT(source_id & 0xFF),
 		       PCI_FUNC(source_id & 0xFF), addr,
 		       fault_reason, reason);
 	else
-		pr_err("[%s PASID 0x%x] Request device [%02x:%02x.%d] fault addr 0x%llx [fault reason 0x%02x] %s\n",
+		pr_err("[%s PASID 0x%x] Request device [%04x:%02x:%02x.%d] fault addr 0x%llx [fault reason 0x%02x] %s\n",
 		       type ? "DMA Read" : "DMA Write", pasid,
+		       iommu->segment,
 		       source_id >> 8, PCI_SLOT(source_id & 0xFF),
 		       PCI_FUNC(source_id & 0xFF), addr,
 		       fault_reason, reason);
-- 
2.43.7

