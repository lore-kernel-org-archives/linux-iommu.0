Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EDDDDDD
	for <iommu@lists.linux.dev>; Mon,  6 Nov 2023 07:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by verein.lst.de (Postfix, from userid 2407)
	id 611E46732D; Mon,  6 Nov 2023 08:44:48 +0100 (CET)
Date: Mon, 6 Nov 2023 08:44:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
	Christoph Hellwig <hch@lst.de>, Bjorn Helgaas <bhelgaas@google.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	Ross Lagerwall <ross.lagerwall@citrix.com>,
	linux-pci <linux-pci@vger.kernel.org>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, Matthew Rosato <mjrosato@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>
Subject: Re: Memory corruption with CONFIG_SWIOTLB_DYNAMIC=y
Message-ID: <20231106074448.GB17777@lst.de>
References: <104a8c8fedffd1ff8a2890983e2ec1c26bff6810.camel@linux.ibm.com> <20231103195949.0af884d0@meshulam.tesarici.cz>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231103195949.0af884d0@meshulam.tesarici.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Nov 03, 2023 at 07:59:49PM +0100, Petr Tesařík wrote:
> I don't think it's possible to improve the allocation logic without
> modifying the page allocator and/or the DMA atomic pool allocator to
> take additional constraints into account.
> 
> I had a wild idea back in March, but it would require some intrusive
> changes in the mm subsystem. Among other things, it would make memory
> zones obsolete. I mean, people may actually like to get rid of DMA,
> DMA32 and NORMAL, but you see how many nasty bugs were introduced even
> by a relatively small change in SWIOTLB. Replacing memory zones with a
> system based on generic physical allocation constraints would probably
> blow up the universe. ;-)

It would be very nice, at least for DMA32 or the 30/31-bit DMA pools
used on some architectures.  For the x86-style 16MB zone DMA I suspect
just having a small pool on the side that's not even exposed to the
memory allocator would probably work better.

I think a lot of the MM folks would love to be able to kill of the
extra zones.
