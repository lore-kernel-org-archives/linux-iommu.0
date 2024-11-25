Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED36618787F
	for <iommu@lists.linux.dev>; Mon, 25 Nov 2024 08:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732522502; cv=none; b=SvXkaq5KnYiSctE3+NqvG3Ac2c4yr3nPPqorGdQCPVThOr4u2pPZJb5ey2+rfDq3Xc3FzqOXauLtN7fmbTBG1NPp4G8GgCBf137GgPqvfJbHKcjXwcKY7aAwZu7KAk5R2cMBSt3YSF3kNG162deUaem0YLGETl7ANA9/cd2Grg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732522502; c=relaxed/simple;
	bh=77nXxMgqlVyuyv8lBV6Qpy6zV1/ggoXLwOPcuD6VSXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pAL3Chx3K5FF/+gUi7tBbEtfvS1T4OdOixT/eVQ5tzheMhAe+3Qj3AgV4muXppDvSpLp5zCrOaxT5iU/bo7h6Lvv/DSpIMWw55Xo/epnf+hfTP/gbfvAZ3BTm/0+254iEz1/lqOzcw3N6VUkwXxNgB5zZBhMGO0aSnnDdew0bD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3610968D09; Mon, 25 Nov 2024 09:14:57 +0100 (CET)
Date: Mon, 25 Nov 2024 09:14:57 +0100
From: Christoph Hellwig <hch@lst.de>
To: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
Cc: Tianyu Lan <Tianyu.Lan@microsoft.com>,
	Michael Kelley <mikelley@microsoft.com>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Raphael Isemann <teemperor@gmail.com>,
	Cristiano Giuffrida <giuffrida@cs.vu.nl>,
	Herbert Bos <h.j.bos@vu.nl>, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [RFC 0/1] swiotlb: Mitigate potential DoS caused by BUG_ON()
Message-ID: <20241125081456.GA16878@lst.de>
References: <20241122191304.4182642-1-bjohannesmeyer@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122191304.4182642-1-bjohannesmeyer@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Nov 22, 2024 at 08:13:03PM +0100, Brian Johannesmeyer wrote:
> It is common for drivers to store the DMA address returned by
> dma_map_single() into a coherent DMA region, which can be manipulated by a
> malicious device. For example, the E100 driver and RealTek 8139C+ driver
> map socket buffers into streaming DMA and save their DMA addresses to
> coherent DMA data. While these drivers might assume trusted hardware, this
> behavior is not necessarily unique to them.

FYI, while I don't mind replacing the BUG_ON with a WARN_ON and leaking
the swiotlb allocation, the part where the addresses are mapped so that
the device can modify them is probably what need to be fixed, and it
would also be useful to have documentation in the tree discouraging it.
