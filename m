From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 0/5] arm-smmu: performance optimization
Date: Fri, 18 Aug 2017 09:39:22 +0100
Message-ID: <20170818083922.GA2333@arm.com>
References: <1498484330-10840-1-git-send-email-thunder.leizhen@huawei.com>
 <20170817143650.GB30338@arm.com>
 <59965CA4.10907@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <59965CA4.10907@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc: Joerg Roedel <joro@8bytes.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, iommu <iommu@lists.linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>, linux-kernel <linux-kernel@vger.kernel.org>, Zefan Li <lizefan@huawei.com>, Xinwei Hu <huxinwei@huawei.com>, Tianhong Ding <dingtianhong@huawei.com>, Hanjun Guo <guohanjun@huawei.com>, John Garry <john.garry@huawei.com>, nwatters@codeaurora.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Aug 18, 2017 at 11:19:00AM +0800, Leizhen (ThunderTown) wrote:
> 
> 
> On 2017/8/17 22:36, Will Deacon wrote:
> > Thunder, Nate, Robin,
> > 
> > On Mon, Jun 26, 2017 at 09:38:45PM +0800, Zhen Lei wrote:
> >> I described the optimization more detail in patch 1 and 2, and patch 3-5 are
> >> the implementation on arm-smmu/arm-smmu-v3 of patch 2.
> >>
> >> Patch 1 is v2. In v1, I directly replaced writel with writel_relaxed in
> >> queue_inc_prod. But Robin figured that it may lead SMMU consume stale
> >> memory contents. I thought more than 3 whole days and got this one.
> >>
> >> This patchset is based on Robin Murphy's [PATCH v2 0/8] io-pgtable lock removal.
> > 
> > For the time being, I think we should focus on the new TLB flushing
> > interface posted by Joerg:
> > 
> > http://lkml.kernel.org/r/1502974596-23835-1-git-send-email-joro@8bytes.org
> > 
> > which looks like it can give us most of the benefits of this series. Once
> > we've got that, we can see what's left in the way of performance and focus
> > on the cmdq batching separately (because I'm still not convinced about it).
> OK, this is a good news.
> 
> But I have a review comment(sorry, I have not subscribed it yet, so can not directly reply it):
> I don't think we should add tlb sync for map operation
> 1. at init time, all tlbs will be invalidated
> 2. when we try to map a new range, there are no related ptes bufferd in tlb, because of above 1 and below 3
> 3. when we unmap the above range, make sure all related ptes bufferd in tlb to be invalidated before unmap finished

Yup, you're completely correct and I raised that with Joerg, who is looking
into a way to avoid it.

Will
