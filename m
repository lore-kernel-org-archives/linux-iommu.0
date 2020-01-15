Return-Path: <SRS0=En+E=3E=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E464C33CB2
	for <iommu@archiver.kernel.org>; Wed, 15 Jan 2020 09:21:50 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2424A24655
	for <iommu@archiver.kernel.org>; Wed, 15 Jan 2020 09:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZzVaV5WZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2424A24655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2359685B29;
	Wed, 15 Jan 2020 09:21:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ap-XQIk133Ls; Wed, 15 Jan 2020 09:21:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 318F984FFF;
	Wed, 15 Jan 2020 09:21:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1558BC1D83;
	Wed, 15 Jan 2020 09:21:45 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 639ECC077D
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jan 2020 09:21:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 521CD85C97
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jan 2020 09:21:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v8cI54rZXEax for <iommu@lists.linux-foundation.org>;
 Wed, 15 Jan 2020 09:21:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id D747985BCD
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jan 2020 09:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579080097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Eiw17BZqQMy1phRlzdakGYNq15F5XtxHay/deSq4pFE=;
 b=ZzVaV5WZjizyt8bib0u/A3gu5kwk38UCCZwCfzVjMAg6oHauvi5jvIQsSSC4PqYNWRwwCB
 clRvC+zzWmU6TNkeVLKSQVMY5h9awTc6HqZ2OkLDVxTUvBmAQi8idBRRXprbAMIDjy1JZm
 patpRH2uJ1/o8IZLl5WM3BriecA+WoU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-oyoxPCwDMLK4UwYtYhkY9g-1; Wed, 15 Jan 2020 04:21:31 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 60BF78024D7;
 Wed, 15 Jan 2020 09:21:29 +0000 (UTC)
Received: from [10.36.117.108] (ovpn-117-108.ams2.redhat.com [10.36.117.108])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B5221084381;
 Wed, 15 Jan 2020 09:21:27 +0000 (UTC)
Subject: Re: [PATCH] iommu/arm-smmu-v3: Add SMMUv3.2 range invalidation support
To: Rob Herring <robh@kernel.org>, iommu@lists.linux-foundation.org
References: <20200113143924.11576-1-robh@kernel.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <2ee87a12-1a0e-bd48-0209-b5e205342d44@redhat.com>
Date: Wed, 15 Jan 2020 10:21:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200113143924.11576-1-robh@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: oyoxPCwDMLK4UwYtYhkY9g-1
X-Mimecast-Spam-Score: 0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org
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

Hi Rob,

On 1/13/20 3:39 PM, Rob Herring wrote:
> Arm SMMUv3.2 adds support for TLB range invalidate operations.
> Support for range invalidate is determined by the RIL bit in the IDR3
> register.
> 
> The range invalidate is in units of the leaf page size and operates on
> 1-32 chunks of a power of 2 multiple pages. First we determine from the
> size what power of 2 multiple we can use and then adjust the granule to
> 32x that size.
> 
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/iommu/arm-smmu-v3.c | 53 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index e91b4a098215..8b6b3e2aa383 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -70,6 +70,9 @@
>  #define IDR1_SSIDSIZE			GENMASK(10, 6)
>  #define IDR1_SIDSIZE			GENMASK(5, 0)
>  
> +#define ARM_SMMU_IDR3			0xc
> +#define IDR3_RIL			(1 << 10)
> +
>  #define ARM_SMMU_IDR5			0x14
>  #define IDR5_STALL_MAX			GENMASK(31, 16)
>  #define IDR5_GRAN64K			(1 << 6)
> @@ -327,9 +330,14 @@
>  #define CMDQ_CFGI_1_LEAF		(1UL << 0)
>  #define CMDQ_CFGI_1_RANGE		GENMASK_ULL(4, 0)
>  
> +#define CMDQ_TLBI_0_NUM			GENMASK_ULL(16, 12)
> +#define CMDQ_TLBI_RANGE_NUM_MAX		32
> +#define CMDQ_TLBI_0_SCALE		GENMASK_ULL(24, 20)
>  #define CMDQ_TLBI_0_VMID		GENMASK_ULL(47, 32)
>  #define CMDQ_TLBI_0_ASID		GENMASK_ULL(63, 48)
>  #define CMDQ_TLBI_1_LEAF		(1UL << 0)
> +#define CMDQ_TLBI_1_TTL			GENMASK_ULL(9, 8)
> +#define CMDQ_TLBI_1_TG			GENMASK_ULL(11, 10)
>  #define CMDQ_TLBI_1_VA_MASK		GENMASK_ULL(63, 12)
>  #define CMDQ_TLBI_1_IPA_MASK		GENMASK_ULL(51, 12)
>  
> @@ -455,9 +463,13 @@ struct arm_smmu_cmdq_ent {
>  		#define CMDQ_OP_TLBI_S2_IPA	0x2a
>  		#define CMDQ_OP_TLBI_NSNH_ALL	0x30
>  		struct {
> +			u8			num;
> +			u8			scale;
>  			u16			asid;
>  			u16			vmid;
>  			bool			leaf;
> +			u8			ttl;
> +			u8			tg;
>  			u64			addr;
>  		} tlbi;
>  
> @@ -595,6 +607,7 @@ struct arm_smmu_device {
>  #define ARM_SMMU_FEAT_HYP		(1 << 12)
>  #define ARM_SMMU_FEAT_STALL_FORCE	(1 << 13)
>  #define ARM_SMMU_FEAT_VAX		(1 << 14)
> +#define ARM_SMMU_FEAT_RANGE_INV		(1 << 15)
>  	u32				features;
>  
>  #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
> @@ -856,13 +869,21 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
>  		cmd[1] |= FIELD_PREP(CMDQ_CFGI_1_RANGE, 31);
>  		break;
>  	case CMDQ_OP_TLBI_NH_VA:
> +		cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_NUM, ent->tlbi.num);
> +		cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_SCALE, ent->tlbi.scale);
>  		cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_ASID, ent->tlbi.asid);
>  		cmd[1] |= FIELD_PREP(CMDQ_TLBI_1_LEAF, ent->tlbi.leaf);
> +		cmd[1] |= FIELD_PREP(CMDQ_TLBI_1_TTL, ent->tlbi.ttl);
> +		cmd[1] |= FIELD_PREP(CMDQ_TLBI_1_TG, ent->tlbi.tg);
>  		cmd[1] |= ent->tlbi.addr & CMDQ_TLBI_1_VA_MASK;
>  		break;
>  	case CMDQ_OP_TLBI_S2_IPA:
> +		cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_NUM, ent->tlbi.num);
> +		cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_SCALE, ent->tlbi.scale);
>  		cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_VMID, ent->tlbi.vmid);
>  		cmd[1] |= FIELD_PREP(CMDQ_TLBI_1_LEAF, ent->tlbi.leaf);
> +		cmd[1] |= FIELD_PREP(CMDQ_TLBI_1_TTL, ent->tlbi.ttl);
> +		cmd[1] |= FIELD_PREP(CMDQ_TLBI_1_TG, ent->tlbi.tg);
>  		cmd[1] |= ent->tlbi.addr & CMDQ_TLBI_1_IPA_MASK;
>  		break;
>  	case CMDQ_OP_TLBI_NH_ASID:
> @@ -2022,12 +2043,39 @@ static void arm_smmu_tlb_inv_range(unsigned long iova, size_t size,
>  		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
>  	}
>  
> +	if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
> +		unsigned long tg, scale;
> +
> +		/* Get the leaf page size */
> +		tg = __ffs(smmu_domain->domain.pgsize_bitmap);
it is unclear to me why you can't set tg with the granule parameter.
> +
> +		/* Determine the power of 2 multiple number of pages */
> +		scale = __ffs(size / (1UL << tg));
> +		cmd.tlbi.scale = scale;
> +
> +		cmd.tlbi.num = CMDQ_TLBI_RANGE_NUM_MAX - 1;
Also could you explain why you use CMDQ_TLBI_RANGE_NUM_MAX.


> +
> +		/* Convert page size of 12,14,16 (log2) to 1,2,3 */
> +		cmd.tlbi.tg = ((tg - ilog2(SZ_4K)) / 2) + 1;
> +
> +		/* Determine what level the granule is at */
> +		cmd.tlbi.ttl = 4 - ((ilog2(granule) - 3) / (tg - 3));
> +
> +		/* Adjust granule to the maximum range */
> +		granule = CMDQ_TLBI_RANGE_NUM_MAX * (1 << scale) * (1UL << tg);
spec says
Range = ((NUM+1)*2 ^ SCALE )*Translation_Granule_Size

Thanks

Eric

> +	}
> +
>  	while (iova < end) {
>  		if (i == CMDQ_BATCH_ENTRIES) {
>  			arm_smmu_cmdq_issue_cmdlist(smmu, cmds, i, false);
>  			i = 0;
>  		}
>  
> +		/* Only possible for range invalidate */
> +		if (granule > (end - iova))
> +			cmd.tlbi.num = ((end - iova) /
> +					(granule / CMDQ_TLBI_RANGE_NUM_MAX)) - 1;
> +
>  		cmd.tlbi.addr = iova;
>  		arm_smmu_cmdq_build_cmd(&cmds[i * CMDQ_ENT_DWORDS], &cmd);
>  		iova += granule;
> @@ -3449,6 +3497,11 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
>  	if (smmu->sid_bits <= STRTAB_SPLIT)
>  		smmu->features &= ~ARM_SMMU_FEAT_2_LVL_STRTAB;
>  
> +	/* IDR3 */
> +	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR3);
> +	if (FIELD_GET(IDR3_RIL, reg))
> +		smmu->features |= ARM_SMMU_FEAT_RANGE_INV;
> +
>  	/* IDR5 */
>  	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR5);
>  
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
