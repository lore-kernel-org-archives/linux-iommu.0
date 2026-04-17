Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4AD31F981
	for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 15:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776439733; cv=none; b=ldxrsT10LKfDXGaBJa4FANRC5A3dzdEksYr4x1io2JhVN4WUGmRQOO5Qjv0wyTuSZRaSXKrxVDLP6uC7ephJBGCis6/mFHqjnTW5PYcJbQTbrrKizljWtEReD6/aIQx8D1DxpUsRoNnLJjvF/8g8nHxr3NQsj1Mlw0RB4TV/F+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776439733; c=relaxed/simple;
	bh=i77yRE8WUhFEs7+CBpzlx+r5MC6ikp723zTT7FvNvsY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=k9R/dt0ie4xXr//C48dax7RI3TNVooUQESQD0V3L5tP4QPo5lYbdDr90wbqv2fJY1SLh/4sd7kiuNtx9Hi9R5EwpgLI2/rn4+hQIMhHs7XwEmA+hQtuWUb2KmV3B3GzNOhgphVm3Eu+xhQlITTNmOs7Dv/3E55nXtKZHN5jCFSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Oi6Te+Y4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DYL7DW7k; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Oi6Te+Y4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DYL7DW7k"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63HCEraW3942129
	for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 15:28:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YaQtfdZufww/K73QQEA/A0d3XIh2ynwFA8tiiBqAF4Y=; b=Oi6Te+Y4gE+h0ub7
	y6aiT0wkH1YE3pSd7X7Ii27zAY28xopCKQ2iKgZRr2E6SRo8QkUVJ/+Ni5SRfIDX
	yU031UGE+uu+vU0DOnu/Q/N19ULH3dh7Opl0eGDK3cPr5Sn3vIIF8mla8L/BXsw/
	CPfJScm8mdfCWW4woWqKudKGRSeH66BjgSb2hEtGZvcEtMECVaTATqhnKtEgP1U9
	Qk/SjyAFQKKRNoXCb7zvwC8cT+aaQOV6Ly4SbRFObHEhfjIrw57aR+zqaF90BkAH
	AGqwmKriE3TxwqSy1Dh07XRxg1br9hsrYGqP0MTssygjLus7onGHP5mjHSOxPhxX
	0AEFaA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dkg7rsvc3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 15:28:51 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35e56ed5d5bso2174095a91.0
        for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 08:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776439731; x=1777044531; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YaQtfdZufww/K73QQEA/A0d3XIh2ynwFA8tiiBqAF4Y=;
        b=DYL7DW7koGJjcAgMImITBr47gax1KbbjipvGLdilEZk6z604c5ZYfW4z90qfWWwI4L
         9goB1fS9rdjz10OEIF20N6wYMRv4xcvWJySzceCV7w3A0+DOsFio32VDiFxQ0OMhchlg
         eJrnYGvGKRDbm9hJr7Oru2g8KFA8DZIDpIDKmFZjd1VA/AF7aBd1yf5zMw4YgYA/4BO+
         +wE53i9c6RjuyKzsPNeIU3I4SyV8zpKyZ8+o8HRcnWDgMeWLvuEyacUTC4Rcq67l/iiP
         v9lqrClisNfJOCPqseah79hszXd2Vh2fkhJEUVVJPgIDciEcjSQ6sTzS0vL6LPyTKVWE
         TmzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776439731; x=1777044531;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YaQtfdZufww/K73QQEA/A0d3XIh2ynwFA8tiiBqAF4Y=;
        b=nXJXmr0WtLFacd9YLdTLwiR8yJIW4ddYgvXrPPdRD10Icc6hh0v7wYmVUDHF7p2BPV
         3lJfsKe64YJAbKMGEOui0g/AtcGM+J7SmpeNxttmzByo7NSjxhSFq7viFKak0ZUHHMYv
         HjGMe8SFbxR9tnAFV9/zk2tQp7SR27JB6tIJjIbQB9IraY39q+tJnQxw7btxZGVFqioX
         zhTi1zvDD6BpJkpvaT7d5U+ZL5h4aRVaeI58KULyrCermhuiX9LHyqyYQnQeAM8cX35u
         OSjYPS6oA1YXPi98C56pHvKqLKoSyXmyoTjN/4qFFXD0WP/m66Dv1t6UUajWJJHMNbJH
         YpWg==
X-Forwarded-Encrypted: i=1; AFNElJ8gUgBh1zNYPValkR6fDwlQRhLfMLKwSCENGmi2vZiO/gXNYZ7k4Q3mEUEAccIAP5yPy19W/Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyLaG/7vpGJE0xzJn4T59EE2d1W+h+jCKK7D3HVBR0MA4oK4Phi
	zeOpEVatvDw9yWdVA32UpFhRhUO2vNT3lghu43wkZ5o1hpZ7yfr/MZ+GOoj+d+feCUqdjQ1R/Ll
	c6C+4xsFT6wzoT4QNyBBLuxCRLIDYXte03Uq+B/tmsDqKqssWl7ri8yHPNA==
X-Gm-Gg: AeBDieua6hr99mVnMbOrVJY232OwMIIYU6v6p+Mby5/y/uuMjymftOE3Q0ozokEv15J
	pxoESOvcefAZEBHWyZ5mnRsvSwwsNmKylhEBxC+LzZtEwzlMqoUMF4g6CgXhr3NCYxbpsH6JXCb
	WYNHwbWQYyNpHA6f5v13I1W8ZM8UCpW5Zw13o02W/v5W+UBOyTASbM14ozamw1G7vD+1uYbKAIU
	YcIE6NkMy9FvonRpJg22oMMGCrOqZBGVXwwdntWfeEAo680dyF2Ma/8V9Fz9/UMbnknEWWfsAMN
	tRjYM2rV2THnG5KClVfjm7PNwz/QkYgP3CAKdN5iVeQGgM6BxvPaZ4Ew1905KRGB19WDQpZ5NfE
	eifEa0MmY+mGyvYmnrcIRzPLzaJy9esSLDQ1Do2hawUq5NpelSW4Je/a47te3+MdQ
X-Received: by 2002:a17:90b:3d02:b0:35b:d795:cf5d with SMTP id 98e67ed59e1d1-361401ec4b4mr2683450a91.5.1776439730730;
        Fri, 17 Apr 2026 08:28:50 -0700 (PDT)
X-Received: by 2002:a17:90b:3d02:b0:35b:d795:cf5d with SMTP id 98e67ed59e1d1-361401ec4b4mr2683418a91.5.1776439730131;
        Fri, 17 Apr 2026 08:28:50 -0700 (PDT)
Received: from [10.206.105.200] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3614195a9fbsm3284378a91.11.2026.04.17.08.28.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2026 08:28:49 -0700 (PDT)
Message-ID: <7cd1a0ff-53be-7eb7-7de7-420dd1ae7cf4@oss.qualcomm.com>
Date: Fri, 17 Apr 2026 20:58:40 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Subject: Re: [PATCH 06/11] media: iris: Fix VM count passed to firmware
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Cc: Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        stable@vger.kernel.org
References: <20260414-glymur-v1-0-7d3d1cf57b16@oss.qualcomm.com>
 <20260414-glymur-v1-6-7d3d1cf57b16@oss.qualcomm.com>
 <20260414063325.f3yag6gnmaysddkp@hu-mojha-hyd.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260414063325.f3yag6gnmaysddkp@hu-mojha-hyd.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 4bPMM84EQSaX94yGvzcD_ggbeZ8wr1R-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDE1NSBTYWx0ZWRfX37Be95SbOIvK
 pKDYANhbXHslrvH0G4Kbpvw33D3FmcK5EjuVVYgQpUBhjCNnS8qXTebFQV/QyyNmOHRknVg0LHO
 Hk0u+v9Dptmwq8PPUt+hRtkA0UMb10HWkKeX63By1mV43Jal0GQrAWIkf/O/EdFJLc6hM5e0QvQ
 +2Vs5BRm/smcd4VwuF0dgwCWNBfEFCAFEbhXQD5efsivdG7VOy108ACENrYI4Lx9syQLZls/uiF
 V1AL48jlm3UW/aWGrp+YkgHXh6k6nr5ZP/1YEwCklE9R4xRzFYizuowNL6PT2R/BwZGqGOPH6xY
 8C+L4cVaLLMYusFNVNAODioGo3Tl/Sm19SDdkDwbf885yF6ZEe7lo4skzwt0Oc6Sqvz0QnDlXMz
 oEIv/FW67DSMSrbb7mbvhb1wpcDs3QazgNSyicxU9x3qsNyijbro3su5WszHt5W7psYS4dfC07K
 +xKHJhSQUhYQ67+Yv5g==
X-Authority-Analysis: v=2.4 cv=b4mCJNGx c=1 sm=1 tr=0 ts=69e251b3 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=5Xy_6AgtP5T3jK3p2aAA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: 4bPMM84EQSaX94yGvzcD_ggbeZ8wr1R-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 phishscore=0 clxscore=1015 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604170155


On 4/14/2026 12:03 PM, Mukesh Ojha wrote:
> On Tue, Apr 14, 2026 at 10:30:02AM +0530, Vishnu Reddy wrote:
>> On Glymur, firmware interprets the value written to CPU_CS_SCIACMDARG3 as
>> the number of virtual machines (VMs) and internally adds 1 to it. Writing
>> 1 causes firmware to treat it as 2 VMs. Since only one VM is required,
>> remove this write to leave the register at its reset value of 0. This does
>> not affect other platforms as only Glymur firmware uses this register,
>> earlier platform firmwares ignore it.
>>
>> Fixes: abf5bac63f68a ("media: iris: implement the boot sequence of the firmware")
>> Cc:stable@vger.kernel.org
>> Signed-off-by: Vishnu Reddy<busanna.reddy@oss.qualcomm.com>
> If this is a fix, should be the first patch in the series., so that it
> can be applied independently.

Ack, I'll move it accordingly.

>> ---
>>   drivers/media/platform/qcom/iris/iris_vpu_common.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.c b/drivers/media/platform/qcom/iris/iris_vpu_common.c
>> index 548e5f1727fd..bfd1e762c38e 100644
>> --- a/drivers/media/platform/qcom/iris/iris_vpu_common.c
>> +++ b/drivers/media/platform/qcom/iris/iris_vpu_common.c
>> @@ -78,7 +78,6 @@ int iris_vpu_boot_firmware(struct iris_core *core)
>>   	iris_vpu_setup_ucregion_memory_map(core);
>>   
>>   	writel(ctrl_init, core->reg_base + CTRL_INIT);
>> -	writel(0x1, core->reg_base + CPU_CS_SCIACMDARG3);
>>   
>>   	while (!ctrl_status && count < max_tries) {
>>   		ctrl_status = readl(core->reg_base + CTRL_STATUS);
>>
>> -- 
>> 2.34.1
>>
