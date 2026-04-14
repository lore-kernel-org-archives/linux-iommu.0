Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0354836C9DF
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 06:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776148418; cv=none; b=fqlL/8a1b9a7M7UIpN0x5RettnnGUyIH2Up4T1nwOPIoNOWLME2Ps9KymzW/4F2U/T1O1wXW2L/XqDBIvf7RiqhFeLLgIxZMXI0UZ2tv/LlRIza+8CeA1N5+UFyaNkRpoZeBcVb9papFLkOEt8F5dDq0q5+J0zJZ+XD4DDMi7Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776148418; c=relaxed/simple;
	bh=y1K+LaRyhz93aZWp+gZtDUUqtVcO3IOvlsscpo93Plo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FvfbNANRJ+KiofvQaicWU2Z+uMiYOvUXKjh4gwpW+3nF7O5TuS5GtxejYPIK1SpEXTNjiF3f+pcEnr7vQ4Qkg7bAqw2bdYpFARqWuZd4bKIw8ONjQxeA5Gh36IxNFW16cF0hvOuRRLtuTgezIoporhCALel9hsxtZeX6GIyjmcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AhAqGbNh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RPRpzkcK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AhAqGbNh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RPRpzkcK"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63E6RITM280834
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 06:33:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=kiBHEicgBcwVfHpBg7CCiYin
	nWHa6rAo+LKmoWMOeFo=; b=AhAqGbNhMZ2GwitpEGbeVgi2jnydxT42avO5ZwSS
	7rmpJQZwelKyMxwIYvfAlS3rs+EhBTn0wtmQDGlfofkzNtr2BLiv6ybCCwlWO34b
	gsyh0atIipinzGL45rw728cAlYgCtq3y68tOqDNVJFT2ukTiElgwHktj5FPrC8m2
	5p6HSvoSI2e0C5enq/EZ2kwkFiqBJ4jTV9WNcO5F2ptbkpIpZ9lf29pQDwJ8LtZU
	cp7TUp+w+gYq5H6PemUan4qtXZ8ZdrdGsDTZ7UcbuOagXjBclRRC1qZAXKa096OS
	IkS23r4ig4wpoOrMJc1LLhsPxSgqwevbXRbmo2TcbPtE9Q==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh86vhbqc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 06:33:35 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-82a77f807e4so5365585b3a.3
        for <iommu@lists.linux.dev>; Mon, 13 Apr 2026 23:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776148415; x=1776753215; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kiBHEicgBcwVfHpBg7CCiYinnWHa6rAo+LKmoWMOeFo=;
        b=RPRpzkcKsCyAvsBfnt0btfrGaWyDinEI3UluQIDASBmxhtG+AH+866TjlJtTXTlRZk
         Gdq7ufmUmpUUKXRxeWzOrJs7PjaC6fbdvHf2E5chxjfYlAfa97FbWn2T51dYSqWTzI3p
         D95ci3CcO96GBET2UbWMYBlf3kpc95A+vij+9/rcVtdBDke5z2YNLtr+pM0tR6K5cm7m
         uT9Lzo2uiMtStgXeX6gOGAUXLNnXMYYUL/QM7F30GcH4negoDSA23qSoIGZri9DhEAaT
         rKkNcTw5i3WQr5NFlWUO0u3N7Yybd6yPlvtpqh/7V/07h3O1EU8y5KvHDqEhq7sltRSi
         /Q6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776148415; x=1776753215;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kiBHEicgBcwVfHpBg7CCiYinnWHa6rAo+LKmoWMOeFo=;
        b=IwppzySD9ghBOA6Gzzw9Ggx4Bn7+4Ab8dgzdoRnHWBkIkZDjCYHx+uyq4JegvJmuZm
         M+zZjv72NHqgqNf9cD2OAjCr3wWwGYMTz+vwmhOaAGT/R7xE8L8WTo6LGKTwWeQMv1WW
         sgL9GoDJFA/Utqav+ielun9dPEcg/mrKJD6RTgJqdS4YuA9u09PyR7eCko+nvikXfMd2
         VrymiDGvsv8SG6RWfrzhIqUGk4oIdbeynpPz+FutHKmZhNxFOtgG6CFp+Aphh7a+reqV
         Kq4BRkRfwZ58sOT4vUmZg0mwUufyITF7jEX5pTDHOpZ+1bqX9xbmCOf6ox3tmq3wglC/
         0pKw==
X-Forwarded-Encrypted: i=1; AFNElJ/HXB5REaBsm7UhqFy78Yxu23V9vitJjowTtZBXqvy2AtygWkE8vUTKyLefkr+lXbl+LiN4Mg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz4iq2inMr7oZMiztI9CCB9Dx5qS8nJIcpztYO3tXH0GwUMwXYh
	NlopbXH1JjrHbSiurrsGP3G+6133hJwptwlegCyhTv3UAQn778iPJxWmkmKL2hiVbjKSngYhTOr
	4jyMTStRuHBsyFXzXLc+nULktq+v49Qgu5+oV3JLaW03H5P56DvOoyK+WtQ==
X-Gm-Gg: AeBDiesYD6FPJykXYjROkJv7QtXbx5SjvPBIPybe4Z2icV5Dp7D/hp4dI+j4b02EDWC
	MKzUtIwZaCBaUwEDJn28MgWekgO7vu1Q9j5Uroya07MYAdcR7YOtgrsFw/JHXzoZ8CtMTq5MBtU
	FQhzGL957Hu5Q3zhwg37AGpvnNzjGogSHrgmi73VlaM95waEsZYFo+EVqIOw3kqOT12hDuFEXkz
	fkvtSoid/zhUDivPxyi7yXLx7qrXWHo2072plktOY8yR61FGCUEgfkApUEoCh93UY4+/Ef3Xfx2
	0HS1N3iecF9QkIW0Kluhh1EvhwIG6pBHkZSuGkGd5pJnA4muc2sSrEe+IZor/lx9N66yoJiLvFx
	5hidWdhN7zBsNlSW49AHc87zq3R7aMKil1G6V1a4eaa9A8BuY
X-Received: by 2002:a05:6a00:2985:b0:827:4372:dd15 with SMTP id d2e1a72fcca58-82f0c2c2096mr15363521b3a.40.1776148414795;
        Mon, 13 Apr 2026 23:33:34 -0700 (PDT)
X-Received: by 2002:a05:6a00:2985:b0:827:4372:dd15 with SMTP id d2e1a72fcca58-82f0c2c2096mr15363469b3a.40.1776148414225;
        Mon, 13 Apr 2026 23:33:34 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c377318sm12699558b3a.26.2026.04.13.23.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 23:33:33 -0700 (PDT)
Date: Tue, 14 Apr 2026 12:03:25 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        stable@vger.kernel.org
Subject: Re: [PATCH 06/11] media: iris: Fix VM count passed to firmware
Message-ID: <20260414063325.f3yag6gnmaysddkp@hu-mojha-hyd.qualcomm.com>
References: <20260414-glymur-v1-0-7d3d1cf57b16@oss.qualcomm.com>
 <20260414-glymur-v1-6-7d3d1cf57b16@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414-glymur-v1-6-7d3d1cf57b16@oss.qualcomm.com>
X-Proofpoint-GUID: N2dANlmlevAbAyatyQyPhhZCu_BZjjAU
X-Authority-Analysis: v=2.4 cv=cffiaHDM c=1 sm=1 tr=0 ts=69dddfbf cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=oTq01oph0ifE-MoszjAA:9 a=CjuIK1q_8ugA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: N2dANlmlevAbAyatyQyPhhZCu_BZjjAU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDA1OSBTYWx0ZWRfXzpaXgISQFbNW
 MYa8pXenIUQHdpRtLvCSWcBU/RKPpYg22Wz4FyWnj3tVG/0tOPHnbzccvNOdlxN8WMy36kOToEq
 psX0A5iZ2Z8O4TNV5yrC/bEpzq4M67kPcOb+A1AetUlxmnzPKXWa3b1Vo4uUi2p8SZmcfolkmQm
 pV/LgWlvvC9Hd+8UKQQpSYdcynD8TsQ5dCHMSfNEf4xttocAIQFSiV/u007LgOiFg1jtN9GM1+9
 aPgOkm9BhFygqBzvGpq4C66QK4TRAYpAJxefg4Ii9NdWiqqAhjKzDqLDpxHVpddjwqkKne0MFjT
 Ri4Cn1PS+ScLWczv44Q6s5sIxRMtROHhZ9pf6OY3HQeCK7UNi93l7hrPuMv4LWrHt61FQ26RGMX
 kXV5QsvNzARpYhVudVBkRkiNq3pZfK4PhlRK3RqJWfLR5S9tibBkFpJgnqyHuVoJcDqlmjudZwN
 KByAICyL/FXr/skDDWw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140059

On Tue, Apr 14, 2026 at 10:30:02AM +0530, Vishnu Reddy wrote:
> On Glymur, firmware interprets the value written to CPU_CS_SCIACMDARG3 as
> the number of virtual machines (VMs) and internally adds 1 to it. Writing
> 1 causes firmware to treat it as 2 VMs. Since only one VM is required,
> remove this write to leave the register at its reset value of 0. This does
> not affect other platforms as only Glymur firmware uses this register,
> earlier platform firmwares ignore it.
> 
> Fixes: abf5bac63f68a ("media: iris: implement the boot sequence of the firmware")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>

If this is a fix, should be the first patch in the series., so that it
can be applied independently.

> ---
>  drivers/media/platform/qcom/iris/iris_vpu_common.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.c b/drivers/media/platform/qcom/iris/iris_vpu_common.c
> index 548e5f1727fd..bfd1e762c38e 100644
> --- a/drivers/media/platform/qcom/iris/iris_vpu_common.c
> +++ b/drivers/media/platform/qcom/iris/iris_vpu_common.c
> @@ -78,7 +78,6 @@ int iris_vpu_boot_firmware(struct iris_core *core)
>  	iris_vpu_setup_ucregion_memory_map(core);
>  
>  	writel(ctrl_init, core->reg_base + CTRL_INIT);
> -	writel(0x1, core->reg_base + CPU_CS_SCIACMDARG3);
>  
>  	while (!ctrl_status && count < max_tries) {
>  		ctrl_status = readl(core->reg_base + CTRL_STATUS);
> 
> -- 
> 2.34.1
> 

-- 
-Mukesh Ojha
