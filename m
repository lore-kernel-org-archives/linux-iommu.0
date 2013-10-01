From: Christoffer Dall <christoffer.dall@linaro.org>
Subject: Re: [RFC PATCH v2 0/7] VFIO for device tree based platform devices
 (work in progress)
Date: Tue, 1 Oct 2013 16:47:33 +0100
Message-ID: <20131001154733.GC63102@lvm>
References: <1380554923-17818-1-git-send-email-a.motakis@virtualopensystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1380554923-17818-1-git-send-email-a.motakis@virtualopensystems.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Antonios Motakis <a.motakis@virtualopensystems.com>
Cc: kvmarm@lists.cs.columbia.edu, alex.williamson@redhat.com, iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, kvm@vger.kernel.org, agraf@suse.de, B08248@freescale.com, tech@virtualopensystems.com
List-Id: iommu@lists.linux-foundation.org

On Mon, Sep 30, 2013 at 05:28:36PM +0200, Antonios Motakis wrote:
> This is a preview of the base work, towards VFIO support on ARM platforms
> with an IOMMU. It forms a base on to which to implement the functionality
> necessary to enable using device tree devices on ARM (and other platforms
> based on device trees) with VFIO.
> 
> This patch series has been subjected to limited testing on the Arndale board
> (with the Exynos 5250 System MMU). More extensive testing will follow as more
> features are implemented.

Which device did you access behind the system MMU?  I seem to recall
someone telling me that only the GPU is behind the system MMU on
Arndale.

> 
> It depends on Cho KyongHo's patch series "iommu/exynos: Fixes and Enhancements
> of System MMU driver with DT", applied on a Linux 3.10.1 kernel, and also my
> own "iommu/exynos: add devices attached to the System MMU to an IOMMU group".
> Those patches are required at least in order to test the proposed module on
> Arndale.
> 
> The API used is identical to the existing VFIO API that is also used with
> PCI devices. Only devices that include a basic set of IRQs and memory regions
> are targeted; devices with complicated relationships with other devices on the
> device tree are not taken into account at this stage.
> 
> The following IOCTLs have been found to be working on the Arndale with no
> changes to VFIO:
>  - VFIO_GET_API_VERSION
>  - VFIO_CHECK_EXTENSION
> The TYPE1 fix proposed here enables the following IOCTLs:
>  - VFIO_GROUP_GET_STATUS
>  - VFIO_GROUP_SET_CONTAINER
>  - VFIO_SET_IOMMU
>  - VFIO_IOMMU_GET_INFO
>  - VFIO_IOMMU_MAP_DMA
> The VFIO platform driver proposed here implements the following:
>  - VFIO_GROUP_GET_DEVICE_FD
>  - VFIO_DEVICE_GET_INFO
>  - VFIO_DEVICE_GET_REGION_INFO
>  - VFIO_DEVICE_GET_IRQ_INFO
> In addition, the VFIO platform driver implements the following through
> the VFIO device file descriptor:
>  - MMAPing memory regions to the virtual address space of the VFIO user.
>  - Read / write of memory regions directly through the file descriptor.
> 
> What still needs to be done, includes:
>  - IRQs / IRQFD support.
>  - The API is not currently extended with device tree specific information.
>  - Proper binding of the VFIO_DT driver to devices; currently to test the
>    driver, one has to edit the device tree and add "vfio" to the
>    compatible property. However Linux does not support OF drivers that
>    can be dynamically bound to any device.
>  - More extensive testing with a functioning device doing DMA.
>  - QEMU / KVM support.
> 
> Antonios Motakis (7):
>   VFIO_IOMMU_TYPE1 workaround to build for platform devices
>   Initial skeleton of VFIO support for Device Tree based devices
>   Return info for device and its memory regions and interrupts
>   VFIO: DT: Support MMAP of MMIO regions
>   VFIO: DT: Read and write support for the device fd
>   VFIO: Update documentation for VFIO_IOMMU_TYPE1 driver
>   VFIO: VFIO_PLATFORM: Update documentation for platform specific
>     devices
> 
>  Documentation/vfio.txt          |  25 +++-
>  drivers/vfio/Kconfig            |  13 +-
>  drivers/vfio/Makefile           |   1 +
>  drivers/vfio/vfio_iommu_type1.c |  22 ++-
>  drivers/vfio/vfio_platform.c    | 308 ++++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/vfio.h       |   1 +
>  6 files changed, 361 insertions(+), 9 deletions(-)
>  create mode 100644 drivers/vfio/vfio_platform.c
> 
> -- 
> 1.8.1.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Christoffer
