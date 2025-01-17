Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224031FBEAF;
	Fri, 17 Jan 2025 09:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737107729; cv=none; b=O5tFj818/ZFhe8i1B2MzgaT7uh3SlH45WtCrS021KPmcsTNOaX7VpxcJG/ynFG0A7XU/RxbmiKjEX4fjKXMDJKKWzNR5eL8QbgRJhQujDamRgv+RSmcisw5+j+1pimg89FS4m+Vi8M2fIySWkm6yBsdWtjlx6JO35cBUsSRN9P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737107729; c=relaxed/simple;
	bh=TUOUHK2qZyE6p72aYK4dRpgpveWCv0LrtLgF/AUWHiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WYjPxghlhF78cFJKu6ht/5AAJ2MJd76tGih7DK+Q+ZvoGpyZ5YN+nbnEoTdqOBKguVhc8xBC/8LrHogLutqLn1w4rURWh3A3Eck75x94dIoZdGfwV2Ij0pcQLmC75ZYLM46CX0HtWdPoVqPc3LioWTqWep9OXghdiAkM/J83OH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id DE8FD68BEB; Fri, 17 Jan 2025 10:55:22 +0100 (CET)
Date: Fri, 17 Jan 2025 10:55:22 +0100
From: Christoph Hellwig <hch@lst.de>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Christoph Hellwig <hch@lst.de>, Bruno Gravato <bgravato@gmail.com>,
	Stefan <linux-kernel@simg.de>, Keith Busch <kbusch@kernel.org>,
	bugzilla-daemon@kernel.org, Adrian Huang <ahuang12@lenovo.com>,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	LKML <linux-kernel@vger.kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [Bug 219609] File corruptions on SSD in 1st M.2 socket of
 AsRock X600M-STX + Ryzen 8700G
Message-ID: <20250117095522.GA2391@lst.de>
References: <401f2c46-0bc3-4e7f-b549-f868dc1834c5@leemhuis.info> <Z36UsE5dj6j5HhkX@kbusch-mbp> <20250109082849.GC20724@lst.de> <210e7b28-de05-44bc-9604-83a79ae131b0@leemhuis.info> <726275aa-a3c2-4dbd-9055-a14db93efa29@simg.de> <CAOBLbT8103fAyoFNF8=YcEM1sM6HodcUe=Ee5NsE2hUkfCYv7g@mail.gmail.com> <3b693647-5e82-4c39-8017-22cada56eb55@leemhuis.info> <20250117080507.GA25953@lst.de> <f81bb87a-c181-4973-be05-f7df84133a46@leemhuis.info>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f81bb87a-c181-4973-be05-f7df84133a46@leemhuis.info>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jan 17, 2025 at 10:51:09AM +0100, Thorsten Leemhuis wrote:
> By booting with 'ignore_loglevel dyndbg="file drivers/pci/* +p"' I
> suppose? No, that is not printed (but other debug lines from the pci
> code are).
> 
> Side note: that "PCI-DMA: Using software bounce buffering for IO
> >> (SWIOTLB)" message does show up on two other AMD machines I own as
> well. One also has a Ryzen 8000, the other one a much older one.
> 
> And BTW a few bits of the latest development in the bugzilla ticket
> (https://bugzilla.kernel.org/show_bug.cgi?id=219609 ):
> 
> * iommu=pt and amd_iommu=off seems to work around the problem (in
> addition to disabling the iommu in the BIOS setup).

That suggests the problem is related to the dma-iommu code, and
my strong suspect is the swiotlb bounce buffering for untrusted
device.  If you feel adventurous, can you try building a kernel
where dev_use_swiotlb() in drivers/iommu/dma-iommu.c is hacked
to always return false?

