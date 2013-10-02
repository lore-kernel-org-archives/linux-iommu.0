From: Antonios Motakis <a.motakis@virtualopensystems.com>
Subject: Re: [PATCH 3/7] Return info for device and its memory regions and interrupts
Date: Wed, 2 Oct 2013 15:14:54 +0200
Message-ID: <CAG8rG2xA=LWAp0DR=_WdJSEC33yZXfP6LJ+oZW8WBr_HLNiarg@mail.gmail.com>
References: <1380554923-17818-1-git-send-email-a.motakis@virtualopensystems.com>
	<1380554923-17818-4-git-send-email-a.motakis@virtualopensystems.com>
	<1380562776.2674.177.camel@ul30vt.home>
	<CAG8rG2yPXX9WtmhJqYMNE_3x4RNGkb1BDab8F3Pk8KUhntM9fg@mail.gmail.com>
	<9F6FE96B71CF29479FF1CDC8046E15036D3803@039-SN1MPN1-003.039d.mgd.msft.net>
	<CAG8rG2ypiSUqfhqLTxgv0+Sh9DO9KAscJy0CmCrr_oG3tmGAgA@mail.gmail.com>
	<9F6FE96B71CF29479FF1CDC8046E15036D3D3A@039-SN1MPN1-003.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <9F6FE96B71CF29479FF1CDC8046E15036D3D3A@039-SN1MPN1-003.039d.mgd.msft.net>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Yoder Stuart-B08248 <B08248@freescale.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, kvm-arm <kvmarm@lists.cs.columbia.edu>, Linux IOMMU <iommu@lists.linux-foundation.org>, Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>, KVM devel mailing list <kvm@vger.kernel.org>, Alexander Graf <agraf@suse.de>, VirtualOpenSystems Technical Team <tech@virtualopensystems.com>
List-Id: iommu@lists.linux-foundation.org

On Wed, Oct 2, 2013 at 3:03 PM, Yoder Stuart-B08248
<B08248@freescale.com> wrote:
>
>
>> -----Original Message-----
>> From: Antonios Motakis [mailto:a.motakis@virtualopensystems.com]
>> Sent: Wednesday, October 02, 2013 6:22 AM
>> To: Yoder Stuart-B08248
>> Cc: Alex Williamson; kvm-arm; Linux IOMMU; Linux Samsung SOC; KVM devel
>> mailing list; Alexander Graf; VirtualOpenSystems Technical Team
>> Subject: Re: [PATCH 3/7] Return info for device and its memory regions
>> and interrupts
>>
>> On Tue, Oct 1, 2013 at 9:32 PM, Yoder Stuart-B08248
>> <B08248@freescale.com> wrote:
>> >> Antonios Motakis wrote
>> >> > Alex Williamson <alex.williamson@redhat.com> wrote:
>> >> > I notice all the open firmware calls here and I'm curious,
>> >> > will all platform devices be making use of open firmware?
>> >> > I don't know if this is synonymous with device tree or not.
>> >> > Thanks,
>> >>
>> >> This VFIO driver will support only devices implemented
>> >> on the device tree. While there can be platform devices
>> >> outside the device tree, I don't think it makes sense
>> >> to support them from the same driver. This is why I
>> >> originally called the driver VFIO_DT, however I renamed
>> >> it to VFIO_PLATFORM after feedback from the first
>> >> RFC. However personally, I still think the VFIO_DT name
>> >> is more appropriate since we don't support all platform
>> >> devices, only those that use the device tree.
>> >
>> > But there is no 'device tree' bus.  The bus type we're
>> > dealing with is a platform bus.
>> >
>> > vfio for platform devices should be independent of whether
>> > the device was discovered in a device tree or not.
>> > All you're doing is exposing mappable regions and IRQs
>> > to user space and it does not matter where the info originated.
>> >
>> > You should be using platform bus structs here not
>> > reparsing device tree nodes.  The struct
>> > platform_device already has resource info in the
>> > struct:
>> >
>> > struct platform_device {
>> >         const char      *name;
>> >         u32             id;
>> >         struct device   dev;
>> >         u32             num_resources;
>> >         struct resource *resource;
>> > };
>> >
>> > Stuart
>> >
>>
>> I will look into this. However, can we rely to have access to all
>> device resources through platform abstractions, for every type of
>> platform device
>
> The only resources we care about in vfio are mappable regions
> and irqs.  So, yes I think we can rely on access to those
> resources.
>
>> It seems to me that platform devices that are not
>> backed by a specific description mechanism (such as device tree) may
>> include a lot of hard coded values etc in their drivers.
>
> If the platform device struct does not have reg/irq resources described
> then we can't expose them to user space with vfio.

Which is my concern actually. If the struct does not describe reg/irq
resources, or even worse if it describes them partially, do we want to
let the user shoot himself on the foot?

Granted this might happen with device tree too, but I find it much
more likely with generic platform devices.

Maybe we should adopt a whitelist instead?

>
> Stuart
>
