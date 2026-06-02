Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19D43EDE54
	for <iommu@lists.linux.dev>; Tue,  2 Jun 2026 10:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780397239; cv=none; b=ifbIyizVjquiy/WViSwzL/jHVA5tJV+II9Yd4JnZPkMxmcl3uojBtMGFKBSg9SpPJ6rZEGM8COcOkBU1RCtAmTg5dYrF8zDsRYcZgkavyt3RfIobgpPqEPwP4JASEr8k08fLc0Ht9vfOetQHyST7PqiXmMmf9VSPjmcOKXa7R0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780397239; c=relaxed/simple;
	bh=TjzGiXc62UrhhblH9SGvj2BUK3+XiOWBAWsAXpz4ajY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZeV+HVPq/JaeS/I8174RwoEKcJOtsrzqHIOMV3YbwC+o3R3jpeQ0xU/Cc+lQRAA9+VtY7RRUPjcJdj/GgH1s/F7XOolK3bpMMZWYxcCA1f7DT+Ubi7eWrx0Z2DAvEse48/GCwdA6hgMdrrVewL4jIot2pKOjo0dd86h6puhV8PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ZI26kRn7; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ZI26kRn7"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780397236; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=6wu4xt2SoksscXk0W48QmnDjXSJs3uObhzvzFgCeYOU=;
	b=ZI26kRn7GUX7bKAaxqpqO7SHdqAlOnP429/OD2ySb9YeSB4YfBaIz5USwIp1Fo/x49f6AUGLxKi+f0kO0yRmjg04n+oltPrUIxHKVLOgJh01Edgfjn0R8rK4cfgHqAT1fyUz2WcLLcH2WXEjUNkbGBgzECaetskCia8a0SoJ1dE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0X44E98x_1780397233;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X44E98x_1780397233 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 02 Jun 2026 18:47:14 +0800
From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
To: adrian.larumbe@collabora.com,
	airlied@gmail.com,
	alex@shazbot.org,
	baolu.lu@linux.intel.com,
	boris.brezillon@collabora.com,
	dri-devel@lists.freedesktop.org,
	dwmw2@infradead.org,
	iommu@lists.linux.dev,
	jgg@ziepe.ca,
	joro@8bytes.org,
	kevin.tian@intel.com,
	kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	liviu.dudau@arm.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	oliver.yang@linux.alibaba.com,
	robh@kernel.org,
	robin.murphy@arm.com,
	shiyu.zsq@linux.alibaba.com,
	steven.price@arm.com,
	suravee.suthikulpanit@amd.com,
	tzimmermann@suse.de,
	wei.guo.simon@linux.alibaba.com,
	will@kernel.org,
	xlpang@linux.alibaba.com
Cc: alikernel-developer@linux.alibaba.com
Subject: [PATCH v2 26/30] iommu/io-pgtable: selftests switch to iova_to_phys_length
Date: Tue,  2 Jun 2026 18:46:33 +0800
Message-ID: <20260602104637.1219810-27-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260602104637.1219810-1-guanghuifeng@linux.alibaba.com>
References: <20260531093637.3893199-1-guanghuifeng@linux.alibaba.com>
 <20260602104637.1219810-1-guanghuifeng@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Migrate io-pgtable ARM selftests to use ops->iova_to_phys_length
instead of the deprecated ops->iova_to_phys.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/iommu/io-pgtable-arm-selftests.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm-selftests.c b/drivers/iommu/io-pgtable-arm-selftests.c
index 334e70350924..78252344c3d0 100644
--- a/drivers/iommu/io-pgtable-arm-selftests.c
+++ b/drivers/iommu/io-pgtable-arm-selftests.c
@@ -72,13 +72,13 @@ static int arm_lpae_run_tests(struct kunit *test, struct io_pgtable_cfg *cfg)
 		 * Initial sanity checks.
 		 * Empty page tables shouldn't provide any translations.
 		 */
-		if (ops->iova_to_phys(ops, 42))
+		if (ops->iova_to_phys_length(ops, 42, NULL) != PHYS_ADDR_MAX)
 			return __FAIL(test, i);
 
-		if (ops->iova_to_phys(ops, SZ_1G + 42))
+		if (ops->iova_to_phys_length(ops, SZ_1G + 42, NULL) != PHYS_ADDR_MAX)
 			return __FAIL(test, i);
 
-		if (ops->iova_to_phys(ops, SZ_2G + 42))
+		if (ops->iova_to_phys_length(ops, SZ_2G + 42, NULL) != PHYS_ADDR_MAX)
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
+			if (ops->iova_to_phys_length(ops, iova + 42, NULL) != PHYS_ADDR_MAX)
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

