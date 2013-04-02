From: Yoder Stuart-B08248 <B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RFC:  vfio API changes needed for powerpc
Date: Tue, 2 Apr 2013 17:32:00 +0000
Message-ID: <9F6FE96B71CF29479FF1CDC8046E15035A0F13@039-SN1MPN1-003.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
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
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Wood Scott-B07421 <B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org" <qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org>, "agraf-l3A5Bk7waGM@public.gmane.org" <agraf-l3A5Bk7waGM@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Bhushan Bharat-R65777 <R65777-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Alex,

We are in the process of implementing vfio-pci support for the Freescale
IOMMU (PAMU).  It is an aperture/window-based IOMMU and is quite different
than x86, and will involve creating a 'type 2' vfio implementation.

For each device's DMA mappings, PAMU has an overall aperture and a number
of windows.  All sizes and window counts must be power of 2.  To illustrate,
below is a mapping for a 256MB guest, including guest memory (backed by
64MB huge pages) and some windows for MSIs:

    Total aperture: 512MB
    # of windows: 8

    win gphys/
    #   iova        phys          size
    --- ----        ----          ----
    0   0x00000000  0xX_XX000000  64MB
    1   0x04000000  0xX_XX000000  64MB
    2   0x08000000  0xX_XX000000  64MB
    3   0x0C000000  0xX_XX000000  64MB
    4   0x10000000  0xf_fe044000  4KB    // msi bank 1
    5   0x14000000  0xf_fe045000  4KB    // msi bank 2
    6   0x18000000  0xf_fe046000  4KB    // msi bank 3
    7            -             -  disabled

There are a couple of updates needed to the vfio user->kernel interface
that we would like your feedback on.

1.  IOMMU geometry

   The kernel IOMMU driver now has an interface (see domain_set_attr,
   domain_get_attr) that lets us set the domain geometry using
   "attributes".

   We want to expose that to user space, so envision needing a couple
   of new ioctls to do this:
        VFIO_IOMMU_SET_ATTR
        VFIO_IOMMU_GET_ATTR     

2.   MSI window mappings

   The more problematic question is how to deal with MSIs.  We need to
   create mappings for up to 3 MSI banks that a device may need to target
   to generate interrupts.  The Linux MSI driver can allocate MSIs from
   the 3 banks any way it wants, and currently user space has no way of
   knowing which bank may be used for a given device.   

   There are 3 options we have discussed and would like your direction:

   A.  Implicit mappings -- with this approach user space would not
       explicitly map MSIs.  User space would be required to set the
       geometry so that there are 3 unused windows (the last 3 windows)
       for MSIs, and it would be up to the kernel to create the mappings.
       This approach requires some specific semantics (leaving 3 windows)
       and it potentially gets a little weird-- when should the kernel
       actually create the MSI mappings?  When should they be unmapped?
       Some convention would need to be established.

   B.  Explicit mapping using DMA map flags.  The idea is that a new
       flag to DMA map (VFIO_DMA_MAP_FLAG_MSI) would mean that
       a mapping is to be created for the supplied iova.  No vaddr
       is given though.  So in the above example there would be a
       a dma map at 0x10000000 for 24KB (and no vaddr).   It's
       up to the kernel to determine which bank gets mapped where.
       So, this option puts user space in control of which windows
       are used for MSIs and when MSIs are mapped/unmapped.   There
       would need to be some semantics as to how this is used-- it
       only makes sense

   C.  Explicit mapping using normal DMA map.  The last idea is that
       we would introduce a new ioctl to give user-space an fd to 
       the MSI bank, which could be mmapped.  The flow would be
       something like this:
          -for each group user space calls new ioctl VFIO_GROUP_GET_MSI_FD
          -user space mmaps the fd, getting a vaddr
          -user space does a normal DMA map for desired iova
       This approach makes everything explicit, but adds a new ioctl
       applicable most likely only to the PAMU (type2 iommu).

Any feedback or direction?

Thanks,
Stuart 
    
