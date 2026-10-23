Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792770475;
	b=ih/mmhSW3hqtT/3kyNBdCrNaIc4VpUYX1zEYSsKqkyfTp0jgU5PIb011fkfyvL8DRbR0
	 lPSFDt9EwuW9km1YMYX578FQMxKEUokqGdLMABPsaQCKhpD2ATWQmX0cpU5XCepue4XXo
	 yL0DTcymghVXl4/kyFnnMrYrDQmJfF9TYIpSG6zZufyG5bVrVtahRbmmX62vt1nWrPZ3q
	 NqhXog7+RpqsPWTfgd3n+0QXhLElX71+PyZffzi2MeHe+85lH5BAc3WtL+3orsJV33q1z
	 RnwHhQnc0VXXlsJMZarjNC24Lc8O/HflPCq1TMle2cOPBuEat7r8FGNT9hW/qpHFJ4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792770475;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=3DsEmIpWhaUrP1kKDxG7mvgGgPiDLbGvm+Lflzn35tM=;
	b=5IHq35sCqiHVgD/CfZ1WHZ0Amk877bNS+haSzaZxjm8XZoJkdyrJzHwgL8o/J/gRWJmx
	 fyzqU0Kz+hr9chah1YPHkrBK3aZ6LYbj93dUg96uv+H3G6ftPoQKSVkhqItidjDcx4acQ
	 nAmmWjboxYvtgfOaRktL6niriuuuCBloj2C78Tj974zsD1CDhhXQS9MAmC4cblTmrCqdI
	 oqTd0bfxTBJq2TYlYVXdoxJIw5dF6vlnAPdDBi4SHGuDRi5LazrIF8xp9HzVWjuFY5NAq
	 x/AWWoRh4D8CW21M4zSBIvWBXo6SBJaKtDr6NYaxHx4JtIm3CZqNuiVysqoBcrhKAFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=u1Ini5Be;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CAC1606A31A
	for <iommu@lists.linux.dev>; Fri, 23 Oct 2026 15:47:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CAC1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=u1Ini5Be
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5BE721BA8;
	Fri, 23 Oct 2026 08:47:50 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8AFF33F673;
	Fri, 23 Oct 2026 08:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792770473; bh=Xg66b1aVvtEpuBjEkws2F7fCI9ej9qfpM+sVufIlZOY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=u1Ini5BeZm3JJyjvt1IwHJyvfF87YJZr414R9G0gog02k9tXl9vREUPCSt0rci1JJ
	 1XcYHYFEAkE3ODwSzPMsjPuOZTbkOnYmtDx8WaNJDMHazlxZFdOC/Dh6H68dbRT5dk
	 ak0gpeywka3yHAQD5+1xUQkJ6zEqTsY+GJ7wKgGM=
Message-ID: <d254f075-74bf-495f-bf88-c8db550ce937@arm.com>
Date: Fri, 23 Oct 2026 16:47:50 +0100
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: iommu: TLB sync timeouts and page table freeing on unmap
To: Yuho Choi <oss.patchbox@gmail.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
 Tomasz Jeznach <tomasz.jeznach@linux.dev>, iommu@lists.linux.dev
References: <20261022175408.52254-2-oss.patchbox@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20261022175408.52254-2-oss.patchbox@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/10/2026 6:54 pm, Yuho Choi wrote:
> Hi,
> 
> While looking at how IOMMU drivers handle TLB invalidation timeouts, I
> noticed that several of them only log the timeout and carry on. For
> example, ipmmu_tlb_sync() in drivers/iommu/ipmmu-vmsa.c (v7.3):
> 
> 	if (read_poll_timeout_atomic(ipmmu_ctx_read_root, val,
> 				     !(val & IMCTR_FLUSH), 1, TLB_LOOP_TIMEOUT,
> 				     false, domain, IMCTR))
> 		dev_err_ratelimited(domain->mmu->dev,
> 			"TLB sync timed out -- MMU may be deadlocked\n");
> 
> and qcom_iommu_tlb_sync() in drivers/iommu/arm/arm-smmu/qcom_iommu.c
> does the same. On unmap, __arm_lpae_unmap() in
> drivers/iommu/io-pgtable-arm.c frees a page table right after the walk
> flush:
> 
> 	io_pgtable_tlb_flush_walk(iop, iova + i * size, size,
> 				  ARM_LPAE_GRANULE(data));
> 	__arm_lpae_free_pgtable(data, lvl + 1, iopte_deref(pte, data));
> 
> and the IOMMU core and its callers release the data pages after
> ->iotlb_sync(). Both callbacks return void, so a driver cannot stop
> that when the invalidation did not complete.
> 
> Is a TLB sync timeout considered fatal enough that this does not
> matter,

Yes. If the IOMMU is sufficiently wedged that it's not responding to 
invalidation, there's every chance it's also not processing client 
transactions either. Logging these warnings mainly serves to help 
contextualise related symptoms of the same underlying condition, like a 
client device also reporting errors, or a subsequent register access 
deadlocking entirely.

I can at least speak for arm-smmu-v3 to say that having the timeout 
warnings there has proven useful multiple times in pinpointing hardware 
issues when bringing up platforms on FPGA, but not things that Linux 
itself would ever have to attempt to "handle", or that would ever occur 
on final production hardware.

Thanks,
Robin.

> or would you take changes in this area? For example, a driver
> could record the failure and fail later map requests, as [1], or
> these callbacks could be allowed to return an error.
> 
> This came up during static analysis for research that is not yet
> published; I have not seen such a timeout on hardware. I'm happy to
> send patches if one of these directions is acceptable.
> 
> [1] https://lore.kernel.org/r/e2b13e82-f762-4fb0-83cb-d4bef57be427@linux.dev
> 
> Thanks,
> Yuho

