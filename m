Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B75C18C0A
	for <iommu@lists.linux.dev>; Thu, 19 Oct 2023 11:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xM1wyTIk"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4079ed65582so22883995e9.1
        for <iommu@lists.linux.dev>; Thu, 19 Oct 2023 04:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697714015; x=1698318815; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=POZqwrn3QOIkuNwW6uoa6fDBdqF1NUX/ckhVqnX/nGM=;
        b=xM1wyTIkrrxj3fnDC7WwJluvkSq5EqrjgYjbBrEr2L0LuiebkAIy6BX4vuQK9ThUiF
         O0jFFwSuRucGFH5/w5TWBO+a7mCM4ncl+tc2EEtEmeQj28lwnM10243xRWXd5j5D0f1P
         FNL1XFZB1PGd163is2R8AeBYBzwTt7ri/87vuAO9MyD9OUnfBGyRuKB/Bu9cgMrNlF0T
         gNeCD+UTtFyrdXxphVPnmxzVjUziBfboJe6X/v1aK98fGcG8/Fpg5eoA+3gMzhCPEphL
         xPuzohj+3z7riTKrkQgAqG1j/x/XkdnLKJfsrD0ZculzQz+qfp7jpQUje7yfovWkjHs1
         hK2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697714015; x=1698318815;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=POZqwrn3QOIkuNwW6uoa6fDBdqF1NUX/ckhVqnX/nGM=;
        b=B3cGWR3FxyfAFmpFyFCGdq4Xq0f7SzKlak73+yp8+5n/s88dK8jDQcvdyoPGncRXW+
         BiJs8yiUa1e2abShpkrHAQEEkMp5i6nMgN59pa6AIMC9wNM9vDi9GzJJEOhDvoM+R3Zf
         c/ZhqBx8ABeDPQ7h9DZpiYqPZF18FP7hS1Be85pWchdMvlUxbSanDyl7LTGExteR8eLX
         hLGWiRw2PP9vxnO2ziHDxWVu+fMudYxihKX0HMaMzI2vudOz30Wfmkcvta1UuH0pAHiU
         pvtH+Hj7Qtjnd8oNWqwjhTN2MfP7FUI4fAxKASr4lP4StgrasHC0hhgoFF17FzrcyTO4
         OBgQ==
X-Gm-Message-State: AOJu0YziJ11TQj89vgUI5LgBPzJVfOI4wHxNJEtqTPejIrwusXwRTsGZ
	FtsRsHyJUJvRgx/3HkKJGRQoag==
X-Google-Smtp-Source: AGHT+IESelDfNhrhBDzW3Tww8D/Nax8XajqTmvOsjCQY9+TpZo5BfDRDQhEygSKOyZRhdOccwizXEA==
X-Received: by 2002:a05:600c:a0a:b0:408:3c10:ad47 with SMTP id z10-20020a05600c0a0a00b004083c10ad47mr1531323wmp.40.1697714014660;
        Thu, 19 Oct 2023 04:13:34 -0700 (PDT)
Received: from [172.30.205.86] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id q12-20020a05600c2e4c00b0040648217f4fsm4089784wmf.39.2023.10.19.04.13.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 04:13:34 -0700 (PDT)
Message-ID: <1cdc2a68-a1e8-4cf2-8a1a-899d14f8db80@linaro.org>
Date: Thu, 19 Oct 2023 13:13:34 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] iommu/arm-smmu-qcom: Add support for TBUs
Content-Language: en-US
To: Georgi Djakov <quic_c_gdjako@quicinc.com>, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, will@kernel.org,
 robin.murphy@arm.com, joro@8bytes.org
Cc: devicetree@vger.kernel.org, andersson@kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 quic_cgoldswo@quicinc.com, quic_sukadev@quicinc.com, quic_pdaly@quicinc.com,
 quic_sudaraja@quicinc.com, djakov@kernel.org
References: <20231019021923.13939-1-quic_c_gdjako@quicinc.com>
 <20231019021923.13939-3-quic_c_gdjako@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231019021923.13939-3-quic_c_gdjako@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/19/23 04:19, Georgi Djakov wrote:
> The ARM MMU-500 implements a Translation Buffer Unit (TBU) for each
> connected master besides a single TCU which controls and manages the
> address translations.
> 
> Allow the Qualcomm SMMU driver to probe for any TBU devices that can
> provide additional debug features like triggering transactions, logging
> outstanding transactions, snapshot capture etc. The most basic use-case
> would be to get information from the TBUs and print it during a context
> fault.
> 
> Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
> ---
>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 12 ++++++++++++
>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h |  4 +++-
>   2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index 7f52ac67495f..655c7f50ca84 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -1,12 +1,14 @@
>   // SPDX-License-Identifier: GPL-2.0-only
>   /*
>    * Copyright (c) 2019, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved
>    */
>   
>   #include <linux/acpi.h>
>   #include <linux/adreno-smmu-priv.h>
>   #include <linux/delay.h>
>   #include <linux/of_device.h>
> +#include <linux/of_platform.h>
>   #include <linux/firmware/qcom/qcom_scm.h>
>   
>   #include "arm-smmu.h"
> @@ -466,6 +468,16 @@ static struct arm_smmu_device *qcom_smmu_create(struct arm_smmu_device *smmu,
>   	qsmmu->smmu.impl = impl;
>   	qsmmu->cfg = data->cfg;
>   
> +	/* Populate TBU devices if such are present in DT */
> +	if (np && of_device_is_compatible(np, "arm,mmu-500")) {
I'd say this can be unconditional.

> +		int ret;
> +
> +		INIT_LIST_HEAD(&qsmmu->tbu_list);
This list is unused.

Konrad
