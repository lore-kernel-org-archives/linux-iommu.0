Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13BE4C6E
	for <iommu@lists.linux.dev>; Wed,  6 Mar 2024 12:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709727063; cv=none; b=B+zfiCgtJGncsz67ybuoP4JvJdStIairo4+hV+AH3Jppx0Pb3hKZ9x0XAUY2oIjIYtLAc9oqYhsZraNtVDUxVfu8OauhhCsC+mbaoYzck+Z7bYQ88U5dOSNKRDG11tPd/DMMBAPYWmzO5bU5y/xWyvywSKQFUPzvdJ7k000wQ0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709727063; c=relaxed/simple;
	bh=7j6dt+UHhsO4ubeQd/eukm+188h+1cgVkv+vI6q0w1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HWHJ5zPUwk5xnCsu0FKW1NYOwUXr8UmamdiMcnU+ZaBYs1HR6Pvz0O+oM5XBcR+PnwEwE/PLA/th3s+xPiZlilz58cFJZlKa5dQW8IMpjds6XE6RSVNycuXpmg4F2PHBJ7NeXmij6fcsdS2s1JrZnuu5dDcSEzQ+L6jcEz1MYJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 772C368C4E; Wed,  6 Mar 2024 13:10:50 +0100 (CET)
Date: Wed, 6 Mar 2024 13:10:50 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Christoph Hellwig <hch@lst.de>,
	Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	iommu@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 0/7] dma-mapping: Simplify arch_setup_dma_ops()
Message-ID: <20240306121050.GA8863@lst.de>
References: <cover.1707493264.git.robin.murphy@arm.com> <6af5e7da-08ba-4fc7-8e57-863377182142@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6af5e7da-08ba-4fc7-8e57-863377182142@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Mar 06, 2024 at 12:02:41PM +0000, Robin Murphy wrote:
> Are either of you happy to pick this series up now that we have Hanjun's 
> acks for the IORT parts? As it stands it still applies cleanly to both 
> iommu/next and dma/for-next. I do have some followup IOMMU patches prepared 
> already (continuing to delete more code, yay!), but I don't want to get too 
> far ahead of myself.

I expected this to go in through the iommu tree.  But if Joerg want
the series (or part of it) to go through the dma-mapping tree I'd
be happy to pick it up ASAP.

