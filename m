Return-Path: <SRS0=z06/=ZD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93E1C43331
	for <iommu@archiver.kernel.org>; Mon, 11 Nov 2019 15:12:37 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B52A1206A3
	for <iommu@archiver.kernel.org>; Mon, 11 Nov 2019 15:12:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B52A1206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 9D752CD9;
	Mon, 11 Nov 2019 15:12:37 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 15337C2A
	for <iommu@lists.linux-foundation.org>;
	Mon, 11 Nov 2019 15:12:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B0ED98AB
	for <iommu@lists.linux-foundation.org>;
	Mon, 11 Nov 2019 15:12:34 +0000 (UTC)
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
	by Forcepoint Email with ESMTP id 44C347F14D0C304C99D7;
	Mon, 11 Nov 2019 23:12:27 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS412-HUB.china.huawei.com
	(10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Mon, 11 Nov 2019
	23:12:19 +0800
Date: Mon, 11 Nov 2019 15:12:10 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v2 5/8] iommu/arm-smmu-v3: Add support for Substream IDs
Message-ID: <20191111151210.00000ec3@huawei.com>
In-Reply-To: <20191108152508.4039168-6-jean-philippe@linaro.org>
References: <20191108152508.4039168-1-jean-philippe@linaro.org>
	<20191108152508.4039168-6-jean-philippe@linaro.org>
Organization: Huawei
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, robin.murphy@arm.com,
	sudeep.holla@arm.com, rjw@rjwysocki.net,
	linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
	robh+dt@kernel.org, guohanjun@huawei.com,
	zhangfei.gao@linaro.org, will@kernel.org,
	linux-arm-kernel@lists.infradead.org, lenb@kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Development issues for Linux IOMMU support
	<iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Fri, 8 Nov 2019 16:25:05 +0100
Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:

> At the moment, the SMMUv3 driver implements only one stage-1 or stage-2
> page directory per device. However SMMUv3 allows more than one address
> space for some devices, by providing multiple stage-1 page directories. In
> addition to the Stream ID (SID), that identifies a device, we can now have
> Substream IDs (SSID) identifying an address space. In PCIe, SID is called
> Requester ID (RID) and SSID is called Process Address-Space ID (PASID).
> 
> Prepare the driver for SSID support, by adding context descriptor tables
> in STEs (previously a single static context descriptor). A complete
> stage-1 walk is now performed like this by the SMMU:
> 
>       Stream tables          Ctx. tables          Page tables
>         +--------+   ,------->+-------+   ,------->+-------+
>         :        :   |        :       :   |        :       :
>         +--------+   |        +-------+   |        +-------+
>    SID->|  STE   |---'  SSID->|  CD   |---'  IOVA->|  PTE  |--> IPA
>         +--------+            +-------+            +-------+
>         :        :            :       :            :       :
>         +--------+            +-------+            +-------+
> 
> Implement a single level of context descriptor table for now, but as with
> stream and page tables, an SSID can be split to index multiple levels of
> tables.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Looks good to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/iommu/arm-smmu-v3.c | 132 ++++++++++++++++++++++++++++++------
>  1 file changed, 111 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 122bed0168a3..df7d45503c65 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -227,6 +227,11 @@
>  #define STRTAB_STE_0_S1CTXPTR_MASK	GENMASK_ULL(51, 6)
>  #define STRTAB_STE_0_S1CDMAX		GENMASK_ULL(63, 59)
>  
> +#define STRTAB_STE_1_S1DSS		GENMASK_ULL(1, 0)
> +#define STRTAB_STE_1_S1DSS_TERMINATE	0x0
> +#define STRTAB_STE_1_S1DSS_BYPASS	0x1
> +#define STRTAB_STE_1_S1DSS_SSID0	0x2
> +
>  #define STRTAB_STE_1_S1C_CACHE_NC	0UL
>  #define STRTAB_STE_1_S1C_CACHE_WBRA	1UL
>  #define STRTAB_STE_1_S1C_CACHE_WT	2UL
> @@ -329,6 +334,7 @@
>  #define CMDQ_PREFETCH_1_SIZE		GENMASK_ULL(4, 0)
>  #define CMDQ_PREFETCH_1_ADDR_MASK	GENMASK_ULL(63, 12)
>  
> +#define CMDQ_CFGI_0_SSID		GENMASK_ULL(31, 12)
>  #define CMDQ_CFGI_0_SID			GENMASK_ULL(63, 32)
>  #define CMDQ_CFGI_1_LEAF		(1UL << 0)
>  #define CMDQ_CFGI_1_RANGE		GENMASK_ULL(4, 0)
> @@ -446,8 +452,11 @@ struct arm_smmu_cmdq_ent {
>  
>  		#define CMDQ_OP_CFGI_STE	0x3
>  		#define CMDQ_OP_CFGI_ALL	0x4
> +		#define CMDQ_OP_CFGI_CD		0x5
> +		#define CMDQ_OP_CFGI_CD_ALL	0x6
>  		struct {
>  			u32			sid;
> +			u32			ssid;
>  			union {
>  				bool		leaf;
>  				u8		span;
> @@ -566,6 +575,7 @@ struct arm_smmu_cd_table {
>  };
>  
>  struct arm_smmu_s1_cfg {
> +	u8				s1fmt;
>  	u8				s1cdmax;
>  	struct arm_smmu_cd_table	table;
>  	struct arm_smmu_ctx_desc	cd;
> @@ -860,10 +870,16 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
>  		cmd[1] |= FIELD_PREP(CMDQ_PREFETCH_1_SIZE, ent->prefetch.size);
>  		cmd[1] |= ent->prefetch.addr & CMDQ_PREFETCH_1_ADDR_MASK;
>  		break;
> +	case CMDQ_OP_CFGI_CD:
> +		cmd[0] |= FIELD_PREP(CMDQ_CFGI_0_SSID, ent->cfgi.ssid);
> +		/* Fallthrough */
>  	case CMDQ_OP_CFGI_STE:
>  		cmd[0] |= FIELD_PREP(CMDQ_CFGI_0_SID, ent->cfgi.sid);
>  		cmd[1] |= FIELD_PREP(CMDQ_CFGI_1_LEAF, ent->cfgi.leaf);
>  		break;
> +	case CMDQ_OP_CFGI_CD_ALL:
> +		cmd[0] |= FIELD_PREP(CMDQ_CFGI_0_SID, ent->cfgi.sid);
> +		break;
>  	case CMDQ_OP_CFGI_ALL:
>  		/* Cover the entire SID range */
>  		cmd[1] |= FIELD_PREP(CMDQ_CFGI_1_RANGE, 31);
> @@ -1456,6 +1472,33 @@ static int arm_smmu_cmdq_issue_sync(struct arm_smmu_device *smmu)
>  }
>  
>  /* Context descriptor manipulation functions */
> +static void arm_smmu_sync_cd(struct arm_smmu_domain *smmu_domain,
> +			     int ssid, bool leaf)
> +{
> +	size_t i;
> +	unsigned long flags;
> +	struct arm_smmu_master *master;
> +	struct arm_smmu_device *smmu = smmu_domain->smmu;
> +	struct arm_smmu_cmdq_ent cmd = {
> +		.opcode	= CMDQ_OP_CFGI_CD,
> +		.cfgi	= {
> +			.ssid	= ssid,
> +			.leaf	= leaf,
> +		},
> +	};
> +
> +	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
> +	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
> +		for (i = 0; i < master->num_sids; i++) {
> +			cmd.cfgi.sid = master->sids[i];
> +			arm_smmu_cmdq_issue_cmd(smmu, &cmd);
> +		}
> +	}
> +	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
> +
> +	arm_smmu_cmdq_issue_sync(smmu);
> +}
> +
>  static int arm_smmu_alloc_cd_leaf_table(struct arm_smmu_device *smmu,
>  					struct arm_smmu_cd_table *table,
>  					size_t num_entries)
> @@ -1481,6 +1524,11 @@ static void arm_smmu_free_cd_leaf_table(struct arm_smmu_device *smmu,
>  	dmam_free_coherent(smmu->dev, size, table->ptr, table->ptr_dma);
>  }
>  
> +static __le64 *arm_smmu_get_cd_ptr(struct arm_smmu_s1_cfg *cfg, u32 ssid)
> +{
> +	return cfg->table.ptr + ssid * CTXDESC_CD_DWORDS;
> +}
> +
>  static u64 arm_smmu_cpu_tcr_to_cd(u64 tcr)
>  {
>  	u64 val = 0;
> @@ -1498,34 +1546,68 @@ static u64 arm_smmu_cpu_tcr_to_cd(u64 tcr)
>  	return val;
>  }
>  
> -static void arm_smmu_write_ctx_desc(struct arm_smmu_device *smmu,
> -				    struct arm_smmu_s1_cfg *cfg)
> +static int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain,
> +				   int ssid, struct arm_smmu_ctx_desc *cd)
>  {
>  	u64 val;
> -	__le64 *cdptr = cfg->table.ptr;
> +	bool cd_live;
> +	struct arm_smmu_device *smmu = smmu_domain->smmu;
> +	__le64 *cdptr = arm_smmu_get_cd_ptr(&smmu_domain->s1_cfg, ssid);
>  
>  	/*
> -	 * We don't need to issue any invalidation here, as we'll invalidate
> -	 * the STE when installing the new entry anyway.
> +	 * This function handles the following cases:
> +	 *
> +	 * (1) Install primary CD, for normal DMA traffic (SSID = 0).
> +	 * (2) Install a secondary CD, for SID+SSID traffic.
> +	 * (3) Update ASID of a CD. Atomically write the first 64 bits of the
> +	 *     CD, then invalidate the old entry and mappings.
> +	 * (4) Remove a secondary CD.
>  	 */
> -	val = arm_smmu_cpu_tcr_to_cd(cfg->cd.tcr) |
> -#ifdef __BIG_ENDIAN
> -	      CTXDESC_CD_0_ENDI |
> -#endif
> -	      CTXDESC_CD_0_R | CTXDESC_CD_0_A | CTXDESC_CD_0_ASET |
> -	      CTXDESC_CD_0_AA64 | FIELD_PREP(CTXDESC_CD_0_ASID, cfg->cd.asid) |
> -	      CTXDESC_CD_0_V;
>  
> -	/* STALL_MODEL==0b10 && CD.S==0 is ILLEGAL */
> -	if (smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
> -		val |= CTXDESC_CD_0_S;
> +	if (!cdptr)
> +		return -ENOMEM;
>  
> -	cdptr[0] = cpu_to_le64(val);
> +	val = le64_to_cpu(cdptr[0]);
> +	cd_live = !!(val & CTXDESC_CD_0_V);
>  
> -	val = cfg->cd.ttbr & CTXDESC_CD_1_TTB0_MASK;
> -	cdptr[1] = cpu_to_le64(val);
> +	if (!cd) { /* (4) */
> +		val = 0;
> +	} else if (cd_live) { /* (3) */
> +		val &= ~CTXDESC_CD_0_ASID;
> +		val |= FIELD_PREP(CTXDESC_CD_0_ASID, cd->asid);
> +		/*
> +		 * Until CD+TLB invalidation, both ASIDs may be used for tagging
> +		 * this substream's traffic
> +		 */
> +	} else { /* (1) and (2) */
> +		cdptr[1] = cpu_to_le64(cd->ttbr & CTXDESC_CD_1_TTB0_MASK);
> +		cdptr[2] = 0;
> +		cdptr[3] = cpu_to_le64(cd->mair);
>  
> -	cdptr[3] = cpu_to_le64(cfg->cd.mair);
> +		/*
> +		 * STE is live, and the SMMU might fetch this CD at any
> +		 * time. Ensure that it observes the rest of the CD before we
> +		 * enable it.
> +		 */
> +		arm_smmu_sync_cd(smmu_domain, ssid, true);
> +
> +		val = arm_smmu_cpu_tcr_to_cd(cd->tcr) |
> +#ifdef __BIG_ENDIAN
> +			CTXDESC_CD_0_ENDI |
> +#endif
> +			CTXDESC_CD_0_R | CTXDESC_CD_0_A | CTXDESC_CD_0_ASET |
> +			CTXDESC_CD_0_AA64 |
> +			FIELD_PREP(CTXDESC_CD_0_ASID, cd->asid) |
> +			CTXDESC_CD_0_V;
> +
> +		/* STALL_MODEL==0b10 && CD.S==0 is ILLEGAL */
> +		if (smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
> +			val |= CTXDESC_CD_0_S;
> +	}
> +
> +	WRITE_ONCE(cdptr[0], cpu_to_le64(val));
> +	arm_smmu_sync_cd(smmu_domain, ssid, true);
> +	return 0;
>  }
>  
>  static int arm_smmu_alloc_cd_tables(struct arm_smmu_domain *smmu_domain)
> @@ -1533,6 +1615,7 @@ static int arm_smmu_alloc_cd_tables(struct arm_smmu_domain *smmu_domain)
>  	struct arm_smmu_device *smmu = smmu_domain->smmu;
>  	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
>  
> +	cfg->s1fmt = STRTAB_STE_0_S1FMT_LINEAR;
>  	return arm_smmu_alloc_cd_leaf_table(smmu, &cfg->table,
>  					    1 << cfg->s1cdmax);
>  }
> @@ -1664,6 +1747,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
>  	if (s1_cfg) {
>  		BUG_ON(ste_live);
>  		dst[1] = cpu_to_le64(
> +			 FIELD_PREP(STRTAB_STE_1_S1DSS, STRTAB_STE_1_S1DSS_SSID0) |
>  			 FIELD_PREP(STRTAB_STE_1_S1CIR, STRTAB_STE_1_S1C_CACHE_WBRA) |
>  			 FIELD_PREP(STRTAB_STE_1_S1COR, STRTAB_STE_1_S1C_CACHE_WBRA) |
>  			 FIELD_PREP(STRTAB_STE_1_S1CSH, ARM_SMMU_SH_ISH) |
> @@ -1674,7 +1758,9 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
>  			dst[1] |= cpu_to_le64(STRTAB_STE_1_S1STALLD);
>  
>  		val |= (s1_cfg->table.ptr_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
> -			FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S1_TRANS);
> +			FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S1_TRANS) |
> +			FIELD_PREP(STRTAB_STE_0_S1CDMAX, s1_cfg->s1cdmax) |
> +			FIELD_PREP(STRTAB_STE_0_S1FMT, s1_cfg->s1fmt);
>  	}
>  
>  	if (s2_cfg) {
> @@ -2224,10 +2310,14 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
>  	cfg->cd.tcr	= pgtbl_cfg->arm_lpae_s1_cfg.tcr;
>  	cfg->cd.mair	= pgtbl_cfg->arm_lpae_s1_cfg.mair[0];
>  
> -	arm_smmu_write_ctx_desc(smmu, cfg);
> +	ret = arm_smmu_write_ctx_desc(smmu_domain, 0, &cfg->cd);
> +	if (ret)
> +		goto out_free_tables;
>  
>  	return 0;
>  
> +out_free_tables:
> +	arm_smmu_free_cd_tables(smmu_domain);
>  out_free_asid:
>  	arm_smmu_bitmap_free(smmu->asid_map, asid);
>  	return ret;


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
