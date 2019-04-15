From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 1/1] iommu/arm-smmu: Add SID information to context fault
	log
Date: Mon, 15 Apr 2019 10:41:38 +0100
Message-ID: <e5945adb-a1a3-1743-e671-39707276fad6@arm.com>
References: <20190415080734.6843-1-vivek.gautam@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190415080734.6843-1-vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 15/04/2019 09:07, Vivek Gautam wrote:
> Extract the SID and add the information to context fault log.
> This is specially useful in a distributed smmu architecture
> where multiple masters are connected to smmu. SID information
> helps to quickly identify the faulting master device.

Hmm, given how it's UNKNOWN for translation faults, which are arguably 
the most likely context fault, I reckon it probably makes more sense to 
just dump the raw register value for the user to interpret, as we do for 
fsr/fsynr.

Robin.

> Signed-off-by: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> ---
>   drivers/iommu/arm-smmu-regs.h |  4 ++++
>   drivers/iommu/arm-smmu.c      | 14 ++++++++++++--
>   2 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-regs.h b/drivers/iommu/arm-smmu-regs.h
> index a1226e4ab5f8..e5be0344b610 100644
> --- a/drivers/iommu/arm-smmu-regs.h
> +++ b/drivers/iommu/arm-smmu-regs.h
> @@ -147,6 +147,10 @@ enum arm_smmu_s2cr_privcfg {
>   #define CBAR_IRPTNDX_SHIFT		24
>   #define CBAR_IRPTNDX_MASK		0xff
>   
> +#define ARM_SMMU_GR1_CBFRSYNRA(n)	(0x400 + ((n) << 2))
> +#define CBFRSYNRA_V2_SID_MASK		0xffff
> +#define CBFRSYNRA_V1_SID_MASK		0x7fff
> +
>   #define ARM_SMMU_GR1_CBA2R(n)		(0x800 + ((n) << 2))
>   #define CBA2R_RW64_32BIT		(0 << 0)
>   #define CBA2R_RW64_64BIT		(1 << 0)
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 045d93884164..aa3426dc68d0 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -575,7 +575,10 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
>   	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>   	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
>   	struct arm_smmu_device *smmu = smmu_domain->smmu;
> +	void __iomem *gr1_base = ARM_SMMU_GR1(smmu);
>   	void __iomem *cb_base;
> +	u32 cbfrsynra;
> +	u16 sid;
>   
>   	cb_base = ARM_SMMU_CB(smmu, cfg->cbndx);
>   	fsr = readl_relaxed(cb_base + ARM_SMMU_CB_FSR);
> @@ -586,9 +589,16 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
>   	fsynr = readl_relaxed(cb_base + ARM_SMMU_CB_FSYNR0);
>   	iova = readq_relaxed(cb_base + ARM_SMMU_CB_FAR);
>   
> +	cbfrsynra = readl_relaxed(gr1_base +
> +				  ARM_SMMU_GR1_CBFRSYNRA(cfg->cbndx));
> +	if (smmu->version > ARM_SMMU_V1)
> +		sid = cbfrsynra & CBFRSYNRA_V2_SID_MASK;
> +	else
> +		sid = cbfrsynra & CBFRSYNRA_V1_SID_MASK;
> +
>   	dev_err_ratelimited(smmu->dev,
> -	"Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cb=%d\n",
> -			    fsr, iova, fsynr, cfg->cbndx);
> +	"Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cb=%d sid = %u\n",
> +			    fsr, iova, fsynr, cfg->cbndx, sid);
>   
>   	writel(fsr, cb_base + ARM_SMMU_CB_FSR);
>   	return IRQ_HANDLED;
> 
