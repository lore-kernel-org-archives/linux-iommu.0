Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9A21CDA0A;
	Tue, 15 Oct 2024 08:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728982702; cv=none; b=tV/hLaRnZGfwE/SWRUh/zYTZ9YkhqKTSs7R0r3ivuJlmgjGZ1kVxoj/H3j/sgU4j8f0/B/1bguG067yT2kAD7/rD6/87ijc/46ip1mVN6Jzr8nY4jKFR9YSufXA1xqJT4LjQ1/TYWG6TCpTeHz8qPgOxbmWh0Bwh1uL2QFlSxzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728982702; c=relaxed/simple;
	bh=JeHs09n/fgnm8DLFzXGTaECcHXz114f/ynuKFiM5gYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=crD9mGlWTHPAkiU7X6nEFToHKWbnwk8MFS9pj3bCYWvHE27/OYFRyfpijcN/aDu9N5xgg7U7RB1mIb2FKmXFZefk4QinHEDfXZDI/GG0SdGEnxwQggOoHkZlsu9Q+7p3Q01EWfc+hOfddnXuzzs15xWKEofLW+JcQ1yFhBLza5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ey99cQkO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ey99cQkO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 637D4C4CEC6;
	Tue, 15 Oct 2024 08:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728982702;
	bh=JeHs09n/fgnm8DLFzXGTaECcHXz114f/ynuKFiM5gYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ey99cQkOIUsPYERXg+Q4eS8nc4wDGlv9ioNHnrjCSwao5Ap/L2ogxIFqEesuZcqcL
	 EZqqFkOiY2Wzf9e9/pE/oalVnXTUuBOjQTuLtKXbofdqz0IntyzmXj9hfBWv+Ou/TZ
	 6BindokGGdA3W3tAPKzUTsKHuPUwMjC6DVyUq24o+S1eLaNjfGF9UnYhuUTXeGoBha
	 fRVjGQXhVYkT0LhzQZiHbJx1PNhspbP9sYwCpC28CWsz1AHN/IjVUZ0sDAYWB7zJoy
	 Yr7hyXLqUsU4TT94X4ziXutxZBPP2OyypQrNE9Zur+AF32dpA3sxEcWX/Rvly+ivG5
	 uQEMfntoWgF6Q==
Date: Tue, 15 Oct 2024 09:58:14 +0100
From: Will Deacon <will@kernel.org>
To: Tomasz Jeznach <tjeznach@rivosinc.com>
Cc: Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Anup Patel <apatel@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Nick Kossifidis <mick@ics.forth.gr>,
	Sebastien Boeuf <seb@rivosinc.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux@rivosinc.com,
	Lu Baolu <baolu.lu@linux.intel.com>, Zong Li <zong.li@sifive.com>
Subject: Re: [PATCH v9 6/7] iommu/riscv: Command and fault queue support
Message-ID: <20241015085814.GB19110@willie-the-truck>
References: <cover.1728579958.git.tjeznach@rivosinc.com>
 <6916f5308478013c7b4cda77403c1e9aa9982384.1728579958.git.tjeznach@rivosinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6916f5308478013c7b4cda77403c1e9aa9982384.1728579958.git.tjeznach@rivosinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Oct 10, 2024 at 12:48:09PM -0700, Tomasz Jeznach wrote:
> Introduce device command submission and fault reporting queues,
> as described in Chapter 3.1 and 3.2 of the RISC-V IOMMU Architecture
> Specification.
> 
> Command and fault queues are instantiated in contiguous system memory
> local to IOMMU device domain, or mapped from fixed I/O space provided
> by the hardware implementation. Detection of the location and maximum
> allowed size of the queue utilize WARL properties of queue base control
> register. Driver implementation will try to allocate up to 128KB of
> system memory, while respecting hardware supported maximum queue size.
> 
> Interrupts allocation is based on interrupt vectors availability and
> distributed to all queues in simple round-robin fashion. For hardware
> Implementation with fixed event type to interrupt vector assignment
> IVEC WARL property is used to discover such mappings.
> 
> Address translation, command and queue fault handling in this change
> is limited to simple fault reporting without taking any action.
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Zong Li <zong.li@sifive.com>
> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> ---
>  drivers/iommu/riscv/iommu-bits.h |  75 +++++
>  drivers/iommu/riscv/iommu.c      | 507 ++++++++++++++++++++++++++++++-
>  drivers/iommu/riscv/iommu.h      |  21 ++
>  3 files changed, 601 insertions(+), 2 deletions(-)

[...]

> +/* Enqueue an entry and wait to be processed if timeout_us > 0
> + *
> + * Error handling for IOMMU hardware not responding in reasonable time
> + * will be added as separate patch series along with other RAS features.
> + * For now, only report hardware failure and continue.
> + */
> +static unsigned int riscv_iommu_queue_send(struct riscv_iommu_queue *queue,
> +					   void *entry, size_t entry_size)
> +{
> +	unsigned int prod;
> +	unsigned int head;
> +	unsigned int tail;
> +	unsigned long flags;
> +
> +	/* Do not preempt submission flow. */
> +	local_irq_save(flags);
> +
> +	/* 1. Allocate some space in the queue */
> +	prod = atomic_inc_return(&queue->prod) - 1;
> +	head = atomic_read(&queue->head);
> +
> +	/* 2. Wait for space availability. */
> +	if ((prod - head) > queue->mask) {
> +		if (readx_poll_timeout(atomic_read, &queue->head,
> +				       head, (prod - head) < queue->mask,
> +				       0, RISCV_IOMMU_QUEUE_TIMEOUT))
> +			goto err_busy;
> +	} else if ((prod - head) == queue->mask) {
> +		const unsigned int last = Q_ITEM(queue, head);
> +
> +		if (riscv_iommu_readl_timeout(queue->iommu, Q_HEAD(queue), head,
> +					      !(head & ~queue->mask) && head != last,
> +					      0, RISCV_IOMMU_QUEUE_TIMEOUT))
> +			goto err_busy;
> +		atomic_add((head - last) & queue->mask, &queue->head);
> +	}
> +
> +	/* 3. Store entry in the ring buffer. */
> +	memcpy(queue->base + Q_ITEM(queue, prod) * entry_size, entry, entry_size);
> +
> +	/* 4. Wait for all previous entries to be ready */
> +	if (readx_poll_timeout(atomic_read, &queue->tail, tail, prod == tail,
> +			       0, RISCV_IOMMU_QUEUE_TIMEOUT))
> +		goto err_busy;
> +
> +	/* 5. Complete submission and restore local interrupts */
> +	dma_wmb();
> +	riscv_iommu_writel(queue->iommu, Q_TAIL(queue), Q_ITEM(queue, prod + 1));

Please explain why a dma_wmb() is sufficient to order the memcpy() stores
before the tail update.

> +	atomic_inc(&queue->tail);

I think this can be reordered before the relaxed MMIO write to tail,
causing other CPUs to exit their polling early.

Will
