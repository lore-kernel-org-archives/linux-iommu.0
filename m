From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 1/5] iommu/arm-smmu-v3: put off the execution of TLBI*
 to reduce lock confliction
Date: Mon, 17 Jul 2017 22:23:37 +0800
Message-ID: <20170717222337.0000508f@huawei.com>
References: <1498484330-10840-1-git-send-email-thunder.leizhen@huawei.com>
        <1498484330-10840-2-git-send-email-thunder.leizhen@huawei.com>
        <20170628093207.GB11053@arm.com>
        <5954610F.9020807@huawei.com>
        <cd5b8ec5-f884-450c-df61-45d70bf40b10@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cd5b8ec5-f884-450c-df61-45d70bf40b10@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: John Garry <john.garry@huawei.com>
Cc: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>, Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, iommu <iommu@lists.linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>, linux-kernel <linux-kernel@vger.kernel.org>, Zefan Li <lizefan@huawei.com>, Xinwei Hu <huxinwei@huawei.com>, Tianhong Ding <dingtianhong@huawei.com>, Hanjun Guo <guohanjun@huawei.com>, nwatters@codeaurora.org, zhouyoujun@huawei.com
List-Id: iommu@lists.linux-foundation.org

On Mon, 17 Jul 2017 14:06:42 +0100
John Garry <john.garry@huawei.com> wrote:

> +
> 
> On 29/06/2017 03:08, Leizhen (ThunderTown) wrote:
> >
> >
> > On 2017/6/28 17:32, Will Deacon wrote:  
> >> Hi Zhen Lei,
> >>
> >> Nate (CC'd), Robin and I have been working on something very similar to
> >> this series, but this patch is different to what we had planned. More below.
> >>
> >> On Mon, Jun 26, 2017 at 09:38:46PM +0800, Zhen Lei wrote:  
> >>> Because all TLBI commands should be followed by a SYNC command, to make
> >>> sure that it has been completely finished. So we can just add the TLBI
> >>> commands into the queue, and put off the execution until meet SYNC or
> >>> other commands. To prevent the followed SYNC command waiting for a long
> >>> time because of too many commands have been delayed, restrict the max
> >>> delayed number.
> >>>
> >>> According to my test, I got the same performance data as I replaced writel
> >>> with writel_relaxed in queue_inc_prod.
> >>>
> >>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> >>> ---
> >>>  drivers/iommu/arm-smmu-v3.c | 42 +++++++++++++++++++++++++++++++++++++-----
> >>>  1 file changed, 37 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> >>> index 291da5f..4481123 100644
> >>> --- a/drivers/iommu/arm-smmu-v3.c
> >>> +++ b/drivers/iommu/arm-smmu-v3.c
> >>> @@ -337,6 +337,7 @@
> >>>  /* Command queue */
> >>>  #define CMDQ_ENT_DWORDS			2
> >>>  #define CMDQ_MAX_SZ_SHIFT		8
> >>> +#define CMDQ_MAX_DELAYED		32
> >>>
> >>>  #define CMDQ_ERR_SHIFT			24
> >>>  #define CMDQ_ERR_MASK			0x7f
> >>> @@ -472,6 +473,7 @@ struct arm_smmu_cmdq_ent {
> >>>  			};
> >>>  		} cfgi;
> >>>
> >>> +		#define CMDQ_OP_TLBI_NH_ALL	0x10
> >>>  		#define CMDQ_OP_TLBI_NH_ASID	0x11
> >>>  		#define CMDQ_OP_TLBI_NH_VA	0x12
> >>>  		#define CMDQ_OP_TLBI_EL2_ALL	0x20
> >>> @@ -499,6 +501,7 @@ struct arm_smmu_cmdq_ent {
> >>>
> >>>  struct arm_smmu_queue {
> >>>  	int				irq; /* Wired interrupt */
> >>> +	u32				nr_delay;
> >>>
> >>>  	__le64				*base;
> >>>  	dma_addr_t			base_dma;
> >>> @@ -722,11 +725,16 @@ static int queue_sync_prod(struct arm_smmu_queue *q)
> >>>  	return ret;
> >>>  }
> >>>
> >>> -static void queue_inc_prod(struct arm_smmu_queue *q)
> >>> +static void queue_inc_swprod(struct arm_smmu_queue *q)
> >>>  {
> >>> -	u32 prod = (Q_WRP(q, q->prod) | Q_IDX(q, q->prod)) + 1;
> >>> +	u32 prod = q->prod + 1;
> >>>
> >>>  	q->prod = Q_OVF(q, q->prod) | Q_WRP(q, prod) | Q_IDX(q, prod);
> >>> +}
> >>> +
> >>> +static void queue_inc_prod(struct arm_smmu_queue *q)
> >>> +{
> >>> +	queue_inc_swprod(q);
> >>>  	writel(q->prod, q->prod_reg);
> >>>  }
> >>>
> >>> @@ -761,13 +769,24 @@ static void queue_write(__le64 *dst, u64 *src, size_t n_dwords)
> >>>  		*dst++ = cpu_to_le64(*src++);
> >>>  }
> >>>
> >>> -static int queue_insert_raw(struct arm_smmu_queue *q, u64 *ent)
> >>> +static int queue_insert_raw(struct arm_smmu_queue *q, u64 *ent, int optimize)
> >>>  {
> >>>  	if (queue_full(q))
> >>>  		return -ENOSPC;
> >>>
> >>>  	queue_write(Q_ENT(q, q->prod), ent, q->ent_dwords);
> >>> -	queue_inc_prod(q);
> >>> +
> >>> +	/*
> >>> +	 * We don't want too many commands to be delayed, this may lead the
> >>> +	 * followed sync command to wait for a long time.
> >>> +	 */
> >>> +	if (optimize && (++q->nr_delay < CMDQ_MAX_DELAYED)) {
> >>> +		queue_inc_swprod(q);
> >>> +	} else {
> >>> +		queue_inc_prod(q);
> >>> +		q->nr_delay = 0;
> >>> +	}
> >>> +  
> >>
> >> So here, you're effectively putting invalidation commands into the command
> >> queue without updating PROD. Do you actually see a performance advantage
> >> from doing so? Another side of the argument would be that we should be  
> > Yes, my sas ssd performance test showed that it can improve about 100-150K/s(the same to I directly replace
> > writel with writel_relaxed). And the average execution time of iommu_unmap(which called by iommu_dma_unmap_sg)
> > dropped from 10us to 5us.
> >  
> >> moving PROD as soon as we can, so that the SMMU can process invalidation
> >> commands in the background and reduce the cost of the final SYNC operation
> >> when the high-level unmap operation is complete.  
> > There maybe that __iowmb() is more expensive than wait for tlbi complete. Except the time of __iowmb()
> > itself, it also protected by spinlock, lock confliction will rise rapidly in the stress scene. __iowmb()
> > average cost 300-500ns(Sorry, I forget the exact value).
> >
> > In addition, after applied this patcheset and Robin's v2, and my earlier dma64 iova optimization patchset.
> > Our net performance test got the same data to global bypass. But sas ssd still have more than 20% dropped.
> > Maybe we should still focus at map/unamp, because the average execution time of iova alloc/free is only
> > about 400ns.
> >
> > By the way, patch2-5 is more effective than this one, it can improve more than 350K/s. And with it, we can
> > got about 100-150K/s improvement of Robin's v2. Otherwise, I saw non effective of Robin's v2. Sorry, I have
> > not tested how about this patch without patch2-5. Further more, I got the same performance data to global
> > bypass for the traditional mechanical hard disk with only patch2-5(without this patch and Robin's).
> >  
Hi All,

I'm a bit of late entry to this discussion.  Just been running some more
detailed tests on our d05 boards and wanted to bring some more numbers to
the discussion.

All tests against 4.12 with the following additions:
* Robin's series removing the io-pgtable spinlock (and a few recent fixes)
* Cherry picked updates to the sas driver, merged prior to 4.13-rc1
* An additional HNS (network card) bug fix that will be upstreamed shortly.

I've broken the results down into this patch and this patch + the remainder
of the set. As leizhen mentioned we got a nice little performance
bump from Robin's series so that was applied first (as it's in mainline now)

SAS tests were fio with noop scheduler, 4k block size and various io depths
1 process per disk.  Note this is probably a different setup to leizhen's
original numbers.

Precentages are off the performance seen with the smmu disabled.
SAS
4.12 - none of this series.
SMMU disabled
read io-depth 32 -   384K IOPS (100%)
read io-depth 2048 - 950K IOPS (100%)
rw io-depth 32 -     166K IOPS (100%)
rw io-depth 2048 -   340K IOPS (100%)

SMMU enabled
read io-depth 32 -   201K IOPS (52%)
read io-depth 2048 - 306K IOPS (32%)
rw io-depth 32 -     99K  IOPS (60%)
rw io-depth 2048 -   150K IOPS (44%)

Robin's recent series with fixes as seen on list (now merged)
SMMU enabled.
read io-depth 32 -   208K IOPS (54%)
read io-depth 2048 - 335K IOPS (35%)
rw io-depth 32 -     105K IOPS (63%)
rw io-depth 2048 -   165K IOPS (49%)

4.12 + Robin's series + just this patch SMMU enabled

(iommu/arm-smmu-v3: put of the execution of TLBI* to reduce lock conflict)

read io-depth 32 -   225K IOPS (59%)
read io-depth 2048 - 365K IOPS (38%) 
rw io-depth 32 -     110K IOPS (66%)
rw io-depth 2048 -   179K IOPS (53%)

4.12 + Robin's series + Second part of this series

(iommu/arm-smmu-v3: put of the execution of TLBI* to reduce lock conflict)
(iommu: add a new member unmap_tlb_sync into struct iommu_ops)
(iommu/arm-smmu-v3: add supprot for unmap an iova range with only on tlb sync)
(iommu/arm-smmu: add support for unmap of a memory range with only one tlb sync)

read io-depth 32 -    225K IOPS (59%)
read io-depth 2048 -  833K IOPS (88%)
rw io-depth 32 -      112K IOPS (67%)
rw io-depth 2048 -    220K IOPS (65%)

Robin's series gave us small gains across the board (3-5% recovered)
relative to the no smmu performance (which we are taking as the ideal case)

This first patch gets us back another 2-5% of the no smmu performance

The next few patches get us very little advantage on the small io-depths
but make a large difference to the larger io-depths - in particular the
read IOPS which is over twice as fast as without the series.

For HNS it seems that we are less dependent on the SMMU performance and
can reach the non SMMU speed.

Tests with
iperf -t 30 -i 10 -c IPADDRESS -P 3 last 10 seconds taken to avoid any
initial variability.

The server end of the link was always running with smmu v3 disabled
so as to act as a fast sink of the data. Some variation seen across
repeat runs.

Mainline v4.12 + network card fix
NO SMMU
9.42 GBits/sec

SMMU
4.36 GBits/sec (46%)

Robin's io-pgtable spinlock series

6.68 to 7.34 (71% - 78% variation across runs)

Just this patch SMMU enabled

(iommu/arm-smmu-v3: put of the execution of TLBI* to reduce lock conflict)

7.96-8.8 GBits/sec (85% - 94%  some variation across runs)

Full series

(iommu/arm-smmu-v3: put of the execution of TLBI* to reduce lock conflict)
(iommu: add a new member unmap_tlb_sync into struct iommu_ops)
(iommu/arm-smmu-v3: add supprot for unmap an iova range with only on tlb sync)
(iommu/arm-smmu: add support for unmap of a memory range with only one tlb sync)

9.42 GBits/Sec (100%)

So HNS test shows a greater boost from Robin's series and this first patch.
This is most likely because the HNS test is not putting as high a load on
the SMMU and associated code as the SAS test.

In both cases however, this shows that both parts of this patch
series are beneficial.

So on to the questions ;)

Will, you mentioned that along with Robin and Nate you were working on
a somewhat related strategy to improve the performance.  Any ETA on that?

As you might imagine, with the above numbers we are very keen to try and
move forward with this as quickly as possible.

If you want additional testing we would be happy to help.

Thanks,

Jonathan



> >>
> >> Will
> >>
> >> .
> >>  
> >  
> 
> 
