From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v7 0/6] Add non-strict mode support for iommu-dma
Date: Tue, 18 Sep 2018 18:10:00 +0100
Message-ID: <20180918171000.GI16498@arm.com>
References: <cover.1536935328.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1536935328.git.robin.murphy@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, thunder.leizhen@huawei.com, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com, guohanjun@huawei.com, huawei.libin@huawei.com, john.garry@huawei.com
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

Thanks for turning this around so quickly.

On Fri, Sep 14, 2018 at 03:30:18PM +0100, Robin Murphy wrote:
> Since we'd like to get this polished up and merged and Leizhen has other
> commitments, here's v7 of the previous series[1] wherein I address all
> my own feedback :) This is a quick tweak of the v6 I sent yesterday
> since I figured out slightly too late a much neater way of setting the
> attribute at the appropriate time.
> 
> The principal change is that I've inverted things slightly such that
> it's now a generic domain attribute controlled by iommu-dma given the
> necessary support from individual IOMMU drivers. That way we can easily
> enable other drivers straight away, as I've done for SMMUv2 here (which
> also allowed me to give it a quick test with MMU-401s on a Juno board).
> Otherwise it's really just cosmetic cleanup and rebasing onto Will's
> pending SMMU queue.

I've been through and had a look, leaving some small comments on the patches
themselves. The only part I failed to figure out is how you tie the lifetime
of the flush queue to the lifetime of the domain so that the timer callback
can't fire after e.g. the DMA cookie has been freed. How does that work?

Cheers,

Will
