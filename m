Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0046722A807
	for <iommu@lists.linux.dev>; Thu, 16 Jan 2025 13:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737035879; cv=none; b=a2gL9i1A/yw8dHFAg2LHi6DMVu8F0dLfiZJmazAO4v8tVKuCv/ryVrfyBV+wRklycj7Dai7qs0Bk2cQr03gELaYPjcwJzBH91nSoTWWjTwfMQDS6qqODT/6YviqqXQX5QIJjc4ZqPcfHB3+F5zpQ10G0kC4J9OOw/Vt3TKrpmZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737035879; c=relaxed/simple;
	bh=Yxc7jw/iPG3lesopnp3CRUrq2Z0zQcEcGDnjRQLXBV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HiAaspeY9i/G5D6ma9TMqOGen6aCc8CAcwaOV2TlJMoVIAtW2VtS9bD1tAaFXaWMatVfY7DMdtTUtxggEJll3aLQxWKedQNitZI7tYeqzsT6Ly0ThFoB5sXs3GiTY/se+bfQi6RE+ATXPwLI1gpDsIvjS6moURKBobsM79yO7gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9EDB9106F;
	Thu, 16 Jan 2025 05:58:25 -0800 (PST)
Received: from [10.1.25.40] (010265703453.arm.com [10.1.25.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 44D333F73F;
	Thu, 16 Jan 2025 05:57:54 -0800 (PST)
Message-ID: <bbc60912-7ed5-4bb1-b273-8061abe49e10@arm.com>
Date: Thu, 16 Jan 2025 13:57:50 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] rust: add dma coherent allocator abstraction.
To: Danilo Krummrich <dakr@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, daniel.almeida@collabora.com,
 aliceryhl@google.com, rust-for-linux@vger.kernel.org,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Valentin Obst <kernel@valentinobst.de>,
 open list <linux-kernel@vger.kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
 Greg KH <gregkh@linuxfoundation.org>
References: <20250108122825.136021-1-abdiel.janulgue@gmail.com>
 <20250108122825.136021-3-abdiel.janulgue@gmail.com>
 <20250108135951.GA18074@lst.de>
 <CANiq72=R2N+QiCiHZQu-6YJ9aYpn_bik3BW3U=nAW3jL7unzLw@mail.gmail.com>
 <20250108151858.GB24499@lst.de> <Z36X_ZnCmBQBMoZ6@pollux>
 <20250109080812.GA20431@lst.de> <Z3-NqwAG_96yq8VD@pollux>
 <20250110083955.GA5395@lst.de> <Z4D5a5NYrAbNxUL6@pollux>
 <Z4kG5AcVeQKegLnb@pollux>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <Z4kG5AcVeQKegLnb@pollux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-01-16 1:17 pm, Danilo Krummrich wrote:
> On Fri, Jan 10, 2025 at 11:41:54AM +0100, Danilo Krummrich wrote:
>> On Fri, Jan 10, 2025 at 09:39:55AM +0100, Christoph Hellwig wrote:
>>> On Thu, Jan 09, 2025 at 09:49:47AM +0100, Danilo Krummrich wrote:
>>>> On Thu, Jan 09, 2025 at 09:08:12AM +0100, Christoph Hellwig wrote:
>>>>> On Wed, Jan 08, 2025 at 04:21:33PM +0100, Danilo Krummrich wrote:
>>>>>> What does "your code" mean? Duplicated in every driver?
>>>>>
>>>>> Yes, interfaces to the DMA API should stay in readable C code and not
>>>>> in weird bindings so that it reminds greppable and maintainable.
>>>>>
>>>>
>>>> Rust drivers shouldn't use C APIs directly, but rather use an abstraction of the
>>>> corresponding C API.
>>>
>>> Don't force me to deal with your shiny language of the day.
>>
>> Again, no one asks you to deal with or maintain this piece of Rust code.
>>
>>> Maintaining
>>> multi-language projects is a pain I have no interest in dealing with.
>>> If you want to use something that's not C, be that assembly or rust you
>>> write to C interfaces and deal with the impedence mismatch yourself as
>>> far as I'm concerned.
>>>
>>
>> This is exactly what we're doing and proposing here, isn't it?
>>
>> We wrote a single piece of Rust code that abstracts the C API for all Rust
>> drivers, which we offer to maintain ourselves.
>>
>> What else are you asking for?
> 
> Since there hasn't been a reply so far, I assume that we're good with
> maintaining the DMA Rust abstractions separately.

Indeed, FWIW it seems like the appropriate level of abstraction to me, 
judging by the other wrappers living in rust/kernel/ already. As far as 
the interaction with C code goes, it appears to be a pretty 
straightforward midlayer consumer of the DMA API much like others we 
already have (e.g. videobuf2-dma-*), just one which happens to be a 
language binding rather than some other kind of functional abstraction.

There is a realistic chance that the C API will evolve in ways which 
break the binding, but as long as a) that won't break non-Rust builds, 
and b) Rust folks are happy to take responsibility for un-breaking the 
Rust build if and when it happens, then that seems reasonable IMO.

Thanks,
Robin.

> 
> Hence, the next version of this patch series will have the corresponding
> maintainer entry.
> 
> - Danilo

