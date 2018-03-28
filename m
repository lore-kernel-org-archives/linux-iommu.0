From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Set GBPA to abort all transactions
Date: Wed, 28 Mar 2018 16:00:47 +0100
Message-ID: <3350f0eb84c8c621cf43aa06ed117cfb@www.loen.fr>
References: <1522247980-31892-1-git-send-email-timur@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1522247980-31892-1-git-send-email-timur@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Timur Tabi <timur@codeaurora.org>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, Sameer Goel <sgoel@codeaurora.org>, Robin Murphy <robin.murphy@arm.com>, nwatters@codeaurora.org
List-Id: iommu@lists.linux-foundation.org

On 2018-03-28 15:39, Timur Tabi wrote:
> From: Sameer Goel <sgoel@codeaurora.org>
>
> Set SMMU_GBPA to abort all incoming translations during the SMMU 
> reset
> when SMMUEN==0.
>
> This prevents a race condition where a stray DMA from the crashed 
> primary
> kernel can try to access an IOVA address as an invalid PA when SMMU 
> is
> disabled during reset in the crash kernel.
>
> Signed-off-by: Sameer Goel <sgoel@codeaurora.org>
> ---
>  drivers/iommu/arm-smmu-v3.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/iommu/arm-smmu-v3.c 
> b/drivers/iommu/arm-smmu-v3.c
> index 3f2f1fc68b52..c04a89310c59 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -2458,6 +2458,18 @@ static int arm_smmu_device_reset(struct
> arm_smmu_device *smmu, bool bypass)
>  	if (reg & CR0_SMMUEN)
>  		dev_warn(smmu->dev, "SMMU currently enabled! Resetting...\n");
>
> +	/*
> +	 * Abort all incoming translations. This can happen in a kdump case
> +	 * where SMMU is initialized when a prior DMA is pending. Just
> +	 * disabling the SMMU in this case might result in writes to 
> invalid
> +	 * PAs.
> +	 */
> +	ret = arm_smmu_update_gbpa(smmu, 1, GBPA_ABORT);
> +	if (ret) {
> +		dev_err(smmu->dev, "GBPA not responding to update\n");
> +		return ret;
> +	}
> +
>  	ret = arm_smmu_device_disable(smmu);
>  	if (ret)
>  		return ret;

A tangential question: can we reliably detect that the SMMU already has 
valid mappings, which would indicate that we're in a pretty bad shape 
already by the time we set that bit? For all we know, memory could have 
been corrupted long before we hit this point, and this patch barely 
narrows the window of opportunity.

At the very least, we should emit a warning and taint the kernel (we've 
recently added such measures to the GICv3 driver).

Thanks,

         M.
-- 
Fast, cheap, reliable. Pick two.
