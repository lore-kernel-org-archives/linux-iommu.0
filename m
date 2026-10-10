Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F004921B3
	for <iommu@lists.linux.dev>; Sat, 10 Oct 2026 11:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791631135; cv=none; b=G8v2aGctNY9w+IA8MXjc5D5yRIjxdqZ61BNj5RMT/VlorVntyaCer3IxP5KaBW74M8DPaWO4OhyvoakJmXjuarX+B/1Vt4WVSAVrJD8QEMZD7+mHItgl6O6tcR5xn0+QMd60O+hvloSgbFUMDwYJhzc7yiumctpv+DJXro81wu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791631135; c=relaxed/simple;
	bh=GtR97k52fW24BvTxl7zSOu6cuY5tK107uL87nymf4ts=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s+VfrBrvwH5/xN6nWs+pr8kTf0niXyzZU9QSW2vRuz6AWImXjvQvfRYitJiAoOc/X96Ftq4ZZyerdXQer12sFrl+htkJ6e+l9zpNkREbmZrCWADH8ZOiBS1hThiRlcX6qo28+TEankvkvkuid2U7kUQRptgGg0iOEsRJgrxnZRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xZ0VYWq2; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xZ0VYWq2"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1791631122; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=uj4FOYScpotQbXUx+KxSCAB7RY2odrIAyrg6q0KBZbw=;
	b=xZ0VYWq2c9ktXWkvPzaMwb7zWyaheGwHl9LUpV610Nb20GO8+KGT8Bk6EBSLUOfMB6mTpZM18ufr+8PnEXWkw73soZ7xq1m2bC4uPWKC2rTGVnop03ziCt4f/kCTwy4myPXeHie2RUrnpuOn/P5kdu/F3e0qEo32PUr1xaECB4Y=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0XCVxUq2_1791631118;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0XCVxUq2_1791631118 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 10 Oct 2026 19:18:40 +0800
From: fangyu.yu@linux.alibaba.com
To: gong.shuai@sanechips.com.cn
Cc: alex@ghiti.fr,
	andrew.jones@oss.qualcomm.com,
	aou@eecs.berkeley.edu,
	fangyu.yu@linux.alibaba.com,
	gsh517025@gmail.com,
	guoren@kernel.org,
	iommu@lists.linux.dev,
	jgg@nvidia.com,
	jgg@ziepe.ca,
	joro@8bytes.org,
	kvm-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	palmer@dabbelt.com,
	pjw@kernel.org,
	robin.murphy@arm.com,
	tomasz.jeznach@linux.dev,
	will@kernel.org,
	zong.li@sifive.com
Subject: Re: [RFC PATCH 1/3] iommu/riscv: Add guest IMSIC GPA mapping helpers
Date: Sat, 10 Oct 2026 19:18:37 +0800
Message-Id: <20261010111837.15424-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <202610090853.6998rsRH081065@mse-db.zte.com.cn>
References: <202610090853.6998rsRH081065@mse-db.zte.com.cn>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>Hi Fangyu,
>
>> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>>
>> IOMMU implementations without the MSI_FLAT capability translate MSI
>> writes through the second-stage page table, so IRQ forwarding on them
>> will need guest IMSIC pages mapped into the second-stage domain.
>>
>> Add an xarray to the MSI table that tracks the HPA installed for each
>> mapped guest IMSIC GPA, and two helpers for use with the MSI table lock
>> held: riscv_iommu_msi_table_map_gpa() installs the initial 4 KiB
>> mapping, and riscv_iommu_msi_table_replace_gpa_leaf() atomically swaps
>> the leaf PTE's PFN when a vCPU's VS-file host page moves, rejecting
>> leaves that do not map the expected old HPA.
>>
>> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>> ---
>>  drivers/iommu/riscv/iommu.c | 94 +++++++++++++++++++++++++++++++++++++
>>  drivers/iommu/riscv/iommu.h | 12 +++++
>>  2 files changed, 106 insertions(+)
>>
>> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
>> index e2e77469ea3c..48fc57d6409c 100644
>> --- a/drivers/iommu/riscv/iommu.c
>> +++ b/drivers/iommu/riscv/iommu.c
>> @@ -24,6 +24,7 @@
>>  #include <linux/moduleparam.h>
>>  #include <linux/mutex.h>
>>  #include <linux/pci.h>
>> +#include <linux/pgtable.h>
>>  #include <linux/generic_pt/iommu.h>
>>
>>  #include "../dma-iommu.h"
>> @@ -1217,6 +1218,92 @@ void riscv_iommu_msi_table_inval_all(struct riscv_iommu_msi_table *msi_table)
>>  	riscv_iommu_iotlb_inval(domain, &gather);
>>  }
>>
>> +int riscv_iommu_msi_table_map_gpa(struct riscv_iommu_msi_table *msi_table,
>> +				  dma_addr_t gpa, phys_addr_t hpa)
>> +{
>> +	struct riscv_iommu_domain *domain =
>> +		container_of(msi_table, struct riscv_iommu_domain, msi_table);
>> +	const int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
>> +
>> +	/* Guest IMSIC GPA mapping only exists in second-stage translations. */
>> +	if (!domain->gscid)
>> +		return -EOPNOTSUPP;
>> +
>> +	return iommu_map(&domain->domain, gpa, hpa, IMSIC_MMIO_PAGE_SZ, prot,
>> +			 GFP_ATOMIC);
>> +}
>> +
>> +int riscv_iommu_msi_table_replace_gpa_leaf(struct riscv_iommu_msi_table *msi_table,
>> +					   dma_addr_t gpa, phys_addr_t old_hpa,
>> +					   phys_addr_t new_hpa)
>
>
>This might fit better inside generic_pt rather than in the driver,
>since it walks the page tables on its own and duplicates things
>the library already owns, like the per-level index widths, the
>x4 root size, and the PTE layout.
>
>I recently tried something very similar, and doing this inside
>generic_pt turned out to be quite feasible (only a quick experiment,
>not cleaned up for posting).
>

Hi Shuai,

Thanks for the review. I agree the driver shouldn't carry format
knowledge that belongs to the library, but I think this particular
operation doesn't fit generic_pt.

This is not a generic page-table operation. It is a special
requirement of RISC-V IOMMU IRQ forwarding (irqbypass) on
implementations without an MSI page table: the guest IMSIC GPA
must be mapped into the second-stage domain, and when a vCPU's
VS-file host page migrates, its leaf must be replaced atomically.
Because a device may write an MSI at any moment, unmap + map
would fault. This operation is driven by the IRQ forwarding
state machine, and because I don't see another generic_pt format
sharing this flow, I think these helpers would be better placed
outside generic_pt. I plan to move them into iommu-ir.c so the
feature-scoped code stays together.

Thanks,
Fangyu

>Thanks,
>Shuai
