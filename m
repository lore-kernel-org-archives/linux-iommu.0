Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55961917D8
	for <iommu@lists.linux.dev>; Tue, 28 Jan 2025 10:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738059796; cv=pass; b=jS/lxByedNyAX8Vncf7KWiAMzz1J+gztFOvaXo/md4qRhDS2XiwZ+aKOcm8RH4iPO7c6bwVYQVpnC/cxGc9DBn5/SvTn/ZvB1ze4nmkG+9Od/ka3yBcMLPP8bfvT28Ld482G9JMJn9ppJbK80QFaFxiAZzhtIjQjaSVJqI/g0I8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738059796; c=relaxed/simple;
	bh=OUlEzlN8rKsfzxO3bFje5k5NF7SE7FqfKjk0K+uX7EA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=iNBC/xKdoXC/+ECLay+t08AIbYIHHi7LQASoJIZa4uitqUpe9i7ClqenjbFV4ZV/I/pRt3bToU5hu7YegdhOAUevln2UXBZGu8ZHm5zZzbsv/l1PVJiuvbwWvMBCK7aaqrAwghR0aBTmgHopR7WiMV7p4WnTSWQJXQi4P3QDvjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=ZtON5QEE; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="ZtON5QEE"
ARC-Seal: i=1; a=rsa-sha256; t=1738059778; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SBshQv91bgNHPBl637MI6poPuAtao2suvvDSb/lC3ozRQ5yJ3DfI3XtUelQcEYTNd+lY2yr4x7W7Zc7mrrgl4PNTnEXEhZ/J4lTVOGcH1s0tXwvMpZOHM0oKfzxk+gGivTXufaFaGKnKe1YP/MUFY+N3fyvZ1SjaPgzFWPaPNQA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1738059778; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=OUlEzlN8rKsfzxO3bFje5k5NF7SE7FqfKjk0K+uX7EA=; 
	b=IMc5jjs+zveduvd/4fwbDfKNqzD/d+mfNYnN2ikd/qyb8HHseIe0VawK6P3QN7N9OzOlBkgalwPbZqXPAC2Scgyp2NN0WkpgEPuFZLPFZMurDsQPUJiLhtR7DSPnzEp0Pvvq1ZVm1TJWPFQMJanolT3ebPLyDtEzs5DGsPKL+Qo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1738059778;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=OUlEzlN8rKsfzxO3bFje5k5NF7SE7FqfKjk0K+uX7EA=;
	b=ZtON5QEExXQHPfDFqfXB4RtSYH6o2FENnGXNMGidH81DZ29rCqinru2WuhXvEXru
	Dc1gRQFJ2mN/fDJhk+3+pugwWxip8NTB4+u1VS5YeAwQeAabW+OSqQvlDqI94ZW1HW/
	zfGkDoPiIz40v3PZdqdsl7rPwH9ESJgzPlqtdT4c=
Received: by mx.zohomail.com with SMTPS id 1738059771363954.1193914927703;
	Tue, 28 Jan 2025 02:22:51 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.300.87.4.3\))
Subject: Re: [PATCH v11 2/3] rust: add dma coherent allocator abstraction.
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <CAH5fLgiW6n82hMhbmJ-ynd6329mEDFX6TzxXQZaaoG47HAWWcA@mail.gmail.com>
Date: Tue, 28 Jan 2025 07:22:35 -0300
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 rust-for-linux@vger.kernel.org,
 dakr@kernel.org,
 robin.murphy@arm.com,
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
 Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 airlied@redhat.com,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <95382414-7A44-45A4-8F3F-C6D755422AD5@collabora.com>
References: <20250123104333.1340512-1-abdiel.janulgue@gmail.com>
 <20250123104333.1340512-3-abdiel.janulgue@gmail.com>
 <CAH5fLgjL0aGGwkjEfXH08Jopwin1NfkLzp9vQWKcHPEum8jV4g@mail.gmail.com>
 <0E0FC88B-95C0-4DBE-B497-AF9101BACE70@collabora.com>
 <CAH5fLgiW6n82hMhbmJ-ynd6329mEDFX6TzxXQZaaoG47HAWWcA@mail.gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
X-Mailer: Apple Mail (2.3826.300.87.4.3)
X-ZohoMailClient: External

Alice,

>=20
> The difference is exactly that - you reduce the amount of data copied
> to just the size of the field.
>=20
> Alice
>=20


Is your idea to have that *in addition* to the safe methods?

How does it work when you want to read a T at a time?

=E2=80=94 Daniel=
