Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F2A9CA4B
	for <iommu@lists.linux.dev>; Mon,  9 Oct 2023 12:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3A32068CFE; Mon,  9 Oct 2023 14:48:06 +0200 (CEST)
Date: Mon, 9 Oct 2023 14:48:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
	iommu@lists.linux.dev, Marek Szyprowski <m.szyprowski@samsung.com>,
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	NXP Linux Team <linux-imx@nxp.com>, linux-m68k@lists.linux-m68k.org,
	netdev@vger.kernel.org, Jim Quinlan <james.quinlan@broadcom.com>,
	linux-riscv <linux-riscv@lists.infradead.org>,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
	"Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	arm-soc <soc@kernel.org>
Subject: Re: [PATCH 1/6] dma-direct: add depdenencies to
 CONFIG_DMA_GLOBAL_POOL
Message-ID: <20231009124805.GA7042@lst.de>
References: <20231009074121.219686-1-hch@lst.de> <20231009074121.219686-2-hch@lst.de> <CAMuHMdWiYDQ5J7R7hPaVAYgXqJvpjdksoF6X-zHrJ_80Ly4XfQ@mail.gmail.com> <20231009091625.GB22463@lst.de> <CAMuHMdUZNewD-QC8J7MWSBP197Vc169meOjjK6=b7M11kVjUzg@mail.gmail.com> <20231009094330.GA24836@lst.de> <CAMuHMdV2FXdUHtjYW8JyXGBgHhR8De0vp3Ee77e6G8Vbs3gG8Q@mail.gmail.com> <1cd44af1-10ac-465a-8d20-e0aa268e036f@arm.com> <CAMuHMdXNX7+VLnSYhj=M9dTSTWLJqjS_WaT0ceMRUYoa5_MSeA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXNX7+VLnSYhj=M9dTSTWLJqjS_WaT0ceMRUYoa5_MSeA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Oct 09, 2023 at 01:10:26PM +0200, Geert Uytterhoeven wrote:
> RISCV_DMA_NONCOHERENT does not select DMA_GLOBAL_POOL,
> ARCH_R9A07G043 selects DMA_GLOBAL_POOL.
> RISCV_DMA_NONCOHERENT does select DMA_DIRECT_REMAP if MMU.

Yeah, and we'll basically need to split RISCV_DMA_NONCOHERENT into
an option for each type of non-coherent support.  This is why we
should never have added support for any of the non-standard versions,
as it's turning into a giant mess.

