Received: from r-passerv.ralfj.de (r-passerv.ralfj.de [109.230.236.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371BF26560B;
	Wed,  5 Mar 2025 21:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.230.236.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741211626; cv=none; b=aQ6XuHGGW4kLA+QSFfVJDymjsKGPnjVXxfqLpuGHoE9TkDul85t8Nq4irUY0yNfUgM2rlhUmInWbKVgQGpZfgJNmokSZWUjUgY5qAZmLNggeKiBFVZThm84svhNZsJYIRUha55pIh6ArDKnwWgoa/Ryn/dMKrOo6fAZ7mcPAeTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741211626; c=relaxed/simple;
	bh=/pqmON2x4dgPuMnH4JNqr66pKMipGIbQoJvgNwduQVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hrFJ3wSkHZDDIkcpBOyhoYIklcIsjTuVbDAJXqLdr8PBXE4Zj8vLFD6K0799prft5JgXWp118TWXXlmtazFvTneRdCXgIPKllsXVgodorw4+Fk5NW+tPzDCDdrJP9YVglu0mykZyTO1CdVUShcHphz414MazdcjuOQdmJ7F0ges=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ralfj.de; spf=pass smtp.mailfrom=ralfj.de; dkim=pass (1024-bit key) header.d=ralfj.de header.i=@ralfj.de header.b=fiXptAc6; arc=none smtp.client-ip=109.230.236.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ralfj.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ralfj.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ralfj.de header.i=@ralfj.de header.b="fiXptAc6"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ralfj.de; s=mail;
	t=1741211622; bh=/pqmON2x4dgPuMnH4JNqr66pKMipGIbQoJvgNwduQVY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fiXptAc6sCk3g9ac540C+D1JtpsAdQDNpVgo9ssKkmjHi0hl5FylmmyZBg6uyj/pL
	 wwcXFstOir9m7W4mg0aeVmLJIVk+D85jkyukol11S+wR/Aa8w7OjDwB/xswH/Oa/z0
	 A0teFhZQF8Z2u3bnLqh5pn6EKJT6jPKCAkEVAkys=
Received: from [IPV6:2001:8e0:207e:3500:4ab6:48fe:df57:b084] (2001-8e0-207e-3500-4ab6-48fe-df57-b084.ewm.ftth.ip6.as8758.net [IPv6:2001:8e0:207e:3500:4ab6:48fe:df57:b084])
	by r-passerv.ralfj.de (Postfix) with ESMTPSA id 0D5922052A87;
	Wed,  5 Mar 2025 22:53:42 +0100 (CET)
Message-ID: <580cfb1a-3619-410f-8b03-61ee984c1b1f@ralfj.de>
Date: Wed, 5 Mar 2025 22:53:39 +0100
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
References: <87bjuil15w.fsf@kernel.org> <87ikoqjg1n.fsf@kernel.org>
 <KpWTCfIlcLYFBpSvWPfALJ9VQn5a99_RAvxgMBc1aCrSalPB-qaW9IhXyaDG7HM1AcFPX5chj_Yr7IQp3F7UqA==@protonmail.internalid>
 <CAH5fLgh6ubawHh76wq7JPbcuBCWhm91m7Rc01MVsX-a3C6qaVA@mail.gmail.com>
 <87mse2hrd8.fsf@kernel.org> <Z8YMTiKS4T9wC4t_@boqun-archlinux>
 <ae8ac31f-c6ad-46ae-80dd-10ec081a16d1@ralfj.de>
 <88456D33-C5CA-4F4F-990E-8C5F2AF7EAF9@gmail.com>
 <hkhgihg4fjkg7zleqnumuj65dfvmxa5rzawkiafrf4kn5ss6nw@o7kc6xe2bmuj>
 <25e7e425-ae72-4370-ae95-958882a07df9@ralfj.de>
 <CAH5fLgidPHQzdUORNpNhtRFsKPU1T-0xdn5OSwYYZh3BgOVRQA@mail.gmail.com>
 <18cmxblLU2QAa4YP25RWCKEnxuonOwWXavYmSsS4C5D40o8RaCkIXo0UDZ2SPnksk5nWYB29Y4zHkjQeOgd4ng==@protonmail.internalid>
 <3aabca39-4658-454a-b0e3-e946e72977e1@ralfj.de> <87eczb71xs.fsf@kernel.org>
 <M_YejDCAOZ7AX0l8ZZ7Z5EesJicUgsjYJUTm0SzLkhYTAYyXRJFTr4QYZMagG4KX6YdHoT-IPhf8ygjircrs0A==@protonmail.internalid>
 <915eacce-cfd8-4bed-a407-32513e43978f@ralfj.de> <87tt875fu8.fsf@kernel.org>
Content-Language: en-US, de-DE
From: Ralf Jung <post@ralfj.de>
In-Reply-To: <87tt875fu8.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi all,

On 05.03.25 22:26, Andreas Hindborg wrote:
> "Ralf Jung" <post@ralfj.de> writes:
> 
>> Hi all,
>>
>>>>> For some kinds of hardware, we might not want to trust the hardware.
>>>>> I.e., there is no race under normal operation, but the hardware could
>>>>> have a bug or be malicious and we might not want that to result in UB.
>>>>> This is pretty similar to syscalls that take a pointer into userspace
>>>>> memory and read it - userspace shouldn't modify that memory during the
>>>>> syscall, but it can and if it does, that should be well-defined.
>>>>> (Though in the case of userspace, the copy happens in asm since it
>>>>> also needs to deal with virtual memory and so on.)
>>>>
>>>> Wow you are really doing your best to combine all the hard problems at the same
>>>> time. ;)
>>>> Sharing memory with untrusted parties is another tricky issue, and even leaving
>>>> aside all the theoretical trouble, practically speaking you'll want to
>>>> exclusively use atomic accesses to interact with such memory. So doing this
>>>> properly requires atomic memcpy. I don't know what that is blocked on, but it is
>>>> good to know that it would help the kernel.
>>>
>>> I am sort of baffled by this, since the C kernel has no such thing and
>>> has worked fine for a few years. Is it a property of Rust that causes us
>>> to need atomic memcpy, or is what the C kernel is doing potentially dangerous?
>>
>> It's the same in C: a memcpy is a non-atomic access. If something else
>> concurrently mutates the memory you are copying from, or something else
>> concurrently reads/writes the memory you are copying two, that is UB.
>> This is not specific to memcpy; it's the same for regular pointer loads/stores.
>> That's why you need READ_ONCE and WRITE_ONCE to specifically indicate to the
>> compiler that these are special accesses that need to be treated differently.
>> Something similar is needed for memcpy.
> 
> I'm not a compiler engineer, so I might be wrong about this, but. If I
> do a C `memcpy` from place A to place B where A is experiencing racy
> writes, if I don't interpret the data at place B after the copy
> operation, the rest of my C program is fine and will work as expected.

The program has UB in that case. A program that has UB may work as expected 
today, but that changes nothing about it having UB.
The C standard is abundantly clear here:
"The execution of a program contains a data race if it contains two conflicting 
actions in different threads, at least one of which is not atomic, and neither 
happens before the other. Any such data race results in undefined behavior."
(C23, §5.1.2.4)

You are describing a hypothetical language that treats data races in a different 
way. Is such a language *possible*? Definitely. For the specific case you 
describe here, one "just" has to declare read-write races to be not UB, but to 
return "poison data" on the read side (poison data is a bit like uninitialized 
memory or padding), which the memcpy would then store on the target side. Any 
future interpretation of the target memory would be UB ("poison data" is not the 
same as "random data"). Such a model has actually been studied [1], though no a 
lot, and not as a proposal for a semantics of a user-facing language. (Rather, 
that was a proposal for an internal compiler IR.) The extra complications 
incurred by this choice are significant -- there is no free lunch here.

[1]: https://sf.snu.ac.kr/publications/promising-ir-full.pdf

However, C is not that language, and neither is Rust. Defining a concurrency 
memory model is extremely non-trivial (there's literally hundreds of papers 
proposing various different models, and there are still some unsolved problems). 
The route the C++ model took was to strictly rule out all data races, and since 
they were the first to actually undertake the effort of defining a model at this 
level of rigor (for a language not willing to pay the cost that would be 
incurred by the Java concurrency memory model), that has been the standard ever 
since. There's a lot of subtle trade-offs here, and I am far from an expert on 
the exact consequences each different choice would have. I just want to caution 
against the obvious reaction of "why don't they just". :)


> I
> may even later copy the data at place B to place C where C might have
> concurrent reads and/or writes, and the kernel will not experience UB
> because of this. The data may be garbage, but that is fine. I am not
> interpreting the data, or making control flow decisions based on it. I
> am just moving the data.
> 
> My understand is: In Rust, this program would be illegal and might
> experience UB in unpredictable ways, not limited to just the data that
> is being moved.

That is correct. C and Rust behave the same here.

> One option I have explored is just calling C memcpy directly, but
> because of LTO, that is no different than doing the operation in Rust.
> 
> I don't think I need atomic memcpy, I just need my program not to
> explode if I move some data to or from a place that is experiencing
> concurrent writes without synchronization. Not in general, but for some
> special cases where I promise not to look at the data outside of moving
> it.

I'm afraid I do not know of a language, other than assembly, that can provide this.

Atomic memcpy, however, should be able to cover your use-case, so it seems like 
a reasonable solution to me? Marking things as atomic is literally how you tell 
the compiler "don't blow up if there are concurrent accesses".

Kind regards,
Ralf

