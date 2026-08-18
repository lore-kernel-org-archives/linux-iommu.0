Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121A933F595
	for <iommu@lists.linux.dev>; Tue, 18 Aug 2026 14:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787061834; cv=none; b=uJnwRleeKdwQaf/tcu8O3cxOWXBpfe6z9boeT25QFSeLw+9NlSty3XJgGhSCrkEvHF+ucZN+/gVeCzi3YCSj7AyjIurcPVf4AZuWyaeZjq0CuAxxjdb5H9LJRriYFvmU6yjU8pYdlHK/8eBQ+1eldtnvKdTI7HHuE+lumsIyK2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787061834; c=relaxed/simple;
	bh=Id8JXoQAMD8MYXmg4kZZnB02NF+iNEURWVvRlx4Yjuk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jd5f39P71ZAxQ7UvWOxUz4UC5StPShsf1C4GN+x8xQh4hJA8jmObC9TCeHGPLPLPOqx4xq2CmUY7Qrdq1fsZUj31BlVh31Lai1Ua5wt/K5TrxvCdXkGN1RQjkQ/SETD8erSF29DiAVBl8cNoPVIOTHBGTxDeXEhJVfPtpmH3WBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vM/PZjLR; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vM/PZjLR"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1787061824; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=3+dGJ9oJ4HyGceZTjzfr3Zv2QrruNTe35bavzWX5RY8=;
	b=vM/PZjLRk+G86Cm3UqEJRrULiS3D0UNkhw+suxKR5mUTOfeWkIkav0cAbID18tJ9fCfdrtKLQ+hYJfbArL1IuEaCmxL+RzEwp1kAnheqTHDwpln7DtLEnmbNsrEfFbFO/u+WkIIRlzeT0HQ5mkol/H3noSsRAphUn6wY8A21LcI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0X9DdTDT_1787061820;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X9DdTDT_1787061820 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 18 Aug 2026 22:03:42 +0800
From: fangyu.yu@linux.alibaba.com
To: andrew.jones@oss.qualcomm.com
Cc: alex@ghiti.fr,
	anup@brainfault.org,
	aou@eecs.berkeley.edu,
	atish.patra@linux.dev,
	baolu.lu@linux.intel.com,
	fangyu.yu@linux.alibaba.com,
	guoren@kernel.org,
	iommu@lists.linux.dev,
	jgg@nvidia.com,
	jgg@ziepe.ca,
	joro@8bytes.org,
	kevin.tian@intel.com,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	palmer@dabbelt.com,
	pjw@kernel.org,
	robin.murphy@arm.com,
	skhawaja@google.com,
	tjeznach@rivosinc.com,
	vasant.hegde@amd.com,
	will@kernel.org
Subject: Re: [RFC PATCH v2 07/10] iommu/riscv: Add domain_alloc_paging_flags for second-stage domain 
Date: Tue, 18 Aug 2026 22:03:40 +0800
Message-Id: <20260818140340.48333-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <rzvdgmjkk5rzn4qehsoajmbak7jpssqancyn3mfvpnzf6wyvsc@alyg5a4c2scx>
References: <rzvdgmjkk5rzn4qehsoajmbak7jpssqancyn3mfvpnzf6wyvsc@alyg5a4c2scx>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>On Thu, May 07, 2026 at 07:37:03PM +0800, fangyu.yu@linux.alibaba.com wrote:
>...
>> +	case IOMMU_HWPT_ALLOC_NEST_PARENT:
>> +	case IOMMU_HWPT_ALLOC_DIRTY_TRACKING:
>> +	case IOMMU_HWPT_ALLOC_DIRTY_TRACKING | IOMMU_HWPT_ALLOC_NEST_PARENT:
>> +		/*
>> +		 * Second-stage (iohgatp) page table for KVM VFIO device
>> +		 * pass-through and dirty tracking. The GPA space is 2 bits
>> +		 * wider than the corresponding first-stage VA space (x4 root
>> +		 * page table), so hw_max_vasz_lg2 values are 41/50/59.
>> +		 */
>> +		if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SV57X4) {
>> +			cfg.common.hw_max_vasz_lg2 = 59;
>> +		} else if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SV48X4) {
>> +			cfg.common.hw_max_vasz_lg2 = 50;
>> +		} else if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SV39X4) {
>> +			cfg.common.hw_max_vasz_lg2 = 41;
>> +		} else {
>> +			ret = -ENODEV;
>> +			goto err_free;
>> +		}
>> +		domain->gscid = ida_alloc_range(&riscv_iommu_gscids, 1,
>> +						RISCV_IOMMU_MAX_GSCID, GFP_KERNEL);
>> +		if (domain->gscid < 0) {
>> +			ret = -ENOMEM;
>> +			goto err_free;
>> +		}
>> +		cfg.common.features |= BIT(PT_FEAT_RISCV_S2);
>
>cfg.common.features currently has PT_FEAT_SIGN_EXTEND which isn't correct
>for the second stage. So it needs to removed and then added back in for
>the first stage. riscv_64_kunit_fmt_cfgs[] in the kunit test will then
>need to also be updated.

Thanks, agreed. PT_FEAT_SIGN_EXTEND is only valid for first-stage
VA translation and should not be inherited by iohgatp domains. I'll move
PT_FEAT_SIGN_EXTEND into the first-stage allocation path, leave second-stage
domains with PT_FEAT_RISCV_S2 only, and update the RISC-V KUnit configs
accordingly in next version.

>
>Thanks,
>drew
