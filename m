Return-Path: <SRS0=Rmex=HD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E0BC433DB
	for <iommu@archiver.kernel.org>; Mon,  1 Feb 2021 12:35:45 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFB9164E9E
	for <iommu@archiver.kernel.org>; Mon,  1 Feb 2021 12:35:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFB9164E9E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2CF3586BC9;
	Mon,  1 Feb 2021 12:35:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8Sb6I62NtIxF; Mon,  1 Feb 2021 12:35:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B7EE8869EF;
	Mon,  1 Feb 2021 12:35:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A6FB6C0174;
	Mon,  1 Feb 2021 12:35:42 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D9AF7C013A
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 12:35:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id D59AD86F96
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 12:35:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TXGoECXq1V99 for <iommu@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 12:35:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 4848686F8D
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 12:35:38 +0000 (UTC)
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DTnSQ63XCz162Rt;
 Mon,  1 Feb 2021 20:34:14 +0800 (CST)
Received: from [10.174.184.42] (10.174.184.42) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Mon, 1 Feb 2021 20:35:28 +0800
Subject: Re: [PATCH v13 04/15] iommu/smmuv3: Allow s1 and s2 configs to coexist
To: Eric Auger <eric.auger@redhat.com>, <eric.auger.pro@gmail.com>,
 <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
 <kvm@vger.kernel.org>, <kvmarm@lists.cs.columbia.edu>, <will@kernel.org>,
 <joro@8bytes.org>, <maz@kernel.org>, <robin.murphy@arm.com>,
 <alex.williamson@redhat.com>
References: <20201118112151.25412-1-eric.auger@redhat.com>
 <20201118112151.25412-5-eric.auger@redhat.com>
From: Keqian Zhu <zhukeqian1@huawei.com>
Message-ID: <01cf1f27-43dc-fb4d-6755-c34c8cac8ec2@huawei.com>
Date: Mon, 1 Feb 2021 20:35:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20201118112151.25412-5-eric.auger@redhat.com>
X-Originating-IP: [10.174.184.42]
X-CFilter-Loop: Reflected
Cc: jean-philippe@linaro.org, vivek.gautam@arm.com, zhangfei.gao@linaro.org
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

On 2020/11/18 19:21, Eric Auger wrote:
> In true nested mode, both s1_cfg and s2_cfg will coexist.
> Let's remove the union and add a "set" field in each
> config structure telling whether the config is set and needs
> to be applied when writing the STE. In legacy nested mode,
> only the 2d stage is used. In true nested mode, the "set" field
nit: s/2d/2nd

> will be set when the guest passes the pasid table.
nit: ... the "set" filed of s1_cfg and s2_cfg will be set ...

> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> v12 -> v13:
> - does not dynamically allocate s1-cfg and s2_cfg anymore. Add
>   the set field
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 43 +++++++++++++--------
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  8 ++--
>  2 files changed, 31 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 1e4acc7f3d3c..18ac5af1b284 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1195,8 +1195,8 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
>  	u64 val = le64_to_cpu(dst[0]);
>  	bool ste_live = false;
>  	struct arm_smmu_device *smmu = NULL;
> -	struct arm_smmu_s1_cfg *s1_cfg = NULL;
> -	struct arm_smmu_s2_cfg *s2_cfg = NULL;
> +	struct arm_smmu_s1_cfg *s1_cfg;
> +	struct arm_smmu_s2_cfg *s2_cfg;
>  	struct arm_smmu_domain *smmu_domain = NULL;
>  	struct arm_smmu_cmdq_ent prefetch_cmd = {
>  		.opcode		= CMDQ_OP_PREFETCH_CFG,
> @@ -1211,13 +1211,24 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
>  	}
>  
>  	if (smmu_domain) {
> +		s1_cfg = &smmu_domain->s1_cfg;
> +		s2_cfg = &smmu_domain->s2_cfg;
> +
>  		switch (smmu_domain->stage) {
>  		case ARM_SMMU_DOMAIN_S1:
> -			s1_cfg = &smmu_domain->s1_cfg;
> +			s1_cfg->set = true;
> +			s2_cfg->set = false;
>  			break;
>  		case ARM_SMMU_DOMAIN_S2:
> +			s1_cfg->set = false;
> +			s2_cfg->set = true;
> +			break;
>  		case ARM_SMMU_DOMAIN_NESTED:
> -			s2_cfg = &smmu_domain->s2_cfg;
> +			/*
> +			 * Actual usage of stage 1 depends on nested mode:
> +			 * legacy (2d stage only) or true nested mode
> +			 */
> +			s2_cfg->set = true;
>  			break;
>  		default:
>  			break;
> @@ -1244,7 +1255,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
>  	val = STRTAB_STE_0_V;
>  
>  	/* Bypass/fault */
> -	if (!smmu_domain || !(s1_cfg || s2_cfg)) {
> +	if (!smmu_domain || !(s1_cfg->set || s2_cfg->set)) {
>  		if (!smmu_domain && disable_bypass)
>  			val |= FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_ABORT);
>  		else
> @@ -1263,7 +1274,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
>  		return;
>  	}
>  
> -	if (s1_cfg) {
> +	if (s1_cfg->set) {
>  		BUG_ON(ste_live);
>  		dst[1] = cpu_to_le64(
>  			 FIELD_PREP(STRTAB_STE_1_S1DSS, STRTAB_STE_1_S1DSS_SSID0) |
> @@ -1282,7 +1293,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
>  			FIELD_PREP(STRTAB_STE_0_S1FMT, s1_cfg->s1fmt);
>  	}
>  
> -	if (s2_cfg) {
> +	if (s2_cfg->set) {
>  		BUG_ON(ste_live);
>  		dst[2] = cpu_to_le64(
>  			 FIELD_PREP(STRTAB_STE_2_S2VMID, s2_cfg->vmid) |
> @@ -1846,24 +1857,24 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
>  {
>  	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>  	struct arm_smmu_device *smmu = smmu_domain->smmu;
> +	struct arm_smmu_s1_cfg *s1_cfg = &smmu_domain->s1_cfg;
> +	struct arm_smmu_s2_cfg *s2_cfg = &smmu_domain->s2_cfg;
>  
>  	iommu_put_dma_cookie(domain);
>  	free_io_pgtable_ops(smmu_domain->pgtbl_ops);
>  
>  	/* Free the CD and ASID, if we allocated them */
> -	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
> -		struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
> -
> +	if (s1_cfg->set) {
>  		/* Prevent SVA from touching the CD while we're freeing it */
>  		mutex_lock(&arm_smmu_asid_lock);
> -		if (cfg->cdcfg.cdtab)
> +		if (s1_cfg->cdcfg.cdtab)
>  			arm_smmu_free_cd_tables(smmu_domain);
> -		arm_smmu_free_asid(&cfg->cd);
> +		arm_smmu_free_asid(&s1_cfg->cd);
>  		mutex_unlock(&arm_smmu_asid_lock);
> -	} else {
> -		struct arm_smmu_s2_cfg *cfg = &smmu_domain->s2_cfg;
> -		if (cfg->vmid)
> -			arm_smmu_bitmap_free(smmu->vmid_map, cfg->vmid);
> +	}
> +	if (s2_cfg->set) {
> +		if (s2_cfg->vmid)
> +			arm_smmu_bitmap_free(smmu->vmid_map, s2_cfg->vmid);
>  	}
>  
>  	kfree(smmu_domain);
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 19196eea7c1d..07f59252dd21 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -562,12 +562,14 @@ struct arm_smmu_s1_cfg {
>  	struct arm_smmu_ctx_desc	cd;
>  	u8				s1fmt;
>  	u8				s1cdmax;
> +	bool				set;
>  };
>  
>  struct arm_smmu_s2_cfg {
>  	u16				vmid;
>  	u64				vttbr;
>  	u64				vtcr;
> +	bool				set;
>  };
>  
>  struct arm_smmu_strtab_cfg {
> @@ -678,10 +680,8 @@ struct arm_smmu_domain {
>  	atomic_t			nr_ats_masters;
>  
>  	enum arm_smmu_domain_stage	stage;
> -	union {
> -		struct arm_smmu_s1_cfg	s1_cfg;
> -		struct arm_smmu_s2_cfg	s2_cfg;
> -	};
> +	struct arm_smmu_s1_cfg	s1_cfg;
> +	struct arm_smmu_s2_cfg	s2_cfg;
>  
>  	struct iommu_domain		domain;
>  
Other looks good to me. ;-)
> 

Thanks,
Keqian
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
