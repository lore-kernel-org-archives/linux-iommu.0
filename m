Return-Path: <SRS0=XGcg=MI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F909C12002
	for <iommu@archiver.kernel.org>; Fri, 16 Jul 2021 13:52:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05E7E613F5
	for <iommu@archiver.kernel.org>; Fri, 16 Jul 2021 13:52:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05E7E613F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BDDBA424BF;
	Fri, 16 Jul 2021 13:52:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jA9OSxE-hMDk; Fri, 16 Jul 2021 13:52:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 03633424B3;
	Fri, 16 Jul 2021 13:52:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A98E3C001A;
	Fri, 16 Jul 2021 13:52:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4AA28C000E
 for <iommu@lists.linux-foundation.org>; Fri, 16 Jul 2021 13:52:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 37AE6424BB
 for <iommu@lists.linux-foundation.org>; Fri, 16 Jul 2021 13:52:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JUcCRRaz1m2v for <iommu@lists.linux-foundation.org>;
 Fri, 16 Jul 2021 13:52:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 72F9F424B3
 for <iommu@lists.linux-foundation.org>; Fri, 16 Jul 2021 13:52:47 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93C26D6E;
 Fri, 16 Jul 2021 06:52:46 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A1C043F774;
 Fri, 16 Jul 2021 06:52:44 -0700 (PDT)
Subject: Re: [PATCH v6 8/9] iommu/arm-smmu: Get associated RMR info and
 install bypass SMR
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org
References: <20210716083442.1708-1-shameerali.kolothum.thodi@huawei.com>
 <20210716083442.1708-9-shameerali.kolothum.thodi@huawei.com>
From: Steven Price <steven.price@arm.com>
Message-ID: <b73d3408-7b2e-4cab-3b8c-efc22d08d99e@arm.com>
Date: Fri, 16 Jul 2021 14:52:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210716083442.1708-9-shameerali.kolothum.thodi@huawei.com>
Content-Language: en-GB
Cc: jon@solid-run.com, linuxarm@huawei.com, guohanjun@huawei.com,
 yangyicong@huawei.com, Sami.Mujawar@arm.com, robin.murphy@arm.com,
 wanghuiqiang@huawei.com
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

On 16/07/2021 09:34, Shameer Kolothum wrote:
> From: Jon Nettleton <jon@solid-run.com>
> 
> Check if there is any RMR info associated with the devices behind
> the SMMU and if any, install bypass SMRs for them. This is to
> keep any ongoing traffic associated with these devices alive
> when we enable/reset SMMU during probe().
> 
> Signed-off-by: Jon Nettleton <jon@solid-run.com>
> Signed-off-by: Steven Price <steven.price@arm.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu.c | 48 +++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index f22dbeb1e510..e9fb3d962a86 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -2063,6 +2063,50 @@ err_reset_platform_ops: __maybe_unused;
>  	return err;
>  }
>  
> +static void arm_smmu_rmr_install_bypass_smr(struct arm_smmu_device *smmu)
> +{
> +	struct list_head rmr_list;
> +	struct iommu_resv_region *e;
> +	int i, cnt = 0;
> +	u32 reg;
> +
> +	INIT_LIST_HEAD(&rmr_list);
> +	if (iommu_dma_get_rmrs(dev_fwnode(smmu->dev), &rmr_list))
> +		return;
> +
> +	/*
> +	 * Rather than trying to look at existing mappings that
> +	 * are setup by the firmware and then invalidate the ones
> +	 * that do no have matching RMR entries, just disable the
> +	 * SMMU until it gets enabled again in the reset routine.
> +	 */
> +	reg = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_sCR0);
> +	reg &= ~ARM_SMMU_sCR0_CLIENTPD;

This looks backwards, the spec states:

  Client Port Disable. The possible values of this bit are:
  0 - Each SMMU client access is subject to SMMU translation, access
      control, and attribute generation.
  1 - Each SMMU client access bypasses SMMU translation, access control,
      and attribute generation.
  This bit resets to 1.

And indeed with the current code if sCR0_USFCFG was set when
sCR0_CLIENTPD is cleared then I get a blank screen until the smmu is reset.

So I believe this should be ORing in the value, i.e.

  reg |= ARM_SMMU_sCR0_CLIENTPD;

And in my testing that works fine even if sCR0_USFCFG is set.

Steve

> +	arm_smmu_gr0_write(smmu, ARM_SMMU_GR0_sCR0, reg);
> +
> +	list_for_each_entry(e, &rmr_list, list) {
> +		u32 sid = e->fw_data.rmr.sid;
> +
> +		i = arm_smmu_find_sme(smmu, sid, ~0);
> +		if (i < 0)
> +			continue;
> +		if (smmu->s2crs[i].count == 0) {
> +			smmu->smrs[i].id = sid;
> +			smmu->smrs[i].mask = 0;
> +			smmu->smrs[i].valid = true;
> +		}
> +		smmu->s2crs[i].count++;
> +		smmu->s2crs[i].type = S2CR_TYPE_BYPASS;
> +		smmu->s2crs[i].privcfg = S2CR_PRIVCFG_DEFAULT;
> +
> +		cnt++;
> +	}
> +
> +	dev_notice(smmu->dev, "\tpreserved %d boot mapping%s\n", cnt,
> +		   cnt == 1 ? "" : "s");
> +	iommu_dma_put_rmrs(dev_fwnode(smmu->dev), &rmr_list);
> +}
> +
>  static int arm_smmu_device_probe(struct platform_device *pdev)
>  {
>  	struct resource *res;
> @@ -2189,6 +2233,10 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>  	}
>  
>  	platform_set_drvdata(pdev, smmu);
> +
> +	/* Check for RMRs and install bypass SMRs if any */
> +	arm_smmu_rmr_install_bypass_smr(smmu);
> +
>  	arm_smmu_device_reset(smmu);
>  	arm_smmu_test_smr_masks(smmu);
>  
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
