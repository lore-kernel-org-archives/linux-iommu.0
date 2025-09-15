Received: from out28-145.mail.aliyun.com (out28-145.mail.aliyun.com [115.124.28.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993B81DC988
	for <iommu@lists.linux.dev>; Mon, 15 Sep 2025 02:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757902521; cv=none; b=mfduXsr81kAU/y4TQAGnTn/4praNsGTZB7iu+yofAe4AgiMR0aUDYUO2SmXRh7xCSoAeEZ2YJ+oQd7efQILswJhh6E1rg4CITMf0y0iP6Gn/oyzKyVHY2Fu9CQ/sUskFOEA9i33wwkWujXDf9dvIcFALtRXJ4VJPdQ0x0VYWO9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757902521; c=relaxed/simple;
	bh=WI3ZQvTshQDIN8vqpCwewhWpdHhOa4zDYJTx4e0oebA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Uo0J8JOsGdsshAGCpNp8/Nj3DS4MJcTQU918+8HQ1xdWJIGWMbbdlWy7lxNH2CPXANDcaT4f0hSAZgV2IiUTW8RTsPbkvDyvOo1O5xbBCHT0ZWV/8fTq3BdYBzyizL5JrO8xjnuvzRmLzVGFDHhZwFTXGwYt2qdJhaylbfBC5ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bosc.ac.cn; spf=pass smtp.mailfrom=bosc.ac.cn; arc=none smtp.client-ip=115.124.28.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bosc.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bosc.ac.cn
Received: from LAPTOP-2KT3QRS7.localdomain(mailfrom:guoyaxing@bosc.ac.cn fp:SMTPD_---.ef9vIh9_1757902187 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 15 Sep 2025 10:09:50 +0800
From: Yaxing Guo <guoyaxing@bosc.ac.cn>
To: linux-riscv@lists.infradead.org
Cc: iommu@lists.linux.dev,
	tjeznach@rivosinc.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	anxu@bosc.ac.cn,
	wangran@bosc.ac.cn,
	Yaxing Guo <guoyaxing@bosc.ac.cn>
Subject: [PATCH v1 2/3] iommu/riscv: Add Makefile support for RISC-V IOMMU perf driver
Date: Mon, 15 Sep 2025 10:09:10 +0800
Message-Id: <20250915020911.1313-2-guoyaxing@bosc.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250915020911.1313-1-guoyaxing@bosc.ac.cn>
References: <20250915020911.1313-1-guoyaxing@bosc.ac.cn>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add compilation rules for iommu-perf.o to support
the new RISC-V IOMMU perf driver.

Signed-off-by: Yaxing Guo <guoyaxing@bosc.ac.cn>
---
 drivers/iommu/riscv/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/riscv/Makefile b/drivers/iommu/riscv/Makefile
index b5929f9f23e6..5e9c7c1ed928 100644
--- a/drivers/iommu/riscv/Makefile
+++ b/drivers/iommu/riscv/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-y += iommu.o iommu-platform.o
+obj-y += iommu.o iommu-platform.o iommu-perf.o
 obj-$(CONFIG_RISCV_IOMMU_PCI) += iommu-pci.o
-- 
2.34.1

