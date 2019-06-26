Return-Path: <SRS0=d63v=UZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E277C48BD6
	for <iommu@archiver.kernel.org>; Wed, 26 Jun 2019 18:00:32 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5426C21783
	for <iommu@archiver.kernel.org>; Wed, 26 Jun 2019 18:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yjWHcRlp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5426C21783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 3CC69CDD;
	Wed, 26 Jun 2019 18:00:32 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 85274B2F
	for <iommu@lists.linux-foundation.org>;
	Wed, 26 Jun 2019 18:00:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 2C1F3710
	for <iommu@lists.linux-foundation.org>;
	Wed, 26 Jun 2019 18:00:31 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id E2FC12177B;
	Wed, 26 Jun 2019 18:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561572030;
	bh=amZXky+dzy6w//rZtfTX48NyKxgLPjoPas3mxcVTbe4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yjWHcRlpFsV3Ts63y+nh2Wr5JEyOiV/tm3lCQSVSJrExovUYgChIQnL3RkPEkPy//
	tRDUh7tJNyr68TWwrj1bgCY2qwIjsKCfUqYb45HxZltQOPAlWt/6Vm7V739Xajuanf
	wfGUH0ykQmRyIrO+fVMe1WlTsvKPI8heorx98kQA=
Date: Wed, 26 Jun 2019 19:00:26 +0100
From: Will Deacon <will@kernel.org>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH 4/8] iommu/arm-smmu-v3: Add support for Substream IDs
Message-ID: <20190626180025.g4clm6qnbbna65de@willie-the-truck>
References: <20190610184714.6786-1-jean-philippe.brucker@arm.com>
	<20190610184714.6786-5-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190610184714.6786-5-jean-philippe.brucker@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, will.deacon@arm.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	robh+dt@kernel.org, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org
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

On Mon, Jun 10, 2019 at 07:47:10PM +0100, Jean-Philippe Brucker wrote:
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
> In all stream table entries, we set S1DSS=SSID0 mode, making translations
> without an SSID use context descriptor 0. Although it would be possible by
> setting S1DSS=BYPASS, we don't currently support SSID when user selects
> iommu.passthrough.

I don't understand your comment here: iommu.passthrough works just as it did
before, right, since we set bypass in the STE config field so S1DSS is not
relevant? I also notice that SSID0 causes transactions with SSID==0 to
abort. Is a PASID of 0 reserved, so this doesn't matter?

> @@ -1062,33 +1143,90 @@ static u64 arm_smmu_cpu_tcr_to_cd(u64 tcr)
>  	return val;
>  }
>  
> -static void arm_smmu_write_ctx_desc(struct arm_smmu_device *smmu,
> -				    struct arm_smmu_s1_cfg *cfg)
> +static int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain,
> +				   int ssid, struct arm_smmu_ctx_desc *cd)
>  {
>  	u64 val;
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
> +
> +	if (!cdptr)
> +		return -ENOMEM;
> +
> +	val = le64_to_cpu(cdptr[0]);
> +	cd_live = !!(val & CTXDESC_CD_0_V);
> +
> +	if (!cd) { /* (4) */
> +		cdptr[0] = 0;

Should we be using WRITE_ONCE here? (although I notice we don't seem to
bother for STEs either...)

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
