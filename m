Return-Path: <SRS0=54Vi=BN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B9FC433DF
	for <iommu@archiver.kernel.org>; Mon,  3 Aug 2020 15:35:40 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69FB820781
	for <iommu@archiver.kernel.org>; Mon,  3 Aug 2020 15:35:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69FB820781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1AAC287A8D;
	Mon,  3 Aug 2020 15:35:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3c08RkZi+1qr; Mon,  3 Aug 2020 15:35:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 237B687985;
	Mon,  3 Aug 2020 15:35:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 08D07C0051;
	Mon,  3 Aug 2020 15:35:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A7475C004C
 for <iommu@lists.linux-foundation.org>; Mon,  3 Aug 2020 15:35:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 90B6F856BF
 for <iommu@lists.linux-foundation.org>; Mon,  3 Aug 2020 15:35:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jOUDDZQOS-kk for <iommu@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 15:35:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (lhrrgout.huawei.com [185.176.76.210])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 66F0085534
 for <iommu@lists.linux-foundation.org>; Mon,  3 Aug 2020 15:35:37 +0000 (UTC)
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.107])
 by Forcepoint Email with ESMTP id C5EA510B5D7074DBF6D8;
 Mon,  3 Aug 2020 16:35:34 +0100 (IST)
Received: from [127.0.0.1] (10.210.168.55) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 3 Aug 2020
 16:35:34 +0100
Subject: Re: [PATCH v3] iommu/arm-smmu-v3: permit users to disable MSI polling
To: Barry Song <song.bao.hua@hisilicon.com>, <will@kernel.org>,
 <robin.murphy@arm.com>, <joro@8bytes.org>, <iommu@lists.linux-foundation.org>
References: <20200801074703.17108-1-song.bao.hua@hisilicon.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <494d71d4-7718-d09e-9171-b78d6a046cb6@huawei.com>
Date: Mon, 3 Aug 2020 16:33:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200801074703.17108-1-song.bao.hua@hisilicon.com>
Content-Language: en-US
X-Originating-IP: [10.210.168.55]
X-ClientProxiedBy: lhreml726-chm.china.huawei.com (10.201.108.77) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: linux-arm-kernel@lists.infradead.org, prime.zeng@hisilicon.com
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

On 01/08/2020 08:47, Barry Song wrote:
> Polling by MSI isn't necessarily faster than polling by SEV. Tests on
> hi1620 show hns3 100G NIC network throughput can improve from 25G to
> 27G if we disable MSI polling while running 16 netperf threads sending
> UDP packets in size 32KB.

BTW, Do we have any more results than this? This is just one scenario.

How about your micro-benchmark, which allows you to set the number of CPUs?

Thanks,
John

> This patch provides a command line option so that users can decide to
> use MSI polling or not based on their tests.
> 
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> ---
>   -v3:
>    * rebase on top of linux-next as arm-smmu-v3.c has moved;
>    * provide a command line option
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
