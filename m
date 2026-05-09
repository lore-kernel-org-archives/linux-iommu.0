Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D6B39C00A
	for <iommu@lists.linux.dev>; Sat,  9 May 2026 17:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778346319; cv=none; b=CTvAf0U7RaptEW4xY5jCS3qHsaxljmOT2caElEmRvXT/7Yho2+t7ESiTX9B8nmklo5tuCEO57pTRAcCbgbTNTxApg1/9OVHNrn1Qlvu7jnibmtRSMMsJ0HiIp8NJOprNpwcUU0XJ/IejADq0ahbkVE/jsXBjWHKPgAkAT9rmhvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778346319; c=relaxed/simple;
	bh=NVEICKATJvs2+Kctq+POLQ5FvfJ23QzrrplUTCJ+oYU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=iaZBQ2NGQDPh1EqKZnrZ+/be48KN8GdPDCwGoRZfKgavBWL82jnwB11VB6DszBskredJozfxps1VEAeqLSzvkbrIaqWQYKbvwed2tHR5MFqKB7d6N8VbnArqj9CBlZT71oVCUeh054wCImSjhOqYUebFyMwVZj5s/EzUxfK/K9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mxhxpFNP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GW6ignWf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mxhxpFNP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GW6ignWf"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64929AJI3601401
	for <iommu@lists.linux.dev>; Sat, 9 May 2026 17:05:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Xp6s8Lkpgmu1HZrD5qkrcJqIJ3vanqdE2IYQa5ZytRI=; b=mxhxpFNPSHyfI4Q8
	/pWIVECDdtxa9ZWYvTY4U54x3Lo9fsJ9htjYScIjlSXVUDWi4R9k7YBAbR5geIBo
	WqYfLASYOxz8AMInOMzC7YCuhiysaek3ky5fvLEfjwIZV1u2sz9V3OG2DkXfEtRO
	I0T/bzIsJJc3KDT7wBYat6SomT9WwdxTTca7e+xzEE/FuXzzCaHceLb5n0X7JUFw
	Ble8E4aUbgi6LMvLGhF6s2CXx+xmEwpMiYi8Xp+AlLt8uWuzCcE/TXiVNR7+ALVH
	f4nR+hrlrDT9BJn0haiYmfjs+cKcG6Q7lOo59nv2DtDoPAYr4FYrhtlM6tFj3zhD
	Ko+dZw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1uvshhur-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sat, 09 May 2026 17:05:17 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c827b1f222bso77361a12.3
        for <iommu@lists.linux.dev>; Sat, 09 May 2026 10:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778346316; x=1778951116; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Xp6s8Lkpgmu1HZrD5qkrcJqIJ3vanqdE2IYQa5ZytRI=;
        b=GW6ignWfpVB3nL6XQ0kcRrEoE+hTu25DGwkXOld4lSuWnbubzyRciXLRFbRcOUJbhE
         ezUyCnbcvTF7c76V5vwFbZcT0X0VGYCZbaBoL6/hcWEjAabSmEMtmOsQqpH+R0jDg/yd
         TMFeqGYBkC3xTNhvG1zUUeGe2fbjPOGkt85MMwqsms4JGXGXHHGLQyhxhsdC2XokCpsF
         q9WrynzqQUtfDAfWDol5g4FrKapJ7lyUAm/lhBdCourMBu1A0ag4xA7/DEBQHY5Vr5B6
         9fIdnWJM3eKETeuHjtJvvf4zWZrIZ0KRbtTvKgbO5mPBIaknLBGnkYjWbZt5iTxcU9B7
         AsgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778346316; x=1778951116;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xp6s8Lkpgmu1HZrD5qkrcJqIJ3vanqdE2IYQa5ZytRI=;
        b=R2fjNV8fXDCL2aMhKeAd+7rZBJf6qMSamaeGGCOUYU8TQHxVl6LysIonY0pKeFKI0V
         P6PWZiiOZPnoMVcZ/93P04bavR64dFBrRzE8862CEcXbHpwf+uVENeRbroUg6gFA5fdD
         rbR4ReeHZf+5BS+MwP83q41Q3fWKe6u3igFCj+XLR8x6lotqceEiBQEsZ9Gru6qRlN9z
         EVxhIfxuIAdYpNPHxmuDyE7OPZLcS8n9TfgxtOZBUCF713YP4CuJHiWqOIvzpd5hHgwi
         TKqX0tRsAiLRdN5CHt9omVmJHMhw4CrbT8HJLeuW3idYGWVknwQgs8iRkT32eRO1PI0n
         d8FA==
X-Forwarded-Encrypted: i=1; AFNElJ+cqD4kPafAIcuDNKhP1/MaQDZ3921Qqmlfm4R3m8YEFp6L9ZghCNvOyDbvyf+bajBC40JNyA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzjJfbZA7mCbLPQ1oWhjsf7F7WU55UkO/gP+lNoOA+w3onQNlI8
	GtthDqClj0S/eJqOhOXad1XTu236xBVEZY4Gp9Pm9hl0Ixm1U+Ue0KJMAhXC2ybxyAy3wGbYX6S
	0tcEQ0PM43EFHdJP0AZeAgri24UO9shdA6x0hItUwT3wkKtNRWrIDBc8l8w==
X-Gm-Gg: Acq92OHBWiRKER8UMhVHymmjZmET9fygjRZF+i0Hp8fOnFuZ3O0qngzoFTHQCb/VqFH
	PnLtMozY/Bj0l9h+JBUYgMnbSeyBtoQMUgAKf9PimOzyYgFhKsLhfVncZebh3t0+m/noZbbC6tZ
	mbjW+UhjDy68qLCOw7Y4UjZATCKx6ePTtMYMctuzWxW7uRUJ+fut6cMLe7+HzFuq4VjdCk/giSK
	oHXkIjmyoYQVdZE1EsZ5wWomeOP7oiGDbs+n+QjfolWWHp3Xr2H36lah76Ntl4f/9bd5a/6s2HJ
	bEzK1IEkpGtpsZvJYBoUz997PI+J9H4Q6LWsPdA1Nf9GBJdSw/7NNl1Furapzkg28Foo6p646G9
	bPbd7FHxvXcwGaHGFLLdmxXh+qTEEFWGa4gnsQaMtUqvC57agtpA=
X-Received: by 2002:a05:6a20:6a09:b0:3a2:dabf:fef7 with SMTP id adf61e73a8af0-3aa5a9ab766mr18187268637.26.1778346316365;
        Sat, 09 May 2026 10:05:16 -0700 (PDT)
X-Received: by 2002:a05:6a20:6a09:b0:3a2:dabf:fef7 with SMTP id adf61e73a8af0-3aa5a9ab766mr18187222637.26.1778346315840;
        Sat, 09 May 2026 10:05:15 -0700 (PDT)
Received: from [192.168.0.9] ([49.205.255.40])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8267696787sm4960455a12.13.2026.05.09.10.05.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 May 2026 10:05:15 -0700 (PDT)
Message-ID: <241a1ff5-b14e-28ee-ae3d-23d5e894fe77@oss.qualcomm.com>
Date: Sat, 9 May 2026 22:35:05 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Subject: Re: [PATCH v5 01/14] media: iris: Add iris vpu bus support
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org
References: <20260509-glymur-v5-0-7fbb340c5dbd@oss.qualcomm.com>
 <20260509-glymur-v5-1-7fbb340c5dbd@oss.qualcomm.com>
 <brt5t4b2eaudpb76rfdutfpe2p3rgjjyyrezcpsarqvuzsvvru@fgf22ttmijfs>
Content-Language: en-US
In-Reply-To: <brt5t4b2eaudpb76rfdutfpe2p3rgjjyyrezcpsarqvuzsvvru@fgf22ttmijfs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA5MDE4NSBTYWx0ZWRfX1RlwDsEmaWO3
 JnUl/C6vohb26gcfi51bI1U5bgyCKW551VU3RtOne5IpdhmGaQLWfmg6imNNrwQyjEkjTEwAhmK
 47397VGCnx0zS3N3WbvxVfV55uH17uMX8OyJcI6gRnrQ/Q8gd/qsVmGFuxRbB0uyOcU3ASNT487
 SYlGHdiV2Gzys5o5bExGn9+u4+40npEx0uUpbEUqmwzqxc6tP8NdP3XnBJ9dkmqznEBjJjyfVVF
 ztp0CHXdEvVWfRhhpWX0f9xHokkgVRG8Djb/eZY4QyfBWYWo7Q28P79elMobpjr1zV27Xp0lT+F
 asAOd48ppuRG999ULbrqXKaHqIT1+iloW+uYc2U4cK4W4gFygLr2kgeRK+xRUpCgaJaCMKlCwiP
 Fxi3P8m4wvjN26FCgS79ao80NX6Zl4iC/X+Hlk0vR5boaGC+Qe+CKKNbIbEyOZq6LM/m3UsUH8o
 NHdJSBPXn4PIF2KA77g==
X-Authority-Analysis: v=2.4 cv=dujrzVg4 c=1 sm=1 tr=0 ts=69ff694d cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=SpcZ+gRb+6o1zy8jT5J+bQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=bJBNbYhuL5TyR-YRFvMA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: MYrAWKM_5iAf_s6iXGWveV12sNlUm5rO
X-Proofpoint-GUID: MYrAWKM_5iAf_s6iXGWveV12sNlUm5rO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-09_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 adultscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605090185


On 5/9/2026 12:46 AM, Dmitry Baryshkov wrote:
> On Sat, May 09, 2026 at 12:29:50AM +0530, Vishnu Reddy wrote:
>> From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>>
>> On glymur platform, firmware loading needs a separate IOMMU mapping with
>> its own stream ID. This stream ID is defined in the device tree with the
>> assosiated firmware function ID in the iommu-map property. To create this
>> mapping, a separate child device is needed so the firmware memory can be
>> isolated in its own IOMMU context.
>>
>> Introduced a new bus called iris-vpu-bus. This creates a dynamic device,
>> and its dma_configure() callback calls of_dma_configure_id() with the
>> function ID provided by the client to map the corresponding stream ID.
>> This sets up a dedicated IOMMU context for the child device.
>>
>> Reviewed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>> ---
>>  drivers/media/platform/qcom/iris/Kconfig        |  4 ++
>>  drivers/media/platform/qcom/iris/Makefile       |  1 +
>>  drivers/media/platform/qcom/iris/iris_vpu_bus.c | 69 +++++++++++++++++++++++++
>>  include/linux/iris_vpu_bus.h                    | 25 +++++++++
>>  4 files changed, 99 insertions(+)
>>
>> diff --git a/drivers/media/platform/qcom/iris/Kconfig b/drivers/media/platform/qcom/iris/Kconfig
>> index 5498f48362d1..025280ef1221 100644
>> --- a/drivers/media/platform/qcom/iris/Kconfig
>> +++ b/drivers/media/platform/qcom/iris/Kconfig
>> @@ -1,3 +1,6 @@
>> +config QCOM_IRIS_VPU_BUS
>> +        bool
>> +
>>  config VIDEO_QCOM_IRIS
>>          tristate "Qualcomm iris V4L2 decoder driver"
>>          depends on VIDEO_DEV
>> @@ -6,6 +9,7 @@ config VIDEO_QCOM_IRIS
>>          select QCOM_MDT_LOADER
>>          select QCOM_SCM
>>          select VIDEOBUF2_DMA_CONTIG
>> +        select QCOM_IRIS_VPU_BUS
>>          help
>>            This is a V4L2 driver for Qualcomm iris video accelerator
>>            hardware. It accelerates decoding operations on various
>> diff --git a/drivers/media/platform/qcom/iris/Makefile b/drivers/media/platform/qcom/iris/Makefile
>> index 2abbd3aeb4af..79bc67980339 100644
>> --- a/drivers/media/platform/qcom/iris/Makefile
>> +++ b/drivers/media/platform/qcom/iris/Makefile
>> @@ -31,3 +31,4 @@ qcom-iris-objs += iris_platform_gen1.o
>>  endif
>>  
>>  obj-$(CONFIG_VIDEO_QCOM_IRIS) += qcom-iris.o
>> +obj-$(CONFIG_QCOM_IRIS_VPU_BUS) += iris_vpu_bus.o
>> diff --git a/drivers/media/platform/qcom/iris/iris_vpu_bus.c b/drivers/media/platform/qcom/iris/iris_vpu_bus.c
>> new file mode 100644
>> index 000000000000..15ba4d9c563e
>> --- /dev/null
>> +++ b/drivers/media/platform/qcom/iris/iris_vpu_bus.c
>> @@ -0,0 +1,69 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +#include <linux/device.h>
>> +#include <linux/iris_vpu_bus.h>
>> +#include <linux/of_device.h>
>> +
>> +static int iris_vpu_bus_dma_configure(struct device *dev)
>> +{
>> +	const u32 *iommu_fid = dev_get_drvdata(dev);
> This should be drm_get_platdata() rather than _drvdata().

Ack, will use dev_get_platdata().

>> +
>> +	return of_dma_configure_id(dev, dev->parent->of_node, true, iommu_fid);
>> +}
>> +
>> +const struct bus_type iris_vpu_bus_type = {
>> +	.name = "iris-vpu-bus",
>> +	.dma_configure = iris_vpu_bus_dma_configure,
>> +};
>> +EXPORT_SYMBOL_GPL(iris_vpu_bus_type);
>> +
>> +static void release_iris_vpu_bus_device(struct device *dev)
>> +{
>> +	kfree(dev);
>> +}
>> +
>> +struct device *create_iris_vpu_bus_device(struct device *parent_device, const char *name,
>> +					  u64 dma_mask, const u32 *iommu_fid)
>> +{
>> +	struct device *dev;
>> +	int ret;
>> +
>> +	dev = kzalloc_obj(*dev);
>> +	if (!dev)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	dev->release = release_iris_vpu_bus_device;
>> +	dev->bus = &iris_vpu_bus_type;
>> +	dev->parent = parent_device;
>> +	dev->coherent_dma_mask = dma_mask;
>> +	dev->dma_mask = &dev->coherent_dma_mask;
>> +
>> +	dev_set_name(dev, "%s", name);
>> +	dev_set_drvdata(dev, (void *)iommu_fid);
>> +
>> +	ret = device_register(dev);
>> +	if (ret) {
>> +		put_device(dev);
>> +		return ERR_PTR(ret);
>> +	}
>> +
>> +	return dev;
>> +}
>> +EXPORT_SYMBOL_GPL(create_iris_vpu_bus_device);
>> +
>> +static int __init iris_vpu_bus_init(void)
>> +{
>> +	int ret;
>> +
>> +	ret = bus_register(&iris_vpu_bus_type);
>> +	if (ret) {
>> +		pr_err("iris-vpu-bus registration failed: %d\n", ret);
> Just 'return bus_register();'

Ack.

>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +postcore_initcall(iris_vpu_bus_init);
>> diff --git a/include/linux/iris_vpu_bus.h b/include/linux/iris_vpu_bus.h
>> new file mode 100644
>> index 000000000000..7437a2ba411c
>> --- /dev/null
>> +++ b/include/linux/iris_vpu_bus.h
>> @@ -0,0 +1,25 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (c) Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +#ifndef _LINUX_IRIS_VPU_BUS_H
>> +#define _LINUX_IRIS_VPU_BUS_H
>> +
>> +#include <linux/device.h>
>> +
>> +#ifdef CONFIG_QCOM_IRIS_VPU_BUS
>> +extern const struct bus_type iris_vpu_bus_type;
>> +
>> +struct device *create_iris_vpu_bus_device(struct device *parent_device, const char *name,
>> +					  u64 dma_mask, const u32 *iommu_fid);
>> +#else
>> +static inline struct device *create_iris_vpu_bus_device(struct device *parent_device,
> You are adding globally visible API without _any_ sensible prefix. It
> should be named other way: iris_vpu_bus_create_device().

Ack.

>> +							const char *name, u64 dma_mask,
>> +							const u32 *iommu_fid)
>> +{
>> +	return ERR_PTR(-ENODEV);
>> +}
>> +#endif
>> +
>> +#endif /* _LINUX_IRIS_VPU_BUS_H */
>>
>> -- 
>> 2.34.1
>>
