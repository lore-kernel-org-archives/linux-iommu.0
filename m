From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 3/7] Return info for device and its memory regions and interrupts
Date: Wed, 2 Oct 2013 14:12:27 +0200
Message-ID: <05391347-DD79-47BD-A569-7887E38DE60E@suse.de>
References: <1380554923-17818-1-git-send-email-a.motakis@virtualopensystems.com> <1380554923-17818-4-git-send-email-a.motakis@virtualopensystems.com> <1380562776.2674.177.camel@ul30vt.home> <CAG8rG2yPXX9WtmhJqYMNE_3x4RNGkb1BDab8F3Pk8KUhntM9fg@mail.gmail.com> <9F6FE96B71CF29479FF1CDC8046E15036D3803@039-SN1MPN1-003.039d.mgd.msft.net> <CAG8rG2ypiSUqfhqLTxgv0+Sh9DO9KAscJy0CmCrr_oG3tmGAgA@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAG8rG2ypiSUqfhqLTxgv0+Sh9DO9KAscJy0CmCrr_oG3tmGAgA@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Antonios Motakis <a.motakis@virtualopensystems.com>
Cc: Yoder Stuart-B08248 <B08248@freescale.com>, Alex Williamson <alex.williamson@redhat.com>, kvm-arm <kvmarm@lists.cs.columbia.edu>, Linux IOMMU <iommu@lists.linux-foundation.org>, Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>, KVM devel mailing list <kvm@vger.kernel.org>, VirtualOpenSystems Technical Team <tech@virtualopensystems.com>
List-Id: iommu@lists.linux-foundation.org


On 02.10.2013, at 13:21, Antonios Motakis wrote:

> On Tue, Oct 1, 2013 at 9:32 PM, Yoder Stuart-B08248
> <B08248@freescale.com> wrote:
>>> Antonios Motakis wrote
>>>> Alex Williamson <alex.williamson@redhat.com> wrote:
>>>> I notice all the open firmware calls here and I'm curious,
>>>> will all platform devices be making use of open firmware?
>>>> I don't know if this is synonymous with device tree or not.
>>>> Thanks,
>>> 
>>> This VFIO driver will support only devices implemented
>>> on the device tree. While there can be platform devices
>>> outside the device tree, I don't think it makes sense
>>> to support them from the same driver. This is why I
>>> originally called the driver VFIO_DT, however I renamed
>>> it to VFIO_PLATFORM after feedback from the first
>>> RFC. However personally, I still think the VFIO_DT name
>>> is more appropriate since we don't support all platform
>>> devices, only those that use the device tree.
>> 
>> But there is no 'device tree' bus.  The bus type we're
>> dealing with is a platform bus.
>> 
>> vfio for platform devices should be independent of whether
>> the device was discovered in a device tree or not.
>> All you're doing is exposing mappable regions and IRQs
>> to user space and it does not matter where the info originated.
>> 
>> You should be using platform bus structs here not
>> reparsing device tree nodes.  The struct
>> platform_device already has resource info in the
>> struct:
>> 
>> struct platform_device {
>>        const char      *name;
>>        u32             id;
>>        struct device   dev;
>>        u32             num_resources;
>>        struct resource *resource;
>> };
>> 
>> Stuart
>> 
> 
> I will look into this. However, can we rely to have access to all
> device resources through platform abstractions, for every type of
> platform device? It seems to me that platform devices that are not
> backed by a specific description mechanism (such as device tree) may
> include a lot of hard coded values etc in their drivers.

The same can be true for device tree based drivers. We should tell user space which device tree node this is based off of so it can go and find properties itself, similar to how a kernel driver can still read dt properties for a platform device. But this is optional - we could just as well give user space a hint on an acpi interface.

What exactly would you consider not abstracted information that the kernel driver would need to know about? All cases I can think of (reset logic, power constraints) are very device specific and would require a new vfio-dt-mydevice driver on top of your generic framework to handle these small device specific bits.


Alex
