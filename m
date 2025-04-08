Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DE1268C62;
	Tue,  8 Apr 2025 12:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744116046; cv=none; b=SBkD0IGLouwLnpX8QUIaYbOqz6m6w+P0MfIheWk1G+WDZGW64ey3RgqD5vlejnTCNO0xQyuW3caJCXXJ2rtFk2NHUfm8rKelUWvGBlxDYQUf16ZFHBKQD4bIvGRvz6cgKceRDq+INmu6rhfPWPw0JmcdoUIEEmfeI12ggBJEw6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744116046; c=relaxed/simple;
	bh=9sfgn6LmdPXb8W2jk29htGHZAeYFFj1229hlzSLGjaY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Xd72KM4+/6jy1r6LymwE12cGmOVDVyuQpz8KXCERpgwRIpc0PsepzPisyYiTAMm84nYO2K9PDfK0c4LQ3VNTVfWAGJy9V4ZYxKOGgvU05jmFDu2fGXn/JAYJXOoRiNhDeVzZp3t+Uq0BHCwnYqwIbzLVQ2enADqIw+YuFfXsSNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBFnjEar; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBFnjEar"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2D62C4CEEC;
	Tue,  8 Apr 2025 12:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744116046;
	bh=9sfgn6LmdPXb8W2jk29htGHZAeYFFj1229hlzSLGjaY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=aBFnjEarPs3J0MUnytD3iVyQQbvBNm0VY7KqsNwT4zgZ5KfbBUEftCrd2g61MZcNE
	 fYFni/Ps05HPon77udexm6fXLbO0OpB9UMW5EYJN7EnF275Vo/tKgpwoAt/WaNrbr1
	 FGb0JRcDWiOydqCuj+0BOIZpTaZwzzbVP4YPMZnFSeB2YbZULceE9j+YLEjrdTjLte
	 KoXDkn4tfSb+gWg3MrYIVT/Fj0yiJztJHcQSZNnJ68RmLRI5xgLAe0WboYFIV0LV6v
	 yICqPZAisitlHGa5DjfWdTxiUYQ0q5TP2ctrM1cVK40zNbPSAGfMumjkPBG2xB7zL0
	 WjQesFC0Bl6vQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Benno Lossin" <benno.lossin@proton.me>
Cc: "Abdiel Janulgue" <abdiel.janulgue@gmail.com>,  <ojeda@kernel.org>,
  "Danilo Krummrich" <dakr@kernel.org>,  "Daniel Almeida"
 <daniel.almeida@collabora.com>,  "Robin Murphy" <robin.murphy@arm.com>,
  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor
 Gross" <tmgross@umich.edu>,  "open list:DMA MAPPING HELPERS DEVICE DRIVER
 API [RUST]" <rust-for-linux@vger.kernel.org>,  "Marek Szyprowski"
 <m.szyprowski@samsung.com>,  "open list:DMA MAPPING HELPERS"
 <iommu@lists.linux.dev>,  "open list" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] rust: dma: convert the read/write macros to return
 Result
In-Reply-To: <D8REH728BFP1.2BGE9DTRP2IPU@proton.me> (Benno Lossin's message of
	"Thu, 27 Mar 2025 22:26:23 +0000")
References: <20250326201230.3193329-1-abdiel.janulgue@gmail.com>
	<20250326201230.3193329-3-abdiel.janulgue@gmail.com>
	<nujfDI6IKBsjlQtGWaMrhjZSQYYeQYckCyOUs9jIzgZGsP1WTalJE0sSg6tp_WMACWo9mzuDfpdzsIlmkKnL8w==@protonmail.internalid>
	<D8REH728BFP1.2BGE9DTRP2IPU@proton.me>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 08 Apr 2025 14:33:52 +0200
Message-ID: <87ldsahlxr.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

"Benno Lossin" <benno.lossin@proton.me> writes:

> On Wed Mar 26, 2025 at 9:11 PM CET, Abdiel Janulgue wrote:
>> As suggested by Andreas Hindborg, we could do better here by
>> having the macros return `Result`, so that we don't have to wrap
>> these calls in a closure for validation which is confusing.
>>
>> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
>> ---
>>  rust/kernel/dma.rs       | 54 +++++++++++++++++++++++-----------------
>>  samples/rust/rust_dma.rs | 21 ++++++----------
>>  2 files changed, 38 insertions(+), 37 deletions(-)
>>
>> diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
>> index d3f448868457..24a6f10370c4 100644
>> --- a/rust/kernel/dma.rs
>> +++ b/rust/kernel/dma.rs
>> @@ -328,20 +328,22 @@ unsafe impl<T: AsBytes + FromBytes + Send> Send for CoherentAllocation<T> {}
>>  #[macro_export]
>>  macro_rules! dma_read {
>>      ($dma:expr, $idx: expr, $($field:tt)*) => {{
>> -        let item = $crate::dma::CoherentAllocation::item_from_index(&$dma, $idx)?;
>> -        // SAFETY: `item_from_index` ensures that `item` is always a valid pointer and can be
>> -        // dereferenced. The compiler also further validates the expression on whether `field`
>> -        // is a member of `item` when expanded by the macro.
>> -        unsafe {
>> -            let ptr_field = ::core::ptr::addr_of!((*item) $($field)*);
>> -            $crate::dma::CoherentAllocation::field_read(&$dma, ptr_field)
>> -        }
>> +        (|| -> Result<_> {
>
> Please use `::core::result::Result<_, _>` instead. If someone uses this
> macro in a place with a different `Result` than the one from the kernel
> crate, then this will result in a compile error. (also in the instances
> below)
>
> You might want to use `::core::result::Result<_, $crate::error::Error>`
> instead though if the type inference can't figure out the error type.
>
>> +            let item = $crate::dma::CoherentAllocation::item_from_index(&$dma, $idx)?;
>> +            // SAFETY: `item_from_index` ensures that `item` is always a valid pointer and can be
>> +            // dereferenced. The compiler also further validates the expression on whether `field`
>> +            // is a member of `item` when expanded by the macro.
>> +            unsafe {
>> +                let ptr_field = ::core::ptr::addr_of!((*item) $($field)*);
>> +                ::core::result::Result::Ok($crate::dma::CoherentAllocation::field_read(&$dma, ptr_field))
>> +            }
>> +        })()
>>      }};
>>      ($dma:ident [ $idx:expr ] $($field:tt)* ) => {
>> -        $crate::dma_read!($dma, $idx, $($field)*);
>> +        $crate::dma_read!($dma, $idx, $($field)*)
>>      };
>>      ($($dma:ident).* [ $idx:expr ] $($field:tt)* ) => {
>> -        $crate::dma_read!($($dma).*, $idx, $($field)*);
>> +        $crate::dma_read!($($dma).*, $idx, $($field)*)
>>      };
>>  }
>>
>
>> diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
>> index 908acd34b8db..cc09d49f2056 100644
>> --- a/samples/rust/rust_dma.rs
>> +++ b/samples/rust/rust_dma.rs
>> @@ -54,13 +54,9 @@ fn probe(pdev: &mut pci::Device, _info: &Self::IdInfo) -> Result<Pin<KBox<Self>>
>>          let ca: CoherentAllocation<MyStruct> =
>>              CoherentAllocation::alloc_coherent(pdev.as_ref(), TEST_VALUES.len(), GFP_KERNEL)?;
>>
>> -        || -> Result {
>> -            for (i, value) in TEST_VALUES.into_iter().enumerate() {
>> -                kernel::dma_write!(ca[i] = MyStruct::new(value.0, value.1));
>> -            }
>> -
>> -            Ok(())
>> -        }()?;
>> +        for (i, value) in TEST_VALUES.into_iter().enumerate() {
>> +            kernel::dma_write!(ca[i] = MyStruct::new(value.0, value.1))?;
>> +        }
>>
>>          let drvdata = KBox::new(
>>              Self {
>> @@ -78,13 +74,10 @@ impl Drop for DmaSampleDriver {
>>      fn drop(&mut self) {
>>          dev_info!(self.pdev.as_ref(), "Unload DMA test driver.\n");
>>
>> -        let _ = || -> Result {
>> -            for (i, value) in TEST_VALUES.into_iter().enumerate() {
>> -                assert_eq!(kernel::dma_read!(self.ca[i].h), value.0);
>> -                assert_eq!(kernel::dma_read!(self.ca[i].b), value.1);
>> -            }
>> -            Ok(())
>> -        }();
>> +        for (i, value) in TEST_VALUES.into_iter().enumerate() {
>> +            assert_eq!(kernel::dma_read!(self.ca[i].h).unwrap(), value.0);
>> +            assert_eq!(kernel::dma_read!(self.ca[i].b).unwrap(), value.1);
>> +        }
>
> This changes the behavior from before: now an error will result in a
> panic where before it was just ignored. Not sure what to do here since
> it's a sample, but if you intend the functional change, I would mention
> it in the commit message.

There is two sides to this. If we want this as a nice example that
people should copy in their drivers, using unwrap is bad. But for
testing and demonstration purposes, I think the unwrap is mandated.

But the `assert_eq!` would panic anyway if comparison fails, right?


Best regards,
Andreas Hindborg


