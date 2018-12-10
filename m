From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: dma_declare_coherent_memory on main memory
Date: Mon, 10 Dec 2018 08:26:48 +0100
Message-ID: <20181210072648.ore6xttedsgpndi4@pengutronix.de>
References: <20181207153432.GA24917@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181207153432.GA24917@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, linux-imx@nxp.com, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Dec 07, 2018 at 04:34:32PM +0100, Christoph Hellwig wrote:
> Hi all,
> 
> the ARM imx27/31 ports and various sh boards use
> dma_declare_coherent_memory on main memory taken from the memblock
> allocator.
> 
> Is there any good reason these couldn't be switched to CMA areas?
> Getting rid of these magic dma_declare_coherent_memory area would
> help making the dma allocator a lot simpler.

At least for i.MX27/31 I'd say this predates CMA support, so historical
reasons.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
