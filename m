From: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 1/1] iommu/arm-smmu-v3: eliminate a potential memory
 corruption on Hi16xx soc
Date: Mon, 15 Oct 2018 12:17:51 +0100
Message-ID: <4583617a-49ad-00b5-97fc-1ea35568c5cd@huawei.com>
References: <1539592576-24352-1-git-send-email-thunder.leizhen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539592576-24352-1-git-send-email-thunder.leizhen@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhen Lei <thunder.leizhen@huawei.com>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, iommu <iommu@lists.linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: LinuxArm <linuxarm@huawei.com>
List-Id: iommu@lists.linux-foundation.org

On 15/10/2018 09:36, Zhen Lei wrote:
> ITS translation register map:
> 0x0000-0x003C	Reserved
> 0x0040		GITS_TRANSLATER
> 0x0044-0xFFFC	Reserved
>

Can you add a better opening than the ITS translation register map?

> The standard GITS_TRANSLATER register in ITS is only 4 bytes, but Hisilicon
> expands the next 4 bytes to carry some IMPDEF information. That means, 8 bytes
> data will be written to MSIAddress each time.
>
> MSIAddr: |----4bytes----|----4bytes----|
> 	 |    MSIData   |    IMPDEF    |
>
> There is no problem for ITS, because the next 4 bytes space is reserved in ITS.
> But it will overwrite the 4 bytes memory following "sync_count". It's very

I think arm_smmu_device.sync_count is better, or "sync_count member in 
the the smmu driver control struct".

> luckly that the previous and the next neighbour of "sync_count" are both aligned

/s/luckly/luckily or fortunately/

> by 8 bytes, so no problem is met now.
>
> It's good to explicitly add a workaround:
> 1. Add gcc __attribute__((aligned(8))) to make sure that "sync_count" is always
>    aligned by 8 bytes.
> 2. Add a "u64" union member to make sure the 4 bytes padding is always exist.
>
> There is no functional change.
>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/iommu/arm-smmu-v3.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 5059d09..a07bc0d 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -586,7 +586,10 @@ struct arm_smmu_device {
>
>  	struct arm_smmu_strtab_cfg	strtab_cfg;
>
> +	union {
> +	u64				padding; /* workaround for Hisilicon */

I think that a more detailed comment is required.

>  	u32				sync_count;

Can you indent these 2 members? However - as discussed internally - this 
may have endian issue so better to declare full 64b struct.

> +	} __attribute__((aligned(8)));
>
>  	/* IOMMU core code handle */
>  	struct iommu_device		iommu;
>
Thanks
