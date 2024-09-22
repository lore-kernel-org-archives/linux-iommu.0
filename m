Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FE61714DC;
	Sun, 22 Sep 2024 04:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726981136; cv=none; b=UrTTnB9rdnU/LIACgY9XS6M0/Fl3egNcN9Rvo1WN6wAYII6yq6lxDno1S0DI5/ia/HcbZkBKt0qT7z1RVrDJsCn7VVgdCyjFSjAuymjVBDkpcAClJ3iyY1a0C1nEy3dpMeMvZ1KmRAJsE//NXkZClpC1fY3i47N2Fd5d5M4+Tdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726981136; c=relaxed/simple;
	bh=YXSLY+t5FY79TwoYTLkj4tm4Eecv8wZq12EaL5qdblk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pqi16JUxsuWwyC/nk8p5YdFLo8TnKzrJ6UERuj/WPCP5lrXP4ocOC90e1wAagRJBGBh8aydIgK0DpLFFEIN7ls9ANOnYMXIsiE38Sw8cKVCDErEotviPqMpxM7mleOsYnkXz7y1J7tNf352xGBiFIyDkOGjMt+BiEzgyqzZwo9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3QqjYo4H; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3QqjYo4H"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=N2RfHzIMHib6uiU/FDsboA5V6UkKty537wvUbBdRcbI=; b=3QqjYo4H2cax8ZRWJhRojE20AL
	WPZBJCUCrR5OmbFxHR06Njpup8WdcSv611N9et6Fj+vHpqIKFxfheVuslkvbrFv2kW9iD5tmFAqUm
	J8iiGGNJ8VaGmCwgDM758xXiPeRCpDIwF9raWIgA3JPyMTTf4SDPgTyj7W55j0Cp3OVRak/9DUyr8
	WRJO2tCCuzcgm4AgEHYe8kOljWwTMBwIhFqXnquL7E2+aN/lJZhF6T+qR1N+e3fu4PvbHPJnfQyyV
	OOn2f2SKhnSMpYau1AMgbjJBFNv6Jk2VnXFEeUQG50mWnFnb8mcT+kqugFxYXNZ18X+Nkcmp8FxGy
	jbAOccQw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1ssEgL-0000000EiSq-22fH;
	Sun, 22 Sep 2024 04:58:49 +0000
Date: Sat, 21 Sep 2024 21:58:49 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Xi Ruoyao <xry111@xry111.site>
Cc: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [GIT PULL] dma-mapping updates for Linux 6.12
Message-ID: <Zu-kCdMau6127_vM@infradead.org>
References: <ZuvYnXzbM2qfXQPT@infradead.org>
 <971fbb889da38ca4e60f3dedde29ea43e9338d68.camel@xry111.site>
 <Zu1byUGU832iWBUp@infradead.org>
 <Zu2Bd50GdSxF_-eA@infradead.org>
 <19e4bdbcda78ace200c78c56eb7173097337b921.camel@xry111.site>
 <Zu5VoW1ZkViSOws3@infradead.org>
 <9a84a7c6f943209cc87a54075ed22df37ebda5f8.camel@xry111.site>
 <Zu7PW07FmBgs_dpI@infradead.org>
 <38bc765eaba8a646a87ce14e1ff06f28d449fcd5.camel@xry111.site>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <38bc765eaba8a646a87ce14e1ff06f28d449fcd5.camel@xry111.site>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sun, Sep 22, 2024 at 01:49:35AM +0800, Xi Ruoyao wrote:
> On Sat, 2024-09-21 at 06:51 -0700, Christoph Hellwig wrote:
> > On Sat, Sep 21, 2024 at 03:56:11PM +0800, Xi Ruoyao wrote:
> > > because the laptop has no serial output.  And the behavior seems not
> > > deterministic.  I have some transcript of messages I photoed in several
> > > boot attempts though:
> > 
> > Can you send me the photos of the messages?  Probably best offlist
> > as the lists don't like attachments.
> 
> I've got something better: one attempt to boot
> b5c58b2fdc427e7958412ecb2de2804a1f7c1572 succeeded and I got a dmesg
> containing some Oops traces.
> 
> The camera does *not* work.  And when I rebooted the system it hung
> (presumably related to these Oops). 

So that oops actually comes from the sounds code and looks unrelated
to DMA.  I suspect that oops is what caused your crashes and thus
messed up the DMA bisection.  Can you try to boot with CONFIG_SND
disabled and see where the bisection for the video issues lands?

(Sorry that all this is such a mess)

