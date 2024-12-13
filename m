Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2393A18E054
	for <iommu@lists.linux.dev>; Fri, 13 Dec 2024 19:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734116947; cv=pass; b=jBt+iB2oGDQ+uFr7vmKEPUt+1pu4g9kPnRNaWNTe1gcNHojWBWpkKmfetk315MQ0yqbtRr2TGy0BYbk9gmi/Y1/WUu0D/tqiHF+wCuOyK7s93zZyAo2JNhV4PBWFdpyZ+rvdeAmBW5lfycDh/IzhVugJ9zbK+rgNAeta8uwdhg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734116947; c=relaxed/simple;
	bh=jD5UHxV6oEgWkausVvj3Lb5W06+sApxFVzCnNvpU/sc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=s8vVjWokli96PUKkaVEVHpVIWnmF9HwLv3apmgl3vL8q0laI+Wx7+gNYof57RPfzuRD0d0L9jFZZ9c/8NmaTH5U5p7jvfFMkkcHicpWS/nibr2dj7XupHcABurAwmYEfPLlSHUoX+CYuGj2YvFHUYz8b43OjvVLs2c0zwnzfACU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=kn6j4ECm; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="kn6j4ECm"
ARC-Seal: i=1; a=rsa-sha256; t=1734116931; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=QUoxdusHF2d5/Q3AKJ4csKs4kVzaRZb9XzozVlgFRswu63KzqZjo85ZDxt3mtsSR5mBXLzLuSuKLaTXqyu2v9qPQJLhsH5sq3kBEdkBOVLAO6YhcVkzyP67gxb3mWx7s7cp/NTLh3A85g1ymP4/O70UKUI9ttwLZ8eXZAupAU1E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1734116931; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=QYJpl/mguOY/+ZOvlZbQZhWNe1kTaOmWbTfP27VR/jY=; 
	b=jfj5m379wuqpJ+7b66jt/aTHqLndPYw2JWxpJgPefOof4nPYiPNmGbRcguQyGwlAQ+rhVNCGnoqc2f/F6KrC6fwnNZdhWgpnLjfMlnBBLIFqbTjA5TWOxYfqArJNrXHCnwJb1D1fZdohc82eXYdy8mNPhQWLDdLvUKoKxSk4Z74=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1734116931;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=QYJpl/mguOY/+ZOvlZbQZhWNe1kTaOmWbTfP27VR/jY=;
	b=kn6j4ECmGuzEMFRvLU4vplub9wPDMnPyqCQMqYOlNJRl4EXzCr4TBMUVoMZPLjVx
	jkw90f5nRf0U3WVbf2NHyxQTboMDXBL+endtgmngMufmrd8QE62AHuSEfqzIxasXBAq
	XHPltS+hX+Wd4nY8BG85vOZTC5pLEMGDQ0m49g38=
Received: by mx.zohomail.com with SMTPS id 1734116927987131.02626907270326;
	Fri, 13 Dec 2024 11:08:47 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: [PATCH v7 2/2] rust: add dma coherent allocator abstraction.
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <b7130ae2-6314-41d9-bda2-d875b22463bb@arm.com>
Date: Fri, 13 Dec 2024 16:08:31 -0300
Cc: Alice Ryhl <aliceryhl@google.com>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 rust-for-linux@vger.kernel.org,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Valentin Obst <kernel@valentinobst.de>,
 open list <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 airlied@redhat.com,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <263C49EB-5A5D-4DF4-B80A-A39E6CE58851@collabora.com>
References: <20241210221603.3174929-1-abdiel.janulgue@gmail.com>
 <20241210221603.3174929-3-abdiel.janulgue@gmail.com>
 <CAH5fLgjO-GbB85dDdxLSSWY74cUn8-Lt-yaRGkUVxb-E8YaO2Q@mail.gmail.com>
 <0F719804-2AD3-4C4E-A98C-2862295990BA@collabora.com>
 <b7130ae2-6314-41d9-bda2-d875b22463bb@arm.com>
To: Robin Murphy <robin.murphy@arm.com>
X-Mailer: Apple Mail (2.3826.200.121)
X-ZohoMailClient: External

Hi Robin,

> On 13 Dec 2024, at 12:28, Robin Murphy <robin.murphy@arm.com> wrote:
>=20
> On 13/12/2024 2:47 pm, Daniel Almeida wrote:
> [...]
>>>> +    /// Returns the CPU-addressable region as a slice.
>>>> +    pub fn cpu_buf(&self) -> &[T]
>>>> +    {
>>>> +        // SAFETY: The pointer is valid due to type invariant on =
`CoherentAllocation` and
>>>> +        // is valid for reads for `self.count * size_of::<T>` =
bytes.
>>>> +        unsafe { core::slice::from_raw_parts(self.cpu_addr, =
self.count) }
>>>=20
>>> Immutable slices require that the data does not change while the
>>> reference is live. Is that the case? If so, your safety comment =
should
>>> explain that.
>>>=20
>>>> +    }
>>>> +
>>>> +    /// Performs the same functionality as `cpu_buf`, except that =
a mutable slice is returned.
>>>> +    pub fn cpu_buf_mut(&mut self) -> &mut [T]
>>>> +    {
>>>> +        // SAFETY: The pointer is valid due to type invariant on =
`CoherentAllocation` and
>>>> +        // is valid for reads for `self.count * size_of::<T>` =
bytes.
>>>> +        unsafe { core::slice::from_raw_parts_mut(self.cpu_addr, =
self.count) }
>>>=20
>>> Mutable slices require that the data is not written to *or read* by
>>> anybody else while the reference is live. Is that the case? If so,
>>> your safety comment should explain that.
>>>=20
>> The buffer will probably be shared between the CPU and some hardware =
device, since this is the
>> point of the dma mapping API.
>> It=E2=80=99s up to the caller to ensure that no hardware operations =
that involve the buffer are currently taking
>> place while the slices above are alive.
>=20
> Hmm, that sounds troublesome... the nature of coherent allocations is =
that both CPU and device may access them at any time, and you can =
definitely expect ringbuffer-style usage models where a CPU is writing =
to part of the buffer while the device is reading/writing another part, =
but also cases where a CPU needs to poll for a device write to a =
particular location.
>=20

Ok, I had based my answer on some other drivers I=E2=80=99ve worked on =
in the past where the approach I cited would work.

I can see it not working for what you described, though.

This is a bit unfortunate, because it means we are back to square one, =
i.e.: back to read() and write() functions and
to the bound on `Copy`. That=E2=80=99s because, no matter how you try to =
dress this, there is no way to give safe and direct access
to the underlying memory if you can=E2=80=99t avoid situations where =
both the CPU and the device will be accessing the memory
at the same time.

I guess the only improvement that could be made over the approach used =
for v2 is to at least use copy_nonoverlapping
instead, because I assume the performance of things like:

+ /// Reads a value on a location specified by index.
+ pub fn read(&self, index: usize) -> Result<T>
+ where
+ T: Copy
+ {
+ if let Some(val) =3D self.cpu_buf().get(index) {
+ Ok(*val)
+ } else {
+ Err(EINVAL)
+ }
+ }

will be atrocious.


> Thanks,
> Robin.
>=20
>> I think that adding that as a safety requirement to `cpu_buf` and =
`cpu_buf_mut` will be sufficient.
>>>> +    }
>>>> +}
>>>> +
>>>> +impl<T: AsBytes + FromBytes> Drop for CoherentAllocation<T> {
>>>> +    fn drop(&mut self) {
>>>> +        let size =3D self.count * core::mem::size_of::<T>();
>>>> +        // SAFETY: the device, cpu address, and the dma handle is =
valid due to the
>>>> +        // type invariants on `CoherentAllocation`.
>>>> +        unsafe { bindings::dma_free_attrs(self.dev.as_raw(), size,
>>>> +                                          self.cpu_addr as _,
>>>> +                                          self.dma_handle,
>>>> +                                          =
self.dma_attrs.as_raw(),) }
>>>> +    }
>>>> +}
>>>> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
>>>> index e1065a7551a3..6e90ebf5a130 100644
>>>> --- a/rust/kernel/lib.rs
>>>> +++ b/rust/kernel/lib.rs
>>>> @@ -35,6 +35,7 @@
>>>> mod build_assert;
>>>> pub mod cred;
>>>> pub mod device;
>>>> +pub mod dma;
>>>> pub mod error;
>>>> #[cfg(CONFIG_RUST_FW_LOADER_ABSTRACTIONS)]
>>>> pub mod firmware;
>>>> =E2=80=94
>>>> 2.43.0
>> =E2=80=94 Daniel


