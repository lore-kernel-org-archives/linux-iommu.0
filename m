From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: RFC:  vfio API changes needed for powerpc
Date: Tue, 02 Apr 2013 14:32:17 -0600
Message-ID: <1364934737.2882.149.camel@bling.home>
References: <9F6FE96B71CF29479FF1CDC8046E15035A0F13@039-SN1MPN1-003.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <9F6FE96B71CF29479FF1CDC8046E15035A0F13-TcFNo7jSaXOLgTCmFNXF2K4g8xLGJsHaLnY5E4hWTkheoWH0uzbU5w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Yoder Stuart-B08248 <B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Wood Scott-B07421 <B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org" <qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org>, "agraf-l3A5Bk7waGM@public.gmane.org" <agraf-l3A5Bk7waGM@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Bhushan Bharat-R65777 <R65777-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Stuart,

On Tue, 2013-04-02 at 17:32 +0000, Yoder Stuart-B08248 wrote:
> Alex,
> 
> We are in the process of implementing vfio-pci support for the Freescale
> IOMMU (PAMU).  It is an aperture/window-based IOMMU and is quite different
> than x86, and will involve creating a 'type 2' vfio implementation.
> 
> For each device's DMA mappings, PAMU has an overall aperture and a number
> of windows.  All sizes and window counts must be power of 2.  To illustrate,
> below is a mapping for a 256MB guest, including guest memory (backed by
> 64MB huge pages) and some windows for MSIs:
> 
>     Total aperture: 512MB
>     # of windows: 8
> 
>     win gphys/
>     #   iova        phys          size
>     --- ----        ----          ----
>     0   0x00000000  0xX_XX000000  64MB
>     1   0x04000000  0xX_XX000000  64MB
>     2   0x08000000  0xX_XX000000  64MB
>     3   0x0C000000  0xX_XX000000  64MB
>     4   0x10000000  0xf_fe044000  4KB    // msi bank 1
>     5   0x14000000  0xf_fe045000  4KB    // msi bank 2
>     6   0x18000000  0xf_fe046000  4KB    // msi bank 3
>     7            -             -  disabled
> 
> There are a couple of updates needed to the vfio user->kernel interface
> that we would like your feedback on.
> 
> 1.  IOMMU geometry
> 
>    The kernel IOMMU driver now has an interface (see domain_set_attr,
>    domain_get_attr) that lets us set the domain geometry using
>    "attributes".
> 
>    We want to expose that to user space, so envision needing a couple
>    of new ioctls to do this:
>         VFIO_IOMMU_SET_ATTR
>         VFIO_IOMMU_GET_ATTR     

Any ioctls to the vfiofd (/dev/vfio/vfio) not claimed by vfio-core are
passed to the IOMMU driver.  So you can effectively have your own type2
ioctl extensions.  Alexey has already posted patches to do this for
SPAPR that add VFIO_IOMMU_ENABLE/DISABLE to allow him access to
VFIO_IOMMU_GET_INFO to examine locked page requirements.  As Scott notes
we need to come up with a clean userspace interface for these though.

> 2.   MSI window mappings
> 
>    The more problematic question is how to deal with MSIs.  We need to
>    create mappings for up to 3 MSI banks that a device may need to target
>    to generate interrupts.  The Linux MSI driver can allocate MSIs from
>    the 3 banks any way it wants, and currently user space has no way of
>    knowing which bank may be used for a given device.   
> 
>    There are 3 options we have discussed and would like your direction:
> 
>    A.  Implicit mappings -- with this approach user space would not
>        explicitly map MSIs.  User space would be required to set the
>        geometry so that there are 3 unused windows (the last 3 windows)
>        for MSIs, and it would be up to the kernel to create the mappings.
>        This approach requires some specific semantics (leaving 3 windows)
>        and it potentially gets a little weird-- when should the kernel
>        actually create the MSI mappings?  When should they be unmapped?
>        Some convention would need to be established.

VFIO would have control of SET/GET_ATTR, right?  So we could reduce the
number exposed to userspace on GET and transparently add MSI entries on
SET.  On x86 the interrupt remapper handles this transparently when MSI
is enabled and userspace never gets direct access to the device MSI
address/data registers.  What kind of restrictions do you have around
adding and removing windows while the aperture is enabled?

>    B.  Explicit mapping using DMA map flags.  The idea is that a new
>        flag to DMA map (VFIO_DMA_MAP_FLAG_MSI) would mean that
>        a mapping is to be created for the supplied iova.  No vaddr
>        is given though.  So in the above example there would be a
>        a dma map at 0x10000000 for 24KB (and no vaddr).   It's
>        up to the kernel to determine which bank gets mapped where.
>        So, this option puts user space in control of which windows
>        are used for MSIs and when MSIs are mapped/unmapped.   There
>        would need to be some semantics as to how this is used-- it
>        only makes sense

This could also be done as another "type2" ioctl extension.  What's the
value to userspace in determining which windows are used by which banks?
It sounds like the case that there are X banks and if userspace wants to
use MSI it needs to leave X windows available for that.  Is this just
buying userspace a few more windows to allow them the choice between MSI
or RAM?

>    C.  Explicit mapping using normal DMA map.  The last idea is that
>        we would introduce a new ioctl to give user-space an fd to 
>        the MSI bank, which could be mmapped.  The flow would be
>        something like this:
>           -for each group user space calls new ioctl VFIO_GROUP_GET_MSI_FD
>           -user space mmaps the fd, getting a vaddr
>           -user space does a normal DMA map for desired iova
>        This approach makes everything explicit, but adds a new ioctl
>        applicable most likely only to the PAMU (type2 iommu).

And the DMA_MAP of that mmap then allows userspace to select the window
used?  This one seems like a lot of overhead, adding a new ioctl, new
fd, mmap, special mapping path, etc.  It would be less overhead to just
add an ioctl to enable MSI, maybe letting userspace pick which windows
get used, but I'm still not sure what the value is to userspace in
exposing it.  Thanks,

Alex
