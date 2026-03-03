Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3CB37267E
	for <iommu@lists.linux.dev>; Tue,  3 Mar 2026 18:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772564388; cv=none; b=Hc72uuQpt9YFFNnyWfTl9tV9B+MRnQfSgjcbd2VGK8AVSGRAEI3KMfbQSC6zIdw4QrHb6EwJsV0OS3yJGECHsqBnes5EFGPq6dH4dw7b855KWbT8b23nTlYjJseIssl40V1wi+8tJreGnbZgyFsk+DljWFYCfTgDN9p1PvxbJ4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772564388; c=relaxed/simple;
	bh=OpM8w/CsdWKFrTx3OTldSo1pPZobJUMav0CmXqMmBdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=btdq80S3QWyl7i/QqTwEKyg/EznST4HdfS3x+UgoaP+1FPFmXWCw5xwwESRXIIt4d3SwAdvRPEeCdbTBtxLneNSfZPR8tg3pD7OxgKCvX7lb0USqZ8amyzUiqjQujrGC0uUMF7eTrbeRJn3X+YlawmutF4YK/5VT/Qq8pw3avyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dZYNhtpx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P8jIr2rJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dZYNhtpx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P8jIr2rJ"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 623H11aA3559910
	for <iommu@lists.linux.dev>; Tue, 3 Mar 2026 18:47:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2w9WfPgSlNGq9kAZE7gc5V3C6SFEsmr7ux+w01L1aeQ=; b=dZYNhtpxFPdIILyj
	vouRW/3y5UPAgQ3OfkqSeP3umkqfkCaDJq2Xd6J76d0ljD+0vJQB4bXJnuLhdX3V
	igOKPOCstHWfuRpz7pu3tFvoWUKmC3auz4BtIg6A8jwLP/H1wH8dy4EfRYB7sBhu
	k6/6xna6G0zX66infyRpxsDoR/Eza0b7V0IQQCyWphoVicHtG/400YsljktM7mTX
	Cgo1/5RK79tFoFZUqwWICmGUlRxlPB1d3R6npDYaRTWZyBPlRn54K6Iyiadl6MA7
	WaXK+kD7NnC0ThSgTEmiADEZrIgvsqzLc2caC6OjsXLiXpfYHSojkLSd1DMvl8Re
	H6+PYw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cnhx5c25r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 03 Mar 2026 18:47:01 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-35979a03106so3370380a91.1
        for <iommu@lists.linux.dev>; Tue, 03 Mar 2026 10:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772563620; x=1773168420; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2w9WfPgSlNGq9kAZE7gc5V3C6SFEsmr7ux+w01L1aeQ=;
        b=P8jIr2rJzJF6E54wrWw4qeg1kbCHc9QzMNB+fuhhb5yf5oc3f4hG/shsCX0FpxlvS0
         5BSzRyqq2hHm/mGrdI0CcCQ/GEXEhfrWPiv9EaCQ5ObxlhGX7aPM7jIErELprcEaM+YB
         ZPKBG4zE9mY7qg5gdze8OW6EsZx04kfp0rSB7hgS+8yriVDfO8ChWXne+fw0+bfn1Od1
         hIpsTlvGKNZaiJnXut1+5oL/Q1qyXch70nVTkmmw+z50WKppBW7zEqS3FdaXNhzzo8r4
         HaeKt/M//CCSZGNvM/Kt1W238Do0KvpWPSsKJaYC+Q3/DpT6C6IEjTEdwIE6XGEJqd2D
         BSmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772563620; x=1773168420;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2w9WfPgSlNGq9kAZE7gc5V3C6SFEsmr7ux+w01L1aeQ=;
        b=DMutkMRd1bNvavAdfnjEoFx+f9xnHyOGJ1C+1oNuY5TjWz9/grJS6ZGE0UgiM/ySes
         FIKyYnTmVu/ASk9YqwfeZ2Q90XeRznBkFeirz7xYtEIXI1qKvlxl42b4x5Hn+M06zHt0
         VCMBCbjDyXKXZmNTEuZOTObv94TEkRvMkgBNnI4/BrZsZgK9padPJIYo8Gpx/EZx12en
         JNSUVDrKC8UgBG+kH//QJ751YqWOxAryru1Ss6RdoUiizIHvzaXXLbGadwVVGtL2ZV8P
         NGbZVguMRKaNNh3KiBV/2X3paoWrhCCUPETDHD5a8GVi7DahYsfj9nr92R5RlqiRYxF6
         2nZg==
X-Forwarded-Encrypted: i=1; AJvYcCWGf2BdOA16zQ2FvebnMHlD/RN3wSW0Iv1XXsyrWWBDvFKgERkLS1yCOgFGTOxEGHS6XalqhQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyFH2kHDqn4EvLbpSwIL9ADfuS8154NJaBbhxF7NK1UlJriLhmZ
	75pctNVpyAww3zlikhgehUpx7s2F5FKtldVJkF2e7/Yb19hXNu9TzewtcVBJC7fWPbd1qKSp7VQ
	XHcPkb5vDhNcS4B/gIdSCLTo39QCQpyVsYlRZyfUBLFcy234X2/2Az9claw==
X-Gm-Gg: ATEYQzxqhjdqFxUFeovzQX3/H8TwuUMRGx7fXlibKr0ADpL78zWjScn2oLsjbwqrlOo
	vXDuUl1+88XZEriwYpggXTAEaRnU87utJdfJlQwjwNp1kA4C1XjkJOE373O8A0fVYf8nc/eE3ci
	hcfH6wyCZCyNCE7gjDSuRss/goVJnPxdsfEPmZCcYZukDkEwt/qopQU8YBbrcS8neseynsjNIzu
	7edqo8dWbYqu4oLujI5NtLdmicxmu0F5Pah156su3UqnWZCgf0iWhxSkN4x4aV/vgrXUC8GgPs4
	A2bdjsBMSeAmjisKmU5gT9WkP0Ba3sLTEfGLjTvcP0JILX/aglM7GX/FQmpNamLC0UOERgZtIlx
	JV+z1Phv70ICXv/Pu8Dr0LYG1VZRG10UY5/4lWHM2byyXdBZXx7xhzOI=
X-Received: by 2002:a17:90b:574f:b0:356:9405:759d with SMTP id 98e67ed59e1d1-35965c3c280mr13369282a91.9.1772563620313;
        Tue, 03 Mar 2026 10:47:00 -0800 (PST)
X-Received: by 2002:a17:90b:574f:b0:356:9405:759d with SMTP id 98e67ed59e1d1-35965c3c280mr13369250a91.9.1772563619746;
        Tue, 03 Mar 2026 10:46:59 -0800 (PST)
Received: from [192.168.0.172] ([49.205.248.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599ca38be9sm2077090a91.4.2026.03.03.10.46.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2026 10:46:59 -0800 (PST)
Message-ID: <e12da06d-cad5-4967-af07-64c7c6e540f4@oss.qualcomm.com>
Date: Wed, 4 Mar 2026 00:16:50 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] media: iris: add context bank devices using
 iommu-map
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
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
References: <20260227-kaanapali-iris-v2-0-850043ac3933@oss.qualcomm.com>
 <20260227-kaanapali-iris-v2-4-850043ac3933@oss.qualcomm.com>
 <rzi7qmzsofocwcqxhsqz3f3tl4ahqnwn34of6qcc54odpben5d@7okuqabxgdqh>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <rzi7qmzsofocwcqxhsqz3f3tl4ahqnwn34of6qcc54odpben5d@7okuqabxgdqh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDE1MSBTYWx0ZWRfXyky6oCbrjfGY
 A3jFyZMHf2vAxDuJjO4wkv86xwNDpNJC+vv/vvXAhNzcrDPPX/kFYGmEwJea9KwIUn/dRVWPI05
 y0hjOWDIiZ0MoxFk+apwbwmYGtbthNq8pjTJZ48VZbGA5G8x8ICeYLBEh8PBtJg02y5uziNIBMC
 0z880TqPicIXje7NJOCdXl2CICjH+diOAJNJ97RpOoxR/PWACqTwee/EVpSCUS+7a3RMshVPodi
 p1mZl4jgEM/oelE3dge88yDPJRW20X+Z+22sAeG+hepyPcaLhakjFqAoolhsAHOJ1cOkoAkhDuL
 rIKYUOd+PBghRBU7lnLYtJWUqdQyA4gZ+hOOVoAzJvJGkBcFXB8cOMBK0lK8F9O5WInoytjM1x2
 /y5Mu4hqchWvXkA5xSKjiIwU4HN54jJdn83woSJAqYHt6UJ81S1XmVnQXDHpBl9leJV6Boq6Oce
 W5ihw/5ss/KrPmR/KuQ==
X-Authority-Analysis: v=2.4 cv=T9CBjvKQ c=1 sm=1 tr=0 ts=69a72ca5 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=KPiuay1jFzAquJblYynD6w==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=BWWBYsVxUbrYxgTBB7YA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: 95XhiDyhIqLYQTVI-4vzS-hIQr_dAnCP
X-Proofpoint-ORIG-GUID: 95XhiDyhIqLYQTVI-4vzS-hIQr_dAnCP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-03_02,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603030151


On 2/28/2026 1:50 AM, Dmitry Baryshkov wrote:
> On Fri, Feb 27, 2026 at 07:41:20PM +0530, Vikash Garodia wrote:
>> Introduce different context banks(CB) and the associated buffer region.
>> Different stream IDs from VPU would be associated to one of these CB.
>> Multiple CBs are needed to increase the IOVA for the video usecases like
>> higher concurrent sessions.
>>
>> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>> ---
>>   .../platform/qcom/iris/iris_platform_common.h      | 18 +++++++
>>   drivers/media/platform/qcom/iris/iris_probe.c      | 60 ++++++++++++++++++++--
>>   drivers/media/platform/qcom/iris/iris_resources.c  | 36 +++++++++++++
>>   drivers/media/platform/qcom/iris/iris_resources.h  |  1 +
>>   4 files changed, 111 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
>> index 5a489917580eb10022fdcb52f7321a915e8b239d..03c50d6e54853fca34d7d32f65d09eb80945fcdd 100644
>> --- a/drivers/media/platform/qcom/iris/iris_platform_common.h
>> +++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
>> @@ -204,6 +204,22 @@ struct icc_vote_data {
>>   	u32 fps;
>>   };
>>   
>> +enum iris_buffer_region {
>> +	IRIS_BITSTREAM_REGION		= BIT(0),
>> +	IRIS_NON_PIXEL_REGION		= BIT(1),
>> +	IRIS_PIXEL_REGION		= BIT(2),
>> +	IRIS_SECURE_BITSTREAM_REGION	= BIT(3),
>> +	IRIS_SECURE_NON_PIXEL_REGION	= BIT(4),
>> +	IRIS_SECURE_PIXEL_REGION	= BIT(5),
> 
> Can a context bank belong to multiple regions at the same time?

yes, they would.

> 
>> +};
>> +
>> +struct iris_context_bank {
>> +	struct device *dev;
> 
> Separate data and the actual device. Define a wrapper around struct
> device for the actual runtime usage.

we still have to store the list of dynamically created device. Name can 
be used to fetch the device from the list, i think the existing approach 
is simpler ?

> 
>> +	const char *name;
>> +	const u32 f_id;
>> +	const enum iris_buffer_region region;
>> +};
>> +
>>   enum platform_pm_domain_type {
>>   	IRIS_CTRL_POWER_DOMAIN,
>>   	IRIS_HW_POWER_DOMAIN,
>> @@ -246,6 +262,8 @@ struct iris_platform_data {
>>   	u32 inst_fw_caps_enc_size;
>>   	const struct tz_cp_config *tz_cp_config_data;
>>   	u32 tz_cp_config_data_size;
>> +	struct iris_context_bank *cb_data;
>> +	u32 cb_data_size;
> 
> Do they differ from platform to platform?
Yes

> Mark them as const, it should be data only.

cb_data_size can be marked as const

> 
>>   	u32 core_arch;
>>   	u32 hw_response_timeout;
>>   	struct ubwc_config_data *ubwc_config;
>> diff --git a/drivers/media/platform/qcom/iris/iris_probe.c b/drivers/media/platform/qcom/iris/iris_probe.c
>> index ddaacda523ecb9990af0dd0640196223fbcc2cab..557adb038328a75510591d91569819abc0b7b1c9 100644
>> --- a/drivers/media/platform/qcom/iris/iris_probe.c
>> +++ b/drivers/media/platform/qcom/iris/iris_probe.c
>> @@ -123,6 +123,49 @@ static int iris_init_resets(struct iris_core *core)
>>   				     core->iris_platform_data->controller_rst_tbl_size);
>>   }
>>   
>> +static void iris_destroy_child_device(struct iris_context_bank *cb)
>> +{
>> +	struct device *dev = cb->dev;
>> +
>> +	if (dev)
>> +		device_unregister(dev);
>> +
>> +	cb->dev = NULL;
>> +}
>> +
>> +static void iris_deinit_context_bank_devices(struct iris_core *core)
>> +{
>> +	struct iris_context_bank *cb;
>> +	int i;
>> +
>> +	for (i = 0; i < core->iris_platform_data->cb_data_size; i++) {
>> +		cb = &core->iris_platform_data->cb_data[i];
>> +		iris_destroy_child_device(cb);
>> +	}
>> +}
>> +
>> +static int iris_init_context_bank_devices(struct iris_core *core)
>> +{
>> +	struct iris_context_bank *cb;
>> +	int ret, i;
>> +
>> +	for (i = 0; i < core->iris_platform_data->cb_data_size; i++) {
>> +		cb = &core->iris_platform_data->cb_data[i];
>> +
>> +		ret = iris_create_child_device_and_map(core, cb);
>> +		if (ret)
>> +			goto err_deinit_cb;
>> +	}
>> +
>> +	return 0;
>> +
>> +err_deinit_cb:
>> +	while (i-- > 0)
>> +		iris_destroy_child_device(&core->iris_platform_data->cb_data[i]);
>> +
>> +	return ret;
>> +}
>> +
>>   static int iris_init_resources(struct iris_core *core)
>>   {
>>   	int ret;
>> @@ -193,6 +236,7 @@ static void iris_remove(struct platform_device *pdev)
>>   		return;
>>   
>>   	iris_core_deinit(core);
>> +	iris_deinit_context_bank_devices(core);
>>   
>>   	video_unregister_device(core->vdev_dec);
>>   	video_unregister_device(core->vdev_enc);
>> @@ -275,12 +319,18 @@ static int iris_probe(struct platform_device *pdev)
>>   
>>   	platform_set_drvdata(pdev, core);
>>   
>> -	dma_mask = core->iris_platform_data->dma_mask;
>> -
>> -	ret = dma_set_mask_and_coherent(dev, dma_mask);
>> +	ret = iris_init_context_bank_devices(core);
>>   	if (ret)
>>   		goto err_vdev_unreg_enc;
>>   
>> +	dma_mask = core->iris_platform_data->dma_mask;
>> +
>> +	if (device_iommu_mapped(core->dev)) {
>> +		ret = dma_set_mask_and_coherent(core->dev, dma_mask);
>> +		if (ret)
>> +			goto err_deinit_cb;
>> +	}
>> +
>>   	dma_set_max_seg_size(&pdev->dev, DMA_BIT_MASK(32));
>>   	dma_set_seg_boundary(&pdev->dev, DMA_BIT_MASK(32));
>>   
>> @@ -288,10 +338,12 @@ static int iris_probe(struct platform_device *pdev)
>>   	pm_runtime_use_autosuspend(core->dev);
>>   	ret = devm_pm_runtime_enable(core->dev);
>>   	if (ret)
>> -		goto err_vdev_unreg_enc;
>> +		goto err_deinit_cb;
>>   
>>   	return 0;
>>   
>> +err_deinit_cb:
>> +	iris_deinit_context_bank_devices(core);
>>   err_vdev_unreg_enc:
>>   	video_unregister_device(core->vdev_enc);
>>   err_vdev_unreg_dec:
>> diff --git a/drivers/media/platform/qcom/iris/iris_resources.c b/drivers/media/platform/qcom/iris/iris_resources.c
>> index 773f6548370a257b8ae7332242544266cbbd61a9..be58e8620086d0f82c2c2bda29247483f5c56d79 100644
>> --- a/drivers/media/platform/qcom/iris/iris_resources.c
>> +++ b/drivers/media/platform/qcom/iris/iris_resources.c
>> @@ -6,6 +6,7 @@
>>   #include <linux/clk.h>
>>   #include <linux/devfreq.h>
>>   #include <linux/interconnect.h>
>> +#include <linux/iris_vpu_bus.h>
>>   #include <linux/pm_domain.h>
>>   #include <linux/pm_opp.h>
>>   #include <linux/pm_runtime.h>
>> @@ -141,3 +142,38 @@ int iris_disable_unprepare_clock(struct iris_core *core, enum platform_clk_type
>>   
>>   	return 0;
>>   }
>> +
>> +static void iris_device_release(struct device *dev)
>> +{
>> +	dev_set_drvdata(dev, NULL);
>> +	kfree(dev);
>> +}
>> +
>> +int iris_create_child_device_and_map(struct iris_core *core, struct iris_context_bank *cb)
>> +{
>> +	struct device *dev;
>> +	int ret;
>> +
>> +	dev = kzalloc_obj(*dev);
>> +	if (!dev)
>> +		return -ENOMEM;
>> +
>> +	dev->release = iris_device_release;
>> +	dev->bus = &iris_vpu_bus_type;
>> +	dev->parent = core->dev;
>> +	dev->coherent_dma_mask = core->iris_platform_data->dma_mask;
>> +	dev->dma_mask = &dev->coherent_dma_mask;
>> +
>> +	dev_set_name(dev, "%s", cb->name);
>> +	dev_set_drvdata(dev, cb);
>> +
>> +	ret = device_register(dev);
>> +	if (ret) {
>> +		put_device(dev);
>> +		return ret;
>> +	}
>> +
>> +	cb->dev = dev;
>> +
>> +	return 0;
>> +}
>> diff --git a/drivers/media/platform/qcom/iris/iris_resources.h b/drivers/media/platform/qcom/iris/iris_resources.h
>> index 6bfbd2dc6db095ec05e53c894e048285f82446c6..b7efe15facb203eea9ae13d5f0abdcc2ea718b4d 100644
>> --- a/drivers/media/platform/qcom/iris/iris_resources.h
>> +++ b/drivers/media/platform/qcom/iris/iris_resources.h
>> @@ -15,5 +15,6 @@ int iris_unset_icc_bw(struct iris_core *core);
>>   int iris_set_icc_bw(struct iris_core *core, unsigned long icc_bw);
>>   int iris_disable_unprepare_clock(struct iris_core *core, enum platform_clk_type clk_type);
>>   int iris_prepare_enable_clock(struct iris_core *core, enum platform_clk_type clk_type);
>> +int iris_create_child_device_and_map(struct iris_core *core, struct iris_context_bank *cb);
>>   
>>   #endif
>>
>> -- 
>> 2.34.1
>>
> 

