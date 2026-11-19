Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795094759;
	b=pZ2w3q7Ho6S9Uus6lyfT2j6c2q4zkLxCjOpCEM1T4BoKiZ1p+y9VtByoV1N8LdlqbxAE
	 g3j2UNn613sWvYrl9H0UIWlIFMW5ZcWrP0YLFTQHxCmLfV0TqYxZJJARyRdx0VOtqTESs
	 s+bAwVqxLCspeePNZamSVyj9flc2Kmrq2aqsvRpqOqgAtDjbKVuR+LJ/XRB+R7pNNat1P
	 gdsLOxXlB9EeT0Yc4RKtxpyCK4THp2unVeewoAGf0Ve5fGAhqo0s7luKbxWqhenFtjKnE
	 t5rUjR1CMa/gplK6g9H37aK/xbH+CHDnp7irgI/lmcrE2uX9GTqhVvjGZJhOuQEr9QA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795094759;
	h=DMARC-Filter:DKIM-Signature:Received:Content-Type:Mime-Version:
	 Subject:From:In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:
	 References:To:X-Mailer:X-ZohoMailClient;
	bh=pr51uze1wqLNhsetq8CpxBiZ5s6nc5Ak2O88RJm+VXU=;
	b=pD6srj+YUUWR3dFeWrE/b37s1YYiBv6NfxLDYbUIInNEl7S00UczoX8udZLM/MubN7/4
	 mbCxSK5edCHtcObX9VZXpLvT6GYCY9o1/iDtGwaQ5aIofRTrk/dj7CWlZivqkwITuq7ow
	 +UupYIUgf1CCjpKBwTLje7WaHn5pf4GjxaOoiAUHWMV9/ZPttN4OQtzNyC4tpKRGM5gEW
	 4Gksh6vqo8i2sqnIMK/K+iUsxj2htyjSJ56YHWQ27cpFjrtOyPVTVTiMVxHdfwSxDdEl3
	 DvDKHzuk2634wF/b9M4250s/iWjL6IHthC8kv7WRs5AS8WSAkYl02otTcXI9Df8LZAA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=gO5QMmtm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDE3606A324;
	Thu, 19 Nov 2026 13:25:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CDE3606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=gO5QMmtm
ARC-Seal: i=1; a=rsa-sha256; t=1795094746; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=R+k1VavXzV7QFASzYoqR/gb/1v0p254Ipn5AGs2N7S4pi0dAmxtNPkVHPj5jlMdWIrZWkGUNyKDjcuT6G468IzSkxy552rWdh528GdIP27l+/vEq/K/DFNFSgGrTmGU6MBtkToezTsz/9RwU2/judnnKKrYnskSaS3+9YcnMBGQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795094746; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=pr51uze1wqLNhsetq8CpxBiZ5s6nc5Ak2O88RJm+VXU=; 
	b=arbENZWcLogbT6Ni0iHRbgEBGV3gfk7v9Z+wb2MI0p7pjZ//g9KcI2UD5+j9YspJnSRbNbUi7MCIPLLa0WPTPr8sauQwD+Jng9FgibE4Cn7pyBUrK6XofTaXxH1QzeRBIefiQLyaZ5n8i3b/EmuSQu904lAB+BqTc5Xcjn4dk5c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: a=rsa-sha256; b=gO5QMmtmFU2qWUGkeDwL8ZDeSv0MHNz8StC0PvdxEjD7eXmZMvTKlhTpO3AKxXltEQ4CMuzmh+xeZbqXorH+geMHU/mvDIzdg7O6EXNpeEZl+SJX2Q27fLQuPEt8NjE3QeXVW2c1g/E8npSeVoNaUWjwbFy29n1B8WHWtrtpK9s=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=pr51uze1wqLNhsetq8CpxBiZ5s6nc5Ak2O88RJm+VXU=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795094743215152.64426972208537;
	Thu, 19 Nov 2026 05:25:43 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH 0/6] rust: iommu: add a paging domain abstraction
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <fe60c0bd-1ee2-4b33-8ca3-564ee08e6db5@arm.com>
Date: Thu, 19 Nov 2026 10:25:24 -0300
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
 Nicolas Dufresne <nicolas.dufresne@collabora.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Will Deacon <will@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 iommu@lists.linux.dev,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 driver-core@lists.linux.dev,
 Detlev Casanova <detlev.casanova@collabora.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CF2BE3BB-4F16-49FC-8421-B2B823BB7BB4@collabora.com>
References: <20261112-b4-iommu-domain-v1-0-c29e86788dda@collabora.com>
 <20261116193821.GC2452510@ziepe.ca>
 <3EB4C2ED-B699-4532-A562-68B78F6E29C6@collabora.com>
 <20261117202055.GA3115493@ziepe.ca>
 <b145b2ceb92c73a4fa0477d7b3895a6e3b4adf99.camel@collabora.com>
 <20261118160909.GC3115493@ziepe.ca>
 <fe60c0bd-1ee2-4b33-8ca3-564ee08e6db5@arm.com>
To: Robin Murphy <robin.murphy@arm.com>
X-Mailer: Apple Mail (2.3901.200.71.1.16)
X-ZohoMailClient: External

>=20
> I can't speak for the actual intent of the Rust drivers, but giving =
them the benefit of the doubt, none of that fearmongering should apply: =
the valid use-case is just simple time-division multiplexing.
>=20
> A =3D iommu_paging_domain_alloc(dev);
> B =3D iommu_paging_domain_alloc(dev);
> iommu_attach(dev, A);
> iommu_map(A, iova_x, virt_to_phys(X));
> dma_map(dev, X) //still needed for the underlying memory
> ... //tell dev to do the work for context A using iova_x
> dma_unmap(dev, X);
> dma_map(dev, Y);
> iommu_map(B, iova_y, virt_to_phys(Y));
> iommu_detach(dev, A);
> iommu_attach(dev, B);
> ... //do some work in context B
>=20

Yeah, this is basically exactly what we want to do..yet Jason has been
repeateadly saying you cannot call the dma api at all once you allocate =
paging
domains. So now, I am confused.

> ...and so on. The only real subtlety is that while you still need to =
make the DMA map/unmap calls as usual (for the sake of managing cache =
coherency), you only use the returned DMA address for checking =
dma_mapping_error() and the subsequent dma_unmap(); the address you give =
to the device is your own IOVA for the mapping through your unmanaged =
domain.

Yeah, exactly.

>=20
> Plus as I mentioned recently in one of those sketchy dma-buf threads, =
it's also true that at the moment, iommu-dma will still do a load of =
unnecessary work in the unattached default domain for reasons that were =
valid 5 years ago, but that now can and really should be optimised out. =
I guess I'll have to steal a day or two from what I'm supposed to be =
doing to write that patch before I get fed up of explaining it :)

Yeah, but I did some perf here, and it doesn=E2=80=99t matter much.

>=20
> Thanks,
> Robin.


