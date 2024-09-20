Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5835224F0;
	Fri, 20 Sep 2024 14:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726841209; cv=none; b=QzQ1XFMuZ5rUsdDWaPwezHZZSyKsvSaWjyPsBV4/7uzvXzP9Bp43yQjX+GCnv3GTp8hvWtHqJwbLYjmvF0UAAh+YZVV3jDtD0RSKcPSU2sG7BZJAPtEfa0JQpHrsXKHIz7p935UxQW7BlaeMadEIb0kOqphe/NXfwifUalXCjgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726841209; c=relaxed/simple;
	bh=ZOeootuidqrahxD7lhxCB4vZQRJvVD2fnMDNzJcBU7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gDsDLyv3O5/ZMhlvWYHDHsg/QaysaavZMdx3I0NqlfjTsJHVtUGsuzKZ4wKzY6MZIBycT6RsDw+MeSsqKwFObbI7lO+UkDZQfMOAuwYXaeqn/C9nb9uAsmz7yfFNGLZ8mNyoCym/I8sOoD40mKqkX8fOSC4VCQ8AL02wsLuobjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mj3hFuaI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mj3hFuaI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=h678lOAm30gvZBFxVYFXloteBxvAImP9kFT9mfXDkaY=; b=mj3hFuaIy+I6p8RxMtrNH4EHH2
	o4v+6hCDONWQx5jnHrylb2cHeYcGJoyvyVvrXzLKqCGMDpHeQEe8Wk+yskIzmaBOdkVyUxvsid+ZD
	74s493QKUxKO5SQwnchAZT/TEXnrl1Mk0htWpsr7V+Dep02SVkQmx2l/WBGJKH5Dqd1soFD4RFeK3
	uaN78CwzaMOaxVmLrhM3Sx5x+3dLFMBLY3vXx2szfDvo1Zyo6tNaRSqb1SYDKJufarqsN5mH+YJkA
	Qqneq8LfYN+hnVwAXNvfz5cKARts5snlWP31T8Cr9dlBVJb2wJUDI4OzXtowVstHOWxW6ZCRqNRhw
	MwKto0aQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sreHX-0000000CKtA-1MbT;
	Fri, 20 Sep 2024 14:06:47 +0000
Date: Fri, 20 Sep 2024 07:06:47 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Xi Ruoyao <xry111@xry111.site>
Cc: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [GIT PULL] dma-mapping updates for Linux 6.12
Message-ID: <Zu2Bd50GdSxF_-eA@infradead.org>
References: <ZuvYnXzbM2qfXQPT@infradead.org>
 <971fbb889da38ca4e60f3dedde29ea43e9338d68.camel@xry111.site>
 <Zu1byUGU832iWBUp@infradead.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zu1byUGU832iWBUp@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Sep 20, 2024 at 04:26:01AM -0700, Christoph Hellwig wrote:
> On Fri, Sep 20, 2024 at 05:41:51AM +0800, Xi Ruoyao wrote:
> > This breaks using my laptop camera with gstreamer (with "gst-launch-1.0
> > v4l2src ! videoconvert ! autovideosink" or GNOME snapshot).
> 
> What camere and driver are you using?

And what architecture and platform are you on? 

