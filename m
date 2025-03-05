Received: from r-passerv.ralfj.de (r-passerv.ralfj.de [109.230.236.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278AE1FCD13;
	Wed,  5 Mar 2025 22:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.230.236.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741212100; cv=none; b=b7EYnUDLoKIdIROm6GsvwNcXkAtSzLqlYaADE69uVjmqW4urQFzzFz5ojx11WYB56Eu8NYg0F3iRR5QtCerdK1T741fZTqUs4d1Q5hV+9KS1d4AHc9fHC/K6FyS7rkhHO+xahPFBl+bxw9oR0ghHiH1yW/KDi3wc9Z52eBcefkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741212100; c=relaxed/simple;
	bh=/408JW3/K3EFm7N0Q/95CTFcpD5T/HxnHzWL4JoSqpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m/LF1eFQbm+yM1pDqCgNPE+IVdSe3J0W9N3mGOlu7DoA78L++68ITN5OpliSFXcccUekuK/Oj5noamxAXUEqsTz6FY4OfvchPDpGf7+lw2phIyNK0w9YcnqO9s/vMDMA8i02yjGiNlfqgCrBux3KCNHqOkky44lpX3yV9MsTF0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ralfj.de; spf=pass smtp.mailfrom=ralfj.de; dkim=pass (1024-bit key) header.d=ralfj.de header.i=@ralfj.de header.b=CgcToDdR; arc=none smtp.client-ip=109.230.236.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ralfj.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ralfj.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ralfj.de header.i=@ralfj.de header.b="CgcToDdR"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ralfj.de; s=mail;
	t=1741212096; bh=/408JW3/K3EFm7N0Q/95CTFcpD5T/HxnHzWL4JoSqpo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CgcToDdRavNi2y+nVVolQqjv0K18KtigroOvSW8w2VgTzlij4wiX58JSHj3t7z/Ar
	 RopwYQJKUDS5RAVyLny+ec25mPtqfzEKCfzc2owr3/kSJoi9Sb7mP7AOXV7H+I4TPg
	 AQ/mDqumjtkfbRUqQ+56L/08e9XqMF/t9rdx/JJo=
Received: from [IPV6:2001:8e0:207e:3500:4ab6:48fe:df57:b084] (2001-8e0-207e-3500-4ab6-48fe-df57-b084.ewm.ftth.ip6.as8758.net [IPv6:2001:8e0:207e:3500:4ab6:48fe:df57:b084])
	by r-passerv.ralfj.de (Postfix) with ESMTPSA id 4106C2052A89;
	Wed,  5 Mar 2025 23:01:36 +0100 (CET)
Message-ID: <5141441e-040f-4ba3-8567-91110fa91df0@ralfj.de>
Date: Wed, 5 Mar 2025 23:01:35 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Allow data races on some read/write operations
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, comex <comexk@gmail.com>,
 Alice Ryhl <aliceryhl@google.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, dakr@kernel.org,
 robin.murphy@arm.com, rust-for-linux@vger.kernel.org,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Trevor Gross <tmgross@umich.edu>,
 Valentin Obst <kernel@valentinobst.de>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>,
 airlied@redhat.com, iommu@lists.linux.dev, lkmm@lists.linux.dev
References: <87bjuil15w.fsf@kernel.org>
 <t4HxdvR7WBX_861hiTXo72jqC9F9oRpIzgA_dD2yhcSuLISEkC-shMfSgllrFPpnkSZXGfRcc47keudMooNiIQ==@protonmail.internalid>
 <CAH5fLgg5MuUu=TX8mMsPf5RcLhMLHSU4Vct=h8rFX6Z7HjPxeA@mail.gmail.com>
 <87ikoqjg1n.fsf@kernel.org>
 <KpWTCfIlcLYFBpSvWPfALJ9VQn5a99_RAvxgMBc1aCrSalPB-qaW9IhXyaDG7HM1AcFPX5chj_Yr7IQp3F7UqA==@protonmail.internalid>
 <CAH5fLgh6ubawHh76wq7JPbcuBCWhm91m7Rc01MVsX-a3C6qaVA@mail.gmail.com>
 <87mse2hrd8.fsf@kernel.org> <Z8YMTiKS4T9wC4t_@boqun-archlinux>
 <ae8ac31f-c6ad-46ae-80dd-10ec081a16d1@ralfj.de>
 <88456D33-C5CA-4F4F-990E-8C5F2AF7EAF9@gmail.com>
 <hkhgihg4fjkg7zleqnumuj65dfvmxa5rzawkiafrf4kn5ss6nw@o7kc6xe2bmuj>
 <9wOjabjsxQUrlTOfcLXOYjYxTroyzIPZCy1xeZsv7IctEqEe-iUaGCL4xKebv01sARjrMfYNkPx4sJLtKLmPXA==@protonmail.internalid>
 <25e7e425-ae72-4370-ae95-958882a07df9@ralfj.de> <87pliv726u.fsf@kernel.org>
Content-Language: en-US, de-DE
From: Ralf Jung <post@ralfj.de>
In-Reply-To: <87pliv726u.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 05.03.25 19:38, Andreas Hindborg wrote:
> "Ralf Jung" <post@ralfj.de> writes:
> 
>> Hi,
>>
>> On 05.03.25 04:24, Boqun Feng wrote:
>>> On Tue, Mar 04, 2025 at 12:18:28PM -0800, comex wrote:
>>>>
>>>>> On Mar 4, 2025, at 11:03 AM, Ralf Jung <post@ralfj.de> wrote:
>>>>>
>>>>> Those already exist in Rust, albeit only unstably:
>>>>> <https://doc.rust-lang.org/nightly/std/intrinsics/fn.volatile_copy_memory.html>.
>>>>> However, I am not sure how you'd even generate such a call in C? The
>>>>> standard memcpy function is not doing volatile accesses, to my
>>>>> knowledge.
>>>>
>>>> The actual memcpy symbol that exists at runtime is written in
>>>> assembly, and should be valid to treat as performing volatile
>>>> accesses.
>>
>> memcpy is often written in C... and AFAIK compilers understand what that
>> function does and will, for instance, happily eliminate the call if they can
>> prove that the destination memory is not being read from again. So, it doesn't
>> behave like a volatile access at all.
>>
>>>> But both GCC and Clang special-case the memcpy function.  For example,
>>>> if you call memcpy with a small constant as the size, the optimizer
>>>> will transform the call into one or more regular loads/stores, which
>>>> can then be optimized mostly like any other loads/stores (except for
>>>> opting out of alignment and type-based aliasing assumptions).  Even if
>>>> the call isn’t transformed, the optimizer will still make assumptions.
>>>> LLVM will automatically mark memcpy `nosync`, which makes it undefined
>>>> behavior if the function “communicate[s] (synchronize[s]) with another
>>>> thread”, including through “volatile accesses”. [1]
>>
>> The question is more,  what do clang and GCC document / guarantee in a stable
>> way regarding memcpy? I have not seen any indication so far that a memcpy call
>> would ever be considered volatile, so we have to treat it like a non-volatile
>> non-atomic operation.
>>
>>>> However, these optimizations should rarely trigger misbehavior in
>>>> practice, so I wouldn’t be surprised if Linux had some code that
>>>> expected memcpy to act volatile…
>>>>
>>>
>>> Also in this particular case we are discussing [1], it's a memcpy (from
>>> or to) a DMA buffer, which means the device can also read or write the
>>> memory, therefore the content of the memory may be altered outside the
>>> program (the kernel), so we cannot use copy_nonoverlapping() I believe.
>>>
>>> [1]: https://lore.kernel.org/rust-for-linux/87bjuil15w.fsf@kernel.org/
>>
>> Is there actually a potential for races (with reads by hardware, not other
>> threads) on the memcpy'd memory?
> 
> There is another use case for this: copying data to/from a page that is
> mapped into user space. In this case, a user space process can
> potentially modify the data in the mapped page while we are
> reading/writing that data. This would be a misbehaved user space
> process, but it should not be able to cause UB in the kernel anyway.

Yeah that sounds like *the* prototypical case of sharing memory with an 
untrusted third party.

> 
> The C kernel just calls memcpy directly for this use case.
> 
> For this use case, we do not interpret or make control flow decisions
> based on the data we read/write. And _if_ user space decides to do
> concurrent writes to the page, we don't care if the data becomes
> garbage. We just need the UB to be confined to the data moved from that
> page, and not leak into the rest of the kernel.

There is no such thing as "confined UB". Well, there is "poison data", which can 
act a bit like that, but sadly the C standard is extremely ambiguous on that 
subject and has been for decades despite repeated requests for clarifications, 
so it is entirely unclear whether and how "poison data" could exist in C. clang, 
for once, has decided that "poison data" is UB in most situations (including 
just copying it to / returning it from another function), and this is consistent 
with some of the messaging of the standards committee. I don't know enough about 
the internals of gcc to comment on what they do.

Personally, I think that's a mistake; there needs to be some clear way to deal 
with uninitialized memory (which is the typical example of "poison data").

In Rust we have a fairly clear idea of what our rules should be here, and you 
can have "poison data" inside the `MaybeUninit` type. However, neither Rust nor 
C have a way to do reads where data races cause "poison data" rather than UB. 
See my other email I just sent for the rest of this line of discussion.
(I'm not used to the sprawling tree of a discussion that is this mailing list, 
so not sure how to best deal with replies that want to "merge" things said in 
different emails.)

Kind regards,
Ralf

