From: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v1 1/3] iommu/tegra-smmu: Fix invalid ASID bits on
 Tegra30/114
Date: Wed, 3 Apr 2019 13:27:03 +0300
Message-ID: <9e7af5f4-9da9-14f4-99a1-53188bebe34f@gmail.com>
References: <20190306225009.3391-1-digetx@gmail.com>
 <20190306225009.3391-2-digetx@gmail.com> <20190403084142.GA5238@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190403084142.GA5238@ulmo>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Joerg Roedel <joro@8bytes.org>, Jonathan Hunter <jonathanh@nvidia.com>, iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

03.04.2019 11:41, Thierry Reding пишет:
> On Thu, Mar 07, 2019 at 01:50:07AM +0300, Dmitry Osipenko wrote:
>> Both Tegra30 and Tegra114 have 4 ASID's and the corresponding bitfield of
>> the TLB_FLUSH register differs from later Tegra generations that have 128
>> ASID's.
>>
>> In a result the PTE's are now flushed correctly from TLB and this fixes
>> problems with graphics (randomly failing tests) on Tegra30.
>>
>> Cc: stable <stable@vger.kernel.org>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/iommu/tegra-smmu.c | 25 ++++++++++++++++++-------
>>  1 file changed, 18 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
>> index 5182c7d6171e..8d30653cd13a 100644
>> --- a/drivers/iommu/tegra-smmu.c
>> +++ b/drivers/iommu/tegra-smmu.c
>> @@ -102,7 +102,6 @@ static inline u32 smmu_readl(struct tegra_smmu *smmu, unsigned long offset)
>>  #define  SMMU_TLB_FLUSH_VA_MATCH_ALL     (0 << 0)
>>  #define  SMMU_TLB_FLUSH_VA_MATCH_SECTION (2 << 0)
>>  #define  SMMU_TLB_FLUSH_VA_MATCH_GROUP   (3 << 0)
>> -#define  SMMU_TLB_FLUSH_ASID(x)          (((x) & 0x7f) << 24)
> 
> Given that the same operation is repeated three times below, it might
> have been worth to fold the conditional into the macro. That'd require
> the macro to take an smmu parameter, but would otherwise leave the
> individual instances shorter.

I had that variant initially and the result felt more clumsy to me.

> But either way, the fix is good, so:
> 
> Acked-by: Thierry Reding <treding@nvidia.com>
> 

Thanks
