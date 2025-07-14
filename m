Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA1721C9F5;
	Mon, 14 Jul 2025 20:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752526674; cv=none; b=Ny2hgtUcrLqYgjPxR6O+Soan3v3bDXb0mUSRrttO/pE2+dg29q4ZbEKilWVuuUWhxqOMv2nbHEEGTS0wphkM8InLNfj8setdWloPpzScf3XH3GeylRTQZCgKZJGj+CJ55NOnKTmmQoWHKMDjVBFhwOuDcwiy+XvFqo0lm6ENsYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752526674; c=relaxed/simple;
	bh=FoXEiIKsEnSTIC3b0/xiL8qZVHlrN7UH18Be1tRtm50=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pWuO7UbGTOUDWgTaqwQBUP35dXPs0GsYiRy93lAtAABhfII8IZ2+5s4/495c5SYCCPyX/bMmWiW3y3nFNvFS9H5/ICuY5dZ/AsCGEs3bFMJUoSLCPuyxZy+V5xJNpiedG+WbpHT07hvgViDu0Nr1wZV8tkBEPNXY71rynTg8JOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ej+Cv/xy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ej+Cv/xy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA8BC4CEED;
	Mon, 14 Jul 2025 20:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752526673;
	bh=FoXEiIKsEnSTIC3b0/xiL8qZVHlrN7UH18Be1tRtm50=;
	h=From:To:Cc:Subject:Date:From;
	b=ej+Cv/xybP3w3Xmx9ukBwO9o6Iy+dWNANcIqr8mh+YFSOl9yZWioLJ5nMyROR1cnW
	 9V1Qs9ktFnfUZy/pEzRra40OFupdeixbdTAsgAQ3MWB0kzRcl3vLAyhW60iM+lmvKE
	 TS6sByjoSK+T0KGyaylrxuvBMajsJ4aRx2IByQmlv5XPzbvQSarpNCVj5Ru/YIY8io
	 tyZrFcYKYIRdVYusR9gke7N0oYHxR/wFqx7tp6S2X8bDUV8hMX9zwJeZOJhL+vuRBe
	 ikO20TyBcS8IJ3NDPUN3XlYYwmi5h/1dLVYnFbJ4y0EkZUblEqwxCxRyVRE4QkPpLE
	 bpiVAmOh3xHFg==
From: Arnd Bergmann <arnd@kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>,
	Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Pranjal Shrivastava <praan@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Krishna Reddy <vdumpa@nvidia.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Nate Watterson <nwatterson@nvidia.com>,
	linux-tegra@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/tegra241-cmdqv: import IOMMUFD module namespace
Date: Mon, 14 Jul 2025 22:57:38 +0200
Message-Id: <20250714205747.3475772-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The tegra variant of smmu-v3 now uses the iommufd mmap interface but
is missing the corresponding import:

ERROR: modpost: module arm_smmu_v3 uses symbol _iommufd_object_depend from namespace IOMMUFD, but does not import it.
ERROR: modpost: module arm_smmu_v3 uses symbol iommufd_viommu_report_event from namespace IOMMUFD, but does not import it.
ERROR: modpost: module arm_smmu_v3 uses symbol _iommufd_destroy_mmap from namespace IOMMUFD, but does not import it.
ERROR: modpost: module arm_smmu_v3 uses symbol _iommufd_object_undepend from namespace IOMMUFD, but does not import it.
ERROR: modpost: module arm_smmu_v3 uses symbol _iommufd_alloc_mmap from namespace IOMMUFD, but does not import it.

Fixes: b135de24cfc0 ("iommu/tegra241-cmdqv: Add user-space use support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index d5d43a1c7708..eb90af5093d8 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -1329,3 +1329,5 @@ tegra241_cmdqv_init_vintf_user(struct arm_vsmmu *vsmmu,
 	tegra241_cmdqv_deinit_vintf(cmdqv, vintf->idx);
 	return ret;
 }
+
+MODULE_IMPORT_NS("IOMMUFD");
-- 
2.39.5

