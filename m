Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937C214B972
	for <iommu@lists.linux.dev>; Fri, 20 Sep 2024 17:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726852553; cv=none; b=AfNrneEPchyb+Ziax+cvsQvCoAZlRY9SYJA++9EMBAMfcZYAbGp1bcpjrjqSkze1UjUoN9sVj3uCEL+uokQrlHJsCDn0qmxa/BhY7VyhjeqRN/pgzPfxb7IaPwol/l1wF9LAjw7YeWORhOCDaAjhltrbLaclek3qFK2Uymedtso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726852553; c=relaxed/simple;
	bh=dIzFFRxzL/UFbCYPLh5cu5+Xwnz0JM/PocDT6ll1Ydw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dq3iwXBIdnDfhuFbGOnzxQMVhfeRNZ/4T69tc8zyubBUAsHsNco3VlkSDd4mxR3ZQdPP773Cu6vdZ66/0fuzyrWwn1I30FVSh4gCc8dZkA6HkahC57lns8GZJw7/ZH6AuRfuI/D4hx4b9X6bU2pBcrE6XIv9XSw7zVIYJnwHFho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=JvRjOubg; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="JvRjOubg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1726852551;
	bh=dIzFFRxzL/UFbCYPLh5cu5+Xwnz0JM/PocDT6ll1Ydw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=JvRjOubgCMuNBBuALfXrVdR23YRepXr2TcDv3zJ/I3T7+PGpNeuWiNzBlW/xmq6fy
	 CtkmGXxO0rgtutMtyXdNx+Oa9TJurSmzlEY+33elHBOLPNmbiCPd2fLJBHgHGwvssF
	 y1tJa/KSCyPCcGOSiAkJ2sBdxSFhtinoxPQCCo00=
Received: from [IPv6:240e:358:11d4:4800:dc73:854d:832e:6] (unknown [IPv6:240e:358:11d4:4800:dc73:854d:832e:6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 60A3D66CC3;
	Fri, 20 Sep 2024 13:15:48 -0400 (EDT)
Message-ID: <19e4bdbcda78ace200c78c56eb7173097337b921.camel@xry111.site>
Subject: Re: [GIT PULL] dma-mapping updates for Linux 6.12
From: Xi Ruoyao <xry111@xry111.site>
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Date: Sat, 21 Sep 2024 01:15:43 +0800
In-Reply-To: <Zu2Bd50GdSxF_-eA@infradead.org>
References: <ZuvYnXzbM2qfXQPT@infradead.org>
	 <971fbb889da38ca4e60f3dedde29ea43e9338d68.camel@xry111.site>
	 <Zu1byUGU832iWBUp@infradead.org> <Zu2Bd50GdSxF_-eA@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0 
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Fri, 2024-09-20 at 07:06 -0700, Christoph Hellwig wrote:
> On Fri, Sep 20, 2024 at 04:26:01AM -0700, Christoph Hellwig wrote:
> > On Fri, Sep 20, 2024 at 05:41:51AM +0800, Xi Ruoyao wrote:
> > > This breaks using my laptop camera with gstreamer (with "gst-
> > > launch-1.0
> > > v4l2src ! videoconvert ! autovideosink" or GNOME snapshot).
> >=20
> > What camere and driver are you using?

Bus 003 Device 003: ID 0c45:6366 Microdia Webcam Vitade AF

The driver is uvcvideo.

> And what architecture and platform are you on?=20

A x86_64 laptop (with Core i5-11300H CPU).

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
