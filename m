Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01DA3E023F
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 19:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773430622; cv=none; b=SiEmj5BWym6kWiQKWf//5gZKwMJoxpwhEHYiAFfuztIvkl/HlLMxP3J4FYr0Z3fLC1ZjlcQ9u7M5wvgh232umRcQnQ3ZE+9kT/+3JrJFKXDs0w3PK0T7uG7qP9dYJm2mA9iRQCXubSzoBYNllwKv6UrMWzYaCi6euXdfaBXtq6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773430622; c=relaxed/simple;
	bh=N0T/TnP4uxl4ukP62hUmU7T5RcwLPE7nXwl716xc/Xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j34QXFcgOsfL+fmnXjxxprgAs1X6UgVwoDAjMQ5XlBiZNtW4jPbMzVA3VVkXWL12GVYpU/jVnIXcnKQkp2P9RmqGOT1j3zeT10Qwn97lf9R9uCT1dt/ogl3ApswvZdbRcAYmYFy22wPhb1zPUn9Ooq5WxytFqftux/5Ux6wXMlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BBBA21758;
	Fri, 13 Mar 2026 12:36:48 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 48CBD3F694;
	Fri, 13 Mar 2026 12:36:52 -0700 (PDT)
Date: Fri, 13 Mar 2026 19:36:50 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Barry Song <21cnbao@gmail.com>, robin.murphy@arm.com, will@kernel.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Barry Song <baohua@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Joerg Roedel <joro@8bytes.org>, Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Tangquan Zheng <zhengtangquan@oppo.com>,
	Huacai Zhou <zhouhuacai@oppo.com>,
	Xueyuan Chen <xueyuan.chen21@gmail.com>
Subject: Re: [PATCH v3 0/5] dma-mapping: arm64: support batched cache sync
Message-ID: <abRnUk-vfvS51FtW@arm.com>
References: <CGME20260228221143eucas1p12a276d4216b6ce0f3c374b093f73acd5@eucas1p1.samsung.com>
 <20260228221125.59863-1-21cnbao@gmail.com>
 <3ece80c7-697e-4d46-a6f8-49c07b0117a1@samsung.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3ece80c7-697e-4d46-a6f8-49c07b0117a1@samsung.com>

On Tue, Mar 03, 2026 at 05:33:37PM +0100, Marek Szyprowski wrote:
> On 28.02.2026 23:11, Barry Song wrote:
> > From: Barry Song <baohua@kernel.org>
> >
> > Many embedded ARM64 SoCs still lack hardware cache coherency support, which
> > causes DMA mapping operations to appear as hotspots in on-CPU flame graphs.
> >
> > For an SG list with *nents* entries, the current dma_map/unmap_sg() and DMA
> > sync APIs perform cache maintenance one entry at a time. After each entry,
> > the implementation synchronously waits for the corresponding region’s
> > D-cache operations to complete. On architectures like arm64, efficiency can
> > be improved by issuing all entries’ operations first and then performing a
> > single batched wait for completion.
> >
> > Tangquan's results show that batched synchronization can reduce
> > dma_map_sg() time by 64.61% and dma_unmap_sg() time by 66.60% on an MTK
> > phone platform (MediaTek Dimensity 9500). The tests were performed by
> > pinning the task to CPU7 and fixing the CPU frequency at 2.6 GHz,
> > running dma_map_sg() and dma_unmap_sg() on 10 MB buffers (10 MB / 4 KB
> > sg entries per buffer) for 200 iterations and then averaging the
> > results.
> >
> > Thanks to Xueyuan for volunteering to take on the testing tasks. He
> > put significant effort into validating paths such as IOVA link/unlink
> > and SWIOTLB on RK3588 boards with NVMe.
> 
> Catalin, Will, I would like to merge this to dma-mapping tree, give Your 
> ack or comment if You are okay with ARM64 related parts.

Sorry for the delay. Yes, feel free to pick them up. I doubt there would
be any conflicts in this area with what I'm merging through the arm64
tree.

Thanks.

-- 
Catalin
