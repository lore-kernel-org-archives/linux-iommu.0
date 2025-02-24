Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A67414A4E9
	for <iommu@lists.linux.dev>; Mon, 24 Feb 2025 23:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740438763; cv=pass; b=qgixPPWSYMiD7LSFpCy5oui9As7o/Myurkpknjh7ZjxuGgcqcUqUFPJ7yx+Xxru83dEY2/G9zb6ElsIaXNKy31m/1eqk5klJOYCJanp8Qf14WLPq8VnrTMhuIj4Q3EGXShYw1HGEp1yQtixHdoJf1qQ6uIbyUhvkbuM9dEezsF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740438763; c=relaxed/simple;
	bh=XXWEC2LqLJIv0MKv58pUZk0CKwpxlzBRzGseoopbZqw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=JX3rwiz2EqgD+CMlO7Jc9uIkjZ57Su0wQy7VtgnAvB+RGtV+xTWKtxY3QV+9ij/+sTcbkd7NgS1fFITWPTd0eqqipI0DS7iZQBjTl0zYR/jCJDTeT3yQrksAB/MjqzgraISt+t98IM3ciy/Pc2JvF8YUOlyqgmOLwkPh3UZlnvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=HHxaMDRl; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="HHxaMDRl"
ARC-Seal: i=1; a=rsa-sha256; t=1740438745; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=PgU9Mm6RT7uuCN862cQr8qLNQ285guHKqyOoMNUV9P7h1iGWyW1SesCfskDE92aoUJjtbtfn7axNKQIU+gdNOOj0yCwRo2Qaxzl4RSQpRS+cVmx/XHLv1tRt14hYcMYbZW+f+bNVehe8w9sPK2zjeQXaRDtXbgO7tWA0/37JupI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740438745; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=bO9uZfn8SM1Jv2su8dWyJGrswvnxZaC5Z+EMWGYE4uY=; 
	b=abm72LkhKE2k+l84SADs9WnPM2jxW49yfJz1w/KJisvMvpZhCJyUBThg/2Ev52AzZ/mk30nUcR/Eeuk8UTfc4unTL9ItcWIMkGIculPplX0kCeRrHvK/q7E0MfGowgeMAZc/n1TBz5OpTqfzQMsSq7Uinvx9KLGd56F7O64O0U8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740438745;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=bO9uZfn8SM1Jv2su8dWyJGrswvnxZaC5Z+EMWGYE4uY=;
	b=HHxaMDRlmysoXNfGvP4Qgk8queEmuYFMHF0MeIe7JUf4THVo241qcT3h3mC4rAbt
	stYCQ1bRF081kb+J1Cvu7Q4LIsFLGyL7z49uxSnS4SRbVDAnyuJCN4Z0KW4nbXBvcBe
	lLx87+OwaYJRM9jZKNyhr9leWPlV3/S1CNR0f+DY=
Received: by mx.zohomail.com with SMTPS id 1740438743258548.6806747875588;
	Mon, 24 Feb 2025 15:12:23 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.300.87.4.3\))
Subject: Re: [PATCH v12 2/3] rust: add dma coherent allocator abstraction.
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <6dea7b6a-1534-47e7-94d2-d67417c3d4c1@proton.me>
Date: Mon, 24 Feb 2025 20:12:05 -0300
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 aliceryhl@google.com,
 dakr@kernel.org,
 robin.murphy@arm.com,
 rust-for-linux@vger.kernel.org,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Valentin Obst <kernel@valentinobst.de>,
 linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 airlied@redhat.com,
 iommu@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <3202F69F-397E-4BC4-8DD8-E2D4B0AB056F@collabora.com>
References: <20250224115007.2072043-1-abdiel.janulgue@gmail.com>
 <20250224115007.2072043-3-abdiel.janulgue@gmail.com>
 <6dea7b6a-1534-47e7-94d2-d67417c3d4c1@proton.me>
To: Benno Lossin <benno.lossin@proton.me>
X-Mailer: Apple Mail (2.3826.300.87.4.3)
X-ZohoMailClient: External

Hi Benno,

>> +pub struct CoherentAllocation<T: AsBytes + FromBytes> {
>> +    dev: ARef<Device>,
>> +    dma_handle: bindings::dma_addr_t,
>> +    count: usize,
>> +    cpu_addr: *mut T,
>> +    dma_attrs: Attrs,
>> +}
>> +
>> +impl<T: AsBytes + FromBytes> CoherentAllocation<T> {
>> +    /// Allocates a region of `size_of::<T> * count` of consistent =
memory.
>> +    ///
>> +    /// # Examples
>> +    ///
>> +    /// ```
>> +    /// use kernel::device::Device;
>> +    /// use kernel::dma::{attrs::*, CoherentAllocation};
>> +    ///
>> +    /// # fn test(dev: &Device) -> Result {
>> +    /// let c: CoherentAllocation<u64> =3D =
CoherentAllocation::alloc_attrs(dev.into(), 4, GFP_KERNEL,
>> +    ///                                                              =
    DMA_ATTR_NO_WARN)?;
>> +    /// # Ok::<(), Error>(()) }
>> +    /// ```
>> +    pub fn alloc_attrs(
>> +        dev: ARef<Device>,
>> +        count: usize,
>> +        gfp_flags: kernel::alloc::Flags,
>> +        dma_attrs: Attrs,
>> +    ) -> Result<CoherentAllocation<T>> {
>> +        build_assert!(
>> +            core::mem::size_of::<T>() > 0,
>> +            "It doesn't make sense for the allocated type to be a =
ZST"
>> +        );
>=20
> Is this a safety requirement? I.e. the `dma_alloc_attrs` function =
cannot
> handle a size of 0?

It doesn=E2=80=99t make any sense to have a ZST here. At the very =
minimum we want to be able to read and
write bytes using this code, or preferably some larger T if applicable. =
The region also has to be allocated and we
need a size for that too.

This was discussed in an early iteration of this patch. I think a build =
failure is warranted.

>=20
>> +    /// r/w access or use-cases where the pointer to the live data =
is needed, `start_ptr()` or
>> +    /// `start_ptr_mut()` could be used instead.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// Callers must ensure that no hardware operations that involve =
the buffer are currently
>> +    /// taking place while the returned slice is live.
>> +    pub unsafe fn as_slice(&self, offset: usize, count: usize) -> =
Result<&[T]> {
>> +        let end =3D offset.checked_add(count).ok_or(EOVERFLOW)?;
>> +        if end >=3D self.count {
>> +            return Err(EINVAL);
>> +        }
>> +        // SAFETY:
>> +        // - The pointer is valid due to type invariant on =
`CoherentAllocation`,
>> +        // we've just checked that the range and index is within =
bounds. The immutability of the
>> +        // of data is also guaranteed by the safety requirements of =
the function.
>> +        // - `offset` can't overflow since it is smaller than =
`self.count` and we've checked
>> +        // that `self.count` won't overflow early in the =
constructor.
>> +        Ok(unsafe { =
core::slice::from_raw_parts(self.cpu_addr.add(offset), count) })
>> +    }
>> +
>> +    /// Performs the same functionality as `as_slice`, except that a =
mutable slice is returned.
>> +    /// See that method for documentation and safety requirements.
>=20
> I don't think this is good documentation style. I think copy-pasting =
the
> first line and second paragraph is better.
>=20
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// It is the callers responsibility to avoid separate read and =
write accesses to the region
>> +    /// while the returned slice is live.
>=20
> This safety requirement is worded quite differently compared to the =
one
> on `as_slice`, why?

This was discussed in an earlier iteration of this patch too. If you =
call this function, you must make
sure that some hw doesn=E2=80=99t change the memory contents while the =
slice is alive.

This is device-specific. e.g.: I know that for video codecs this is =
possible. Therefore this API
can be used there.

On the other hand, some people may use the API to share ring buffers =
with the hw or even implement
some polling logic where the CPU is waiting for a given memory location =
to be written by the HW.=20

If you=E2=80=99re trying to do this, you cannot use this API, that=E2=80=99=
s what the safety requirement is about.

Although I=E2=80=99d word this differently to be honest, i.e.:

 /// It is the callers responsibility to avoid concurrent access to the =
region by the CPU and any other device
 /// while the slice is alive.

This is also needs a bit of work, but at least it makes the point =
clearer.

>=20
>> +    pub unsafe fn as_slice_mut(&self, offset: usize, count: usize) =
-> Result<&mut [T]> {
>> +        let end =3D offset.checked_add(count).ok_or(EOVERFLOW)?;
>> +        if end >=3D self.count {
>> +            return Err(EINVAL);
>> +        }
>> +        // SAFETY:
>> +        // - The pointer is valid due to type invariant on =
`CoherentAllocation`,
>> +        // we've just checked that the range and index is within =
bounds. The immutability of the
>> +        // of data is also guaranteed by the safety requirements of =
the function.
>> +        // - `offset` can't overflow since it is smaller than =
`self.count` and we've checked
>> +        // that `self.count` won't overflow early in the =
constructor.
>> +        Ok(unsafe { =
core::slice::from_raw_parts_mut(self.cpu_addr.add(offset), count) })
>> +    }
>> +
>> +    /// Writes data to the region starting from `offset`. `offset` =
is in units of `T`, not the
>> +    /// number of bytes.
>> +    ///
>> +    /// # Examples
>> +    ///
>> +    /// ```
>> +    /// # fn test(alloc: &mut kernel::dma::CoherentAllocation<u8>) =
-> Result {
>> +    /// let somedata: [u8; 4] =3D [0xf; 4];
>> +    /// let buf: &[u8] =3D &somedata;
>> +    /// alloc.write(buf, 0)?;
>> +    /// # Ok::<(), Error>(()) }
>> +    /// ```
>> +    pub fn write(&self, src: &[T], offset: usize) -> Result {
>> +        let end =3D offset.checked_add(src.len()).ok_or(EOVERFLOW)?;
>> +        if end >=3D self.count {
>> +            return Err(EINVAL);
>> +        }
>> +        // SAFETY:
>> +        // - The pointer is valid due to type invariant on =
`CoherentAllocation`
>> +        // and we've just checked that the range and index is within =
bounds.
>> +        // - `offset` can't overflow since it is smaller than =
`self.count` and we've checked
>> +        // that `self.count` won't overflow early in the =
constructor.
>> +        unsafe {
>> +            core::ptr::copy_nonoverlapping(src.as_ptr(), =
self.cpu_addr.add(offset), src.len())
>=20
> Why are there no concurrent write or read operations on `cpu_addr`?

Sorry, can you rephrase this question?

=E2=80=94 Daniel=
