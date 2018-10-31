From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3 1/1] iommu/arm-smmu-v3: eliminate a potential memory
 corruption on hi1620 and earlier
Date: Wed, 31 Oct 2018 11:43:50 +0000
Message-ID: <ba9a0f3b-d150-c066-91a4-9ed9a380670b@arm.com>
References: <1540958527-15408-1-git-send-email-thunder.leizhen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1540958527-15408-1-git-send-email-thunder.leizhen@huawei.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Zhen Lei <thunder.leizhen@huawei.com>, John Garry <john.garry@huawei.com>, Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, iommu <iommu@lists.linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: LinuxArm <linuxarm@huawei.com>
List-Id: iommu@lists.linux-foundation.org

On 31/10/2018 04:02, Zhen Lei wrote:
> The standard GITS_TRANSLATER register in ITS is only 4 bytes, but
> Hisilicon expands the next 4 bytes to carry some IMPDEF information. That
> means, total 8 bytes data will be written to MSIAddress each time.
> 
> MSIAddr: |----4bytes----|----4bytes----|
> 	 |    MSIData   |    IMPDEF    |
> 
> There is no problem for ITS, because the next 4 bytes space is reserved
> in ITS. But it will overwrite the 4 bytes memory following "sync_count".
> It's very fortunately that the previous and the next neighbour of the
> "sync_count" are both aligned by 8 bytes, so no problem is met now.
> 
> It's good to explicitly add a workaround. Let's enclose the "sync_count"
> into a union and companion with a new member "padding" of type u64.
> 
> There is no functional change.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>   drivers/iommu/arm-smmu-v3.c | 18 +++++++++++++++++-
>   1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 6947ccf..4e94730 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -576,7 +576,23 @@ struct arm_smmu_device {
> 
>   	struct arm_smmu_strtab_cfg	strtab_cfg;
> 
> -	u32				sync_count;
> +	/*
> +	 * The member "padding" is used to make sure the member "sync_count" to
> +	 * be aligned at 8 bytes boundary, and 4 bytes padding memory followed.
> +	 *
> +	 * These are required by hi1620 and earlier of Hisilicon. Because the
> +	 * ITS hardware on hi1620 and earlier will truncate the MSIAddress(Here
> +	 * it's the address of "sync_count") to 8 bytes boundary first, then
> +	 * write 32 bits MSIdata at offset 0, and 32 bits IMPDEF data at offset
> +	 * 4. Without this workaround, the adjacent member maybe overwritten.
> +	 *
> +	 *                    |---4bytes---|---4bytes---|
> +	 * MSIAddress & (~0x7):   MSIdata  | IMPDEF data|
> +	 */
> +	union {
> +		u32			sync_count;
> +		u64			padding;
> +	};
> 
>   	/* IOMMU core code handle */
>   	struct iommu_device		iommu;
> --
> 1.8.3
> 
> 
