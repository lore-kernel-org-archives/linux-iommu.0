From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 2/2] ACPI / scan: Refactor _CCA enforcement
Date: Tue, 11 Dec 2018 11:15:04 +0100
Message-ID: <CAJZ5v0g=RSXxFWU-Yu0UA2AFV+qNoW7Q6t1S8ecydrTrHJZwXA@mail.gmail.com>
References: <cover.1544199754.git.robin.murphy@arm.com> <fe956f04bfe7f8293f6205ee224b087046e40a91.1544199754.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <fe956f04bfe7f8293f6205ee224b087046e40a91.1544199754.git.robin.murphy@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bjorn Helgaas <bhelgaas@google.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Dec 7, 2018 at 5:31 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> Rather than checking the DMA attribute at each callsite, just pass it
> through for acpi_dma_configure() to handle directly. That can then deal
> with the relatively exceptional DEV_DMA_NOT_SUPPORTED case by explicitly
> installing dummy DMA ops instead of just skipping setup entirely. This
> will then free up the dev->dma_ops == NULL case for some valuable
> fastpath optimisations.
>
> CC: Rafael J. Wysocki <rjw@rjwysocki.net>
> CC: Len Brown <lenb@kernel.org>
> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> CC: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

The changes in this patch are fine by me:

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/acpi/scan.c      | 5 +++++
>  drivers/base/platform.c  | 3 +--
>  drivers/pci/pci-driver.c | 3 +--
>  3 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index bd1c59fb0e17..b75ae34ed188 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1456,6 +1456,11 @@ int acpi_dma_configure(struct device *dev, enum dev_dma_attr attr)
>         const struct iommu_ops *iommu;
>         u64 dma_addr = 0, size = 0;
>
> +       if (attr == DEV_DMA_NOT_SUPPORTED) {
> +               set_dma_ops(dev, &dma_dummy_ops);
> +               return 0;
> +       }
> +
>         iort_dma_setup(dev, &dma_addr, &size);
>
>         iommu = iort_iommu_configure(dev);
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 41b91af95afb..c6daca875c17 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -1138,8 +1138,7 @@ int platform_dma_configure(struct device *dev)
>                 ret = of_dma_configure(dev, dev->of_node, true);
>         } else if (has_acpi_companion(dev)) {
>                 attr = acpi_get_dma_attr(to_acpi_device_node(dev->fwnode));
> -               if (attr != DEV_DMA_NOT_SUPPORTED)
> -                       ret = acpi_dma_configure(dev, attr);
> +               ret = acpi_dma_configure(dev, attr);
>         }
>
>         return ret;
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index bef17c3fca67..f899a28b90f8 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -1602,8 +1602,7 @@ static int pci_dma_configure(struct device *dev)
>                 struct acpi_device *adev = to_acpi_device_node(bridge->fwnode);
>                 enum dev_dma_attr attr = acpi_get_dma_attr(adev);
>
> -               if (attr != DEV_DMA_NOT_SUPPORTED)
> -                       ret = acpi_dma_configure(dev, attr);
> +               ret = acpi_dma_configure(dev, attr);
>         }
>
>         pci_put_host_bridge_device(bridge);
> --
> 2.19.1.dirty
>
