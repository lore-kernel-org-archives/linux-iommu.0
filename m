From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH] dmaengine: fsl-edma: dma map slave device address
Date: Mon, 4 Feb 2019 12:33:30 +0530
Message-ID: <20190204070330.GG4296@vkoul-mobl>
References: <20190118100623.13271-1-laurentiu.tudor@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190118100623.13271-1-laurentiu.tudor@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc: dmaengine@vger.kernel.org, linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, robin.murphy@arm.com
List-Id: iommu@lists.linux-foundation.org

On 18-01-19, 12:06, Laurentiu Tudor wrote:
> This mapping needs to be created in order for slave dma transfers
> to work on systems with SMMU. The implementation mostly mimics the
> one in pl330 dma driver, authored by Robin Murphy.

Applied, thanks

-- 
~Vinod
