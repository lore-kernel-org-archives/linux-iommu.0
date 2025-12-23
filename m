Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D53221546;
	Tue, 23 Dec 2025 21:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766526692; cv=none; b=oxXESdvDbIldG7uVJ3U2WD6RpSoFofmLAgyPWwbcRmsrTnZTQPNtOseZwIrIWATp3LRVdUmqg/Kybth8ir7D3jTcdXTowAwMlY4IPGwoE6lyuTOv0szQHHWJOH2JhYKSrXUtE5vdfpSKUPujXGkpXZzGQ5iChGBJVWSJ6JoOOmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766526692; c=relaxed/simple;
	bh=nPztlmeytqfzpUowH51PmANLBSAr7eYemow6AkdWkRw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lbnXeIEQ5mTkuiE1P1tMganajX30d+1pLIeRU0OhrIfEYzOXKZN/Jk51TscaVY5GWuH2tgpoDV+tGamcEK1bfxz9tlhE6USOuxHRHj52RXoh7F4pmgKVi6JbWQtHDIJR6VsvOuX1f0K2MW12aeAfmfes9NVxzazuMfyVhO12rVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/IRTHLi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/IRTHLi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA268C113D0;
	Tue, 23 Dec 2025 21:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766526692;
	bh=nPztlmeytqfzpUowH51PmANLBSAr7eYemow6AkdWkRw=;
	h=From:To:Cc:Subject:Date:From;
	b=X/IRTHLiq8vLADKMTGgAGVGib7Dig7VG0NCn8u+PO6wrU5M9Y/CmppizJF2VjH74n
	 ydUY/v9JG5T5pphPQ8E2pMj9jwoiZkFyTSpwkMGWPEisoz3lQj3cXi41xQKK9lkcj9
	 Le7u6zzADwWw3aipHcYPbG747wTBJ1pdR6UPnc8J/CVYnMpweI4cooXcwpR/MxU3qi
	 BtRGXf2hrNLUsuOlrYL4r7biWiKdjsSG/a4kN7tzyn588NZ5dgDPibrE0eCC8H++ur
	 mwHdh/RxQXvFZbNsyhN4B04QrKPYmsDwunbridBpONt1j1PdMal5wSn1w8T7JJ6IhV
	 9lRGNPGA9KcxA==
From: Arnd Bergmann <arnd@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Samiullah Khawaja <skhawaja@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Pranjal Shrivastava <praan@google.com>,
	Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommufd: fix selftest link dependency on amdv1 driver
Date: Tue, 23 Dec 2025 22:51:22 +0100
Message-Id: <20251223215127.603969-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

When CONFIG_AMD_IOMMU is disabled, the selftest runs into a link failure:

aarch64-linux-ld: drivers/iommu/iommufd/selftest.o: in function `mock_domain_alloc_pgtable.isra.0':
selftest.c:(.text+0x1590): undefined reference to `pt_iommu_amdv1_init'
aarch64-linux-ld: drivers/iommu/iommufd/selftest.o:(.rodata+0x280): undefined reference to `pt_iommu_amdv1_map_pages'
aarch64-linux-ld: drivers/iommu/iommufd/selftest.o:(.rodata+0x288): undefined reference to `pt_iommu_amdv1_unmap_pages'
aarch64-linux-ld: drivers/iommu/iommufd/selftest.o:(.rodata+0x2b0): undefined reference to `pt_iommu_amdv1_iova_to_phys'
aarch64-linux-ld: drivers/iommu/iommufd/selftest.o:(.rodata+0x2d8): undefined reference to `pt_iommu_amdv1_read_and_clear_dirty'

Change the top-level function to skip all the amdv1 tests in this configuration.

Fixes: e93d5945ed5b ("iommufd: Change the selftest to use iommupt instead of xarray")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/iommu/iommufd/selftest.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 550ff36dec3a..4d04d7642b1b 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -479,6 +479,11 @@ mock_domain_alloc_pgtable(struct device *dev,
 	}
 
 	case MOCK_IOMMUPT_AMDV1: {
+		if (!IS_ENABLED(CONFIG_AMD_IOMMU)) {
+			rc = -EOPNOTSUPP;
+			goto err_free;
+		}
+
 		struct pt_iommu_amdv1_cfg cfg = {};
 
 		cfg.common.hw_max_vasz_lg2 = 64;
-- 
2.39.5

