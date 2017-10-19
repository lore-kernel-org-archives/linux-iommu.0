From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 1/3] iommu/arm-smmu-v3: put off the execution of TLBI*
	to reduce lock confliction
Date: Thu, 19 Oct 2017 10:12:26 +0100
Message-ID: <20171019091225.GA29762@arm.com>
References: <1505221238-9428-1-git-send-email-thunder.leizhen@huawei.com>
	<1505221238-9428-2-git-send-email-thunder.leizhen@huawei.com>
	<20171018125849.GD4077@arm.com> <59E8155D.2070102@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <59E8155D.2070102-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Leizhen (ThunderTown)" <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Cc: Kefeng Wang <wangkefeng.wang-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jinyue Li <lijinyue-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Libin <huawei.libin-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Hanjun Guo <guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Oct 19, 2017 at 11:00:45AM +0800, Leizhen (ThunderTown) wrote:
> 
> 
> On 2017/10/18 20:58, Will Deacon wrote:
> > Hi Thunder,
> > 
> > On Tue, Sep 12, 2017 at 09:00:36PM +0800, Zhen Lei wrote:
> >> Because all TLBI commands should be followed by a SYNC command, to make
> >> sure that it has been completely finished. So we can just add the TLBI
> >> commands into the queue, and put off the execution until meet SYNC or
> >> other commands. To prevent the followed SYNC command waiting for a long
> >> time because of too many commands have been delayed, restrict the max
> >> delayed number.
> >>
> >> According to my test, I got the same performance data as I replaced writel
> >> with writel_relaxed in queue_inc_prod.
> >>
> >> Signed-off-by: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> >> ---
> >>  drivers/iommu/arm-smmu-v3.c | 42 +++++++++++++++++++++++++++++++++++++-----
> >>  1 file changed, 37 insertions(+), 5 deletions(-)
> > 
> > If we want to go down the route of explicit command batching, I'd much
> > rather do it by implementing the iotlb_range_add callback in the driver,
> > and have a fixed-length array of batched ranges on the domain. We could
> I think even if iotlb_range_add callback is implemented, this patch is still valuable. The main purpose
> of this patch is to reduce dsb operation. So in the scenario with iotlb_range_add implemented:
> .iotlb_range_add:
> spin_lock_irqsave(&smmu->cmdq.lock, flags);
> ...
> add tlbi range-1 to cmq-queue
> ...
> add tlbi range-n to cmq-queue			//n
> dsb
> ...
> spin_unlock_irqrestore(&smmu->cmdq.lock, flags);
> 
> .iotlb_sync
> spin_lock_irqsave(&smmu->cmdq.lock, flags);
> ...
> add cmd_sync to cmq-queue
> dsb
> ...
> spin_unlock_irqrestore(&smmu->cmdq.lock, flags);
> 
> Although iotlb_range_add can reduce n-1 dsb operations, but there are
> still 1 left. If n is not large enough, this patch is helpful.

Then pick an n that is large enough, based on the compatible string.

Will
