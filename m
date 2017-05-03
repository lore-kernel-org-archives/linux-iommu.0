From: Sunil Kovvuri <sunil.kovvuri@gmail.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Poll for CMDQ drain completion more effectively
Date: Wed, 3 May 2017 21:24:13 +0530
Message-ID: <CA+sq2CeU7RN_UEiN1fuRtFpkHwgORHv_qU8yvziHqteLdz+_rw@mail.gmail.com>
References: <1493291587-23488-1-git-send-email-sunil.kovvuri@gmail.com>
 <CA+sq2CdR0vC76F1m-LvYGfZW32nKbQg9dQsfJ_jtvYgZ7yyt3g@mail.gmail.com> <20170503153738.GP8233@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170503153738.GP8233@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, LAKML <linux-arm-kernel@lists.infradead.org>, Robert Richter <robert.richter@cavium.com>, jcm@redhat.com, Sunil Goutham <sgoutham@cavium.com>, Geetha <gakula@cavium.com>
List-Id: iommu@lists.linux-foundation.org

On Wed, May 3, 2017 at 9:07 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Wed, May 03, 2017 at 06:49:09PM +0530, Sunil Kovvuri wrote:
>> On Thu, Apr 27, 2017 at 4:43 PM,  <sunil.kovvuri@gmail.com> wrote:
>> > From: Sunil Goutham <sgoutham@cavium.com>
>> >
>> > Modified polling on CMDQ consumer similar to how polling is done for TLB SYNC
>> > completion in SMMUv2 driver. Code changes are done with reference to
>> >
>> > 8513c8930069 iommu/arm-smmu: Poll for TLB sync completion more effectively
>> >
>> > Poll timeout has been increased which addresses issue of 100us timeout not
>> > sufficient, when command queue is full with TLB invalidation commands.
>> >
>> > Signed-off-by: Sunil Goutham <sgoutham@cavium.com>
>> > Signed-off-by: Geetha <gakula@cavium.com>
>> > ---
>> >  drivers/iommu/arm-smmu-v3.c | 15 ++++++++++++---
>> >  1 file changed, 12 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>> > index d412bdd..34599d4 100644
>> > --- a/drivers/iommu/arm-smmu-v3.c
>> > +++ b/drivers/iommu/arm-smmu-v3.c
>> > @@ -379,6 +379,9 @@
>> >  #define CMDQ_SYNC_0_CS_NONE            (0UL << CMDQ_SYNC_0_CS_SHIFT)
>> >  #define CMDQ_SYNC_0_CS_SEV             (2UL << CMDQ_SYNC_0_CS_SHIFT)
>> >
>> > +#define CMDQ_DRAIN_TIMEOUT_US          1000
>> > +#define CMDQ_SPIN_COUNT                        10
>> > +
>> >  /* Event queue */
>> >  #define EVTQ_ENT_DWORDS                        4
>> >  #define EVTQ_MAX_SZ_SHIFT              7
>> > @@ -737,7 +740,8 @@ static void queue_inc_prod(struct arm_smmu_queue *q)
>> >   */
>> >  static int queue_poll_cons(struct arm_smmu_queue *q, bool drain, bool wfe)
>> >  {
>> > -       ktime_t timeout = ktime_add_us(ktime_get(), ARM_SMMU_POLL_TIMEOUT_US);
>> > +       ktime_t timeout = ktime_add_us(ktime_get(), CMDQ_DRAIN_TIMEOUT_US);
>> > +       unsigned int spin_cnt, delay = 1;
>> >
>> >         while (queue_sync_cons(q), (drain ? !queue_empty(q) : queue_full(q))) {
>> >                 if (ktime_compare(ktime_get(), timeout) > 0)
>> > @@ -746,8 +750,13 @@ static int queue_poll_cons(struct arm_smmu_queue *q, bool drain, bool wfe)
>> >                 if (wfe) {
>> >                         wfe();
>> >                 } else {
>> > -                       cpu_relax();
>> > -                       udelay(1);
>> > +                       for (spin_cnt = 0;
>> > +                            spin_cnt < CMDQ_SPIN_COUNT; spin_cnt++) {
>> > +                               cpu_relax();
>> > +                               continue;
>> > +                       }
>> > +                       udelay(delay);
>> > +                       delay *= 2;
>> >                 }
>> >         }
>> >
>> > --
>> > 2.7.4
>> >
>>
>> Sorry for the ignorance.
>> Is there a patchwork where I can check current status of ARM IOMMU
>> related patches ?
>>
>> And is this patch accepted, if not any comments / feedback ?
>
> Please be patient: the merge window is open and it's not been long since you
> posted the patch, which looks pretty bonkers at first glance.
>
> Will

Look at this
https://lkml.org/lkml/2017/4/3/605
The same thing, i pinged after a week and you said you already picked it up.
All I am asking is how do i know the current status, how many days
would normally
be considered being patient ?
Instead of troubling you, is there a patchwork where i can check the status ?

Thanks,
Sunil.
