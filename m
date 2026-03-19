Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53061399353
	for <iommu@lists.linux.dev>; Thu, 19 Mar 2026 07:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773905898; cv=none; b=ks35YGCTOXerlbApeuUGelClVlMQc9BZzAgV5ruXNzrvHLwL3XviNoYyanK03+P1wx+ffBxSEC2js+X64nE1Sh/b3JfxxAk78BXGoIkS8pwjDk41hJX8hBFKlMjSQiNkX+ImZhwD9ZW09JTBk34k7vP51bkbWK87TpiWDNGGW0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773905898; c=relaxed/simple;
	bh=UNeVSmO8Mgab/v1dEV/ATI5VmMcAW917v7NN5lqKJKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S0CqHEzCFE0h8HkThyRw43BespMsd94HXcUR0poB5kapqlniqw6T1VvzXQ++HqaMBGy1PFXClNsmbw6Nibgu9EXbIGn2hNQYTarq6Ze5OLHM0joAxdA6Au4eAKtF/enHTTuOmZq84Exj7MzOctWmumeuRadBwjQGicztkaj7K+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=symQzY16; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="symQzY16"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773905893; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=oPDiGtoIzm3InSMa1allZTsHpr47UCJD5YwtL801kIo=;
	b=symQzY16lzOEK4OXJrkEirGsaF2ef6Pt1MPNDWA9d9XNadPGT/MNYp8KoX25QsWRO+sAslKRT3f1BeXsEZ9K74MgUhyHD+J1WV+HCuxdlfbHc8vZskNBPEcseoJeQ8SNo8N3QqoQ6s2rhYriyVAlhbdH+Ha3M5yFp2HH5rFsFaE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0X.HbDIc_1773905893;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X.HbDIc_1773905893 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 19 Mar 2026 15:38:13 +0800
From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
To: joro@8bytes.org,
	suravee.suthikulpanit@amd.com,
	will@kernel.org,
	robin.murphy@arm.com
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	ming.shu@amd.com
Subject: [PATCH 2/2] iommu/amd: Fix illegal cap/mmio access in IOMMU debugfs
Date: Thu, 19 Mar 2026 15:37:54 +0800
Message-ID: <20260319073754.651998-3-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260319073754.651998-1-guanghuifeng@linux.alibaba.com>
References: <20260319073754.651998-1-guanghuifeng@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the current AMD IOMMU debugfs, when multiple processes simultaneously
access the IOMMU mmio/cap registers using the IOMMU debugfs, illegal
access issues can occur in the following execution flow:

1. CPU1: Sets a valid access address using iommu_mmio/capability_write,
and verifies the access address's validity in iommu_mmio/capability_show

2. CPU2: Sets an invalid address using iommu_mmio/capability_write

3. CPU1: accesses the IOMMU mmio/cap registers based on the invalid
address, resulting in an illegal access.

This patch modifies the execution process to first verify the address's
validity and then access it based on the same address, ensuring
correctness and robustness.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/iommu/amd/debugfs.c | 42 +++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/amd/debugfs.c b/drivers/iommu/amd/debugfs.c
index 0b03e0622f67..4e66473d7cea 100644
--- a/drivers/iommu/amd/debugfs.c
+++ b/drivers/iommu/amd/debugfs.c
@@ -26,22 +26,19 @@ static ssize_t iommu_mmio_write(struct file *filp, const char __user *ubuf,
 {
 	struct seq_file *m = filp->private_data;
 	struct amd_iommu *iommu = m->private;
-	int ret;
-
-	iommu->dbg_mmio_offset = -1;
+	int ret, dbg_mmio_offset = iommu->dbg_mmio_offset = -1;
 
 	if (cnt > OFS_IN_SZ)
 		return -EINVAL;
 
-	ret = kstrtou32_from_user(ubuf, cnt, 0, &iommu->dbg_mmio_offset);
+	ret = kstrtou32_from_user(ubuf, cnt, 0, &dbg_mmio_offset);
 	if (ret)
 		return ret;
 
-	if (iommu->dbg_mmio_offset > iommu->mmio_phys_end - sizeof(u64)) {
-		iommu->dbg_mmio_offset = -1;
-		return  -EINVAL;
-	}
+	if (dbg_mmio_offset > iommu->mmio_phys_end - sizeof(u64))
+		return -EINVAL;
 
+	iommu->dbg_mmio_offset = dbg_mmio_offset;
 	return cnt;
 }
 
@@ -49,14 +46,16 @@ static int iommu_mmio_show(struct seq_file *m, void *unused)
 {
 	struct amd_iommu *iommu = m->private;
 	u64 value;
+	int dbg_mmio_offset = iommu->dbg_mmio_offset;
 
-	if (iommu->dbg_mmio_offset < 0) {
+	if (dbg_mmio_offset < 0 || dbg_mmio_offset >
+			iommu->mmio_phys_end - sizeof(u64)) {
 		seq_puts(m, "Please provide mmio register's offset\n");
 		return 0;
 	}
 
-	value = readq(iommu->mmio_base + iommu->dbg_mmio_offset);
-	seq_printf(m, "Offset:0x%x Value:0x%016llx\n", iommu->dbg_mmio_offset, value);
+	value = readq(iommu->mmio_base + dbg_mmio_offset);
+	seq_printf(m, "Offset:0x%x Value:0x%016llx\n", dbg_mmio_offset, value);
 
 	return 0;
 }
@@ -67,23 +66,20 @@ static ssize_t iommu_capability_write(struct file *filp, const char __user *ubuf
 {
 	struct seq_file *m = filp->private_data;
 	struct amd_iommu *iommu = m->private;
-	int ret;
-
-	iommu->dbg_cap_offset = -1;
+	int ret, dbg_cap_offset = iommu->dbg_cap_offset = -1;
 
 	if (cnt > OFS_IN_SZ)
 		return -EINVAL;
 
-	ret = kstrtou32_from_user(ubuf, cnt, 0, &iommu->dbg_cap_offset);
+	ret = kstrtou32_from_user(ubuf, cnt, 0, &dbg_cap_offset);
 	if (ret)
 		return ret;
 
 	/* Capability register at offset 0x14 is the last IOMMU capability register. */
-	if (iommu->dbg_cap_offset > 0x14) {
-		iommu->dbg_cap_offset = -1;
+	if (dbg_cap_offset > 0x14)
 		return -EINVAL;
-	}
 
+	iommu->dbg_cap_offset = dbg_cap_offset;
 	return cnt;
 }
 
@@ -91,21 +87,21 @@ static int iommu_capability_show(struct seq_file *m, void *unused)
 {
 	struct amd_iommu *iommu = m->private;
 	u32 value;
-	int err;
+	int err, dbg_cap_offset = iommu->dbg_cap_offset;
 
-	if (iommu->dbg_cap_offset < 0) {
+	if (dbg_cap_offset < 0 || dbg_cap_offset > 0x14) {
 		seq_puts(m, "Please provide capability register's offset in the range [0x00 - 0x14]\n");
 		return 0;
 	}
 
-	err = pci_read_config_dword(iommu->dev, iommu->cap_ptr + iommu->dbg_cap_offset, &value);
+	err = pci_read_config_dword(iommu->dev, iommu->cap_ptr + dbg_cap_offset, &value);
 	if (err) {
 		seq_printf(m, "Not able to read capability register at 0x%x\n",
-			   iommu->dbg_cap_offset);
+			   dbg_cap_offset);
 		return 0;
 	}
 
-	seq_printf(m, "Offset:0x%x Value:0x%08x\n", iommu->dbg_cap_offset, value);
+	seq_printf(m, "Offset:0x%x Value:0x%08x\n", dbg_cap_offset, value);
 
 	return 0;
 }
-- 
2.43.7

