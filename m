Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6967943D4F4
	for <iommu@lists.linux.dev>; Thu,  4 Jun 2026 12:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780577527; cv=none; b=ZhJitnzdi3xjz4uRV+9VHTa1v71vLZ9tdvVouJJRlItFSzFOaswxrpZ0nLtP7awY7DlF2vvi/uGgsgaNJ0MvtBFxae9KsMZgpNyq9IRqhHK7YQOzAlgWVw9eBIlYvvX+JHh/RQMcXn3kA5JLqRIRjqlnVqZ7qu7pozx96wQc580=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780577527; c=relaxed/simple;
	bh=77v9Al1lhh7IeOYvE+UjGRjE+iVb2hZ3YgJY6y3laQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BSUYv0L2D1u/0YmLgkeQ3MQG4ylEX/lG4N7JgumzMLGjzjBXm/JvcLh8xlUtswIsPuLwTQdf0DTk1do6BYCIZJZM6ROTbQ8DlZWVIgVU8iAeYsyWtIYYm4V82tCYj+wqY1+cR97z23/fB0uCooSdbF790LAJJXSclzlZS6Z9fu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cv7szaif; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=huU8dUtl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cv7szaif";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="huU8dUtl"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6548UFQs598074
	for <iommu@lists.linux.dev>; Thu, 4 Jun 2026 12:52:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=XgEAN0/+gM+54F4VHBCxD3vD
	G/6RjDY/mUjZmgXTXkY=; b=cv7szaifabc9i/rBVu+6yJCIPhf9YS5ZWrXb0Cn2
	WIZxxHuFffeW3CqWnz6oVEgffx9RksYyxCgYtl1wi83p+8KZqsl2ajf+MGJDds6t
	Y9vH6qhtIuAauLC+PVKPktU7jFgIfO1H6tI1BBhbjy7L2mjiPbFYIrK0yR9NQ+lL
	xUZ6EnwHKMKrg/HcpMv4ENmcCc5ahfI2kXTgKTVt0a2Cvx+uFXJit3AQ2PZ0ak6O
	LPpjneRJQv4MqX7nz0nGvwQJxx2ETr/WXfaQhyThKwLufFQ6oFdYiUH155WezWZM
	8tEW0AIKTlAxcymhWO9hn6lmlcJS61WxmaVvRybeHHeL+A==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejy8m2cyg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 04 Jun 2026 12:52:04 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-6c152655acfso84173137.0
        for <iommu@lists.linux.dev>; Thu, 04 Jun 2026 05:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780577523; x=1781182323; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XgEAN0/+gM+54F4VHBCxD3vDG/6RjDY/mUjZmgXTXkY=;
        b=huU8dUtlvLDCgqAtcrwYmMKWp4mnyhr/8dsSlFzyZISnFgtv0O+Q9NBhXAy7jF8lEd
         zSOC4/vD2f+imJLgkWFXjPqQPyYAeuVbzqER7COtXz6TLzbQ23DutEtLH/VRFFqCczEw
         MNZ98ZJIjMGkaaQ6a3/qPAaWvXT/JYC/xBVDFnZTpCRNRb6l4T4wxp+DyQKBz869Ij02
         NoKDn7mmnUyjAisXAsZa3jJSqN4uwp++cEMLtUrIvwVW9DZVh3vrrx29R0p3lwvOWv9o
         FQD0d6cpViwVr5OedajkRlXS1cY4oo8Pe4STrUHX/2aj40quVcXLQzCQvdgy8T5szZkP
         YPZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780577523; x=1781182323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XgEAN0/+gM+54F4VHBCxD3vDG/6RjDY/mUjZmgXTXkY=;
        b=FE0M+PAOUhUKTOtxKRb9QeCTfZX4Dhaj81/sLC5NZF28y+77xwqSAQF6Rq7Qbxd4B3
         BiYNXjEmgvpwmaq1+lTW9agzFae2d8q0x1WQR2NuMdahwZN38Sy4CbXGxFC66+egVMv7
         joSrQmrx/Xxm7YDdcPeH7nWzrNiCnFyXUZrzzEjW7y4r1E6RAi1Do6rUCbUnDGcGpp+N
         zymp3GDiYBUqYE9XQQnJRSG5OkDkz3IJnZOPS7E9CiTUN71GBJ4qW7bRDjTImmWnc882
         DzilZzwerbhRHgtd13zfj3M2j22xtnGSYN9ZF8PLyPJNd6qx0O4KAnQ7ZEeC+Xx4VPiq
         LIDw==
X-Forwarded-Encrypted: i=1; AFNElJ8eEmRm6Jvy87kmm7O15nAt/1dMN9fKUavbtczU+B439bBpzrEMieRbLz8magd7rC6AyTnD7A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzxpIzRhxWpQqBIaDxYLIIfrwG7WXK78qj9YyhZ/AUqJjpTGzYL
	lNLd2ABP2TpDhc4+QrWk5NrG3eyO9/BnuOt3EfaCZ4J7jSNawQYaWaht7z6mZHc+AnMuXbZmusY
	oNWORjf4EyXnvmngEdoWNK+to8Oel8+JgmWOBi4zqmSe/45ODr85LXjMp0Q==
X-Gm-Gg: Acq92OGya9EPqceBc6IJqdIc1fHRqKeWOoIEUpoA31673PtuO6hxWfXoIfmoJGOW+Er
	nZH6K96mk4IoHVUAbAwjuo9mcI9/iC3zN126vcXIhetsiHOc43za2fPSSXzKd+o+QAumIVwOYBx
	tupN78wJ0Hx79KfaZ7YiM6sy7M3gospwmvEt5rX32ncJE80hJ9x+bJO5F21OHv9vzlu46uwD1nM
	NVKaeiycqB8E5oeMxUuNNng5G57cDBOs8wpznySHyomOa6Y+fjdm7cXRWf9trGrVyD8YY6+o/tm
	v1bYtl4dbcN3vhY7BhKyDltQvvm4dtkW7qR8yEHrSsN4IjNc4auyTeohmWHWl0e4GnbP7hRXiQY
	dF18HuyBGqnezaBoXwmlPWHm44/KhKzVPQblVZ7V0ZncKr/D8v1iG/JnOpX2bVR53f6bGfIi9LJ
	M47JXg394iEiX2jE957XCGxWQS1hCB1wwLGGI43IUpB16JJQ==
X-Received: by 2002:a05:6102:8027:b0:6a2:cfe7:20b3 with SMTP id ada2fe7eead31-6ec278d65d9mr4057226137.2.1780577523208;
        Thu, 04 Jun 2026 05:52:03 -0700 (PDT)
X-Received: by 2002:a05:6102:8027:b0:6a2:cfe7:20b3 with SMTP id ada2fe7eead31-6ec278d65d9mr4057200137.2.1780577522595;
        Thu, 04 Jun 2026 05:52:02 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b99c74esm1188940e87.81.2026.06.04.05.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 05:52:01 -0700 (PDT)
Date: Thu, 4 Jun 2026 15:51:59 +0300
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
Subject: Re: [PATCH v2 1/3] dt-bindings: display: msm: qcm2290: Add Shikra
 MDSS
Message-ID: <elb6gc36lkxdbvukretqx5widqozg4tw3wbg3o7ma3fsckjueu@sruvhflcy2sm>
References: <20260604-shikra-display-v2-0-b3c1b2b67edc@oss.qualcomm.com>
 <20260604-shikra-display-v2-1-b3c1b2b67edc@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604-shikra-display-v2-1-b3c1b2b67edc@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=KfDidwYD c=1 sm=1 tr=0 ts=6a2174f4 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=gEfo2CItAAAA:8
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=VFkWRHED51hAbpIxpgQA:9 a=CjuIK1q_8ugA:10
 a=ODZdjJIeia2B_SHc_B0f:22 a=sptkURWiP4Gy88Gu7hUp:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDEyNCBTYWx0ZWRfX3w+e8su0BrXX
 Ax29hMMF3UsPQra+Zoj4h+ronRdlYSx3ebpFjJ1otvOwxEJv07hXsjuMDmK0MAzbG8EmvJYTD7F
 yK8v8jA5rotLwgXEXZDeoSrsRFzp/qug+BGLt0bgsg945qLTPFLGCEtDbYedT+RjHPSZpg9iHmj
 XGMyXKETyOMjRuSoF8wx4wqZTtONVOU+BO0b0CU1+hjYXxY6iPzllkOKqdQ0m4h50p5fH32E/qu
 z+LSfurw/3Fk0O3H+76Hcoyb5gBwwJXLVvqAKrHpWYu+Riq5u0yqo7PDkBSsDUxYWd22Wbe4RIM
 qno907QnmQHLP+wadmPCB7E1dS6BPT19/EPqoaSiYGj8UivPeinzVN75j0Cpx2Us80UbgCXmFut
 gA+NvMzGV5OILkZllaeUC5A39P9hfxA7EOXMyZcZBxKkGNZWBLYchYStoX70jKVmkBGLkDEs7Hi
 J5JjTZ1tgWr9fqW3r+A==
X-Proofpoint-GUID: oEPZGkAJnY6QG-UfTpSHQ-b-uY_UF2pv
X-Proofpoint-ORIG-GUID: oEPZGkAJnY6QG-UfTpSHQ-b-uY_UF2pv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040124

On Thu, Jun 04, 2026 at 06:00:47PM +0530, Nabige Aala wrote:
> Shikra SoC uses the same MDSS/DPU/DSI hardware as QCM2290 (DPU 6.5),
> sharing the same register layout, DSI controller and 14nm DSI PHY.
> Add qcom,shikra-mdss to the qcm2290-mdss binding compatible enum
> rather than introducing a separate binding file.
> 
> Register qcom,shikra-dsi-ctrl in dsi-controller-main.yaml alongside
> qcom,qcm2290-dsi-ctrl, and update the qcm2290-mdss patternProperties
> to accept both SoC-specific DPU and DSI controller compatibles.
> 
> Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
> ---
>  .../bindings/display/msm/dsi-controller-main.yaml  |  1 +
>  .../bindings/display/msm/qcom,qcm2290-dpu.yaml     |  7 ++--
>  .../bindings/display/msm/qcom,qcm2290-mdss.yaml    | 38 ++++++++++++++++++----
>  3 files changed, 37 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> index dbc0613e427e..a2f3e91104af 100644
> --- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> @@ -33,6 +33,7 @@ properties:
>                - qcom,sdm660-dsi-ctrl
>                - qcom,sdm670-dsi-ctrl
>                - qcom,sdm845-dsi-ctrl
> +              - qcom,shikra-dsi-ctrl

It is the same as QCM2290. Why didn't you follow the pattern and add it
using qcm2290 one as a fallback?

>                - qcom,sm6115-dsi-ctrl
>                - qcom,sm6125-dsi-ctrl
>                - qcom,sm6150-dsi-ctrl
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
> index bb09ecd1a5b4..7184b09a8774 100644
> --- a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
> @@ -4,21 +4,36 @@
>  $id: http://devicetree.org/schemas/display/msm/qcom,qcm2290-mdss.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: Qualcomm QCM220 Display MDSS
> +title: Qualcomm QCM2290 and Shikra Display MDSS
>  
>  maintainers:
>    - Loic Poulain <loic.poulain@linaro.org>
> +  - Nabige Aala <nabige.aala@oss.qualcomm.com>

Nope.

>  
>  description:
>    Device tree bindings for MSM Mobile Display Subsystem(MDSS) that encapsulates
>    sub-blocks like DPU display controller and DSI. Device tree bindings of MDSS
> -  are mentioned for QCM2290 target.
> +  are mentioned for QCM2290 and Shikra targets. Shikra uses the same MDSS/DPU/DSI
> +  hardware as QCM2290 (DPU 6.5) and shares the same register layout.
>  
>  $ref: /schemas/display/msm/mdss-common.yaml#
>  
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - qcom,qcm2290-mdss
> +  required:
> +    - compatible

Why do you need this?

> +
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
> @@ -52,7 +67,11 @@ patternProperties:
>  
>      properties:
>        compatible:
> -        const: qcom,qcm2290-dpu
> +        oneOf:
> +          - const: qcom,qcm2290-dpu
> +          - items:
> +              - const: qcom,shikra-dpu
> +              - const: qcom,qcm2290-dpu
>  
>    "^dsi@[0-9a-f]+$":
>      type: object
> @@ -60,9 +79,14 @@ patternProperties:
>  
>      properties:
>        compatible:
> -        items:
> -          - const: qcom,qcm2290-dsi-ctrl
> -          - const: qcom,mdss-dsi-ctrl
> +        oneOf:
> +          - items:
> +              - const: qcom,qcm2290-dsi-ctrl
> +              - const: qcom,mdss-dsi-ctrl
> +          - items:
> +              - const: qcom,shikra-dsi-ctrl
> +              - const: qcom,qcm2290-dsi-ctrl
> +              - const: qcom,mdss-dsi-ctrl

Change this to contains:qcom,qcm2290-dsi-ctrl

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
