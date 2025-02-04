Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC7A25A655;
	Tue,  4 Feb 2025 06:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738650373; cv=none; b=jaYui6EKC7kZSQP+gamanVIyxsrtcbHAO4B9u86QQJ5lGC2N+Nn6gjn4LODapGenCf4rXLDqkWkmb6fqgnbToAGGasPM7D5uw/AwpdFC/1MD/Nw3ljGvyhle5ZwgqFC73+juQlHLzQRfw4AHEDbKiPB5uXsmn9B8rXYbwzQp43M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738650373; c=relaxed/simple;
	bh=DLyHuE7sBiuH1plr2pK6VDDhcA0imwUEYWT9w5+hooQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B4y/VbNnSHYRUoR41gHmyZhnl5irPGm5kh2IBHjFQfBsnZVC/AMDPjlW3ZEsGYjdPW9C4cYttgOlnRMI+kbudrgQHp5VrQTrHcLH4B4BFOci+0lICyUFWrQKe990lTZUdeyOEMW5uXc5yWUC5zW9mm/ja++pFMZnh61n2V40/jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 077F668AFE; Tue,  4 Feb 2025 07:26:06 +0100 (CET)
Date: Tue, 4 Feb 2025 07:26:05 +0100
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
Message-ID: <20250204062605.GB29300@lst.de>
References: <Z36UsE5dj6j5HhkX@kbusch-mbp> <20250109082849.GC20724@lst.de> <210e7b28-de05-44bc-9604-83a79ae131b0@leemhuis.info> <726275aa-a3c2-4dbd-9055-a14db93efa29@simg.de> <CAOBLbT8103fAyoFNF8=YcEM1sM6HodcUe=Ee5NsE2hUkfCYv7g@mail.gmail.com> <3b693647-5e82-4c39-8017-22cada56eb55@leemhuis.info> <20250117080507.GA25953@lst.de> <f81bb87a-c181-4973-be05-f7df84133a46@leemhuis.info> <20250117095522.GA2391@lst.de> <266965cf-9cf9-4434-be42-458e92d7366d@leemhuis.info>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <266965cf-9cf9-4434-be42-458e92d7366d@leemhuis.info>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jan 17, 2025 at 11:30:47AM +0100, Thorsten Leemhuis wrote:
> >> Side note: that "PCI-DMA: Using software bounce buffering for IO
> >>>> (SWIOTLB)" message does show up on two other AMD machines I own as
> >> well. One also has a Ryzen 8000, the other one a much older one.

The message will aways show with > 4G of memory.  It only implies swiotlb
is initialized, not that any device actually uses it.

> >> And BTW a few bits of the latest development in the bugzilla ticket
> >> (https://bugzilla.kernel.org/show_bug.cgi?id=219609 ):
> >>
> >> * iommu=pt and amd_iommu=off seems to work around the problem (in
> >> addition to disabling the iommu in the BIOS setup).

iommu_pt calls iommu_set_default_passthrough, which sets
iommu_def_domain_type to IOMMU_DOMAIN_IDENTITY.  I.e. the hardware
IOMMu is left on, but treated as a 1:1 mapping by Linux.

amd_iommu=off sets amd_iommu_disabled, which calls disable_iommus,
which from a quick read disables the hardware IOMMU.

In either case we'll end up using dma-direct instead of dma-iommu.

> > 
> > That suggests the problem is related to the dma-iommu code, and
> > my strong suspect is the swiotlb bounce buffering for untrusted
> > device.  If you feel adventurous, can you try building a kernel
> > where dev_use_swiotlb() in drivers/iommu/dma-iommu.c is hacked
> > to always return false?
> 
> Tried that, did not help: I still get corrupted data.

.. which together with this implies that the problem only happens
when using the dma-iommu code (with or without swiotlb buffering
for unaligned / untrusted data), and does not happen with
dma-direct.

If we assume it also is related to the optimal dma size, which
the original report suggests, the values for that might be
interesting.  For dma-iommu this is:

	PAGE_SIZE << (IOVA_RANGE_CACHE_MAX_SIZE - 1);

where IOVA_RANGE_CACHE_MAX_SIZE is 6, i.e.

	PAGE_SIZE << 5 or 131072 for x86_64.

for dma-direct it falls back to dma_max_mapping_size, which is
SIZE_MAX without swiotlb, or swiotlb_max_mapping_size, which
is a bit complicate due to minimum alignment, but in this case
should evaluate to: 258048, which is almost twice as big.

And all this unfortunately leaves me really confused.  If someone is
interested in playing around with at the risk of data corruption it would
be interesting to hack hardcoded values into dma_opt_mapping_size, e.g.
plug in the 131072 used by dma-iommu while using dma-direct with the
above iommu disable options.
