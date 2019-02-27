From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Subject: Re: [PATCH 0/5] iommu/arm-smmu-v3: make smmu can be enabled in kdump
 kernel
Date: Wed, 27 Feb 2019 11:25:43 +0800
Message-ID: <5C760337.2070504@huawei.com>
References: <20190219075443.17732-1-thunder.leizhen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190219075443.17732-1-thunder.leizhen@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, iommu <iommu@lists.linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

Hi Will, Robin:
   Do you have time to review these patches? Hope you can give me some opinions.


On 2019/2/19 15:54, Zhen Lei wrote:
> This patch series include two parts:
> 1. Patch1-2 use dummy STE tables with "ste abort" hardware feature to abort unexpected
>    devices accessing. For more details, see the description in patch 2.
> 2. If the "ste abort" feature is not support, force the unexpected devices in the
>    secondary kernel to use the memory maps which it used in the first kernel. For more
>    details, see patch 5.
> 
> 
> Zhen Lei (5):
>   iommu/arm-smmu-v3: make sure the stale caching of L1STD are invalid
>   iommu/arm-smmu-v3: make smmu can be enabled in kdump kernel
>   iommu/arm-smmu-v3: add macro xxx_SIZE to replace xxx_DWORDS shift
>   iommu/arm-smmu-v3: move arm_smmu_get_step_for_sid() a little ahead
>   iommu/arm-smmu-v3: workaround for STE abort in kdump kernel
> 
>  drivers/iommu/arm-smmu-v3.c | 243 +++++++++++++++++++++++++++++++++++---------
>  1 file changed, 194 insertions(+), 49 deletions(-)
> 

-- 
Thanks!
BestRegards
