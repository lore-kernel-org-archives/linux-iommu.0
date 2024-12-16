Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85E7A937
	for <iommu@lists.linux.dev>; Mon, 16 Dec 2024 11:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734346859; cv=pass; b=UYi6HhBwt+d9r8HP1FEmHvGTm29z8LJOU4CqYxL5fL2d0ybFZeqAHNwtfwgRkAihQDBIDYxj8RELZpqNm3CgI+GtJI1lEgs8MgaFqsI8G4VoM3765RG/HiN8bv2ZkTzB3V1SoeuxBOu1hyCCKwBsL8YcuZe5jGmUfYp2VV/mohw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734346859; c=relaxed/simple;
	bh=5xkg+XoFQcDR4Nj5bHPQrnGb3VP3GtQKKAKjk8PtFws=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=DDu5+qreSZOWSgsj9KM3v0F4MMZqYnhfTC0gbkPc6SdhDQDCrGUh6TgtAuvEF4mei6niSAxmnpx0WhYyehdTubcQoEFnVud4KPh9cox4k0695xo4b3mitFGKpkoD2jXHuq23RK6Vy9sjOolpXu35XpMnZHUc9l36WZPTgzC1Sxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=GqN/uwg3; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="GqN/uwg3"
ARC-Seal: i=1; a=rsa-sha256; t=1734346843; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZYlP6MkXJQuAGqB7M8bxK2G2Y66dw7Bvj7yYva62rvYea6pvky/lzA8j3sP1OPEGbVQh0IGDLFlsbN32P8aOocQSXCQPqb8eWwY5vAcAmLoxYKdQSR7U6TrQsxeO8lwmWzVwwi7u8XeBymdtSEB1SHl/W+w5K5ueQrCPCycOX/Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1734346843; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=piuy8bLoj7Ex+dtJ8kT5C+iCAk/X82mSA3N2sYjnfsU=; 
	b=Gg4/pW8w9jW0ITFKHB/NbHRbkJrtVM6fRus1tQREAbwbSkK6rQpcsYW6HAuEw6TveTFd98Coqh9crRsd53v6MqyebLi8vGqUkTslqodfQGde34wLKj1XCOZkUDhhen6kDAD9tKMAFZqoAah1Unt9pQzYZPZKkoT6kOYMCAv3bfs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1734346843;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=piuy8bLoj7Ex+dtJ8kT5C+iCAk/X82mSA3N2sYjnfsU=;
	b=GqN/uwg3he+FwuubtfKQyUnghKNEboQMAnLD8XaA4XHZKpEq9yr4OovirttgL0Xi
	NbprxYCNVQO1IL9P85LLC8DZlOdCFLIfwRdGQU4o1fN9MdQSpKqNeVp43rsGRbtII7I
	zloiMj583cV3QoanT4iShEDTC1GFnNusDC0v5Qb4=
Received: by mx.zohomail.com with SMTPS id 1734346841633737.7947914694015;
	Mon, 16 Dec 2024 03:00:41 -0800 (PST)
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
In-Reply-To: <f340e2c9-a794-4ea9-8b1a-53496765e769@gmail.com>
Date: Mon, 16 Dec 2024 08:00:24 -0300
Cc: Robin Murphy <robin.murphy@arm.com>,
 Alice Ryhl <aliceryhl@google.com>,
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
Message-Id: <216C2A0A-8393-47DC-9A83-0020461512BF@collabora.com>
References: <20241210221603.3174929-1-abdiel.janulgue@gmail.com>
 <20241210221603.3174929-3-abdiel.janulgue@gmail.com>
 <CAH5fLgjO-GbB85dDdxLSSWY74cUn8-Lt-yaRGkUVxb-E8YaO2Q@mail.gmail.com>
 <0F719804-2AD3-4C4E-A98C-2862295990BA@collabora.com>
 <b7130ae2-6314-41d9-bda2-d875b22463bb@arm.com>
 <263C49EB-5A5D-4DF4-B80A-A39E6CE58851@collabora.com>
 <f340e2c9-a794-4ea9-8b1a-53496765e769@gmail.com>
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
X-Mailer: Apple Mail (2.3826.200.121)
X-ZohoMailClient: External



> On 16 Dec 2024, at 07:23, Abdiel Janulgue <abdiel.janulgue@gmail.com> =
wrote:
>=20
>=20
>=20
> On 13/12/2024 21:08, Daniel Almeida wrote:
>> Hi Robin,
>>> On 13 Dec 2024, at 12:28, Robin Murphy <robin.murphy@arm.com> wrote:
>>>=20
>>> On 13/12/2024 2:47 pm, Daniel Almeida wrote:
>>> [...]
>>>>>> +    /// Returns the CPU-addressable region as a slice.
>>>>>> +    pub fn cpu_buf(&self) -> &[T]
>>>>>> +    {
>>>>>> +        // SAFETY: The pointer is valid due to type invariant on =
`CoherentAllocation` and
>>>>>> +        // is valid for reads for `self.count * size_of::<T>` =
bytes.
>>>>>> +        unsafe { core::slice::from_raw_parts(self.cpu_addr, =
self.count) }
>>>>>=20
>>>>> Immutable slices require that the data does not change while the
>>>>> reference is live. Is that the case? If so, your safety comment =
should
>>>>> explain that.
>>>>>=20
>>>>>> +    }
>>>>>> +
>>>>>> +    /// Performs the same functionality as `cpu_buf`, except =
that a mutable slice is returned.
>>>>>> +    pub fn cpu_buf_mut(&mut self) -> &mut [T]
>>>>>> +    {
>>>>>> +        // SAFETY: The pointer is valid due to type invariant on =
`CoherentAllocation` and
>>>>>> +        // is valid for reads for `self.count * size_of::<T>` =
bytes.
>>>>>> +        unsafe { core::slice::from_raw_parts_mut(self.cpu_addr, =
self.count) }
>>>>>=20
>>>>> Mutable slices require that the data is not written to *or read* =
by
>>>>> anybody else while the reference is live. Is that the case? If so,
>>>>> your safety comment should explain that.
>>>>>=20
>>>> The buffer will probably be shared between the CPU and some =
hardware device, since this is the
>>>> point of the dma mapping API.
>>>> It=E2=80=99s up to the caller to ensure that no hardware operations =
that involve the buffer are currently taking
>>>> place while the slices above are alive.
>>>=20
>>> Hmm, that sounds troublesome... the nature of coherent allocations =
is that both CPU and device may access them at any time, and you can =
definitely expect ringbuffer-style usage models where a CPU is writing =
to part of the buffer while the device is reading/writing another part, =
but also cases where a CPU needs to poll for a device write to a =
particular location.
>>>=20
>> Ok, I had based my answer on some other drivers I=E2=80=99ve worked =
on in the past where the approach I cited would work.
>> I can see it not working for what you described, though.
>> This is a bit unfortunate, because it means we are back to square =
one, i.e.: back to read() and write() functions and
>> to the bound on `Copy`. That=E2=80=99s because, no matter how you try =
to dress this, there is no way to give safe and direct access
>> to the underlying memory if you can=E2=80=99t avoid situations where =
both the CPU and the device will be accessing the memory
>> at the same time.
>=20
> This is unfortunate indeed. Thanks Alice for pointing out the =
limitations of slice.
>=20
> Btw, do we have any other concerns in going back to plain old raw =
pointers instead? i.e.,
>=20
>    pub fn read(&self, index: usize) -> Result<T> {
>        if index >=3D self.count {
>            return Err(EINVAL);
>        }
>=20
>        let ptr =3D self.cpu_addr.wrapping_add(index);
>        // SAFETY: We just checked that the index is within bounds.
>        Ok(unsafe { ptr.read() })
>    }
>=20
>    pub fn write(&self, index: usize, value: &T) -> Result
>    where
>        T: Copy,
>    {
>        if index >=3D self.count {
>            return Err(EINVAL);
>        }
>=20
>        let ptr =3D self.cpu_addr.wrapping_add(index);
>        // SAFETY: We just checked that the index is within bounds.
>        unsafe { ptr.write(*value) };
>        Ok(())
>    }
>=20
>> I guess the only improvement that could be made over the approach =
used for v2 is to at least use copy_nonoverlapping
>> instead,=20
>=20
> You mean introduce something like read_raw(dst: *mut u8,...) and =
write_raw(&self, src: *const u8,...)?


What I mean is that you don=E2=80=99t have to read (and bounds-check) a =
single index per function call.

Using copy_nonoverlapping lets you read/write multiple values with only =
a single function call and a
single check. It=E2=80=99s basically equivalent to a memcpy.


>=20
> Regards,
> Abdiel


