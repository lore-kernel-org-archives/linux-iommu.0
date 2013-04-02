From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: RFC: vfio API changes needed for powerpc
Date: Tue, 02 Apr 2013 15:16:11 -0600
Message-ID: <1364937371.2882.166.camel@bling.home>
References: <9F6FE96B71CF29479FF1CDC8046E15035A0F13@039-SN1MPN1-003.039d.mgd.msft.net>
	<1364934737.2882.149.camel@bling.home>
	<CALRxmdBrW5HUpprhWLr9-U8_t5LBuaPEtWP9vQGOAfyOQ0eV9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CALRxmdBrW5HUpprhWLr9-U8_t5LBuaPEtWP9vQGOAfyOQ0eV9A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

On Tue, 2013-04-02 at 15:54 -0500, Stuart Yoder wrote:
> On Tue, Apr 2, 2013 at 3:32 PM, Alex Williamson
> <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> >> 2.   MSI window mappings
> >>
> >>    The more problematic question is how to deal with MSIs.  We need to
> >>    create mappings for up to 3 MSI banks that a device may need to target
> >>    to generate interrupts.  The Linux MSI driver can allocate MSIs from
> >>    the 3 banks any way it wants, and currently user space has no way of
> >>    knowing which bank may be used for a given device.
> >>
> >>    There are 3 options we have discussed and would like your direction:
> >>
> >>    A.  Implicit mappings -- with this approach user space would not
> >>        explicitly map MSIs.  User space would be required to set the
> >>        geometry so that there are 3 unused windows (the last 3 windows)
> >>        for MSIs, and it would be up to the kernel to create the mappings.
> >>        This approach requires some specific semantics (leaving 3 windows)
> >>        and it potentially gets a little weird-- when should the kernel
> >>        actually create the MSI mappings?  When should they be unmapped?
> >>        Some convention would need to be established.
> >
> > VFIO would have control of SET/GET_ATTR, right?  So we could reduce the
> > number exposed to userspace on GET and transparently add MSI entries on
> > SET.
> 
> The number of windows is always power of 2 (and max is 256).  And to reduce
> PAMU cache pressure you want to use the fewest number of windows
> you can.    So, I don't see practically how we could transparently
> steal entries to
> add the MSIs.     Either user space knows to leave empty windows for
> MSIs and by convention the kernel knows which windows those are (as
> in option #A) or explicitly tell the kernel which windows (as in option #B).

Ok, apparently I don't understand the API.  Is it something like
userspace calls GET_ATTR and finds out that there are 256 available
windows, userspace determines that it needs 8 for RAM and then it has an
MSI device, so it needs to call SET_ATTR and ask for 16?  That seems
prone to exploitation by the first userspace to allocate it's aperture,
but I'm also not sure why userspace could specify the (non-power of 2)
number of windows it needs for RAM, then VFIO would see that the devices
attached have MSI and add those windows and align to a power of 2.

> > On x86 the interrupt remapper handles this transparently when MSI
> > is enabled and userspace never gets direct access to the device MSI
> > address/data registers.  What kind of restrictions do you have around
> > adding and removing windows while the aperture is enabled?
> 
> The windows can be enabled/disabled event while the aperture is
> enabled (pretty sure)...
> 
> >>    B.  Explicit mapping using DMA map flags.  The idea is that a new
> >>        flag to DMA map (VFIO_DMA_MAP_FLAG_MSI) would mean that
> >>        a mapping is to be created for the supplied iova.  No vaddr
> >>        is given though.  So in the above example there would be a
> >>        a dma map at 0x10000000 for 24KB (and no vaddr).   It's
> >>        up to the kernel to determine which bank gets mapped where.
> >>        So, this option puts user space in control of which windows
> >>        are used for MSIs and when MSIs are mapped/unmapped.   There
> >>        would need to be some semantics as to how this is used-- it
> >>        only makes sense
> >
> > This could also be done as another "type2" ioctl extension.  What's the
> > value to userspace in determining which windows are used by which banks?
> > It sounds like the case that there are X banks and if userspace wants to
> > use MSI it needs to leave X windows available for that.  Is this just
> > buying userspace a few more windows to allow them the choice between MSI
> > or RAM?
> 
> Yes, it would potentially give user space the flexibility some more windows.
> It also makes more explicit when the MSI mappings are created.  In option
> #A the MSI mappings would probably get created at the time of the first
> normal DMA map.
> 
> So, you're saying with this approach you'd rather see a new type 2
> ioctl instead of adding new flags to DMA map, right?

I'm not sure I know enough yet to have a suggestion.  What would be the
purpose of userspace specifying the iova and size here?  If userspace
just needs to know that it needs X addition windows for MSI and can tell
the kernel to use banks 0 through (X-1) for MSI, that sounds more like
an ioctl interface than a DMA_MAP flag.  Thanks,

Alex

> >>    C.  Explicit mapping using normal DMA map.  The last idea is that
> >>        we would introduce a new ioctl to give user-space an fd to
> >>        the MSI bank, which could be mmapped.  The flow would be
> >>        something like this:
> >>           -for each group user space calls new ioctl VFIO_GROUP_GET_MSI_FD
> >>           -user space mmaps the fd, getting a vaddr
> >>           -user space does a normal DMA map for desired iova
> >>        This approach makes everything explicit, but adds a new ioctl
> >>        applicable most likely only to the PAMU (type2 iommu).
> >
> > And the DMA_MAP of that mmap then allows userspace to select the window
> > used?  This one seems like a lot of overhead, adding a new ioctl, new
> > fd, mmap, special mapping path, etc.  It would be less overhead to just
> > add an ioctl to enable MSI, maybe letting userspace pick which windows
> > get used, but I'm still not sure what the value is to userspace in
> > exposing it.  Thanks,
> 
> Thanks,
> Stuart
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
