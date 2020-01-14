Return-Path: <SRS0=+KdK=3D=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74D3C33C9E
	for <iommu@archiver.kernel.org>; Tue, 14 Jan 2020 16:30:28 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FD1E24658
	for <iommu@archiver.kernel.org>; Tue, 14 Jan 2020 16:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s+Iyq+RN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FD1E24658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5D0488610F;
	Tue, 14 Jan 2020 16:30:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QntvpJHetbX9; Tue, 14 Jan 2020 16:30:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id E0D2C86123;
	Tue, 14 Jan 2020 16:30:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CABF3C1D83;
	Tue, 14 Jan 2020 16:30:23 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9314DC077D
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jan 2020 16:30:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 8E4B620523
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jan 2020 16:30:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t4PDn+XfC7v4 for <iommu@lists.linux-foundation.org>;
 Tue, 14 Jan 2020 16:30:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66])
 by silver.osuosl.org (Postfix) with ESMTPS id EDB4220522
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jan 2020 16:30:15 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id p17so14483920wma.1
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jan 2020 08:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=FxzudKMd6YPzfM/0BCFYKKllAjp2Gts8h1iV+G6imWk=;
 b=s+Iyq+RN5AGDwxAr+7mKSPO+f5dVtM5aGFjxvkHZQBHQwXAqMg2vwzQPELgT1uodlp
 JXy/DuVb0oRdwbqTf/mCxgl+cpu3UILK2AlyUaBXvCpExWHPCFV6DjDsEzNGUIwTZ5yM
 izcUzJzY0MkhGcHsS3VehJ5SVpR5GInPz9A9d6+sBta87TRrKVLGgT/8YECNLDXfV+wN
 deCf8GyzR05dexz2K+saRt/Eaug/UCfoJzH/YhFoJBGXqiTHp5FJxeXIrnqS8DzEb7YA
 xOg8gP/zZKWgb5mblk2brIQs9wCO4ujce8asFWCePfF4zyW1ssuhO8NuuUWvdyKNz3K7
 xxJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=FxzudKMd6YPzfM/0BCFYKKllAjp2Gts8h1iV+G6imWk=;
 b=jPAOSFV5buwiyXnVE6Mt7Gh2GMoctK7Xgat91nJM3azVOr4vvb3qWIxU3ZKh2UxvlJ
 IadaUCun2WjPjPCUqYcx7FmxhrC5fV04kWG67axmI+bAG+DvH9/WjRBWu19e5/D/qiqC
 jQMtzPGZUMDkC0MXoAEBLIDFY6ixM/3RaU2CzzgIxOBi5R/gE6zvicAf4K0+Ac6N/WTU
 rUAD97c9WPF+Z5kBYG5fmuJ1QPrRrT0URFH+IAw6CyAQ/bdArKc1PIFdqsTkuIs1oqXC
 s2wm9x454bO8bS9hsszVgX1YIpUN0ASWX4I3lkL89kr9uLH0O6+f9I+qWUIYbgFz16O2
 1fSA==
X-Gm-Message-State: APjAAAWp//golYF4vmRO/OkSntgzsvfY/7fDUT0MTAkZerV7LK4Y79Cd
 +m7juzt06WH8fDwhFr0Cj+4bZw==
X-Google-Smtp-Source: APXvYqxmcTGf2eTNhXZGx1ouob2jWFN+Aj7RA5BSt55FfOJCn9ALBt2Ou920JluYTTjGalcW0fwmLw==
X-Received: by 2002:a1c:740b:: with SMTP id p11mr29763542wmc.78.1579019414216; 
 Tue, 14 Jan 2020 08:30:14 -0800 (PST)
Received: from myrica ([2001:171b:2266:ba60:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id u18sm19852028wrt.26.2020.01.14.08.30.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2020 08:30:13 -0800 (PST)
Date: Tue, 14 Jan 2020 17:30:09 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 07/13] iommu/arm-smmu-v3: Add support for Substream IDs
Message-ID: <20200114163009.GA5319@myrica>
References: <20191219163033.2608177-1-jean-philippe@linaro.org>
 <20191219163033.2608177-8-jean-philippe@linaro.org>
 <20200114123819.GC29222@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200114123819.GC29222@willie-the-truck>
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

On Tue, Jan 14, 2020 at 12:38:19PM +0000, Will Deacon wrote:
> > +static void arm_smmu_sync_cd(struct arm_smmu_domain *smmu_domain,
> > +			     int ssid, bool leaf)
> > +{
> > +	size_t i;
> > +	unsigned long flags;
> > +	struct arm_smmu_master *master;
> > +	struct arm_smmu_device *smmu = smmu_domain->smmu;
> > +	struct arm_smmu_cmdq_ent cmd = {
> > +		.opcode	= CMDQ_OP_CFGI_CD,
> > +		.cfgi	= {
> > +			.ssid	= ssid,
> > +			.leaf	= leaf,
> > +		},
> > +	};
> > +
> > +	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
> > +	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
> > +		for (i = 0; i < master->num_sids; i++) {
> > +			cmd.cfgi.sid = master->sids[i];
> > +			arm_smmu_cmdq_issue_cmd(smmu, &cmd);
> > +		}
> > +	}
> > +	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
> > +
> > +	arm_smmu_cmdq_issue_sync(smmu);
> 
> Can you send a follow-up patch converting this to batch submission, please?

Ok

> > +}
> > +
> >  static int arm_smmu_alloc_cd_leaf_table(struct arm_smmu_device *smmu,
> >  					struct arm_smmu_cd_table *table,
> >  					size_t num_entries)
> > @@ -1498,34 +1541,65 @@ static u64 arm_smmu_cpu_tcr_to_cd(u64 tcr)
> >  	return val;
> >  }
> >  
> > -static void arm_smmu_write_ctx_desc(struct arm_smmu_device *smmu,
> > -				    struct arm_smmu_s1_cfg *cfg)
> > +static int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain,
> > +				   int ssid, struct arm_smmu_ctx_desc *cd)
> >  {
> > -	u64 val;
> > -	__le64 *cdptr = cfg->table.ptr;
> > -
> >  	/*
> > -	 * We don't need to issue any invalidation here, as we'll invalidate
> > -	 * the STE when installing the new entry anyway.
> > +	 * This function handles the following cases:
> > +	 *
> > +	 * (1) Install primary CD, for normal DMA traffic (SSID = 0).
> > +	 * (2) Install a secondary CD, for SID+SSID traffic.
> > +	 * (3) Update ASID of a CD. Atomically write the first 64 bits of the
> > +	 *     CD, then invalidate the old entry and mappings.
> > +	 * (4) Remove a secondary CD.
> >  	 */
> > -	val = arm_smmu_cpu_tcr_to_cd(cfg->cd.tcr) |
> > -#ifdef __BIG_ENDIAN
> > -	      CTXDESC_CD_0_ENDI |
> > -#endif
> > -	      CTXDESC_CD_0_R | CTXDESC_CD_0_A | CTXDESC_CD_0_ASET |
> > -	      CTXDESC_CD_0_AA64 | FIELD_PREP(CTXDESC_CD_0_ASID, cfg->cd.asid) |
> > -	      CTXDESC_CD_0_V;
> > +	u64 val;
> > +	bool cd_live;
> > +	struct arm_smmu_device *smmu = smmu_domain->smmu;
> > +	__le64 *cdptr = smmu_domain->s1_cfg.table.ptr + ssid *
> > +			CTXDESC_CD_DWORDS;
> >  
> > -	/* STALL_MODEL==0b10 && CD.S==0 is ILLEGAL */
> > -	if (smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
> > -		val |= CTXDESC_CD_0_S;
> > +	val = le64_to_cpu(cdptr[0]);
> > +	cd_live = !!(val & CTXDESC_CD_0_V);
> >  
> > -	cdptr[0] = cpu_to_le64(val);
> > +	if (!cd) { /* (4) */
> > +		val = 0;
> > +	} else if (cd_live) { /* (3) */
> > +		val &= ~CTXDESC_CD_0_ASID;
> > +		val |= FIELD_PREP(CTXDESC_CD_0_ASID, cd->asid);
> > +		/*
> > +		 * Until CD+TLB invalidation, both ASIDs may be used for tagging
> > +		 * this substream's traffic
> > +		 */
> 
> I don't think you need to change anything here, but I do find it a little
> scary that we can modify live CDs like this. However, given that the
> hardware is permitted to cache the structures regardless of validity, it
> appears to be the only option. Terrifying!
> 
> > +	} else { /* (1) and (2) */
> > +		cdptr[1] = cpu_to_le64(cd->ttbr & CTXDESC_CD_1_TTB0_MASK);
> 
> Can you use FIELD_PREP here too?

No, FIELD_PREP will shift ttbr left by 4 bits

> > +		cdptr[2] = 0;
> > +		cdptr[3] = cpu_to_le64(cd->mair);
> > +
> > +		/*
> > +		 * STE is live, and the SMMU might read dwords of this CD in any
> > +		 * order. Ensure that it observes valid values before reading
> > +		 * V=1.
> > +		 */
> > +		arm_smmu_sync_cd(smmu_domain, ssid, true);
> >  
> > -	val = cfg->cd.ttbr & CTXDESC_CD_1_TTB0_MASK;
> > -	cdptr[1] = cpu_to_le64(val);
> > +		val = arm_smmu_cpu_tcr_to_cd(cd->tcr) |
> > +#ifdef __BIG_ENDIAN
> > +			CTXDESC_CD_0_ENDI |
> > +#endif
> > +			CTXDESC_CD_0_R | CTXDESC_CD_0_A | CTXDESC_CD_0_ASET |
> > +			CTXDESC_CD_0_AA64 |
> > +			FIELD_PREP(CTXDESC_CD_0_ASID, cd->asid) |
> > +			CTXDESC_CD_0_V;
> >  
> > -	cdptr[3] = cpu_to_le64(cfg->cd.mair);
> > +		/* STALL_MODEL==0b10 && CD.S==0 is ILLEGAL */
> > +		if (smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
> > +			val |= CTXDESC_CD_0_S;
> > +	}
> > +
> > +	WRITE_ONCE(cdptr[0], cpu_to_le64(val));
> 
> Can you add a comment here citing 3.21.3 ("Configuration structures and
> configuration invalidation completion") please? Specifically, the note that
> states:
> 
>   | The size of single-copy atomic reads made by the SMMU is IMPLEMENTATION
>   | DEFINED but must be at least 64 bits.
> 
> Because that's really crucial to the WRITE_ONCE() above!
> 
> Shouldn't we also do the same thing for the STE side of things? I think so,
> and you can just comment of them with the quote and cite the comment from
> the other callsite.

Yes, makes sense

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
