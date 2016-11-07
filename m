From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH V3 0/8] IOMMU probe deferral support
Date: Mon, 7 Nov 2016 19:22:19 +0000
Message-ID: <9f36244f-62d4-08e3-d64a-2b04ad4dc2e0@arm.com>
References: <1475600632-21289-1-git-send-email-sricharan@codeaurora.org>
	<60ee8066-f167-e9df-ae3e-4138f1133bad@arm.com>
	<003a01d22f97$82534c70$86f9e550$@codeaurora.org>
	<421e2b14-0231-d376-02a0-097423120b3d@arm.com>
	<006f01d236ae$61751c40$245f54c0$@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <006f01d236ae$61751c40$245f54c0$@codeaurora.org>
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

Hi Sricharan,

On 04/11/16 15:16, Sricharan wrote:
> Hi Robin,
> 
>>>> Yikes, on second look, that definitely shouldn't be happening.
>>>> Everything below is probably the resulting fallout.
>>>
>>> [   40.206703] vfio-pci 0000:08:00.0: Failed to setup iommu ops
>>>
>>> I think the above print which says "failed to setup iommu_ops"
>>> because the call ops->add_device failed in of_pci_iommu_configure
>>> is the reason for the failure, in my case i simply do not get this even with
>>> your scripts. ops->add_device succeeds in the rebind as well. So still
>>> checking what could be happening in your case.
>>
>> I was looking at your code base from [1].The ops->add_device
>> callback from of_pci_iommu_configure on the rebind is the
>> one which is causing the failure. But not able to spot out
>>from code which point is causing the failure. It would be very helpful
>> if i can know which is the return value from the add_device callback
>> or point inside add_device callback which fails in your setup.
>>
>>
>> [1] git://linux-arm.org/linux-rm iommu/misc
> 
> With little more try, i saw an issue where i had an failure
> similar to what you reported. The issue happens when multiple
> devices fall in to same group due to matching sids. I ended up
> doing a fix like below and it would be nice to verify if it is the same
> that we are seeing in your setup and if the fix makes a difference ?
> 
> From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> Date: Fri, 4 Nov 2016 20:28:49 +0530
> Subject: [PATCH] iommu/arm-smmu: Fix group's reference counting
> 
> iommu_group_get_for_dev which gets called in the add_device
> callback, increases the reference count of the iommu_group,
> so we do an iommu_group_put after that. iommu_group_get_for_dev
> inturn calls device_group callback and in the case of arm-smmu
> we call generic_device_group/pci_device_group which takes
> care of increasing the group's reference. But when we return
> an already existing group(when multiple devices have same group)
> the reference is not incremented, resulting in issues when the
> remove_device callback for the devices is invoked.
> Fixing the same here.

Bah, yes, this does look like my fault - after flip-flopping between
about 3 different ways to keep refcounts for the S2CR entries, none of
which would quite work, I ripped it all out but apparently still got
things wrong, oh well. Thanks for figuring it out.

On the probe-deferral angle, whilst it's useful to have uncovered this
bug, I don't think we should actually be calling remove_device() from
DMA teardown. I think it's preferable from a user perspective if group
numbering remains stable, rather than changing depending on the order in
which they unbind/rebind VFIO drivers. I'm really keen to try and get
this in shape for 4.10, so I've taken the liberty of hacking up my own
branch (iommu/defer) based on v3 - would you mind taking a look at the
two "iommu/of:" commits to see what you think? (Ignore the PCI changes
to your later patches - that was an experiment which didn't really work out)

> Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> ---
>  drivers/iommu/arm-smmu.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 71ce4b6..a1d0b3c 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -1516,8 +1516,10 @@ static struct iommu_group *arm_smmu_device_group(struct device *dev)
>  		group = smmu->s2crs[idx].group;
>  	}
>  
> -	if (group)
> +	if (group) {
> +		iommu_group_get_by_id(iommu_group_id(group));
>  		return group;

This might as well just be inline, i.e.:

		return iommu_group_get_by_id(iommu_group_id(group));

It's a shame we have to go all round the houses when we have the group
right there, but this is probably the most expedient fix. I guess we can
extend the API with some sort of iommu_group_get(group) overload in
future if we really want to.

Robin.

> +	}
>  
>  	if (dev_is_pci(dev))
>  		group = pci_device_group(dev);
> 
