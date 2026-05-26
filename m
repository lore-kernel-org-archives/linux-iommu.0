Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156B03DD877
	for <iommu@lists.linux.dev>; Tue, 26 May 2026 11:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779794507; cv=none; b=dUTB6rdUUM2UQKchtMfEjabMkCLXSeXP4QbPGopgkv1gB/qfXpIdHeyIqcyDaN1eqeA93sDEwELoYrq6RINgPxzdRC1WITg6Jg+BuEsISBwctQKzVa3n8iWZtnnO4+gzHXxF6FoO+91n1vKg0UkTvWRE9TGVpP4nbaGmlK6eTjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779794507; c=relaxed/simple;
	bh=i/pTzMVi9XbOmZoluvn42b58PFWtzW94v/MUSd3ggjY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=lE2vCEdVazcZ7KUS7o7TIEW6ua0Walf17sAO/ygbEjnSpZL8ZIbn/69q5xurSlpiRAry1EB/+97oPdsTgJ1svN1ze8hrR9AL0z2Nh10WS8++7vhyX8NrgQZZf99W0CWnx//LQw5Cr8/pfBQ3fJodXZxmvPkfvxTR11+IOSMbSWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=McMcpSj3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hZnOKWqh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="McMcpSj3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hZnOKWqh"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64Q6mSnD3263539
	for <iommu@lists.linux.dev>; Tue, 26 May 2026 11:21:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	657l6qX2PWzLBimaQHEMg2HJ1WHmLAQaXwJId8moVA8=; b=McMcpSj354sThUE1
	mYD59EORxNrXnhcSVzzJVxU/mtgBOTkATHS3zgzpFAJgFzOCrZ6Tko9QcRFX4fdG
	pjO/cSrfmFsIXqG1Fw7Ao+Ras3SPAAQV63vtpdpB+azxJWxOrGkxzP+cwyxpmql1
	mRRhTVOo6NwaBvRWNf0+jzf3jb3IsstT0cj7NGw+SyGajOJL2J5Fd/8gFPX2OMiO
	+gtHnIgX1IVHJnvyEIDB0PSekbn3xyg1BAdfZoOFcdvA4Z5K/j+K1CcxJtgrUD2/
	z3z4W3alIsFRXRbx2o8KKfCwZu8NS6qvdcKgUni8T3BjfMJcYOw3WsWE1Vy2pWuw
	H6qBFQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ecnhs45mv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 26 May 2026 11:21:43 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8397b14a689so6443037b3a.2
        for <iommu@lists.linux.dev>; Tue, 26 May 2026 04:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779794503; x=1780399303; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=657l6qX2PWzLBimaQHEMg2HJ1WHmLAQaXwJId8moVA8=;
        b=hZnOKWqhkYOzcwf7FshKSzfrfzq6BuOojS0Z5JzNS86+2Hj28StVm8tXAPwUiUv9YO
         bTU6ZxcLhdpTFgRKq6qkP6QgxEO0k12cdKGA+aNEi5gPuzRLQw8Ytj7wQp+eYcSwWk81
         t9YGmHbAG3eI7XFXo8NqBYbVwiZPF9IChBql3PX/Go/1eP/ZrnBBG71988/n8vhcuiw2
         CIsc/Wy5vegbh6F/jtKE2Yutt+ZZbbteQbEAEzEAnXiwoJfJVa/M/yDZrws/rScRf9M8
         +oXxG62RoqHcGFkQYLAqeTWxGOfV3ZhwL6KrTbGkr73w5z13dGPwdpW8nuoWBHzE4GYb
         sujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779794503; x=1780399303;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=657l6qX2PWzLBimaQHEMg2HJ1WHmLAQaXwJId8moVA8=;
        b=Rr6B3FG3iNzgt5FBS9BEjdCOZ/IaigbfLXik9BYgeRdr7ueMB8qmFPkfGq7xvR4zr9
         RtYNoTcU+3E/+lG42+hlXvgoHAxplF6hUUNwaonQdYhv0YLY6CO9QRkA72KE8exUuvCv
         jZcvVxl0jV4pjCg2Nr3sAE9C9gH1Mz8T9J5yjTxgFOvLXIxC5RKs1/wtNI71oP4wWlq1
         6sqifkJIqQxxYDV3juqYZkySAXJ9BYdH2yqQIBFDB0hpVlSx3f5x4180GhwUL0p8unm0
         nrcnQoU5WJ0bUqK3dH7ARTb3XoxNTvd54KeS0YVFa9GIhc9XK72Sy+18S6MI3cPnoe5X
         /rjw==
X-Forwarded-Encrypted: i=1; AFNElJ/ubXApViDYi4Srfp0s2zRHu5Aww1H2GahkepwX9rVK9oqHnHbsKLZS7eDVZKm6QtcWdhRIrA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxfYgLd0uWyOrO4gtE8NkZtnJHioWaQxdnPLCWT22R+SXqrEPmY
	FTzNHUqM3nSOOBJDItQlBUFD3kkZI2gC4XkTIOGQ13hCNb6nTuUHq06wxCDEjZsvzEQk1UewhZ8
	3csxbuGGJcnTDVHux2Dq5EszWrFxiEenc/QvYKtk0gBSL6XG9gBpeflmXBA==
X-Gm-Gg: Acq92OFrBFIHTCVIV5WXnmI7rYnw6fXxTRXRZNw1XUzlGh13jY686TbcAxbW6piZsO2
	YnMjMH0ni/KeFA+vioxdHJql+ynJiekaTNO3v6oP2g8lj1+ujeB4uf/vQdNW67xDIm4f+jP9Vjy
	TQYUWjJgi34q3XFX2ihVEfAW9b4WWcC35BYg9ESE/jllJZetDikK/VbcyiffDGRGGBTGHywrbrs
	43POYcPnt9ADJdHl02xz+80V1fz/W+xVj5lJihWfL1hiQNfE5mQYk/uIM3dP/PuwwYdmsGrHenp
	k1dxu9T90oIDEtLzoo5+NMx1axJD0FxuH99YLGJwQIpV3LzxhLWiCNZ1CrKOmAQttJ0p+d4QAOs
	/S1usWAIwazceUHEDpw2XY92sMxXIyfABOsf+0944hZDHoBUb5ocCpA==
X-Received: by 2002:a05:6a00:1988:b0:838:127d:a16e with SMTP id d2e1a72fcca58-8415f33166bmr15334896b3a.17.1779794502947;
        Tue, 26 May 2026 04:21:42 -0700 (PDT)
X-Received: by 2002:a05:6a00:1988:b0:838:127d:a16e with SMTP id d2e1a72fcca58-8415f33166bmr15334846b3a.17.1779794502360;
        Tue, 26 May 2026 04:21:42 -0700 (PDT)
Received: from [10.206.105.200] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164ac9b74sm11949564b3a.3.2026.05.26.04.21.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 04:21:41 -0700 (PDT)
Message-ID: <2757cc51-f755-905e-3dae-4f4cf12db15b@oss.qualcomm.com>
Date: Tue, 26 May 2026 16:51:32 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Subject: Re: [PATCH v5 03/14] media: iris: Fix VM count passed to firmware
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
        devicetree@vger.kernel.org, stable@vger.kernel.org
References: <20260509-glymur-v5-0-7fbb340c5dbd@oss.qualcomm.com>
 <20260509-glymur-v5-3-7fbb340c5dbd@oss.qualcomm.com>
 <zfh3hb4gowxejxeip3l24jub2z3xh26pzl5xmjhjos634c6e3u@y26yubeb7v33>
 <11c63862-5e8b-9f3a-5479-706e672879a5@oss.qualcomm.com>
 <izj6zy7c4ec2cjbsznkaxa4q3hupwteqprjzpajjquwchwa227@mplk7d7uccz7>
Content-Language: en-US
In-Reply-To: <izj6zy7c4ec2cjbsznkaxa4q3hupwteqprjzpajjquwchwa227@mplk7d7uccz7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Vd3H+lp9 c=1 sm=1 tr=0 ts=6a158247 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=FhdRzFEOr7cjOW0uG60A:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: pXrLPkQdACfmx1mT3wb2UgzKA7bRDsfZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDA5OSBTYWx0ZWRfX0Bw5dsca6ZiG
 FIZP76rY1XdeeFFvAaLKC5pWuNWW4PYq1uKQ+yIEsvGH7shg3+WxIRdzuRf8APb3K2FGASZQok2
 rDunKjHjCBR6ATKKokeRSAN+QbCyD9AIl/x0XPnRKQWg1b0JwO/Fww4vquCbMQ9Nu8kPdY9VZ7h
 q5lnOmFNW50UA1r+Gk9koqeRvyxtKkz4OBwD0HVmhxCITHp6nCW727zu5h9r44ihYQTpIdCxPIM
 1XB1diw0H0PDurAzuaWW3KHgal1nUoEn4loaa1LRsR1IeCkcabnbjiWpAlwMjnq344oiWeclAtx
 N/qdKXl+HbnZQRB38ihtQAiTHhwwGoGEUoVTSOfNzAqaIy2552IPGnEnulVsMVljrvLcmiSdcM7
 EiISecO9wwYTLG0GQ3cI8SdikthQNTMHXXhcZP2JYJKFNXqRzIhJQCc9mu34ZokUwh0MIQdLOPj
 lfJbRm3nkhECHNh1D4Q==
X-Proofpoint-ORIG-GUID: pXrLPkQdACfmx1mT3wb2UgzKA7bRDsfZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_02,2026-05-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260099


On 5/17/2026 10:59 PM, Dmitry Baryshkov wrote:
> On Fri, May 15, 2026 at 04:48:44PM +0530, Vishnu Reddy wrote:
>> On 5/9/2026 12:50 AM, Dmitry Baryshkov wrote:
>>> On Sat, May 09, 2026 at 12:29:52AM +0530, Vishnu Reddy wrote:
>>>> On Glymur, firmware interprets the value written to CPU_CS_SCIACMDARG3 as
>>>> the number of virtual machines (VMs) and internally adds 1 to it. Writing
>>>> 1 causes firmware to treat it as 2 VMs. Since only one VM is required,
>>>> remove this write to leave the register at its reset value of 0. This does
>>>> not affect other platforms as only Glymur firmware uses this register,
>>>> earlier platform firmwares ignore it.
>>> The explanation is pretty suspicious. I can see this write in venus
>>> sources too and it was added in the initial submission, dating 2017. The
>>> driver targeted two platforms, MSM8916 and MSM8996, so this write
>>> predates Glymur pretty much.
>> Thank you for the historical context! I checked with the firmware team and
>> confirmed that this register is not read by any of the platform firmwares
>> currently supported in the Iris driver. Regarding MSM8916 and MSM8996, those
>> are not supported in the Iris driver.
> So, which platforms actually needed that register? The "currently
> supported" is not strong enough. We are bringing in Agatti support and
> support for SM8150 and SDM845 is in discussion. I would not be surprised
> if we end up porting other older platforms too. So, you are changing the
> historical behaviour. You need to document the applicability of the
> change.

Apologies for the late reply, I was on vacation last week.

I'll move this to a glymur-specific vpu_ops hook and keep the existing behavior
for the remaining platforms.

>>>> Fixes: abf5bac63f68 ("media: iris: implement the boot sequence of the firmware")
>>>> Cc: stable@vger.kernel.org
>>>> Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>>>> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>>>> ---
>>>>  drivers/media/platform/qcom/iris/iris_vpu_common.c | 1 -
>>>>  1 file changed, 1 deletion(-)
>>>>
