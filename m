Return-Path: <SRS0=Tv0G=2I=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CF5C2D0D2
	for <iommu@archiver.kernel.org>; Wed, 18 Dec 2019 16:08:11 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E15862465E
	for <iommu@archiver.kernel.org>; Wed, 18 Dec 2019 16:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rf+XD25p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E15862465E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id C2FE0884DE;
	Wed, 18 Dec 2019 16:08:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7t76FTcQhavx; Wed, 18 Dec 2019 16:08:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 146528715D;
	Wed, 18 Dec 2019 16:08:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EB74BC1797;
	Wed, 18 Dec 2019 16:08:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DC566C077D
 for <iommu@lists.linux-foundation.org>; Wed, 18 Dec 2019 16:08:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D836185A49
 for <iommu@lists.linux-foundation.org>; Wed, 18 Dec 2019 16:08:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UGKJWh6Mx7tG for <iommu@lists.linux-foundation.org>;
 Wed, 18 Dec 2019 16:08:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id C573B85A0E
 for <iommu@lists.linux-foundation.org>; Wed, 18 Dec 2019 16:08:07 +0000 (UTC)
Received: by mail-wm1-f67.google.com with SMTP id a5so2420489wmb.0
 for <iommu@lists.linux-foundation.org>; Wed, 18 Dec 2019 08:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=HlbfX+nhA+yr8jwGVCf2vKWxFkPoGRCkCNeDk7rXv8M=;
 b=rf+XD25p+0eZtPn+Of3DpE7+VILCHxiI01e18MTPQvaI5Dx5ShYXNOuMZBBRGuWrW7
 l1zm14YHYrXBbPr0m+9SGpjE2MuyavX8n33cvL3Vn8k8IL4M71hQ/J7q9ms5ff+SEIEs
 D5jVsZF/E/N2V61nstQEiUgxdDSwlTbs//LUlxEeE0qiWM8OEDDM5v3/A72LGQhxvJKl
 wXRcvQ5GlzwYd42FGdjPWyGqNoTYN1oDy1wSS9NJZTpGPtUVCev9S9YLPd506DGk4Isz
 x7/Z7s7Fg8Fa+HMicr3R0DyfE7Fpezg9WcqfnaGeDhTrWZHL/y5EBz2iTSThhjSqSTnK
 5DzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=HlbfX+nhA+yr8jwGVCf2vKWxFkPoGRCkCNeDk7rXv8M=;
 b=FnCfyN4MvpJsGAEQuUFhYsbUgZaQgAu42WfJhXKupOMhpmh89s48fYId3v7QNo16R5
 CMS20S4+/X78paRvI7wC75oMzcU5f6nelfm9XQKER/ZgjrR3CKeQ9PJJy0HNw4pEa34Y
 vBvmnIaKrp5+c036kTMDRFj2sxlYJmFPc2cHXwV2XNElsxMaqnNuvLAQTPuwrAR/tjgS
 gdDv0QbKCVz7yzKKchKh45o+niw9DpJidsYCzf1I6rhYa1HDjHc9EzlARixm4lLdLFje
 qJPoDkgvnKlOjHwVDwWH02Ott7ZShA+rf1MUeECEtZxUkBxZcanNYJ1ea//kXWt4hpZb
 4Ajw==
X-Gm-Message-State: APjAAAWMub8KhK0R6Kdc6499DUw+tatJg2qCaFrJqXvk0T+QScgKZEpd
 tbkR1QTzOFPFzEXAJv9peVuHww==
X-Google-Smtp-Source: APXvYqx/JAqyGPCzoycHN+vwCa6OM+w0zw+UC9aZwLHysrkzU1K2buIOHwW7fRDNS6a2Je7DE55Xgw==
X-Received: by 2002:a7b:cbc9:: with SMTP id n9mr4172404wmi.89.1576685286095;
 Wed, 18 Dec 2019 08:08:06 -0800 (PST)
Received: from myrica (adsl-84-227-176-239.adslplus.ch. [84.227.176.239])
 by smtp.gmail.com with ESMTPSA id z187sm2951508wme.16.2019.12.18.08.08.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2019 08:08:05 -0800 (PST)
Date: Wed, 18 Dec 2019 17:07:59 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v3 07/13] iommu/arm-smmu-v3: Add support for Substream IDs
Message-ID: <20191218160759.GF2371701@myrica>
References: <20191209180514.272727-1-jean-philippe@linaro.org>
 <20191209180514.272727-8-jean-philippe@linaro.org>
 <aeed148a-3c55-6e97-8d97-efa4f8c6d9f4@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aeed148a-3c55-6e97-8d97-efa4f8c6d9f4@redhat.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
 sudeep.holla@arm.com, rjw@rjwysocki.net, robin.murphy@arm.com,
 linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
 robh+dt@kernel.org, guohanjun@huawei.com, bhelgaas@google.com,
 zhangfei.gao@linaro.org, will@kernel.org, linux-arm-kernel@lists.infradead.org,
 lenb@kernel.org
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

On Tue, Dec 17, 2019 at 05:43:59PM +0100, Auger Eric wrote:
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
> I see arm_smmu_write_ctx_desc getting called with non null cd in
> arm_smmu_attach_dev but I do not see it removed in the detach path?

No we don't have to remove the primary CD, since detach clears the STE and
frees the CD tables.

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
> > +			CTXDESC_CD_DWORDS;>
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
> > +	} else { /* (1) and (2) */
> > +		cdptr[1] = cpu_to_le64(cd->ttbr & CTXDESC_CD_1_TTB0_MASK);
> > +		cdptr[2] = 0;
> > +		cdptr[3] = cpu_to_le64(cd->mair);
> > +
> > +		/*
> > +		 * STE is live, and the SMMU might fetch this CD at any
> > +		 * time. Ensure that it observes the rest of the CD before we
> > +		 * enable it.
> Mostly, on't you want the invalid state to be seen?

Sorry I didn't get your question. Without the sync, the SMMU could read an
invalid address in CD[1], read V=1 in CD[0] and proceed with dereferencing
the bogus pointer before seeing our update to CD[1].

To prevent this we follow the update procedure described in IHI0070Ca
3.21.3.1 (Configuration structure update procedure):

    Because the SMMU can read any reachable structure at any time, and is not
    required to read the double-words of the structure in order, Arm
    recommends that the following procedure is used to initialize structures:
    1. Structure starts invalid, having V == 0.
    2. Fill in all fields, leaving V == 0, then perform a DSB operation to
       ensure written data is observable from the SMMU.
    3. Issue a CMD_CFGI_<STRUCT>, as appropriate.
    4. Issue a CMD_SYNC, and wait for completion.
    5. Set V to 1, then perform a DSB operation to ensure write is
       observable by the SMMU.
    6. Issue CMD_CFGI_<STRUCT>, as appropriate.
    7. Optionally issue a CMD_SYNC, and wait for completion. This must be
       done if a subsequent software operation, such as enabling device
       DMA, depends on the SMMU using the new structure.

> > @@ -1664,6 +1739,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
> >  	if (s1_cfg) {
> >  		BUG_ON(ste_live);
> >  		dst[1] = cpu_to_le64(
> > +			 FIELD_PREP(STRTAB_STE_1_S1DSS, STRTAB_STE_1_S1DSS_SSID0) |
> >  			 FIELD_PREP(STRTAB_STE_1_S1CIR, STRTAB_STE_1_S1C_CACHE_WBRA) |
> >  			 FIELD_PREP(STRTAB_STE_1_S1COR, STRTAB_STE_1_S1C_CACHE_WBRA) |
> >  			 FIELD_PREP(STRTAB_STE_1_S1CSH, ARM_SMMU_SH_ISH) |
> > @@ -1674,7 +1750,9 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
> >  			dst[1] |= cpu_to_le64(STRTAB_STE_1_S1STALLD);
> >  
> >  		val |= (s1_cfg->table.ptr_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
> > -			FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S1_TRANS);
> > +			FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S1_TRANS) |
> > +			FIELD_PREP(STRTAB_STE_0_S1CDMAX, s1_cfg->s1cdmax) |
> > +			FIELD_PREP(STRTAB_STE_0_S1FMT, s1_cfg->s1fmt);
> Do I understand correctly that each time we update the CD, we also
> update the STE. This is not wrong but theoretically this is not needed,
> right?

Only the primary CD. Once we add SVA (or auxiliary domains) we need to
update secondary CDs while the STE is live. This series is just
preparation for SVA support. I didn't include the full support because it
requires another 25+ patches.

> This also explains why you do not need the CMD_PREFETCH_CONFIG with ssid
> because you invalidate the config per sid?

Hm, I didn't add a CMD_PREFETCH_CONFIG to CDs because I don't know if it's
useful. Maybe as future optimization.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
