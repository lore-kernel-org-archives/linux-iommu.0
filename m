From: Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: RFC: vfio API changes needed for powerpc
Date: Tue, 2 Apr 2013 15:57:16 -0500
Message-ID: <1364936236.24520.23@snotra>
References: <1364934737.2882.149.camel@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="Flowed"; DelSp="Yes"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1364934737.2882.149.camel-xdHQ/5r00wBBDLzU/O5InQ@public.gmane.org> (from
	alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org on Tue Apr  2 15:32:17 2013)
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
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Wood Scott-B07421 <B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "agraf-l3A5Bk7waGM@public.gmane.org" <agraf-l3A5Bk7waGM@public.gmane.org>, "qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org" <qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org>, Yoder Stuart-B08248 <B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Bhushan Bharat-R65777 <R65777-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 04/02/2013 03:32:17 PM, Alex Williamson wrote:
> On Tue, 2013-04-02 at 17:32 +0000, Yoder Stuart-B08248 wrote:
> > 2.   MSI window mappings
> >
> >    The more problematic question is how to deal with MSIs.  We need  
> to
> >    create mappings for up to 3 MSI banks that a device may need to  
> target
> >    to generate interrupts.  The Linux MSI driver can allocate MSIs  
> from
> >    the 3 banks any way it wants, and currently user space has no  
> way of
> >    knowing which bank may be used for a given device.
> >
> >    There are 3 options we have discussed and would like your  
> direction:
> >
> >    A.  Implicit mappings -- with this approach user space would not
> >        explicitly map MSIs.  User space would be required to set the
> >        geometry so that there are 3 unused windows (the last 3  
> windows)
> >        for MSIs, and it would be up to the kernel to create the  
> mappings.
> >        This approach requires some specific semantics (leaving 3  
> windows)
> >        and it potentially gets a little weird-- when should the  
> kernel
> >        actually create the MSI mappings?  When should they be  
> unmapped?
> >        Some convention would need to be established.
> 
> VFIO would have control of SET/GET_ATTR, right?  So we could reduce  
> the
> number exposed to userspace on GET and transparently add MSI entries  
> on
> SET.

What do you mean by "reduce the number exposed"?  Userspace decides how  
many entries there are, but it must be a power of two beteen 1 and 256.

> On x86 the interrupt remapper handles this transparently when MSI
> is enabled and userspace never gets direct access to the device MSI
> address/data registers.

x86 has a totally different mechanism here, as far as I understand --  
even before you get into restrictions on mappings.

> What kind of restrictions do you have around
> adding and removing windows while the aperture is enabled?

Subwindows can be modified while the aperture is enabled, but the  
aperture size and number of subwindows cannot be changed.

> >    B.  Explicit mapping using DMA map flags.  The idea is that a new
> >        flag to DMA map (VFIO_DMA_MAP_FLAG_MSI) would mean that
> >        a mapping is to be created for the supplied iova.  No vaddr
> >        is given though.  So in the above example there would be a
> >        a dma map at 0x10000000 for 24KB (and no vaddr).   It's
> >        up to the kernel to determine which bank gets mapped where.
> >        So, this option puts user space in control of which windows
> >        are used for MSIs and when MSIs are mapped/unmapped.   There
> >        would need to be some semantics as to how this is used-- it
> >        only makes sense
> 
> This could also be done as another "type2" ioctl extension.

Again, what is "type2", specifically?  If someone else is adding their  
own IOMMU that is kind of, sort of like PAMU, how would they know if  
it's close enough?  What assumptions can a user make when they see that  
they're dealing with "type2"?

> What's the value to userspace in determining which windows are used  
> by which banks?

That depends on who programs the MSI config space address.  What is  
important is userspace controlling which iovas will be dedicated to  
this, in case it wants to put something else there.

> It sounds like the case that there are X banks and if userspace wants  
> to
> use MSI it needs to leave X windows available for that.  Is this just
> buying userspace a few more windows to allow them the choice between  
> MSI
> or RAM?

Well, there could be that.  But also, userspace will generally have a  
much better idea of the type of mappings it's creating, so it's easier  
to keep everything explicit at the kernel/user interface than require  
more complicated code in the kernel to figure things out automatically  
(not just for MSIs but in general).

If the kernel automatically creates the MSI mappings, when does it  
assume that userspace is done creating its own?  What if userspace  
doesn't need any DMA other than the MSIs?  What if userspace wants to  
continue dynamically modifying its other mappings?

> >    C.  Explicit mapping using normal DMA map.  The last idea is that
> >        we would introduce a new ioctl to give user-space an fd to
> >        the MSI bank, which could be mmapped.  The flow would be
> >        something like this:
> >           -for each group user space calls new ioctl  
> VFIO_GROUP_GET_MSI_FD
> >           -user space mmaps the fd, getting a vaddr
> >           -user space does a normal DMA map for desired iova
> >        This approach makes everything explicit, but adds a new ioctl
> >        applicable most likely only to the PAMU (type2 iommu).
> 
> And the DMA_MAP of that mmap then allows userspace to select the  
> window
> used?  This one seems like a lot of overhead, adding a new ioctl, new
> fd, mmap, special mapping path, etc.

There's going to be special stuff no matter what.  This would keep it  
separated from the IOMMU map code.

I'm not sure what you mean by "overhead" here... the runtime overhead  
of setting things up is not particularly relevant as long as it's  
reasonable.  If you mean development and maintenance effort, keeping  
things well separated should help.

-Scott
