Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5E12C433EF
	for <iommu@archiver.kernel.org>; Mon,  6 Dec 2021 14:48:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 73D0860C33;
	Mon,  6 Dec 2021 14:48:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u8Ua1YFrwhV4; Mon,  6 Dec 2021 14:48:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4203160C2D;
	Mon,  6 Dec 2021 14:48:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2DDD2C001E;
	Mon,  6 Dec 2021 14:48:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 61707C0012
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 14:48:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5101D405D7
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 14:48:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JEE17PB5_Keh for <iommu@lists.linux-foundation.org>;
 Mon,  6 Dec 2021 14:48:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 30D614044C
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 14:48:10 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7535D1FB;
 Mon,  6 Dec 2021 06:48:09 -0800 (PST)
Received: from [10.57.34.58] (unknown [10.57.34.58])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E46123F5A1;
 Mon,  6 Dec 2021 06:48:07 -0800 (PST)
Message-ID: <76a1cc8a-562e-1474-1c26-c2c391cb978f@arm.com>
Date: Mon, 6 Dec 2021 14:48:02 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [RFC PATCH] per device enable smmu whem iommu passthrough
Content-Language: en-GB
To: Jay Chen <jkchen@linux.alibaba.com>, will@kernel.org, joro@8bytes.org,
 inux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org,
 linux-doc@vger.kernel.org
References: <20211130081440.12397-1-jkchen@linux.alibaba.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20211130081440.12397-1-jkchen@linux.alibaba.com>
Cc: zhangliguang@linux.alibaba.com
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

On 2021-11-30 08:14, Jay Chen wrote:
> Currently, when iommu.passthrough=1 is set,
> all arm smmu peripherals are bypassed. This
> patch allows specific peripherals to use smmu translate.

The existing solution for this is the sysfs interface, where the usage 
model is to start up with translation as the default, then from an 
initrd or later userspace, reconfigure certain "trusted" devices into 
passthrough before loading their drivers (technically you *could* do it 
the other way round too, but that makes a lot less sense from a 
trust/privilege point of view). See the original discussion for some of 
the reasons why a command-line interface isn't really viable:

https://lore.kernel.org/linux-iommu/FFF73D592F13FD46B8700F0A279B802F48DA796E@ORSMSX114.amr.corp.intel.com/

Furthermore, usual comment about there being no reason for this to be 
specific to any particular driver.

Thanks,
Robin.

> Signed-off-by: Jay Chen <jkchen@linux.alibaba.com>
> ---
>   .../admin-guide/kernel-parameters.txt         |  6 +++
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 41 +++++++++++++++++++
>   2 files changed, 47 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 91ba391f9b32..7ecc7a4c84d7 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2076,6 +2076,12 @@
>   			1 - Bypass the IOMMU for DMA.
>   			unset - Use value of CONFIG_IOMMU_DEFAULT_PASSTHROUGH.
>   
> +	smmuv3_no_passthrough=
> +			[ARM64] enable smmu for devices when iommu.passthrough=1.
> +			Format: {83:00.0,84:00.0,devname}
> +			83:00.0 - the bdf for one pci devices
> +			devname - the name for the platform device
> +
>   	io7=		[HW] IO7 for Marvel-based Alpha systems
>   			See comment before marvel_specify_io7 in
>   			arch/alpha/kernel/core_marvel.c.
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index a388e318f86e..e2a57bd37f32 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -76,6 +76,8 @@ struct arm_smmu_option_prop {
>   DEFINE_XARRAY_ALLOC1(arm_smmu_asid_xa);
>   DEFINE_MUTEX(arm_smmu_asid_lock);
>   
> +char *smmuv3_nopt;
> +
>   /*
>    * Special value used by SVA when a process dies, to quiesce a CD without
>    * disabling it.
> @@ -102,6 +104,17 @@ static void parse_driver_options(struct arm_smmu_device *smmu)
>   	} while (arm_smmu_options[++i].opt);
>   }
>   
> +static int __init arm_smmu_no_passthrough_setup(char *str)
> +{
> +	if (!str)
> +		return -EINVAL;
> +
> +	smmuv3_nopt = str;
> +
> +	return 0;
> +}
> +__setup("smmuv3_no_passthrough=", arm_smmu_no_passthrough_setup);
> +
>   /* Low-level queue manipulation functions */
>   static bool queue_has_space(struct arm_smmu_ll_queue *q, u32 n)
>   {
> @@ -2831,6 +2844,33 @@ static int arm_smmu_dev_disable_feature(struct device *dev,
>   	}
>   }
>   
> +static int arm_smmu_def_domain_type(struct device *dev)
> +{
> +	char *str = smmuv3_nopt;
> +	const char *tmp;
> +
> +	if (!dev || !str)
> +		return 0;
> +
> +	if (dev_is_pci(dev)) {
> +		tmp = dev_name(dev);
> +		tmp += strcspn(tmp, ":") + 1;
> +	} else {
> +		tmp = dev_name(dev);
> +	}
> +
> +	while (*str) {
> +		if (!strncmp(str, tmp, strlen(tmp)))
> +			return IOMMU_DOMAIN_DMA;
> +
> +		str += strcspn(str, ",");
> +		while (*str == ',')
> +			str++;
> +	}
> +
> +	return 0;
> +}
> +
>   static struct iommu_ops arm_smmu_ops = {
>   	.capable		= arm_smmu_capable,
>   	.domain_alloc		= arm_smmu_domain_alloc,
> @@ -2856,6 +2896,7 @@ static struct iommu_ops arm_smmu_ops = {
>   	.sva_unbind		= arm_smmu_sva_unbind,
>   	.sva_get_pasid		= arm_smmu_sva_get_pasid,
>   	.page_response		= arm_smmu_page_response,
> +	.def_domain_type	= arm_smmu_def_domain_type,
>   	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
>   	.owner			= THIS_MODULE,
>   };
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
