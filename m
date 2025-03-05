Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECF424BC1D;
	Wed,  5 Mar 2025 14:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741185658; cv=none; b=BoWo+KD/9P8P4YARcoDUlK94bdxa5kz2LoklO/CFA9DTlGwxalmuMORxncU46twcquNoL4LwJ5HvLZRXLsXpmhZEAJOtKcBTAv8W2VkCRjOnS4CnLYev5sw/kpMllNFWxudPtw/cTdjZMEc8DQ5pHmAUstxzsIeLjVcNqfFJQIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741185658; c=relaxed/simple;
	bh=5U/l8tp3eXkOkoO0GNc25qWdsPJ4RZ44ItczgZrbGDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u1e1tf+/e5lSk3G4PP+d5/PQFLxPvNkSZNvkScT7l8ZBsJkyKXLMmZaxZ3ee2PEHvE/3dpuWoRh0hMeJyyPhlz2hrZpnpvJ/89DdtU3XclWOVQyHIXXcCIp8Pli5mR+Xab+sSge+9FSfLEC1G9QNTq+knoEQqirNUleTNzPhSio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA650FEC;
	Wed,  5 Mar 2025 06:41:09 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 725733F673;
	Wed,  5 Mar 2025 06:40:53 -0800 (PST)
Message-ID: <39aa741e-8522-497d-a8f2-d43bc93fb29f@arm.com>
Date: Wed, 5 Mar 2025 14:40:51 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Allow data races on some read/write operations
To: Ralf Jung <post@ralfj.de>, Alice Ryhl <aliceryhl@google.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, comex <comexk@gmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, dakr@kernel.org,
 rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Trevor Gross <tmgross@umich.edu>, Valentin Obst <kernel@valentinobst.de>,
 linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
 iommu@lists.linux.dev, lkmm@lists.linux.dev
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
 <3aabca39-4658-454a-b0e3-e946e72977e1@ralfj.de>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <3aabca39-4658-454a-b0e3-e946e72977e1@ralfj.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05/03/2025 1:27 pm, Ralf Jung wrote:
> Hi,
> 
> On 05.03.25 14:23, Alice Ryhl wrote:
>> On Wed, Mar 5, 2025 at 2:10 PM Ralf Jung <post@ralfj.de> wrote:
>>>
>>> Hi,
>>>
>>> On 05.03.25 04:24, Boqun Feng wrote:
>>>> On Tue, Mar 04, 2025 at 12:18:28PM -0800, comex wrote:
>>>>>
>>>>>> On Mar 4, 2025, at 11:03 AM, Ralf Jung <post@ralfj.de> wrote:
>>>>> However, these optimizations should rarely trigger misbehavior in
>>>>> practice, so I wouldn’t be surprised if Linux had some code that
>>>>> expected memcpy to act volatile…
>>>>>
>>>>
>>>> Also in this particular case we are discussing [1], it's a memcpy (from
>>>> or to) a DMA buffer, which means the device can also read or write the
>>>> memory, therefore the content of the memory may be altered outside the
>>>> program (the kernel), so we cannot use copy_nonoverlapping() I believe.
>>>>
>>>> [1]: https://lore.kernel.org/rust-for-linux/87bjuil15w.fsf@kernel.org/
>>>
>>> Is there actually a potential for races (with reads by hardware, not 
>>> other
>>> threads) on the memcpy'd memory? Or is this the pattern where you 
>>> copy some data
>>> somewhere and then set a flag in an MMIO register to indicate that 
>>> the data is
>>> ready and the device can start reading it? In the latter case, the 
>>> actual data
>>> copy does not race with anything, so it can be a regular non-atomic 
>>> non-volatile
>>> memcpy. The flag write *should* be a release write, and release 
>>> volatile writes
>>> do not exist, so that is a problem, but it's a separate problem from 
>>> volatile
>>> memcpy. One can use a release fence followed by a relaxed write instead.
>>> Volatile writes do not currently act like relaxed writes, but you 
>>> need that
>>> anyway for WRITE_ONCE to make sense so it seems fine to rely on that 
>>> here as well.
>>>
>>> Rust should have atomic volatile accesses, and various ideas have 
>>> been proposed
>>> over the years, but sadly nobody has shown up to try and push this 
>>> through.
>>>
>>> If the memcpy itself can indeed race, you need an atomic volatile 
>>> memcpy --
>>> which neither C nor Rust have, though there are proposals for atomic 
>>> memcpy (and
>>> arguably, there should be a way to interact with a device using 
>>> non-volatile
>>> atomics... but anyway in the LKMM, atomics are modeled with volatile, 
>>> so things
>>> are even more entangled than usual ;).
>>
>> For some kinds of hardware, we might not want to trust the hardware.
>> I.e., there is no race under normal operation, but the hardware could
>> have a bug or be malicious and we might not want that to result in UB.
>> This is pretty similar to syscalls that take a pointer into userspace
>> memory and read it - userspace shouldn't modify that memory during the
>> syscall, but it can and if it does, that should be well-defined.
>> (Though in the case of userspace, the copy happens in asm since it
>> also needs to deal with virtual memory and so on.)
> 
> Wow you are really doing your best to combine all the hard problems at 
> the same time. ;)
> Sharing memory with untrusted parties is another tricky issue, and even 
> leaving aside all the theoretical trouble, practically speaking you'll 
> want to exclusively use atomic accesses to interact with such memory. So 
> doing this properly requires atomic memcpy. I don't know what that is 
> blocked on, but it is good to know that it would help the kernel.

If you don't trust the device then I wouldn't think it actually matters 
what happens at this level - the higher-level driver is already going to 
have to carefully check and sanitise whatever data it reads back from 
the buffer before consuming it, at which point reading a torn value due 
to a race would be essentially indistinguishable from if the device had 
gone wrong and simply written that nonsense value itself.

I think the more significant case is when polling for the device to 
write back some kind of status word, where in C code the driver would 
use READ_ONCE() to ensure a single-copy-atomic read of the same size the 
device is going to write - sticking a regular memcpy() into the middle 
of that can't necessarily be trusted to work correctly (even if it may 
appear to 99% of the time).

Thanks,
Robin.
