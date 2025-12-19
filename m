Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11255326D50
	for <iommu@lists.linux.dev>; Fri, 19 Dec 2025 11:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766145398; cv=none; b=ECXPOGyd1WiNQwItGLoovphE3dejDu/4M1BnJbJlioHBTQ7p9RBLwRlT59Ale0TaUsgTLVce0KKjag8j1sc6KTRH7s9cKaH4Kebbd4RdlS/zk3NQS/Wh6YvJr8+iEIToFxwrPGIiJ0ZrJQTMFqgwwKPAjUAT3EPtsQ3V1yLiPJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766145398; c=relaxed/simple;
	bh=xSBNng48d95mFO41RN3vYNshk9EXdKjreVgBIo1Y+O4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Stk97bvUE5oOfkC5XXUuO4fsAYxK3V1iY9AnnLfnZqM7oIRJoZFj7qIq4zmWzY/ude76jdoNkevSYTpvdmjZsWFXp0xxAefZtLFnFeA4b3y7O3LnF3pPCdbeYeEW6LqVpAhXMazh4Dl6IjMOUt6Wq0mAaoAxhdySCKUsJkskwk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wnVTbIpB; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wnVTbIpB"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-477cf2230c8so16067685e9.0
        for <iommu@lists.linux.dev>; Fri, 19 Dec 2025 03:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766145395; x=1766750195; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mkaqMA6/YRs+atfd8F6eMMGUKP5TMTio+X5wBeN5H4g=;
        b=wnVTbIpB1YKVfRHzoWCbg+XYYp5BzClQkW3gvKGUXBCQ+drGcffkL1FDhvEXrnq5bv
         Ov5EOu3d5q8d98VJ2uADarhlWntzhRhzJDYNNigpkkxeleVG53PCqSfK9XXZcS93WAkJ
         S6RcEavtFSU4+bVgwXoNX2s/0MJoQyT7GiFxzxA5sm8+VQc7k6d6rHkajG9S3ppJByx5
         t1u8ONOd1KsUBDlzut7wzZDyDb491Qe9GmTn0/xmJ4JrdnJB2B8zXUHu1L6KAJSBH8Kg
         +4gB25HmZ5qbacvijUkgCfjPOtOSeOkDVSzOl6FRQt9SOLXtgVWxtwFNUlqfkiwUHB4w
         I8gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766145395; x=1766750195;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mkaqMA6/YRs+atfd8F6eMMGUKP5TMTio+X5wBeN5H4g=;
        b=Jk5ZHwsnBRlA+XiayVixqJB+2asa0zLwBp+4aoNEP1Bioic9OJebe4lHU98BQwmYod
         svQ2Hv7Nca7wDZVo3bdO2Fyl4yoIngQMG07s1ZwsFZqo5MG6Yw/IKjx/SyALHwCntVmF
         KmAbqoG9V59o5GZ2uNUG2XdzitTsrdnnNST7kZr++LZj9xuieyLfNLmGqRTFRctvAWe/
         EelQ5HRpHxkwRn5ygYVSZwoGkJJCxgXcEITBnQmmVYtg2Rj61BLIgJeRFRPb2uuTzW2g
         TJF5XU5gL4Te3m1EG1NkQQLn+oUQ/OUPINdUsFo9qUDjObvVANaVne+Xc0xTm8T3lfcw
         fANw==
X-Forwarded-Encrypted: i=1; AJvYcCVFdHMLhRx3O6GoXJpYJNRupRPhBYimLsNJ/PhYJmJqKKvR/9blunOPbykJzsmrq/wJUMzsGA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw3hV7ZYqtryMo3H8hoG0wQcx0QflD50vAtx7HlPVpvGry6M3Er
	5RorInD36sPsc6L9VPQa2EeMiWtgMZNmmhvggVNOSTInPcibK8TvoUWorOntxKkMDqZ8S3A+nAh
	qyQQf2ZXu3PCPdIl5TA==
X-Google-Smtp-Source: AGHT+IETGgnrJ5JSkspuyQkXAkdOEEV7IhSt2kY/j3stwKIypAfgeI2VbpbJpaknM2AoreVAyy/bf4GSgKtwpYw=
X-Received: from wmdd4.prod.google.com ([2002:a05:600c:a204:b0:47a:9bff:595c])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:620d:b0:479:1b0f:dfff with SMTP id 5b1f17b1804b1-47d19549f5dmr25515775e9.10.1766145395625;
 Fri, 19 Dec 2025 03:56:35 -0800 (PST)
Date: Fri, 19 Dec 2025 11:56:34 +0000
In-Reply-To: <09296628-B3CB-42EE-9FF3-D18FCCE41335@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251219-io-pgtable-v4-1-68aaa7a40380@google.com>
 <63063977-BA16-4F00-AFBA-8DD6409902E1@collabora.com> <aUU6SwJjch1R56t3@google.com>
 <09296628-B3CB-42EE-9FF3-D18FCCE41335@collabora.com>
Message-ID: <aUU9cnJ7R2TfDerm@google.com>
Subject: Re: [PATCH v4] io: add io_pgtable abstraction
From: Alice Ryhl <aliceryhl@google.com>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Will Deacon <will@kernel.org>, 
	Boris Brezillon <boris.brezillon@collabora.com>, Robin Murphy <robin.murphy@arm.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Asahi Lina <lina+kernel@asahilina.net>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, iommu@lists.linux.dev, linux-mm@kvack.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 08:50:06AM -0300, Daniel Almeida wrote:
>=20
>=20
> > On 19 Dec 2025, at 08:43, Alice Ryhl <aliceryhl@google.com> wrote:
> >=20
> > On Fri, Dec 19, 2025 at 08:04:17AM -0300, Daniel Almeida wrote:
> >> Hi Alice,
> >>=20
> >>> On 19 Dec 2025, at 07:50, Alice Ryhl <aliceryhl@google.com> wrote:
> >>>=20
> >>> From: Asahi Lina <lina+kernel@asahilina.net>
> >>>=20
> >>> This will be used by the Tyr driver to create and modify the page tab=
le
> >>> of each address space on the GPU. Each time a mapping gets created or
> >>> removed by userspace, Tyr will call into GPUVM, which will figure out
> >>> which calls to map_pages and unmap_pages are required to map the data=
 in
> >>> question in the page table so that the GPU may access those pages whe=
n
> >>> using that address space.
> >>>=20
> >>> The Rust type wraps the struct using a raw pointer rather than the us=
ual
> >>> Opaque+ARef approach because Opaque+ARef requires the target type to =
be
> >>> refcounted.
> >>>=20
> >>> Signed-off-by: Asahi Lina <lina+kernel@asahilina.net>
> >>> Acked-by: Boris Brezillon <boris.brezillon@collabora.com>
> >>> Co-developed-by: Alice Ryhl <aliceryhl@google.com>
> >>> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> >=20
> >>> +/// An io page table using a specific format.
> >>> +///
> >>> +/// # Invariants
> >>> +///
> >>> +/// The pointer references a valid io page table.
> >>> +pub struct IoPageTable<F: IoPageTableFmt> {
> >>> +    ptr: NonNull<bindings::io_pgtable_ops>,
> >>> +    _marker: PhantomData<F>,
> >>> +}
> >>> +
> >>> +// SAFETY: `struct io_pgtable_ops` is not restricted to a single thr=
ead.
> >>> +unsafe impl<F: IoPageTableFmt> Send for IoPageTable<F> {}
> >>> +// SAFETY: `struct io_pgtable_ops` may be accessed concurrently.
> >>> +unsafe impl<F: IoPageTableFmt> Sync for IoPageTable<F> {}
> >>> +
> >>> +/// The format used by this page table.
> >>> +pub trait IoPageTableFmt: 'static {
> >>> +    /// The value representing this format.
> >>> +    const FORMAT: io_pgtable_fmt;
> >>> +}
> >>> +
> >>> +impl<F: IoPageTableFmt> IoPageTable<F> {
> >>=20
> >> I don=E2=80=99t see a reason to keep struct Foo and impl Foo separate.
> >>=20
> >> IMHO, these should always be together, as the first thing one wants
> >> to read after a type declaration is its implementation.
> >=20
> > I thought it was pretty natural like this. First we describe the page
> > table, then we say it's thread safe, then we describe that a page table
> > must specify a FORMAT, then we describe that it has a constructor,
> > then we say you can map pages, etc. etc.
>=20
> Right, this is more a personal preference thing anyways. Fine with me if =
you
> want to keep it like this.
>=20
> >=20
> >>> +    /// Create a new `IoPageTable` as a device resource.
> >>> +    #[inline]
> >>> +    pub fn new(
> >>> +        dev: &Device<Bound>,
> >>> +        config: Config,
> >>> +    ) -> impl PinInit<Devres<IoPageTable<F>>, Error> + '_ {
> >>> +        // SAFETY: Devres ensures that the value is dropped during d=
evice unbind.
> >>> +        Devres::new(dev, unsafe { Self::new_raw(dev, config) })
> >>> +    }
> >>> +
> >>> +    /// Create a new `IoPageTable`.
> >>> +    ///
> >>> +    /// # Safety
> >>> +    ///
> >>> +    /// If successful, then the returned value must be dropped befor=
e the device is unbound.
> >>> +    #[inline]
> >>> +    pub unsafe fn new_raw(dev: &Device<Bound>, config: Config) -> Re=
sult<IoPageTable<F>> {
> >>> +        let mut raw_cfg =3D bindings::io_pgtable_cfg {
> >>> +            quirks: config.quirks,
> >>> +            pgsize_bitmap: config.pgsize_bitmap,
> >>> +            ias: config.ias,
> >>> +            oas: config.oas,
> >>> +            coherent_walk: config.coherent_walk,
> >>> +            tlb: &raw const NOOP_FLUSH_OPS,
> >>> +            iommu_dev: dev.as_raw(),
> >>> +            // SAFETY: All zeroes is a valid value for `struct io_pg=
table_cfg`.
> >>> +            ..unsafe { core::mem::zeroed() }
> >>> +        };
> >>> +
> >>> +        // SAFETY:
> >>> +        // * The raw_cfg pointer is valid for the duration of this c=
all.
> >>> +        // * The provided `FLUSH_OPS` contains valid function pointe=
rs that accept a null pointer
> >>> +        //   as cookie.
> >>> +        // * The caller ensures that the io pgtable does not outlive=
 the device.
> >>=20
> >> We should probably tailor the sentence above for Devres?
> >=20
> > Maybe "does not outlive device unbind" is better worded, but not sure
> > what you're looking for with Devres tailoring.
>=20
> What about =E2=80=9CDevres ensures that the io potable does not outlive d=
evice
> unbind by revoking access=E2=80=9D, or something along these lines?

The `new_raw` method does not require the caller to use `Devres` to do
that, so it's not necessarily the case that it is Devres that ensures
this. An end-user could call `new_raw` directly and use some other
mechanism if they wish.

> >>> +        let ops =3D unsafe {
> >>> +            bindings::alloc_io_pgtable_ops(F::FORMAT, &mut raw_cfg, =
core::ptr::null_mut())
> >>> +        };
> >>=20
> >> I=E2=80=99d add a blank here.
> >>=20
> >>> +impl<F: IoPageTableFmt> Drop for IoPageTable<F> {
> >>> +    fn drop(&mut self) {
> >>> +        // SAFETY: The caller of `ttbr` promised that the page table=
 is not live when this
> >>> +        // destructor runs.
> >>=20
> >>=20
> >> Not sure I understand this sentence. Perhaps we should remove the word=
 =E2=80=9Cttbr=E2=80=9D from here? ttbr is a register.
> >=20
> > ttbr is a method defined below with a safety requirement.
>=20
> Can't we link to that then? i.e.: [`ttbr`]: Self::ttbr, or whatever the r=
ight
> syntax is. Because it=E2=80=99s more natural to think about ttbr the regi=
ster vs
> ttbr the method.

This isn't a doc comment. There's no such thing as a link in normal
comments. But I can write:

	The caller of `Self::ttbr()` promised that the ...

Alice
