From: Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: RFC: vfio API changes needed for powerpc
Date: Tue, 2 Apr 2013 17:44:06 -0500
Message-ID: <1364942646.24520.27@snotra>
References: <1364938324.2882.179.camel@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="Flowed"; DelSp="Yes"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1364938324.2882.179.camel-xdHQ/5r00wBBDLzU/O5InQ@public.gmane.org> (from
	alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org on Tue Apr  2 16:32:04 2013)
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

On 04/02/2013 04:32:04 PM, Alex Williamson wrote:
> On Tue, 2013-04-02 at 15:57 -0500, Scott Wood wrote:
> > On 04/02/2013 03:32:17 PM, Alex Williamson wrote:
> > > On x86 the interrupt remapper handles this transparently when MSI
> > > is enabled and userspace never gets direct access to the device  
> MSI
> > > address/data registers.
> >
> > x86 has a totally different mechanism here, as far as I understand  
> --
> > even before you get into restrictions on mappings.
> 
> So what control will userspace have over programming the actually MSI
> vectors on PAMU?

Not sure what you mean -- PAMU doesn't get explicitly involved in  
MSIs.  It's just another 4K page mapping (per relevant MSI bank).  If  
you want isolation, you need to make sure that an MSI group is only  
used by one VFIO group, and that you're on a chip that has alias pages  
with just one MSI bank register each (newer chips do, but the first  
chip to have a PAMU didn't).

> > > This could also be done as another "type2" ioctl extension.
> >
> > Again, what is "type2", specifically?  If someone else is adding  
> their
> > own IOMMU that is kind of, sort of like PAMU, how would they know if
> > it's close enough?  What assumptions can a user make when they see  
> that
> > they're dealing with "type2"?
> 
> Naming always has and always will be a problem.  I assume this is  
> named
> type2 rather than PAMU because it's trying to expose a generic  
> windowed
> IOMMU fitting the IOMMU API.

But how closely is the MSI situation related to a generic windowed  
IOMMU, then?  We could just as well have a highly flexible IOMMU in  
terms of arbitrary 4K page mappings, but still handle MSIs as pages to  
be mapped rather than a translation table.  Or we could have a windowed  
IOMMU that has an MSI translation table.

> Like type1, it doesn't really make sense
> to name it "IOMMU API" because that's a kernel internal interface and
> we're designing a userspace interface that just happens to use that.
> Tagging it to a piece of hardware makes it less reusable.

Well, that's my point.  Is it reusable at all, anyway?  If not, then  
giving it a more obscure name won't change that.  If it is reusable,  
then where is the line drawn between things that are PAMU-specific or  
MPIC-specific and things that are part of the "generic windowed IOMMU"  
abstraction?

>  Type1 is arbitrary.  It might as well be named "brown" and this one  
> can be
> "blue".

The difference is that "type1" seems to refer to hardware that can do  
arbitrary 4K page mappings, possibly constrained by an aperture but  
nothing else.  More than one IOMMU can reasonably fit that.  The odds  
that another IOMMU would have exactly the same restrictions as PAMU  
seem smaller in comparison.

In any case, if you had to deal with some Intel-only quirk, would it  
make sense to call it a "type1 attribute"?  I'm not advocating one way  
or the other on whether an abstraction is viable here (though Stuart  
seems to think it's "highly unlikely anything but a PAMU will comply"),  
just that if it is to be abstracted rather than a hardware-specific  
interface, we need to document what is and is not part of the  
abstraction.  Otherwise a non-PAMU-specific user won't know what they  
can rely on, and someone adding support for a new windowed IOMMU won't  
know if theirs is close enough, or they need to introduce a "type3".

> > > What's the value to userspace in determining which windows are  
> used
> > > by which banks?
> >
> > That depends on who programs the MSI config space address.  What is
> > important is userspace controlling which iovas will be dedicated to
> > this, in case it wants to put something else there.
> 
> So userspace is programming the MSI vectors, targeting a user  
> programmed
> iova?  But an iova selects a window and I thought there were some  
> number
> of MSI banks and we don't really know which ones we'll need...  still
> confused.

Userspace would also need a way to find out the page offset and data  
value.  That may be an argument in favor of having the two ioctls  
Stuart later suggested (get MSI count, and map MSI).  Would there be  
any complication in the VFIO code from tracking a mapping that doesn't  
have a userspace virtual address associated with it?

> > There's going to be special stuff no matter what.  This would keep  
> it
> > separated from the IOMMU map code.
> >
> > I'm not sure what you mean by "overhead" here... the runtime  
> overhead
> > of setting things up is not particularly relevant as long as it's
> > reasonable.  If you mean development and maintenance effort, keeping
> > things well separated should help.
> 
> Overhead in terms of code required and complexity.  More things to
> reference count and shut down in the proper order on userspace exit.
> Thanks,

That didn't stop others from having me convert the KVM device control  
API to use file descriptors instead of something more ad-hoc with a  
better-defined destruction order. :-)

I don't know if it necessarily needs to be a separate fd -- it could be  
just another device resource like BARs, with some way for userspace to  
tell if the page is shared by multiple devices in the group (e.g. make  
the physical address visible).

-Scott
