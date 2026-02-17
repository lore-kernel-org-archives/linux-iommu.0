Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158E2361DD1
	for <iommu@lists.linux.dev>; Tue, 17 Feb 2026 14:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771337503; cv=none; b=p+/sZ/Xncj0pc8C501yrsMScjdPU8FiEM7YCIYT7Kq/CuuKXK0YzTkfnP55UYkO0W91v4zvqqOtb0akyBwEo+23hZhz80Xs7zw5eldYPIVWT/0LumF7xAG26aZBipLyeskK00C2ZrTmLv1q2ttH3TqUWSo3e3rG7Y4650140lJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771337503; c=relaxed/simple;
	bh=jbgmdcTQxX7pyYFMINAL/5nT7jyyBScF9+NauEz/E6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=izbuBjL9fQ6ftRIggTTCiHWzLxNp4aZQfZ+QndnTxFmxVbSjNyyksst5LNhVMamO5iqFWu5tfgeWiMEpha/ShgVGPaieebko6JVbVHg0E+c7dHbwZcGZfJ1ZpJuB51S2R2pTgaaCWV/fp8QncoVwCMirE7kI0K+Z7MozdBijvPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hT+3rthc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=j7CeLRmO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hT+3rthc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j7CeLRmO"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HAoIoK1613301
	for <iommu@lists.linux.dev>; Tue, 17 Feb 2026 14:11:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	z1exp7vWAOAc8GFVwCy/aOu418CWdLbMRQ0dGRhuTVw=; b=hT+3rthckeAUkSf7
	Ik3aPKqd2Ytki8m6GCCFOkTg+oDsN4fmmSJ0Dy4aOj/g9wevAwrNglBHZWY27h53
	id4lXQenRM1ayaKrD04TONS4AmGImKcEP2Wo/DALoXp6aJT/c9fi9tmXhR04EGKg
	SO9yM5VuprjfgZ6+/YUMsMbt+BPRBN0ucrSQjdc0yQbIHUdnGmc8Zl9gSxZ0oQbT
	muJ80Qr3gvujp/DzyX4tPw7zwl9Hflq73kipJZjqXTudiyOD6N+6w4VdZ2zWIA2n
	0MVKxNC+wcEHrSWVzRH4q3+aYsMrvwtj3iX7cuFPu4PEs+uWEKsAIWHG+fGTU4wq
	6ZB64g==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cc662tnv9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 17 Feb 2026 14:11:40 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c5269fcecdeso2600054a12.0
        for <iommu@lists.linux.dev>; Tue, 17 Feb 2026 06:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771337500; x=1771942300; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z1exp7vWAOAc8GFVwCy/aOu418CWdLbMRQ0dGRhuTVw=;
        b=j7CeLRmOkUZu6xrxJ7PLHrxjE5WBaSuejxdYWmo+i5d1eAu9/d9fNa+BUCDhqUuvRe
         b57t4/TPcUsxbP18tJlQufx6CGGIXKxN32JJIgRDw2paGFF8CxZoRFniusCNlpq2ueAG
         kTojufVocjvXsezZH4tHia3E0qnByxkhiHEcIMxpknIM1oHStxf1hYJmdI5K3m0P++bf
         afinkVKR0ujFHIqJs2N2vXKCynflUOhgY6xuMs/ebZXPYvUIXKVsorEta038RPJeceD9
         SAZE/7eW6rZ2XlO8veAiuPPrwig36SURYTgSNkgA3Vu5Dk0fgYxE1huiP8hroE/oHDIv
         7qbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771337500; x=1771942300;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z1exp7vWAOAc8GFVwCy/aOu418CWdLbMRQ0dGRhuTVw=;
        b=SHFsHZ14uNegS9lhPR+BoIgMY8R5MZYAC9zHu/CcTgBlrX9YDMmzyR3UnpvG2+CNBG
         H3tLFICZFZeKT1hO6WaoHu3bFyKQyeYZRhCt1uCN/WBkjQAQwzR2i16lXS4M7YI9E4qL
         WyWEHI3v/pfI3XNDD6XhaAiW0xZ4+iDwg3avzR2I5Mxfgd5Jeu6q8TTvcfeOaZVcCb/d
         /09mqw4ekYnDyQ+rl3l5fef6Ykq0jz8SSu31Grf0b5HT6JYHDu6gUs0ifqGSDOi1e+vt
         s5jyu8x93LXc2LECrzoizLIDfO0EcuyDevteDKJ9berHBl8yesEBTIe2ZGxMSxNuEZiW
         +tGQ==
X-Forwarded-Encrypted: i=1; AJvYcCX757ml65j9i71gcLWg1CuRXyPcJz6yJycg9Wdtcz5yDKaVKhEKdq+Ad60R156YDuiIFU3Xfg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxzKrh5kJTMTQJRmIdAaiCBVe00ZtOwUdi11TNxGCZbA/i3oM69
	YIzm+TmPczzxj+ESLSmscluT7V11VOiHTtL7E/2cZpVga65wQSxy2FG/ixWPOYZYEfXYpxn9EoP
	6rt7mpGSmD3oQxQmGkPiYe44izf9lxrC2wlTwlyLJlM8U/PDKDFOpQbwYWw==
X-Gm-Gg: AZuq6aIF688gJcTd0CxnI/h0i6cKEc8LyyS4dqj/kPKjnGfDawgGCZ1J2/qRXRe3MNY
	PzhdJ0/6hIXhZuLuGNpkb+jxjP4adjyab2USWo9XdJrBUuuLv1jopgkuJ/9WWMGOIgNnm5H/8QP
	rWjDHXJndRn7jblc5hUHfaX0jY//BS714wPGAiNfE9KcfMCuxg5wk2I1EzmUGhaIq4mitlTl93V
	51MQC7gQY3cu02DeQKxBQ++4EJyAQ9SFz7BWRTFLmJT/e7dE2oOin5xPKaR8IIEW1+sylhNwHui
	oi8CK7wVxT6+3NVhMiEkRb3WpWZQNmHDp+P8rIBAsngIv7IQ8u+eGjJfpoAFHOOg5elwF8ABrMx
	I6VIj02AvJsVRU/2U8xlsaVx/tfwLNRY7y51coDN9F4rR2j/pKJCTNw==
X-Received: by 2002:a05:6a00:928d:b0:821:8230:235d with SMTP id d2e1a72fcca58-824d95f6a41mr10187818b3a.39.1771337499940;
        Tue, 17 Feb 2026 06:11:39 -0800 (PST)
X-Received: by 2002:a05:6a00:928d:b0:821:8230:235d with SMTP id d2e1a72fcca58-824d95f6a41mr10187791b3a.39.1771337499420;
        Tue, 17 Feb 2026 06:11:39 -0800 (PST)
Received: from [10.204.100.45] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6b90b9fsm15414434b3a.46.2026.02.17.06.11.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 06:11:38 -0800 (PST)
Message-ID: <7161bb8b-f8e4-4efe-a136-40983678a84e@oss.qualcomm.com>
Date: Tue, 17 Feb 2026 19:41:31 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] media: iris: Switch to hardware mode after firmware
 boot
To: Bryan O'Donoghue <bod@kernel.org>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
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
        Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, Bryan O'Donoghue <bryan.odonoghue@linaro.org>
References: <20260126-kaanapali-iris-v1-0-e2646246bfc1@oss.qualcomm.com>
 <fLxe2FUgx2tsLsXWrEdDq_iHxUUnVhy0BT_zzO3t3rmpLau36zhbLaZFyH5tQZJRO-uLVcHm4RsG_x1PEVOnKw==@protonmail.internalid>
 <20260126-kaanapali-iris-v1-4-e2646246bfc1@oss.qualcomm.com>
 <dd36c365-cffb-4fac-bf11-40e4896cbab5@kernel.org>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <dd36c365-cffb-4fac-bf11-40e4896cbab5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDExNCBTYWx0ZWRfX9z4+uZkCCgcZ
 aCuzY4Ok3F7cBW2uBFGMH89DMu96h1KS9fJ/ycZKSQazJkGa2mysmXxK6B7DCp+XWEjPfSCYuiK
 c9M0Cr4kfKwO76bG47D/qhdqE5B/1h69HA/Pxp9smPLhjqxG9Gn2zggyzPpYHD1wLaiHfhu7i5y
 zt3aMEikp6obCTqxeSXUHbm/ncTY84+93c4N2mJ9eO1sfphLJrNtrgQ3BemqiHIXoguqKe7/gkB
 KCkQXoaEbcCrjhefqJ9CJ9f+UX+zM2nl+x6d3CuLuEGRJdgwktC0UREJubNln3NT24j8kcsHsbU
 G+NLpuKJg7A1tdHzdhEnVsmrQGQQTwks1PnjcJvGPTjJRbxn5izzJqaAG0j4U22WLOHUT7JvESY
 e8gCB2mToZB5Rj0x/ugXqJ1fRlxUrGR4/0CKHoOcoU8Pd5Jed4bScWr9ASSc95TSxg+2mQwLjrX
 ukZXkyf9Vv2J2L61QLg==
X-Authority-Analysis: v=2.4 cv=Y6b1cxeN c=1 sm=1 tr=0 ts=6994771d cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=PsZjGXtKO3tw9YjmHZYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: J4VDCz6Kh7bOvQSb3o5lQeLch7mjuFeS
X-Proofpoint-ORIG-GUID: J4VDCz6Kh7bOvQSb3o5lQeLch7mjuFeS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_01,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170114



On 2/2/2026 8:39 PM, Bryan O'Donoghue wrote:
> On 26/01/2026 12:25, Vikash Garodia wrote:
>> Currently the driver switches the vcodec GDSC to hardware (HW) mode
>> before firmware load and boot sequence. GDSC can be powered off,
>> keeping in hw mode, thereby the vcodec registers programmed in TrustZone
>> (TZ) carry default (reset) values.
>> Move the transition to HW mode after firmware load and boot sequence.
>>
>> The bug was exposed with driver configuring different stream ids to
>> different devices via iommu-map. With registers carrying reset values,
>> VPU would not generate desired stream-id, thereby leading to SMMU fault.
>>
>> Fixes: dde659d37036 ("media: iris: Introduce vpu ops for vpu4 with 
>> necessary hooks")
>> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>> ---
>>   drivers/media/platform/qcom/iris/iris_core.c       |  4 ++++
>>   drivers/media/platform/qcom/iris/iris_hfi_common.c |  4 ++++
>>   drivers/media/platform/qcom/iris/iris_vpu2.c       |  1 +
>>   drivers/media/platform/qcom/iris/iris_vpu3x.c      |  9 +++-----
>>   drivers/media/platform/qcom/iris/iris_vpu4x.c      | 24 +++++++++++ 
>> +----------
>>   drivers/media/platform/qcom/iris/iris_vpu_common.c | 16 +++++++++------
>>   drivers/media/platform/qcom/iris/iris_vpu_common.h |  3 +++
>>   7 files changed, 38 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/media/platform/qcom/iris/iris_core.c b/drivers/ 
>> media/platform/qcom/iris/iris_core.c
>> index 
>> 8406c48d635b6eba0879396ce9f9ae2292743f09..dbaac01eb15a0e622e85635fddd29c1f7fc18662 100644
>> --- a/drivers/media/platform/qcom/iris/iris_core.c
>> +++ b/drivers/media/platform/qcom/iris/iris_core.c
>> @@ -75,6 +75,10 @@ int iris_core_init(struct iris_core *core)
>>       if (ret)
>>           goto error_unload_fw;
>>
>> +    ret = iris_vpu_switch_to_hwmode(core);
>> +    if (ret)
>> +        goto error_unload_fw;
>> +
>>       ret = iris_hfi_core_init(core);
>>       if (ret)
>>           goto error_unload_fw;
>> diff --git a/drivers/media/platform/qcom/iris/iris_hfi_common.c b/ 
>> drivers/media/platform/qcom/iris/iris_hfi_common.c
>> index 
>> 92112eb16c11048e28230a2926dfb46e3163aada..621c66593d88d47ef3438c98a07cb29421c4e375 100644
>> --- a/drivers/media/platform/qcom/iris/iris_hfi_common.c
>> +++ b/drivers/media/platform/qcom/iris/iris_hfi_common.c
>> @@ -159,6 +159,10 @@ int iris_hfi_pm_resume(struct iris_core *core)
>>       if (ret)
>>           goto err_suspend_hw;
>>
>> +    ret = iris_vpu_switch_to_hwmode(core);
>> +    if (ret)
>> +        goto err_suspend_hw;
>> +
>>       ret = ops->sys_interframe_powercollapse(core);
>>       if (ret)
>>           goto err_suspend_hw;
>> diff --git a/drivers/media/platform/qcom/iris/iris_vpu2.c b/drivers/ 
>> media/platform/qcom/iris/iris_vpu2.c
>> index 
>> 9c103a2e4e4eafee101a8a9b168fdc8ca76e277d..01ef40f3895743b3784464e2d5ba2de1aeca5a4a 100644
>> --- a/drivers/media/platform/qcom/iris/iris_vpu2.c
>> +++ b/drivers/media/platform/qcom/iris/iris_vpu2.c
>> @@ -44,4 +44,5 @@ const struct vpu_ops iris_vpu2_ops = {
>>       .power_off_controller = iris_vpu_power_off_controller,
>>       .power_on_controller = iris_vpu_power_on_controller,
>>       .calc_freq = iris_vpu2_calc_freq,
>> +    .set_hwmode = iris_vpu_set_hwmode,
>>   };
>> diff --git a/drivers/media/platform/qcom/iris/iris_vpu3x.c b/drivers/ 
>> media/platform/qcom/iris/iris_vpu3x.c
>> index 
>> fe4423b951b1e9e31d06dffc69d18071cc985731..3dad47be78b58f6cd5ed6f333b3376571a04dbf0 100644
>> --- a/drivers/media/platform/qcom/iris/iris_vpu3x.c
>> +++ b/drivers/media/platform/qcom/iris/iris_vpu3x.c
>> @@ -234,14 +234,8 @@ static int iris_vpu35_power_on_hw(struct 
>> iris_core *core)
>>       if (ret)
>>           goto err_disable_hw_free_clk;
>>
>> -    ret = dev_pm_genpd_set_hwmode(core->pmdomain_tbl- 
>> >pd_devs[IRIS_HW_POWER_DOMAIN], true);
>> -    if (ret)
>> -        goto err_disable_hw_clk;
>> -
>>       return 0;
>>
>> -err_disable_hw_clk:
>> -    iris_disable_unprepare_clock(core, IRIS_HW_CLK);
>>   err_disable_hw_free_clk:
>>       iris_disable_unprepare_clock(core, IRIS_HW_FREERUN_CLK);
>>   err_disable_axi_clk:
>> @@ -266,6 +260,7 @@ const struct vpu_ops iris_vpu3_ops = {
>>       .power_off_controller = iris_vpu_power_off_controller,
>>       .power_on_controller = iris_vpu_power_on_controller,
>>       .calc_freq = iris_vpu3x_vpu4x_calculate_frequency,
>> +    .set_hwmode = iris_vpu_set_hwmode,
>>   };
>>
>>   const struct vpu_ops iris_vpu33_ops = {
>> @@ -274,6 +269,7 @@ const struct vpu_ops iris_vpu33_ops = {
>>       .power_off_controller = iris_vpu33_power_off_controller,
>>       .power_on_controller = iris_vpu_power_on_controller,
>>       .calc_freq = iris_vpu3x_vpu4x_calculate_frequency,
>> +    .set_hwmode = iris_vpu_set_hwmode,
>>   };
>>
>>   const struct vpu_ops iris_vpu35_ops = {
>> @@ -283,4 +279,5 @@ const struct vpu_ops iris_vpu35_ops = {
>>       .power_on_controller = iris_vpu35_vpu4x_power_on_controller,
>>       .program_bootup_registers = 
>> iris_vpu35_vpu4x_program_bootup_registers,
>>       .calc_freq = iris_vpu3x_vpu4x_calculate_frequency,
>> +    .set_hwmode = iris_vpu_set_hwmode,
>>   };
>> diff --git a/drivers/media/platform/qcom/iris/iris_vpu4x.c b/drivers/ 
>> media/platform/qcom/iris/iris_vpu4x.c
>> index 
>> a8db02ce5c5ec583c4027166b34ce51d3d683b4e..02e100a4045fced33d7a3545b632cc5f0955233f 100644
>> --- a/drivers/media/platform/qcom/iris/iris_vpu4x.c
>> +++ b/drivers/media/platform/qcom/iris/iris_vpu4x.c
>> @@ -252,21 +252,10 @@ static int iris_vpu4x_power_on_hardware(struct 
>> iris_core *core)
>>           ret = iris_vpu4x_power_on_apv(core);
>>           if (ret)
>>               goto disable_hw_clocks;
>> -
>> -        iris_vpu4x_ahb_sync_reset_apv(core);
>>       }
>>
>> -    iris_vpu4x_ahb_sync_reset_hardware(core);
>> -
>> -    ret = iris_vpu4x_genpd_set_hwmode(core, true, efuse_value);
>> -    if (ret)
>> -        goto disable_apv_power_domain;
>> -
>>       return 0;
>>
>> -disable_apv_power_domain:
>> -    if (!(efuse_value & DISABLE_VIDEO_APV_BIT))
>> -        iris_vpu4x_power_off_apv(core);
>>   disable_hw_clocks:
>>       iris_vpu4x_disable_hardware_clocks(core, efuse_value);
>>   disable_vpp1_power_domain:
>> @@ -359,6 +348,18 @@ static void iris_vpu4x_power_off_hardware(struct 
>> iris_core *core)
>>       iris_disable_power_domains(core, core->pmdomain_tbl- 
>> >pd_devs[IRIS_HW_POWER_DOMAIN]);
>>   }
>>
>> +static int iris_vpu4x_set_hwmode(struct iris_core *core)
>> +{
>> +    u32 efuse_value = readl(core->reg_base + WRAPPER_EFUSE_MONITOR);
>> +
>> +    if (!(efuse_value & DISABLE_VIDEO_APV_BIT))
>> +        iris_vpu4x_ahb_sync_reset_apv(core);
>> +
>> +    iris_vpu4x_ahb_sync_reset_hardware(core);
>> +
>> +    return iris_vpu4x_genpd_set_hwmode(core, true, efuse_value);
> I'd like to see something in the commit log about the efuse value. What 
> is it, why does it appear etc.
> 
> Because just to be difficult you are not doing a 1:1 switch to hw_mode 
> here, you're also introducing contingent logic.
> 

The reset was added _only_ on vpu4 switching to hw mode as there is an 
issue of register corruption if ahb reset is not performed before mode 
switch. Hence reset is made explicitly part of hw mode switch.
Its there in earlier code "iris_vpu4x_power_on_hardware" as well, while 
this patch is shifting the code to a vpu specific hw mode api.

fuse check is only to differentiate between apv and others, since apv 
reset sequence is different than others.

I can add these info in commit.

Regards,
Vikash
