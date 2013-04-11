From: Yoder Stuart-B08248 <B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: RFC: vfio API changes needed for powerpc (v3)
Date: Thu, 11 Apr 2013 16:15:12 +0000
Message-ID: <9F6FE96B71CF29479FF1CDC8046E15035A8F02@039-SN1MPN1-003.039d.mgd.msft.net>
References: <9F6FE96B71CF29479FF1CDC8046E15035A29FB@039-SN1MPN1-003.039d.mgd.msft.net>
	<1365200245.17535.13@snotra>
	<9F6FE96B71CF29479FF1CDC8046E15035A5CA3@039-SN1MPN1-003.039d.mgd.msft.net>
	<20130411125659.GL6858@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20130411125659.GL6858-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Wood Scott-B07421 <B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org" <qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org>, "agraf-l3A5Bk7waGM@public.gmane.org" <agraf-l3A5Bk7waGM@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Bhushan Bharat-R65777 <R65777-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


> -----Original Message-----
> From: Joerg Roedel [mailto:joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org]
> Sent: Thursday, April 11, 2013 7:57 AM
> To: Yoder Stuart-B08248
> Cc: Wood Scott-B07421; kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org;
> agraf-l3A5Bk7waGM@public.gmane.org; Bhushan Bharat-R65777
> Subject: Re: RFC: vfio API changes needed for powerpc (v3)
> 
> On Tue, Apr 09, 2013 at 01:22:15AM +0000, Yoder Stuart-B08248 wrote:
> > > What happens if a normal unmap call is done on the MSI iova?  Do we
> > > need a separate unmap?
> >
> > I was thinking a normal unmap on an MSI windows would be an error...but
> > I'm not set on that.   I put the msi unmap there to make things symmetric,
> > a normal unmap would work as well...and then we could drop the msi unmap.
> 
> Hmm, this API semantic isn't very clean. When you explicitly map the MSI
> banks a clean API would also allow to unmap them. But that is not
> possible in your design because the kernel is responsible for mapping
> MSIs and you can't unmap a MSI bank that is in use by the kernel.

The mapping that the vfio API creates is specific only to the
assigned device.   So it can be unmapped without affecting
any other device... there is nothing else in the kernel making
the mapping "in use".  Another device in use by the kernel using the
same MSI bank would have its own independent mapping.   So, these
mappings are not global but are device specific...just like normal
DMA memory mappings.
  
> So since the kernel owns the MSI setup anyways it should also take care
> of mapping the MSI banks. What is the reason to not let the kernel
> allocate the MSI banks top-down from the end of the DMA window space?
> Just let userspace know (or even set if needed) in advance how many of
> the windows it configures the kernel will take for mapping MSI banks and
> you are fine, no?

As designed the API lets user space determine the number of windows
needed for MSIs, so they can be set.  The only difference between
what we've proposed and what you described, I think, is that the proposal
allows user space to _which_ windows are used for which MSI banks.

Stuart
