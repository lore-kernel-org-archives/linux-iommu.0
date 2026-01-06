Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B038238C33;
	Tue,  6 Jan 2026 06:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767681475; cv=none; b=hVMJ9piBmOHXd3Zy4KMLUYbLShpECzYXJe9MOAMfLZ0bbTsnOjGgm9Nb4uWIurTQCAe43JWLEr71OjWZqMudvDI57EiBqQUnVchCwtZqtgElAS4uUK/e5RIGB/AZz1Uo/+AxT2694GDSrpzPcluVZNTGOxgZ+VcrE+MBO5i8FC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767681475; c=relaxed/simple;
	bh=BTY3qbG6lw8MNKTh9vwaWJkOKG3i9gvUi5qIYXM9YIg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k6bqqsu6v+qMWcH+wM5RFpR8m3jsYgl2F94s2EdWtSLvRw3zlTZ6u6yYiAb9Jz3FCD0bHhS0dXF9q7yYNZM5S3cbpCvYt++zRVSfhLjkp74BaJ2oiehP1RhBpg52bGT3D3WldT6nTTY+hwWcG/POIqCJ6DkWfpy84gYbhNjU0Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Djtf/fF7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Djtf/fF7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2C5DC116C6;
	Tue,  6 Jan 2026 06:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767681475;
	bh=BTY3qbG6lw8MNKTh9vwaWJkOKG3i9gvUi5qIYXM9YIg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Djtf/fF77dkGoLZRmeYTtQMKDKuZXspyLiBRn8sLLSZN58LqZ4Hwy0AdqFJuB84OR
	 t9EDKmBnh/Qfosrc+v/UxfkKeR6+lTJ1urj9DVQWN4uEYZxSti2KpGV6PiC4cd143J
	 vP5EMfWvC9TOmUttC0bP1TGSrAcb2Lk5Uqc5y+/C+GfMkHQW2U08ge5KyYUDvmt6BD
	 gtf1T1ds/IIn4FNLdTTZii7RR5y9aeZo3uG/xYBQzmMS1yLTDPGzUB3tusZIY0IdrC
	 iNhheNm470/0lnEbDE8/8q3ac5ekQE5sXL1B7S+6ohY+2atF8tUTfpK4B9mOZ/wbuO
	 5sGgbBv8bo5Wg==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-coco@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
	maz@kernel.org, tglx@linutronix.de, robin.murphy@arm.com,
	suzuki.poulose@arm.com, akpm@linux-foundation.org,
	steven.price@arm.com
Subject: Re: [PATCH v2 1/4] swiotlb: dma: its: Enforce host page-size
 alignment for shared buffers
In-Reply-To: <20260106011636.GQ125261@ziepe.ca>
References: <20251221160920.297689-1-aneesh.kumar@kernel.org>
 <20251221160920.297689-2-aneesh.kumar@kernel.org>
 <20260106011636.GQ125261@ziepe.ca>
Date: Tue, 06 Jan 2026 12:07:48 +0530
Message-ID: <yq5a7btvjlfn.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Jason Gunthorpe <jgg@ziepe.ca> writes:

> On Sun, Dec 21, 2025 at 09:39:17PM +0530, Aneesh Kumar K.V (Arm) wrote:
>> +#define mem_encrypt_align mem_encrypt_align
>> +static inline size_t mem_encrypt_align(size_t size)
>> +{
>> +	return size;
>> +}
>> +
>
> IMHO this is the wrong API.
>
> The issue here is not about alignment, it is about the permitted
> granule size for shared/private.
>
> On X86 this will be PAGE_SIZE on ARM64 it is
>   max(hypervisor_page_size, PAGE_SIZE)
>
> So think the arch helper should simply be
>
>   __pure size_T mem_encrypt_granule_size(void);
>
>> +	if (WARN_ON(!IS_ALIGNED(addr, mem_encrypt_align(PAGE_SIZE))))
>> +		return 0;
>> +
>> +	if (WARN_ON(!IS_ALIGNED(numpages << PAGE_SHIFT, mem_encrypt_align(PAGE_SIZE))))
>> +		return 0;
>
> And then we don't end up with weiro reading stuff like this..
>
> if (WARN_ON(!IS_ALIGNED(addr, mem_encrypt_granule_size())) ||
>     WARN_ON(!IS_ALIGNED(numpages, mem_encrypt_granule_size() / PAGE_SIZE)))
>
> Is much more readable..
>

I added this helper

>> @@ -319,8 +319,8 @@ static void __init *swiotlb_memblock_alloc(unsigned long nslabs,
>>  		unsigned int flags,
>>  		int (*remap)(void *tlb, unsigned long nslabs))
>>  {
>> -	size_t bytes = PAGE_ALIGN(nslabs << IO_TLB_SHIFT);
>>  	void *tlb;
>> +	size_t bytes = mem_encrypt_align(nslabs << IO_TLB_SHIFT);
>
> The stuff like this is just ALING(nslabs << IO_TLB_SHIFT, mem_encrypt_granule_size())
>

I guess we can still keep mem_encrypt_align so that changes like below
becomes simpler.

-	int page_order = get_order(min_size);
+	int page_order = get_order(mem_encrypt_align(min_size));
 
-aneesh
