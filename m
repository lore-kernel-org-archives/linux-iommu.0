From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH 0/2] VFIO no-iommu
Date: Sun, 11 Oct 2015 12:23:24 -0600
Message-ID: <1444587804.4059.277.camel@redhat.com>
References: <20151009182228.14752.99700.stgit@gimli.home>
	<BN1PR0301MB0627AEEF3B5B7E5FB87ECB29EA320@BN1PR0301MB0627.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <BN1PR0301MB0627AEEF3B5B7E5FB87ECB29EA320-RQSpjbwlmjSD1ymB6+i1+JwN6zqB+hSMnBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: "avi-VrcmuVmyx1hWk0Htik3J/w@public.gmane.org" <avi-VrcmuVmyx1hWk0Htik3J/w@public.gmane.org>, "avi-RmZWMc9puTNJc61us3aD9laTQe2KTcn/@public.gmane.org" <avi-RmZWMc9puTNJc61us3aD9laTQe2KTcn/@public.gmane.org>, "gleb-VrcmuVmyx1hWk0Htik3J/w@public.gmane.org" <gleb-VrcmuVmyx1hWk0Htik3J/w@public.gmane.org>, "corbet-T1hC0tSOHrs@public.gmane.org" <corbet-T1hC0tSOHrs@public.gmane.org>, "bruce.richardson-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <bruce.richardson-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "alexander.duyck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <alexander.duyck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "gleb-RmZWMc9puTNJc61us3aD9laTQe2KTcn/@public.gmane.org" <gleb-RmZWMc9puTNJc61us3aD9laTQe2KTcn/@public.gmane.org>, "stephen-OTpzqLSitTUnbdJkjeBofR2eb7JE58TQ@public.gmane.org" <stephen-OTpzqLSitTUnbdJkjeBofR2eb7JE58TQ@public.gmane.org>, "vladz-RmZWMc9puTNJc61us3aD9laTQe2KTcn/@public.gmane.org" <vladz-RmZWMc9puTNJc61us3aD9laTQe2KTcn/@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "hjk-vqZO0P4V72/QD6PfKP4TzA@public.gmane.org" <hjk-vqZO0P4V72/QD6PfKP4TzA@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Sun, 2015-10-11 at 17:29 +0000, Varun Sethi wrote:
> Hi Alex,
> Thanks for the patch Alex. This would also require support in Qemu to expose the physical address to the VM. Are you looking at that part as well?

Quoting from below:

        It should be obvious, but I always feel obligated to state that
        this does not and will not ever enable device assignment to
        virtual machines on non-IOMMU capable platforms.


I have no intention whatsoever, nor would I encourage or support use of
this mode for assignment to a virtual machine.  VFIO has uses beyond
QEMU.  Thanks,

Alex

> -----Original Message-----
> From: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org [mailto:iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org] On Behalf Of Alex Williamson
> Sent: Saturday, October 10, 2015 12:11 AM
> To: alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
> Cc: avi-VrcmuVmyx1hWk0Htik3J/w@public.gmane.org; avi-RmZWMc9puTNJc61us3aD9laTQe2KTcn/@public.gmane.org; gleb-VrcmuVmyx1hWk0Htik3J/w@public.gmane.org; mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; bruce.richardson-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org; corbet-T1hC0tSOHrs@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; alexander.duyck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; gleb-RmZWMc9puTNJc61us3aD9laTQe2KTcn/@public.gmane.org; stephen-OTpzqLSitTUnbdJkjeBofR2eb7JE58TQ@public.gmane.org; vladz-RmZWMc9puTNJc61us3aD9laTQe2KTcn/@public.gmane.org; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; hjk-vqZO0P4V72/QD6PfKP4TzA@public.gmane.org; gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
> Subject: [RFC PATCH 0/2] VFIO no-iommu
> 
> Recent patches for UIO have been attempting to add MSI/X support, which unfortunately implies DMA support, which users have been enabling anyway, but was never intended for UIO.  VFIO on the other hand expects an IOMMU to provide isolation of devices, but provides a much more complete device interface, which already supports full MSI/X support.  There's really no way to support userspace drivers with DMA capable devices without an IOMMU to protect the host, but we can at least think about doing it in a way that properly taints the kernel and avoids creating new code duplicating existing code, that does have a supportable use case.
> 
> The diffstat is only so large because I moved vfio.c to vfio_core.c so I could more easily keep the module named vfio.ko while keeping the bulk of the no-iommu support in a separate file that can be optionally compiled.  We're really looking at a couple hundred lines of mostly stub code.  The VFIO_NOIOMMU_IOMMU could certainly be expanded to do page pinning and virt_to_bus() translation, but I didn't want to complicate anything yet.
> 
> I've only compiled this and tested loading the module with the new no-iommu mode enabled, I haven't actually tried to port a DPDK driver to it, though it ought to be a pretty obvious mix of the existing UIO and VFIO versions (set the IOMMU, but avoid using it for mapping, use however bus translations are done w/ UIO).  The core vfio device file is still /dev/vfio/vfio, but all the groups become /dev/vfio-noiommu/$GROUP.
> 
> It should be obvious, but I always feel obligated to state that this does not and will not ever enable device assignment to virtual machines on non-IOMMU capable platforms.
> 
> I'm curious what IOMMU folks think of this.  This hack is really only possible because we don't use iommu_ops for regular DMA, so we can hijack it fairly safely.  I believe that's intended to change though, so this may not be practical long term.  Thanks,
> 
> Alex
> 
> ---
> 
> Alex Williamson (2):
>       vfio: Move vfio.c vfio_core.c
>       vfio: Include no-iommu mode
> 
> 
>  drivers/vfio/Kconfig        |   15 
>  drivers/vfio/Makefile       |    4 
>  drivers/vfio/vfio.c         | 1640 ------------------------------------------
>  drivers/vfio/vfio_core.c    | 1680 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/vfio/vfio_noiommu.c |  185 +++++
>  drivers/vfio/vfio_private.h |   31 +
>  include/uapi/linux/vfio.h   |    2 
>  7 files changed, 1917 insertions(+), 1640 deletions(-)  delete mode 100644 drivers/vfio/vfio.c  create mode 100644 drivers/vfio/vfio_core.c  create mode 100644 drivers/vfio/vfio_noiommu.c  create mode 100644 drivers/vfio/vfio_private.h _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
