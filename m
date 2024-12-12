Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE03748A
	for <iommu@lists.linux.dev>; Thu, 12 Dec 2024 05:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733982023; cv=none; b=BRveCjEZdarvhOk82nE5m/Qrcxuq6TS+J5NOSBis2xjloJU1m+0JfZLOuVuwfjlprLB6652rn3/yPrfHCdPSt12NcD+N/f05U1O1e8J9xQCDP3lz3GxJMYNmK7ORquYUHni0EtSPJXm76XmbkTil0dvcBUel384QhW4+2Cgf91Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733982023; c=relaxed/simple;
	bh=8+wLHBxsVYK9GRcGzaHZkjg9nn60iJZ+PsU2pBMMUSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u8Kgx9iNIam1lit5WjGRB+LnoF2auzB68rc/XTvT0mu/SwtKi+/QDrGriZbZBJ+X4nU9s1yEg5liPPfkyES3F1ijoZFk6xwWeMtxRr5PutgphYEZFdUy2VwlYMiUyS6FdTlX5vBb6goufZQk6CzPst8F3DaZM43dR/3U909odu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0C5B068D07; Thu, 12 Dec 2024 06:40:15 +0100 (CET)
Date: Thu, 12 Dec 2024 06:40:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ahmad Fatoum <a.fatoum@pengutronix.de>, kasan-dev@googlegroups.com,
	iommu@lists.linux.dev, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Marco Elver <elver@google.com>, Kees Cook <keescook@chromium.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: Using KASAN to catch streaming DMA API violations
Message-ID: <20241212054014.GA4695@lst.de>
References: <72ad8ca7-5280-457e-9769-b8a645966105@pengutronix.de> <360e2ec9-556e-4507-a539-f86f7619fe29@app.fastmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <360e2ec9-556e-4507-a539-f86f7619fe29@app.fastmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Dec 06, 2024 at 09:14:27AM +0100, Arnd Bergmann wrote:
> Right. I would go even further and say that transferring ownership
> to the device poisons an area that is aligned to ARCH_DMA_MINALIGN,
> making it possibly bigger on both ends of the area. Transferring
> ownership back to the CPU only unpoisons the exact area that was
> specified, leaving the unaligned bytes around it as uninitialized.

Yes.

> That may need to be controlled by an additional Kconfig option on
> top of poisoning the data initially.

Note that we'll definitively need a config option for the basic
checks as well.  There is plenty o drivers that don't do any DMA
ownership management right now.  And while I'd like to see everything
fixed it's going to take a while to get there.

