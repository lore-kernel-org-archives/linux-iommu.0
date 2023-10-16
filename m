Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54CE27738
	for <iommu@lists.linux.dev>; Mon, 16 Oct 2023 13:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9503B6732D; Mon, 16 Oct 2023 15:17:45 +0200 (CEST)
Date: Mon, 16 Oct 2023 15:17:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Christoph Hellwig <hch@lst.de>, Greg Ungerer <gerg@linux-m68k.org>,
	iommu@lists.linux.dev, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Conor Dooley <conor@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	NXP Linux Team <linux-imx@nxp.com>, linux-m68k@lists.linux-m68k.org,
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	Jim Quinlan <james.quinlan@broadcom.com>
Subject: Re: [PATCH 04/12] soc: renesas: select RISCV_DMA_NONCOHERENT from
 ARCH_R9A07G043
Message-ID: <20231016131745.GB26484@lst.de>
References: <20231016054755.915155-1-hch@lst.de> <20231016054755.915155-5-hch@lst.de> <20231016-pantyhose-tall-7565b6b20fb9@wendy>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016-pantyhose-tall-7565b6b20fb9@wendy>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Oct 16, 2023 at 01:52:57PM +0100, Conor Dooley wrote:
> > +	select RISCV_DMA_NONCOHERENT
> >  	select ERRATA_ANDES if RISCV_SBI
> >  	select ERRATA_ANDES_CMO if ERRATA_ANDES
> 
> Since this Kconfig menu has changed a bit in linux-next, the selects
> are unconditional here, and ERRATA_ANDES_CMO will in turn select
> RISCV_DMA_NONCOHERENT.

Oh, looks like another patch landed there in linux-next.  I had
waited for the previous one go go upstream in -rc6.  Not sure
how to best handle this conflict.
