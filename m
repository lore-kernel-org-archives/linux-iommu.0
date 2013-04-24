From: Yoder Stuart-B08248 <B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: RFC:  vfio / iommu driver for hardware with no iommu
Date: Wed, 24 Apr 2013 15:22:50 +0000
Message-ID: <9F6FE96B71CF29479FF1CDC8046E15035BEEA9@039-SN1MPN1-002.039d.mgd.msft.net>
References: <9F6FE96B71CF29479FF1CDC8046E15035BE0A3@039-SN1MPN1-002.039d.mgd.msft.net>
	<20130424105718.GJ17148@8bytes.org>
	<6A3DF150A5B70D4F9B66A25E3F7C888D06FF5799@039-SN2MPN1-011.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <6A3DF150A5B70D4F9B66A25E3F7C888D06FF5799-RL0Hj/+nBVCMXPU/2EZmt64g8xLGJsHaLnY5E4hWTkheoWH0uzbU5w@public.gmane.org>
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
To: Bhushan Bharat-R65777 <R65777-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Bhushan Bharat-R65777
> Sent: Wednesday, April 24, 2013 6:04 AM
> To: Joerg Roedel; Yoder Stuart-B08248
> Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> Subject: RE: RFC: vfio / iommu driver for hardware with no iommu
> 
> 
> 
> > -----Original Message-----
> > From: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org [mailto:iommu-
> > bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org] On Behalf Of Joerg Roedel
> > Sent: Wednesday, April 24, 2013 4:27 PM
> > To: Yoder Stuart-B08248
> > Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> > Subject: Re: RFC: vfio / iommu driver for hardware with no iommu
> >
> > On Tue, Apr 23, 2013 at 04:13:00PM +0000, Yoder Stuart-B08248 wrote:
> > > We're aware of the obvious limitations-- no protection, DMA'able
> > > memory must be physically contiguous and will have no iova->phy
> > > translation.  But there are use cases where all OSes involved are
> > > trusted and customers can
> > > live with those limitations.   Virtualization is used
> > > here not to sandbox untrusted code, but to consolidate multiple OSes.
> >
> > One of the major points of VFIO is to provide a userspace interface for hardware
> > IOMMUs. So if you have a platform without an IOMMU why do you care about VFIO at
> > all?
> 
> We want to do direct device assignment to user space.
> So if the device is behind iommu then it will be a secure interface.
> if device is not behind a iommu then it is insecure. But the user space can access the device. This way
> we can be consistent with one mechanism to do direct device assignment.

And more specifically, there's the desire to assign things like
a PCI device to a KVM virtual machine on a platform without
an iommu.   QEMU uses vfio-pci and we don't want to implement
a completely separate user space approach to do this.  We want
QEMU to stay (mostly) unchanged.

Stuart
