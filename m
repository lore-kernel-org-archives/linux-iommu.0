Return-Path: <SRS0=2ATj=ZS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A79C432C0
	for <iommu@archiver.kernel.org>; Tue, 26 Nov 2019 09:28:45 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43AD220678
	for <iommu@archiver.kernel.org>; Tue, 26 Nov 2019 09:28:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43AD220678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7CAF386A48;
	Tue, 26 Nov 2019 09:28:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mmcI7t-zdGnX; Tue, 26 Nov 2019 09:28:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 021F086940;
	Tue, 26 Nov 2019 09:28:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DDDCAC0880;
	Tue, 26 Nov 2019 09:28:41 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1755DC0878
 for <iommu@lists.linuxfoundation.org>; Tue, 26 Nov 2019 09:28:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 004E786FF9
 for <iommu@lists.linuxfoundation.org>; Tue, 26 Nov 2019 09:28:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QLlDwl249uCa for <iommu@lists.linuxfoundation.org>;
 Tue, 26 Nov 2019 09:28:38 +0000 (UTC)
X-Greylist: delayed 00:15:14 by SQLgrey-1.7.6
Received: from huawei.com (lhrrgout.huawei.com [185.176.76.210])
 by hemlock.osuosl.org (Postfix) with ESMTPS id AB90286EA5
 for <iommu@lists.linuxfoundation.org>; Tue, 26 Nov 2019 09:28:38 +0000 (UTC)
Received: from lhreml706-cah.china.huawei.com (unknown [172.18.7.107])
 by Forcepoint Email with ESMTP id 35295FC91DF0DEC22361;
 Tue, 26 Nov 2019 09:13:22 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml706-cah.china.huawei.com (10.201.108.47) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 26 Nov 2019 09:13:21 +0000
Received: from [127.0.0.1] (10.202.226.46) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 26 Nov
 2019 09:13:21 +0000
Subject: Re: [PATCH v3 09/14] iommu/arm-smmu: Prevent forced unbinding of Arm
 SMMU drivers
To: Will Deacon <will@kernel.org>, <iommu@lists.linuxfoundation.org>,
 <linux-kernel@vger.kernel.org>
References: <20191121114918.2293-1-will@kernel.org>
 <20191121114918.2293-10-will@kernel.org>
From: John Garry <john.garry@huawei.com>
Message-ID: <5c91d467-5e59-482b-8f4f-e0cfa3db9028@huawei.com>
Date: Tue, 26 Nov 2019 09:13:20 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191121114918.2293-10-will@kernel.org>
Content-Language: en-US
X-Originating-IP: [10.202.226.46]
X-ClientProxiedBy: lhreml720-chm.china.huawei.com (10.201.108.71) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: "Isaac J. Manjarres" <isaacm@codeaurora.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, Saravana
 Kannan <saravanak@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>
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

On 21/11/2019 11:49, Will Deacon wrote:
> Forcefully unbinding the Arm SMMU drivers is a pretty dangerous operation,
> since it will likely lead to catastrophic failure for any DMA devices
> mastering through the SMMU being unbound. When the driver then attempts
> to "handle" the fatal faults, it's very easy to trip over dead data
> structures, leading to use-after-free.
> 
> On John's machine, he reports that the machine was "unusable" due to
> loss of the storage controller following a forced unbind of the SMMUv3
> driver:
> 
>    | # cd ./bus/platform/drivers/arm-smmu-v3
>    | # echo arm-smmu-v3.0.auto > unbind
>    | hisi_sas_v2_hw HISI0162:01: CQE_AXI_W_ERR (0x800) found!
>    | platform arm-smmu-v3.0.auto: CMD_SYNC timeout at 0x00000146
>    | [hwprod 0x00000146, hwcons 0x00000000]
> 
> Prevent this forced unbinding of the drivers by setting "suppress_bind_attrs"
> to true.

This seems a reasonable approach for now.

BTW, I'll give this series a spin this week, which again looks to be 
your iommu/module branch, excluding the new IORT patch.

Cheers,
John

> 
> Link: https://lore.kernel.org/lkml/06dfd385-1af0-3106-4cc5-6a5b8e864759@huawei.com
> Reported-by: John Garry <john.garry@huawei.com>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>   drivers/iommu/arm-smmu-v3.c | 5 +++--
>   drivers/iommu/arm-smmu.c    | 7 ++++---
>   2 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 2ad8e2ca0583..3fd75abce3bb 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -3700,8 +3700,9 @@ MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
>   
>   static struct platform_driver arm_smmu_driver = {
>   	.driver	= {
> -		.name		= "arm-smmu-v3",
> -		.of_match_table	= of_match_ptr(arm_smmu_of_match),
> +		.name			= "arm-smmu-v3",
> +		.of_match_table		= of_match_ptr(arm_smmu_of_match),
> +		.suppress_bind_attrs	= true,
>   	},
>   	.probe	= arm_smmu_device_probe,
>   	.remove	= arm_smmu_device_remove,
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 53bbe0663b9e..d6c83bd69555 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -2237,9 +2237,10 @@ static const struct dev_pm_ops arm_smmu_pm_ops = {
>   
>   static struct platform_driver arm_smmu_driver = {
>   	.driver	= {
> -		.name		= "arm-smmu",
> -		.of_match_table	= of_match_ptr(arm_smmu_of_match),
> -		.pm		= &arm_smmu_pm_ops,
> +		.name			= "arm-smmu",
> +		.of_match_table		= of_match_ptr(arm_smmu_of_match),
> +		.pm			= &arm_smmu_pm_ops,
> +		.suppress_bind_attrs    = true,
>   	},
>   	.probe	= arm_smmu_device_probe,
>   	.remove	= arm_smmu_device_remove,
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
