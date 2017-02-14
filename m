From: Rob Clark <robdclark@gmail.com>
Subject: Re: [RFC 2/2] iommu/arm-smmu: support qcom implementation
Date: Tue, 14 Feb 2017 14:17:16 -0500
Message-ID: <CAF6AEGsxyR6mjJ1OcDLt8b9LUvVNJ7hqmJ+=bd9=6N=nHCQA3A@mail.gmail.com>
References: <20170210184154.20193-1-robdclark@gmail.com> <20170210184154.20193-2-robdclark@gmail.com>
 <93887c69-97ed-16a6-5f06-1f6ce49131a7@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <93887c69-97ed-16a6-5f06-1f6ce49131a7@arm.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, Sricharan <sricharan@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, Andy Gross <agross@codeaurora.org>nd@arm.com
List-Id: iommu@lists.linux-foundation.org

On Tue, Feb 14, 2017 at 1:46 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> Hi Rob,
>
> On 10/02/17 18:41, Rob Clark wrote:
>> For devices with iommu(s) in secure mode, we cannot touch global
>> registers, and we have to live with the context -> sid mapping that
>> the secure world has set up for us.
>>
>> This enables, for example db410c (apq8016) devices to use the up-
>> stream arm-smmu driver.  This is the last major hurdle for having
>> the gpu working out of the box on an upstream kernel.
>>
>> NOTE: at this point, it works but I haven't spent any time thinking
>> much about the bindings.  Since we can't read the global regs, we
>> need to get all the device config info from DT (or at least anything
>> that can't be hard-coded).
>
> This approach seems, I have to say, unworkably horrible. I'm absolutely
> against the idea of pretending we have access to global state which we
> don't, then piling a facsimile of that state into the DT for no reason
> other than to keep the overcomplicated pretence up. This configuration
> comes out looking and behaving like a discrete IOMMU (see e.g.
> rockchip-iommu for inspiration) - if we have to support it, it would
> make far more sense to simply describe what we have, i.e. a
> "qcom,apq8016-smmu-context-bank" with a single interrupt and
> #iommu-cells = <0>. They'd want their own probe routine and private data
> (AFAICS more or less just a base address, an IRQ, ID features and an
> iommu_group), and probably a separate iommu_ops because you'd want to
> handle {add,remove}_device() and device_group() significantly
> differently. By the time we get up to {attach,remove}_dev() it might be
> clean enough to dynamically handle both cases in the same code,
> especially with a little general refactor of the ARM_SMMU_CB*
> arithmetic, and once we get to operating on arm_smmu_domains there
> should be no real difference.

fair enough.. I'll give this approach a try.

I guess at the end of the day, the code sharing might just amount to
arm_smmu_init_context_bank_ctx() (ie. half of what was
arm_smmu_init_context_bank()).  Possibly just splitting out a header
w/ the register offset #defines is the extent of the code sharing that
would make sense.

>> Also, this only works for non-secure contexts.  For secure contexts,
>> even things like map/unmap need to go via scm, so that bypasses
>> even more of arm-smmu.  I'm not sure if it is better to have all of
>> those special paths added to arm-smmu.  Or have a 2nd iommu driver
>> for the secure contexts.  (I think the second path only works since
>> I don't think the CPU is really touching the hw at all for secure
>> contexts.)
>>
>> Not in lieu of bindings docs (which will come before this is more
>> than just an RFC), but here is an example of what the DT bindings
>> look like:
>>
>>       gpu_iommu: qcom,iommu@1f00000 {
>>               compatible = "qcom,smmu-v2";
>>               reg = <0x1f00000 0x10000>;
>>
>>               #global-interrupts = <1>;
>>               interrupts =
>>                       <GIC_SPI 43 0>,        // global
>>                       <GIC_SPI 241 0>,       // unk0
>>                       <GIC_SPI 241 0>,       // gfx3d_user
>>                       <GIC_SPI 242 0>;       // gfx3d_priv
>>
>>               qcom,stream-to-cb = <
>>                       0x0002       // unk0
>>                       0x0000       // gfx3d_user
>>                       0x0001       // gfx3d_priv
>>               >;
>>
>>               #iommu-cells = <1>;
>>
>>               clocks = <&gcc GCC_SMMU_CFG_CLK>,
>>                        <&gcc GCC_GFX_TCU_CLK>;
>>               clock-names = "smmu_iface_clk", "smmu_bus_clk";
>>
>>               qcom,cb-count = <3>;
>>               qcom,iommu-secure-id = <18>;
>>               qcom,mapping-groups-count = <3>;
>>
>>               status = "okay";
>>       };
>>
>> Since we must live with the assignment of stream-id's to context bank
>> mapping that the secure world has set up for us, the "qcom,stream-to-cb"
>> binding gives a mapping table of sid to cb.  (Indexed by cb, value is
>> the sid.)  I'm not 100% sure what to do about devices with multiple
>> sid's..  if I understand how things work properly, we could probably
>> make the values in this table the result of OR'ing all the sids
>> together.
>>
>> The "qcom,cb-count" and "qcom,mapping-groups-count" can go away and
>> be computed from "qcom,stream-to-cb".  I just haven't done that yet.
>> The "qcom,iommu-secure-id" field is needed for the one scm call needed
>> for non-secure contexts for initial configuration.
>>
>> Anyways, at this point, I'm mostly just looking for feedback about
>> whether this is the best way forward, vs introducing a seperate iommu
>> driver, and any suggestions anyone might have.  And any ideas about how
>> to best handle the secure context banks, since I think we have no
>> choice but to use them for venus (the video enc/dec block).
>
> I'd say the answer to how we handle secure contexts is "we don't".
> Disregarding the apparent craziness of why the non-secure world would be
> allowed direct control of an entirely secure device, at that point it's
> not really an ARM SMMU any more, it's just *some*
> firmware-paravirtualised IOMMU. If you can't touch the hardware, who
> knows what's actually under there; "qcom-scm-iommu" is welcome to its
> own driver.

Well, at least splitting things into a per-ctx-bank device makes it
easier to have a different driver for secure cb's.

(It would be nice if there was a way to just take the secure cb's out
of secure mode and then treat them the same as non-secure cb's.. at
the end of the day, I just want to watch big buck bunny..)

BR,
-R

> Robin.
>
>> Signed-off-by: Rob Clark <robdclark@gmail.com>
>> ---
>>  drivers/iommu/arm-smmu.c | 233 +++++++++++++++++++++++++++++++++++++++++++----
>>  1 file changed, 217 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index 938417e..7b7d05f 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -52,6 +52,9 @@
>>  #include <linux/slab.h>
>>  #include <linux/spinlock.h>
>>
>> +#include <linux/qcom_scm.h>
>> +
>>  #include <linux/amba/bus.h>
>>
>>  #include "io-pgtable.h"
>> @@ -309,6 +312,7 @@ enum arm_smmu_implementation {
>>       GENERIC_SMMU,
>>       ARM_MMU500,
>>       CAVIUM_SMMUV2,
>> +     QCOM_SMMUV2,
>>  };
>>
>>  struct arm_smmu_s2cr {
>> @@ -380,6 +384,11 @@ struct arm_smmu_device {
>>       struct arm_smmu_s2cr            *s2crs;
>>       struct mutex                    stream_map_mutex;
>>
>> +     void __iomem                    *local_base; /* specific to qcom */
>> +     u32                             *stream_map; /* specific to qcom */
>> +     u32                             sec_id;      /* specific to qcom */
>> +     DECLARE_BITMAP(context_init, ARM_SMMU_MAX_CBS); /* specific to qcom */
>> +
>>       unsigned long                   va_size;
>>       unsigned long                   ipa_size;
>>       unsigned long                   pa_size;
>> @@ -599,6 +608,9 @@ static void __arm_smmu_tlb_sync(struct arm_smmu_device *smmu)
>>       int count = 0;
>>       void __iomem *gr0_base = ARM_SMMU_GR0(smmu);
>>
>> +     if (smmu->model == QCOM_SMMUV2)
>> +             return;
>> +
>>       writel_relaxed(0, gr0_base + ARM_SMMU_GR0_sTLBGSYNC);
>>       while (readl_relaxed(gr0_base + ARM_SMMU_GR0_sTLBGSTATUS)
>>              & sTLBGSTATUS_GSACTIVE) {
>> @@ -739,19 +751,17 @@ static irqreturn_t arm_smmu_global_fault(int irq, void *dev)
>>       return IRQ_HANDLED;
>>  }
>>
>> -static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
>> -                                    struct io_pgtable_cfg *pgtbl_cfg)
>> +static void arm_smmu_init_context_bank_global(struct arm_smmu_domain *smmu_domain,
>> +                                           struct io_pgtable_cfg *pgtbl_cfg)
>>  {
>> -     u32 reg, reg2;
>> -     u64 reg64;
>> +     u32 reg;
>>       bool stage1;
>>       struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
>>       struct arm_smmu_device *smmu = smmu_domain->smmu;
>> -     void __iomem *cb_base, *gr1_base;
>> +     void __iomem *gr1_base;
>>
>>       gr1_base = ARM_SMMU_GR1(smmu);
>>       stage1 = cfg->cbar != CBAR_TYPE_S2_TRANS;
>> -     cb_base = ARM_SMMU_CB_BASE(smmu) + ARM_SMMU_CB(smmu, cfg->cbndx);
>>
>>       if (smmu->version > ARM_SMMU_V1) {
>>               if (cfg->fmt == ARM_SMMU_CTX_FMT_AARCH64)
>> @@ -782,6 +792,20 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
>>               reg |= ARM_SMMU_CB_VMID(smmu, cfg) << CBAR_VMID_SHIFT;
>>       }
>>       writel_relaxed(reg, gr1_base + ARM_SMMU_GR1_CBAR(cfg->cbndx));
>> +}
>> +
>> +static void arm_smmu_init_context_bank_ctx(struct arm_smmu_domain *smmu_domain,
>> +                                        struct io_pgtable_cfg *pgtbl_cfg)
>> +{
>> +     u32 reg, reg2;
>> +     u64 reg64;
>> +     bool stage1;
>> +     struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
>> +     struct arm_smmu_device *smmu = smmu_domain->smmu;
>> +     void __iomem *cb_base;
>> +
>> +     stage1 = cfg->cbar != CBAR_TYPE_S2_TRANS;
>> +     cb_base = ARM_SMMU_CB_BASE(smmu) + ARM_SMMU_CB(smmu, cfg->cbndx);
>>
>>       /* TTBRs */
>>       if (stage1) {
>> @@ -848,8 +872,41 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
>>       writel_relaxed(reg, cb_base + ARM_SMMU_CB_SCTLR);
>>  }
>>
>> +static int qcom_smmu_find_context_bank(struct arm_smmu_device *smmu,
>> +                                    struct iommu_fwspec *fwspec)
>> +{
>> +     int i;
>> +
>> +     /* TODO how to handle devices w/ multiple stream-ids?  I think
>> +      * things are arranged such that I can OR all the sids together
>> +      * and match that to an entry in stream-map??
>> +      */
>> +     u32 sid = fwspec->ids[0];
>> +
>> +     for (i = 0; i < smmu->num_context_banks; i++)
>> +             if (smmu->stream_map[i] == sid)
>> +                     return i;
>> +
>> +     dev_err(smmu->dev, "Failed to find qcom,stream-to-cb entry for 0x%0x\n", sid);
>> +
>> +     return -ENXIO;
>> +}
>> +
>> +static int qcom_smmu_sec_program_iommu(struct arm_smmu_device *smmu,
>> +                                    struct arm_smmu_domain *smmu_domain)
>> +{
>> +     if (smmu->local_base) {
>> +#define SMMU_INTR_SEL_NS     (0x2000)
>> +             writel_relaxed(0xffffffff, smmu->local_base + SMMU_INTR_SEL_NS);
>> +             mb();
>> +     }
>> +
>> +     return qcom_scm_restore_sec_cfg(smmu->sec_id, smmu_domain->cfg.cbndx);
>> +}
>> +
>>  static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>> -                                     struct arm_smmu_device *smmu)
>> +                                     struct arm_smmu_device *smmu,
>> +                                     struct iommu_fwspec *fwspec)
>>  {
>>       int irq, start, ret = 0;
>>       unsigned long ias, oas;
>> @@ -953,12 +1010,22 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>>               goto out_unlock;
>>       }
>>
>> -     ret = __arm_smmu_alloc_bitmap(smmu->context_map, start,
>> -                                   smmu->num_context_banks);
>> -     if (ret < 0)
>> -             goto out_unlock;
>> +     if (smmu->model == QCOM_SMMUV2) {
>> +             /* need to use sid->cb mapping that is already set up: */
>> +             ret = qcom_smmu_find_context_bank(smmu, fwspec);
>> +             if (ret < 0)
>> +                     goto out_unlock;
>> +
>> +             cfg->cbndx = ret;
>> +     } else {
>> +             ret = __arm_smmu_alloc_bitmap(smmu->context_map, start,
>> +                             smmu->num_context_banks);
>> +             if (ret < 0)
>> +                     goto out_unlock;
>> +             cfg->cbndx = ret;
>> +     }
>> +
>>
>> -     cfg->cbndx = ret;
>>       if (smmu->version < ARM_SMMU_V2) {
>>               cfg->irptndx = atomic_inc_return(&smmu->irptndx);
>>               cfg->irptndx %= smmu->num_context_irqs;
>> @@ -986,8 +1053,23 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>>       domain->geometry.aperture_end = (1UL << ias) - 1;
>>       domain->geometry.force_aperture = true;
>>
>> -     /* Initialise the context bank with our page table cfg */
>> -     arm_smmu_init_context_bank(smmu_domain, &pgtbl_cfg);
>> +     if (smmu->model == QCOM_SMMUV2) {
>> +             /* initializing the hw must happen only on first attach..
>> +              * which we otherwise run afoul of since a _DMA domain
>> +              * is automatically attached before drm/msm overrides
>> +              * and attaches it's own domain.
>> +              */
>> +             if (!test_and_set_bit(cfg->cbndx, smmu->context_init)) {
>> +                     ret = qcom_smmu_sec_program_iommu(smmu, smmu_domain);
>> +                     if (ret)
>> +                             goto out_unlock;
>> +             }
>> +     } else {
>> +             /* Initialise the context bank with our page table cfg */
>> +             arm_smmu_init_context_bank_global(smmu_domain, &pgtbl_cfg);
>> +     }
>> +
>> +     arm_smmu_init_context_bank_ctx(smmu_domain, &pgtbl_cfg);
>>
>>       /*
>>        * Request context fault interrupt. Do this last to avoid the
>> @@ -1107,6 +1189,8 @@ static void arm_smmu_write_s2cr(struct arm_smmu_device *smmu, int idx)
>>
>>  static void arm_smmu_write_sme(struct arm_smmu_device *smmu, int idx)
>>  {
>> +     if (smmu->model == QCOM_SMMUV2)
>> +             return;
>>       arm_smmu_write_s2cr(smmu, idx);
>>       if (smmu->smrs)
>>               arm_smmu_write_smr(smmu, idx);
>> @@ -1288,6 +1372,10 @@ static int arm_smmu_domain_add_master(struct arm_smmu_domain *smmu_domain,
>>               s2cr[idx].type = type;
>>               s2cr[idx].privcfg = S2CR_PRIVCFG_DEFAULT;
>>               s2cr[idx].cbndx = cbndx;
>> +
>> +             if (smmu->model == QCOM_SMMUV2)
>> +                     continue;
>> +
>>               arm_smmu_write_s2cr(smmu, idx);
>>       }
>>       return 0;
>> @@ -1317,7 +1405,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>>
>>       smmu = fwspec_smmu(fwspec);
>>       /* Ensure that the domain is finalised */
>> -     ret = arm_smmu_init_domain_context(domain, smmu);
>> +     ret = arm_smmu_init_domain_context(domain, smmu, fwspec);
>>       if (ret < 0)
>>               return ret;
>>
>> @@ -1682,6 +1770,9 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
>>       int i;
>>       u32 reg, major;
>>
>> +     if (smmu->model == QCOM_SMMUV2)
>> +             return;
>> +
>>       /* clear global FSR */
>>       reg = readl_relaxed(ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sGFSR);
>>       writel(reg, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sGFSR);
>> @@ -1764,6 +1855,103 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
>>       writel(reg, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
>>  }
>>
>> +/* for devices with qcom,smmu-v2, we cannot touch the global space,
>> + * so get all the configuration from devicetree.
>> + */
>> +static int qcom_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
>> +{
>> +     struct device_node *np = smmu->dev->of_node;
>> +     u32 size, cb_offset, i;
>> +     int ret;
>> +
>> +     if (of_property_read_u32(np, "qcom,cb-count", &smmu->num_context_banks)) {
>> +             dev_err(smmu->dev, "missing qcom,cb-count property\n");
>> +             return -ENODEV;
>> +     }
>> +
>> +     dev_notice(smmu->dev, "\t%u context banks\n", smmu->num_context_banks);
>> +
>> +     // TODO get from dt?
>> +     smmu->pgsize_bitmap = SZ_4K;
>> +
>> +     dev_notice(smmu->dev, "\tSupported page sizes: 0x%08lx\n",
>> +                smmu->pgsize_bitmap);
>> +
>> +     if (of_property_read_u32(np, "qcom,mapping-groups-count", &size)) {
>> +             dev_err(smmu->dev, "missing qcom,cb-count property\n");
>> +             return -ENODEV;
>> +     }
>> +
>> +     if (of_property_read_u32(np, "qcom,cb-base-offset", &cb_offset))
>> +             cb_offset = 0x8000;
>> +
>> +     if (of_property_read_u32(np, "qcom,iommu-secure-id", &smmu->sec_id)) {
>> +             dev_err(smmu->dev, "missing qcom,iommu-secure-id property\n");
>> +             return -ENODEV;
>> +     }
>> +
>> +     /*
>> +      * Bit of a hack perhaps.. ARM_SMMU_CB_BASE() assumes that cb0 starts
>> +      * half way through the IO region size.. not sure that is really true.
>> +      */
>> +     smmu->size = cb_offset << 1;
>> +     smmu->pgshift = 12;
>> +
>> +     smmu->stream_map = devm_kmalloc_array(smmu->dev, smmu->num_context_banks,
>> +                                           sizeof(*smmu->stream_map),
>> +                                           GFP_KERNEL);
>> +     if (!smmu->stream_map)
>> +             return -ENOMEM;
>> +
>> +     for (i = 0; i < smmu->num_context_banks; i++) {
>> +             ret = of_property_read_u32_index(np, "qcom,stream-to-cb", i,
>> +                                              &smmu->stream_map[i]);
>> +             if (ret) {
>> +                     dev_err(smmu->dev, "could not read qcom,stream-to-cb idx %d\n", i);
>> +                     return ret;
>> +             }
>> +     }
>> +
>> +     /*
>> +      * The hardware does actually support stream-matching, but we cannot
>> +      * touch the global space, so we have to live with how secure world
>> +      * has set things up for us.  So don't set ARM_SMMU_FEAT_STREAM_MATCH
>> +      * and leave smmu->smrs as NULL.  We just need to arrange that each
>> +      * domain gets mapped to the correct context in s2crs.
>> +      */
>> +
>> +     smmu->s2crs = devm_kmalloc_array(smmu->dev, size, sizeof(*smmu->s2crs),
>> +                                      GFP_KERNEL);
>> +     if (!smmu->s2crs)
>> +             return -ENOMEM;
>> +
>> +     for (i = 0; i < size; i++)
>> +             smmu->s2crs[i] = s2cr_init_val;
>> +
>> +     smmu->num_mapping_groups = size;
>> +
>> +     // *shrug*?
>> +     smmu->streamid_mask = ~0;
>> +     smmu->smr_mask_mask = ~0;
>> +     smmu->features = ARM_SMMU_FEAT_TRANS_S1 | ARM_SMMU_FEAT_FMT_AARCH32_L;
>> +
>> +     /* TODO we might need to be able to use this on some 32b devices? */
>> +     smmu->va_size  = 48;
>> +     smmu->ipa_size = 48;
>> +     smmu->pa_size  = 48;
>> +
>> +     // XXX deduplicate from arm_smmu_device_cfg_probe()
>> +     if (smmu->features &
>> +         (ARM_SMMU_FEAT_FMT_AARCH32_L | ARM_SMMU_FEAT_FMT_AARCH64_4K))
>> +             smmu->pgsize_bitmap |= SZ_4K | SZ_2M | SZ_1G;
>> +     if (smmu->features & ARM_SMMU_FEAT_FMT_AARCH64_16K)
>> +             smmu->pgsize_bitmap |= SZ_16K | SZ_32M;
>> +     if (smmu->features & ARM_SMMU_FEAT_FMT_AARCH64_64K)
>> +             smmu->pgsize_bitmap |= SZ_64K | SZ_512M;
>> +
>> +     return 0;
>> +}
>> +
>>  static int arm_smmu_id_size_to_bits(int size)
>>  {
>>       switch (size) {
>> @@ -1833,6 +2021,11 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
>>       dev_notice(smmu->dev, "SMMUv%d with:\n",
>>                       smmu->version == ARM_SMMU_V2 ? 2 : 1);
>>
>> +     mutex_init(&smmu->stream_map_mutex);
>> +
>> +     if (smmu->model == QCOM_SMMUV2)
>> +             return qcom_smmu_device_cfg_probe(smmu);
>> +
>>       /* ID0 */
>>       id = readl_relaxed(gr0_base + ARM_SMMU_GR0_ID0);
>>
>> @@ -1918,7 +2111,6 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
>>               smmu->s2crs[i] = s2cr_init_val;
>>
>>       smmu->num_mapping_groups = size;
>> -     mutex_init(&smmu->stream_map_mutex);
>>
>>       if (smmu->version < ARM_SMMU_V2 || !(id & ID0_PTFS_NO_AARCH32)) {
>>               smmu->features |= ARM_SMMU_FEAT_FMT_AARCH32_L;
>> @@ -2034,6 +2226,7 @@ static struct arm_smmu_match_data name = { .version = ver, .model = imp }
>>
>>  ARM_SMMU_MATCH_DATA(smmu_generic_v1, ARM_SMMU_V1, GENERIC_SMMU);
>>  ARM_SMMU_MATCH_DATA(smmu_generic_v2, ARM_SMMU_V2, GENERIC_SMMU);
>> +ARM_SMMU_MATCH_DATA(qcom_smmuv2, ARM_SMMU_V2, QCOM_SMMUV2);
>>  ARM_SMMU_MATCH_DATA(arm_mmu401, ARM_SMMU_V1_64K, GENERIC_SMMU);
>>  ARM_SMMU_MATCH_DATA(arm_mmu500, ARM_SMMU_V2, ARM_MMU500);
>>  ARM_SMMU_MATCH_DATA(cavium_smmuv2, ARM_SMMU_V2, CAVIUM_SMMUV2);
>> @@ -2041,6 +2234,7 @@ ARM_SMMU_MATCH_DATA(cavium_smmuv2, ARM_SMMU_V2, CAVIUM_SMMUV2);
>>  static const struct of_device_id arm_smmu_of_match[] = {
>>       { .compatible = "arm,smmu-v1", .data = &smmu_generic_v1 },
>>       { .compatible = "arm,smmu-v2", .data = &smmu_generic_v2 },
>> +     { .compatible = "qcom,smmu-v2", .data = &qcom_smmuv2 },
>>       { .compatible = "arm,mmu-400", .data = &smmu_generic_v1 },
>>       { .compatible = "arm,mmu-401", .data = &arm_mmu401 },
>>       { .compatible = "arm,mmu-500", .data = &arm_mmu500 },
>> @@ -2172,6 +2366,13 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>>               return PTR_ERR(smmu->base);
>>       smmu->size = resource_size(res);
>>
>> +     if (smmu->model == QCOM_SMMUV2) {
>> +             res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
>> +                                                "smmu_local_base");
>> +             if (res)
>> +                     smmu->local_base = devm_ioremap_resource(dev, res);
>> +     }
>> +
>>       num_irqs = 0;
>>       while ((res = platform_get_resource(pdev, IORESOURCE_IRQ, num_irqs))) {
>>               num_irqs++;
>>
>
