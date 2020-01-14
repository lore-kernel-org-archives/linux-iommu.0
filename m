Return-Path: <SRS0=+KdK=3D=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64319C33CB1
	for <iommu@archiver.kernel.org>; Tue, 14 Jan 2020 12:38:36 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28ADD24672
	for <iommu@archiver.kernel.org>; Tue, 14 Jan 2020 12:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4X6TGCn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28ADD24672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 02B1D85092;
	Tue, 14 Jan 2020 12:38:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x-eMv2e0KPTy; Tue, 14 Jan 2020 12:38:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0D7A385168;
	Tue, 14 Jan 2020 12:38:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC4F8C1D83;
	Tue, 14 Jan 2020 12:38:31 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 503D9C077D
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jan 2020 12:38:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 47209862B7
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jan 2020 12:38:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LsgH6L51vbyl for <iommu@lists.linux-foundation.org>;
 Tue, 14 Jan 2020 12:38:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 4272B852CB
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jan 2020 12:38:26 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1007B24672;
 Tue, 14 Jan 2020 12:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1579005506;
 bh=4qRrU6xmKvpy8FR7qF450rvS7P/WNYx1D18kyu0KUL8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=n4X6TGCnSCEYxOD71ysSAp8JqXB5gP16QX5rGahs/0uN3bqmXYSyl+JtzTnAQh8Tf
 x6BPKCttM9fo/zNYtq5QNsdsMIX4hoCnE4RWUwWnlqYn6E2/eom8qg/1I9dkGMouZ/
 efdkw+13BcWXIYmoiRfeHQ56lSg9kxK6OTMT5GpI=
Date: Tue, 14 Jan 2020 12:38:19 +0000
From: Will Deacon <will@kernel.org>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v4 07/13] iommu/arm-smmu-v3: Add support for Substream IDs
Message-ID: <20200114123819.GC29222@willie-the-truck>
References: <20191219163033.2608177-1-jean-philippe@linaro.org>
 <20191219163033.2608177-8-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191219163033.2608177-8-jean-philippe@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
 sudeep.holla@arm.com, rjw@rjwysocki.net, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, robh+dt@kernel.org, guohanjun@huawei.com,
 bhelgaas@google.com, zhangfei.gao@linaro.org, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org, lenb@kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
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
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, Dec 19, 2019 at 05:30:27PM +0100, Jean-Philippe Brucker wrote:
> At the moment, the SMMUv3 driver implements only one stage-1 or stage-2
> page directory per device. However SMMUv3 allows more than one address
> space for some devices, by providing multiple stage-1 page directories. In
> addition to the Stream ID (SID), that identifies a device, we can now have
> Substream IDs (SSID) identifying an address space. In PCIe, SID is called
> Requester ID (RID) and SSID is called Process Address-Space ID (PASID).
> A complete stage-1 walk goes through the context descriptor table:
> 
>       Stream tables       Ctx. Desc. tables       Page tables
>         +--------+   ,------->+-------+   ,------->+-------+
>         :        :   |        :       :   |        :       :
>         +--------+   |        +-------+   |        +-------+
>    SID->|  STE   |---'  SSID->|  CD   |---'  IOVA->|  PTE  |--> IPA
>         +--------+            +-------+            +-------+
>         :        :            :       :            :       :
>         +--------+            +-------+            +-------+
> 
> Rewrite arm_smmu_write_ctx_desc() to modify context descriptor table
> entries. To keep things simple we only implement one level of context
> descriptor tables here, but as with stream and page tables, an SSID can
> be split to index multiple levels of tables.
> 
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  drivers/iommu/arm-smmu-v3.c | 125 +++++++++++++++++++++++++++++-------
>  1 file changed, 102 insertions(+), 23 deletions(-)

--->8

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

Can you send a follow-up patch converting this to batch submission, please?

> +}
> +
>  static int arm_smmu_alloc_cd_leaf_table(struct arm_smmu_device *smmu,
>  					struct arm_smmu_cd_table *table,
>  					size_t num_entries)
> @@ -1498,34 +1541,65 @@ static u64 arm_smmu_cpu_tcr_to_cd(u64 tcr)
>  	return val;
>  }
>  
> -static void arm_smmu_write_ctx_desc(struct arm_smmu_device *smmu,
> -				    struct arm_smmu_s1_cfg *cfg)
> +static int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain,
> +				   int ssid, struct arm_smmu_ctx_desc *cd)
>  {
> -	u64 val;
> -	__le64 *cdptr = cfg->table.ptr;
> -
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
> +	u64 val;
> +	bool cd_live;
> +	struct arm_smmu_device *smmu = smmu_domain->smmu;
> +	__le64 *cdptr = smmu_domain->s1_cfg.table.ptr + ssid *
> +			CTXDESC_CD_DWORDS;
>  
> -	/* STALL_MODEL==0b10 && CD.S==0 is ILLEGAL */
> -	if (smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
> -		val |= CTXDESC_CD_0_S;
> +	val = le64_to_cpu(cdptr[0]);
> +	cd_live = !!(val & CTXDESC_CD_0_V);
>  
> -	cdptr[0] = cpu_to_le64(val);
> +	if (!cd) { /* (4) */
> +		val = 0;
> +	} else if (cd_live) { /* (3) */
> +		val &= ~CTXDESC_CD_0_ASID;
> +		val |= FIELD_PREP(CTXDESC_CD_0_ASID, cd->asid);
> +		/*
> +		 * Until CD+TLB invalidation, both ASIDs may be used for tagging
> +		 * this substream's traffic
> +		 */

I don't think you need to change anything here, but I do find it a little
scary that we can modify live CDs like this. However, given that the
hardware is permitted to cache the structures regardless of validity, it
appears to be the only option. Terrifying!

> +	} else { /* (1) and (2) */
> +		cdptr[1] = cpu_to_le64(cd->ttbr & CTXDESC_CD_1_TTB0_MASK);

Can you use FIELD_PREP here too?

> +		cdptr[2] = 0;
> +		cdptr[3] = cpu_to_le64(cd->mair);
> +
> +		/*
> +		 * STE is live, and the SMMU might read dwords of this CD in any
> +		 * order. Ensure that it observes valid values before reading
> +		 * V=1.
> +		 */
> +		arm_smmu_sync_cd(smmu_domain, ssid, true);
>  
> -	val = cfg->cd.ttbr & CTXDESC_CD_1_TTB0_MASK;
> -	cdptr[1] = cpu_to_le64(val);
> +		val = arm_smmu_cpu_tcr_to_cd(cd->tcr) |
> +#ifdef __BIG_ENDIAN
> +			CTXDESC_CD_0_ENDI |
> +#endif
> +			CTXDESC_CD_0_R | CTXDESC_CD_0_A | CTXDESC_CD_0_ASET |
> +			CTXDESC_CD_0_AA64 |
> +			FIELD_PREP(CTXDESC_CD_0_ASID, cd->asid) |
> +			CTXDESC_CD_0_V;
>  
> -	cdptr[3] = cpu_to_le64(cfg->cd.mair);
> +		/* STALL_MODEL==0b10 && CD.S==0 is ILLEGAL */
> +		if (smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
> +			val |= CTXDESC_CD_0_S;
> +	}
> +
> +	WRITE_ONCE(cdptr[0], cpu_to_le64(val));

Can you add a comment here citing 3.21.3 ("Configuration structures and
configuration invalidation completion") please? Specifically, the note that
states:

  | The size of single-copy atomic reads made by the SMMU is IMPLEMENTATION
  | DEFINED but must be at least 64 bits.

Because that's really crucial to the WRITE_ONCE() above!

Shouldn't we also do the same thing for the STE side of things? I think so,
and you can just comment of them with the quote and cite the comment from
the other callsite.

Thanks,

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
