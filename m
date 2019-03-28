From: Gary R Hook <ghook-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] iommu/amd: Reserve exclusion range in iova-domain
Date: Thu, 28 Mar 2019 14:52:19 +0000
Message-ID: <3850c381-30d6-b2a3-d976-66939d8e612a@amd.com>
References: <20190328104459.18589-1-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190328104459.18589-1-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Content-Language: en-US
Content-ID: <C3B4F7566688114BA14F07BD9F5697E9-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 3/28/19 5:44 AM, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> 
> If a device has an exclusion range specified in the IVRS
> table, this region needs to be reserved in the iova-domain
> of that device. This hasn't happened until now and can cause
> data corruption on data transfered with these devices.
> 
> Treat exclusion ranges as reserved regions in the iommu-core
> to fix the problem.
> 
> Fixes: be2a022c0dd0 ('x86, AMD IOMMU: add functions to parse IOMMU memory mapping requirements for devices')
> Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> ---
>   drivers/iommu/amd_iommu.c      | 9 ++++++---
>   drivers/iommu/amd_iommu_init.c | 7 ++++---
>   2 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index 21cb088d6687..2a8d2806d5b9 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -3169,21 +3169,24 @@ static void amd_iommu_get_resv_regions(struct device *dev,
>   		return;
>   
>   	list_for_each_entry(entry, &amd_iommu_unity_map, list) {
> +		int type, prot = 0;
>   		size_t length;
> -		int prot = 0;
>   
>   		if (devid < entry->devid_start || devid > entry->devid_end)
>   			continue;
>   
> +		type   = IOMMU_RESV_DIRECT;
>   		length = entry->address_end - entry->address_start;
>   		if (entry->prot & IOMMU_PROT_IR)
>   			prot |= IOMMU_READ;
>   		if (entry->prot & IOMMU_PROT_IW)
>   			prot |= IOMMU_WRITE;
> +		if (entry->prot & (1 << 2))

Could we add
#define IOMMU_WRITE_EXCL (1 << 2)
to amd_iommu_types.h?

The bit is documented in the AMD IOMMU spec, so this seems safe...

> +			/* Exclusion range */
> +			type = IOMMU_RESV_RESERVED;
>   
>   		region = iommu_alloc_resv_region(entry->address_start,
> -						 length, prot,
> -						 IOMMU_RESV_DIRECT);
> +						 length, prot, type);
>   		if (!region) {
>   			dev_err(dev, "Out of memory allocating dm-regions\n");
>   			return;
> diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
> index f773792d77fd..1b1378619fc9 100644
> --- a/drivers/iommu/amd_iommu_init.c
> +++ b/drivers/iommu/amd_iommu_init.c
> @@ -2013,6 +2013,9 @@ static int __init init_unity_map_range(struct ivmd_header *m)
>   	if (e == NULL)
>   		return -ENOMEM;
>   
> +	if (m->flags & IVMD_FLAG_EXCL_RANGE)
> +		init_exclusion_range(m);
> +
>   	switch (m->type) {
>   	default:
>   		kfree(e);
> @@ -2059,9 +2062,7 @@ static int __init init_memory_definitions(struct acpi_table_header *table)
>   
>   	while (p < end) {
>   		m = (struct ivmd_header *)p;
> -		if (m->flags & IVMD_FLAG_EXCL_RANGE)
> -			init_exclusion_range(m);
> -		else if (m->flags & IVMD_FLAG_UNITY_MAP)
> +		if (m->flags & (IVMD_FLAG_UNITY_MAP | IVMD_FLAG_EXCL_RANGE))
>   			init_unity_map_range(m);
>   
>   		p += m->length;
> 

The problem I see here is that if, for some untold reason, there is more 
than one exclusion range emitted, where only the last one wins in the 
hardware, we'd still end up with more than one range reserved in the 
IOVA tree. Clearly, this is extremely unlikely, but wouldn't we want to 
protect against that sort of misuse/mistake?

I could be missing something.
