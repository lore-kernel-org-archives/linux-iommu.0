Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719AA214A9E;
	Thu,  9 Jan 2025 08:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736411336; cv=none; b=pxw2o4Qwp2zz9+bE8l8gaTJ8iQpxmYzecnbMbaDg13VFWwNnyKk36MoOXrjXuFy0bpxu4MkikXJkVH5IrEjEvUra4TV2gton4nNewXyra+y77h+LkS/AqkmAyIU81FOh7VoARGNgKo2zG6gFWD2XD1YF+AphUx0xtK1BNfXRxRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736411336; c=relaxed/simple;
	bh=hyK4nvB5Gtc2JIzVs8lJyfGtnwyUn0eWz/1MWI2scIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dSYVzaJ1xNpuRfMwbqvibt1wa7TCLzYO8g2ISHEj2W8zbJpkosAA/SUmUp+74KGskoEYiRkb4s325OyrTVZJsSccUgsLMzMEcU5uO3UYDG+XFR0/gfzT4YCdOhsRObQI6Pm2on18azNolK0OU0Ih6I43p908Yta1HZDhll5rZfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E215468AFE; Thu,  9 Jan 2025 09:28:49 +0100 (CET)
Date: Thu, 9 Jan 2025 09:28:49 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
	Adrian Huang <ahuang12@lenovo.com>, Christoph Hellwig <hch@lst.de>,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Regression] File corruptions on SSD in 1st M.2 socket of
 AsRock X600M-STX
Message-ID: <20250109082849.GC20724@lst.de>
References: <401f2c46-0bc3-4e7f-b549-f868dc1834c5@leemhuis.info> <Z36UsE5dj6j5HhkX@kbusch-mbp>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z36UsE5dj6j5HhkX@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 08, 2025 at 08:07:28AM -0700, Keith Busch wrote:
> It should always be okay to do smaller transfers as long as everything
> stays aligned the logical block size. I'm guessing the dma opt change
> has exposed some other flaw in the nvme controller. For example, two
> consecutive smaller writes are hitting some controller side caching bug
> that a single larger trasnfer would have handled correctly. The host
> could have sent such a sequence even without the patch reverted, but
> happens to not be doing that in this particular test.

Yes.  This somehow reminds of the bug with an Intel SSD that got
really upset with quickly following writes to different LBAs inside the
same indirection unit.  But as the new smaller size is nicely aligned
that seems unlikely.  Maybe the higher number of commands simply overloads
the buggy firmware?

Of course the real question is why we're even seeing the limitation.
The value suggests it's the swiotlb one.  Does the system use AMD SEV
(memory encryption)?
