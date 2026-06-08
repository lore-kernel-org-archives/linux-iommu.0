Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B83340408
	for <iommu@lists.linux.dev>; Mon,  8 Jun 2026 12:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780920540; cv=none; b=ZsAKqOTXCBxcT3l9TeeToQag2zLr/o/WkSRTJ/OfPpYE4t5y/zrsUjM1ke923PIpppiIlrw4d0Uk5Jc8w6EHM5N5RoqJUtAKM7vaICjEI+JJC7ftc59ZiPI4DK6mu/XiN4AKT18wh5LJSNw4iXyxYVyI5Tfhz6S/goVFfvFS55U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780920540; c=relaxed/simple;
	bh=XiYzvzrRYBA/JuO/QX1C2PuSDfSlMv273Z2HFb4Zwn8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=WdBrKg50QTt78pRi3i5DhRaCsPhNKve04rHLqzIEA/G5JY9eoY4xhNQ8XEt6BgmdaRrA4bIhQmmGfOtZElCko8K4+pvE0DF6By7tXXOdi4jhAHhOGJazq7IoqZUKgUR62L00JZF9NabHQLsFpzco13I/KtkjV8+ry/rVKAfD2b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kJ8GQ3tg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZafXk593; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kJ8GQ3tg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZafXk593"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658BCEb33480289
	for <iommu@lists.linux.dev>; Mon, 8 Jun 2026 12:08:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	P1bf8K6eKadkefRImKNtRwUweNjPVdl7MQY80nf/beo=; b=kJ8GQ3tgWSIXFx5V
	KaDA7I/oOXBKaOphO2BEwWl4O43NK6C5fXG5css4cuSRahXZQSJ7M6LWA277yIDd
	vbFE/fQlTgh0DwkBIeMjVSxKWJZwTKhNd2cGt3LYOQWetGsihMiFA674NBDuGdCn
	T2CmXqOpD8SBQVd3uM2A/tB1Q81u1AgfC7zhS19jaFSef5M3RcfoqzgvFgSXzL3u
	rxPnzF+YFcDvyPHfZmKGAab09QR2AlL/UuW3hjvycuKtOUubr7pKL9dgJXEnOty2
	3j572mDq302uwdlBIPUzM9FwVws0EnmW5cTyWuN+wu2R4kaF6A2RjTNYf8Nd5UCT
	fGYTMw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emaj502vg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 08 Jun 2026 12:08:58 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2c0c1e08848so59178045ad.0
        for <iommu@lists.linux.dev>; Mon, 08 Jun 2026 05:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780920537; x=1781525337; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P1bf8K6eKadkefRImKNtRwUweNjPVdl7MQY80nf/beo=;
        b=ZafXk593GA1KVk3ToGd1jDdMwd9kYsnC/NILQ8x/n8/JRFu/Zie6EmlzVhSismZ7RK
         W/Mbpy2CcrvGdqf3b2bKCT/vSIKv4Fp81lA9y/5fF5ETIa/6R1AiReTYvK2ljJS8QYj0
         wpXIHFdV+yw/ud26Sh5UViyjpVa4sR/1WlcqrjnuPYU3Anmgj1voXIU0SOW+giLNjimJ
         /3AkjE2bO3+HEf2HQUoz+BL4ngrpYVUbuBznkHpZHOP+85SdGRJiR8Cn9soDsClpJ64c
         nf6x1hLOyQn7YNueATtJEDQnEAzJwT0by3VNI3rbDV6mbMMIOIARXkI9BJ82pJCtwnkD
         4WPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780920537; x=1781525337;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P1bf8K6eKadkefRImKNtRwUweNjPVdl7MQY80nf/beo=;
        b=mwNPfYHJMpTLf0Xv5GERJXyb//lFi7ntr9LmrI+7HkP1VxfylPGJ/cyu3tbM1ROqre
         tQcPtRhoclqAbR8kTx2Ky64o7YZcu7kNuQ1tP2BW6cJxxOTrqq2MxUGGRdTQdFjAwIfF
         qYSvRH3he/5ZYrmATBFhNkao1laqcnmN69HW3OIHdKFVnzUUp6Zac295vvZvnly59jf6
         S8DbCtOYbtul8j4Ckglj3mzjj/SLbahNTQcRlTXTWpomKknixfWITWttjy0nMCzNnadi
         HZtXerlJqpN+oiJ6K8F5XIP6IO+B41Pig6hcl5Bc7G2A3XB5SXXtNuThJithf9/aVJmg
         ry9Q==
X-Forwarded-Encrypted: i=1; AFNElJ+vqqFMXEPEjmIPt8NJIvaSfQXdH8xTOqUJSs/Xar9b2aiV6swmMyy3WJjhxfwwjRwegx+Q0w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxvyUafH/C3nTi6bsTTuEkwRtqDLdaQkOE4SUQacCcPdnHXEQln
	3KI7t6bgkkseeTJAwp+5RMX3SWXA0SH8DacxG/CSLtKAyAm05EB9zAIrhhMBDUTiWfFGtkU72J/
	nKtVuj2hJYfEECuRnR99NfmdiiGQniJV+T2sAdI8z+875cTdhHB+8/nnXag==
X-Gm-Gg: Acq92OEy9ImiG6R6e2edGMFaq3BQHFHLKcId1PWzmeMUyz/igzuJXwcChuKGVUcPIUv
	6zmoGJYznBjXLTQdvWcVhAuqKfW4hPU7+YSaoE5mNM0pQ8rU58Bmgiykybgt3HRU5t97QYeyaeR
	uL+Np3aOC+JDu4eBY4pg5k+L1pd5VrY+aQi3EIV6I6QLb0MOjvdSB24P9LLmwuvT/IHizrua+Ai
	ZkL/F8TimOX1S+K3lIH3/NBUsxLj2rcT3ZTR2tXzlks4CmT3RKy9O+ZgFkr59kqTwN1vDdORrDc
	HGiJOwx3Y5TTrv97IchjINLnJEEXECQqFRO8lvYpLZbGi/hu4zhzOBlgRKdClHC/sR0eUCe612S
	hj7NM5W4VyJOXB67zr5BBs9S7xDzOjRKDH2ko6mQJMeiiHXA5q2cJDM2ra1idiWBP
X-Received: by 2002:a17:903:1ac5:b0:2c2:8659:da2c with SMTP id d9443c01a7336-2c28659dc9bmr20889185ad.14.1780920537144;
        Mon, 08 Jun 2026 05:08:57 -0700 (PDT)
X-Received: by 2002:a17:903:1ac5:b0:2c2:8659:da2c with SMTP id d9443c01a7336-2c28659dc9bmr20888535ad.14.1780920536563;
        Mon, 08 Jun 2026 05:08:56 -0700 (PDT)
Received: from [10.206.105.200] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c1664a67b0sm183538985ad.80.2026.06.08.05.08.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 05:08:56 -0700 (PDT)
Message-ID: <b10d6220-08d4-bcef-44c3-6bd2c1e096bb@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 17:38:48 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v7 07/12] media: iris: Add power sequence for glymur
Content-Language: en-US
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
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
 <b9a11d38-13f7-ee33-0537-2557050afdfa@oss.qualcomm.com>
In-Reply-To: <b9a11d38-13f7-ee33-0537-2557050afdfa@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: uU37jefjrPQoFIFePURCzYYYOWAoazpI
X-Proofpoint-GUID: uU37jefjrPQoFIFePURCzYYYOWAoazpI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDExNSBTYWx0ZWRfX0CLhRAAOSnaa
 1ioLrnpr+p5a4Dx95OWjpExfWWaU+PfgadHHXZdfx/kMUgVQ/8M8tXgO8zaJjbNFKfa3pxEqF4P
 A3sIPZWrIssmmKmesjaPVdsWY8rnuXXGSvt2p++rajWv0bmHmw4jtVTA1DXQ8h7ThdnD4GdrNsu
 yty2NiQJIiHq7xIpMqy7vUdoNc4M/7A05/aFbQNMrxfOT8Dgkwa9vz4QOWq/o+CYTI8nV48nC/k
 cLTBRsMNltMH+YBGJxi7DUafsKCORN3sqXT6N7aBeouKifVCyY09Olw8/uTPXzDuH4ay/l9uQJ2
 EO78MWw+UlepHqC5Uh6n+5Ybph/jDxOmyi9evWT1rzW8WL3cBZ+lGzE3cxk7qDU2ZJlhv1JXCZD
 dN2vGbtQbLIYt9ValR8FOrBVsy1g+AF1LGhDjAQx3hnAx8lkgdjDaI58+i6x20YyAMbTDAnb1IA
 wjkwtEGn3r/qOxAtSiQ==
X-Authority-Analysis: v=2.4 cv=TLh1jVla c=1 sm=1 tr=0 ts=6a26b0da cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=zzk4QuvOVKE_xORUXiEA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015
 phishscore=0 malwarescore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080115


On 6/8/2026 11:09 AM, Vishnu Reddy wrote:
> On 6/8/2026 3:17 AM, Dmitry Baryshkov wrote:
>> On Wed, Jun 03, 2026 at 07:48:45PM +0530, Vishnu Reddy wrote:
>>> Glymur platform has two video codec cores: vcodec0 and vcodec1.
>>>
>>> Both cores share a common clock source (video_cc_mvs0_clk_src) and the
>>> same power rails. The clock dividers between the source and the branch
>>> clocks are fixed. So when both cores are running, the source clock always
>>> runs at the highest frequency requested by either core.
>>>
>>> Since both cores share the same power rails, the power corner cannot be
>>> voted independently. Scaling one core's power corner up or down would
>>> directly affect the other, leading to under or over-voting.
>>>
>>> For these reasons, both cores should voted the clock and power rail must
>>> be based on the workload of both cores.
>>>
>>> Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>>> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>>> ---
>>>  drivers/media/platform/qcom/iris/iris_vpu3x.c      | 111 ++++++++++++++++++++-
>>>  drivers/media/platform/qcom/iris/iris_vpu_common.h |   1 +
>>>  .../platform/qcom/iris/iris_vpu_register_defines.h |  10 ++
>>>  3 files changed, 117 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/media/platform/qcom/iris/iris_vpu3x.c b/drivers/media/platform/qcom/iris/iris_vpu3x.c
>>> index 7cda94601555..f07eaf4b3be2 100644
>>> --- a/drivers/media/platform/qcom/iris/iris_vpu3x.c
>>> +++ b/drivers/media/platform/qcom/iris/iris_vpu3x.c
>>> @@ -17,14 +17,14 @@
>>>  #define NOC_HALT				BIT(0)
>>>  #define AON_WRAPPER_SPARE			(AON_BASE_OFFS + 0x28)
>>>  
>>> -static bool iris_vpu3x_hw_power_collapsed(struct iris_core *core)
>>> +static bool iris_vpu3x_hw_power_collapsed(struct iris_core *core, u32 pwr_status_bit)
>>>  {
>>>  	u32 value, pwr_status;
>>>  
>>>  	value = readl(core->reg_base + WRAPPER_CORE_POWER_STATUS);
>>> -	pwr_status = value & BIT(1);
>>> +	pwr_status = value & pwr_status_bit;
>>>  
>>> -	return pwr_status ? false : true;
>>> +	return !pwr_status;
>>>  }
>>>  
>>>  static void iris_vpu3_power_off_hardware(struct iris_core *core)
>>> @@ -32,7 +32,7 @@ static void iris_vpu3_power_off_hardware(struct iris_core *core)
>>>  	u32 reg_val = 0, value, i;
>>>  	int ret;
>>>  
>>> -	if (iris_vpu3x_hw_power_collapsed(core))
>>> +	if (iris_vpu3x_hw_power_collapsed(core, VCODEC0_POWER_STATUS))
>>>  		goto disable_power;
>>>  
>>>  	dev_err(core->dev, "video hw is power on\n");
>>> @@ -78,7 +78,7 @@ static void iris_vpu33_power_off_hardware(struct iris_core *core)
>>>  	u32 count = 0;
>>>  	int ret;
>>>  
>>> -	if (iris_vpu3x_hw_power_collapsed(core))
>>> +	if (iris_vpu3x_hw_power_collapsed(core, VCODEC0_POWER_STATUS))
>>>  		goto disable_power;
>>>  
>>>  	dev_err(core->dev, "video hw is power on\n");
>>> @@ -221,6 +221,98 @@ static void iris_vpu35_power_off_hw(struct iris_core *core)
>>>  	iris_vpu33_power_off_hardware(core);
>>>  }
>>>  
>>> +static void iris_vpu36_power_off_vcodec(struct iris_core *core, u32 core_id)
>>> +{
>>> +	u32 value, i;
>>> +	int ret;
>>> +
>>> +	if (iris_vpu3x_hw_power_collapsed(core,
>>> +					  core_id ? VCODEC1_POWER_STATUS : VCODEC0_POWER_STATUS))
>>> +		goto disable_power;
>>> +
>>> +	value = readl(core->reg_base + WRAPPER_CORE_CLOCK_CONFIG);
>>> +	if (value)
>>> +		writel(CORE_CLK_RUN, core->reg_base + WRAPPER_CORE_CLOCK_CONFIG);
>>> +
>>> +	for (i = 0; i < core->iris_platform_data->num_vpp_pipe; i++) {
>>> +		ret = readl_poll_timeout(core->reg_base + (core_id ? VCODEC1_SS_IDLE_STATUSN :
>>> +					 VCODEC_SS_IDLE_STATUSN) + 4 * i, value,
>>> +					 value & DMA_NOC_IDLE, 2000, 20000);
>> Unreadable. Extract register addresses to separate variables.
> Ack
>
>>> +		if (ret)
>>> +			goto disable_power;
>>> +	}
>>> +
>>> +	writel(core_id ? REQ_VCODEC1_POWER_DOWN_PREP : REQ_POWER_DOWN_PREP,
>>> +	       core->reg_base + AON_WRAPPER_MVP_NOC_LPI_CONTROL);
>>> +	ret = readl_poll_timeout(core->reg_base + AON_WRAPPER_MVP_NOC_LPI_STATUS, value,
>>> +				 value & (core_id ? NOC_LPI_VCODEC1_STATUS_DONE :
>>> +				 NOC_LPI_STATUS_DONE), 2000, 20000);
>>> +	if (ret)
>>> +		goto disable_power;
>>> +
>>> +	writel(0, core->reg_base + AON_WRAPPER_MVP_NOC_LPI_CONTROL);
>>> +
>>> +	writel((core_id ? VCODEC1_BRIDGE_SW_RESET | VCODEC1_BRIDGE_HW_RESET_DISABLE :
>>> +	       CORE_BRIDGE_SW_RESET | CORE_BRIDGE_HW_RESET_DISABLE),
>>> +	       core->reg_base + CPU_CS_AHB_BRIDGE_SYNC_RESET);
>>> +	writel(core_id ? VCODEC1_BRIDGE_HW_RESET_DISABLE : CORE_BRIDGE_HW_RESET_DISABLE,
>>> +	       core->reg_base + CPU_CS_AHB_BRIDGE_SYNC_RESET);
>>> +	writel(0x0, core->reg_base + CPU_CS_AHB_BRIDGE_SYNC_RESET);
>>> +
>>> +disable_power:
>>> +	dev_pm_genpd_set_hwmode(core->vcodec[core_id].dev, false);
>>> +	iris_disable_power_domain_and_clocks(core, &core->vcodec[core_id]);
>>> +}
>>> +
>>> +static void iris_vpu36_power_off_hw(struct iris_core *core)
>>> +{
>>> +	u32 num_cores = max(core->iris_platform_data->num_cores, 1);
>> Can we trust the patch authors that VPU3.6 hardware data will have at
>> least 1 core?
> On Glymur (VPU3.6), num_cores is 2. The max() guard is unnecessary.
> Will access num_cores directly.
>
>>> +	int i;
>>> +
>>> +	for (i = 0; i < num_cores; i++)
>>> +		iris_vpu36_power_off_vcodec(core, i);
>>> +}
>>> +
>>>  #define WRAPPER_DEBUG_BRIDGE_LPI_STATUS		(WRAPPER_BASE_OFFS + 0x58)
>>>  #define WRAPPER_IRIS_CPU_NOC_LPI_CONTROL	(WRAPPER_BASE_OFFS + 0x5C)
>> Lowercase hex.
> Ack

Just now I found that this change is not part of this series.
Can I take this into separate post?

>>>  #define REQ_POWER_DOWN_PREP			BIT(0)
>>> +#define REQ_VCODEC1_POWER_DOWN_PREP		BIT(1)
>>>  
