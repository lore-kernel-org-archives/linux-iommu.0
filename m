From: Yoder Stuart-B08248 <B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RFC:  vfio API changes needed for powerpc (v2)
Date: Thu, 4 Apr 2013 17:32:46 +0000
Message-ID: <9F6FE96B71CF29479FF1CDC8046E15035A273C@039-SN1MPN1-003.039d.mgd.msft.net>
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

Based on the email thread over the last couple of days, I have
below an more concrete proposal (v2) for new ioctls supporting vfio-pci
on SoCs with the Freescale PAMU.

Example usage is as described by Scott:

count = VFIO_IOMMU_GET_MSI_BANK_COUNT
VFIO_IOMMU_SET_ATTR(ATTR_GEOMETRY)
VFIO_IOMMU_SET_ATTR(ATTR_WINDOWS)
// do other DMA maps now, or later, or not at all, doesn't matter
for (i = 0; i < count; i++)
        VFIO_IOMMU_MAP_MSI_BANK(iova, i);
// The kernel now knows where each bank has been mapped, and can
//   update PCI config space appropriately.

Thanks,
Stuart

----------------------------------------------------------------------------

The Freescale PAMU is an aperture-based IOMMU with the following 
characteristics.  Each device has an entry in a table in memory
describing the iova->phys mapping. The mapping has:
   -an overall aperture that is power of 2 sized, and has a start iova that
    is naturally aligned
   -has 1 or more windows within the aperture
      -number of windows must be power of 2, max is 256
      -size of each window is determined by aperture size / # of windows
      -iova of each window is determined by aperture start iova / # of windows
      -the mapped region in each window can be different than
       the window size...mapping must power of 2 
      -physical address of the mapping must be naturally aligned
       with the mapping size

/*
 * VFIO_PAMU_GET_ATTR
 *
 * Gets the iommu attributes for the current vfio container.  This 
 * ioctl is applicable to an iommu type of VFIO_PAMU only.
 * Caller sets argsz and attribute.  The ioctl fills in
 * the provided struct vfio_pamu_attr based on the attribute
 * value that was set.
 * Operates on VFIO file descriptor (/dev/vfio/vfio).
 * Return: 0 on success, -errno on failure
 */
struct vfio_pamu_attr {
        __u32   argsz;
        __u32   attribute;
#define VFIO_ATTR_GEOMETRY     1
#define VFIO_ATTR_WINDOWS      2
#define VFIO_ATTR_PAMU_STASH   3

        /* fowlling fields are for VFIO_ATTR_GEOMETRY */
        __u64 aperture_start; /* first address that can be mapped    */
        __u64 aperture_end;   /* last address that can be mapped     */

        /* follwing fields are for VFIO_ATTR_WINDOWS */
        __u32 windows;        /* number of windows in the aperture */
                              /* initially this will be the max number
                               * of windows that can be set
                               */

        /* following fields are for VFIO_ATTR_PAMU_STASH */
        __u32 cpu;            /* CPU number for stashing */
        __u32 cache;          /* cache ID for stashing */
};
#define VFIO_PAMU_GET_ATTR  _IO(VFIO_TYPE, VFIO_BASE + x,
        struct vfio_pamu_attr)

/*
 * VFIO_PAMU_SET_ATTR
 *
 * Sets the iommu attributes for the current vfio container.  This 
 * ioctl is applicable to an iommu type of VFIO_PAMU only.
 * Caller sets struct vfio_pamu attr, including argsz and attribute and
 * setting any fields that are valid for the attribute.
 * Operates on VFIO file descriptor (/dev/vfio/vfio).
 * Return: 0 on success, -errno on failure
 */
#define VFIO_PAMU_SET_ATTR  _IO(VFIO_TYPE, VFIO_BASE + x,
        struct vfio_pamu_attr)

/*
 * VFIO_PAMU_GET_MSI_BANK_COUNT
 *
 * Returns the number of MSI banks for this platform.  This tells user space
 * how many aperture windows should be reserved for MSI banks when setting
 * the PAMU geometry and window count.
 * Fills in provided struct vfio_pamu_msi_banks. Caller sets argsz. 
 * Operates on VFIO file descriptor (/dev/vfio/vfio).
 * Return: 0 on success, -errno on failure
 */
struct vfio_pamu_msi_banks {
        __u32   argsz;
        __u32   bank_count;  /* the number of MSI
};
#define VFIO_PAMU_GET_MSI_BANK_COUNT  _IO(VFIO_TYPE, VFIO_BASE + x,
        struct vfio_pamu_msi_banks)

/*
 * VFIO_PAMU_MAP_MSI_BANK
 *
 * Maps the MSI bank at the specified index and iova.  User space must
 * call this ioctl once for each MSI bank (count of banks is returned by
 * VFIO_IOMMU_GET_MSI_BANK_COUNT).
 * Caller provides struct vfio_pamu_msi_bank_map with all fields set.
 * Operates on VFIO file descriptor (/dev/vfio/vfio).
 * Return: 0 on success, -errno on failure
 */

struct vfio_pamu_msi_bank_map {
        __u32   argsz;
        __u32   msi_bank_index;  /* the index of the MSI bank */
        __u64   iova;      /* the iova the bank is to be mapped to */
};

/*
 * VFIO_PAMU_UNMAP_MSI_BANK
 *
 * Unmaps the MSI bank at the specified iova.
 * Caller provides struct vfio_pamu_msi_bank_unmap with all fields set.
 * Operates on VFIO file descriptor (/dev/vfio/vfio).
 * Return: 0 on success, -errno on failure
 */

struct vfio_pamu_msi_bank_unmap {
        __u32   argsz;
        __u64   iova;      /* the iova to be unmapped to */
};
