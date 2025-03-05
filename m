Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D951A23B1
	for <iommu@lists.linux.dev>; Wed,  5 Mar 2025 19:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741203035; cv=none; b=LXBNweDsuEcy8SOTeEoH8dqa9wwbuWeJruvrn+/U4Bgyv+JXmVNXM3OzwPOrtdU2svWSiRoVqpQXc6riyTbIoYqAi2N8upr6E0GWsr62admODJeEULs0ehO1N24BaXqfRrlApsri5OrwXh7N/Db7rGgDuA26HeoeDB1OMOs3rJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741203035; c=relaxed/simple;
	bh=t6SiDVwaTHvhAlwjcDp2TYwOA5pPtU4A7kw092Af/vg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4KZZJlOT6/hyJQ6pRZd+Roeg+XvoSQAXSgf0NssKMzhWUBqbIx7kKBkVj9MesH6XdcnyIleDK7bGf/g2vodJ9T1Wq3R0lNddSuLsjRVwqUwO5mVxGswCW0vPFXvypS4R5P0gh4MxNjulpaGEDPum9gwVqWjI92slG6774FcmEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=HXo+74RD; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="HXo+74RD"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7be8f281714so834852285a.1
        for <iommu@lists.linux.dev>; Wed, 05 Mar 2025 11:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1741203032; x=1741807832; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oId15+YDneGVvUrzPX64hfAInMf60MXmTWB86DACpPE=;
        b=HXo+74RD5NYgZgrZ9HHktIPGi/znuEjupilTaM6INVQcj/XCzttn7T26apxmu738Hx
         tXuhklQ4H3ehRFbyA1ilYsg+JXGgBHZ0EF6nuE7PH/U1Ubvl+2Wl1rrYBqzkjazDNexs
         oxhvPBMLC1wi35tZjhqGkcLM4h+QfUmNg9+pw6tLzZs1eBvGqMwv/tPWdvYpRom6vctM
         ktxc2vbGbjhLsdjI99mkniWlXf3jC9/tqvFsPr8wxff5F6ZiSv3Idpc3P9QfE8VElDWE
         7EiAygKJZwrXx4JfDzwyWJTtEmeyKrsNVk5jnPBPG1Ze3pkkhXeNmZ1pS9Xo73cFxsr/
         uA0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741203032; x=1741807832;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oId15+YDneGVvUrzPX64hfAInMf60MXmTWB86DACpPE=;
        b=GvzwFls+sPqIcR20nozN6rX+R4FyoOw/qDHAYS78WxMPDIoMqrCQY3L9N09lCwQrib
         axJOunrxMa4AqwZm2dgnP/5gkeB9vffHfjbyfb0FmMOYFZw0RWtkXNftV4mN1sThH/F5
         g/YB3EdbKL43rlfT7nJnkZzqVVJgAUuEaTNwf96O/le9T0y1Pjj9F+f4M6I8Neirq9CO
         JG5LpEAZl5fRXF8GxIxa8J1hQterxNCbOzFPx7bHvS/IWCftMasneTPFxIPFIv4cRJML
         UQwzLrETNvW0GI0PT4sREdbOajTUD/xFwz7/8Gnemj904441Mr6sEFaAkEIh2SbZLn/0
         hCKw==
X-Forwarded-Encrypted: i=1; AJvYcCV8pJL5IPmcoj1fu7/XAfTnSR5YR2ZkWeWlTyxKgMuKrkKoq5+aGg9TLE5ahp1mM6mxjIzeTQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzzX1Z11ykK91xLs5f3ejz9NlHKmadQspmpFUrfBXDxpSurGkVU
	4AC8o2OwiXoDxhUsAFmBxJG+qrO9XDy/U6eWlOnofGnzsst7DuNttuhW3QfEJA==
X-Gm-Gg: ASbGnctEXXczIFBTqgYGeIfSV55ll0eF9YZZNu2Rjh7qJKXgj9os0tLTuG4WtNTzSSs
	7gbkxSv6xPtzpBnRx0oDlKWsBiMZfyldQQDpNXbBCaoybk7Cz1ld/hWnIrH7EeieI8r6dfSg9T3
	IR45aHQTJaNSlgHnYFLFMQaIWqbyfFaIHcysKdfmkHPgyJrLHXVsxgi26Ryj8J1bZwKzjeyFvI3
	LR4QxjIXJph27bxTbFprQiiC7borczOs+6ACWR2+tyPxLh+9cEjmYKXGUe8EACpRkMscrzcSTEg
	wiwAUOEeRvw2TaFF3XcZ+o38WO+9XX1i8oZHc2rIdxwR0q/MtiKozmYUGJRATShJwSIiPzLYc97
	UrJtTdD3mP4cbYjEUWar76V86JRIbkORXsMbDwg==
X-Google-Smtp-Source: AGHT+IEdHIEYyOFA6iBD4IRAvEEK44U33sXsSKu1qSukoScCCId/HavsdZVIN+N6mZ49Avbu1kb/wA==
X-Received: by 2002:a05:620a:84c4:b0:7c0:a0fd:7b2c with SMTP id af79cd13be357-7c3d8e55666mr759133185a.22.1741203032165;
        Wed, 05 Mar 2025 11:30:32 -0800 (PST)
Received: from rowland.harvard.edu (nat-65-112-8-24.harvard-secure.wrls.harvard.edu. [65.112.8.24])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3d30234c7sm214999985a.34.2025.03.05.11.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 11:30:31 -0800 (PST)
Date: Wed, 5 Mar 2025 14:30:28 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Ralf Jung <post@ralfj.de>, Alice Ryhl <aliceryhl@google.com>,
	Boqun Feng <boqun.feng@gmail.com>, comex <comexk@gmail.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>, dakr@kernel.org,
	robin.murphy@arm.com, rust-for-linux@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
	iommu@lists.linux.dev, lkmm@lists.linux.dev
Subject: Re: Allow data races on some read/write operations
Message-ID: <471eec19-1abb-43f1-aec0-d0db56f6ca9e@rowland.harvard.edu>
References: <87mse2hrd8.fsf@kernel.org>
 <Z8YMTiKS4T9wC4t_@boqun-archlinux>
 <ae8ac31f-c6ad-46ae-80dd-10ec081a16d1@ralfj.de>
 <88456D33-C5CA-4F4F-990E-8C5F2AF7EAF9@gmail.com>
 <hkhgihg4fjkg7zleqnumuj65dfvmxa5rzawkiafrf4kn5ss6nw@o7kc6xe2bmuj>
 <25e7e425-ae72-4370-ae95-958882a07df9@ralfj.de>
 <CAH5fLgidPHQzdUORNpNhtRFsKPU1T-0xdn5OSwYYZh3BgOVRQA@mail.gmail.com>
 <18cmxblLU2QAa4YP25RWCKEnxuonOwWXavYmSsS4C5D40o8RaCkIXo0UDZ2SPnksk5nWYB29Y4zHkjQeOgd4ng==@protonmail.internalid>
 <3aabca39-4658-454a-b0e3-e946e72977e1@ralfj.de>
 <87eczb71xs.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87eczb71xs.fsf@kernel.org>

On Wed, Mar 05, 2025 at 07:43:59PM +0100, Andreas Hindborg wrote:
> "Ralf Jung" <post@ralfj.de> writes:
> 
> > Hi,
> >
> > On 05.03.25 14:23, Alice Ryhl wrote:
> >> On Wed, Mar 5, 2025 at 2:10 PM Ralf Jung <post@ralfj.de> wrote:
> >>>
> >>> Hi,
> >>>
> >>> On 05.03.25 04:24, Boqun Feng wrote:
> >>>> On Tue, Mar 04, 2025 at 12:18:28PM -0800, comex wrote:
> >>>>>
> >>>>>> On Mar 4, 2025, at 11:03 AM, Ralf Jung <post@ralfj.de> wrote:
> >>>>> However, these optimizations should rarely trigger misbehavior in
> >>>>> practice, so I wouldn’t be surprised if Linux had some code that
> >>>>> expected memcpy to act volatile…
> >>>>>
> >>>>
> >>>> Also in this particular case we are discussing [1], it's a memcpy (from
> >>>> or to) a DMA buffer, which means the device can also read or write the
> >>>> memory, therefore the content of the memory may be altered outside the
> >>>> program (the kernel), so we cannot use copy_nonoverlapping() I believe.
> >>>>
> >>>> [1]: https://lore.kernel.org/rust-for-linux/87bjuil15w.fsf@kernel.org/
> >>>
> >>> Is there actually a potential for races (with reads by hardware, not other
> >>> threads) on the memcpy'd memory? Or is this the pattern where you copy some data
> >>> somewhere and then set a flag in an MMIO register to indicate that the data is
> >>> ready and the device can start reading it? In the latter case, the actual data
> >>> copy does not race with anything, so it can be a regular non-atomic non-volatile
> >>> memcpy. The flag write *should* be a release write, and release volatile writes
> >>> do not exist, so that is a problem, but it's a separate problem from volatile
> >>> memcpy. One can use a release fence followed by a relaxed write instead.
> >>> Volatile writes do not currently act like relaxed writes, but you need that
> >>> anyway for WRITE_ONCE to make sense so it seems fine to rely on that here as well.
> >>>
> >>> Rust should have atomic volatile accesses, and various ideas have been proposed
> >>> over the years, but sadly nobody has shown up to try and push this through.
> >>>
> >>> If the memcpy itself can indeed race, you need an atomic volatile memcpy --
> >>> which neither C nor Rust have, though there are proposals for atomic memcpy (and
> >>> arguably, there should be a way to interact with a device using non-volatile
> >>> atomics... but anyway in the LKMM, atomics are modeled with volatile, so things
> >>> are even more entangled than usual ;).
> >>
> >> For some kinds of hardware, we might not want to trust the hardware.
> >> I.e., there is no race under normal operation, but the hardware could
> >> have a bug or be malicious and we might not want that to result in UB.
> >> This is pretty similar to syscalls that take a pointer into userspace
> >> memory and read it - userspace shouldn't modify that memory during the
> >> syscall, but it can and if it does, that should be well-defined.
> >> (Though in the case of userspace, the copy happens in asm since it
> >> also needs to deal with virtual memory and so on.)
> >
> > Wow you are really doing your best to combine all the hard problems at the same
> > time. ;)
> > Sharing memory with untrusted parties is another tricky issue, and even leaving
> > aside all the theoretical trouble, practically speaking you'll want to
> > exclusively use atomic accesses to interact with such memory. So doing this
> > properly requires atomic memcpy. I don't know what that is blocked on, but it is
> > good to know that it would help the kernel.
> 
> I am sort of baffled by this, since the C kernel has no such thing and
> has worked fine for a few years. Is it a property of Rust that causes us
> to need atomic memcpy, or is what the C kernel is doing potentially dangerous?

I agree; this is a strange discussion.

What is it that people want to protect against?  If the issue is 
undefined behavior caused by a second party modifying the source of a 
memcpy() while the copy is in progress -- well, there's no way to 
protect against that.  You just have to make sure either that it cannot 
happen or else that you can cope with potentially torn values in the 
copy's destination.

Is the issue a matter of informing verifiers or sanitizers that a data 
race during a memcpy() shouldn't count as undefined behavior?  Surely 
the way to do this depends on the verifier/sanitizer in question.  As 
far as I know, there is no version of memcpy() whose arguments are 
declared to be pointers to atomics.  (And if such a thing did exist, it 
would be part of C++, not of C.)

Alan Stern
