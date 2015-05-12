From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 2/3] iommu/arm-smmu: Add initial driver support for ARM
	SMMUv3 devices
Date: Tue, 12 May 2015 17:55:00 +0100
Message-ID: <20150512165500.GE2062@arm.com>
References: <1431108046-9675-1-git-send-email-will.deacon@arm.com>
	<1431108046-9675-3-git-send-email-will.deacon@arm.com>
	<5551AE56.6050906@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5551AE56.6050906-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: leizhen <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Cc: "huxinwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <huxinwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Sanil kumar <sanil.kumar-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, Gaojianbo <gaojianbo-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, Dingtianhong <dingtianhong-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Leizhen,

Thanks for the review!

On Tue, May 12, 2015 at 08:40:06AM +0100, leizhen wrote:
> 
> > +
> > +static int queue_poll_cons(struct arm_smmu_queue *q, u32 until, bool wfe)
> > +{
> > +     ktime_t timeout = ktime_add_us(ktime_get(), ARM_SMMU_POLL_TIMEOUT_US);
> > +
> > +     while (queue_sync_cons(q), __queue_cons_before(q, until)) {
> > +             if (ktime_compare(ktime_get(), timeout) > 0)
> 
> Is it good to limit hardware behavior? May be wait for ever will be
> better. If SMMU can not consume queue items under normal condition, the
> SMMU hardware is broken, will lead software system to be crashed later.

I disagree. Having a broken SMMU lock-up the entire kernel is considerably
worse than having e.g. a DMA master get stuck. If this timeout expires,
then we'll print a message and continue without waiting any longer for
a CMD_SYNC completion (see arm_smmu_cmdq_issue_cmd).

> > +                     return -ETIMEDOUT;
> > +
> > +             if (wfe) {
> > +                     wfe();
> > +             } else {
> > +                     cpu_relax();
> > +                     udelay(1);
> > +             }
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static void queue_write(__le64 *dst, u64 *src, size_t n_dwords)
> > +{
> > +     int i;
> > +
> > +     for (i = 0; i < n_dwords; ++i)
> > +             *dst++ = cpu_to_le64(*src++);
> > +}
> > +
> > +static int queue_insert_raw(struct arm_smmu_queue *q, u64 *ent)
> > +{
> > +     if (queue_full(q))
> > +             return -ENOSPC;
> > +
> > +     queue_write(Q_ENT(q, q->prod), ent, q->ent_dwords);
> 
> A dmb or dsb maybe needed. We must insure all data written are completed,
> then notify hardware to consume.

The dsb is performed when we update the producer pointer in queue_inc_prod
(since we use writel as opposed to writel_relaxed).

> > +     queue_inc_prod(q);
> > +     return 0;
> > +}
> > +
> > +
> > +/* High-level queue accessors */
> > +static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
> > +{
> > +     memset(cmd, 0, CMDQ_ENT_DWORDS << 3);
> > +     cmd[0] |= (ent->opcode & CMDQ_0_OP_MASK) << CMDQ_0_OP_SHIFT;
> > +
> > +     switch (ent->opcode) {
> > +     case CMDQ_OP_TLBI_EL2_ALL:
> 
> > +     case CMDQ_OP_CMD_SYNC:
> > +             cmd[0] |= CMDQ_SYNC_0_CS_SEV;
> 
> We can not always set SIG_SEV, actually it should base upon
> SMMU_IDR0.SEV(smmu->features & ARM_SMMU_FEAT_SEV)

It doesn't matter for the CMD_SYNC command (which treats SIG_SEV as
SIG_NONE in this case). What actually matters is that we don't perform
wfe() when the SMMU can't issue the event, but that's already taken care
of in arm_smmu_cmdq_issue_cmd.

> > +             break;
> > +     default:
> > +             return -ENOENT;
> > +     }
> > +
> > +     return 0;
> > +}
> 
> > +
> > +static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
> > +                                    struct io_pgtable_cfg *pgtbl_cfg)
> > +{
> > +     int ret;
> > +     u16 asid;
> > +     struct arm_smmu_device *smmu = smmu_domain->smmu;
> > +     struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
> > +
> > +     asid = arm_smmu_bitmap_alloc(smmu->asid_map, smmu->asid_bits);
> > +     if (IS_ERR_VALUE(asid))
> > +             return asid;
> > +
> > +     cfg->cdptr = dma_zalloc_coherent(smmu->dev, CTXDESC_CD_DWORDS << 3,
> > +                                      &cfg->cdptr_dma, GFP_KERNEL);
> 
> Why use dma_zalloc_coherent? iova is coverted from PA by calling
> phys_to_dma. I afraid PA and iova maybe not equal. In fact, the mapping
> between iova and PA is rely on SMMU driver itself. Why not use
> virt_to_phys to get PA, SMMU hardware actually require PA.

The SMMU structure walker is not allowed to be chained into another SMMU,
so the physical and DMA addresses are equal here. That said, the walker
does not need to be cache coherent, so I need to use the coherent DMA
allocator to get memory of the correct attributes. I also need the table
to be naturally aligned.

An alternative would be something like __get_free_pages with homebrew
cache maintenance for non-coherent SMMUs, but I don't want to re-invent
the DMA mapping code in the driver (we already have a similar mess with
the page tables, which I'd like to sort out).

> > +static int arm_smmu_alloc_l2_strtab(struct arm_smmu_device *smmu)
> > +{
> > +     int ret;
> > +     unsigned int i;
> > +     struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
> > +     size_t size = sizeof(*cfg->l1_desc) * cfg->num_l1_descs;
> > +     void *strtab = smmu->strtab_cfg.strtab;
> > +
> > +     cfg->l1_desc = devm_kzalloc(smmu->dev, size, GFP_KERNEL);
> > +     if (!cfg->l1_desc) {
> > +             dev_err(smmu->dev, "failed to allocate l1 stream table desc\n");
> > +             return -ENOMEM;
> > +     }
> > +
> > +     size = 1 << (STRTAB_SPLIT + ilog2(STRTAB_STE_DWORDS) + 3);
> > +     for (i = 0; i < cfg->num_l1_descs; ++i) {
> > +             struct arm_smmu_strtab_l1_desc *desc = &cfg->l1_desc[i];
> > +
> > +             desc->span = STRTAB_SPLIT + 1;
> > +             desc->l2ptr = dma_zalloc_coherent(smmu->dev, size,
> > +                                               &desc->l2ptr_dma, GFP_KERNEL);
> 
> No, no, please don't allocate all Lv2 table memory, we should dynamic
> allocation when needed.  Otherwise we can not save memory relative to one
> level table. And cfg->l1_desc seems not necessary.  Before create mapping
> for a specified StreamID, we read corresponding Lv1 table entry, if L2Ptr
> is NULL, then we build Lv2 table. Otherwise, means this Lv2 table have
> already been built, because a Lv2 table is shared by a group of StreamIDs.

The purpose of the two level approach isn't to save memory; it's to remove
the need for a single (large) contiguous block. Furthermore, we need all
master devices in the system to come up in a state where their transactions
bypass the SMMU (i.e. we don't require them to use the SMMU for
translation). Achieving this necessitates a fully-populated stream-table
before any DMA occurs.

I suppose we could look into populating it based on the ->add_device
callback, which currently does have some range checks
(arm_smmu_sid_in_range). Is that what you had in mind?

> > +             if (!desc->l2ptr) {
> > +                     dev_err(smmu->dev,
> > +                             "failed to allocate l2 stream table %u\n", i);
> > +                     ret = -ENOMEM;
> > +                     goto out_free_l2;
> > +             }
> > +
> > +             arm_smmu_init_bypass_stes(desc->l2ptr, 1 << STRTAB_SPLIT);
> > +             arm_smmu_write_strtab_l1_desc(strtab, desc);
> > +             strtab += STRTAB_STE_DWORDS;
> > +     }
> > +
> > +     return 0;
> > +
> > +out_free_l2:
> > +     arm_smmu_free_l2_strtab(smmu);
> > +     return ret;
> > +}
> > +
> > +static int arm_smmu_init_strtab(struct arm_smmu_device *smmu)
> > +{
> > +     void *strtab;
> > +     u64 reg;
> > +     u32 size;
> > +     int ret = 0;
> > +
> > +     strtab = dma_zalloc_coherent(smmu->dev, 1 << STRTAB_L1_SZ_SHIFT,
> > +                                  &smmu->strtab_cfg.strtab_dma, GFP_KERNEL);
> 
> As above, when Lv2 tables are dynamic allocation, we can create Lv1 table
> base on SMMU_IDR1.SIDSIZE and support non-pic devices. Oh, if SIDSIZE is
> too large, like 32. Maybe we should use 64K size Lv2 table.  But we can
> only use PAGE_SIZE first, for lazy.

Right now, the l2 tables are 4k and l1 table is 8k. That's (a) nice for
allocation on a system with 4k pages and (b) enough to cover a PCI host
controller. The problem with supporting 32-bit SIDs is that the l1 will
become a sizeable contiguous chunk which we'll have to allocate
regardless.

So, if we keep the l2 size at 4k for the moment, how big would you like
the l1? For a 32-bit numberspace, it would be 4MB, which I don't think is
practical.

> > +     if (!strtab) {
> > +             dev_err(smmu->dev, "failed to allocate l1 stream table\n");
> > +             return -ENOMEM;
> > +     }
> > +     smmu->strtab_cfg.strtab = strtab;
> > +
> > +     reg  = smmu->strtab_cfg.strtab_dma &
> > +            STRTAB_BASE_ADDR_MASK << STRTAB_BASE_ADDR_SHIFT;
> > +     reg |= STRTAB_BASE_RA;
> > +     smmu->strtab_cfg.strtab_base = reg;
> > +
> > +     if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) {
> > +             size = STRTAB_L1_SZ_SHIFT - (ilog2(STRTAB_L1_DESC_DWORDS) + 3);
> > +             smmu->strtab_cfg.num_l1_descs = 1 << size;
> > +             size += STRTAB_SPLIT;
> > +             reg = STRTAB_BASE_CFG_FMT_2LVL;
> > +
> > +             ret = arm_smmu_alloc_l2_strtab(smmu);
> > +             if (ret)
> > +                     goto out_free_l1;
> > +     } else {
> > +             size = STRTAB_L1_SZ_SHIFT - (ilog2(STRTAB_STE_DWORDS) + 3);
> > +             smmu->strtab_cfg.num_l1_descs = 0;
> > +             reg = STRTAB_BASE_CFG_FMT_LINEAR;
> > +             arm_smmu_init_bypass_stes(strtab, 1 << size);
> > +     }
> > +
> > +     if (size < smmu->sid_bits)
> > +             dev_warn(smmu->dev, "%s strtab only covers %u/%u bits of SID\n",
> > +                      smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB ?
> > +                      "2-level" : "linear",
> > +                      size, smmu->sid_bits);
> > +
> > +     reg |= (size & STRTAB_BASE_CFG_LOG2SIZE_MASK)
> > +             << STRTAB_BASE_CFG_LOG2SIZE_SHIFT;
> > +     reg |= (STRTAB_SPLIT & STRTAB_BASE_CFG_SPLIT_MASK)
> > +             << STRTAB_BASE_CFG_SPLIT_SHIFT;
> > +     smmu->strtab_cfg.strtab_base_cfg = reg;
> > +
> > +     /* Allocate the first VMID for stage-2 bypass STEs */
> > +     set_bit(0, smmu->vmid_map);
> > +     return 0;
> > +
> > +out_free_l1:
> > +     dma_free_coherent(smmu->dev, 1 << STRTAB_L1_SZ_SHIFT, strtab,
> > +                       smmu->strtab_cfg.strtab_dma);
> > +     return ret;
> > +}
> > +
> > +static void arm_smmu_free_strtab(struct arm_smmu_device *smmu)
> > +{
> > +     struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
> > +
> > +     arm_smmu_free_l2_strtab(smmu);
> > +     dma_free_coherent(smmu->dev, 1 << STRTAB_L1_SZ_SHIFT, cfg->strtab,
> > +                       cfg->strtab_dma);
> > +}
> > +
> 
> > +
> > +static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
> > +{
> > +     int ret;
> > +     u32 reg, enables;
> > +     struct arm_smmu_cmdq_ent cmd;
> > +
> > +     /* Clear CR0 and sync (disables SMMU and queue processing) */
> > +     reg = readl_relaxed(smmu->base + ARM_SMMU_CR0);
> > +     if (reg & CR0_SMMUEN)
> > +             dev_warn(smmu->dev, "SMMU currently enabled! Resetting...\n");
> > +
> > +     ret = arm_smmu_device_disable(smmu);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /* CR1 (table and queue memory attributes) */
> > +     reg = (CR1_SH_ISH << CR1_TABLE_SH_SHIFT) |
> > +           (CR1_CACHE_WB << CR1_TABLE_OC_SHIFT) |
> > +           (CR1_CACHE_WB << CR1_TABLE_IC_SHIFT) |
> > +           (CR1_SH_ISH << CR1_QUEUE_SH_SHIFT) |
> > +           (CR1_CACHE_WB << CR1_QUEUE_OC_SHIFT) |
> > +           (CR1_CACHE_WB << CR1_QUEUE_IC_SHIFT);
> > +     writel_relaxed(reg, smmu->base + ARM_SMMU_CR1);
> > +
> > +     /* CR2 (random crap) */
> > +     reg = CR2_PTM | CR2_RECINVMID | CR2_E2H;
> 
> Do we need to explicitly set CR2_E2H? Linux only run at EL1.

Setting E2H won't cause any harm and I'd expect Linux to run there in the
future. If we ever decide to share CPU page tables with the SMMU, then we'll
need this set to participate in DVM.

> > +     writel_relaxed(reg, smmu->base + ARM_SMMU_CR2);
> > +
> > +     /* Stream table */
> > +     writeq_relaxed(smmu->strtab_cfg.strtab_base,
> > +                    smmu->base + ARM_SMMU_STRTAB_BASE);
> > +     writel_relaxed(smmu->strtab_cfg.strtab_base_cfg,
> > +                    smmu->base + ARM_SMMU_STRTAB_BASE_CFG);
> > +
> > +     /* Command queue */
> > +     writeq_relaxed(smmu->cmdq.q.q_base, smmu->base + ARM_SMMU_CMDQ_BASE);
> > +     writel_relaxed(smmu->cmdq.q.prod, smmu->base + ARM_SMMU_CMDQ_PROD);
> > +     writel_relaxed(smmu->cmdq.q.cons, smmu->base + ARM_SMMU_CMDQ_CONS);
> > +
> > +     enables = CR0_CMDQEN;
> > +     ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
> > +                                   ARM_SMMU_CR0ACK);
> > +     if (ret) {
> > +             dev_err(smmu->dev, "failed to enable command queue\n");
> > +             return ret;
> > +     }
> > +
> > +     /* Invalidate any cached configuration */
> > +     cmd.opcode = CMDQ_OP_CFGI_ALL;
> > +     arm_smmu_cmdq_issue_cmd(smmu, &cmd);
> > +     cmd.opcode = CMDQ_OP_CMD_SYNC;
> > +     arm_smmu_cmdq_issue_cmd(smmu, &cmd);
> > +
> > +     /* Invalidate any stale TLB entries */
> > +     cmd.opcode = CMDQ_OP_TLBI_EL2_ALL;
> 
> Do we need to execute CMDQ_OP_TLBI_EL2_ALL? Linux only run at EL1. It at
> least rely on SMMU_IDR0.Hyp

The SMMU isn't guaranteed to come up clean out of reset, so it's a good
idea to perform this invalidation in case of junk in the TLB. Given that
Linux owns the stage-2 translation, then this is the right place to do it.

Will
