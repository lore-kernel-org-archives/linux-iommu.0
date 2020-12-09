Return-Path: <SRS0=OQvg=FN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06ACC4361B
	for <iommu@archiver.kernel.org>; Wed,  9 Dec 2020 14:27:12 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03E30207B1
	for <iommu@archiver.kernel.org>; Wed,  9 Dec 2020 14:27:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03E30207B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id D7B7C877EB;
	Wed,  9 Dec 2020 14:27:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Xkon1ROy6fBF; Wed,  9 Dec 2020 14:27:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id E38CB87218;
	Wed,  9 Dec 2020 14:27:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2529C0FA7;
	Wed,  9 Dec 2020 14:27:10 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2113C013B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 14:27:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id DF7CF87711
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 14:27:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aeI5ngO1jDwP for <iommu@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 14:27:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 47AD887218
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 14:27:07 +0000 (UTC)
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.55])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4CrfVx558zzQp1g;
 Wed,  9 Dec 2020 22:26:33 +0800 (CST)
Received: from dggema766-chm.china.huawei.com (10.1.198.208) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Wed, 9 Dec 2020 22:27:01 +0800
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggema766-chm.china.huawei.com (10.1.198.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Wed, 9 Dec 2020 22:27:01 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2106.002; Wed, 9 Dec 2020 14:26:59 +0000
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com"
 <eric.auger.pro@gmail.com>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
 "will@kernel.org" <will@kernel.org>, "joro@8bytes.org" <joro@8bytes.org>,
 "maz@kernel.org" <maz@kernel.org>, "robin.murphy@arm.com"
 <robin.murphy@arm.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>
Subject: RE: [PATCH v13 05/15] iommu/smmuv3: Get prepared for nested stage
 support
Thread-Topic: [PATCH v13 05/15] iommu/smmuv3: Get prepared for nested stage
 support
Thread-Index: AQHWvZ3YzXx0Iv4/TkmqLZQuADrJXqnu73jQ
Date: Wed, 9 Dec 2020 14:26:59 +0000
Message-ID: <d31ca662eb124fd3ba0c88936dcc098f@huawei.com>
References: <20201118112151.25412-1-eric.auger@redhat.com>
 <20201118112151.25412-6-eric.auger@redhat.com>
In-Reply-To: <20201118112151.25412-6-eric.auger@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.1.56]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "Zengtao \(B\)" <prime.zeng@hisilicon.com>,
 "vivek.gautam@arm.com" <vivek.gautam@arm.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 qubingbing <qubingbing@hisilicon.com>
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

Hi Eric,

> -----Original Message-----
> From: Eric Auger [mailto:eric.auger@redhat.com]
> Sent: 18 November 2020 11:22
> To: eric.auger.pro@gmail.com; eric.auger@redhat.com;
> iommu@lists.linux-foundation.org; linux-kernel@vger.kernel.org;
> kvm@vger.kernel.org; kvmarm@lists.cs.columbia.edu; will@kernel.org;
> joro@8bytes.org; maz@kernel.org; robin.murphy@arm.com;
> alex.williamson@redhat.com
> Cc: jean-philippe@linaro.org; zhangfei.gao@linaro.org;
> zhangfei.gao@gmail.com; vivek.gautam@arm.com; Shameerali Kolothum
> Thodi <shameerali.kolothum.thodi@huawei.com>;
> jacob.jun.pan@linux.intel.com; yi.l.liu@intel.com; tn@semihalf.com;
> nicoleotsuka@gmail.com; yuzenghui <yuzenghui@huawei.com>
> Subject: [PATCH v13 05/15] iommu/smmuv3: Get prepared for nested stage
> support
> 
> When nested stage translation is setup, both s1_cfg and
> s2_cfg are set.
> 
> We introduce a new smmu domain abort field that will be set
> upon guest stage1 configuration passing.
> 
> arm_smmu_write_strtab_ent() is modified to write both stage
> fields in the STE and deal with the abort field.
> 
> In nested mode, only stage 2 is "finalized" as the host does
> not own/configure the stage 1 context descriptor; guest does.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> v10 -> v11:
> - Fix an issue reported by Shameer when switching from with vSMMU
>   to without vSMMU. Despite the spec does not seem to mention it
>   seems to be needed to reset the 2 high 64b when switching from
>   S1+S2 cfg to S1 only. Especially dst[3] needs to be reset (S2TTB).
>   On some implementations, if the S2TTB is not reset, this causes
>   a C_BAD_STE error
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 64
> +++++++++++++++++----
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  2 +
>  2 files changed, 56 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 18ac5af1b284..412ea1bafa50 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1181,8 +1181,10 @@ static void arm_smmu_write_strtab_ent(struct
> arm_smmu_master *master, u32 sid,
>  	 * three cases at the moment:
>  	 *
>  	 * 1. Invalid (all zero) -> bypass/fault (init)
> -	 * 2. Bypass/fault -> translation/bypass (attach)
> -	 * 3. Translation/bypass -> bypass/fault (detach)
> +	 * 2. Bypass/fault -> single stage translation/bypass (attach)
> +	 * 3. Single or nested stage Translation/bypass -> bypass/fault (detach)
> +	 * 4. S2 -> S1 + S2 (attach_pasid_table)
> +	 * 5. S1 + S2 -> S2 (detach_pasid_table)
>  	 *
>  	 * Given that we can't update the STE atomically and the SMMU
>  	 * doesn't read the thing in a defined order, that leaves us
> @@ -1193,7 +1195,8 @@ static void arm_smmu_write_strtab_ent(struct
> arm_smmu_master *master, u32 sid,
>  	 * 3. Update Config, sync
>  	 */
>  	u64 val = le64_to_cpu(dst[0]);
> -	bool ste_live = false;
> +	bool s1_live = false, s2_live = false, ste_live;
> +	bool abort, nested = false, translate = false;
>  	struct arm_smmu_device *smmu = NULL;
>  	struct arm_smmu_s1_cfg *s1_cfg;
>  	struct arm_smmu_s2_cfg *s2_cfg;
> @@ -1233,6 +1236,8 @@ static void arm_smmu_write_strtab_ent(struct
> arm_smmu_master *master, u32 sid,
>  		default:
>  			break;
>  		}
> +		nested = s1_cfg->set && s2_cfg->set;

This is a problem when the Guest is booted with iommu.passthrough = 1 as we
set s1_cfg.set = false for IOMMU_PASID_CONFIG_BYPASS. 

Results in BUG_ON(ste_live && !nested).

Can we instead have nested = true set a bit above in the code, where we set
s2_cfg->set = true for the ARM_SMMU_DOMAIN_NESTED case?

Please take a look.

Thanks,
Shameer

> +		translate = s1_cfg->set || s2_cfg->set;
>  	}
> 
>  	if (val & STRTAB_STE_0_V) {
> @@ -1240,23 +1245,36 @@ static void arm_smmu_write_strtab_ent(struct
> arm_smmu_master *master, u32 sid,
>  		case STRTAB_STE_0_CFG_BYPASS:
>  			break;
>  		case STRTAB_STE_0_CFG_S1_TRANS:
> +			s1_live = true;
> +			break;
>  		case STRTAB_STE_0_CFG_S2_TRANS:
> -			ste_live = true;
> +			s2_live = true;
> +			break;
> +		case STRTAB_STE_0_CFG_NESTED:
> +			s1_live = true;
> +			s2_live = true;
>  			break;
>  		case STRTAB_STE_0_CFG_ABORT:
> -			BUG_ON(!disable_bypass);
>  			break;
>  		default:
>  			BUG(); /* STE corruption */
>  		}
>  	}
> 
> +	ste_live = s1_live || s2_live;
> +
>  	/* Nuke the existing STE_0 value, as we're going to rewrite it */
>  	val = STRTAB_STE_0_V;
> 
>  	/* Bypass/fault */
> -	if (!smmu_domain || !(s1_cfg->set || s2_cfg->set)) {
> -		if (!smmu_domain && disable_bypass)
> +
> +	if (!smmu_domain)
> +		abort = disable_bypass;
> +	else
> +		abort = smmu_domain->abort;
> +
> +	if (abort || !translate) {
> +		if (abort)
>  			val |= FIELD_PREP(STRTAB_STE_0_CFG,
> STRTAB_STE_0_CFG_ABORT);
>  		else
>  			val |= FIELD_PREP(STRTAB_STE_0_CFG,
> STRTAB_STE_0_CFG_BYPASS);
> @@ -1274,8 +1292,16 @@ static void arm_smmu_write_strtab_ent(struct
> arm_smmu_master *master, u32 sid,
>  		return;
>  	}
> 
> +	BUG_ON(ste_live && !nested);
> +
> +	if (ste_live) {
> +		/* First invalidate the live STE */
> +		dst[0] = cpu_to_le64(STRTAB_STE_0_CFG_ABORT);
> +		arm_smmu_sync_ste_for_sid(smmu, sid);
> +	}
> +
>  	if (s1_cfg->set) {
> -		BUG_ON(ste_live);
> +		BUG_ON(s1_live);
>  		dst[1] = cpu_to_le64(
>  			 FIELD_PREP(STRTAB_STE_1_S1DSS,
> STRTAB_STE_1_S1DSS_SSID0) |
>  			 FIELD_PREP(STRTAB_STE_1_S1CIR,
> STRTAB_STE_1_S1C_CACHE_WBRA) |
> @@ -1294,7 +1320,14 @@ static void arm_smmu_write_strtab_ent(struct
> arm_smmu_master *master, u32 sid,
>  	}
> 
>  	if (s2_cfg->set) {
> -		BUG_ON(ste_live);
> +		u64 vttbr = s2_cfg->vttbr & STRTAB_STE_3_S2TTB_MASK;
> +
> +		if (s2_live) {
> +			u64 s2ttb = le64_to_cpu(dst[3] & STRTAB_STE_3_S2TTB_MASK);
> +
> +			BUG_ON(s2ttb != vttbr);
> +		}
> +
>  		dst[2] = cpu_to_le64(
>  			 FIELD_PREP(STRTAB_STE_2_S2VMID, s2_cfg->vmid) |
>  			 FIELD_PREP(STRTAB_STE_2_VTCR, s2_cfg->vtcr) |
> @@ -1304,9 +1337,12 @@ static void arm_smmu_write_strtab_ent(struct
> arm_smmu_master *master, u32 sid,
>  			 STRTAB_STE_2_S2PTW | STRTAB_STE_2_S2AA64 |
>  			 STRTAB_STE_2_S2R);
> 
> -		dst[3] = cpu_to_le64(s2_cfg->vttbr & STRTAB_STE_3_S2TTB_MASK);
> +		dst[3] = cpu_to_le64(vttbr);
> 
>  		val |= FIELD_PREP(STRTAB_STE_0_CFG,
> STRTAB_STE_0_CFG_S2_TRANS);
> +	} else {
> +		dst[2] = 0;
> +		dst[3] = 0;
>  	}
> 
>  	if (master->ats_enabled)
> @@ -1982,6 +2018,14 @@ static int arm_smmu_domain_finalise(struct
> iommu_domain *domain,
>  		return 0;
>  	}
> 
> +	if (smmu_domain->stage == ARM_SMMU_DOMAIN_NESTED &&
> +	    (!(smmu->features & ARM_SMMU_FEAT_TRANS_S1) ||
> +	     !(smmu->features & ARM_SMMU_FEAT_TRANS_S2))) {
> +		dev_info(smmu_domain->smmu->dev,
> +			 "does not implement two stages\n");
> +		return -EINVAL;
> +	}
> +
>  	/* Restrict the stage to what we can actually support */
>  	if (!(smmu->features & ARM_SMMU_FEAT_TRANS_S1))
>  		smmu_domain->stage = ARM_SMMU_DOMAIN_S2;
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 07f59252dd21..269779dee8d1 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -206,6 +206,7 @@
>  #define STRTAB_STE_0_CFG_BYPASS		4
>  #define STRTAB_STE_0_CFG_S1_TRANS	5
>  #define STRTAB_STE_0_CFG_S2_TRANS	6
> +#define STRTAB_STE_0_CFG_NESTED		7
> 
>  #define STRTAB_STE_0_S1FMT		GENMASK_ULL(5, 4)
>  #define STRTAB_STE_0_S1FMT_LINEAR	0
> @@ -682,6 +683,7 @@ struct arm_smmu_domain {
>  	enum arm_smmu_domain_stage	stage;
>  	struct arm_smmu_s1_cfg	s1_cfg;
>  	struct arm_smmu_s2_cfg	s2_cfg;
> +	bool				abort;
> 
>  	struct iommu_domain		domain;
> 
> --
> 2.21.3

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
