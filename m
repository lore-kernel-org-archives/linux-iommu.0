From: Baptiste Reynal <b.reynal-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: Re: [PATCH v11 00/20] VFIO support for platform and ARM AMBA devices
Date: Fri, 16 Jan 2015 14:25:03 +0100
Message-ID: <CAN9JPjERBVnGku8_BJuesMnzJyQYUgz6rJhL_VrCOgLVQuXyuw@mail.gmail.com>
References: <1420541335-17190-1-git-send-email-a.motakis@virtualopensystems.com>
	<54AF93AB.9030302@linaro.org>
	<CAG8rG2yc1ityUwswPiTR_w5f3tSeX_KB2g06HcPCPARXPHGvfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1901405275142688878=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAG8rG2yc1ityUwswPiTR_w5f3tSeX_KB2g06HcPCPARXPHGvfg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Cc: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, VirtualOpenSystems Technical Team <tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, kvm-arm <kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org>, Christoffer Dall <christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============1901405275142688878==
Content-Type: multipart/alternative; boundary=001a11c12f8c8125f7050cc4e63d

--001a11c12f8c8125f7050cc4e63d
Content-Type: text/plain; charset=UTF-8

Hello Eric,

I'm not sure I understand the issue here. I tried to reproduce the bug by
triggering an interrupt without unmasking it, but the interrupt is unmasked
when the program access to the device (vfio_platform_open reinit IRQs).

May I have more details on the bug ?

Thanks

On Fri, Jan 9, 2015 at 12:33 PM, Antonios Motakis <
a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org> wrote:

> On Fri, Jan 9, 2015 at 9:39 AM, Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> > Hi Antonios,
> >
> > when moving to 3.19rc3 I observe a regression with my xgmac use case
> > (real-time change?).
> >
> > I guess what happens is when I kill a first qemu session, guest does not
> > have time to complete the virtual IRQ and the unmask is not performed by
> > the virqfd handler. When starting a new QEMU session, the irqfd
> > signalling is put in place again but since the masked field is set, the
> > IRQ is left unmasked (v11 modification in vfio_set_trigger).
> >
> > The problem is that we don't discriminate between user mask action and
> > automasked handler action. In case the user did not mask, I think we
> > should reset the masked field when doing the free_irq. What do you think?
>
> Hello Eric,
>
> I agree, we should reset the masked field for future users.
>
> Best regards
> Antonios
>
> >
> > Best Regards
> >
> > Eric
> >
> > On 01/06/2015 11:48 AM, Antonios Motakis wrote:
> >> This patch series aims to implement VFIO support for platform devices
> that
> >> reside behind an IOMMU. Examples of such devices are devices behind an
> ARM
> >> SMMU, or behind a Samsung Exynos System MMU.
> >>
> >> The API used is based on the existing VFIO API that is also used with
> PCI
> >> devices. Only devices that include a basic set of IRQs and memory
> regions are
> >> targeted; devices with complex relationships with other devices on a
> device
> >> tree are not taken into account at this stage.
> >>
> >> This patch series may be applied on the following series/patches:
> >>  - [PATCH] driver core: amba: add device binding path 'driver_override'
> >>  - [PATCH v3 0/6] vfio: type1: support for ARM SMMUS with
> VFIO_IOMMU_TYPE1
> >>
> >> A copy can be cloned from the branch vfio-platform-v11 at:
> >> git-9UaJU3cA/F/QT0dZR+AlfA@public.gmane.org:virtualopensystems/linux-kvm-arm.git
> >>
> >> Changes since v10:
> >>  - Check if interrupt is already masked when setting a new trigger
> >>  - Fixed kasprintf with unchecked return value in VFIO AMBA driver
> >> Changes since v9:
> >>  - Reworked the splitting of the patches that decouple virqfd from PCI
> >>  - Some styling issues and typos
> >>  - Removed superfluous includes
> >>  - AMBA devices are now named vfio-amba- suffixed by the AMBA device id
> >>  - Several other cleanups and fixes
> >> Changes since v8:
> >>  - Separate irq handler for edge and level triggered interrupts
> >>  - Mutex based lock for VFIO fd open/release
> >>  - Fixed bug where the first region of a platform device wasn't exposed
> >>  - Read only regions can be MMAPed only read only
> >>  - Code cleanups
> >> Changes since v7:
> >>  - Some initial placeholder functionality for PIO resources
> >>  - Cleaned up code for IRQ triggering, masking and unmasking
> >>  - Some functionality has been removed from this series and posted
> separately:
> >>    - VFIO_IOMMU_TYPE1 support for ARM SMMUs
> >>    - IOMMU NOEXEC patches
> >>    - driver_override functionality for AMBA devices
> >>  - Several fixes
> >> Changes since v6:
> >>  - Integrated support for AMBA devices
> >>  - Numerous cleanups and fixes
> >> Changes since v5:
> >>  - Full eventfd support for IRQ masking and unmasking.
> >>  - Changed IOMMU_EXEC to IOMMU_NOEXEC, along with related flags in VFIO.
> >>  - Other fixes based on reviewer comments.
> >> Changes since v4:
> >>  - Use static offsets for each region in the VFIO device fd
> >>  - Include patch in the series for the ARM SMMU to expose IOMMU_EXEC
> >>    availability via IOMMU_CAP_DMA_EXEC
> >>  - Rebased on VFIO multi domain support:
> >>    - IOMMU_EXEC is now available if at least one IOMMU in the container
> >>      supports it
> >>    - Expose IOMMU_EXEC if available via the capability
> VFIO_IOMMU_PROT_EXEC
> >>  - Some bug fixes
> >> Changes since v3:
> >>  - Use Kim Phillips' driver_probe_device()
> >> Changes since v2:
> >>  - Fixed Read/Write and MMAP on device regions
> >>  - Removed dependency on Device Tree
> >>  - Interrupts support
> >>  - Interrupt masking/unmasking
> >>  - Automask level sensitive interrupts
> >>  - Introduced VFIO_DMA_MAP_FLAG_EXEC
> >>  - Code clean ups
> >>
> >> Antonios Motakis (20):
> >>   vfio/platform: initial skeleton of VFIO support for platform devices
> >>   vfio: platform: probe to devices on the platform bus
> >>   vfio: platform: add the VFIO PLATFORM module to Kconfig
> >>   vfio: amba: VFIO support for AMBA devices
> >>   vfio: amba: add the VFIO for AMBA devices module to Kconfig
> >>   vfio/platform: return info for bound device
> >>   vfio/platform: return info for device memory mapped IO regions
> >>   vfio/platform: read and write support for the device fd
> >>   vfio/platform: support MMAP of MMIO regions
> >>   vfio/platform: return IRQ info
> >>   vfio/platform: initial interrupts support code
> >>   vfio/platform: trigger an interrupt via eventfd
> >>   vfio/platform: support for level sensitive interrupts
> >>   vfio: add a vfio_ prefix to virqfd_enable and virqfd_disable and
> >>     export
> >>   vfio: virqfd: rename vfio_pci_virqfd_init and vfio_pci_virqfd_exit
> >>   vfio: add local lock for virqfd instead of depending on VFIO PCI
> >>   vfio: pass an opaque pointer on virqfd initialization
> >>   vfio: move eventfd support code for VFIO_PCI to a separate file
> >>   vfio: initialize the virqfd workqueue in VFIO generic code
> >>   vfio/platform: implement IRQ masking/unmasking via an eventfd
> >>
> >>  drivers/vfio/Kconfig                          |   1 +
> >>  drivers/vfio/Makefile                         |   5 +-
> >>  drivers/vfio/pci/vfio_pci.c                   |   8 -
> >>  drivers/vfio/pci/vfio_pci_intrs.c             | 238 +-----------
> >>  drivers/vfio/pci/vfio_pci_private.h           |   3 -
> >>  drivers/vfio/platform/Kconfig                 |  19 +
> >>  drivers/vfio/platform/Makefile                |   8 +
> >>  drivers/vfio/platform/vfio_amba.c             | 115 ++++++
> >>  drivers/vfio/platform/vfio_platform.c         | 103 +++++
> >>  drivers/vfio/platform/vfio_platform_common.c  | 520
> ++++++++++++++++++++++++++
> >>  drivers/vfio/platform/vfio_platform_irq.c     | 340 +++++++++++++++++
> >>  drivers/vfio/platform/vfio_platform_private.h |  82 ++++
> >>  drivers/vfio/vfio.c                           |   8 +
> >>  drivers/vfio/virqfd.c                         | 213 +++++++++++
> >>  include/linux/vfio.h                          |  27 ++
> >>  include/uapi/linux/vfio.h                     |   2 +
> >>  16 files changed, 1456 insertions(+), 236 deletions(-)
> >>  create mode 100644 drivers/vfio/platform/Kconfig
> >>  create mode 100644 drivers/vfio/platform/Makefile
> >>  create mode 100644 drivers/vfio/platform/vfio_amba.c
> >>  create mode 100644 drivers/vfio/platform/vfio_platform.c
> >>  create mode 100644 drivers/vfio/platform/vfio_platform_common.c
> >>  create mode 100644 drivers/vfio/platform/vfio_platform_irq.c
> >>  create mode 100644 drivers/vfio/platform/vfio_platform_private.h
> >>  create mode 100644 drivers/vfio/virqfd.c
> >>
> >
>

--001a11c12f8c8125f7050cc4e63d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello Eric,<br><br></div>I&#39;m not sure I understan=
d the issue here. I tried to reproduce the bug by triggering an interrupt w=
ithout unmasking it, but the interrupt is unmasked when the program access =
to the device (vfio_platform_open reinit IRQs).<br><br>May I have more deta=
ils on the bug ?<br><br>Thanks<br><div><div><div class=3D"gmail_extra"><br>=
<div class=3D"gmail_quote">On Fri, Jan 9, 2015 at 12:33 PM, Antonios Motaki=
s <span dir=3D"ltr">&lt;<a href=3D"mailto:a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org"=
 target=3D"_blank">a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org</a>&gt;</span> wrote:<b=
r><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex"><span class=3D"">On Fri, Jan 9, 2015 at 9:=
39 AM, Eric Auger &lt;<a href=3D"mailto:eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org">eric.auger@l=
inaro.org</a>&gt; wrote:<br>
&gt; Hi Antonios,<br>
&gt;<br>
&gt; when moving to 3.19rc3 I observe a regression with my xgmac use case<b=
r>
&gt; (real-time change?).<br>
&gt;<br>
&gt; I guess what happens is when I kill a first qemu session, guest does n=
ot<br>
&gt; have time to complete the virtual IRQ and the unmask is not performed =
by<br>
&gt; the virqfd handler. When starting a new QEMU session, the irqfd<br>
&gt; signalling is put in place again but since the masked field is set, th=
e<br>
&gt; IRQ is left unmasked (v11 modification in vfio_set_trigger).<br>
&gt;<br>
&gt; The problem is that we don&#39;t discriminate between user mask action=
 and<br>
&gt; automasked handler action. In case the user did not mask, I think we<b=
r>
&gt; should reset the masked field when doing the free_irq. What do you thi=
nk?<br>
<br>
</span>Hello Eric,<br>
<br>
I agree, we should reset the masked field for future users.<br>
<br>
Best regards<br>
<span class=3D"HOEnZb"><font color=3D"#888888">Antonios<br>
</font></span><div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt;<br>
&gt; Best Regards<br>
&gt;<br>
&gt; Eric<br>
&gt;<br>
&gt; On 01/06/2015 11:48 AM, Antonios Motakis wrote:<br>
&gt;&gt; This patch series aims to implement VFIO support for platform devi=
ces that<br>
&gt;&gt; reside behind an IOMMU. Examples of such devices are devices behin=
d an ARM<br>
&gt;&gt; SMMU, or behind a Samsung Exynos System MMU.<br>
&gt;&gt;<br>
&gt;&gt; The API used is based on the existing VFIO API that is also used w=
ith PCI<br>
&gt;&gt; devices. Only devices that include a basic set of IRQs and memory =
regions are<br>
&gt;&gt; targeted; devices with complex relationships with other devices on=
 a device<br>
&gt;&gt; tree are not taken into account at this stage.<br>
&gt;&gt;<br>
&gt;&gt; This patch series may be applied on the following series/patches:<=
br>
&gt;&gt;=C2=A0 - [PATCH] driver core: amba: add device binding path &#39;dr=
iver_override&#39;<br>
&gt;&gt;=C2=A0 - [PATCH v3 0/6] vfio: type1: support for ARM SMMUS with VFI=
O_IOMMU_TYPE1<br>
&gt;&gt;<br>
&gt;&gt; A copy can be cloned from the branch vfio-platform-v11 at:<br>
&gt;&gt; git-9UaJU3cA/F/QT0dZR+AlfA@public.gmane.org:virtualopensystems/linux-kvm-arm.git<br>
&gt;&gt;<br>
&gt;&gt; Changes since v10:<br>
&gt;&gt;=C2=A0 - Check if interrupt is already masked when setting a new tr=
igger<br>
&gt;&gt;=C2=A0 - Fixed kasprintf with unchecked return value in VFIO AMBA d=
river<br>
&gt;&gt; Changes since v9:<br>
&gt;&gt;=C2=A0 - Reworked the splitting of the patches that decouple virqfd=
 from PCI<br>
&gt;&gt;=C2=A0 - Some styling issues and typos<br>
&gt;&gt;=C2=A0 - Removed superfluous includes<br>
&gt;&gt;=C2=A0 - AMBA devices are now named vfio-amba- suffixed by the AMBA=
 device id<br>
&gt;&gt;=C2=A0 - Several other cleanups and fixes<br>
&gt;&gt; Changes since v8:<br>
&gt;&gt;=C2=A0 - Separate irq handler for edge and level triggered interrup=
ts<br>
&gt;&gt;=C2=A0 - Mutex based lock for VFIO fd open/release<br>
&gt;&gt;=C2=A0 - Fixed bug where the first region of a platform device wasn=
&#39;t exposed<br>
&gt;&gt;=C2=A0 - Read only regions can be MMAPed only read only<br>
&gt;&gt;=C2=A0 - Code cleanups<br>
&gt;&gt; Changes since v7:<br>
&gt;&gt;=C2=A0 - Some initial placeholder functionality for PIO resources<b=
r>
&gt;&gt;=C2=A0 - Cleaned up code for IRQ triggering, masking and unmasking<=
br>
&gt;&gt;=C2=A0 - Some functionality has been removed from this series and p=
osted separately:<br>
&gt;&gt;=C2=A0 =C2=A0 - VFIO_IOMMU_TYPE1 support for ARM SMMUs<br>
&gt;&gt;=C2=A0 =C2=A0 - IOMMU NOEXEC patches<br>
&gt;&gt;=C2=A0 =C2=A0 - driver_override functionality for AMBA devices<br>
&gt;&gt;=C2=A0 - Several fixes<br>
&gt;&gt; Changes since v6:<br>
&gt;&gt;=C2=A0 - Integrated support for AMBA devices<br>
&gt;&gt;=C2=A0 - Numerous cleanups and fixes<br>
&gt;&gt; Changes since v5:<br>
&gt;&gt;=C2=A0 - Full eventfd support for IRQ masking and unmasking.<br>
&gt;&gt;=C2=A0 - Changed IOMMU_EXEC to IOMMU_NOEXEC, along with related fla=
gs in VFIO.<br>
&gt;&gt;=C2=A0 - Other fixes based on reviewer comments.<br>
&gt;&gt; Changes since v4:<br>
&gt;&gt;=C2=A0 - Use static offsets for each region in the VFIO device fd<b=
r>
&gt;&gt;=C2=A0 - Include patch in the series for the ARM SMMU to expose IOM=
MU_EXEC<br>
&gt;&gt;=C2=A0 =C2=A0 availability via IOMMU_CAP_DMA_EXEC<br>
&gt;&gt;=C2=A0 - Rebased on VFIO multi domain support:<br>
&gt;&gt;=C2=A0 =C2=A0 - IOMMU_EXEC is now available if at least one IOMMU i=
n the container<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 supports it<br>
&gt;&gt;=C2=A0 =C2=A0 - Expose IOMMU_EXEC if available via the capability V=
FIO_IOMMU_PROT_EXEC<br>
&gt;&gt;=C2=A0 - Some bug fixes<br>
&gt;&gt; Changes since v3:<br>
&gt;&gt;=C2=A0 - Use Kim Phillips&#39; driver_probe_device()<br>
&gt;&gt; Changes since v2:<br>
&gt;&gt;=C2=A0 - Fixed Read/Write and MMAP on device regions<br>
&gt;&gt;=C2=A0 - Removed dependency on Device Tree<br>
&gt;&gt;=C2=A0 - Interrupts support<br>
&gt;&gt;=C2=A0 - Interrupt masking/unmasking<br>
&gt;&gt;=C2=A0 - Automask level sensitive interrupts<br>
&gt;&gt;=C2=A0 - Introduced VFIO_DMA_MAP_FLAG_EXEC<br>
&gt;&gt;=C2=A0 - Code clean ups<br>
&gt;&gt;<br>
&gt;&gt; Antonios Motakis (20):<br>
&gt;&gt;=C2=A0 =C2=A0vfio/platform: initial skeleton of VFIO support for pl=
atform devices<br>
&gt;&gt;=C2=A0 =C2=A0vfio: platform: probe to devices on the platform bus<b=
r>
&gt;&gt;=C2=A0 =C2=A0vfio: platform: add the VFIO PLATFORM module to Kconfi=
g<br>
&gt;&gt;=C2=A0 =C2=A0vfio: amba: VFIO support for AMBA devices<br>
&gt;&gt;=C2=A0 =C2=A0vfio: amba: add the VFIO for AMBA devices module to Kc=
onfig<br>
&gt;&gt;=C2=A0 =C2=A0vfio/platform: return info for bound device<br>
&gt;&gt;=C2=A0 =C2=A0vfio/platform: return info for device memory mapped IO=
 regions<br>
&gt;&gt;=C2=A0 =C2=A0vfio/platform: read and write support for the device f=
d<br>
&gt;&gt;=C2=A0 =C2=A0vfio/platform: support MMAP of MMIO regions<br>
&gt;&gt;=C2=A0 =C2=A0vfio/platform: return IRQ info<br>
&gt;&gt;=C2=A0 =C2=A0vfio/platform: initial interrupts support code<br>
&gt;&gt;=C2=A0 =C2=A0vfio/platform: trigger an interrupt via eventfd<br>
&gt;&gt;=C2=A0 =C2=A0vfio/platform: support for level sensitive interrupts<=
br>
&gt;&gt;=C2=A0 =C2=A0vfio: add a vfio_ prefix to virqfd_enable and virqfd_d=
isable and<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0export<br>
&gt;&gt;=C2=A0 =C2=A0vfio: virqfd: rename vfio_pci_virqfd_init and vfio_pci=
_virqfd_exit<br>
&gt;&gt;=C2=A0 =C2=A0vfio: add local lock for virqfd instead of depending o=
n VFIO PCI<br>
&gt;&gt;=C2=A0 =C2=A0vfio: pass an opaque pointer on virqfd initialization<=
br>
&gt;&gt;=C2=A0 =C2=A0vfio: move eventfd support code for VFIO_PCI to a sepa=
rate file<br>
&gt;&gt;=C2=A0 =C2=A0vfio: initialize the virqfd workqueue in VFIO generic =
code<br>
&gt;&gt;=C2=A0 =C2=A0vfio/platform: implement IRQ masking/unmasking via an =
eventfd<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 drivers/vfio/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;&gt;=C2=A0 drivers/vfio/Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A05 +-<br>
&gt;&gt;=C2=A0 drivers/vfio/pci/vfio_pci.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A08 -<br>
&gt;&gt;=C2=A0 drivers/vfio/pci/vfio_pci_intrs.c=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0| 238 +-----------<br>
&gt;&gt;=C2=A0 drivers/vfio/pci/vfio_pci_private.h=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A03 -<br>
&gt;&gt;=C2=A0 drivers/vfio/platform/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 19 +<br>
&gt;&gt;=C2=A0 drivers/vfio/platform/Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A08 +<br>
&gt;&gt;=C2=A0 drivers/vfio/platform/vfio_amba.c=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0| 115 ++++++<br>
&gt;&gt;=C2=A0 drivers/vfio/platform/vfio_platform.c=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| 103 +++++<br>
&gt;&gt;=C2=A0 drivers/vfio/platform/vfio_platform_common.c=C2=A0 | 520 +++=
+++++++++++++++++++++++<br>
&gt;&gt;=C2=A0 drivers/vfio/platform/vfio_platform_irq.c=C2=A0 =C2=A0 =C2=
=A0| 340 +++++++++++++++++<br>
&gt;&gt;=C2=A0 drivers/vfio/platform/vfio_platform_private.h |=C2=A0 82 +++=
+<br>
&gt;&gt;=C2=A0 drivers/vfio/vfio.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A08 +<b=
r>
&gt;&gt;=C2=A0 drivers/vfio/virqfd.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 213 +++++++++++<br>
&gt;&gt;=C2=A0 include/linux/vfio.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 27 ++<br>
&gt;&gt;=C2=A0 include/uapi/linux/vfio.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +<br>
&gt;&gt;=C2=A0 16 files changed, 1456 insertions(+), 236 deletions(-)<br>
&gt;&gt;=C2=A0 create mode 100644 drivers/vfio/platform/Kconfig<br>
&gt;&gt;=C2=A0 create mode 100644 drivers/vfio/platform/Makefile<br>
&gt;&gt;=C2=A0 create mode 100644 drivers/vfio/platform/vfio_amba.c<br>
&gt;&gt;=C2=A0 create mode 100644 drivers/vfio/platform/vfio_platform.c<br>
&gt;&gt;=C2=A0 create mode 100644 drivers/vfio/platform/vfio_platform_commo=
n.c<br>
&gt;&gt;=C2=A0 create mode 100644 drivers/vfio/platform/vfio_platform_irq.c=
<br>
&gt;&gt;=C2=A0 create mode 100644 drivers/vfio/platform/vfio_platform_priva=
te.h<br>
&gt;&gt;=C2=A0 create mode 100644 drivers/vfio/virqfd.c<br>
&gt;&gt;<br>
&gt;<br>
</div></div></blockquote></div><br></div></div></div></div>

--001a11c12f8c8125f7050cc4e63d--

--===============1901405275142688878==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1901405275142688878==--
