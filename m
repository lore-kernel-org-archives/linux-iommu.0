Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E65541D4DE
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 22:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783376614; cv=none; b=JNAV/A1kcSlSBxk2uDSnV+JmjZflo0pdEOVLBGWV793LXpHRH6v72VOq3f7jin65+lPEwlcy7ktUYvMiqHR13xlo/SaviT681ePQ4tSMBcQw4Xiq8MHuKItn02EEf6QmfJAe0X3LGE4eOTacp360hWCIlNaA1JmggO+cLVmIUDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783376614; c=relaxed/simple;
	bh=an1W5Mo0/xOtBBJU+PkEQmauIy3QAIV1aElRv70z4cY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YdRrUyuzGb6a80NgNk575klBWU5q2DO6In7k+FGkRYPyHMuTZwBgJ6N32VaGYKS5MzAMs9im7UYzSmexQrZCdh2AKGnDzht+bov2e4CAxp7uJPkPJWk4dKO/SSZwq5thGO+HDgkoN97cc2eeSqQAUKbIEC+TggvdWtLyBVirjsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cgSK9Zar; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=B/YffwBr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cgSK9Zar";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="B/YffwBr"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666KE89a1654887
	for <iommu@lists.linux.dev>; Mon, 6 Jul 2026 22:23:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=WaWa4MGfpSWu+L1vhHqpxj3K
	PWIdAgUllBsZqFOfmBc=; b=cgSK9ZaruPNrvWg45rTPSYJSJ8Dc3RHumZCRnjOK
	NWnu9BNkdVFvmhjtJE0lr2KMhV3K3FS2H3UWrrlOes/jZbpTWoVSK+7CQE+ZkEyB
	X9FuO7DgCt79QhhUiDI63AEYK6YH0y3ZIBhByuw8a1S/16ieeFh9DvJ5FmAnBbdX
	8NaX9xNzjALX25XL+rQWFDXRcOTnvPnOW+8h3NymVxY6mDYsgBxJ+8MpdOn1/mzZ
	yP7+iktuSg45691PNUAl7KPBHod6Ija6bHExpwZHYu5AcHFH/vMQBv1NQlXiWO+f
	bNKRCpazyauYqKT5BRdYbUg53iatMT0J1ArsC62QEY1oHw==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f89qpk7nk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 22:23:27 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-7383a52d9beso3436007137.2
        for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 15:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783376607; x=1783981407; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WaWa4MGfpSWu+L1vhHqpxj3KPWIdAgUllBsZqFOfmBc=;
        b=B/YffwBrccQQlP0m3N+pbQvu+ZYmuEXoVZQtiFMCq0C47g6ZAE91cH2qfTbqoiEh84
         HhM7+hqI7jGGpYSnEIwXRLw0hrojrMkcCqKTHrEAp5mBY7Osu4Vl/b8QTeZqtKFurFfS
         pu0VfHJCxsEg9fZ4XjhYAVgfL0Ub7PPSrGLDjXzlpTfwo/8ufhKkypOA4A09BD8q/8Wl
         fgqXpLW5EsQdVYlxhRMONokoP5eB5d/KYyoQn9PdFc6KKM3MhcudSMTVsy0B9NT0Xjrt
         bbhCQbIq1x6wDY0OpYULC0xRuNK0McsD+BHAAdwu1dH6Ne6UnEv23AqLcxqCgDsFx3Sp
         lwZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783376607; x=1783981407;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WaWa4MGfpSWu+L1vhHqpxj3KPWIdAgUllBsZqFOfmBc=;
        b=FuJHVwxvZ0+t9ZfKuC6TISPfRGBP82JqaTrSaiw2M+7f+8YrYPqDgjeZHJONXTNRm6
         XtBWhukBpGORnK8pD12KwP3CfFFAT/THcvrrmzw8ShqZFDjLamJo26PL4SE/0TwLvbzV
         mkMBU80k6hI0I7l2FK/MnQmuzDTM6yW7Ee4lRoGbAxQbfbJFXcbyMtjbquuJSyXVCa+G
         ZTWmWAS/2OVZddA3So9bIuDl9GmQ4bziPdVJav2XXrOk2xmYrx/s2Bl6U1SjZtKI+ZEp
         3o9RdqCinr7TmLQ7UteReymYj3pJfC2HIyIi9to/eqBINvAIKPGROfdZPEX8/7gW4Iiy
         TA+A==
X-Forwarded-Encrypted: i=1; AHgh+Ro2NSUkxVunN7jtPE/WmpiMNfIiaCfz6eR0I7Mj8qaja+YvC9+Dn8MphfUN4Hgu72xkRL0N7Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz+HSiF+LtceXmjvuuuFeK22tbzNL+579WGY7daWlQkLmTG3Y7v
	ZVKSPma+pc6fCdLuKH4H9Awg6oDkxw6PFJX2yyDjGHLAE41jaYmUbTU/pcTl0OicexhhWlwl4j8
	lLI0nW8YA+UoMV0Ja20UqNlYw1Mi+shA9FxYHh6Ihq9f16BYwMQpEQv4Yp5LJ2SSVMA==
X-Gm-Gg: AfdE7ck42s3d30f43nmoD7N89TtzhZmO+xoFcca/kORSj3qMe466RdlxZRh1lVynB6R
	6auUxOm1RClBUCmrXp7mJPL4M6JPVHZ/HJtaave9X+HCrWREe6zrFZ48dAa9Gnh33WLUa7ALY3U
	d+CySfUj0VLJB3nAC8n7szuPglZDVhRtz7d931RZLXnHTzg1j8+Q5/q/Li6y1RY0LsvOXAGR1hO
	KpLdFSwBVMguBmRGiVhoSk4NBjZ9pERHU+2fstzOm72eWeOGbV8WyVgPscbC9qyLO/rcmESspwu
	dk5sKwObHTgFCKzv1DsDJ565Vrw14PWNDSoMxItMi5qo54Fgwm2ysrqrsb0PGnOi12CqEkKesPq
	P0isU9mFQcLjqjgWutOK4zJ++PTanzTSv8jelxym/djR+ALHlerNLF5M21ZMHyvytjKE8mGwAMA
	bmhW4enCX/T/eaG/gjHEdlz0pf
X-Received: by 2002:a05:6102:5091:b0:736:e4c0:cddf with SMTP id ada2fe7eead31-744b7b30a40mr1244158137.6.1783376606599;
        Mon, 06 Jul 2026 15:23:26 -0700 (PDT)
X-Received: by 2002:a05:6102:5091:b0:736:e4c0:cddf with SMTP id ada2fe7eead31-744b7b30a40mr1244139137.6.1783376605954;
        Mon, 06 Jul 2026 15:23:25 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aed13839bbsm3177862e87.35.2026.07.06.15.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 15:23:24 -0700 (PDT)
Date: Tue, 7 Jul 2026 01:23:22 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Subject: Re: [PATCH 8/8] arm64: dts: qcom: eliza-mtp: Enable Adreno A722 GPU
Message-ID: <clfy5lvz7vm3ogw7pvyyidiujqcjxftx55p67szwgc6ivsq6r6@xrrcbfdkqkjo>
References: <20260705-eliza-gpu-v1-0-c9f1354dbd29@oss.qualcomm.com>
 <20260705-eliza-gpu-v1-8-c9f1354dbd29@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260705-eliza-gpu-v1-8-c9f1354dbd29@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=c6qbhx9l c=1 sm=1 tr=0 ts=6a4c2adf cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=UQAiW8fk4jwks4S4FoYA:9 a=CjuIK1q_8ugA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-ORIG-GUID: JlAs064cKBID6rRK-Vu1RCnrY9fBaFiO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyNiBTYWx0ZWRfXyyVJU7JcpaQn
 GQMzJfHJBcrybHquCmkXEOJTiIhXsYYXVOy+FydJOWv7OwRpAR9mFjtKjkAHOGACsOPflgx0F1T
 239l2A5pGaNLApAM2O3ukYVomZZRf/4A4bcLpzCNIKsyRWC2FfgFEQjqiwV5BmPeRFHkHr9SgsV
 vaR5hR290dc2OC+3kCubjssGRdjTeINeK1LDPnIrRTs9mCuJ+Rc7L8HqrpvJA/6F0luMI2Nba65
 ajiShrtldSbRC139io+t81Bxs4N2/K1Pq9w4L5uyrnQ09aa5Q18tDMvajWKPKIuga0rYFFpTIP4
 jZeUdtlVMhns8awji6dso1Z1QzEpL/wgeSDf7VL1xhqeJNSSvDc2PMIQ3wK4DFsG/Q8TayTQcKK
 /+0hXM1Gi7dW4cXOpm531h/VrDVYb1GIDFb9VdEfSFKFr+odK9mDTQnnZgd8iJdImdqedR/NRNw
 d6rMtMAG18U8a/8eVNQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyNiBTYWx0ZWRfX88S3DOeT8b74
 PODuWgYUld7oA44VM0qnWnI8SKQxMrmp4a6sVdyKcmlv8gSSnGLrt4b/oTN+O0pmcA3VKPVyhaR
 YT7tZP8ygzgncXvOd7Qt8lVq8CFLBgo=
X-Proofpoint-GUID: JlAs064cKBID6rRK-Vu1RCnrY9fBaFiO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060226

On Sun, Jul 05, 2026 at 01:44:23PM +0530, Akhil P Oommen wrote:
> From: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
> 
> Enable the Adreno A722 GPU on the Eliza MTP board and provide the zap
> shader firmware path.
> 
> Signed-off-by: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/eliza-mtp.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/eliza-mtp.dts b/arch/arm64/boot/dts/qcom/eliza-mtp.dts
> index 1374afd9d14e..b280d8e845b1 100644
> --- a/arch/arm64/boot/dts/qcom/eliza-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/eliza-mtp.dts
> @@ -417,6 +417,14 @@ vreg_l7k: ldo7 {
>  	};
>  };
>  
> +&gpu {
> +	status = "okay";
> +};
> +
> +&gpu_zap_shader {
> +	firmware-name = "qcom/eliza/gen70e00_zap.mbn";

Should it be gen71700_zap.mbn?

> +};
> +
>  &mdss {
>  	status = "okay";
>  };
> 
> -- 
> 2.54.0
> 

-- 
With best wishes
Dmitry
