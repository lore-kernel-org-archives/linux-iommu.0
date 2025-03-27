Received: from mail-24416.protonmail.ch (mail-24416.protonmail.ch [109.224.244.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9E11E521B
	for <iommu@lists.linux.dev>; Thu, 27 Mar 2025 22:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743114399; cv=none; b=l5zk5jpOXAG2ym0aj3Oxk53H37Yoepx4vQUFZfz4fh6umg/rXRZWEn+ZP9vvIphipnljWqIZQLeE4zKWYMHosysG5XrJHIkULIIQEqrT5wfFTwLPDGhmVPoJ0cVShg3ifVeWXgE5l7wiNS+2DTdh9yIcEGqCEAR5+YNJ7J8kw7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743114399; c=relaxed/simple;
	bh=BRnlcNfWQbFo7F9dtGvjQD0vy1X2b35kekENnJxalfI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vFba5gnQLsV8qkItCYs+u8qgELTiptt/Y5+DUNtErrSjtMbhlADYvjv6FAakKYFBjNlNWfW7lFFoajEhdA40rvPOqPbA8fDEXOV9htP6vbDtdNqtPuJ8lY/4qDWUE/5GJm0bJIooVWH6cYNI1irINba+8hEi4qwLaneRVCfmV3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=R03Q07x+; arc=none smtp.client-ip=109.224.244.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="R03Q07x+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1743114389; x=1743373589;
	bh=oWvixeUAvhF2kqEr6ADx5r++iXHceMBawi9sqId8wXM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=R03Q07x+4fJbXxxkFsTBoAbeHPMo8RDuNnMvlIlMRDkutsDsBwf91Btt2uTpgLUWr
	 10RA/dmGj3ZM7E08ReXRTvI0Md2kf+1cUW/rGT9m++kNPOtx4A1wrPqpkmKTvD/Tbw
	 UX/PrR/hcYvaEKcyaUbxp+zzUlUWwUDDWEvZKurHnV+lKQA+LBNmv5EOJ7z9rzw2xW
	 aExRV1NGGMiLkWRaNWIbKse/6SatOeXSs467vMw+eqPKEy3pUdb6j8JepeWRigeCHV
	 WYosTH+2W17I5bU61zaeBFyhzM41c854voqgGh60ZB4erBHHA/26CkqfNvoXtGFj4T
	 iIe5cFMuc67ZA==
Date: Thu, 27 Mar 2025 22:26:23 +0000
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>, a.hindborg@kernel.org, ojeda@kernel.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, Robin Murphy <robin.murphy@arm.com>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, "open list:DMA MAPPING HELPERS DEVICE DRIVER API [RUST]" <rust-for-linux@vger.kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] rust: dma: convert the read/write macros to return Result
Message-ID: <D8REH728BFP1.2BGE9DTRP2IPU@proton.me>
In-Reply-To: <20250326201230.3193329-3-abdiel.janulgue@gmail.com>
References: <20250326201230.3193329-1-abdiel.janulgue@gmail.com> <20250326201230.3193329-3-abdiel.janulgue@gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 14740b0a863e8eb4e2bb6a1950d342e4a2b68679
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed Mar 26, 2025 at 9:11 PM CET, Abdiel Janulgue wrote:
> As suggested by Andreas Hindborg, we could do better here by
> having the macros return `Result`, so that we don't have to wrap
> these calls in a closure for validation which is confusing.
>
> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> ---
>  rust/kernel/dma.rs       | 54 +++++++++++++++++++++++-----------------
>  samples/rust/rust_dma.rs | 21 ++++++----------
>  2 files changed, 38 insertions(+), 37 deletions(-)
>
> diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
> index d3f448868457..24a6f10370c4 100644
> --- a/rust/kernel/dma.rs
> +++ b/rust/kernel/dma.rs
> @@ -328,20 +328,22 @@ unsafe impl<T: AsBytes + FromBytes + Send> Send for=
 CoherentAllocation<T> {}
>  #[macro_export]
>  macro_rules! dma_read {
>      ($dma:expr, $idx: expr, $($field:tt)*) =3D> {{
> -        let item =3D $crate::dma::CoherentAllocation::item_from_index(&$=
dma, $idx)?;
> -        // SAFETY: `item_from_index` ensures that `item` is always a val=
id pointer and can be
> -        // dereferenced. The compiler also further validates the express=
ion on whether `field`
> -        // is a member of `item` when expanded by the macro.
> -        unsafe {
> -            let ptr_field =3D ::core::ptr::addr_of!((*item) $($field)*);
> -            $crate::dma::CoherentAllocation::field_read(&$dma, ptr_field=
)
> -        }
> +        (|| -> Result<_> {

Please use `::core::result::Result<_, _>` instead. If someone uses this
macro in a place with a different `Result` than the one from the kernel
crate, then this will result in a compile error. (also in the instances
below)

You might want to use `::core::result::Result<_, $crate::error::Error>`
instead though if the type inference can't figure out the error type.

> +            let item =3D $crate::dma::CoherentAllocation::item_from_inde=
x(&$dma, $idx)?;
> +            // SAFETY: `item_from_index` ensures that `item` is always a=
 valid pointer and can be
> +            // dereferenced. The compiler also further validates the exp=
ression on whether `field`
> +            // is a member of `item` when expanded by the macro.
> +            unsafe {
> +                let ptr_field =3D ::core::ptr::addr_of!((*item) $($field=
)*);
> +                ::core::result::Result::Ok($crate::dma::CoherentAllocati=
on::field_read(&$dma, ptr_field))
> +            }
> +        })()
>      }};
>      ($dma:ident [ $idx:expr ] $($field:tt)* ) =3D> {
> -        $crate::dma_read!($dma, $idx, $($field)*);
> +        $crate::dma_read!($dma, $idx, $($field)*)
>      };
>      ($($dma:ident).* [ $idx:expr ] $($field:tt)* ) =3D> {
> -        $crate::dma_read!($($dma).*, $idx, $($field)*);
> +        $crate::dma_read!($($dma).*, $idx, $($field)*)
>      };
>  }
> =20

> diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
> index 908acd34b8db..cc09d49f2056 100644
> --- a/samples/rust/rust_dma.rs
> +++ b/samples/rust/rust_dma.rs
> @@ -54,13 +54,9 @@ fn probe(pdev: &mut pci::Device, _info: &Self::IdInfo)=
 -> Result<Pin<KBox<Self>>
>          let ca: CoherentAllocation<MyStruct> =3D
>              CoherentAllocation::alloc_coherent(pdev.as_ref(), TEST_VALUE=
S.len(), GFP_KERNEL)?;
> =20
> -        || -> Result {
> -            for (i, value) in TEST_VALUES.into_iter().enumerate() {
> -                kernel::dma_write!(ca[i] =3D MyStruct::new(value.0, valu=
e.1));
> -            }
> -
> -            Ok(())
> -        }()?;
> +        for (i, value) in TEST_VALUES.into_iter().enumerate() {
> +            kernel::dma_write!(ca[i] =3D MyStruct::new(value.0, value.1)=
)?;
> +        }
> =20
>          let drvdata =3D KBox::new(
>              Self {
> @@ -78,13 +74,10 @@ impl Drop for DmaSampleDriver {
>      fn drop(&mut self) {
>          dev_info!(self.pdev.as_ref(), "Unload DMA test driver.\n");
> =20
> -        let _ =3D || -> Result {
> -            for (i, value) in TEST_VALUES.into_iter().enumerate() {
> -                assert_eq!(kernel::dma_read!(self.ca[i].h), value.0);
> -                assert_eq!(kernel::dma_read!(self.ca[i].b), value.1);
> -            }
> -            Ok(())
> -        }();
> +        for (i, value) in TEST_VALUES.into_iter().enumerate() {
> +            assert_eq!(kernel::dma_read!(self.ca[i].h).unwrap(), value.0=
);
> +            assert_eq!(kernel::dma_read!(self.ca[i].b).unwrap(), value.1=
);
> +        }

This changes the behavior from before: now an error will result in a
panic where before it was just ignored. Not sure what to do here since
it's a sample, but if you intend the functional change, I would mention
it in the commit message.

---
Cheers,
Benno

>      }
>  }
> =20


