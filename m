From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 0/7 v7] Support for fsl-mc bus and its devices in SMMU
Date: Tue, 25 Sep 2018 09:48:41 +0200
Message-ID: <20180925074841.oukeyvrmub45kzis@8bytes.org>
References: <1536587361-11047-1-git-send-email-nipun.gupta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1536587361-11047-1-git-send-email-nipun.gupta@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nipun Gupta <nipun.gupta@nxp.com>
Cc: robin.murphy@arm.com, will.deacon@arm.com, robh+dt@kernel.org, robh@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com, gregkh@linuxfoundation.org, laurentiu.tudor@nxp.com, bhelgaas@google.com, hch@lst.de, m.szyprowski@samsung.com, shawnguo@kernel.org, frowand.list@gmail.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, bharat.bhushan@nxp.com, stuyoder@gmail.com, leoyang.li@nxp.com
List-Id: iommu@lists.linux-foundation.org

On Mon, Sep 10, 2018 at 07:19:14PM +0530, Nipun Gupta wrote:
> Nipun Gupta (7):
>   Documentation: fsl-mc: add iommu-map device-tree binding for fsl-mc
>     bus
>   iommu/of: make of_pci_map_rid() available for other devices too
>   iommu/of: support iommu configuration for fsl-mc devices
>   iommu/arm-smmu: Add support for the fsl-mc bus
>   bus: fsl-mc: support dma configure for devices on fsl-mc bus
>   bus: fsl-mc: set coherent dma mask for devices on fsl-mc bus
>   arm64: dts: ls208xa: comply with the iommu map binding for fsl_mc

Applied, thanks Nipun.
