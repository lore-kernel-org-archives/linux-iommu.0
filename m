From: Baptiste Reynal <b.reynal-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: Re: [PATCH v11 00/20] VFIO support for platform and ARM AMBA devices
Date: Tue, 20 Jan 2015 16:10:46 +0100
Message-ID: <CAN9JPjEhUhjgnDAMmMGxgFoLkhqQYgvsKeZ2+oDKzWMCe+qzhw@mail.gmail.com>
References: <1420541335-17190-1-git-send-email-a.motakis@virtualopensystems.com>
	<54AF93AB.9030302@linaro.org>
	<CAG8rG2yc1ityUwswPiTR_w5f3tSeX_KB2g06HcPCPARXPHGvfg@mail.gmail.com>
	<CAN9JPjERBVnGku8_BJuesMnzJyQYUgz6rJhL_VrCOgLVQuXyuw@mail.gmail.com>
	<54BCD9A6.4050501@linaro.org> <54BCF846.1070906@linaro.org>
	<CAN9JPjF5sAH-UNKtBhfiHK7cQJBwNwg2UEcrj8sv9Em6MnBVxg@mail.gmail.com>
	<54BD4857.3070707@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3687622641814676273=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <54BD4857.3070707-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, VirtualOpenSystems Technical Team <tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, kvm-arm <kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org>, Christoffer Dall <christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============3687622641814676273==
Content-Type: multipart/alternative; boundary=001a11c2952ae5658c050d16d7ed

--001a11c2952ae5658c050d16d7ed
Content-Type: text/plain; charset=UTF-8

This fix should work, in a more elegant way. Could you confirm ?

I'm sorry I don't have any means to reproduce the bug on my side ...

Thanks,
Baptiste

diff --git a/drivers/vfio/platform/vfio_platform_irq.c
b/drivers/vfio/platform/vfio_platform_irq.c
index 6ade36b..f5f3de0 100644
--- a/drivers/vfio/platform/vfio_platform_irq.c
+++ b/drivers/vfio/platform/vfio_platform_irq.c
@@ -208,6 +208,7 @@ static int vfio_set_trigger(struct vfio_platform_device
*vdev, int index,

        irq->trigger = trigger;

+       irq_set_status_flags(irq->hwirq, IRQ_NOAUTOEN);
        ret = request_irq(irq->hwirq, handler, 0, irq->name, irq);
        if (ret) {
                kfree(irq->name);
@@ -216,12 +217,8 @@ static int vfio_set_trigger(struct
vfio_platform_device *vdev, int index,
                return ret;
        }

-       /* if the IRQ has been masked by the user before setting an eventfd,
-        * then we need to make sure it is properly disabled */
-       spin_lock_irqsave(&irq->lock, flags);
-       if (irq->masked)
-               disable_irq_nosync(irq->hwirq);
-       spin_unlock_irqrestore(&irq->lock, flags);
+       if (!irq->masked)
+               enable_irq(irq->hwirq);

        return 0;
 }

On Mon, Jan 19, 2015 at 7:09 PM, Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:

> Hi Baptiste,
>
> yes it fixes the issue in my use case.
>
> Best Regards
>
> Eric
>
> On 01/19/2015 06:00 PM, Baptiste Reynal wrote:
> > Hi Eric,
> >
> > Thanks for taking time about this issue. I agree with you, there is a
> > problem here. While I think on a better fix and to be sure the problem
> > is here, may you try this patch and tell me if the problem is solved ?
> > (This should work as the automasked_irq_handler doesn't do anything if
> > the IRQ is masked).
> >
> > If you have a suggestion on a fix, you're welcome :)
> >
> > diff --git a/drivers/vfio/platform/vfio_platform_irq.c
> > b/drivers/vfio/platform/vfio_platform_irq.c
> > index 6ade36b..c9bac80 100644
> > --- a/drivers/vfio/platform/vfio_platform_irq.c
> > +++ b/drivers/vfio/platform/vfio_platform_irq.c
> > @@ -184,6 +184,7 @@ static int vfio_set_trigger(struct
> > vfio_platform_device *vdev, int index,
> >         struct eventfd_ctx *trigger;
> >         unsigned long flags;
> >         int ret;
> > +       bool masked;
> >
> >         if (irq->trigger) {
> >                 free_irq(irq->hwirq, irq);
> > @@ -208,6 +209,8 @@ static int vfio_set_trigger(struct
> > vfio_platform_device *vdev, int index,
> >
> >         irq->trigger = trigger;
> >
> > +       masked = irq->masked;
> > +
> >         ret = request_irq(irq->hwirq, handler, 0, irq->name, irq);
> >         if (ret) {
> >                 kfree(irq->name);
> > @@ -219,7 +222,7 @@ static int vfio_set_trigger(struct
> > vfio_platform_device *vdev, int index,
> >         /* if the IRQ has been masked by the user before setting an
> eventfd,
> >          * then we need to make sure it is properly disabled */
> >         spin_lock_irqsave(&irq->lock, flags);
> > -       if (irq->masked)
> > +       if (masked)
> >                 disable_irq_nosync(irq->hwirq);
> >         spin_unlock_irqrestore(&irq->lock, flags);
> >
> > On Mon, Jan 19, 2015 at 1:27 PM, Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
> > <mailto:eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>> wrote:
> >
> >     Hi Baptiste,
> >
> >     I think what happens on the second qemu run is:
> >
> >     an IRQ hits immediatly after request_irq
> >     automasked handler sets masked = true
> >     in vfio_set_trigger following condition becomes true
> >             if (irq->masked)
> >                     disable_irq_nosync(irq->hwirq);
> >     IRQ is disabled twice, in handler and in vfio_set_trigger while
> there is
> >     a single enable in resamplefd handler.
> >     To me you should prevent from entering ISR between request_irq and
> >     disable_irq.
> >
> >     It does not happen on the first run because no IRQ hit.
> >
> >     Please let me know if you share this understanding.
> >
> >     Best Regards
> >
> >     Eric
> >
> >     On 01/19/2015 11:17 AM, Eric Auger wrote:
> >     > Hi Baptiste,
> >     >
> >     > sorry I was off on Friday. you're right I missed the masked field
> was
> >     > reset on init. Nethertheless with current QEMU VFIO code, IRQ runs
> on
> >     > the first run and not on the second one. I investigate on my side
> ...
> >     >
> >     > Best Regards
> >     >
> >     > Eric
> >     >
> >     >
> >     >
> >     >
> >     > On 01/16/2015 02:25 PM, Baptiste Reynal wrote:
> >     >> Hello Eric,
> >     >>
> >     >> I'm not sure I understand the issue here. I tried to reproduce
> >     the bug
> >     >> by triggering an interrupt without unmasking it, but the
> interrupt is
> >     >> unmasked when the program access to the device (vfio_platform_open
> >     >> reinit IRQs).
> >     >>
> >     >> May I have more details on the bug ?
> >     >>
> >     >> Thanks
> >     >>
> >     >> On Fri, Jan 9, 2015 at 12:33 PM, Antonios Motakis
> >     >> <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org
> >     <mailto:a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
> >     >> <mailto:a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org
> >     <mailto:a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>>> wrote:
> >     >>
> >     >>     On Fri, Jan 9, 2015 at 9:39 AM, Eric Auger
> >     <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org <mailto:eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> >     >>     <mailto:eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
> >     <mailto:eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>>> wrote:
> >     >>     > Hi Antonios,
> >     >>     >
> >     >>     > when moving to 3.19rc3 I observe a regression with my xgmac
> >     use case
> >     >>     > (real-time change?).
> >     >>     >
> >     >>     > I guess what happens is when I kill a first qemu session,
> >     guest does not
> >     >>     > have time to complete the virtual IRQ and the unmask is not
> >     performed by
> >     >>     > the virqfd handler. When starting a new QEMU session, the
> irqfd
> >     >>     > signalling is put in place again but since the masked field
> >     is set, the
> >     >>     > IRQ is left unmasked (v11 modification in vfio_set_trigger).
> >     >>     >
> >     >>     > The problem is that we don't discriminate between user mask
> >     action and
> >     >>     > automasked handler action. In case the user did not mask, I
> >     think we
> >     >>     > should reset the masked field when doing the free_irq. What
> >     do you think?
> >     >>
> >     >>     Hello Eric,
> >     >>
> >     >>     I agree, we should reset the masked field for future users.
> >     >>
> >     >>     Best regards
> >     >>     Antonios
> >     >>
> >     >>     >
> >     >>     > Best Regards
> >     >>     >
> >     >>     > Eric
> >     >>     >
> >     >>     > On 01/06/2015 11:48 AM, Antonios Motakis wrote:
> >     >>     >> This patch series aims to implement VFIO support for
> platform
> >     >>     devices that
> >     >>     >> reside behind an IOMMU. Examples of such devices are
> devices
> >     >>     behind an ARM
> >     >>     >> SMMU, or behind a Samsung Exynos System MMU.
> >     >>     >>
> >     >>     >> The API used is based on the existing VFIO API that is
> >     also used
> >     >>     with PCI
> >     >>     >> devices. Only devices that include a basic set of IRQs and
> >     memory
> >     >>     regions are
> >     >>     >> targeted; devices with complex relationships with other
> >     devices
> >     >>     on a device
> >     >>     >> tree are not taken into account at this stage.
> >     >>     >>
> >     >>     >> This patch series may be applied on the following
> >     series/patches:
> >     >>     >>  - [PATCH] driver core: amba: add device binding path
> >     >>     'driver_override'
> >     >>     >>  - [PATCH v3 0/6] vfio: type1: support for ARM SMMUS with
> >     >>     VFIO_IOMMU_TYPE1
> >     >>     >>
> >     >>     >> A copy can be cloned from the branch vfio-platform-v11 at:
> >     >>     >> git-9UaJU3cA/F/QT0dZR+AlfA@public.gmane.org:virtualopensystems/linux-kvm-arm.git
> >     >>     >>
> >     >>     >> Changes since v10:
> >     >>     >>  - Check if interrupt is already masked when setting a new
> >     trigger
> >     >>     >>  - Fixed kasprintf with unchecked return value in VFIO
> >     AMBA driver
> >     >>     >> Changes since v9:
> >     >>     >>  - Reworked the splitting of the patches that decouple
> virqfd
> >     >>     from PCI
> >     >>     >>  - Some styling issues and typos
> >     >>     >>  - Removed superfluous includes
> >     >>     >>  - AMBA devices are now named vfio-amba- suffixed by the
> AMBA
> >     >>     device id
> >     >>     >>  - Several other cleanups and fixes
> >     >>     >> Changes since v8:
> >     >>     >>  - Separate irq handler for edge and level triggered
> >     interrupts
> >     >>     >>  - Mutex based lock for VFIO fd open/release
> >     >>     >>  - Fixed bug where the first region of a platform device
> >     wasn't
> >     >>     exposed
> >     >>     >>  - Read only regions can be MMAPed only read only
> >     >>     >>  - Code cleanups
> >     >>     >> Changes since v7:
> >     >>     >>  - Some initial placeholder functionality for PIO resources
> >     >>     >>  - Cleaned up code for IRQ triggering, masking and
> unmasking
> >     >>     >>  - Some functionality has been removed from this series and
> >     >>     posted separately:
> >     >>     >>    - VFIO_IOMMU_TYPE1 support for ARM SMMUs
> >     >>     >>    - IOMMU NOEXEC patches
> >     >>     >>    - driver_override functionality for AMBA devices
> >     >>     >>  - Several fixes
> >     >>     >> Changes since v6:
> >     >>     >>  - Integrated support for AMBA devices
> >     >>     >>  - Numerous cleanups and fixes
> >     >>     >> Changes since v5:
> >     >>     >>  - Full eventfd support for IRQ masking and unmasking.
> >     >>     >>  - Changed IOMMU_EXEC to IOMMU_NOEXEC, along with related
> >     flags
> >     >>     in VFIO.
> >     >>     >>  - Other fixes based on reviewer comments.
> >     >>     >> Changes since v4:
> >     >>     >>  - Use static offsets for each region in the VFIO device fd
> >     >>     >>  - Include patch in the series for the ARM SMMU to expose
> >     IOMMU_EXEC
> >     >>     >>    availability via IOMMU_CAP_DMA_EXEC
> >     >>     >>  - Rebased on VFIO multi domain support:
> >     >>     >>    - IOMMU_EXEC is now available if at least one IOMMU in
> the
> >     >>     container
> >     >>     >>      supports it
> >     >>     >>    - Expose IOMMU_EXEC if available via the capability
> >     >>     VFIO_IOMMU_PROT_EXEC
> >     >>     >>  - Some bug fixes
> >     >>     >> Changes since v3:
> >     >>     >>  - Use Kim Phillips' driver_probe_device()
> >     >>     >> Changes since v2:
> >     >>     >>  - Fixed Read/Write and MMAP on device regions
> >     >>     >>  - Removed dependency on Device Tree
> >     >>     >>  - Interrupts support
> >     >>     >>  - Interrupt masking/unmasking
> >     >>     >>  - Automask level sensitive interrupts
> >     >>     >>  - Introduced VFIO_DMA_MAP_FLAG_EXEC
> >     >>     >>  - Code clean ups
> >     >>     >>
> >     >>     >> Antonios Motakis (20):
> >     >>     >>   vfio/platform: initial skeleton of VFIO support for
> platform
> >     >>     devices
> >     >>     >>   vfio: platform: probe to devices on the platform bus
> >     >>     >>   vfio: platform: add the VFIO PLATFORM module to Kconfig
> >     >>     >>   vfio: amba: VFIO support for AMBA devices
> >     >>     >>   vfio: amba: add the VFIO for AMBA devices module to
> Kconfig
> >     >>     >>   vfio/platform: return info for bound device
> >     >>     >>   vfio/platform: return info for device memory mapped IO
> >     regions
> >     >>     >>   vfio/platform: read and write support for the device fd
> >     >>     >>   vfio/platform: support MMAP of MMIO regions
> >     >>     >>   vfio/platform: return IRQ info
> >     >>     >>   vfio/platform: initial interrupts support code
> >     >>     >>   vfio/platform: trigger an interrupt via eventfd
> >     >>     >>   vfio/platform: support for level sensitive interrupts
> >     >>     >>   vfio: add a vfio_ prefix to virqfd_enable and
> >     virqfd_disable and
> >     >>     >>     export
> >     >>     >>   vfio: virqfd: rename vfio_pci_virqfd_init and
> >     vfio_pci_virqfd_exit
> >     >>     >>   vfio: add local lock for virqfd instead of depending on
> >     VFIO PCI
> >     >>     >>   vfio: pass an opaque pointer on virqfd initialization
> >     >>     >>   vfio: move eventfd support code for VFIO_PCI to a
> >     separate file
> >     >>     >>   vfio: initialize the virqfd workqueue in VFIO generic
> code
> >     >>     >>   vfio/platform: implement IRQ masking/unmasking via an
> >     eventfd
> >     >>     >>
> >     >>     >>  drivers/vfio/Kconfig                          |   1 +
> >     >>     >>  drivers/vfio/Makefile                         |   5 +-
> >     >>     >>  drivers/vfio/pci/vfio_pci.c                   |   8 -
> >     >>     >>  drivers/vfio/pci/vfio_pci_intrs.c             | 238
> >     +-----------
> >     >>     >>  drivers/vfio/pci/vfio_pci_private.h           |   3 -
> >     >>     >>  drivers/vfio/platform/Kconfig                 |  19 +
> >     >>     >>  drivers/vfio/platform/Makefile                |   8 +
> >     >>     >>  drivers/vfio/platform/vfio_amba.c             | 115 ++++++
> >     >>     >>  drivers/vfio/platform/vfio_platform.c         | 103 +++++
> >     >>     >>  drivers/vfio/platform/vfio_platform_common.c  | 520
> >     >>     ++++++++++++++++++++++++++
> >     >>     >>  drivers/vfio/platform/vfio_platform_irq.c     | 340
> >     >>     +++++++++++++++++
> >     >>     >>  drivers/vfio/platform/vfio_platform_private.h |  82 ++++
> >     >>     >>  drivers/vfio/vfio.c                           |   8 +
> >     >>     >>  drivers/vfio/virqfd.c                         | 213
> >     +++++++++++
> >     >>     >>  include/linux/vfio.h                          |  27 ++
> >     >>     >>  include/uapi/linux/vfio.h                     |   2 +
> >     >>     >>  16 files changed, 1456 insertions(+), 236 deletions(-)
> >     >>     >>  create mode 100644 drivers/vfio/platform/Kconfig
> >     >>     >>  create mode 100644 drivers/vfio/platform/Makefile
> >     >>     >>  create mode 100644 drivers/vfio/platform/vfio_amba.c
> >     >>     >>  create mode 100644 drivers/vfio/platform/vfio_platform.c
> >     >>     >>  create mode 100644
> >     drivers/vfio/platform/vfio_platform_common.c
> >     >>     >>  create mode 100644
> drivers/vfio/platform/vfio_platform_irq.c
> >     >>     >>  create mode 100644
> >     drivers/vfio/platform/vfio_platform_private.h
> >     >>     >>  create mode 100644 drivers/vfio/virqfd.c
> >     >>     >>
> >     >>     >
> >     >>
> >     >>
> >     >
> >
> >
>
>

--001a11c2952ae5658c050d16d7ed
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>This fix should work, in a more elegant way=
. Could you confirm ?<br><br></div>I&#39;m sorry I don&#39;t have any means=
 to reproduce the bug on my side ...<br><br></div>Thanks,<br></div>Baptiste=
<br><div><div><br>diff --git a/drivers/vfio/platform/vfio_platform_irq.c b/=
drivers/vfio/platform/vfio_platform_irq.c<br>index 6ade36b..f5f3de0 100644<=
br>--- a/drivers/vfio/platform/vfio_platform_irq.c<br>+++ b/drivers/vfio/pl=
atform/vfio_platform_irq.c<br>@@ -208,6 +208,7 @@ static int vfio_set_trigg=
er(struct vfio_platform_device *vdev, int index,<br>=C2=A0<br>=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 irq-&gt;trigger =3D trigger;<br>=C2=A0<br>+=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 irq_set_status_flags(irq-&gt;hwirq, IR=
Q_NOAUTOEN);<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D request_=
irq(irq-&gt;hwirq, handler, 0, irq-&gt;name, irq);<br>=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (ret) {<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfree(irq-&gt;name);<br=
>@@ -216,12 +217,8 @@ static int vfio_set_trigger(struct vfio_platform_devi=
ce *vdev, int index,<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;<br>=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 }<br>=C2=A0<br>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* if the IRQ has been masked by the user before setting an eventfd,<br=
>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * then we need to make sure it=
 is properly disabled */<br>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock=
_irqsave(&amp;irq-&gt;lock, flags);<br>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (irq-&gt;masked)<br>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 disable_irq_nosync(irq-&gt;hwirq);<=
br>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_unlock_irqrestore(&amp;irq-&g=
t;lock, flags);<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!irq-&gt;maske=
d)<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 enable_irq(irq-&gt;hwirq);<br>=C2=A0<br>=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;<br>=C2=A0}<br></div></div></div><div =
class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Mon, Jan 19, 2015 a=
t 7:09 PM, Eric Auger <span dir=3D"ltr">&lt;<a href=3D"mailto:eric.auger@li=
naro.org" target=3D"_blank">eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org</a>&gt;</span> wrote:<br>=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hi Baptiste,<br>
<br>
yes it fixes the issue in my use case.<br>
<br>
Best Regards<br>
<br>
Eric<br>
<div><div class=3D"h5"><br>
On 01/19/2015 06:00 PM, Baptiste Reynal wrote:<br>
&gt; Hi Eric,<br>
&gt;<br>
&gt; Thanks for taking time about this issue. I agree with you, there is a<=
br>
&gt; problem here. While I think on a better fix and to be sure the problem=
<br>
&gt; is here, may you try this patch and tell me if the problem is solved ?=
<br>
&gt; (This should work as the automasked_irq_handler doesn&#39;t do anythin=
g if<br>
&gt; the IRQ is masked).<br>
&gt;<br>
&gt; If you have a suggestion on a fix, you&#39;re welcome :)<br>
&gt;<br>
&gt; diff --git a/drivers/vfio/platform/vfio_platform_irq.c<br>
&gt; b/drivers/vfio/platform/vfio_platform_irq.c<br>
&gt; index 6ade36b..c9bac80 100644<br>
&gt; --- a/drivers/vfio/platform/vfio_platform_irq.c<br>
&gt; +++ b/drivers/vfio/platform/vfio_platform_irq.c<br>
&gt; @@ -184,6 +184,7 @@ static int vfio_set_trigger(struct<br>
&gt; vfio_platform_device *vdev, int index,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct eventfd_ctx *trigger;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long flags;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0bool masked;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (irq-&gt;trigger) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free_irq(=
irq-&gt;hwirq, irq);<br>
&gt; @@ -208,6 +209,8 @@ static int vfio_set_trigger(struct<br>
&gt; vfio_platform_device *vdev, int index,<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0irq-&gt;trigger =3D trigger;<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0masked =3D irq-&gt;masked;<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D request_irq(irq-&gt;hwirq, ha=
ndler, 0, irq-&gt;name, irq);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(irq=
-&gt;name);<br>
&gt; @@ -219,7 +222,7 @@ static int vfio_set_trigger(struct<br>
&gt; vfio_platform_device *vdev, int index,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* if the IRQ has been masked by the =
user before setting an eventfd,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * then we need to make sure it is pr=
operly disabled */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock_irqsave(&amp;irq-&gt;lock, =
flags);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0if (irq-&gt;masked)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (masked)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0disable_i=
rq_nosync(irq-&gt;hwirq);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock_irqrestore(&amp;irq-&gt;l=
ock, flags);<br>
&gt;<br>
&gt; On Mon, Jan 19, 2015 at 1:27 PM, Eric Auger &lt;<a href=3D"mailto:eric=
.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org">eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org</a><br>
</div></div><div><div class=3D"h5">&gt; &lt;mailto:<a href=3D"mailto:eric.a=
uger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org">eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org</a>&gt;&gt; wrote:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Hi Baptiste,<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0I think what happens on the second qemu run is:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0an IRQ hits immediatly after request_irq<br>
&gt;=C2=A0 =C2=A0 =C2=A0automasked handler sets masked =3D true<br>
&gt;=C2=A0 =C2=A0 =C2=A0in vfio_set_trigger following condition becomes tru=
e<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (irq-&gt;masked)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0disable_irq_nosync(irq-&gt;hwirq);<br>
&gt;=C2=A0 =C2=A0 =C2=A0IRQ is disabled twice, in handler and in vfio_set_t=
rigger while there is<br>
&gt;=C2=A0 =C2=A0 =C2=A0a single enable in resamplefd handler.<br>
&gt;=C2=A0 =C2=A0 =C2=A0To me you should prevent from entering ISR between =
request_irq and<br>
&gt;=C2=A0 =C2=A0 =C2=A0disable_irq.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0It does not happen on the first run because no IRQ =
hit.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Please let me know if you share this understanding.=
<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Best Regards<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Eric<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0On 01/19/2015 11:17 AM, Eric Auger wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Hi Baptiste,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; sorry I was off on Friday. you&#39;re right I =
missed the masked field was<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; reset on init. Nethertheless with current QEMU=
 VFIO code, IRQ runs on<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; the first run and not on the second one. I inv=
estigate on my side ...<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Best Regards<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Eric<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; On 01/16/2015 02:25 PM, Baptiste Reynal wrote:=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; Hello Eric,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; I&#39;m not sure I understand the issue he=
re. I tried to reproduce<br>
&gt;=C2=A0 =C2=A0 =C2=A0the bug<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; by triggering an interrupt without unmaski=
ng it, but the interrupt is<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; unmasked when the program access to the de=
vice (vfio_platform_open<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; reinit IRQs).<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; May I have more details on the bug ?<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; Thanks<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; On Fri, Jan 9, 2015 at 12:33 PM, Antonios =
Motakis<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; &lt;<a href=3D"mailto:a.motakis@virtualope=
nsystems.com">a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:a.motakis@virtualopens=
ystems.com">a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org</a>&gt;<br>
</div></div>&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; &lt;mailto:<a href=3D"mailto:a=
.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org">a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org</a><br>
<span class=3D"">&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:a.mot=
akis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org">a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org</a>&gt;&gt;&g=
t; wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0On Fri, Jan 9, 2015 at =
9:39 AM, Eric Auger<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"mailto:eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org">eric.a=
uger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org</a> &lt;mailto:<a href=3D"mailto:eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org">eri=
c.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org</a>&gt;<br>
</span>&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a hr=
ef=3D"mailto:eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org">eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org</a><br>
<div class=3D"HOEnZb"><div class=3D"h5">&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:=
<a href=3D"mailto:eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org">eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org</a>&gt;&gt;&=
gt; wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; Hi Antonios,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; when moving to 3.1=
9rc3 I observe a regression with my xgmac<br>
&gt;=C2=A0 =C2=A0 =C2=A0use case<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; (real-time change?=
).<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; I guess what happe=
ns is when I kill a first qemu session,<br>
&gt;=C2=A0 =C2=A0 =C2=A0guest does not<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; have time to compl=
ete the virtual IRQ and the unmask is not<br>
&gt;=C2=A0 =C2=A0 =C2=A0performed by<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; the virqfd handler=
. When starting a new QEMU session, the irqfd<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; signalling is put =
in place again but since the masked field<br>
&gt;=C2=A0 =C2=A0 =C2=A0is set, the<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; IRQ is left unmask=
ed (v11 modification in vfio_set_trigger).<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; The problem is tha=
t we don&#39;t discriminate between user mask<br>
&gt;=C2=A0 =C2=A0 =C2=A0action and<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; automasked handler=
 action. In case the user did not mask, I<br>
&gt;=C2=A0 =C2=A0 =C2=A0think we<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; should reset the m=
asked field when doing the free_irq. What<br>
&gt;=C2=A0 =C2=A0 =C2=A0do you think?<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0Hello Eric,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0I agree, we should rese=
t the masked field for future users.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0Best regards<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0Antonios<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; Best Regards<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; Eric<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; On 01/06/2015 11:4=
8 AM, Antonios Motakis wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; This patch ser=
ies aims to implement VFIO support for platform<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0devices that<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; reside behind =
an IOMMU. Examples of such devices are devices<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0behind an ARM<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; SMMU, or behin=
d a Samsung Exynos System MMU.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; The API used i=
s based on the existing VFIO API that is<br>
&gt;=C2=A0 =C2=A0 =C2=A0also used<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0with PCI<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; devices. Only =
devices that include a basic set of IRQs and<br>
&gt;=C2=A0 =C2=A0 =C2=A0memory<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0regions are<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; targeted; devi=
ces with complex relationships with other<br>
&gt;=C2=A0 =C2=A0 =C2=A0devices<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0on a device<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; tree are not t=
aken into account at this stage.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; This patch ser=
ies may be applied on the following<br>
&gt;=C2=A0 =C2=A0 =C2=A0series/patches:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 - [PATCH=
] driver core: amba: add device binding path<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&#39;driver_override&#3=
9;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 - [PATCH=
 v3 0/6] vfio: type1: support for ARM SMMUS with<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0VFIO_IOMMU_TYPE1<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; A copy can be =
cloned from the branch vfio-platform-v11 at:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; git-9UaJU3cA/F/QT0dZR+AlfA@public.gmane.org=
:virtualopensystems/linux-kvm-arm.git<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; Changes since =
v10:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 - Check =
if interrupt is already masked when setting a new<br>
&gt;=C2=A0 =C2=A0 =C2=A0trigger<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 - Fixed =
kasprintf with unchecked return value in VFIO<br>
&gt;=C2=A0 =C2=A0 =C2=A0AMBA driver<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; Changes since =
v9:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 - Rework=
ed the splitting of the patches that decouple virqfd<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0from PCI<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 - Some s=
tyling issues and typos<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 - Remove=
d superfluous includes<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 - AMBA d=
evices are now named vfio-amba- suffixed by the AMBA<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0device id<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 - Severa=
l other cleanups and fixes<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; Changes since =
v8:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 - Separa=
te irq handler for edge and level triggered<br>
&gt;=C2=A0 =C2=A0 =C2=A0interrupts<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 - Mutex =
based lock for VFIO fd open/release<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 - Fixed =
bug where the first region of a platform device<br>
&gt;=C2=A0 =C2=A0 =C2=A0wasn&#39;t<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0exposed<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 - Read o=
nly regions can be MMAPed only read only<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 - Code c=
leanups<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; Changes since =
v7:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 - Some i=
nitial placeholder functionality for PIO resources<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 - Cleane=
d up code for IRQ triggering, masking and unmasking<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 - Some f=
unctionality has been removed from this series and<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0posted separately:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 -=
 VFIO_IOMMU_TYPE1 support for ARM SMMUs<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 -=
 IOMMU NOEXEC patches<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 -=
 driver_override functionality for AMBA devices<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 - Severa=
l fixes<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; Changes since =
v6:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 - Integr=
ated support for AMBA devices<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 - Numero=
us cleanups and fixes<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; Changes since =
v5:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 - Full e=
ventfd support for IRQ masking and unmasking.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 - Change=
d IOMMU_EXEC to IOMMU_NOEXEC, along with related<br>
&gt;=C2=A0 =C2=A0 =C2=A0flags<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0in VFIO.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 - Other =
fixes based on reviewer comments.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; Changes since =
v4:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 - Use st=
atic offsets for each region in the VFIO device fd<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 - Includ=
e patch in the series for the ARM SMMU to expose<br>
&gt;=C2=A0 =C2=A0 =C2=A0IOMMU_EXEC<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 a=
vailability via IOMMU_CAP_DMA_EXEC<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 - Rebase=
d on VFIO multi domain support:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 -=
 IOMMU_EXEC is now available if at least one IOMMU in the<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0container<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =
=C2=A0 supports it<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 -=
 Expose IOMMU_EXEC if available via the capability<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0VFIO_IOMMU_PROT_EXEC<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 - Some b=
ug fixes<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; Changes since =
v3:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 - Use Ki=
m Phillips&#39; driver_probe_device()<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; Changes since =
v2:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 - Fixed =
Read/Write and MMAP on device regions<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 - Remove=
d dependency on Device Tree<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 - Interr=
upts support<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 - Interr=
upt masking/unmasking<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 - Automa=
sk level sensitive interrupts<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 - Introd=
uced VFIO_DMA_MAP_FLAG_EXEC<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 - Code c=
lean ups<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; Antonios Motak=
is (20):<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0vf=
io/platform: initial skeleton of VFIO support for platform<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0devices<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0vf=
io: platform: probe to devices on the platform bus<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0vf=
io: platform: add the VFIO PLATFORM module to Kconfig<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0vf=
io: amba: VFIO support for AMBA devices<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0vf=
io: amba: add the VFIO for AMBA devices module to Kconfig<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0vf=
io/platform: return info for bound device<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0vf=
io/platform: return info for device memory mapped IO<br>
&gt;=C2=A0 =C2=A0 =C2=A0regions<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0vf=
io/platform: read and write support for the device fd<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0vf=
io/platform: support MMAP of MMIO regions<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0vf=
io/platform: return IRQ info<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0vf=
io/platform: initial interrupts support code<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0vf=
io/platform: trigger an interrupt via eventfd<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0vf=
io/platform: support for level sensitive interrupts<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0vf=
io: add a vfio_ prefix to virqfd_enable and<br>
&gt;=C2=A0 =C2=A0 =C2=A0virqfd_disable and<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =
=C2=A0export<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0vf=
io: virqfd: rename vfio_pci_virqfd_init and<br>
&gt;=C2=A0 =C2=A0 =C2=A0vfio_pci_virqfd_exit<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0vf=
io: add local lock for virqfd instead of depending on<br>
&gt;=C2=A0 =C2=A0 =C2=A0VFIO PCI<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0vf=
io: pass an opaque pointer on virqfd initialization<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0vf=
io: move eventfd support code for VFIO_PCI to a<br>
&gt;=C2=A0 =C2=A0 =C2=A0separate file<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0vf=
io: initialize the virqfd workqueue in VFIO generic code<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0vf=
io/platform: implement IRQ masking/unmasking via an<br>
&gt;=C2=A0 =C2=A0 =C2=A0eventfd<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 drivers/=
vfio/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 drivers/=
vfio/Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A05 +-<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 drivers/=
vfio/pci/vfio_pci.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A08 -<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 drivers/=
vfio/pci/vfio_pci_intrs.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =
238<br>
&gt;=C2=A0 =C2=A0 =C2=A0+-----------<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 drivers/=
vfio/pci/vfio_pci_private.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0=
 =C2=A03 -<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 drivers/=
vfio/platform/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 19 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 drivers/=
vfio/platform/Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A08 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 drivers/=
vfio/platform/vfio_amba.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =
115 ++++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 drivers/=
vfio/platform/vfio_platform.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 103 +++++<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 drivers/=
vfio/platform/vfio_platform_common.c=C2=A0 | 520<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0+++++++++++++++++++++++=
+++<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 drivers/=
vfio/platform/vfio_platform_irq.c=C2=A0 =C2=A0 =C2=A0| 340<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0+++++++++++++++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 drivers/=
vfio/platform/vfio_platform_private.h |=C2=A0 82 ++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 drivers/=
vfio/vfio.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A08 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 drivers/=
vfio/virqfd.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 213<br>
&gt;=C2=A0 =C2=A0 =C2=A0+++++++++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 include/=
linux/vfio.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 27 ++<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 include/=
uapi/linux/vfio.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 16 files=
 changed, 1456 insertions(+), 236 deletions(-)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 create m=
ode 100644 drivers/vfio/platform/Kconfig<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 create m=
ode 100644 drivers/vfio/platform/Makefile<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 create m=
ode 100644 drivers/vfio/platform/vfio_amba.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 create m=
ode 100644 drivers/vfio/platform/vfio_platform.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 create m=
ode 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0drivers/vfio/platform/vfio_platform_common.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 create m=
ode 100644 drivers/vfio/platform/vfio_platform_irq.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 create m=
ode 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0drivers/vfio/platform/vfio_platform_private.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 create m=
ode 100644 drivers/vfio/virqfd.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;<br>
&gt;<br>
<br>
</div></div></blockquote></div><br></div>

--001a11c2952ae5658c050d16d7ed--

--===============3687622641814676273==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3687622641814676273==--
