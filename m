Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D050B8613B
	for <iommu@lists.linux.dev>; Tue,  5 Mar 2024 14:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709647719; cv=none; b=siBcM7/jj+pEZTnJqi6imWBKIRFVVGLxC6eDhlYOzmt1M0IzDMwjJi24zkw9MUg3MyIWDlETc/1Vd6eNOGDUaH5y4eD2qZvdl4iBpEc4bVhIEDzM9B5HhYt+clPIPr6nB/XjRRQyWZ78NUTzPn2ZrY6ha1B6+hXAjdVT6OgVEVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709647719; c=relaxed/simple;
	bh=ewIBfX/apZ/XRSsDq8e9bZDdrJfrqmhnRuRfiKH1Lmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ndsj8Qwd7IfbPFuP5fbe9/Sjc2j6vw6EiseQ/nJYkSWRw+gwchXuPZjIjHJ27NKSY5Jsu2OA4mdYfZbaBkzI7qdHXZ8F/TUL4ET5ybe/pN0m6MQiALibg0VTrwJmnKEPum1IZ1LAnXv09vl59AcqGNb2OgUqO8rMniVxw+7aFF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 220A468C7B; Tue,  5 Mar 2024 15:08:34 +0100 (CET)
Date: Tue, 5 Mar 2024 15:08:33 +0100
From: Christoph Hellwig <hch@lst.de>
To: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc: Michael Kelley <mhklinux@outlook.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	"kernel-team@android.com" <kernel-team@android.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Dexuan Cui <decui@microsoft.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v5 6/6] swiotlb: Remove pointless stride adjustment for
 allocations >= PAGE_SIZE
Message-ID: <20240305140833.GC3659@lst.de>
References: <20240301180853.5ac20b27@meshulam.tesarici.cz> <8869c8b2-29c3-41e4-8f8a-5bcf9c0d22bb@arm.com> <20240301194212.3c64c9b2@meshulam.tesarici.cz> <SN6PR02MB41571DA1EE99BFAA65869024D4232@SN6PR02MB4157.namprd02.prod.outlook.com> <20240304120055.56035c21@meshulam.tesarici.cz> <ffd7646b-37b1-4cd2-822a-848b36b076c9@arm.com> <20240304165506.49e3b2d3@meshulam.tesarici.cz> <20240304160210.GB21077@willie-the-truck> <SN6PR02MB41571F68F8F9E003C4359948D4232@SN6PR02MB4157.namprd02.prod.outlook.com> <20240304200428.4111d78e@meshulam.tesarici.cz>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240304200428.4111d78e@meshulam.tesarici.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Mar 04, 2024 at 08:04:28PM +0100, Petr Tesařík wrote:
> Sure, this will solve the allocations. But my understanding of this
> same thread is that we don't need it here. The historical page order
> alignment applies ONLY to allocations, NOT to mappings. It is
> documented in Documentation/core-api/dma-api-howto.rst under Consistent
> DMA mappings, for dma_alloc_coherent(). IIUC it does not apply to the
> streaming DMA mappings. At least, it would explain why nobody
> complained that the more strict guarantee for sizes greater than
> PAGE_SIZE was not kept...

Yes.  arm32 (and before the dma-direct conversion various other
architectures) have relaxed the required to a PAGE_SIZE alignment,
and at least no native dma direct has ever returned less than PAGE_SIZE
alignment even for smaller allocations (as they are all rounded up
to PAGE_SIZE).  So I think the documentation could also use some
updating to match reality.

