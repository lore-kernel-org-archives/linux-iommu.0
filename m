From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 1/3] iommu: Disambiguate MSI region types
Date: Mon, 13 Mar 2017 14:24:57 +0000
Message-ID: <5db5c64f-05e4-6167-3c29-b1607a794ce3@arm.com>
References: <1b012c7e82ccef1a34be38d81e82e74f129dfedc.1489088954.git.robin.murphy@arm.com>
	<a4b012cc-e95d-37af-374a-f06661798168@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <a4b012cc-e95d-37af-374a-f06661798168-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 13/03/17 13:08, Auger Eric wrote:
> Hi Robin,
> 
> On 09/03/2017 20:50, Robin Murphy wrote:
>> Whilst it doesn't matter much to VFIO at the moment, when parsing
>> reserved regions on the host side we really needs to be able to tell
> s/needs/need

Oops!

>> the difference between the software-reserved region used to map MSIs
>> translated by an IOMMU, and hardware regions for which the write might
>> never even reach the IOMMU. In particular, ARM systems assume the former
>> topology, but may need to cope with the latter as well, which will
>> require rather different handling in the iommu-dma layer.
>>
>> For clarity, rename the software-managed type to IOMMU_RESV_SW_MSI, use
>> IOMMU_RESV_MSI to describe the hardware type, and document everything a
>> little bit. Since the x86 MSI remapping hardware falls squarely under
>> this meaning of IOMMU_RESV_MSI, apply that type to their regions as well,
>> so that we tell a consistent story to userspace across platforms (and
>> have future consistency if those drivers start migrating to iommu-dma).
>>
>> Fixes: d30ddcaa7b02 ("iommu: Add a new type field in iommu_resv_region")
> does it really fall under the category of fix here?

I was somewhat on the fence about that, as the rationale above does tend
towards future new functionality, but the primary effect of this patch
alone is an ABI-visible change for x86 in terms of "expose the MSI
region as an MSI region". IMO it would be better to get that in before
said ABI gets baked into a kernel release, hence leaning towards the
"fix" side of things. I'm happy to rewrite the commit message in reverse
order (i.e. "clean up this ABI inconsistency, with these additional
benefits") if it would be clearer.

>> CC: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>> CC: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>> CC: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
>> CC: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>> ---
>>  drivers/iommu/amd_iommu.c       | 2 +-
>>  drivers/iommu/arm-smmu-v3.c     | 2 +-
>>  drivers/iommu/arm-smmu.c        | 2 +-
>>  drivers/iommu/intel-iommu.c     | 2 +-
>>  drivers/iommu/iommu.c           | 1 +
>>  drivers/vfio/vfio_iommu_type1.c | 2 +-
>>  include/linux/iommu.h           | 5 +++++
>>  7 files changed, 11 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
>> index 98940d1392cb..b17536d6e69b 100644
>> --- a/drivers/iommu/amd_iommu.c
>> +++ b/drivers/iommu/amd_iommu.c
>> @@ -3202,7 +3202,7 @@ static void amd_iommu_get_resv_regions(struct device *dev,
>>  
>>  	region = iommu_alloc_resv_region(MSI_RANGE_START,
>>  					 MSI_RANGE_END - MSI_RANGE_START + 1,
>> -					 0, IOMMU_RESV_RESERVED);
>> +					 0, IOMMU_RESV_MSI);
>>  	if (!region)
>>  		return;
>>  	list_add_tail(&region->list, head);
>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>> index 5806a6acc94e..591bb96047c9 100644
>> --- a/drivers/iommu/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm-smmu-v3.c
>> @@ -1888,7 +1888,7 @@ static void arm_smmu_get_resv_regions(struct device *dev,
>>  	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
>>  
>>  	region = iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
>> -					 prot, IOMMU_RESV_MSI);
>> +					 prot, IOMMU_RESV_SW_MSI);
>>  	if (!region)
>>  		return;
>>  
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index abf6496843a6..b493c99e17f7 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -1608,7 +1608,7 @@ static void arm_smmu_get_resv_regions(struct device *dev,
>>  	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
>>  
>>  	region = iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
>> -					 prot, IOMMU_RESV_MSI);
>> +					 prot, IOMMU_RESV_SW_MSI);
>>  	if (!region)
>>  		return;
>>  
>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>> index 238ad3447712..f1611fd6f5b0 100644
>> --- a/drivers/iommu/intel-iommu.c
>> +++ b/drivers/iommu/intel-iommu.c
>> @@ -5249,7 +5249,7 @@ static void intel_iommu_get_resv_regions(struct device *device,
>>  
>>  	reg = iommu_alloc_resv_region(IOAPIC_RANGE_START,
>>  				      IOAPIC_RANGE_END - IOAPIC_RANGE_START + 1,
>> -				      0, IOMMU_RESV_RESERVED);
>> +				      0, IOMMU_RESV_MSI);
>>  	if (!reg)
>>  		return;
>>  	list_add_tail(&reg->list, head);
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 8ea14f41a979..7dbc05f10d5a 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -72,6 +72,7 @@ static const char * const iommu_group_resv_type_string[] = {
>>  	[IOMMU_RESV_DIRECT]	= "direct",
>>  	[IOMMU_RESV_RESERVED]	= "reserved",
>>  	[IOMMU_RESV_MSI]	= "msi",
>> +	[IOMMU_RESV_SW_MSI]	= "msi",

As a side note, is it intentional that the values are bitfields, in
other words, is it ever going to make sense to combine them? The fact
that we use them directly to index an array here suggests not, and that
we might be better off with a plain enum. Otherwise, another possibility
would be to keep a single "MSI" type flag and add a separate
"software-managed" flag alongside it, with a corresponding tweak to
iommu_group_show_resv_regions(). Does anyone have a strong opinion
either way?

>>  };
>>  
>>  #define IOMMU_GROUP_ATTR(_name, _mode, _show, _store)		\
>> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
>> index c26fa1f3ed86..e32abdebd2df 100644
>> --- a/drivers/vfio/vfio_iommu_type1.c
>> +++ b/drivers/vfio/vfio_iommu_type1.c
>> @@ -1192,7 +1192,7 @@ static bool vfio_iommu_has_resv_msi(struct iommu_group *group,
> Maybe we should change the name of the function into
> vfio_iommu_has_resv_sw_msi?

Good idea, will do.

> Besides
> Reviewed-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Thanks!

Robin.

> 
> Thanks
> 
> Eric
> 
> 
>>  	INIT_LIST_HEAD(&group_resv_regions);
>>  	iommu_get_group_resv_regions(group, &group_resv_regions);
>>  	list_for_each_entry(region, &group_resv_regions, list) {
>> -		if (region->type & IOMMU_RESV_MSI) {
>> +		if (region->type & IOMMU_RESV_SW_MSI) {
>>  			*base = region->start;
>>  			ret = true;
>>  			goto out;
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index 6a6de187ddc0..fad2c4913be4 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -125,9 +125,14 @@ enum iommu_attr {
>>  };
>>  
>>  /* These are the possible reserved region types */
>> +/* Memory regions which must have 1:1 translations present at all times */
>>  #define IOMMU_RESV_DIRECT	(1 << 0)
>> +/* Arbitrary "never map this or give it to a device" address ranges */
>>  #define IOMMU_RESV_RESERVED	(1 << 1)
>> +/* Hardware MSI region (untranslated) */
>>  #define IOMMU_RESV_MSI		(1 << 2)
>> +/* Software-managed MSI translation window */
>> +#define IOMMU_RESV_SW_MSI	(1 << 3)
>>  
>>  /**
>>   * struct iommu_resv_region - descriptor for a reserved memory region
>>
