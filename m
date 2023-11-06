Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8E063C4
	for <iommu@lists.linux.dev>; Mon,  6 Nov 2023 07:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by verein.lst.de (Postfix, from userid 2407)
	id B3F0D6732D; Mon,  6 Nov 2023 08:42:43 +0100 (CET)
Date: Mon, 6 Nov 2023 08:42:43 +0100
From: Christoph Hellwig <hch@lst.de>
To: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc: Halil Pasic <pasic@linux.ibm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Christoph Hellwig <hch@lst.de>, Bjorn Helgaas <bhelgaas@google.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	Ross Lagerwall <ross.lagerwall@citrix.com>,
	linux-pci <linux-pci@vger.kernel.org>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, Matthew Rosato <mjrosato@linux.ibm.com>
Subject: Re: Memory corruption with CONFIG_SWIOTLB_DYNAMIC=y
Message-ID: <20231106074243.GA17777@lst.de>
References: <104a8c8fedffd1ff8a2890983e2ec1c26bff6810.camel@linux.ibm.com> <20231103171447.02759771.pasic@linux.ibm.com> <20231103214831.26d29f4d@meshulam.tesarici.cz>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231103214831.26d29f4d@meshulam.tesarici.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Nov 03, 2023 at 09:50:53PM +0100, Petr Tesařík wrote:
> Seconded. I have also been struggling with the various alignment
> constraints. I have even written (but not yet submitted) a patch to
> calculate the combined alignment mask in swiotlb_tbl_map_single() and
> pass it down to all other functions, just to make it clear what
> alignment mask is used.

That does sound like a good idea.

> My understanding is that buffer alignment may be required by:
> 
> 1. hardware which cannot handle an unaligned base address (presumably
>    because the chip performs a simple OR operation to get the addresses
>    of individual fields);

There's all kinds of weird encodings that discard the low bits.
For NVMe it's the PRPs (that is actually documented in the NVMe
spec, so it might be easiest to grasp), but except for a Mellox
vendor extension this is also how all RDMA memory registrations
work.

