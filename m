Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C230B3D64
	for <iommu@lists.linux.dev>; Sun, 22 Sep 2024 06:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726988226; cv=none; b=M23NwU8vnBQMkN0VFPLrm9SzChUollMLtapKPXjHsQtCUkee9JeTGwPw5C3786dL+aaK25fP/vzxcIOJVGtKpO3+oMKiYkF8Cg+mMGG+dToaFgzUma4LZYy7+356BiZKI6uaUnGwAiqO3ppCdj8sB3Afm60tmyivL/EIqnUwmDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726988226; c=relaxed/simple;
	bh=fLH2JhS+Mxvs30aCPCSU4p0Fws3QoUZ8WOpiHW4hIy4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EaEvE7ioySkkSt73sK1ODhxVc7SJMuDXB0ARIH4+yxzk79/biXEEBQ2LswRUQo5opZk18WeH6r0F1UDePbJG2VMPJrdjC+fcgGmlW54HOmv+Z28iGvqyPHIkPL5ohLphHwWx7tonjtKsyY7991PzGJDauzM9ou9l3xlGV3tLKYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=J3WZbU3e; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="J3WZbU3e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1726988223;
	bh=fLH2JhS+Mxvs30aCPCSU4p0Fws3QoUZ8WOpiHW4hIy4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=J3WZbU3eVU2urWWzcaCEkIyCEpkhGR9Yc5OR9kCCyRqu0RrpKGhViJYcUtW5MKxfk
	 5qLRiZ29ovhLNeIFG3U+JnDBQU0+CfwgX6QWlVOzI0TzU3hWahEv4Kv7yV0XBmoxjZ
	 oMWSdfkmHUnf2j0PHo8hxtB/2XCUCJNhCxcM+c4E=
Received: from [IPv6:240e:358:118b:a200:dc73:854d:832e:2] (unknown [IPv6:240e:358:118b:a200:dc73:854d:832e:2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id B8E6E1A3FD6;
	Sun, 22 Sep 2024 02:57:01 -0400 (EDT)
Message-ID: <11368b7c0b7370aea61b3dda73e462fb70f306a7.camel@xry111.site>
Subject: Re: [GIT PULL] dma-mapping updates for Linux 6.12
From: Xi Ruoyao <xry111@xry111.site>
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Date: Sun, 22 Sep 2024 14:56:57 +0800
In-Reply-To: <Zu-kCdMau6127_vM@infradead.org>
References: <ZuvYnXzbM2qfXQPT@infradead.org>
	 <971fbb889da38ca4e60f3dedde29ea43e9338d68.camel@xry111.site>
	 <Zu1byUGU832iWBUp@infradead.org> <Zu2Bd50GdSxF_-eA@infradead.org>
	 <19e4bdbcda78ace200c78c56eb7173097337b921.camel@xry111.site>
	 <Zu5VoW1ZkViSOws3@infradead.org>
	 <9a84a7c6f943209cc87a54075ed22df37ebda5f8.camel@xry111.site>
	 <Zu7PW07FmBgs_dpI@infradead.org>
	 <38bc765eaba8a646a87ce14e1ff06f28d449fcd5.camel@xry111.site>
	 <Zu-kCdMau6127_vM@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0 
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Sat, 2024-09-21 at 21:58 -0700, Christoph Hellwig wrote:
> On Sun, Sep 22, 2024 at 01:49:35AM +0800, Xi Ruoyao wrote:
> > On Sat, 2024-09-21 at 06:51 -0700, Christoph Hellwig wrote:
> > > On Sat, Sep 21, 2024 at 03:56:11PM +0800, Xi Ruoyao wrote:
> > > > because the laptop has no serial output.=C2=A0 And the behavior see=
ms not
> > > > deterministic.=C2=A0 I have some transcript of messages I photoed i=
n several
> > > > boot attempts though:
> > >=20
> > > Can you send me the photos of the messages?=C2=A0 Probably best offli=
st
> > > as the lists don't like attachments.
> >=20
> > I've got something better: one attempt to boot
> > b5c58b2fdc427e7958412ecb2de2804a1f7c1572 succeeded and I got a dmesg
> > containing some Oops traces.
> >=20
> > The camera does *not* work.=C2=A0 And when I rebooted the system it hun=
g
> > (presumably related to these Oops).=20
>=20
> So that oops actually comes from the sounds code and looks unrelated
> to DMA.=C2=A0 I suspect that oops is what caused your crashes and thus
> messed up the DMA bisection.=C2=A0 Can you try to boot with CONFIG_SND
> disabled and see where the bisection for the video issues lands?

With SND disabled, b5c58b2fdc427e7958412ecb2de2804a1f7c1572 boots fine
(no oops), but the camera does not work.=20
f69e342eec008e1bab772d3963c3dd9979293e13 boots fine and the camera works
fine.

So the first bad commit is b5c58b2fdc427e7958412ecb2de2804a1f7c1572.


--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
