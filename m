Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72ACC34A796
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 02:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783911174; cv=none; b=MeCnlq0y0fIE5bKp9DTq0HTgaA/V8EipAiT8S7Tw5okJ8f8/fjF9g3VJUIUiU1J12Jz1+LyV9ossoYuvh3/XgndxWwvXn7bAei+dSnpMBLjXOhJMvJbngklkhRDUbE6MBbwZNcRiX27ANWtnzhMvknbON+4sjCR8v6fqpUwLU6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783911174; c=relaxed/simple;
	bh=elnOmjtKhc7ZkUcjMxaedGgEBkAQlLWA/eMr2agyeMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CraNiJ32iJYvK8Mz9ENf8WVXaiJDM5pAKD9JAIlvLzI7qk7Rd2BT3maTxqWvZEJ56A9gq1Cg59Uk03y98QOR2rUklMRMj3xCQEqW/Bx7sSZ8UcPqqpEUnklA2ULm2YYfZzmMkBgOFcUi50l8wSw2HyrmiJMYd6d9eEstvA/1isI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VDRH7Ltn; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VDRH7Ltn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783911171; x=1815447171;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=elnOmjtKhc7ZkUcjMxaedGgEBkAQlLWA/eMr2agyeMg=;
  b=VDRH7LtnMKf3FjpIW9W+WaNEG+wYi1T1lEHwx0xrUqj3v9SHuTPTDU56
   upJ00spF4y1CmbxHw4GcokNOI/+A37MpntA0C2GxUQd9dYQK3Rm5NaGw3
   7ykQ0u8BWrxWYEXhWbZxVTvRJg8LcwlEAcR8f8Rzzq9YdviwA5rMmxFtg
   sWPrCjFvzu9S7ky9f7DGFOO7w0TjpSLJLuoTC7GOpW0anf5WrWNzyPLyQ
   vG8m+mJNpctQDIxPWXewNMTr1Tvw0SQo7dAC8BAlnnnaTsMOxn99bKG7B
   7zfKvoWdsgSCW951L0EAr3eQfVLzH+fc4m48Cnvt5NiTyFi2itIu+cVl5
   A==;
X-CSE-ConnectionGUID: dIsqwVidQvKkwMSrCWnTJg==
X-CSE-MsgGUID: dnXrSirkS66XkILa0nQBgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84709283"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84709283"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2026 19:52:50 -0700
X-CSE-ConnectionGUID: 0xBnQF12SVyIsp67boBrGA==
X-CSE-MsgGUID: +r3WTgUeTh6smqnFWa6EqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="251012556"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2026 19:52:47 -0700
Message-ID: <791a320f-ca6e-430d-b71c-82e95ca5a488@linux.intel.com>
Date: Mon, 13 Jul 2026 10:51:04 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu/riscv: Replace illegal command with dummy
 IOFENCE to prevent hardware lockup
To: Zong Li <zong.li@sifive.com>, tomasz.jeznach@linux.dev, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, iommu@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260630023042.837926-1-zong.li@sifive.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260630023042.837926-1-zong.li@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/30/26 10:30, Zong Li wrote:
> When the RISC-V IOMMU encounters an illegal command, the hardware
> stops processing and the HEAD register remains pointing at the
> illegal command. If software does not handle this properly, the
> hardware will be stuck at this index indefinitely, preventing any
> further command queue operations.
> 
> This patch implements a recovery mechanism by replacing the illegal
> command with a dummy IOFENCE instruction (all operands are zero):
> 
> 1. Prevents hardware lockup: By overwriting the illegal command with
>     a valid instruction, the hardware can continue processing from the
>     current position instead of being stuck.
> 
> 2. Enables user recovery: After replacing the illegal command, the
>     user/driver has an opportunity to retry the original failed
>     operation rather than losing all queued work.
> 
> 3. Minimal hardware impact: A dummy IOFENCE behaves as a NOP, it
>     it performs no cache invalidation operations and has no side
>     effects on the system state. This is the safest replacement
>     instruction.
> 
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
> 
> The main goal is to at least prevent the hardware from getting stuck
> and crashing the entire system.
> 
> Here are the main issues we would need to solve if we fully follow the spec:
> 
> 1. IOFENCE index shift: After an illegal command, if another thread is
> waiting for subsequent IOFENCE to finish, resubmitting commands will
> change that IOFENCE's index in the queue. This means the waiting
> thread in 'riscv_iommu_cmd_sync' might finish too early because the
> 'prod' value should be changed as well. We could fix this by making
> IOFENCE write a sequence number to a specific address, and having the
> thread wait for that data instead.
> 
> 2. Timeout errors: If an illegal command happens while another thread
> is trying to write a command, that thread might be waiting for the
> tail to move (in 'riscv_iommu_queue_send'), and exit the wait due to a
> timeout. This leads to errors in the caller subsystem (like DMA). So
> it seems even if the resubmit finishes later, it might not help much.
> 
> 3. Queue tail mismatch: Similar to point 2 situation, a thread waiting
> in 'riscv_iommu_queue_send' expects prod == queue->tail. If we
> resubmit commands quickly, queue->tail is updated asynchronously to a
> farther value. The waiting thread might never see the condition met
> and time out.
> 
> 4. Shadow queue overhead: Inside the threading IRQ handler, we cannot
> easily know what the illegal command was just by checking the current
> command queue. We would need to create a "shadow command queue" to
> keep a history. This would break the current driver design. We would
> also need to add locks to prevent race conditions on shadow command
> queue, which would reduce the driver's performance.
> 
> Considering these trade-offs, I prefer not to make the driver much
> more complex and slower just to handle rare hardware errors.
> Treating this hardware fault as a fatal error without trying to
> recover it in software might be too extreme and would require a
> hardware reset. Therefore, this patch might be a good middle ground.
> It prevents the hardware lockup. Even though we might lose some commands
> and cause incorrect results for the user, it at least keeps the system
> alive and gives the user a chance to retry their operation again.
> 
> Changed in v1:
> - Added more comments
> - Rebased on v7.2-rc1
> 
>   drivers/iommu/riscv/iommu.c | 32 +++++++++++++++++++++++++++++++-
>   1 file changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index cec3ddd7ab10..c009c1906e23 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -464,13 +464,43 @@ static unsigned int riscv_iommu_queue_send(struct riscv_iommu_queue *queue,
>   static irqreturn_t riscv_iommu_cmdq_process(int irq, void *data)
>   {
>   	const struct riscv_iommu_queue *queue = (struct riscv_iommu_queue *)data;
> -	unsigned int ctrl;
> +	struct riscv_iommu_command cmd;
> +	unsigned int ctrl, head;
>   
>   	/* Clear MF/CQ errors, complete error recovery to be implemented. */
>   	ctrl = riscv_iommu_readl(queue->iommu, queue->qcr);
>   	if (ctrl & (RISCV_IOMMU_CQCSR_CQMF | RISCV_IOMMU_CQCSR_CMD_TO |
>   		    RISCV_IOMMU_CQCSR_CMD_ILL | RISCV_IOMMU_CQCSR_FENCE_W_IP)) {
> +
> +		/*
> +		 * Resubmitting all commands submitted since the last IOFENCE that
> +		 * successfully completed will introduce various race conditions.
> +		 * Use a dummy IOFENCE instead of the illegal command to prevent
> +		 * hardware lockup.
> +		 * Please note that some commands might be lost, including:
> +		 *  - The task from the illegal command itself
> +		 *  - The commands submitted between the last IOFENCE and illegal one
> +		 * However, this gives the user or driver a chance to retry the
> +		 * failed operation without resetting the enitre system
> +		 */
> +		if (ctrl & RISCV_IOMMU_CQCSR_CMD_ILL) {
> +			/*
> +			 * The head pointer is not updated by the hardware, it
> +			 * still points to the index of illegal command
> +			 */
> +			riscv_iommu_readl_timeout(queue->iommu, Q_HEAD(queue), head,
> +						  !(head & ~queue->mask), 0,
> +						  RISCV_IOMMU_QUEUE_TIMEOUT);
> +
> +			memset(&cmd, 0, sizeof(cmd));
> +			cmd.dword0 = FIELD_PREP(RISCV_IOMMU_CMD0_OPCODE,
> +						RISCV_IOMMU_CMD_IOFENCE_OPCODE);
> +			memcpy(queue->base + head * sizeof(cmd), &cmd, sizeof(cmd));
> +			dma_wmb();

So the command that the hardware complained about as illegal (which
might simply be a compatibility issue) is being ignored here, right?

Doesn't this introduce a severe bug? For example, if the overwritten
command was a cache invalidation request following a page table unmap,
the IOMMU hardware will continue using the stale cache entries. This
could result in silent data corruption or severe security
vulnerabilities.

> +		}
> +
>   		riscv_iommu_writel(queue->iommu, queue->qcr, ctrl);
> +
>   		dev_warn(queue->iommu->dev,
>   			 "Queue #%u error; fault:%d timeout:%d illegal:%d fence_w_ip:%d\n",
>   			 queue->qid,

Thanks,
baolu
