Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1383D2D8DA3
	for <iommu@lists.linux.dev>; Mon, 13 Apr 2026 11:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776080224; cv=none; b=sN84afzJWfat0Tp6c1lsfw1AF1xleiaeKYKrw5zJplPQt0ii9ik3E6CX/RNwleogmBhfKRvtLcmsGCJMwP2UUu0VW9n/6n7Q2wydhifi7I2OBNChqXCHQa4E0LFZC554OxPrRvftEe9PtWVXEMl2EK1Xz3mswjkd8DLPFiQbSy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776080224; c=relaxed/simple;
	bh=u31WMTZhCVRe+PNsva1h4St1zHrWhdgOsfudYSelL5A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QDtJ0pjH+xlWCCnsN62ZnGfesJ7wvi2t0f4uYwaiJER3NFT0dfuTRtDMuD2YzREQu1VUfSsyU0sIZ+VRAk3i0Jmzk5I2mqbcc6vK+hlULkz5c8+JcmsevIZVk6qB0Hx5hFPKakqnl96xtDeTUnRw7M9zIylc2fh5+q5SECdksCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=P+wJ8HFL; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="P+wJ8HFL"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1776080213; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=AnyIHNbrDxqyBLIAAV2HhBqSqqIJqc6RZL+OmGgzoOQ=;
	b=P+wJ8HFLePWVWCy5JEgT8IEngJpag7mJyXhSnHo4IRhN0hhboQxStBxqKymT5SSOv4f/hqf5v00n6VURTp8sRwKPFvuBV70ZjMV5f0jzAhifmLdWZcV5xiHbsu7f5oZUVqlJdZcDRwKl9cxEPPcWs1ZZG/ZA9x5c4Y6BeS3LFEU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0X0vg84-_1776080210;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X0vg84-_1776080210 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 13 Apr 2026 19:36:51 +0800
From: fangyu.yu@linux.alibaba.com
To: kevin.tian@intel.com
Cc: alex@ghiti.fr,
	aou@eecs.berkeley.edu,
	baolu.lu@linux.intel.com,
	fangyu.yu@linux.alibaba.com,
	guoren@kernel.org,
	iommu@lists.linux.dev,
	jgg@ziepe.ca,
	joro@8bytes.org,
	kvm-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	palmer@dabbelt.com,
	pjw@kernel.org,
	robin.murphy@arm.com,
	tjeznach@rivosinc.com,
	vasant.hegde@amd.com,
	will@kernel.org
Subject: Re: RE: [PATCH 2/2] iommupt: Encode IOMMU_MMIO/IOMMU_CACHE via RISC-V Svpbmt bits  
Date: Mon, 13 Apr 2026 19:36:45 +0800
Message-Id: <20260413113645.28757-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <BN9PR11MB52766502D575970096482F428C242@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <BN9PR11MB52766502D575970096482F428C242@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

>> From: fangyu.yu@linux.alibaba.com <fangyu.yu@linux.alibaba.com>
>> Sent: Saturday, April 11, 2026 10:22 AM
>>
>> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>>
>> When the RISC-V IOMMU page table format support Svpbmt, PBMT provides
>> a way to tag mappings with page-based memory types. Encode memory type
>> via PBMT in RISC-V IOMMU PTEs:
>>
>>   - IOMMU_MMIO   -> PBMT=IO
>>   - !IOMMU_CACHE -> PBMT=NC
>
>In concept IOMMU_CACHE is cleared when IOMMU_MMIO is set. From the
>code PBMT=IO in this case.
>
>So strictly speaking the 2nd line should be:
>
>  - !IOMMU_MMIO && !IOMMU_CACHE -> PBMT=NC
>
>??
>

Agree. I'll clarify the commit message accordingly to avoid implying
that the MMIO case could fall into the NC rule.

>>   - otherwise    -> PBMT=Normal (PBMT=0)
>>
>> Clear the PBMT field before applying the selected encoding, and only
>> touch PBMT when PT_FEAT_RISCV_SVPBMT is advertised.
>>
>> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>> ---
>>  drivers/iommu/generic_pt/fmt/riscv.h | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/iommu/generic_pt/fmt/riscv.h
>> b/drivers/iommu/generic_pt/fmt/riscv.h
>> index a7fef6266a36..02051bb3c6e5 100644
>> --- a/drivers/iommu/generic_pt/fmt/riscv.h
>> +++ b/drivers/iommu/generic_pt/fmt/riscv.h
>> @@ -58,6 +58,8 @@ enum {
>>  	RISCVPT_G = BIT(5),
>>  	RISCVPT_A = BIT(6),
>>  	RISCVPT_D = BIT(7),
>> +	RISCVPT_NC = BIT(61),
>> +	RISCVPT_IO = BIT(62),
>>  	RISCVPT_RSW = GENMASK(9, 8),
>>  	RISCVPT_PPN32 = GENMASK(31, 10),
>
>sort by bit positions
>

Got it, will reorder in v2.

>>
>> @@ -237,6 +239,13 @@ static inline int riscvpt_iommu_set_prot(struct
>> pt_common *common,
>>  		pte |= RISCVPT_R;
>>  	if (!(iommu_prot & IOMMU_NOEXEC))
>>  		pte |= RISCVPT_X;
>> +	if (common->features & BIT(PT_FEAT_RISCV_SVPBMT)) {
>> +		pte &= ~RISCVPT_PBMT;
>
>this is unnecessary due to the earlier assignment:
>
>	pte = RISCVPT_A | RISCVPT_U;
>

As things stand it’s not needed, I'll drop it in v2.

>> +		if (iommu_prot & IOMMU_MMIO)
>> +			pte |= RISCVPT_IO;
>> +		else if (!(iommu_prot & IOMMU_CACHE))
>> +			pte |= RISCVPT_NC;
>> +	}
>>
>>  	/* Caller must specify a supported combination of flags */
>>  	if (unlikely((pte & (RISCVPT_X | RISCVPT_W | RISCVPT_R)) == 0))
>> --
>> 2.50.1

Thanks,
Fangyu
