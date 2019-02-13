From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 01/12] mfd/sm501: depend on HAS_DMA
Date: Wed, 13 Feb 2019 19:17:05 +0100
Message-ID: <20190213181705.GB19706@lst.de>
References: <20190211133554.30055-1-hch@lst.de> <20190211133554.30055-2-hch@lst.de> <20190213072931.GD1863@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190213072931.GD1863@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, x86@kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Feb 13, 2019 at 07:29:31AM +0000, Lee Jones wrote:
> I would normally have taken this, but I fear it will conflict with
> [PATCH 06/12].  For that reason, just take my:
> 
>   Acked-by: Lee Jones <lee.jones@linaro.org>

Yes, I'll need it for the later patches in the series.

Thanks for the review.
