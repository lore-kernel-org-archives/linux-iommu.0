From: Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: RFC: vfio API changes needed for powerpc
Date: Tue, 2 Apr 2013 14:39:24 -0500
Message-ID: <1364931564.24520.16@snotra>
References: <9F6FE96B71CF29479FF1CDC8046E15035A0F13@039-SN1MPN1-003.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="Flowed"; DelSp="Yes"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <9F6FE96B71CF29479FF1CDC8046E15035A0F13-TcFNo7jSaXOLgTCmFNXF2K4g8xLGJsHaLnY5E4hWTkheoWH0uzbU5w@public.gmane.org>
	(from B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org on Tue Apr  2 12:32:00 2013)
Content-Disposition: inline
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
Cc: Wood Scott-B07421 <B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "agraf-l3A5Bk7waGM@public.gmane.org" <agraf-l3A5Bk7waGM@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org" <qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org>, Bhushan Bharat-R65777 <R65777-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 04/02/2013 12:32:00 PM, Yoder Stuart-B08248 wrote:
> Alex,
> 
> We are in the process of implementing vfio-pci support for the  
> Freescale
> IOMMU (PAMU).  It is an aperture/window-based IOMMU and is quite  
> different
> than x86, and will involve creating a 'type 2' vfio implementation.
> 
> For each device's DMA mappings, PAMU has an overall aperture and a  
> number
> of windows.  All sizes and window counts must be power of 2.  To  
> illustrate,
> below is a mapping for a 256MB guest, including guest memory (backed  
> by
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
> There are a couple of updates needed to the vfio user->kernel  
> interface
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

Note that this means attributes need to be updated for user-API  
appropriateness, such as using fixed-size types.

> 2.   MSI window mappings
> 
>    The more problematic question is how to deal with MSIs.  We need to
>    create mappings for up to 3 MSI banks that a device may need to  
> target
>    to generate interrupts.  The Linux MSI driver can allocate MSIs  
> from
>    the 3 banks any way it wants, and currently user space has no way  
> of
>    knowing which bank may be used for a given device.
> 
>    There are 3 options we have discussed and would like your  
> direction:
> 
>    A.  Implicit mappings -- with this approach user space would not
>        explicitly map MSIs.  User space would be required to set the
>        geometry so that there are 3 unused windows (the last 3  
> windows)

Where does userspace get the number "3" from?  E.g. on newer chips  
there are 4 MSI banks.  Maybe future chips have even more.

>    B.  Explicit mapping using DMA map flags.  The idea is that a new
>        flag to DMA map (VFIO_DMA_MAP_FLAG_MSI) would mean that
>        a mapping is to be created for the supplied iova.  No vaddr
>        is given though.  So in the above example there would be a
>        a dma map at 0x10000000 for 24KB (and no vaddr).

A single 24 KiB mapping wouldn't work (and why 24KB?  What if only one  
MSI group is involved in this VFIO group?  What if four MSI groups are  
involved?).  You'd need to either have a naturally aligned,  
power-of-two sized mapping that covers exactly the pages you want to  
map and no more, or you'd need to create a separate mapping for each  
MSI bank, and due to PAMU subwindow alignment restrictions these  
mappings could not be contiguous in iova-space.

>    C.  Explicit mapping using normal DMA map.  The last idea is that
>        we would introduce a new ioctl to give user-space an fd to
>        the MSI bank, which could be mmapped.  The flow would be
>        something like this:
>           -for each group user space calls new ioctl  
> VFIO_GROUP_GET_MSI_FD
>           -user space mmaps the fd, getting a vaddr
>           -user space does a normal DMA map for desired iova
>        This approach makes everything explicit, but adds a new ioctl
>        applicable most likely only to the PAMU (type2 iommu).

The new ioctl isn't really specific to PAMU (or whatever "type2" is  
supposed to be, which nobody ever explains when I ask), so much as to  
the MSI implementation.  It just exposes the MSI register as another  
device resource (well, technically a groupwide resource, unless we  
expose it on a per-device basis and provide enough information for  
userspace to recognize when it's the same for other devices in the  
group) to be mmapped, which userspace can choose to map in the IOMMU as  
well.

Note that in the explicit case, userspace would have to program the MSI  
iova into the PCI device's config space (or communicate the chosen  
address to the kernel so it can set the config space registers).

-Scott
