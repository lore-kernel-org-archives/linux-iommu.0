Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF37110A
	for <iommu@lists.linux.dev>; Wed, 22 Jun 2022 07:17:37 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0413913D5;
	Wed, 22 Jun 2022 00:17:37 -0700 (PDT)
Received: from [10.57.85.1] (unknown [10.57.85.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC4353F66F;
	Wed, 22 Jun 2022 00:17:35 -0700 (PDT)
Message-ID: <bc4add1b-8b89-7989-5afb-df6b5338eb3d@arm.com>
Date: Wed, 22 Jun 2022 08:17:29 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 3/3] iommu: Clean up release_device checks
Content-Language: en-GB
To: Baolu Lu <baolu.lu@linux.intel.com>, joro@8bytes.org, will@kernel.org
Cc: iommu@lists.linux-foundation.org, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1655822151.git.robin.murphy@arm.com>
 <02671dbfad7a3343fc25a44222350efcb455fe3c.1655822151.git.robin.murphy@arm.com>
 <59002dbd-d72a-4f9c-7ad8-808ee8d2ff05@linux.intel.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <59002dbd-d72a-4f9c-7ad8-808ee8d2ff05@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Message-ID: <20220622071729.6q3CeuRxdAtdcpTm0zoSwourSbHVHFD76-zDzmS7woU@z>

On 2022-06-22 02:36, Baolu Lu wrote:
> On 2022/6/21 23:14, Robin Murphy wrote:
>> Since .release_device is now called through per-device ops, any call
>> which gets as far as a driver definitely*is*  for that driver, for a
>> device which has successfully passed .probe_device, so all the checks to
>> that effect are now redundant and can be removed. In the same vein we
>> can also skip freeing fwspecs which are now managed by core code.
> 
> Does this depend on any other series? I didn't see iommu_fwspec_free()
> called in the core code. Or I missed anything?

dev_iommu_free() cleans up param->fwspec directly (see b54240ad4943). 
FWIW the plan is that iommu_fwspec_free() should eventually go away - of 
the remaining uses after this, two are in fact similarly redundant 
already, since there's also a dev_iommu_free() in the probe failure 
path, and the other two should disappear in part 2 of fixing the bus 
probing mess (wherein the of_xlate step gets pulled into 
iommu_probe_device as well, and finally works correctly again).

Cheers,
Robin.

> 
>>
>> Signed-off-by: Robin Murphy<robin.murphy@arm.com>
>> ---
>>   drivers/iommu/apple-dart.c                  |  3 ---
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  8 +-------
>>   drivers/iommu/arm/arm-smmu/arm-smmu.c       | 14 +++-----------
>>   drivers/iommu/arm/arm-smmu/qcom_iommu.c     | 11 -----------
>>   drivers/iommu/exynos-iommu.c                |  3 ---
>>   drivers/iommu/mtk_iommu.c                   |  5 -----
>>   drivers/iommu/mtk_iommu_v1.c                |  5 -----
>>   drivers/iommu/sprd-iommu.c                  | 11 -----------
>>   drivers/iommu/virtio-iommu.c                |  8 +-------
>>   9 files changed, 5 insertions(+), 63 deletions(-)
> 
> Best regards,
> baolu
