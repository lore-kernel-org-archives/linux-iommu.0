Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD942D738F
	for <iommu@lists.linux.dev>; Fri, 16 Oct 2026 03:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792119713; cv=none; b=bzMjLJO46Rc3jOuOXgj8gcIhhcyDc5N9RgYGAxIYBSwjhmofouioUaHCqZNA32HksoYQrXxpCMBHV5ZbsqExxipBk+UEPdy1o1Iuie2p/7Rric8iL98P1GF08pacxaBU/tcEAo6hSNiQc+vqssdplSIoSrDimQjifQwBJPP5f0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792119713; c=relaxed/simple;
	bh=0v039CvrPkfYK3JQLaQF5YFH8+rzT6W/53Fw5Z25W8I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T+5vGdrz98VRMj5n4pJtyd+Adl23SRSwVS9CW9cf4f+SLyo3GzV3Fp8MUkpPyrWe+RGcZzu6pZwEuYynS6ah7XVK3voY3vMcQK/jleH+ZbtXnpTcxnPnQq20KFmfeyyQMTIzbn/+JP5224U0wahBfeJWBsfNsb+9b/byRtB+AtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=f1LQ2GSw; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="f1LQ2GSw"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1792119703; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=mrYD4Xmw9JmUEwP1jk5CPITT3K8gC8rF0fjahbJTkBU=;
	b=f1LQ2GSwkkcoDs8AMQTuJmUVphd7My4b2l29ibY8YipeIOyMv1GUxFTXO0lntVyqvKvYuBbUDKoaSQb26GC+bgTBNOUPX+h3MwfAtcUbklKTglZ9m7RLrgWKF5HNYMaPJb2MLSOcCr3fvudQ1NPmAQrMCdDKBNh/Tp8C3BiQkGg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R491e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0XCtC-XB_1792119699;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0XCtC-XB_1792119699 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 16 Oct 2026 11:01:41 +0800
From: fangyu.yu@linux.alibaba.com
To: jgg@nvidia.com
Cc: alex@ghiti.fr,
	andrew.jones@oss.qualcomm.com,
	aou@eecs.berkeley.edu,
	fangyu.yu@linux.alibaba.com,
	gsh517025@gmail.com,
	guoren@kernel.org,
	iommu@lists.linux.dev,
	jgg@ziepe.ca,
	joro@8bytes.org,
	jroedel@suse.de,
	kvm-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	palmer@dabbelt.com,
	pjw@kernel.org,
	robin.murphy@arm.com,
	tomasz.jeznach@linux.dev,
	will@kernel.org,
	zong.li@sifive.com
Subject: Re: [RFC PATCH v2 3/4] iommu/riscv: Add guest IMSIC GPA mapping helpers
Date: Fri, 16 Oct 2026 11:01:38 +0800
Message-Id: <20261016030138.91675-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <179210803193.58760.10996339526486124321.b4-reply@b4>
References: <179210803193.58760.10996339526486124321.b4-reply@b4>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>>
>> IOMMU implementations without the MSI_FLAT capability translate MSI
>> writes through the second-stage page table, so IRQ forwarding on them
>> will need guest IMSIC pages mapped into the second-stage domain.
>>
>> Add an xarray to the MSI table that tracks the HPA installed for each
>> mapped guest IMSIC GPA, and two helpers for use with the MSI table lock
>> held: riscv_iommu_msi_table_map_gpa() installs the initial 4 KiB
>> mapping, and riscv_iommu_msi_table_replace_gpa() repoints the leaf PTE
>> when a vCPU's VS-file host page moves, using the generic page table
>> replace_leaf op instead of walking the table in the driver.
>>
>> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>> ---
>>  drivers/iommu/riscv/iommu.c | 43 +++++++++++++++++++++++++++++++++++++
>>  drivers/iommu/riscv/iommu.h | 12 +++++++++++
>>  2 files changed, 55 insertions(+)
>>
>> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
>> index e2e77469ea3c..88e131ce96c1 100644
>> --- a/drivers/iommu/riscv/iommu.c
>> +++ b/drivers/iommu/riscv/iommu.c
>> @@ -1217,6 +1217,42 @@ void riscv_iommu_msi_table_inval_all(struct riscv_iommu_msi_table *msi_table)
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
>
>Andrew has moved well past a v3
>
>I shouldn't be seeing code in iommu or irq drivers directly mapping into
>domains. That doesn't work, Andrew's latest series don't do this.
>
>It still needs to use the SW_MSI mechanism and related.
>

Andrew has posted two patch series in the community: one is the
MSI remap v6 series[1], and another is the IRQ bypass v3 series[2].
I think you are referring to the MSI remap v6 series. My patch was
based on the IRQ bypass v3 series, and I added this patch on top
of it.

[1] https://lore.kernel.org/linux-iommu/179209292714.4133959.5997128071302263244.b4-review@b4/T/#t
[2] https://lore.kernel.org/linux-riscv/20260928143113.49838-1-andrew.jones@oss.qualcomm.com/

>Nothing in the commit messages clearly explained what this is actually for
>without having to go dig up the riscv manuals again. Please explain how the
>interrupt translation works and what actual user visible problem this is
>trying to solve is.
>

The interrupt translation is based on Andrew's irq bypass patch
description.

RISC-V IOMMU defines an optional MSI page table feature, which can
be used to implement irq bypass by translating the vIMSIC GPA to
the pIMSIC HPA.

My patch complements that design. If the RISC-V IOMMU hardware does
not implement the MSI page table, then the second-stage page table
can be used instead to map vIMSIC GPA to pIMSIC HPA.

Thanks,
Fangyu

>--
>Jason
