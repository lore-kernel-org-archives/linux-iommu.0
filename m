Received: from mta0.migadu.com (out-102.mta0.migadu.com [91.218.175.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B2E442391
	for <iommu@lists.linux.dev>; Sat,  5 Sep 2026 18:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788633441; cv=none; b=FgT/cTJS5zDThnxydMX0euKmrduMO4RisW/yRn4SFPPAP8kHn+Xf7MCAysjcaBae7S2RwOypJWTyDwAPKFu9NmGg0cVaq+NfY0NOgUhJ4sFoLaElcdEJkh3WaJs85K+kJ+IrYR3O3xIDTUSE3aQVt6rDaJqsOSzuFBMOLPorFZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788633441; c=relaxed/simple;
	bh=I2hZAS3S7zBbw3qzs6V1oH6J1n9227ey8lD2DiKGnxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XSWf6pIW4IXhZolHhPOQuujQvksyWhAQvbRh1vW2ZeTkFONUFAh/TJDeLWa9QceT2n+41qVDXaTRfyVzAzoLV/y+unXBiqtlLyshwefYhCvj2zQF9g3O7Sg8/Grbt09mLtfiF2QLfeIoUrCiJCs6EyAqh/A6esRrJTLbFxNPevE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Tgwr3fBy; arc=none smtp.client-ip=91.218.175.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Tgwr3fBy"
X-Envelope-To: iommu@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=I2hZAS3S7zBbw3qzs6V1oH6J1n9227ey8lD2DiKGnxs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788633437; v=1; x=1789238237;
 b=Tgwr3fByoRlxbTz+enl3FTypVoOTKxfx6DQ7FukQerkr5XKMsnMPIX5w1Tn8+Ov1WzT7FZAc
 oUasCBoBFYaT1dnOlMTFql3NssmB1Uzy+8J6IGV/dEzurnxf9K/LLXe2pQ72dFd8Bfeg56JpAE5
 009OmVZjFZBT75GPWAyq4i5A=
X-Envelope-To: iommu@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id ea0f1e74fddd1034;
	Sat, 05 Sep 2026 18:37:07 +0000
X-Mizu-Trace-ID: ea0f1e74fddd1034
X-Migadu-Flow: FLOW_OUT
Message-ID: <b36f40ac-cd77-a480-d558-139334334b16@linux.dev>
Date: Sat, 5 Sep 2026 14:37:05 -0400
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] dma-mapping: don't trace the DMA address when the
 allocation fails
Content-Language: en-US
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260905071919.30784-1-donggeunyoo.kernel@gmail.com>
 <568a4f04-e0db-342a-13a8-886cf6b2a8ab@linux.dev>
 <20260905172650.158565-1-donggeunyoo.kernel@gmail.com>
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20260905172650.158565-1-donggeunyoo.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/5/26 13:26, Donggeun Yoo wrote:
> On 9/5/26 08:57, Sean Anderson wrote:
>> I don't understand what you mean. We are literally in an if-statement
>> that checks whether the allocation succeeded.
> 
> That if checks whether the device has a coherent pool, not whether the
> allocation out of it worked. dma_alloc_from_dev_coherent():
> 
>   * Returns 0 if dma_alloc_coherent should continue with allocating from
>   * generic memory areas, or !0 if dma_alloc_coherent should return @ret.
> 
> It returns 1 as soon as it finds a pool; __dma_alloc_from_coherent()
> stores NULL in @ret and leaves *dma_handle alone when the request is
> larger than the pool or the pool is full. The third paragraph of the
> commit message says this.
> 
> The second hunk is under no condition at all: dma_direct_alloc(),
> iommu_dma_alloc() and ops->alloc() return NULL on failure, and the trace
> below the if/else chain runs either way.

Ah, I see what you mean. TBH I would just do something like

cpu_handle ? *dma_handle : NULL

to make it clear what we're doing

--Sean
