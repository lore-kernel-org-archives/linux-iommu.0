Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEC5175A75
	for <iommu@lists.linux.dev>; Sun,  7 Jun 2026 21:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780868846; cv=none; b=AGnT1QqZFY/qaBcgF1mlp5QhXgIOuPb3al3jLo2cYQ7j8CqpCIhrJ2f8Z4Ehor7ko8vP3PuPdjXtAxnqYfrSR5YP5sHXAR2ngVClpn8VnZGwCksMTT9LOiWS4lZ6x25yemFEMKbym8GUt5ikpIr9dPmmKqcwcS6SSFbo2GkqeXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780868846; c=relaxed/simple;
	bh=o8gh3GBhsqBBq+L5KMKWxrXgCRkn6VkVN4YlzVqZycc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OL2czXQrcdWUS5qS45xSX6pnfwIpxD9Zi21Ffjhhcl3t1Mlug5mhqdTfHs9bnq4p4jC6L22zNX9yeu0EvBMhqs1Lz8wH+ZLzi99gAeNPzp7gX39F/J0l6XX+zl4bxVRFq/giSTMlar+Pz2j/1IPaiGoK47VHjxa5cIBbcn3pGkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ieHjw2JL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LWvaB0Rg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ieHjw2JL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LWvaB0Rg"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 657JFmid876142
	for <iommu@lists.linux.dev>; Sun, 7 Jun 2026 21:47:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=51lBbpCYJCXT+JKNHVZsiJOe
	yNd6G5pwkWCrK7BFzFg=; b=ieHjw2JLCF7b2hmy7afqVeegZ8cLsKdSOQiTLBCd
	F0thDaa7HptpA4xF/pWHXIwwIkfyM1PgsHZ0LKX9d4BpeRf/i0KZ6JN/InLS//04
	LeGuET1Uez59k1BQQ8naj5WJKqxnv/UYP7GERUGftsPPR+1fT9yhpoZ8uKTk1p5I
	wvYLR5Wrj3/w0o6URJ6yn7wwQK+rU9ajS3cIZzXMwXYmeIjLmxF7rOWmQOGFQUWV
	FU3TiSggsATXc6dq0VhWpYe3JMfXCxEyLQk3JEymPkBMHXnX/Y2nHZNvK48VkK8J
	duCyP0fM7sQ3Abxi8gb0tO4pzxMfDXFwLobxZDnHwjfZ7g==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emcqgvjag-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 07 Jun 2026 21:47:24 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5b26cdde6c5so907136e0c.3
        for <iommu@lists.linux.dev>; Sun, 07 Jun 2026 14:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780868844; x=1781473644; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=51lBbpCYJCXT+JKNHVZsiJOeyNd6G5pwkWCrK7BFzFg=;
        b=LWvaB0RgynuMAeEP8/e/4YhIrDYvGhCxN7wS7Wx+HXnvpR2Ur9jZnwHwsF0xKGPLRX
         K6eGmzQZbFWZjgyppXXNhoXCP745ETRWf13QxlWOKQSxlWqWODKK8RbLncWQEhAsO5qJ
         DSTIVON5vmIzx0ygppcvmwa3enQvzll6+TQlQFfflgfZKeIsAH/n2w8nx4VOyUuA0J5X
         iKE79xIroNTbJRh436KCAbQOQUYWH7CHBZF2E7iTne7Y+TkKIZTXR9qWv1XIyxbsqAuK
         HHodbVDr7VKdohsKW98WLh0yZ0YsvJ8DYUvxkVPLFOmE51RlLVoiL/k05voN3bJsPvcp
         HWhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780868844; x=1781473644;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=51lBbpCYJCXT+JKNHVZsiJOeyNd6G5pwkWCrK7BFzFg=;
        b=g1/57VosWz2KIvXR50u3GRbSfsdKj3jhd/kl3499AiybTx4u6vtID9Dmg3FDU+FmEG
         vzcT5xBvbCi3DT6MUqTWz9gsglBaQi0qdEc59EJKesnQ4qjp5A4Z52ZVC8fTI9+56OwZ
         kuPVH/Spgh6cYNGYrgsVzdCCYZHDCoj4In5J93P41i8KhcqEUNpksnjVPgO9JEXjdGFf
         li80kH9g9XeGYMsgrp5baySU7m1HHG1Ha27K2Vrtu7jc4MA1oPD8i7Ah2q8Wl4CeHS9D
         qA7fxSTMYjYQMuw+Z2V4cn0Jz618r0HElw3NWAIi7ZOrksemUtIUhyMGdkliJOON4ki3
         CoKQ==
X-Forwarded-Encrypted: i=1; AFNElJ+cj5ILXGma2svzn9Vz4I8giwrr/na1eAAUX3Cnie7A5IuLLMgWc9Cf1WRlOZmaXhU24cANsg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwxhSjW1yXmf/yRzR+5Icm0LsYajYh5+nR/61GYOydqEmt9rzvz
	s2D02uUM1uaxG8mcquZQ9EwMU92kQruKmwVYJqDYJ8YYiJvSxBx7XkUmPCMTfwrPB2YANABjZsj
	yhZAZPU1NZVpbH65OtAK44Fc6D2lWmnsKcezgtoGNwyncbgZmoBRW2Y/URw==
X-Gm-Gg: Acq92OEHfcJyHuu5re0st70YW8irvfOow4b87F2vjri2/B9wCd51l2i6Ayvy+S8aE/X
	2YSiLUClZcBJpV8OO1AF8DpNH33ZwIeh+jmsFSjQxaQmVizMMPAtsHAR8HHm1HNZM7uXM/CskrV
	KnTdRilObt+Fh6isLAnQOlT6tTsGOrJiQ/cldd03pmaHhn6Zgn6ES+yb6p1EJfL6XFdTsPKszhX
	xWZNWTWYy/ptADsZ1JLdFUdGy9peDlydQI+jHXMTXyfMwhxAbyUtUYCgf/cM8OtVorpx9GSOrFt
	MIZUwfBcosZhPUv+ltzuXvJ7Xq/D1v9u5uGBMXuSZbNmZ/OUgAbk9vSdhZXKPza83NVam6mOGoH
	ScUVHZLFZ1cGGTxCOHzK/zlH3ZraenY5R8hnOQbjX2ziGiFfCzwpYTigMvqnMZBzn04hzCrsFl9
	ZfzzbJ/nTyOwnE5CUjJYIU8B4SE9l93D0TklCmbWVfPvhwNg==
X-Received: by 2002:a05:6122:3d12:b0:588:2fc:f169 with SMTP id 71dfb90a1353d-5ac53c970c2mr6805019e0c.13.1780868843846;
        Sun, 07 Jun 2026 14:47:23 -0700 (PDT)
X-Received: by 2002:a05:6122:3d12:b0:588:2fc:f169 with SMTP id 71dfb90a1353d-5ac53c970c2mr6805004e0c.13.1780868843454;
        Sun, 07 Jun 2026 14:47:23 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b8ed659sm3341110e87.12.2026.06.07.14.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 14:47:22 -0700 (PDT)
Date: Mon, 8 Jun 2026 00:47:18 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 07/12] media: iris: Add power sequence for glymur
Message-ID: <g5fpxwtlajz4p6gn55pjtgb2czjkbjyjlii2zkznle6lbtdgzb@zsiafc57gaco>
References: <20260603-glymur-v7-0-afaa55d11fe0@oss.qualcomm.com>
 <20260603-glymur-v7-7-afaa55d11fe0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603-glymur-v7-7-afaa55d11fe0@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=dJGWXuZb c=1 sm=1 tr=0 ts=6a25e6ec cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=xfsqrxKm7_4DSI4w90sA:9 a=CjuIK1q_8ugA:10 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-GUID: L-Io7KxF8AvY55HK-dM5JpHwWizkHz2j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA3MDIxOSBTYWx0ZWRfXzWY9742qWkTy
 S0lcck89vd5mVO4qjypc37/Fj9VtgjtJG6fsJ4CE7KiOIfBpoi1i/PNb8db5rIiTCuI1W/pbVzo
 laoRlURwiqhpxka5NdyhK8n8Cl9zoi7jya4404iqSOF6R4cwD0MKIQOGiPImy1bV/5y35l6+0rr
 lDP2ckPV4R5t/Gpx3G5cy5YIt8nXCd5MyZ3kp8PNuTSgCSpqLtwy07LUIzxGjMDOS/CLs+eLXUO
 V6q0aOe38Sv8Pxif4Z77wHWTeHwey/TlVSGTK2lxLm1Exaiq6S6lCI0vvzyo+xgTv4BATTJ7WPV
 9FwfQui8x52V59WTR57/JVhrpfIJ5YPr6970NKt7ZNVB6t/Evl6rOnYpt41/jM1Y7LsaE6TCm/G
 nTDQ8RB2EiiM1uvMDiL0ryEmWgPuQe3XS1HsYFjhoLfa3oD4tpO0KO7K76en28tJP/Q70pXxLG5
 GvVvtSA8kvN79/Q31NA==
X-Proofpoint-ORIG-GUID: L-Io7KxF8AvY55HK-dM5JpHwWizkHz2j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-07_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606070219

On Wed, Jun 03, 2026 at 07:48:45PM +0530, Vishnu Reddy wrote:
> Glymur platform has two video codec cores: vcodec0 and vcodec1.
> 
> Both cores share a common clock source (video_cc_mvs0_clk_src) and the
> same power rails. The clock dividers between the source and the branch
> clocks are fixed. So when both cores are running, the source clock always
> runs at the highest frequency requested by either core.
> 
> Since both cores share the same power rails, the power corner cannot be
> voted independently. Scaling one core's power corner up or down would
> directly affect the other, leading to under or over-voting.
> 
> For these reasons, both cores should voted the clock and power rail must
> be based on the workload of both cores.
> 
> Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> ---
>  drivers/media/platform/qcom/iris/iris_vpu3x.c      | 111 ++++++++++++++++++++-
>  drivers/media/platform/qcom/iris/iris_vpu_common.h |   1 +
>  .../platform/qcom/iris/iris_vpu_register_defines.h |  10 ++
>  3 files changed, 117 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_vpu3x.c b/drivers/media/platform/qcom/iris/iris_vpu3x.c
> index 7cda94601555..f07eaf4b3be2 100644
> --- a/drivers/media/platform/qcom/iris/iris_vpu3x.c
> +++ b/drivers/media/platform/qcom/iris/iris_vpu3x.c
> @@ -17,14 +17,14 @@
>  #define NOC_HALT				BIT(0)
>  #define AON_WRAPPER_SPARE			(AON_BASE_OFFS + 0x28)
>  
> -static bool iris_vpu3x_hw_power_collapsed(struct iris_core *core)
> +static bool iris_vpu3x_hw_power_collapsed(struct iris_core *core, u32 pwr_status_bit)
>  {
>  	u32 value, pwr_status;
>  
>  	value = readl(core->reg_base + WRAPPER_CORE_POWER_STATUS);
> -	pwr_status = value & BIT(1);
> +	pwr_status = value & pwr_status_bit;
>  
> -	return pwr_status ? false : true;
> +	return !pwr_status;
>  }
>  
>  static void iris_vpu3_power_off_hardware(struct iris_core *core)
> @@ -32,7 +32,7 @@ static void iris_vpu3_power_off_hardware(struct iris_core *core)
>  	u32 reg_val = 0, value, i;
>  	int ret;
>  
> -	if (iris_vpu3x_hw_power_collapsed(core))
> +	if (iris_vpu3x_hw_power_collapsed(core, VCODEC0_POWER_STATUS))
>  		goto disable_power;
>  
>  	dev_err(core->dev, "video hw is power on\n");
> @@ -78,7 +78,7 @@ static void iris_vpu33_power_off_hardware(struct iris_core *core)
>  	u32 count = 0;
>  	int ret;
>  
> -	if (iris_vpu3x_hw_power_collapsed(core))
> +	if (iris_vpu3x_hw_power_collapsed(core, VCODEC0_POWER_STATUS))
>  		goto disable_power;
>  
>  	dev_err(core->dev, "video hw is power on\n");
> @@ -221,6 +221,98 @@ static void iris_vpu35_power_off_hw(struct iris_core *core)
>  	iris_vpu33_power_off_hardware(core);
>  }
>  
> +static void iris_vpu36_power_off_vcodec(struct iris_core *core, u32 core_id)
> +{
> +	u32 value, i;
> +	int ret;
> +
> +	if (iris_vpu3x_hw_power_collapsed(core,
> +					  core_id ? VCODEC1_POWER_STATUS : VCODEC0_POWER_STATUS))
> +		goto disable_power;
> +
> +	value = readl(core->reg_base + WRAPPER_CORE_CLOCK_CONFIG);
> +	if (value)
> +		writel(CORE_CLK_RUN, core->reg_base + WRAPPER_CORE_CLOCK_CONFIG);
> +
> +	for (i = 0; i < core->iris_platform_data->num_vpp_pipe; i++) {
> +		ret = readl_poll_timeout(core->reg_base + (core_id ? VCODEC1_SS_IDLE_STATUSN :
> +					 VCODEC_SS_IDLE_STATUSN) + 4 * i, value,
> +					 value & DMA_NOC_IDLE, 2000, 20000);

Unreadable. Extract register addresses to separate variables.

> +		if (ret)
> +			goto disable_power;
> +	}
> +
> +	writel(core_id ? REQ_VCODEC1_POWER_DOWN_PREP : REQ_POWER_DOWN_PREP,
> +	       core->reg_base + AON_WRAPPER_MVP_NOC_LPI_CONTROL);
> +	ret = readl_poll_timeout(core->reg_base + AON_WRAPPER_MVP_NOC_LPI_STATUS, value,
> +				 value & (core_id ? NOC_LPI_VCODEC1_STATUS_DONE :
> +				 NOC_LPI_STATUS_DONE), 2000, 20000);
> +	if (ret)
> +		goto disable_power;
> +
> +	writel(0, core->reg_base + AON_WRAPPER_MVP_NOC_LPI_CONTROL);
> +
> +	writel((core_id ? VCODEC1_BRIDGE_SW_RESET | VCODEC1_BRIDGE_HW_RESET_DISABLE :
> +	       CORE_BRIDGE_SW_RESET | CORE_BRIDGE_HW_RESET_DISABLE),
> +	       core->reg_base + CPU_CS_AHB_BRIDGE_SYNC_RESET);
> +	writel(core_id ? VCODEC1_BRIDGE_HW_RESET_DISABLE : CORE_BRIDGE_HW_RESET_DISABLE,
> +	       core->reg_base + CPU_CS_AHB_BRIDGE_SYNC_RESET);
> +	writel(0x0, core->reg_base + CPU_CS_AHB_BRIDGE_SYNC_RESET);
> +
> +disable_power:
> +	dev_pm_genpd_set_hwmode(core->vcodec[core_id].dev, false);
> +	iris_disable_power_domain_and_clocks(core, &core->vcodec[core_id]);
> +}
> +
> +static void iris_vpu36_power_off_hw(struct iris_core *core)
> +{
> +	u32 num_cores = max(core->iris_platform_data->num_cores, 1);

Can we trust the patch authors that VPU3.6 hardware data will have at
least 1 core?

> +	int i;
> +
> +	for (i = 0; i < num_cores; i++)
> +		iris_vpu36_power_off_vcodec(core, i);
> +}
> +
>  #define WRAPPER_DEBUG_BRIDGE_LPI_STATUS		(WRAPPER_BASE_OFFS + 0x58)
>  #define WRAPPER_IRIS_CPU_NOC_LPI_CONTROL	(WRAPPER_BASE_OFFS + 0x5C)

Lowercase hex.

>  #define REQ_POWER_DOWN_PREP			BIT(0)
> +#define REQ_VCODEC1_POWER_DOWN_PREP		BIT(1)
>  

-- 
With best wishes
Dmitry
