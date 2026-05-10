Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02BC39C645
	for <iommu@lists.linux.dev>; Sun, 10 May 2026 14:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778424060; cv=none; b=rJ9g4lPp3DqpfhkY1dyzCAX89dBtaqjUo4er7JvMpKsra8zQLbKk1aDXNq+ua/hmqYxehAPg5EVwYCOWGuGZBkwvhtC227eU3W1pouwtUsHwwk6akyEw2y3ildSRiyA9NORx+gM3LtE2TgZEhzHqBNFUDXEEV9t8kqnZmjGsU40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778424060; c=relaxed/simple;
	bh=DJvPcNnxSjxkGj7lDXtDd+kqdKUOvgDmtsXYiFAuCBE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rGIsivufLznuocNmE56AREjl/ztWrWpu33YZadVQKkhxWDZF1iy/d/hOhUOYsVJ75iEt0IMkuMU9Lj0uFjnG8muSqBsrMBbf7K3uiIlB0o17qLLtKNtlpEoxhEB4ZyZjYTCVb/1+QBGk0iKeCTftjO8KjTG88FHn3VkjT1G84Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Cb2rFDwR; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Cb2rFDwR"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778424048; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=R6vTP+75SxlXoCmcc8VJ7xs6oTFPgGOP+Sy2kcFXi10=;
	b=Cb2rFDwRgbo9ExQnFWG/V/wmivICAKGjC3iAH7GLL6cJj/BgWdjCflJJtAPyMrdxRLa17Q8xA6NNHFSYckbGwhO4jUJZD8Ijqwyrr/LfmLkaVjOTg9srLXjYR4HJBtQxMMf2Bd7VJqPwPeq72Q8RcPC6eFFH7oru5fMSXDOK53k=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0X2cswKI_1778424045;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X2cswKI_1778424045 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 10 May 2026 22:40:47 +0800
From: fangyu.yu@linux.alibaba.com
To: andrew.jones@oss.qualcomm.com
Cc: anup@brainfault.org,
	fangyu.yu@linux.alibaba.com,
	iommu@lists.linux.dev,
	joro@8bytes.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	palmer@dabbelt.com,
	pjw@kernel.org,
	tjeznach@rivosinc.com,
	will@kernel.org
Subject: Re: Re: [PATCH 1/2] iommu/riscv: Map IMSIC addresses for paging domains 
Date: Sun, 10 May 2026 22:40:38 +0800
Message-Id: <20260510144038.54523-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <fhv3w4kmxd5kw26kdlj4uj7cgr5mhov7rytph6dedokdpe36d4@svjdhnilgnwe>
References: <fhv3w4kmxd5kw26kdlj4uj7cgr5mhov7rytph6dedokdpe36d4@svjdhnilgnwe>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>> >When IOMMU_DMA is enabled, devices get paging domains and MSI writes
>> >to IMSIC interrupt files must be handled correctly in the s-stage.
>> >As the device always writes to the host physical IMSIC addresses,
>> >which the IMSIC irqchip programs directly, install s-stage identity
>> >mappings for the host IMSICs. But, use IOMMU_RESV_DIRECT_RELAXABLE
>> >since the 1:1 mappings aren't required for device assignment.
>> >
>> >Loop over the cpus rather than imsic groups to handle asymmetric
>> >configurations.
>> >
>> >Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
>> >---
>> > drivers/iommu/riscv/iommu.c         | 34 +++++++++++++++++++++++++++++
>> > include/linux/irqchip/riscv-imsic.h |  7 ++++++
>> > 2 files changed, 41 insertions(+)
>> >
>> >diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
>> >index a31f50bbad35..3c6aa9d69f95 100644
>> >--- a/drivers/iommu/riscv/iommu.c
>> >+++ b/drivers/iommu/riscv/iommu.c
>> >@@ -19,6 +19,7 @@
>> > #include <linux/init.h>
>> > #include <linux/iommu.h>
>> > #include <linux/iopoll.h>
>> >+#include <linux/irqchip/riscv-imsic.h>
>> > #include <linux/kernel.h>
>> > #include <linux/pci.h>
>> > #include <linux/generic_pt/iommu.h>
>> >@@ -1286,6 +1287,38 @@ static struct iommu_domain *riscv_iommu_alloc_paging_domain(struct device *dev)
>> > 	return &domain->domain;
>> > }
>> >
>> >+static void riscv_iommu_get_resv_regions(struct device *dev, struct list_head *head)
>> >+{
>> >+	const struct imsic_global_config *imsic_global;
>> >+	unsigned int cpu;
>> >+
>> >+	if (!imsic_enabled())
>> >+		return;
>> >+
>> >+	imsic_global = imsic_get_global_config();
>> >+
>> >+	for_each_possible_cpu(cpu) {
>> >+		const struct imsic_local_config *local;
>> >+		struct iommu_resv_region *reg;
>> >+
>> >+		local = per_cpu_ptr(imsic_global->local, cpu);
>> >+		if (!local->msi_va)
>> >+			continue;
>> >+
>> >+		/*
>> >+		 * The device always writes to the host physical IMSIC address, so install
>> >+		 * identity mappings directly. Use IOMMU_RESV_DIRECT_RELAXABLE instead of
>> >+		 * IOMMU_RESV_DIRECT since these 1:1 mappings are not required for assigned
>> >+		 * devices.
>> >+		 */
>> >+		reg = iommu_alloc_resv_region(local->msi_pa, IMSIC_MMIO_PAGE_SZ,
>> >+					      IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO,
>> >+					      IOMMU_RESV_DIRECT_RELAXABLE, GFP_KERNEL);
>> >+		if (reg)
>> >+			list_add_tail(&reg->list, head);
>> >+	}
>> >+}
>> >+
>> 
>> Hi Andrew,
>> 
>> Thanks for picking this up -- enabling IOMMU_DMA on RISC-V has been
>> along-standing gap, and handling the IMSIC MSI mapping is the missing
>> piece that finally unblocks it.
>> 
>> One concern is that the current implementation emits one 4 KiB
>> RESV_DIRECT_RELAXABLE region for each possible CPU. On platforms
>> with hundreds of harts, this noticeably increases the cost of both
>> .get_resv_regions() and the iommu_create_device_direct_mappings()
>> walk.
>> 
>> Since interrupt files within one IMSIC group occupy a physically
>> contiguous range, would it make sense to emit one region per IMSIC
>> group covering the full group stride, aligned down/up to 2 MiB so
>> the core can map it as a superpage? This would over-map some padding
>> within the IMSIC PA window, but RESV_DIRECT_RELAXABLE keeps the
>> padding out of assigned-device IOVA space, so it looks harmless.
>> 
>
>Hi Fangyu,
>
>Thanks for pointing out this issue. We'll need to decide how much we
>want to isolate the devices from VMs in order to address it, though,
>because, if we do group mappings, then we'll also be exposing the guest
>interrupt files to the devices.
>
>I'll certainly send a v2 to do larger mappings when s-mode imsics are
>contiguous (nr-guest-files = 0) and then we can consider creating a
>way to opt-in to group mappings even when nr-guest-files != 0. How's
>that sound?
>

Hi Andrew,

As you mentioned, my suggestion could also expose the guest interrupt
files to the device-visible/mappable range, but the current approach
already appears to provide only limited isolation. So I think this
change would not materially increase the risk.

In any case, I respect your decision, and we can certainly proceed
with your current suggestion for now.

Thanks,
Fangyu

>Thanks,
>drew
