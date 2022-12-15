Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74036210D
	for <iommu@lists.linux.dev>; Thu, 15 Dec 2022 07:32:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD64C43396;
	Thu, 15 Dec 2022 07:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1671089541;
	bh=IuVFclXBC2xjRNMPRTtq1KAZ9dbUziFQCUjGxBXpNv0=;
	h=From:To:Cc:Subject:Date:From;
	b=up1c8ix9evWyaIMVotw+FBoA3JiiMPOQLHfXEwVt3x77Nriis+Zm6svfODeRCKBN9
	 7c2P5ndXAZ1jbzSJIo/s3/e6KywByC4vonLI08eGglyWEY3umhcUUsBBLXqZnyoGk5
	 wGd+B+au8iNgkco3LADOjNSIkEqFGs5z0QF9M6NfQ4mokYfA4KvrSqfJz/ZipEx2WU
	 ku7C83aDCGn0GmT/OQPVVNFUYC9wem9jHynrYBGH9JQ94ULEoLvWxC+svkB8+kY/Nj
	 KqSkQahr89gkKfeLUq/L2qFN2LA/Kijh+jlGJ4ErSLDlgzVGYsHUMTrESTNpmsM+Dt
	 t0qQZAzNpYGtQ==
From: guoren@kernel.org
To: palmer@dabbelt.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	iommu@lists.linux.dev,
	Guo Ren <guoren@linux.alibaba.com>,
	kernel test robot <lkp@intel.com>,
	Guo Ren <guoren@kernel.org>
Subject: [PATCH] iommu/renesas: Support riscv compile
Date: Thu, 15 Dec 2022 02:32:12 -0500
Message-Id: <20221215073212.1966823-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guo Ren <guoren@linux.alibaba.com>

After riscv selects ARCH_RENESAS, we need to add ARM64 || ARM
dependency here.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 drivers/iommu/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index dc5f7a156ff5..746b95b9f345 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -283,6 +283,7 @@ config EXYNOS_IOMMU_DEBUG
 
 config IPMMU_VMSA
 	bool "Renesas VMSA-compatible IPMMU"
+	depends on ARM64 || ARM
 	depends on ARCH_RENESAS || (COMPILE_TEST && !GENERIC_ATOMIC64)
 	select IOMMU_API
 	select IOMMU_IO_PGTABLE_LPAE
-- 
2.36.1

