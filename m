Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519781EA74
	for <iommu@lists.linux.dev>; Tue,  9 Jul 2024 11:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720526035; cv=none; b=bbg3GxSGjJgzD59Q7Yiu8Zn+8NoaGtfPyN3L0a+PnRdbxByW9GZsdZk/SmY+jqy5HlWz/sV7IVBcGMdKY8wDrbFcVt86wc2K7/syA0IBUXG2nyXP2FH9syzBrjDyWIumcFtto5P2lNKu2/9XkFcGsRYl4GCcw6j0W+v79LP8CyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720526035; c=relaxed/simple;
	bh=P1PAnlgaEusVCR67f/r6Ul7rj+Tvw+6FgY27sUFbFqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AL/vJItgWdbaePi7N92A/EBgLyOvvI0IZXjsej8n0PfLsisM2LBEKXGbZjj1KDzXIHK0D+DqO0Ba6aXRJpqZmVnW+DlnrjOCu5nKGzIrSxh4XrL9lMa5xw8ImqEDhEXcgfXfpz8plfHvLUJ4Q/QXOgQiVGW3xLffbAYk8yTMx38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDCA9153B;
	Tue,  9 Jul 2024 04:54:17 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A9C843F762;
	Tue,  9 Jul 2024 04:53:51 -0700 (PDT)
Message-ID: <55b3b816-23f5-40ae-a1fb-5820cb8de0de@arm.com>
Date: Tue, 9 Jul 2024 12:53:41 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -fixes] dma-mapping: add default implementation to
 arch_dma_{set|clear}_uncached
To: Yangyu Chen <cyy@cyyself.name>
Cc: iommu@lists.linux.dev,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Christoph Hellwig <hch@lst.de>
References: <tencent_A5ED71472ADCAF18F59085464CBE23C12A07@qq.com>
 <20240709111901.GC4421@lst.de>
 <tencent_651BC4D11C9730062064ACB186AF4A904005@qq.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <tencent_651BC4D11C9730062064ACB186AF4A904005@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/07/2024 12:39 pm, Yangyu Chen wrote:
> 
> 
>> On Jul 9, 2024, at 19:19, Christoph Hellwig <hch@lst.de> wrote:
>>
>> On Tue, Jul 09, 2024 at 05:25:29PM +0800, Yangyu Chen wrote:
>>> Currently, we have some code in kernel/dma/direct.c which references
>>> arch_dma_set_uncached and arch_dma_clear_uncached. However, many
>>> architectures do not provide these symbols, and the code currently
>>> relies on compiler optimization to cut the unnecessary code. When the
>>> compiler fails to optimize it, the code will reference the symbol and
>>> cause a link error. I found this bug when developing some new extensions
>>> for RISC-V on LLVM. The error message is shown below:
>>
>> Same comment as for the last one.  I think your compiler misbehaves,
>> and the typical reason for that would be if you disable all
>> optimizations.
>>
> 
> The reason is that some optimizations failed to apply after adding
> some passes. I will fix the compiler later. Whatever, we should not
> rely on this optimization to get the code being successfully compiled.

We rely on unreachable code being optimised out *all over* the place - 
it's kind of the main point of constructs like IS_ENABLED(), and why the 
kernel as a whole does not and will not support being compiled with -O0. 
Frankly I'm quite surprised that this one would be the only case you hit 
if your compiler is not doing that properly.

Thanks,
Robin.
