Return-Path: <SRS0=H7Zn=I4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1F7C433C1
	for <iommu@archiver.kernel.org>; Tue, 30 Mar 2021 09:24:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15E1E61982
	for <iommu@archiver.kernel.org>; Tue, 30 Mar 2021 09:24:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15E1E61982
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BC56A83CE6;
	Tue, 30 Mar 2021 09:24:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X3Ma-mvJ9Qm9; Tue, 30 Mar 2021 09:24:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id B006183D78;
	Tue, 30 Mar 2021 09:24:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7C084C000C;
	Tue, 30 Mar 2021 09:24:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BA8BFC000A
 for <iommu@lists.linux-foundation.org>; Tue, 30 Mar 2021 09:24:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A53B2402A8
 for <iommu@lists.linux-foundation.org>; Tue, 30 Mar 2021 09:24:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BlMAt0-m-2D7 for <iommu@lists.linux-foundation.org>;
 Tue, 30 Mar 2021 09:24:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 888F9402B0
 for <iommu@lists.linux-foundation.org>; Tue, 30 Mar 2021 09:24:08 +0000 (UTC)
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F8kVF4Ljjz9tHp;
 Tue, 30 Mar 2021 17:21:57 +0800 (CST)
Received: from [10.174.185.179] (10.174.185.179) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Tue, 30 Mar 2021 17:23:55 +0800
Subject: Re: [PATCH v14 13/13] iommu/smmuv3: Accept configs with more than one
 context descriptor
To: Eric Auger <eric.auger@redhat.com>
References: <20210223205634.604221-1-eric.auger@redhat.com>
 <20210223205634.604221-14-eric.auger@redhat.com>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <86614466-3c74-3a38-5f2e-6ac2f55c309a@huawei.com>
Date: Tue, 30 Mar 2021 17:23:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20210223205634.604221-14-eric.auger@redhat.com>
Content-Language: en-US
X-Originating-IP: [10.174.185.179]
X-CFilter-Loop: Reflected
Cc: kvm@vger.kernel.org, vivek.gautam@arm.com, kvmarm@lists.cs.columbia.edu,
 eric.auger.pro@gmail.com, jean-philippe@linaro.org, wangxingang5@huawei.com,
 maz@kernel.org, jiangkunkun@huawei.com, vsethi@nvidia.com,
 zhangfei.gao@linaro.org, will@kernel.org, alex.williamson@redhat.com,
 wanghaibin.wang@huawei.com, linux-kernel@vger.kernel.org,
 lushenming@huawei.com, iommu@lists.linux-foundation.org, robin.murphy@arm.com
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Eric,

On 2021/2/24 4:56, Eric Auger wrote:
> In preparation for vSVA, let's accept userspace provided configs
> with more than one CD. We check the max CD against the host iommu
> capability and also the format (linear versus 2 level).
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 332d31c0680f..ab74a0289893 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -3038,14 +3038,17 @@ static int arm_smmu_attach_pasid_table(struct iommu_domain *domain,
>   		if (smmu_domain->s1_cfg.set)
>   			goto out;
>   
> -		/*
> -		 * we currently support a single CD so s1fmt and s1dss
> -		 * fields are also ignored
> -		 */
> -		if (cfg->pasid_bits)
> +		list_for_each_entry(master, &smmu_domain->devices, domain_head) {
> +			if (cfg->pasid_bits > master->ssid_bits)
> +				goto out;
> +		}
> +		if (cfg->vendor_data.smmuv3.s1fmt == STRTAB_STE_0_S1FMT_64K_L2 &&
> +				!(smmu->features & ARM_SMMU_FEAT_2_LVL_CDTAB))
>   			goto out;
>   
>   		smmu_domain->s1_cfg.cdcfg.cdtab_dma = cfg->base_ptr;
> +		smmu_domain->s1_cfg.s1cdmax = cfg->pasid_bits;
> +		smmu_domain->s1_cfg.s1fmt = cfg->vendor_data.smmuv3.s1fmt;

And what about the SIDSS field?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
