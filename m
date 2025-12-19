Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B323191A1
	for <iommu@lists.linux.dev>; Fri, 19 Dec 2025 11:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766145070; cv=pass; b=pxuWIciHhsk7cG1TwyH+jzgt2p2MT8M767ijMn1Sojn9TChcx8GprF3cNfgTUbhHmESdfU5YVpGwurmkdLIQjSas6MbSBe/0/MsTFvj5bWn5Dm3kaGzwFz/yQ3TRsRgicttHKm6tINQgXGX4c1OXFLt8pjyhFKzrmjrf4x5q/+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766145070; c=relaxed/simple;
	bh=JQTj+gxdLkdpkJsyFoftkmLSr+8BV3RAE+R0v/efvtU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Grtw7XQp/PJ5k4QpQVU4IlisuJJfhuyk8i4tkG6SdTLCwPBIl6HavDPWh+u9eitI8U9WyPo6csu9T/xkVT3GcqofGUuInZVFnskZ4X2oFRHte+1C8z7RzaTcMwpvH5b49lqztrOJXTPa5TBR6VK6fMn7+JjFvz0P9IXGT4M48Dw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=e1sCZCFQ; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="e1sCZCFQ"
ARC-Seal: i=1; a=rsa-sha256; t=1766145027; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Cu8gnDuELQSMuusDRGN76qpIXkD1QOTcEld66w4TBYZ9tZyrBOzFzg0LzBHEKdbYCrqRAVaO9m9mU+4eQ931NpgUthPboz6zA7wgC25DMe9JeHeeYGjV9c0y8gbJhEoFiS3LOp0tLWvVufrU/P1dU0+tSGza2CQsGy5vjL/2WDY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1766145027; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=bagxgs37dECR0fIYnnfs0GVR8oB2eKVNw7yBfChIglY=; 
	b=eOvUFWCx2879V4ntQqAAwGAIHAMypV7ve07wNyVVWOnJO9jGgkQfzMgK9C8lOgFCijFJIGltlU19SaGd06cqpbsXRFUuDOsQSdSpmIvXl3uaIp6WGV+uhP3vkbknMvnelr7+ZcN11N+CvQu4GH0ufM0FZzjaCm8xghqvfvnlM8E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1766145027;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=bagxgs37dECR0fIYnnfs0GVR8oB2eKVNw7yBfChIglY=;
	b=e1sCZCFQ4C9kUdlY/EvScjUU6DZIpBnLFijl6A8sSI//Vtaq0bNtPViF6mbTwOAH
	KVEscMiutUBdxgS32sqw9qI8gVqvEPbg7cIw71gHk+trS/k0h+GHj8YOsyJdldrEt8S
	7H358bsz6ULdO/YFV8TFzavtaH+d9zd0+mXSBU8s=
Received: by mx.zohomail.com with SMTPS id 1766145024661652.388080029692;
	Fri, 19 Dec 2025 03:50:24 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v4] io: add io_pgtable abstraction
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <aUU6SwJjch1R56t3@google.com>
Date: Fri, 19 Dec 2025 08:50:06 -0300
Cc: Miguel Ojeda <ojeda@kernel.org>,
 Will Deacon <will@kernel.org>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Joerg Roedel <joro@8bytes.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Asahi Lina <lina+kernel@asahilina.net>,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 iommu@lists.linux.dev,
 linux-mm@kvack.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <09296628-B3CB-42EE-9FF3-D18FCCE41335@collabora.com>
References: <20251219-io-pgtable-v4-1-68aaa7a40380@google.com>
 <63063977-BA16-4F00-AFBA-8DD6409902E1@collabora.com>
 <aUU6SwJjch1R56t3@google.com>
To: Alice Ryhl <aliceryhl@google.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External



> On 19 Dec 2025, at 08:43, Alice Ryhl <aliceryhl@google.com> wrote:
>=20
> On Fri, Dec 19, 2025 at 08:04:17AM -0300, Daniel Almeida wrote:
>> Hi Alice,
>>=20
>>> On 19 Dec 2025, at 07:50, Alice Ryhl <aliceryhl@google.com> wrote:
>>>=20
>>> From: Asahi Lina <lina+kernel@asahilina.net>
>>>=20
>>> This will be used by the Tyr driver to create and modify the page =
table
>>> of each address space on the GPU. Each time a mapping gets created =
or
>>> removed by userspace, Tyr will call into GPUVM, which will figure =
out
>>> which calls to map_pages and unmap_pages are required to map the =
data in
>>> question in the page table so that the GPU may access those pages =
when
>>> using that address space.
>>>=20
>>> The Rust type wraps the struct using a raw pointer rather than the =
usual
>>> Opaque+ARef approach because Opaque+ARef requires the target type to =
be
>>> refcounted.
>>>=20
>>> Signed-off-by: Asahi Lina <lina+kernel@asahilina.net>
>>> Acked-by: Boris Brezillon <boris.brezillon@collabora.com>
>>> Co-developed-by: Alice Ryhl <aliceryhl@google.com>
>>> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>=20
>>> +/// An io page table using a specific format.
>>> +///
>>> +/// # Invariants
>>> +///
>>> +/// The pointer references a valid io page table.
>>> +pub struct IoPageTable<F: IoPageTableFmt> {
>>> +    ptr: NonNull<bindings::io_pgtable_ops>,
>>> +    _marker: PhantomData<F>,
>>> +}
>>> +
>>> +// SAFETY: `struct io_pgtable_ops` is not restricted to a single =
thread.
>>> +unsafe impl<F: IoPageTableFmt> Send for IoPageTable<F> {}
>>> +// SAFETY: `struct io_pgtable_ops` may be accessed concurrently.
>>> +unsafe impl<F: IoPageTableFmt> Sync for IoPageTable<F> {}
>>> +
>>> +/// The format used by this page table.
>>> +pub trait IoPageTableFmt: 'static {
>>> +    /// The value representing this format.
>>> +    const FORMAT: io_pgtable_fmt;
>>> +}
>>> +
>>> +impl<F: IoPageTableFmt> IoPageTable<F> {
>>=20
>> I don=E2=80=99t see a reason to keep struct Foo and impl Foo =
separate.
>>=20
>> IMHO, these should always be together, as the first thing one wants
>> to read after a type declaration is its implementation.
>=20
> I thought it was pretty natural like this. First we describe the page
> table, then we say it's thread safe, then we describe that a page =
table
> must specify a FORMAT, then we describe that it has a constructor,
> then we say you can map pages, etc. etc.

Right, this is more a personal preference thing anyways. Fine with me if =
you
want to keep it like this.

>=20
>>> +    /// Create a new `IoPageTable` as a device resource.
>>> +    #[inline]
>>> +    pub fn new(
>>> +        dev: &Device<Bound>,
>>> +        config: Config,
>>> +    ) -> impl PinInit<Devres<IoPageTable<F>>, Error> + '_ {
>>> +        // SAFETY: Devres ensures that the value is dropped during =
device unbind.
>>> +        Devres::new(dev, unsafe { Self::new_raw(dev, config) })
>>> +    }
>>> +
>>> +    /// Create a new `IoPageTable`.
>>> +    ///
>>> +    /// # Safety
>>> +    ///
>>> +    /// If successful, then the returned value must be dropped =
before the device is unbound.
>>> +    #[inline]
>>> +    pub unsafe fn new_raw(dev: &Device<Bound>, config: Config) -> =
Result<IoPageTable<F>> {
>>> +        let mut raw_cfg =3D bindings::io_pgtable_cfg {
>>> +            quirks: config.quirks,
>>> +            pgsize_bitmap: config.pgsize_bitmap,
>>> +            ias: config.ias,
>>> +            oas: config.oas,
>>> +            coherent_walk: config.coherent_walk,
>>> +            tlb: &raw const NOOP_FLUSH_OPS,
>>> +            iommu_dev: dev.as_raw(),
>>> +            // SAFETY: All zeroes is a valid value for `struct =
io_pgtable_cfg`.
>>> +            ..unsafe { core::mem::zeroed() }
>>> +        };
>>> +
>>> +        // SAFETY:
>>> +        // * The raw_cfg pointer is valid for the duration of this =
call.
>>> +        // * The provided `FLUSH_OPS` contains valid function =
pointers that accept a null pointer
>>> +        //   as cookie.
>>> +        // * The caller ensures that the io pgtable does not =
outlive the device.
>>=20
>> We should probably tailor the sentence above for Devres?
>=20
> Maybe "does not outlive device unbind" is better worded, but not sure
> what you're looking for with Devres tailoring.

What about =E2=80=9CDevres ensures that the io potable does not outlive =
device
unbind by revoking access=E2=80=9D, or something along these lines?

>=20
>>> +        let ops =3D unsafe {
>>> +            bindings::alloc_io_pgtable_ops(F::FORMAT, &mut raw_cfg, =
core::ptr::null_mut())
>>> +        };
>>=20
>> I=E2=80=99d add a blank here.
>>=20
>>> +impl<F: IoPageTableFmt> Drop for IoPageTable<F> {
>>> +    fn drop(&mut self) {
>>> +        // SAFETY: The caller of `ttbr` promised that the page =
table is not live when this
>>> +        // destructor runs.
>>=20
>>=20
>> Not sure I understand this sentence. Perhaps we should remove the =
word =E2=80=9Cttbr=E2=80=9D from here? ttbr is a register.
>=20
> ttbr is a method defined below with a safety requirement.

Can't we link to that then? i.e.: [`ttbr`]: Self::ttbr, or whatever the =
right
syntax is. Because it=E2=80=99s more natural to think about ttbr the =
register vs
ttbr the method.

>=20
> Alice


