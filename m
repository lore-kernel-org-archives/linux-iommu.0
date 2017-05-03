From: Sunil Kovvuri <sunil.kovvuri-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Poll for CMDQ drain completion more
	effectively
Date: Wed, 3 May 2017 21:53:49 +0530
Message-ID: <CA+sq2CfVdZ-KrUxH8BsjydkqPd8gRiNn6Vp2_aOaL8O6nALS1w@mail.gmail.com>
References: <1493291587-23488-1-git-send-email-sunil.kovvuri@gmail.com>
	<a9d1bb4d-6578-93bb-66cf-5ed55952b85a@arm.com>
	<20170503154046.GQ8233@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170503154046.GQ8233-5wv7dgnIgG8@public.gmane.org>
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
Cc: jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Robert Richter <robert.richter-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Geetha <gakula-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, Sunil Goutham <sgoutham-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, LAKML <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, May 3, 2017 at 9:10 PM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> On Wed, May 03, 2017 at 04:33:57PM +0100, Robin Murphy wrote:
>> On 27/04/17 12:13, sunil.kovvuri-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
>> > From: Sunil Goutham <sgoutham-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
>> >
>> > Modified polling on CMDQ consumer similar to how polling is done for TLB SYNC
>> > completion in SMMUv2 driver. Code changes are done with reference to
>> >
>> > 8513c8930069 iommu/arm-smmu: Poll for TLB sync completion more effectively
>> >
>> > Poll timeout has been increased which addresses issue of 100us timeout not
>> > sufficient, when command queue is full with TLB invalidation commands.
>> >
>> > Signed-off-by: Sunil Goutham <sgoutham-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
>> > Signed-off-by: Geetha <gakula-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
>> > ---
>> >  drivers/iommu/arm-smmu-v3.c | 15 ++++++++++++---
>> >  1 file changed, 12 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>> > index d412bdd..34599d4 100644
>> > --- a/drivers/iommu/arm-smmu-v3.c
>> > +++ b/drivers/iommu/arm-smmu-v3.c
>> > @@ -379,6 +379,9 @@
>> >  #define CMDQ_SYNC_0_CS_NONE                (0UL << CMDQ_SYNC_0_CS_SHIFT)
>> >  #define CMDQ_SYNC_0_CS_SEV         (2UL << CMDQ_SYNC_0_CS_SHIFT)
>> >
>> > +#define CMDQ_DRAIN_TIMEOUT_US              1000
>> > +#define CMDQ_SPIN_COUNT                    10
>> > +
>> >  /* Event queue */
>> >  #define EVTQ_ENT_DWORDS                    4
>> >  #define EVTQ_MAX_SZ_SHIFT          7
>> > @@ -737,7 +740,8 @@ static void queue_inc_prod(struct arm_smmu_queue *q)
>> >   */
>> >  static int queue_poll_cons(struct arm_smmu_queue *q, bool drain, bool wfe)
>> >  {
>> > -   ktime_t timeout = ktime_add_us(ktime_get(), ARM_SMMU_POLL_TIMEOUT_US);
>> > +   ktime_t timeout = ktime_add_us(ktime_get(), CMDQ_DRAIN_TIMEOUT_US);
>> > +   unsigned int spin_cnt, delay = 1;
>> >
>> >     while (queue_sync_cons(q), (drain ? !queue_empty(q) : queue_full(q))) {
>> >             if (ktime_compare(ktime_get(), timeout) > 0)
>> > @@ -746,8 +750,13 @@ static int queue_poll_cons(struct arm_smmu_queue *q, bool drain, bool wfe)
>> >             if (wfe) {
>> >                     wfe();
>> >             } else {
>> > -                   cpu_relax();
>> > -                   udelay(1);
>> > +                   for (spin_cnt = 0;
>> > +                        spin_cnt < CMDQ_SPIN_COUNT; spin_cnt++) {
>> > +                           cpu_relax();
>> > +                           continue;
>> > +                   }
>> > +                   udelay(delay);
>> > +                   delay *= 2;
>>
>> Sorry, I can't make sense of this. The referenced commit uses the spin
>> loop to poll opportunistically a few times before delaying. This loop
>> just adds a short open-coded udelay to an exponential udelay, and it's
>> not really clear that that's any better than a fixed udelay (especially
>> as the two cases in which we poll are somewhat different).
>>
>> What's wrong with simply increasing the timeout value alone?
>
> I asked that the timeout is only increased for the drain case, and that
> we fix the issue here where we udelat if cons didn't move immediately:
>
> http://lists.infradead.org/pipermail/linux-arm-kernel/2017-April/503389.html
>
> but I don't think the patch above actually achieves any of that.
>
> Will

Sorry, I completely screwed up the spin poll above.
Will resubmit.

Thanks,
Sunil.
