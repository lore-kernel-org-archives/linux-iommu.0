Return-Path: <SRS0=eogA=LY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4835DC11F68
	for <iommu@archiver.kernel.org>; Wed, 30 Jun 2021 08:50:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 990D861CD7
	for <iommu@archiver.kernel.org>; Wed, 30 Jun 2021 08:50:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 990D861CD7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5FB684023E;
	Wed, 30 Jun 2021 08:50:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NLERfzg4eMb4; Wed, 30 Jun 2021 08:50:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1930F401E8;
	Wed, 30 Jun 2021 08:50:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D3F39C001A;
	Wed, 30 Jun 2021 08:50:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0349AC000E
 for <iommu@lists.linux-foundation.org>; Wed, 30 Jun 2021 08:50:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D69BC83A6F
 for <iommu@lists.linux-foundation.org>; Wed, 30 Jun 2021 08:50:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id et4p_DSfvosQ for <iommu@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 08:50:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 56D7983A67
 for <iommu@lists.linux-foundation.org>; Wed, 30 Jun 2021 08:50:34 +0000 (UTC)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GFFMv58LFzZp54;
 Wed, 30 Jun 2021 16:47:23 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 30 Jun 2021 16:50:30 +0800
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 30 Jun 2021 16:50:28 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2176.012; Wed, 30 Jun 2021 09:50:26 +0100
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Jon Nettleton <jon@solid-run.com>, Robin Murphy <robin.murphy@arm.com>
Subject: RE: [PATCH v5 7/8] iommu/arm-smmu: Get associated RMR info and
 install bypass SMR
Thread-Topic: [PATCH v5 7/8] iommu/arm-smmu: Get associated RMR info and
 install bypass SMR
Thread-Index: AQHXUIyLvua7xjhPQkeDex9n58702KsTV/iAgBdgBoCAAGnfAIAAMyCAgAEihEA=
Date: Wed, 30 Jun 2021 08:50:26 +0000
Message-ID: <d2223be42ce9497da8c02a87558beab6@huawei.com>
References: <20210524110222.2212-1-shameerali.kolothum.thodi@huawei.com>
 <20210524110222.2212-8-shameerali.kolothum.thodi@huawei.com>
 <2bc3ae21-f2af-ee2c-5e9d-d47633e0439e@arm.com>
 <CABdtJHtpN7s2gTwUkeWcachOnk6djgMaJLGtnKq5SExA82bDDA@mail.gmail.com>
 <b33c1525-5a74-a985-fd39-f4df8614f210@arm.com>
 <CABdtJHsz+ycVffJTyekau_OY6ROmoTBWAGd_guikxauT=nnuJQ@mail.gmail.com>
In-Reply-To: <CABdtJHsz+ycVffJTyekau_OY6ROmoTBWAGd_guikxauT=nnuJQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.82.108]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: Linuxarm <linuxarm@huawei.com>, Steven
 Price <steven.price@arm.com>, ACPI Devel
 Maling List <linux-acpi@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 wanghuiqiang <wanghuiqiang@huawei.com>,
 "Guohanjun \(Hanjun Guo\)" <guohanjun@huawei.com>,
 yangyicong <yangyicong@huawei.com>,
 "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
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



> -----Original Message-----
> From: Jon Nettleton [mailto:jon@solid-run.com]
> Sent: 29 June 2021 17:26
> To: Robin Murphy <robin.murphy@arm.com>
> Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
> linux-arm-kernel <linux-arm-kernel@lists.infradead.org>; ACPI Devel Maling
> List <linux-acpi@vger.kernel.org>; iommu@lists.linux-foundation.org; Linuxarm
> <linuxarm@huawei.com>; Steven Price <steven.price@arm.com>; Guohanjun
> (Hanjun Guo) <guohanjun@huawei.com>; yangyicong
> <yangyicong@huawei.com>; Sami.Mujawar@arm.com; wanghuiqiang
> <wanghuiqiang@huawei.com>
> Subject: Re: [PATCH v5 7/8] iommu/arm-smmu: Get associated RMR info and
> install bypass SMR
> 

[...]
 
> Shameer,
> 
> Sorry for the delays.  Here is a diff of the changes that should
> address the issues pointed out by Robin,
> I have tested that this works as expected on my HoneyComb LX2160A.

Ok. Thanks for that.

> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index ab7b9db77625..a358bd326d0b 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -2068,29 +2068,21 @@ static void
> arm_smmu_rmr_install_bypass_smr(struct arm_smmu_device *smmu)
>         struct list_head rmr_list;
>         struct iommu_resv_region *e;
>         int i, cnt = 0;
> -       u32 smr;
>         u32 reg;
> 
>         INIT_LIST_HEAD(&rmr_list);
>         if (iommu_dma_get_rmrs(dev_fwnode(smmu->dev), &rmr_list))
>                 return;
> 
> -       reg = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_sCR0);
> +       /* Rather than trying to look at existing mappings that
> +        * are setup by the firmware and then invalidate the ones
> +        * that do no have matching RMR entries, just disable the
> +        * SMMU until it gets enabled again in the reset routine.
> +        */
> 
> -       if ((reg & ARM_SMMU_sCR0_USFCFG) && !(reg &
> ARM_SMMU_sCR0_CLIENTPD)) {
> -               /*
> -                * SMMU is already enabled and disallowing bypass, so
> preserve
> -                * the existing SMRs
> -                */
> -               for (i = 0; i < smmu->num_mapping_groups; i++) {
> -                       smr = arm_smmu_gr0_read(smmu,
> ARM_SMMU_GR0_SMR(i));
> -                       if (!FIELD_GET(ARM_SMMU_SMR_VALID, smr))
> -                               continue;
> -                       smmu->smrs[i].id =
> FIELD_GET(ARM_SMMU_SMR_ID, smr);
> -                       smmu->smrs[i].mask =
> FIELD_GET(ARM_SMMU_SMR_MASK, smr);
> -                       smmu->smrs[i].valid = true;
> -               }
> -       }
> +       reg = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_sCR0);
> +       reg &= ~ARM_SMMU_sCR0_CLIENTPD;
> +       arm_smmu_gr0_write(smmu, ARM_SMMU_GR0_sCR0, reg);
> 
>         list_for_each_entry(e, &rmr_list, list) {
>                 u32 sid = e->fw_data.rmr.sid;
> @@ -2100,25 +2092,16 @@ static void
> arm_smmu_rmr_install_bypass_smr(struct arm_smmu_device *smmu)
>                         continue;
>                 if (smmu->s2crs[i].count == 0) {
>                         smmu->smrs[i].id = sid;
> -                       smmu->smrs[i].mask = ~0;
> +                       smmu->smrs[i].mask = 0;
>                         smmu->smrs[i].valid = true;
>                 }
>                 smmu->s2crs[i].count++;
>                 smmu->s2crs[i].type = S2CR_TYPE_BYPASS;
>                 smmu->s2crs[i].privcfg = S2CR_PRIVCFG_DEFAULT;
> -               smmu->s2crs[i].cbndx = 0xff;
> 
>                 cnt++;
>         }
> 
> -       if ((reg & ARM_SMMU_sCR0_USFCFG) && !(reg &
> ARM_SMMU_sCR0_CLIENTPD)) {
> -               /* Remove the valid bit for unused SMRs */
> -               for (i = 0; i < smmu->num_mapping_groups; i++) {
> -                       if (smmu->s2crs[i].count == 0)
> -                               smmu->smrs[i].valid = false;
> -               }
> -       }
> -
>         dev_notice(smmu->dev, "\tpreserved %d boot mapping%s\n", cnt,
>                    cnt == 1 ? "" : "s");
>         iommu_dma_put_rmrs(dev_fwnode(smmu->dev), &rmr_list);
> 
> Please include that in your next patch series.  Let me know if you
> want me to send you the patch direct
> off the list.

No problem, I will take this in next.

Thanks,
Shameer
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
