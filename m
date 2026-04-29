Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E121E22E9
	for <iommu@lists.linux.dev>; Wed, 29 Apr 2026 01:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777427169; cv=none; b=SU7V+dCRJkKUW+26R8OpdLwA6xcLd8u3JgWm3jBm6Cy+jTBGrp6r9Q9h3t9ec2fTTNEn/sMG2P4n2cErTL6Bv1EsyVZwPyqSYcynoXbb4A4Z4nf10vMXg/rFvc1v5ig2+iKKO8sQxbU5G/gC+VC6PHbluzyv0pNbod4gz/XZnbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777427169; c=relaxed/simple;
	bh=2o/xt/0dJyi96I3owp/PKM2S3T6QIdQ/3Gxoiv6ZvL4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B55t6iB9e60XnSGUaDlv3njakIxC7cI/POna2SX92j/JsdfEI7NdU2zfr9n97YYP7O229iGizdqYN0QNcoy0p0jBxdwpy2AHVHN5p4WUlTfIL/fZDdYS5CyZWmLdDYtonbnw+S0T/mQxcl9HfZkZdQ2wlXubQJniImeISfY0Zl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=MNVVKTy4; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="MNVVKTy4"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1777427164; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=0ABfuJZF6yh/Y+/JJ98VtxHR90cMCDZPqGB01IOmkmo=;
	b=MNVVKTy4BEy2Uy0OxIFr7d2ss+z6PuI068CVIHwyyHg9iY8SSVRiDGC5RezhCeQ5yXe27/SsXCHhnFtBSVEMGR8gTL/Qgb2g2Lttw0EGCZTakgCfNj2ZrF2KaviKNNseTtLky1qE+Jvlt6ekJA1PStXVY57LINH83CUz/kw6eFw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R481e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0X1vuOY6_1777427161;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X1vuOY6_1777427161 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 29 Apr 2026 09:46:02 +0800
From: fangyu.yu@linux.alibaba.com
To: jgg@ziepe.ca
Cc: alex@ghiti.fr,
	anup@brainfault.org,
	aou@eecs.berkeley.edu,
	atish.patra@linux.dev,
	baolu.lu@linux.intel.com,
	fangyu.yu@linux.alibaba.com,
	guoren@kernel.org,
	iommu@lists.linux.dev,
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
Subject: Re: Re: [RFC PATCH 08/11] iommu/riscv: Add dirty tracking support for second-stage domains 
Date: Wed, 29 Apr 2026 09:46:00 +0800
Message-Id: <20260429014600.67055-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260428133800.GG849557@ziepe.ca>
References: <20260428133800.GG849557@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

>> @@ -1247,6 +1247,84 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
>>  	return 0;
>>  }
>>  
>> +/*
>> + * Enable or disable hardware A/D bit updates (GADE) in the device context for
>> + * all devices attached to a second-stage domain. When dirty tracking is
>> + * enabled the IOMMU hardware will set the dirty bit in PTEs on write access,
>> + * making them visible to read_and_clear_dirty().
>> + */
>> +static int riscv_iommu_set_dirty_tracking(struct iommu_domain *iommu_domain,
>> +					  bool enable)
>> +{
>> +	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
>> +	struct riscv_iommu_bond *bond;
>> +	struct riscv_iommu_device *iommu, *prev;
>> +	struct riscv_iommu_dc *dc;
>> +	struct iommu_fwspec *fwspec;
>> +	struct riscv_iommu_command cmd;
>> +	u64 tc;
>> +	int i;
>> +
>> +	rcu_read_lock();
>> +
>> +	list_for_each_entry_rcu(bond, &domain->bonds, list) {
>> +		iommu = dev_to_iommu(bond->dev);
>> +		fwspec = dev_iommu_fwspec_get(bond->dev);
>> +
>> +		for (i = 0; i < fwspec->num_ids; i++) {
>> +			dc = riscv_iommu_get_dc(iommu, fwspec->ids[i]);
>> +			tc = READ_ONCE(dc->tc);
>> +			if (!(tc & RISCV_IOMMU_DC_TC_V))
>> +				continue;
>> +
>> +			if (enable)
>> +				tc |= RISCV_IOMMU_DC_TC_GADE;
>> +			else
>> +				tc &= ~RISCV_IOMMU_DC_TC_GADE;
>> +			WRITE_ONCE(dc->tc, tc);
>
>I'm pretty sure you don't need to do this. Just preset GADE when ever
>a S2 domain is attached, rely on the pre-set D to avoid any HW cost
>and you are fine. No need to change it dynamically unless something is
>reall weird about riscv.
>

Thanks, that’s a good suggestion. I will follow that approach: preset GADE
on second-stage domain attach and rely on the core-managed D-bit behavior.

Fangyu

>Jason
