Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C083947AE
	for <iommu@lists.linux.dev>; Sat,  6 Jun 2026 12:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780748591; cv=none; b=kAWqG+eLhmUBIPCm12PDpmZKXeAvlkxmm7HagcHmonmGphOVtAXiA0gNRKh2CamWd1Q+d7wrxmRU7LVbyWwfCPZOAwyszua9Le3k90Z6nsVV6NdXb+pBlVlP+AuDusNljMtdTEKnLQ68TXcO9OiDdD2tfpw+kUN5a7U6dfjq5Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780748591; c=relaxed/simple;
	bh=IEDW3y4y/S1Dxq+eQ+GqKXMRpq4vjTkLsXm7j9tPZJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TV26G9e1IWpzC3TJGmscmmIaxMgXCi0kvSnGwjmRnv71JDuikYib6fVH61NtlThPq54773NnLMSwvFt+x8/DSzJbeVwuCJCo+bk88cfAAUmJYw3YE4yqQzZO8jwOBi2ur37sk3L1Mq3VgnBFfaQnU5eucMg9ju8NZYHjKky4Glo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WBmeTuPI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IwOBhNMe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WBmeTuPI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IwOBhNMe"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 656BDa6O1279187
	for <iommu@lists.linux.dev>; Sat, 6 Jun 2026 12:23:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=CACWQZmD4R6XLQ6GUpqLrmsN
	jTowQtAT8WsqwDHWPdg=; b=WBmeTuPIOwbj+d1qhz3dLCw/DxKcDzYN36fVQCa7
	MzqzyPGZ5yNuJvDk5V7qEnXnGW0mtIM33IIH6w0A80MLFDoP2KoMDxG/l07B6D6n
	NH10gHN7+BCOTTtMiI/B85/yLHwOeAKr68Q4KZF4NmrZD0wS2fI/5uP01yVK6l/x
	xm+ijz0lWyd0LYGdJHgtH9sMH6KVCa04fgsRQeWGOsor9btSqR4eLuP8qYVA4opQ
	iMj7pKTJIeyS+LW9wR3Tn2awb6DgOJ7+I0/POtGuYVOQ9QNoMujVAUB3zV/rEn7F
	9WcInIola8DuFHFAuMWEQlDy5jt1WYnSwrJICXSxLS7wKA==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emagr9acc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sat, 06 Jun 2026 12:23:09 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-963d7e5ac48so3271025241.1
        for <iommu@lists.linux.dev>; Sat, 06 Jun 2026 05:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780748589; x=1781353389; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CACWQZmD4R6XLQ6GUpqLrmsNjTowQtAT8WsqwDHWPdg=;
        b=IwOBhNMerB7xIG/7JgXbe3AbVLKy535PmG1IUdBM+N3oFO+3lEnN2nt47Xu8hQnCSg
         UNlWCxL/rfCSnnKLkE03ItGQKcrjNZSMtwyLQFE6PYdUWi8Io7UqBmNs5z5LZbbQKpiE
         j1bMZ9j/dcMr5mqe7tWhLpMsUQSNLRc3v6DFAvOpTaOjoELdys988woOxCFtGn4SLPbn
         8UbDI4nwnVyAr6FsovUY9kJ0JWvNjt54b6Od8UqsarybM21qnL7Zt3O/UPywI5zjzsKD
         jQWOjUbfiCU9MIJ+nlgFObF6OeLFeOBVOPFRbrblvvG4v3uN/+6ffjUNTaLjJfz0HXH/
         8K7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780748589; x=1781353389;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CACWQZmD4R6XLQ6GUpqLrmsNjTowQtAT8WsqwDHWPdg=;
        b=gWwu5qO3HI/1StfKXnUmwAzh7Xcef51RdOqPbwNhhHlMzgk2/CPjnqlNKcKK50XJaP
         MT22zXQgYHE/Eq4jqQV1M1Rn1QKPyPKZ6MjbTCEU0nncJ1XZDyoKZifqenDtf9E9qlsd
         NkYyiy3ZHonI3I++mfRXvL5rOosNqYd6y7BQFPUzvdDnEXTmjyriXNW+0B9GnA4AcFD3
         cXkz9RrXW1CS42MhuRT6yb3/ISgKaGTCdJ+OzLNZqIUlSeFxCGv2WCxHcdBpLo/xnoEF
         bkTA7Eb/H6qFF6Qy4JkA6Q8axpYnnLTfR/8W1FeUGdlL0zomvg1moBLoofMtwaY7ZSij
         AFTw==
X-Forwarded-Encrypted: i=1; AFNElJ/2V/XNVMXqSTs1QAvruiIkfJM4pugkCs2PgjkVVWE1m2Nl3IN064kJwDMWVmKFmg/rFo7bzQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwNk2M/R2xPlSVxWe0o8GAdr+YRkFseiVg0AACl1eoDZ3nsOaK3
	ZJs8ikL6qqiG7A7xiPqFGKPWdrrKf6OEnFkf2hnhLC7GsCqof8Yie6Z6O6UdTsjITJjla+4TxEg
	gtJ3efT5z2x4oCXB0zbsiscRDM/m+DKPKfPZVtfudg5nqAX5VPpwOdyAQPw==
X-Gm-Gg: Acq92OHSGBKrEKmaiYwEpZD1IFVgw1LaoRfGlUQTxuHhXSNN8mkiyOcS94cdgfXWtkY
	RLUZ35oERoQNaxs8x6e3wYzoX+oIuaoCOtt9SrJTFoUtb3GJYipwJraA5/7BpsDxS76CDNsZ7k4
	oFUrhKyKJO+4PPS+1SIF1sg5bVw4E4ivjDPFNcKhsb0YTiIwEzntGplBoNKmTDoa9WX14KIgGkb
	/J60AniyjBwaE13N2mmMLyGJIELCoCxcPAlWoGbOGPgddfR8P5kO5LsXhHwpoOHqjDMNJwvfBsK
	pAfyUgVV0fx4NYeb8pk0khddxTSX7fGYa+v0WH5NXDu+3pkessA/ZdkzmkReySdoMxZZtscjwfu
	5yPdDmGWqnDg0yjM9ONd9cJtzDwlB10vpwEimWPpwlEzuFI2LIkxscHFdBmmUC+J9J7oY3po6Fb
	++xxITCqZiepdwbQQkYKUD+t/ITtpgtbjAXyEcfG+6/dCBzA==
X-Received: by 2002:a05:6102:f14:b0:631:4c79:b1e8 with SMTP id ada2fe7eead31-6ff0afefe3dmr3974203137.22.1780748588668;
        Sat, 06 Jun 2026 05:23:08 -0700 (PDT)
X-Received: by 2002:a05:6102:f14:b0:631:4c79:b1e8 with SMTP id ada2fe7eead31-6ff0afefe3dmr3974174137.22.1780748588296;
        Sat, 06 Jun 2026 05:23:08 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b97ac34sm2444082e87.39.2026.06.06.05.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 05:23:07 -0700 (PDT)
Date: Sat, 6 Jun 2026 15:23:05 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Nabige Aala <nabige.aala@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/3] dt-bindings: display: msm: qcm2290: Add Shikra
 MDSS
Message-ID: <fphua2bsw36libxqkrfubnaybvdtwncplddhexx26dtbjir7ov@jvmu4avug54z>
References: <20260605-shikra-display-v3-0-9846ba5fe635@oss.qualcomm.com>
 <20260605-shikra-display-v3-1-9846ba5fe635@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605-shikra-display-v3-1-9846ba5fe635@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDEyNCBTYWx0ZWRfX3LR7j1A7hyTa
 PG1A1tcd7dwO6qK/m4bkjCtNR5Dk+aGD601ANQD8l0sdm3dZZCJo+fpXfrCcY6+j3HmaKjb+rDJ
 bUz+fvIrV/9o7cNKYNmPKJD3Oz7kp1FuHkBR7KnyDNAQC4ikrn2tot+Mv+wtqnZkRJoP9WunQjr
 PHg/zPR8w7g8e7AOVL/HqyVkAUU9dTs+ZYwHIsSW0WqhcRS/43UFeaJ8UpMx+Mczz5UXL2BuTMW
 7ftQD7eZaD14hYpRtDV4t9UIjn9S4VJb63nPKKXYb3wkABzheXe1mw5meWd6nPQ8VIsuFZKQP63
 OX9Yxq0n+/97258RU97cPftcRx0B9w5ydVCKxaqh8nD3EiOvQVCrUNqYeMVHckkw6OWQIFZC9lZ
 rQ+IYWHYvDja6okmnItHYa+p7sNLxM+M/ARwxrvqKzB44v/x6MOFBgGmxZjJPBb283QnAlFcoje
 igK9Z4CIu9sFCO5kxvQ==
X-Authority-Analysis: v=2.4 cv=G/4s1dk5 c=1 sm=1 tr=0 ts=6a24112d cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=gEfo2CItAAAA:8
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=jtPkKwLRCkpF2dlEjY4A:9 a=CjuIK1q_8ugA:10
 a=TD8TdBvy0hsOASGTdmB-:22 a=sptkURWiP4Gy88Gu7hUp:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: C24hs0kruHj1o89LR4RwmYMdUNudG_Ss
X-Proofpoint-GUID: C24hs0kruHj1o89LR4RwmYMdUNudG_Ss
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-06_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606060124

On Fri, Jun 05, 2026 at 03:48:51PM +0530, Nabige Aala wrote:
> Shikra reuses the same MDSS/DPU 6.5 hardware as QCM2290. Extend
> the existing qcm2290 bindings to cover Shikra by adding fallback
> compatible chains for MDSS, DPU and DSI controller nodes rather
> than introducing a separate binding file.
> 
> Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
> ---
>  .../bindings/display/msm/dsi-controller-main.yaml  |  4 ++++
>  .../bindings/display/msm/qcom,qcm2290-dpu.yaml     |  7 +++++--
>  .../bindings/display/msm/qcom,qcm2290-mdss.yaml    | 22 +++++++++++++++-------
>  3 files changed, 24 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> index dbc0613e427e..ab2cfd6d6e3e 100644
> --- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> @@ -57,6 +57,10 @@ properties:
>            - const: qcom,eliza-dsi-ctrl
>            - const: qcom,sm8750-dsi-ctrl
>            - const: qcom,mdss-dsi-ctrl
> +      - items:
> +          - const: qcom,shikra-dsi-ctrl
> +          - const: qcom,qcm2290-dsi-ctrl
> +          - const: qcom,mdss-dsi-ctrl

Wrong sort order, qcm2290 < sm8750

>        - enum:
>            - qcom,dsi-ctrl-6g-qcm2290
>            - qcom,mdss-dsi-ctrl # This should always come with an SoC-specific compatible
> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-dpu.yaml
> index be6cd8adb3b6..e166a73651df 100644
> --- a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-dpu.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-dpu.yaml
> @@ -13,8 +13,11 @@ $ref: /schemas/display/msm/dpu-common.yaml#
>  
>  properties:
>    compatible:
> -    const: qcom,qcm2290-dpu
> -
> +    oneOf:
> +      - const: qcom,qcm2290-dpu
> +      - items:
> +          - const: qcom,shikra-dpu
> +          - const: qcom,qcm2290-dpu
>    reg:
>      items:
>        - description: Address offset and size for mdp register set
> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
> index bb09ecd1a5b4..ef21b2c263f2 100644
> --- a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
> @@ -4,7 +4,7 @@
>  $id: http://devicetree.org/schemas/display/msm/qcom,qcm2290-mdss.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: Qualcomm QCM220 Display MDSS
> +title: Qualcomm QCM2290 and Shikra Display MDSS
>  
>  maintainers:
>    - Loic Poulain <loic.poulain@linaro.org>
> @@ -12,13 +12,18 @@ maintainers:
>  description:
>    Device tree bindings for MSM Mobile Display Subsystem(MDSS) that encapsulates
>    sub-blocks like DPU display controller and DSI. Device tree bindings of MDSS
> -  are mentioned for QCM2290 target.
> +  are mentioned for QCM2290 and Shikra targets. Shikra uses the same MDSS/DPU/DSI
> +  hardware as QCM2290 (DPU 6.5) and shares the same register layout.
>  
>  $ref: /schemas/display/msm/mdss-common.yaml#
>  
>  properties:
>    compatible:
> -    const: qcom,qcm2290-mdss
> +    oneOf:
> +      - const: qcom,qcm2290-mdss
> +      - items:
> +          - const: qcom,shikra-mdss
> +          - const: qcom,qcm2290-mdss
>  
>    clocks:
>      items:
> @@ -52,7 +57,11 @@ patternProperties:
>  
>      properties:
>        compatible:
> -        const: qcom,qcm2290-dpu
> +        oneOf:
> +          - const: qcom,qcm2290-dpu
> +          - items:
> +              - const: qcom,shikra-dpu
> +              - const: qcom,qcm2290-dpu

Use contains:

>  
>    "^dsi@[0-9a-f]+$":
>      type: object
> @@ -60,9 +69,8 @@ patternProperties:
>  
>      properties:
>        compatible:
> -        items:
> -          - const: qcom,qcm2290-dsi-ctrl
> -          - const: qcom,mdss-dsi-ctrl
> +        contains:
> +          const: qcom,qcm2290-dsi-ctrl
>  
>    "^phy@[0-9a-f]+$":
>      type: object
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
