From: Yoder Stuart-B08248 <B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: RFC:  vfio API changes needed for powerpc (v2)
Date: Thu, 4 Apr 2013 21:38:44 +0000
Message-ID: <9F6FE96B71CF29479FF1CDC8046E15035A29AC@039-SN1MPN1-003.039d.mgd.msft.net>
References: <9F6FE96B71CF29479FF1CDC8046E15035A273C@039-SN1MPN1-003.039d.mgd.msft.net>
	<1365100973.2882.315.camel@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1365100973.2882.315.camel-xdHQ/5r00wBBDLzU/O5InQ@public.gmane.org>
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


> > /*
> >  * VFIO_PAMU_MAP_MSI_BANK
> >  *
> >  * Maps the MSI bank at the specified index and iova.  User space must
> >  * call this ioctl once for each MSI bank (count of banks is returned by
> >  * VFIO_IOMMU_GET_MSI_BANK_COUNT).
> >  * Caller provides struct vfio_pamu_msi_bank_map with all fields set.
> >  * Operates on VFIO file descriptor (/dev/vfio/vfio).
> >  * Return: 0 on success, -errno on failure
> >  */
> >
> > struct vfio_pamu_msi_bank_map {
> >         __u32   argsz;
> >         __u32   msi_bank_index;  /* the index of the MSI bank */
> >         __u64   iova;      /* the iova the bank is to be mapped to */
> > };
> 
> Again, flags.  If we dynamically add or remove devices from a container
> the bank count can change, right?  If bank count goes from 2 to 3, does
> userspace know assume the new bank is [2]?  If bank count goes from 3 to
> 2, which index was that?  If removing a device removes an MSI bank then
> vfio-pamu will automatically do the unmap, right?

My assumption is that the bank count returned by VFIO_IOMMU_GET_MSI_BANK_COUNT
is the max bank count for a platform.  (number will mostly likely always be
3 or 4).  So it won't change as devices are added or removed.

If devices are added or removed, the kernel side can enable or disable
the corresponding MSI windows.  But that is hidden from user space.

Stuart
