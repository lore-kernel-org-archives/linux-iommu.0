Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EFF10F1
	for <iommu@lists.linux.dev>; Mon,  1 Dec 2025 19:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764619060; cv=none; b=mO1PtPZa6Wy09nqi7lEwskqiNTIffmxaD4enSIL3xCpETGoktWZ8ErYHujMszz7toqcnSMkpxgZf5CQD1YvccQYZw/tr00aEfejMb0/dB1g2v6du9Xi6Q7sZURS9w/0FTDqJ8nMe8Nfky3NxDJa2ORoMFQn073LXr/JDQtJQwFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764619060; c=relaxed/simple;
	bh=z4xIHlkPIo0SuqbDVj/hzRolgsVnm4bnvhbb1wX7iDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s7iwx3KrnRSUwf8CNRZB3FqMa4PUpmotKMHA44l1ORXzVLaEQSGQ47ZwB3VbBvIselbLFLVXzCr43Kyuzrrdal7U2kEc1Ljh2sxk3pTkbXHokjyqaAtRjvGo/aJMBQn+3mnJ4x7J/TrgP2GY9gcRoLh/UrE1lAeUDmQRDyfVSi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 770C3153B;
	Mon,  1 Dec 2025 11:57:29 -0800 (PST)
Received: from [10.57.88.78] (unknown [10.57.88.78])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC1833F73B;
	Mon,  1 Dec 2025 11:57:34 -0800 (PST)
Message-ID: <4c347cb4-bb82-4209-82fc-59088cc19bc2@arm.com>
Date: Mon, 1 Dec 2025 19:57:31 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] iommu/arm-smmu-v3: Fix CMDQ timeout warning
To: Jacob Pan <jacob.pan@linux.microsoft.com>, Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 Joerg Roedel <joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Zhang Yu <zhangyu1@linux.microsoft.com>,
 Jean Philippe-Brucker <jean-philippe@linaro.org>,
 Alexander Grest <Alexander.Grest@microsoft.com>
References: <20251114171718.42215-1-jacob.pan@linux.microsoft.com>
 <20251114171718.42215-2-jacob.pan@linux.microsoft.com>
 <aSXlFDAa672dZGVm@willie-the-truck>
 <20251130150624.000053e7@linux.microsoft.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20251130150624.000053e7@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-11-30 11:06 pm, Jacob Pan wrote:
> Hi Will,
> 
> On Tue, 25 Nov 2025 17:19:16 +0000
> Will Deacon <will@kernel.org> wrote:
> 
>> On Fri, Nov 14, 2025 at 09:17:17AM -0800, Jacob Pan wrote:
>>> While polling for n spaces in the cmdq, the current code instead
>>> checks if the queue is full. If the queue is almost full but not
>>> enough space (<n), then the CMDQ timeout warning is never triggered
>>> even if the polling has exceeded timeout limit.
>>>
>>> The existing arm_smmu_cmdq_poll_until_not_full() doesn't fit
>>> efficiently nor ideally to the only caller
>>> arm_smmu_cmdq_issue_cmdlist():
>>>   - It uses a new timer at every single call, which fails to limit
>>> to the preset ARM_SMMU_POLL_TIMEOUT_US per issue.
>>> - It has a redundant internal queue_full(), which doesn't detect
>>> whether there is a enough space for number of n commands.
>>>
>>> This patch polls for the availability of exact space instead of
>>> full and emit timeout warning accordingly.
>>>
>>> Fixes: 587e6c10a7ce ("iommu/arm-smmu-v3: Reduce contention during
>>> command-queue insertion") Co-developed-by: Yu Zhang
>>> <zhangyu1@linux.microsoft.com> Signed-off-by: Yu Zhang
>>> <zhangyu1@linux.microsoft.com> Signed-off-by: Jacob Pan
>>> <jacob.pan@linux.microsoft.com>
>>
>> I'm assuming you're seeing problems with an emulated command queue?
>> Any chance you could make that bigger?
>>
> This is not related to queue size, but rather a logic issue when
> anytime queue is nearly full.

It is absolutely related to queue size, because there are only two
reasons why this warning should ever be seen:

1: The SMMU is in some unexpected error state and has stopped consuming
commands altogether.
2: The queue is far too small to do its job of buffering commands for
the number of present CPUs.

>>> @@ -804,12 +794,13 @@ int arm_smmu_cmdq_issue_cmdlist(struct
>>> arm_smmu_device *smmu, local_irq_save(flags);
>>>   	llq.val = READ_ONCE(cmdq->q.llq.val);
>>>   	do {
>>> +		struct arm_smmu_queue_poll qp;
>>>   		u64 old;
>>>   
>>> +		queue_poll_init(smmu, &qp);
>>>   		while (!queue_has_space(&llq, n + sync)) {
>>>   			local_irq_restore(flags);
>>> -			if
>>> (arm_smmu_cmdq_poll_until_not_full(smmu, cmdq, &llq))
>>> -				dev_err_ratelimited(smmu->dev,
>>> "CMDQ timeout\n");
>>> +			arm_smmu_cmdq_poll(smmu, cmdq, &llq, &qp);
>>>   
>>
>> Isn't this broken for wfe-based polling? The SMMU only generates the
>> wake-up event when the queue becomes non-full.
> I don't see this is a problem since any interrupts such as scheduler
> tick can be a break evnt for WFE, no?

No, we cannot assume that any other WFE wakeup event is *guaranteed*.
It's certainly possible to get stuck in WFE on a NOHZ_FULL kernel with
the arch timer event stream disabled - I recall proving that back when I
hoped I might not have to bother upstreaming a workaround for MMU-600
erratum #1076982.

Yes, a large part of the reason we enable the event stream by default is
to help mitigate errata and software bugs which lead to missed events,
but that still doesn't mean we should consciously abuse it. I guess
something like the diff below (completely untested) would be a bit
closer to correct (basically, allow WFE when the queue is completely
full, but suppress it if we're then still waiting for more space in a
non-full queue).

Thanks,
Robin.

----->8-----
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index a0c6d87f85a1..206c6c6860dd 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -123,7 +123,7 @@ static void parse_driver_options(struct arm_smmu_device *smmu)
  }
  
  /* Low-level queue manipulation functions */
-static bool queue_has_space(struct arm_smmu_ll_queue *q, u32 n)
+static int queue_space(struct arm_smmu_ll_queue *q)
  {
  	u32 space, prod, cons;
  
@@ -135,7 +135,7 @@ static bool queue_has_space(struct arm_smmu_ll_queue *q, u32 n)
  	else
  		space = cons - prod;
  
-	return space >= n;
+	return space;
  }
  
  static bool queue_empty(struct arm_smmu_ll_queue *q)
@@ -796,9 +796,11 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
  	do {
  		struct arm_smmu_queue_poll qp;
  		u64 old;
+		int space;
  
  		queue_poll_init(smmu, &qp);
-		while (!queue_has_space(&llq, n + sync)) {
+		while (space = queue_space(&llq), space < n + sync) {
+			qp.wfe &= !space;
  			local_irq_restore(flags);
  			arm_smmu_cmdq_poll(smmu, cmdq, &llq, &qp);
  			local_irq_save(flags);

