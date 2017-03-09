From: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 03/09] iommu/ipmmu-vmsa: Enable multi context support
Date: Thu, 9 Mar 2017 13:16:05 +0900
Message-ID: <CANqRtoQ37DhHkV=k-b09_cvyiXMwaqFhATa=vOpU4mhHvuYdPA@mail.gmail.com>
References: <148897088333.16106.13237004440297956899.sendpatchset@little-apple>
	<148897091345.16106.2935423334300744039.sendpatchset@little-apple>
	<bdf40dff-c958-b749-1149-f9417c84466a@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <bdf40dff-c958-b749-1149-f9417c84466a-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

Thanks for your feedback!

On Wed, Mar 8, 2017 at 9:21 PM, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
> On 08/03/17 11:01, Magnus Damm wrote:
>> From: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
>>
>> Add support for up to 8 contexts. Each context is mapped to one
>> domain. One domain is assigned one or more slave devices. Contexts
>> are allocated dynamically and slave devices are grouped together
>> based on which IPMMU device they are connected to. This makes slave
>> devices tied to the same IPMMU device share the same IOVA space.
>>
>> Signed-off-by: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
>> ---
>>
>>  Changes since V2:
>>  - Updated patch description to reflect code included in:
>>    [PATCH v7 00/07] iommu/ipmmu-vmsa: IPMMU multi-arch update V7
>>
>>  Changes since V1:
>>  - Support up to 8 contexts instead of 4
>>  - Use feature flag and runtime handling
>>  - Default to single context
>>
>>  drivers/iommu/ipmmu-vmsa.c |   38 ++++++++++++++++++++++++++++++--------
>>  1 file changed, 30 insertions(+), 8 deletions(-)
>>
>> --- 0012/drivers/iommu/ipmmu-vmsa.c
>> +++ work/drivers/iommu/ipmmu-vmsa.c   2017-03-08 17:59:19.900607110 +0900
>> @@ -30,11 +30,12 @@
>>
>>  #include "io-pgtable.h"
>>
>> -#define IPMMU_CTX_MAX 1
>> +#define IPMMU_CTX_MAX 8
>>
>>  struct ipmmu_features {
>>       bool use_ns_alias_offset;
>>       bool has_cache_leaf_nodes;
>> +     bool has_eight_ctx;
>
> Wouldn't it be more sensible to just encode a number of contexts
> directly, if it isn't reported by the hardware itself? I'm just
> imagining future hardware generations... :P
>
> bool also_has_another_eight_ctx_on_top_of_that;
> bool wait_no_this_is_the_one_where_ctx_15_isnt_usable;

=)

Sure, I agree with you!

Please note that this is currently a mix of software and hardware
policy. On R-Car Gen2 (ARM32) the legacy code only uses a single
context for now but 4 contexts are supported by hardware according to
the data sheet. The remaining 3 contexts are untested at this point.
For R-Car Gen3 (ARM64) the hardware supports 8 contexts and this patch
enables all of them.

>>  };
>>
>>  struct ipmmu_vmsa_device {
>> @@ -44,6 +45,7 @@ struct ipmmu_vmsa_device {
>>       const struct ipmmu_features *features;
>>       bool is_leaf;
>>       unsigned int num_utlbs;
>> +     unsigned int num_ctx;
>>       spinlock_t lock;                        /* Protects ctx and domains[] */
>>       DECLARE_BITMAP(ctx, IPMMU_CTX_MAX);
>>       struct ipmmu_vmsa_domain *domains[IPMMU_CTX_MAX];
>> @@ -376,11 +378,12 @@ static int ipmmu_domain_allocate_context
>>
>>       spin_lock_irqsave(&mmu->lock, flags);
>>
>> -     ret = find_first_zero_bit(mmu->ctx, IPMMU_CTX_MAX);
>> -     if (ret != IPMMU_CTX_MAX) {
>> +     ret = find_first_zero_bit(mmu->ctx, mmu->num_ctx);
>> +     if (ret != mmu->num_ctx) {
>>               mmu->domains[ret] = domain;
>>               set_bit(ret, mmu->ctx);
>
> Using test_and_set_bit() in a loop would avoid having to take a lock here.

So you mean that in case of test_and_set_bit() returns 1 then we try
find_first_zero_bit() again?

This is not really a performance sensitive part of the driver, so I'm
currently optimizing for code readability. I'm of course all for
dropping the lock, but I have a hard time figuring out how your
suggestion could result in semi-readable code. Any pointers? =)

>> @@ -1112,6 +1123,17 @@ static int ipmmu_probe(struct platform_d
>>       if (mmu->features->use_ns_alias_offset)
>>               mmu->base += IM_NS_ALIAS_OFFSET;
>>
>> +     /*
>> +      * The number of contexts varies with generation and instance.
>> +      * Newer SoCs get a total of 8 contexts enabled, older ones just one.
>> +      */
>> +     if (mmu->features->has_eight_ctx)
>> +             mmu->num_ctx = 8;
>> +     else
>> +             mmu->num_ctx = 1;
>> +
>> +     WARN_ON(mmu->num_ctx > IPMMU_CTX_MAX);
>
> The likelihood of that happening doesn't appear to warrant a runtime
> check. Especially one which probably isn't even generated because it's
> trivially resolvable to "if (false)..." at compile time.

Sure, I agree. Will drop.

Thanks,

/ magnus
