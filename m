From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v5 04/19] iommu/of: Introduce iommu_fwspec
Date: Thu, 1 Sep 2016 13:07:19 +0100
Message-ID: <900f3dcb-217c-4fb3-2f7d-15572f31a0c0@arm.com>
References: <cover.1471975357.git.robin.murphy@arm.com>
 <3e8eaf4fd65833fecc62828214aee81f6ca6c190.1471975357.git.robin.murphy@arm.com>
 <20160831172856.GI29505@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160831172856.GI29505-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 31/08/16 18:28, Will Deacon wrote:
> On Tue, Aug 23, 2016 at 08:05:15PM +0100, Robin Murphy wrote:
>> Introduce a common structure to hold the per-device firmware data that
>> non-architectural IOMMU drivers generally need to keep track of.
>> Initially this is DT-specific to complement the existing of_iommu
>> support code, but will generalise further once other firmware methods
>> (e.g. ACPI IORT) come along.
>>
>> Ultimately the aim is to promote the fwspec to a first-class member of
>> struct device, and handle the init/free automatically in the firmware
>> code. That way we can have API calls look for dev->fwspec->iommu_ops
>> before falling back to dev->bus->iommu_ops, and thus gracefully handle
>> those troublesome multi-IOMMU systems which we currently cannot. To
>> start with, though, make use of the existing archdata field and delegate
>> the init/free to drivers to allow an incremental conversion rather than
>> the impractical pain of trying to attempt everything in one go.
>>
>> Suggested-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
>> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>> ---
>>
>> v5: Fix shocking num_ids oversight.
>>
>>  drivers/iommu/of_iommu.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/of_iommu.h | 15 ++++++++++++++
>>  2 files changed, 67 insertions(+)
>>
>> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
>> index 1a65cc806898..bec51eb47b0d 100644
>> --- a/drivers/iommu/of_iommu.c
>> +++ b/drivers/iommu/of_iommu.c
>> @@ -219,3 +219,55 @@ static int __init of_iommu_init(void)
>>  	return 0;
>>  }
>>  postcore_initcall_sync(of_iommu_init);
>> +
>> +int iommu_fwspec_init(struct device *dev, struct device_node *iommu_np)
>> +{
>> +	struct iommu_fwspec *fwspec = dev->archdata.iommu;
>> +
>> +	if (fwspec)
>> +		return 0;
>> +
>> +	fwspec = kzalloc(sizeof(*fwspec), GFP_KERNEL);
>> +	if (!fwspec)
>> +		return -ENOMEM;
>> +
>> +	fwspec->iommu_np = of_node_get(iommu_np);
>> +	fwspec->iommu_ops = of_iommu_get_ops(iommu_np);
>> +	dev->archdata.iommu = fwspec;
>> +	return 0;
>> +}
>> +
>> +void iommu_fwspec_free(struct device *dev)
>> +{
>> +	struct iommu_fwspec *fwspec = dev->archdata.iommu;
>> +
>> +	if (fwspec) {
>> +		of_node_put(fwspec->iommu_np);
>> +		kfree(fwspec);
>> +	}
>> +}
>> +
>> +int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids)
>> +{
>> +	struct iommu_fwspec *fwspec = dev->archdata.iommu;
>> +	size_t size;
>> +
>> +	if (!fwspec)
>> +		return -EINVAL;
>> +
>> +	size = offsetof(struct iommu_fwspec, ids[fwspec->num_ids + num_ids]);
>> +	fwspec = krealloc(dev->archdata.iommu, size, GFP_KERNEL);
>> +	if (!fwspec)
>> +		return -ENOMEM;
>> +
>> +	while (num_ids--)
>> +		fwspec->ids[fwspec->num_ids++] = *ids++;
>> +
>> +	dev->archdata.iommu = fwspec;
> 
> It might just be me, but I find this really fiddly to read. The fact
> that you realloc the whole fwspec, rather than just the array isn't
> helping, but I also think that while loop would be much better off as
> a for loop, using the index as, well, an index into the ids array and
> fwspec->ids array.

Sure - copying one array into the tail end of another is always going to
be boring, ugly code, which I feel compelled to make as compact as
possible so as not to distract from the more interesting code, but I
guess that's self-defeating if it then no longer looks like something
simple and boring to skip over. I'll expend a few more precious lines on
turning it back into something staid and sensible ;)

My argument for embedding the IDs directly in the fwspec is that for
most devices there's only likely to be a single one anyway, and other
than a brief period up until add_device() they're then going to be fixed
for the lifetime of the device, so saving a little memory fragmentation
and a level of indirection on all subsequent uses is certainly not going
to be detrimental (plus it slightly simplifies the cleanup/free cases
here as well).

Robin.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
