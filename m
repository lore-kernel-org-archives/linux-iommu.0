Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADEE3A3E61
	for <iommu@lists.linux.dev>; Thu, 19 Mar 2026 07:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773905902; cv=none; b=MOFtfln1jHPq4B2vYVNb5lm0Wu7WJUUbWc/9p/OT4RlvNtFR4xL3NHphtAfhdOUTeZFoNVbyZafKH/ydMIQYbh8xwt1FJN9o7EOLMviiqrqmxwxq+08Y9QsZ/wbSJjRyS85vLVvnWmO2nksuVblFm0YP4faUN+Qb6/UjSVKSgv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773905902; c=relaxed/simple;
	bh=A+0Ub8LK2Sro9xETxnNcenTrLDH/r/59z4r1kDVVZBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qW/j6pBO5gWqhb4L/M/2xgW/6VjImyYtmHxpGgMMv24qBtobSbQLcN3UeAdFHgPNJm8UCisMclj7XHZri+m3sqrxR/qvStGSdAbvfYAoohKtgbM4SVLrJX+Q0cJK/OMag5gfwgPBQjoyvY3eufbsGzZSU0893Ac+s4ANSsIZL1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jESFlCKt; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jESFlCKt"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773905893; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=QKEW3Jbfg2XYZKXRGBvGg0e5m1rDToi+MBji5wzT9iY=;
	b=jESFlCKtdbDFZUoE4T/xlFXozxNyd5DpBrDOBz3vhpT4XVJUSyzr8OZEAc76dlJvYE+6s/DLn0maPWK5oajvkOezhMVdNSP5eX7PRd3v7N1BtN8Cu7GdX0L63/sJHbnN6EjC1mKDPT1D4NOT4yRlWPpJg4uxx4gskD/BxljXYEg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0X.HbDIW_1773905892;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X.HbDIW_1773905892 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 19 Mar 2026 15:38:12 +0800
From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
To: joro@8bytes.org,
	suravee.suthikulpanit@amd.com,
	will@kernel.org,
	robin.murphy@arm.com
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	ming.shu@amd.com
Subject: [PATCH 1/2] iommu/amd: Fix illegal device-id access in IOMMU debugfs
Date: Thu, 19 Mar 2026 15:37:53 +0800
Message-ID: <20260319073754.651998-2-guanghuifeng@linux.alibaba.com>
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

In the current AMD IOMMU debugFS, when multiple processes use the IOMMU
debugFS process simultaneously, illegal access issues can occur in the
following execution flow:

1. CPU1: Sets a valid sbdf via devid_write, then checks the sbdf's
validity in execution flows such as devid_show, iommu_devtbl_show,
and iommu_irqtbl_show.

2. CPU2: Sets an invalid sbdf via devid_write, at which point the sbdf
value is -1.

3. CPU1: accesses the IOMMU device table, IRQ table, based on the
invalid SBDF value of -1, resulting in illegal access.

This is especially problematic in monitoring scripts, where multiple
scripts may access debugFS simultaneously, and some scripts may
unexpectedly set invalid values, which triggers illegal access in
debugfs.

This patch modifies the execution flow of devid_show,
iommu_devtbl_show, and iommu_irqtbl_show to ensure that these
processes determine the validity and access based on the
same device-id, thus guaranteeing correctness and robustness.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/iommu/amd/debugfs.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/amd/debugfs.c b/drivers/iommu/amd/debugfs.c
index 20b04996441d..0b03e0622f67 100644
--- a/drivers/iommu/amd/debugfs.c
+++ b/drivers/iommu/amd/debugfs.c
@@ -197,10 +197,11 @@ static ssize_t devid_write(struct file *filp, const char __user *ubuf,
 static int devid_show(struct seq_file *m, void *unused)
 {
 	u16 devid;
+	int sbdf_shadow = sbdf;
 
-	if (sbdf >= 0) {
-		devid = PCI_SBDF_TO_DEVID(sbdf);
-		seq_printf(m, "%04x:%02x:%02x.%x\n", PCI_SBDF_TO_SEGID(sbdf),
+	if (sbdf_shadow >= 0) {
+		devid = PCI_SBDF_TO_DEVID(sbdf_shadow);
+		seq_printf(m, "%04x:%02x:%02x.%x\n", PCI_SBDF_TO_SEGID(sbdf_shadow),
 			   PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid));
 	} else
 		seq_puts(m, "No or Invalid input provided\n");
@@ -237,13 +238,14 @@ static int iommu_devtbl_show(struct seq_file *m, void *unused)
 {
 	struct amd_iommu_pci_seg *pci_seg;
 	u16 seg, devid;
+	int sbdf_shadow = sbdf;
 
-	if (sbdf < 0) {
+	if (sbdf_shadow < 0) {
 		seq_puts(m, "Enter a valid device ID to 'devid' file\n");
 		return 0;
 	}
-	seg = PCI_SBDF_TO_SEGID(sbdf);
-	devid = PCI_SBDF_TO_DEVID(sbdf);
+	seg = PCI_SBDF_TO_SEGID(sbdf_shadow);
+	devid = PCI_SBDF_TO_DEVID(sbdf_shadow);
 
 	for_each_pci_segment(pci_seg) {
 		if (pci_seg->id != seg)
@@ -336,19 +338,20 @@ static int iommu_irqtbl_show(struct seq_file *m, void *unused)
 {
 	struct amd_iommu_pci_seg *pci_seg;
 	u16 devid, seg;
+	int sbdf_shadow = sbdf;
 
 	if (!irq_remapping_enabled) {
 		seq_puts(m, "Interrupt remapping is disabled\n");
 		return 0;
 	}
 
-	if (sbdf < 0) {
+	if (sbdf_shadow < 0) {
 		seq_puts(m, "Enter a valid device ID to 'devid' file\n");
 		return 0;
 	}
 
-	seg = PCI_SBDF_TO_SEGID(sbdf);
-	devid = PCI_SBDF_TO_DEVID(sbdf);
+	seg = PCI_SBDF_TO_SEGID(sbdf_shadow);
+	devid = PCI_SBDF_TO_DEVID(sbdf_shadow);
 
 	for_each_pci_segment(pci_seg) {
 		if (pci_seg->id != seg)
-- 
2.43.7

