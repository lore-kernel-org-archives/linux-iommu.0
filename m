Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8C71EA74
	for <iommu@lists.linux.dev>; Tue,  9 Jul 2024 11:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720525869; cv=none; b=kN4lumG1bPzWnx/u8kMLVRu2ymSp85RlALuKyJnI73C4SOb9pDZdFsg0S14sQCk1c3i56m78JztPv+vRsgwZP3qSQLYXA+AaKQkcs02YRghQ19HvNza7txSX1v3JYj2avdVgN2DuERBr+IZUwxtqcfZzNh15m2U51sA79RAaV1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720525869; c=relaxed/simple;
	bh=9J7/VvorApxZyEwc6503bE/xVbF4fVh6GpJw6bgEdEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UrMjLNgA6R4KfWBACAvlqYo/Cl06wLf5IS2pI6un0zWkLeeet+reqpur2Yw+XgxsnUDMFzhDblhePUjkbkwtMnCsCpOJl2Pwep5advL6byDpdnAwcsF+b/C+RCJE1qB3I/AqPlcrv9YcUocB/vWvvVIRxfW6bPBpviGGPf9yiEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C293268BEB; Tue,  9 Jul 2024 13:51:03 +0200 (CEST)
Date: Tue, 9 Jul 2024 13:51:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Christoph Hellwig <hch@lst.de>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>,
	"jgross@suse.com" <jgross@suse.com>,
	"sstabellini@kernel.org" <sstabellini@kernel.org>,
	"oleksandr_tyshchenko@epam.com" <oleksandr_tyshchenko@epam.com>,
	"m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
	"petr@tesarici.cz" <petr@tesarici.cz>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH v3 1/1] swiotlb: Reduce swiotlb pool lookups
Message-ID: <20240709115103.GA7662@lst.de>
References: <20240708194100.1531-1-mhklinux@outlook.com> <20240709062555.GB16797@lst.de> <SN6PR02MB41571D61C2DE0D914D8B0923D4DB2@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB41571D61C2DE0D914D8B0923D4DB2@SN6PR02MB4157.namprd02.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jul 09, 2024 at 11:48:08AM +0000, Michael Kelley wrote:
> Your tweaks look fine to me. Evidently I misunderstood your
> preference in our previous exchange about #ifdef vs. IS_ENABLED()
> in swiotlb_find_pool(), and the effect on dma_uses_io_tlb.

Actually I actively mislead you.  Yes, I prefer the IS_ENABLED, but
I missed that it would require make the field available unconditionally,
which is not worth the tradeoff.  Sorry for that.

