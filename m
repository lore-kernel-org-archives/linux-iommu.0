Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31074779BE
	for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 20:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772223300; cv=none; b=BhHlc2EDLdFlY7ruL7/GRJvC4n718zkBz7vjCuwO9QiZK6332i58TDqjNRmxNK3gildsepx+lcHG8wr2S2btH4RDd5EmofZHCNlOwbYmz/Zd8c9muD6IfdyOPv/a6WSG4zUDGKfWYsWzXUTcuOruR03fo/BBNi0c6Ubmxr+zQUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772223300; c=relaxed/simple;
	bh=iucNoNEStscn+tF3OuWq/KxWs14WthoY9Q8cXGzCxVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=APx14QC12N9COxEUTimiQFHXWupzIyJxVhABNCIMNEW2EsrRzZT7KaFfyi0qvH0FTMvb9OPLVG14cAVoaf4FfocHS+u8FBeMovyCC5IZ7HREpaFLfuY7fyurv9PRbuQ5cYU0Fi+UHRqnh8C/mFkOgN00ZbhsxsGrp/YEXF83T70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l46VX7Ci; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Z7eVcX81; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l46VX7Ci";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z7eVcX81"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61RH0HU9527330
	for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 20:14:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=d3qWlTlHeHHlcRziGZQh+7Eh
	dQAZWCc1/zRjvAUju5Y=; b=l46VX7CiT4zVHDcCd/GnnhhLMZLwnJdSy/NSQCL8
	K4woeRxVjr48lgLFgPd1jDHU9UiH88OgxAtrY6SGuqHktIdLSKdfPbTCo0vYn7lv
	HS0dGrwrI4rbeKM1XFTgClUN32V8EaYNG+HD+NSOossL1Pvttv/7n43eORVi01GQ
	LNtUp2Wl8GEaX0fT1OmYmoZvnYHunR1MQe7gZvApkf+WqP8j9ja/5syrSG8yOAXk
	47f7DWYt5ThDHkaufGgEbebUwtuzC2ZhExf4VUAZbodWhIys6MXdMbE0J5kQL5+y
	CKnYNPRcDFvfMQdsK8isU3XHcQm0zjjwuFAKEUQ9h4SFFw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cjw23c7fw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 20:14:57 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cb4e37a796so1795443385a.2
        for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 12:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772223295; x=1772828095; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d3qWlTlHeHHlcRziGZQh+7EhdQAZWCc1/zRjvAUju5Y=;
        b=Z7eVcX81/CgJL/kLh4e8GmChw4tUAvd5LwpX/1bRVbxheVpjiYIS5iGIotSKbIoKGB
         keDAVyGUo8JnaRMJnpaQubhtCZFA4rI/rlc6Db4rKgksAdUFk2OXq/GWITvHbogzYBU0
         RuRqQwMaFPoSw3uwVCL2n4Wr51C1k7NBYRYbj2YbPwTIVjLWIG/DGUoVKqOAC96LAmyc
         PeoOF++BIafTPjNLCTcN+psY6zNfP4KUYRcr7GtThR7njIzeoieA3/9if0YLqt9YuJwK
         /Pmgi8uzEfwcJOFoRZqOL8+DtisaFFDJM1/97lLCnTj47VpUL2+5jwR7bfTwZg0aO3CZ
         o+eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772223295; x=1772828095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d3qWlTlHeHHlcRziGZQh+7EhdQAZWCc1/zRjvAUju5Y=;
        b=MKFIkzWBpYleKsbx1XaXvMQkbgmliM6z9Vx2JjCqURtgET4nCg2jeaU95xCwDra93p
         J7qXzoAqyMKPZhS0iLiQIf/qZ1Acrfzzt4xf+SdO012+J4gpHb8yVSyTKKG69kMh5UyD
         T4UfXIiiRNAT0utz+qyVm9chFyXw+gS+FsQxSqutqOW+x7dhSI0+1yPK5+4on7cU4fFA
         +JdLOjgW2+OClUlIBfxGUKUWMo74IFYAhoRtVwFdPDNs4NxojFdvTeegeqy952f9r0KR
         xlHKYof5OqBIYv4GncdicCkenyWc3DtQTG+PpVMddMQ557Ze/+lg8Iop8PW2AvhYxgeC
         +AUw==
X-Forwarded-Encrypted: i=1; AJvYcCXLr6H6m8+2fzH5sjDN7+D2OKHK/a6qeJtXmxvn9eWnnTzsqlShLZzSswDmQoH+weApxUdp7A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw4KTQetqI7yPtEOWOdpls47+N5oU5qQiSy6o0wDCmmssKWbl9z
	RJPMtFY5yjRFBY6oi5hAy4B408brgVuIdP2qpdxwIPiIW8PEWv14qOHbopYwAv9KVSAIAnC6z1/
	zk6izgcvlW1A0Gomgvwg22C/Tn9anV1ef9v7Clq0K4uhO7HB/tARnlDVNQQ==
X-Gm-Gg: ATEYQzxh96acctoC48Wf0wMNV8EvWPS5hgt9R8/a7hZnxoniDZkaeAnHkiFkFXjJeuG
	P93dCuyuf/tVuGbb82lhR9U9ob8rqM2VP0dJWYg0BhYJJrS6aLhKwlipneEyhYRaZX9VkMExG2D
	L+CuazCmmamOEMFanMSSjue3ebnFOHy2OGupS1OD+Wuop8Kli9fIboOS+puFRe2s0QSSgpckHB7
	+41Ug6pVl/no3Cz8/2SakrHP9CY20SZ4RlBH820GrIUffreGDrwGcdjdOheu5/3TSJRaNb/vX8/
	pFp8In5raa/HmqIxLOhc3+eB3qvhFqztVmRyc7kP7XcQb8jboo2USmL42DrYP3BA7M3fR83NoIR
	26dD5MFnZZ5PJr0roCwryh5CpUjDTy51xjX5XeqzFyY/pg7kB0aXZsUI7Qi444bi9lKuyWSovDa
	tEMpMm3qD5xn5aTiVFE28yWsDgRAUDAX931Fo=
X-Received: by 2002:a05:620a:28d6:b0:8c6:a341:ac1a with SMTP id af79cd13be357-8cbc8de81famr504701585a.52.1772223295039;
        Fri, 27 Feb 2026 12:14:55 -0800 (PST)
X-Received: by 2002:a05:620a:28d6:b0:8c6:a341:ac1a with SMTP id af79cd13be357-8cbc8de81famr504697385a.52.1772223294554;
        Fri, 27 Feb 2026 12:14:54 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a116022215sm102994e87.52.2026.02.27.12.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 12:14:53 -0800 (PST)
Date: Fri, 27 Feb 2026 22:14:52 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Hans Verkuil <hverkuil+cisco@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: [PATCH v2 3/7] media: iris: add iris vpu bus support and
 register it with iommu_buses
Message-ID: <rgglzg6kcq4xz5wtambs3mwch7foxruh7ecbabtu6gm7txr3wu@b67uwl6mk5tx>
References: <20260227-kaanapali-iris-v2-0-850043ac3933@oss.qualcomm.com>
 <20260227-kaanapali-iris-v2-3-850043ac3933@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227-kaanapali-iris-v2-3-850043ac3933@oss.qualcomm.com>
X-Proofpoint-GUID: PJ-QwUPA2LQOB5e6WQj9ONnlhNc_LofP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE3NyBTYWx0ZWRfX9ZO0XmynJPHA
 YY3d4Zi2VIhl6C301/Sw9386jklA1tsQYUAgnTvWOLy8JPNXdwJt/e7Gc38emo3nb/R9fuLp5h1
 48wripRMammiboe6yRLbavK+eBQHSVzVjFr1jVTVQyeQ08UNHlwoe2q2VQ+hSXRcP5ID6AdBKQQ
 o8iJnaHjcJCjvKKUrr1N99T9h9Jw/gIzux6+N2SwtMz09Gbscu3doY9JsDesmg4OvdT1kltv0uf
 cWl0nXL7d2brcxceXLq4FaORcaX4zpGzR2bwkWzFQOD5lWi/ZLodeyefBQFPz6p/4UGdN/sUOKd
 aeXWbwCOGe8HAcxrVomSnTt7eTZW/bPGWYqu2dmCT6TyvA0BhSBnF0coy8jfE6GeeNSsFCTc5XV
 ca08xME4sfQD84uPTRBpYRdHpFn7EQ6JsEf0mcFTydN6ShJBY1MiH3wcfuTukIQ6T8TOZPHOJkp
 B3cT4FGTaJTE2P47rSg==
X-Authority-Analysis: v=2.4 cv=cJHtc1eN c=1 sm=1 tr=0 ts=69a1fb41 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=A7-SorSeRF4lZ4C7dWIA:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: PJ-QwUPA2LQOB5e6WQj9ONnlhNc_LofP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_04,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270177

On Fri, Feb 27, 2026 at 07:41:19PM +0530, Vikash Garodia wrote:
> Add iris vpu bus support and hooks the new bus into the iommu_buses
> list. Iris devices need their own bus so that each iris device can run
> its own dma_configure() logic.

What are "Iris devices"? Are there multiple en/decoders in an SoC?

> 
> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> ---
>  drivers/iommu/iommu.c                           |  4 ++++
>  drivers/media/platform/qcom/iris/Makefile       |  4 ++++
>  drivers/media/platform/qcom/iris/iris_vpu_bus.c | 32 +++++++++++++++++++++++++
>  include/linux/iris_vpu_bus.h                    | 13 ++++++++++
>  4 files changed, 53 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 35db5178095404fec87cd0f18e44ea97cf354e78..fd5fb7c10da22ab548d359ca1f44504acc3d646c 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -13,6 +13,7 @@
>  #include <linux/bug.h>
>  #include <linux/types.h>
>  #include <linux/init.h>
> +#include <linux/iris_vpu_bus.h>
>  #include <linux/export.h>
>  #include <linux/slab.h>
>  #include <linux/errno.h>
> @@ -178,6 +179,9 @@ static const struct bus_type * const iommu_buses[] = {
>  #ifdef CONFIG_CDX_BUS
>  	&cdx_bus_type,
>  #endif
> +#if IS_ENABLED(CONFIG_VIDEO_QCOM_IRIS)
> +	&iris_vpu_bus_type,
> +#endif
>  };
>  
>  /*
> diff --git a/drivers/media/platform/qcom/iris/Makefile b/drivers/media/platform/qcom/iris/Makefile
> index 2abbd3aeb4af07e52bf372a4b2f352463529c92c..6f4052b98491aeddc299669334d4c93e9a3420e4 100644
> --- a/drivers/media/platform/qcom/iris/Makefile
> +++ b/drivers/media/platform/qcom/iris/Makefile
> @@ -31,3 +31,7 @@ qcom-iris-objs += iris_platform_gen1.o
>  endif
>  
>  obj-$(CONFIG_VIDEO_QCOM_IRIS) += qcom-iris.o
> +
> +ifdef CONFIG_VIDEO_QCOM_IRIS
> +obj-y += iris_vpu_bus.o
> +endif
> diff --git a/drivers/media/platform/qcom/iris/iris_vpu_bus.c b/drivers/media/platform/qcom/iris/iris_vpu_bus.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..34ce78d9b0ff1feda15ba4f060a56d02749a0858
> --- /dev/null
> +++ b/drivers/media/platform/qcom/iris/iris_vpu_bus.c
> @@ -0,0 +1,32 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2026 Qualcomm Innovation Center, Inc. All rights reserved.

Drop the year.

> + */
> +
> +#include <linux/device.h>
> +#include <linux/of_device.h>
> +
> +#include "iris_platform_common.h"
> +
> +static int iris_vpu_bus_dma_configure(struct device *dev)
> +{
> +	struct iris_context_bank *cb = dev_get_drvdata(dev);
> +
> +	if (!cb)
> +		return -ENODEV;
> +
> +	return of_dma_configure_id(dev, dev->parent->of_node, true, &cb->f_id);
> +}
> +
> +const struct bus_type iris_vpu_bus_type = {
> +	.name = "iris-bus",
> +	.dma_configure = iris_vpu_bus_dma_configure,
> +};
> +EXPORT_SYMBOL_GPL(iris_vpu_bus_type);
> +
> +static int __init iris_vpu_bus_init(void)
> +{
> +	return bus_register(&iris_vpu_bus_type);

Together with the Host1x it's the third bus having exactly the same
functionality that I've seen in the last several days (I counted the
FastRPC one). Could you please generalize Tegra code and come up with
the single bug that will work for all simple users?

> +}
> +
> +postcore_initcall(iris_vpu_bus_init);
> diff --git a/include/linux/iris_vpu_bus.h b/include/linux/iris_vpu_bus.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..8aba472fcadd269e196b7243da5660deaff31abb
> --- /dev/null
> +++ b/include/linux/iris_vpu_bus.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0-only
> + *
> + * Copyright (c) 2026 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#ifndef __IRIS_VPU_BUS_H__
> +#define __IRIS_VPU_BUS_H__
> +
> +#if IS_ENABLED(CONFIG_VIDEO_QCOM_IRIS)
> +extern const struct bus_type iris_vpu_bus_type;
> +#endif
> +
> +#endif /* __IRIS_VPU_BUS_H__ */
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
