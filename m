Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB44D198E71
	for <iommu@lists.linux.dev>; Thu, 27 Jun 2024 15:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719501919; cv=none; b=fXBSf+ynbFPZ74iBHqk1cTOd/mrq6BE0JxMK65SMV0d9GIWh0ClXzw8643NDm+cgjsMEAj/IyFqefaPkXirNThAXuG4qYOOJScWWikOEYmVvjnsK27lMd3K8fIHUVm0iibo0JfXFHyWIu3+GuLBvrR1UhVX0+fAb/6R835og9OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719501919; c=relaxed/simple;
	bh=KMLjZIT1/+LEZM2TlXdwIk0EpfixpoY2KLbfpRu0jnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PCstdufmqgxlGsyd4QlfZLexfmkT2/0EaK6OjdsjNxbaF+t6dndwOt9Pbpaq1QUCc1r8e/8RzdZ/wojCCxyM63g/5ssuRS9JHs12Y1bkG3jEUFaILhEcVb3KUXRHO3wrSE57KlbzWeuRY3zsQ+16pUQ7nh9vaT3C6myneXRh0xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2DCFC68BFE; Thu, 27 Jun 2024 17:25:13 +0200 (CEST)
Date: Thu, 27 Jun 2024 17:25:13 +0200
From: "hch@lst.de" <hch@lst.de>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>,
	"hch@lst.de" <hch@lst.de>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>,
	"jgross@suse.com" <jgross@suse.com>,
	"sstabellini@kernel.org" <sstabellini@kernel.org>,
	"oleksandr_tyshchenko@epam.com" <oleksandr_tyshchenko@epam.com>,
	"m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [RFC 1/1] swiotlb: Reduce calls to swiotlb_find_pool()
Message-ID: <20240627152513.GA23497@lst.de>
References: <20240607031421.182589-1-mhklinux@outlook.com> <SN6PR02MB41577686D72E206DB0084E90D4D62@SN6PR02MB4157.namprd02.prod.outlook.com> <20240627060251.GA15590@lst.de> <20240627085216.556744c1@meshulam.tesarici.cz> <SN6PR02MB4157E61B49C8435E38AC968DD4D72@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157E61B49C8435E38AC968DD4D72@SN6PR02MB4157.namprd02.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jun 27, 2024 at 02:59:03PM +0000, Michael Kelley wrote:
> Conceptually, it's still being used as a boolean function based on
> whether the return value is NULL.  Renaming it to swiotlb_get_pool()
> more accurately describes the return value, but obscures the
> intent of determining if it is a swiotlb buffer.  I'll think about it.
> Suggestions are welcome.

Just keep is_swiotlb_buffer as a trivial inline helper that returns
bool.

