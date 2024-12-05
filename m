Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D606C22144F
	for <iommu@lists.linux.dev>; Thu,  5 Dec 2024 16:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733416934; cv=pass; b=FKAleLG1Q2uKYvALcukAicz1o5jpI8IjqCOrfPuJ09yI4AETJ0UenppoXI6neMvxrQGzP69mLc20UWQrafiWN28CbjRmDuhxjC8l4XUsA43j+SRiN5pxnRu0JJ8TZwgsHpAgtZX28daeT3umIPWst4sj5lTSyAelOR98l0vYYzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733416934; c=relaxed/simple;
	bh=Sebvlj1DGyLQfsL3EI2/A4XZI8OHBF7gs2UVv0NUflU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=cwnyTrFiFuyYmHXPiDphUzlHI9ZyLWBwq4/TZI/oJlynkebmJDa2x8JaiCLCPsBwyv2at1Z8pQuJbKIOu1wvZTiyp4bhWwIH3Fd3RWcqSdi/vh3oTSpQgW+VIzA6fe+Jc5T7Ju8TbpsGj/nW5TXyYElONn9LQiiDCd1TsoxFrN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=aoXwslXK; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="aoXwslXK"
ARC-Seal: i=1; a=rsa-sha256; t=1733416917; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gBnHYjZixng/c4n712jANLnMPrdDb4BxH47HST1X1up1c8gSTkP07YOuLrX5Hm52SuEOwpHWwsXAVvRqmG8TzwInHMiouzAUFFBoWxOxWxY+vTYJOyw4lkpJgxQkc+6F580iXQOhRCQRDvWLmiMJc/o1cM7EKZ99U4uS8vLM8yg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1733416917; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=YXZddBtz/YqqPvMbZdS1nSj3D+T/w/QlmGLRpsHcPJI=; 
	b=Hbya8YRD0AWOUIN4amsBeMVYwCrS04a0cE0trsp3ENUjoZHDEBUPuU5gMy9ugcxocazjhz4Z1hAGTX6lg6ZQr9Fl2KGGd2fvMpXlkqsZUDHCDoOWaShgUfqXA+jkejADXn7ZG+2UvB11+uQAXfX9B97Gyvvp+OvOSLmLeYgiSxM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1733416917;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=YXZddBtz/YqqPvMbZdS1nSj3D+T/w/QlmGLRpsHcPJI=;
	b=aoXwslXKBKPsl8jsZHrtuiplvCOy5b9fUmi2Dek3lUDLLA5AJ63W6NlX7zCJ5yF8
	WpSWUqQfuHd8NU/z10X3NPN+tH+oDvHmh2isoIrIFkuTkpFKb0LXyl96APo4hATq9gA
	jDmj3m4zmZ8j0D9fZelvcr9vOnPoU+9dGveDLQmE=
Received: by mx.zohomail.com with SMTPS id 1733416914958643.6013597236526;
	Thu, 5 Dec 2024 08:41:54 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: [PATCH v6 2/2] rust: add dma coherent allocator abstraction.
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <c9baa4bb-81db-42ae-98be-d8cb7d57f237@gmail.com>
Date: Thu, 5 Dec 2024 13:41:38 -0300
Cc: Robin Murphy <robin.murphy@arm.com>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Valentin Obst <kernel@valentinobst.de>,
 "open list:RUST" <rust-for-linux@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 airlied@redhat.com,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F62F742D-B373-43D1-B527-9B9D3E5DB211@collabora.com>
References: <20241205113234.2021442-1-abdiel.janulgue@gmail.com>
 <20241205113234.2021442-2-abdiel.janulgue@gmail.com>
 <1c13843f-6929-4bc6-8564-0ec2d964c41d@arm.com>
 <c9baa4bb-81db-42ae-98be-d8cb7d57f237@gmail.com>
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
X-Mailer: Apple Mail (2.3826.200.121)
X-ZohoMailClient: External

Hi Abdiel,

> On 5 Dec 2024, at 11:25, Abdiel Janulgue <abdiel.janulgue@gmail.com> =
wrote:
>=20
> On 05/12/2024 15:07, Robin Murphy wrote:
>>> +    pub fn alloc_coherent(
>>> +        dev: &Device,
>>> +        count: usize,
>>> +        flags: kernel::alloc::Flags,
>> Might it be worth adding at least a placeholder type and argument for =
"attrs" as well, so there's less churn involved in coming back and =
adding it later? Or is the intention to have a separate =
dma_alloc_attrs() constructor for such users?
>=20
> It certainly is possible to include attrs in the constructor using =
Option:
> ```
>    pub fn alloc_coherent(
>        dev: &Device,
>        count: usize,
>        flags: kernel::alloc::Flags,
>        attrs: Option<u64>,
>    ) -> Result<CoherentAllocation<T>> {
>=20
> <cut>
>        let ret =3D unsafe {
>            bindings::dma_alloc_attrs(
>                dev.as_raw(),
>                size,
>                &mut dma_handle, flags.as_raw(),
>                attrs.unwrap_or(0),
>            )
>        };
> <cut>
>    }
>=20
> ```
> So the signature of the constructor could be:
>=20
> let c =3D CoherentAllocation::alloc_coherent(dev, 4, GFP_KERNEL, =
None)?;
>=20
> Andreas, Miguel, Daniel, any thoughts?
>=20
> Regards,
> Abdiel
>=20

Instead of a raw u64, you should take inspiration from the work in the =
Alloc crate and elsewhere to define
a proper `flags` type, which you can name `attr` in this case.

=E2=80=94 Daniel



