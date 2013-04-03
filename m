From: Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: RFC: vfio API changes needed for powerpc
Date: Wed, 3 Apr 2013 15:00:53 -0500
Message-ID: <1365019253.25627.8@snotra>
References: <1364943035.24520.28@snotra> <1364960240.2882.230.camel@bling.home>
	<CALRxmdDHYp1+svjwDrhMc9w2p7H8t87PphEZ1t+97C-EHDR+3g@mail.gmail.com>
	<1365016682.25627.6@snotra>
	<CALRxmdAbVFbPUCDV1fHauAeQxDQWDC8SjsQn-Xyn3PbzKhFjmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="Flowed"; DelSp="Yes"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CALRxmdAbVFbPUCDV1fHauAeQxDQWDC8SjsQn-Xyn3PbzKhFjmQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
	(from b08248-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org on Wed Apr  3 14:43:06 2013)
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
To: Stuart Yoder <b08248-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Wood Scott-B07421 <B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "agraf-l3A5Bk7waGM@public.gmane.org" <agraf-l3A5Bk7waGM@public.gmane.org>, "qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org" <qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org>, Yoder Stuart-B08248 <B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Bhushan Bharat-R65777 <R65777-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 04/03/2013 02:43:06 PM, Stuart Yoder wrote:
> On Wed, Apr 3, 2013 at 2:18 PM, Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>  
> wrote:
> > On 04/03/2013 02:09:45 PM, Stuart Yoder wrote:
> >>
> >> > Would is be possible for userspace to simply leave room for MSI  
> bank
> >> > mapping (how much room could be determined by something like
> >> > VFIO_IOMMU_GET_MSI_BANK_COUNT) then document the API that  
> userspace can
> >> > DMA_MAP starting at the 0x0 address of the aperture, growing up,  
> and
> >> > VFIO will map banks on demand at the top of the aperture,  
> growing down?
> >> > Wouldn't that avoid a lot of issues with userspace needing to  
> know
> >> > anything about MSI banks (other than count) and coordinating irq  
> numbers
> >> > and enabling handlers?
> >>
> >> This is basically option #A in the original proposals sent.   I  
> like
> >> this approach, in that it
> >> is simpler and keeps user space mostly out of this...which is
> >> consistent with how things are done
> >> on x86.  User space just needs to know how many windows to leave at
> >> the top of the aperture.
> >> The kernel then has the flexibility to use those windows how it  
> wants.
> >>
> >> But one question, is when should the kernel actually map (and  
> unmap)
> >> the MSI banks.
> >
> >
> > I think userspace should explicitly request it.  Userspace still  
> wouldn't
> > need to know anything but the count:
> >
> > count = VFIO_IOMMU_GET_MSI_BANK_COUNT
> > VFIO_IOMMU_SET_ATTR(ATTR_GEOMETRY)
> > VFIO_IOMMU_SET_ATTR(ATTR_WINDOWS)
> > // do other DMA maps now, or later, or not at all, doesn't matter
> > for (i = 0; i < count; i++)
> >         VFIO_IOMMU_MAP_MSI_BANK(iova, i);
> > // The kernel now knows where each bank has been mapped, and can  
> update PCI
> > config space appropriately.
> 
> And the overall aperture enable/disable would occur on the first
> dma/msi map() and last dma/msi unmap()?

Yes.  We may want the optional ability to do an overall enable/disable  
for reasons we discussed a while ago, but in the absence of an explicit  
disable the domain would be enabled on first map.

-Scott
