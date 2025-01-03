Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348112629C
	for <iommu@lists.linux.dev>; Fri,  3 Jan 2025 16:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735923519; cv=none; b=oxMfVyaQkW0PTlSZc7wbA+dx7wZ7+l+J82uo5wABNAczTIPxkIqaB535FML5Iv8V7FHcaJODRaHkzOr53XT9u7YN9DI2YGZgC39SW6TxCS7EXawDO8hHVovIzmCsl2x6dr7gThUJXG7wYxNc+lGSqLGLRTNX78FDkIXIe0xhh8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735923519; c=relaxed/simple;
	bh=MKohgh1fouvUCESBH55E/BaW0RRckya6u9YugS73dEE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gsu1kuLUE7JH10XStzpu3g09fq5SIIbBbvtJ14jOXZUs3UUhQDVNEiP4AbMFwtZx6qFnjUH6+wiEGrJdIKcLzftcvxjbEtQ2HlRZNpvW9VL6OlmEiml236WTK4zWgsGfsS2sWs2wNGP0lvkGoiCX0uhRFV5X+cchwUT0u6kr6Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: Gao Shiyuan <gaoshiyuan@baidu.com>
To: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <christophe.jaillet@wanadoo.fr>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<gaoshiyuan@baidu.com>
Subject: [PATCH v2 1/1] iommu/amd: remove return value of amd_iommu_detect
Date: Sat, 4 Jan 2025 00:58:08 +0800
Message-ID: <20250103165808.80939-1-gaoshiyuan@baidu.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BC-Mail-EX04.internal.baidu.com (172.31.51.44) To
 bjkjy-mail-ex26.internal.baidu.com (172.31.50.42)
X-FEAS-Client-IP: 10.127.64.17
X-FE-Policy-ID: 52:10:53:SYSTEM

The return value of amd_iommu_detect is not used, so remove it and
is consistent with other iommu detect functions.

Signed-off-by: Gao Shiyuan <gaoshiyuan@baidu.com>
---
 drivers/iommu/amd/init.c  | 10 ++++------
 include/linux/amd-iommu.h |  4 ++--
 2 files changed, 6 insertions(+), 8 deletions(-)

v1 -> v2:
* Remove return; at the end of amd_iommu_detect

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 0e0a531042ac..bc419d3b7c1e 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3398,25 +3398,23 @@ static bool amd_iommu_sme_check(void)
  * IOMMUs
  *
  ****************************************************************************/
-int __init amd_iommu_detect(void)
+void __init amd_iommu_detect(void)
 {
 	int ret;
 
 	if (no_iommu || (iommu_detected && !gart_iommu_aperture))
-		return -ENODEV;
+		return;
 
 	if (!amd_iommu_sme_check())
-		return -ENODEV;
+		return;
 
 	ret = iommu_go_to_state(IOMMU_IVRS_DETECTED);
 	if (ret)
-		return ret;
+		return;
 
 	amd_iommu_detected = true;
 	iommu_detected = 1;
 	x86_init.iommu.iommu_init = amd_iommu_init;
-
-	return 1;
 }
 
 /****************************************************************************
diff --git a/include/linux/amd-iommu.h b/include/linux/amd-iommu.h
index 2b90c48a6a87..062fbd4c9b77 100644
--- a/include/linux/amd-iommu.h
+++ b/include/linux/amd-iommu.h
@@ -31,11 +31,11 @@ struct amd_iommu_pi_data {
 struct task_struct;
 struct pci_dev;
 
-extern int amd_iommu_detect(void);
+extern void amd_iommu_detect(void);
 
 #else /* CONFIG_AMD_IOMMU */
 
-static inline int amd_iommu_detect(void) { return -ENODEV; }
+static inline void amd_iommu_detect(void) { }
 
 #endif /* CONFIG_AMD_IOMMU */
 
-- 
2.39.3 (Apple Git-146)

