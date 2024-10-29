Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1927BB0A
	for <iommu@lists.linux.dev>; Tue, 29 Oct 2024 03:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730173630; cv=none; b=GRQZwSVRvGa4gp0EuXEdbsg2NSf+aar5+ghnBd8yWJ01MadvC4WIZFsJf7QZH7AvZJ5+ZGmu5Pe4wUU3RLQC1/xv+NKcAIsJRGdmacTA1ruFANe4e4UzHvsdsmoGdpp6KGXXmzLNKkKxoff8OLL2CuA3Uz7Sfc6Gd0vfOmgDXjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730173630; c=relaxed/simple;
	bh=2zhtoWxv/vKGf1aYno22Freq5lwsRi0n2wH7n1xvSEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oy3Ojp3mrpZk0vo56xwt85c58lWS/ABn75WG2rxaYNShKGjgNakANMDhB7t3mEo1DIvZ76oM/SEOJ981c5PeJ3PIVv/JAjO2stGN++cmpd0mI84X0/Zm4b1FwGNcF+hlvZrcP/Jem8dqapwgxmU9ZoN4Y5FSTOxrI5WsNhnYKzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=E/JaLWrE; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="E/JaLWrE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1730173495;
	bh=DQIhbLNlt9DvsLjiQNN/rundzjZSVfwFY+R/5zDuZFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=E/JaLWrE2FMNsJysY3dGuSP1vMB5Yj9g8BStOel2dIQtMdj0t/Axk8+RYxy4qOuSr
	 ZNjM9gKY7WiHlawkpTmdX0kcCNXDloigyn2xbtMo+qz7gEKWCX9pgahBL9AzBRcjfn
	 aVI907zvNfnjfyRWY4d4doopKMfeZntFV+OkXWY0=
X-QQ-mid: bizesmtpsz14t1730173478tp4j2l
X-QQ-Originating-IP: O3UGPyux8Ewa1dPqE/PX0ukXv8GpTX8LK01ws1TILBg=
Received: from [10.12.18.83] ( [123.124.208.226])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 29 Oct 2024 11:44:36 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 18159466664826028980
Message-ID: <42343B920E2D57E3+7852570a-367a-491c-a4bd-56cbabf747f8@uniontech.com>
Date: Tue, 29 Oct 2024 11:44:36 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu/arm-smmu: Add judgment on the size and granule
 parameters passed in
To: Robin Murphy <robin.murphy@arm.com>
Cc: dmitry.baryshkov@linaro.org, gouhao@uniontech.com, iommu@lists.linux.dev,
 jgg@ziepe.ca, joro@8bytes.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, robdclark@chromium.org, will@kernel.org
References: <20241024100224.62942-1-goutongchen@uniontech.com>
 <20241028034823.22838-1-goutongchen@uniontech.com>
 <3d2041e7-95eb-4d60-92ab-d67e2f46531e@arm.com>
From: =?UTF-8?B?57yR5ZCM55Cb?= <goutongchen@uniontech.com>
In-Reply-To: <3d2041e7-95eb-4d60-92ab-d67e2f46531e@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-0
X-QQ-XMAILINFO: MJt5Q2Gt+7dfr8Y4UnBzCtCT5dNMEoRv1KUzPXKBo2WTU2q2dnJ8xa+Q
	tIL9R3f+G0Z6/w4QS9retf+0dpk+r/Eih7M9gRrIe0g10ey6vS6g//lZdIPqj7GjV6RKZaf
	j4ObZea0mmMNfj5Y8KjxutfkQrV7Fw/lru8rHl6UZ4/sG35glIt+V99V6m4yn0eGyYZitA9
	c425aPeCpCiPSzBshScACwlUFBq4US5ytAV5h2Z9iKXxRnrrXWbTFITgWX5NJQrWoEpuX0A
	eVHGo5Ny7At6AFqc7rBXHmJxbiP3CUwmgIOggAH8dEzXxdVOdhIRM1lXZdsKhYbKB3/rfi+
	Lup+P4XSeVUEbQUwOLW2Y2ZJw78oguxF+1MiPtxV6wgG7eXNQ+IL2+nS0fMzMl0z1LdMeFw
	tjRRjsVZ7pOa0XfPHSNF0oUUglNWHbAKoZJbd/KCbsueK3c/RN/FAJVgBpZPTUyOzXdiMGV
	s8L6tpj72FwYVWVO1h42JNKWV/UOy/R68wWgHmhFI07njUymjsEcsd+Zkrqh/tFxG1fFUWB
	fBTNMJdvrgCTTH1N8oLZhftFXOvOJdt9ej3tO46ACAjJ0aYfMBybkLJeedwq9uuvl2frZBX
	VbDjWNPS1QZfu2x6fzd2fZPC7RXSY47fyQ56OQLqTAAyQoDadKoKgQEt15EliQNDSFuaP3Z
	NwbHDBVFl/ZPU4k2/Vte0KaIXok7lVfDduiyCa1K/oEstfodyo34HxA4u/pud+od4C6ZoMK
	fxhbV/6TfyaE+3kSqnbi/r4bfSMoViWRf8Hvt1xzNCaaLY/uL14hk6OMfE8RpXS56YuHwxa
	AkXxI6SXwKiQGcmKCYPxzOrbWHfJrqBbeFBbknh/G1Wd9YPSr7MIUoRiO4qCbVdydyaSm1d
	78Brdq3JUakWJpTW/bq4eVspLNVdGtqKswavyXA81iGiVdOH7joVc3BZxI7jzx4JnC8egXg
	obCkDFBiMdVJuRQVVyfq5BvyhxAkFxC/5aTA=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0


在 2024/10/28 19:41, Robin Murphy 写道:
> On 2024-10-28 3:48 am, goutongchen@uniontech.com wrote:
>> From: goutongchen <goutongchen@uniontech.com>
>>
>> In the arm_smmu_tlb_inv_range_s1 and arm_smmu_tlb_inv_range_s2
>> functions, the size and granule passed in must be judged.
>> It must be ensured that the passed in parameter is not 0 and
>> the size is an integer multiple of the granule, otherwise it
>> will cause an infinite while loop.
>>
>> This was encountered during testing, and was initially triggered
>> by passing in a size value of 0, causing the kernel to crash.
>
> Still NAK. If there is a bug in the upstream io-pgtable-arm code which 
> can actually cause this, please send a patch to fix *that* bug. 
> Otherwise, if you've made a broken downstream change then it is not 
> upstream's responsibility to maintain unnecessary code in a 
> questionable attempt to paper over (some small subset of) such 
> brokenness.
>
> If you pass any sufficiently large size value which *does* happen to 
> be a multiple of the granule, you're still going to see the same RCU 
> stalls and failure to progress within reasonable time. If you pass 
> something inappropriate for the "cookie" pointer, you're likely to 
> corrupt memory or really crash. If you pass arguments which all look 
> plausible but still don't match what actually needs invalidating, the 
> consequences of under-invalidation can be even more subtle, nasty and 
> hard to debug.
>
> The iommu_flush_ops are not a public interface intended to be called 
> arbitrarily from anywhere in the kernel with unchecked input, they are 
> a low-level private interface between IOMMU drivers and their 
> respective io-pgtable implementations, and as such they are designed 
> for their callers to call them correctly by construction. Calling them 
> incorrectly indicates a serious bug in the caller, since getting 
> mapping and/or TLB invalidation wrong often leads to memory corruption 
> or other issues down the line. Hence I'm not convinced this change is 
> actually even desirable as a downstream debugging aid - if you're 
> lucky enough to get stuck on an obviously-wrong call here, that's 
> surely the clearest possible indication of the source of the bug in 
> its calling context, far better than trying to ignore it and then 
> having it drowned out by more distant things blowing up later due to 
> 2nd- and 3rd-order effects.
>
> Thanks,
> Robin.
>

OK! Thanks, very much!

Goutongchen.


>> [    8.214378][  T675] xhci_hcd 0000:0b:00.0: new USB bus registered, 
>> assigned bus number 1
>> [   68.246185][    C0] rcu: INFO: rcu_sched self-detected stall on CPU
>> [   68.246866][    C0] rcu:     0-....: (5999 ticks this GP) 
>> idle=796c/1/0x4000000000000000 softirq=161/161 fqs=2999
>> [   68.247924][    C0] rcu:     (t=6000 jiffies g=-699 q=1 ncpus=128)
>> [   68.248452][    C0] CPU: 0 PID: 675 Comm: kworker/0:2 Not tainted 
>> 6.6.0-25.02.2500.002.uos25.aarch64 #1
>> [   68.249237][    C0] Hardware name: Inspur     CS5260F 
>> /CS5260F          , BIOS 4.0.16 05/31/22 16:53:51
>> [   68.250029][    C0] Workqueue: events work_for_cpu_fn
>> [   68.250497][    C0] pstate: a0000005 (NzCv daif -PAN -UAO -TCO 
>> -DIT -SSBS BTYPE=--)
>> [   68.251188][    C0] pc : arm_smmu_tlb_inv_range_s1+0xf0/0x158
>> [   68.251704][    C0] lr : arm_smmu_tlb_inv_walk_s1+0x44/0x68
>> [   68.252189][    C0] sp : ffff80008044b780
>> [   68.252530][    C0] x29: ffff80008044b780 x28: 0000000000000000 
>> x27: 0000000000001000
>> [   68.253212][    C0] x26: 0000000000000600 x25: 0000000000000001 
>> x24: 0000000000000600
>> [   68.253857][    C0] x23: 0000000000000000 x22: 0000000000001000 
>> x21: fffffc64e2e59000
>> [   68.254544][    C0] x20: 0000000039c1d1a6 x19: ffff3fe944c40280 
>> x18: 0000000000000000
>> [   68.255240][    C0] x17: 626d756e20737562 x16: ffffb0e7e08c1008 
>> x15: 0000000000000000
>> [   68.255930][    C0] x14: ffff3ef8c1ea15cd x13: ffff3ef8c1ea15cb 
>> x12: fffffcfba30e3880
>> [   68.256538][    C0] x11: 00000000ffff7fff x10: ffff80008044b6b0 x9 
>> : ffffb0e7decd1b5c
>> [   68.257126][    C0] x8 : 0000000000000dc0 x7 : ffff3ee8c4148000 x6 
>> : ffff3ee8c4148000
>> [   68.257822][    C0] x5 : 0000000000000008 x4 : 0000000000000000 x3 
>> : ffff3fe944c40800
>> [   68.258497][    C0] x2 : 0000000000000010 x1 : 0000000000000020 x0 
>> : ffffb0e7dfd6c3d0
>> [   68.259185][    C0] Call trace:
>> [   68.259451][    C0]  arm_smmu_tlb_inv_range_s1+0xf0/0x158
>> [   68.259933][    C0]  arm_smmu_tlb_inv_walk_s1+0x44/0x68
>> [   68.260384][    C0]  __arm_lpae_map+0x1f0/0x2c0
>> [   68.260796][    C0]  arm_lpae_map_pages+0xec/0x150
>> [   68.261215][    C0]  arm_smmu_map_pages+0x48/0x130
>> [   68.261654][    C0]  __iommu_map+0x134/0x2a8
>> [   68.262098][    C0]  iommu_map_sg+0xb8/0x1c8
>> [   68.262500][    C0] 
>> __iommu_dma_alloc_noncontiguous.constprop.0+0x180/0x270
>> [   68.263145][    C0]  iommu_dma_alloc+0x178/0x238
>> [   68.263557][    C0]  dma_alloc_attrs+0xf8/0x108
>> [   68.263962][    C0]  xhci_mem_init+0x1e8/0x6d0
>> [   68.264372][    C0]  xhci_init+0x88/0x1d0
>> [   68.264736][    C0]  xhci_gen_setup+0x284/0x468
>> [   68.265121][    C0]  xhci_pci_setup+0x60/0x1f8
>> [   68.265506][    C0]  usb_add_hcd+0x278/0x650
>> [   68.265860][    C0]  usb_hcd_pci_probe+0x218/0x458
>> [   68.266256][    C0]  xhci_pci_probe+0x7c/0x270
>> [   68.266660][    C0]  local_pci_probe+0x48/0xb8
>> [   68.267074][    C0]  work_for_cpu_fn+0x24/0x40
>> [   68.267548][    C0]  process_one_work+0x170/0x3c0
>> [   68.267999][    C0]  worker_thread+0x234/0x3b8
>> [   68.268383][    C0]  kthread+0xf0/0x108
>> [   68.268704][    C0]  ret_from_fork+0x10/0x20
>>
>> Signed-off-by: goutongchen <goutongchen@uniontech.com>
>> ---
>>   drivers/iommu/arm/arm-smmu/arm-smmu.c | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c 
>> b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> index 8321962b3714..fdd7d7e9ce06 100644
>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> @@ -282,6 +282,13 @@ static void arm_smmu_tlb_inv_range_s1(unsigned 
>> long iova, size_t size,
>>       struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
>>       int idx = cfg->cbndx;
>>   +    if (size == 0 || granule == 0 || (size % granule) != 0) {
>> +        dev_err(smmu->dev,
>> +                 "The size or granule passed in is err. size=%zu, 
>> granule=%zu\n",
>> +                 size, granule);
>> +        return;
>> +    }
>> +
>>       if (smmu->features & ARM_SMMU_FEAT_COHERENT_WALK)
>>           wmb();
>>   @@ -309,6 +316,13 @@ static void arm_smmu_tlb_inv_range_s2(unsigned 
>> long iova, size_t size,
>>       struct arm_smmu_device *smmu = smmu_domain->smmu;
>>       int idx = smmu_domain->cfg.cbndx;
>>   +    if (size == 0 || granule == 0 || (size % granule) != 0) {
>> +        dev_err(smmu->dev,
>> +                 "The size or granule passed in is err. size=%zu, 
>> granule=%zu\n",
>> +                 size, granule);
>> +        return;
>> +    }
>> +
>>       if (smmu->features & ARM_SMMU_FEAT_COHERENT_WALK)
>>           wmb();
>
>
