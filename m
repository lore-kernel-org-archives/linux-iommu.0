Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9799A3195FE;
	Wed, 17 Sep 2025 13:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758116492; cv=none; b=k0jJ0ZEjcNzb4YPoEqrvUfO+6opf/RJJ7GtttLdgymFSGkcGNuXL1h/XChmHG/guzqZDrZwLZRWSbaNcQtcYuANlu8q8RNO7jUTRJpkRFONpCKlytc9Cop8RHlLD0PXC9KH6/A6h5TRPy/wDLV37BkwDK0l/9qVcDLSG1uZc8g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758116492; c=relaxed/simple;
	bh=sQdxo9SHlz51iSsTYeRMaDH1R61J5cb2/KGHfNquLPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q+5wV6KIk+8+dg9DNWhCs5vamzFSTSEtEEUy8uQhdLM/AgXNCSjNwWwU382EMAhHX4lwINfzwdWx4pDHLv6HN2PkZz7nqQ+cCklG/XaMe61hpLbKy0U3/NafpC8rEgbdYhlJ5e8A7GNY9TbbVodhPNS6sLkpwfSRIEPdKD0XsbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ax4ebU2V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ax4ebU2V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4BB3C4CEF0;
	Wed, 17 Sep 2025 13:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758116492;
	bh=sQdxo9SHlz51iSsTYeRMaDH1R61J5cb2/KGHfNquLPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ax4ebU2V58seIKiExQTG+K/Ojes9WRpuct4T/mglVB9AUokZ9llUAVlJTvAilmfjd
	 pbEGgmRc2FMFiqRQKWisabz0AnTaRGCy/Oc2i/AyA2KEVynk9Zm2ChnPkeiA1iQyPY
	 Pufr0WD+YSz/IhrOkbkAfxbOZ0WJVYSp4Z4EpE+LzF8AKKLobaT7JmZf0I8rczKOE4
	 PRUtTDYFeZPBMZGEJ5/IJHg6YAPygnZsbEXLkAHWj+o0iltSRZtHaJm7ZrSSXCAube
	 3JRBYiXu9Ckrhz7+Kt2Yr32kwHDfWvcRBWW2VFgbAN1lN9n2qcBM6FmmbkfFc1DMp8
	 gMjH1mt0ITNUw==
Date: Wed, 17 Sep 2025 16:41:28 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v3 3/4] ARM: dma-mapping: Switch to physical address
 mapping callbacks
Message-ID: <20250917134128.GC6464@unreal>
References: <cover.1758006942.git.leon@kernel.org>
 <5f96e44b1fb5d92a6a5f25fc9148a733a1a53b9d.1758006942.git.leon@kernel.org>
 <20250916184617.GW1086830@nvidia.com>
 <20250917103644.GB6464@unreal>
 <20250917113248.GA1086830@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917113248.GA1086830@nvidia.com>

On Wed, Sep 17, 2025 at 08:32:48AM -0300, Jason Gunthorpe wrote:
> On Wed, Sep 17, 2025 at 01:36:44PM +0300, Leon Romanovsky wrote:
> > On Tue, Sep 16, 2025 at 03:46:17PM -0300, Jason Gunthorpe wrote:
> > > On Tue, Sep 16, 2025 at 10:32:06AM +0300, Leon Romanovsky wrote:
> > > > +	if (!dev->dma_coherent &&
> > > > +	    !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO)))
> > > > +		__dma_page_cpu_to_dev(phys_to_page(phys), offset, size, dir);
> > > 
> > > I'd keep going and get rid of the page here too, maybe as a second
> > > patch in this series:
> > 
> > Thanks, it is always unclear how far to go with cleanups.
> 
> IMHO to maximally support what Matthew is working on I'd remove all
> the struct page things and prefer the pfn/phys variations from the MM
> side.

ok, my patches can be found here:
https://git.kernel.org/pub/scm/linux/kernel/git/leon/linux-rdma.git/log/?h=dmabuf-vfio

I converted "struct page" path from all archs with .map_page.

Thanks
