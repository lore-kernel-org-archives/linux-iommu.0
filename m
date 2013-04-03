From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: RFC: vfio API changes needed for powerpc
Date: Wed, 03 Apr 2013 13:23:37 -0600
Message-ID: <1365017017.2882.269.camel@bling.home>
References: <1364943035.24520.28@snotra> <1364960240.2882.230.camel@bling.home>
	<CALRxmdDHYp1+svjwDrhMc9w2p7H8t87PphEZ1t+97C-EHDR+3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CALRxmdDHYp1+svjwDrhMc9w2p7H8t87PphEZ1t+97C-EHDR+3g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Cc: Wood Scott-B07421 <B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "agraf-l3A5Bk7waGM@public.gmane.org" <agraf-l3A5Bk7waGM@public.gmane.org>, "qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org" <qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org>, Yoder Stuart-B08248 <B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Bhushan Bharat-R65777 <R65777-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, 2013-04-03 at 14:09 -0500, Stuart Yoder wrote:
> > Would is be possible for userspace to simply leave room for MSI bank
> > mapping (how much room could be determined by something like
> > VFIO_IOMMU_GET_MSI_BANK_COUNT) then document the API that userspace can
> > DMA_MAP starting at the 0x0 address of the aperture, growing up, and
> > VFIO will map banks on demand at the top of the aperture, growing down?
> > Wouldn't that avoid a lot of issues with userspace needing to know
> > anything about MSI banks (other than count) and coordinating irq numbers
> > and enabling handlers?
> 
> This is basically option #A in the original proposals sent.   I like
> this approach, in that it
> is simpler and keeps user space mostly out of this...which is
> consistent with how things are done
> on x86.  User space just needs to know how many windows to leave at
> the top of the aperture.
> The kernel then has the flexibility to use those windows how it wants.
> 
> But one question, is when should the kernel actually map (and unmap)
> the MSI banks.   One thing we need to do is enable the aperture...and current
> thinking is that is done on the first DMA_MAP.   Similarly when the last mapping
> is unmapped we could also umap the MSI banks.
> 
> Sequence would be something like:
> 
>         VFIO_GROUP_SET_CONTAINER     // add groups to the container
> 
>         VFIO_SET_IOMMU(VFIO_FSL_PAMU)    // set iommu model
> 
>         cnt = VFIO_IOMMU_GET_MSI_BANK_COUNT    // returns max # of MSI banks
> 
>         VFIO_IOMMU_SET_ATTR(ATTR_GEOMETRY) // set overall aperture
> 
>         VFIO_IOMMU_SET_ATTR(ATTR_WINDOWS) // set # of windows,
> including MSI banks
> 
>         VFIO_IOMMU_MAP_DMA    // map the guest's memory
>                ---> kernel enables aperture and maps needed MSI banks here
> 
>         VFIO_DEVICE_SET_IRQS
>                ---> kernel sets actual MSI addr/data in physical
> device here (I think)

You could also make use of the IOMMU_ENABLE/DISABLE entry points that
Alexey plans to use.  Ideally I'd think that you'd want to enable the
required MSI banks for a device on DEVICE_SET_IRQs.  That's effectively
what happens on x86.  Perhaps some information stored in the domain
structure would let architecture hooks in MSI setup enable those
mappings for you?  Thanks,

Alex
