From: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v1 4/4] iommu/tegra: gart: Optimize map/unmap
Date: Fri, 27 Apr 2018 15:01:57 +0300
Message-ID: <1980b5a2-3921-04f5-0519-ba926ac66e3d@gmail.com>
References: <cover.1523304324.git.digetx@gmail.com>
 <f21a7b6a8f141b87f75687904a76f3728ea639a8.1523304324.git.digetx@gmail.com>
 <20180427100202.GO30388@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180427100202.GO30388@ulmo>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Joerg Roedel <joro@8bytes.org>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 27.04.2018 13:02, Thierry Reding wrote:
> On Mon, Apr 09, 2018 at 11:07:22PM +0300, Dmitry Osipenko wrote:
>> Currently GART writes one page entry at a time. More optimal would be to
>> aggregate the writes and flush BUS buffer in the end, this gives map/unmap
>> 10-40% (depending on size of mapping) performance boost compared to a
>> flushing after each entry update.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/iommu/tegra-gart.c | 63 +++++++++++++++++++++++++++++++++++-----------
>>  1 file changed, 48 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
>> index 4a0607669d34..9f59f5f17661 100644
>> --- a/drivers/iommu/tegra-gart.c
>> +++ b/drivers/iommu/tegra-gart.c
>> @@ -36,7 +36,7 @@
>>  #define GART_APERTURE_SIZE	SZ_32M
>>  
>>  /* bitmap of the page sizes currently supported */
>> -#define GART_IOMMU_PGSIZES	(SZ_4K)
>> +#define GART_IOMMU_PGSIZES	GENMASK(24, 12)
> 
> That doesn't look right. The GART really only supports 4 KiB pages. You
> seem to be "emulating" more page sizes here in order to improve mapping
> performance. That seems wrong to me. I'm wondering if this couldn't be
> improved by a similar factor by simply moving the flushing into an
> implementation of ->iotlb_sync().
> 
> That said, it seems like ->iotlb_sync() is only used for unmapping, but
> I don't see a reason why iommu_map() wouldn't need to call it as well
> after going through several calls to ->map(). It seems to me like a
> driver that implements ->iotlb_sync() would want to use it to optimize
> for both the mapping and unmapping cases.

I vaguely remember looking at the IOMMU syncing, but decided to try at first the
way this patch is. I'll be happy to switch to map/unmap syncing, let's see what
Joerg would suggest.

> Joerg, I've gone over the git log and header files and I see no mention
> of why the TLB flush interface isn't used for mapping. Do you recall any
> special reasons why the same shouldn't be applied for mapping? Would you
> accept any patches doing this?
