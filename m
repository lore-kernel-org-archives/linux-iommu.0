Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA273A8742
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 15:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773414148; cv=none; b=nXnSoRBIsJBCO5p4xIhBG+ILQ9cIc32zSjdcg8Eko3lQnIurwhCRCZ3gySjEDtZe+2VRzwjxgN2fFB692YA/sTeIPgF3gBF3Mf2dpjawbgB0EUlpbloajM3LtiAB+qaFwwSe4NA0Mcr2PCi50STnkKMzm17pPkdEvSLvIbaTku0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773414148; c=relaxed/simple;
	bh=mzZtPop+kd9wHX66geTaApsjeGRa3Ox7dMES620e74M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BmbDsDZDXt+KG0aFyACuMagoR63VLaANyvKjFVIVlieIA/BGmV03tmul1z/8ISm7zGtn2DY8p3YxagVmFgXQqxAWZbDTHefH4XwFY2qxj11Qd8S0Gc7VwVnESHPgLxfbzTXAr5OySpFoIKqR3JmViJ+Wvt3qgvek/V8tgK0S2/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E6wFI0Kg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=G5D7TftM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E6wFI0Kg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G5D7TftM"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D8vFLj481699
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 15:02:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=WMUq5P4ypLEyeKmuS5tsKloR
	VL58fpkquz0oY5oAxeI=; b=E6wFI0KgMwmyFaLzBNeAR8bTpbglXb2Nd1dAYC+V
	pegAe8uqUFODo/Ezs/mofND0DIxT0of5gcxkR3LF+O3An4mx1eOc+FmGLBD+xZz/
	zIMX9FJO41XWy7TSjkvgbR9ZXs9ObIVhK5vb+Xpng5L+rrFtSu8qtSSTLJTuZgYR
	+xGtA90qf3kHBRDyUC1BitX7rK8jtJSB1k+ssgz46WgpLMxa7GhbjIhTT++0yNM4
	eZ9rJcbVPVpqcg67/s43vevPJdCfqEbmj4ZXYsqm67swWanxJxCnceRNtH7sVfxA
	W/6GofkjWrXR9+zvIwt21hY3apBgYsXEOzRGfIOPAOuUvw==
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvfh7s8q1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 15:02:25 +0000 (GMT)
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-67bdee390a9so9333796eaf.3
        for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 08:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773414145; x=1774018945; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WMUq5P4ypLEyeKmuS5tsKloRVL58fpkquz0oY5oAxeI=;
        b=G5D7TftMNC0Llm4BaUdnsgeeJoNoKtQ2WzzKvlOjOPz/An1sReylYXxlo4ef3uLs5t
         32VnxNQZlzbUn6XI/cQ9mow0AJycE6oEghKEeqCUBlNjA/9Ns1RzlYi2r13GIUFu3+BP
         wAUP/kiTamX96sHWTtPUvs56nI0pywE35W0w42zrYFWQ0P3G7Rog1YNyK2M6nhzETzh1
         Hezj54kl5PuGhH8TmzK6kdN6U+gQgLnvfUHXexxtR3G3MmZuaLrjI7+llgI0Gj164Q8d
         hXSEj0M8MPZwWympto/3y4CtPO2NIYr/YfLBzua3UdJWf9EpRZPSpoE2GWfwE/QhkUwu
         op/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773414145; x=1774018945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WMUq5P4ypLEyeKmuS5tsKloRVL58fpkquz0oY5oAxeI=;
        b=Td78ZBBWXG4hN2N3RzldsKVNDdKYrHsc0WTrDV3+z0DQ2AmV1XZmq8Vo6Qy05zwpo7
         ONUlndZ80k6DAAPqH2Z9f39B3/GvK2DMV4mEofkWnmXoJeqMEhZ0Vm+/cxxAWdYELDjK
         NRR9GoJoasti/Xoaouz9TR4hs59YfVyjg5+gt8dnxxoHDu2xc4UacRtY0l84On62lEQm
         6DbhttBXxVOIOInHgYcnRCtK0OLJy7ev7WAmJHQNcNRHpEMadYY1xHKHUi7mJ5A/TuGN
         3DS3I92XHldbDXRqedgPT3FSHKYbV4+F9/IEK5eZMHLlgRrgn+I6cSH/gSBHwvDHtDB3
         UFsw==
X-Forwarded-Encrypted: i=1; AJvYcCWAxmGnQ1XOqS40gc3SXRNsihg7tieTBm2kGFALq7kgN6DdMJbTfu5rs0wgcD9bXAHruWmGzA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyas/x0uzo14tprsLDIXWjuJXnUSq8k+cveK9E6HZ4bqvTuQbfu
	sDlt1h2MrC9Uhv0Xe23jvLuVJ5clIa2iVzvmyNmCldRwqX7ah12NwctrP0fOqF5YRb6qFlX74yK
	MSnBB+tZl0oDzV5/GZvAB6t/c1m2fsRv8W6m/TY6rU8PwztQqsiuSZEfWgQ==
X-Gm-Gg: ATEYQzyLvzH4XnZrPBOXDr3S0RQF/iGG+dHtkZOyh/05oUSglUuBAH8SWup4+e7iI44
	UcO4kqrNgQsSwsGRn4EYmaWban9v3kTw4zIfjOz1JdaOqOSv40GW8k5jP86yGqesz/vFd0UtKdl
	KXs7n86B50m+MGsGZ7/JEOECMqzwWQT/METS98D3ErmmuvAoAjHBIuTmlPafZEdTDTiQaDrvN3Q
	RVzdHTtICdCeje2+bSjzZ7WjHPpQ0cO/PSP9ylqVFlTuV+Mx63gBz0WZX0sdjInBS+UAKOJ9nTz
	PPuGgyKp2zOG2/JDPrEZ9Xcw3dF2fLnlqfsIs3kfYMZwxFbz89lP6fQy/CbPZ+mWOCnRULzZL7f
	sOIYrCjTmv4Fcj9p40xo4A6XwoJCxstJQvCH+eZCpDqho6ZH9z+3j0goqWLkgSnKBkk+jyBHpa7
	wgLp50OFjqRNj5ebQTBfpBcvWxeLiwSObP8mI=
X-Received: by 2002:a05:6820:6ac8:b0:679:e930:b553 with SMTP id 006d021491bc7-67bda9ea0a4mr2208363eaf.32.1773414144537;
        Fri, 13 Mar 2026 08:02:24 -0700 (PDT)
X-Received: by 2002:a05:6820:6ac8:b0:679:e930:b553 with SMTP id 006d021491bc7-67bda9ea0a4mr2208321eaf.32.1773414143791;
        Fri, 13 Mar 2026 08:02:23 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a15635786bsm1534849e87.61.2026.03.13.08.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 08:02:22 -0700 (PDT)
Date: Fri, 13 Mar 2026 17:02:19 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Hans Verkuil <hverkuil+cisco@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v3 1/7] media: dt-bindings: qcom-kaanapali-iris: Add
 kaanapali video codec binding
Message-ID: <hfuqu5uwjuh4ie55zwaqqbsflhf5yn55hnjva356nivoq46m2i@o5pkjnfrwycq>
References: <20260313-kaanapali-iris-v3-0-9c0d1a67af4b@oss.qualcomm.com>
 <20260313-kaanapali-iris-v3-1-9c0d1a67af4b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313-kaanapali-iris-v3-1-9c0d1a67af4b@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: JfBWaQVvLFauMDEn1H2IBfoUtV3AK-56
X-Proofpoint-GUID: JfBWaQVvLFauMDEn1H2IBfoUtV3AK-56
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDEyMCBTYWx0ZWRfX4lpFhjY34x+O
 SK3vg4xL8hwuKmm1tm9+/APkhybd8QregMARnowLLO87lQkRHsOOwIOxckwZmmixWy30fyH9m1V
 cnwaDt3+jIO1VD27yUWVtBJyqhIif0G3YpwcTjfs8nPmb2Z1Xk7W/6Twh3iqWITvEx69nHJikra
 jdx26jsrKIMkGiGMEWegelJesqy89rlhFySs3LPHafYqC9wIyroXE/ixMofhKvHgNioNOvaPuCp
 HHkrimwspJIoKNmTqWewvosvAlCzjq5y6u7AHvO5+UwTCFNEMQoVM1/L/7JMuZyCYOFGYOwJUGc
 E+nrz2GEECajeMKHCSaUMsJqtUtUBrY2D4kZSaE0sfewmILxLVSvRVhuAxpNB3Op5czv7Gh8iBW
 fPr9Yac67KNZ4gXTcuWT2qYxVhHb0zU7TZIEqVehDMNfwHgbUDRizyrEVmWUhNebunEvVsT0V3z
 7Qq/0z4OmQQdzDGEvwQ==
X-Authority-Analysis: v=2.4 cv=BpiQAIX5 c=1 sm=1 tr=0 ts=69b42701 cx=c_pps
 a=V4L7fE8DliODT/OoDI2WOg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=NEAV23lmAAAA:8
 a=EUspDBNiAAAA:8 a=aeCAS9ip0PrbuPtrNpkA:9 a=CjuIK1q_8ugA:10
 a=WZGXeFmKUf7gPmL3hEjn:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130120

On Fri, Mar 13, 2026 at 06:49:35PM +0530, Vikash Garodia wrote:
> Kaanapali SOC brings in the new generation of video IP i.e iris4. When
> compared to previous generation, iris3x, it has,
> - separate power domains for stream and pixel processing hardware blocks
>   (bse and vpp).
> - additional power domain for apv codec.
> - power domains for individual pipes (VPPx).
> - different clocks and reset lines.
> 
> This patch depends on
> https://github.com/devicetree-org/dt-schema/pull/184/changes/d341298d62805bc972dfba691da6b3b62aa3ff15
> 
> Nacked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> ---
>  .../bindings/media/qcom,kaanapali-iris.yaml        | 254 +++++++++++++++++++++
>  include/dt-bindings/media/qcom,kaanapali-iris.h    |  18 ++
>  2 files changed, 272 insertions(+)

> +
> +    video-codec@2000000 {
> +        compatible = "qcom,kaanapali-iris";
> +        reg = <0x02000000 0xf0000>;
> +
> +        clocks = <&gcc_video_axi0_clk>,
> +                 <&video_cc_mvs0c_clk>,
> +                 <&video_cc_mvs0_clk>,
> +                 <&gcc_video_axi1_clk>,
> +                 <&video_cc_mvs0c_freerun_clk>,
> +                 <&video_cc_mvs0_freerun_clk>,
> +                 <&video_cc_mvs0b_clk>,
> +                 <&video_cc_mvs0_vpp0_clk>,
> +                 <&video_cc_mvs0_vpp1_clk>,
> +                 <&video_cc_mvs0a_clk>;
> +        clock-names = "iface",
> +                      "core",
> +                      "vcodec0_core",
> +                      "iface1",
> +                      "core_freerun",
> +                      "vcodec0_core_freerun",
> +                      "vcodec_bse",
> +                      "vcodec_vpp0",
> +                      "vcodec_vpp1",
> +                      "vcodec_apv";
> +
> +        dma-coherent;
> +
> +        interconnects = <&gem_noc_master_appss_proc &config_noc_slave_venus_cfg>,
> +                        <&mmss_noc_master_video_mvp &mc_virt_slave_ebi1>;
> +        interconnect-names = "cpu-cfg",
> +                             "video-mem";
> +
> +        interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
> +
> +        iommu-map = <IRIS_BITSTREAM &apps_smmu 0x1944 0x0 0x1>,
> +                    <IRIS_NON_PIXEL &apps_smmu 0x1940 0x0 0x1>,
> +                    <IRIS_NON_PIXEL &apps_smmu 0x1a20 0x0 0x1>,

It think we still haven't settled on letting iommu-map to have several
entries for a single function.

> +                    <IRIS_PIXEL &apps_smmu 0x1943 0x0 0x1>,
> +                    <IRIS_SECURE_BITSTREAM &apps_smmu 0x1946 0x0 0x1>,
> +                    <IRIS_SECURE_NON_PIXEL &apps_smmu 0x1941 0x0 0x1>,
> +                    <IRIS_SECURE_NON_PIXEL &apps_smmu 0x1a21 0x0 0x1>,
> +                    <IRIS_SECURE_PIXEL &apps_smmu 0x1945 0x0 0x1>,
> +                    <IRIS_FIRMWARE &apps_smmu 0x1a22 0x0 0x1>;
> +
> +        memory-region = <&video_mem>;
> +
> +        operating-points-v2 = <&iris_opp_table>;
> +
> +        power-domains = <&video_cc_mvs0c_gdsc>,
> +                        <&video_cc_mvs0_gdsc>,
> +                        <&rpmhpd RPMHPD_MXC>,
> +                        <&rpmhpd RPMHPD_MMCX>,
> +                        <&video_cc_mvs0_vpp0_gdsc>,
> +                        <&video_cc_mvs0_vpp1_gdsc>,
> +                        <&video_cc_mvs0a_gdsc>;
> +        power-domain-names = "venus",
> +                             "vcodec0",
> +                             "mxc",
> +                             "mmcx",
> +                             "vpp0",
> +                             "vpp1",
> +                             "apv";
> +
> +        resets = <&gcc_video_axi0_clk_ares>,
> +                 <&gcc_video_axi1_clk_ares>,
> +                 <&video_cc_mvs0c_freerun_clk_ares>,
> +                 <&video_cc_mvs0_freerun_clk_ares>;
> +        reset-names = "bus0",
> +                      "bus1",
> +                      "core",
> +                      "vcodec0_core";
> +
> +        iris_opp_table: opp-table {
> +            compatible = "operating-points-v2";
> +
> +            opp-240000000 {
> +                opp-hz = /bits/ 64 <240000000 240000000 240000000 360000000>;
> +                required-opps = <&rpmhpd_opp_low_svs_d1>,
> +                                <&rpmhpd_opp_low_svs_d1>;

It's a DT and not the schema question, but please cross-check the OPP
points here. If I understand Taniya correctly, we should be using
corners from the PLL type rather than from the video_cc clock plan (they
differ for some reason). Downstream videocc driver also should have
correct rail corners for the PLLs.

> +            };
> +

-- 
With best wishes
Dmitry
