Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D3550097F;
	Fri,  9 Jan 2026 03:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767928554; cv=none; b=u/xiZchtlmFu+ovHqPt253TaZc4hDan7LGeoDLR9BLTaZLEXl1gZjCT+YadFJVlgGmgcAbHJXaZfpeTWxPgmA49qx06JTaf7rwoDrIrFTXRhcvr4QMdfO+n/OGEUor5fByosE2dQJhN9BzEWfAp1MKeSZaAwtS+hywX8I9zErN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767928554; c=relaxed/simple;
	bh=O7AkpeJoA2tDzLIf8XVdUdY/zxdBrpgc5MILVfKOwds=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IPvpmPJJ8/TW8nRJT4bQMFOqFAC+E6/iO6SLVT1L5u4gIlR+/1CFvZtjfli+xQWZsn9VEIE1MD1lohkR8WVLOpdRm6y9pA696s/jP7LTGqMKcPrcQ7iM/+0iWJ6bFxAp7rPlowQna+G1WhUHA5mqO3zre0xKBgo0p0XbhT4nbcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aq3g5Jpt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aq3g5Jpt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FD88C116C6;
	Fri,  9 Jan 2026 03:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767928554;
	bh=O7AkpeJoA2tDzLIf8XVdUdY/zxdBrpgc5MILVfKOwds=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=aq3g5Jpt2waagcIRwf7bXvzFcDACKrqy6May9Yiwb1/gtB71KhrG8XfxpCHdebJXc
	 zY2UF5o7DaRZbSV/TdTXIqBWYfn+0XTaTpoVKD8PaEH4Rxg1dZzCawk0sl/NkPOec1
	 6qg3cOZbPoJzUACaCV6ZKXck2t7xwJX8KWx6VuRtT32bbvoH5DHcdRoUa7g6esYX1o
	 wbqBFUVqp96hhoUjysXFmt4xAN+oLIBoVzV9JVm7vwVfXiQr2yM5FIBc7i4D44FgXW
	 Ap6JGrT+H1JrHOGfDicHRJlHDPz5IBd7wzQoaxLXKf55ySzn8ldyB1Pqy47zCP2jgl
	 sTIpkqwfdqXuA==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH] dma-direct: Skip cache prep for HighMem coherent
 allocations
In-Reply-To: <1ada44db-63a9-43ac-81da-0bdd4e7b7363@arm.com>
References: <20260102155118.2551804-1-aneesh.kumar@kernel.org>
 <CGME20260108105031eucas1p2a3e8d0308ae6a5d43b5250ca8b14ecb9@eucas1p2.samsung.com>
 <9cbe49ae-6612-491d-8ac6-6a99a08d73e2@arm.com>
 <9f28b833-5813-4e5d-b705-eed9a2a31863@samsung.com>
 <1ada44db-63a9-43ac-81da-0bdd4e7b7363@arm.com>
Date: Fri, 09 Jan 2026 08:45:48 +0530
Message-ID: <yq5a4iov5vdn.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Robin Murphy <robin.murphy@arm.com> writes:

> On 2026-01-08 12:41 pm, Marek Szyprowski wrote:
>> On 08.01.2026 11:50, Robin Murphy wrote:
>>> On 2026-01-02 3:51 pm, Aneesh Kumar K.V (Arm) wrote:
>>>> dma_direct_alloc() calls arch_dma_prep_coherent() to clean any dirty
>>>> cache lines from the kernel linear alias before creating a coherent
>>>> remapping.
>>>>
>>>> HighMem pages have no kernel alias mapping, so there are no alias cache
>>>> lines to clean. Skip arch_dma_prep_coherent() for HighMem allocations.
>>>
>>> This is assuming that caches are always cleaned when unmapping
>>> highmem, and no still-mapped highmem pages are dirty - how is that
>>> guaranteed? The fact that they're not in the linear map doesn't mean
>>> they don't necessarily have kernel aliases in either vmalloc
>>> pagetables or caches.
>> 
>> 
>> Right, so it is better to keep this unconditional
>> arch_dma_prep_coherent() call. I will drop it from dma-mapping-fixes then.
>
> Yeah, I think the confusing thing here is that there are architectures 
> with CONFIG_HIGHMEM that don't actually check for and handle it in their 
> arch_dma_prep_coherent() as they seemingly should, however I'm not sure 
> off-hand whether they also support/use highmem CMA in the manner that 
> could end up being an issue in practice (the lack of any reports of 
> crashes or DMA corruption over the last however many years suggests not...)
>

Should we then remove the PageHighMem() check with DMA_ATTR_NO_KERNEL_MAPPING?

-aneesh
