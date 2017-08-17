From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH] iommu: Avoid NULL group dereference
Date: Thu, 17 Aug 2017 11:51:48 +0100
Message-ID: <a2476bec-460f-01ad-6e21-cce6cec76d36@arm.com>
References: <59a6c4f0a790eea40e2b2f2be840b63317dd44e4.1502966326.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <59a6c4f0a790eea40e2b2f2be840b63317dd44e4.1502966326.git.robin.murphy@arm.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org
Cc: iommu@lists.linux-foundation.org, shawn.lin@rock-chips.com, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 17/08/17 11:40, Robin Murphy wrote:
> The recently-removed FIXME in iommu_get_domain_for_dev() turns out to
> have been a little misleading, since that check is still worthwhile even
> when groups *are* universal. We have a few IOMMU-aware drivers which
> only care whether their device is already attached to an existing domain
> or not, for which the previous behaviour of iommu_get_domain_for_dev()
> was ideal, and who now crash if their device does not have an IOMMU.
> 
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

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
