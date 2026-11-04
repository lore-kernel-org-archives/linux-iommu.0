Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793793017;
	b=TY9g2ZmK+6a3u03/Oy/8XsoQx/8scAKe/jM82qzy03Ut149STVo9k/WdFLpZsYAP40P4
	 vK9CJUPLbF/4u8f305dSJ5BgE+dd9U/sRguc0Y4lgJbewtGk3ccmZuO+VNv65lSL/9rAS
	 emwtdAu8XaVHXIrMa+z2pzp/muMUPD3+ThudgdFfAm1QkdjPYmNAfFshQqomseAP/Q0ny
	 ALJkEL4ge86XunXrqdd2dTr/UuzZoRIGdGO18h3cEIY0QuwQTmBVimtHBpPWkeIKD59sw
	 /186sJ0xUZvr5LwA1jSQCt4tCMv/HflP5kUb0wFP+sxWLXaL1f2JSkc0ldwXvQNSe1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793793017;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dHmMS48ILVn+iA6DDXmhdMJgbhJve1Nt2JIcHMkfueY=;
	b=yU8esl1pQUFmabZn6eE/BGT2cZn5/x7sXg+Pjfu+2ugAJwZwwrj6nYINJslrL6px0cVF
	 bq6GjMrV+gVaqzqIkVZ3JvJT7QIqpZO8QhnRuRu9Ur7xcwPS8JXYrbmm1+E3ldxr1Sy5Y
	 zyYRg6e2ptuC5mebMJpGnJqtw8mlr2mTcZznQ2DowDP/YvIJOAKleKsy9kcTVNG6EWh3B
	 6DBkKbbrl4fgJ3bAGnSaaxKF7fYuYL9FGcrT2jh4UhHa6eknvHpEChYbQM0Fdk39dF3Pg
	 oEWjsLptZO2wiiU5X0d8BIp8pFLUSzdiTd/2drm+ZT8SSmx4JuNVt9pWIZmfwJ+uQCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b="qcEj/cNz";
	arc=none smtp.remote-ip=115.124.30.133
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB11606A33D
	for <iommu@lists.linux.dev>; Wed,  4 Nov 2026 11:50:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCB11606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=qcEj/cNz
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793793010; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=dHmMS48ILVn+iA6DDXmhdMJgbhJve1Nt2JIcHMkfueY=;
	b=qcEj/cNz6Sp3dAVjfmkj6NnLl1p+uvmSeulbHGWBbf0Q6ciz1rLjSIyufkallqr+0TVoCsyCo1pXvlZVha9hT7ij66IQlpEoDyVUcuRQDQXWuwoOY096etNPP3DHMKoL7PX1aARzh3NiV+AhkmlpEx5g+UaqK7AOvS2mOLpCSBQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R651e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=29;SR=0;TI=SMTPD_---0XE5lrbG_1793793006;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0XE5lrbG_1793793006 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 04 Nov 2026 19:50:08 +0800
From: fangyu.yu@linux.alibaba.com
To: gong.shuai@sanechips.com.cn
Cc: alex@ghiti.fr,
	andrew.jones@linux.dev,
	anup@brainfault.org,
	aou@eecs.berkeley.edu,
	atish.patra@linux.dev,
	baolu.lu@linux.intel.com,
	fangyu.yu@linux.alibaba.com,
	guoren@kernel.org,
	iommu@lists.linux.dev,
	jgg@nvidia.com,
	jgg@ziepe.ca,
	joerg.roedel@amd.com,
	joro@8bytes.org,
	jroedel@suse.de,
	kevin.tian@intel.com,
	kvm-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	nutty.liu@hotmail.com,
	palmer@dabbelt.com,
	pjw@kernel.org,
	robin.murphy@arm.com,
	skhawaja@google.com,
	tanchi25@mails.ucas.ac.cn,
	tomasz.jeznach@linux.dev,
	vasant.hegde@amd.com,
	will@kernel.org,
	zong.li@sifive.com
Subject: Re: [PATCH v7 09/10] iommu/riscv: Add dirty tracking support for second-stage domains 
Date: Wed,  4 Nov 2026 19:50:01 +0800
Message-Id: <20261104115001.71362-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261104084503.118083-1-gong.shuai@sanechips.com.cn>
References: <20261104084503.118083-1-gong.shuai@sanechips.com.cn>
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

>Hi Fangyu,
>
>> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>> 
>> Add hardware dirty tracking support for second-stage (iohgatp) domains
>> used in KVM VFIO device pass-through.
>> 
>> The RISC-V IOMMU can automatically set the dirty bit in PTEs on write
>> access when DC.tc.GADE is set and the hardware has AMO_HWAD capability.
>> Wire this up to the iommufd dirty tracking interface:
>> 
>>   - riscv_iommu_set_dirty_tracking(): Return success without toggling GADE.
>> 
>>   - riscv_iommu_dirty_ops: Exposes set_dirty_tracking and the generic
>>     page-table read_and_clear_dirty via IOMMU_PT_DIRTY_OPS(riscv_64).
>> 
>>   - domain_alloc_paging_flags: Assigns dirty_ops to second-stage domains
>>     when IOMMU_HWPT_ALLOC_DIRTY_TRACKING is requested.
>> 
>>   - riscv_iommu_capable: Reports IOMMU_CAP_DIRTY_TRACKING when
>>     AMO_HWAD is present.
>> 
>> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>> Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
>> ---
>>  drivers/iommu/riscv/iommu.c | 32 ++++++++++++++++++++++++++++++--
>>  1 file changed, 30 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
>> index b3f05dfdf278..ff1043afe973 100644
>> --- a/drivers/iommu/riscv/iommu.c
>> +++ b/drivers/iommu/riscv/iommu.c
>> @@ -1350,6 +1350,10 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
>>  	if (domain->gscid) {
>>  		if (!riscv_iommu_iohgatp_supported(iommu, pt_info.iohgatp_mode))
>>  			return -EINVAL;
>> +		/* Dirty tracking requires AMO_HWAD on every attached IOMMU */
>> +		if (iommu_domain->dirty_ops &&
>> +		    !(iommu->caps & RISCV_IOMMU_CAPABILITIES_AMO_HWAD))
>> +			return -EINVAL;
>>  
>>  		dc.iohgatp =
>>  			FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_MODE, pt_info.iohgatp_mode) |
>> @@ -1377,6 +1381,21 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
>>  	return 0;
>>  }
>>  
>> +static int riscv_iommu_set_dirty_tracking(struct iommu_domain *iommu_domain,
>> +					  bool enable)
>> +{
>> +	/*
>> +	 * Always enabled and the dirty bitmap is cleared prior to
>> +	 * set_dirty_tracking().
>> +	 */
>> +	return 0;
>> +}
>> +
>> +static const struct iommu_dirty_ops riscv_iommu_dirty_ops = {
>> +	IOMMU_PT_DIRTY_OPS(riscv_64),
>> +	.set_dirty_tracking = riscv_iommu_set_dirty_tracking,
>> +};
>> +
>>  static const struct iommu_domain_ops riscv_iommu_paging_domain_ops = {
>>  	IOMMU_PT_DOMAIN_OPS(riscv_64),
>>  	.attach_dev = riscv_iommu_attach_paging_domain,
>> @@ -1418,7 +1437,8 @@ static int riscv_iommu_init_domain_s1(struct device *dev,
>>   */
>>  static int riscv_iommu_init_domain_s2(struct device *dev,
>>  				      struct riscv_iommu_domain *domain,
>> -				      struct pt_iommu_riscv_64_cfg *cfg)
>> +				      struct pt_iommu_riscv_64_cfg *cfg,
>> +				      u32 flags)
>>  {
>>  	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
>>  
>> @@ -1439,6 +1459,10 @@ static int riscv_iommu_init_domain_s2(struct device *dev,
>>  	if (domain->gscid < 0)
>>  		return -ENOMEM;
>>  
>> +	/* AMO_HWAD is checked by iommufd via IOMMU_CAP_DIRTY_TRACKING */
>> +	if (flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING)
>> +		domain->domain.dirty_ops = &riscv_iommu_dirty_ops;
>> +
>>  	return 0;
>>  }
>>  
>> @@ -1481,7 +1505,7 @@ riscv_iommu_domain_alloc_paging_flags(struct device *dev, u32 flags,
>>  	case IOMMU_HWPT_ALLOC_NEST_PARENT:
>>  	case IOMMU_HWPT_ALLOC_DIRTY_TRACKING:
>>  	case IOMMU_HWPT_ALLOC_DIRTY_TRACKING | IOMMU_HWPT_ALLOC_NEST_PARENT:
>> -		ret = riscv_iommu_init_domain_s2(dev, domain, &cfg);
>> +		ret = riscv_iommu_init_domain_s2(dev, domain, &cfg, flags);
>>  		break;
>>  	default:
>>  		ret = -EOPNOTSUPP;
>> @@ -1559,9 +1583,13 @@ static struct iommu_group *riscv_iommu_device_group(struct device *dev)
>>  
>>  static bool riscv_iommu_capable(struct device *dev, enum iommu_cap cap)
>>  {
>> +	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
>> +
>>  	switch (cap) {
>>  	case IOMMU_CAP_CACHE_COHERENCY:
>>  		return dev_is_dma_coherent(dev);
>> +	case IOMMU_CAP_DIRTY_TRACKING:
>> +		return !!(iommu->caps & RISCV_IOMMU_CAPABILITIES_AMO_HWAD);
>
>I'm not quite sure about this. Could there be a device that supports
>AMO_HWAD but not any of the S2 modes? GET_HW_INFO would report
>DIRTY_TRACKING as supported, but HWPT_ALLOC would then fail in
>riscv_iommu_init_domain_s2(). Should this check also include the
>S2 modes, like
>
>    AMO_HWAD && (SV39X4|SV48X4|SV57X4) ?
>

Good question, I had also considered this.

From the IOMMU spec alone, I could not confirm whether
AMO_HWAD implies support for S2 modes.

However, I found this statement in the IOMMU spec:

"The IOMMU must support all the virtual memory
extensions that are supported by any of the harts in
the system."

For virtualization scenarios, we assume the CPU hart
must support at least one S2 mode (hgatp). From this
perspective, the IOMMU should support at least one S2
mode in a virtualization setup, regardless of
AMO_HWAD.

>BTW, in riscv_iommu_init_domain_s1/s2, why not return -EOPNOTSUPP
>instead of -ENODEV for "cannot find supported page table mode"?
>

I used -ENODEV to follow the existing S1 behavior:
no compatible paging mode is available on this IOMMU.

While -EOPNOTSUPP would also be reasonable, I suggest
keeping S1 and S2 consistent and leaving this unchanged
in this series.

Thanks,
Fangyu

>Thanks,
>Shuai
>
>>  	default:
>>  		return false;
>>  	}
>> -- 
>> 2.50.1
>> 
