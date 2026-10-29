Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793238090;
	b=aI+7BtbCaLcQYFRaXkv8gXedwicpPNMHsoxBw38AV/MYmo4F1txGiDKlGeQ6ZxPgX+jz
	 T+FEmOScpSeGigUSHZVHQdWhf6z2KSXd1PCM9Sx75ICkce9g9QWAcMPuon6adBbTOArhg
	 ucqNlRcOcE0w0BOo3om92AVBolaOogRCDaqf4mtCnZEzVXyWOD/m2ML2bvm5PctK8uYWU
	 UyIGBi715uUMPczBMmIN2sO+YzBK7Kcmqox4vLDjmqjOJSyGnrnZEgYllSC0zPO4tdLul
	 UOxXZEb1py6V+WLZs+Ga4EhVD2JptIRXTzMq1avsfqntOCR6h09jpR3e+w7xTHHaySg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793238090;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=C7QU0MynSPZH9XIFESMQueT1x5DIy1wAFQgauvOVdHE=;
	b=ZtEBDju7TwkO+yNXXCGY3BBkdy7qLo97lilyAnHhYTsnj0PmAkMYoK1kfJE75RHI/XLm
	 J0Zn2UMQStqq2+WMouvo4oZsfZh2d1WfnN4Yuu8wN2Ey9mD9AgH9AF4QhTagVry/HqGRt
	 A8M6HP/OUmnleYl6w7p3HHbS+0haYEnZEXoqBHbztomL+f9a8FtBK1wE+BNyEOvimFXh+
	 jVDeLqUBepquSmPluD6aijw3QPFp3JiCehjcLm4rNkPZZul7JWWy5QmNWJ304Yz5+1iN2
	 m9yone+hx3wnYsxhLLAXycFT+ZaanOvbv85J3mZC/HcRW8qo7o/y1LWNVNi8Js4lg9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b="v/6d4aMX";
	arc=none smtp.remote-ip=115.124.30.98
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BA9606A31D
	for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 01:41:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16BA9606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=v/6d4aMX
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793238085; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=C7QU0MynSPZH9XIFESMQueT1x5DIy1wAFQgauvOVdHE=;
	b=v/6d4aMXYaOr7ue/G5H372yJbrktzf5kEgEBixMVm2NoqF425JpYLJpAZd0vge3HGNtMIQIC2oGEZb0MzdSGQttU+wZ4mjZJTCnokkViqFnxerl7AFgzVpjCT+4s24jAEX8+x6LbZPpJY0e+qe3auCwfFCUx7Nxg2pq2UG+OWI0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0XDhzCnt_1793238081;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0XDhzCnt_1793238081 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 29 Oct 2026 09:41:23 +0800
From: fangyu.yu@linux.alibaba.com
To: jgg@nvidia.com
Cc: alex@ghiti.fr,
	andrew.jones@linux.dev,
	anup@brainfault.org,
	aou@eecs.berkeley.edu,
	atish.patra@linux.dev,
	baolu.lu@linux.intel.com,
	fangyu.yu@linux.alibaba.com,
	gong.shuai@sanechips.com.cn,
	guoren@kernel.org,
	iommu@lists.linux.dev,
	jgg@ziepe.ca,
	joerg.roedel@amd.com,
	joro@8bytes.org,
	jroedel@suse.de,
	kevin.tian@intel.com,
	kvm-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	palmer@dabbelt.com,
	pjw@kernel.org,
	robin.murphy@arm.com,
	skhawaja@google.com,
	tanchi25@mails.ucas.ac.cn,
	tomasz.jeznach@linux.dev,
	vasant.hegde@amd.com,
	will@kernel.org,
	zong.li@sifive.com
Subject: Re: [RFC PATCH v5 07/10] iommu/riscv: Add domain_alloc_paging_flags for second-stage domain  
Date: Thu, 29 Oct 2026 09:41:17 +0800
Message-Id: <20261029014117.80953-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <179320128834.2412245.6365239689333877950.b4-review@b4>
References: <179320128834.2412245.6365239689333877950.b4-review@b4>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>> [ ... 22 lines skipped ... ]
>> -static struct iommu_domain *riscv_iommu_alloc_paging_domain(struct device *dev)
>> +static struct iommu_domain *
>> +riscv_iommu_domain_alloc_paging_flags(struct device *dev, u32 flags,
>> +				      const struct iommu_user_data *user_data)
>>  {
>>  	struct pt_iommu_riscv_64_cfg cfg = {};
>>  	struct riscv_iommu_domain *domain;
>>  	struct riscv_iommu_device *iommu;
>>  	int ret;
>> +	const u32 supported_flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING |
>> +				    IOMMU_HWPT_ALLOC_NEST_PARENT;
>>
>> -	iommu = dev_to_iommu(dev);
>> -	if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SV57) {
>> -		cfg.common.hw_max_vasz_lg2 = 57;
>> -	} else if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SV48) {
>> -		cfg.common.hw_max_vasz_lg2 = 48;
>> -	} else if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SV39) {
>> -		cfg.common.hw_max_vasz_lg2 = 39;
>> -	} else {
>> -		dev_err(dev, "cannot find supported page table mode\n");
>> -		return ERR_PTR(-ENODEV);
>> -	}
>> -	cfg.common.hw_max_oasz_lg2 = 56;
>> +	if (flags & ~supported_flags)
>> +		return ERR_PTR(-EOPNOTSUPP);
>
>This probably isn't needed since the switch checks it?
>

Right, the switch already enumerates all valid combinations, and
the default case returns -EOPNOTSUPP, so this check is
redundant. I'll drop it, along with supported_flags, in v6.

>> [ ... 30 lines skipped ... ]
>> +	switch (flags) {
>> +	case 0:
>> +		cfg.common.features |= BIT(PT_FEAT_SIGN_EXTEND);
>> +		if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SV57) {
>> +			cfg.common.hw_max_vasz_lg2 = 57;
>> +		} else if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SV48) {
>> +			cfg.common.hw_max_vasz_lg2 = 48;
>> +		} else if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SV39) {
>> +			cfg.common.hw_max_vasz_lg2 = 39;
>> +		} else {
>> +			ret = -ENODEV;
>> +			goto err_free;
>> +		}
>> +		domain->pscid = ida_alloc_range(&riscv_iommu_pscids, 1,
>> +						RISCV_IOMMU_MAX_PSCID, GFP_KERNEL);
>> +		if (domain->pscid < 0) {
>> +			ret = -ENOMEM;
>> +			goto err_free;
>> +		}
>> +		break;
>
>I'd prefer you make functions riscv_iommu_init_domain_s1/s2() to put
>this in, it will be clearer
>

Agreed. In v6, I will move the page table mode selection, the
PSCID/GSCID allocation, and the stage-specific feature bits
into riscv_iommu_init_domain_s1/s2().

Thanks,
Fangyu

>It looks ok otherwise
>
>Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>
>--
>Jason
