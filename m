From: "Leizhen (ThunderTown)" <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 0/5] arm-smmu: performance optimization
Date: Fri, 18 Aug 2017 11:19:00 +0800
Message-ID: <59965CA4.10907@huawei.com>
References: <1498484330-10840-1-git-send-email-thunder.leizhen@huawei.com>
	<20170817143650.GB30338@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170817143650.GB30338-5wv7dgnIgG8@public.gmane.org>
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
Cc: Hanjun Guo <guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Xinwei Hu <huxinwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Zefan Li <lizefan-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Tianhong Ding <dingtianhong-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



On 2017/8/17 22:36, Will Deacon wrote:
> Thunder, Nate, Robin,
> 
> On Mon, Jun 26, 2017 at 09:38:45PM +0800, Zhen Lei wrote:
>> I described the optimization more detail in patch 1 and 2, and patch 3-5 are
>> the implementation on arm-smmu/arm-smmu-v3 of patch 2.
>>
>> Patch 1 is v2. In v1, I directly replaced writel with writel_relaxed in
>> queue_inc_prod. But Robin figured that it may lead SMMU consume stale
>> memory contents. I thought more than 3 whole days and got this one.
>>
>> This patchset is based on Robin Murphy's [PATCH v2 0/8] io-pgtable lock removal.
> 
> For the time being, I think we should focus on the new TLB flushing
> interface posted by Joerg:
> 
> http://lkml.kernel.org/r/1502974596-23835-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
> 
> which looks like it can give us most of the benefits of this series. Once
> we've got that, we can see what's left in the way of performance and focus
> on the cmdq batching separately (because I'm still not convinced about it).
OK, this is a good news.

But I have a review comment(sorry, I have not subscribed it yet, so can not directly reply it):
I don't think we should add tlb sync for map operation
1. at init time, all tlbs will be invalidated
2. when we try to map a new range, there are no related ptes bufferd in tlb, because of above 1 and below 3
3. when we unmap the above range, make sure all related ptes bufferd in tlb to be invalidated before unmap finished

> 
> Thanks,
> 
> Will
> 
> .
> 

-- 
Thanks!
BestRegards
