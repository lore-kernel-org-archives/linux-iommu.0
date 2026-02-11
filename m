Received: from outbound.baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038D026F288
	for <iommu@lists.linux.dev>; Wed, 11 Feb 2026 03:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770782376; cv=none; b=ePzGvDOuFHroifkwzWl4VRG5nB1jbeBrf9ds6Uw5wofbPtpRco+2YLFdjLl7rqwVW6c/N4t77Rz6No+rbkANZoq03yZljDQp1foWcm4CvjR+oVOtBHBwccMJHC6f8C0JZpZTkMLOh0tEbMBezUOTHmY/mZj6E8O1eHBIgv1mAxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770782376; c=relaxed/simple;
	bh=T3EHwisaN29K6tSBJMpUEWqvevQc4pDn691tjJXoyEU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Eg4UxOBUHYvEC9Sdee/2eEE6NtjCHLDPf1xswx4XrJwUtS8UMKqyf1Gcp3JIZrUrBO+951CKs/DpBb2T4nC2MzDHBMhGQYe5UqWjmUobQYBNRT3XFlKEzUBuFUVFta4fdpJhWOiUfPqMLJX/eoWId/0gTM4R2a2XM8AHC11KNCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: lirongqing <lirongqing@baidu.com>
To: Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] iommu/amd: Add NUMA node affinity for IOMMU log buffers
Date: Tue, 10 Feb 2026 22:58:39 -0500
Message-ID: <20260211035839.1970-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc6.internal.baidu.com (172.31.3.16) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
X-FEAS-Client-IP: 172.31.50.47
X-FE-Policy-ID: 52:10:53:SYSTEM

From: Li RongQing <lirongqing@baidu.com>

Currently, PPR Log and GA logs for AMD IOMMU are allocated using
iommu_alloc_pages_sz(), which does not account for NUMA affinity. This can
lead to remote memory access latencies if the memory is allocated on a
different node than the IOMMU hardware.

Switch to iommu_alloc_pages_node_sz() to ensure that these data structures
are allocated on the same NUMA node as the IOMMU device. If the node
information is unavailable, it defaults to NUMA_NO_NODE.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/iommu/amd/init.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 384c90b..721d9d0 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -851,10 +851,11 @@ static void __init free_command_buffer(struct amd_iommu *iommu)
 void *__init iommu_alloc_4k_pages(struct amd_iommu *iommu, gfp_t gfp,
 				  size_t size)
 {
+	int nid = iommu->dev ? dev_to_node(&iommu->dev->dev) : NUMA_NO_NODE;
 	void *buf;
 
 	size = PAGE_ALIGN(size);
-	buf = iommu_alloc_pages_sz(gfp, size);
+	buf = iommu_alloc_pages_node_sz(nid, gfp, size);
 	if (!buf)
 		return NULL;
 	if (check_feature(FEATURE_SNP) &&
@@ -957,14 +958,16 @@ static int iommu_ga_log_enable(struct amd_iommu *iommu)
 
 static int iommu_init_ga_log(struct amd_iommu *iommu)
 {
+	int nid = iommu->dev ? dev_to_node(&iommu->dev->dev) : NUMA_NO_NODE;
+
 	if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir))
 		return 0;
 
-	iommu->ga_log = iommu_alloc_pages_sz(GFP_KERNEL, GA_LOG_SIZE);
+	iommu->ga_log = iommu_alloc_pages_node_sz(nid, GFP_KERNEL, GA_LOG_SIZE);
 	if (!iommu->ga_log)
 		goto err_out;
 
-	iommu->ga_log_tail = iommu_alloc_pages_sz(GFP_KERNEL, 8);
+	iommu->ga_log_tail = iommu_alloc_pages_node_sz(nid, GFP_KERNEL, 8);
 	if (!iommu->ga_log_tail)
 		goto err_out;
 
-- 
2.9.4

