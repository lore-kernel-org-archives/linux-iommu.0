Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8ABB3911AA
	for <iommu@lists.linux.dev>; Tue, 12 May 2026 14:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778597028; cv=none; b=Cob3V/0zorHdc+Pw47jYlsyje17Vnn8+/M7ZgPg8K5gZXvUo9n72mgTPKZCFf0iP/Vdk8H6mQqPkwPoyD875Rr97zc98DBddEVrN/nMLRIcPqhaAJGZ6TKWyP9/XMcrVzAVLLMs3/b1oo2O4UN+TAa5wN9/eT+VuUolAPsDBhNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778597028; c=relaxed/simple;
	bh=zoHZ7UHQoDpxjF4aFyfEOg/0NtSuC+QVM9Bivg8ckgo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nMb7V4Y1CqS39vx25clFIJogOzJBg4XNWBgVKhrKjG6RE1V0MJg6KLURwuMltjx5NppfzrEAveHJj1O9Swn24FIMS6GmPn6xq+TSWFqXPOZyBSuRSH5QUAN3JLp461ZGpKkZ+c6/sqXokkfT8obiOCMaObFBA87oTNAaKJXl0Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=HKL6lNNb; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="HKL6lNNb"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778597019; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=rGf7I8/6d+oaxOH3iQMKwENVJqvQ7e/ZZfEuXFJcHxM=;
	b=HKL6lNNbfTRKjzAlGFvyT6TPdqJ2TBW6jnKTaJsvmZqoBjoTYQD1Bq4yyPWeTSZKFxGXxIaNXx4x2fgP/qxblKj0bzZPcx8nX+mUkzIsGmWsn20MkcbEnAgAJChDq7NwBKN1odk2uHuWRmNkWv7gQIGGzWXB4CYOkNS7pUnOv0o=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0X2qqOSF_1778597016;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X2qqOSF_1778597016 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 12 May 2026 22:43:37 +0800
From: fangyu.yu@linux.alibaba.com
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	jgg@nvidia.com,
	nutty.liu@hotmail.com
Cc: guoren@kernel.org,
	kvm@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Fangyu Yu <fangyu.yu@linux.alibaba.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] iommupt: Fixup build warning by using BIT_ULL() for RISCVPT_NC/IO
Date: Tue, 12 May 2026 22:43:30 +0800
Message-Id: <20260512144330.91113-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fangyu Yu <fangyu.yu@linux.alibaba.com>

Fix build warning on 32-bit configurations by using BIT_ULL() for
RISCVPT_NC and RISCVPT_IO.

Fixes: 6c21eb174c6c ("iommupt: Encode IOMMU_MMIO/IOMMU_CACHE via RISC-V Svpbmt bits")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202605121350.wZxB51k0-lkp@intel.com/
Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
 drivers/iommu/generic_pt/fmt/riscv.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/generic_pt/fmt/riscv.h b/drivers/iommu/generic_pt/fmt/riscv.h
index 2648bb57953e..ae9a76514416 100644
--- a/drivers/iommu/generic_pt/fmt/riscv.h
+++ b/drivers/iommu/generic_pt/fmt/riscv.h
@@ -64,8 +64,8 @@ enum {
 	RISCVPT_PPN64 = GENMASK_ULL(53, 10),
 	RISCVPT_PPN64_64K = GENMASK_ULL(53, 14),
 	RISCVPT_PBMT = GENMASK_ULL(62, 61),
-	RISCVPT_NC = BIT(61),
-	RISCVPT_IO = BIT(62),
+	RISCVPT_NC = BIT_ULL(61),
+	RISCVPT_IO = BIT_ULL(62),
 	RISCVPT_N = BIT_ULL(63),
 
 	/* Svnapot encodings for ppn[0] */
-- 
2.50.1

