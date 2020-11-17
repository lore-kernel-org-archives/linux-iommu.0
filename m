Return-Path: <SRS0=JfyE=EX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44624C5519F
	for <iommu@archiver.kernel.org>; Tue, 17 Nov 2020 12:36:26 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAC072222A
	for <iommu@archiver.kernel.org>; Tue, 17 Nov 2020 12:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oe4rqqeR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAC072222A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1EEF086F8E;
	Tue, 17 Nov 2020 12:36:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CwBTDewnrbzS; Tue, 17 Nov 2020 12:36:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0EADD86F6F;
	Tue, 17 Nov 2020 12:36:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D4A51C0891;
	Tue, 17 Nov 2020 12:36:22 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8C49FC07FF
 for <iommu@lists.linux-foundation.org>; Tue, 17 Nov 2020 12:36:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6E6E5864B2
 for <iommu@lists.linux-foundation.org>; Tue, 17 Nov 2020 12:36:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iqtXv71T8vHf for <iommu@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 12:36:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B2A458464A
 for <iommu@lists.linux-foundation.org>; Tue, 17 Nov 2020 12:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605616578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F/eCo8dQ+dAVX586N6vjPqvKgNkUBrQxp/QkZVV0lg8=;
 b=Oe4rqqeR+DjGXynngo9WomBEMwuNqTw+Mhgv8on9oB6h7cGResni0anDmrYetceHTCOz7D
 qXLv5sXoqxwc5qidL5+Kl5RmLZu8sT7vLqr1kauknXsck3z8CvO00d1jw5NPxtzki/phrN
 oQaG3ZhWywd+/T992Tv0Ef3SzVLrnYY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-bXRDGJ21NkacSpNgrH9EkQ-1; Tue, 17 Nov 2020 07:36:14 -0500
X-MC-Unique: bXRDGJ21NkacSpNgrH9EkQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A3EBB8049D6;
 Tue, 17 Nov 2020 12:36:11 +0000 (UTC)
Received: from [10.36.115.104] (ovpn-115-104.ams2.redhat.com [10.36.115.104])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A82B86EF44;
 Tue, 17 Nov 2020 12:36:03 +0000 (UTC)
Subject: Re: [PATCH v12 04/15] iommu/smmuv3: Dynamically allocate s1_cfg and
 s2_cfg
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
 "will@kernel.org" <will@kernel.org>, "joro@8bytes.org" <joro@8bytes.org>,
 "maz@kernel.org" <maz@kernel.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>
References: <20201116104316.31816-1-eric.auger@redhat.com>
 <20201116104316.31816-5-eric.auger@redhat.com>
 <166d9bfb655b44c4990bade987a49860@huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <6b1265c4-0ccc-9f51-d320-7b71df941898@redhat.com>
Date: Tue, 17 Nov 2020 13:36:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <166d9bfb655b44c4990bade987a49860@huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "vivek.gautam@arm.com" <vivek.gautam@arm.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
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

Hi Shameer,

On 11/17/20 12:39 PM, Shameerali Kolothum Thodi wrote:
> Hi Eric,
> 
>> -----Original Message-----
>> From: Eric Auger [mailto:eric.auger@redhat.com]
>> Sent: 16 November 2020 10:43
>> To: eric.auger.pro@gmail.com; eric.auger@redhat.com;
>> iommu@lists.linux-foundation.org; linux-kernel@vger.kernel.org;
>> kvm@vger.kernel.org; kvmarm@lists.cs.columbia.edu; will@kernel.org;
>> joro@8bytes.org; maz@kernel.org; robin.murphy@arm.com
>> Cc: jean-philippe@linaro.org; zhangfei.gao@linaro.org;
>> zhangfei.gao@gmail.com; vivek.gautam@arm.com; Shameerali Kolothum
>> Thodi <shameerali.kolothum.thodi@huawei.com>;
>> alex.williamson@redhat.com; jacob.jun.pan@linux.intel.com;
>> yi.l.liu@intel.com; tn@semihalf.com; nicoleotsuka@gmail.com
>> Subject: [PATCH v12 04/15] iommu/smmuv3: Dynamically allocate s1_cfg and
>> s2_cfg
>>
>> In preparation for the introduction of nested stages
>> let's turn s1_cfg and s2_cfg fields into pointers which are
>> dynamically allocated depending on the smmu_domain stage.
> 
> This will break compile if we have CONFIG_ARM_SMMU_V3_SVA
> because ,
> https://github.com/eauger/linux/blob/5.10-rc4-2stage-v12/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c#L40
> 
> Do we really need to make these pointers?

Thanks for reporting. I think I can do differently. Working on this now.

Thanks

Eric
> 
> Thanks,
> Shameer
>  
>> In nested mode, both stages will coexist and s1_cfg will
>> be allocated when the guest configuration gets passed.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 83 ++++++++++++---------
>>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  6 +-
>>  2 files changed, 48 insertions(+), 41 deletions(-)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> index d828d6cbeb0e..4baf9fafe462 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> @@ -953,9 +953,9 @@ static __le64 *arm_smmu_get_cd_ptr(struct
>> arm_smmu_domain *smmu_domain,
>>  	unsigned int idx;
>>  	struct arm_smmu_l1_ctx_desc *l1_desc;
>>  	struct arm_smmu_device *smmu = smmu_domain->smmu;
>> -	struct arm_smmu_ctx_desc_cfg *cdcfg = &smmu_domain->s1_cfg.cdcfg;
>> +	struct arm_smmu_ctx_desc_cfg *cdcfg =
>> &smmu_domain->s1_cfg->cdcfg;
>>
>> -	if (smmu_domain->s1_cfg.s1fmt == STRTAB_STE_0_S1FMT_LINEAR)
>> +	if (smmu_domain->s1_cfg->s1fmt == STRTAB_STE_0_S1FMT_LINEAR)
>>  		return cdcfg->cdtab + ssid * CTXDESC_CD_DWORDS;
>>
>>  	idx = ssid >> CTXDESC_SPLIT;
>> @@ -990,7 +990,7 @@ int arm_smmu_write_ctx_desc(struct
>> arm_smmu_domain *smmu_domain, int ssid,
>>  	__le64 *cdptr;
>>  	struct arm_smmu_device *smmu = smmu_domain->smmu;
>>
>> -	if (WARN_ON(ssid >= (1 << smmu_domain->s1_cfg.s1cdmax)))
>> +	if (WARN_ON(ssid >= (1 << smmu_domain->s1_cfg->s1cdmax)))
>>  		return -E2BIG;
>>
>>  	cdptr = arm_smmu_get_cd_ptr(smmu_domain, ssid);
>> @@ -1056,7 +1056,7 @@ static int arm_smmu_alloc_cd_tables(struct
>> arm_smmu_domain *smmu_domain)
>>  	size_t l1size;
>>  	size_t max_contexts;
>>  	struct arm_smmu_device *smmu = smmu_domain->smmu;
>> -	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
>> +	struct arm_smmu_s1_cfg *cfg = smmu_domain->s1_cfg;
>>  	struct arm_smmu_ctx_desc_cfg *cdcfg = &cfg->cdcfg;
>>
>>  	max_contexts = 1 << cfg->s1cdmax;
>> @@ -1104,7 +1104,7 @@ static void arm_smmu_free_cd_tables(struct
>> arm_smmu_domain *smmu_domain)
>>  	int i;
>>  	size_t size, l1size;
>>  	struct arm_smmu_device *smmu = smmu_domain->smmu;
>> -	struct arm_smmu_ctx_desc_cfg *cdcfg = &smmu_domain->s1_cfg.cdcfg;
>> +	struct arm_smmu_ctx_desc_cfg *cdcfg =
>> &smmu_domain->s1_cfg->cdcfg;
>>
>>  	if (cdcfg->l1_desc) {
>>  		size = CTXDESC_L2_ENTRIES * (CTXDESC_CD_DWORDS << 3);
>> @@ -1211,17 +1211,8 @@ static void arm_smmu_write_strtab_ent(struct
>> arm_smmu_master *master, u32 sid,
>>  	}
>>
>>  	if (smmu_domain) {
>> -		switch (smmu_domain->stage) {
>> -		case ARM_SMMU_DOMAIN_S1:
>> -			s1_cfg = &smmu_domain->s1_cfg;
>> -			break;
>> -		case ARM_SMMU_DOMAIN_S2:
>> -		case ARM_SMMU_DOMAIN_NESTED:
>> -			s2_cfg = &smmu_domain->s2_cfg;
>> -			break;
>> -		default:
>> -			break;
>> -		}
>> +		s1_cfg = smmu_domain->s1_cfg;
>> +		s2_cfg = smmu_domain->s2_cfg;
>>  	}
>>
>>  	if (val & STRTAB_STE_0_V) {
>> @@ -1664,10 +1655,10 @@ static void arm_smmu_tlb_inv_context(void
>> *cookie)
>>  	 * careful, 007.
>>  	 */
>>  	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
>> -		arm_smmu_tlb_inv_asid(smmu, smmu_domain->s1_cfg.cd.asid);
>> +		arm_smmu_tlb_inv_asid(smmu, smmu_domain->s1_cfg->cd.asid);
>>  	} else {
>>  		cmd.opcode	= CMDQ_OP_TLBI_S12_VMALL;
>> -		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
>> +		cmd.tlbi.vmid	= smmu_domain->s2_cfg->vmid;
>>  		arm_smmu_cmdq_issue_cmd(smmu, &cmd);
>>  		arm_smmu_cmdq_issue_sync(smmu);
>>  	}
>> @@ -1693,10 +1684,10 @@ static void arm_smmu_tlb_inv_range(unsigned
>> long iova, size_t size,
>>
>>  	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
>>  		cmd.opcode	= CMDQ_OP_TLBI_NH_VA;
>> -		cmd.tlbi.asid	= smmu_domain->s1_cfg.cd.asid;
>> +		cmd.tlbi.asid	= smmu_domain->s1_cfg->cd.asid;
>>  	} else {
>>  		cmd.opcode	= CMDQ_OP_TLBI_S2_IPA;
>> -		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
>> +		cmd.tlbi.vmid	= smmu_domain->s2_cfg->vmid;
>>  	}
>>
>>  	if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
>> @@ -1846,24 +1837,25 @@ static void arm_smmu_domain_free(struct
>> iommu_domain *domain)
>>  {
>>  	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>>  	struct arm_smmu_device *smmu = smmu_domain->smmu;
>> +	struct arm_smmu_s1_cfg *s1_cfg = smmu_domain->s1_cfg;
>> +	struct arm_smmu_s2_cfg *s2_cfg = smmu_domain->s2_cfg;
>>
>>  	iommu_put_dma_cookie(domain);
>>  	free_io_pgtable_ops(smmu_domain->pgtbl_ops);
>>
>>  	/* Free the CD and ASID, if we allocated them */
>> -	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
>> -		struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
>> -
>> -		/* Prevent SVA from touching the CD while we're freeing it */
>> +	if (s1_cfg) {
>>  		mutex_lock(&arm_smmu_asid_lock);
>> -		if (cfg->cdcfg.cdtab)
>> +		/* Prevent SVA from touching the CD while we're freeing it */
>> +		if (s1_cfg->cdcfg.cdtab)
>>  			arm_smmu_free_cd_tables(smmu_domain);
>> -		arm_smmu_free_asid(&cfg->cd);
>> +		arm_smmu_free_asid(&s1_cfg->cd);
>>  		mutex_unlock(&arm_smmu_asid_lock);
>> -	} else {
>> -		struct arm_smmu_s2_cfg *cfg = &smmu_domain->s2_cfg;
>> -		if (cfg->vmid)
>> -			arm_smmu_bitmap_free(smmu->vmid_map, cfg->vmid);
>> +	}
>> +	if (s2_cfg) {
>> +		if (s2_cfg->vmid)
>> +			arm_smmu_bitmap_free(smmu->vmid_map, s2_cfg->vmid);
>> +		kfree(s2_cfg);
>>  	}
>>
>>  	kfree(smmu_domain);
>> @@ -1876,8 +1868,11 @@ static int arm_smmu_domain_finalise_s1(struct
>> arm_smmu_domain *smmu_domain,
>>  	int ret;
>>  	u32 asid;
>>  	struct arm_smmu_device *smmu = smmu_domain->smmu;
>> -	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
>>  	typeof(&pgtbl_cfg->arm_lpae_s1_cfg.tcr) tcr =
>> &pgtbl_cfg->arm_lpae_s1_cfg.tcr;
>> +	struct arm_smmu_s1_cfg *cfg = kzalloc(sizeof(*cfg), GFP_KERNEL);
>> +
>> +	if (!cfg)
>> +		return -ENOMEM;
>>
>>  	refcount_set(&cfg->cd.refs, 1);
>>
>> @@ -1890,6 +1885,8 @@ static int arm_smmu_domain_finalise_s1(struct
>> arm_smmu_domain *smmu_domain,
>>
>>  	cfg->s1cdmax = master->ssid_bits;
>>
>> +	smmu_domain->s1_cfg = cfg;
>> +
>>  	ret = arm_smmu_alloc_cd_tables(smmu_domain);
>>  	if (ret)
>>  		goto out_free_asid;
>> @@ -1922,6 +1919,8 @@ static int arm_smmu_domain_finalise_s1(struct
>> arm_smmu_domain *smmu_domain,
>>  out_free_asid:
>>  	arm_smmu_free_asid(&cfg->cd);
>>  out_unlock:
>> +	kfree(cfg);
>> +	smmu_domain->s1_cfg = NULL;
>>  	mutex_unlock(&arm_smmu_asid_lock);
>>  	return ret;
>>  }
>> @@ -1930,14 +1929,19 @@ static int arm_smmu_domain_finalise_s2(struct
>> arm_smmu_domain *smmu_domain,
>>  				       struct arm_smmu_master *master,
>>  				       struct io_pgtable_cfg *pgtbl_cfg)
>>  {
>> -	int vmid;
>> +	int vmid, ret;
>>  	struct arm_smmu_device *smmu = smmu_domain->smmu;
>> -	struct arm_smmu_s2_cfg *cfg = &smmu_domain->s2_cfg;
>> +	struct arm_smmu_s2_cfg *cfg = kzalloc(sizeof(*cfg), GFP_KERNEL);
>>  	typeof(&pgtbl_cfg->arm_lpae_s2_cfg.vtcr) vtcr;
>>
>> +	if (!cfg)
>> +		return -ENOMEM;
>> +
>>  	vmid = arm_smmu_bitmap_alloc(smmu->vmid_map, smmu->vmid_bits);
>> -	if (vmid < 0)
>> -		return vmid;
>> +	if (vmid < 0) {
>> +		ret = vmid;
>> +		goto out_free_cfg;
>> +	}
>>
>>  	vtcr = &pgtbl_cfg->arm_lpae_s2_cfg.vtcr;
>>  	cfg->vmid	= (u16)vmid;
>> @@ -1949,7 +1953,12 @@ static int arm_smmu_domain_finalise_s2(struct
>> arm_smmu_domain *smmu_domain,
>>  			  FIELD_PREP(STRTAB_STE_2_VTCR_S2SH0, vtcr->sh) |
>>  			  FIELD_PREP(STRTAB_STE_2_VTCR_S2TG, vtcr->tg) |
>>  			  FIELD_PREP(STRTAB_STE_2_VTCR_S2PS, vtcr->ps);
>> +	smmu_domain->s2_cfg = cfg;
>>  	return 0;
>> +
>> +out_free_cfg:
>> +	kfree(cfg);
>> +	return ret;
>>  }
>>
>>  static int arm_smmu_domain_finalise(struct iommu_domain *domain,
>> @@ -2231,10 +2240,10 @@ static int arm_smmu_attach_dev(struct
>> iommu_domain *domain, struct device *dev)
>>  		ret = -ENXIO;
>>  		goto out_unlock;
>>  	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 &&
>> -		   master->ssid_bits != smmu_domain->s1_cfg.s1cdmax) {
>> +		   master->ssid_bits != smmu_domain->s1_cfg->s1cdmax) {
>>  		dev_err(dev,
>>  			"cannot attach to incompatible domain (%u SSID bits != %u)\n",
>> -			smmu_domain->s1_cfg.s1cdmax, master->ssid_bits);
>> +			smmu_domain->s1_cfg->s1cdmax, master->ssid_bits);
>>  		ret = -EINVAL;
>>  		goto out_unlock;
>>  	}
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>> index 2944beb1571b..6fdc35b32dbf 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>> @@ -679,10 +679,8 @@ struct arm_smmu_domain {
>>  	atomic_t			nr_ats_masters;
>>
>>  	enum arm_smmu_domain_stage	stage;
>> -	union {
>> -		struct arm_smmu_s1_cfg	s1_cfg;
>> -		struct arm_smmu_s2_cfg	s2_cfg;
>> -	};
>> +	struct arm_smmu_s1_cfg	*s1_cfg;
>> +	struct arm_smmu_s2_cfg	*s2_cfg;
>>
>>  	struct iommu_domain		domain;
>>
>> --
>> 2.21.3
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
