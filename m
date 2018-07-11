From: Rob Herring <rob.herring@linaro.org>
Subject: Re: [RFC PATCH 0/4] Stop losing firmware-set DMA masks
Date: Wed, 11 Jul 2018 08:40:30 -0600
Message-ID: <CABGGisxVqLMu3TUpbJGWnUFgzUor-8tdyV8KJeU0YT7y=BHrAQ@mail.gmail.com>
References: <cover.1531239284.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1531239284.git.robin.murphy@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, m.szyprowski@samsung.com, iommu@lists.linux-foundation.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, hanjun.guo@linaro.org, Sudeep Holla <sudeep.holla@arm.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, joro@8bytes.org, x86@kernel.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Jul 10, 2018 at 12:43 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> Whilst the common firmware code invoked by dma_configure() initialises
> devices' DMA masks according to limitations described by the respective
> properties ("dma-ranges" for OF and _DMA/IORT for ACPI), the nature of
> the dma_set_mask() API leads to that information getting lost when
> well-behaved drivers probe and set a 64-bit mask, since in general
> there's no way to tell the difference between a firmware-described mask
> (which should be respected) and whatever default may have come from the
> bus code (which should be replaced outright). This can break DMA on
> systems with certain IOMMU topologies (e.g. [1]) where the IOMMU driver
> only knows its maximum supported address size, not how many of those
> address bits might actually be wired up between any of its input
> interfaces and the associated DMA master devices. Similarly, some PCIe
> root complexes only have a 32-bit native interface on their host bridge,
> which leads to the same DMA-address-truncation problem in systems with a
> larger physical memory map and RAM above 4GB (e.g. [2]).
>
> These patches attempt to deal with this in the simplest way possible by
> generalising the specific quirk for 32-bit bridges into an arbitrary
> mask which can then also be plumbed into the firmware code. In the
> interest of being minimally invasive, I've only included a point fix
> for the IOMMU issue as seen on arm64 - there may be further tweaks
> needed in DMA ops to catch all possible incarnations of this problem,
> but this initial RFC is mostly about the impact beyond the dma-mapping
> subsystem itself.

Couldn't you set and use the device's parent's dma_mask instead. At
least for DT, we should always have a parent device representing the
bus. That would avoid further bloating of struct device.

Rob
