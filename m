From: Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: RFC: vfio API changes needed for powerpc
Date: Tue, 2 Apr 2013 17:50:35 -0500
Message-ID: <1364943035.24520.28@snotra>
References: <1364938725.2882.184.camel@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="Flowed"; DelSp="Yes"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1364938725.2882.184.camel-xdHQ/5r00wBBDLzU/O5InQ@public.gmane.org> (from
	alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org on Tue Apr  2 16:38:45 2013)
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

On 04/02/2013 04:38:45 PM, Alex Williamson wrote:
> On Tue, 2013-04-02 at 16:08 -0500, Stuart Yoder wrote:
> > On Tue, Apr 2, 2013 at 3:57 PM, Scott Wood  
> <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org> wrote:
> > >> >    C.  Explicit mapping using normal DMA map.  The last idea  
> is that
> > >> >        we would introduce a new ioctl to give user-space an fd  
> to
> > >> >        the MSI bank, which could be mmapped.  The flow would be
> > >> >        something like this:
> > >> >           -for each group user space calls new ioctl
> > >> > VFIO_GROUP_GET_MSI_FD
> > >> >           -user space mmaps the fd, getting a vaddr
> > >> >           -user space does a normal DMA map for desired iova
> > >> >        This approach makes everything explicit, but adds a new  
> ioctl
> > >> >        applicable most likely only to the PAMU (type2 iommu).
> > >>
> > >> And the DMA_MAP of that mmap then allows userspace to select the  
> window
> > >> used?  This one seems like a lot of overhead, adding a new  
> ioctl, new
> > >> fd, mmap, special mapping path, etc.
> > >
> > >
> > > There's going to be special stuff no matter what.  This would  
> keep it
> > > separated from the IOMMU map code.
> > >
> > > I'm not sure what you mean by "overhead" here... the runtime  
> overhead of
> > > setting things up is not particularly relevant as long as it's  
> reasonable.
> > > If you mean development and maintenance effort, keeping things  
> well
> > > separated should help.
> >
> > We don't need to change DMA_MAP.  If we can simply add a new "type  
> 2"
> > ioctl that allows user space to set which windows are MSIs, it  
> seems vastly
> > less complex than an ioctl to supply a new fd, mmap of it, etc.
> >
> > So maybe 2 ioctls:
> >     VFIO_IOMMU_GET_MSI_COUNT

Do you mean a count of actual MSIs or a count of MSI banks used by the  
whole VFIO group?

> >     VFIO_IOMMU_MAP_MSI(iova, size)

Not sure how you mean "size" to be used -- for MPIC it would be 4K per  
bank, and you can only map one bank at a time (which bank you're  
mapping should be a parameter, if only so that the kernel doesn't have  
to keep iteration state for you).

> How are MSIs related to devices on PAMU?

PAMU doesn't care about MSIs.  The relation of individual MSIs to a  
device is standard PCI stuff.  Each MSI bank (which is part of the  
MPIC, not PAMU) can hold numerous MSIs.  The VFIO user would want to  
map all MSI banks that are in use by any of the devices in the group.   
Ideally we'd let the VFIO grouping influence the allocation of MSIs.

> On x86 MSI count is very
> device specific, which means it wold be a VFIO_DEVICE_* ioctl  
> (actually
> VFIO_DEVICE_GET_IRQ_INFO does this for us on x86).  The trouble with  
> it
> being a device ioctl is that you need to get the device FD, but the
> IOMMU protection needs to be established before you can get that... so
> there's an ordering problem if you need it from the device before
> configuring the IOMMU.  Thanks,

What do you mean by "IOMMU protection needs to be established"?   
Wouldn't we just start with no mappings in place?

-Scott
