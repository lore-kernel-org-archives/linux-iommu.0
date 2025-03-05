Received: from r-passerv.ralfj.de (r-passerv.ralfj.de [109.230.236.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82D4248880;
	Wed,  5 Mar 2025 13:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.230.236.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741181266; cv=none; b=vDGXq8cSwRiTA4nspHmaonqMmClGiN495OuYVk268RcKJmjVJ2agA8A6yymCDn8d4cx1+39KgSpd3dFeSUeyvuZnHhvxLwspkJfp7V1cEpj8o6cSqvu0EhjOyWfF0wrgdEFJcWKvf8EC2VBOWM0MU0PShRe1EZvNvdWBBj5ay68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741181266; c=relaxed/simple;
	bh=nTMOHRcHrHRd5F5sk8EJ52AHGRSwuN+C0p918nQFYIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KHc03cD3F3ecSJhMrbX2Bvg5YN25dhMrWAS74heavPvxKSpleJuxOqCUwKVwSZ/lA6wNE8L7bFAWZMh+OiUs1nqy1ou+WwcmEDf3SGkBcxfQ6VbFZOCOcr4qaqNyk5duBigOc6/52qVFFhJHOFMamhfOSsbNSYctVlFroGZfuso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ralfj.de; spf=pass smtp.mailfrom=ralfj.de; dkim=pass (1024-bit key) header.d=ralfj.de header.i=@ralfj.de header.b=dMPSKM2l; arc=none smtp.client-ip=109.230.236.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ralfj.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ralfj.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ralfj.de header.i=@ralfj.de header.b="dMPSKM2l"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ralfj.de; s=mail;
	t=1741181262; bh=nTMOHRcHrHRd5F5sk8EJ52AHGRSwuN+C0p918nQFYIE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dMPSKM2lHhFNh+8no4j7Z1N03SCFx9pxMM2N9wVT6fe8XjvT+aO7OsEcbnE6/jDBA
	 34FTbRA8l/ss4jxw5T/XAzxq6CwFligOFGr+zMq6b89wscoiTF8cUtwtkZLCSgwsQP
	 rJWumRSVxM9LKjzRneCutwC73FZOO1juUaL74lds=
Received: from [IPV6:2001:67c:10ec:5784:8000::87] (2001-67c-10ec-5784-8000--87.net6.ethz.ch [IPv6:2001:67c:10ec:5784:8000::87])
	by r-passerv.ralfj.de (Postfix) with ESMTPSA id 9FCE62052A89;
	Wed,  5 Mar 2025 14:27:42 +0100 (CET)
Message-ID: <3aabca39-4658-454a-b0e3-e946e72977e1@ralfj.de>
Date: Wed, 5 Mar 2025 14:27:42 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Allow data races on some read/write operations
To: Alice Ryhl <aliceryhl@google.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, comex <comexk@gmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>,
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
 <25e7e425-ae72-4370-ae95-958882a07df9@ralfj.de>
 <CAH5fLgidPHQzdUORNpNhtRFsKPU1T-0xdn5OSwYYZh3BgOVRQA@mail.gmail.com>
Content-Language: en-US, de-DE
From: Ralf Jung <post@ralfj.de>
In-Reply-To: <CAH5fLgidPHQzdUORNpNhtRFsKPU1T-0xdn5OSwYYZh3BgOVRQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 05.03.25 14:23, Alice Ryhl wrote:
> On Wed, Mar 5, 2025 at 2:10 PM Ralf Jung <post@ralfj.de> wrote:
>>
>> Hi,
>>
>> On 05.03.25 04:24, Boqun Feng wrote:
>>> On Tue, Mar 04, 2025 at 12:18:28PM -0800, comex wrote:
>>>>
>>>>> On Mar 4, 2025, at 11:03 AM, Ralf Jung <post@ralfj.de> wrote:
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
>> threads) on the memcpy'd memory? Or is this the pattern where you copy some data
>> somewhere and then set a flag in an MMIO register to indicate that the data is
>> ready and the device can start reading it? In the latter case, the actual data
>> copy does not race with anything, so it can be a regular non-atomic non-volatile
>> memcpy. The flag write *should* be a release write, and release volatile writes
>> do not exist, so that is a problem, but it's a separate problem from volatile
>> memcpy. One can use a release fence followed by a relaxed write instead.
>> Volatile writes do not currently act like relaxed writes, but you need that
>> anyway for WRITE_ONCE to make sense so it seems fine to rely on that here as well.
>>
>> Rust should have atomic volatile accesses, and various ideas have been proposed
>> over the years, but sadly nobody has shown up to try and push this through.
>>
>> If the memcpy itself can indeed race, you need an atomic volatile memcpy --
>> which neither C nor Rust have, though there are proposals for atomic memcpy (and
>> arguably, there should be a way to interact with a device using non-volatile
>> atomics... but anyway in the LKMM, atomics are modeled with volatile, so things
>> are even more entangled than usual ;).
> 
> For some kinds of hardware, we might not want to trust the hardware.
> I.e., there is no race under normal operation, but the hardware could
> have a bug or be malicious and we might not want that to result in UB.
> This is pretty similar to syscalls that take a pointer into userspace
> memory and read it - userspace shouldn't modify that memory during the
> syscall, but it can and if it does, that should be well-defined.
> (Though in the case of userspace, the copy happens in asm since it
> also needs to deal with virtual memory and so on.)

Wow you are really doing your best to combine all the hard problems at the same 
time. ;)
Sharing memory with untrusted parties is another tricky issue, and even leaving 
aside all the theoretical trouble, practically speaking you'll want to 
exclusively use atomic accesses to interact with such memory. So doing this 
properly requires atomic memcpy. I don't know what that is blocked on, but it is 
good to know that it would help the kernel.

Kind regards,
Ralf

