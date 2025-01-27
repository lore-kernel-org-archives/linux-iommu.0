Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254F51FC0E2
	for <iommu@lists.linux.dev>; Mon, 27 Jan 2025 06:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737958599; cv=none; b=L06X1OvYM0vm2fpBImLsrnntbY/1TwCOkB6nzjvDxTBglpFSG0cFFjPrmHwpIFTuzebxYyjf8Map4LaUM4IhU6xYzGmBj974ucmsjHKtF2Dh8uAaIGwP5l8esE31+NIEUj9rW1V/nO4TQEVAMToqpzGCSP9kVXF6Qb1zLiz1GM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737958599; c=relaxed/simple;
	bh=l8mm3vkso/DxM2r/9AfApXAQEdBzma/iQnvj8NRl6lU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TSXZd3k9mH7akI4oxPVxM/N+rjccAP2efHY0I0fiyR5VQ9TlDTggtouw3PR+6jDhbErBdVwr6HMjRVMoyno3nZELWXWQGSbBroCfTZryq88Sh5EoJ/E8+BEw0DHj5DrsE1UBUyibaDFJsRmGjlbt7Oa8X4EDxSu8bWGpjPLABbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=hzne3dX+; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="hzne3dX+"
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id ADDDF217825;
	Mon, 27 Jan 2025 07:16:26 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1737958587; bh=IbnOS6w/ZaPtMjH2qcpBTcMwwAEznLpq8RP35ahPW2Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hzne3dX+QxzyhFyuQtYFri+8EzA2LsxX+qaJpwK0LTyc4N27ILJDVzyaTvvp1bRr5
	 6yynJkOSmRkuujVmaSZEHlFVR44lS3Hegth/sh91ocU14FiQWnoaHmzqjHckSMDsYb
	 ehpwh88w1vYwaUwluWwNDPR1tOlv/c5ZwEvbrv1QehW4nTR22BDgrzRy8Gb5x25Q33
	 qJfTYh5YA8ZQVTknQ2c5nEcM/79sdkUGQuFw5SyPwYXmhJbJ7KYW0oF6pa2c5vsZ3o
	 AdHhX83yimayPqDl5GmZfef8aUolAMitVXe6p12hDSI2eATC9yTY7XknvFz7bKLEmS
	 rWFiPyPPvu1Qg==
Date: Mon, 27 Jan 2025 07:16:25 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 rust-for-linux@vger.kernel.org, daniel.almeida@collabora.com,
 dakr@kernel.org, robin.murphy@arm.com, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?B?QmrDtnJu?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas
 Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Valentin Obst <kernel@valentinobst.de>, open list
 <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Marek
 Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com, "open list:DMA
 MAPPING HELPERS" <iommu@lists.linux.dev>
Subject: Re: [PATCH v11 2/3] rust: add dma coherent allocator abstraction.
Message-ID: <20250127071625.1882afa4@meshulam.tesarici.cz>
In-Reply-To: <CAH5fLgjL0aGGwkjEfXH08Jopwin1NfkLzp9vQWKcHPEum8jV4g@mail.gmail.com>
References: <20250123104333.1340512-1-abdiel.janulgue@gmail.com>
	<20250123104333.1340512-3-abdiel.janulgue@gmail.com>
	<CAH5fLgjL0aGGwkjEfXH08Jopwin1NfkLzp9vQWKcHPEum8jV4g@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 24 Jan 2025 08:27:36 +0100
Alice Ryhl <aliceryhl@google.com> wrote:

> On Thu, Jan 23, 2025 at 11:43=E2=80=AFAM Abdiel Janulgue
> <abdiel.janulgue@gmail.com> wrote:
> >
> > Add a simple dma coherent allocator rust abstraction. Based on
> > Andreas Hindborg's dma abstractions from the rnvme driver, which
> > was also based on earlier work by Wedson Almeida Filho.
> >
> > Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com> =20
>=20
> Overall I think it looks pretty good, but a follow-up from our
> discussion the other day.
>=20
> > +    /// Returns the device, base address, dma handle, attributes and t=
he size of the
> > +    /// allocated region.
> > +    ///
> > +    /// The caller takes ownership of the returned resources, i.e., wi=
ll have the responsibility
> > +    /// in calling `bindings::dma_free_attrs`. The allocated region is=
 valid as long as
> > +    /// the returned device exists.
> > +    pub fn into_parts(
> > +        self,
> > +    ) -> (
> > +        ARef<Device>,
> > +        *mut T,
> > +        bindings::dma_addr_t,
> > +        crate::ffi::c_ulong,
> > +        usize,
> > +    ) {
> > +        let size =3D self.count * core::mem::size_of::<T>();
> > +        let ret =3D (
> > +            // SAFETY: `&self.dev` is valid for reads.
> > +            unsafe { core::ptr::read(&self.dev) }, =20
>=20
> This safety comment should explain why this will not lead to
> decrementing the refcount too many times. Which is because this
> doesn't actually duplicate the ARef due to the use of mem::forget.
>=20
> That said, I think wrapping self in ManuallyDrop is slightly easier to
> read than using mem::forget. I refer you to this pattern from Tokio
> that solves a similar problem:
> https://github.com/tokio-rs/tokio/blob/ee19b0ed7371b069112b9c9ef9280b81f3=
438d26/tokio/src/sync/rwlock/owned_write_guard.rs#L38-L51
>=20
> > +            self.cpu_addr,
> > +            self.dma_handle,
> > +            self.dma_attrs.as_raw(), =20
>=20
> Why not return the Attrs type instead of an integer?
>=20
> > +            size,
> > +        );
> > +        core::mem::forget(self);
> > +        ret
> > +    } =20
>=20
> > +    /// Reads data from the region starting from `offset` as a slice.
> > +    /// `offset` and `count` are in units of `T`, not the number of by=
tes.
> > +    ///
> > +    /// Due to the safety requirements of slice, the data returned sho=
uld be regarded by the
> > +    /// caller as a snapshot of the region when this function is calle=
d, as the region could
> > +    /// be modified by the device at anytime. For ringbuffer type of r=
/w access or use-cases
> > +    /// where the pointer to the live data is needed, `start_ptr()` or=
 `start_ptr_mut()`
> > +    /// could be used instead.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// Callers must ensure that no hardware operations that involve t=
he buffer are currently
> > +    /// taking place while the returned slice is live.
> > +    pub unsafe fn as_slice(&self, offset: usize, count: usize) -> Resu=
lt<&[T]> { =20
>=20
> You were asked to rename this function because it returns a slice, but
> I wonder if it's better to take an `&mut [T]` argument and to have
> this function copy data into that argument. That way, we could make
> the function itself safe. Perhaps the actual copy needs to be
> volatile?
>=20
> Well ... I understand that we did this previously and that we want to
> avoid it because it causes too much reading if T is a struct and we
> just want to read one of its fields. How about an API like this?
>=20
> dma_read!(my_alloc[7].foo)
>=20
> which expands to something that reads the value of the foo field of
> the 7th element, and
>=20
> dma_write!(my_alloc[7].foo =3D 13);
>=20
> That expands to something that writes 13 to field foo of the 7th element.
>=20
> Thoughts? I'm proposing this to avoid going in circles between the
> same solutions.

I don't have a strong opinion, but maybe you could elaborate a bit on
what exactly you dislike about as_slice() / as_slice_mut().

Petr T
