From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH V2] iommu/arm-smmu-v2: ThunderX mis-extends 64bit registers
Date: Thu, 6 Aug 2015 17:16:25 +0100
Message-ID: <20150806161625.GJ25483@arm.com>
References: <1438793668-15597-1-git-send-email-tchalamarla@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1438793668-15597-1-git-send-email-tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Tirumalesh Chalamarla <tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "robert.richter-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org" <robert.richter-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org" <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Tirumalesh,

I think this looks pretty good now, just one small comment below.

On Wed, Aug 05, 2015 at 05:54:28PM +0100, Tirumalesh Chalamarla wrote:
> The SMMU architecture defines two different behaviors when 64-bit
> registers are written with 32-bit writes.  The first behavior causes
> zero extension into the upper 32-bits.  The second behavior splits a
> 64-bit register into "normal" 32-bit register pairs.
> 
> On some buggy implementations, registers incorrectly zero extended
> when they should instead behave as normal 32-bit register pairs.
> 
> Signed-off-by: Tirumalesh Chalamarla <tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
> ---
> 
> Changes from V1:
> 	- Introduced smmu_writeq
> 
>  drivers/iommu/arm-smmu.c | 45 +++++++++++++++++++++++++--------------------
>  1 file changed, 25 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 66a803b..0912c78 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -69,6 +69,18 @@
>  		((smmu->options & ARM_SMMU_OPT_SECURE_CFG_ACCESS)	\
>  			? 0x400 : 0))
>  
> +#ifdef CONFIG_64BIT
> +#define smmu_writeq(reg64, addr)	writeq_relaxed((reg64), (addr))
> +#else
> +#define smmu_writeq(reg64, addr)				\
> +	do {							\
> +		u64 __val = (reg64);				\
> +		void __iomem *__addr = (addr);			\
> +		writel_relaxed(__val >> 32, __addr + 4);	\
> +		writel_relaxed(__val, __addr);			\
> +	} while (0)
> +#endif
> +
>  /* Configuration registers */
>  #define ARM_SMMU_GR0_sCR0		0x0
>  #define sCR0_CLIENTPD			(1 << 0)
> @@ -226,7 +238,7 @@
>  #define TTBCR2_SEP_SHIFT		15
>  #define TTBCR2_SEP_UPSTREAM		(0x7 << TTBCR2_SEP_SHIFT)
>  
> -#define TTBRn_HI_ASID_SHIFT            16
> +#define TTBRn_ASID_SHIFT		48
>  
>  #define FSR_MULTI			(1 << 31)
>  #define FSR_SS				(1 << 30)
> @@ -762,22 +774,17 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
>  
>  	/* TTBRs */
>  	if (stage1) {
> -		reg = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[0];
> -		writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR0_LO);
> -		reg = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[0] >> 32;
> -		reg |= ARM_SMMU_CB_ASID(cfg) << TTBRn_HI_ASID_SHIFT;
> -		writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR0_HI);
> -
> -		reg = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[1];
> -		writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR1_LO);
> -		reg = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[1] >> 32;
> -		reg |= ARM_SMMU_CB_ASID(cfg) << TTBRn_HI_ASID_SHIFT;
> -		writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR1_HI);
> +		u64 reg64 = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[0];

Can we move this declaration to the start of the function along with
u32 reg, please? It's used in both cases of the if/else block so it
might be a tad cleaner.

Will
