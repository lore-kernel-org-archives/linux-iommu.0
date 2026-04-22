Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85ED014EC73
	for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 01:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776822353; cv=none; b=VxJxX7KqE8Lpg9exe1V+EtLztyERzFdwNB0LlAZGL5v/yN6KlbDTS3kgcUF60L+OrGwj+03WP3OpPoXS3jNMuiZlQF8Vl5BGCDbiqceNUhtJnX1Lfpt3JYOqMxFCqvveXl/1+OEHgSGAQbBP64G44bdGVFLfPLQGEkvBcWHMEUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776822353; c=relaxed/simple;
	bh=WAELlRbfu9Q9ChOw2T9Dh9NZf+cQmOdSh1QOFmr3Lig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QSsn853AACoZzmKye9vLi3Uf/vCr0FU534qXuFgB6I1St7WjFJVcZXHC97hafP6HY1tUHFwQdHBZ1Y2iYrTeJDgXf+QQY5lQEr2UvFFuLmfkwmMV1js6QrJqmAcg+Ab1aRdLLQBhiDJeq3aTZSlqs/N+jR/qxnQih6DU7rOKc9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fX0/CtT7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=juBNm6gY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fX0/CtT7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="juBNm6gY"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63LIa8dS3083043
	for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 01:45:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=5wHdqqn7SDS+5SZ20jG8Ptef
	E6PvolnfCH/vcLHZcaI=; b=fX0/CtT79Lf7McX0/JXcisYHIuPoYziwG/mSIRfA
	XEjvT0ia0LCX9MctirgK32TibQzWRVtk+qYMJL16lyXc1AjW61vJMXJShxXbiUKV
	uVZ/g9XJP6nId4Uyn8jm5swJq4XNnqJie1CUGayva1WuFux25XpeRyHICacVauvK
	CEoH2Im7Hq/AcB8h63ZtnvZc1BKfTrZpFZCt8hpgdIcOJH6DpxG1Sv4KZsaRfaM6
	1TgHwDtLN2vJ2zmWbWviDq5PaGI3+jg6d3kexdOFm+BDUA2eU50W8KPNXky0/xDp
	bBr2fvx/cN4Jhlq0ZmzzI8RTGRnfZ/k7UN3nicHhRAfBjA==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpenmh5xj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 01:45:51 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-60f8cfefd57so6772584137.1
        for <iommu@lists.linux.dev>; Tue, 21 Apr 2026 18:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776822351; x=1777427151; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5wHdqqn7SDS+5SZ20jG8PtefE6PvolnfCH/vcLHZcaI=;
        b=juBNm6gY0Vmc4HMMZ/bvSnCK96gSUV637QwAzwN8uQTpKmIoyO/r+6wD/rxuRKv9uM
         tQ2HkGSym5BDSlA1XrET9XmOHPNIMElpHk3D0j0EkNhw9UuHwvVSZp7gJcPw2IsdsMF7
         UbQ/KMJvbpezYG2qzZ7vpwYdekr44V/Grz92YVhQ+j7dlR583shnJ3JeZHN2W5zwRR2d
         aAIYkJKZa8rGj+nibeJ0oe9h4dvmyzAmPKV5hay6AEmoq0yX8nPthAyT0wAsIypQOZ04
         K0a7EGfMcO/1oTva9elFo0U6yCJ8t6P1pN3qxUzmEUneh6vavZ6QU0REPmqHqQtGLY4o
         uFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776822351; x=1777427151;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5wHdqqn7SDS+5SZ20jG8PtefE6PvolnfCH/vcLHZcaI=;
        b=mUwKiKw700xxBeqZbnFKqFYrrR/K1idQlFYlnAW07obbPhQ6hi7M9lJLyC+paw2HAV
         moq3oFaf4OBdjJVojIFfBFV+jP7a029wNTPJL5gJufzOBrWfGvLl3FiI3Cd+6Q9d0zK0
         I4ISNXzzgwc6CxH7P0pxq0xDwdYe6NCtg6BhDfJU+CNxwpF0tEUYOnAOz8TQq5Er/ga3
         WQo/dKe9djqVuRqrgUiMu7AJuxMFIueL7DaEICBiZhmP9eICipTzg0KfTu+kRVJdQk63
         xpvc2ACeCSMwwaLprbIgu8XuQ9h/p4v27P9cw9o4FNpeGc/ENr8yNUQt78qLbRMn0eJC
         62Yg==
X-Forwarded-Encrypted: i=1; AFNElJ8j5T3BnmwE7qComVKirRJ8hwPhWEWLSTqvpsHCFPdTSbHlfMLwxymRT4/cKfbjmUagssm0Jw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyey6fXG2CzPvG601d6spVHB1Sv+VI1znyHy4MCoGpzVLRcA115
	A9jTdyKQR+tEj+2kZCZrevErGoEXb/e6MIIcegYRS4m8qXtl5WcvtvaoySdJHLK4hdheTAMFoTq
	3Iv8uHY0vaKD299v4lEYeLSw6G8Cvm1EszoPF3GUxb/zch9Ocdjou8ibOWw==
X-Gm-Gg: AeBDiet4aL0FJ/xXXq3TP6AK9wHkM4ZJygUFchGByFRrUFjMRaOH1qJV/cjNsfDrB+Z
	K6mr3vaQSD4k073spNn6cPNtmyvrAooB5qnOHSsDFiFUxJ2baA5U2q2LosCkfOnKrTTLF2qCgDq
	kfXXgWRayRK5ifhQ6f8tdgH/uZND+kWVzNje1356WdNFN+8L/fHRcV3TZx3z2OC7RVX0EjoVhSi
	CG6m3JVnLWC4K3QZdyOCMSfI6qNbAiZ2jrZkMxqniVGmZr03diMU0LDgwz7yDZFsJXfAkbsdveC
	Y4IZEeE7BqVqPvAwBTB1rBVcQSneniro/flNbRa5ygSgJbvGO3CESNTLP6nHeNcNe/7EfDmfaDb
	mClVCHx4+XsJKBpaCl8xlVyXXbXoy2z4/YTm95rHwy+6opgFfznSEj4ZiOva5mfq7aoDVRdgEgX
	rc7dipC01FDMYCTn12S+1PLmtlkAp72fl5GdPgog/oebyWAA==
X-Received: by 2002:a05:6102:5716:b0:5f7:2568:abb2 with SMTP id ada2fe7eead31-616f4b4be78mr10249654137.6.1776822350785;
        Tue, 21 Apr 2026 18:45:50 -0700 (PDT)
X-Received: by 2002:a05:6102:5716:b0:5f7:2568:abb2 with SMTP id ada2fe7eead31-616f4b4be78mr10249640137.6.1776822350339;
        Tue, 21 Apr 2026 18:45:50 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38ecb4f51a7sm32980981fa.7.2026.04.21.18.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 18:45:48 -0700 (PDT)
Date: Wed, 22 Apr 2026 04:45:45 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: contact@alex-min.fr
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Guru Das Srinagesh <linux@gurudas.dev>,
        Linus Walleij <linusw@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Kees Cook <kees@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        iommu@lists.linux.dev
Subject: Re: [PATCH 3/8] pinctrl: qcom: Register functions before enabling
 pinctrl
Message-ID: <jqxpgl3wqpcbou5uvg6culdxbnebhydd6q3owtgubfxnflsdnh@gegu3gmz5bhh>
References: <20260421-mainline-send-v1-sending-v1-0-bcb0857724de@alex-min.fr>
 <20260421-mainline-send-v1-sending-v1-3-bcb0857724de@alex-min.fr>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421-mainline-send-v1-sending-v1-3-bcb0857724de@alex-min.fr>
X-Proofpoint-GUID: OVbzfGg6WEkkiOocKW-190kFIawB_STo
X-Proofpoint-ORIG-GUID: OVbzfGg6WEkkiOocKW-190kFIawB_STo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDAxNSBTYWx0ZWRfX6xI8ip9g68no
 pNWeONunF0aQU4gFPcfRNqVyqLQiiXCn63liDKiHUPIr6EBCKTA8r/hmz9V5cLsahdq2HBY1xRt
 bglEHV569taNfNODH+nghCv0z27nusZdkv23cgzwidq1sGKvEtmtuZJ9dfM1Sdy+ncagfNkns8R
 F4LQp44XahZjPRk1TZrwXSTUaz3Sn7bII7UHWL/uimyCeowyhYxB3bZnnzxYiq1Kxvtud7q0hRP
 1UDzq0W47FLgh6Il64ij1Qxqy83ItkK+opkytvoYDJkXEcZcfH9+xV0X0bZ0RURi88z66BcI+fx
 rsPOxfUAZlKe4d6gxdrmhgLgUvLBmu/SQ4iXxQyyoImCKXqT2irKNHlRRxHXIRQWsNIsUL1iM+n
 uT2Ro5+VdUhVTR/EDzImP3vCdhQx110qD99EFUK8HSdfP9XbBCoW1kJ4el1aba1hvWr1/IMoFCP
 Ulr1pFlpt9kr/PBbufw==
X-Authority-Analysis: v=2.4 cv=Xd65Co55 c=1 sm=1 tr=0 ts=69e8284f cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=PRS8Z04pAEUxk0G-eYAA:9
 a=CjuIK1q_8ugA:10 a=O8hF6Hzn-FEA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604220015

On Tue, Apr 21, 2026 at 11:45:09AM +0200, Alexandre MINETTE via B4 Relay wrote:
> From: Alexandre MINETTE <contact@alex-min.fr>
> 
> Register Qualcomm pinctrl with devm_pinctrl_register_and_init() so pin
> functions can be added before the pinctrl device is enabled.
> 
> This lets pinmux_generic_add_pinfunction() populate the function list
> before consumers request states during pinctrl_enable().

Why is this required? Could you please extend the commit message?

> 
> Signed-off-by: Alexandre MINETTE <contact@alex-min.fr>
> ---
>  drivers/pinctrl/qcom/pinctrl-msm.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
> index 45b3a2763eb8..a2a1e0835735 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> @@ -1593,11 +1593,11 @@ int msm_pinctrl_probe(struct platform_device *pdev,
>  	pctrl->desc.pins = pctrl->soc->pins;
>  	pctrl->desc.npins = pctrl->soc->npins;
>  
> -	pctrl->pctrl = devm_pinctrl_register(&pdev->dev, &pctrl->desc, pctrl);
> -	if (IS_ERR(pctrl->pctrl)) {
> -		dev_err(&pdev->dev, "Couldn't register pinctrl driver\n");
> -		return PTR_ERR(pctrl->pctrl);
> -	}
> +	ret = devm_pinctrl_register_and_init(&pdev->dev, &pctrl->desc,
> +					     pctrl, &pctrl->pctrl);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "Couldn't register pinctrl driver\n");
>  
>  	for (i = 0; i < soc_data->nfunctions; i++) {
>  		func = &soc_data->functions[i];
> @@ -1607,6 +1607,11 @@ int msm_pinctrl_probe(struct platform_device *pdev,
>  			return ret;
>  	}
>  
> +	ret = pinctrl_enable(pctrl->pctrl);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "Couldn't enable pinctrl driver\n");
> +
>  	ret = msm_gpio_init(pctrl);
>  	if (ret)
>  		return ret;
> 
> -- 
> 2.43.0
> 
> 

-- 
With best wishes
Dmitry
