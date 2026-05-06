Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA18E47F2CF
	for <iommu@lists.linux.dev>; Wed,  6 May 2026 14:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778076957; cv=none; b=a1I6Am3sGJ9MTWcEoRIbF/spg7CBwXD8c4hLc/OG0FpV+/rcRMjQyYQWnrmq/W4tMmduN4vutaeKCoOoCshARHQUP49qtSz/PT0HGsJKJH3M+7XMHg1JTQnKC65EUaZf1+4zBsUy36tT/WyOkuXyZdm68N5b1OwapcUneWGqiCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778076957; c=relaxed/simple;
	bh=77fJr5LiA/sxupPT8D6D6Tg2q69Ndutr+ng2W7NYQUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X0BCYkt9UnRHEQ5hdMeGLVlSkLxY24m5MVwNdxzXuCDPuMPtGEEL8jvi9oEGhVirKBjj1HNfIqx6TU97c7Cwb6UyiO8m25J4XfAR5KafIidCEvdj/2Bgyt+fTuzD2dnJtdMWkwHyK8F0nzGPGY7qpybEHwqrW5fKnnpi9wcGj0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a3omOw4Q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SEKSiRNT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a3omOw4Q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SEKSiRNT"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646A0Mbr1987488
	for <iommu@lists.linux.dev>; Wed, 6 May 2026 14:15:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	meGD3Bi0QGO28p7xtSgOSjUMqCXzjYkDyPriOZRTKRg=; b=a3omOw4QdhsyYJGa
	si+XT6kwzHEmJtWJ34j54LJFoLnFRPyBE+tH1EZz99YBZmqTXh2F6vrHR5mWyTD/
	Z+u/xy8szUADasJXV0Bi4KCPXCbEKAlG8/XjLhWVUPvfE6EvNDojpLpzNl7YodAE
	fwHhjNyGBCZSVvxEnbJc29PaBaw5S+GqT4VZbLft5AcIEHZyurd3wJZMvvQaOStB
	QF6jCgJHilepC2m/jhVYYBNkNADsupACM1pn4ovl2rKt5FeO/oOWSvX8NbHne2Ov
	P7PfBXaYnsea66A7joZnbdFzc7Hlv5oc+8jr5+aegWfQ2TC0WiuiKq9OsM0QH2Jd
	6A14rQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e03gp0v2j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 06 May 2026 14:15:54 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-35845fcf0f5so893770a91.0
        for <iommu@lists.linux.dev>; Wed, 06 May 2026 07:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778076954; x=1778681754; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=meGD3Bi0QGO28p7xtSgOSjUMqCXzjYkDyPriOZRTKRg=;
        b=SEKSiRNTxpaEi/rXfbKuRk9nFvrzu0OdH3hQyFJBs/1aS99Rbhf413Bf9hHrxs+HE4
         Vp0thACTxgo1YFwdJgMWuj0J50vJTfAf2NvWOvrH4cK4YD5Z3Atzh0vhIJ82Z4nqUovV
         zon/bxex5mJQhDNhMEuJE4tIOHXsPDzZxN038l2DQEMCjWUbpRSc5YQ0NLJEuAAs7ZuH
         PZovbJMKKYFg7lXkigtj9Hy1Kjnbd9uxR7J5Xy224jvLpV90n90XGIysxRHTHlOcHzHH
         BeFcVVjsxMiXGMDAHQjgnmMMAoNaweeZM40Zthz0SNpcyw+RUgTExn9sHe5qaGqE+xqo
         o8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778076954; x=1778681754;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=meGD3Bi0QGO28p7xtSgOSjUMqCXzjYkDyPriOZRTKRg=;
        b=q7OLs96NLh5EzUmyZoloBEEiSNmGjdhm4dCgoWgLIk1qzqvSWbwq10jnCj50v75V3x
         27WYJlTumhJpiFAE4HbVhet2NI8WeqD4xu+mDXXX1mQ9rl690fWp2eceRzkt27HojOI1
         Or+59YvlXLdSPDxJHi0N/biWJ4pouOVfZVYbPaeBDv13ZQt0a6Te97sFz4DiztUAqP+O
         84ca4qCfp5qYc9bCplbsLGFEOXgWfM5cuF5st9z/5lkwwKAUPPz6xPZMMNAiUw8krWrh
         iX0UYMiyoh2cIuIWaUSIjOwbQbejNQq/mAzZMqbMOignQRvTRodBvbxeuBBJKrsdmrL+
         bHQg==
X-Forwarded-Encrypted: i=1; AFNElJ8wHYisFBq/x0FM+XFc3uZnY7A7Yxh3yhFyqPn3bempMV9g8a2pUX7Eoh6J4KIRwfgMgfIy3g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyc4GqRzjEtldCEoSUwNWGbYDXxXuU1ZSohBslcXLRu/9FxFzDa
	Ap2jAGxhSeUUJipckPCXFKs1Fzb17ekZT2v+ha7EAGFgfFB2IIlPfiR3WV2TDZCGky7UrY5b93r
	mmUyet1XzSAqKxPf4SJTcB+9tuId9l13hsPIjJzcbx/J5cB1EF/TN833mWeps6IkPHw==
X-Gm-Gg: AeBDiev+C7erCQs3GE7ZSVa/LJ80Xz079aJsa5XLSzD8bNghAMkFwVaEtEt7+BNP6sH
	ZWtznypMqtrZ0iIRRgqW10/5amOcWa0k8IdSf23cGq1KRiGQ7hODBACmi08588bGoiiZfAtxUE1
	BlvTVyC0r5WduU5ZuxOLlFLWUhkSxS4NLWkoBtKt9P5srsV3BQCNE8kEzo7UH7+DL3JxQDjmnGA
	5fNGKEZiRZse7ElD9QbZ4JM1BqvKYfxF6lfi6zIoq/oxX6ev0d9brNByEIbw1MLuA+9H5S/K+Tn
	3rnWbhgri3pUfB7wcW1D0S5Lhmko2MfzxhlsSPXM6LPHxJdVav5f6LkfBoNYqIlEcLecJMwc8eY
	51aPFlUwKPojO5j/JO/NR1noXoxo0+GWQ9LerxNv6IA98VeR7e+5DV8cnI1JLTHVH
X-Received: by 2002:a17:90b:1b48:b0:364:721e:42d3 with SMTP id 98e67ed59e1d1-365a96ec81cmr2744688a91.4.1778076953043;
        Wed, 06 May 2026 07:15:53 -0700 (PDT)
X-Received: by 2002:a17:90b:1b48:b0:364:721e:42d3 with SMTP id 98e67ed59e1d1-365a96ec81cmr2744637a91.4.1778076952422;
        Wed, 06 May 2026 07:15:52 -0700 (PDT)
Received: from [10.204.101.47] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-365b08d6c5csm1710667a91.1.2026.05.06.07.15.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 07:15:51 -0700 (PDT)
Message-ID: <6092c78d-b21a-4eb1-815a-87a530781705@oss.qualcomm.com>
Date: Wed, 6 May 2026 19:45:43 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/13] media: iris: Add iris vpu bus support
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux.dev
References: <20260505-glymur-v4-0-17571dbd1caa@oss.qualcomm.com>
 <20260505-glymur-v4-4-17571dbd1caa@oss.qualcomm.com>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20260505-glymur-v4-4-17571dbd1caa@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE0MCBTYWx0ZWRfXzGj+gDSwcpnt
 8LXpI5UGf8u1avsk0YNw89TvcfkJ7PBUKeyMj3r0NXESCyc/AC3QP9mAXawiJsGMw5o8RLRYBtn
 olcetaw11zAxtcbINhEDS0C9WHQ3fsiF4L2COt4jQeGFInCmWVHlMqpFLV8l3RP6672JyJDFMCm
 PaurfY9vKlcxO35fZLaVVZjnQbA5DbQfyC4uSZdM4HdTFF24u6KQzV74p8exzuuUAgwpiUI6X+9
 RTSPKRVVmNVV33tRLSTGkaqZTOcdWWktIO1tErz2XwFTcVD88rXL7xTrAf9xPo3aMgbpj1zSIu8
 d8NMdM2OYLQQN3/tW4OTuOuVIYdR87G35TcgshQ+Y2Gf8I4j4TlqtnU/xX3NWhlB5UyOR2S9QrP
 2W+WhVBeVFAHSOsFcOnGU812Fc9QoP5QFn+a5UZqHJ2wlTPINKoqzrwukpgXxKlIAynEr5a0O+w
 Vt1Wfn+xK3BwH4cTHOw==
X-Proofpoint-ORIG-GUID: GaOfcwnJbtPldVXvtvhrNchhRup_i4DI
X-Proofpoint-GUID: GaOfcwnJbtPldVXvtvhrNchhRup_i4DI
X-Authority-Analysis: v=2.4 cv=W8wIkxWk c=1 sm=1 tr=0 ts=69fb4d1a cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=B53-pikVkeDfK7DE9NMA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_03,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060140


On 5/5/2026 12:29 PM, Vishnu Reddy wrote:
> From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> 
> On glymur platform, firmware loading needs a separate IOMMU mapping with
> its own stream ID. This stream ID is defined in the device tree with the
> assosiated firmware function ID in the iommu-map property. To create this
> mapping, a separate child device is needed so the firmware memory can be
> isolated in its own IOMMU context.
> 
> Introduced a new bus called iris-vpu-bus. This creates a dynamic device,
> and its dma_configure() callback calls of_dma_configure_id() with the
> function ID provided by the client to map the corresponding stream ID.
> This sets up a dedicated IOMMU context for the child device.
> 
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> ---
>   drivers/media/platform/qcom/iris/Makefile       |  4 ++
>   drivers/media/platform/qcom/iris/iris_vpu_bus.c | 69 +++++++++++++++++++++++++
>   include/linux/iris_vpu_bus.h                    | 25 +++++++++
>   3 files changed, 98 insertions(+)
> 
> diff --git a/drivers/media/platform/qcom/iris/Makefile b/drivers/media/platform/qcom/iris/Makefile
> index 2abbd3aeb4af..6f4052b98491 100644
> --- a/drivers/media/platform/qcom/iris/Makefile
> +++ b/drivers/media/platform/qcom/iris/Makefile
> @@ -31,3 +31,7 @@ qcom-iris-objs += iris_platform_gen1.o
>   endif
>   
>   obj-$(CONFIG_VIDEO_QCOM_IRIS) += qcom-iris.o
> +
> +ifdef CONFIG_VIDEO_QCOM_IRIS
> +obj-y += iris_vpu_bus.o
> +endif
> diff --git a/drivers/media/platform/qcom/iris/iris_vpu_bus.c b/drivers/media/platform/qcom/iris/iris_vpu_bus.c
> new file mode 100644
> index 000000000000..15ba4d9c563e
> --- /dev/null
> +++ b/drivers/media/platform/qcom/iris/iris_vpu_bus.c
> @@ -0,0 +1,69 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/iris_vpu_bus.h>
> +#include <linux/of_device.h>
> +
> +static int iris_vpu_bus_dma_configure(struct device *dev)
> +{
> +	const u32 *iommu_fid = dev_get_drvdata(dev);
> +
> +	return of_dma_configure_id(dev, dev->parent->of_node, true, iommu_fid);
> +}
> +
> +const struct bus_type iris_vpu_bus_type = {
> +	.name = "iris-vpu-bus",
> +	.dma_configure = iris_vpu_bus_dma_configure,
> +};
> +EXPORT_SYMBOL_GPL(iris_vpu_bus_type);
> +
> +static void release_iris_vpu_bus_device(struct device *dev)
> +{
> +	kfree(dev);
> +}
> +
> +struct device *create_iris_vpu_bus_device(struct device *parent_device, const char *name,
> +					  u64 dma_mask, const u32 *iommu_fid)
> +{
> +	struct device *dev;
> +	int ret;
> +
> +	dev = kzalloc_obj(*dev);
> +	if (!dev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	dev->release = release_iris_vpu_bus_device;
> +	dev->bus = &iris_vpu_bus_type;
> +	dev->parent = parent_device;
> +	dev->coherent_dma_mask = dma_mask;
> +	dev->dma_mask = &dev->coherent_dma_mask;
> +
> +	dev_set_name(dev, "%s", name);
> +	dev_set_drvdata(dev, (void *)iommu_fid);
> +
> +	ret = device_register(dev);
> +	if (ret) {
> +		put_device(dev);
> +		return ERR_PTR(ret);
> +	}
> +
> +	return dev;
> +}
> +EXPORT_SYMBOL_GPL(create_iris_vpu_bus_device);
> +
> +static int __init iris_vpu_bus_init(void)
> +{
> +	int ret;
> +
> +	ret = bus_register(&iris_vpu_bus_type);
> +	if (ret) {
> +		pr_err("iris-vpu-bus registration failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +postcore_initcall(iris_vpu_bus_init);
> diff --git a/include/linux/iris_vpu_bus.h b/include/linux/iris_vpu_bus.h
> new file mode 100644
> index 000000000000..750e878e489f
> --- /dev/null
> +++ b/include/linux/iris_vpu_bus.h
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#ifndef _LINUX_IRIS_VPU_BUS_H
> +#define _LINUX_IRIS_VPU_BUS_H
> +
> +#include <linux/device.h>
> +
> +#if IS_ENABLED(CONFIG_VIDEO_QCOM_IRIS)
> +extern const struct bus_type iris_vpu_bus_type;
> +
> +struct device *create_iris_vpu_bus_device(struct device *parent_device, const char *name,
> +					  u64 dma_mask, const u32 *iommu_fid);
> +#else
> +static inline struct device *create_iris_vpu_bus_device(struct device *parent_device,
> +							const char *name, u64 dma_mask,
> +							const u32 *iommu_fid)
> +{
> +	return NULL;

change this to return ERR_PTR(-ENODEV);

> +}
> +#endif
> +
> +#endif /* _LINUX_IRIS_VPU_BUS_H */
> 

