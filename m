Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745B023D7;
	Sat, 21 Sep 2024 05:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726895525; cv=none; b=k5hldQ0n49OXDn5PTxTaPSOuW5RVQ2r3gFEJJMGy3haV13VwAiEF745Ta2PmyE7wdYPk2t5R6MGkB3Pf+hTG8THrAoZdo+s+gvOMZjtYYCgkZwM2mn5SX2jqHoxglWHFDrJHWUJ/QRHoPQfNAFiWmCzCUTHwL+OFQpyF9z6lyiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726895525; c=relaxed/simple;
	bh=IR/RbcMLxcEW3CRKaS6EynZYpOWxbMRipKXPM/A7enI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kxqx8v2u2LcDM5rFaGTpqcqURhz5DEM5YiDrKu6RzWSOHL9SXV2pgITmJsKdEW6aWyQHIKAx1m2iP2pxVXihMkToq9gSJZDTYfmo/um4MvyOKKHMUWXIbl1SuVue5/ZV7+Kq5hHEXurgHACwFM+RF2lt5GhdNhu0EZmhItzCtig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Yzvh+Ycg; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Yzvh+Ycg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aFd39RIctJw4zsfsu+lPZgQI531f+ULw03qXnb91Xg0=; b=Yzvh+YcgcoYLMZhpZPEdHHiyVN
	1kvkCg24IxEibqg7ahFo5LW7zCQRwuh5PBDUuhWnFqK5/LtS3LNJ2zaYJ1H0SJPzypOJ/BlIrVvxT
	GPA4mKd3faowmln/RV9d3mwm0/vhmGqeSGGn+qcU40/bMNY0WP1OfWik5UsOJT1bwFYboD/P2s90I
	MDz6ixA2NX+g7zF3lvudAp0PSUZ2X9ZmlJ0JLKpd1IG8cN+Yf57PYMX38cMMmJAhuMSyFPOpiKJWi
	JS9eR5L9RDlWA4JyogciWhM7DauCg87ugKE/3qso0y2CHqFeWUtQs5zTJBhcuiXryJTElhpNpN5V4
	XNW9r6Zg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1srsPZ-0000000DJLL-20CV;
	Sat, 21 Sep 2024 05:12:01 +0000
Date: Fri, 20 Sep 2024 22:12:01 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Xi Ruoyao <xry111@xry111.site>
Cc: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [GIT PULL] dma-mapping updates for Linux 6.12
Message-ID: <Zu5VoW1ZkViSOws3@infradead.org>
References: <ZuvYnXzbM2qfXQPT@infradead.org>
 <971fbb889da38ca4e60f3dedde29ea43e9338d68.camel@xry111.site>
 <Zu1byUGU832iWBUp@infradead.org>
 <Zu2Bd50GdSxF_-eA@infradead.org>
 <19e4bdbcda78ace200c78c56eb7173097337b921.camel@xry111.site>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19e4bdbcda78ace200c78c56eb7173097337b921.camel@xry111.site>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sat, Sep 21, 2024 at 01:15:43AM +0800, Xi Ruoyao wrote:
> > > What camere and driver are you using?
> 
> Bus 003 Device 003: ID 0c45:6366 Microdia Webcam Vitade AF
> 
> The driver is uvcvideo.
> 
> > And what architecture and platform are you on? 
> 
> A x86_64 laptop (with Core i5-11300H CPU).

Oh, so it's not arm64, which has the most juicy changes this time
around.

Can you try the following "manual bisect" for me?

First test f69e342eec008e1bab772d3963c3dd9979293e13 to see if that
works.  If it doesn't work come back as I'm a bit lost :)

If it does work, try b5c58b2fdc427e7958412ecb2de2804a1f7c1572 next,
if it doesn't work can you send me your dmesg?

We'll then work from there.
