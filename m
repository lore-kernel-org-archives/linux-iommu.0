Received: from r-passerv.ralfj.de (r-passerv.ralfj.de [109.230.236.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918F8250C18;
	Tue,  4 Mar 2025 19:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.230.236.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741115039; cv=none; b=Ie+FE+R3//UkxbFbN97i8Ql2eXK3gvEZLShG2lDNWTbda/WnHXEyeYIPt1u5tVyWPJFYlUi4nHl7Zg9ffmS1MtvLrVVoiwRJHm5nPtiuRsFyHwBBlsDihu1pt0F0PmKzsXHvUpbpwDSu8UGMfKIW4UIcTPdPpkgoB/h8ZV3GY0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741115039; c=relaxed/simple;
	bh=T2QMug6/HcuzNxtAtbS9Jn2aCBfG39h86vtnhUTbmLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fSPFCvmuNSPGbz5XKqT9nJXkr3W3vRRZdugv6OnmkYsjE7/PL4vWgXXRVOQkQqS6669XMzPBGP+tQIB5otP53AeZAlqkKKHW5Qqst/Hrq25Kw+9AzbFNCcWWFvfLHboBDzDwBVws9G7pK/Z1T5c8Q9iygQDHvpxFw3VBx/FGK6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ralfj.de; spf=pass smtp.mailfrom=ralfj.de; dkim=pass (1024-bit key) header.d=ralfj.de header.i=@ralfj.de header.b=JWFqyVR+; arc=none smtp.client-ip=109.230.236.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ralfj.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ralfj.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ralfj.de header.i=@ralfj.de header.b="JWFqyVR+"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ralfj.de; s=mail;
	t=1741115035; bh=T2QMug6/HcuzNxtAtbS9Jn2aCBfG39h86vtnhUTbmLk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JWFqyVR+8dD7VNvNXjfb3Q+hTZ/yKakitg36qKEMBGOPLIJz+g/YeY7UEZd9DLUrD
	 Vdx0zdeo0HSULFw8QnfeUjRDtTnYT+j5OGHj4oKt8oVMu4AYzw5hFJjQSifEMEusSR
	 dEserCGzfwJF/ZPhYKr4NsCq4NdpMgzNPOfxEsVw=
Received: from [IPV6:2001:67c:10ec:5784:8000::87] (2001-67c-10ec-5784-8000--87.net6.ethz.ch [IPv6:2001:67c:10ec:5784:8000::87])
	by r-passerv.ralfj.de (Postfix) with ESMTPSA id A271D2052D09;
	Tue,  4 Mar 2025 20:03:55 +0100 (CET)
Message-ID: <ae8ac31f-c6ad-46ae-80dd-10ec081a16d1@ralfj.de>
Date: Tue, 4 Mar 2025 20:03:51 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Allow data races on some read/write operations
To: Boqun Feng <boqun.feng@gmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, dakr@kernel.org,
 robin.murphy@arm.com, rust-for-linux@vger.kernel.org,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Trevor Gross <tmgross@umich.edu>,
 Valentin Obst <kernel@valentinobst.de>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>,
 airlied@redhat.com, iommu@lists.linux.dev, comex <comexk@gmail.com>,
 lkmm@lists.linux.dev
References: <6dea7b6a-1534-47e7-94d2-d67417c3d4c1@proton.me>
 <tnwDK3QN_Xr0Yoa3U8HVxS5OqjvxIhgmmO_ifTGJR_EtIzjoxawOHtnbOJ9yChsUWXyFPcU9beIdrgbpfGZI8w==@protonmail.internalid>
 <3202F69F-397E-4BC4-8DD8-E2D4B0AB056F@collabora.com>
 <87bjuil15w.fsf@kernel.org>
 <t4HxdvR7WBX_861hiTXo72jqC9F9oRpIzgA_dD2yhcSuLISEkC-shMfSgllrFPpnkSZXGfRcc47keudMooNiIQ==@protonmail.internalid>
 <CAH5fLgg5MuUu=TX8mMsPf5RcLhMLHSU4Vct=h8rFX6Z7HjPxeA@mail.gmail.com>
 <87ikoqjg1n.fsf@kernel.org>
 <KpWTCfIlcLYFBpSvWPfALJ9VQn5a99_RAvxgMBc1aCrSalPB-qaW9IhXyaDG7HM1AcFPX5chj_Yr7IQp3F7UqA==@protonmail.internalid>
 <CAH5fLgh6ubawHh76wq7JPbcuBCWhm91m7Rc01MVsX-a3C6qaVA@mail.gmail.com>
 <87mse2hrd8.fsf@kernel.org> <Z8YMTiKS4T9wC4t_@boqun-archlinux>
Content-Language: en-US, de-DE
From: Ralf Jung <post@ralfj.de>
In-Reply-To: <Z8YMTiKS4T9wC4t_@boqun-archlinux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

Ah, the never-ending LKMM vs Rust concurrency story. :)

> In general, this will fall into the exception that we've been given
> from the Rust people. In cases such as this where the Rust language
> does not give us the operation we want, do it like you do in C. Since
> Rust uses LLVM which does not miscompile the C part of the kernel, it
> should not miscompile the Rust part either.

Right, so to be clear this is all a compromise. :)  We don't want Rust to have 
two official memory models. We certainly don't want random Rust programs out 
there experimenting with any non-standard memory models and then expect that to 
work. (They can't all have a Paul McKenny keeping things together. ;) That's why 
in all official docs, you'll only find the one Rust concurrency memory model, 
which is the C++ model.
But meanwhile, the kernel is not some random Rust program out there (and you do 
have Paul ;). The LKMM works quite well in practice, and it is a critical part 
for Rust-for-Linux. Also, we have pretty good contacts with the Rust-for-Linux 
folks, so when there are issues we can just talk.

Given that the LKMM is at the edge (or, arguably, somewhat beyond the edge) of 
what compiler backends can reliably support, I think the lowest-risk strategy is 
to make LKMM usage from Rust look to the compiler just like LKMM usage in C. 
Since it works in C, it should then hopefully also work in Rust. To do this, you 
have to bend (really, break) some of the usual rules for Rust, and that's the 
special exception mentioned above.

>> For cases where we need to do the equivalent of `memmove`/`memcpy`, what
>> are is our options?
>>
> 
> Seems we need "volatile" memmove and memcpy in Rust?

Those already exist in Rust, albeit only unstably: 
<https://doc.rust-lang.org/nightly/std/intrinsics/fn.volatile_copy_memory.html>. 
However, I am not sure how you'd even generate such a call in C? The standard 
memcpy function is not doing volatile accesses, to my knowledge.

Kind regards,
Ralf

>> In case we have no options, do you know who would be the right people on
>> the Rust Project side to contact about getting an exception for this
>> case?
>>
> 
> I will say it'll be t-opsem.
> 
> Regards,
> Boqun
> 
>>
>> Best regards,
>> Andreas Hindborg
>>
>>

