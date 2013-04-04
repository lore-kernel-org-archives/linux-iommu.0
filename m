From: Yoder Stuart-B08248 <B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: RFC: vfio API changes needed for powerpc (v2)
Date: Thu, 4 Apr 2013 23:11:59 +0000
Message-ID: <9F6FE96B71CF29479FF1CDC8046E15035A2B7F@039-SN1MPN1-003.039d.mgd.msft.net>
References: <9F6FE96B71CF29479FF1CDC8046E15035A29AC@039-SN1MPN1-003.039d.mgd.msft.net>
	(from B08248@freescale.com on Thu Apr  4 16:38:44 2013)
	<1365115909.14772.20@snotra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1365115909.14772.20@snotra>
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
To: Wood Scott-B07421 <B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org" <qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "agraf-l3A5Bk7waGM@public.gmane.org" <agraf-l3A5Bk7waGM@public.gmane.org>, Bhushan Bharat-R65777 <R65777-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Thursday, April 04, 2013 5:52 PM
> To: Yoder Stuart-B08248
> Cc: Alex Williamson; Wood Scott-B07421; agraf-l3A5Bk7waGM@public.gmane.org; Bhushan Bharat-R65777; Sethi Varun-B16395;
> kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> Subject: Re: RFC: vfio API changes needed for powerpc (v2)
> 
> On 04/04/2013 04:38:44 PM, Yoder Stuart-B08248 wrote:
> >
> > > > /*
> > > >  * VFIO_PAMU_MAP_MSI_BANK
> > > >  *
> > > >  * Maps the MSI bank at the specified index and iova.  User space
> > must
> > > >  * call this ioctl once for each MSI bank (count of banks is
> > returned by
> > > >  * VFIO_IOMMU_GET_MSI_BANK_COUNT).
> > > >  * Caller provides struct vfio_pamu_msi_bank_map with all fields
> > set.
> > > >  * Operates on VFIO file descriptor (/dev/vfio/vfio).
> > > >  * Return: 0 on success, -errno on failure
> > > >  */
> > > >
> > > > struct vfio_pamu_msi_bank_map {
> > > >         __u32   argsz;
> > > >         __u32   msi_bank_index;  /* the index of the MSI bank */
> > > >         __u64   iova;      /* the iova the bank is to be mapped
> > to */
> > > > };
> > >
> > > Again, flags.  If we dynamically add or remove devices from a
> > container
> > > the bank count can change, right?  If bank count goes from 2 to 3,
> > does
> > > userspace know assume the new bank is [2]?  If bank count goes from
> > 3 to
> > > 2, which index was that?  If removing a device removes an MSI bank
> > then
> > > vfio-pamu will automatically do the unmap, right?
> >
> > My assumption is that the bank count returned by
> > VFIO_IOMMU_GET_MSI_BANK_COUNT
> > is the max bank count for a platform.  (number will mostly likely
> > always be
> > 3 or 4).  So it won't change as devices are added or removed.
> 
> It should be the actual number of banks used.  This is required if
> we're going to have userspace do the iteration and specify the exact
> iovas to use -- and even if we aren't going to do that, it would be
> more restrictive on available iova-space than is necessary.  Usually
> there will be only one bank in the group.
> 
> Actually mapping all of the MSI banks, all the time, would completely
> negate the point of using the separate alias pages.

The geometry, windows, DMA mappings, etc is set on a 'container'
which may have multiple groups in it.  So user space needs to
determine the total number of MSI windows needed when setting
the geometry and window count.

In the flow you proposed:

count = VFIO_IOMMU_GET_MSI_BANK_COUNT
VFIO_IOMMU_SET_ATTR(ATTR_GEOMETRY)
VFIO_IOMMU_SET_ATTR(ATTR_WINDOWS)
// do other DMA maps now, or later, or not at all, doesn't matter
for (i = 0; i < count; i++)
        VFIO_IOMMU_MAP_MSI_BANK(iova, i);

...that "count" has to be the total, not the count for 1 of
N possible groups.   So the get count ioctl is not done on
a group.

However, like you pointed out we don't want to negate isolation 
of the separate alias pages.  All this API is doing is telling
the kernel which windows to use for which MSI banks.   It's up
to the kernel to actually enable them as needed.

Say 3 MSI banks exist.  If there are no groups added to the
vfio container and all 3 MAP_MSI_BANK calls occurred
the picture may look like this (based on my earlier example):

   win gphys/
    #   enabled iova        phys          size
    --- ------- ----        ----          ----
    5     N     0x10000000  0xf_fe044000  4KB    // msi bank 1
    6     N     0x14000000  0xf_fe045000  4KB    // msi bank 2
    7     N     0x18000000  0xf_fe046000  4KB    // msi bank 3

User space adds 2 groups that use bank 1:

   win          gphys/
    #   enabled iova        phys          size
    --- ------- ----        ----          ----
    5     Y     0x10000000  0xf_fe044000  4KB    // msi bank 1
    6     N     0x14000000  0xf_fe045000  4KB    // msi bank 2
    7     N     0x18000000  0xf_fe046000  4KB    // msi bank 3

User space adds another group that uses bank 3:

   win          gphys/
    #   enabled iova        phys          size
    --- ------- ----        ----          ----
    5     Y     0x10000000  0xf_fe044000  4KB    // msi bank 1
    6     N     0x14000000  0xf_fe045000  4KB    // msi bank 2
    7     Y     0x18000000  0xf_fe046000  4KB    // msi bank 3

User space doesn't need to care what is actually enabled,
it just needs to the the kernel which windows to use
and the kernel can take care of the rest.

Stuart
