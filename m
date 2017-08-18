From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH] iommu: Avoid NULL group dereference
Date: Fri, 18 Aug 2017 08:49:54 +0800
Message-ID: <25ce000c-77d1-c01e-795d-0b52d2892318@rock-chips.com>
References: <59a6c4f0a790eea40e2b2f2be840b63317dd44e4.1502966326.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <59a6c4f0a790eea40e2b2f2be840b63317dd44e4.1502966326.git.robin.murphy@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org
Cc: shawn.lin@rock-chips.com, iommu@lists.linux-foundation.org, marc.zyngier@arm.com, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi

On 2017/8/17 18:40, Robin Murphy wrote:
> The recently-removed FIXME in iommu_get_domain_for_dev() turns out to
> have been a little misleading, since that check is still worthwhile even
> when groups *are* universal. We have a few IOMMU-aware drivers which
> only care whether their device is already attached to an existing domain
> or not, for which the previous behaviour of iommu_get_domain_for_dev()
> was ideal, and who now crash if their device does not have an IOMMU.
> 

It works, thanks!

Tested-by: Shawn Lin <shawn.lin@rock-chips.com>


> With IOMMU groups now serving as a reliable indicator of whether a
> device has an IOMMU or not (barring false-positives from VFIO no-IOMMU
> mode), drivers could arguably do this:
> 
> 	group = iommu_group_get(dev);
> 	if (group) {
> 		domain = iommu_get_domain_for_dev(dev);
> 		iommu_group_put(group);
> 	}
> 
> However, rather than duplicate that code across multiple callsites,
> particularly when it's still only the domain they care about, let's skip
> straight to the next step and factor out the check into the common place
> it applies - in iommu_get_domain_for_dev() itself. Sure, it ends up
> looking rather familiar, but now it's backed by the reasoning of having
> a robust API able to do the expected thing for all devices regardless.
> 
> Fixes: 05f80300dc8b ("iommu: Finish making iommu_group support mandatory")
> Reported-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> As well as dma-iommu, there are at least the Cavium ThunderX and
> Freescale DPAA2 ethernet drivers expecting this to work too.
> 
>   drivers/iommu/iommu.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index af69bf7e035a..5499a0387349 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1352,6 +1352,8 @@ struct iommu_domain *iommu_get_domain_for_dev(struct device *dev)
>   	struct iommu_group *group;
>   
>   	group = iommu_group_get(dev);
> +	if (!group)
> +		return NULL;
>   
>   	domain = group->domain;
>   
> 
