From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] iommu/arm-smmu: don't touch the secure STLBIALL register
Date: Tue, 6 Jan 2015 14:15:07 +0000
Message-ID: <20150106141507.GB3484@arm.com>
References: <1419356362-27343-1-git-send-email-mitchelh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1419356362-27343-1-git-send-email-mitchelh@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mitchel Humpherys <mitchelh@codeaurora.org>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

Hi Mitch,

On Tue, Dec 23, 2014 at 05:39:22PM +0000, Mitchel Humpherys wrote:
> Currently we do a STLBIALL when we initialize the SMMU.  However, in
> some configurations that register is not supposed to be touched and is
> marked as "Secure only" in the spec.  Rip it out.
> 
> Signed-off-by: Mitchel Humpherys <mitchelh@codeaurora.org>
> ---
>  drivers/iommu/arm-smmu.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 60558f794922..9170bbced5e5 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -173,7 +173,6 @@
>  #define PIDR2_ARCH_MASK			0xf
>  
>  /* Global TLB invalidation */
> -#define ARM_SMMU_GR0_STLBIALL		0x60
>  #define ARM_SMMU_GR0_TLBIVMID		0x64
>  #define ARM_SMMU_GR0_TLBIALLNSNH	0x68
>  #define ARM_SMMU_GR0_TLBIALLH		0x6c
> @@ -1686,7 +1685,6 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
>  	}
>  
>  	/* Invalidate the TLB, just in case */
> -	writel_relaxed(0, gr0_base + ARM_SMMU_GR0_STLBIALL);
>  	writel_relaxed(0, gr0_base + ARM_SMMU_GR0_TLBIALLH);
>  	writel_relaxed(0, gr0_base + ARM_SMMU_GR0_TLBIALLNSNH);

I was slightly worried that this would break the Calxeda implementation
with ARM_SMMU_OPT_SECURE_CFG_ACCESS, but actually these registers aren't
even aliased there so I think there's a bigger bug for them.

Anyway, given that their hardware has gone the way of the dodo, I'll take
the patch as-is unless you have any further comments?

Will
