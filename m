Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F393D3D1B
	for <iommu@lists.linux.dev>; Sun, 20 Sep 2026 05:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789882083; cv=none; b=bh0kTlsx+u6iWHP0Q6isRrPB9Cl1PZVdtrGp0id9kH1b9Zzmo/8yEjEXz8BGcXMbsroLXHStGPCoo7J8yScg9g29J5YEPuw71mF6ciEzZkssrq8Jecu4xyZWXK/X1Lqyk2ExdvMdqutbjP4u9ioa47m+NSFsvdbuHAT1ct/FiO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789882083; c=relaxed/simple;
	bh=VPmM384DuEsHewt/yV7T9T7OzMmPlKdECyWKJQTC8Ys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D55pGp+JIDOyHdEINjuJxgxiVIe6YspnmKuyhwEHtOuKotlZ1s7OiOGA4OIZVkLZRe9Apn7MoOz042sHkpxbV/r/eA4tHc81oMlCXUMW1D4oOyVYgs96htqh1VDPC85PzZSDjaUg3gQN/H3HEqCLsTwtEJnhnjpdZr6eIG7htcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NUvqioFU; arc=none smtp.client-ip=74.125.227.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUvqioFU"
Received: by mail-pj2-f8.google.com with SMTP id 98e67ed59e1d1-398b9f722abso1091499a91.0
        for <iommu@lists.linux.dev>; Sat, 19 Sep 2026 22:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789882081; x=1790486881; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kRdyhVbDbtwWbg31SSUY067XkC3mS81pEbCoqok50kg=;
        b=NUvqioFUv1P8PDHtn3zP+jrcZ8Xila7bpwca+yQkvz6H/TUlaY3CWyY2PcM1q/K45P
         m6FLa42q2NLYTgUFNaGZ9dH0ZY4gtsE7lMkU+Qgg5v3Wi0OirRZzEdiGr1xgjPOz4wSa
         0eAAhyCSj3F5fMVE1Gbga7AxEu5kJSU1e16W+zn4oNHLHJO0VLdqEnD7xcvgmXzOrn5s
         YVK3axGZN3Phk1HIK/AXR8eEJ7ZU4qUI+tReyG8ZhiBiezNq4WpBhvhla9q+rKZ4N6IR
         NqjJjZVdVJBKl76WyZ9vZhZ8hlJBolKeph1ORDujCK2dalCTk3A1OwpNnYPsoiM9bWDL
         96Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789882081; x=1790486881;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kRdyhVbDbtwWbg31SSUY067XkC3mS81pEbCoqok50kg=;
        b=HSXTo5GmgmIeRh+zb3xjZo8vYFr+lbK7OE9m0bpsx04ZzsnOokusPCKmBO1Nq6o90P
         Uu9TzMH5vBNJWM/Le6sy3eMbYtimcmblpzOlVeeaw0ufXaC9T/juYXn6AfCQkXcIEWmr
         0Rsuh97TGRUTdwNZjlAALkWOMHY1jXzvDBggBPoyV5ue0KVSgobx13Igek0QCh2iDGEl
         7teK1LQhYS6zcVrgtwlKr5kFxLJE4oPzzwTCjAPuFiExFh4rwuI1x/BKC0QiaeF/OCLP
         4/XvifgIuXM8NsEY3x0jFm2ATpSZ5So0CP1cx5Ar0y6JQcO/uCOyxC8IiOgjuIjFWpiQ
         qReA==
X-Forwarded-Encrypted: i=1; AKwUvBwZlL5f8Sb/jXJkb4ZgEDddwZ2OtKNV09YX9YADenEYy09KaWKEegnAywXyywCXdpb6oza9Lg==@lists.linux.dev
X-Gm-Message-State: AFuF++l+/z3bzFVYLUUYB/itvk7l7MtmH2GX30wl2cYq6oBgK0tCC2//
	exMg/7aMViYT8MnsUKyByOkpwaFC3KhTk9dJbQhJmnkNuq+rRRXc5O3H
X-Gm-Gg: AYBFou0XnFFed4Ik6sf1jwHXVT559akpyH9/pd8HpWJbMswsBi2HNtNLLbkHqF+RhWE
	KHgR5gP3SCeBTC/QjFjs48cAk03uQcszl1DvaYhw4BAX6+cfzPDrfxrz2unH8+5IjGq9KIrmL6I
	LpEvAGVmjEA0S7aXP9DISz4z1BaVNgv4gFPUuDecKmvOn41Lu1PBOUnAdXzn68gZuApb/EpXIus
	L1SkNqrCldLpYj9SHzxM7jLpiuizCfbKIvTD0ENPgry0VNzgGFiR4F01cqaxt9K5bqf3Y4tJczB
	X5paox3UpwJMs8uJQpiJeCsXyPwUg9eTdtfbaRNEMyVCiT0UD9sH2KQUr8mNbHpSRfXg2+se6rM
	NYLPJQE6g6mQFJmbHHy89Lcp94hRZDqmYH85KmHEFYwUxdOtYUwKG4YZYiM0DTwwtkdgDVzcp93
	zEF2P1en7nvBIxe0bnTvKSzvkz5+G9+2a5h65SFl6muCkSQNVTqmZbQKBepj6d4FU+9H1G6THQg
	fcE3j2I9gD0Uy9Q
X-Received: by 2002:a17:90b:2b8e:b0:39d:f024:c7ee with SMTP id 98e67ed59e1d1-39e5500a842mr11856295a91.25.1789882080607;
        Sat, 19 Sep 2026 22:28:00 -0700 (PDT)
Received: from [192.168.50.174] ([124.64.19.40])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6cabafbasm7603098a91.10.2026.09.19.22.27.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Sep 2026 22:28:00 -0700 (PDT)
Message-ID: <229a6c7c-f320-40a5-b9c6-06b31a5de28a@gmail.com>
Date: Sun, 20 Sep 2026 13:27:48 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 04/10] iommu/riscv: use data structure instead of
 individual values
To: fangyu.yu@linux.alibaba.com
Cc: alex@ghiti.fr, andrew.jones@oss.qualcomm.com, anup@brainfault.org,
 aou@eecs.berkeley.edu, atish.patra@linux.dev, baolu.lu@linux.intel.com,
 gong.shuai@sanechips.com.cn, guoren@kernel.org, iommu@lists.linux.dev,
 jgg@nvidia.com, jgg@ziepe.ca, joerg.roedel@amd.com, joro@8bytes.org,
 jroedel@suse.de, kevin.tian@intel.com, kvm-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 palmer@dabbelt.com, pjw@kernel.org, robin.murphy@arm.com,
 skhawaja@google.com, tomasz.jeznach@linux.dev, vasant.hegde@amd.com,
 will@kernel.org, zong.li@sifive.com
References: <6d1bfb10-fd04-4e4e-895d-55c16fcea13f@gmail.com>
 <20260920030846.20403-1-fangyu.yu@linux.alibaba.com>
From: Gong Shuai <gsh517025@gmail.com>
In-Reply-To: <20260920030846.20403-1-fangyu.yu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Fangyu,

On 9/20/2026 11:08 AM, fangyu.yu@linux.alibaba.com wrote:
>>Hi Fangyu,
>>
>>On 9/15/2026 11:28 AM, fangyu.yu@linux.alibaba.com wrote:
>>> From: Zong Li <zong.li@sifive.com>
>>>
>>> The parameter will be increased when we need to set up more
>>> bit fields in the device context. Use a data structure to
>>> wrap them up.
>>>
>>> Signed-off-by: Zong Li <zong.li@sifive.com>
>>> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>>> ---
>>>   drivers/iommu/riscv/iommu.c | 27 +++++++++++++++++----------
>>>   1 file changed, 17 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
>>> index a6c8307e82ea..c5b6214ee672 100644
>>> --- a/drivers/iommu/riscv/iommu.c
>>> +++ b/drivers/iommu/riscv/iommu.c
>>> @@ -1165,7 +1165,7 @@ static void riscv_iommu_iodir_iotinval(struct riscv_iommu_device *iommu,
>>>    * interim translation faults.
>>>    */
>>>   static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
>>> -				     struct device *dev, u64 fsc, u64 ta)
>>> +				     struct device *dev, struct riscv_iommu_dc *new_dc)
>>>   {
>>>   	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
>>>   	struct riscv_iommu_dc *dc;
>>> @@ -1204,10 +1204,10 @@ static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
>>>   	for (i = 0; i < fwspec->num_ids; i++) {
>>>   		dc = riscv_iommu_get_dc(iommu, fwspec->ids[i]);
>>>   		tc = READ_ONCE(dc->tc);
>>> -		tc |= ta & RISCV_IOMMU_DC_TC_V;
>>> +		tc |= new_dc->ta & RISCV_IOMMU_DC_TC_V;
>>
>>According to SPEC 3.1.3.3, the "V bit" does not exist in DC.ta.
>>This should be a convention from when the iodir_update() function
>>did not yet use `struct riscv_iommu_dc` as a parameter, using bit 0
>>of DC.ta to indicate that the DC is valid. Now that iodir_update()
>>receives the complete dc, it can directly access DC.tc.V, so this
>>convention should no longer be necessary and will cause confusion.
>>
> 
> Hi Shuai:
> 
> Thanks for the clarification.
> 
> My understanding is that `ta` here is used as a
> combined concept, not only for `DC.ta`, but also
> for `PC.ta` in this flow.
> 
> The `V` bit is only initialized when `ta` is first
> set up, so the current usage still follows the
> original design, without changing most of the
> existing logic.
> 
> The original code also has comments describing
> this behavior.

I got your point.

When fsc and ta were passed as separate raw parameters, treating
them as a combined concept was arguably reasonable, since the same
bit layout is shared between DC and PC in this path. But now that
iodir_update() takes a struct riscv_iommu_dc, I think it would be
better to keep the semantics explicit.

If PDT/PC support is added later, we can introduce a separate
struct riscv_iommu_pc parameter for the PC context, instead of
trying to make one ta/fsc cover both cases.


> Thanks,
> Fangyu
> 
>>>
>>> -		WRITE_ONCE(dc->fsc, fsc);
>>> -		WRITE_ONCE(dc->ta, ta & RISCV_IOMMU_PC_TA_PSCID);
>>> +		WRITE_ONCE(dc->fsc, new_dc->fsc);
>>> +		WRITE_ONCE(dc->ta, new_dc->ta & RISCV_IOMMU_PC_TA_PSCID);
>>
>>`RISCV_IOMMU_PC_*` should be replaced with `RISCV_IOMMU_DC_*` for
>>readability. There are several other similar places in this file
>>that are unrelated to Process Context or PASID but use the *PC* macros.
>>
> 
> My understanding is similar to the `ta` case: `fsc`
> likely refers to both `dc.fsc` and `pc.fsc` in this
> path, since some of their fields share the same bit
> layout.
Yeah, exactly, they share the same layout, so logically it's fine.

> 
> If we want to rename these for readability, I think
> that should be done in a separate patch set, rather
> than as part of this one.

Agree that it should be done in a separate patch.

Thanks,
Shuai

> 
>>
>>Thanks,
>>Shuai
>>
>>>   		/* Update device context, write TC.V as the last step. */
>>>   		dma_wmb();
>>>   		WRITE_ONCE(dc->tc, tc);
>>> @@ -1288,22 +1288,22 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
>>>   	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
>>>   	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
>>>   	struct pt_iommu_riscv_64_hw_info pt_info;
>>> -	u64 fsc, ta;
>>> +	struct riscv_iommu_dc dc = {0};
>>>
>>>   	pt_iommu_riscv_64_hw_info(&domain->riscvpt, &pt_info);
>>>
>>>   	if (!riscv_iommu_pt_supported(iommu, pt_info.fsc_iosatp_mode))
>>>   		return -ENODEV;
>>>
>>> -	fsc = FIELD_PREP(RISCV_IOMMU_PC_FSC_MODE, pt_info.fsc_iosatp_mode) |
>>> +	dc.fsc = FIELD_PREP(RISCV_IOMMU_PC_FSC_MODE, pt_info.fsc_iosatp_mode) |
>>>   	      FIELD_PREP(RISCV_IOMMU_PC_FSC_PPN, pt_info.ppn);
>>> -	ta = FIELD_PREP(RISCV_IOMMU_PC_TA_PSCID, domain->pscid) |
>>> +	dc.ta = FIELD_PREP(RISCV_IOMMU_PC_TA_PSCID, domain->pscid) |
>>>   	     RISCV_IOMMU_PC_TA_V;
>>>
>>>   	if (riscv_iommu_bond_link(domain, dev))
>>>   		return -ENOMEM;
>>>
>>> -	riscv_iommu_iodir_update(iommu, dev, fsc, ta);
>>> +	riscv_iommu_iodir_update(iommu, dev, &dc);
>>>   	riscv_iommu_bond_unlink(info->domain, dev);
>>>   	info->domain = domain;
>>>
>>> @@ -1378,9 +1378,12 @@ static int riscv_iommu_attach_blocking_domain(struct iommu_domain *iommu_domain,
>>>   {
>>>   	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
>>>   	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
>>> +	struct riscv_iommu_dc dc = {0};
>>> +
>>> +	dc.fsc = RISCV_IOMMU_FSC_BARE;
>>>
>>>   	/* Make device context invalid, translation requests will fault w/ #258 */
>>> -	riscv_iommu_iodir_update(iommu, dev, RISCV_IOMMU_FSC_BARE, 0);
>>> +	riscv_iommu_iodir_update(iommu, dev, &dc);
>>>   	riscv_iommu_bond_unlink(info->domain, dev);
>>>   	info->domain = NULL;
>>>
>>> @@ -1400,8 +1403,12 @@ static int riscv_iommu_attach_identity_domain(struct iommu_domain *iommu_domain,
>>>   {
>>>   	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
>>>   	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
>>> +	struct riscv_iommu_dc dc = {0};
>>> +
>>> +	dc.fsc = RISCV_IOMMU_FSC_BARE;
>>> +	dc.ta = RISCV_IOMMU_PC_TA_V;
>>>
>>> -	riscv_iommu_iodir_update(iommu, dev, RISCV_IOMMU_FSC_BARE, RISCV_IOMMU_PC_TA_V);
>>> +	riscv_iommu_iodir_update(iommu, dev, &dc);
>>>   	riscv_iommu_bond_unlink(info->domain, dev);
>>>   	info->domain = NULL;
>>>

