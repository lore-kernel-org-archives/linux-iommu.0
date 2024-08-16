Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24DC1BF339;
	Fri, 16 Aug 2024 21:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723842438; cv=none; b=PIlMSmL88UOCRvTqm4dyqKMLNMEBZYTiHxz73iQSY9L4la8hEy8smuDxsoWNoVmFU0nqPAh+ujavCNi3IJKDCbbBNk5pHg9Ebax6geJ+tC4jYfIp5pT7BlwLOUoJVMrfVlNAzWqTFA2eL2246cRruvkX7rREaTLeDpmdpQ7Gek8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723842438; c=relaxed/simple;
	bh=s3jVdAVjzFoRJo4B/B/8soz52JAn5/6CmLtBL9Mcx5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JTcivloBVjYeZqD58ykPlF3diEwYEJbZTmJvieuTkkVJbw0RPKZBiP+2J1V29wQmMKp6g2crNM5kcGZfitg63gF13YcEiPgJSSr/odgpfq3QA5NJVEcfLJIJ55NpbjUH2b43Gs6g/pwqdXZzM9H8Op5Pn/p/JG5ykm2cto+mMa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GdffXrF0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GdffXrF0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ADB6C32782;
	Fri, 16 Aug 2024 21:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723842438;
	bh=s3jVdAVjzFoRJo4B/B/8soz52JAn5/6CmLtBL9Mcx5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GdffXrF0Lz1CQ2UIzTQO+cLy/3HZFENL+eTTOM0GigbyBqzxAlip2pWJpGHnkZC4/
	 gTRAGOccI3wXLv0zVlpyBCajr9ExQgp24c+2YmcUQ/cZNRLz7PXNkWxRQb2X7XeC1s
	 zVouCnwoD6F69VPHuk+YH03ZLVpvgVbXMFcl4MRmfQRmJ0granvwojEjRIKQ84hHD9
	 Ih9lZSFwC0HjqyFGlgH2PlIRM8KvNE3Xhg4iZZ1+k7QGV8eJ4SaJkPIRCT3iPQZXn/
	 F4sJv6hxV+A5qWR0MR6oWytkR6sPpZulCAn26OViJKoy/EqusNfxcSwzJyYrjmAM1y
	 aq2N68h//IDJQ==
Date: Fri, 16 Aug 2024 15:07:17 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
Cc: will@kernel.org, m.szyprowski@samsung.com, saravanak@google.com,
	klarasmodin@gmail.com, robin.murphy@arm.com, iommu@lists.linux.dev,
	aisheng.dong@nxp.com, kernel@quicinc.com,
	devicetree@vger.kernel.org, catalin.marinas@arm.com, hch@lst.de,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/2] of: reserved_mem: Restruture how the reserved
 memory regions are processed
Message-ID: <172384243424.2188220.6416522765336763832.robh@kernel.org>
References: <20240809184814.2703050-1-quic_obabatun@quicinc.com>
 <20240809184814.2703050-2-quic_obabatun@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809184814.2703050-2-quic_obabatun@quicinc.com>


On Fri, 09 Aug 2024 11:48:13 -0700, Oreoluwa Babatunde wrote:
> Reserved memory regions defined in the devicetree can be broken up into
> two groups:
> i) Statically-placed reserved memory regions
> i.e. regions defined with a static start address and size using the
>      "reg" property.
> ii) Dynamically-placed reserved memory regions.
> i.e. regions defined by specifying an address range where they can be
>      placed in memory using the "alloc_ranges" and "size" properties.
> 
> These regions are processed and set aside at boot time.
> This is done in two stages as seen below:
> 
> Stage 1:
> At this stage, fdt_scan_reserved_mem() scans through the child nodes of
> the reserved_memory node using the flattened devicetree and does the
> following:
> 
> 1) If the node represents a statically-placed reserved memory region,
>    i.e. if it is defined using the "reg" property:
>    - Call memblock_reserve() or memblock_mark_nomap() as needed.
>    - Add the information for that region into the reserved_mem array
>      using fdt_reserved_mem_save_node().
>      i.e. fdt_reserved_mem_save_node(node, name, base, size).
> 
> 2) If the node represents a dynamically-placed reserved memory region,
>    i.e. if it is defined using "alloc-ranges" and "size" properties:
>    - Add the information for that region to the reserved_mem array with
>      the starting address and size set to 0.
>      i.e. fdt_reserved_mem_save_node(node, name, 0, 0).
>    Note: This region is saved to the array with a starting address of 0
>    because a starting address is not yet allocated for it.
> 
> Stage 2:
> After iterating through all the reserved memory nodes and storing their
> relevant information in the reserved_mem array,fdt_init_reserved_mem() is
> called and does the following:
> 
> 1) For statically-placed reserved memory regions:
>    - Call the region specific init function using
>      __reserved_mem_init_node().
> 2) For dynamically-placed reserved memory regions:
>    - Call __reserved_mem_alloc_size() which is used to allocate memory
>      for each of these regions, and mark them as nomap if they have the
>      nomap property specified in the DT.
>    - Call the region specific init function.
> 
> The current size of the resvered_mem array is 64 as is defined by
> MAX_RESERVED_REGIONS. This means that there is a limitation of 64 for
> how many reserved memory regions can be specified on a system.
> As systems continue to grow more and more complex, the number of
> reserved memory regions needed are also growing and are starting to hit
> this 64 count limit, hence the need to make the reserved_mem array
> dynamically sized (i.e. dynamically allocating memory for the
> reserved_mem array using membock_alloc_*).
> 
> On architectures such as arm64, memory allocated using memblock is
> writable only after the page tables have been setup. This means that if
> the reserved_mem array is going to be dynamically allocated, it needs to
> happen after the page tables have been setup, not before.
> 
> Since the reserved memory regions are currently being processed and
> added to the array before the page tables are setup, there is a need to
> change the order in which some of the processing is done to allow for
> the reserved_mem array to be dynamically sized.
> 
> It is possible to process the statically-placed reserved memory regions
> without needing to store them in the reserved_mem array until after the
> page tables have been setup because all the information stored in the
> array is readily available in the devicetree and can be referenced at
> any time.
> Dynamically-placed reserved memory regions on the other hand get
> assigned a start address only at runtime, and hence need a place to be
> stored once they are allocated since there is no other referrence to the
> start address for these regions.
> 
> Hence this patch changes the processing order of the reserved memory
> regions in the following ways:
> 
> Step 1:
> fdt_scan_reserved_mem() scans through the child nodes of
> the reserved_memory node using the flattened devicetree and does the
> following:
> 
> 1) If the node represents a statically-placed reserved memory region,
>    i.e. if it is defined using the "reg" property:
>    - Call memblock_reserve() or memblock_mark_nomap() as needed.
>    - Call the region specific initialization function for the region
>      using fdt_init_reserved_mem_node().
> 
> 2) If the node represents a dynamically-placed reserved memory region,
>    i.e. if it is defined using "alloc-ranges" and "size" properties:
>    - Call __reserved_mem_alloc_size() which will:
>      i) Allocate memory for the reserved region and call
>      memblock_mark_nomap() as needed.
>      ii) Call the region specific initialization function using
>      fdt_init_reserved_mem_node().
>      iii) Save the region information in the reserved_mem array using
>      fdt_reserved_mem_save_node().
> 
> Step 2:
> 1) This stage of the reserved memory processing is now only used to add
>    the statically-placed reserved memory regions into the reserved_mem
>    array using fdt_scan_reserved_mem_reg_nodes().
> 
> 2) This step is also moved to be after the page tables have been
>    setup. Moving this will allow us to replace the reserved_mem
>    array with a dynamically sized array before storing the rest of
>    these regions.
> 
> Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
> ---
>  drivers/of/fdt.c             |   5 +-
>  drivers/of/of_private.h      |   3 +-
>  drivers/of/of_reserved_mem.c | 172 +++++++++++++++++++++++++----------
>  3 files changed, 131 insertions(+), 49 deletions(-)
> 

Applied, thanks!

