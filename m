Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FA915ADB4
	for <iommu@lists.linux.dev>; Wed, 10 Apr 2024 12:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712750543; cv=none; b=qyAjsXNiUQm8mRK4LhVUE8I6GS0rJtMNQgGuWH5LPedS6hXes70uxl1c+VEKlqVYpLks82SXtEWsmIbg1i+cN1jvYOF4uoF9JVoYkRoGKGkB8GjLG4WNiiqshgWJ4R7BQ+sSwVkAT/oBGZZd4bt0wh3y42k0Qo9Ms5dTlRs6iSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712750543; c=relaxed/simple;
	bh=xB8xNT5TZ+8idLPQRdpVsxTMm4mthuyK1wxukUtb10c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N7+NBJ1GB3/1vOz2IPfLpT/mvoA4lJgobJmM+EAB9IFS3heEIUWKceQ01pHYQYZkEQYB7u0mS6zmD0/Kax7EqsSNwP7OTxqSWcQVYfDEBPmB4b582J1Qo7aGXcufJ8RwdlnXxyjzWrLnXfa8vZ0HTV0Co/WN9J5eUOVrYHCRLgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HOQ6rMxH; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HOQ6rMxH"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d8b2389e73so17287161fa.3
        for <iommu@lists.linux.dev>; Wed, 10 Apr 2024 05:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712750540; x=1713355340; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2rOsmIDCW9tEFKE8tS+sIYykh0jMck+s4Yo4qCRXhxo=;
        b=HOQ6rMxHwbaAX7i0Rsipu6UF3d3o7aqb+ZEklOltKLkWOMleM9DoxpdsqbksfM7Gkk
         QhxS7EnTCHQsE8wpa9WAhzw/skWH9UZOvg5bWq2DUiE2XJ+9wkhSPD14adnpe4xhbJiQ
         E7iANi6DpZeaCDSXT5yVrozIglpJ/nZ3qy2LrF8IuHv5RDYo1yIzQ4E9K+oDfDpfXo72
         ZUI/tNjDbv4kfnKaFUyGs+O61BGZkCUYcbI+51QFcdqcmwY6XhQkaqfgvSfQLcheNt9v
         PxZ6+pf2eGwcnS9ihGMqOKA0Nwac0JLh8Xf5h/KA+LGfeGX/ceTxaUejov0mQXPGdjCM
         XXUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712750540; x=1713355340;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2rOsmIDCW9tEFKE8tS+sIYykh0jMck+s4Yo4qCRXhxo=;
        b=PEK8IkD8aoXlEDCmyBI6jcRNEEUF8C5JxMDdcSh204qsIie4FlhqgwR73K2gy8sh5r
         uvIfTg5hQroiRvsqvfuH4Vie6nr3kLNfV5IuAZzfT2phhLc7MCpqTTvrxZ3g0rNhCxEP
         80vY97hUOTO6/rDO59vnJBDJFUxqwN36SXE5aJTnPDX8ZCUw5UjzxWuUJIgAS3jDWlCa
         T3+WpZPa24p8GgVyVJuyz1k8xgftGJNbMFvQXZPR/c9q8IlPup6hawrIzNKG+siAAE3m
         rHnRv93u2KobyuaNCoKz1NQSe+oj7DLPTboSHYDct4sqCuadeSrqSOfGCuqxPCf8YPwF
         zBTA==
X-Forwarded-Encrypted: i=1; AJvYcCUCnEfgbJreMfisziiFhetUatZqWhmDyxTPo7kO9EaSpypaLTo5s7JE6MbAoTBSy8kgPMOGq1LkfmEUy0TPsv3cDCQifJ4=
X-Gm-Message-State: AOJu0YyV0G9SSufrPeSKGwOR30MCkfPV0VbueX8CJB7SGfPGwzF6E3fY
	2eDk9Js4BniNDuBdtz1SJKaO2rJh41Tz0UL3AXjpej/8nXmy5otjDbYLvW33v3g=
X-Google-Smtp-Source: AGHT+IGilayBjVPPPsJrW4/d24tX8SyRvpVvblAytZMmw2oDFnm170N+wpXAz9u0jhqkmG3BfjRZ1g==
X-Received: by 2002:a2e:bc18:0:b0:2d8:5a4b:1623 with SMTP id b24-20020a2ebc18000000b002d85a4b1623mr2006539ljf.7.1712750539998;
        Wed, 10 Apr 2024 05:02:19 -0700 (PDT)
Received: from [172.30.204.89] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id bg22-20020a05651c0b9600b002d6c051d299sm1796301ljb.56.2024.04.10.05.02.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 05:02:19 -0700 (PDT)
Message-ID: <38e9be7d-f52d-4610-88d8-362557326b4d@linaro.org>
Date: Wed, 10 Apr 2024 14:02:18 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/7] iommu/arm-smmu-qcom-tbu: Add Qualcomm TBU driver
To: Georgi Djakov <quic_c_gdjako@quicinc.com>, will@kernel.org,
 robin.murphy@arm.com, joro@8bytes.org, iommu@lists.linux.dev
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org, andersson@kernel.org,
 robdclark@gmail.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 quic_cgoldswo@quicinc.com, quic_sukadev@quicinc.com, quic_pdaly@quicinc.com,
 quic_sudaraja@quicinc.com, djakov@kernel.org
References: <20240329210638.3647523-1-quic_c_gdjako@quicinc.com>
 <20240329210638.3647523-3-quic_c_gdjako@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240329210638.3647523-3-quic_c_gdjako@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/29/24 22:06, Georgi Djakov wrote:
> Operating the TBUs (Translation Buffer Units) from Linux on Qualcomm
> platforms can help with debugging context faults. To help with that,
> the TBUs can run ATOS (Address Translation Operations) to manually
> trigger address translation of IOVA to physical address in hardware
> and provide more details when a context fault happens.
> 
> The driver will control the resources needed by the TBU to allow
> running the debug operations such as ATOS, check for outstanding
> transactions, do snapshot capture etc.
> 
> Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
> ---
>   drivers/iommu/Kconfig                         |   9 +
>   drivers/iommu/arm/arm-smmu/Makefile           |   1 +
>   .../iommu/arm/arm-smmu/arm-smmu-qcom-tbu.c    | 372 ++++++++++++++++++
>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h    |   2 +
>   drivers/iommu/arm/arm-smmu/arm-smmu.h         |   2 +
>   5 files changed, 386 insertions(+)
>   create mode 100644 drivers/iommu/arm/arm-smmu/arm-smmu-qcom-tbu.c
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 0af39bbbe3a3..b699e88f42c5 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -374,6 +374,15 @@ config ARM_SMMU_QCOM
>   	  When running on a Qualcomm platform that has the custom variant
>   	  of the ARM SMMU, this needs to be built into the SMMU driver.
>   
> +config ARM_SMMU_QCOM_TBU
> +	bool "Qualcomm TBU driver"
> +	depends on ARM_SMMU_QCOM
> +	help
> +	  The SMMUs on Qualcomm platforms may include Translation Buffer
> +	  Units (TBUs) for each master. Enabling support for these units
> +	  allows to operate the TBUs and obtain additional information
> +	  when debugging memory management issues like context faults.
> +
>   config ARM_SMMU_QCOM_DEBUG
>   	bool "ARM SMMU QCOM implementation defined debug support"
>   	depends on ARM_SMMU_QCOM
> diff --git a/drivers/iommu/arm/arm-smmu/Makefile b/drivers/iommu/arm/arm-smmu/Makefile
> index 2a5a95e8e3f9..c35ff78fcfd5 100644
> --- a/drivers/iommu/arm/arm-smmu/Makefile
> +++ b/drivers/iommu/arm/arm-smmu/Makefile
> @@ -3,4 +3,5 @@ obj-$(CONFIG_QCOM_IOMMU) += qcom_iommu.o
>   obj-$(CONFIG_ARM_SMMU) += arm_smmu.o
>   arm_smmu-objs += arm-smmu.o arm-smmu-impl.o arm-smmu-nvidia.o
>   arm_smmu-$(CONFIG_ARM_SMMU_QCOM) += arm-smmu-qcom.o
> +arm_smmu-$(CONFIG_ARM_SMMU_QCOM_TBU) += arm-smmu-qcom-tbu.o
>   arm_smmu-$(CONFIG_ARM_SMMU_QCOM_DEBUG) += arm-smmu-qcom-debug.o
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-tbu.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-tbu.c
> new file mode 100644
> index 000000000000..e3202ed89566
> --- /dev/null
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-tbu.c
> @@ -0,0 +1,372 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/interconnect.h>
> +#include <linux/iopoll.h>
> +#include <linux/list.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_device.h>
> +#include <linux/spinlock.h>
> +
> +#include "arm-smmu.h"
> +#include "arm-smmu-qcom.h"
> +
> +#define TBU_DBG_TIMEOUT_US		100
> +#define DEBUG_AXUSER_REG		0x30
> +#define DEBUG_AXUSER_CDMID		GENMASK_ULL(43, 36)
> +#define DEBUG_AXUSER_CDMID_VAL		0xff
> +#define DEBUG_PAR_REG			0x28
> +#define DEBUG_PAR_FAULT_VAL		BIT(0)
> +#define DEBUG_PAR_PA			GENMASK_ULL(47, 12)
> +#define DEBUG_SID_HALT_REG		0x0
> +#define DEBUG_SID_HALT_VAL		BIT(16)
> +#define DEBUG_SID_HALT_SID		GENMASK(9, 0)
> +#define DEBUG_SR_HALT_ACK_REG		0x20
> +#define DEBUG_SR_HALT_ACK_VAL		BIT(1)
> +#define DEBUG_SR_ECATS_RUNNING_VAL	BIT(0)
> +#define DEBUG_TXN_AXCACHE		GENMASK(5, 2)
> +#define DEBUG_TXN_AXPROT		GENMASK(8, 6)
> +#define DEBUG_TXN_AXPROT_PRIV		0x1
> +#define DEBUG_TXN_AXPROT_NSEC		0x2
> +#define DEBUG_TXN_TRIGG_REG		0x18
> +#define DEBUG_TXN_TRIGGER		BIT(0)
> +#define DEBUG_VA_ADDR_REG		0x8
> +
> +static LIST_HEAD(tbu_list);
> +static DEFINE_MUTEX(tbu_list_lock);
> +static DEFINE_SPINLOCK(atos_lock);
> +
> +struct qcom_tbu {
> +	struct device *dev;
> +	struct device_node *smmu_np;
> +	u32 sid_range[2];
> +	struct list_head list;
> +	struct clk *clk;
> +	struct icc_path	*path;
> +	void __iomem *base;
> +	spinlock_t halt_lock; /* multiple halt or resume can't execute concurrently */
> +	int halt_count;
> +};
> +
> +static struct qcom_smmu *to_qcom_smmu(struct arm_smmu_device *smmu)
> +{
> +	return container_of(smmu, struct qcom_smmu, smmu);
> +}
> +
> +static struct qcom_tbu *qcom_find_tbu(struct qcom_smmu *qsmmu, u32 sid)
> +{
> +	struct qcom_tbu *tbu;
> +	u32 start, end;
> +
> +	mutex_lock(&tbu_list_lock);

#include <linux/cleanup.h>

guard(mutex)(&tbu_list_lock);

and remove the unlocks

similarly for the spinlocks below

Konrad
