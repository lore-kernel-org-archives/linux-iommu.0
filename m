Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12E6324703
	for <iommu@lists.linux.dev>; Fri, 19 Dec 2025 11:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766144594; cv=none; b=H4+E5hK91+lXt38fMJ9EruDe3AaQkXXHaYfy5gKDnyIu3oUQ3XJk6uDopA/LKWR5FIZ0wQeytoMmN2PblG4qwoHA7ygGL61wOpHM/T4KsqXa6DqEFhg7pxs4rX/zNoZ576nH6sJDTymnuYmqZEq5cx5VsqcEwungbMA4ryIhnQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766144594; c=relaxed/simple;
	bh=oGbuUqS2jxVUU4XMsigTRyHeJjXOinYBUJLPzNiDMdw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YSUc5TuhChVsOoOrv/wnJ33SBXRkgn7xAC/aNv2baowFPHXxlBaw69FAMpmAEgmQs+Iu/q7OfckStX5KrNGhpp+/MR9fVS/Ag8h4O3zVJeX5Q3MXoDht4QA19MGoUUuZi9v4GDTZt6jNy1Szr5szuHOMHcW1VWyKaODY5wcnNac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S+kiUoOJ; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S+kiUoOJ"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-477b8a667bcso20093305e9.2
        for <iommu@lists.linux.dev>; Fri, 19 Dec 2025 03:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766144589; x=1766749389; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HgOuhXFb6asuFtmyA1DS3ttJfuOKyeiapeN5mpH9fMU=;
        b=S+kiUoOJtMWpte7aJ929UPS+SFvmKrHBfPOqqpBaZTgvQy8EJHaWuvK381/v6hPMSZ
         /3EztebgrZM+HoUqjW645tqVrUznwKnRDiTL4rl9Uf6AnERpJTsnP76CGnTxAMAnQd69
         XnpYditmcpskSCZaSRkOz45zPPdWVoN4LHiKib/jIvJ1OidIfyr1s71PJbbocHUlrtIB
         nxo4J491esTTAI8vptw3ZQZDVpciBWLrORUek6LH8Ba038jGhjl6AWNaJmm3nMC8qNt5
         4EcuOkyk349HuSWNAiY0LBMsgKMpWvUnHCdxWmKKWsD2SLVCKfty0E8bawnBQw+tD0ty
         CmHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766144589; x=1766749389;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HgOuhXFb6asuFtmyA1DS3ttJfuOKyeiapeN5mpH9fMU=;
        b=O3bjP63GxHx6JgSdIAZ8wiyl9mwHjMFZeR4kXRxG+KLrOWIsYUiQLlrktOO8U6YyxL
         4NuNcrG/jfEOES6zZNe7gmXIXqnFpXR0iKzQO7Uph61Ln0UX48LJIxJxP/ks5dUcV/4e
         F1XhCgOdBWOO6cOsOozkDtkgIyPE9BaFv5LEUDO3ZqR7sVG0ktxIse1l7XBhDfnO5mW5
         BoJ5zSCg1LUVu7ra/KorGSKP7gWGyo0H9YBKsGQndDQAuHyVNmwBUSza8E5LF7Zj1yDw
         X6q13VNuhW1Vl37AVWyoKCYNwonA0RGN+50yoBolwYArcKTGrISDKhq2Y7aqCwQosFNE
         OPow==
X-Forwarded-Encrypted: i=1; AJvYcCV/wdwbFCUse1YkWvl2xl6sS3QxcRh/GI1z8pCHuAgArlwo6tzsiuPPT7uL6s+hJdeaACB+MA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwKox3/yxMFC/xiqvcYKtLjcvL2DZvxqVLKu96ayF1rAwP2PX4y
	te/85AJ17yrnoYqVWTgUeQY3gObHUM/yuT/jnfrvf6xPGdCSFA6hths5fXUMqqA2lAaC0n+LMad
	yggcb/AjakuL7RXM0dg==
X-Google-Smtp-Source: AGHT+IHprtxZfJiX2ZTaI0JdAojBb71DA2tCdz167jCwg+T/Tn5dVzLQg5Aj76IcKhmIc5GQV60E6z/fc8k1Pj0=
X-Received: from wmoo20.prod.google.com ([2002:a05:600d:114:b0:47a:9f70:c329])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:524f:b0:477:b642:9dc1 with SMTP id 5b1f17b1804b1-47d19594b2emr19835145e9.20.1766144588812;
 Fri, 19 Dec 2025 03:43:08 -0800 (PST)
Date: Fri, 19 Dec 2025 11:43:07 +0000
In-Reply-To: <63063977-BA16-4F00-AFBA-8DD6409902E1@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251219-io-pgtable-v4-1-68aaa7a40380@google.com> <63063977-BA16-4F00-AFBA-8DD6409902E1@collabora.com>
Message-ID: <aUU6SwJjch1R56t3@google.com>
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

On Fri, Dec 19, 2025 at 08:04:17AM -0300, Daniel Almeida wrote:
> Hi Alice,
>=20
> > On 19 Dec 2025, at 07:50, Alice Ryhl <aliceryhl@google.com> wrote:
> >=20
> > From: Asahi Lina <lina+kernel@asahilina.net>
> >=20
> > This will be used by the Tyr driver to create and modify the page table
> > of each address space on the GPU. Each time a mapping gets created or
> > removed by userspace, Tyr will call into GPUVM, which will figure out
> > which calls to map_pages and unmap_pages are required to map the data i=
n
> > question in the page table so that the GPU may access those pages when
> > using that address space.
> >=20
> > The Rust type wraps the struct using a raw pointer rather than the usua=
l
> > Opaque+ARef approach because Opaque+ARef requires the target type to be
> > refcounted.
> >=20
> > Signed-off-by: Asahi Lina <lina+kernel@asahilina.net>
> > Acked-by: Boris Brezillon <boris.brezillon@collabora.com>
> > Co-developed-by: Alice Ryhl <aliceryhl@google.com>
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>

> > +/// An io page table using a specific format.
> > +///
> > +/// # Invariants
> > +///
> > +/// The pointer references a valid io page table.
> > +pub struct IoPageTable<F: IoPageTableFmt> {
> > +    ptr: NonNull<bindings::io_pgtable_ops>,
> > +    _marker: PhantomData<F>,
> > +}
> > +
> > +// SAFETY: `struct io_pgtable_ops` is not restricted to a single threa=
d.
> > +unsafe impl<F: IoPageTableFmt> Send for IoPageTable<F> {}
> > +// SAFETY: `struct io_pgtable_ops` may be accessed concurrently.
> > +unsafe impl<F: IoPageTableFmt> Sync for IoPageTable<F> {}
> > +
> > +/// The format used by this page table.
> > +pub trait IoPageTableFmt: 'static {
> > +    /// The value representing this format.
> > +    const FORMAT: io_pgtable_fmt;
> > +}
> > +
> > +impl<F: IoPageTableFmt> IoPageTable<F> {
>=20
> I don=E2=80=99t see a reason to keep struct Foo and impl Foo separate.
>=20
> IMHO, these should always be together, as the first thing one wants
> to read after a type declaration is its implementation.

I thought it was pretty natural like this. First we describe the page
table, then we say it's thread safe, then we describe that a page table
must specify a FORMAT, then we describe that it has a constructor,
then we say you can map pages, etc. etc.

> > +    /// Create a new `IoPageTable` as a device resource.
> > +    #[inline]
> > +    pub fn new(
> > +        dev: &Device<Bound>,
> > +        config: Config,
> > +    ) -> impl PinInit<Devres<IoPageTable<F>>, Error> + '_ {
> > +        // SAFETY: Devres ensures that the value is dropped during dev=
ice unbind.
> > +        Devres::new(dev, unsafe { Self::new_raw(dev, config) })
> > +    }
> > +
> > +    /// Create a new `IoPageTable`.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// If successful, then the returned value must be dropped before =
the device is unbound.
> > +    #[inline]
> > +    pub unsafe fn new_raw(dev: &Device<Bound>, config: Config) -> Resu=
lt<IoPageTable<F>> {
> > +        let mut raw_cfg =3D bindings::io_pgtable_cfg {
> > +            quirks: config.quirks,
> > +            pgsize_bitmap: config.pgsize_bitmap,
> > +            ias: config.ias,
> > +            oas: config.oas,
> > +            coherent_walk: config.coherent_walk,
> > +            tlb: &raw const NOOP_FLUSH_OPS,
> > +            iommu_dev: dev.as_raw(),
> > +            // SAFETY: All zeroes is a valid value for `struct io_pgta=
ble_cfg`.
> > +            ..unsafe { core::mem::zeroed() }
> > +        };
> > +
> > +        // SAFETY:
> > +        // * The raw_cfg pointer is valid for the duration of this cal=
l.
> > +        // * The provided `FLUSH_OPS` contains valid function pointers=
 that accept a null pointer
> > +        //   as cookie.
> > +        // * The caller ensures that the io pgtable does not outlive t=
he device.
>=20
> We should probably tailor the sentence above for Devres?

Maybe "does not outlive device unbind" is better worded, but not sure
what you're looking for with Devres tailoring.

> > +        let ops =3D unsafe {
> > +            bindings::alloc_io_pgtable_ops(F::FORMAT, &mut raw_cfg, co=
re::ptr::null_mut())
> > +        };
>=20
> I=E2=80=99d add a blank here.
>=20
> > +impl<F: IoPageTableFmt> Drop for IoPageTable<F> {
> > +    fn drop(&mut self) {
> > +        // SAFETY: The caller of `ttbr` promised that the page table i=
s not live when this
> > +        // destructor runs.
>=20
>=20
> Not sure I understand this sentence. Perhaps we should remove the word =
=E2=80=9Cttbr=E2=80=9D from here? ttbr is a register.

ttbr is a method defined below with a safety requirement.

Alice
