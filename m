Return-Path: <SRS0=dlfR=AT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE49C433E0
	for <iommu@archiver.kernel.org>; Wed,  8 Jul 2020 12:25:47 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CE0D20720
	for <iommu@archiver.kernel.org>; Wed,  8 Jul 2020 12:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="BOJVLZzt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CE0D20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A4BCB24F92;
	Wed,  8 Jul 2020 12:25:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8s4KngjsTwk0; Wed,  8 Jul 2020 12:25:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 52FCA263CE;
	Wed,  8 Jul 2020 12:25:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 337F0C077B;
	Wed,  8 Jul 2020 12:25:44 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 57BDDC016F
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jul 2020 12:25:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5438B87CA9
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jul 2020 12:25:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iIDqtPgqZhNe for <iommu@lists.linux-foundation.org>;
 Wed,  8 Jul 2020 12:25:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from hqnvemgate24.nvidia.com (hqnvemgate24.nvidia.com
 [216.228.121.143])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 3167C87E35
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jul 2020 12:25:01 +0000 (UTC)
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5f05bab10000>; Wed, 08 Jul 2020 05:23:13 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Wed, 08 Jul 2020 05:25:00 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Wed, 08 Jul 2020 05:25:00 -0700
Received: from [10.26.73.185] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 8 Jul
 2020 12:24:53 +0000
Subject: Re: [PATCH v10 3/5] iommu/arm-smmu: add NVIDIA implementation for ARM
 MMU-500 usage
To: Krishna Reddy <vdumpa@nvidia.com>, <joro@8bytes.org>, <will@kernel.org>,
 <robin.murphy@arm.com>, <robh+dt@kernel.org>, <treding@nvidia.com>
References: <20200708050017.31563-1-vdumpa@nvidia.com>
 <20200708050017.31563-4-vdumpa@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <db7fc2f9-9081-43e0-c171-730b7cb7b3cd@nvidia.com>
Date: Wed, 8 Jul 2020 13:24:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200708050017.31563-4-vdumpa@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1594210994; bh=lTT5SW3WiC0mMT9fhDOGr6AwfezU0Y8iL8pYUaAOO8Y=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=BOJVLZztj2LultPgdg9jJcN/4LtHOhBNnegVQnjuzxqyQrC0MDSbpPbNvNBFstRJf
 3RwpL7ij9WUDoHKUc42B+btR2GZ7gyOg05ggfsSdWuaA0TR9Q3a6+pVGBI1Gxqpbqy
 L3GKiDpm7sdnj8zOjCZG9nEXR8AW7RYhwlKd4p+R/2PNQIhm62fSnzbrNpNekDijXe
 V+Dfd59y/OGXwZdgfLelFQlG1uPUqGtw9qjp2/iqxJz10LmZGSksLYS5F7ORybF5cQ
 UaJrj7wj0TdA1Vhd5jDiX3VpwkVyMPQYCg0yS02m/0uBs2LP+fx4Wbttupfu9ziu9W
 P8rf23ZRZ4Quw==
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


On 08/07/2020 06:00, Krishna Reddy wrote:
> NVIDIA's Tegra194 SoC has three ARM MMU-500 instances.
> It uses two of the ARM MMU-500s together to interleave IOVA
> accesses across them and must be programmed identically.
> This implementation supports programming the two ARM MMU-500s
> that must be programmed identically.
> 
> The third ARM MMU-500 instance is supported by standard
> arm-smmu.c driver itself.
> 
> Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
> ---
>  MAINTAINERS                     |   2 +
>  drivers/iommu/Makefile          |   2 +-
>  drivers/iommu/arm-smmu-impl.c   |   3 +
>  drivers/iommu/arm-smmu-nvidia.c | 179 ++++++++++++++++++++++++++++++++
>  drivers/iommu/arm-smmu.c        |   1 +
>  drivers/iommu/arm-smmu.h        |   1 +
>  6 files changed, 187 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/iommu/arm-smmu-nvidia.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c23352059a6b..534cedaf8e55 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16811,8 +16811,10 @@ F:	drivers/i2c/busses/i2c-tegra.c
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
> index 342190196dfb..2b8203db73ec 100644
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
> index c75b9d957b70..f15571d05474 100644
> --- a/drivers/iommu/arm-smmu-impl.c
> +++ b/drivers/iommu/arm-smmu-impl.c
> @@ -171,6 +171,9 @@ struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu)
>  	if (of_property_read_bool(np, "calxeda,smmu-secure-config-access"))
>  		smmu->impl = &calxeda_impl;
>  
> +	if (of_device_is_compatible(np, "nvidia,tegra194-smmu"))
> +		return nvidia_smmu_impl_init(smmu);
> +

I wonder if we should be matching nvidia,smmu-500 here as well because
any device that has that we want to call nvidia_smmu_impl_init(). I
understand that there is only tegra194 today, but seems funny to match
nvidia,smmu-500 below and then nvidia,tegra194-smmu here. That said ...

>  	if (of_device_is_compatible(np, "qcom,sdm845-smmu-500") ||
>  	    of_device_is_compatible(np, "qcom,sc7180-smmu-500"))
>  		return qcom_smmu_impl_init(smmu);
> diff --git a/drivers/iommu/arm-smmu-nvidia.c b/drivers/iommu/arm-smmu-nvidia.c
> new file mode 100644
> index 000000000000..2f55e5793d34
> --- /dev/null
> +++ b/drivers/iommu/arm-smmu-nvidia.c
> @@ -0,0 +1,179 @@
> +// SPDX-License-Identifier: GPL-2.0-only
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
> + * Two of them are used together and must be programmed identically for
> + * interleaved IOVA accesses across them and translates accesses from
> + * non-isochronous HW devices.
> + * Third one is used for translating accesses from isochronous HW devices.
> + * This implementation supports programming of the two instances that must
> + * be programmed identically.
> + * The third instance usage is through standard arm-smmu driver itself and
> + * is out of scope of this implementation.
> + */
> +#define NUM_SMMU_INSTANCES 2
> +
> +struct nvidia_smmu {
> +	struct arm_smmu_device	smmu;
> +	void __iomem		*bases[NUM_SMMU_INSTANCES];
> +};
> +
> +static inline void __iomem *nvidia_smmu_page(struct arm_smmu_device *smmu,
> +					     unsigned int inst, int page)
> +{
> +	struct nvidia_smmu *nvidia_smmu;
> +
> +	nvidia_smmu = container_of(smmu, struct nvidia_smmu, smmu);
> +	return nvidia_smmu->bases[inst] + (page << smmu->pgshift);
> +}
> +
> +static u32 nvidia_smmu_read_reg(struct arm_smmu_device *smmu,
> +				int page, int offset)
> +{
> +	void __iomem *reg = nvidia_smmu_page(smmu, 0, page) + offset;
> +
> +	return readl_relaxed(reg);
> +}
> +
> +static void nvidia_smmu_write_reg(struct arm_smmu_device *smmu,
> +				  int page, int offset, u32 val)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < NUM_SMMU_INSTANCES; i++) {
> +		void __iomem *reg = nvidia_smmu_page(smmu, i, page) + offset;
> +
> +		writel_relaxed(val, reg);
> +	}
> +}
> +
> +static u64 nvidia_smmu_read_reg64(struct arm_smmu_device *smmu,
> +				  int page, int offset)
> +{
> +	void __iomem *reg = nvidia_smmu_page(smmu, 0, page) + offset;
> +
> +	return readq_relaxed(reg);
> +}
> +
> +static void nvidia_smmu_write_reg64(struct arm_smmu_device *smmu,
> +				    int page, int offset, u64 val)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < NUM_SMMU_INSTANCES; i++) {
> +		void __iomem *reg = nvidia_smmu_page(smmu, i, page) + offset;
> +
> +		writeq_relaxed(val, reg);
> +	}
> +}
> +
> +static void nvidia_smmu_tlb_sync(struct arm_smmu_device *smmu, int page,
> +				 int sync, int status)
> +{
> +	unsigned int delay;
> +
> +	arm_smmu_writel(smmu, page, sync, 0);
> +
> +	for (delay = 1; delay < TLB_LOOP_TIMEOUT; delay *= 2) {
> +		unsigned int spin_cnt;
> +
> +		for (spin_cnt = TLB_SPIN_COUNT; spin_cnt > 0; spin_cnt--) {
> +			u32 val = 0;
> +			unsigned int i;
> +
> +			for (i = 0; i < NUM_SMMU_INSTANCES; i++) {
> +				void __iomem *reg;
> +
> +				reg = nvidia_smmu_page(smmu, i, page) + status;
> +				val |= readl_relaxed(reg);
> +			}
> +
> +			if (!(val & ARM_SMMU_sTLBGSTATUS_GSACTIVE))
> +				return;
> +
> +			cpu_relax();
> +		}
> +
> +		udelay(delay);
> +	}
> +
> +	dev_err_ratelimited(smmu->dev,
> +			    "TLB sync timed out -- SMMU may be deadlocked\n");
> +}
> +
> +static int nvidia_smmu_reset(struct arm_smmu_device *smmu)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < NUM_SMMU_INSTANCES; i++) {
> +		u32 val;
> +		void __iomem *reg = nvidia_smmu_page(smmu, i, ARM_SMMU_GR0) +
> +				    ARM_SMMU_GR0_sGFSR;
> +
> +		/* clear global FSR */
> +		val = readl_relaxed(reg);
> +		writel_relaxed(val, reg);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct arm_smmu_impl nvidia_smmu_impl = {
> +	.read_reg = nvidia_smmu_read_reg,
> +	.write_reg = nvidia_smmu_write_reg,
> +	.read_reg64 = nvidia_smmu_read_reg64,
> +	.write_reg64 = nvidia_smmu_write_reg64,
> +	.reset = nvidia_smmu_reset,
> +	.tlb_sync = nvidia_smmu_tlb_sync,
> +};
> +
> +struct arm_smmu_device *nvidia_smmu_impl_init(struct arm_smmu_device *smmu)
> +{
> +	struct resource *res;
> +	struct device *dev = smmu->dev;
> +	struct nvidia_smmu *nvidia_smmu;
> +	struct platform_device *pdev = to_platform_device(dev);
> +
> +	nvidia_smmu = devm_kzalloc(dev, sizeof(*nvidia_smmu), GFP_KERNEL);
> +	if (!nvidia_smmu)
> +		return ERR_PTR(-ENOMEM);
> +
> +	/*
> +	 * Copy the data from struct arm_smmu_device *smmu allocated in
> +	 * arm-smmu.c. The smmu from struct nvidia_smmu replaces the smmu
> +	 * pointer used in arm-smmu.c once this function returns.
> +	 * This is necessary to derive nvidia_smmu from smmu pointer passed
> +	 * through arm_smmu_impl function calls subsequently.
> +	 */
> +	nvidia_smmu->smmu = *smmu;
> +	/* Instance 0 is ioremapped by arm-smmu.c. */
> +	nvidia_smmu->bases[0] = smmu->base;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	if (!res)
> +		return ERR_PTR(-ENODEV);
> +
> +	nvidia_smmu->bases[1] = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(nvidia_smmu->bases[1]))
> +		return ERR_CAST(nvidia_smmu->bases[1]);
> +
> +	nvidia_smmu->smmu.impl = &nvidia_smmu_impl;
> +
> +	/*
> +	 * Free the struct arm_smmu_device *smmu allocated in arm-smmu.c.
> +	 * Once this function returns, arm-smmu.c would use arm_smmu_device
> +	 * allocated as part of struct nvidia_smmu.
> +	 */
> +	devm_kfree(dev, smmu);
> +
> +	return &nvidia_smmu->smmu;
> +}
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index e03e873d3bca..c123a5814f70 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -1943,6 +1943,7 @@ static const struct of_device_id arm_smmu_of_match[] = {
>  	{ .compatible = "arm,mmu-401", .data = &arm_mmu401 },
>  	{ .compatible = "arm,mmu-500", .data = &arm_mmu500 },
>  	{ .compatible = "cavium,smmu-v2", .data = &cavium_smmuv2 },
> +	{ .compatible = "nvidia,smmu-500", .data = &arm_mmu500 },
>  	{ .compatible = "qcom,smmu-v2", .data = &qcom_smmuv2 },
>  	{ },
>  };
> diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
> index c7d0122a7c6c..fad63efa1a72 100644
> --- a/drivers/iommu/arm-smmu.h
> +++ b/drivers/iommu/arm-smmu.h
> @@ -452,6 +452,7 @@ static inline void arm_smmu_writeq(struct arm_smmu_device *smmu, int page,
>  	arm_smmu_writeq((s), ARM_SMMU_CB((s), (n)), (o), (v))
>  
>  struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu);
> +struct arm_smmu_device *nvidia_smmu_impl_init(struct arm_smmu_device *smmu);
>  struct arm_smmu_device *qcom_smmu_impl_init(struct arm_smmu_device *smmu);
>  
>  int arm_mmu500_reset(struct arm_smmu_device *smmu);
> 

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Thanks
Jon

-- 
nvpublic
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
