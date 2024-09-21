Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB36413DDB9
	for <iommu@lists.linux.dev>; Sat, 21 Sep 2024 07:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726905386; cv=none; b=Y51PgKZ94GfgvlTPjUtd96buTskIx398QukfIItKOoiMLYT+KQgRhWFLicUJuuyz61qQJQnVVX+Ji/DdVl5vFnBgVx60TYl0w9L72Ert57zch4gb0GRGbSzCyz/rcS0MsBtTwNJtXHEUAXbKdyyjC6EDIuZuJ3HYvY70b9oeAII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726905386; c=relaxed/simple;
	bh=IA+wM59KgilMHvG0jWyMMct10R/+PHODryPdpvVdz6M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RsXhgV3qhQ8L0bLfOhR7C0AqBxDtuPj9/H0q10GJbafmuwDEHwiYEcQ85SASqXgSBYXIJp5pjAkHkyjmPe0p7jMBbVrLnWN83GgIfGmK0T5HTX12Zf8WY0iiX2aP3acs0aXaq/1So/rnR3+1AtSETDiR9wJheVv1v9R5z9y0gQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=Vf5j3SRr; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="Vf5j3SRr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1726905377;
	bh=jAkLGM/lyQa3sExpXVoRFmK9scx17Ch6bL+pFETgyVc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Vf5j3SRrEJpHEbslAe92R4BsVoYXO9hJyRUW3CiyUiuDXer45bpVeRDumX2bCFG66
	 rloLnkAKqOBuTb31U/NDDIycokLbTMnlOO16q8j4oSVIwM0XckpDvUSphs3NE15JU7
	 BZSPsrKpLsWpsH3/rYrSVPt0k4QkNdyzNM6/Mn3A=
Received: from [IPv6:240e:358:11d4:4800:dc73:854d:832e:6] (unknown [IPv6:240e:358:11d4:4800:dc73:854d:832e:6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 725271A4029;
	Sat, 21 Sep 2024 03:56:15 -0400 (EDT)
Message-ID: <9a84a7c6f943209cc87a54075ed22df37ebda5f8.camel@xry111.site>
Subject: Re: [GIT PULL] dma-mapping updates for Linux 6.12
From: Xi Ruoyao <xry111@xry111.site>
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Date: Sat, 21 Sep 2024 15:56:11 +0800
In-Reply-To: <Zu5VoW1ZkViSOws3@infradead.org>
References: <ZuvYnXzbM2qfXQPT@infradead.org>
	 <971fbb889da38ca4e60f3dedde29ea43e9338d68.camel@xry111.site>
	 <Zu1byUGU832iWBUp@infradead.org> <Zu2Bd50GdSxF_-eA@infradead.org>
	 <19e4bdbcda78ace200c78c56eb7173097337b921.camel@xry111.site>
	 <Zu5VoW1ZkViSOws3@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0 
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Fri, 2024-09-20 at 22:12 -0700, Christoph Hellwig wrote:
> On Sat, Sep 21, 2024 at 01:15:43AM +0800, Xi Ruoyao wrote:
> > > > What camere and driver are you using?
> >=20
> > Bus 003 Device 003: ID 0c45:6366 Microdia Webcam Vitade AF
> >=20
> > The driver is uvcvideo.
> >=20
> > > And what architecture and platform are you on?=20
> >=20
> > A x86_64 laptop (with Core i5-11300H CPU).
>=20
> Oh, so it's not arm64, which has the most juicy changes this time
> around.
>=20
> Can you try the following "manual bisect" for me?
>=20
> First test f69e342eec008e1bab772d3963c3dd9979293e13 to see if that
> works.=C2=A0 If it doesn't work come back as I'm a bit lost :)

Yes it works (kernel boots fine and camera works fine).

> If it does work, try b5c58b2fdc427e7958412ecb2de2804a1f7c1572 next,
> if it doesn't work can you send me your dmesg?

It behaves completely erratically on boot.  I cannot get a full log
because the laptop has no serial output.  And the behavior seems not
deterministic.  I have some transcript of messages I photoed in several
boot attempts though:

Oops: general protection fault, probably non-canonical address 0xf5c1150c09=
0c1cc1: 0000 [#1] PREEMPT SMP

BUG: kernel NULL pointer dereference, address: 0000000000000078

BUG: Bad page map in process systemd-journal pte:150000000b pmd:1641dc067


--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
