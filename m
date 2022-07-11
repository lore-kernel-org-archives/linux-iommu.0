Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311D07A
	for <iommu@lists.linux.dev>; Mon, 11 Jul 2022 13:40:04 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7943968AA6; Mon, 11 Jul 2022 15:40:00 +0200 (CEST)
Date: Mon, 11 Jul 2022 15:40:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ben Dooks <ben.dooks@sifive.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	iommu@lists.linux-foundation.org,
	Sudip Mukherjee <sudip.mukherjee@sifive.com>,
	Jude Onyenegecha <jude.onyenegecha@sifive.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] swiotlb: ensure io_tlb_default_mem spinlock always
 initialised
Message-ID: <20220711134000.GA18865@lst.de>
References: <20220708170811.270589-1-ben.dooks@sifive.com> <fdf5d34e-7668-c05c-9098-30e34939c88a@arm.com> <683344bd-dc9b-0bb5-9377-b3e9ab410a74@sifive.com> <e6c43ef0-870b-5fe6-141e-0a3d566b030e@arm.com> <20220711102134.GB4639@lst.de> <4fa8b709-c883-54dc-c302-20c9e55ae93a@sifive.com> <20220711103921.GA6542@lst.de> <43426798-44df-c2c7-1f46-0b79201cb620@sifive.com> <ac4944b8-5d15-4761-6315-7dba6eaee0e7@arm.com> <265d7b6b-a0a4-ecaf-10bd-15e1ea416a06@sifive.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <265d7b6b-a0a4-ecaf-10bd-15e1ea416a06@sifive.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jul 11, 2022 at 01:54:11PM +0100, Ben Dooks wrote:
> I need to go back and check through what we did to get some that worked
> for us, and then come back and try and make some idea of how that is
> best done with upstream kernel.
>
> It might be possible for the PCIe controller to do some sort of very
> simple IOMMU for the case where we might have somehow an PCI device
> added to the system, but that is a very rare use-case I expect and
> if someone does it they can do the effort of updating the PCIe code
> and everything else that goes with it.

Unfortunately there also are plenty of PCIe devices with addressing
limitation even if the PCIe spec explicitly forbits that.  40, 44 or
48 bit limitations seems to be more common than 32-bits, though.
