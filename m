From: Christoph Hellwig <hch@lst.de>
Subject: dma_declare_coherent_memory on main memory
Date: Fri, 7 Dec 2018 16:34:32 +0100
Message-ID: <20181207153432.GA24917@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, linux-imx@nxp.com, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi all,

the ARM imx27/31 ports and various sh boards use
dma_declare_coherent_memory on main memory taken from the memblock
allocator.

Is there any good reason these couldn't be switched to CMA areas?
Getting rid of these magic dma_declare_coherent_memory area would
help making the dma allocator a lot simpler.
