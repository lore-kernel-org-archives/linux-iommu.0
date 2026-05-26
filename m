Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237BB3E0741
	for <iommu@lists.linux.dev>; Tue, 26 May 2026 11:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779794528; cv=none; b=n6gin8HdX2yavwi0pGASRiL5iWA5O3vhw0IXHkuaMsXU5P/Xmun3NirI0suuCYY0TNdosFm6jwYvXdPIDJVmmcgmZsroH2i9MbUQR/LAtsitn4Ky9kCZyGwu1RJre5DXYCqKYGXLROl7KbW9EvxjSbM5qajuTeAADI/9BAmWju4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779794528; c=relaxed/simple;
	bh=/yncQd0Zxa9MLAxggJJqjRbvynz4dgJeU0MwQFRRgFU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gWGh3q44G6qOx/1SGdEkJvofamIUFjAnZ7bfCTyW8RyFN59MvMWMsa1lyOCKcLoN9nWH9F02KfzIDVvOurS1mf5/cVdhfBdwIU0jiVSqnWncZ5zvtIlLsMZDYoKN5iXcx0wEDwtn82mP7pNz64eQRwqWPJ+XYOj9dzHmNDulhRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jabu0NMZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dB9ZntTp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jabu0NMZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dB9ZntTp"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64Q6aw6q3263677
	for <iommu@lists.linux.dev>; Tue, 26 May 2026 11:22:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GWbWB92mAfm/LTqQavnqSGY4yqIRpAm3OrnreoW4Vi8=; b=jabu0NMZ+jzinQ7I
	5LihflWkF84CDpwdIY6vJOr5M4kPRlHP7f1lO5qbXX6qX1kM4lncicddI49dhxVy
	bAKdit1sWHIeBP9RypXHZ7uo+nXDF99C6bGBDABxvW+jn1M9jRdBrQhHRlvPJb+S
	w2w0y5bGPXrEsdPS38KAP0t0CWzaETGrad4+BT4fZ2fL/8kdN4Nf/+TRUIAYGaUh
	2uf/uQsdSpg7qdz1mRQ5lXQVgA0lvHgVkSkjzMdzpLI5nM1K5dTB9bQCjXeqxqkx
	hnG8Dm8z/Fjrp/6uxk7GthG4XVeSHcSWzgreDyL2oUCgKuleWXgy20vIwzmbPWm9
	qVRw+w==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ecnhs45ph-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 26 May 2026 11:22:04 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ba115ab6bbso114400235ad.3
        for <iommu@lists.linux.dev>; Tue, 26 May 2026 04:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779794524; x=1780399324; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GWbWB92mAfm/LTqQavnqSGY4yqIRpAm3OrnreoW4Vi8=;
        b=dB9ZntTp2maaBKV1yAQ6krATRh3lLnl/drEc5fLYutmivCwBYE7ohq+ppFImTrbIh/
         eCxaJGxzdEPq4fqNv6caTrF1FGCIraYi2fbVd9NOrRi1kh+Agl0ExLhClK+ug9U0CmE9
         ECrYjq1HskhLg9BQyvVCMgdn4t3HBM21Kx8PhphFl5B8/S6Cq4KbWLxhvN3MMRLMO4l2
         4IPW+yM19yt+/b71DbxwA3LLUHeesh4lcAWULcBYAePTqCX0BtJsXDnexyIm0yanru0e
         4q4veIrBWGFZ2nWCKJ61E8wnHHFqvIQi8Z1JCqNnLoAwqSUa+AqLRMerjd8TSvbSnA59
         Gdrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779794524; x=1780399324;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GWbWB92mAfm/LTqQavnqSGY4yqIRpAm3OrnreoW4Vi8=;
        b=IDqwhOYawceECrkbfK7GMgoUP9yibSrjxMNKMpwWrwfICUMsoy/7y4bHO+kjqtS3gr
         5HXA4D0kGLwEwnYpRBl7S3Knsj3cJDDni48e5cqL2xArJTBnarts0gubkzrGUwIPBSD+
         FVBdVi00pjFr8fqqj0CwbIAjwT2irM956O3iGAZhHg9540rfAMArFWi1BFkIgx8rP1Er
         eHlSDHMl4mOaxJVrq82hRUOh/L5QgclfDyYr1B3Lk0UJdQR5Yo54GphcMpuMjBTbgx4s
         MsPWvKqGkur9iSTwvvhxm1gSQUAA6iyWKpOaCYg3u9cwKe5KOO0AOSyZ1FdFh8fUoCif
         HUxQ==
X-Forwarded-Encrypted: i=1; AFNElJ9xuITTqP2RyR0WdMgvSS7oqnFCdtM9QiR109nAj7UmhCLmmSBbugr8KoGknr6e+aoA/jwkpg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx3GWRGs0+fc0+wF5MJQA5YU7xrxBgBWu24kRpVwj8kI8DDdkSr
	TZtjJPAW0Q/qPifjFEBNJDGrpr9I7odPmnpEYv0gFPD5g0msZTcyBQrgEjakQ9JeK6IlDUSvy5v
	AnLl1AOTKuuU61X916DFx65doR/vbPMXCzmY2m31O2In8GDkrGoB4gYvU+w==
X-Gm-Gg: Acq92OFla2CJvRsxiEJllZ9MeLks8HSnQV7rriXdgIU6gjj0MTlLh2p75RZBQBsx7gz
	IP/Hg9LH2loeOdEl5XW7q7MDeuqQfXokEn2KfO9fKx0Cd+fxjOIlgLngM50LdKnGz7IF8Lxlq3Q
	dv3gthZHaz+wSweEvvSFlPnQEHcw0DMdREFcjcqnFWK6hzgqVw6xj+RrtDwHeNSOf8CQ3PRiTw2
	wA4iDiLRrB1Ydkwuoqwi6QCbwDV73/ML4gwojOj+WIcLpNrBhMmC5H6MTDYfdqw1AD2bhOs1YEO
	8ZjIUVsJLOuy33C1iB6AD7NX7hilxw2+ZdHoo4wKQirVyB4ptElpg02w3j3xb7Xnr+TwhwRmVZ1
	u2y3A3WQxX5mtA1Z62E22PgnlWWmYjexBTd9qGdaZcYN2AcqUoSszUQ==
X-Received: by 2002:a17:903:f8b:b0:2b2:5503:1b8c with SMTP id d9443c01a7336-2beb06c4f36mr191751935ad.11.1779794523812;
        Tue, 26 May 2026 04:22:03 -0700 (PDT)
X-Received: by 2002:a17:903:f8b:b0:2b2:5503:1b8c with SMTP id d9443c01a7336-2beb06c4f36mr191751495ad.11.1779794523240;
        Tue, 26 May 2026 04:22:03 -0700 (PDT)
Received: from [10.206.105.200] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb56b5886sm109627245ad.20.2026.05.26.04.21.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 04:22:02 -0700 (PDT)
Message-ID: <c05c27ff-033a-6b38-5d51-a712d8a515f4@oss.qualcomm.com>
Date: Tue, 26 May 2026 16:51:54 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Subject: Re: [PATCH v6 10/14] media: iris: Add power sequence for Glymur
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
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org
References: <20260515-glymur-v6-0-f6a99cb43a24@oss.qualcomm.com>
 <20260515-glymur-v6-10-f6a99cb43a24@oss.qualcomm.com>
 <u4twzqwgu75ermwdi5miw7r4gkjw4iaok35jcm6o4ecgpst4rz@a63dq3cihmes>
Content-Language: en-US
In-Reply-To: <u4twzqwgu75ermwdi5miw7r4gkjw4iaok35jcm6o4ecgpst4rz@a63dq3cihmes>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Vd3H+lp9 c=1 sm=1 tr=0 ts=6a15825c cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=Ewolc4YIVSBHiCPDOKEA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: eLflmZscZJX8dXuQ03pghddBWTarP-Ul
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDA5OSBTYWx0ZWRfX8cgsein95P1J
 G8oIdyoLsjNmQahJyWSlufK2PPM9xTaVXwVl0iWNkEWRd6GZqxO5iejVI6xje59MQhUTEOvRuCB
 6/DM9mO4XOCzC/0vvOR9ZjsNctUuMeoNZn6+pYTdYlfTWqD9dSeaRkVSuFd/k/6ijRTlIPzUHPi
 w6ECBKqxY8SV7WWPqxiocr6SJSyjAabs9ALw4M23ft21vN7qAXIL1W4Y5T7keUcbMGuVeHdsmJK
 LM+LPv0H2KQ4T+sHT75Q98y1wXJlCYpaWrPEdMsmoA8RrDDtAg3ZqZIQJIarRrLIo38nN/nnN6r
 LvvvXLzWkqToH8JFLHpdf0PMNOOjg3g8l97OplLy8gdJ8JHcydm9w6sB/e970xRifchnhkXm4Sb
 Bf5EzRnPB/tcLXYoby2MCkH3Ct1t66ihERp2xxjfb/byLk/o2TJTn64pZdLNpO9lfQLqE0GslK2
 kW+s0C8YHNM5ebZ2iMQ==
X-Proofpoint-ORIG-GUID: eLflmZscZJX8dXuQ03pghddBWTarP-Ul
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_02,2026-05-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260099


On 5/17/2026 11:39 PM, Dmitry Baryshkov wrote:
> On Fri, May 15, 2026 at 04:51:25PM +0530, Vishnu Reddy wrote:
>> The Glymur platform has two video codec cores: vcodec0 and vcodec1.
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
>> Reuse the existing code wherever possible and add power sequence for
>> vcodec1.
>>
>> Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>> ---
>>  .../platform/qcom/iris/iris_platform_common.h      |   4 +
>>  drivers/media/platform/qcom/iris/iris_vpu3x.c      | 137 ++++++++++++++++++++-
>>  drivers/media/platform/qcom/iris/iris_vpu_common.h |   1 +
>>  .../platform/qcom/iris/iris_vpu_register_defines.h |  10 ++
>>  4 files changed, 147 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
>> index 1d757cb8e9e1..366e499dec53 100644
>> --- a/drivers/media/platform/qcom/iris/iris_platform_common.h
>> +++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
>> @@ -63,6 +63,9 @@ enum platform_clk_type {
>>  	IRIS_VCODEC_VPP0_CLK,
>>  	IRIS_VCODEC_VPP1_CLK,
>>  	IRIS_APV_HW_CLK,
>> +	IRIS_AXI_VCODEC1_CLK,
>> +	IRIS_VCODEC1_CLK,
>> +	IRIS_VCODEC1_FREERUN_CLK,
>>  };
>>  
>>  struct platform_clk_data {
>> @@ -208,6 +211,7 @@ enum platform_pm_domain_type {
>>  	IRIS_VCODEC_VPP0_POWER_DOMAIN,
>>  	IRIS_VCODEC_VPP1_POWER_DOMAIN,
>>  	IRIS_APV_HW_POWER_DOMAIN,
>> +	IRIS_VCODEC1_POWER_DOMAIN,
>>  };
>>  
>>  struct iris_firmware_data {
>> diff --git a/drivers/media/platform/qcom/iris/iris_vpu3x.c b/drivers/media/platform/qcom/iris/iris_vpu3x.c
>> index 39e9c78c3a69..68a4997af23f 100644
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
>> @@ -254,6 +254,124 @@ static void iris_vpu35_power_off_hw(struct iris_core *core)
>>  	iris_disable_unprepare_clock(core, IRIS_AXI_VCODEC_CLK);
>>  }
>>  
>> +static int iris_vpu36_power_on_hw1(struct iris_core *core)
>> +{
>> +	int ret;
>> +
>> +	ret = iris_enable_power_domains(core, IRIS_VCODEC1_POWER_DOMAIN);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = iris_prepare_enable_clock(core, IRIS_AXI_VCODEC1_CLK);
>> +	if (ret)
>> +		goto err_disable_hw1_power;
>> +
>> +	ret = iris_prepare_enable_clock(core, IRIS_VCODEC1_FREERUN_CLK);
>> +	if (ret)
>> +		goto err_disable_axi1_clk;
>> +
>> +	ret = iris_prepare_enable_clock(core, IRIS_VCODEC1_CLK);
>> +	if (ret)
>> +		goto err_disable_hw1_free_clk;
> And this is what I'm talking about for the indirection. To bring up the
> vcodec core, you need to enable several power domains and then power on
> several clocks. Here you list them all one by one.
>
> Compare this to:
>
> struct iris_vcodec {
> 	struct device *dev;
> 	struct device* pd;
> 	struct clk_bulk_data *clocks;
> 	unsigned int num_clocks;
> };
>
> int iris_vcodec_power_on(struct iris_core *core, struct iris_vcodec *vc)
> {
> 	int ret;
>
> 	ret = iris_opp_set_rate(vc->dev, ULONG_MAX);
> 	if (ret)
> 		return ret;
>
> 	ret = pm_runtime_get_sync(vc->pd);
> 	if (ret < 0)
> 		return ret;
>
> 	ret = clk_bulk_prepare_enable(vc->num_clocks, vc->clocks);
> 	if (ret)
> 		pm_runtime_put_sync(vc->pd);
>
> 	return ret;
> }
>
> This is the generic code, handling vcodec enablement on any platform,
> including Glymur. Most platforms will have one vcodec instance, Glymur
> will have two (or it can be an array of those). The only difference
> would be in the platform code, filling the fields of that structure.

Thanks for the suggestion, I'll work on this and post the updated changes in
the next revision.

>> +
>> +	return 0;
>> +
>> +err_disable_hw1_free_clk:
>> +	iris_disable_unprepare_clock(core, IRIS_VCODEC1_FREERUN_CLK);
>> +err_disable_axi1_clk:
>> +	iris_disable_unprepare_clock(core, IRIS_AXI_VCODEC1_CLK);
>> +err_disable_hw1_power:
>> +	iris_disable_power_domains(core, IRIS_VCODEC1_POWER_DOMAIN);
>> +
>> +	return ret;
>> +}
>> +
>> +static int iris_vpu36_power_on_hw(struct iris_core *core)
>> +{
>> +	int ret;
>> +
>> +	ret = iris_vpu35_power_on_hw(core);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = iris_vpu36_power_on_hw1(core);
>> +	if (ret)
>> +		goto err_power_off_hw;
> static int iris_vpu_power_on_vcodecs(struct iris_core *core)
> {
> 	int i, ret;
>
> 	for (i = 0; i < core->num_vcodec; i++) {
> 		ret = iris_vcodec_power_on(core, core->vc[i]);
> 		if (ret)
> 			goto err;
> 	}
>
> 	return 0;
>
> err:
> 	for (; i >= 0; i--)
> 		iris_vcodec_power_off(core, core->vc[i]);
>
> 	return ret;
> }
>
> Similar abstraction for powering on the whole core, calling
> iris_vpu_power_on_vcodecs() inside.
>
>
>> +
>> +	return 0;
>> +
>> +err_power_off_hw:
>> +	iris_vpu35_power_off_hw(core);
>> +
>> +	return ret;
>> +}
>> +
>> +static void iris_vpu36_power_off_hw1(struct iris_core *core)
>> +{
>> +	u32 value, i;
>> +	int ret;
>> +
>> +	if (iris_vpu3x_hw_power_collapsed(core, VCODEC1_POWER_STATUS))
>> +		goto disable_power;
>> +
>> +	value = readl(core->reg_base + WRAPPER_CORE_CLOCK_CONFIG);
>> +	if (value)
>> +		writel(CORE_CLK_RUN, core->reg_base + WRAPPER_CORE_CLOCK_CONFIG);
>> +
>> +	for (i = 0; i < core->iris_platform_data->num_vpp_pipe; i++) {
>> +		ret = readl_poll_timeout(core->reg_base + VCODEC1_SS_IDLE_STATUSN + 4 * i,
>> +					 value, value & DMA_NOC_IDLE, 2000, 20000);
>> +		if (ret)
>> +			goto disable_power;
>> +	}
>> +
>> +	writel(REQ_VCODEC1_POWER_DOWN_PREP, core->reg_base + AON_WRAPPER_MVP_NOC_LPI_CONTROL);
>> +	ret = readl_poll_timeout(core->reg_base + AON_WRAPPER_MVP_NOC_LPI_STATUS,
>> +				 value, value & NOC_LPI_VCODEC1_STATUS_DONE, 2000, 20000);
>> +	if (ret)
>> +		goto disable_power;
>> +
>> +	writel(0, core->reg_base + AON_WRAPPER_MVP_NOC_LPI_CONTROL);
>> +
>> +	writel(VCODEC1_BRIDGE_SW_RESET | VCODEC1_BRIDGE_HW_RESET_DISABLE, core->reg_base +
>> +	       CPU_CS_AHB_BRIDGE_SYNC_RESET);
>> +	writel(VCODEC1_BRIDGE_HW_RESET_DISABLE, core->reg_base + CPU_CS_AHB_BRIDGE_SYNC_RESET);
>> +	writel(0x0, core->reg_base + CPU_CS_AHB_BRIDGE_SYNC_RESET);
>> +
>> +disable_power:
>> +	iris_genpd_set_hwmode(core, IRIS_VCODEC1_POWER_DOMAIN, false);
>> +	iris_disable_unprepare_clock(core, IRIS_VCODEC1_CLK);
>> +	iris_disable_unprepare_clock(core, IRIS_VCODEC1_FREERUN_CLK);
>> +	iris_disable_unprepare_clock(core, IRIS_AXI_VCODEC1_CLK);
>> +	iris_disable_power_domains(core, IRIS_VCODEC1_POWER_DOMAIN);
>> +}
>> +
>> +static void iris_vpu36_power_off_hw(struct iris_core *core)
>> +{
>> +	iris_vpu35_power_off_hw(core);
>> +	iris_vpu36_power_off_hw1(core);
>> +}
>> +
>> +static int iris_vpu36_set_hwmode(struct iris_core *core)
>> +{
>> +	int ret;
>> +
>> +	ret = iris_genpd_set_hwmode(core, IRIS_VCODEC_POWER_DOMAIN, true);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = iris_genpd_set_hwmode(core, IRIS_VCODEC1_POWER_DOMAIN, true);
>> +	if (ret)
>> +		goto error_disable_vcodec_hwmode;
>> +
>> +	return 0;
>> +
>> +error_disable_vcodec_hwmode:
>> +	iris_genpd_set_hwmode(core, IRIS_VCODEC_POWER_DOMAIN, false);
>> +
>> +	return ret;
>> +}
>> +
>>  const struct vpu_ops iris_vpu3_ops = {
>>  	.power_off_hw = iris_vpu3_power_off_hardware,
>>  	.power_on_hw = iris_vpu_power_on_hw,
>> @@ -281,3 +399,12 @@ const struct vpu_ops iris_vpu35_ops = {
>>  	.calc_freq = iris_vpu3x_vpu4x_calculate_frequency,
>>  	.set_hwmode = iris_vpu_set_hwmode,
>>  };
>> +
>> +const struct vpu_ops iris_vpu36_ops = {
>> +	.power_off_hw = iris_vpu36_power_off_hw,
>> +	.power_on_hw = iris_vpu36_power_on_hw,
>> +	.power_off_controller = iris_vpu35_vpu4x_power_off_controller,
>> +	.power_on_controller = iris_vpu35_vpu4x_power_on_controller,
>> +	.calc_freq = iris_vpu3x_vpu4x_calculate_frequency,
>> +	.set_hwmode = iris_vpu36_set_hwmode,
>> +};
>> diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.h b/drivers/media/platform/qcom/iris/iris_vpu_common.h
>> index 09799a375c14..63bf0cec58e2 100644
>> --- a/drivers/media/platform/qcom/iris/iris_vpu_common.h
>> +++ b/drivers/media/platform/qcom/iris/iris_vpu_common.h
>> @@ -12,6 +12,7 @@ extern const struct vpu_ops iris_vpu2_ops;
>>  extern const struct vpu_ops iris_vpu3_ops;
>>  extern const struct vpu_ops iris_vpu33_ops;
>>  extern const struct vpu_ops iris_vpu35_ops;
>> +extern const struct vpu_ops iris_vpu36_ops;
>>  extern const struct vpu_ops iris_vpu4x_ops;
>>  
>>  struct vpu_ops {
>> diff --git a/drivers/media/platform/qcom/iris/iris_vpu_register_defines.h b/drivers/media/platform/qcom/iris/iris_vpu_register_defines.h
>> index 72168b9ffa73..e67d98b8c91e 100644
>> --- a/drivers/media/platform/qcom/iris/iris_vpu_register_defines.h
>> +++ b/drivers/media/platform/qcom/iris/iris_vpu_register_defines.h
>> @@ -7,6 +7,7 @@
>>  #define __IRIS_VPU_REGISTER_DEFINES_H__
>>  
>>  #define VCODEC_BASE_OFFS			0x00000000
>> +#define VCODEC1_BASE_OFFS			0x00040000
>>  #define AON_MVP_NOC_RESET			0x0001F000
>>  #define CPU_BASE_OFFS				0x000A0000
>>  #define WRAPPER_BASE_OFFS			0x000B0000
>> @@ -14,6 +15,8 @@
>>  #define AON_BASE_OFFS				0x000E0000
>>  
>>  #define VCODEC_SS_IDLE_STATUSN			(VCODEC_BASE_OFFS + 0x70)
>> +#define VCODEC1_SS_IDLE_STATUSN			(VCODEC1_BASE_OFFS + 0x70)
>> +#define DMA_NOC_IDLE				BIT(22)
>>  
>>  #define AON_WRAPPER_MVP_NOC_RESET_REQ		(AON_MVP_NOC_RESET + 0x000)
>>  #define VIDEO_NOC_RESET_REQ			(BIT(0) | BIT(1))
>> @@ -35,6 +38,8 @@
>>  #define CPU_CS_AHB_BRIDGE_SYNC_RESET		(CPU_CS_BASE_OFFS + 0x160)
>>  #define CORE_BRIDGE_SW_RESET			BIT(0)
>>  #define CORE_BRIDGE_HW_RESET_DISABLE		BIT(1)
>> +#define VCODEC1_BRIDGE_SW_RESET			BIT(2)
>> +#define VCODEC1_BRIDGE_HW_RESET_DISABLE		BIT(3)
>>  
>>  #define CPU_CS_X2RPMH				(CPU_CS_BASE_OFFS + 0x168)
>>  #define MSK_SIGNAL_FROM_TENSILICA		BIT(0)
>> @@ -52,14 +57,19 @@
>>  #define WRAPPER_DEBUG_BRIDGE_LPI_STATUS		(WRAPPER_BASE_OFFS + 0x58)
>>  #define WRAPPER_IRIS_CPU_NOC_LPI_CONTROL	(WRAPPER_BASE_OFFS + 0x5C)
>>  #define REQ_POWER_DOWN_PREP			BIT(0)
>> +#define REQ_VCODEC1_POWER_DOWN_PREP		BIT(1)
>>  
>>  #define WRAPPER_IRIS_CPU_NOC_LPI_STATUS		(WRAPPER_BASE_OFFS + 0x60)
>>  #define NOC_LPI_STATUS_DONE			BIT(0) /* Indicates the NOC handshake is complete */
>>  #define NOC_LPI_STATUS_DENY			BIT(1) /* Indicates the NOC handshake is denied */
>>  #define NOC_LPI_STATUS_ACTIVE			BIT(2) /* Indicates the NOC is active */
>> +#define NOC_LPI_VCODEC1_STATUS_DONE		BIT(8)
>>  
>>  #define WRAPPER_IRIS_VCODEC_VPU_WRAPPER_SPARE_0	(WRAPPER_BASE_OFFS + 0x78)
>>  #define WRAPPER_CORE_POWER_STATUS		(WRAPPER_BASE_OFFS + 0x80)
>> +#define VCODEC0_POWER_STATUS			BIT(1)
>> +#define VCODEC1_POWER_STATUS			BIT(4)
>> +
>>  #define WRAPPER_CORE_CLOCK_CONFIG		(WRAPPER_BASE_OFFS + 0x88)
>>  #define CORE_CLK_RUN				0x0
>>  
>>
>> -- 
>> 2.34.1
>>
