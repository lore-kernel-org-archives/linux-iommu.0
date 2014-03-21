From: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH V2] iommu/amd: Fix logic to determine and checking max
	PASID
Date: Fri, 21 Mar 2014 14:07:41 -0500
Message-ID: <532C8DFD.7020605@amd.com>
References: <1394067258-5968-1-git-send-email-suravee.suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1394067258-5968-1-git-send-email-suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: jay.cornwall-5C7GfCeVMHo@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kim.naru-5C7GfCeVMHo@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Joerg,

Do you have any concerns about the V2 of this patch?

Thanks,

Suravee

On 3/5/2014 6:54 PM, suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
>
> In reality, the spec can only support 16-bit PASID since
> INVALIDATE_IOTLB_PAGES and COMPLETE_PPR_REQUEST commands only allow 16-bit
> PASID. So, we updated the PASID_MASK accordingly and invoke BUG_ON
> if the hardware is reporting PASmax more than 16-bit.
>
> Besides, max PASID is defined as ((2^(PASmax+1)) - 1). The current does not
> determine this correctly.
>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
> Tested-by: Jay Cornwall <Jay.Cornwall-5C7GfCeVMHo@public.gmane.org>
> ---
>   drivers/iommu/amd_iommu.c       |    4 ++--
>   drivers/iommu/amd_iommu_init.c  |   16 +++++++++-------
>   drivers/iommu/amd_iommu_types.h |   11 ++++++++---
>   3 files changed, 19 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index faf0da4..66ef2cb 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -963,7 +963,7 @@ static void build_inv_iommu_pasid(struct iommu_cmd *cmd, u16 domid, int pasid,
>
>   	address &= ~(0xfffULL);
>
> -	cmd->data[0]  = pasid & PASID_MASK;
> +	cmd->data[0]  = pasid;
>   	cmd->data[1]  = domid;
>   	cmd->data[2]  = lower_32_bits(address);
>   	cmd->data[3]  = upper_32_bits(address);
> @@ -1001,7 +1001,7 @@ static void build_complete_ppr(struct iommu_cmd *cmd, u16 devid, int pasid,
>
>   	cmd->data[0]  = devid;
>   	if (gn) {
> -		cmd->data[1]  = pasid & PASID_MASK;
> +		cmd->data[1]  = pasid;
>   		cmd->data[2]  = CMD_INV_IOMMU_PAGES_GN_MASK;
>   	}
>   	cmd->data[3]  = tag & 0x1ff;
> diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
> index 28b4bea..b76c58d 100644
> --- a/drivers/iommu/amd_iommu_init.c
> +++ b/drivers/iommu/amd_iommu_init.c
> @@ -150,7 +150,7 @@ int amd_iommus_present;
>   bool amd_iommu_np_cache __read_mostly;
>   bool amd_iommu_iotlb_sup __read_mostly = true;
>
> -u32 amd_iommu_max_pasids __read_mostly = ~0;
> +u32 amd_iommu_max_pasid __read_mostly = ~0;
>
>   bool amd_iommu_v2_present __read_mostly;
>   bool amd_iommu_pc_present __read_mostly;
> @@ -1231,14 +1231,16 @@ static int iommu_init_pci(struct amd_iommu *iommu)
>
>   	if (iommu_feature(iommu, FEATURE_GT)) {
>   		int glxval;
> -		u32 pasids;
> -		u64 shift;
> +		u32 max_pasid;
> +		u64 pasmax;
>
> -		shift   = iommu->features & FEATURE_PASID_MASK;
> -		shift >>= FEATURE_PASID_SHIFT;
> -		pasids  = (1 << shift);
> +		pasmax = iommu->features & FEATURE_PASID_MASK;
> +		pasmax >>= FEATURE_PASID_SHIFT;
> +		max_pasid  = (1 << (pasmax + 1)) - 1;
>
> -		amd_iommu_max_pasids = min(amd_iommu_max_pasids, pasids);
> +		amd_iommu_max_pasid = min(amd_iommu_max_pasid, max_pasid);
> +
> +		BUG_ON(amd_iommu_max_pasid & ~PASID_MASK);
>
>   		glxval   = iommu->features & FEATURE_GLXVAL_MASK;
>   		glxval >>= FEATURE_GLXVAL_SHIFT;
> diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
> index e400fbe..55ba46b 100644
> --- a/drivers/iommu/amd_iommu_types.h
> +++ b/drivers/iommu/amd_iommu_types.h
> @@ -98,7 +98,12 @@
>   #define FEATURE_GLXVAL_SHIFT	14
>   #define FEATURE_GLXVAL_MASK	(0x03ULL << FEATURE_GLXVAL_SHIFT)
>
> -#define PASID_MASK		0x000fffff
> +/* Note:
> + * The current driver only support 16-bit PASID.
> + * Currently, hardware only implement upto 16-bit PASID
> + * even though the spec says it could have upto 20 bits.
> + */
> +#define PASID_MASK		0x0000ffff
>
>   /* MMIO status bits */
>   #define MMIO_STATUS_EVT_INT_MASK	(1 << 1)
> @@ -696,8 +701,8 @@ extern unsigned long *amd_iommu_pd_alloc_bitmap;
>    */
>   extern u32 amd_iommu_unmap_flush;
>
> -/* Smallest number of PASIDs supported by any IOMMU in the system */
> -extern u32 amd_iommu_max_pasids;
> +/* Smallest max PASID supported by any IOMMU in the system */
> +extern u32 amd_iommu_max_pasid;
>
>   extern bool amd_iommu_v2_present;
>
>
