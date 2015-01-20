From: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v11 00/20] VFIO support for platform and ARM AMBA devices
Date: Tue, 20 Jan 2015 17:33:24 +0100
Message-ID: <54BE8354.70801@linaro.org>
References: <1420541335-17190-1-git-send-email-a.motakis@virtualopensystems.com>	<54AF93AB.9030302@linaro.org>	<CAG8rG2yc1ityUwswPiTR_w5f3tSeX_KB2g06HcPCPARXPHGvfg@mail.gmail.com>	<CAN9JPjERBVnGku8_BJuesMnzJyQYUgz6rJhL_VrCOgLVQuXyuw@mail.gmail.com>	<54BCD9A6.4050501@linaro.org>	<54BCF846.1070906@linaro.org>	<CAN9JPjF5sAH-UNKtBhfiHK7cQJBwNwg2UEcrj8sv9Em6MnBVxg@mail.gmail.com>	<54BD4857.3070707@linaro.org>
	<CAN9JPjEhUhjgnDAMmMGxgFoLkhqQYgvsKeZ2+oDKzWMCe+qzhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAN9JPjEhUhjgnDAMmMGxgFoLkhqQYgvsKeZ2+oDKzWMCe+qzhw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Baptiste Reynal <b.reynal-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Cc: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, VirtualOpenSystems Technical Team <tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, kvm-arm <kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org>, Christoffer Dall <christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 01/20/2015 04:10 PM, Baptiste Reynal wrote:
> This fix should work, in a more elegant way. Could you confirm ?
> 
> I'm sorry I don't have any means to reproduce the bug on my side ...


Hi Baptiste,

No Problem. It looks OK to me and runs fine in my xgmac use case.

Best Regards

Eric
> 
> Thanks,
> Baptiste
> 
> diff --git a/drivers/vfio/platform/vfio_platform_irq.c
> b/drivers/vfio/platform/vfio_platform_irq.c
> index 6ade36b..f5f3de0 100644
> --- a/drivers/vfio/platform/vfio_platform_irq.c
> +++ b/drivers/vfio/platform/vfio_platform_irq.c
> @@ -208,6 +208,7 @@ static int vfio_set_trigger(struct
> vfio_platform_device *vdev, int index,
>  
>         irq->trigger = trigger;
>  
> +       irq_set_status_flags(irq->hwirq, IRQ_NOAUTOEN);
>         ret = request_irq(irq->hwirq, handler, 0, irq->name, irq);
>         if (ret) {
>                 kfree(irq->name);
> @@ -216,12 +217,8 @@ static int vfio_set_trigger(struct
> vfio_platform_device *vdev, int index,
>                 return ret;
>         }
>  
> -       /* if the IRQ has been masked by the user before setting an eventfd,
> -        * then we need to make sure it is properly disabled */
> -       spin_lock_irqsave(&irq->lock, flags);
> -       if (irq->masked)
> -               disable_irq_nosync(irq->hwirq);
> -       spin_unlock_irqrestore(&irq->lock, flags);
> +       if (!irq->masked)
> +               enable_irq(irq->hwirq);
>  
>         return 0;
>  }
> 
> On Mon, Jan 19, 2015 at 7:09 PM, Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
> <mailto:eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>> wrote:
> 
>     Hi Baptiste,
> 
>     yes it fixes the issue in my use case.
> 
>     Best Regards
> 
>     Eric
> 
>     On 01/19/2015 06:00 PM, Baptiste Reynal wrote:
>     > Hi Eric,
>     >
>     > Thanks for taking time about this issue. I agree with you, there is a
>     > problem here. While I think on a better fix and to be sure the problem
>     > is here, may you try this patch and tell me if the problem is solved ?
>     > (This should work as the automasked_irq_handler doesn't do anything if
>     > the IRQ is masked).
>     >
>     > If you have a suggestion on a fix, you're welcome :)
>     >
>     > diff --git a/drivers/vfio/platform/vfio_platform_irq.c
>     > b/drivers/vfio/platform/vfio_platform_irq.c
>     > index 6ade36b..c9bac80 100644
>     > --- a/drivers/vfio/platform/vfio_platform_irq.c
>     > +++ b/drivers/vfio/platform/vfio_platform_irq.c
>     > @@ -184,6 +184,7 @@ static int vfio_set_trigger(struct
>     > vfio_platform_device *vdev, int index,
>     >         struct eventfd_ctx *trigger;
>     >         unsigned long flags;
>     >         int ret;
>     > +       bool masked;
>     >
>     >         if (irq->trigger) {
>     >                 free_irq(irq->hwirq, irq);
>     > @@ -208,6 +209,8 @@ static int vfio_set_trigger(struct
>     > vfio_platform_device *vdev, int index,
>     >
>     >         irq->trigger = trigger;
>     >
>     > +       masked = irq->masked;
>     > +
>     >         ret = request_irq(irq->hwirq, handler, 0, irq->name, irq);
>     >         if (ret) {
>     >                 kfree(irq->name);
>     > @@ -219,7 +222,7 @@ static int vfio_set_trigger(struct
>     > vfio_platform_device *vdev, int index,
>     >         /* if the IRQ has been masked by the user before setting
>     an eventfd,
>     >          * then we need to make sure it is properly disabled */
>     >         spin_lock_irqsave(&irq->lock, flags);
>     > -       if (irq->masked)
>     > +       if (masked)
>     >                 disable_irq_nosync(irq->hwirq);
>     >         spin_unlock_irqrestore(&irq->lock, flags);
>     >
>     > On Mon, Jan 19, 2015 at 1:27 PM, Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
>     <mailto:eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>     > <mailto:eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org <mailto:eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>>> wrote:
>     >
>     >     Hi Baptiste,
>     >
>     >     I think what happens on the second qemu run is:
>     >
>     >     an IRQ hits immediatly after request_irq
>     >     automasked handler sets masked = true
>     >     in vfio_set_trigger following condition becomes true
>     >             if (irq->masked)
>     >                     disable_irq_nosync(irq->hwirq);
>     >     IRQ is disabled twice, in handler and in vfio_set_trigger
>     while there is
>     >     a single enable in resamplefd handler.
>     >     To me you should prevent from entering ISR between request_irq and
>     >     disable_irq.
>     >
>     >     It does not happen on the first run because no IRQ hit.
>     >
>     >     Please let me know if you share this understanding.
>     >
>     >     Best Regards
>     >
>     >     Eric
>     >
>     >     On 01/19/2015 11:17 AM, Eric Auger wrote:
>     >     > Hi Baptiste,
>     >     >
>     >     > sorry I was off on Friday. you're right I missed the masked
>     field was
>     >     > reset on init. Nethertheless with current QEMU VFIO code,
>     IRQ runs on
>     >     > the first run and not on the second one. I investigate on my
>     side ...
>     >     >
>     >     > Best Regards
>     >     >
>     >     > Eric
>     >     >
>     >     >
>     >     >
>     >     >
>     >     > On 01/16/2015 02:25 PM, Baptiste Reynal wrote:
>     >     >> Hello Eric,
>     >     >>
>     >     >> I'm not sure I understand the issue here. I tried to reproduce
>     >     the bug
>     >     >> by triggering an interrupt without unmasking it, but the
>     interrupt is
>     >     >> unmasked when the program access to the device
>     (vfio_platform_open
>     >     >> reinit IRQs).
>     >     >>
>     >     >> May I have more details on the bug ?
>     >     >>
>     >     >> Thanks
>     >     >>
>     >     >> On Fri, Jan 9, 2015 at 12:33 PM, Antonios Motakis
>     >     >> <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org
>     <mailto:a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
>     >     <mailto:a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org
>     <mailto:a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>>
>     >     >> <mailto:a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org
>     <mailto:a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
>     >     <mailto:a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org
>     <mailto:a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>>>> wrote:
>     >     >>
>     >     >>     On Fri, Jan 9, 2015 at 9:39 AM, Eric Auger
>     >     <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org <mailto:eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>     <mailto:eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org <mailto:eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>>
>     >     >>     <mailto:eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
>     <mailto:eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>     >     <mailto:eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
>     <mailto:eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>>>> wrote:
>     >     >>     > Hi Antonios,
>     >     >>     >
>     >     >>     > when moving to 3.19rc3 I observe a regression with my
>     xgmac
>     >     use case
>     >     >>     > (real-time change?).
>     >     >>     >
>     >     >>     > I guess what happens is when I kill a first qemu session,
>     >     guest does not
>     >     >>     > have time to complete the virtual IRQ and the unmask
>     is not
>     >     performed by
>     >     >>     > the virqfd handler. When starting a new QEMU session,
>     the irqfd
>     >     >>     > signalling is put in place again but since the masked
>     field
>     >     is set, the
>     >     >>     > IRQ is left unmasked (v11 modification in
>     vfio_set_trigger).
>     >     >>     >
>     >     >>     > The problem is that we don't discriminate between
>     user mask
>     >     action and
>     >     >>     > automasked handler action. In case the user did not
>     mask, I
>     >     think we
>     >     >>     > should reset the masked field when doing the
>     free_irq. What
>     >     do you think?
>     >     >>
>     >     >>     Hello Eric,
>     >     >>
>     >     >>     I agree, we should reset the masked field for future users.
>     >     >>
>     >     >>     Best regards
>     >     >>     Antonios
>     >     >>
>     >     >>     >
>     >     >>     > Best Regards
>     >     >>     >
>     >     >>     > Eric
>     >     >>     >
>     >     >>     > On 01/06/2015 11:48 AM, Antonios Motakis wrote:
>     >     >>     >> This patch series aims to implement VFIO support for
>     platform
>     >     >>     devices that
>     >     >>     >> reside behind an IOMMU. Examples of such devices are
>     devices
>     >     >>     behind an ARM
>     >     >>     >> SMMU, or behind a Samsung Exynos System MMU.
>     >     >>     >>
>     >     >>     >> The API used is based on the existing VFIO API that is
>     >     also used
>     >     >>     with PCI
>     >     >>     >> devices. Only devices that include a basic set of
>     IRQs and
>     >     memory
>     >     >>     regions are
>     >     >>     >> targeted; devices with complex relationships with other
>     >     devices
>     >     >>     on a device
>     >     >>     >> tree are not taken into account at this stage.
>     >     >>     >>
>     >     >>     >> This patch series may be applied on the following
>     >     series/patches:
>     >     >>     >>  - [PATCH] driver core: amba: add device binding path
>     >     >>     'driver_override'
>     >     >>     >>  - [PATCH v3 0/6] vfio: type1: support for ARM SMMUS
>     with
>     >     >>     VFIO_IOMMU_TYPE1
>     >     >>     >>
>     >     >>     >> A copy can be cloned from the branch
>     vfio-platform-v11 at:
>     >     >>     >> git-9UaJU3cA/F/QT0dZR+AlfA@public.gmane.org:virtualopensystems/linux-kvm-arm.git
>     >     >>     >>
>     >     >>     >> Changes since v10:
>     >     >>     >>  - Check if interrupt is already masked when setting
>     a new
>     >     trigger
>     >     >>     >>  - Fixed kasprintf with unchecked return value in VFIO
>     >     AMBA driver
>     >     >>     >> Changes since v9:
>     >     >>     >>  - Reworked the splitting of the patches that
>     decouple virqfd
>     >     >>     from PCI
>     >     >>     >>  - Some styling issues and typos
>     >     >>     >>  - Removed superfluous includes
>     >     >>     >>  - AMBA devices are now named vfio-amba- suffixed by
>     the AMBA
>     >     >>     device id
>     >     >>     >>  - Several other cleanups and fixes
>     >     >>     >> Changes since v8:
>     >     >>     >>  - Separate irq handler for edge and level triggered
>     >     interrupts
>     >     >>     >>  - Mutex based lock for VFIO fd open/release
>     >     >>     >>  - Fixed bug where the first region of a platform device
>     >     wasn't
>     >     >>     exposed
>     >     >>     >>  - Read only regions can be MMAPed only read only
>     >     >>     >>  - Code cleanups
>     >     >>     >> Changes since v7:
>     >     >>     >>  - Some initial placeholder functionality for PIO
>     resources
>     >     >>     >>  - Cleaned up code for IRQ triggering, masking and
>     unmasking
>     >     >>     >>  - Some functionality has been removed from this
>     series and
>     >     >>     posted separately:
>     >     >>     >>    - VFIO_IOMMU_TYPE1 support for ARM SMMUs
>     >     >>     >>    - IOMMU NOEXEC patches
>     >     >>     >>    - driver_override functionality for AMBA devices
>     >     >>     >>  - Several fixes
>     >     >>     >> Changes since v6:
>     >     >>     >>  - Integrated support for AMBA devices
>     >     >>     >>  - Numerous cleanups and fixes
>     >     >>     >> Changes since v5:
>     >     >>     >>  - Full eventfd support for IRQ masking and unmasking.
>     >     >>     >>  - Changed IOMMU_EXEC to IOMMU_NOEXEC, along with
>     related
>     >     flags
>     >     >>     in VFIO.
>     >     >>     >>  - Other fixes based on reviewer comments.
>     >     >>     >> Changes since v4:
>     >     >>     >>  - Use static offsets for each region in the VFIO
>     device fd
>     >     >>     >>  - Include patch in the series for the ARM SMMU to
>     expose
>     >     IOMMU_EXEC
>     >     >>     >>    availability via IOMMU_CAP_DMA_EXEC
>     >     >>     >>  - Rebased on VFIO multi domain support:
>     >     >>     >>    - IOMMU_EXEC is now available if at least one
>     IOMMU in the
>     >     >>     container
>     >     >>     >>      supports it
>     >     >>     >>    - Expose IOMMU_EXEC if available via the capability
>     >     >>     VFIO_IOMMU_PROT_EXEC
>     >     >>     >>  - Some bug fixes
>     >     >>     >> Changes since v3:
>     >     >>     >>  - Use Kim Phillips' driver_probe_device()
>     >     >>     >> Changes since v2:
>     >     >>     >>  - Fixed Read/Write and MMAP on device regions
>     >     >>     >>  - Removed dependency on Device Tree
>     >     >>     >>  - Interrupts support
>     >     >>     >>  - Interrupt masking/unmasking
>     >     >>     >>  - Automask level sensitive interrupts
>     >     >>     >>  - Introduced VFIO_DMA_MAP_FLAG_EXEC
>     >     >>     >>  - Code clean ups
>     >     >>     >>
>     >     >>     >> Antonios Motakis (20):
>     >     >>     >>   vfio/platform: initial skeleton of VFIO support
>     for platform
>     >     >>     devices
>     >     >>     >>   vfio: platform: probe to devices on the platform bus
>     >     >>     >>   vfio: platform: add the VFIO PLATFORM module to
>     Kconfig
>     >     >>     >>   vfio: amba: VFIO support for AMBA devices
>     >     >>     >>   vfio: amba: add the VFIO for AMBA devices module
>     to Kconfig
>     >     >>     >>   vfio/platform: return info for bound device
>     >     >>     >>   vfio/platform: return info for device memory mapped IO
>     >     regions
>     >     >>     >>   vfio/platform: read and write support for the
>     device fd
>     >     >>     >>   vfio/platform: support MMAP of MMIO regions
>     >     >>     >>   vfio/platform: return IRQ info
>     >     >>     >>   vfio/platform: initial interrupts support code
>     >     >>     >>   vfio/platform: trigger an interrupt via eventfd
>     >     >>     >>   vfio/platform: support for level sensitive interrupts
>     >     >>     >>   vfio: add a vfio_ prefix to virqfd_enable and
>     >     virqfd_disable and
>     >     >>     >>     export
>     >     >>     >>   vfio: virqfd: rename vfio_pci_virqfd_init and
>     >     vfio_pci_virqfd_exit
>     >     >>     >>   vfio: add local lock for virqfd instead of
>     depending on
>     >     VFIO PCI
>     >     >>     >>   vfio: pass an opaque pointer on virqfd initialization
>     >     >>     >>   vfio: move eventfd support code for VFIO_PCI to a
>     >     separate file
>     >     >>     >>   vfio: initialize the virqfd workqueue in VFIO
>     generic code
>     >     >>     >>   vfio/platform: implement IRQ masking/unmasking via an
>     >     eventfd
>     >     >>     >>
>     >     >>     >>  drivers/vfio/Kconfig                          |   1 +
>     >     >>     >>  drivers/vfio/Makefile                         |   5 +-
>     >     >>     >>  drivers/vfio/pci/vfio_pci.c                   |   8 -
>     >     >>     >>  drivers/vfio/pci/vfio_pci_intrs.c             | 238
>     >     +-----------
>     >     >>     >>  drivers/vfio/pci/vfio_pci_private.h           |   3 -
>     >     >>     >>  drivers/vfio/platform/Kconfig                 |  19 +
>     >     >>     >>  drivers/vfio/platform/Makefile                |   8 +
>     >     >>     >>  drivers/vfio/platform/vfio_amba.c             | 115
>     ++++++
>     >     >>     >>  drivers/vfio/platform/vfio_platform.c         | 103
>     +++++
>     >     >>     >>  drivers/vfio/platform/vfio_platform_common.c  | 520
>     >     >>     ++++++++++++++++++++++++++
>     >     >>     >>  drivers/vfio/platform/vfio_platform_irq.c     | 340
>     >     >>     +++++++++++++++++
>     >     >>     >>  drivers/vfio/platform/vfio_platform_private.h |  82
>     ++++
>     >     >>     >>  drivers/vfio/vfio.c                           |   8 +
>     >     >>     >>  drivers/vfio/virqfd.c                         | 213
>     >     +++++++++++
>     >     >>     >>  include/linux/vfio.h                          |  27 ++
>     >     >>     >>  include/uapi/linux/vfio.h                     |   2 +
>     >     >>     >>  16 files changed, 1456 insertions(+), 236 deletions(-)
>     >     >>     >>  create mode 100644 drivers/vfio/platform/Kconfig
>     >     >>     >>  create mode 100644 drivers/vfio/platform/Makefile
>     >     >>     >>  create mode 100644 drivers/vfio/platform/vfio_amba.c
>     >     >>     >>  create mode 100644
>     drivers/vfio/platform/vfio_platform.c
>     >     >>     >>  create mode 100644
>     >     drivers/vfio/platform/vfio_platform_common.c
>     >     >>     >>  create mode 100644
>     drivers/vfio/platform/vfio_platform_irq.c
>     >     >>     >>  create mode 100644
>     >     drivers/vfio/platform/vfio_platform_private.h
>     >     >>     >>  create mode 100644 drivers/vfio/virqfd.c
>     >     >>     >>
>     >     >>     >
>     >     >>
>     >     >>
>     >     >
>     >
>     >
> 
> 
