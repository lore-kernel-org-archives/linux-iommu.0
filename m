From: Bhushan Bharat-R65777 <R65777-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: RFC: vfio API changes needed for powerpc (v3)
Date: Tue, 9 Apr 2013 17:47:13 +0000
Message-ID: <6A3DF150A5B70D4F9B66A25E3F7C888D06FC9ACB@039-SN2MPN1-013.039d.mgd.msft.net>
References: <9F6FE96B71CF29479FF1CDC8046E15035A29FB@039-SN1MPN1-003.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <9F6FE96B71CF29479FF1CDC8046E15035A29FB-TcFNo7jSaXOLgTCmFNXF2K4g8xLGJsHaLnY5E4hWTkheoWH0uzbU5w@public.gmane.org>
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
To: Yoder Stuart-B08248 <B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Wood Scott-B07421 <B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org" <qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org>, "agraf-l3A5Bk7waGM@public.gmane.org" <agraf-l3A5Bk7waGM@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


So now the sequence would be something like:

1)        VFIO_GROUP_SET_CONTAINER     // add groups to the container

2)        VFIO_SET_IOMMU(VFIO_FSL_PAMU)    // set iommu model

3)        count = VFIO_IOMMU_GET_MSI_BANK_COUNT    // returns max # of MSI banks

4)        VFIO_IOMMU_SET_ATTR(ATTR_GEOMETRY) // set overall aperture

5)        VFIO_IOMMU_SET_ATTR(ATTR_WINDOWS) // set # of windows, including MSI banks

6)	 For (int I = 0; I < count; i++)
	 	VFIO_IOMMU_PAMU_MAP_MSI_BANK() // map the MSI banks, do not enable aperture here.

7)	 Memory Listener will call-> VFIO_IOMMU_MAP_DMA    // map the guest's memory
               ---> kernel enables aperture here on first VFIO_IOMMU_MAP_DMA

8)        VFIO_DEVICE_SET_IRQS
               ---> VFIO in kernel makes pci_enable_msix()/pci_enable_msi_block() calls, this sets actual MSI addr/data in physical device.
		  ---> As the address set by above APIs is not what we want so
		    -> is using MSIX, VFIO will update address in the MSI-X table
		    -> if using MSI, update MSI address in PCI configuration space.



Thanks
-Bharat


> -----Original Message-----
> From: Yoder Stuart-B08248
> Sent: Friday, April 05, 2013 3:40 AM
> To: Alex Williamson
> Cc: Wood Scott-B07421; agraf-l3A5Bk7waGM@public.gmane.org; Bhushan Bharat-R65777; Sethi Varun-B16395;
> kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> Subject: RFC: vfio API changes needed for powerpc (v3)
> 
> -v3 updates
>    -made vfio_pamu_attr a union, added flags
>    -s/VFIO_PAMU_/VFIO_IOMMU_PAMU_/ for the ioctls to make it more
>     clear which fd is being operated on
>    -added flags to vfio_pamu_msi_bank_map/umap
>    -VFIO_PAMU_GET_MSI_BANK_COUNT now just returns a __u32
>     not a struct
>    -fixed some typos
> 
> ----------------------------------------------------------------------------
> 
> The Freescale PAMU is an aperture-based IOMMU with the following
> characteristics.  Each device has an entry in a table in memory
> describing the iova->phys mapping. The mapping has:
>    -an overall aperture that is power of 2 sized, and has a start iova that
>     is naturally aligned
>    -has 1 or more windows within the aperture
>       -number of windows must be power of 2, max is 256
>       -size of each window is determined by aperture size / # of windows
>       -iova of each window is determined by aperture start iova / # of windows
>       -the mapped region in each window can be different than
>        the window size...mapping must power of 2
>       -physical address of the mapping must be naturally aligned
>        with the mapping size
> 
> These ioctls operate on the VFIO file descriptor (/dev/vfio/vfio).
> 
> /*
>  * VFIO_IOMMU_PAMU_GET_ATTR
>  *
>  * Gets the iommu attributes for the current vfio container.  This
>  * ioctl is applicable to an iommu type of VFIO_PAMU only.
>  * Caller sets argsz and attribute.  The ioctl fills in
>  * the provided struct vfio_pamu_attr based on the attribute
>  * value that was set.
> 
>  * Return: 0 on success, -errno on failure
>  */
> struct vfio_pamu_attr {
>         __u32   argsz;
>         __u32   flags;        /* no flags currently */
>         __u32   attribute;
> 
>         union {
>                 /* VFIO_ATTR_GEOMETRY */
>                 struct {
>                         __u64 aperture_start; /* first addr that can be mapped
> */
>                         __u64 aperture_end;  /* last addr that can be mapped */
>                 } attr;
> 
>                 /* VFIO_ATTR_WINDOWS */
>                 __u32 windows;  /* number of windows in the aperture */
>                                 /* initially this will be the max number
>                                  * of windows that can be set
>                                  */
> 
>                 /* VFIO_ATTR_PAMU_STASH */
>                 struct {
>                         __u32 cpu;     /* CPU number for stashing */
>                         __u32 cache;   /* cache ID for stashing */
>                 } stash;
>         }
> };
> #define VFIO_IOMMU_PAMU_GET_ATTR  _IO(VFIO_TYPE, VFIO_BASE + x,
>         struct vfio_pamu_attr)
> 
> /*
>  * VFIO_IOMMU_PAMU_SET_ATTR
>  *
>  * Sets the iommu attributes for the current vfio container.  This
>  * ioctl is applicable to an iommu type of VFIO_PAMU only.
>  * Caller sets struct vfio_pamu attr, including argsz and attribute and
>  * setting any fields that are valid for the attribute.
>  * Return: 0 on success, -errno on failure
>  */
> #define VFIO_IOMMU_PAMU_SET_ATTR  _IO(VFIO_TYPE, VFIO_BASE + x,
>         struct vfio_pamu_attr)
> 
> /*
>  * VFIO_IOMMU_PAMU_GET_MSI_BANK_COUNT
>  *
>  * Returns the number of MSI banks for this platform.  This tells user space
>  * how many aperture windows should be reserved for MSI banks when setting
>  * the PAMU geometry and window count.
>  * Return: __u32 bank count on success, -errno on failure
>  */
> #define VFIO_IOMMU_PAMU_GET_MSI_BANK_COUNT _IO(VFIO_TYPE, VFIO_BASE + x, __u32)
> 
> /*
>  * VFIO_IOMMU_PAMU_MAP_MSI_BANK
>  *
>  * Maps the MSI bank at the specified index and iova.  User space must
>  * call this ioctl once for each MSI bank (count of banks is returned by
>  * VFIO_IOMMU_PAMU_GET_MSI_BANK_COUNT).
>  * Caller provides struct vfio_pamu_msi_bank_map with all fields set.
>  * Return: 0 on success, -errno on failure
>  */
> 
> struct vfio_pamu_msi_bank_map {
>         __u32   argsz;
>         __u32   flags;     /* no flags currently */
>         __u32   msi_bank_index;  /* the index of the MSI bank */
>         __u64   iova;      /* the iova the bank is to be mapped to */
> };
> #define VFIO_IOMMU_PAMU_MAP_MSI_BANK  _IO(VFIO_TYPE, VFIO_BASE + x,
>         struct vfio_pamu_msi_bank_map )
> 
> /*
>  * VFIO_IOMMU_PAMU_UNMAP_MSI_BANK
>  *
>  * Unmaps the MSI bank at the specified iova.
>  * Caller provides struct vfio_pamu_msi_bank_unmap with all fields set.
>  * Operates on VFIO file descriptor (/dev/vfio/vfio).
>  * Return: 0 on success, -errno on failure
>  */
> 
> struct vfio_pamu_msi_bank_unmap {
>         __u32   argsz;
>         __u32   flags;     /* no flags currently */
>         __u64   iova;      /* the iova to be unmapped to */
> };
> #define VFIO_IOMMU_PAMU_UNMAP_MSI_BANK  _IO(VFIO_TYPE, VFIO_BASE + x,
>         struct vfio_pamu_msi_bank_unmap )
