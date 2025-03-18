Received: from r-passerv.ralfj.de (r-passerv.ralfj.de [109.230.236.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074D1186294;
	Tue, 18 Mar 2025 14:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.230.236.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742309616; cv=none; b=DSJRr5cYYs8S/RyWdChhle2awt/7c6tYcEoUcB7oltGjCmtSPimok5KyV1meOcdxmHwCvYjtHNQWdAzHULUrPJhwDsVInwL13GY+55wBL/IsWWvyoPb8c7gaDppeKBJEhQDnc7C36SOlVEGfGHs3fuv/IpQufU+fb0frrIuvDdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742309616; c=relaxed/simple;
	bh=RP0WI5+Yi2SwFLtN1Vk6krhjctaFYiPoqve8wlV+RcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T4kSqRmgMdj477H3U09N1w6hGKZmssn0zPcAGFIo70IArMW6SBJ/6idUc1nTaZMZ38y8t8uqEtEW9hhjQT8ZwQP1W+YBcMqi6mdZqn4AnMBKYAUBpd2W+HjoZerfK3FX8bHye0RCPLQFlw2fs2KU3T2HrJ0hzgjykKC/GnHufUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ralfj.de; spf=pass smtp.mailfrom=ralfj.de; dkim=pass (1024-bit key) header.d=ralfj.de header.i=@ralfj.de header.b=skVI2dgR; arc=none smtp.client-ip=109.230.236.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ralfj.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ralfj.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ralfj.de header.i=@ralfj.de header.b="skVI2dgR"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ralfj.de; s=mail;
	t=1742309098; bh=RP0WI5+Yi2SwFLtN1Vk6krhjctaFYiPoqve8wlV+RcM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=skVI2dgR9zzo4J1h32yXTXSrdvAg1jk3jdE9srQ3+900YGoP68HEN0uktDwryUu8K
	 tidX0H/1bwqtLUo80blJN/zW2iCWAssWDq6hAqWkbcExsDrLrwkjLMiMNrdVTHqEBo
	 MxibUl/eDvl/adEPPd2m1F9apyn7aXuYEtVY8rXA=
Received: from [IPV6:2001:67c:10ec:5784:8000::87] (2001-67c-10ec-5784-8000--87.net6.ethz.ch [IPv6:2001:67c:10ec:5784:8000::87])
	by r-passerv.ralfj.de (Postfix) with ESMTPSA id 90C472052AB0;
	Tue, 18 Mar 2025 15:44:58 +0100 (CET)
Message-ID: <ab8fd525-9a63-46e2-a443-b9d94eed6004@ralfj.de>
Date: Tue, 18 Mar 2025 15:44:50 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Allow data races on some read/write operations
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>,
 comex <comexk@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, dakr@kernel.org,
 robin.murphy@arm.com, rust-for-linux@vger.kernel.org,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Trevor Gross <tmgross@umich.edu>,
 Valentin Obst <kernel@valentinobst.de>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>,
 airlied@redhat.com, iommu@lists.linux.dev, lkmm@lists.linux.dev
References: <87bjuil15w.fsf@kernel.org> <87mse2hrd8.fsf@kernel.org>
 <Z8YMTiKS4T9wC4t_@boqun-archlinux>
 <ae8ac31f-c6ad-46ae-80dd-10ec081a16d1@ralfj.de>
 <88456D33-C5CA-4F4F-990E-8C5F2AF7EAF9@gmail.com>
 <hkhgihg4fjkg7zleqnumuj65dfvmxa5rzawkiafrf4kn5ss6nw@o7kc6xe2bmuj>
 <25e7e425-ae72-4370-ae95-958882a07df9@ralfj.de>
 <CAH5fLgidPHQzdUORNpNhtRFsKPU1T-0xdn5OSwYYZh3BgOVRQA@mail.gmail.com>
 <18cmxblLU2QAa4YP25RWCKEnxuonOwWXavYmSsS4C5D40o8RaCkIXo0UDZ2SPnksk5nWYB29Y4zHkjQeOgd4ng==@protonmail.internalid>
 <3aabca39-4658-454a-b0e3-e946e72977e1@ralfj.de> <87eczb71xs.fsf@kernel.org>
 <M_YejDCAOZ7AX0l8ZZ7Z5EesJicUgsjYJUTm0SzLkhYTAYyXRJFTr4QYZMagG4KX6YdHoT-IPhf8ygjircrs0A==@protonmail.internalid>
 <915eacce-cfd8-4bed-a407-32513e43978f@ralfj.de> <87tt875fu8.fsf@kernel.org>
 <-_bKVxONywzmy2K6TPj5TT6swM4PhCN6ulfel4V8yTlJi3MzAGbIiKIVQ0TQzoVJ7wRfM8Ie5Jh5MSv9yf-sKg==@protonmail.internalid>
 <580cfb1a-3619-410f-8b03-61ee984c1b1f@ralfj.de> <87frjp5iyn.fsf@kernel.org>
Content-Language: en-US, de-DE
From: Ralf Jung <post@ralfj.de>
In-Reply-To: <87frjp5iyn.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

>>> I
>>> may even later copy the data at place B to place C where C might have
>>> concurrent reads and/or writes, and the kernel will not experience UB
>>> because of this. The data may be garbage, but that is fine. I am not
>>> interpreting the data, or making control flow decisions based on it. I
>>> am just moving the data.
>>>
>>> My understand is: In Rust, this program would be illegal and might
>>> experience UB in unpredictable ways, not limited to just the data that
>>> is being moved.
>>
>> That is correct. C and Rust behave the same here.
> 
> Is there a difference between formal models of the languages and
> practical implementations of the languages here? I'm asking this because
> C kernel developers seem to be writing these programs that are illegal
> under the formal spec of the C language, but work well in practice.
> Could it be the same in Rust?
> 
> That is, can I do this copy and get away with it in practice under the
> circumstances outlined earlier?

As with off-label drug usage, things can of course go well even if you 
deliberately leave the range of well-defined usage defined by the manufacturer.
However, answering your question conclusively requires intimate knowledge of the 
entire compilation chain. I'm not even sure if there's a single person that has 
everything from front-end transformations to back-end lowering in their head...
At the scale that compilers have reached, I think we have to compartmentalize by 
establishing abstractions (such as the Rust / C language specs, and the LLVM IR 
language spec). This enables each part of the compiler to locally ensure their 
consistency with the spec (hopefully that one part still fits in one person's 
head), and as long as everyone uses the same spec and interprets it the same 
way, we achieve a consistent end-to-end result from many individually consistent 
pieces.

Personally my goal has always been to identify the cases where programmers 
deliberately reach for such off-label usage, figure out the missing parts in the 
language that motivate them to do this, and add them, so that we can move on 
having everything on solid footing. :)   I did not realize that atomic memcpy is 
so crucial for the kernel, but it makes sense in hindsight. So IMO that is where 
we should spend our effort, rather than digging through the entire compilation 
pipeline to determine some works-in-practice off-label alternative.

>>> One option I have explored is just calling C memcpy directly, but
>>> because of LTO, that is no different than doing the operation in Rust.
>>>
>>> I don't think I need atomic memcpy, I just need my program not to
>>> explode if I move some data to or from a place that is experiencing
>>> concurrent writes without synchronization. Not in general, but for some
>>> special cases where I promise not to look at the data outside of moving
>>> it.
>>
>> I'm afraid I do not know of a language, other than assembly, that can provide this.
>>
>> Atomic memcpy, however, should be able to cover your use-case, so it seems like
>> a reasonable solution to me? Marking things as atomic is literally how you tell
>> the compiler "don't blow up if there are concurrent accesses".
> 
> If atomic memcpy is what we really need to write these kinds of programs in
> Rust, what would be the next steps to get this in the language?

There is an RFC, but it has been stalled for a while: 
<https://github.com/rust-lang/rfcs/pull/3301>. I do not know its exact status. 
It might be blocked on having this in the C++ model, though at least unstable 
experimentation should be possible before C++ has fully standardized the way 
this will look. (We'll want to ensure consistency of the C++ and Rust models 
here to ensure that C, C++, and Rust can interop on shared memory in a coherent 
way.)
On the C++ side (where the atomic memcpy would likely be added to the 
concurrency memory model, to be then adopted by C and Rust), I heard there was a 
lot of non-technical trouble due to ISO changing their procedural rules for how 
they wanted changes to the standard to look like. I don't know any further 
details here as I am not directly involved.

> Also, would there be a performance price to pay for this?

I know little about evaluating performance at the low-level architectural or 
even microarchitectural level. However I would think in the end the memcpy 
itself (when using the "relaxed" atomic ordering) would be the same existing 
operation, the same assembly, it is just treated differently by optimizations 
before reaching the assembly stage.

Kind regards,
Ralf

> 
> 
> Best regards,
> Andreas Hindborg
> 
> 
> 

