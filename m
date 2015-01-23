From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH 3/5] iommu: implement common IOMMU ops for DMA mapping
Date: Fri, 23 Jan 2015 18:14:03 +0000
Message-ID: <54C28F6B.4020707@arm.com>
References: <cover.1421086706.git.robin.murphy@arm.com>
	<09e5515a9afcb3235f4c425520cd18a6032d31b4.1421086706.git.robin.murphy@arm.com>
	<54C287F7.3060603@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <54C287F7.3060603-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Laura Abbott <lauraa-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Cc: "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "stefano.stabellini-mvvWK6WmYclDPfheJLI6IQ@public.gmane.org" <stefano.stabellini-mvvWK6WmYclDPfheJLI6IQ@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, "thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Laura,

Thanks for looking

On 23/01/15 17:42, Laura Abbott wrote:
> On 1/12/2015 12:48 PM, Robin Murphy wrote:
>> Taking inspiration from the existing arch/arm code, break out some
>> generic functions to interface the DMA-API to the IOMMU-API. This will
>> do the bulk of the heavy lifting for IOMMU-backed dma-mapping.
>>
>> Whilst the target is arm64, rather than introduce yet another private
>> implementation, place this in common code as the first step towards
>> consolidating the numerous versions spread around between architecture
>> code and IOMMU drivers.
>>
>> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>> ---
>>    include/linux/dma-iommu.h |  78 ++++++++
>>    lib/Kconfig               |   8 +
>>    lib/Makefile              |   1 +
>>    lib/dma-iommu.c           | 455 ++++++++++++++++++++++++++++++++++++++++++++++
>>    4 files changed, 542 insertions(+)
>>    create mode 100644 include/linux/dma-iommu.h
>>    create mode 100644 lib/dma-iommu.c
>>
>> diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
>> new file mode 100644
>> index 0000000..4515407
>> --- /dev/null
>> +++ b/include/linux/dma-iommu.h
> <snip>
>> +
>> +struct iommu_dma_mapping *iommu_dma_create_mapping(struct iommu_ops *ops,
>> +		dma_addr_t base, size_t size)
>> +{
>> +	struct iommu_dma_mapping *mapping;
>> +	struct iommu_domain *domain;
>> +	struct iova_domain *iovad;
>> +	struct iommu_domain_geometry *dg;
>> +	unsigned long order, base_pfn, end_pfn;
>> +
>> +	pr_debug("base=%pad\tsize=0x%zx\n", &base, size);
>> +	mapping = kzalloc(sizeof(*mapping), GFP_KERNEL);
>> +	if (!mapping)
>> +		return NULL;
>> +
>> +	/*
>> +	 * HACK: We'd like to ask the relevant IOMMU in ops for a suitable
>> +	 * domain, but until that happens, bypass the bus nonsense and create
>> +	 * one directly for this specific device/IOMMU combination...
>> +	 */
>> +	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
>> +
>> +	if (!domain)
>> +		goto out_free_mapping;
>> +	domain->ops = ops;
>> +
>> +	if (ops->domain_init(domain))
>> +		goto out_free_mapping;
>> +	/*
>> +	 * ...and do the bare minimum to sanity-check that the domain allows
>> +	 * at least some access to the device...
>> +	 */
>> +	dg = &domain->geometry;
>> +	if (!(base < dg->aperture_end && base + size > dg->aperture_start)) {
>> +		pr_warn("DMA range outside IOMMU capability; is DT correct?\n");
>> +		goto out_free_mapping;
>> +	}
>
> This check seems to always fail with base = 0 because dg->aperture_end is
> always going to be 0 as well. base <= dg->aperature_end ?
>

Strictly you're right, since aperture_end should be the highest mappable 
address thus you could create a valid, if a little silly, 1-byte domain 
if both were zero. However, it shouldn't really be zero.

I put this bit in since the majority of IOMMU drivers set up the 
geometry in domain_init and it seemed worth making use of. The ARM SMMU 
driver is currently one of the odd ones out that don't, however one of 
my as-yet-unpublished patches porting it to the new of_iommu_configure 
framework involves fixing domain initialisation and adds geometry setup 
as well - that's what I've been testing with. I'm hoping to get that 
series out soon, but among other things it needs a messy merge with 
Will's pagetable changes.

Robin.
