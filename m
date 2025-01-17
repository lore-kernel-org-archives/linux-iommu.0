Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B271F8666;
	Fri, 17 Jan 2025 08:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737101114; cv=none; b=NHqu8FlwA98huX4RApLlYWxVHhhEkRxR80vsgrrUbzP5NKR3RPpWumZZEhoPHwGATGmqmA3WqAOUqcffW3roL36urSq1CzEUd/aHhc3rGBlz6tuBBpIhef7j5hf7G459KbRV9WYAV7j4iZ8zIilfxve373AFrdXIzQMI31/ykeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737101114; c=relaxed/simple;
	bh=A8bEs3iuta2JNndbbTdTqr7PQ0B6+RHuOaBAUjtmGYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e/lJGZ7vhrzP6dkVLrQgrUGlgaoN6d7ispNWX9PankTC9pxvG0d3KjJ4y6X4tNxX2y8q62akc7SwgMLuXBZl5np3PFaaDo53ZYS8umtJG7RzRCY2xEL95QdVOTdxxB5bdfDA/910l5hRy2oqlPxQSVk/3qoLO0ekOPgMfb/NX9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BDD1968BFE; Fri, 17 Jan 2025 09:05:07 +0100 (CET)
Date: Fri, 17 Jan 2025 09:05:07 +0100
From: Christoph Hellwig <hch@lst.de>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Bruno Gravato <bgravato@gmail.com>, Stefan <linux-kernel@simg.de>,
	Keith Busch <kbusch@kernel.org>, bugzilla-daemon@kernel.org,
	Adrian Huang <ahuang12@lenovo.com>,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [Bug 219609] File corruptions on SSD in 1st M.2 socket of
 AsRock X600M-STX + Ryzen 8700G
Message-ID: <20250117080507.GA25953@lst.de>
References: <401f2c46-0bc3-4e7f-b549-f868dc1834c5@leemhuis.info> <Z36UsE5dj6j5HhkX@kbusch-mbp> <20250109082849.GC20724@lst.de> <210e7b28-de05-44bc-9604-83a79ae131b0@leemhuis.info> <726275aa-a3c2-4dbd-9055-a14db93efa29@simg.de> <CAOBLbT8103fAyoFNF8=YcEM1sM6HodcUe=Ee5NsE2hUkfCYv7g@mail.gmail.com> <3b693647-5e82-4c39-8017-22cada56eb55@leemhuis.info>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b693647-5e82-4c39-8017-22cada56eb55@leemhuis.info>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 15, 2025 at 09:40:04AM +0100, Thorsten Leemhuis wrote:
> What does it mean that disabling the NVMe devices's write cache often
> but apparently not always helps? It it just reducing the chance of the
> problem occurring or accidentally working around it?

For consumer NAND device you basically can't disable the volatile
write cache.  If you do disable it, that just means it gets flushed
after every write, meaning you have to write the entire NAND
(super)block for every write, causing a huge slowdown (and a lot of
media wear).  This will change timings a lot obviously.  If it doesn't
change the timing the driver just fakes it, which reputable vendors
shouldn't be doing, but I would not be entirely surprised about
for noname devices.

> hch initially brought up that swiotlb seems to be used. Are there any
> BIOS setup settings we should try? I tried a few changes yesterday, but
> I still get the "PCI-DMA: Using software bounce buffering for IO
> (SWIOTLB)" message in the log and not a single line mentioning DMAR.

The real question would be to figure out why it is used.

Do you see the

	pci_dbg(dev, "marking as untrusted\n");

message in the commit log if enabling the pci debug output?
(I though we had a sysfs file for that, but I can't find it).

