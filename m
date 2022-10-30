Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DF117FD
	for <iommu@lists.linux.dev>; Sun, 30 Oct 2022 08:11:47 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1527B68AA6; Sun, 30 Oct 2022 09:05:41 +0100 (CET)
Date: Sun, 30 Oct 2022 09:05:40 +0100
From: Christoph Hellwig <hch@lst.de>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, Ashish Kalra <ashish.kalra@amd.com>,
	Pankaj Gupta <pankaj.gupta@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH kernel] x86/swiotlb/amd: Half the size if allocation
 failed
Message-ID: <20221030080540.GH4214@lst.de>
References: <20221027052607.260234-1-aik@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027052607.260234-1-aik@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

The subject looks wrong - this just touches the swiotlb code, and
nothing x86 or AMD specific.

The code flow now looks a little confusing.  Can yu just add a little
swiotlb_memblock_alloc helper that does the two variants of memblock
allocation and remap, so that we can keep a simply
loop around them in the caller?
