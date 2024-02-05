Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B3640C1B
	for <iommu@lists.linux.dev>; Mon,  5 Feb 2024 15:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707147176; cv=none; b=pktb5WeCvAnGIOc0E0gvc1Bb3gfFDLkDvAS2/lslKfjBc+Hy7h89mjinBa6v7StwEaMUTiFXlxWfQvOvEYzXTtVGFXxwZaoRyJJRIOotbgl7eu0ElMVwPqkzOF56rA8ptwMt/5RYHrncHFOH3OGpjH857P74M+KDPKAxrPcVFVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707147176; c=relaxed/simple;
	bh=gp8tv3IVxGAchewnqQ11OPRI0Ycp1XlYtKMxh98HcZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eVx+9EWLYqWbDMwnjNXeKIgievuZjdN5QX8K6p3kYRdSZT+oEY/WFXY2bud325JtrQtKkGNY/rBIGp4c4+0BbJz+L/QcrcCmrsObAKPNMeQ5BwUjUQ4vBt9Cej2o3xvy8g67IVcr9n72YSU9ezhnLOF9X3r4/Z/ZugM2yVh65ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14C211FB;
	Mon,  5 Feb 2024 07:33:36 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 483403F5A1;
	Mon,  5 Feb 2024 07:32:52 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org
Cc: will@kernel.org,
	pasha.tatashin@soleen.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	rientjes@google.com,
	yosryahmed@google.com,
	john.g.garry@oracle.com
Subject: [PATCH v3 3/3] iommu/iova: use named kmem_cache for iova magazines
Date: Mon,  5 Feb 2024 15:32:41 +0000
Message-Id: <dc5c51aaba50906a92b9ba1a5137ed462484a7be.1707144953.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1707144953.git.robin.murphy@arm.com>
References: <cover.1707144953.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pasha Tatashin <pasha.tatashin@soleen.com>

The magazine buffers can take gigabytes of kmem memory, dominating all
other allocations. For observability purpose create named slab cache so
the iova magazine memory overhead can be clearly observed.

With this change:

> slabtop -o | head
 Active / Total Objects (% used)    : 869731 / 952904 (91.3%)
 Active / Total Slabs (% used)      : 103411 / 103974 (99.5%)
 Active / Total Caches (% used)     : 135 / 211 (64.0%)
 Active / Total Size (% used)       : 395389.68K / 411430.20K (96.1%)
 Minimum / Average / Maximum Object : 0.02K / 0.43K / 8.00K

OBJS ACTIVE  USE OBJ SIZE  SLABS OBJ/SLAB CACHE SIZE NAME
244412 244239 99%    1.00K  61103       4    244412K iommu_iova_magazine
 91636  88343 96%    0.03K    739     124      2956K kmalloc-32
 75744  74844 98%    0.12K   2367      32      9468K kernfs_node_cache

On this machine it is now clear that magazine use 242M of kmem memory.

Acked-by: David Rientjes <rientjes@google.com>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
[ rm: adjust to rework of iova_cache_{get,put} ]
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/iova.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index b5de865ee50b..d59d0ea2fd21 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -590,6 +590,8 @@ struct iova_rcache {
 	struct delayed_work work;
 };
 
+static struct kmem_cache *iova_magazine_cache;
+
 unsigned long iova_rcache_range(void)
 {
 	return PAGE_SIZE << (IOVA_RANGE_CACHE_MAX_SIZE - 1);
@@ -599,7 +601,7 @@ static struct iova_magazine *iova_magazine_alloc(gfp_t flags)
 {
 	struct iova_magazine *mag;
 
-	mag = kmalloc(sizeof(*mag), flags);
+	mag = kmem_cache_alloc(iova_magazine_cache, flags);
 	if (mag)
 		mag->size = 0;
 
@@ -608,7 +610,7 @@ static struct iova_magazine *iova_magazine_alloc(gfp_t flags)
 
 static void iova_magazine_free(struct iova_magazine *mag)
 {
-	kfree(mag);
+	kmem_cache_free(iova_magazine_cache, mag);
 }
 
 static void
@@ -953,6 +955,12 @@ int iova_cache_get(void)
 		if (!iova_cache)
 			goto out_err;
 
+		iova_magazine_cache = kmem_cache_create("iommu_iova_magazine",
+							sizeof(struct iova_magazine),
+							0, SLAB_HWCACHE_ALIGN, NULL);
+		if (!iova_magazine_cache)
+			goto out_err;
+
 		err = cpuhp_setup_state_multi(CPUHP_IOMMU_IOVA_DEAD, "iommu/iova:dead",
 					      NULL, iova_cpuhp_dead);
 		if (err) {
@@ -968,6 +976,7 @@ int iova_cache_get(void)
 
 out_err:
 	kmem_cache_destroy(iova_cache);
+	kmem_cache_destroy(iova_magazine_cache);
 	mutex_unlock(&iova_cache_mutex);
 	return err;
 }
@@ -984,6 +993,7 @@ void iova_cache_put(void)
 	if (!iova_cache_users) {
 		cpuhp_remove_multi_state(CPUHP_IOMMU_IOVA_DEAD);
 		kmem_cache_destroy(iova_cache);
+		kmem_cache_destroy(iova_magazine_cache);
 	}
 	mutex_unlock(&iova_cache_mutex);
 }
-- 
2.39.2.101.g768bb238c484.dirty

