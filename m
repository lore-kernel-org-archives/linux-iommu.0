Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4711E17DFF3
	for <iommu@lists.linux.dev>; Fri, 20 Sep 2024 17:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726854508; cv=none; b=VAbu9haPfHKDJeMscxaM4QosQMqyQwjO/nsAxTMDiHeK0WQFrZSOFR4MRaZ69FPKyxJ8ke9sdSRXOjnRdRUl1yvjwWIPgGNy7dORXhYuJJWINODybSO/wR4LaHeNGdSx6/ObQoOMLZ4GGIp8iEMVcm36Kc+uvoWsJ0E4ZKiRn7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726854508; c=relaxed/simple;
	bh=aWwPpZHzSlJfNdq3P5TS6avS7q24zoecm9lrazbcwBs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oMY1AyKvdb8li19XqM0s+CyiIMVZDo0QKdaOUrcQqSSa23BCOZz9w4poISCt9kgmPKGTwLNqSsHoDRPdaoWZwKEBRM6CFUCXpINmQmRb6XhGEovYzcrdCtPiU+gXOYRm45WNcZwQLxaYSeXtZJFpONLnVUXvA04/rFppERwwXiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=cK9WSfKF; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="cK9WSfKF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1726854506;
	bh=kj+DQMcZ1/5V7o0qstx3IiSUxd57rjtEsml9nY2PzME=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=cK9WSfKFZ11IvTeOGu56wfHqnoqfDd8ehNGEj3hTuFJUJiMDQAUlfCyLSAgirBCfp
	 RZ6YsGeqTaiYfabHLmg++lQx/O6lagcm/LVoAS3drJ5Bz8G9BcpcQ8GbKsSeLXjzk0
	 bIJike5iQIi/c/bzGsOHsCDln9DUFOwNr3334VOc=
Received: from [IPv6:240e:358:11d4:4800:dc73:854d:832e:6] (unknown [IPv6:240e:358:11d4:4800:dc73:854d:832e:6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 910CB66D2C;
	Fri, 20 Sep 2024 13:48:24 -0400 (EDT)
Message-ID: <9e2388993a63cfbb7f48e847852d308dee850109.camel@xry111.site>
Subject: Re: [GIT PULL] dma-mapping updates for Linux 6.12
From: Xi Ruoyao <xry111@xry111.site>
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Date: Sat, 21 Sep 2024 01:48:20 +0800
In-Reply-To: <19e4bdbcda78ace200c78c56eb7173097337b921.camel@xry111.site>
References: <ZuvYnXzbM2qfXQPT@infradead.org>
		 <971fbb889da38ca4e60f3dedde29ea43e9338d68.camel@xry111.site>
		 <Zu1byUGU832iWBUp@infradead.org> <Zu2Bd50GdSxF_-eA@infradead.org>
	 <19e4bdbcda78ace200c78c56eb7173097337b921.camel@xry111.site>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0 
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Sat, 2024-09-21 at 01:15 +0800, Xi Ruoyao wrote:
> On Fri, 2024-09-20 at 07:06 -0700, Christoph Hellwig wrote:
> > On Fri, Sep 20, 2024 at 04:26:01AM -0700, Christoph Hellwig wrote:
> > > On Fri, Sep 20, 2024 at 05:41:51AM +0800, Xi Ruoyao wrote:
> > > > This breaks using my laptop camera with gstreamer (with "gst-
> > > > launch-1.0
> > > > v4l2src ! videoconvert ! autovideosink" or GNOME snapshot).
> > >=20
> > > What camere and driver are you using?
>=20
> Bus 003 Device 003: ID 0c45:6366 Microdia Webcam Vitade AF
>=20
> The driver is uvcvideo.

And I just borrowed a different camera:

Bus 003 Device 010: ID 1bcf:2283 Sunplus Innovation Technology Inc. FULL HD=
 webcam

It suffers the same issue so it's unlikely to be related to a specific
camera model.  This camera is also driven by uvcvideo.

v4l2gl from v4l-utils-1.28.1 suffers the issue either, so it's unlikely
to be related to a specific userspace v4l2 program too.

> > And what architecture and platform are you on?=20
>=20
> A x86_64 laptop (with Core i5-11300H CPU).
>=20

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
