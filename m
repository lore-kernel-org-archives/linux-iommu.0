Received: from r-passerv.ralfj.de (r-passerv.ralfj.de [109.230.236.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973D52475C2;
	Wed,  5 Mar 2025 13:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.230.236.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741180232; cv=none; b=EJAZgap2wukeuZ9KFgD3yYZ3Ir7pXQpOi3Vd5BmUow6m3YX1e6I2v3okd6GrjlE+2UDMeSKeYr2dH5aBjJANplY5s41C6j6raK5UQlM9IyIGlk5UPYNsyVnwBarPWTABygwiO2yqGj0c1z3XfrQcJCB4WMb7UWVdb8IYcY8NyvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741180232; c=relaxed/simple;
	bh=MLh2QFr7rGTwa5f2sq8RD9fMY5NELA+8OS3W5Af0sKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MaqlPqhrVV0RGjFTWJzfoJ4QaoKWJ1ZakEGXLhrdHaHwj/xs9em+dhhClpnVA1s9hhJp6OpW02EcHuCLWUt0LG0TIlqIfwVUjMoV+MOuCJLCg6Hkkvj9iGY6d2I3847/uz4o9ZxzZqRezKnSRJLQIRqrFDfprog5NCajPDnFLxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ralfj.de; spf=pass smtp.mailfrom=ralfj.de; dkim=pass (1024-bit key) header.d=ralfj.de header.i=@ralfj.de header.b=Kc/c8pyd; arc=none smtp.client-ip=109.230.236.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ralfj.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ralfj.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ralfj.de header.i=@ralfj.de header.b="Kc/c8pyd"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ralfj.de; s=mail;
	t=1741180228; bh=MLh2QFr7rGTwa5f2sq8RD9fMY5NELA+8OS3W5Af0sKY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Kc/c8pydRbdIH1lS8LP9ZwHDA0GcibFlib19ZzRsj7Pa+6munRpDCrtdi+rZ3tA0Q
	 U4WM6tebrX1VZIh9r6zZCS6I+rYbTG+niEQ6g3VP4E8iIsteKnfcyPa2VBZlw8vDUH
	 TP6zvPWvZc6s/0vLeBWrbb8kG3cATIMvDrG8lyUY=
Received: from [IPV6:2001:67c:10ec:5784:8000::12e7] (2001-67c-10ec-5784-8000--12e7.net6.ethz.ch [IPv6:2001:67c:10ec:5784:8000::12e7])
	by r-passerv.ralfj.de (Postfix) with ESMTPSA id B57AE2052A89;
	Wed,  5 Mar 2025 14:10:27 +0100 (CET)
Message-ID: <25e7e425-ae72-4370-ae95-958882a07df9@ralfj.de>
Date: Wed, 5 Mar 2025 14:10:22 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Allow data races on some read/write operations
To: Boqun Feng <boqun.feng@gmail.com>, comex <comexk@gmail.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
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
Content-Language: en-US, de-DE
From: Ralf Jung <post@ralfj.de>
In-Reply-To: <hkhgihg4fjkg7zleqnumuj65dfvmxa5rzawkiafrf4kn5ss6nw@o7kc6xe2bmuj>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 05.03.25 04:24, Boqun Feng wrote:
> On Tue, Mar 04, 2025 at 12:18:28PM -0800, comex wrote:
>>
>>> On Mar 4, 2025, at 11:03 AM, Ralf Jung <post@ralfj.de> wrote:
>>>
>>> Those already exist in Rust, albeit only unstably:
>>> <https://doc.rust-lang.org/nightly/std/intrinsics/fn.volatile_copy_memory.html>.
>>> However, I am not sure how you'd even generate such a call in C? The
>>> standard memcpy function is not doing volatile accesses, to my
>>> knowledge.
>>
>> The actual memcpy symbol that exists at runtime is written in
>> assembly, and should be valid to treat as performing volatile
>> accesses.

memcpy is often written in C... and AFAIK compilers understand what that 
function does and will, for instance, happily eliminate the call if they can 
prove that the destination memory is not being read from again. So, it doesn't 
behave like a volatile access at all.

>> But both GCC and Clang special-case the memcpy function.  For example,
>> if you call memcpy with a small constant as the size, the optimizer
>> will transform the call into one or more regular loads/stores, which
>> can then be optimized mostly like any other loads/stores (except for
>> opting out of alignment and type-based aliasing assumptions).  Even if
>> the call isn’t transformed, the optimizer will still make assumptions.
>> LLVM will automatically mark memcpy `nosync`, which makes it undefined
>> behavior if the function “communicate[s] (synchronize[s]) with another
>> thread”, including through “volatile accesses”. [1]

The question is more,  what do clang and GCC document / guarantee in a stable 
way regarding memcpy? I have not seen any indication so far that a memcpy call 
would ever be considered volatile, so we have to treat it like a non-volatile 
non-atomic operation.

>> However, these optimizations should rarely trigger misbehavior in
>> practice, so I wouldn’t be surprised if Linux had some code that
>> expected memcpy to act volatile…
>>
> 
> Also in this particular case we are discussing [1], it's a memcpy (from
> or to) a DMA buffer, which means the device can also read or write the
> memory, therefore the content of the memory may be altered outside the
> program (the kernel), so we cannot use copy_nonoverlapping() I believe.
> 
> [1]: https://lore.kernel.org/rust-for-linux/87bjuil15w.fsf@kernel.org/

Is there actually a potential for races (with reads by hardware, not other 
threads) on the memcpy'd memory? Or is this the pattern where you copy some data 
somewhere and then set a flag in an MMIO register to indicate that the data is 
ready and the device can start reading it? In the latter case, the actual data 
copy does not race with anything, so it can be a regular non-atomic non-volatile 
memcpy. The flag write *should* be a release write, and release volatile writes 
do not exist, so that is a problem, but it's a separate problem from volatile 
memcpy. One can use a release fence followed by a relaxed write instead. 
Volatile writes do not currently act like relaxed writes, but you need that 
anyway for WRITE_ONCE to make sense so it seems fine to rely on that here as well.

Rust should have atomic volatile accesses, and various ideas have been proposed 
over the years, but sadly nobody has shown up to try and push this through.

If the memcpy itself can indeed race, you need an atomic volatile memcpy -- 
which neither C nor Rust have, though there are proposals for atomic memcpy (and 
arguably, there should be a way to interact with a device using non-volatile 
atomics... but anyway in the LKMM, atomics are modeled with volatile, so things 
are even more entangled than usual ;).

Kind regards,
Ralf

