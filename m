Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40E83E8C75;
	Tue, 20 Jan 2026 14:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768918707; cv=none; b=VvCWbHUIK/abtgJJKysPejjb7Tyc1fZ1f8NNpMMJEJEbci/YRUSzgGwiN7ewoW3XorityturW0V1LvZ20MhCjQE1pQKLewYwrynWkfq0B/ehfjavEMor1eXn3b1A9O50XXXi3zkYs+6pC5JhJq4FbEliDY/8yQOS21sYN0/0Xbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768918707; c=relaxed/simple;
	bh=jYFmjGVn9Gxazb7ic7mjZ4Hmn+5VpeE8sTh+tba5U8c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SI2zqfkKGO3fk5VDHe3y674lCJJ/1p319pAEUSwf3y9rE0D5ApQ1cS3v54tqkNiYNgoNiR5az8oh2YQoXTH/TrTCOC6soVn594GS707Dsre8Q7WTlwRZob1XKa72zAQIOEWEaaEF2dO+yhddze7tQ7xiWs4As0KiTMMsnGhvfMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pVvAc6zl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pVvAc6zl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B06FDC16AAE;
	Tue, 20 Jan 2026 14:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768918706;
	bh=jYFmjGVn9Gxazb7ic7mjZ4Hmn+5VpeE8sTh+tba5U8c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=pVvAc6zl4bM7WVDlOBk8xPsQTp8Zmhi58d7XVrBilgjVYLWrqhe64IImFsYWXhAXR
	 SaEaBrIsxtG1k8oeNWFjodyYEbS6eWZZrfe0W2xKrNCemYW3Adjwj4eVv0fa82FIPB
	 6J8QLD6ojy/RvHGsYjvaPi2yKOZ/+gCiqm51pv7/jz4/nZXRc8KzBwo7tIu7S2p47Z
	 ivNjHS0RtihZ5IhK6q7vg9RSYRfIaYAcFUPWpfr9e96haY2RTNJOqKjdGIhvcDr8El
	 8085o9dsBKUOc0VI/eBd08+3I1LBrsdG+DbFcQL40LB64BG57V+DaJ9QHr4ErRWgtI
	 KopNUmhTx5esA==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-coco@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
	robin.murphy@arm.com, jgg@ziepe.ca, steven.price@arm.com,
	Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 1/2] dma-direct: Validate DMA mask against canonical DMA
 addresses
In-Reply-To: <2a0b6d1b-875a-4075-8fc9-a8534afc9168@arm.com>
References: <20260120064255.179425-1-aneesh.kumar@kernel.org>
 <2a0b6d1b-875a-4075-8fc9-a8534afc9168@arm.com>
Date: Tue, 20 Jan 2026 19:48:14 +0530
Message-ID: <yq5atswgjrkp.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Suzuki K Poulose <suzuki.poulose@arm.com> writes:

> On 20/01/2026 06:42, Aneesh Kumar K.V (Arm) wrote:
>> On systems that apply an address encryption tag or mask to DMA addresses,
>> DMA mask validation must be performed against the canonical DMA address.
>> Using a non-canonical (e.g. encrypted or unencrypted) DMA address
>> can incorrectly fail capability checks, since architecture-specific
>> encryption bits are not part of the device=E2=80=99s actual DMA addressi=
ng
>> capability. For example, arm64 adds PROT_NS_SHARED to unencrypted DMA
>> addresses.
>>=20
>> Fix this by validating device DMA masks against __phys_to_dma(), ensuring
>> that the architecture encryption mask does not influence the check.
>>=20
>> Fixes: b66e2ee7b6c8 ("dma: Introduce generic dma_addr_*crypted helpers")
>
>
>> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>> ---
>>   kernel/dma/direct.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
>> index 8e04f72baaa3..a5639e9415f5 100644
>> --- a/kernel/dma/direct.c
>> +++ b/kernel/dma/direct.c
>> @@ -580,12 +580,12 @@ int dma_direct_supported(struct device *dev, u64 m=
ask)
>>=20=20=20
>>   	/*
>>   	 * This check needs to be against the actual bit mask value, so use
>> -	 * phys_to_dma_unencrypted() here so that the SME encryption mask isn't
>> +	 * __phys_to_dma() here so that the arch specific encryption mask isn't
>>   	 * part of the check.
>>   	 */
>>   	if (IS_ENABLED(CONFIG_ZONE_DMA))
>>   		min_mask =3D min_t(u64, min_mask, zone_dma_limit);
>> -	return mask >=3D phys_to_dma_unencrypted(dev, min_mask);
>> +	return mask >=3D __phys_to_dma(dev, min_mask);
>
> This is wrong, isn't it ? For e.g., for CCA, even though the "Flag" is
> added to the PA, it is really part of the actual "PA" and thus must be
> checked against the full PA ?
>

That is true only when the device is operating in untrusted mode?. For a
trusted device that mask is valid mask right?

-aneesh
