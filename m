Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821433E1CFF
	for <iommu@lists.linux.dev>; Wed,  6 May 2026 16:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778083351; cv=none; b=Ii78R/Q1CsRX28JlEbkAegc0pJ9FZgu5w/t4vJSxxGW7YHXhl4imYxsFglAK1qdk8G5gupLtKPL6bgRw4S//mkaUpbCUC/lUf7aUYo6aZJkDTUQN2qCvheSVaUXPDmbazwj0Ro7knXO5rneRjXnT4ihzFFP7RIsOEfn4RkarFtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778083351; c=relaxed/simple;
	bh=IOTEW2qQ5N89NXwb1CeAN1Uhwjjf6nKKdaqAgo1Twjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oMkv0Wmous2Jy4STmm6mbg1rxl0MIJ1qT1vUKat2HgteLFAF1x0cx6iXV3GrUEu9DOPLTcI6zFeOs8rPjVXcTlUI8y2OujeR7aslYZzrBAtLSjXzO0B6oXjxLwL6gEwsuU5GPx/RwRHV+HJOO3mGz3Hp7DdQDF99CCiK7RP+bs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NMjbqf09; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KZArDUW0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NMjbqf09";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KZArDUW0"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646C5Jgu3036347
	for <iommu@lists.linux.dev>; Wed, 6 May 2026 16:02:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TGZ1h1/OF53J3gFzAIo0xWBAkfLlfizlmwek520L4Rk=; b=NMjbqf09KRZ3cMc5
	/KHw2mkkI9Ijj7nU+6NObGB8gY8snyi0I3TFsEk36Zv7Y07/4oUJ3y3OJpeX1lE2
	ygAKbC6Zwh2UjQ6K3s8lsKc2cFPyUH0xYmQkAZpx3/Syc7Bv5uOvjTks/wlcZ+iH
	/Fgl5pgY1fMor5jsGIzCAbu9CtrJrdM21LGgafmvJRQf1UbmpSZZup8Qcc1TxLzM
	K4sv9ZV5lrpwuzaEOAV/Qa1r9R8YNacZ0PUs1qiELmDHitpQ3ekOdFcjo2TF/ARr
	J0U9z0DC8eS4oRrtwDaOucDXFgYyu8QTVwvHeTT4AjYFnEeNUEoI41ntb7WzPk7y
	A5g0Gg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e05bf0x22-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 06 May 2026 16:02:19 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b9f5ac4e36so37998275ad.2
        for <iommu@lists.linux.dev>; Wed, 06 May 2026 09:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778083338; x=1778688138; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TGZ1h1/OF53J3gFzAIo0xWBAkfLlfizlmwek520L4Rk=;
        b=KZArDUW09CdaV5qj9+iuIrBAn4oM2KAyTNC2T2UcW+zT8mJ9LH+yFMjt8q/BCHln1K
         dAV9x1fkZRNgyZzq/lhPF+vBg4b4pmJGmNwzw5Ge5DcJMxBcNOA0bbLlA2bwy3I0UQJj
         GLx9X4D0sQxAemDiJDnRXlI5rt4N+Kt5oYDt/oMJo6wz4fXyEAhPd82wTR5GFlJwqAsK
         uyl0F37DwMHTYibfDUm3K+n7FzwF8r3wZgDL3dgOG0urjLWach/nZQTxf3Tv3hMHCRoT
         eDMK3QJ40k4FX/L+7J1LnZwhgytl8DJyKfZc9Fk07KufsSQ4St9x9ThZTw8w/NkUN61j
         M+5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778083338; x=1778688138;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TGZ1h1/OF53J3gFzAIo0xWBAkfLlfizlmwek520L4Rk=;
        b=MkiRsgRBvMe5wJpHvtIXHY284jz1oMhFwKY/QybsMigPcgAs55JgUR6JwZqbYSBLwl
         /KprLMTJZ2yAcimTa/mQNDDZlBPJoLOVq/6Nh96wIm8atCRLQBNvGsYtL7qhAgvlA1+N
         EDypnuOVsK3+2891wLBRVljuV9vlp1OV7Xq6mPj4yhDULOm1rDjHyiRQBP1o6mcdL6RQ
         FQrOxi7AAWsDEYwiJFlyLDnx/kVr1VA0T/YOGEwsIbD7j/+DZh00dcJB6VSrNvunjg41
         FPlk2903gYk32OtchMK74fKDTGRB/QuYEgT2xau3bzXruSKs984Nq9BN0pw26yD87vsK
         xF8w==
X-Forwarded-Encrypted: i=1; AFNElJ/XvryR/EFL4ooGyx7MXlFJXK7sjyOEzXFNbaN1ipw/s3VoVzXD4Sk4SU5DQOaweKVILMvRWw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwZk52GAS4d4qDIW3dXZ5I1JMMv16ArA1l9cC6gTVgOo+Ed4ccS
	F+wCZjoutVyjkdLeglDE+vMqd08jr1ansO7PLJEdS1FTzJWjKTnpg9WGhIKWvcgREOgOwAzr7k5
	rrF9PdZT3pj43VhkH+C9dsAX4cbr3R2imfPET4SoQEwB8v8waqvOfjhZKMA==
X-Gm-Gg: AeBDiesG+EN6q6ocOojgzBjSQSs6VqSZtBF7ulSQsATjzrDDnHOCJ4LPPUzWhrj8sCh
	zGVE9M8IZJJw/xsJzO00/LdfiEubBkHLDbDAx+FV51GdMXVykWnSd49qps6sLxLzcxzLj8P5AFf
	O9Av16FvJ6uvCtfjKbUinXmEPuZJ4h95PN/OQN5fCp57hCzDTME4vxGD4yE+6WWMaywo0acVe4l
	J3YUJ9dRO6cgPhoba6lYLlZlAsyI1x6IF3CY16KJq/jjJ1w95FUJ8arVJYfE0VUBC2/w5/jaO2f
	E1eczMLIhNs+ajHXdUYhTMRvt/IhAm1GCR80M4MWAdM7g82ZHSi1QgBCYF7L7TrrLwF/fRplwEX
	LlsARXGa/LhHoAv8O/DKWpvY0aprl1qFPNWvIGzYs+YTtZpKNyvL6UJl0KzOQgW7d
X-Received: by 2002:a17:902:da87:b0:2b2:ebed:7afc with SMTP id d9443c01a7336-2ba7a33354emr44077645ad.27.1778083337881;
        Wed, 06 May 2026 09:02:17 -0700 (PDT)
X-Received: by 2002:a17:902:da87:b0:2b2:ebed:7afc with SMTP id d9443c01a7336-2ba7a33354emr44076295ad.27.1778083337057;
        Wed, 06 May 2026 09:02:17 -0700 (PDT)
Received: from [10.204.101.47] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ba849032bfsm23120095ad.44.2026.05.06.09.02.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 09:02:16 -0700 (PDT)
Message-ID: <2b4ff288-1068-4411-bfbf-d007740710ae@oss.qualcomm.com>
Date: Wed, 6 May 2026 21:32:09 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/13] arm64: dts: qcom: glymur: Add iris video node
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux.dev
References: <20260505-glymur-v4-0-17571dbd1caa@oss.qualcomm.com>
 <20260505-glymur-v4-13-17571dbd1caa@oss.qualcomm.com>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20260505-glymur-v4-13-17571dbd1caa@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE1OCBTYWx0ZWRfXwZgVQyEk1nW1
 o7nzPPZmWXn/qlI9IY38ELZRGNAq0ARyZbrWvPJn9bkMb4b/jdWTbpJvVxCVotNAd+2CD666izP
 aQkxhqnEiX5HItfy068Bty26Jo4DilAvik1+5Eb13s5LsUCFZDMT3jlgOTgZtJU9vBjxMMax1Fm
 8TzokYiaAj5Fs/Ds2A6kiTHpoejBUCfWu+Dl58rSungWOdN3SpXg1rdOhUHhvmsWmpo8K4hZsvE
 6PHbmpCuWVE6X834QbzKHV/LUgZlh8KSGoApyP+vOgrXwxDbhtFX06AR7Fhv1KsWgiStrTlNhOy
 USkY/UZMsCa+A6QTio2TqZNOz0SG7Mr/1JNrfDJDbEBd8+Kbg55stdthuqqUE4RoGDfXa9i9sCx
 e+yKxi3wn26XbWVRbPA60o5ZPvreXPPPDG5/eweuej/mC+QsLrXIXaUBEmPfTcWw3XnTi7+6VAd
 vxBgLOVOJLWt4FDSIuw==
X-Authority-Analysis: v=2.4 cv=PqmjqQM3 c=1 sm=1 tr=0 ts=69fb660b cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=glmcflYCJT591w8RKWQA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: MENZxzpHW7aNxouokthn97ggYpZWtNec
X-Proofpoint-ORIG-GUID: MENZxzpHW7aNxouokthn97ggYpZWtNec
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605060158


On 5/5/2026 12:29 PM, Vishnu Reddy wrote:
> Add iris video codec to glymur SoC, which comes with significantly
> different powering up sequence than previous platforms, thus different
> clocks and resets.
> 
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> ---
>   arch/arm64/boot/dts/qcom/glymur-crd.dts |   4 ++
>   arch/arm64/boot/dts/qcom/glymur.dtsi    | 118 ++++++++++++++++++++++++++++++++
>   2 files changed, 122 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/glymur-crd.dts b/arch/arm64/boot/dts/qcom/glymur-crd.dts
> index 35aaf09e4e2b..8d6ea857634b 100644
> --- a/arch/arm64/boot/dts/qcom/glymur-crd.dts
> +++ b/arch/arm64/boot/dts/qcom/glymur-crd.dts
> @@ -198,6 +198,10 @@ ptn3222_1: redriver@47 {
>   	};
>   };
>   
> +&iris {
> +	status = "okay";
> +};
> +

generally board enablement change goes as separate patch, not sure on 
this though.

>   &mdss {
>   	status = "okay";
>   };
> diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
> index f23cf81ddb77..c47443174f97 100644
> --- a/arch/arm64/boot/dts/qcom/glymur.dtsi
> +++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
> @@ -13,6 +13,7 @@
>   #include <dt-bindings/interconnect/qcom,glymur-rpmh.h>
>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>   #include <dt-bindings/mailbox/qcom-ipcc.h>
> +#include <dt-bindings/media/qcom,glymur-iris.h>
>   #include <dt-bindings/phy/phy-qcom-qmp.h>
>   #include <dt-bindings/power/qcom,rpmhpd.h>
>   #include <dt-bindings/power/qcom-rpmpd.h>
> @@ -4163,6 +4164,123 @@ usb_mp: usb@a400000 {
>   			status = "disabled";
>   		};
>   
> +		iris: video-codec@aa00000 {
> +			compatible = "qcom,glymur-iris";
> +			reg = <0x0 0xaa00000 0x0 0xf0000>;
> +
> +			clocks = <&gcc GCC_VIDEO_AXI0_CLK>,
> +				 <&videocc VIDEO_CC_MVS0C_CLK>,
> +				 <&videocc VIDEO_CC_MVS0_CLK>,
> +				 <&gcc GCC_VIDEO_AXI0C_CLK>,
> +				 <&videocc VIDEO_CC_MVS0C_FREERUN_CLK>,
> +				 <&videocc VIDEO_CC_MVS0_FREERUN_CLK>,
> +				 <&gcc GCC_VIDEO_AXI1_CLK>,
> +				 <&videocc VIDEO_CC_MVS1_CLK>,
> +				 <&videocc VIDEO_CC_MVS1_FREERUN_CLK>;
> +			clock-names = "iface",
> +				      "core",
> +				      "vcodec0_core",
> +				      "iface1",
> +				      "core_freerun",
> +				      "vcodec0_core_freerun",
> +				      "iface2",
> +				      "vcodec1_core",
> +				      "vcodec1_core_freerun";
> +
> +			dma-coherent;
> +
> +			interconnects = <&hsc_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
> +					 &config_noc SLAVE_VENUS_CFG QCOM_ICC_TAG_ACTIVE_ONLY>,
> +					<&mmss_noc MASTER_VIDEO QCOM_ICC_TAG_ALWAYS
> +					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
> +			interconnect-names = "cpu-cfg",
> +					     "video-mem";
> +
> +			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			iommus = <&apps_smmu 0x1940 0x0>,
> +				 <&apps_smmu 0x1943 0x0>,
> +				 <&apps_smmu 0x1944 0x0>,
> +				 <&apps_smmu 0x19e0 0x0>;
> +
> +			iommu-map = <IOMMU_FID_IRIS_FIRMWARE &apps_smmu 0x19e2 0x1>;
> +
> +			memory-region = <&video_mem>;
> +
> +			operating-points-v2 = <&iris_opp_table>;
> +
> +			power-domains = <&videocc VIDEO_CC_MVS0C_GDSC>,
> +					<&videocc VIDEO_CC_MVS0_GDSC>,
> +					<&rpmhpd RPMHPD_MXC>,
> +					<&rpmhpd RPMHPD_MMCX>,
> +					<&videocc VIDEO_CC_MVS1_GDSC>;
> +			power-domain-names = "venus",
> +					     "vcodec0",
> +					     "mxc",
> +					     "mmcx",
> +					     "vcodec1";
> +
> +			resets = <&gcc GCC_VIDEO_AXI0_CLK_ARES>,
> +				 <&gcc GCC_VIDEO_AXI0C_CLK_ARES>,
> +				 <&videocc VIDEO_CC_MVS0C_FREERUN_CLK_ARES>,
> +				 <&videocc VIDEO_CC_MVS0_FREERUN_CLK_ARES>,
> +				 <&gcc GCC_VIDEO_AXI1_CLK_ARES>,
> +				 <&videocc VIDEO_CC_MVS1_FREERUN_CLK_ARES>;
> +			reset-names = "bus0",
> +				      "bus1",
> +				      "core",
> +				      "vcodec0_core",
> +				      "bus2",
> +				      "vcodec1_core";
> +
> +			/*
> +			 * IRIS firmware is signed by vendors, only
> +			 * enable on boards where the proper signed firmware
> +			 * is available.
> +			 */
> +			status = "disabled";
> +
> +			iris_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				opp-240000000 {
> +					opp-hz = /bits/ 64 <240000000 240000000 360000000>;
> +					required-opps = <&rpmhpd_opp_svs>,
> +							<&rpmhpd_opp_low_svs>;
> +				};
> +
> +				opp-338000000 {
> +					opp-hz = /bits/ 64 <338000000 338000000 507000000>;
> +					required-opps = <&rpmhpd_opp_svs>,
> +							<&rpmhpd_opp_svs>;
> +				};
> +
> +				opp-366000000 {
> +					opp-hz = /bits/ 64 <366000000 366000000 549000000>;
> +					required-opps = <&rpmhpd_opp_svs_l1>,
> +							<&rpmhpd_opp_svs_l1>;
> +				};
> +
> +				opp-444000000 {
> +					opp-hz = /bits/ 64 <444000000 444000000 666000000>;
> +					required-opps = <&rpmhpd_opp_svs_l1>,
> +							<&rpmhpd_opp_nom>;
> +				};
> +
> +				opp-533333334 {
> +					opp-hz = /bits/ 64 <533333334 533333334 800000000>;
> +					required-opps = <&rpmhpd_opp_svs_l1>,
> +							<&rpmhpd_opp_turbo>;
> +				};
> +
> +				opp-655000000 {
> +					opp-hz = /bits/ 64 <655000000 655000000 982000000>;
> +					required-opps = <&rpmhpd_opp_nom>,
> +							<&rpmhpd_opp_turbo_l1>;
> +				};
> +			};
> +		};
> +
>   		mdss: display-subsystem@ae00000 {
>   			compatible = "qcom,glymur-mdss";
>   			reg = <0x0 0x0ae00000 0x0 0x1000>;
> 

otherwise, LGTM

Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
