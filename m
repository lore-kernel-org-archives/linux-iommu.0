Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC4D1CAA80
	for <iommu@lists.linux.dev>; Mon,  3 Feb 2025 18:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.63.210.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738608385; cv=none; b=Z3BNrSzCfTBEGgR2IXrCpC7/0uZXxSPtjJXNLDjRma/kGfn9eNrDZe9syYXeNXoVQkjQvoJz6+YW9mdsRDoFVWoSa9mqlslAh1aRavyJmb1xJvBksHbc1Hkz8CvLb3hpCxJ2frAkZAPgVjDMMC5X7FS05vsoHIP822SA79Mkh5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738608385; c=relaxed/simple;
	bh=DdBNZBVqhdt8t/yzb8j+B7YHIkBAvG76Ih0ekZehw5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B8Qb8K65y1/9c5yy94S7GViXyEYah9ovQ8Q7ONhPUQEsiHaeNzxIphDnkP4sI+5Trg4RW9ZVB/qNAh4FHE02E1CsNNlGAmEDo41i3lcZ7FYse1x/BEWS+B1Y5nwcIvvYB/GoAERZahgQeiJ5jDPq6eVslaDcK9K44EE0ORgDgpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marcan.st; spf=pass smtp.mailfrom=marcan.st; dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b=Iru9fUzJ; arc=none smtp.client-ip=212.63.210.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marcan.st
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marcan.st
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b="Iru9fUzJ"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: marcan@marcan.st)
	by mail.marcansoft.com (Postfix) with ESMTPSA id 24A7841D83;
	Mon,  3 Feb 2025 18:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
	t=1738608378; bh=DdBNZBVqhdt8t/yzb8j+B7YHIkBAvG76Ih0ekZehw5k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Iru9fUzJ7S5Zu8P8ln0ykbRKU0yif9DF72LO3K8SQw+7/2n+2Gx84FqPHrLPbzko3
	 ygwJPP7x4ic7HTbhN7r2ivy4WrdB6Aa6HzdimSEsyw99eu+sC+7Tbv1sWIdxMmZyal
	 AOzeDZSXTEfaYELOCxO4PQrW1fsdDdf9BV7HTgxCQBAXTWgML/DsNUzwe1Hs+I0m3d
	 11Hhf9GuqPFSPnXUEl7+PWPbWMeyQRJnHT9ZVwFghQdDcz+dZmcBMPjDlds9eR3C8e
	 sTYZA3hsOle3gUIPWPSRA7rLFAPmlSIwG1Tfxu6ychEwbfi+NH2tM3KbyrnstyGKdB
	 9VpvcX7X4pf1w==
Message-ID: <2b9b75d1-eb8e-494a-b05f-59f75c92e6ae@marcan.st>
Date: Tue, 4 Feb 2025 03:46:14 +0900
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] rust: add dma coherent allocator abstraction.
To: Jason Gunthorpe <jgg@nvidia.com>, Greg KH <gregkh@linuxfoundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: phasta@kernel.org, Christoph Hellwig <hch@lst.de>,
 Danilo Krummrich <dakr@kernel.org>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, daniel.almeida@collabora.com,
 aliceryhl@google.com, robin.murphy@arm.com, rust-for-linux@vger.kernel.org,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Valentin Obst <kernel@valentinobst.de>,
 open list <linux-kernel@vger.kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
References: <Z3-NqwAG_96yq8VD@pollux> <20250110083955.GA5395@lst.de>
 <Z4D5a5NYrAbNxUL6@pollux> <Z4kG5AcVeQKegLnb@pollux>
 <20250128092334.GA28548@lst.de>
 <293df3d54bad446e8fd527f204c6dc301354e340.camel@mailbox.org>
 <20250130154646.GA2298732@nvidia.com> <2025013030-gummy-cosmic-7927@gregkh>
 <20250130172437.GN5556@nvidia.com>
 <2025013148-reversal-pessimism-1515@gregkh>
 <20250131135421.GO5556@nvidia.com>
From: Hector Martin <marcan@marcan.st>
Content-Language: en-US
In-Reply-To: <20250131135421.GO5556@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025/01/31 22:54, Jason Gunthorpe wrote:
> On Fri, Jan 31, 2025 at 08:47:54AM +0100, Greg KH wrote:
>> On Thu, Jan 30, 2025 at 01:24:37PM -0400, Jason Gunthorpe wrote:
>>> On Thu, Jan 30, 2025 at 05:11:43PM +0100, Greg KH wrote:
>>>> On Thu, Jan 30, 2025 at 11:46:46AM -0400, Jason Gunthorpe wrote:
>>>>> On Thu, Jan 30, 2025 at 02:19:16PM +0100, Philipp Stanner wrote:
>>>>>> would some sort of official statement by the "entire community"
>>>>>> reassure you that the burden of keeping Rust abstractions working with
>>>>>> any changes on the C side rests entirely on the Rust side's
>>>>>> shoulders?
>>>>>
>>>>> You'd have to reconcile that with the recent event where Linus defered
>>>>> the MM pull request and some C patches were dropped because of rust
>>>>> kbuild bugs:
>>>>>
>>>>> https://lore.kernel.org/linux-mm/CAHk-=whddBhfi5DUi370W3pYs+z3r2E7KYuHjwR=a1eRig5Gxg@mail.gmail.com/
>>>>>
>>>>> It seems to me the message is now crystal clear, and the opposite of
>>>>> what you claim.
>>>>>
>>>>> All PRs to Linus must not break the rust build and the responsibilty
>>>>> for that falls to all the maintainers. If the Rust team is not quick
>>>>> enough to resolve any issues during the development window then
>>>>> patches must be dropped before sending PRs, or Linus will refuse the
>>>>> PR.
>>>>>
>>>>> Effectively this seems to imply that patches changing some of the C
>>>>> API cannot be merged by maintainers unless accompanied by matching
>>>>> Rust hunks.
>>>>>
>>>>> If there are different instructions to maintainers I would be
>>>>> interested to know.
>>>>
>>>> That's not the case, the one you point at above was a tooling issue that
>>>> people missed due to the holidays.  Fixing it up was simple enough and
>>>> people did so and moved on.
>>>
>>> Regardless of holidays, you seem to be saying that Linus should have
>>> accepted Andrew's PR and left rust with build failures?
>>
>> I can't answer for Linus, sorry.  
> 
> Then I think we need a clear statement from Linus how he will be
> working. If he is build testing rust or not.
> 
> Without that I don't think the Rust team should be saying "any changes
> on the C side rests entirely on the Rust side's shoulders".
> 
> It is clearly not the process if Linus is build testing rust and
> rejecting PRs that fail to build.

Adding Linus

My 2c: If Linus doesn't pipe up with an authoritative answer to this
thread, Miguel and the other Rust folks should just merge this series
once it is reviewed and ready, ignoring Christoph's overt attempt at
sabotaging the project. If Linus pulls it, what Christoph says doesn't
matter. If Linus doesn't pull it, the R4L project is essentially dead
until either Linus or Christoph make a move. Everything else is beating
around the bush.

Rust folks: Please don't waste your time and mental cycles on drama like
this. It's not worth your time. Either Linus likes it, or he doesn't.
Everything else is distractions orchestrated by a subset of saboteur
maintainers who are trying to demoralize you until you give up, because
they know they're going to be on the losing side of history sooner or
later. No amount of sabotage from old entrenched maintainers is going to
stop the world from moving forward towards memory-safe languages.

FWIW, in my opinion, the "cancer" comment from Christoph would be enough
to qualify for Code-of-Conduct action, but I doubt anything of the sort
will happen.

> 
>> But a generic "hey, this broke our
>> working toolchain builds" is something that is much much much different
> 
> It broke some builds, it sounded like the typical rust build was not
> effected because it used the same version of clang for C code and
> bindgen. Linus was mixing gcc and clang in his build.
> 
>> than "an api changed so I now have to turn off this driver in my build"
>> issue.
> 
> I tested this theory, allnoconfig x86 build, enable 64 bit, rust and
> PCI only. *NO* Rust drivers enabled.
> 
> Make a hypothetical C API change:
> 
>        --- a/include/asm-generic/pci_iomap.h
>        +++ b/include/asm-generic/pci_iomap.h
>        @@ -18,7 +18,7 @@ extern void __iomem *pci_iomap_range(struct pci_dev *dev, int bar,
> 	extern void __iomem *pci_iomap_wc_range(struct pci_dev *dev, int bar,
> 					       unsigned long offset,
> 					       unsigned long maxlen);
>        -extern void pci_iounmap(struct pci_dev *dev, void __iomem *);
>        +extern void pci_iounmap(struct pci_dev *dev, void __iomem *, unsigned int flags);
> 	/* Create a virtual mapping cookie for a port on a given PCI device.
> 	 * Do not call this directly, it exists to make it easier for architectures
> 	 * to override */
>        diff --git a/lib/iomap.c b/lib/iomap.c
>        index 4f8b31baa5752a..5b63063a1a811f 100644
>        --- a/lib/iomap.c
>        +++ b/lib/iomap.c
>        @@ -421,7 +421,7 @@ EXPORT_SYMBOL(ioport_unmap);
> 	#ifdef CONFIG_PCI
> 	/* Hide the details if this is a MMIO or PIO address space and just do what
> 	 * you expect in the correct way. */
>        -void pci_iounmap(struct pci_dev *dev, void __iomem * addr)
>        +void pci_iounmap(struct pci_dev *dev, void __iomem * addr, unsigned int flags)
> 	{
> 	       IO_COND(addr, /* nothing */, iounmap(addr));
> 	}
> 
> And the result is..
> 
>        error[E0061]: this function takes 3 arguments but 2 arguments were supplied
> 	  --> ../rust/kernel/pci.rs:320:13
> 	   |
>        320 |             bindings::pci_iounmap(pdev.as_raw(), ioptr as _);
> 	   |             ^^^^^^^^^^^^^^^^^^^^^--------------------------- an argument of type `u32` is missing
> 	   |
>        note: function defined here
> 	  --> /tmp/x/build/rust/bindings/bindings_generated.rs:3:1444598
> 	   |
>        3   | ...> * mut ffi :: c_void ; } extern "C" { pub fn pci_iounmap (dev : * mut pci_dev , arg1 : * mut ffi :: c_v...
> 	   |                                                  ^^^^^^^^^^^
>        help: provide the argument
> 	   |
>        320 |             bindings::pci_iounmap(pdev.as_raw(), ioptr as _, /* u32 */);
> 	   |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Build fails.
> 
> Can't seem to fix this using kconfig without turning off CONFIG_RUST,
> exactly the same outcome as Uros's case.
> 
> Doesn't seem "much much much different" to me.
> 
> This shouldn't be surprising. It doesn't work like C. Rust builds the
> PCI bindings always once CONFIG_PCI is turned on. It doesn't matter if
> no rust driver is being built that consumes those bindings. It won't
> work like staging does where you can just turn off one driver.
> 
> Jason
> 
> 

- Hector

