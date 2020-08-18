Return-Path: <SRS0=kAxJ=B4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 327C4C433DF
	for <iommu@archiver.kernel.org>; Tue, 18 Aug 2020 14:31:23 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0310F206DA
	for <iommu@archiver.kernel.org>; Tue, 18 Aug 2020 14:31:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0310F206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id CEF2A87532;
	Tue, 18 Aug 2020 14:31:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M7YirHp92ucI; Tue, 18 Aug 2020 14:31:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id EF3CF87476;
	Tue, 18 Aug 2020 14:31:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C03ABC088B;
	Tue, 18 Aug 2020 14:31:21 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 18285C0051
 for <iommu@lists.linux-foundation.org>; Tue, 18 Aug 2020 14:31:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id F22988619A
 for <iommu@lists.linux-foundation.org>; Tue, 18 Aug 2020 14:31:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2upR8dPSfKGz for <iommu@lists.linux-foundation.org>;
 Tue, 18 Aug 2020 14:31:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9AF86861F4
 for <iommu@lists.linux-foundation.org>; Tue, 18 Aug 2020 14:31:18 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D533D1FB;
 Tue, 18 Aug 2020 07:31:17 -0700 (PDT)
Received: from [10.57.40.122] (unknown [10.57.40.122])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 916713F66B;
 Tue, 18 Aug 2020 07:31:16 -0700 (PDT)
Subject: Re: [PATCH v4] iommu/arm-smmu-v3: permit users to disable msi polling
To: Barry Song <song.bao.hua@hisilicon.com>, will@kernel.org, joro@8bytes.org
References: <20200818111752.18624-1-song.bao.hua@hisilicon.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <46ba8400-d3d8-c2bf-a912-b9b2828e3858@arm.com>
Date: Tue, 18 Aug 2020 15:31:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200818111752.18624-1-song.bao.hua@hisilicon.com>
Content-Language: en-GB
Cc: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org,
 prime.zeng@hisilicon.com, linuxarm@huawei.com
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

On 2020-08-18 12:17, Barry Song wrote:
> Polling by MSI isn't necessarily faster than polling by SEV. Tests on
> hi1620 show hns3 100G NIC network throughput can improve from 25G to
> 27G if we disable MSI polling while running 16 netperf threads sending
> UDP packets in size 32KB. TX throughput can improve from 7G to 7.7G for
> single thread.
> The reason for the throughput improvement is that the latency to poll
> the completion of CMD_SYNC becomes smaller. After sending a CMD_SYNC
> in an empty cmd queue, typically we need to wait for 280ns using MSI
> polling. But we only need around 190ns after disabling MSI polling.
> This patch provides a command line option so that users can decide to
> use MSI polling or not based on their tests.
> 
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> ---
>   -v4: rebase on top of 5.9-rc1
>   refine changelog
> 
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 18 ++++++++++++++----
>   1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 7196207be7ea..89d3cb391fef 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -418,6 +418,11 @@ module_param_named(disable_bypass, disable_bypass, bool, S_IRUGO);
>   MODULE_PARM_DESC(disable_bypass,
>   	"Disable bypass streams such that incoming transactions from devices that are not attached to an iommu domain will report an abort back to the device and will not be allowed to pass through the SMMU.");
>   
> +static bool disable_msipolling;
> +module_param_named(disable_msipolling, disable_msipolling, bool, S_IRUGO);

Just use module_param() - going out of the way to specify a "different" 
name that's identical to the variable name is silly.

Also I think the preference these days is to specify permissions as 
plain octal constants rather than those rather inscrutable macros. I 
certainly find that more readable myself.

(Yes, the existing parameter commits the same offences, but I'd rather 
clean that up separately than perpetuate it)

> +MODULE_PARM_DESC(disable_msipolling,
> +	"Disable MSI-based polling for CMD_SYNC completion.");
> +
>   enum pri_resp {
>   	PRI_RESP_DENY = 0,
>   	PRI_RESP_FAIL = 1,
> @@ -980,6 +985,13 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
>   	return 0;
>   }
>   
> +static bool arm_smmu_use_msipolling(struct arm_smmu_device *smmu)
> +{
> +	return !disable_msipolling &&
> +	       smmu->features & ARM_SMMU_FEAT_COHERENCY &&
> +	       smmu->features & ARM_SMMU_FEAT_MSI;
> +}

I'd wrap this up into a new ARM_SMMU_OPT_MSIPOLL flag set at probe time, 
rather than constantly reevaluating this whole expression (now that it's 
no longer simply testing two adjacent bits of the same word).

Robin.

> +
>   static void arm_smmu_cmdq_build_sync_cmd(u64 *cmd, struct arm_smmu_device *smmu,
>   					 u32 prod)
>   {
> @@ -992,8 +1004,7 @@ static void arm_smmu_cmdq_build_sync_cmd(u64 *cmd, struct arm_smmu_device *smmu,
>   	 * Beware that Hi16xx adds an extra 32 bits of goodness to its MSI
>   	 * payload, so the write will zero the entire command on that platform.
>   	 */
> -	if (smmu->features & ARM_SMMU_FEAT_MSI &&
> -	    smmu->features & ARM_SMMU_FEAT_COHERENCY) {
> +	if (arm_smmu_use_msipolling(smmu)) {
>   		ent.sync.msiaddr = q->base_dma + Q_IDX(&q->llq, prod) *
>   				   q->ent_dwords * 8;
>   	}
> @@ -1332,8 +1343,7 @@ static int __arm_smmu_cmdq_poll_until_consumed(struct arm_smmu_device *smmu,
>   static int arm_smmu_cmdq_poll_until_sync(struct arm_smmu_device *smmu,
>   					 struct arm_smmu_ll_queue *llq)
>   {
> -	if (smmu->features & ARM_SMMU_FEAT_MSI &&
> -	    smmu->features & ARM_SMMU_FEAT_COHERENCY)
> +	if (arm_smmu_use_msipolling(smmu))
>   		return __arm_smmu_cmdq_poll_until_msi(smmu, llq);
>   
>   	return __arm_smmu_cmdq_poll_until_consumed(smmu, llq);
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
