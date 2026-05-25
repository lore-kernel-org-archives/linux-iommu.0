Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5068622D781
	for <iommu@lists.linux.dev>; Mon, 25 May 2026 03:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779680896; cv=none; b=REtikbxFmvQ6AEXdCb9mdbZ9bCaEyVKNkM9Q0sAXm7qcLnYyg1ZFCBvVXHsJCvobB/QcwshUteHT2AIEn88QJM0/f1LoK+YwU/XIb5jMkWqYqQXCxc2qHzmYxe9IxYALjooRu7hdDb/SZMthEecnxWTa/2cIauRpME/BK11DSyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779680896; c=relaxed/simple;
	bh=TAOhXlHXz6ihP3yFKICFEHPF0JGvkVzEFhfh4t8MaUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KA1N72gU9rkx/aC5P1kR9pUqUHZgWvi1GDCNrgPZZgTFUvVXmk9ShNMSVD2zXyL6mQTtITM2h/lmLFfXJjpze/shNg4uoWAacJkwL6OF6MEji3c9vXu2/Wa3vOodEc5piZ6y32iPbtt5/q+Bj71mpaPLp40x28FzltQw9oJz9Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ENmeF6cA; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ENmeF6cA"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779680885; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=LzYDX8FRhSqO0nYS8B6zvb4SGlG2cwar8vVaCKz3SDA=;
	b=ENmeF6cA7ERw1yvB2suEt5GPhjbfswA+bzRttAOEv+5PXYv9/7o9Ltp6Ztt6sKMutzWqLHYn08nNHEogw6b0ihVZrwwkB+jGrISoteptOWFRC08OqbtW6hiRWTej0EqS0jOfxqHaXfzcthDHvHchJe8+FIxydNt2lWALxZ+2Kz4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0X3U4bE3_1779680875;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X3U4bE3_1779680875 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 25 May 2026 11:48:04 +0800
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
Subject: [PATCH] iommu/vt-d: improve IOMMU fault information
Date: Mon, 25 May 2026 11:47:55 +0800
Message-ID: <20260525034755.3645658-1-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
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
 drivers/iommu/intel/dmar.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index d33c119a935e..ca9afbb55e76 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1894,7 +1894,8 @@ static int dmar_fault_do_one(struct intel_iommu *iommu, int type,
 	reason = dmar_get_fault_reason(fault_reason, &fault_type);
 
 	if (fault_type == INTR_REMAP) {
-		pr_err("[INTR-REMAP] Request device [%02x:%02x.%d] fault index 0x%llx [fault reason 0x%02x] %s\n",
+		pr_err("[DMAR:%s] [INTR-REMAP] Request device [%04x:%02x:%02x.%d] fault index 0x%llx [fault reason 0x%02x] %s\n",
+		       iommu->name, iommu->segment,
 		       source_id >> 8, PCI_SLOT(source_id & 0xFF),
 		       PCI_FUNC(source_id & 0xFF), addr >> 48,
 		       fault_reason, reason);
@@ -1903,14 +1904,18 @@ static int dmar_fault_do_one(struct intel_iommu *iommu, int type,
 	}
 
 	if (pasid == IOMMU_PASID_INVALID)
-		pr_err("[%s NO_PASID] Request device [%02x:%02x.%d] fault addr 0x%llx [fault reason 0x%02x] %s\n",
+		pr_err("[DMAR:%s] [%s NO_PASID] Request device [%04x:%02x:%02x.%d] fault addr 0x%llx [fault reason 0x%02x] %s\n",
+		       iommu->name,
 		       type ? "DMA Read" : "DMA Write",
+		       iommu->segment,
 		       source_id >> 8, PCI_SLOT(source_id & 0xFF),
 		       PCI_FUNC(source_id & 0xFF), addr,
 		       fault_reason, reason);
 	else
-		pr_err("[%s PASID 0x%x] Request device [%02x:%02x.%d] fault addr 0x%llx [fault reason 0x%02x] %s\n",
+		pr_err("[DMAR:%s] [%s PASID 0x%x] Request device [%04x:%02x:%02x.%d] fault addr 0x%llx [fault reason 0x%02x] %s\n",
+		       iommu->name,
 		       type ? "DMA Read" : "DMA Write", pasid,
+		       iommu->segment,
 		       source_id >> 8, PCI_SLOT(source_id & 0xFF),
 		       PCI_FUNC(source_id & 0xFF), addr,
 		       fault_reason, reason);
-- 
2.43.7

