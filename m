Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA8139D6E6
	for <iommu@lists.linux.dev>; Sat,  9 May 2026 17:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778346452; cv=none; b=iTw/dA4W3L3mN/AZJHAgEDLzoAaRP8l1L551K7s/7S36/uPwJlOZM5PHBY6imQi9LmGwwmZzQ2+hmAuaLzIP917jmjExvGi6Fqom9oHZK7iVXSdJ3cGUtcfRYgTiIIiGlnbqiGgKnPUvDlnPRSkyKY8OBdJ9YLPlx0H0+eDPeN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778346452; c=relaxed/simple;
	bh=QhhESLt4sU4La0hv5PEaGGtWswEN/2rxsz2V4OX7lNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D/9CnNymcYLx7OVVgzUq03G9M4ZNxfJx7bZF23D4FuGxn1XLtRdqQqscfvwoiKtdtePwACjsgqspUAyeRs7bERbDMhlwPzN8TBnHICZMMJ7JVmayIK5aimuTzuHwO3EgUCkyO3J9w/ocmT5jCVlnaC2FvGTEW7IrTqkdgC655dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PSvGJXcZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PdhghiTX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PSvGJXcZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PdhghiTX"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6494diW63075656
	for <iommu@lists.linux.dev>; Sat, 9 May 2026 17:07:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NK26YkhXhOkB1zXXrflzYxxjD7OJUQPCc6PGnNHByaw=; b=PSvGJXcZAgrUyxaM
	U6HDSgO1E2DllbScsXkg2vFzairaUrRNUwT/eHB8sNtYb9Mi7QIPIy9oRuPp6vTX
	qvqZRxKGECeOJAlfKPy/tChHjGd3dsC3WQJRMuKXFTcs30wkjWhlQQS4IXA5w7/p
	HBCSU6AEzIdjXCyIKsoOYmhpMEhezBnUYxN6RrWPmSg19rXe30Gas6nCH1SOJnPM
	AEA+TWemEm0jcVf5UooqQbDMp/fWsupOsSgjZzz+wuPDfLlBOu77UV2Bzx9WcaXz
	y/werDFzZw+zG/79CrF4/vSovF3+4jEul/RGYwcb/AftErqGrCTWy32yDRypTCXd
	xaWKfw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1x3k18me-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sat, 09 May 2026 17:07:30 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82f74bcfb86so3024255b3a.0
        for <iommu@lists.linux.dev>; Sat, 09 May 2026 10:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778346450; x=1778951250; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NK26YkhXhOkB1zXXrflzYxxjD7OJUQPCc6PGnNHByaw=;
        b=PdhghiTXcPnxNjaL7tBJoidw9DzE5otsex54jxmiUJBGbt3gZ9IMwnQqLgEjf9YShh
         B3AADrHnb23qQifu6E/ezqZVSTtZFpzf70XCpjel2V8wlLljghQsbVakCZsAwTyssvhJ
         1jICWQXifgwnD/qW2yV6U14qSzEgOJk0QT2G7fNQ6KMPsGSJF8DVgIhnzV0GktqSwW1f
         ej6bqWCmd24TIfVkNpqN6JZIoUBy15esRXiaX4DCYrO2A0MV9EkYRU89ltYhgpXtDLro
         RiTj9sc7lFI5H+xUDU1PzB11GjbX5xrlb5TypXNTKURprWp0eZZvnIr9O2ZqEEymIzWD
         GVMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778346450; x=1778951250;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NK26YkhXhOkB1zXXrflzYxxjD7OJUQPCc6PGnNHByaw=;
        b=dPnxFUC2bTvP1gx4jyYDi38hsXBMZ64AVAEUkR5JCcx9Y2ks+WI4TnL5LcoNqx9jzp
         E0zXoLN10QOtbrL4Bkhj2aA/sz3Zj1OAboKBglHvm9YA1PnaKbkEEmIaGBr7H8Sik0FF
         m8eC2qJGcF7zi6T7SUbVcNNRu5dgnPrmHn4vUvSU4kqsGLFZEIEJobowBLg6iFzSl3mS
         HDdCmw74ABXpotefRKaclG2aX+RlGv+KAFq7BJkIch9q6Kmy4ReGek0EtPg4DcblsF2F
         QjsBE9B7grozKRoo6gtg5wZASLStOWwHaX6UWin2dkaw+NVhicThXd9UL97zZmML3F38
         HuVQ==
X-Forwarded-Encrypted: i=1; AFNElJ+ulR0p7FmnBsNtVEudiuvQAhL5ANgxGz5uyuEmGyeBTp4MRz7ygETDjn/mz6+jmDAKPqCu+w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw6jCtd7mhEQk/PirRlFg3Bx7MYH+S6y2z3UNLjk7Ez3HSj3KJ7
	tUq8gV6c/g+HJI7BOFGeNzG6Snul/T1mH4EMdrrdRJ7Kr6H/PRWGbjaUN3wsBj4YTccSS7wRgUf
	p7p5Z2sApztmL87zFy1Ey8yhiQKfxG6IfWfkgLUUezFNR687hu0f3ghE+HA==
X-Gm-Gg: Acq92OEoeMupeYMp/YM31Bd9YuxmsFAnJYORwxDVIJE/AbxlM5TNuglMokn1Pjaxg4p
	+DPhCWaUE6DBs/MgBt1L5dQvzPKnx/2+LXfP2bNJyoqeBMkzDdDYudY1U34VXx4a5r+ZRi7XxvX
	75JcrjSRZxB/cPy6+YIt23O2vplcMEG+umxZRW37I7Msfc8YEZESk0l1ZEeUVEsM6e3pHyO05VS
	Rt3FhFPCc7dVBsBc2fZ4XkrogO289vXjmBfg/G2Uk9D/AqDU6Ki+kM344MLkYr0YUFxk/x1c08W
	BOpfolGBSdd6U6YJCq1Re4kEAD0uUUVYF+Y8hUAU5Ha1QOJaq38oN2IDYt49AzTOc209k+pLLQy
	XJaApEKDSbhoc47WqEMUjM0bRNHBZiQ7tmqy9MHG0hBCfStK2tCuWa9CeDwgLxA==
X-Received: by 2002:a05:6a00:1303:b0:81f:3f03:6846 with SMTP id d2e1a72fcca58-83e3bf8eaf4mr2810763b3a.47.1778346450096;
        Sat, 09 May 2026 10:07:30 -0700 (PDT)
X-Received: by 2002:a05:6a00:1303:b0:81f:3f03:6846 with SMTP id d2e1a72fcca58-83e3bf8eaf4mr2810726b3a.47.1778346449532;
        Sat, 09 May 2026 10:07:29 -0700 (PDT)
Received: from [192.168.0.9] ([49.205.255.40])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83967dbee14sm20911031b3a.48.2026.05.09.10.07.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 May 2026 10:07:29 -0700 (PDT)
Message-ID: <4eef8b17-47b5-e8f0-4a44-87fdf1d69d18@oss.qualcomm.com>
Date: Sat, 9 May 2026 22:37:20 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v5 08/14] media: iris: Rename clock and power domain
 macros to use vcodec prefix
Content-Language: en-US
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
 <20260509-glymur-v5-8-7fbb340c5dbd@oss.qualcomm.com>
 <6hr42ins65rf6ftdmme5lok6ham67piz3343kdwxaff2acktcz@oipdhket32og>
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
In-Reply-To: <6hr42ins65rf6ftdmme5lok6ham67piz3343kdwxaff2acktcz@oipdhket32og>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA5MDE4NiBTYWx0ZWRfX0ZrhHLIoBaWW
 0z3qwlGX/mjBNzck4mDDD+cxnT/l4qzGa6pRBGk+v2+XM4aa8Xody/7F3f65sh6pWgfDUouAYhm
 g0oGnfea3EJXeIUPK0jkW1WLbuAOQ/MTSNPEROYv7MWBSbXYfJdiQrNZRX2hBORisW+6xJPQyGB
 hOYHv/MjfRuknaV1LjWd3ste04qPKngaANP1EikeTXpllQSJuuIiIvpOt95EHabtlSDnhTsKGyH
 01ICwuWfk5R61NzLnjK9rQQ1qYBni09vuWM7GczJ+j+XYm4y8gUxXMiPv16lZFlpHayaAdRTMUz
 5dcL7CEqXW9Yr08GApBQM+tKDn6DOWzoceZq2RQmTyvX5vSEmgOCMS4//HhmWndNjHwD7/sW5sT
 tJOW/C4UgdzWxYzt6HWUXuJquqxMY8orya1YxsWWKU4TQSctNUCelCeIr06zRtAbnsCJr11Ygfj
 alw8FhZ48OmDd0TiQpQ==
X-Proofpoint-ORIG-GUID: xETNwEvWOMfT4UtmEiY1IHPtO2KYznnk
X-Authority-Analysis: v=2.4 cv=UNvt2ify c=1 sm=1 tr=0 ts=69ff69d2 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=SpcZ+gRb+6o1zy8jT5J+bQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=2nvh9x2cStbi1KpodkAA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: xETNwEvWOMfT4UtmEiY1IHPtO2KYznnk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-09_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501 phishscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605090186


On 5/9/2026 1:52 AM, Dmitry Baryshkov wrote:
> On Sat, May 09, 2026 at 12:29:57AM +0530, Vishnu Reddy wrote:
>> The current clock and power domain enum names are too generic. Rename
>> them with a vcodec prefix to make the names more meaningful and to easily
>> accommodate vcodec1 enums for the secondary core for glymur platform.
>>
>> No functional changes intended.
>>
>> Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>> ---
>>  .../platform/qcom/iris/iris_platform_common.h      | 12 ++++----
>>  .../media/platform/qcom/iris/iris_platform_gen1.c  |  6 ++--
>>  .../media/platform/qcom/iris/iris_platform_gen2.c  |  6 ++--
>>  .../platform/qcom/iris/iris_platform_sc7280.h      | 10 +++----
>>  .../platform/qcom/iris/iris_platform_sm8750.h      | 12 ++++----
>>  drivers/media/platform/qcom/iris/iris_vpu3x.c      | 21 +++++++-------
>>  drivers/media/platform/qcom/iris/iris_vpu4x.c      | 30 +++++++++++---------
>>  drivers/media/platform/qcom/iris/iris_vpu_common.c | 33 +++++++++++-----------
>>  8 files changed, 67 insertions(+), 63 deletions(-)
>>
>> diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
>> index 55ff6137d9a9..30e9d4d288c6 100644
>> --- a/drivers/media/platform/qcom/iris/iris_platform_common.h
>> +++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
>> @@ -49,14 +49,14 @@ extern const struct iris_platform_data sm8650_data;
>>  extern const struct iris_platform_data sm8750_data;
>>  
>>  enum platform_clk_type {
>> -	IRIS_AXI_CLK, /* AXI0 in case of platforms with multiple AXI clocks */
>> +	IRIS_AXI_VCODEC_CLK,
>>  	IRIS_CTRL_CLK,
>>  	IRIS_AHB_CLK,
>> -	IRIS_HW_CLK,
>> -	IRIS_HW_AHB_CLK,
>> -	IRIS_AXI1_CLK,
>> +	IRIS_VCODEC_CLK,
>> +	IRIS_VCODEC_AHB_CLK,
>> +	IRIS_AXI_CTRL_CLK,
> Why AXI_CTRL is better than AXI1?

Glymur has 3 AXI clocks: axi_vcodec0, axi_ctrl, and axi_vcodec1. Using
positional names like AXI0/AXI1/AXI2 doesn't convey their purpose, whereas
naming them as AXI_VCODEC_CLK, AXI_CTRL_CLK makes the intent clearer,
especially when platforms differ in the number of AXI clocks they expose.

>
>>  	IRIS_CTRL_FREERUN_CLK,
>> -	IRIS_HW_FREERUN_CLK,
>> +	IRIS_VCODEC_FREERUN_CLK,
> Can we at least group them too?
>
>>  	IRIS_BSE_HW_CLK,
> Is BSE a core or a codec clock?
>
>>  	IRIS_VPP0_HW_CLK,
>>  	IRIS_VPP1_HW_CLK,
>> @@ -206,7 +206,7 @@ struct icc_vote_data {
>>  
>>  enum platform_pm_domain_type {
>>  	IRIS_CTRL_POWER_DOMAIN,
>> -	IRIS_HW_POWER_DOMAIN,
>> +	IRIS_VCODEC_POWER_DOMAIN,
>>  	IRIS_VPP0_HW_POWER_DOMAIN,
>>  	IRIS_VPP1_HW_POWER_DOMAIN,
>>  	IRIS_APV_HW_POWER_DOMAIN,
