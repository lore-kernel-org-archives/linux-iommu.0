Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BBC347BBD
	for <iommu@lists.linux.dev>; Wed, 19 Nov 2025 10:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763549604; cv=none; b=fVd4HjxxI/WSB8M3lVsBikzuiUa8qk5aHipaxi47FnEFmgf3Gup9I9WD7mUQwINym6gLVF4qaZ46adM4cvkbd1+TFpraU8ntaMRpkF7VYDlrQ5RXKRgVzVag1h9IhtbJXTp2vVJsnDxuFpeOH0F/CS9uYp/Kr5674YtBYJdfi44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763549604; c=relaxed/simple;
	bh=OVN9x4WgQ9m7z3f5WptXRb3qzxmysTsrjNlqQXMZZZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KCqbZoDHcSt2sSHNAMh6ZmCH/FlCpsnWUFcq8mvSKHBJH/5EfOqUCusuOub0+PHYyCk444cXJbMezMT+GxpLg/+FTau4aV1X9GopNgups7ruYKFGUQFM69zY39bgq+NsUhrusN160i5tJP322PLOlWZ+FAa3rlPMFn1ruRMq6EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Lpm+tBdg; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Lpm+tBdg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1763549600;
	bh=OVN9x4WgQ9m7z3f5WptXRb3qzxmysTsrjNlqQXMZZZ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Lpm+tBdgrzPU5GVCnn9ToOep2ZOC7SNAXx8S0f0YKrKlSbl4YBCjr+lMYe7GaojB6
	 ZkcK4eaU1fBUOeoy594HQdhTlsMki5Mo/y2fNCH2SGgwFATTNH2EeZhzfPZw7CnAGg
	 1Y9+DPF4MTdNWXKoh4nikx8Om04kgUA9wEENT05E/UlMHTCyheEFo3mmr8mCRxMstt
	 DC6bRItrznOyDYOPfDAKOGODMOViqIQgUb9mXRnf1pngIfnUU5RN4wxG2+1UIaXc8j
	 FTWzXXYmC8W6XcQsyfbY5b/C3eruf/BfZmpA5vKoGbH1HT5OGOOY0Pw/nkGlH1ztMw
	 ufS5/OZrHyExQ==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E9EBC17E0364;
	Wed, 19 Nov 2025 11:53:19 +0100 (CET)
Date: Wed, 19 Nov 2025 11:53:16 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Will
 Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo
 <gary@garyguo.net>, =?UTF-8?B?QmrDtnJu?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, Danilo
 Krummrich <dakr@kernel.org>, Joerg Roedel <joro@8bytes.org>, Robin Murphy
 <robin.murphy@arm.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam
 R. Howlett" <Liam.Howlett@oracle.com>, Asahi Lina
 <lina+kernel@asahilina.net>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, iommu@lists.linux.dev, linux-mm@kvack.org
Subject: Re: [PATCH v3] io: add io_pgtable abstraction
Message-ID: <20251119115316.5de0239a@fedora>
In-Reply-To: <8A5C6836-992B-477A-A77C-EE0736166552@collabora.com>
References: <20251112-io-pgtable-v3-1-b00c2e6b951a@google.com>
	<8A5C6836-992B-477A-A77C-EE0736166552@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 12 Nov 2025 09:57:09 -0300
Daniel Almeida <daniel.almeida@collabora.com> wrote:

> > +    /// Unmap a range of virtually contiguous pages of the same size.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// This page table must contain a mapping at `iova` that consists=
 of exactly `pgcount` pages
> > +    /// of size `pgsize`. =20
>=20
> Same here. I don=E2=80=99t think the above is necessarily a requirement.

It's not, indeed, the returned size will tell you how much was unmapped
if there's less to unmap, or the region has holes.
