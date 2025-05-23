Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F15D221D87;
	Fri, 23 May 2025 12:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748002382; cv=none; b=rk3bt59RUPWwBufP5ozTB76CHbWOuGpcYZVaG1rXLa3XvPRvshbVbJWE4p++eN8NgHDJu2dM08h5atCiB+Q4nwmKKRX6cXB1+LWe4FXIFicl5wMU1m5DjdNUHngDzDgooFMQ/05b8b1412dXH6PSbH0dIc4ACeQ1h4NrwcEOUqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748002382; c=relaxed/simple;
	bh=hcgJywXUeqcfDYKiMg3vHV01/zX3zwztfEiViOg12aE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DbUXubBPboIYWM//OUzz8R8cbs0FR6ZGptYP9HCj8Nh9wUGqUvqRN1oj+O2HWCWOo/eCsq6Kbs8uxEa2AJbVyw6pKP6pfH3JHgwfRVmv3KpckaK3ePZ0FWtni+KalHj9DBzLx1uqE5j5+0XW6ExYknsELUoXnoSq8OvSNa+awlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qcmuQ6FU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qcmuQ6FU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A84FDC4CEE9;
	Fri, 23 May 2025 12:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748002382;
	bh=hcgJywXUeqcfDYKiMg3vHV01/zX3zwztfEiViOg12aE=;
	h=From:To:Cc:Subject:Date:From;
	b=qcmuQ6FUdDpddr5PnkdyEGBTodooVk9KnxKHBGspPYq9i7COvkSZe0MALo22vQ7M2
	 4WO9QXIYgdFKj6M3pXQL0RlfPYeRsbNINEjxh+UamxbQPyXgvHSuHOZ8o8V1i+d0G0
	 6j+wKXoMeIKHbJj0copuFoNuDcVOyn3CeqvNvC4p8rAEOfifwU7RdxzYijOnKCiTMG
	 oRhrIi/XsJ0UAtrJ/82A3hFIK02EQECEi3QWJhQogroBDEKQLYoKaJfxEYF/nNAr0l
	 W0EJqm5gQ9ljEZm3uCbdEhYl3+vUuYksaPc0QeffPw7Q4uJUTueqmBOJ1XM29wP10L
	 iJiAOZG2movLA==
From: Arnd Bergmann <arnd@kernel.org>
To: Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Rolf Eike Beer <eb@emlix.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Nate Watterson <nwatterson@nvidia.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommu: arm: fix building smmuv3 as loadable module
Date: Fri, 23 May 2025 14:12:53 +0200
Message-Id: <20250523121257.2340274-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The smmu-v3 kunit test fail to link when the SMMU driver is configured
as a loadable mdoule:

ERROR: modpost: "arm_smmu_make_cdtable_ste" [drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.ko] undefined!
ERROR: modpost: "arm_smmu_make_s2_domain_ste" [drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.ko] undefined!
ERROR: modpost: "arm_smmu_make_s1_cd" [drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.ko] undefined!
ERROR: modpost: "arm_smmu_make_bypass_ste" [drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.ko] undefined!
ERROR: modpost: "arm_smmu_make_abort_ste" [drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.ko] undefined!
ERROR: modpost: "arm_smmu_make_sva_cd" [drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.ko] undefined!
ERROR: modpost: "arm_smmu_get_ste_used" [drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.ko] undefined!
ERROR: modpost: "arm_smmu_write_entry" [drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.ko] undefined!
ERROR: modpost: "arm_smmu_get_cd_used" [drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.ko] undefined!

The problem is that the drivers/iommu/arm/arm-smmu-v3/Makefile only gets
parsed while building modules, but the driver itself is accidentally marked
as built-in unconditionally, so not only does the kunit test fail, but the
entire driver is missing.

Change the driver configuration back to $(CONFIG_ARM_SMMU_V3) so it
actually gets build here.

Fixes: e436576b0231 ("iommu: make inclusion of arm/arm-smmu-v3 directory conditional")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/iommu/arm/arm-smmu-v3/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/Makefile b/drivers/iommu/arm/arm-smmu-v3/Makefile
index 6cc7c8557b9e..493a659cc66b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/Makefile
+++ b/drivers/iommu/arm/arm-smmu-v3/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-y += arm_smmu_v3.o
+obj-$(CONFIG_ARM_SMMU_V3) += arm_smmu_v3.o
 arm_smmu_v3-y := arm-smmu-v3.o
 arm_smmu_v3-$(CONFIG_ARM_SMMU_V3_IOMMUFD) += arm-smmu-v3-iommufd.o
 arm_smmu_v3-$(CONFIG_ARM_SMMU_V3_SVA) += arm-smmu-v3-sva.o
-- 
2.39.5

