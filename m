Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571DD226EE2
	for <iommu@lists.linux.dev>; Thu,  5 Dec 2024 16:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733417277; cv=none; b=oyh0oKc/6l9PunYAOnB9yI7h0jiIFnfvE690Z0lXYy087MylcEDDrYb3eXwovBFFkEuZd96rjU3fo6F0TypgpkIPrlMuenYcf2G829RuoFm5vlKijfLVz6VusTwxZHDGO7fvfek3ho+k2RNIP7jxnN6WGBLS8ijpBxrdjqBWtYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733417277; c=relaxed/simple;
	bh=IU+eFOmNE8CvqiKfoipivl03I158vNpcxc5SBgBrzYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sFrm4KEY6NLbZ8u+B/Ij4dqyAx4qqeSJjFEZgjKMcLiT7ZQZ2/4PrDC9ouRLnhhDUltlLIeS1MAwsvW6js4P3c17vHg91INMHgvyT/SQmCORy/upSqKNanPNA0rQJyiE4FY6NhsE88FjtpFUcWK3ep52zOZdTx5U2R/sQEzDinA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE6E21063;
	Thu,  5 Dec 2024 08:48:22 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9BD273F5A1;
	Thu,  5 Dec 2024 08:47:52 -0800 (PST)
Message-ID: <6e0209be-c58c-4f42-ae0a-eaa016cd05a5@arm.com>
Date: Thu, 5 Dec 2024 16:47:51 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] rust: add dma coherent allocator abstraction.
To: Daniel Almeida <daniel.almeida@collabora.com>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Valentin Obst <kernel@valentinobst.de>,
 "open list:RUST" <rust-for-linux@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
References: <20241205113234.2021442-1-abdiel.janulgue@gmail.com>
 <20241205113234.2021442-2-abdiel.janulgue@gmail.com>
 <1c13843f-6929-4bc6-8564-0ec2d964c41d@arm.com>
 <c9baa4bb-81db-42ae-98be-d8cb7d57f237@gmail.com>
 <F62F742D-B373-43D1-B527-9B9D3E5DB211@collabora.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <F62F742D-B373-43D1-B527-9B9D3E5DB211@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/12/2024 4:41 pm, Daniel Almeida wrote:
> Hi Abdiel,
> 
>> On 5 Dec 2024, at 11:25, Abdiel Janulgue <abdiel.janulgue@gmail.com> wrote:
>>
>> On 05/12/2024 15:07, Robin Murphy wrote:
>>>> +    pub fn alloc_coherent(
>>>> +        dev: &Device,
>>>> +        count: usize,
>>>> +        flags: kernel::alloc::Flags,
>>> Might it be worth adding at least a placeholder type and argument for "attrs" as well, so there's less churn involved in coming back and adding it later? Or is the intention to have a separate dma_alloc_attrs() constructor for such users?
>>
>> It certainly is possible to include attrs in the constructor using Option:
>> ```
>>     pub fn alloc_coherent(
>>         dev: &Device,
>>         count: usize,
>>         flags: kernel::alloc::Flags,
>>         attrs: Option<u64>,
>>     ) -> Result<CoherentAllocation<T>> {
>>
>> <cut>
>>         let ret = unsafe {
>>             bindings::dma_alloc_attrs(
>>                 dev.as_raw(),
>>                 size,
>>                 &mut dma_handle, flags.as_raw(),
>>                 attrs.unwrap_or(0),

Note that you'd also want to store the attrs in the CoherentAllocation 
itself, since they must be passed to the free and (eventually) mmap 
calls too.

>>             )
>>         };
>> <cut>
>>     }
>>
>> ```
>> So the signature of the constructor could be:
>>
>> let c = CoherentAllocation::alloc_coherent(dev, 4, GFP_KERNEL, None)?;
>>
>> Andreas, Miguel, Daniel, any thoughts?
>>
>> Regards,
>> Abdiel
>>
> 
> Instead of a raw u64, you should take inspiration from the work in the Alloc crate and elsewhere to define
> a proper `flags` type, which you can name `attr` in this case.

Indeed, some type-checking would be rather neat, especially given that 
there are actually different sets of DMA attributes which apply to the 
coherent vs. streaming APIs (and no, that isn't very well documented...)

Thanks,
Robin.
