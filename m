Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C57DC088
	for <iommu@lists.linux.dev>; Tue, 14 Feb 2023 14:11:53 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1C13A68BFE; Tue, 14 Feb 2023 15:11:43 +0100 (CET)
Date: Tue, 14 Feb 2023 15:11:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>,
	"David S. Miller" <davem@davemloft.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, Arnd Bergmann <arnd@arndb.de>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
	sparclinux@vger.kernel.org, iommu@lists.linux.dev,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH] dma-mapping: no need to pass a bus_type into
 get_arch_dma_ops()
Message-ID: <20230214141142.GA14060@lst.de>
References: <20230214140121.131859-1-gregkh@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214140121.131859-1-gregkh@linuxfoundation.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Feb 14, 2023 at 03:01:21PM +0100, Greg Kroah-Hartman wrote:
> The get_arch_dma_ops() arch-specific function never does anything with
> the struct bus_type that is passed into it, so remove it entirely as it
> is not needed.

Yes.  (and eventually get_arch_dma_ops should go away entirely, but that's
a separate story).

> Note: Unless someone objects, I would like to take this through the
> driver-core tree, as further bus_type cleanups depend on it, and it's
> stand-alone from everyone else's tree at the moment from what I can
> determine.

Please do!

Acked-by: Christoph Hellwig <hch@lst.de>
