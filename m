Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC123815CB
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 02:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783997119; cv=none; b=Nrhoy/o8Wsuj8j9h0BxK9aUCEosg/46xZJZWmB5Z7kukCBw5nblv8C4bA8GO1fVnHMWQdsdigFGUVHP3R2sJy+C3FBFywki/exeZncIVz3KobiH9xnPSZbMCIDh8nlYNpm0Wz2Ez7HNkw/KrKGWFGimZTIIbobmMU0zIXsxn4Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783997119; c=relaxed/simple;
	bh=bI/RLZI5ieSSpy1w9a9UjxYKL6mdMMQDeZ3K0RdNQ7o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dw7uKl7cLH3u5pug1lQ0/famHa725Y1UNwCNzmMBGaRBMw50WmWaJ9OoBfUDu5cPMSzLtEezDRcqVWQlHwvH9nixf/TkXTjsefaLrK6jR+O2oG2P3m91XSftrh3DzY6/gx2Tc0+9yBPIxBbNgrkQat340IjK+kNmN0KXIaSvkIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=SlAWzHc7; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="SlAWzHc7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=ye
	O0o3YHGMSFYG7mdyIM3TH2ArtkAO+UvzTw6LiRN5Q=; b=SlAWzHc7DgtOg9KnN4
	FH6XDOJhH3TsbwZJfWwcy6PmyUsypDXZn9iGrvSa6JB0TOILQERWnZ91r3BNKtM8
	0JOeaR+2uqcArMraWlyr4q8qdBz2UGMMCgqO+BYKwFF7MCnEpxBm/raUWzfiexFb
	mmp73FM9LX5WOG845x1p30bJg=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDHpaWdolVqHLitJg--.35054S2;
	Tue, 14 Jul 2026 10:44:46 +0800 (CST)
From: weimin xiong <15927021679@163.com>
To: iommu@lists.linux.dev
Cc: joro@8bytes.org,
	suravee.suthikulpanit@amd.com,
	vasant.hegde@amd.com,
	will@kernel.org,
	robin.murphy@arm.com,
	xiongweimin <xiongweimin@kylinos.cn>
Subject: [PATCH] iommu/amd: fix grammar and typos in comments
Date: Tue, 14 Jul 2026 10:44:45 +0800
Message-ID: <20260714024445.188383-1-15927021679@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHpaWdolVqHLitJg--.35054S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFyDCF1UAFWrGr4xuF4xCrg_yoW8ur15pF
	47GrWYqFyUWF1kGa47X3y5ZFy5t397Aa4FkrWFkwsIgr1DGFyrCF95Ka4xt3s3JrZ5Ja43
	Zw1qvrsrZFnaqr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jwl19UUUUU=
X-CM-SenderInfo: jprvmjixqsilmxzbiqqrwthudrp/xtbC0h6-SGpVop6NPgAA3L

From: xiongweimin <xiongweimin@kylinos.cn>

Correct possessive "its", article before acpihid, and a couple of
mangled sentences in IOMMU flush/irq comments.

Signed-off-by: xiongweimin <xiongweimin@kylinos.cn>
---
 drivers/iommu/amd/iommu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 563f9c267..824a585df 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -456,7 +456,7 @@ static void clone_aliases(struct amd_iommu *iommu, struct device *dev)
 
 	/*
 	 * The IVRS alias stored in the alias table may not be
-	 * part of the PCI DMA aliases if it's bus differs
+	 * part of the PCI DMA aliases if its bus differs
 	 * from the original device.
 	 */
 	clone_alias(pdev, iommu->pci_seg->alias_table[pci_dev_id(pdev)], pdev);
@@ -505,7 +505,7 @@ static struct iommu_dev_data *find_dev_data(struct amd_iommu *iommu, u16 devid)
 }
 
 /*
-* Find or create an IOMMU group for a acpihid device.
+* Find or create an IOMMU group for an acpihid device.
 */
 static struct iommu_group *acpihid_device_group(struct device *dev)
 {
@@ -1268,7 +1268,7 @@ static void build_inv_dte(struct iommu_cmd *cmd, u16 devid)
 
 /*
  * Builds an invalidation address which is suitable for one page or multiple
- * pages. Sets the size bit (S) as needed is more than one page is flushed.
+ * pages. Sets the size bit (S) as needed if more than one page is flushed.
  */
 static inline u64 build_inv_address(u64 address, u64 last)
 {
@@ -3687,7 +3687,7 @@ static void fill_msi_msg(struct msi_msg *msg, u32 index)
 	/*
 	 * The struct msi_msg.dest_mode_logical is used to set the DM bit
 	 * in MSI Message Address Register. For device w/ 2K int-remap support,
-	 * this is bit must be set to 1 regardless of the actual destination
+	 * this bit must be set to 1 regardless of the actual destination
 	 * mode, which is signified by the IRTE[DM].
 	 */
 	if (FEATURE_NUM_INT_REMAP_SUP_2K(amd_iommu_efr2))
-- 
2.43.0


No virus found
		Checked by Hillstone Network AntiVirus

