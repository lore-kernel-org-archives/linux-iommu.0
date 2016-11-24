From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH V3 0/8] IOMMU probe deferral support
Date: Thu, 24 Nov 2016 19:11:43 +0000
Message-ID: <f2ad6976-0f8f-d116-bc43-37337dd9f41f@arm.com>
References: <1475600632-21289-1-git-send-email-sricharan@codeaurora.org>
	<60ee8066-f167-e9df-ae3e-4138f1133bad@arm.com>
	<003a01d22f97$82534c70$86f9e550$@codeaurora.org>
	<421e2b14-0231-d376-02a0-097423120b3d@arm.com>
	<006f01d236ae$61751c40$245f54c0$@codeaurora.org>
	<9f36244f-62d4-08e3-d64a-2b04ad4dc2e0@arm.com>
	<002b01d24340$5d56e730$1804b590$@codeaurora.org>
	<918128b9-cdb0-1454-000a-146cee7a05ea@arm.com>
	<004401d2466d$5b8b2170$12a16450$@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <004401d2466d$5b8b2170$12a16450$@codeaurora.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sricharan <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 24/11/16 16:10, Sricharan wrote:
> Hi Robin,
> 
> <snip..>
> 
>>
>>>>>>> iommu_group_get_for_dev which gets called in the add_device
>>>>>>> callback, increases the reference count of the iommu_group,
>>>>>>> so we do an iommu_group_put after that. iommu_group_get_for_dev
>>>>>>> inturn calls device_group callback and in the case of arm-smmu
>>>>>>> we call generic_device_group/pci_device_group which takes
>>>>>>> care of increasing the group's reference. But when we return
>>>>>>> an already existing group(when multiple devices have same group)
>>>>>>> the reference is not incremented, resulting in issues when the
>>>>>>> remove_device callback for the devices is invoked.
>>>>>>> Fixing the same here.
>>>>>>
>>>>>> Bah, yes, this does look like my fault - after flip-flopping between
>>>>>> about 3 different ways to keep refcounts for the S2CR entries, none of
>>>>>> which would quite work, I ripped it all out but apparently still got
>>>>>> things wrong, oh well. Thanks for figuring it out.
>>>>>>
>>>>>> On the probe-deferral angle, whilst it's useful to have uncovered this
>>>>>> bug, I don't think we should actually be calling remove_device() from
>>>>>> DMA teardown. I think it's preferable from a user perspective if group
>>>>>> numbering remains stable, rather than changing depending on the order in
>>>>>> which they unbind/rebind VFIO drivers. I'm really keen to try and get
>>>>>> this in shape for 4.10, so I've taken the liberty of hacking up my own
>>>>>> branch (iommu/defer) based on v3 - would you mind taking a look at the
>>>>>> two "iommu/of:" commits to see what you think? (Ignore the PCI changes
>>>>>> to your later patches - that was an experiment which didn't really work out)
>>>>>
>>>>> Ok, will take a look at this now and respond more on this.
>>>>>
>>>> Sorry for the delayed response on this. I was OOO for the last few days.
>>>> So i tested this branch and it worked fine. I tested it with a pci device
>>>> for both normal and deferred probe cases.  The of/iommu patches
>>>> are the cleanup/preparation patches and it looks fine. One thing is without
>>>> calling the remove_device callback, the resources like (smes for exmaple)
>>>> and the group association of the device all remain allocated. That does not
>>>> feel correct, given that the associated device does not exist. So to
>>>> understand that, what happens with VFIO in this case which makes the
>>>> group renumbering/rebinding a problem ?
>>>>
>>>
>>> Would it be ok if i post a V4 based on your branch above ?
>>
>> Sure, as long as none of the hacks slip through :) - I've just pushed
>> out a mild rework based on Lorenzo's v9, which I hope shouldn't break
>> anything for you.
>>
> 
> Ok sure, i will test and just the post out the stuff from your branch then
> mostly by tomorrow.

Cool. We're rather hoping that the ACPI stuff is good to go for 4.10
now, so it's probably worth pulling the rest of that in (beyond the one
patch I picked) to make sure the of_dma_configure/acpi_dma_configure
paths don't inadvertently diverge.

>> Having thought a bit more about the add/remove thing, I'm inclined to
>> agree that the group numbering itself may not be that big an issue in
>> practice - sure, it could break my little script, but it looks like QEMU
>> and such work with the device ID rather than the group number directly,
>> so might not even notice. However, the fact remains that the callbacks
>> are intended to handle a device being added to/removed from its bus, and
>> will continue to do so on other platforms, so I don't like the idea of
>> introducing needlessly different behaviour. If you unbind a driver, the
>> stream IDs and everything don't stop existing at the hardware level; the
>> struct device to which the in-kernel data belongs still exists and
>> doesn't stop being associated with its bus. There's no good reason for
>> freeing SMEs that we'll only reallocate again (inadequately-specced
>> hardware with not enough SMRs/contexts is not a *good* reason), and
> 
> ok, so SMRs/contexts was the reason i was adding the remove_dev
> callback, but if thats not good enough then there was no other
> intention.
> 
>> there are also some strong arguments against letting any stream IDs the
>> kernel knows about go back to bypass after a driver has been bound - by
> 
> ok, but not sure why is this so ?

Any device the kernel is in control of, having bound a driver to it,
definitely should not be doing DMA after that driver is unbound...

>> keeping groups around as expected that's something we can implement
>> quite easily without having to completely lock down bypass for stream
>> IDs the kernel *doesn't* know about.
>>
> 
> So do you mean in this case to keep the unbound device's group/context bank
> to bypass rather than resetting the streamids ?

...which we can easily enforce by keeping the device attached to its
default domain, in which nothing should be mapped by that point (we
could even have a group notifier switch its S2CRs to faulting entries
for extreme paranoia). Freeing the SMRs means those stream IDs would
instead fall back to the default "unmatched" behaviour, which in general
is going to be bypass, and thus allow DMA attacks.

It's harder to disable unmatched bypass in general, because we may have
devices which physically master through the SMMU but want low latency
more than they want translation (at the moment the best we can do is
leave the kernel unaware of those stream IDs), or there could be unknown
devices under control of the firmware or other agents which we would
disrupt by hitting a system-wide switch.

Robin.

> 
> Regards,
>  Sricharan
> 
