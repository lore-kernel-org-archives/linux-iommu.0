From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 6/7] iommu/arm-smmu: Decouple context format from kernel
	config
Date: Fri, 22 Apr 2016 18:38:04 +0100
Message-ID: <571A617C.3020102@arm.com>
References: <cover.1460391217.git.robin.murphy@arm.com>
	<173006777218859d1671ae517c70592c6c02f630.1460391217.git.robin.murphy@arm.com>
	<20160421163019.GL929@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160421163019.GL929-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, brian.starkey-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 21/04/16 17:30, Will Deacon wrote:
> Hi Robin,
>
> On Wed, Apr 13, 2016 at 06:13:02PM +0100, Robin Murphy wrote:
>> The way the driver currently forces an AArch32 or AArch64 context format
>> based on the kernel config and SMMU architecture version is suboptimal,
>> in that it makes it very hard to support oddball mix-and-match cases
>> like the SMMUv1 64KB supplement, or situations where the reduced table
>> depth of an AArch32 short descriptor context may be desirable under an
>> AArch64 kernel. It also only happens to work on current implementations
>> which do support all the relevant formats.
>>
>> Introduce an explicit notion of context format, so we can manage that
>> independently and get rid of the inflexible #ifdeffery.
>
> Thanks for doing all of this! One comment on the page size stuff:
>
>> +	if (IS_ENABLED(CONFIG_64BIT) || cfg->fmt == ARM_SMMU_CTX_FMT_NONE) {
>> +		switch (PAGE_SIZE) {
>> +		case SZ_64K:
>> +			if (smmu->features & ARM_SMMU_FEAT_FMT_AARCH64_64K) {
>> +				cfg->fmt = ARM_SMMU_CTX_FMT_AARCH64;
>> +				break;
>> +			} /* else fall through */
>> +		case SZ_16K:
>> +			if (smmu->features & ARM_SMMU_FEAT_FMT_AARCH64_16K) {
>> +				cfg->fmt = ARM_SMMU_CTX_FMT_AARCH64;
>> +				break;
>> +			} /* else fall through */
>> +		case SZ_4K:
>> +			if (smmu->features & ARM_SMMU_FEAT_FMT_AARCH64_4K)
>> +				cfg->fmt = ARM_SMMU_CTX_FMT_AARCH64;
>> +		}
>> +	}
>
> The io-pgtable code (arm_lpae_restrict_pgsizes) already does something
> *very* similar to this, using the pgsize_bitmap as input. Can you not
> just choose the ARM_SMMU_CTX_FMT_AARCH64 here and set the pgsize_bitmap
> to represent all page sizes supported by the hardware? That way, you should
> end up with the best option coming back from the pgtable code (I do this
> in the v3 driver, fwiw).

It took a while to come back to me, but the problem is that we can't 
call alloc_io_pgtable_ops(fmt...) before choosing either ARM_64_LPAE_Sx 
or ARM_32_LPAE_Sx for fmt, but if we commit to 64-bit we'll get stuck 
later without the possibility of falling back to AArch32 if it turns out 
we don't have a viable AArch64 granule. Plus we'd have to remove the 
LPAE page sizes from the bitmap beforehand in the case we don't support 
AARCH64_4K lest we end up with a phantom format the hardware doesn't 
actually do, and it all starts getting rather horrible...

Robin.

> Will
>
