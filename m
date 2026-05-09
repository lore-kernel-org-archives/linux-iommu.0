Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6F5374178
	for <iommu@lists.linux.dev>; Sat,  9 May 2026 02:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778294781; cv=none; b=LvGM9RDe+D87wYC5mfl/KOIEsgwG9NekjSrFbNiVXxaaCaTJPgQUBXsMvl7fr8ujY8+QDPggoCytn+19C1PSxbbx6fhBZRd9CoRAttX0szxAn8kIHq8PqC0BsAcBgfy6khFoQ5D6yBcphxCuEfJ1K6WuCz7ZGxX4eEPRFgwiC5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778294781; c=relaxed/simple;
	bh=2lQvI3eWTzyJtAFOoLPchUt7vjSHRyjNBxvcylCdAgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pn6EKVJ0CKr9Vvy2uY4biP0zSXJQV5dgdkQuvwURwfoQ9JgVsxMwTFKlU9lO8uzQx4Z3lJ/+SfnFFc7prOvpJmcIM8Mkek93fZ6ktGgnyxKo7Vhh3gQ7q2gBU5xB0GfR+4MMO8Xv8nB0QbGMy0bQ77RQVQODPdM1HTqBNR75flg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kx/N7PKC; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kx/N7PKC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778294781; x=1809830781;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2lQvI3eWTzyJtAFOoLPchUt7vjSHRyjNBxvcylCdAgA=;
  b=Kx/N7PKCaZwjuN31qJKGHpl+/WzH5acTZcH06zQQlLUVP8JkI6KxLy8C
   vaSxtO5QJI2EJ5flIznLbo+xYhykavN+QT8vXf/NZsotspS/c5BDETdQ/
   etSoM27gTPaoIDWz1j9GyBpxIxY9Hd9OSnNHBL51w7r3j+YbkWGZAgRG2
   uzCUi0sCp67gu4bYkczjacTsVAgdebY3l1IJHK1HuHJfUbr1GoNQY9UfI
   9TApJpyOwi7iV6cSuV415tcFskEW9Yh9pyQTGbqtvQn0IYAeX9/JHBDfN
   EjLnZp2CMlKfpWh68Ju1vS9rpb5D2wgqgRxr99eOA0AovvHJrormzpMDD
   Q==;
X-CSE-ConnectionGUID: 00DiGXDMQPy+12FKDEWEEQ==
X-CSE-MsgGUID: 9NU+6VcbRUevrgfjtJzUqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11780"; a="83142520"
X-IronPort-AV: E=Sophos;i="6.23,224,1770624000"; 
   d="scan'208";a="83142520"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 19:46:20 -0700
X-CSE-ConnectionGUID: ZORUAAIgSbacym5ZotVoXA==
X-CSE-MsgGUID: ym1tPgqCQ4urfGMkOcFsJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,224,1770624000"; 
   d="scan'208";a="236103475"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa010.jf.intel.com with ESMTP; 08 May 2026 19:46:18 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>,
	=?UTF-8?q?Naval=20Alcal=C3=A1?= <ari@naval.cat>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] iommu/vt-d: Avoid NULL pointer dereference or refcount corruption
Date: Sat,  9 May 2026 10:43:46 +0800
Message-ID: <20260509024348.3516523-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260509024348.3516523-1-baolu.lu@linux.intel.com>
References: <20260509024348.3516523-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

Commit 60f030f7418d ("iommu/vt-d: Avoid use of NULL after WARN_ON_ONCE")
fixed a NULL pointer dereference in an unlikely situation partly.

If dev_pasid is not found in the dev_pasids list, it remains NULL.
However, the teardown operations are executed unconditionally, this lead
to a NULL pointer dereference or refcount corruption.

If the domain was never attached to this IOMMU, info will be NULL, which
would cause an immediate dereference when checking --info->refcnt.

Even if info is not NULL, decrementing the refcount without having removed
a valid PASID might unbalance the count. This could lead to premature
dropping of the refcount to 0, potentially causing a use-after-free for the
remaining active devices sharing the domain.

Fix it by returning early if dev_pasid is NULL, before executing the
teardown operations.

Issue found by AI review and suggested by Kevin Tian.
https://sashiko.dev/#/patchset/20260421031347.1408890-1-zhenzhong.duan%40intel.com

Fixes: 60f030f7418d ("iommu/vt-d: Avoid use of NULL after WARN_ON_ONCE")
Cc: stable@vger.kernel.org
Suggested-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20260422033538.95000-1-zhenzhong.duan@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index a4b123c33022..4d0e65bc131d 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3545,12 +3545,13 @@ void domain_remove_dev_pasid(struct iommu_domain *domain,
 	}
 	spin_unlock_irqrestore(&dmar_domain->lock, flags);
 
+	if (WARN_ON_ONCE(!dev_pasid))
+		return;
+
 	cache_tag_unassign_domain(dmar_domain, dev, pasid);
 	domain_detach_iommu(dmar_domain, iommu);
-	if (!WARN_ON_ONCE(!dev_pasid)) {
-		intel_iommu_debugfs_remove_dev_pasid(dev_pasid);
-		kfree(dev_pasid);
-	}
+	intel_iommu_debugfs_remove_dev_pasid(dev_pasid);
+	kfree(dev_pasid);
 }
 
 static int blocking_domain_set_dev_pasid(struct iommu_domain *domain,
-- 
2.43.0

