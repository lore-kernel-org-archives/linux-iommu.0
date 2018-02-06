From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH RFC 1/1] iommu/arm-smmu: Fix context fault message
 considering non-NTS
Date: Tue, 6 Feb 2018 11:52:18 +0000
Message-ID: <fb3c1797-118f-500b-002b-5ecb9172af1c@arm.com>
References: <1517912213-3962-1-git-send-email-vivek.gautam@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1517912213-3962-1-git-send-email-vivek.gautam@codeaurora.org>
Content-Language: en-GB
Sender: linux-arm-msm-owner@vger.kernel.org
To: Vivek Gautam <vivek.gautam@codeaurora.org>, will.deacon@arm.com, joro@8bytes.org, iommu@lists.linux-foundation.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Vivek,

On 06/02/18 10:16, Vivek Gautam wrote:
> SMMU_CBn_FSYNR0 definition from SMMU v2 architecture document
> says that, the S1CBNDX[23:16] field is only valid if SMMU_IDR0.NTS==1.
> So, update the fsynr in context bank fault handler, so that the
> fault message displays cbndx only when we have nested translations
> enabled.
> Otherwise, it is confusing when 'cb' gives the actual context
> bank, while the 'fsynr' gives a different value.
> 
> Example, on a sdm845 system:
> Before this patch -
> arm-smmu 15000000.apps-smmu: Unhandled context fault:
>                            fsr=0x402, iova=0x9e0fb600, fsynr=0x3c0020, cb=0
> After this patch -
> arm-smmu 15000000.apps-smmu: Unhandled context fault:
>                            fsr=0x402, iova=0x9e0aa000, fsynr=0x20, cb=0
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> Hi Robin,
> Does it make sense to mask fsynr like this?
> Would it still be confusing for CB==0?
> Tagging the patch as RFC to get your comments. If looks good,
> then i will send the patch for your ack.
> Thanks.

I would expect that anyone who knows how to decode a raw FSYNR0 value 
should also be aware of when various fields are valid or not. I have 
page 302 of IHI0062D.c open next to this email, and to me it seems 
virtually impossible to read the definition of S1CBNDX without 
inherently seeing all the conditions under which it is UNKNOWN (which 
incidentally are more than this patch would cover).

In general, I don't agree with this - we're dumping the raw state of a 
register, and it's already a cryptic hex value that you have to refer to 
the architecture spec to decode. There is perhaps some argument for 
pretty-printing faults with everything fully decoded, but given that 
they should never be seen under normal operation (especially global 
faults), I really don't think that's worth the bother either.

Robin.

>   drivers/iommu/arm-smmu.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 69e7c60792a8..827659515b22 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -550,6 +550,9 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
>   	fsynr = readl_relaxed(cb_base + ARM_SMMU_CB_FSYNR0);
>   	iova = readq_relaxed(cb_base + ARM_SMMU_CB_FAR);
>   
> +	if (!smmu->features & ARM_SMMU_FEAT_TRANS_NESTED)
> +		fsynr &= 0xffff;
> +
>   	dev_err_ratelimited(smmu->dev,
>   	"Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cb=%d\n",
>   			    fsr, iova, fsynr, cfg->cbndx);
> 
