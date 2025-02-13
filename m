Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FECD20D4E6
	for <iommu@lists.linux.dev>; Thu, 13 Feb 2025 09:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739440263; cv=pass; b=aZPzhzPAK+davsS8W1ix+gEUWqxQIZEBtJU/DqTkFbTofFPm/M/RTB5L1KeH9inOmQiOfydjgwscHo1OEeWjLZumVyPIklb54cDdps3S13CY5RMGvynXzRWqMbfOLF9t80EXb48DXBOIkPNqbp+wM826/M4b/omigYe9s2MUdnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739440263; c=relaxed/simple;
	bh=aSRyyPeM6e5hQFaheTBxy/WzU6InWEh4hO0nlSkJE6o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mzPEdYZJEsF3apH+xI5JtqMaEvNq81cjGT0Mox2xv9dWrwqI4qBkazkkf7z52yxYIrKChRAV0Mq7jW2oz6Vlcmb1igMCuc5NYHFa5lsnn+amX8aVbb6VmsbTYXIfUzCRwfWllvshENsYqwxRgyzqQgC2ICIkpSoaMvMcNxXAX68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=jSEwOGCZ; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="jSEwOGCZ"
ARC-Seal: i=1; a=rsa-sha256; t=1739440236; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cRWqjHO3xN30Cw8P6pNjxFBHiCsis+aZAywXAQQYz0GWTOzg1oiFFne67FvDzzHXxFXURB6pn6t9zRKK+0innD1DfTbe4wpQXyj08ECXCAZQEonjvmHTRwQmyjK43v+vQXRcp95/akdrW5jCorq02xdEyvArN9jJfyIcxciCJcg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739440236; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=aSRyyPeM6e5hQFaheTBxy/WzU6InWEh4hO0nlSkJE6o=; 
	b=aMuTrwZ2XVBEhcXDtMCdnSsVoVsZziE1u76i99bG7mvbsPT9lvzPSeDi+2QA0nqkLPa1D4GXwCaJsOUQQIH/qhQ8baPca8WdM/FXSr+tlzyVMJ884F3JxiwojjCNlk8ACNa5n/h2vtK+SaBLLZfi9EmWSSNVXH4SSd2l6iQw9dI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739440236;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=aSRyyPeM6e5hQFaheTBxy/WzU6InWEh4hO0nlSkJE6o=;
	b=jSEwOGCZw1I/yx2GrlRv6f9kQrS6mIJ7n6nMPE6VRODYffhsDVgZrLzBR3EGZKje
	o/FnCSuNxR1g0M44IR5Y5fqTl2HupozZDOx2YrZpECMrEGWoDERDy1cUpeL1i5s736a
	mktxmteFrD6x1efFzZ1jxYud5ZlOQNhbzpG9csJh5nPbdscUDKTTsCMOMkN6YvaWiZl
	wcZ7ggGLARF+nzr7N/lQUEvlQRbp8IkZYcxGlIxnEdRGcmPQT1B4KWyl5m//85XVCaT
	+BZWOHlEivDQWFWB/hfDVKGtOHu+w9eAzNoYuI/f/pd1Ab/recIDPshuoEgOPeyZMcE
	pQqQCE0HGw==
Received: by mx.zohomail.com with SMTPS id 1739440234709175.6616970322301;
	Thu, 13 Feb 2025 01:50:34 -0800 (PST)
Message-ID: <2e57e189de98a165e24bb0f65b2e0c9b17f51e40.camel@icenowy.me>
Subject: Re: On community influencing (was Re: [PATCH v8 2/2] rust: add dma
 coherent allocator abstraction.)
From: Icenowy Zheng <uwu@icenowy.me>
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>, Danilo Krummrich
	 <dakr@kernel.org>
Cc: Hector Martin <marcan@marcan.st>, Steven Rostedt <rostedt@goodmis.org>, 
 "Dr. Greg" <greg@enjellic.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Dave Airlie <airlied@gmail.com>, Jason
 Gunthorpe <jgg@nvidia.com>, Greg KH <gregkh@linuxfoundation.org>,
 phasta@kernel.org, Christoph Hellwig <hch@lst.de>,  Miguel Ojeda
 <miguel.ojeda.sandonis@gmail.com>, daniel.almeida@collabora.com,
 aliceryhl@google.com,  robin.murphy@arm.com,
 rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, Alex
 Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo
 <gary@garyguo.net>, Bj??rn Roy Baron <bjorn3_gh@protonmail.com>, Benno
 Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Valentin Obst <kernel@valentinobst.de>,
 open list <linux-kernel@vger.kernel.org>, Marek Szyprowski
 <m.szyprowski@samsung.com>, airlied@redhat.com, "open list:DMA MAPPING
 HELPERS" <iommu@lists.linux.dev>, DRI Development
 <dri-devel@lists.freedesktop.org>
Date: Thu, 13 Feb 2025 17:50:20 +0800
In-Reply-To: <b0efde29-248f-43f2-97bf-ab16b55af63a@gmail.com>
References: <20250131135421.GO5556@nvidia.com>
	 <2b9b75d1-eb8e-494a-b05f-59f75c92e6ae@marcan.st>
	 <Z6OzgBYZNJPr_ZD1@phenom.ffwll.local>
	 <CAPM=9tzPR9wd=3Wbjnp-T0W8-dDfGah-H3Ny52G85B+2Ev9ksA@mail.gmail.com>
	 <208e1fc3-cfc3-4a26-98c3-a48ab35bb9db@marcan.st>
	 <CAHk-=wi=ZmP2=TmHsFSUGq8vUZAOWWSK1vrJarMaOhReDRQRYQ@mail.gmail.com>
	 <20250207121638.GA7356@wind.enjellic.com>
	 <Z6bdCrgGEq8Txd-s@home.goodmis.org>
	 <1e8452ab-613a-4c85-adc0-0c4a293dbf50@marcan.st>
	 <07c447b77bdac1f8ade1f93456f853f89d4842ee.camel@icenowy.me>
	 <Z6nTxks3u-ErSalQ@cassiopeiae>
	 <d7d1fb8af8857e7ebfdea48213849ea9ba446477.camel@icenowy.me>
	 <b0efde29-248f-43f2-97bf-ab16b55af63a@gmail.com>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ZohoMailClient: External
X-ZohoMail-Owner: <2e57e189de98a165e24bb0f65b2e0c9b17f51e40.camel@icenowy.me>+zmo_0_

=E5=9C=A8 2025-02-13=E6=98=9F=E6=9C=9F=E5=9B=9B=E7=9A=84 08:41 +0200=EF=BC=
=8CAbdiel Janulgue=E5=86=99=E9=81=93=EF=BC=9A
> Hi,
>=20
> On 13/02/2025 05:49, Icenowy Zheng wrote:
> >=20
> > Sorry, but I did a fact check on this, and I found that the only
> > "reviewer" of DMA MAPPING HELPERS is Robin Murphy, he has only one
> > reply in this thread, and the reply only says "Indeed, FWIW it
> > seems
> > like the appropriate level of abstraction to me,
> > judging by the other wrappers living in rust/kernel/ already", he
> > didn't offer to be a reviewer,=20
>=20
> Robin did offer:
>=20
> https://lore.kernel.org/rust-for-linux/4956d01e-2d06-4edd-813b-9da94b4820=
69@arm.com/

Well okay it's a further thing.

