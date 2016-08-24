From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v4 6/8] iommu/arm-smmu: Implement of_xlate() for SMMUv3
Date: Wed, 24 Aug 2016 16:08:18 +0100
Message-ID: <09911a58-1566-9a32-c911-f61e690d354a@arm.com>
References: <cover.1467388950.git.robin.murphy@arm.com>
 <925b054b1e96dc83c0b1dc9607785d0346187366.1467388950.git.robin.murphy@arm.com>
 <20160729144655.GA3359@e106794-lin.localdomain>
 <1d570682-d815-657e-2119-b706e0034e2c@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1d570682-d815-657e-2119-b706e0034e2c-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Philippe Brucker <Jean-Philippe.Brucker-5wv7dgnIgG8@public.gmane.org>, will.deacon-5wv7dgnIgG8@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 29/07/16 19:55, Robin Murphy wrote:
> On 29/07/16 15:46, Jean-Philippe Brucker wrote:
>> Hi Robin,
>>
>> Very sorry about the delay, I forgot about this minor comment, below
>>
>> On Fri, Jul 01, 2016 at 05:50:15PM +0100, Robin Murphy wrote:
[...]
>>> +		smmu = arm_smmu_get_by_node(fwspec->iommu_np);
>>> +		if (!smmu)
>>> +			return -ENODEV;
>>> +		master = kzalloc(sizeof(*master), GFP_KERNEL);
>>> +		if (!master)
>>> +			return -ENOMEM;
>>> +
>>> +		master->smmu = smmu;
>>> +		fwspec->iommu_priv = master;
>>
>> It's probably best to initialise master->ste.bypass = true here, to
>> reflect the initial state of STEs. Otherwise attach_dev always calls
>> detach_dev first for nothing.
> 
> I'm actually now thinking that that check in attach_dev() should be for
> ste->valid, rather than ste->bypass. That matches the similar check in
> remove_device(), and looking at old local branches I apparently did have
> it that way at some point, and I now can't quite remember why it ended
> up differently. I'll have a proper dig into it next week.

[for a value of "next week" relative to "last week", at least...]

Having now remembered, the reason it is this way is a subtle concession
to the nasty PCI RID alias case. When you come to probe the second
device behind a non-transparent bridge, the first device is already
attached to the default domain so the underlying STE is no longer a
bypass entry, but we've got no way of knowing that - we can't tell we're
going to be in an alias group until we call iommu_group_get_for_dev(),
and by the time that returns it's already too late, since the attach to
the default domain (and thus the attempt to write a now-valid STE with
the same data again) will have happened.

The least complicated ways around that that I can think of are 1)
inspect the stream table itself on attach, 2) maintain a semi-redundant
list within the group of exactly which ID is attached to which domain at
any point in time, 3) treat the initial per-device state as undefined
(!valid, !bypass) so that the initial domain attach is always a safe
break-before-make on the stream table, or 4) disallow aliasing IDs
entirely and just let the BUG() in write_strtab_ent() fire if a
non-transparent bridge ever comes along.

Discounting #4 as unreasonable, #3 is by far the least complicated, so
I've kept this as it is for now. #2 might seem reasonable at a glance,
but it wouldn't be useful for anything _except_ this specific situation,
which in practice we'd expect to encounter rarely if ever.

Robin.

>> Apart from that, this version works fine with my twisted setup. Note
>> that we might have to add a master->fwspec reference in the future, to
>> access those SIDs from various places. If I understood correctly, it
>> should be fine as those objects have the same lifetime after the
>> add_device call.
> 
> That sounds reasonable, although I can't think offhand where we might
> have a master_data without having got it via the containing device
> (unless we also add some other means of keeping track of them). Since
> this series doesn't need any kind of reverse-lookup capabilities I'm
> just keeping things as simple as possible for the time being.
> 
> Robin.
> 
>>
>> Thanks,
>> Jean-Philippe
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
