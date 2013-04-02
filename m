From: Stuart Yoder <b08248-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: RFC: vfio API changes needed for powerpc
Date: Tue, 2 Apr 2013 16:08:27 -0500
Message-ID: <CALRxmdCe-RMZuhPSviQsQUxWZbxXABOZDsM8ZoNaqrp=xH+TaA@mail.gmail.com>
References: <1364934737.2882.149.camel@bling.home> <1364936236.24520.23@snotra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1364936236.24520.23@snotra>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Wood Scott-B07421 <B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "agraf-l3A5Bk7waGM@public.gmane.org" <agraf-l3A5Bk7waGM@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org" <qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org>, Yoder Stuart-B08248 <B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Bhushan Bharat-R65777 <R65777-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Apr 2, 2013 at 3:57 PM, Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org> wrote:
>> This could also be done as another "type2" ioctl extension.
>
>
> Again, what is "type2", specifically?  If someone else is adding their own
> IOMMU that is kind of, sort of like PAMU, how would they know if it's close
> enough?  What assumptions can a user make when they see that they're dealing
> with "type2"?

We will define that as part of the type2 implementation.   Highly unlikely
anything but a PAMU will comply.

>> What's the value to userspace in determining which windows are used by
>> which banks?
>
>
> That depends on who programs the MSI config space address.  What is
> important is userspace controlling which iovas will be dedicated to this, in
> case it wants to put something else there.
>
>
>> It sounds like the case that there are X banks and if userspace wants to
>> use MSI it needs to leave X windows available for that.  Is this just
>> buying userspace a few more windows to allow them the choice between MSI
>> or RAM?
>
>
> Well, there could be that.  But also, userspace will generally have a much
> better idea of the type of mappings it's creating, so it's easier to keep
> everything explicit at the kernel/user interface than require more
> complicated code in the kernel to figure things out automatically (not just
> for MSIs but in general).
>
> If the kernel automatically creates the MSI mappings, when does it assume
> that userspace is done creating its own?  What if userspace doesn't need any
> DMA other than the MSIs?  What if userspace wants to continue dynamically
> modifying its other mappings?
>
>
>> >    C.  Explicit mapping using normal DMA map.  The last idea is that
>> >        we would introduce a new ioctl to give user-space an fd to
>> >        the MSI bank, which could be mmapped.  The flow would be
>> >        something like this:
>> >           -for each group user space calls new ioctl
>> > VFIO_GROUP_GET_MSI_FD
>> >           -user space mmaps the fd, getting a vaddr
>> >           -user space does a normal DMA map for desired iova
>> >        This approach makes everything explicit, but adds a new ioctl
>> >        applicable most likely only to the PAMU (type2 iommu).
>>
>> And the DMA_MAP of that mmap then allows userspace to select the window
>> used?  This one seems like a lot of overhead, adding a new ioctl, new
>> fd, mmap, special mapping path, etc.
>
>
> There's going to be special stuff no matter what.  This would keep it
> separated from the IOMMU map code.
>
> I'm not sure what you mean by "overhead" here... the runtime overhead of
> setting things up is not particularly relevant as long as it's reasonable.
> If you mean development and maintenance effort, keeping things well
> separated should help.

We don't need to change DMA_MAP.  If we can simply add a new "type 2"
ioctl that allows user space to set which windows are MSIs, it seems vastly
less complex than an ioctl to supply a new fd, mmap of it, etc.

So maybe 2 ioctls:
    VFIO_IOMMU_GET_MSI_COUNT
    VFIO_IOMMU_MAP_MSI(iova, size)

Stuart
