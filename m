From: Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: RFC: vfio API changes needed for powerpc
Date: Wed, 3 Apr 2013 16:19:36 -0500
Message-ID: <1365023976.25627.13@snotra>
References: <1364960240.2882.230.camel@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="Flowed"; DelSp="Yes"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1364960240.2882.230.camel-xdHQ/5r00wBBDLzU/O5InQ@public.gmane.org> (from
	alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org on Tue Apr  2 22:37:20 2013)
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
Cc: Wood Scott-B07421 <B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org" <qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org>, "agraf-l3A5Bk7waGM@public.gmane.org" <agraf-l3A5Bk7waGM@public.gmane.org>, Yoder Stuart-B08248 <B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Bhushan Bharat-R65777 <R65777-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 04/02/2013 10:37:20 PM, Alex Williamson wrote:
> On Tue, 2013-04-02 at 17:50 -0500, Scott Wood wrote:
> > On 04/02/2013 04:38:45 PM, Alex Williamson wrote:
> > > On Tue, 2013-04-02 at 16:08 -0500, Stuart Yoder wrote:
> > > > On Tue, Apr 2, 2013 at 3:57 PM, Scott Wood
> > > <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org> wrote:
> > > > >> >    C.  Explicit mapping using normal DMA map.  The last  
> idea
> > > is that
> > > > >> >        we would introduce a new ioctl to give user-space  
> an fd
> > > to
> > > > >> >        the MSI bank, which could be mmapped.  The flow  
> would be
> > > > >> >        something like this:
> > > > >> >           -for each group user space calls new ioctl
> > > > >> > VFIO_GROUP_GET_MSI_FD
> > > > >> >           -user space mmaps the fd, getting a vaddr
> > > > >> >           -user space does a normal DMA map for desired  
> iova
> > > > >> >        This approach makes everything explicit, but adds a  
> new
> > > ioctl
> > > > >> >        applicable most likely only to the PAMU (type2  
> iommu).
> > > > >>
> > > > >> And the DMA_MAP of that mmap then allows userspace to select  
> the
> > > window
> > > > >> used?  This one seems like a lot of overhead, adding a new
> > > ioctl, new
> > > > >> fd, mmap, special mapping path, etc.
> > > > >
> > > > >
> > > > > There's going to be special stuff no matter what.  This would
> > > keep it
> > > > > separated from the IOMMU map code.
> > > > >
> > > > > I'm not sure what you mean by "overhead" here... the runtime
> > > overhead of
> > > > > setting things up is not particularly relevant as long as it's
> > > reasonable.
> > > > > If you mean development and maintenance effort, keeping things
> > > well
> > > > > separated should help.
> > > >
> > > > We don't need to change DMA_MAP.  If we can simply add a new  
> "type
> > > 2"
> > > > ioctl that allows user space to set which windows are MSIs, it
> > > seems vastly
> > > > less complex than an ioctl to supply a new fd, mmap of it, etc.
> > > >
> > > > So maybe 2 ioctls:
> > > >     VFIO_IOMMU_GET_MSI_COUNT
> >
> > Do you mean a count of actual MSIs or a count of MSI banks used by  
> the
> > whole VFIO group?
> 
> I hope the latter, which would clarify how this is distinct from
> DEVICE_GET_IRQ_INFO.  Is hotplug even on the table?  Presumably
> dynamically adding a device could bring along additional MSI banks?

I'm not sure -- maybe we could say that hotplug can add banks, but not  
remove them or change the order, so userspace would just need to check  
if the number of banks changed, and map the extras.

> The current VFIO MSI support has the host handling everything about  
> MSI.
> The user never programs an MSI vector to the physical device, they set
> up everything through ioctl.  On interrupt, we simply trigger an  
> eventfd
> and leave it to things like KVM irqfd or QEMU to do the right thing  
> in a
> virtual machine.
> 
> Here the MSI vector has to go through a PAMU window to hit the correct
> MSI bank.  So that means it has some component of the iova involved,
> which we're proposing here is controlled by userspace (whether that
> vector uses an offset from 0x10000000 or 0x00000000 depending on which
> window slot is used to make the MSI bank).  I assume we're still  
> working
> in a model where the physical interrupt fires into the host and a
> host-based interrupt handler triggers an eventfd, right?

Yes (subject to possible future optimizations).

> So that means the vector also has host components so we trigger the  
> correct ISR.  How
> is that coordinated?

Everything but the iova component needs to come from the host MSI  
allocator.

> Would is be possible for userspace to simply leave room for MSI bank
> mapping (how much room could be determined by something like
> VFIO_IOMMU_GET_MSI_BANK_COUNT) then document the API that userspace  
> can
> DMA_MAP starting at the 0x0 address of the aperture, growing up, and
> VFIO will map banks on demand at the top of the aperture, growing  
> down?
> Wouldn't that avoid a lot of issues with userspace needing to know
> anything about MSI banks (other than count) and coordinating irq  
> numbers
> and enabling handlers?

This would restrict a (possibly unlikely) use case where the user wants  
to map something near the top of the aperture but has another place  
MSIs can go (or is willing to live without MSIs).  Otherwise it could  
be workable, as long as we can require an explicit MSI enabling on a  
device to happen after the aperture and subwindow count are set up.   
I'm not sure it would really buy anything over having userspace iterate  
over the MSI bank count, though -- it would probably be a bit more  
complicated.

> > > On x86 MSI count is very
> > > device specific, which means it wold be a VFIO_DEVICE_* ioctl
> > > (actually
> > > VFIO_DEVICE_GET_IRQ_INFO does this for us on x86).  The trouble  
> with
> > > it
> > > being a device ioctl is that you need to get the device FD, but  
> the
> > > IOMMU protection needs to be established before you can get  
> that... so
> > > there's an ordering problem if you need it from the device before
> > > configuring the IOMMU.  Thanks,
> >
> > What do you mean by "IOMMU protection needs to be established"?
> > Wouldn't we just start with no mappings in place?
> 
> If no mappings blocks all DMA, sure, that's fine.  Once the VFIO  
> device
> FD is accessible by userspace we have to protect the host against DMA.
> If any IOMMU_SET_ATTR calls temporarily disable DMA protection, that
> could be exploitable.  Thanks,

Unless the PAMU is globally in bypass mode (which it wouldn't be),  
there's no way to disable protection other than creating one giant  
mapping.

-Scott
