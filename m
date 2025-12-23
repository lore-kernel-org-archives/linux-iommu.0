Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E6431986D;
	Tue, 23 Dec 2025 08:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766477899; cv=none; b=U76Zpacbmh9ZcZr+IVi5y5GycHzCmGvt3IM0Nl5juIdaW8Q5Ppwn7vOYT1UgoyEhenmJG20BhBsX5Yym5/8gOVKDLG8UMFNkB7dTGOa681Kpj0RRqjfm0CQ3Z8OGgEor9eBxmEryId+mloWpikdfWk6vqNXdfkKGu3CHl+UvBXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766477899; c=relaxed/simple;
	bh=6eulUnmbgXsIvIdg2PSj6P5PQtByGDl1HAD8cVVALfA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D7p2gymdvQ2Gfz01s3JyXs3OP9VX9IrNwz6hUKpZizYrm2RV4ZxWr4Qtdk3C6LdhsCdNDjPKLoyPrWhtIGUC8y7dActvNM6xUUX5trAXW7n/oCCCEQ1rpbcy27XRyWbRGjVO6MSGrSfwiYnPwfSOgKKF7J5OfUHLeflrZgmH3/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Occ2lqxX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Occ2lqxX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B566C113D0;
	Tue, 23 Dec 2025 08:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766477898;
	bh=6eulUnmbgXsIvIdg2PSj6P5PQtByGDl1HAD8cVVALfA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Occ2lqxX/0DkgIjKSzIbK8k7k7CaJg53ns3z04uEFvxDO7Xd0vFGoQnE4A/IRm/Bi
	 ZklyEczLxWYd93NbQtG1uGfiwcv3YtF8dUFF/Sxv2pam7fwbLc855nYvKVHzqAjWwy
	 DPt8AoN2/lUvfVkEhSsSLTub/Ae9RSNEUOWU3emr4AKpkCayKRjwy4lIjFKLqX/Cho
	 kaAxTa7f08/x5yT3jOFZ+pMuTME1XLwEhFscp8lD0FUP2I5OcyaH+hymUZmTRoeJ5b
	 5vdVoGj+6Gr/FUuLYYv2g/0i971zis9xdMcd1LTgZmagb2kPQxrVVVIkUCCfAtUZ3M
	 7I5tmelrkhWCw==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-coco@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
	maz@kernel.org, tglx@linutronix.de, robin.murphy@arm.com,
	akpm@linux-foundation.org, jgg@ziepe.ca, steven.price@arm.com
Subject: Re: [PATCH v2 4/4] dma: direct: set decrypted flag for remapped dma
 allocations
In-Reply-To: <5820e8f3-9cf8-423f-89df-0df7ca78a84b@arm.com>
References: <20251221160920.297689-1-aneesh.kumar@kernel.org>
 <20251221160920.297689-5-aneesh.kumar@kernel.org>
 <5820e8f3-9cf8-423f-89df-0df7ca78a84b@arm.com>
Date: Tue, 23 Dec 2025 13:48:07 +0530
Message-ID: <yq5ams39txvk.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Suzuki K Poulose <suzuki.poulose@arm.com> writes:

> On 21/12/2025 16:09, Aneesh Kumar K.V (Arm) wrote:
>> Devices that are DMA non-coherent and need a remap were skipping
>> dma_set_decrypted(), leaving buffers encrypted even when the device
>> requires unencrypted access. Move the call after the remap
>> branch so both paths mark the allocation decrypted (or fail cleanly)
>> before use.
>> 
>> Fixes: f3c962226dbe ("dma-direct: clean up the remapping checks in dma_direct_alloc")
>> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>> ---
>>   kernel/dma/direct.c | 8 +++-----
>>   1 file changed, 3 insertions(+), 5 deletions(-)
>> 
>> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
>> index 3448d877c7c6..a62dc25524cc 100644
>> --- a/kernel/dma/direct.c
>> +++ b/kernel/dma/direct.c
>> @@ -271,9 +271,6 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>>   	if (remap) {
>>   		pgprot_t prot = dma_pgprot(dev, PAGE_KERNEL, attrs);
>>   
>> -		if (force_dma_unencrypted(dev))
>> -			prot = pgprot_decrypted(prot);
>
> This would be problematic, isn't it ? We don't support decrypted on a
> vmap area for arm64. If we move this down, we might actually use the
> vmapped area. Not sure if other archs are fine with "decrypting" a
> "vmap" address.
>
> If we map the "vmap" address with pgprot_decrypted, we could go ahead
> and further map the linear map (i.e., page_address(page)) decrypted
> and get everything working.

We still have the problem w.r.t free

dma_direct_free():

	if (is_vmalloc_addr(cpu_addr)) {
		vunmap(cpu_addr);
	} else {
		if (dma_set_encrypted(dev, cpu_addr, size))
			return;
	}

-aneesh
