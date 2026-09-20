Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D812BEFEB
	for <iommu@lists.linux.dev>; Sun, 20 Sep 2026 03:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789873741; cv=none; b=K11QapIVQ/Zz3fd/9RHie5ZaFmV5ol1clkArFLuf9/nwxBN3pGCJw4GAJzcX6n/vbSuBjDKSLO4v+p7dM4DhJ4stTphRYGutQCffAi1Y0d0fgmS7+UVj0NOaQtwKbVByO38Acn/J/rcEEQTpd5f2JiyEjSQJYMLMCkBJ3jnKelY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789873741; c=relaxed/simple;
	bh=GdC1OedL/4ySIzhuKX/hmq9lsGc6pa3Kd7GQt7te8gM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aZiIkvJwp5Kf8EbpKEk3ept/Ir9wUJBm4YndEays60ajoAPRHHQp3ZJeLvd16I5GVrLjT16ELfoi/PGWqitiQBakXNLYDDd4JmcizSNJGV4suqs4tzkKgtv98sz5Zq0ikbKzEkak/aDepWJ6VbnCj0g6aTOSIkyv9RMHeQfunpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ir6zAVyY; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ir6zAVyY"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1789873730; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=wjTZldjz1iDULhUhQBqLiB6G8Q6aBj6HV95v1HhDU/I=;
	b=ir6zAVyYKMVLLMWCwdx6kpHi4PDSA9tFahWH7DQ0IKCOXsV7FiCzqW61POaATls2yy2l1WDuKZK8VSnMmyy//1B7TEGGjpA5y3ZqfNalOtymGN7aGZF5OSYEDdkO0XRDQ0FhyCwVbFeIRyxEe+CFU2J8OOyhwsrIoN8UHy+GnV8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R461e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0XBErkLX_1789873726;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0XBErkLX_1789873726 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 20 Sep 2026 11:08:48 +0800
From: fangyu.yu@linux.alibaba.com
To: gsh517025@gmail.com
Cc: alex@ghiti.fr,
	andrew.jones@oss.qualcomm.com,
	anup@brainfault.org,
	aou@eecs.berkeley.edu,
	atish.patra@linux.dev,
	baolu.lu@linux.intel.com,
	fangyu.yu@linux.alibaba.com,
	gong.shuai@sanechips.com.cn,
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
	palmer@dabbelt.com,
	pjw@kernel.org,
	robin.murphy@arm.com,
	skhawaja@google.com,
	tomasz.jeznach@linux.dev,
	vasant.hegde@amd.com,
	will@kernel.org,
	zong.li@sifive.com
Subject: Re: [RFC PATCH v4 04/10] iommu/riscv: use data structure instead of individual values
Date: Sun, 20 Sep 2026 11:08:46 +0800
Message-Id: <20260920030846.20403-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <6d1bfb10-fd04-4e4e-895d-55c16fcea13f@gmail.com>
References: <6d1bfb10-fd04-4e4e-895d-55c16fcea13f@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>Hi Fangyu,
>
>On 9/15/2026 11:28 AM, fangyu.yu@linux.alibaba.com wrote:
>> From: Zong Li <zong.li@sifive.com>
>>
>> The parameter will be increased when we need to set up more
>> bit fields in the device context. Use a data structure to
>> wrap them up.
>>
>> Signed-off-by: Zong Li <zong.li@sifive.com>
>> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>> ---
>>   drivers/iommu/riscv/iommu.c | 27 +++++++++++++++++----------
>>   1 file changed, 17 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
>> index a6c8307e82ea..c5b6214ee672 100644
>> --- a/drivers/iommu/riscv/iommu.c
>> +++ b/drivers/iommu/riscv/iommu.c
>> @@ -1165,7 +1165,7 @@ static void riscv_iommu_iodir_iotinval(struct riscv_iommu_device *iommu,
>>    * interim translation faults.
>>    */
>>   static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
>> -				     struct device *dev, u64 fsc, u64 ta)
>> +				     struct device *dev, struct riscv_iommu_dc *new_dc)
>>   {
>>   	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
>>   	struct riscv_iommu_dc *dc;
>> @@ -1204,10 +1204,10 @@ static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
>>   	for (i = 0; i < fwspec->num_ids; i++) {
>>   		dc = riscv_iommu_get_dc(iommu, fwspec->ids[i]);
>>   		tc = READ_ONCE(dc->tc);
>> -		tc |= ta & RISCV_IOMMU_DC_TC_V;
>> +		tc |= new_dc->ta & RISCV_IOMMU_DC_TC_V;
>
>According to SPEC 3.1.3.3, the "V bit" does not exist in DC.ta.
>This should be a convention from when the iodir_update() function
>did not yet use `struct riscv_iommu_dc` as a parameter, using bit 0
>of DC.ta to indicate that the DC is valid. Now that iodir_update()
>receives the complete dc, it can directly access DC.tc.V, so this
>convention should no longer be necessary and will cause confusion.
>

Hi Shuai:

Thanks for the clarification.

My understanding is that `ta` here is used as a
combined concept, not only for `DC.ta`, but also
for `PC.ta` in this flow.

The `V` bit is only initialized when `ta` is first
set up, so the current usage still follows the
original design, without changing most of the
existing logic.

The original code also has comments describing
this behavior.

Thanks,
Fangyu

>>
>> -		WRITE_ONCE(dc->fsc, fsc);
>> -		WRITE_ONCE(dc->ta, ta & RISCV_IOMMU_PC_TA_PSCID);
>> +		WRITE_ONCE(dc->fsc, new_dc->fsc);
>> +		WRITE_ONCE(dc->ta, new_dc->ta & RISCV_IOMMU_PC_TA_PSCID);
>
>`RISCV_IOMMU_PC_*` should be replaced with `RISCV_IOMMU_DC_*` for
>readability. There are several other similar places in this file
>that are unrelated to Process Context or PASID but use the *PC* macros.
>

My understanding is similar to the `ta` case: `fsc`
likely refers to both `dc.fsc` and `pc.fsc` in this
path, since some of their fields share the same bit
layout.

If we want to rename these for readability, I think
that should be done in a separate patch set, rather
than as part of this one.

>
>Thanks,
>Shuai
>
>>   		/* Update device context, write TC.V as the last step. */
>>   		dma_wmb();
>>   		WRITE_ONCE(dc->tc, tc);
>> @@ -1288,22 +1288,22 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
>>   	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
>>   	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
>>   	struct pt_iommu_riscv_64_hw_info pt_info;
>> -	u64 fsc, ta;
>> +	struct riscv_iommu_dc dc = {0};
>>
>>   	pt_iommu_riscv_64_hw_info(&domain->riscvpt, &pt_info);
>>
>>   	if (!riscv_iommu_pt_supported(iommu, pt_info.fsc_iosatp_mode))
>>   		return -ENODEV;
>>
>> -	fsc = FIELD_PREP(RISCV_IOMMU_PC_FSC_MODE, pt_info.fsc_iosatp_mode) |
>> +	dc.fsc = FIELD_PREP(RISCV_IOMMU_PC_FSC_MODE, pt_info.fsc_iosatp_mode) |
>>   	      FIELD_PREP(RISCV_IOMMU_PC_FSC_PPN, pt_info.ppn);
>> -	ta = FIELD_PREP(RISCV_IOMMU_PC_TA_PSCID, domain->pscid) |
>> +	dc.ta = FIELD_PREP(RISCV_IOMMU_PC_TA_PSCID, domain->pscid) |
>>   	     RISCV_IOMMU_PC_TA_V;
>>
>>   	if (riscv_iommu_bond_link(domain, dev))
>>   		return -ENOMEM;
>>
>> -	riscv_iommu_iodir_update(iommu, dev, fsc, ta);
>> +	riscv_iommu_iodir_update(iommu, dev, &dc);
>>   	riscv_iommu_bond_unlink(info->domain, dev);
>>   	info->domain = domain;
>>
>> @@ -1378,9 +1378,12 @@ static int riscv_iommu_attach_blocking_domain(struct iommu_domain *iommu_domain,
>>   {
>>   	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
>>   	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
>> +	struct riscv_iommu_dc dc = {0};
>> +
>> +	dc.fsc = RISCV_IOMMU_FSC_BARE;
>>
>>   	/* Make device context invalid, translation requests will fault w/ #258 */
>> -	riscv_iommu_iodir_update(iommu, dev, RISCV_IOMMU_FSC_BARE, 0);
>> +	riscv_iommu_iodir_update(iommu, dev, &dc);
>>   	riscv_iommu_bond_unlink(info->domain, dev);
>>   	info->domain = NULL;
>>
>> @@ -1400,8 +1403,12 @@ static int riscv_iommu_attach_identity_domain(struct iommu_domain *iommu_domain,
>>   {
>>   	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
>>   	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
>> +	struct riscv_iommu_dc dc = {0};
>> +
>> +	dc.fsc = RISCV_IOMMU_FSC_BARE;
>> +	dc.ta = RISCV_IOMMU_PC_TA_V;
>>
>> -	riscv_iommu_iodir_update(iommu, dev, RISCV_IOMMU_FSC_BARE, RISCV_IOMMU_PC_TA_V);
>> +	riscv_iommu_iodir_update(iommu, dev, &dc);
>>   	riscv_iommu_bond_unlink(info->domain, dev);
>>   	info->domain = NULL;
>>
