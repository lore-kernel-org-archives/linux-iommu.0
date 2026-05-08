Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732BA23E342
	for <iommu@lists.linux.dev>; Fri,  8 May 2026 20:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778271750; cv=none; b=attWc9LyuwLw25RaL7Riq6kpT3JBBFnP6jyQnSxr4/ykbLqlaA4VSEBhtaUl45iYbNXXjVOa95rVSCMkZBzCIIdsfIM8nvwQVLFppbqdYbHWe50Suv9dKfkE7ic2PeaKff/U3ifACjB4tddKNZ3+yzN7HqxW+zMyj88fNmIRbVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778271750; c=relaxed/simple;
	bh=+FeoASb8ovnMoSwAHzqvf/4UpoY37EViOCEWLfpnb74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=arqDYo4k04ZNquXdUB2iVaLn0qBj2xiOZHm0Zcd3dadMjED1il1IdEHiDGzRNftGNIRCjrS+bZWuTkN0+hMGu2bQBcYMu2ARHdiMs6Xy02l98XRenI+f9HJU0PAJnyqS47AhrQUcMmHHjF4LiWwEvNS5BvZrvgHGGxyzk4qB1YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B5p0s194; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dtLFtRsh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B5p0s194";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dtLFtRsh"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 648Hdq4e874113
	for <iommu@lists.linux.dev>; Fri, 8 May 2026 20:22:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=VvGwdKoiuQ+OZDlMszXSVliH
	FXLgaU6CLyX9TMT17Ho=; b=B5p0s194aR8s0/a2ojrmD6M8cEfqeXH6atcP/8jk
	PI7SOP3XLgIJruTqRBntcvcm1q351weYMhw28ITDtVockz1ks+zO2bzMEdOdIGNq
	UDGERjRzkkJE5BW+w3807tfBNCF3LW4x/FdPu/W245IFQLgd8mHzstqkaQn4IEMg
	jIRyzpS72pIrfjjWSn+EWG3nc35zJUJkDtw95ScOVKMCkWV7nMjZspWmbAxgjA2/
	YylzbBv2B8qZUyruZcbwZeM5NxJbLU22XDuixULG5+VIZ4WTpnLzcLobzleAifFa
	GkoRZDIcViRH7JJTvew3PopGFUp6q9wDtY3Ke3swubKK6g==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1me80g9u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 08 May 2026 20:22:26 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-95ce6d50ea7so1517412241.1
        for <iommu@lists.linux.dev>; Fri, 08 May 2026 13:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778271746; x=1778876546; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VvGwdKoiuQ+OZDlMszXSVliHFXLgaU6CLyX9TMT17Ho=;
        b=dtLFtRshd+li852ELXsZoSdSWLg9BrNROu7fcE6AYbLZKVPv8/UaZaMrmNftEOFW3O
         cf6eTb8PJZ2IqpxI8b01t6awEMMeENJlkAnxZymZA3Hjls8sR0AeAyn8LoYhV3YL1PBS
         ZVEsoiIHr1m3SsjAccfQlJz06UFn+ns9TFrKdySuE4TxWPFeyirShT8MfgBJWNxAliE4
         cOwzCBGa4qIc785dCWUI04XMpzGeX0pCUBgCDIiPKjxQ3gZn8leG41t9eBUJyiuWHAJ4
         UKnIKOvjc8OB2opxt7kxWhaJGqWJ0R5ljm+g92XAhAFUZNUShWMOyRRNWm2NgDkdH09S
         DHeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778271746; x=1778876546;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VvGwdKoiuQ+OZDlMszXSVliHFXLgaU6CLyX9TMT17Ho=;
        b=cB4pWAQ8JtwKXloN3+9dqZf/dapne/O6hck1fIWpLcl9OIuzqPM4WQWNTSHhkjBzJK
         ulgOMhKyrKbsU999S0ymqK4X+tYfKUZIPV3To4gTOc6KDAKCEG19NvKGDsKdqSo1JcmT
         kNbiLLJ7WsN4ZEC3/sBYYwDrpu15zDYajeTV0WE5bsl2to+4UZ/KAS8ySKjdIml832tL
         7WizgWygrYKw41lpRNSWKfnenK0rDBoD/jT7iJoQTgX5qkslRpxhjlx/w+ts7fEhISqJ
         otDhTpibSgehsluQKbNrCg5d2iaywKIhj/J+zj6LDCKLgCT2XR/wd7TuaZi8zKe3DruD
         /QCw==
X-Forwarded-Encrypted: i=1; AFNElJ+2HebS+la7TBQrvG8lfZqSGXthvGtSDvtUKNwqyFRrLgjK8ttgXKEDghIsu5QAb84c15UXgA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz22yQ1R51cIwJvklsOJdrjdJWMOTHXr4PK6BzgaU8t3SZIqWu4
	+GyvvJhUi1ztPCxZn1xMxNNrILIHzLF6rO17OQx5AYNwHHX+GayYuvJjtRODGs5HoiRIY3+NbRt
	JRL6rvcqSjb7wh0CFpfgjReq0WPzK7J8kNkxs9vk+s+PH/yMreqV0rkeg1g==
X-Gm-Gg: Acq92OHxNmH+opD4mgMQJrV/lIfrUL9RblqPxh/Ld1pcdzBosn6FJjc0OqEZVneABKx
	mSBO9WswQxj1ybnlVW1anJ+yKaI6HccKgso5P7sgKEPf+jI1jm4/Zmg7/vSPejZRmpdCKUxiYgH
	tO3qEyF9vQWGicRWQQJkVTtmjggUMaQhGZpyQnJZgPzYUNd8Bd/zix8QwzOKxo1YJRsponqPWZb
	Ai9JYZGe04pib3NWasjOIAiyPCF1m1I08cZRXEntFW4lzlMCz5Q7falNqNXn/q2BPT1GO123BlN
	wKyO5NaG1gA+Bn08XoIS9BctIbOG0wJb/bGT7kkTekF7l8xDZ/UHsU/an2de2G4WPUCCa0xWMF3
	sQSQ4NUBTwYvaZsFiHRDXWn1OnWvHGpDZq+z8OhlWMdU77pgK/0IkTjgs7hZromi+pvsEdDlS4D
	xao5eA6psUomrHQVdrX6/RTmyFX7spjaFfhLw=
X-Received: by 2002:a05:6102:4a83:b0:610:5b9:dde6 with SMTP id ada2fe7eead31-6313e95940emr2510652137.6.1778271745777;
        Fri, 08 May 2026 13:22:25 -0700 (PDT)
X-Received: by 2002:a05:6102:4a83:b0:610:5b9:dde6 with SMTP id ada2fe7eead31-6313e95940emr2510629137.6.1778271745340;
        Fri, 08 May 2026 13:22:25 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a8b3e75c31sm263763e87.18.2026.05.08.13.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 13:22:23 -0700 (PDT)
Date: Fri, 8 May 2026 23:22:21 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
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
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 08/14] media: iris: Rename clock and power domain
 macros to use vcodec prefix
Message-ID: <6hr42ins65rf6ftdmme5lok6ham67piz3343kdwxaff2acktcz@oipdhket32og>
References: <20260509-glymur-v5-0-7fbb340c5dbd@oss.qualcomm.com>
 <20260509-glymur-v5-8-7fbb340c5dbd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260509-glymur-v5-8-7fbb340c5dbd@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDIwMSBTYWx0ZWRfX3Ou6jKugekes
 UzR+oWAJv2c1upqRNJXpIomg0VrkwAySDOEkD9XRgzTeJ1BY3h61cTiTx2Vz/cKb87gNTfkgHAu
 pGU4t5c5zW5uzGtBPpIqOa6Ot1oswvAVuQphY4ITe9M5foxDo9+bNXcf+kK/ATeGmfA1By3ke98
 qM+mHCKcsiYfBQd8fZVYz96enP7svg1VcAenSjMEk3xqGy0bZZW9M6GK0ZMJFk60aK9/l0RyBni
 1GRX2YWjLigS/sYvkV8EJK92JzErq6+tAhDfXs+q128WlAvoccdsGFxml+oK05SVhv2CZ+Fg6mS
 nV7KnbYWH9CmF1ZxR29xSwva90JgZOYNqSZYz7oApu7Mwvw5F0Fy9dkGLdhp4yB8eYm1v766UNL
 3LvszEfSns6O12MvDavVXShODTMvFE7IQ5hcOcCQadgAAA06iQTqC3eaZ/9T7qxqjVGxvBNuBCO
 iccYyrgktWAu9NaBpmw==
X-Authority-Analysis: v=2.4 cv=BsKtB4X5 c=1 sm=1 tr=0 ts=69fe4602 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=z21jRD9xLDxBhwdHImoA:9 a=CjuIK1q_8ugA:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-GUID: PmLYjruNVHOggfh3PFVkUmn1R-1Qq7I3
X-Proofpoint-ORIG-GUID: PmLYjruNVHOggfh3PFVkUmn1R-1Qq7I3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080201

On Sat, May 09, 2026 at 12:29:57AM +0530, Vishnu Reddy wrote:
> The current clock and power domain enum names are too generic. Rename
> them with a vcodec prefix to make the names more meaningful and to easily
> accommodate vcodec1 enums for the secondary core for glymur platform.
> 
> No functional changes intended.
> 
> Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> ---
>  .../platform/qcom/iris/iris_platform_common.h      | 12 ++++----
>  .../media/platform/qcom/iris/iris_platform_gen1.c  |  6 ++--
>  .../media/platform/qcom/iris/iris_platform_gen2.c  |  6 ++--
>  .../platform/qcom/iris/iris_platform_sc7280.h      | 10 +++----
>  .../platform/qcom/iris/iris_platform_sm8750.h      | 12 ++++----
>  drivers/media/platform/qcom/iris/iris_vpu3x.c      | 21 +++++++-------
>  drivers/media/platform/qcom/iris/iris_vpu4x.c      | 30 +++++++++++---------
>  drivers/media/platform/qcom/iris/iris_vpu_common.c | 33 +++++++++++-----------
>  8 files changed, 67 insertions(+), 63 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
> index 55ff6137d9a9..30e9d4d288c6 100644
> --- a/drivers/media/platform/qcom/iris/iris_platform_common.h
> +++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
> @@ -49,14 +49,14 @@ extern const struct iris_platform_data sm8650_data;
>  extern const struct iris_platform_data sm8750_data;
>  
>  enum platform_clk_type {
> -	IRIS_AXI_CLK, /* AXI0 in case of platforms with multiple AXI clocks */
> +	IRIS_AXI_VCODEC_CLK,
>  	IRIS_CTRL_CLK,
>  	IRIS_AHB_CLK,
> -	IRIS_HW_CLK,
> -	IRIS_HW_AHB_CLK,
> -	IRIS_AXI1_CLK,
> +	IRIS_VCODEC_CLK,
> +	IRIS_VCODEC_AHB_CLK,
> +	IRIS_AXI_CTRL_CLK,

Why AXI_CTRL is better than AXI1?

>  	IRIS_CTRL_FREERUN_CLK,
> -	IRIS_HW_FREERUN_CLK,
> +	IRIS_VCODEC_FREERUN_CLK,

Can we at least group them too?

>  	IRIS_BSE_HW_CLK,

Is BSE a core or a codec clock?

>  	IRIS_VPP0_HW_CLK,
>  	IRIS_VPP1_HW_CLK,
> @@ -206,7 +206,7 @@ struct icc_vote_data {
>  
>  enum platform_pm_domain_type {
>  	IRIS_CTRL_POWER_DOMAIN,
> -	IRIS_HW_POWER_DOMAIN,
> +	IRIS_VCODEC_POWER_DOMAIN,
>  	IRIS_VPP0_HW_POWER_DOMAIN,
>  	IRIS_VPP1_HW_POWER_DOMAIN,
>  	IRIS_APV_HW_POWER_DOMAIN,

-- 
With best wishes
Dmitry
