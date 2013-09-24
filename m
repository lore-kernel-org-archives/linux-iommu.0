From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 2/7] iommu/arm-smmu: Calculate SMMU_CB_BASE from smmu
 register values
Date: Tue, 24 Sep 2013 16:34:57 +0100
Message-ID: <20130924153457.GC20774@mudshark.cambridge.arm.com>
References: <1380035221-11576-1-git-send-email-andreas.herrmann@calxeda.com>
 <1380035221-11576-3-git-send-email-andreas.herrmann@calxeda.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1380035221-11576-3-git-send-email-andreas.herrmann@calxeda.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andreas Herrmann <andreas.herrmann@calxeda.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Sep 24, 2013 at 04:06:56PM +0100, Andreas Herrmann wrote:
> Currently it is derived from smmu resource size. If the resource size
> is wrongly specified (e.g. too large) this leads to a miscalculation
> and can cause undefined behaviour when context bank registers are
> modified.
> 
> Signed-off-by: Andreas Herrmann <andreas.herrmann@calxeda.com>
> ---
>  drivers/iommu/arm-smmu.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 97b764b..f5a856e 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -207,7 +207,7 @@
>  #define CBA2R_RW64_64BIT		(1 << 0)
>  
>  /* Translation context bank */
> -#define ARM_SMMU_CB_BASE(smmu)		((smmu)->base + ((smmu)->size >> 1))
> +#define ARM_SMMU_CB_BASE(smmu)		((smmu)->cb_base)
>  #define ARM_SMMU_CB(smmu, n)		((n) * (smmu)->pagesize)
>  
>  #define ARM_SMMU_CB_SCTLR		0x0
> @@ -339,6 +339,7 @@ struct arm_smmu_device {
>  	struct device_node		*parent_of_node;
>  
>  	void __iomem			*base;
> +	void __iomem			*cb_base;
>  	unsigned long			size;
>  	unsigned long			pagesize;
>  
> @@ -1701,7 +1702,9 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
>  
>  	/* Check that we ioremapped enough */
>  	size = 1 << (((id >> ID1_NUMPAGENDXB_SHIFT) & ID1_NUMPAGENDXB_MASK) + 1);
> -	size *= (smmu->pagesize << 1);
> +	size *= smmu->pagesize;
> +	smmu->cb_base = smmu->base + size;
> +	size *= 2;
>  	if (smmu->size < size)
>  		dev_warn(smmu->dev,
>  			 "device is 0x%lx bytes but only mapped 0x%lx!\n",

Hmm, this is a tricky one. We know that we have an inconsistency (i.e. the
DT and the hardware don't agree on the size of the device) but we warn and
attempt to continue with the value from the DT. I don't think that trusting
the hardware is the right thing to do in this case, since it's not possible
to change so we should let the DT act as an override.

In other words: if the device tree is wrong, go fix it.

Will
