From: Yoder Stuart-B08248 <B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: RFC: vfio API changes needed for powerpc (v3)
Date: Tue, 9 Apr 2013 01:22:15 +0000
Message-ID: <9F6FE96B71CF29479FF1CDC8046E15035A5CA3@039-SN1MPN1-003.039d.mgd.msft.net>
References: <9F6FE96B71CF29479FF1CDC8046E15035A29FB@039-SN1MPN1-003.039d.mgd.msft.net>
	(from B08248@freescale.com on Thu Apr  4 17:10:27 2013)
	<1365200245.17535.13@snotra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1365200245.17535.13@snotra>
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
> Sent: Friday, April 05, 2013 5:17 PM
> To: Yoder Stuart-B08248
> Cc: Alex Williamson; Wood Scott-B07421; agraf-l3A5Bk7waGM@public.gmane.org; Bhushan Bharat-R65777; Sethi Varun-B16395;
> kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> Subject: Re: RFC: vfio API changes needed for powerpc (v3)
> 
> On 04/04/2013 05:10:27 PM, Yoder Stuart-B08248 wrote:
> > /*
> >  * VFIO_IOMMU_PAMU_UNMAP_MSI_BANK
> >  *
> >  * Unmaps the MSI bank at the specified iova.
> >  * Caller provides struct vfio_pamu_msi_bank_unmap with all fields
> > set.
> >  * Operates on VFIO file descriptor (/dev/vfio/vfio).
> >  * Return: 0 on success, -errno on failure
> >  */
> >
> > struct vfio_pamu_msi_bank_unmap {
> >         __u32   argsz;
> >         __u32   flags;     /* no flags currently */
> >         __u64   iova;      /* the iova to be unmapped to */
> > };
> > #define VFIO_IOMMU_PAMU_UNMAP_MSI_BANK  _IO(VFIO_TYPE, VFIO_BASE + x,
> >         struct vfio_pamu_msi_bank_unmap )
> 
> What happens if a normal unmap call is done on the MSI iova?  Do we
> need a separate unmap?

I was thinking a normal unmap on an MSI windows would be an error...but
I'm not set on that.   I put the msi unmap there to make things symmetric,
a normal unmap would work as well...and then we could drop the msi unmap.

Stuart
