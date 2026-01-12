Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6339828002B;
	Mon, 12 Jan 2026 12:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768220535; cv=none; b=XzAitCUXaUHZHltcPe+LuZC4t/VgxlpV7o4ozYS/zLKjrg56FvJ458NwpLA5CDEZDeevISPebxe6tmyUuXgPiwEksk7NV/XE+HvTWMfbDOZGU+xaKZRRX5gOi2vNCGANk5H7BSe4B9SAb50FDrIoaoz+/oGD2+ClwhPBxG6osd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768220535; c=relaxed/simple;
	bh=In/hpMRJfhiXzhzZwIdodDpGGdbZM78IgG2doxTojRg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RONLJOKjk7T6dZLc7nY++Q4YR0FxXXQboJ6DH7gnPOM3eysA5finsHwa4Uq7aApQR5sVrmHADzFLmSR5aebb9INoKeEp9OUhTTQkxafZexpxgkT+wZk1rvYPZpVmZq4BQ9lnQG9jkhRwSmYgV1rUVtl8hgrtmJ58aAzCPOq6Zm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uoRHMqLC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uoRHMqLC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75184C16AAE;
	Mon, 12 Jan 2026 12:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768220535;
	bh=In/hpMRJfhiXzhzZwIdodDpGGdbZM78IgG2doxTojRg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=uoRHMqLCYjA19cYSXsN3rOETGaopZKHHwjj2gK+WuMdLeVLv4viV0nibx15+1Gezu
	 +eGDRzZVTdy7HN/c3KotgetK58ho7o2A1Z9s1xGrve2wpGIUQiQe+NTczvoWPvBWq6
	 MIVhrLV5u5/dt3XmdvaERcDW5jVlIAM++VCDIDDJQ7ZcQIQMMSZ2ZxNzyFwjJFOH3d
	 tRTtcM768KJQ7B3AxV4UwOd8PFXbT6HqPV6RpSddDhp/OellW0OBVG957N/8BpJLg+
	 GclFSbXlb/52B0rv3EMJkbNgPJjBzx7htPQcF4IvwzQ9qbZVAhKEy5xbj6gipBY4ER
	 QTt7mvT80dcMw==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH] dma-direct: Skip cache prep for HighMem coherent
 allocations
In-Reply-To: <f827085f-0084-41d8-8ab5-a0ecfc0260d2@samsung.com>
References: <20260102155118.2551804-1-aneesh.kumar@kernel.org>
 <CGME20260108105031eucas1p2a3e8d0308ae6a5d43b5250ca8b14ecb9@eucas1p2.samsung.com>
 <9cbe49ae-6612-491d-8ac6-6a99a08d73e2@arm.com>
 <9f28b833-5813-4e5d-b705-eed9a2a31863@samsung.com>
 <1ada44db-63a9-43ac-81da-0bdd4e7b7363@arm.com>
 <yq5a4iov5vdn.fsf@kernel.org>
 <f827085f-0084-41d8-8ab5-a0ecfc0260d2@samsung.com>
Date: Mon, 12 Jan 2026 17:52:08 +0530
Message-ID: <yq5afr8bdnrj.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Marek Szyprowski <m.szyprowski@samsung.com> writes:

> On 09.01.2026 04:15, Aneesh Kumar K.V wrote:
>> Robin Murphy <robin.murphy@arm.com> writes:
>>> On 2026-01-08 12:41 pm, Marek Szyprowski wrote:
>>>> On 08.01.2026 11:50, Robin Murphy wrote:
>>>>> On 2026-01-02 3:51 pm, Aneesh Kumar K.V (Arm) wrote:
>>>>>> dma_direct_alloc() calls arch_dma_prep_coherent() to clean any dirty
>>>>>> cache lines from the kernel linear alias before creating a coherent
>>>>>> remapping.
>>>>>>
>>>>>> HighMem pages have no kernel alias mapping, so there are no alias cache
>>>>>> lines to clean. Skip arch_dma_prep_coherent() for HighMem allocations.
>>>>> This is assuming that caches are always cleaned when unmapping
>>>>> highmem, and no still-mapped highmem pages are dirty - how is that
>>>>> guaranteed? The fact that they're not in the linear map doesn't mean
>>>>> they don't necessarily have kernel aliases in either vmalloc
>>>>> pagetables or caches.
>>>> Right, so it is better to keep this unconditional
>>>> arch_dma_prep_coherent() call. I will drop it from dma-mapping-fixes then.
>>> Yeah, I think the confusing thing here is that there are architectures
>>> with CONFIG_HIGHMEM that don't actually check for and handle it in their
>>> arch_dma_prep_coherent() as they seemingly should, however I'm not sure
>>> off-hand whether they also support/use highmem CMA in the manner that
>>> could end up being an issue in practice (the lack of any reports of
>>> crashes or DMA corruption over the last however many years suggests not...)
>>>
>> Should we then remove the PageHighMem() check with DMA_ATTR_NO_KERNEL_MAPPING?
>
> Right, this has to be unified.

I had a related question, how do we handle cache flushes required for
architectures that don't implement CONFIG_ARCH_HAS_DMA_PREP_COHERENT (arch/arm)?

-aneesh
