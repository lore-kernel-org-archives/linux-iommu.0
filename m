Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF8B3314C4;
	Fri, 17 Apr 2026 15:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776440104; cv=none; b=I6ZiX73V5yvUfjsRi1EeUeYnrh+XyeS4XYGzn0INc/guadyw7QApj9qIPFXC+ZCrzv4CfdAA66dajydvvdavyGIKgAAgtQZGQveGGUjNJFaWqy/bF8F59OWqYaA9OMo5OCSCmHXNY1YdaPO7TOT65D5X09tiG9kX0wVvJ5h+fG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776440104; c=relaxed/simple;
	bh=MXC5T84fFHWYdoGwwTdQ27efFFHWa0KZWj7r2wHR2Xk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lNt80Nj+zeB+CG13F5YC8Ej07iBZoxMPLvFtEwUR8EfZ8IQiWWUPa2+tn+OF0iwtxDm6hrjx+QhRSyPnUbgG1e6Qz/kcMIKC3wWY2QG30NHuPRYCZnhPobD1v4LEkxEpDo39SZeDc8p4L8q0YFWThEgA3I8kWL0KDxjNW8Oydok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IAf5mbq+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IAf5mbq+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FA16C19425;
	Fri, 17 Apr 2026 15:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776440104;
	bh=MXC5T84fFHWYdoGwwTdQ27efFFHWa0KZWj7r2wHR2Xk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=IAf5mbq+Jz86ny9+ALOP4pyxG1kM1byimf5rZY/VpMITeYdJ0depARewkLoWICzOv
	 AyDjz1hnt/muuc359E/kK0jpNJQUrl5QbIZDyIOQJv4llHr9DnIol3OXLVw8VHxWYb
	 8ASMnjXGPCY8jlAGGMwW0u9mC2YMIlGwj5VspownppWAmR9Okt2c8wPLJRyzZX5j3S
	 811vC4/uvsqGLVtBfrF9k21cfclYZUd7+1unMqf51t8L91GhWe05A7n/v5kZppmjF+
	 4b/WRYnv5Obq1DApOv0DsBhwVmNdZkAJuoBr1iztWE2+cCLxgVjNSqTsAJd+GXsTxu
	 suDXOFlTFkkgw==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org,
	maz@kernel.org, suzuki.poulose@arm.com, catalin.marinas@arm.com,
	jiri@resnulli.us, Mostafa Saleh <smostafa@google.com>
Subject: Re: [RFC PATCH 2/7] dma-direct: use DMA_ATTR_CC_DECRYPTED in
 alloc/free paths
In-Reply-To: <20260417152828.GJ2577880@ziepe.ca>
References: <20260417085900.3062416-1-aneesh.kumar@kernel.org>
 <20260417085900.3062416-3-aneesh.kumar@kernel.org>
 <20260417152828.GJ2577880@ziepe.ca>
Date: Fri, 17 Apr 2026 21:04:56 +0530
Message-ID: <yq5a340tiorj.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Jason Gunthorpe <jgg@ziepe.ca> writes:

> On Fri, Apr 17, 2026 at 02:28:55PM +0530, Aneesh Kumar K.V (Arm) wrote:
>> Propagate force_dma_unencrypted() into DMA_ATTR_CC_DECRYPTED in the
>> dma-direct allocation path and use the attribute to drive the related
>> decisions.
>> 
>> This updates dma_direct_alloc(), dma_direct_free(), and
>> dma_direct_alloc_pages() to fold the forced unencrypted case into attrs.
>> 
>> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>> ---
>>  kernel/dma/direct.c | 34 ++++++++++++++++++++++++++--------
>>  1 file changed, 26 insertions(+), 8 deletions(-)
>> 
>> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
>> index c2a43e4ef902..3932033f4d8c 100644
>> --- a/kernel/dma/direct.c
>> +++ b/kernel/dma/direct.c
>> @@ -201,16 +201,21 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>>  		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
>>  {
>>  	bool remap = false, set_uncached = false;
>> -	bool mark_mem_decrypt = true;
>> +	bool mark_mem_decrypt = !!(attrs & DMA_ATTR_CC_DECRYPTED);
>>  	struct page *page;
>
> This is changing the API, I think it should not be hidden in a patch
> like this, also not sure it even makes sense..
>
> DMA_ATTR_CC_DECRYPTED only says the address passed to mapping is
> decrypted. It is like DMA_ATTR_MMIO in this regard.
>
> Passing it to dma_alloc_attrs() is currently invalid, and I think it
> should remain invalid, or at least this new behavior introduced in its
> own patch deliberately.
>

That is probably confusion on my side. I thought all the DMA attr can be
used on the alloc side to specify the attribute for DMA allocation
buffer. 

>
> Meaning, if you call dma_direct_alloc() force_dma_decrypted decides
> what setting DMA_ATTR_CC_DECRYPTED takes and it is EOPNOTSUPP if the
> user passes it in.
>

Sure, I can update the patchset to implement the above.

-aneesh
