Received: from mail-m1973190.qiye.163.com (mail-m1973190.qiye.163.com [220.197.31.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BEA22126D
	for <iommu@lists.linux.dev>; Fri, 22 Aug 2025 02:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755830975; cv=none; b=lUJUgjb6LkKWDy3GxUMb0yuknr7k9H68pssgxZuNyDtvcUJ2Grczl/H4Zz9nonr1RgWOMmuRY5msUolvldcp7KSpH4hz2ImjFqm28On/jb5WRUDCBCB1gfjKYhGdVq+v7t3HLLHkCWwC+KpZ9TIA3LF39uKHyZlUqiZNRiwQbxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755830975; c=relaxed/simple;
	bh=o3C8eYNeJJZNc4OggbKLfGp2psaVDgU1MkppGi+eyTU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HeS6UiOtyJ7FjAzsp3sVKcx67TiEG56Q+qhjyz/91CqsPBgHEbbBCOhtRCjkvPhQ0yz7xi/94tXeVix5XzjypXdiFal1OIvi8x6GFm7UoZYSrEcfDHBXu/TncMavTW2PEQ2999Eo8GoSjJTfdVEj8fTTH6YXNetuO2Tgv0djeYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=220.197.31.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from localhost.localdomain (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTP id f014022a;
	Fri, 22 Aug 2025 10:49:24 +0800 (GMT+08:00)
From: Zhen Ni <zhen.ni@easystack.cn>
To: joro@8bytes.org,
	suravee.suthikulpanit@amd.com,
	will@kernel.org,
	robin.murphy@arm.com
Cc: iommu@lists.linux.dev,
	Zhen Ni <zhen.ni@easystack.cn>,
	stable@vger.kernel.org
Subject: [PATCH] iommu/amd: Fix ivrs_base memleak in early_amd_iommu_init()
Date: Fri, 22 Aug 2025 10:49:15 +0800
Message-Id: <20250822024915.673427-1-zhen.ni@easystack.cn>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a98cfae52530229kunm894ba8a8de43a2
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkZTR0fVklDSBpDQ0JMTENMSlYVFAkWGhdVGRETFh
	oSFyQUDg9ZV1kYEgtZQVlJSkNVQk9VSkpDVUJLWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
	VKQktLWQY+

Fix a permanent ACPI table memory leak in early_amd_iommu_init() when
CMPXCHG16B feature is not supported

Fixes: 82582f85ed22 ("iommu/amd: Disable AMD IOMMU if CMPXCHG16B feature is not supported")
Cc: stable@vger.kernel.org
Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
---
 drivers/iommu/amd/init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 7b5af6176de9..dddc432de7b0 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3067,7 +3067,8 @@ static int __init early_amd_iommu_init(void)
 
 	if (!boot_cpu_has(X86_FEATURE_CX16)) {
 		pr_err("Failed to initialize. The CMPXCHG16B feature is required.\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out;
 	}
 
 	/*
-- 
2.20.1

