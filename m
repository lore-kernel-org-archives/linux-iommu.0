Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D39E41C69;
	Wed, 23 Apr 2025 16:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745426602; cv=none; b=YgIYewV99upz/sZALb1Lnsc9AZmaJBX1wYOd4fAbD0F2TIIDduHMdTnQwEahycNjBQ6V+Y0O2Caw3wM4RbvVs7R7cpkBkKks4uu9zXjvEQkC96fz5Kmc8Hz2c3LHffQD9CKn29XJpzIO/rd8VzWDQpkng13ATkC7z0wpvmJBMgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745426602; c=relaxed/simple;
	bh=wXXLTEPyxftuq7Jgbipr9JXu2LJ10xEMjsTpIxgzqBE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Lnx65lTFWhwt7Mgb/oW2qMFvHRmTKzDQkXll1NDIwMxc8zL4vyW3O9RMfEYuZqk5fBM9UJy9ja7/X9jp71qT0wsPfuSYnXRee2b1WUMxDCgA3RA+uWhDD9r4htJ3ROIshSyvBugYWbpdkEOJmDUm3GcG+IALj8Wyic/534XXjK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qUi3lURS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qUi3lURS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03B0BC4CEE2;
	Wed, 23 Apr 2025 16:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745426602;
	bh=wXXLTEPyxftuq7Jgbipr9JXu2LJ10xEMjsTpIxgzqBE=;
	h=From:To:Cc:Subject:Date:From;
	b=qUi3lURSZ4dlqMx+GrhtXEZ20GaWEdwicEKiEjOJeJS+jM7EAj2iL0rkBPdP0ZhLq
	 PPaVg1KjTaqzrF4Af+S+Yo5kxpuSD/yCHepSW/X0mSWZe0eVnOuPVR4muX6EP23/q2
	 oChMMergC9hKdwe0DW93SLkvFDgXwAUreaTz/Ovg2hbzauoBTBaAnQrnDu0dAuJkY9
	 VCb0h9g15NIe1Tzj2Rfsjgu0Ol+rWY59OazZO9fRfrc8z5mqv7/Pf0aEGDzLND15Lw
	 QzEmU6o6Pf2wzR4v3mu0Yc0JEU/0XBWzCnsJ5y3+GjVO5Hvg4kOFbCuBPUP6FcqJs+
	 8VFp45h9sys/Q==
From: Arnd Bergmann <arnd@kernel.org>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Magnus Damm <damm+renesas@opensource.se>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommu: ipmmu-vmsa: avoid Wformat-security warning
Date: Wed, 23 Apr 2025 18:40:02 +0200
Message-Id: <20250423164006.2661372-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

iommu_device_sysfs_add() requires a constant format string, otherwise
a W=1 build produces a warning:

drivers/iommu/ipmmu-vmsa.c:1093:62: error: format string is not a string literal (potentially insecure) [-Werror,-Wformat-security]
 1093 |         ret = iommu_device_sysfs_add(&mmu->iommu, &pdev->dev, NULL, dev_name(&pdev->dev));
      |                                                                     ^~~~~~~~~~~~~~~~~~~~
drivers/iommu/ipmmu-vmsa.c:1093:62: note: treat the string as an argument to avoid this
 1093 |         ret = iommu_device_sysfs_add(&mmu->iommu, &pdev->dev, NULL, dev_name(&pdev->dev));
      |                                                                     ^
      |                                                                     "%s",

This was an old bug but I saw it now because the code was changed as part
of commit d9d3cede4167 ("iommu/ipmmu-vmsa: Register in a sensible order").

Fixes: 7af9a5fdb9e0 ("iommu/ipmmu-vmsa: Use iommu_device_sysfs_add()/remove()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/iommu/ipmmu-vmsa.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index e424b279a8cd..90341b24a811 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -1090,7 +1090,8 @@ static int ipmmu_probe(struct platform_device *pdev)
 	if (mmu->features->has_cache_leaf_nodes && ipmmu_is_root(mmu))
 		return 0;
 
-	ret = iommu_device_sysfs_add(&mmu->iommu, &pdev->dev, NULL, dev_name(&pdev->dev));
+	ret = iommu_device_sysfs_add(&mmu->iommu, &pdev->dev, NULL, "%s",
+				     dev_name(&pdev->dev));
 	if (ret)
 		return ret;
 
-- 
2.39.5

