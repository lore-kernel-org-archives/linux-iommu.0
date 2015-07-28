From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 2/5] iommu/arm-smmu: Sort out coherency
Date: Tue, 28 Jul 2015 10:43:49 +0100
Message-ID: <20150728094349.GE29209@arm.com>
References: <c8cc82fea26044e393ff857014d4146faac5ec1e.1438019069.git.robin.murphy@arm.com>
	<4d5880f2131854bc59107ccc917993136e511341.1438019069.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4d5880f2131854bc59107ccc917993136e511341.1438019069.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <Robin.Murphy-5wv7dgnIgG8@public.gmane.org>
Cc: "laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

Cheers for doing this. Just a few comments (mainly in relation to being
consistent with SMMUv3).

On Mon, Jul 27, 2015 at 07:18:09PM +0100, Robin Murphy wrote:
> Currently we detect the whether the SMMU has coherent page table walk

"we detect the whether"?

> capability from the IDR0.CTTW field, and base our cache maintenance
> decisions on that. In preparation for fixing the bogus DMA API usage,
> however, we need to ensure that the DMA API agrees about this, which
> necessitates deferring to the dma-coherent property in the device tree
> for the final say.
> 
> As an added bonus, since systems exist where an external CTTW signal
> has been tied off incorrectly at integration, allowing DT to override
> it offers a neat workaround for coherency issues with such SMMUs.
> 
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu.txt |  4 ++++
>  drivers/iommu/arm-smmu.c                             | 17 ++++++++++++++---
>  2 files changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> index 0676050..04724fc 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> @@ -43,6 +43,10 @@ conditions.
>  
>  ** System MMU optional properties:
>  
> +- dma-coherent  : Presence or absence should correctly reflect whether
> +                  the SMMU translation table walk interface is
> +                  cache-coherent with the CPU.
> +

Please copy the text from:
Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt#
and remove the bit about stream table accesses.

>  - calxeda,smmu-secure-config-access : Enable proper handling of buggy
>                    implementations that always use secure access to
>                    SMMU configuration registers. In this case non-secure
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 4cd0c29..9a59bef 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -1532,6 +1532,7 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
>  	unsigned long size;
>  	void __iomem *gr0_base = ARM_SMMU_GR0(smmu);
>  	u32 id;
> +	bool cttw_dt, cttw_reg;
>  
>  	dev_notice(smmu->dev, "probing hardware configuration...\n");
>  	dev_notice(smmu->dev, "SMMUv%d with:\n", smmu->version);
> @@ -1571,10 +1572,20 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
>  		dev_notice(smmu->dev, "\taddress translation ops\n");
>  	}
>  
> -	if (id & ID0_CTTW) {
> +	/*
> +	 * In order for DMA API calls to work properly, we must defer to what
> +	 * the DT says about coherency, regardless of what the hardware claims.
> +	 * Fortunately, this also opens up a workaround for systems where the
> +	 * ID register value has ended up configured incorrectly.
> +	 */
> +	cttw_dt = of_property_read_bool(smmu->dev->of_node, "dma-coherent");

Use of_dma_is_coherent(smmu->dev->of_node)

> +	if (cttw_dt)
>  		smmu->features |= ARM_SMMU_FEAT_COHERENT_WALK;
> -		dev_notice(smmu->dev, "\tcoherent table walk\n");
> -	}
> +	cttw_reg = !!(id & ID0_CTTW);
> +	if (cttw_dt || cttw_reg)
> +		dev_notice(smmu->dev, "\t%scoherent table walk%s\n",
> +			   cttw_dt ? "" : "no ",
> +			   (cttw_dt == cttw_reg) ? "" : " (overridden by DT)");

Similarly here; I think we should just follow the message printed by the
SMMUv3 driver but s/IDR0.COHACC/ID0.CTTW/.

Will
