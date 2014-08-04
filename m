From: Sachin Kamat <spk.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/1] iommu: exynos: Fix trivial typos
Date: Mon, 4 Aug 2014 09:55:35 +0530
Message-ID: <CAK5sBcFtiYc_O5WJLKXxSRL2JOaRG4=fzTn2q5FebSm6A2a=5w@mail.gmail.com>
References: <1406959395-22600-1-git-send-email-sachin.kamat@samsung.com>
	<53DC8F86.9020007@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <53DC8F86.9020007-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, trivial-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Sat, Aug 2, 2014 at 12:43 PM, Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org> wrote:
> On 08/01/14 23:03, Sachin Kamat wrote:
>> Fixed trivial typos and grammar to improve readability.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>> ---
>>  drivers/iommu/exynos-iommu.c | 22 +++++++++++-----------
>>  1 file changed, 11 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
>> index d037e87..327ebec 100644
>> --- a/drivers/iommu/exynos-iommu.c
>> +++ b/drivers/iommu/exynos-iommu.c
>> @@ -32,7 +32,7 @@
>>  typedef u32 sysmmu_iova_t;
>>  typedef u32 sysmmu_pte_t;
>>
>> -/* We does not consider super section mapping (16MB) */
>> +/* We do not consider super section mapping (16MB) */
>>  #define SECT_ORDER 20
>>  #define LPAGE_ORDER 16
>>  #define SPAGE_ORDER 12
>> @@ -307,7 +307,7 @@ static void show_fault_information(const char *name,
>>
>>  static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
>>  {
>> -     /* SYSMMU is in blocked when interrupt occurred. */
>> +     /* SYSMMU is in blocked state when interrupt occurred. */
>>       struct sysmmu_drvdata *data = dev_id;
>>       enum exynos_sysmmu_inttype itype;
>>       sysmmu_iova_t addr = -1;
>> @@ -567,8 +567,8 @@ static void sysmmu_tlb_invalidate_entry(struct device *dev, sysmmu_iova_t iova,
>>               /*
>>                * L2TLB invalidation required
>>                * 4KB page: 1 invalidation
>> -              * 64KB page: 16 invalidation
>> -              * 1MB page: 64 invalidation
>> +              * 64KB page: 16 invalidations
>> +              * 1MB page: 64 invalidations
>>                * because it is set-associative TLB
>>                * with 8-way and 64 sets.
>>                * 1MB page can be cached in one of all sets.
>> @@ -862,13 +862,13 @@ static sysmmu_pte_t *alloc_lv2entry(struct exynos_iommu_domain *priv,
>>
>>               /*
>>                * If pretched SLPD is a fault SLPD in zero_l2_table, FLPD cache
>
> What is               pretched ?

Should have been pre-fetched.

>
>> -              * may caches the address of zero_l2_table. This function
>> +              * may cache the address of zero_l2_table. This function
>>                * replaces the zero_l2_table with new L2 page table to write
>>                * valid mappings.
>>                * Accessing the valid area may cause page fault since FLPD
>> -              * cache may still caches zero_l2_table for the valid area
>> +              * cache may still cache zero_l2_table for the valid area
>>                * instead of new L2 page table that have the mapping
>
>                                                      has
>
>> -              * information of the valid area
>> +              * information of the valid area.
>>                * Thus any replacement of zero_l2_table with other valid L2
>>                * page table must involve FLPD cache invalidation for System
>>                * MMU v3.3.
>> @@ -963,14 +963,14 @@ static int lv2set_page(sysmmu_pte_t *pent, phys_addr_t paddr, size_t size,
>>  /*
>>   * *CAUTION* to the I/O virtual memory managers that support exynos-iommu:
>>   *
>> - * System MMU v3.x have an advanced logic to improve address translation
>> + * System MMU v3.x has an advanced logic to improve address translation
>
>                   drop:   an
> just say:             has advanced logic

OK.

>
>>   * performance with caching more page table entries by a page table walk.
>>   * However, the logic has a bug that caching fault page table entries and System
>>   * MMU reports page fault if the cached fault entry is hit even though the fault
>>   * entry is updated to a valid entry after the entry is cached.
>>   * To prevent caching fault page table entries which may be updated to valid
>>   * entries later, the virtual memory manager should care about the w/a about the
>> - * problem. The followings describe w/a.
>> + * problem. The following describes w/a.
>>   *
>
> Please change all "w/a" to "workaround".
> It took me a while to figure out what w/a means.

It did to me too :). Will replace.

>
>>   * Any two consecutive I/O virtual address regions must have a hole of 128KiB
>>   * in maximum to prevent misbehavior of System MMU 3.x. (w/a of h/w bug)
>> @@ -982,8 +982,8 @@ static int lv2set_page(sysmmu_pte_t *pent, phys_addr_t paddr, size_t size,
>>   *
>>   * Because System MMU v3.3 caches page table entries more aggressively, it needs
>>   * more w/a.
>> - * - Any two consecutive I/O virtual regions must be have a hole of larger size
>> - *   than or equal size to 128KiB.
>> + * - Any two consecutive I/O virtual regions must be have a hole of size larger
>
>                                                 must have a hole
>
>> + *   than or equal to 128KiB.
>>   * - Start address of an I/O virtual region must be aligned by 128KiB.
>>   */
>>  static int exynos_iommu_map(struct iommu_domain *domain, unsigned long l_iova,

Thanks for the review. Will incorporate all your comments.

-- 
Regards,
Sachin.
