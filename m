Return-Path: <SRS0=xM8W=A2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D22DC433ED
	for <iommu@archiver.kernel.org>; Wed, 15 Jul 2020 10:20:46 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FA8D205CB
	for <iommu@archiver.kernel.org>; Wed, 15 Jul 2020 10:20:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FA8D205CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E5A7488126;
	Wed, 15 Jul 2020 10:20:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KP5sDun2GK2T; Wed, 15 Jul 2020 10:20:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id AAA9B879B1;
	Wed, 15 Jul 2020 10:20:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A14FDC0891;
	Wed, 15 Jul 2020 10:20:44 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0CC3BC0733
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jul 2020 10:20:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id EF6E68839E
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jul 2020 10:20:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IlBR4CPez8J1 for <iommu@lists.linux-foundation.org>;
 Wed, 15 Jul 2020 10:20:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id CF95588007
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jul 2020 10:20:41 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 320B930E;
 Wed, 15 Jul 2020 03:20:41 -0700 (PDT)
Received: from [10.57.32.45] (unknown [10.57.32.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50A073F718;
 Wed, 15 Jul 2020 03:20:39 -0700 (PDT)
Subject: Re: [PATCH v4 1/4] iommu/arm-smmu: Call configuration impl hook
 before consuming features
To: Tomasz Nowicki <tn@semihalf.com>, will@kernel.org, joro@8bytes.org,
 gregory.clement@bootlin.com, robh+dt@kernel.org, hannah@marvell.com
References: <20200715070649.18733-1-tn@semihalf.com>
 <20200715070649.18733-2-tn@semihalf.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <def8aa82-bcca-b209-a6b4-81725fc4fbdb@arm.com>
Date: Wed, 15 Jul 2020 11:20:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200715070649.18733-2-tn@semihalf.com>
Content-Language: en-GB
Cc: devicetree@vger.kernel.org, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, nadavh@marvell.com,
 iommu@lists.linux-foundation.org, mw@semihalf.com,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2020-07-15 08:06, Tomasz Nowicki wrote:
> 'cfg_probe' hook is called at the very end of configuration probing
> procedure and therefore features override and workaround may become
> complex like for ID register fixups. In preparation for adding Marvell
> errata move 'cfg_probe' a bit earlier to have chance to adjust
> the detected features before we start consuming them.
> 
> Since the Cavium quirk (the only user) does not alter features
> it is safe to do so.

Sorry for the confusion of failing to match my own intent in the first 
place ;)

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> ---
>   drivers/iommu/arm-smmu.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 243bc4cb2705..19f906de6420 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -1728,7 +1728,7 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
>   	unsigned int size;
>   	u32 id;
>   	bool cttw_reg, cttw_fw = smmu->features & ARM_SMMU_FEAT_COHERENT_WALK;
> -	int i;
> +	int i, ret;
>   
>   	dev_notice(smmu->dev, "probing hardware configuration...\n");
>   	dev_notice(smmu->dev, "SMMUv%d with:\n",
> @@ -1891,6 +1891,12 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
>   			smmu->features |= ARM_SMMU_FEAT_FMT_AARCH64_64K;
>   	}
>   
> +	if (smmu->impl && smmu->impl->cfg_probe) {
> +		ret = smmu->impl->cfg_probe(smmu);
> +		if (ret)
> +			return ret;
> +	}
> +
>   	/* Now we've corralled the various formats, what'll it do? */
>   	if (smmu->features & ARM_SMMU_FEAT_FMT_AARCH32_S)
>   		smmu->pgsize_bitmap |= SZ_4K | SZ_64K | SZ_1M | SZ_16M;
> @@ -1918,9 +1924,6 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
>   		dev_notice(smmu->dev, "\tStage-2: %lu-bit IPA -> %lu-bit PA\n",
>   			   smmu->ipa_size, smmu->pa_size);
>   
> -	if (smmu->impl && smmu->impl->cfg_probe)
> -		return smmu->impl->cfg_probe(smmu);
> -
>   	return 0;
>   }
>   
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
