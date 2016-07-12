From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] iommu/arm-smmu-v3: limit use of 2-level stream tables
Date: Tue, 12 Jul 2016 10:36:06 +0100
Message-ID: <5784BA06.2020607@arm.com>
References: <1468260059-10759-1-git-send-email-nwatters@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1468260059-10759-1-git-send-email-nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Nate Watterson <nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 11/07/16 19:00, Nate Watterson wrote:
> In the current arm-smmu-v3 driver, all smmus that support 2-level
> stream tables are being forced to use them. This is suboptimal for
> smmus that support fewer stream id bits than would fill in a single
> second level table. This patch limits the use of 2-level tables to
> smmus that both support the feature and whose first level table can
> possibly contain more than a single entry.

Makes sense to me, in principle.

> Signed-off-by: Nate Watterson <nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> ---
>  drivers/iommu/arm-smmu-v3.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 5f6b3bc..742254c 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -2531,6 +2531,17 @@ static int arm_smmu_device_probe(struct arm_smmu_device *smmu)
>  	smmu->ssid_bits = reg >> IDR1_SSID_SHIFT & IDR1_SSID_MASK;
>  	smmu->sid_bits = reg >> IDR1_SID_SHIFT & IDR1_SID_MASK;
>  
> +	/*
> +	 * If the SMMU supports fewer bits than would fill a single L2 stream
> +	 * table, use a linear table instead.
> +	 */
> +	if (smmu->sid_bits <= STRTAB_SPLIT &&
> +	    smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) {
> +		smmu->features &= ~ARM_SMMU_FEAT_2_LVL_STRTAB;
> +		dev_info(smmu->dev, "SIDSIZE (%d) <= STRTAB_SPLIT (%d) : disabling 2-level stream tables\n",
> +			 smmu->sid_bits, STRTAB_SPLIT);

There's no useful reason to squawk about this; it's just noise.

Whatever old version of the spec I have here would appear to agree: "In
all cases, aside from the lookup of the STE itself, the choice of Stream
Table format is irrelevant to any other SMMU operation."

> +	}
> +
>  	/* IDR5 */
>  	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR5);

I think this now leaves some of the logic in arm_smmu_init_strtab_2lvl()
redundant, so it would probably be worth tidying that up at the same time.

Robin.
