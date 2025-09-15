Received: from out198-10.us.a.mail.aliyun.com (out198-10.us.a.mail.aliyun.com [47.90.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2952E22370A
	for <iommu@lists.linux.dev>; Mon, 15 Sep 2025 02:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757902213; cv=none; b=sveFUaESCT1pZlWLZ7v6MRSuXghZt0riWwQUu8Fo+hHzO3fNyL2TLptBj9rUW/8+q61wJJSK3Yqg1nwVq8YoABi8kcRWnfijbf12P7LRultGfDlVYDXCSuWW9peBeRabbbKyuk7rxPUQ3DjEUIssWTMXYt4E2sEd778/kKS6Jzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757902213; c=relaxed/simple;
	bh=QKOv4bfIa7OqcrE+fgTeJU2BQs8K+xVI2PV7D0hIf0k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zz2/IzpC7au79ZQr7fT1PBli1ucYmMHrrANEQnbtHIZferrGFMq6wDUE2dV+ncoRtzKDe++Jn1jTvVBGQKJTKTl7FjQLHLDUrS3uq2Qr/ooQiRFu88k3pm5H8LGl8zZVetwlgWPdIeGM5aRvNV4h/6huj++DgYqVC/jtFonndQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bosc.ac.cn; spf=pass smtp.mailfrom=bosc.ac.cn; arc=none smtp.client-ip=47.90.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bosc.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bosc.ac.cn
Received: from LAPTOP-2KT3QRS7.localdomain(mailfrom:guoyaxing@bosc.ac.cn fp:SMTPD_---.ef9vIm0_1757902191 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 15 Sep 2025 10:09:53 +0800
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
Subject: [PATCH v1 3/3] iommu/riscv: Register RISC-V IOMMU PMU at init time
Date: Mon, 15 Sep 2025 10:09:11 +0800
Message-Id: <20250915020911.1313-3-guoyaxing@bosc.ac.cn>
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

Register the RISC-V IOMMU driver during IOMMU driver
initialization.

Signed-off-by: Yaxing Guo <guoyaxing@bosc.ac.cn>
---
 drivers/iommu/riscv/iommu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 0eae2f4bdc5e..453d04b03c6c 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -23,6 +23,7 @@
 #include "../iommu-pages.h"
 #include "iommu-bits.h"
 #include "iommu.h"
+#include "iommu-perf.h"
 
 /* Timeouts in [us] */
 #define RISCV_IOMMU_QCSR_TIMEOUT	150000
@@ -1604,6 +1605,7 @@ void riscv_iommu_remove(struct riscv_iommu_device *iommu)
 	riscv_iommu_iodir_set_mode(iommu, RISCV_IOMMU_DDTP_IOMMU_MODE_OFF);
 	riscv_iommu_queue_disable(&iommu->cmdq);
 	riscv_iommu_queue_disable(&iommu->fltq);
+	riscv_iommu_pmu_unregister(iommu);
 }
 
 int riscv_iommu_init(struct riscv_iommu_device *iommu)
@@ -1656,6 +1658,14 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
 		goto err_remove_sysfs;
 	}
 
+	rc = riscv_iommu_pmu_alloc(iommu);
+	if (rc) {
+		dev_err(iommu->dev, "cannot alloc iommu pmu (%d)\n", rc);
+		iommu_device_sysfs_remove(&iommu->iommu);
+		goto err_remove_sysfs;
+	}
+	riscv_iommu_pmu_register(iommu);
+
 	return 0;
 
 err_remove_sysfs:
-- 
2.34.1

