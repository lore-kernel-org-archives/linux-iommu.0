From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 02/12] device.h: dma_mem is only needed for
 HAVE_GENERIC_DMA_COHERENT
Date: Tue, 12 Feb 2019 08:49:06 +0100
Message-ID: <20190212074906.GA5924@kroah.com>
References: <20190211133554.30055-1-hch@lst.de>
 <20190211133554.30055-3-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190211133554.30055-3-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org, Lee Jones <lee.jones@linaro.org>, x86@kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Feb 11, 2019 at 02:35:44PM +0100, Christoph Hellwig wrote:
> No need to carry an unused field around.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/device.h | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
