Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0469020CCF5
	for <iommu@lists.linux.dev>; Wed, 12 Feb 2025 13:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739365647; cv=none; b=KM/UAeYmGLPbtrk23Rq5MZ7sJ3mjEOqcBv3J6xG9tPAujSkqWm6nxhSCZazrYTemjPK1C/pnz0754HjyVB1nxohXoH4PhKeHq5SqETZDRomAjca3B+WMd+g6F0h8yrRdhw4MxL6rc/zFkMiSX0Yb22URYXSaEIR0aRONZkGgaKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739365647; c=relaxed/simple;
	bh=UoAO9GjW2doCYGuRGY8Y8bf14wyHQN29mYKG8IS0QyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d3Fy6vAIrH0E1PEytr0Ts7VH17PvCr5tlSnQOBrtZEtGrdGvlgPR6oB1+pu+DwgeLDsX3qY/EcsB/2vdBbsmWg/3NXruRldiHgRaCySqB015W0DFDMQQ0XGVT0ZQfTSoHZ4w+wNxu4OAACu0DVCzZ2EE4DMN6Cyz+7rzovhKWAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dcDhl7r8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dcDhl7r8"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51C9gNCW015774
	for <iommu@lists.linux.dev>; Wed, 12 Feb 2025 13:07:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gRuPU5MLz6UvJIh9FeNXTscDgCKFwAX6i3T1Y2CbOg8=; b=dcDhl7r8v560eZxp
	Cym9zu8gp6OvQcSAE6DpHGAmiWEnn3ssZR2Tpm7WdYLQ0TqYdr2JPGvB6tDpcNJt
	EmvYx8dtrL40UhKEG0Nka9M6X9YDcByIOHFiF8KAQP9qFEvp3GMEHslE4QzBLfks
	g/2Ps4oxO6mREh3VRiirHF60qu7uohzY1dhBgh5TUE3L9GGquAqtpToIOcGKUpkl
	6Lra6incRkkcMbK1chA0SJ25akNXkGOqWk6hcI81leZrKOY/o3f7JjAO7T0LpQ4Y
	wT4S7MDOqbpba1xk5ssH3JpOAuNUsrITCqg3/VsjrI1XUbTu5GE/YyCUEeguLbJf
	0dvOZA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44rgpghw6c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 12 Feb 2025 13:07:25 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-46a32c5cdbdso2161281cf.1
        for <iommu@lists.linux.dev>; Wed, 12 Feb 2025 05:07:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739365644; x=1739970444;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gRuPU5MLz6UvJIh9FeNXTscDgCKFwAX6i3T1Y2CbOg8=;
        b=uSws+5WRt3cBQFJ8hylxSVyUZOZYK/Um6h0DAahlyCSNLG9QNBi08XuVad1Wy3v5Ra
         tFrZl7gmOInok9OIJNdRoI1tYJ2Pjj2E3jDSh1Rs8iVDpCaDKorJa7JtfT6ANocXDqHg
         tzeaBGJI1dC1XSIUoDGXBWELUJiFvsw7SgQ12nCulg+abf5qIN99G6O6hvfmsTv7eY4I
         zJPNU1V57VcZmnl6Ri7CdCjFRezggUKtV76T+Ifw6C5I8dqrVAAnFmjxRDawn/vcVnKX
         2IaV54K1MRZDRgdrB+YwMmCldOH9GJkmYvy2vvjK4C+hhk1G6Y7Tyu+Y/Of4mF3VcwCL
         44XA==
X-Forwarded-Encrypted: i=1; AJvYcCURZ2Y3qbv4CRjz6A2xUQQRakBP90D3Zhkr6ldI9eWz9a3745CODVXXkfrfwhSeePo4d1gNgA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzQEMMgDpQ+MV+d5r86Mk2RPRBJz2H3sgB0AFccp/bvBwOg41PB
	5pBRfMHL9HZZgC+JthenR9V7sJiGvPK/KloWKFf3LQjQSC3w3rrdqwGZk2z6lWt8ZtrUJPUNWTn
	srhFUS00zSdJ0jv8Vb8dd5qX6vkgw1IdcWIgZy0k7+BIU+BTDGNb49Q==
X-Gm-Gg: ASbGncuSvztr5n+PekNDXs4dfLjmzz0Wo4oTf9TODbCMjlFuUgBnboa0H594pAfYfqW
	3WOCC6DQ6jo+o8pMNJpJL+d62exHrobUYgCrHQHzCJ7Sn81qZn0TEJwsk1I7FMBBazvE7/cX8gP
	iI+4suYIiQDWslVt6DF2LAkTyeqaCy5cvqE1sBifOi2UKq9Kft1GOcSCURgsJxJiqV8KSqH6hHb
	UWfkRiCpu1Jb8KV+0MlY8qbRbTPmAAbZBHgBy2wtdCRPQxf44QDPdlYNngytLumv5AdaUBlNigi
	Lt8JY4LxkFNF90310w3mpyaEhdBAlwHtXdZS0beVblQjWKy3cJRYdY4HQvU=
X-Received: by 2002:ac8:5e12:0:b0:461:6599:b9a with SMTP id d75a77b69052e-471afed742emr16227311cf.11.1739365643679;
        Wed, 12 Feb 2025 05:07:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGCA7giG/gMWBnfeZO8qNqAYL1V7WqLfjH9to4onOJOTmpMIsvYAtGlEa5pxRnxYvlkUj5Q3Q==
X-Received: by 2002:ac8:5e12:0:b0:461:6599:b9a with SMTP id d75a77b69052e-471afed742emr16227051cf.11.1739365642987;
        Wed, 12 Feb 2025 05:07:22 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7dca728fcsm350960766b.166.2025.02.12.05.07.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 05:07:22 -0800 (PST)
Message-ID: <7664b71c-ed47-4765-9ac4-5dbe3ec80d3c@oss.qualcomm.com>
Date: Wed, 12 Feb 2025 14:07:19 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] arm64: dts: qcom: Add initial support for MSM8937
To: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        =?UTF-8?Q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>,
        Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, iommu@lists.linux.dev,
        Dang Huynh <danct12@riseup.net>
References: <20250211-msm8937-v1-0-7d27ed67f708@mainlining.org>
 <20250211-msm8937-v1-8-7d27ed67f708@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250211-msm8937-v1-8-7d27ed67f708@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 6efQwLOOmDjosESfCAI9dRDwtQGDhlpL
X-Proofpoint-GUID: 6efQwLOOmDjosESfCAI9dRDwtQGDhlpL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_04,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxlogscore=999
 priorityscore=1501 mlxscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502120101

On 11.02.2025 11:37 PM, Barnabás Czémán wrote:
> From: Dang Huynh <danct12@riseup.net>
> 
> Add initial support for MSM8937 SoC.
> 
> Signed-off-by: Dang Huynh <danct12@riseup.net>
> Co-developed-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---

So the computer tells me 8917 and 8937 are *very* similar. Have you
tried assessing how making 8937.dtsi an overlay atop 8917.dtsi would
work out?


>  arch/arm64/boot/dts/qcom/msm8937.dtsi | 2145 +++++++++++++++++++++++++++++++++
>  1 file changed, 2145 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8937.dtsi b/arch/arm64/boot/dts/qcom/msm8937.dtsi
> new file mode 100644
> index 0000000000000000000000000000000000000000..ef633c1694ad98165e58130cbeb186d2f0e2dcaa
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8937.dtsi
> @@ -0,0 +1,2145 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2023, Dang Huynh <danct12@riseup.net>
> + */
> +
> +#include <dt-bindings/clock/qcom,gcc-msm8917.h>
> +#include <dt-bindings/clock/qcom,rpmcc.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/power/qcom-rpmpd.h>
> +#include <dt-bindings/thermal/thermal.h>
> +
> +/ {
> +	interrupt-parent = <&intc>;
> +
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	clocks {
> +		xo_board: xo-board {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +		};
> +
> +		sleep_clk: sleep-clk {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +		};
> +	};
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu4: cpu@0 {

I'm pretty sure a CPU with a MPIDR of 0 should be called CPU0

> +			compatible = "arm,cortex-a53";
> +			reg = <0x0>;
> +			device_type = "cpu";
> +			enable-method = "psci";
> +			operating-points-v2 = <&cpu_opp_table_c0>;
> +			next-level-cache = <&l2_0>;
> +			#cooling-cells = <2>;
> +			l2_0: l2-cache {

Please add a newline between the last property and the subnode

> +				compatible = "cache";
> +				cache-level = <2>;

cache-size = <0x80000>;

[...]

> +		cpu0: cpu@100 {
> +			compatible = "arm,cortex-a53";
> +			reg = <0x100>;
> +			device_type = "cpu";
> +			next-level-cache = <&l2_1>;
> +			enable-method = "psci";
> +			operating-points-v2 = <&cpu_opp_table_c1>;
> +			#cooling-cells = <2>;
> +			power-domains = <&cpu_pd0>;
> +			power-domain-names = "psci";
> +			l2_1: l2-cache {
> +				compatible = "cache";
> +				cache-level = <2>;

cache-size = <0x100000>;

I'll do further review if you decide it makes sense to keep this
separate from 8917

Konrad
