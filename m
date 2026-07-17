Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCCD2BE630
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 13:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784295969; cv=none; b=l1XBzaZPAzBab7fbIphU1KgP1ImVMK2/PYUu9jOzJL+8Qj5jwT4+kb2onbHEiRl1E0t3B1EhH8fKyNIb+z0HBVLiSEQGNDA7Nau3OceLQlbm7iuoXzh2NQb7DfUx/vdqurrvTd4M8PXXITGlD+IpViFh2y4nwF2Dhlg8kooEOrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784295969; c=relaxed/simple;
	bh=oVSwNZKvL5ApsvrO/fsoicw8QzcV2ADUXDc99VZMKqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NiOf46kIISxfqpVbmPQqWw7cHk5TVRffG76O5RLnm3g1pPo2+8D7eVijJhA6i/z2WKOV5oV0e0yWA6bfvgEdWtv1JggCefbhet68A7fwCxOmQISZgwb86heDoxNrrYy2dNugTOSf+fb4YZfgLEZa4XSfb+b3SygfuJIS5cESbUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gacF2h8n; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gacF2h8n"
Message-ID: <e2b13e82-f762-4fb0-83cb-d4bef57be427@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784295962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IBYknkOUR+X5gWeNDz73pOHrtI3vYIa/FeeT/Ee4dEo=;
	b=gacF2h8nxvL5R+JrB5W/wDnZoO6vASG9mFlsX07ZknpssG0oJg2Q2PghyZxgwRbOybeiVG
	Bt2+LYmGs1eXhPhVK/wQ/keIA8QWgxY8In+xaXY3uwYjXuV5OmrqlBk1dHHGWR6ZSso/Sq
	U0EN5qEB+tR7zu19ENl7UrLNTRdq4JA=
Date: Fri, 17 Jul 2026 15:45:45 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [PATCH v2] iommu/riscv: Replace illegal command with dummy
 IOFENCE to prevent hardware lockup
To: Zong Li <zong.li@sifive.com>, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, iommu@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260630023042.837926-1-zong.li@sifive.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tomasz Jeznach <tomasz.jeznach@linux.dev>
In-Reply-To: <20260630023042.837926-1-zong.li@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,

On 6/29/26 7:30 PM, Zong Li wrote:
> When the RISC-V IOMMU encounters an illegal command, the hardware
> stops processing and the HEAD register remains pointing at the
> illegal command. If software does not handle this properly, the
> hardware will be stuck at this index indefinitely, preventing any
> further command queue operations.

The definition of proper handling was included in the spec. This patch 
simply implements logic to ignore real hardware errors and move forward, 
leaving the system in an unspecified state. The driver should not allow 
the system to pretend that everything is fine.

> This patch implements a recovery mechanism by replacing the illegal
> command with a dummy IOFENCE instruction (all operands are zero):
>
> 1. Prevents hardware lockup: By overwriting the illegal command with
>     a valid instruction, the hardware can continue processing from the
>     current position instead of being stuck.
Currently, there is no clear way of communicating mapping 
synchronization failures in the IOMMU/DMA path. The only reasonable 
fault handler is either to panic or to make the fault visible to the 
user with a very long timeout. The timeout approach has been chosen in 
this driver; there are pros and cons to this, but let's not get into 
that discussion here.

By overwriting an illegal command without any notification to the user, 
we are simply hiding e.g. TLB invalidation faults and likely causing 
use-after-free errors for DMA transfers. I would prefer not to go that way.

> 2. Enables user recovery: After replacing the illegal command, the
>     user/driver has an opportunity to retry the original failed
>     operation rather than losing all queued work.
Unfortunately user/driver has no way to know if any retry is required.

> 3. Minimal hardware impact: A dummy IOFENCE behaves as a NOP, it
>     it performs no cache invalidation operations and has no side
>     effects on the system state. This is the safest replacement
>     instruction.
In the first place, an illegal command should not be enqueued into the 
command queue. If there is one, it's a driver/software bug or a hardware 
incompatibility with the specification. We should address this problem 
first. If a command has been interpreted as illegal, there might be 
other possible reasons for the fault - e.g., reading commands from an 
incorrect memory location or some other memory corruption related 
issues. Overwriting it with a "NOP" might not resolve this at all.

I agree there is error handling needed for cmd_ill / timeout / fault 
errors, but so far the only reasonable way to handle those is to make 
the fault loud and annoying to the user (applications), with the IOMMU 
driver reporting errors via the kernel log.

Is this patch trying to solve a real problem of a hardware faulting on 
illegal instructions, or is this a theoretical scenario with the 
implementation mimicking the SMMU implementation?

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

Unfortunately, there is already a 'fix' added in the driver to exit the 
sync wait loop if a fault is reported on the command queue (line #381). 
There is a race with the fault interrupt handler that should be 
addressed and fixed.

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

As an alternative trade-off, maybe consider reporting and storing the 
fault for the IOMMU instance and failing all subsequent page map 
requests. Instead of a long timeout, this would fail quickly, giving 
users a clear signal that the DMA subsystem using this IOMMU device is 
no longer usable.

An alternative error-handling mechanism I've considered in the past was 
to shut down the command queue, quiesce all IOMMU interfaces (PRI/ATS), 
and completely reprogram the IOMMU from scratch (setting up the DDTP and 
re-enabling the command queue). As per the specification, restarting the 
command queue clears cmd_ill/timeout/fault errors. Once the IOMMU 
configuration is restarted, we can unblock any pending 
riscv_iommu_queue_wait() calls with a simpler sequence lock.

> It prevents the hardware lockup. Even though we might lose some commands
> and cause incorrect results for the user, it at least keeps the system
> alive and gives the user a chance to retry their operation again.
I think this patch only hides hardware errors, potentially masking 
not-so-rare real faults.


Best,
- Tomasz

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
> +		}
> +
>   		riscv_iommu_writel(queue->iommu, queue->qcr, ctrl);
> +
>   		dev_warn(queue->iommu->dev,
>   			 "Queue #%u error; fault:%d timeout:%d illegal:%d fence_w_ip:%d\n",
>   			 queue->qid,

