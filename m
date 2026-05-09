Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A80323BCF7
	for <iommu@lists.linux.dev>; Sat,  9 May 2026 02:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778293286; cv=none; b=pPHyY0UyvQ1bIY5zudACxq/W7lHmsOq+mu+sWjZHvECLyDnlx2FsvX7T685I1KXcVKT9oH3ldFrxn4N25RoTvMpi4qJ86/KQQFFX03W4vlbuQmZ81XPzS0PLS1fEnucejcVTNtPDp55CDJc2u8CPRfMjdpvCPXjXAWcz01hcv1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778293286; c=relaxed/simple;
	bh=EYHygaLXEzen/cX/MOFt4Um+zDLrToLbUAl6lCcmcNY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EfFKLAPRd/WiRiFgWcasHOXcUCIAsy/p1JGDq2S1fUeRV3L5XgF/wA9SH0woxarbYT7nTzWOcv0dNKwqpvezWReTf80lqYbN+iikkcVIVsT1E9oTWJxkzoGtOBgM1LkLlXSof2kD2hkD71XVdTb08CD6ykoPrdmvjpEwyfl3z0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=euZUrpWD; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="euZUrpWD"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778293281; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=yM6gBNBfMjfsnVo2Zphvol5VwDk6zyg7O9ApOWcqZ4g=;
	b=euZUrpWDfCJsDl0Ol48BMdk8DC+Fx/k092tRSdkhl3ZDM/g8q1XHTAn3IYdCQWyHuXeseEL1JvrZ9oplUABy8RKR5TorRdXXn0+31e7ZCP/kW+/BvXx2x1M7/cWW961POTeTKPX7dgfJj7sk/j2e05Gtx565dQn9cCkSY8SEcU0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0X2Z3i8N_1778293278;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X2Z3i8N_1778293278 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 09 May 2026 10:21:20 +0800
From: fangyu.yu@linux.alibaba.com
To: andrew.jones@oss.qualcomm.com
Cc: anup@brainfault.org,
	iommu@lists.linux.dev,
	joro@8bytes.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	palmer@dabbelt.com,
	pjw@kernel.org,
	tjeznach@rivosinc.com,
	will@kernel.org
Subject: Re:  [PATCH 1/2] iommu/riscv: Map IMSIC addresses for paging domains
Date: Sat,  9 May 2026 10:21:13 +0800
Message-Id: <20260509022113.53400-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260508212339.381933-2-andrew.jones@oss.qualcomm.com>
References: <20260508212339.381933-2-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>When IOMMU_DMA is enabled, devices get paging domains and MSI writes
>to IMSIC interrupt files must be handled correctly in the s-stage.
>As the device always writes to the host physical IMSIC addresses,
>which the IMSIC irqchip programs directly, install s-stage identity
>mappings for the host IMSICs. But, use IOMMU_RESV_DIRECT_RELAXABLE
>since the 1:1 mappings aren't required for device assignment.
>
>Loop over the cpus rather than imsic groups to handle asymmetric
>configurations.
>
>Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
>---
> drivers/iommu/riscv/iommu.c         | 34 +++++++++++++++++++++++++++++
> include/linux/irqchip/riscv-imsic.h |  7 ++++++
> 2 files changed, 41 insertions(+)
>
>diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
>index a31f50bbad35..3c6aa9d69f95 100644
>--- a/drivers/iommu/riscv/iommu.c
>+++ b/drivers/iommu/riscv/iommu.c
>@@ -19,6 +19,7 @@
> #include <linux/init.h>
> #include <linux/iommu.h>
> #include <linux/iopoll.h>
>+#include <linux/irqchip/riscv-imsic.h>
> #include <linux/kernel.h>
> #include <linux/pci.h>
> #include <linux/generic_pt/iommu.h>
>@@ -1286,6 +1287,38 @@ static struct iommu_domain *riscv_iommu_alloc_paging_domain(struct device *dev)
> 	return &domain->domain;
> }
>
>+static void riscv_iommu_get_resv_regions(struct device *dev, struct list_head *head)
>+{
>+	const struct imsic_global_config *imsic_global;
>+	unsigned int cpu;
>+
>+	if (!imsic_enabled())
>+		return;
>+
>+	imsic_global = imsic_get_global_config();
>+
>+	for_each_possible_cpu(cpu) {
>+		const struct imsic_local_config *local;
>+		struct iommu_resv_region *reg;
>+
>+		local = per_cpu_ptr(imsic_global->local, cpu);
>+		if (!local->msi_va)
>+			continue;
>+
>+		/*
>+		 * The device always writes to the host physical IMSIC address, so install
>+		 * identity mappings directly. Use IOMMU_RESV_DIRECT_RELAXABLE instead of
>+		 * IOMMU_RESV_DIRECT since these 1:1 mappings are not required for assigned
>+		 * devices.
>+		 */
>+		reg = iommu_alloc_resv_region(local->msi_pa, IMSIC_MMIO_PAGE_SZ,
>+					      IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO,
>+					      IOMMU_RESV_DIRECT_RELAXABLE, GFP_KERNEL);
>+		if (reg)
>+			list_add_tail(&reg->list, head);
>+	}
>+}
>+

Hi Andrew,

Thanks for picking this up -- enabling IOMMU_DMA on RISC-V has been
along-standing gap, and handling the IMSIC MSI mapping is the missing
piece that finally unblocks it.

One concern is that the current implementation emits one 4 KiB
RESV_DIRECT_RELAXABLE region for each possible CPU. On platforms
with hundreds of harts, this noticeably increases the cost of both
.get_resv_regions() and the iommu_create_device_direct_mappings()
walk.

Since interrupt files within one IMSIC group occupy a physically
contiguous range, would it make sense to emit one region per IMSIC
group covering the full group stride, aligned down/up to 2 MiB so
the core can map it as a superpage? This would over-map some padding
within the IMSIC PA window, but RESV_DIRECT_RELAXABLE keeps the
padding out of assigned-device IOVA space, so it looks harmless.

Thanks,
Fangyu

> static int riscv_iommu_attach_blocking_domain(struct iommu_domain *iommu_domain,
> 					      struct device *dev,
> 					      struct iommu_domain *old)
>@@ -1401,6 +1434,7 @@ static const struct iommu_ops riscv_iommu_ops = {
> 	.blocked_domain = &riscv_iommu_blocking_domain,
> 	.release_domain = &riscv_iommu_blocking_domain,
> 	.domain_alloc_paging = riscv_iommu_alloc_paging_domain,
>+	.get_resv_regions = riscv_iommu_get_resv_regions,
> 	.device_group = riscv_iommu_device_group,
> 	.probe_device = riscv_iommu_probe_device,
> 	.release_device	= riscv_iommu_release_device,
>diff --git a/include/linux/irqchip/riscv-imsic.h b/include/linux/irqchip/riscv-imsic.h
>index 4b348836de7a..ba3000f047b0 100644
>--- a/include/linux/irqchip/riscv-imsic.h
>+++ b/include/linux/irqchip/riscv-imsic.h
>@@ -88,6 +88,13 @@ static inline const struct imsic_global_config *imsic_get_global_config(void)
>
> #endif
>
>+static inline bool imsic_enabled(void)
>+{
>+	const struct imsic_global_config *imsic_global = imsic_get_global_config();
>+
>+	return imsic_global && imsic_global->nr_ids;
>+}
>+
> #if IS_ENABLED(CONFIG_ACPI) && IS_ENABLED(CONFIG_RISCV_IMSIC)
> int imsic_platform_acpi_probe(struct fwnode_handle *fwnode);
> struct fwnode_handle *imsic_acpi_get_fwnode(struct device *dev);
>--
>2.43.0
