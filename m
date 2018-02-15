From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 01/37] iommu: Introduce Shared Virtual Addressing API
Date: Thu, 15 Feb 2018 10:59:09 +0100
Message-ID: <20180215095909.r4nwqjhuijusssuy@8bytes.org>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-2-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180212183352.22730-2-jean-philippe.brucker@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org, sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org, robin.murphy@arm.com, bhelgaas@google.com, alex.williamson@redhat.com, tn@semihalf.com, liubo95@huawei.com, thunder.leizhen@huawei.com, xieyisheng1@huawei.com, xuzaibo@huawei.com, ilias.apalodimas@linaro.org, jonathan.cameron@huawei.com, shunyong.yang@hxt-semitech.com, nwatters@codeaurora.org, okaya@codeaurora.org, jcrouse@codeaurora.org, rfranz@cavium.com, dwmw2@infradead.org, jacob.jun.pan@linux.intel.com, yi.l.liu
List-Id: iommu@lists.linux-foundation.org

On Mon, Feb 12, 2018 at 06:33:16PM +0000, Jean-Philippe Brucker wrote:
  
> +config IOMMU_SVA
> +	bool "Shared Virtual Addressing API for the IOMMU"
> +	select IOMMU_API
> +	help
> +	  Enable process address space management for the IOMMU API. In systems
> +	  that support it, device drivers can bind process address spaces to
> +	  devices and share their page tables using this API.
> +
> +	  If unsure, say N here.

I think this should be an option selected by IOMMU driver and not be
activly selectable by the user.

> +/**
> + * iommu_sva_device_shutdown() - Shutdown Shared Virtual Addressing for a device
> + * @dev: the device
> + *
> + * Disable SVA. The device should not be performing any DMA while this function
> + * is running.

Is this a good idea? How about devices that get hot-unplugged while
processes still use them and there is DMA going back and forth? This
function can be the point to shut down all ongoing stuff first and the
shutdown the device.

