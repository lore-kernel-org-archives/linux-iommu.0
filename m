Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0827A3A27E
	for <iommu@lists.linux.dev>; Mon,  5 Feb 2024 15:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707147169; cv=none; b=Y49a4eJTY3Nkv3DQHj43kxjE74ww3vVevAuMNzhsHn3KLk9bp0EXiOjzX3OtenPqk13s8UrDsvtjholhSPdX/9cCp/8EZr8Ivaca8ye4Ppp7bRH+KriZAZcxdrULvEQe/H2jwUhRTbGXBLLvpreMKTzyo4hcef8f8WaWpLTdST4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707147169; c=relaxed/simple;
	bh=M6yxaufXQSaUctlg9rkP73rx1vbqTh2nUd3NBrS+Se8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sc5mfOf10VpxBxk4pPgeLFIElR/8SLspoARLNTdM4WrFPwxyBJMqpSwHdHabJzlADKSzFSWQBXB9KcuhgQ9MA08yxVANWFFESBCLfCZppBc2sgjaRQ18rqJi33w6RBn7eMhfjrGffQQroblGXMzmzW3ZV0x3nm5jlAoushxjMxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36CBDDA7;
	Mon,  5 Feb 2024 07:33:30 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6A7DF3F5A1;
	Mon,  5 Feb 2024 07:32:46 -0800 (PST)
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
Subject: [PATCH v3 1/3] iommu/iova: Tidy up iova_cache_get() failure
Date: Mon,  5 Feb 2024 15:32:39 +0000
Message-Id: <ae4a3bda2d6a9b738221553c838d30473bd624e7.1707144953.git.robin.murphy@arm.com>
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

Failure handling in iova_cache_get() is a little messy, and we'd like
to add some more to it, so let's tidy up a bit first. By leaving the
hotplug handler until last we can take advantage of kmem_cache_destroy()
being NULL-safe to have a single cleanup label. We can also improve the
error reporting, noting that kmem_cache_create() already screams if it
fails, so that one is redundant.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/iova.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index d30e453d0fb4..cf95001d85c0 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -254,26 +254,20 @@ static void free_iova_mem(struct iova *iova)
 
 int iova_cache_get(void)
 {
+	int err = -ENOMEM;
+
 	mutex_lock(&iova_cache_mutex);
 	if (!iova_cache_users) {
-		int ret;
+		iova_cache = kmem_cache_create("iommu_iova", sizeof(struct iova), 0,
+					       SLAB_HWCACHE_ALIGN, NULL);
+		if (!iova_cache)
+			goto out_err;
 
-		ret = cpuhp_setup_state_multi(CPUHP_IOMMU_IOVA_DEAD, "iommu/iova:dead", NULL,
-					iova_cpuhp_dead);
-		if (ret) {
-			mutex_unlock(&iova_cache_mutex);
-			pr_err("Couldn't register cpuhp handler\n");
-			return ret;
-		}
-
-		iova_cache = kmem_cache_create(
-			"iommu_iova", sizeof(struct iova), 0,
-			SLAB_HWCACHE_ALIGN, NULL);
-		if (!iova_cache) {
-			cpuhp_remove_multi_state(CPUHP_IOMMU_IOVA_DEAD);
-			mutex_unlock(&iova_cache_mutex);
-			pr_err("Couldn't create iova cache\n");
-			return -ENOMEM;
+		err = cpuhp_setup_state_multi(CPUHP_IOMMU_IOVA_DEAD, "iommu/iova:dead",
+					      NULL, iova_cpuhp_dead);
+		if (err) {
+			pr_err("IOVA: Couldn't register cpuhp handler: %pe\n", ERR_PTR(err));
+			goto out_err;
 		}
 	}
 
@@ -281,6 +275,11 @@ int iova_cache_get(void)
 	mutex_unlock(&iova_cache_mutex);
 
 	return 0;
+
+out_err:
+	kmem_cache_destroy(iova_cache);
+	mutex_unlock(&iova_cache_mutex);
+	return err;
 }
 EXPORT_SYMBOL_GPL(iova_cache_get);
 
-- 
2.39.2.101.g768bb238c484.dirty

