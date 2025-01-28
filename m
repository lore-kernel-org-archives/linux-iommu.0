Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DEAD51C
	for <iommu@lists.linux.dev>; Tue, 28 Jan 2025 10:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738059340; cv=pass; b=lOyQOdFCH1tHHHLjAE/1Yi+uYOryBgcojtDm7UtUoWlOMxc6lZ/vKAPDKxh8OzWEOAJ4ntC3ueRRUVi90ZsxbbNFiY9QIKXYCyXWpWRb8jqcy0prMG+71nTi7G+7PWVEaNagvXBUu4+7+6Y1peCUElxf9IQe7/H1y9zYLrjfbcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738059340; c=relaxed/simple;
	bh=rSX+R2st+gbYVa2uSul/aZDry8BR9qSOpAWjcK5Y5sI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=jYHYkIuvYhyEemwjqJupWAVeyfoRZXhydBPjUverLi+Ourb7Et8OUkLuHRb9xrX4xr7E9DtyJizipw3R5nRQaubIwO2SI4R8Y3LWWJP4b4bsEKcSUJozGLoaOuLQF4Kg+0gCiaHrgfKUz5/n7504mG/0McpIiY6x6Tu59RXaiPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=TEqYdIbo; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="TEqYdIbo"
ARC-Seal: i=1; a=rsa-sha256; t=1738059319; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=g/BPC96uBss/vx6TBJomjihz1dQCdfxm6jJNAEbkV66+2cHbe+iBcjsSv1rwV4BGDZwk0ObgeVxPFoVu1pohD6WqP/nEzzaUYE4IADFwqoUjBRG99Q4d2k8C0Kb293HvaDmU+qp536D/LxsDlN+VhJ2LrLtuwSoqy5a9mnbrvkU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1738059319; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=rSX+R2st+gbYVa2uSul/aZDry8BR9qSOpAWjcK5Y5sI=; 
	b=En+jvcIzZSus6BMgzCkdbeWnii6IghHnAYKvr0W/l0xZ8xNnkbgMkosts5HpSxMKlDUePj/gaXDU0KTSKkOqBJ6sLcVh6kqI+LgpPvfitfvX1Tw2XCePiHdwdxLtwmRUj2DmqKlfrBp4FMp2/EBJUikjXfmuLJB++XO1GK0IXA0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1738059319;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=rSX+R2st+gbYVa2uSul/aZDry8BR9qSOpAWjcK5Y5sI=;
	b=TEqYdIboaJmxVmZAl5Dcxfg5bbjMXyYi+wLJ1i7zBx6G0Nz5ZIPpH3ngWbQnzazS
	4iDnDrROKy+//AEV0qUbdQhuCDiFwXbtIxmrh2nLl+El1WR++7D4N+UdvYI0uxR+n/g
	qnOGcS3D/8+A8orkfgItuXUQsV87JBrBON3A0U7c=
Received: by mx.zohomail.com with SMTPS id 1738059312965878.968649915268;
	Tue, 28 Jan 2025 02:15:12 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.300.87.4.3\))
Subject: Re: [PATCH v8 2/2] rust: add dma coherent allocator abstraction.
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <ddd6c0f6-a0da-4bf1-b9fd-9f73651b7cb0@gmail.com>
Date: Tue, 28 Jan 2025 07:14:56 -0300
Cc: Danilo Krummrich <dakr@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 aliceryhl@google.com,
 rust-for-linux@vger.kernel.org,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Valentin Obst <kernel@valentinobst.de>,
 open list <linux-kernel@vger.kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 airlied@redhat.com,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
 Greg KH <gregkh@linuxfoundation.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <16DAE79A-1D63-40D0-9329-5008BC6ABC64@collabora.com>
References: <CANiq72=R2N+QiCiHZQu-6YJ9aYpn_bik3BW3U=nAW3jL7unzLw@mail.gmail.com>
 <20250108151858.GB24499@lst.de> <Z36X_ZnCmBQBMoZ6@pollux>
 <20250109080812.GA20431@lst.de> <Z3-NqwAG_96yq8VD@pollux>
 <20250110083955.GA5395@lst.de> <Z4D5a5NYrAbNxUL6@pollux>
 <Z4kG5AcVeQKegLnb@pollux> <bbc60912-7ed5-4bb1-b273-8061abe49e10@arm.com>
 <Z4kshDHw8NEjQONR@pollux> <Z4pheSjBMOjgvk8W@phenom.ffwll.local>
 <ddd6c0f6-a0da-4bf1-b9fd-9f73651b7cb0@gmail.com>
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
X-Mailer: Apple Mail (2.3826.300.87.4.3)
X-ZohoMailClient: External



> On 17 Jan 2025, at 16:10, Abdiel Janulgue <abdiel.janulgue@gmail.com> =
wrote:
>=20
>=20
> On 17/01/2025 15:56, Simona Vetter wrote:
>> Plus this patch here is not even close to tackling
>> the sg based dma-api parts.
>=20
> The scatterlist portion of dma-api bindings are in the pipeline. The =
idea was to start upstreaming this basic component of the dma-api first.
>=20
> Regards,
> Abdiel
>=20

Oh, I just realized you=E2=80=99re working on the scatterlist stuff. =
This will indeed come in handy!

Thanks for that.

=E2=80=94 Daniel=20=
