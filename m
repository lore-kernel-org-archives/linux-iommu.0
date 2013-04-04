From: Scott Wood <scottwood@freescale.com>
Subject: Re: RFC: vfio API changes needed for powerpc (v2)
Date: Thu, 4 Apr 2013 17:51:49 -0500
Message-ID: <1365115909.14772.20@snotra>
References: <9F6FE96B71CF29479FF1CDC8046E15035A29AC@039-SN1MPN1-003.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Content-Transfer-Encoding: 8BIT
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <9F6FE96B71CF29479FF1CDC8046E15035A29AC@039-SN1MPN1-003.039d.mgd.msft.net>
	(from B08248@freescale.com on Thu Apr  4 16:38:44 2013)
Content-Disposition: inline
Sender: kvm-owner@vger.kernel.org
To: Yoder Stuart-B08248 <B08248@freescale.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, Wood Scott-B07421 <B07421@freescale.com>, "agraf@suse.de" <agraf@suse.de>, Bhushan Bharat-R65777 <R65777@freescale.com>, Sethi Varun-B16395 <B16395@freescale.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
List-Id: iommu@lists.linux-foundation.org

On 04/04/2013 04:38:44 PM, Yoder Stuart-B08248 wrote:
> 
> > > /*
> > >  * VFIO_PAMU_MAP_MSI_BANK
> > >  *
> > >  * Maps the MSI bank at the specified index and iova.  User space  
> must
> > >  * call this ioctl once for each MSI bank (count of banks is  
> returned by
> > >  * VFIO_IOMMU_GET_MSI_BANK_COUNT).
> > >  * Caller provides struct vfio_pamu_msi_bank_map with all fields  
> set.
> > >  * Operates on VFIO file descriptor (/dev/vfio/vfio).
> > >  * Return: 0 on success, -errno on failure
> > >  */
> > >
> > > struct vfio_pamu_msi_bank_map {
> > >         __u32   argsz;
> > >         __u32   msi_bank_index;  /* the index of the MSI bank */
> > >         __u64   iova;      /* the iova the bank is to be mapped  
> to */
> > > };
> >
> > Again, flags.  If we dynamically add or remove devices from a  
> container
> > the bank count can change, right?  If bank count goes from 2 to 3,  
> does
> > userspace know assume the new bank is [2]?  If bank count goes from  
> 3 to
> > 2, which index was that?  If removing a device removes an MSI bank  
> then
> > vfio-pamu will automatically do the unmap, right?
> 
> My assumption is that the bank count returned by  
> VFIO_IOMMU_GET_MSI_BANK_COUNT
> is the max bank count for a platform.  (number will mostly likely  
> always be
> 3 or 4).  So it won't change as devices are added or removed.

It should be the actual number of banks used.  This is required if  
we're going to have userspace do the iteration and specify the exact  
iovas to use -- and even if we aren't going to do that, it would be  
more restrictive on available iova-space than is necessary.  Usually  
there will be only one bank in the group.

Actually mapping all of the MSI banks, all the time, would completely  
negate the point of using the separate alias pages.

-Scott
