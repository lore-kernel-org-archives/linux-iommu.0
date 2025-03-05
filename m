Received: from r-passerv.ralfj.de (r-passerv.ralfj.de [109.230.236.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4EF78F3A;
	Wed,  5 Mar 2025 19:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.230.236.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741203736; cv=none; b=XCT/hzDYuVDOMbUn0d5gFtDsC4AcPNBP7eDcAbpoVQYwjVXo+5s7tXpW14dIpBqOaBXSxPw3LSmhRZhhoTB2tpVGVwfPZo5NdmEKyXzrfxpD4n2cH5vuubwgTzY959sCBQOqSt2Rtog2xsJGiQVrKloHPyX6IU/4vUGxCdpjPSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741203736; c=relaxed/simple;
	bh=jvgDE48yAFQRM5GDptUv9cYZLwD0HT8HVoLIV3xxIss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YcFl46kKrt/8BQ8yvYANhv/Cr+zukmmSM8AFhDviUbM0Iu3Ew4Lb6/K2x96zFNDJ1nCdy+XmnpiGWEi25cVGj3SiT8A75i7UtqfkVz+voalyzKGDgGFw+MI4TsPhROeAiBoHBUgag5WIYB+fO6G7M2ZQSfqHYvRySdBj9bpyriA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ralfj.de; spf=pass smtp.mailfrom=ralfj.de; dkim=pass (1024-bit key) header.d=ralfj.de header.i=@ralfj.de header.b=FOd0Hne9; arc=none smtp.client-ip=109.230.236.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ralfj.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ralfj.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ralfj.de header.i=@ralfj.de header.b="FOd0Hne9"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ralfj.de; s=mail;
	t=1741203727; bh=jvgDE48yAFQRM5GDptUv9cYZLwD0HT8HVoLIV3xxIss=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FOd0Hne964De2cbX/O5PqOkWir9XktbgHn7/3cLuvwXfbfAd3Jo/qAKckE5sG4VxJ
	 6mhvJClqCvWSrNTN7fszGMzxRK/v+NRyFGI8w//o55T1gEzr2cVkIG+Nv4yvsCzeXt
	 CVX4hzl/lQ7OYRGk//vFDxx05u5BPNfjdedKSHPs=
Received: from [IPV6:2001:8e0:207e:3500:4ab6:48fe:df57:b084] (2001-8e0-207e-3500-4ab6-48fe-df57-b084.ewm.ftth.ip6.as8758.net [IPv6:2001:8e0:207e:3500:4ab6:48fe:df57:b084])
	by r-passerv.ralfj.de (Postfix) with ESMTPSA id 1ABFA2052A89;
	Wed,  5 Mar 2025 20:42:07 +0100 (CET)
Message-ID: <915eacce-cfd8-4bed-a407-32513e43978f@ralfj.de>
Date: Wed, 5 Mar 2025 20:42:05 +0100
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
 <18cmxblLU2QAa4YP25RWCKEnxuonOwWXavYmSsS4C5D40o8RaCkIXo0UDZ2SPnksk5nWYB29Y4zHkjQeOgd4ng==@protonmail.internalid>
 <3aabca39-4658-454a-b0e3-e946e72977e1@ralfj.de> <87eczb71xs.fsf@kernel.org>
Content-Language: en-US, de-DE
From: Ralf Jung <post@ralfj.de>
In-Reply-To: <87eczb71xs.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

>>> For some kinds of hardware, we might not want to trust the hardware.
>>> I.e., there is no race under normal operation, but the hardware could
>>> have a bug or be malicious and we might not want that to result in UB.
>>> This is pretty similar to syscalls that take a pointer into userspace
>>> memory and read it - userspace shouldn't modify that memory during the
>>> syscall, but it can and if it does, that should be well-defined.
>>> (Though in the case of userspace, the copy happens in asm since it
>>> also needs to deal with virtual memory and so on.)
>>
>> Wow you are really doing your best to combine all the hard problems at the same
>> time. ;)
>> Sharing memory with untrusted parties is another tricky issue, and even leaving
>> aside all the theoretical trouble, practically speaking you'll want to
>> exclusively use atomic accesses to interact with such memory. So doing this
>> properly requires atomic memcpy. I don't know what that is blocked on, but it is
>> good to know that it would help the kernel.
> 
> I am sort of baffled by this, since the C kernel has no such thing and
> has worked fine for a few years. Is it a property of Rust that causes us
> to need atomic memcpy, or is what the C kernel is doing potentially dangerous?

It's the same in C: a memcpy is a non-atomic access. If something else 
concurrently mutates the memory you are copying from, or something else 
concurrently reads/writes the memory you are copying two, that is UB.
This is not specific to memcpy; it's the same for regular pointer loads/stores. 
That's why you need READ_ONCE and WRITE_ONCE to specifically indicate to the 
compiler that these are special accesses that need to be treated differently. 
Something similar is needed for memcpy.

Kind regards,
Ralf

