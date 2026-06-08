Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C393783A1
	for <iommu@lists.linux.dev>; Mon,  8 Jun 2026 05:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780897173; cv=none; b=jVua3oSk9tTvXWBBKfL2jSb4yThF0O1lruZuU6BE8oXjVuJYqimdZLcfMkvpkVlOIf77/YQGPN/hjV5pzyIl7Ycugsjr67JAEeLsoWvSNxo6q6HRnFfq9QBhaMUH1Jg5Fd0rcNVYI1qehYU00XhIHSKYzaej/40hPs++MHJFk9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780897173; c=relaxed/simple;
	bh=cMCkxruPB0+/BzQoZuFiIbm/OEHgsUhSYjlGeEC+JAM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=po1tUfbpknFKeEsAnnxSEy+TxlxcSHvxjh03d03Gm2fM+gS27TZi1YpaGq1iga0+kNlNz9fu48IkjhpkeTdJObmvbupgpmLzvq0cLdftZ1kZZU36fSAsBSZZnlFwivOCQ3KHch4+y3eTB3a/0Xce3alHnwnAZitpyxEc4jejDoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Aux8Bjki; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dfWR0SYt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Aux8Bjki";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dfWR0SYt"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6580ECwU1575140
	for <iommu@lists.linux.dev>; Mon, 8 Jun 2026 05:39:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0HUAabhh/cNwlZD3LTk55FqmkLMmZVgRrQqnCafWe2g=; b=Aux8BjkioW1WDjDC
	fiEEiqjE79eRs9GyMm9EA+dmldhCR5bCbUFu+lz8UOy9hlUWW88+WrcujAF365p8
	Lqf9vwGHMkWekA/kQtBM3bO20YYIdLDkn+ZaCpSRTeV+eAJ2MYbZKDoVjeihkzOM
	tFMGttspDZOdqccrwqmKzNqmaJ8KapXcE3qFy+eHM8etnIJ3Xhq1Mp1ME7CJ+glT
	RaZomr6hDzH+JydZ5acKIPaEWfMuBZ/Rw7ckBOEYXzmPlog2TstOQNY5FhEO/eU2
	UOZsxN3N0Vq+KqN1i15kIfW6wECKDBytGdpmiZnKW2HgOuidvcZzNn+ROL56jzC2
	qaIVRw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4embs1dv1s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 08 Jun 2026 05:39:31 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-36bbcd40642so2864104a91.0
        for <iommu@lists.linux.dev>; Sun, 07 Jun 2026 22:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780897170; x=1781501970; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0HUAabhh/cNwlZD3LTk55FqmkLMmZVgRrQqnCafWe2g=;
        b=dfWR0SYted7R6fhYwWlRt26B87u0S4RkzqfGNlOkK4nUb4kJ5wJm+xbKhfJ9ZJmzkr
         EjR0UtN08mQXfguUxt7o7IlPAf2v22ycz9c+rTC/Z4ZFzBIY0rtlxFkVperk2d27fMQf
         T6waDrSTyfYZlmiLFyv5z1PSoYLFB2l/pEOfvbdiKHx/kpoIgpL83kAbe73/NZDUmWyj
         n6e5GbSx/M7F2JeE/oPCWpzOtrQQTvqciL/xf2fXUOb0C7Nc3TlKlzSZ21IfBDbPUFLI
         Uq4Q+mzWm8eST03aqDll7FrFWPOyyP4KPbwXH9YiBc4moOQ0t3znwPXEd1yYvDEhdTVa
         Thyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780897170; x=1781501970;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0HUAabhh/cNwlZD3LTk55FqmkLMmZVgRrQqnCafWe2g=;
        b=O6Lublxt22Zeh3jmLXUFufbmvuCaJkHTUWBcOSiKBL+wh4Pnizp/WM26cfaEwzr0Zq
         EGaL0Vs2Xn2sRqAyWBG1O/9BQ/yC5uY9v4awXoXi81oT1m4W4YSnbc7I1+Ud9x3avaXS
         wDEtIt0FXzJ6Gtcn9mEpfnkqDZxGaGuVq1/Tr9+r0xMSu3qFAesNTRq9oKYMzLOTwFeN
         2tpJ9T2EfsnXysWkszVANpanDvFQjN4EYDlk/10QnyB8/DohESizpwvrJsIYsfKIRRNY
         RQ7h7K2QuOpZF2yhIV7WQMQte5uDR/D2FMrUkUEAkuLWFX8FXvCL3OR6FfwBhNNHZFds
         uNRQ==
X-Forwarded-Encrypted: i=1; AFNElJ9vExGk5IA3vPU78S57TCVDecIyqRofx4GYfqy0jGKP89BEqnpHR6XH6cd+Ejl2uQX/UxronQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwVdNTyFJ9ThAqLhI40qgLXMQtHKw3O8iPI3T0ou0XrQHM2SR9I
	ocwUDiu4HRQJJm9rI2pfXHLH1yXLRkMmbT3eBsZCgy1nj0IO9DJzscDuR/PllojsQoHtLm9nEzE
	eWs1VOKaZox7x/zFSNicaoigBxeFYxcmT87s9EWi5OafQOXCfI+ZfIC/G3w==
X-Gm-Gg: Acq92OGwPL/kSqEztmUq3nZ9ABLt8z11qnuUYyQoG66EXd3TzD8MUJbI9r+4G3QSGs1
	VJldkCbmhTmKfKHgy++XU58bxmLelqzNqZh2dIvR/I+ru+T1NJPxL9cex8xN2Ff4MMOHKLwCZxf
	SntY95s6lUHhpzT8glQPdYFnYMYK3qZWvOlxueTcAeNTIiZ7uWq/9ydRxPEt5ZOrPlhRb1DVr2a
	2eTfl0NO6y25I/HZOUmZepH/yS2jH28i/Ub1cAHMJGvSv8Tm+QHZqmbuK38qk6EcEu8kLF8BxTS
	ubQ3lLcDkzOp3UzgiRnrDJwra5U2N/72lZFdZIXotyrFZyeuYNE0J4ebLUnKl/18+7x55hAJCc9
	ECABW93SO/Vh29Yw1WtmX8khPmcUDK+BYXSZ3IvJRXz73h525+duHwoI5npfYFIV/
X-Received: by 2002:a17:90b:548e:b0:369:e4d4:79c6 with SMTP id 98e67ed59e1d1-370f0b55fbemr14256607a91.20.1780897170487;
        Sun, 07 Jun 2026 22:39:30 -0700 (PDT)
X-Received: by 2002:a17:90b:548e:b0:369:e4d4:79c6 with SMTP id 98e67ed59e1d1-370f0b55fbemr14256589a91.20.1780897170005;
        Sun, 07 Jun 2026 22:39:30 -0700 (PDT)
Received: from [10.206.105.200] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3712ef0add7sm8612386a91.0.2026.06.07.22.39.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jun 2026 22:39:29 -0700 (PDT)
Message-ID: <b9a11d38-13f7-ee33-0537-2557050afdfa@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 11:09:22 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Subject: Re: [PATCH v7 07/12] media: iris: Add power sequence for glymur
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org
References: <20260603-glymur-v7-0-afaa55d11fe0@oss.qualcomm.com>
 <20260603-glymur-v7-7-afaa55d11fe0@oss.qualcomm.com>
 <g5fpxwtlajz4p6gn55pjtgb2czjkbjyjlii2zkznle6lbtdgzb@zsiafc57gaco>
Content-Language: en-US
In-Reply-To: <g5fpxwtlajz4p6gn55pjtgb2czjkbjyjlii2zkznle6lbtdgzb@zsiafc57gaco>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA0OSBTYWx0ZWRfX1w2OiJXIAYue
 e9nEodwkFNvFZHgsTt1CIYTX8FBq/Z8+3feKJ27vD+pxU2AmaYn24aLCbtRrMcOwVt7OKA7SnWv
 MjCMuoS/D5KJRzZs0Wn/nVNhn2j2qm+Exq20fsYQx7KtHf5fsxbQq/LB6HJh4RWcKMfybFio3K4
 4zXD6S2TnCKbPn5aPjSNKOehivWJyqcCSQI3yR7XpfXdmLxwcfIwrSlvUv1e1pd8UpcGn/EhVzI
 gCORt4NCnfJ/GBKi6TUWQtbguZyWErUpDb2fhYPvde14tspkeDtnfgVs7atsLKZEHBgOZsjrCP5
 KccR3dqIukybvpBM05EWvszeAOq0B8vquh/WSueRN/FqcA2AFSl/95U9nsLwBh4VGNhFs5bur1y
 xo8Gc+hB4wtpocXtBZFWzMoieZuvSdaDz6gRNH0Wkj25OGmwuXk88Ep9NHJBbwyv8b7ic6OKWDh
 xtvX4H3eSC8FmujAm6A==
X-Authority-Analysis: v=2.4 cv=CeY4Irrl c=1 sm=1 tr=0 ts=6a265593 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=XOSsvO-zd5c9LZtoon0A:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: ucjVaw9yInEs9iTxg__Ffj2xsWJ_XSVC
X-Proofpoint-GUID: ucjVaw9yInEs9iTxg__Ffj2xsWJ_XSVC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_01,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080049


On 6/8/2026 3:17 AM, Dmitry Baryshkov wrote:
> On Wed, Jun 03, 2026 at 07:48:45PM +0530, Vishnu Reddy wrote:
>> Glymur platform has two video codec cores: vcodec0 and vcodec1.
>>
>> Both cores share a common clock source (video_cc_mvs0_clk_src) and the
>> same power rails. The clock dividers between the source and the branch
>> clocks are fixed. So when both cores are running, the source clock always
>> runs at the highest frequency requested by either core.
>>
>> Since both cores share the same power rails, the power corner cannot be
>> voted independently. Scaling one core's power corner up or down would
>> directly affect the other, leading to under or over-voting.
>>
>> For these reasons, both cores should voted the clock and power rail must
>> be based on the workload of both cores.
>>
>> Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>> ---
>>  drivers/media/platform/qcom/iris/iris_vpu3x.c      | 111 ++++++++++++++++++++-
>>  drivers/media/platform/qcom/iris/iris_vpu_common.h |   1 +
>>  .../platform/qcom/iris/iris_vpu_register_defines.h |  10 ++
>>  3 files changed, 117 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/media/platform/qcom/iris/iris_vpu3x.c b/drivers/media/platform/qcom/iris/iris_vpu3x.c
>> index 7cda94601555..f07eaf4b3be2 100644
>> --- a/drivers/media/platform/qcom/iris/iris_vpu3x.c
>> +++ b/drivers/media/platform/qcom/iris/iris_vpu3x.c
>> @@ -17,14 +17,14 @@
>>  #define NOC_HALT				BIT(0)
>>  #define AON_WRAPPER_SPARE			(AON_BASE_OFFS + 0x28)
>>  
>> -static bool iris_vpu3x_hw_power_collapsed(struct iris_core *core)
>> +static bool iris_vpu3x_hw_power_collapsed(struct iris_core *core, u32 pwr_status_bit)
>>  {
>>  	u32 value, pwr_status;
>>  
>>  	value = readl(core->reg_base + WRAPPER_CORE_POWER_STATUS);
>> -	pwr_status = value & BIT(1);
>> +	pwr_status = value & pwr_status_bit;
>>  
>> -	return pwr_status ? false : true;
>> +	return !pwr_status;
>>  }
>>  
>>  static void iris_vpu3_power_off_hardware(struct iris_core *core)
>> @@ -32,7 +32,7 @@ static void iris_vpu3_power_off_hardware(struct iris_core *core)
>>  	u32 reg_val = 0, value, i;
>>  	int ret;
>>  
>> -	if (iris_vpu3x_hw_power_collapsed(core))
>> +	if (iris_vpu3x_hw_power_collapsed(core, VCODEC0_POWER_STATUS))
>>  		goto disable_power;
>>  
>>  	dev_err(core->dev, "video hw is power on\n");
>> @@ -78,7 +78,7 @@ static void iris_vpu33_power_off_hardware(struct iris_core *core)
>>  	u32 count = 0;
>>  	int ret;
>>  
>> -	if (iris_vpu3x_hw_power_collapsed(core))
>> +	if (iris_vpu3x_hw_power_collapsed(core, VCODEC0_POWER_STATUS))
>>  		goto disable_power;
>>  
>>  	dev_err(core->dev, "video hw is power on\n");
>> @@ -221,6 +221,98 @@ static void iris_vpu35_power_off_hw(struct iris_core *core)
>>  	iris_vpu33_power_off_hardware(core);
>>  }
>>  
>> +static void iris_vpu36_power_off_vcodec(struct iris_core *core, u32 core_id)
>> +{
>> +	u32 value, i;
>> +	int ret;
>> +
>> +	if (iris_vpu3x_hw_power_collapsed(core,
>> +					  core_id ? VCODEC1_POWER_STATUS : VCODEC0_POWER_STATUS))
>> +		goto disable_power;
>> +
>> +	value = readl(core->reg_base + WRAPPER_CORE_CLOCK_CONFIG);
>> +	if (value)
>> +		writel(CORE_CLK_RUN, core->reg_base + WRAPPER_CORE_CLOCK_CONFIG);
>> +
>> +	for (i = 0; i < core->iris_platform_data->num_vpp_pipe; i++) {
>> +		ret = readl_poll_timeout(core->reg_base + (core_id ? VCODEC1_SS_IDLE_STATUSN :
>> +					 VCODEC_SS_IDLE_STATUSN) + 4 * i, value,
>> +					 value & DMA_NOC_IDLE, 2000, 20000);
> Unreadable. Extract register addresses to separate variables.

Ack

>> +		if (ret)
>> +			goto disable_power;
>> +	}
>> +
>> +	writel(core_id ? REQ_VCODEC1_POWER_DOWN_PREP : REQ_POWER_DOWN_PREP,
>> +	       core->reg_base + AON_WRAPPER_MVP_NOC_LPI_CONTROL);
>> +	ret = readl_poll_timeout(core->reg_base + AON_WRAPPER_MVP_NOC_LPI_STATUS, value,
>> +				 value & (core_id ? NOC_LPI_VCODEC1_STATUS_DONE :
>> +				 NOC_LPI_STATUS_DONE), 2000, 20000);
>> +	if (ret)
>> +		goto disable_power;
>> +
>> +	writel(0, core->reg_base + AON_WRAPPER_MVP_NOC_LPI_CONTROL);
>> +
>> +	writel((core_id ? VCODEC1_BRIDGE_SW_RESET | VCODEC1_BRIDGE_HW_RESET_DISABLE :
>> +	       CORE_BRIDGE_SW_RESET | CORE_BRIDGE_HW_RESET_DISABLE),
>> +	       core->reg_base + CPU_CS_AHB_BRIDGE_SYNC_RESET);
>> +	writel(core_id ? VCODEC1_BRIDGE_HW_RESET_DISABLE : CORE_BRIDGE_HW_RESET_DISABLE,
>> +	       core->reg_base + CPU_CS_AHB_BRIDGE_SYNC_RESET);
>> +	writel(0x0, core->reg_base + CPU_CS_AHB_BRIDGE_SYNC_RESET);
>> +
>> +disable_power:
>> +	dev_pm_genpd_set_hwmode(core->vcodec[core_id].dev, false);
>> +	iris_disable_power_domain_and_clocks(core, &core->vcodec[core_id]);
>> +}
>> +
>> +static void iris_vpu36_power_off_hw(struct iris_core *core)
>> +{
>> +	u32 num_cores = max(core->iris_platform_data->num_cores, 1);
> Can we trust the patch authors that VPU3.6 hardware data will have at
> least 1 core?

On Glymur (VPU3.6), num_cores is 2. The max() guard is unnecessary.
Will access num_cores directly.

>> +	int i;
>> +
>> +	for (i = 0; i < num_cores; i++)
>> +		iris_vpu36_power_off_vcodec(core, i);
>> +}
>> +
>>  #define WRAPPER_DEBUG_BRIDGE_LPI_STATUS		(WRAPPER_BASE_OFFS + 0x58)
>>  #define WRAPPER_IRIS_CPU_NOC_LPI_CONTROL	(WRAPPER_BASE_OFFS + 0x5C)
> Lowercase hex.

Ack

>>  #define REQ_POWER_DOWN_PREP			BIT(0)
>> +#define REQ_VCODEC1_POWER_DOWN_PREP		BIT(1)
>>  
