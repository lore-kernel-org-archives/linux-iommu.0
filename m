From: "Bharat.Bhushan-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Bharat.Bhushan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH v9 03/19] vfio: platform: add the VFIO PLATFORM module to
	Kconfig
Date: Wed, 12 Nov 2014 11:00:16 +0000
Message-ID: <a3bfa6c9705d4dd8a345e4a2e5ff3cbb@BN3PR0301MB1265.namprd03.prod.outlook.com>
References: <1414433284-31719-1-git-send-email-a.motakis@virtualopensystems.com>
	<1414433284-31719-4-git-send-email-a.motakis@virtualopensystems.com>
	<CAOhR-w2N3SF=3DTgFr22JfAKDXxzz0PASznJaRjK3oBrRTVcsw@mail.gmail.com>
	<d3c4a63eaa294f1987a797a39eed4650@BN3PR0301MB1265.namprd03.prod.outlook.com>
	<CAOhR-w305sv-_D3QNCtifkzODTv0XoPKBEs6C2MRT1fPVKjZ8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAOhR-w305sv-_D3QNCtifkzODTv0XoPKBEs6C2MRT1fPVKjZ8A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Hongbo Zhang <hongbo.zhang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "open list:VFIO DRIVER" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, "tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org" <tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, "kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org" <kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Hongbo Zhang [mailto:hongbo.zhang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org]
> Sent: Wednesday, November 12, 2014 4:09 PM
> To: Bhushan Bharat-R65777
> Cc: Antonios Motakis; open list:VFIO DRIVER; will.deacon-5wv7dgnIgG8@public.gmane.org;
> alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; open list; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org;
> tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org; kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org
> Subject: Re: [PATCH v9 03/19] vfio: platform: add the VFIO PLATFORM module to
> Kconfig
> 
> On 12 November 2014 18:05, Bharat.Bhushan-KZfg59tc24xl57MIdRCFDg@public.gmane.org
> <Bharat.Bhushan-KZfg59tc24xl57MIdRCFDg@public.gmane.org> wrote:
> > Hi,
> >
> >
> >
> > This is not yet supported on Freescale PowerPC. I am still in process
> > of upstreaming the FSL PAMU specific patches for same.
> >
> > Initial plan is to test with PCIe devices and then with Platform devices.
> >
> 
> I see there is already driver/iommu/fsl_pamu.c, doesn't it work?

We need VFIO iommu driver for same.

> Could you explain briefly what is wrong? I've heard that the vfio pci works on
> powerpc platforms.

Yes, patches are in Freescale internal git repository. But those patches are yet to be upstreamed. I have started working on same.

Thanks
-Bharat

> 
> >
> >
> > Thanks
> >
> > -Bharat
> >
> >
> >
> > From: kvmarm-bounces-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org
> > [mailto:kvmarm-bounces-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org] On Behalf Of Hongbo
> > Zhang
> > Sent: Wednesday, November 12, 2014 3:08 PM
> > To: Antonios Motakis
> > Cc: open list:VFIO DRIVER; will.deacon-5wv7dgnIgG8@public.gmane.org;
> > alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; open list;
> > iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org;
> > kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org
> > Subject: Re: [PATCH v9 03/19] vfio: platform: add the VFIO PLATFORM
> > module to Kconfig
> >
> >
> >
> >
> >
> >
> >
> > On 28 October 2014 02:07, Antonios Motakis
> > <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org> wrote:
> >
> > Enable building the VFIO PLATFORM driver that allows to use Linux
> > platform devices with VFIO.
> >
> > Signed-off-by: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
> > ---
> >  drivers/vfio/Kconfig           | 1 +
> >  drivers/vfio/Makefile          | 1 +
> >  drivers/vfio/platform/Kconfig  | 9 +++++++++
> > drivers/vfio/platform/Makefile | 4 ++++
> >  4 files changed, 15 insertions(+)
> >  create mode 100644 drivers/vfio/platform/Kconfig  create mode 100644
> > drivers/vfio/platform/Makefile
> >
> > diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig index
> > a0abe04..962fb80 100644
> > --- a/drivers/vfio/Kconfig
> > +++ b/drivers/vfio/Kconfig
> > @@ -27,3 +27,4 @@ menuconfig VFIO
> >           If you don't know what to do here, say N.
> >
> >  source "drivers/vfio/pci/Kconfig"
> > +source "drivers/vfio/platform/Kconfig"
> > diff --git a/drivers/vfio/Makefile b/drivers/vfio/Makefile index
> > 0b035b1..dadf0ca 100644
> > --- a/drivers/vfio/Makefile
> > +++ b/drivers/vfio/Makefile
> > @@ -3,3 +3,4 @@ obj-$(CONFIG_VFIO_IOMMU_TYPE1) += vfio_iommu_type1.o
> >  obj-$(CONFIG_VFIO_IOMMU_SPAPR_TCE) += vfio_iommu_spapr_tce.o
> >  obj-$(CONFIG_VFIO_SPAPR_EEH) += vfio_spapr_eeh.o
> >  obj-$(CONFIG_VFIO_PCI) += pci/
> > +obj-$(CONFIG_VFIO_PLATFORM) += platform/
> > diff --git a/drivers/vfio/platform/Kconfig
> > b/drivers/vfio/platform/Kconfig new file mode 100644 index
> > 0000000..c51af17
> > --- /dev/null
> > +++ b/drivers/vfio/platform/Kconfig
> > @@ -0,0 +1,9 @@
> > +config VFIO_PLATFORM
> > +       tristate "VFIO support for platform devices"
> > +       depends on VFIO && EVENTFD && ARM
> >
> >
> >
> > Hi Antonios,
> >
> > Is this only for ARM? how about X86 and PowerPC?
> >
> > On Freescale's PowerPC platform, the IOMMU is called PAMU (Peripheral
> > Access Management Unit), and I am trying to use this VFIO framework on it.
> >
> >
> >
> > +       help
> > +         Support for platform devices with VFIO. This is required to make
> > +         use of platform devices present on the system using the VFIO
> > +         framework.
> > +
> > +         If you don't know what to do here, say N.
> > diff --git a/drivers/vfio/platform/Makefile
> > b/drivers/vfio/platform/Makefile new file mode 100644 index
> > 0000000..279862b
> > --- /dev/null
> > +++ b/drivers/vfio/platform/Makefile
> > @@ -0,0 +1,4 @@
> > +
> > +vfio-platform-y := vfio_platform.o vfio_platform_common.o
> > +
> > +obj-$(CONFIG_VFIO_PLATFORM) += vfio-platform.o
> > --
> > 2.1.1
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe
> > linux-kernel" in the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
> >
