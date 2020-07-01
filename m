Return-Path: <SRS0=cxdO=AM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F47EC433DF
	for <iommu@archiver.kernel.org>; Wed,  1 Jul 2020 08:16:19 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ACAC206A1
	for <iommu@archiver.kernel.org>; Wed,  1 Jul 2020 08:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="aPd4B47o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ACAC206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A8F763019C;
	Wed,  1 Jul 2020 08:16:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TXYw2wVMKEHw; Wed,  1 Jul 2020 08:16:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 550E52FDA8;
	Wed,  1 Jul 2020 08:16:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 38459C0865;
	Wed,  1 Jul 2020 08:16:16 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42C51C0733
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jul 2020 08:16:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 2A59E8C36E
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jul 2020 08:16:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qepWc1TlbrlA for <iommu@lists.linux-foundation.org>;
 Wed,  1 Jul 2020 08:16:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from hqnvemgate25.nvidia.com (hqnvemgate25.nvidia.com
 [216.228.121.64])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 2164B8C308
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jul 2020 08:16:14 +0000 (UTC)
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5efc461b0000>; Wed, 01 Jul 2020 01:15:23 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Wed, 01 Jul 2020 01:16:13 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Wed, 01 Jul 2020 01:16:13 -0700
Received: from [10.26.73.166] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 1 Jul
 2020 08:16:04 +0000
Subject: Re: [PATCH v9 2/4] iommu/arm-smmu: add NVIDIA implementation for ARM
 MMU-500 usage
To: Krishna Reddy <vdumpa@nvidia.com>, <joro@8bytes.org>, <will@kernel.org>,
 <robin.murphy@arm.com>, <robh+dt@kernel.org>, <treding@nvidia.com>
References: <20200630235752.8737-1-vdumpa@nvidia.com>
 <20200630235752.8737-3-vdumpa@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <ed35713b-ec24-db7b-7367-7873134f76ca@nvidia.com>
Date: Wed, 1 Jul 2020 09:16:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200630235752.8737-3-vdumpa@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1593591323; bh=4I8oqO18CDsJelJAvfh/7H1AvPcTauGIZI8cYK+8mV4=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=aPd4B47oOaZ0+he7yiJKIv2HwyBtSjF4hGrYa3pH4P333lHQsnzl8o1DTvuRFzPou
 JsSdKo+HPDo7q6TktSYreIyoWLd/qJFaGILHFuhn/5inpVmmcDJ+HDYj3FeVkypHMO
 /lpIhcdRquy/yqt/E3lwVQG+/epovLj7gUQtglLXE39vjP3FRtdySRn7AviWAExwNX
 1kr+vRnuwS5URij1AUgbjgOyoTNX6EvdKSViJiszfOw+Xjdp5CKWkHslfB4OeVBIc5
 R20WIcH1fC7jlvT5QF2b69owN4Qw5Q17JmLrkClYmRuEKSBOqfQwcqvpk1coMwH4pm
 duWWjn/4T0jGg==
Cc: snikam@nvidia.com, devicetree@vger.kernel.org, nicoleotsuka@gmail.com,
 mperttunen@nvidia.com, bhuntsman@nvidia.com, yhsu@nvidia.com,
 linux-kernel@vger.kernel.org, talho@nvidia.com,
 iommu@lists.linux-foundation.org, nicolinc@nvidia.com,
 linux-tegra@vger.kernel.org, praithatha@nvidia.com,
 linux-arm-kernel@lists.infradead.org, bbiswas@nvidia.com
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


On 01/07/2020 00:57, Krishna Reddy wrote:
> NVIDIA's Tegra194 SoC has three ARM MMU-500 instances.
> It uses two of ARM MMU-500s together to interleave IOVA accesses
> across them and must be programmed identically.
> The third SMMU instance is used as a regular ARM MMU-500 and it
> can either be programmed independently or identical to other
> two ARM MMU-500s.
> 
> This implementation supports programming two or three ARM MMU-500s
> identically as per DT config.
> 
> Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
> ---
>  MAINTAINERS                     |   2 +
>  drivers/iommu/Makefile          |   2 +-
>  drivers/iommu/arm-smmu-impl.c   |   3 +
>  drivers/iommu/arm-smmu-nvidia.c | 206 ++++++++++++++++++++++++++++++++
>  drivers/iommu/arm-smmu.h        |   1 +
>  5 files changed, 213 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/iommu/arm-smmu-nvidia.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7b5ffd646c6b9..64c37dbdd4426 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16808,8 +16808,10 @@ F:	drivers/i2c/busses/i2c-tegra.c
>  
>  TEGRA IOMMU DRIVERS
>  M:	Thierry Reding <thierry.reding@gmail.com>
> +R:	Krishna Reddy <vdumpa@nvidia.com>
>  L:	linux-tegra@vger.kernel.org
>  S:	Supported
> +F:	drivers/iommu/arm-smmu-nvidia.c
>  F:	drivers/iommu/tegra*
>  
>  TEGRA KBC DRIVER
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index 342190196dfb0..2b8203db73ec3 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -15,7 +15,7 @@ obj-$(CONFIG_AMD_IOMMU) += amd/iommu.o amd/init.o amd/quirks.o
>  obj-$(CONFIG_AMD_IOMMU_DEBUGFS) += amd/debugfs.o
>  obj-$(CONFIG_AMD_IOMMU_V2) += amd/iommu_v2.o
>  obj-$(CONFIG_ARM_SMMU) += arm_smmu.o
> -arm_smmu-objs += arm-smmu.o arm-smmu-impl.o arm-smmu-qcom.o
> +arm_smmu-objs += arm-smmu.o arm-smmu-impl.o arm-smmu-nvidia.o arm-smmu-qcom.o
>  obj-$(CONFIG_ARM_SMMU_V3) += arm-smmu-v3.o
>  obj-$(CONFIG_DMAR_TABLE) += intel/dmar.o
>  obj-$(CONFIG_INTEL_IOMMU) += intel/iommu.o intel/pasid.o
> diff --git a/drivers/iommu/arm-smmu-impl.c b/drivers/iommu/arm-smmu-impl.c
> index c75b9d957b702..f15571d05474e 100644
> --- a/drivers/iommu/arm-smmu-impl.c
> +++ b/drivers/iommu/arm-smmu-impl.c
> @@ -171,6 +171,9 @@ struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu)
>  	if (of_property_read_bool(np, "calxeda,smmu-secure-config-access"))
>  		smmu->impl = &calxeda_impl;
>  
> +	if (of_device_is_compatible(np, "nvidia,tegra194-smmu"))
> +		return nvidia_smmu_impl_init(smmu);
> +
>  	if (of_device_is_compatible(np, "qcom,sdm845-smmu-500") ||
>  	    of_device_is_compatible(np, "qcom,sc7180-smmu-500"))
>  		return qcom_smmu_impl_init(smmu);
> diff --git a/drivers/iommu/arm-smmu-nvidia.c b/drivers/iommu/arm-smmu-nvidia.c
> new file mode 100644
> index 0000000000000..5c874912e1c1a
> --- /dev/null
> +++ b/drivers/iommu/arm-smmu-nvidia.c
> @@ -0,0 +1,206 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// NVIDIA ARM SMMU v2 implementation quirks
> +// Copyright (C) 2019-2020 NVIDIA CORPORATION.  All rights reserved.
> +
> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#include "arm-smmu.h"
> +
> +/*
> + * Tegra194 has three ARM MMU-500 Instances.
> + * Two of them are used together for interleaved IOVA accesses and
> + * used by non-isochronous HW devices for SMMU translations.
> + * Third one is used for SMMU translations from isochronous HW devices.
> + * It is possible to use this implementation to program either
> + * all three or two of the instances identically as desired through
> + * DT node.
> + *
> + * Programming all the three instances identically comes with redundant TLB
> + * invalidations as all three never need to be TLB invalidated for a HW device.
> + *
> + * When Linux kernel supports multiple SMMU devices, the SMMU device used for
> + * isochornous HW devices should be added as a separate ARM MMU-500 device
> + * in DT and be programmed independently for efficient TLB invalidates.
> + */

We should address Robin's comment about the 'When' above.

> +#define MAX_SMMU_INSTANCES 3
> +
> +struct nvidia_smmu {
> +	struct arm_smmu_device	smmu;
> +	unsigned int		num_inst;
> +	void __iomem		*bases[MAX_SMMU_INSTANCES];
> +};
> +
> +static inline struct nvidia_smmu *to_nvidia_smmu(struct arm_smmu_device *smmu)
> +{
> +	return container_of(smmu, struct nvidia_smmu, smmu);
> +}
> +
> +static inline void __iomem *nvidia_smmu_page(struct arm_smmu_device *smmu,
> +					     unsigned int inst, int page)
> +{
> +	struct nvidia_smmu *nvidia_smmu = to_nvidia_smmu(smmu);
> +
> +	if (!nvidia_smmu->bases[0])
> +		nvidia_smmu->bases[0] = smmu->base;


Robin said that he would accept a patch to move the
devm_ioremap_resource() call in arm_smmu_device_probe() so that we do
not need to do this. See the V7 series. I think that this would be a
good improvement so that we could avoid doing the above.

Cheers
Jon

-- 
nvpublic
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
