From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] iommu/arm-smmu-v2: ThunderX(errata-23399) mis-extends
	64bit registers
Date: Fri, 31 Jul 2015 12:27:40 +0100
Message-ID: <20150731112740.GC29497@arm.com>
References: <1438278906-29627-1-git-send-email-tchalamarla@caviumnetworks.com>
	<20150730184523.GC16663@arm.com>
	<96AD8EF9-D416-43AB-BA6F-2C25098BB8BB@caviumnetworks.com>
	<91236962-23EF-4306-B0FA-0F7DAE4F06CD@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <91236962-23EF-4306-B0FA-0F7DAE4F06CD-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Chalamarla, Tirumalesh" <Tirumalesh.Chalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Richter, Robert" <Robert.Richter-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jul 30, 2015 at 09:54:04PM +0100, Chalamarla, Tirumalesh wrote:
> is some thing like this looks good

That's the right sort of idea, but please send a proper patch that you've
actually tested. The diff below mixes up reg64 and reg.

Will

> +#ifdef CONFIG_64BIT
> +#define smmu_writeq(reg64, addr)       writeq_relaxed((reg64), (addr))
> +#else
> +#define smmu_writeq(reg64, addr)                       \
> +               writel_relaxed(((reg64) >> 32), ((addr) + 4));  \
> +               writel_relaxed((reg64), (addr))
> +
> +
>  /* Configuration registers */
>  #define ARM_SMMU_GR0_sCR0              0x0
>  #define sCR0_CLIENTPD                  (1 << 0)
> @@ -226,7 +234,7 @@
>  #define TTBCR2_SEP_SHIFT               15
>  #define TTBCR2_SEP_UPSTREAM            (0x7 << TTBCR2_SEP_SHIFT)
> 
> -#define TTBRn_HI_ASID_SHIFT            16
> +#define TTBRn_ASID_SHIFT               48
> 
>  #define FSR_MULTI                      (1 << 31)
>  #define FSR_SS                         (1 << 30)
> @@ -719,6 +727,7 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
>                                        struct io_pgtable_cfg *pgtbl_cfg)
>  {
>         u32 reg;
> +       u64 reg64;
>         bool stage1;
>         struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
>         struct arm_smmu_device *smmu = smmu_domain->smmu;
> @@ -762,22 +771,16 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
> 
>         /* TTBRs */
>         if (stage1) {
> -               reg = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[0];
> -               writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR0_LO);
> -               reg = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[0] >> 32;
> -               reg |= ARM_SMMU_CB_ASID(cfg) << TTBRn_HI_ASID_SHIFT;
> -               writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR0_HI);
> -
> -               reg = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[1];
> -               writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR1_LO);
> -               reg = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[1] >> 32;
> -               reg |= ARM_SMMU_CB_ASID(cfg) << TTBRn_HI_ASID_SHIFT;
> -               writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR1_HI);
> +               reg64 = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[0];
> +               reg64 |= ((u64)ARM_SMMU_CB_ASID(cfg)) << TTBRn_ASID_SHIFT;
> +               smmu_writeq(reg64, cb_base + ARM_SMMU_CB_TTBR0_LO);
> +
> +               reg64 = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[1];
> +               reg64 |= ARM_SMMU_CB_ASID(cfg) << TTBRn_ASID_SHIFT;
> +               smmu_writeq(reg, cb_base + ARM_SMMU_CB_TTBR1_LO);
>         } else {
> -               reg = pgtbl_cfg->arm_lpae_s2_cfg.vttbr;
> -               writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR0_LO);
> -               reg = pgtbl_cfg->arm_lpae_s2_cfg.vttbr >> 32;
> -               writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR0_HI);
> +               reg64 = pgtbl_cfg->arm_lpae_s2_cfg.vttbr;
> +               smmu_writeq(reg, cb_base + ARM_SMMU_CB_TTBR0_LO);
>         }
> 
>         /* TTBCR */
> @@ -1236,10 +1239,8 @@ static phys_addr_t arm_smmu_iova_to_phys_hard(struct iommu_domain *domain,
>                 u32 reg = iova & ~0xfff;
>                 writel_relaxed(reg, cb_base + ARM_SMMU_CB_ATS1PR_LO);
>         } else {
> -               u32 reg = iova & ~0xfff;
> -               writel_relaxed(reg, cb_base + ARM_SMMU_CB_ATS1PR_LO);
> -               reg = ((u64)iova & ~0xfff) >> 32;
> -               writel_relaxed(reg, cb_base + ARM_SMMU_CB_ATS1PR_HI);
> +               u64 reg = iova & ~0xfff;
> +               smmu_writeq(reg, cb_base + ARM_SMMU_CB_ATS1PR_LO);
>         }
> 
>         if (readl_poll_timeout_atomic(cb_base + ARM_SMMU_CB_ATSR, tmp,
