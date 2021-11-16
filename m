Return-Path: <SRS0=BhyV=QD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10FBC433F5
	for <iommu@archiver.kernel.org>; Tue, 16 Nov 2021 12:06:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1EE961B3D
	for <iommu@archiver.kernel.org>; Tue, 16 Nov 2021 12:06:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A1EE961B3D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 605114047A;
	Tue, 16 Nov 2021 12:06:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NtIom-s35I3j; Tue, 16 Nov 2021 12:06:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4E97E4047C;
	Tue, 16 Nov 2021 12:06:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 315BFC001E;
	Tue, 16 Nov 2021 12:06:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F1403C0012
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 12:06:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D21194047C
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 12:06:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5cgseoke9nHO for <iommu@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 12:06:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0E8C54047A
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 12:06:44 +0000 (UTC)
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HtlCZ3mXzz67bJm;
 Tue, 16 Nov 2021 20:06:34 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 16 Nov 2021 13:06:41 +0100
Received: from [10.47.82.31] (10.47.82.31) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Tue, 16 Nov
 2021 12:06:40 +0000
Subject: Re: [PATCH 2/2] perf/smmuv3: Add devicetree support
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, <robh+dt@kernel.org>
References: <20211116113536.69758-1-jean-philippe@linaro.org>
 <20211116113536.69758-3-jean-philippe@linaro.org>
From: John Garry <john.garry@huawei.com>
Message-ID: <0f410098-2a58-9024-9fe4-77fb54b2a076@huawei.com>
Date: Tue, 16 Nov 2021 12:06:36 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20211116113536.69758-3-jean-philippe@linaro.org>
Content-Language: en-US
X-Originating-IP: [10.47.82.31]
X-ClientProxiedBy: lhreml706-chm.china.huawei.com (10.201.108.55) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, will@kernel.org,
 iommu@lists.linux-foundation.org, uchida.jun@socionext.com, leo.yan@linaro.org,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org
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

On 16/11/2021 11:35, Jean-Philippe Brucker wrote:
> Add device-tree support to the SMMUv3 PMCG.  One small cosmetic change
> while factoring the option mask printout: don't display it when zero, it
> only contains one erratum at the moment.
> 
> Signed-off-by: Jay Chen <jkchen@linux.alibaba.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>   drivers/perf/arm_smmuv3_pmu.c | 25 +++++++++++++++++++++++--
>   1 file changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
> index 226348822ab3..958325ac103a 100644
> --- a/drivers/perf/arm_smmuv3_pmu.c
> +++ b/drivers/perf/arm_smmuv3_pmu.c
> @@ -47,6 +47,7 @@
>   #include <linux/kernel.h>
>   #include <linux/list.h>
>   #include <linux/msi.h>
> +#include <linux/of.h>
>   #include <linux/perf_event.h>
>   #include <linux/platform_device.h>
>   #include <linux/smp.h>
> @@ -750,8 +751,15 @@ static void smmu_pmu_get_acpi_options(struct smmu_pmu *smmu_pmu)
>   		smmu_pmu->options |= SMMU_PMCG_EVCNTR_RDONLY;
>   		break;
>   	}
> +}
> +
> +static void smmu_pmu_get_of_options(struct smmu_pmu *smmu_pmu)
> +{
> +	struct device_node *node = smmu_pmu->dev->of_node;
>   
> -	dev_notice(smmu_pmu->dev, "option mask 0x%x\n", smmu_pmu->options);
> +	if (of_device_is_compatible(node, "hisilicon,smmu-v3-pmcg-hip08"))

I don't think that this is necessary. We don't support DT for hip08, nor 
have any plans to. Incidentally, was this binding missing in your series?

Thanks,
John

> +		/* HiSilicon Erratum 162001800 */
> +		smmu_pmu->options |= SMMU_PMCG_EVCNTR_RDONLY;
>   }
>   
>   static int smmu_pmu_probe(struct platform_device *pdev)
> @@ -834,7 +842,13 @@ static int smmu_pmu_probe(struct platform_device *pdev)
>   		return -EINVAL;
>   	}
>   
> -	smmu_pmu_get_acpi_options(smmu_pmu);
> +	if (dev->of_node)
> +		smmu_pmu_get_of_options(smmu_pmu);
> +	else
> +		smmu_pmu_get_acpi_options(smmu_pmu);
> +
> +	if (smmu_pmu->options)
> +		dev_notice(dev, "option mask 0x%x\n", smmu_pmu->options);
>   
>   	/* Pick one CPU to be the preferred one to use */
>   	smmu_pmu->on_cpu = raw_smp_processor_id();
> @@ -884,10 +898,17 @@ static void smmu_pmu_shutdown(struct platform_device *pdev)
>   	smmu_pmu_disable(&smmu_pmu->pmu);
>   }
>   
> +static const struct of_device_id arm_smmu_pmu_match[] = {
> +	{ .compatible = "arm,smmu-v3-pmcg" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, arm_smmu_pmu_match);
> +
>   static struct platform_driver smmu_pmu_driver = {
>   	.driver = {
>   		.name = "arm-smmu-v3-pmcg",
>   		.suppress_bind_attrs = true,
> +		.of_match_table = of_match_ptr(arm_smmu_pmu_match),
>   	},
>   	.probe = smmu_pmu_probe,
>   	.remove = smmu_pmu_remove,
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
