Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A353D35677E
	for <iommu@lists.linux.dev>; Sun, 31 May 2026 09:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780220222; cv=none; b=pAZt31S/I9A4nHU4lcRmklNdCv/CgesAkWfaVRgoGAvQ2HkeWCD7Q7ThfRN6LzgLiElQzw6qj5lp5UuRyA4nLO/j4V8F9LbJM4SImabroDh5Or6ZJuH6Mr7AOBU6UsD9m+FWszsENV6bAte14pCC/cd/fLXLLb36/KEyCwx8JqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780220222; c=relaxed/simple;
	bh=pKmgUI48sTB5iHvAnPZ7bLYJ+0ijpTEuXSqdVUx5LiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TrXJZ1+s+LWcRMV3tZ/Dovk0KIo5PJFY/s53bqTCv4X8aKDc//c4zdF8uOBCMWdibV/2mhtSI4YyJeo+GlE0AVEuSWbsGwHgatuaYyHpGvA8S46wCoIgC5XfLH2Jln+qDv1NnYQVABvboViW0aNPgRQrvXmyxZna4m+FiywON/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YLiQQQac; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YLiQQQac"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780220217; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=RpB/ofZVI8aYfi4QDy17DKJQX9fsUwx+3+WYjwsW/4E=;
	b=YLiQQQacHXyjwkvKe4+Og+po2eZ1293UunyFYQWtuqPOersDZHMUL/Vwoa2oWkSIUQ6awoFpefjDMggV6D1MpzLHEOELRoRSMJoKx67xBZNX6JmGNMvsF6I58GjG73M6Wf4cPi9qI4WmCIPv7bxX/Y5dRFrUABC7RTA0TYm12Vs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=27;SR=0;TI=SMTPD_---0X3tRVr2_1780220214;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X3tRVr2_1780220214 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 31 May 2026 17:36:54 +0800
From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
To: boris.brezillon@collabora.com,
	robh@kernel.org,
	steven.price@arm.com,
	adrian.larumbe@collabora.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	liviu.dudau@arm.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	alex@shazbot.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com,
	suravee.suthikulpanit@amd.com,
	dwmw2@infradead.org
Cc: xlpang@linux.alibaba.com,
	oliver.yang@linux.alibaba.com,
	shiyu.zsq@linux.alibaba.com,
	wei.guo.simon@linux.alibaba.com
Subject: [PATCH 8/9] drm/gpu, iommu/io-pgtable: switch to iova_to_phys_length
Date: Sun, 31 May 2026 17:36:36 +0800
Message-ID: <20260531093637.3893199-9-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260531093637.3893199-1-guanghuifeng@linux.alibaba.com>
References: <20260529115116.GR2487554@ziepe.ca>
 <20260531093637.3893199-1-guanghuifeng@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Migrate remaining callers of io_pgtable_ops.iova_to_phys:
- panthor_mmu: use ops->iova_to_phys_length(ops, iova, NULL)
- panfrost_mmu: same
- io-pgtable selftests: use iova_to_phys_length with NULL

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Acked-by: Shiqiang Zhang <shiyu.zsq@linux.alibaba.com>
Acked-by: Simon Guo <wei.guo.simon@linux.alibaba.com>
---
 drivers/gpu/drm/panfrost/panfrost_mmu.c  |  2 +-
 drivers/gpu/drm/panthor/panthor_mmu.c    |  2 +-
 drivers/iommu/io-pgtable-arm-selftests.c | 12 ++++++------
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index 4a3162c3b659..b7c420eb76ec 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -514,7 +514,7 @@ void panfrost_mmu_unmap(struct panfrost_gem_mapping *mapping)
 
 		if (bo->is_heap)
 			pgcount = 1;
-		if (!bo->is_heap || ops->iova_to_phys(ops, iova)) {
+		if (!bo->is_heap || ops->iova_to_phys_length(ops, iova, NULL)) {
 			unmapped_page = ops->unmap_pages(ops, iova, pgsize, pgcount, NULL);
 			WARN_ON(unmapped_page != pgsize * pgcount);
 		}
diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 75d98dad7b1d..05bc7ec95931 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -903,7 +903,7 @@ static void panthor_vm_unmap_pages(struct panthor_vm *vm, u64 iova, u64 size)
 			 * are out-of-sync. This is not supposed to happen, hence the
 			 * above WARN_ON().
 			 */
-			while (!ops->iova_to_phys(ops, iova + unmapped_sz) &&
+			while (!ops->iova_to_phys_length(ops, iova + unmapped_sz, NULL) &&
 			       unmapped_sz < pgsize * pgcount)
 				unmapped_sz += SZ_4K;
 
diff --git a/drivers/iommu/io-pgtable-arm-selftests.c b/drivers/iommu/io-pgtable-arm-selftests.c
index 334e70350924..d1d0529f711d 100644
--- a/drivers/iommu/io-pgtable-arm-selftests.c
+++ b/drivers/iommu/io-pgtable-arm-selftests.c
@@ -72,13 +72,13 @@ static int arm_lpae_run_tests(struct kunit *test, struct io_pgtable_cfg *cfg)
 		 * Initial sanity checks.
 		 * Empty page tables shouldn't provide any translations.
 		 */
-		if (ops->iova_to_phys(ops, 42))
+		if (ops->iova_to_phys_length(ops, 42, NULL))
 			return __FAIL(test, i);
 
-		if (ops->iova_to_phys(ops, SZ_1G + 42))
+		if (ops->iova_to_phys_length(ops, SZ_1G + 42, NULL))
 			return __FAIL(test, i);
 
-		if (ops->iova_to_phys(ops, SZ_2G + 42))
+		if (ops->iova_to_phys_length(ops, SZ_2G + 42, NULL))
 			return __FAIL(test, i);
 
 		/*
@@ -100,7 +100,7 @@ static int arm_lpae_run_tests(struct kunit *test, struct io_pgtable_cfg *cfg)
 					    GFP_KERNEL, &mapped))
 				return __FAIL(test, i);
 
-			if (ops->iova_to_phys(ops, iova + 42) != (iova + 42))
+			if (ops->iova_to_phys_length(ops, iova + 42, NULL) != (iova + 42))
 				return __FAIL(test, i);
 
 			iova += SZ_1G;
@@ -114,7 +114,7 @@ static int arm_lpae_run_tests(struct kunit *test, struct io_pgtable_cfg *cfg)
 			if (ops->unmap_pages(ops, iova, size, 1, NULL) != size)
 				return __FAIL(test, i);
 
-			if (ops->iova_to_phys(ops, iova + 42))
+			if (ops->iova_to_phys_length(ops, iova + 42, NULL))
 				return __FAIL(test, i);
 
 			/* Remap full block */
@@ -122,7 +122,7 @@ static int arm_lpae_run_tests(struct kunit *test, struct io_pgtable_cfg *cfg)
 					   IOMMU_WRITE, GFP_KERNEL, &mapped))
 				return __FAIL(test, i);
 
-			if (ops->iova_to_phys(ops, iova + 42) != (iova + 42))
+			if (ops->iova_to_phys_length(ops, iova + 42, NULL) != (iova + 42))
 				return __FAIL(test, i);
 
 			iova += SZ_1G;
-- 
2.43.7

