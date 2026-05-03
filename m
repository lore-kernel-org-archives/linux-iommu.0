Received: from mail-106111.protonmail.ch (mail-106111.protonmail.ch [79.135.106.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE272C15BE
	for <iommu@lists.linux.dev>; Sun,  3 May 2026 18:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777832928; cv=none; b=H+XdTg1ivcpMnq6UvyJEKNu3VcEW1ruMtFsGMD1ZTFmjaSxddNJm6TIWtxLDQ2tYEJfA3OKeb2rOhbRCtLu17U1AuytnNVDFSlOLxrMHO+YcsahnzR6TllGJA6sHRClQ9U3cF1gde4euPyczE/tMc6FekeeQ5bAkVA437Om4g/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777832928; c=relaxed/simple;
	bh=VYo98G9LYQZAgchu3pErKrxjjIzFnfrk+RocwlnjPzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=si6oY4oc8ySjV40jyEkS5txUBYzzpDOoDhEQa6PZtt4LFek6YAGuQHXFM7dNwQqpCBIJ+1IfqIXBmsW6lsmUraX4bKgxpLbSpF9S/grVOa0b6WIE7VS2tK7+gfOfLM+07jqGOMVpsQSbIsyk/VkL3WfkY3WhkBKUTSd7CU8dbNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=pjlI7Tjv; arc=none smtp.client-ip=79.135.106.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="pjlI7Tjv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1777832913; x=1778092113;
	bh=o95u23FBpkLn4PXJWNFhC1YCBKZbusyxEdzbhMJ4BsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=pjlI7TjvmVAWndM7KNEvYXGtsfXsMcWVNhvRcI51A6RJBmhw3Br3YyR5YMV09xtTB
	 DdfDrg0VphLdBW7yOqz4+Co0JYlJVAlpLVV1G3Zqj1ltlHhnAKr76O+iJ/OXz5DzpE
	 hYbEN8ldOs/3aay5DKJCl01G5a0ot6/fnRSjEkCVyocHT9NBzmZGBDqMKQDrOTDLJ2
	 wNIPWyYUh0EUF86eaSLSID5PdZ2Y81LFS7hjZTVoW+sS7KaGRdMejALm+t2pDcIEuU
	 +Uy8IgIUGT4KE7HqnGv2BOVaRfd+Vkhq3akR+PwGtOwF9VAh/BXSlWvGRjEGzwP58m
	 +WLRsFCslu1DQ==
X-Pm-Submission-Id: 4g7tZP4Z6lz1DDX4
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: x@2005.tr
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Robin Murphy <robin.murphy@arm.com>,
	driver-core@lists.linux.dev,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH] rust: io: use newtype for PhysAddr
Date: Sun,  3 May 2026 21:28:26 +0300
Message-ID: <20260503182827.21492-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260503103050.200526-1-x@2005.tr>
References: <20260503103050.200526-1-x@2005.tr>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 03 May 2026 13:30:50 +0300=0D
x@2005.tr wrote:=0D
=0D
> From: Favilances Noir <favilances@proton.me>=0D
> =0D
> From: Favilances Noir <favilances@proton.me>=0D
> =0D
> Currently, `PhysAddr` is a type alias for `phys_addr_t`. This means=0D
> that physical addresses can be mixed with unrelated integer values=0D
> without Rust noticing.=0D
> =0D
> Use a transparent newtype for `PhysAddr` instead, and update the=0D
> affected call sites to perform explicit raw conversions at the FFI=0D
> boundary.=0D
> =0D
> This keeps the existing `phys_addr_t` representation while making=0D
> physical addresses distinct in Rust type checking.=0D
> =0D
> Signed-off-by: Favilances Noir <favilances@proton.me>=0D
> ---=0D
>  rust/kernel/devres.rs        |  8 +++++---=0D
>  rust/kernel/io.rs            | 30 ++++++++++++++++++++++++------=0D
>  rust/kernel/io/mem.rs        |  4 ++--=0D
>  rust/kernel/io/resource.rs   |  6 +++---=0D
>  rust/kernel/iommu/pgtable.rs |  2 +-=0D
>  5 files changed, 35 insertions(+), 15 deletions(-)=0D
> =0D
> diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs=0D
> index 9e5f93aed20c..beb3723d2519 100644=0D
> --- a/rust/kernel/devres.rs=0D
> +++ b/rust/kernel/devres.rs=0D
> @@ -85,10 +85,10 @@ struct Inner<T> {=0D
>  ///     ///=0D
>  ///     /// [`paddr`, `paddr` + `SIZE`) must be a valid MMIO region that=
 is mappable into the CPUs=0D
>  ///     /// virtual address space.=0D
> -///     unsafe fn new(paddr: usize) -> Result<Self>{=0D
> +///     unsafe fn new(paddr: PhysAddr) -> Result<Self>{=0D
>  ///         // SAFETY: By the safety requirements of this function [`pad=
dr`, `paddr` + `SIZE`) is=0D
>  ///         // valid for `ioremap`.=0D
> -///         let addr =3D unsafe { bindings::ioremap(paddr as PhysAddr, S=
IZE) };=0D
> +///         let addr =3D unsafe { bindings::ioremap(paddr.into_raw(), SI=
ZE) };=0D
>  ///         if addr.is_null() {=0D
>  ///             return Err(ENOMEM);=0D
>  ///         }=0D
> @@ -114,7 +114,9 @@ struct Inner<T> {=0D
>  /// }=0D
>  /// # fn no_run(dev: &Device<Bound>) -> Result<(), Error> {=0D
>  /// // SAFETY: Invalid usage for example purposes.=0D
> -/// let iomem =3D unsafe { IoMem::<{ core::mem::size_of::<u32>() }>::new=
(0xBAAAAAAD)? };=0D
> +/// let iomem =3D unsafe {=0D
> +///     IoMem::<{ core::mem::size_of::<u32>() }>::new(PhysAddr::from_raw=
(0xBAAAAAAD))?=0D
> +/// };=0D
>  /// let devres =3D Devres::new(dev, iomem)?;=0D
>  ///=0D
>  /// let res =3D devres.try_access().ok_or(ENXIO)?;=0D
> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs=0D
> index fcc7678fd9e3..2d55ee93caae 100644=0D
> --- a/rust/kernel/io.rs=0D
> +++ b/rust/kernel/io.rs=0D
> @@ -21,9 +21,25 @@=0D
>  =0D
>  /// Physical address type.=0D
>  ///=0D
> -/// This is a type alias to either `u32` or `u64` depending on the confi=
g option=0D
> -/// `CONFIG_PHYS_ADDR_T_64BIT`, and it can be a u64 even on 32-bit archi=
tectures.=0D
> -pub type PhysAddr =3D bindings::phys_addr_t;=0D
> +/// This wraps either `u32` or `u64` depending on the config option=0D
> +/// `CONFIG_PHYS_ADDR_T_64BIT`, and it can be a `u64` even on 32-bit arc=
hitectures.=0D
> +#[repr(transparent)]=0D
> +#[derive(Clone, Copy)]=0D
=0D
Copy and Clone seem never used, please drop them (also see [1]).=0D
=0D
[1]: https://rust-for-linux.zulipchat.com/#narrow/channel/509436-Nova/topic=
/clone.2Fcopy.20additions=0D
=0D
Regards,=0D
Onur=0D
=0D
> +pub struct PhysAddr(bindings::phys_addr_t);=0D
> +=0D
> +impl PhysAddr {=0D
> +    /// Creates a physical address from the raw C type.=0D
> +    #[inline]=0D
> +    pub const fn from_raw(value: bindings::phys_addr_t) -> Self {=0D
> +        Self(value)=0D
> +    }=0D
> +=0D
> +    /// Turns this physical address into the raw C type.=0D
> +    #[inline]=0D
> +    pub const fn into_raw(self) -> bindings::phys_addr_t {=0D
> +        self.0=0D
> +    }=0D
> +}=0D
>  =0D
>  /// Resource Size type.=0D
>  ///=0D
> @@ -101,10 +117,10 @@ pub fn maxsize(&self) -> usize {=0D
>  ///     ///=0D
>  ///     /// [`paddr`, `paddr` + `SIZE`) must be a valid MMIO region that=
 is mappable into the CPUs=0D
>  ///     /// virtual address space.=0D
> -///     unsafe fn new(paddr: usize) -> Result<Self>{=0D
> +///     unsafe fn new(paddr: PhysAddr) -> Result<Self>{=0D
>  ///         // SAFETY: By the safety requirements of this function [`pad=
dr`, `paddr` + `SIZE`) is=0D
>  ///         // valid for `ioremap`.=0D
> -///         let addr =3D unsafe { bindings::ioremap(paddr as PhysAddr, S=
IZE) };=0D
> +///         let addr =3D unsafe { bindings::ioremap(paddr.into_raw(), SI=
ZE) };=0D
>  ///         if addr.is_null() {=0D
>  ///             return Err(ENOMEM);=0D
>  ///         }=0D
> @@ -131,7 +147,9 @@ pub fn maxsize(&self) -> usize {=0D
>  ///=0D
>  ///# fn no_run() -> Result<(), Error> {=0D
>  /// // SAFETY: Invalid usage for example purposes.=0D
> -/// let iomem =3D unsafe { IoMem::<{ core::mem::size_of::<u32>() }>::new=
(0xBAAAAAAD)? };=0D
> +/// let iomem =3D unsafe {=0D
> +///     IoMem::<{ core::mem::size_of::<u32>() }>::new(PhysAddr::from_raw=
(0xBAAAAAAD))?=0D
> +/// };=0D
>  /// iomem.write32(0x42, 0x0);=0D
>  /// assert!(iomem.try_write32(0x42, 0x0).is_ok());=0D
>  /// assert!(iomem.try_write32(0x42, 0x4).is_err());=0D
> diff --git a/rust/kernel/io/mem.rs b/rust/kernel/io/mem.rs=0D
> index 7dc78d547f7a..f21f9038b297 100644=0D
> --- a/rust/kernel/io/mem.rs=0D
> +++ b/rust/kernel/io/mem.rs=0D
> @@ -254,12 +254,12 @@ fn ioremap(resource: &Resource) -> Result<Self> {=0D
>              // SAFETY:=0D
>              // - `res_start` and `size` are read from a presumably valid=
 `struct resource`.=0D
>              // - `size` is known not to be zero at this point.=0D
> -            unsafe { bindings::ioremap_np(res_start, size) }=0D
> +            unsafe { bindings::ioremap_np(res_start.into_raw(), size) }=
=0D
>          } else {=0D
>              // SAFETY:=0D
>              // - `res_start` and `size` are read from a presumably valid=
 `struct resource`.=0D
>              // - `size` is known not to be zero at this point.=0D
> -            unsafe { bindings::ioremap(res_start, size) }=0D
> +            unsafe { bindings::ioremap(res_start.into_raw(), size) }=0D
>          };=0D
>  =0D
>          if addr.is_null() {=0D
> diff --git a/rust/kernel/io/resource.rs b/rust/kernel/io/resource.rs=0D
> index b7ac9faf141d..5dda1061db68 100644=0D
> --- a/rust/kernel/io/resource.rs=0D
> +++ b/rust/kernel/io/resource.rs=0D
> @@ -58,7 +58,7 @@ fn drop(&mut self) {=0D
>          };=0D
>  =0D
>          // SAFETY: Safe as per the invariant of `Region`.=0D
> -        unsafe { release_fn(start, size) };=0D
> +        unsafe { release_fn(start.into_raw(), size) };=0D
>      }=0D
>  }=0D
>  =0D
> @@ -113,7 +113,7 @@ pub fn request_region(=0D
>          let region =3D unsafe {=0D
>              bindings::__request_region(=0D
>                  self.0.get(),=0D
> -                start,=0D
> +                start.into_raw(),=0D
>                  size,=0D
>                  name.as_char_ptr(),=0D
>                  flags.0 as c_int,=0D
> @@ -137,7 +137,7 @@ pub fn size(&self) -> ResourceSize {=0D
>      pub fn start(&self) -> PhysAddr {=0D
>          let inner =3D self.0.get();=0D
>          // SAFETY: Safe as per the invariants of `Resource`.=0D
> -        unsafe { (*inner).start }=0D
> +        PhysAddr::from_raw(unsafe { (*inner).start })=0D
>      }=0D
>  =0D
>      /// Returns the name of the resource.=0D
> diff --git a/rust/kernel/iommu/pgtable.rs b/rust/kernel/iommu/pgtable.rs=
=0D
> index c88e38fd938a..ae724ca1e8ad 100644=0D
> --- a/rust/kernel/iommu/pgtable.rs=0D
> +++ b/rust/kernel/iommu/pgtable.rs=0D
> @@ -182,7 +182,7 @@ pub unsafe fn map_pages(=0D
>              (map_pages)(=0D
>                  self.raw_ops(),=0D
>                  iova,=0D
> -                paddr,=0D
> +                paddr.into_raw(),=0D
>                  pgsize,=0D
>                  pgcount,=0D
>                  prot as i32,=0D
> -- =0D
> 2.54.0=0D
> =0D
