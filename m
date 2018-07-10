From: Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC PATCH 1/4] dma-mapping: Generalise dma_32bit_limit flag
Date: Tue, 10 Jul 2018 20:04:33 +0200
Message-ID: <20180710180433.GB26285@lst.de>
References: <cover.1531239284.git.robin.murphy@arm.com>
 <a85a5fe22fced65b2960251fc6e8d8f1e68f828a.1531239284.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <a85a5fe22fced65b2960251fc6e8d8f1e68f828a.1531239284.git.robin.murphy@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com, gregkh@linuxfoundation.org, joro@8bytes.org, x86@kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org, robh+dt@kernel.org, hanjun.guo@linaro.org, sudeep.holla@arm.com, frowand.list@gmail.com, hch@lst.de, linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com
List-Id: iommu@lists.linux-foundation.org

On Tue, Jul 10, 2018 at 06:17:16PM +0100, Robin Murphy wrote:
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 8be8106270c2..95e185347e34 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -183,7 +183,7 @@ int dma_direct_supported(struct device *dev, u64 mask)
>  	 * Various PCI/PCIe bridges have broken support for > 32bit DMA even
>  	 * if the device itself might support it.
>  	 */
> -	if (dev->dma_32bit_limit && mask > DMA_BIT_MASK(32))
> +	if (dev->bus_dma_mask && mask > dev->bus_dma_mask)
>  		return 0;

The comment above this check needs an updated (or just be removed).

Also we still have a few architectures not using dma-direct. I guess
most were doing fine without such limits anyway, but at least arm
will probably need an equivalent check.
