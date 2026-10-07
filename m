Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAECB3A59A3
	for <iommu@lists.linux.dev>; Wed,  7 Oct 2026 16:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791391207; cv=none; b=APHovhO97DjtIqy6YJDpWfpMY2U6LhLN+1E+Su9cAh8dpX2zZcAqC28G0pbt5j6rzuUGjPcGX+DiIq/azP/3z4k7KN2vM8PVQruzwJONBS9hYGnuNtpE+d/MnMOCD81rJOpafIZzhXm8gh4e40betB5er2vIFdGQcb9cZMcFUYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791391207; c=relaxed/simple;
	bh=RsIlUhbc158q92/khn0EiHUvOM1rXiYQlXQLjAYxhwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B10I7IYIhw6L7XQDbBqH4G+re0axoLPZlUHrkxl8/eqG8xHfAMJSscEy1LWj1+jrha6eupl7eOW6ZblROZKfhn9Yd2/kSV/70mHkvDCyABf0lq2FAtcysLWUpoLYtG/iuH80op3SFYGldv3kJ2R/cuMiJEf5nd1Pfpt0a2Cp784=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=m1KTjd4I; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="m1KTjd4I"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8FB7F1595;
	Wed,  7 Oct 2026 09:40:01 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4AE1A3F763;
	Wed,  7 Oct 2026 09:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791391204; bh=RsIlUhbc158q92/khn0EiHUvOM1rXiYQlXQLjAYxhwM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=m1KTjd4IbrVvo4Jn+1KiWqZ+1amstNgSAC4kx26kLFrJLx7Br2Ezd7m5Qs5gB+4Dj
	 iLXs7Wonp73ii65YHcN+5g1IMI6sI3tTq6z8PsBPDxKdEkxGlhO7NR+nAFPVHgsVYy
	 6k9Ml23TjlULpXp6wmv0RB8GZZOqAmEFcMDlycow=
Message-ID: <ae8db5bf-9f9e-4f0d-afa1-91718323568e@arm.com>
Date: Wed, 7 Oct 2026 17:39:58 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu/arm-smmu-v3: Align memory attributes for
 SMMU-originated accesses
To: Daniel Mentz <danielmentz@google.com>
Cc: iommu@lists.linux.dev, will@kernel.org, joro@8bytes.org,
 nicolinc@nvidia.com, smostafa@google.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 dawei.li@linux.dev, jgg@ziepe.ca, praan@google.com
References: <20261004195027.227748-1-danielmentz@google.com>
 <92758f79-d5b7-4c15-a55d-6bea5f84a028@arm.com>
 <CAE2F3rAJdC9pAqMKcXhxpw1keGzH_kQUNBoPHXjTP8+7TOhfwQ@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <CAE2F3rAJdC9pAqMKcXhxpw1keGzH_kQUNBoPHXjTP8+7TOhfwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05/10/2026 10:26 pm, Daniel Mentz wrote:
> On Mon, Oct 5, 2026 at 9:42 AM Robin Murphy <robin.murphy@arm.com> wrote:
>> This still isn't answering the question of "why?" though. Yes the
>> architecture says some things, but if we were strict about avoiding
>> mismatched attributes then Linux couldn't ever support non-coherent DMA
>> at all! Similarly while the architecture does permit SMMU
>> implementations to be picky about their output attributes, does any such
>> implementation actually exist at all, let alone in a system capable of
>> running mainline Linux?
> 
> Fair point that existing implementations have been forgiving in
> practice. My thinking here is simply that a small, self-contained
> cleanup that brings the driver into line with the architecture spec is
> worthwhile on its own merits, even without a known implementation where
> this currently causes problems.
> 
> This is really in the same spirit as your commit 7618e4790982
> ("iommu/io-pgtable-arm: Improve attribute handling"), which aligned the
> attribute handling with the architecture specification on the basis
> that:
> 
>    "Although the SMMU architectures seem to give some slightly stronger
>     guarantees of Non-Cacheable output types becoming implicitly Outer
>     Shareable in most cases, we may as well be explicit and not take any
>     chances."

That was more about being self-consistent and technically compliant with 
VMSAv7, which again is not relevant to SMMUv3. In fact if we _only_ had 
to support SMMUv3 and not arbitrary other io-pgtable users then we could 
point to 13.1.7 "Ensuring consistent output attributes" to prove that 
that change would not have been necessary.

> As I noted in my reply on the v1 thread [1], under ARM IHI 0070
> (sections 3.15, 6.3.11, and 13.1.2), a non-coherent SMMUv3
> implementation (SMMU_IDR0.COHACC == 0) in which every SMMU-originated
> access configured with Normal Write-Back, Inner Shareable attributes
> fails and records an External Abort (F_STE_FETCH, F_CD_FETCH,
> CERROR_ABT, etc.) is completely architecturally compliant, yet wouldn't
> work with the current arm-smmu-v3 driver.

Sure, and another system could only support iNC-oWB, wherein this change 
still wouldn't work. If you want to argue against making assumptions 
about the implementation/interconnect, you can't simply make a slightly 
different assumption about the implementation/interconnect ;)

In fact for maximum fun, you could even have an interconnect that only 
supports the iWB-oWB-ISH type, but the SMMU is still non-coherent since 
it's in a _different_ inner shareability domain from the CPUs...

Yes, 13.1.2 "Attribute support" says that the system may not support all 
memory types, and unsupported ones may abort, but then equally it says 
"[...] the SMMU is not required to generate attributes that it does not 
use. With the exception of R/W, INST, and PRIV all configuration fields 
that affect unused attributes are IGNORED." And this is why the 
mismatched attributes argument doesn't stand up on its own - without 
knowing the system-specific details of exactly what is being ignored 
from what we think we've programmed, how can we say what the actual 
attributes used to access memory really are, and thus what is or isn't 
mismatched?

Thanks,
Robin.

> It seems reasonable to be explicit here too and program attributes that
> are valid per the spec, rather than relying on the interconnect to
> silently degrade Write-Back attributes to Non-Cacheable.
> 
> [1] https://lore.kernel.org/linux-iommu/CAE2F3rACz6Z7X3NNfLWEfjTD9K9YJyYHHyGzcBafEemTFGhgqQ@mail.gmail.com/
> 
> Thanks,
> Daniel

