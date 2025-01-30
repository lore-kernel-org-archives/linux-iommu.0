Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B161B4F0B
	for <iommu@lists.linux.dev>; Thu, 30 Jan 2025 13:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738244144; cv=pass; b=TjpcKEctK4HzSL/EYQGdGnKSUgOlsMJ8GQyEe6wgtA52Jw0w2TeJq0xyWET8w7T4Kg5xKpPJWWztomB5W/DDt6CHNR6uhrdISRrvweSOG0KvhHknMYpnowWCIzG/AZ23GjIDXK4IdrirXYiQQDLb2DG3V3nCil1mqRUj1lUX93M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738244144; c=relaxed/simple;
	bh=OsmosenQJyN8MZbYan5U9QG6GgMO5s6XsOCWYmEad2Q=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=O3tMNNIQaSpIVwL65APGhjduiLpQ1WR3O+cvAEDHDx7h1hMJqQtXCfkMe00NDJhlLrEW49libaPSJwkjaLxt9oeV7ItNWVCnO/WO8Gc1QFDeXusmpPlAFlfULfrQe4/aTI/XnZI/EEztKM9Z7z3XyZQ/nWt3sWrkQkna65xEKTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=IGprdlhZ; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="IGprdlhZ"
ARC-Seal: i=1; a=rsa-sha256; t=1738244123; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=n6Al7lc3JS4dSTXEs7TEpzJqgfVLEaxx6xIQC3IxB8KnZjRarFgyOZrLBbdp53DSUOUlyynJBHpTfkgHGU2FoPRKwyO8WQTLUaFw4V5Gzn4a5FcK4dfUW6AYfkbkcp4cC5FJ7zZ5YDUoy3T7dBMHbtRqBit9UOmpu/xTEJfIsKk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1738244123; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=OsmosenQJyN8MZbYan5U9QG6GgMO5s6XsOCWYmEad2Q=; 
	b=J9gN/OjkuqfYNl9AoZWmAqSUfgmswwzPUnvwbxuwI1m6imLqVaoG+gu1u28ofKyVe0dC1W5yHgFTKcoMB4x/CIwE3+Ft8oEdllPiun+6zGVCjTm8mk7G40B31VraqDBYkiUkA+PsbXWBAfaFvHT4ikJI5QueyhCDCHaPNgHCxm0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1738244123;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=OsmosenQJyN8MZbYan5U9QG6GgMO5s6XsOCWYmEad2Q=;
	b=IGprdlhZ4CFlvokdRZcllXZ6YdGYzssx4Wy8sQ91lrFGWZ6Q4FBtpG5lMezHXGGh
	ipbOu9dEaQabUh4OVmW5Ar+f/OatXnKjlwVEOHKmPCPAVcJ9MacUrJvAIOhcpp9+IjD
	ufqsnP5dXISGqvvhHvKAZTKopkSLXOOXT0YEAIrM=
Received: by mx.zohomail.com with SMTPS id 1738244116974973.7744363257904;
	Thu, 30 Jan 2025 05:35:16 -0800 (PST)
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
In-Reply-To: <293df3d54bad446e8fd527f204c6dc301354e340.camel@mailbox.org>
Date: Thu, 30 Jan 2025 10:35:00 -0300
Cc: Christoph Hellwig <hch@lst.de>,
 Danilo Krummrich <dakr@kernel.org>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 aliceryhl@google.com,
 robin.murphy@arm.com,
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
Message-Id: <F2D88DDC-DE2E-4422-9A37-951C28F23A7B@collabora.com>
References: <20250108122825.136021-3-abdiel.janulgue@gmail.com>
 <20250108135951.GA18074@lst.de>
 <CANiq72=R2N+QiCiHZQu-6YJ9aYpn_bik3BW3U=nAW3jL7unzLw@mail.gmail.com>
 <20250108151858.GB24499@lst.de> <Z36X_ZnCmBQBMoZ6@pollux>
 <20250109080812.GA20431@lst.de> <Z3-NqwAG_96yq8VD@pollux>
 <20250110083955.GA5395@lst.de> <Z4D5a5NYrAbNxUL6@pollux>
 <Z4kG5AcVeQKegLnb@pollux> <20250128092334.GA28548@lst.de>
 <293df3d54bad446e8fd527f204c6dc301354e340.camel@mailbox.org>
To: phasta@kernel.org
X-Mailer: Apple Mail (2.3826.300.87.4.3)
X-ZohoMailClient: External


>=20
> Hallo,
>=20
> would some sort of official statement by the "entire community"
> reassure you that the burden of keeping Rust abstractions working with
> any changes on the C side rests entirely on the Rust side's shoulders?
> (because that's what the statements made by the latter seem to mean to
> me)
>=20


This has been offered over and over in this thread, i.e.:


```
If you don't feel comfortable maintaining the Rust abstraction (or just =
don't
want to), that's fine. I don't think anyone expects you to do that, we =
can take
care of that instead.
```

https://lore.kernel.org/rust-for-linux/Z3-NqwAG_96yq8VD@pollux/

Communication is not the issue here.

Also, this person waited until v8 to give a single line NAK. This is not =
very nice.

=E2=80=94 Daniel=
