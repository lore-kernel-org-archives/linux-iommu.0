Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535D627FB35
	for <iommu@lists.linux.dev>; Mon, 11 Aug 2025 06:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754893612; cv=none; b=dD8ui1HJx7kNUaSCC+hu66qgM1+5LqvzA14WCIq+cGj0+pjIdqyFvoojt61NU8zChIv3ANuFQ6hu1DsT1mx7S+gPgyGm/4nN0jGsmVKmX6Phtubnb7u6OAPUY5JRtHMmhKNLXt73f3qDbkkXWBWFO11pl70nfLWQ9aDiOjbTRHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754893612; c=relaxed/simple;
	bh=wvqy4UJ6IUTFndqB+XoDiJyOKD1YlqbUlQRCilku3zU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hg1XFsX/Txe65aHvyLzLFSHyriZ4klwmBE9Gs425o37CIn4dlGHG97zcXXrwaq/cmE/dcreyBDYJlfjK7n/OuBdiMKZc1GS4CROSwKbUR2BJrM2DWVb3KgdZvFqXZjQQIKQjOwZmVdA0/Vm7Mpjh058D9BfT7S8ghbyO8nEyI6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=OallRH+J; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="OallRH+J"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1754893606; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=DZN23X/8T7TOOtz+3clkVBeibPzLGB2AE7hvZ+c8lTI=;
	b=OallRH+JYD0KSXZIp0/PSCQFcsV4pu6usvGBpH9WFslWQs875+1pMTz+zPuqJ4aQ/50YIfvi9/T8BOj9mXSKbFoDuopbKTCQ0tt878FlRm9vHG9OTgta8nWwtImfTaOiD59BYd3cDBw+zzfFegXUQUdibNVsYPLtCjjTEz7vMUw=
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0WlP-v89_1754892670 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 11 Aug 2025 14:11:11 +0800
From: fangyu.yu@linux.alibaba.com
To: anup@brainfault.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	atishp@atishpatra.org,
	tjeznach@rivosinc.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	sunilvl@ventanamicro.com,
	rafael.j.wysocki@intel.com,
	tglx@linutronix.de,
	ajones@ventanamicro.com
Cc: guoren@linux.alibaba.com,
	guoren@kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	Fangyu Yu <fangyu.yu@linux.alibaba.com>
Subject: [RFC PATCH 1/6] RISC-V: Add more elements to irqbypass vcpu_info
Date: Mon, 11 Aug 2025 14:10:59 +0800
Message-Id: <20250811061104.10326-2-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250811061104.10326-1-fangyu.yu@linux.alibaba.com>
References: <20250811061104.10326-1-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fangyu Yu <fangyu.yu@linux.alibaba.com>

To support MRIF mode, we need to add more elements to
let the iommu driver get the ppn of MRIF.

Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
 arch/riscv/include/asm/irq.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/include/asm/irq.h b/arch/riscv/include/asm/irq.h
index 8588667cbb5f..6293ac00e051 100644
--- a/arch/riscv/include/asm/irq.h
+++ b/arch/riscv/include/asm/irq.h
@@ -30,6 +30,9 @@ struct riscv_iommu_vcpu_info {
 	u32 group_index_shift;
 	u64 gpa;
 	u64 hpa;
+	u32 host_irq;
+	bool mrif;
+	struct msi_msg *host_msg;
 };
 
 #ifdef CONFIG_ACPI
-- 
2.49.0

