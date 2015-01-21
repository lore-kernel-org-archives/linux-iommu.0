From: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: Re: [PATCH v11 00/20] VFIO support for platform and ARM AMBA devices
Date: Wed, 21 Jan 2015 13:54:52 +0100
Message-ID: <CAG8rG2zZH8bycZwf3o3ggRZJYP=ZUYfKi7vmzUqQoXYv59GkEw@mail.gmail.com>
References: <1420541335-17190-1-git-send-email-a.motakis@virtualopensystems.com>
	<1421692750.6130.377.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1421692750.6130.377.camel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, VirtualOpenSystems Technical Team <tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, kvm-arm <kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org>, Christoffer Dall <christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hello Alex,

On Mon, Jan 19, 2015 at 7:39 PM, Alex Williamson
<alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>
> On Tue, 2015-01-06 at 11:48 +0100, Antonios Motakis wrote:
> > This patch series aims to implement VFIO support for platform devices that
> > reside behind an IOMMU. Examples of such devices are devices behind an ARM
> > SMMU, or behind a Samsung Exynos System MMU.
> >
> > The API used is based on the existing VFIO API that is also used with PCI
> > devices. Only devices that include a basic set of IRQs and memory regions are
> > targeted; devices with complex relationships with other devices on a device
> > tree are not taken into account at this stage.
> >
> > This patch series may be applied on the following series/patches:
> >  - [PATCH] driver core: amba: add device binding path 'driver_override'
>
> Are we stalled from feature bloat again?  What if we dropped amba
> support for now, is there still a useful patch series remaining?

With AMBA support removed from v12, I believe we are not stalled anymore.
The two AMBA patches could be merged later, and applied manually in
the meantime by those who do their testing on the PL330 DMA
controller.

>
> >  - [PATCH v3 0/6] vfio: type1: support for ARM SMMUS with VFIO_IOMMU_TYPE1
>
> Is there anything blocking this series now?  I think we were waiting on
> the NOEXEC stuff for the iommu branch, which I think is now in v3.19-rc,
> right?
>
> Otherwise it looks like there's at least another revision required to
> this series to resolve the mask issue reported by Eric.  Is that
> correct?  Thanks,

Yes, correct on both points.

With Baptiste's touch ups to v12, these should be resolved.

Best regards,
Antonios

>
> Alex
>
> > A copy can be cloned from the branch vfio-platform-v11 at:
> > git-9UaJU3cA/F/QT0dZR+AlfA@public.gmane.org:virtualopensystems/linux-kvm-arm.git
> >
> > Changes since v10:
> >  - Check if interrupt is already masked when setting a new trigger
> >  - Fixed kasprintf with unchecked return value in VFIO AMBA driver
> > Changes since v9:
> >  - Reworked the splitting of the patches that decouple virqfd from PCI
> >  - Some styling issues and typos
> >  - Removed superfluous includes
> >  - AMBA devices are now named vfio-amba- suffixed by the AMBA device id
> >  - Several other cleanups and fixes
> > Changes since v8:
> >  - Separate irq handler for edge and level triggered interrupts
> >  - Mutex based lock for VFIO fd open/release
> >  - Fixed bug where the first region of a platform device wasn't exposed
> >  - Read only regions can be MMAPed only read only
> >  - Code cleanups
> > Changes since v7:
> >  - Some initial placeholder functionality for PIO resources
> >  - Cleaned up code for IRQ triggering, masking and unmasking
> >  - Some functionality has been removed from this series and posted separately:
> >    - VFIO_IOMMU_TYPE1 support for ARM SMMUs
> >    - IOMMU NOEXEC patches
> >    - driver_override functionality for AMBA devices
> >  - Several fixes
> > Changes since v6:
> >  - Integrated support for AMBA devices
> >  - Numerous cleanups and fixes
> > Changes since v5:
> >  - Full eventfd support for IRQ masking and unmasking.
> >  - Changed IOMMU_EXEC to IOMMU_NOEXEC, along with related flags in VFIO.
> >  - Other fixes based on reviewer comments.
> > Changes since v4:
> >  - Use static offsets for each region in the VFIO device fd
> >  - Include patch in the series for the ARM SMMU to expose IOMMU_EXEC
> >    availability via IOMMU_CAP_DMA_EXEC
> >  - Rebased on VFIO multi domain support:
> >    - IOMMU_EXEC is now available if at least one IOMMU in the container
> >      supports it
> >    - Expose IOMMU_EXEC if available via the capability VFIO_IOMMU_PROT_EXEC
> >  - Some bug fixes
> > Changes since v3:
> >  - Use Kim Phillips' driver_probe_device()
> > Changes since v2:
> >  - Fixed Read/Write and MMAP on device regions
> >  - Removed dependency on Device Tree
> >  - Interrupts support
> >  - Interrupt masking/unmasking
> >  - Automask level sensitive interrupts
> >  - Introduced VFIO_DMA_MAP_FLAG_EXEC
> >  - Code clean ups
> >
> > Antonios Motakis (20):
> >   vfio/platform: initial skeleton of VFIO support for platform devices
> >   vfio: platform: probe to devices on the platform bus
> >   vfio: platform: add the VFIO PLATFORM module to Kconfig
> >   vfio: amba: VFIO support for AMBA devices
> >   vfio: amba: add the VFIO for AMBA devices module to Kconfig
> >   vfio/platform: return info for bound device
> >   vfio/platform: return info for device memory mapped IO regions
> >   vfio/platform: read and write support for the device fd
> >   vfio/platform: support MMAP of MMIO regions
> >   vfio/platform: return IRQ info
> >   vfio/platform: initial interrupts support code
> >   vfio/platform: trigger an interrupt via eventfd
> >   vfio/platform: support for level sensitive interrupts
> >   vfio: add a vfio_ prefix to virqfd_enable and virqfd_disable and
> >     export
> >   vfio: virqfd: rename vfio_pci_virqfd_init and vfio_pci_virqfd_exit
> >   vfio: add local lock for virqfd instead of depending on VFIO PCI
> >   vfio: pass an opaque pointer on virqfd initialization
> >   vfio: move eventfd support code for VFIO_PCI to a separate file
> >   vfio: initialize the virqfd workqueue in VFIO generic code
> >   vfio/platform: implement IRQ masking/unmasking via an eventfd
> >
> >  drivers/vfio/Kconfig                          |   1 +
> >  drivers/vfio/Makefile                         |   5 +-
> >  drivers/vfio/pci/vfio_pci.c                   |   8 -
> >  drivers/vfio/pci/vfio_pci_intrs.c             | 238 +-----------
> >  drivers/vfio/pci/vfio_pci_private.h           |   3 -
> >  drivers/vfio/platform/Kconfig                 |  19 +
> >  drivers/vfio/platform/Makefile                |   8 +
> >  drivers/vfio/platform/vfio_amba.c             | 115 ++++++
> >  drivers/vfio/platform/vfio_platform.c         | 103 +++++
> >  drivers/vfio/platform/vfio_platform_common.c  | 520 ++++++++++++++++++++++++++
> >  drivers/vfio/platform/vfio_platform_irq.c     | 340 +++++++++++++++++
> >  drivers/vfio/platform/vfio_platform_private.h |  82 ++++
> >  drivers/vfio/vfio.c                           |   8 +
> >  drivers/vfio/virqfd.c                         | 213 +++++++++++
> >  include/linux/vfio.h                          |  27 ++
> >  include/uapi/linux/vfio.h                     |   2 +
> >  16 files changed, 1456 insertions(+), 236 deletions(-)
> >  create mode 100644 drivers/vfio/platform/Kconfig
> >  create mode 100644 drivers/vfio/platform/Makefile
> >  create mode 100644 drivers/vfio/platform/vfio_amba.c
> >  create mode 100644 drivers/vfio/platform/vfio_platform.c
> >  create mode 100644 drivers/vfio/platform/vfio_platform_common.c
> >  create mode 100644 drivers/vfio/platform/vfio_platform_irq.c
> >  create mode 100644 drivers/vfio/platform/vfio_platform_private.h
> >  create mode 100644 drivers/vfio/virqfd.c
> >
>
>
>
