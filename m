Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20AC1272B7
	for <iommu@lists.linux.dev>; Thu, 25 Apr 2024 10:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714040307; cv=none; b=a2PtgqMCvpd8W1igsVC1Eu9bR7VwFmLpLgoGDGWzV4FfLLn8wU74vqMrpDEqOK4Gx4Y1XvZZcR6vHmYm9PjWYqJW8ZQ5QVh8u4yffctA32zTobXBIDNOtYRJiPi5wRXz/r5jIrelwkw4svFYSk55psT87U+ghvZLGLzFNx1Gr+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714040307; c=relaxed/simple;
	bh=qpx9spVeO8CkWFjQ72oQekACDvn3i/PHgcVhhu25UTc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c/QgYCxBrLcUEg6Fa5CU97+9D4cDvEPUVVKgnh/hZD3S9ZL7tZjDQ5ovAmgxdvKMJJARZsPYDh5Tqzi2Qi9ZwQYw+mfdxsZJhSo+YfHeVLtZ3I3xswudi9aRTuYWQKMloYcXtmkNHbKDGVtpnjnFH0Cf3tM5iUDRWn027kJaSOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gXoWfZaL; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gXoWfZaL"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714040297; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=QcCGmMZke9wNUqDSX//NGSJSaxDB+PepcH2WxN5WEqo=;
	b=gXoWfZaLXRG3rQuUUH2JZfgR0/KI3yErqZFobq5FlEzG/5yJc+IgspoH7ffIyY5iCX/tdxEl4+e5wItSbJhZ80PV3g55HsZxYXUhZ2sn5FFX6IOiinl/UATbu3YNA9tN1YxJmaF7tvaCejq1ssD5rrfmVadx/YgMnQxuLAZLMlo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R461e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=llfl@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W5F8.U6_1714040295;
Received: from localhost(mailfrom:llfl@linux.alibaba.com fp:SMTPD_---0W5F8.U6_1714040295)
          by smtp.aliyun-inc.com;
          Thu, 25 Apr 2024 18:18:16 +0800
From: "Kun(llfl)" <llfl@linux.alibaba.com>
To: Joerg Roedel <joro@8bytes.org>,
	Vasant Hegde <vasant.hegde@amd.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] iommu/amd: Fix memory leak in alloc_pci_segment()
Date: Thu, 25 Apr 2024 18:17:20 +0800
Message-ID: <a06d50c3a82214a82ccb88c22aa4e4a1d595b39c.1714040214.git.llfl@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the memory leak issue that occurs when resource allocation fails in
alloc_pci_segment(). The dev_table, alias_table, and rlookup_table were
introduced individually in three commits. But they all fail to release
allocated resources when other allocations fail.

Fixes: 04230c119930 ("iommu/amd: Introduce per PCI segment device table")
Fixes: 99fc4ac3d297 ("iommu/amd: Introduce per PCI segment alias_table"),
Fixes: eda797a27795 ("iommu/amd: Introduce per PCI segment rlookup table").
Reported-by: Xuchun Shang <xuchun.shang@linux.alibaba.com>
Signed-off-by: Kun(llfl) <llfl@linux.alibaba.com>
---
 drivers/iommu/amd/init.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index ac6754a85f35..4ce567f39473 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1642,13 +1642,22 @@ static struct amd_iommu_pci_seg *__init alloc_pci_segment(u16 id,
 	list_add_tail(&pci_seg->list, &amd_iommu_pci_seg_list);
 
 	if (alloc_dev_table(pci_seg))
-		return NULL;
+		goto alloc_dev_fail;
 	if (alloc_alias_table(pci_seg))
-		return NULL;
+		goto alloc_alias_fail;
 	if (alloc_rlookup_table(pci_seg))
-		return NULL;
+		goto alloc_rlookup_fail;
 
 	return pci_seg;
+
+alloc_rlookup_fail:
+	free_rlookup_table(pci_seg);
+alloc_alias_fail:
+	free_alias_table(pci_seg);
+alloc_dev_fail:
+	free_dev_table(pci_seg);
+	kfree(pci_seg);
+	return NULL;
 }
 
 static struct amd_iommu_pci_seg *__init get_pci_segment(u16 id,
-- 
2.43.0

