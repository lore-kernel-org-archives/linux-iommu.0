Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7178D3C457D
	for <iommu@lists.linux.dev>; Tue, 21 Apr 2026 12:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776776097; cv=none; b=Uh43uXb8+ywLsCJg4lOcjFKvMDcGJoRsMNF9dmsK7o0C2MPJ5QTwXVKWE9FbuiMltT1Fv+eCQjplorsgumqnHgeRSeHnPCF139rgKupTDHbuqbVWnXPDi0W6MtEi0U18XKRpRI8pS/YiqaAFjs/QLSLWmXvzfTegsIx8ztml0EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776776097; c=relaxed/simple;
	bh=fodvftv33ebpx4wJKdHyNpCWMGGrih5vKtq5237bJL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z+qqI8lhAo0LTx3NUTHN0wJCPsDuF/HSvnAmTcZPF6SMnVAEMyvUMjksrIDxWtJn/EkMJiv4A3BY0BjDiS1CfLvvYIJU1JmAmkMMvTIqenIXjZKkj32ulTNG2NdmCO+cTYHZIPc8TYuCQrcFbX6x5cjG38cZgTuSpyXkKrs9Ggo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Fqm2ws5X; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Fqm2ws5X"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A1C925DC;
	Tue, 21 Apr 2026 05:54:50 -0700 (PDT)
Received: from [10.57.20.50] (unknown [10.57.20.50])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B83B3FE76;
	Tue, 21 Apr 2026 05:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1776776095; bh=fodvftv33ebpx4wJKdHyNpCWMGGrih5vKtq5237bJL0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Fqm2ws5XKWUo4weToB3fmpoY24dHZjI5DSdM7S9M0Vqd4mKMG2ogls8rcE/HRf+yL
	 whP3OGTN89sJGr7x0kaucC6RkMydZaKjuyigGorl1Ot7ofPRucNV+u+ka+rlzOobyE
	 HOPy/ut9f7o7wJaxxiASIesEo49PhrIB54lHmGII=
Message-ID: <d83e00a6-6c01-4640-bd69-e10daeedeeae@arm.com>
Date: Tue, 21 Apr 2026 13:54:52 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] dma-direct: set decrypted flag for remapped DMA
 allocations
Content-Language: en-GB
To: Jason Gunthorpe <jgg@ziepe.ca>,
 "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org,
 maz@kernel.org, catalin.marinas@arm.com, jiri@resnulli.us,
 Mostafa Saleh <smostafa@google.com>
References: <20260420061415.3650870-1-aneesh.kumar@kernel.org>
 <20260420061415.3650870-8-aneesh.kumar@kernel.org>
 <20260421123419.GC3611611@ziepe.ca>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20260421123419.GC3611611@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/04/2026 13:34, Jason Gunthorpe wrote:
> On Mon, Apr 20, 2026 at 11:44:14AM +0530, Aneesh Kumar K.V (Arm) wrote:
>> Devices that are DMA non-coherent and require a remap were skipping
>> dma_set_decrypted(), leaving DMA buffers encrypted even when the device
>> requires unencrypted access. Move the call after the if (remap) branch
>> so that both the direct and remapped allocation paths correctly mark the
>> allocation as decrypted (or fail cleanly) before use.
>>
>> Architectures such as arm64 cannot mark vmap addresses as decrypted, and
>> highmem pages necessarily require a vmap remap.
> 
> I don't think I saw an aswer for this, why can't arm accept
> pgprot_decrypted() for vmap? It really should, I don't think we should
> have these minor pointless arch differences.
> 
> Suzuki? You mentioned it, can you elaborate?

We can accept pgprot_decrypted(), but this must be done carefully
as the backing pages must be first converted to "decrypted" in the
linear map (set_memory_decrypted()).

With that in place, it should be fine. It is, 
set_memory_decrypted(vmalloc_address) is we don't support.

Cheers
Suzuki

> 
> Jason

