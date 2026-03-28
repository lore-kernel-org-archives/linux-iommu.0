Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7792136404D
	for <iommu@lists.linux.dev>; Sat, 28 Mar 2026 11:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774696925; cv=none; b=cI9BtcOpbR3PCQ4jzAZRyI3+zizYwhUoGrwP/KfI5tBKTaxjiBfGlMdMvUlpXbb+Kl4CnZlDQfJxDjpC7Ltoi7ON/MyML2YC6dprcnig1V9VchnPHcykI+3Uc0ac9rU2hKJxCC0TIDVXfr5w2VvIu5roNtPh7RWjEZfDBLpnkE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774696925; c=relaxed/simple;
	bh=RtNXBGNtRATM5jqnHVn3bv+4chif7R/yZkqXomXDMTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tG3QSgQMb18aU0lXj0Rk+DcMbvIrg+yoKwxEDrhf1pKvjJMVNUEwAd9/pNt8SJS31jVTeaymeiCSn6MDTcdcRGTsI2f2MGCoQG9jplexcdp/0A+KkdjEOV3sCOgyWiDDgNXPNpky6TNAE7gOd7RaJ+Poum58UWsfFvaFXp6MEuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZGDSk71s; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Z0HuzxuB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZGDSk71s";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z0HuzxuB"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62S3Z9HM350127
	for <iommu@lists.linux.dev>; Sat, 28 Mar 2026 11:22:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fHSZ6caN9gdEFf4pzLfXl5hJ0qRQBkpE/9XtrzJn3VU=; b=ZGDSk71s0QHAPjHH
	5u2hLCdm4aZ2avufHtVHWUeQs8reEpdPIxA5MkbUXUlzYBOilgNCxMj60VnGonMc
	GJKd87vyY85a3Evxf7lFdSVwUamuAs0VNZnkNowigSfjxXiCKNfAYBoZaZFln6oY
	XIOzERua/3OKDHHpo0pGAhKJfdiQJxn9uPUS3HaU7Hm/qjBjQgH5bMWJDho2W4kq
	gxfx/3+7jjH06baZxl6dbbdiyu6yFTGW3iPX/JbBD46mKiv8i7tuNQaI+4J4SYJe
	BozUaEO4YQYw6zmUiKGLBiu5XVissyWyHVrqRymOOwjPTJzq6Wrro1+MTsSo3iPa
	TiIqsg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d67710nwh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sat, 28 Mar 2026 11:22:01 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35c1107da15so1464878a91.2
        for <iommu@lists.linux.dev>; Sat, 28 Mar 2026 04:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774696921; x=1775301721; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fHSZ6caN9gdEFf4pzLfXl5hJ0qRQBkpE/9XtrzJn3VU=;
        b=Z0HuzxuBTyzdIMxJxRZzC8HklsX20xECxdc75d06NvTqRZEDUGsIkDUgFwsDXcmIq4
         bypVWe33omQULxvi9N8ssU3+iomRg8GPQUIdXdTZ78DD7zUCCX1yZAJY0Z97+VuVyl/r
         vugG6CS9n6VNK2DqiN2ZvLJW+r3ARAyegSQDC62Ozph76eAWz0dneRzwdEx1kou7WAZJ
         kEXYAK+UfzSmp+yzUJcW5v5+v+PJerolxaKRlBG3GFsuJfrJkYZngNOHRf2NVuAjEflw
         AW6kBrjmbCmPQ2Vx0YG8Pth535rAVQz3JCgLd/nc8+ESHehxi5MhNaF83N+YBqarNdDV
         brfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774696921; x=1775301721;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fHSZ6caN9gdEFf4pzLfXl5hJ0qRQBkpE/9XtrzJn3VU=;
        b=n/puf7+Oiz6e8TKRelkJHnmgW1gibekijAO/rOwwQhQgFWn2Ff9wfUaND5R0SBQUh5
         eG1QSFOIBaayU8dek37IWfYCP1OekT7J0luGt4V0fCmio042B9a/rHZhG7kUay6jB4x2
         TzUUXi4i3ALNyJ+QltDyUQjy4wZccLjQPV0E3zrOQ4RiRDucMV+rSYJgYbHlOSGpTjSd
         tRlundCR2tQ8VzaKZABovMvxFrNuz6wnjF/DAOo2hs2o1pAhBCbSrkQStNcPtTl2S1/3
         t4hLu1XDSRTG8TtYuMFzeFHGSCEQz9Z541fxLd9tykkjNWM/sSDYAlCjOMIJycH48+T7
         MqyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoX9GTUSQ/UTZImLA4lByQ4+DJpDIn6hck97yRAPLDIsoFvnFWMeHdsLL1JFPsPc0NFQSz7g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyHWs0Pb26MZsVL/UHZG17lbEcoWau9ocpy+RQOJz2q952BOyCE
	lC2CjuJYlr44ldejxuG4+1ErakfEuCxOiNmW4Wj+EG9O/FzikcKgDhH5efUt5/ZLxDdHJvuOFuf
	vADamsa1ocYRYjo0lnc9W6aUCdWpRJsDWiLURB4vRVzW+APTVqJXVTVWAdA==
X-Gm-Gg: ATEYQzwwk2c92nu6IyRRf8GG/dn+ppUP3oZb68ASBPKWM1LJnIeh1d4y2Pg/XvZuuQq
	OUbHsPH/Q62Dv3y4hPJUX832Hd2fGNXCv8FgYQZ+9aNk4An/N1wzfRAK4Pqs3ErMfDlm6JWb98N
	IGnYjajPNDqP4xhWZdAWxCJ0WWf13i0pLLMBCkDFP2tdqQpmkQ/p+ZfhOzcqdqS3+x3fDoDPw90
	JvINZTt1q0zKVABQjC4JzZFr2cuU78S1J8Dm5IDNq3m7zwFlkVHLcHzPDbBz/0eXH5Rjgevbf5b
	s2Z5PwmiwHe3dhDZGsiGvep08rMQ6fRctXXKEaNNIi33J21LbwdGDTi99FNadvS1mHIXqX7jbAy
	PNINCPiaNWSA3/frOP1T/6ZngshVI+HKfijvL7WGi6Ep6sBJSxPVBuRc=
X-Received: by 2002:a17:90b:4a8a:b0:35a:329:73c6 with SMTP id 98e67ed59e1d1-35c2ff50d24mr5384528a91.3.1774696921044;
        Sat, 28 Mar 2026 04:22:01 -0700 (PDT)
X-Received: by 2002:a17:90b:4a8a:b0:35a:329:73c6 with SMTP id 98e67ed59e1d1-35c2ff50d24mr5384505a91.3.1774696920519;
        Sat, 28 Mar 2026 04:22:00 -0700 (PDT)
Received: from [192.168.0.172] ([49.205.250.68])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c22db1321sm7232716a91.14.2026.03.28.04.21.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Mar 2026 04:22:00 -0700 (PDT)
Message-ID: <a0d39848-eae3-4aba-95e1-9df923e8772f@oss.qualcomm.com>
Date: Sat, 28 Mar 2026 16:51:51 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] media: iris: add platform data for kaanapali
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
References: <20260313-kaanapali-iris-v3-0-9c0d1a67af4b@oss.qualcomm.com>
 <20260313-kaanapali-iris-v3-7-9c0d1a67af4b@oss.qualcomm.com>
 <5t3bke2sjkxahn4pjhdpyznbrdmu67u7cfgdfwqgjcgo7cbg2e@4wr2jadk6b7i>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <5t3bke2sjkxahn4pjhdpyznbrdmu67u7cfgdfwqgjcgo7cbg2e@4wr2jadk6b7i>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: zBSXSAfYExAuLePnwF6gQI6-KnPEPJM0
X-Authority-Analysis: v=2.4 cv=efYwvrEH c=1 sm=1 tr=0 ts=69c7b9d9 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=yLWmkx75ThOYqhw51wEqsw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=lgd4gDGqqKjXK5urUKYA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: zBSXSAfYExAuLePnwF6gQI6-KnPEPJM0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI4MDA4MiBTYWx0ZWRfX2nosJJfZmBSJ
 bsR5xEgEUa7apJjGHgg2iG8BNlxr61lhujqbv0StmDK5OGn29cWZs1MxtXrA09OoI+DkE48bTWs
 NYlr/NrrN0hpUtbnT1yLA9pJISOJ/47ZEUcAk/ASbQYixL0p/lm47XDxn+D+QI1TGVhH4NqbbND
 R4kp31Z956mD3UyXNqG0bXGcllR9phDqE/K+NT6yH/g00t6/E+1KKK2jk2g/tCB6UzYqSdJU0AC
 RUcjPz6BnBL3vAGOtPNRV6DrZXYQkwEoG/xG7xtc/4cLyKBI+qMibISq5QhBHNDulM1uIPi7UcZ
 iFFFULmgyjLicxkdMUzU8tRBTpvUhiKWRuPVDAjw/UbfAkn4w7+6DpF6lBpzP2CeaVFiCWNvu/M
 tFtGi3nEtWlYG1hsoXM7hieGgUFENFLgjYsWpv4mtqL98NJrdlcC4ZlJEMQJQFGhB3Tus7xm80Q
 524RP8oXsvXvdfT793A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-27_02,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603280082


On 3/13/2026 9:16 PM, Dmitry Baryshkov wrote:
> On Fri, Mar 13, 2026 at 06:49:41PM +0530, Vikash Garodia wrote:
>> Add support for the kaanapali platform by re-using the SM8550
>> definitions and using the vpu4 ops.
>> Move the configurations that differs in a per-SoC platform header, that
>> will contain SoC specific data.
>>
>> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>> ---
>>   .../platform/qcom/iris/iris_platform_common.h      |  1 +
>>   .../media/platform/qcom/iris/iris_platform_gen2.c  | 90 ++++++++++++++++++++++
>>   .../platform/qcom/iris/iris_platform_kaanapali.h   | 83 ++++++++++++++++++++
>>   drivers/media/platform/qcom/iris/iris_probe.c      |  4 +
>>   4 files changed, 178 insertions(+)
>>
> 
>> diff --git a/drivers/media/platform/qcom/iris/iris_platform_kaanapali.h b/drivers/media/platform/qcom/iris/iris_platform_kaanapali.h
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..bdca1e5bf673353862c1554fb0420f73b3f519cb
>> --- /dev/null
>> +++ b/drivers/media/platform/qcom/iris/iris_platform_kaanapali.h
>> @@ -0,0 +1,83 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (c) Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +#ifndef __IRIS_PLATFORM_KAANAPALI_H__
>> +#define __IRIS_PLATFORM_KAANAPALI_H__
>> +
>> +#include <dt-bindings/media/qcom,kaanapali-iris.h>
> 
> So, you are including the bindings here, from the header, which gets
> included from the C source file including headers for all the platforms.
> What if Kaanapali+1 (or +3) defines different sets of regions?
> 

thats correct, to handle this, the soc platform data can be defined in 
iris_platform_kaanapali.c, and iris_platform_kaanapali.h can extern the 
platform data struct which gets included in gen2.c.
Also would have preferred naming the binding abi header 
"qcom,kaanapali-iris.h" to something generic so that it can be included 
in other platforms, but it seems like the maintainer does not like that 
idea.

>> +
>> +#define VIDEO_REGION_VM0_SECURE_NP_ID		1
>> +#define VIDEO_REGION_VM0_NONSECURE_NP_ID	5
>> +
>> +static const char *const kaanapali_clk_reset_table[] = {
>> +	"bus0",
>> +	"bus1",
>> +	"core",
>> +	"vcodec0_core",
>> +};
>> +
>> +static const char *const kaanapali_pmdomain_table[] = {
>> +	"venus",
>> +	"vcodec0",
>> +	"vpp0",
>> +	"vpp1",
>> +	"apv",
>> +};
>> +
>> +static const struct platform_clk_data kaanapali_clk_table[] = {
>> +	{ IRIS_AXI_CLK, "iface" },
>> +	{ IRIS_CTRL_CLK, "core" },
>> +	{ IRIS_HW_CLK, "vcodec0_core" },
>> +	{ IRIS_AXI1_CLK, "iface1" },
>> +	{ IRIS_CTRL_FREERUN_CLK, "core_freerun" },
>> +	{ IRIS_HW_FREERUN_CLK, "vcodec0_core_freerun" },
>> +	{ IRIS_BSE_HW_CLK, "vcodec_bse" },
>> +	{ IRIS_VPP0_HW_CLK, "vcodec_vpp0" },
>> +	{ IRIS_VPP1_HW_CLK, "vcodec_vpp1" },
>> +	{ IRIS_APV_HW_CLK, "vcodec_apv" },
>> +};
>> +
>> +static const char *const kaanapali_opp_clk_table[] = {
>> +	"vcodec0_core",
>> +	"vcodec_apv",
>> +	"vcodec_bse",
>> +	"core",
>> +	NULL,
>> +};
>> +
>> +static struct tz_cp_config tz_cp_config_kaanapali[] = {
>> +	{
>> +		.cp_start = VIDEO_REGION_VM0_SECURE_NP_ID,
>> +		.cp_size = 0,
>> +		.cp_nonpixel_start = 0x01000000,
>> +		.cp_nonpixel_size = 0x24800000,
>> +	},
>> +	{
>> +		.cp_start = VIDEO_REGION_VM0_NONSECURE_NP_ID,
>> +		.cp_size = 0,
>> +		.cp_nonpixel_start = 0x25800000,
>> +		.cp_nonpixel_size = 0xda400000,
>> +	},
>> +};
>> +
>> +static struct iris_context_bank kaanapali_cb_data[] = {
>> +	{
>> +		.name = "iris_bitstream",
>> +		.f_id = IRIS_BITSTREAM,
>> +		.region_mask = BIT(IRIS_BITSTREAM_REGION),
> 
> I'd say, it's really easy to mix IRIS_BITSTREAM and
> IRIS_BITSTREAM_REGION when looking at the code, which might be bad
> because they are not equal.

this logic have changed now given that the handling is now 1:1, rather 
than multi map case. Maybe..we can revisit this in v4.

Regards,
Vikash

> 
>> +	},
>> +	{
>> +		.name = "iris_non_pixel",
>> +		.f_id = IRIS_NON_PIXEL,
>> +		.region_mask = BIT(IRIS_NON_PIXEL_REGION),
>> +	},
>> +	{
>> +		.name = "iris_pixel",
>> +		.f_id = IRIS_PIXEL,
>> +		.region_mask = BIT(IRIS_PIXEL_REGION),
>> +	},
>> +};
>> +
>> +#endif /* __IRIS_PLATFORM_KAANAPALI_H__ */
>> diff --git a/drivers/media/platform/qcom/iris/iris_probe.c b/drivers/media/platform/qcom/iris/iris_probe.c
>> index 439e6e0fe8adf8287f81d26257ef2a7e9f21e53d..f6d8761daf0471d3aabec21c708445ee7698487b 100644
>> --- a/drivers/media/platform/qcom/iris/iris_probe.c
>> +++ b/drivers/media/platform/qcom/iris/iris_probe.c
>> @@ -406,6 +406,10 @@ static const struct dev_pm_ops iris_pm_ops = {
>>   };
>>   
>>   static const struct of_device_id iris_dt_match[] = {
>> +	{
>> +		.compatible = "qcom,kaanapali-iris",
>> +		.data = &kaanapali_data,
>> +	},
>>   	{
>>   		.compatible = "qcom,qcs8300-iris",
>>   		.data = &qcs8300_data,
>>
>> -- 
>> 2.34.1
>>
> 

