Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EC0170A15
	for <iommu@lists.linux.dev>; Wed, 22 Jan 2025 09:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737537229; cv=none; b=f5rnHSxA6WdKBw6BpciXSdMc1pVien6tKhWUjwa0pEuqF4VfwyFcs1LtEZYnJTkTHqwnkJH1/kFpCwrj3LG8jO+qRMMqCIZCw8/I3RAl1cy43YuQ5s5Y2j6LAq8+uuOrRbHG7xe18cVtjwC3ul9yidn78kYIcG9SPy60yGmhxVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737537229; c=relaxed/simple;
	bh=lJyM2M53C+oYgrKFYeHteahmuUakX1U9RqsD2aaf2AM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i+MPhW1Xmik/ZhGRVNzb5THDEIwKbDb6DLKCkMb3/v6pkZjACrb0oo6Oqk0Nq43z4EKUrEj5Iii0DSlbl1kHjeUvkCKlXqKVCJ15Q05e4259m/mZ3D4ZgQMexWmg5FqTDUCLn0Hsg9MfmpSy39C4SUsMbsZqfVuVW8n1ITKbl2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iCFWoq4I; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iCFWoq4I"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-385e06af753so3276497f8f.2
        for <iommu@lists.linux.dev>; Wed, 22 Jan 2025 01:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737537225; x=1738142025; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8IkfhCmY6dDspr1DMhSmmJ7oWkBzIBYutY/kcr3VeIA=;
        b=iCFWoq4I5IKC28V477QifzZitchysAJlolh6GGsG+2/c8mLr/tZ/4BDiaLXBRTRFv1
         EP/x9sRBk3c5h3KljKluUPsbEw0gYHi+Klxv40Y/PNEpvHYqGGHxr3lkTkTBqTVfLvMY
         a9t+hIZG1QltAywh0Cwa/9+CKrcGk986Pa1x8/ZK8zkhO8RmAFZUFlJvjMTAiBkIweFD
         N2/ynUQT3JinYlopGqDQ4pFKtHqi307SFbtmUGisoL2C0gmpqJpKAHJfyIkCtGM6kpg+
         MhpJJT3xnMwqSMNxFr36EDhEnl/Are5o24C4+OBljIUpTYp4nJbT0euas9SmzHSdtSMf
         8L7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737537225; x=1738142025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8IkfhCmY6dDspr1DMhSmmJ7oWkBzIBYutY/kcr3VeIA=;
        b=JjOT0a3b0UdX8kWJNWUOK1MqP4o9SZn3uYarB1lU56b/K3Dp9c7JdsyKmhEWzikuK6
         z++dhw+KsW1HR9GGWDMIOcG2B7eiJhRe0RsB1qNDOYCOinJso6rrCrzg4y2IFu4lAydO
         3pht68kPCQ/6ELX3A/5WOuFCc1eEGt8wd9VBLjjLRIUbTlbEO0AgvbUI7vMnilokNSBF
         DmsCjvjnYObyXmqdyzatI1c+fPQffMSaLtW+TBXT/Z3glP07vUdr4TIklsWTexAom3FL
         Z/KvYMnsrreW+7mOueEUh52ug3y7m/9eZ2pLMJH2RxdDTpXAVdxtewhRcf6jzNxvgJaL
         GNyw==
X-Forwarded-Encrypted: i=1; AJvYcCUD7VigdqR/tAgnGp+l2kwYwg69NXuofG/Kp5e68v+BIwdjYQkmedVXpDdzZudtjELT8l9zNQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyNh/8l8JT96oQGQFXceYH/HVmOvoA7+nS0ljp34miBYY6PD3cH
	xNF8nOZGAbruJ5tx8m4Nv0N01L0e7APY1WccytgceBLrW+C+YtnNRpi9f9nxYb5RdySj27cZwE6
	fifrRijokTzwDEkqFe0UHMM+f7ZOl55hq52M4
X-Gm-Gg: ASbGncsQZymteKMa/zcctwBrWyp5mcrVlcbOmAzbLrt2x9+3i4RxjZiZtrjX2n2BHr6
	f82nAuAC7NkdEqZT5NA82e+mK2gHCOvKeDOAqK5JVXX25KGVwRAT/ZQolNordGgltuFazD88sHO
	r6drz8
X-Google-Smtp-Source: AGHT+IHK+Dd7SoRcT2CTFs1LpfotwW3in1hFTtTfbcnPZM3TLjGpvOahcpqaYeqbkLj0JCe1b5C4HTCvnr3bN7vIO2E=
X-Received: by 2002:a05:6000:186f:b0:385:e105:d884 with SMTP id
 ffacd0b85a97d-38bf57b6095mr20621039f8f.46.1737537225109; Wed, 22 Jan 2025
 01:13:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250121191432.1178734-1-abdiel.janulgue@gmail.com> <20250121191432.1178734-3-abdiel.janulgue@gmail.com>
In-Reply-To: <20250121191432.1178734-3-abdiel.janulgue@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 22 Jan 2025 10:13:32 +0100
X-Gm-Features: AbW1kvZBDfEun-f5Vo2uhtkolwcUGu5Q3JEc1au9tXb4idQdtbWRfdRIBZEiIxo
Message-ID: <CAH5fLgjVjAVwR+osD4ajKfyewdWPpkSyV+oy=ppaCULUdPqB7w@mail.gmail.com>
Subject: Re: [PATCH v10 2/3] rust: add dma coherent allocator abstraction.
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: rust-for-linux@vger.kernel.org, daniel.almeida@collabora.com, 
	dakr@kernel.org, robin.murphy@arm.com, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Valentin Obst <kernel@valentinobst.de>, 
	open list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com, 
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2025 at 8:14=E2=80=AFPM Abdiel Janulgue
<abdiel.janulgue@gmail.com> wrote:
>
> Add a simple dma coherent allocator rust abstraction. Based on
> Andreas Hindborg's dma abstractions from the rnvme driver, which
> was also based on earlier work by Wedson Almeida Filho.
>
> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> ---
>  rust/bindings/bindings_helper.h |   1 +
>  rust/kernel/dma.rs              | 281 ++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs              |   1 +
>  3 files changed, 283 insertions(+)
>  create mode 100644 rust/kernel/dma.rs
>
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_hel=
per.h
> index 5c4dfe22f41a..49bf713b9bb6 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -11,6 +11,7 @@
>  #include <linux/blk_types.h>
>  #include <linux/blkdev.h>
>  #include <linux/cred.h>
> +#include <linux/dma-mapping.h>
>  #include <linux/errname.h>
>  #include <linux/ethtool.h>
>  #include <linux/file.h>
> diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
> new file mode 100644
> index 000000000000..ebae7270190e
> --- /dev/null
> +++ b/rust/kernel/dma.rs
> @@ -0,0 +1,281 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Direct memory access (DMA).
> +//!
> +//! C header: [`include/linux/dma-mapping.h`](srctree/include/linux/dma-=
mapping.h)
> +
> +use crate::{
> +    bindings, build_assert,
> +    device::Device,
> +    error::code::*,
> +    error::Result,
> +    transmute::{AsBytes, FromBytes},
> +    types::ARef,
> +};
> +
> +/// Possible attributes associated with a DMA mapping.
> +///
> +/// They can be combined with the operators `|`, `&`, and `!`.
> +///
> +/// Values can be used from the [`attrs`] module.
> +#[derive(Clone, Copy, PartialEq)]
> +#[repr(transparent)]
> +pub struct Attrs(u32);
> +
> +impl Attrs {
> +    /// Get the raw representation of this attribute.
> +    pub(crate) fn as_raw(self) -> crate::ffi::c_ulong {
> +        self.0 as _
> +    }
> +
> +    /// Check whether `flags` is contained in `self`.
> +    pub fn contains(self, flags: Attrs) -> bool {
> +        (self & flags) =3D=3D flags
> +    }
> +}
> +
> +impl core::ops::BitOr for Attrs {
> +    type Output =3D Self;
> +    fn bitor(self, rhs: Self) -> Self::Output {
> +        Self(self.0 | rhs.0)
> +    }
> +}
> +
> +impl core::ops::BitAnd for Attrs {
> +    type Output =3D Self;
> +    fn bitand(self, rhs: Self) -> Self::Output {
> +        Self(self.0 & rhs.0)
> +    }
> +}
> +
> +impl core::ops::Not for Attrs {
> +    type Output =3D Self;
> +    fn not(self) -> Self::Output {
> +        Self(!self.0)
> +    }
> +}
> +
> +/// DMA mapping attrributes.
> +pub mod attrs {
> +    use super::Attrs;
> +
> +    /// Specifies that reads and writes to the mapping may be weakly ord=
ered, that is that reads
> +    /// and writes may pass each other.
> +    pub const DMA_ATTR_WEAK_ORDERING: Attrs =3D Attrs(bindings::DMA_ATTR=
_WEAK_ORDERING);
> +
> +    /// Specifies that writes to the mapping may be buffered to improve =
performance.
> +    pub const DMA_ATTR_WRITE_COMBINE: Attrs =3D Attrs(bindings::DMA_ATTR=
_WRITE_COMBINE);
> +
> +    /// Lets the platform to avoid creating a kernel virtual mapping for=
 the allocated buffer.
> +    pub const DMA_ATTR_NO_KERNEL_MAPPING: Attrs =3D Attrs(bindings::DMA_=
ATTR_NO_KERNEL_MAPPING);
> +
> +    /// Allows platform code to skip synchronization of the CPU cache fo=
r the given buffer assuming
> +    /// that it has been already transferred to 'device' domain.
> +    pub const DMA_ATTR_SKIP_CPU_SYNC: Attrs =3D Attrs(bindings::DMA_ATTR=
_SKIP_CPU_SYNC);
> +
> +    /// Forces contiguous allocation of the buffer in physical memory.
> +    pub const DMA_ATTR_FORCE_CONTIGUOUS: Attrs =3D Attrs(bindings::DMA_A=
TTR_FORCE_CONTIGUOUS);
> +
> +    /// This is a hint to the DMA-mapping subsystem that it's probably n=
ot worth the time to try
> +    /// to allocate memory to in a way that gives better TLB efficiency.
> +    pub const DMA_ATTR_ALLOC_SINGLE_PAGES: Attrs =3D Attrs(bindings::DMA=
_ATTR_ALLOC_SINGLE_PAGES);
> +
> +    /// This tells the DMA-mapping subsystem to suppress allocation fail=
ure reports (similarly to
> +    /// __GFP_NOWARN).
> +    pub const DMA_ATTR_NO_WARN: Attrs =3D Attrs(bindings::DMA_ATTR_NO_WA=
RN);
> +
> +    /// Used to indicate that the buffer is fully accessible at an eleva=
ted privilege level (and
> +    /// ideally inaccessible or at least read-only at lesser-privileged =
levels).
> +    pub const DMA_ATTR_PRIVILEGED: Attrs =3D Attrs(bindings::DMA_ATTR_PR=
IVILEGED);
> +}
> +
> +/// An abstraction of the `dma_alloc_coherent` API.
> +///
> +/// This is an abstraction around the `dma_alloc_coherent` API which is =
used to allocate and map
> +/// large consistent DMA regions.
> +///
> +/// A [`CoherentAllocation`] instance contains a pointer to the allocate=
d region (in the
> +/// processor's virtual address space) and the device address which can =
be given to the device
> +/// as the DMA address base of the region. The region is released once [=
`CoherentAllocation`]
> +/// is dropped.
> +///
> +/// # Invariants
> +///
> +/// For the lifetime of an instance of [`CoherentAllocation`], the cpu a=
ddress is a valid pointer
> +/// to an allocated region of consistent memory and we hold a reference =
to the device.
> +pub struct CoherentAllocation<T: AsBytes + FromBytes> {
> +    dev: ARef<Device>,
> +    dma_handle: bindings::dma_addr_t,
> +    count: usize,
> +    cpu_addr: *mut T,
> +    dma_attrs: Attrs,
> +}
> +
> +impl<T: AsBytes + FromBytes> CoherentAllocation<T> {
> +    /// Allocates a region of `size_of::<T> * count` of consistent memor=
y.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::device::Device;
> +    /// use kernel::dma::{attrs::*, CoherentAllocation};
> +    ///
> +    /// # fn test(dev: &Device) -> Result {
> +    /// let c: CoherentAllocation<u64> =3D CoherentAllocation::alloc_att=
rs(dev.into(), 4, GFP_KERNEL,
> +    ///                                                                 =
 DMA_ATTR_NO_WARN)?;
> +    /// # Ok::<(), Error>(()) }
> +    /// ```
> +    pub fn alloc_attrs(
> +        dev: ARef<Device>,
> +        count: usize,
> +        gfp_flags: kernel::alloc::Flags,
> +        dma_attrs: Attrs,
> +    ) -> Result<CoherentAllocation<T>> {
> +        build_assert!(
> +            core::mem::size_of::<T>() > 0,
> +            "It doesn't make sense for the allocated type to be a ZST"
> +        );
> +
> +        let size =3D count
> +            .checked_mul(core::mem::size_of::<T>())
> +            .ok_or(EOVERFLOW)?;
> +        let mut dma_handle =3D 0;
> +        // SAFETY: device pointer is guaranteed as valid by invariant on=
 `Device`.
> +        // We ensure that we catch the failure on this function and thro=
w an ENOMEM
> +        let ret =3D unsafe {
> +            bindings::dma_alloc_attrs(
> +                dev.as_raw(),
> +                size,
> +                &mut dma_handle,
> +                gfp_flags.as_raw(),
> +                dma_attrs.as_raw(),
> +            )
> +        };
> +        if ret.is_null() {
> +            return Err(ENOMEM);
> +        }
> +        // INVARIANT: We just successfully allocated a coherent region w=
hich is accessible for
> +        // `count` elements, hence the cpu address is valid. We also hol=
d a refcounted reference
> +        // to the device.
> +        Ok(Self {
> +            dev,
> +            dma_handle,
> +            count,
> +            cpu_addr: ret as *mut T,
> +            dma_attrs,
> +        })
> +    }
> +
> +    /// Performs the same functionality as `alloc_attrs`, except the `dm=
a_attrs` is 0 by default.
> +    pub fn alloc_coherent(
> +        dev: ARef<Device>,
> +        count: usize,
> +        gfp_flags: kernel::alloc::Flags,
> +    ) -> Result<CoherentAllocation<T>> {
> +        CoherentAllocation::alloc_attrs(dev, count, gfp_flags, Attrs(0))
> +    }
> +
> +    /// Returns the device, base address, dma handle, attributes and the=
 size of the
> +    /// allocated region.
> +    ///
> +    /// The caller takes ownership of the returned resources, i.e., will=
 have the responsibility
> +    /// in calling `bindings::dma_free_attrs`. The allocated region is v=
alid as long as
> +    /// the returned device exists.
> +    pub fn into_parts(
> +        self,
> +    ) -> (
> +        ARef<Device>,
> +        *mut T,
> +        bindings::dma_addr_t,
> +        crate::ffi::c_ulong,
> +        usize,
> +    ) {
> +        let size =3D self.count * core::mem::size_of::<T>();
> +        let ret =3D (
> +            self.dev.clone(),

Calling clone here increments the refcount, but you don't want to do
that since it leaks a count.

otherwise lgtm

Alice
