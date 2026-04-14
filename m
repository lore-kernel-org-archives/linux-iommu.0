Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E912E54A3
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 09:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776160028; cv=none; b=n5NL//tEw0AM8MNn4BX8bGSCaBA7zkGtEtUChbM8u1t94mNg0ra1Ek1iLNo+mnQV03tE4XC6Oik0qxM+NOpUK84Grpz0ZMGhxdAMA27Qy8c7QCHYvR1k9uwNICFH7MSpvyzwbmkBrnPtzl74qyJ2sL1DfH/sRIweHx8i2JVBLoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776160028; c=relaxed/simple;
	bh=bjuwUPJGb9fXauot3dZqpj3OmjYfw9KmiKsmItE1Hr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qcko9MJ3/pvuwny+zyT39GzA/Yd44P0TW1Pfdug7IgO1YZ2DN/C34x9C+GUssqtReVB14CXOdX5P9H4j6aky5bpZKuExVOxmjtANkxj6Nsx4gzhrkMVUZiidO3+OkIdBS/VUBRHPBDnCFFCA1GI7Uoz/kNwgYFGPLXbkbkiw0rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PXsKBTM2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KxTjSEA6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PXsKBTM2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KxTjSEA6"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63E6VoCk2633460
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 09:47:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	F42C15/5cFyYzvnToR9Xb100FwBKpqaf4bheTzT88hQ=; b=PXsKBTM2lmiMQFU8
	wZ3kMKj13svV0ITG3z/mbJbStjTyMVqiUmy/BwsAQaAw5bScJhH63U2D15e+esKr
	1XWrNSm0LrnMIFc2SUmrcXTKm73TPo+ywwMrpsBuZtc0emEorRnK7yB+RJaoyNeO
	mcY19v4TIqxzQFF1HP2QmoM5vxTra0f6VYYKld1K6GCQ3uFU265AXsVDEQWhvHCZ
	hjSr59Ky2tyH72V/Qd1xEcDCFtxdTniVEuCEYLdsPW2b32qYy2rEO+Yum53ay9KZ
	cuf9QIL28nOszEKv5OMwls92jQaVJslxVTwFVfkzdnSkyzpLj7xkWPHG6S0YF8MH
	IcBDVA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh86ca560-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 09:47:06 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35d9f68d00fso10594556a91.2
        for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 02:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776160026; x=1776764826; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F42C15/5cFyYzvnToR9Xb100FwBKpqaf4bheTzT88hQ=;
        b=KxTjSEA61G3aNA7AT7bXLcTCtoCDKzzlTWEnadG+/kVWZwZBbJJHWiSF6SkfSGQuVv
         VGEo9ttdqGa9hlPNzn+JsIPzIb7uyvXUGeaXeO9m1hEFKm31RyJY/+IIL1hzmx/3VeLN
         q836JNYpMK3nqHcXwmt+Ate9ha3UtL7r/rND/FJU/yvUD5B3XyUhAUChJQRObo+W2c2h
         KMqY0MIgy5BbGXHXcUFnLYolt78R5DaAf/6leq+If8O+ztducEWB76R8dMYJIBADzVKi
         Vsg7HExp0Dsc5votqDLBVI0NjuDwnLuZcJ5AGRFciYLq4/4EAQCDs0jL0DSDlVDKYcQj
         +CyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776160026; x=1776764826;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F42C15/5cFyYzvnToR9Xb100FwBKpqaf4bheTzT88hQ=;
        b=VkLXjKtDyfauoq9aqlJcp72DCg7UGaRTfQk6kqZo2lD4NcY2DuB8Dv8/WK4EQyRF6z
         82Et68eCa9DmbK+/DExH/vbssUqdyW7zt0Qb8FU7sOWG1lag/rdUUj7vIYsXe4pM9FM1
         uXKx7cRNl4uDdlQ/8tFPGiB2NrWWogJ89M3O1GQFvsEbSj5yIzRzi0feeqvWgn0FVLpK
         p1gicrfrdM8P1p8g/i7PLejMt4+mZVau+zk70cTdylrWJ3jJGaYPKa1XVLH7+CSfQlOh
         9nYVHjq0ez1Lb6ZtyLr/r2OZmyfN8lXy0XSxXUGldcjvfH2rH21incxzSlqXA6apyY39
         AVbQ==
X-Forwarded-Encrypted: i=1; AFNElJ/5veiiY2yARQBTH+jB2/gjUExnRUXYCGZh0vB4ebSUFpmtun++1YASobpVA9vJKuy76NEKgw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyU9K57TXUg49U7uQ5nBjUBnXDUmj4AfyFAKrEd4YHB9Aa2HXS7
	2gRrQKi9+1U23a3DFC3LvCm301v9+1vvZZ4iHm0sP9o44TwrVgprmu7x96GcT2IIMOkcOaHOthL
	UA5g+LbVB8inVii6BLaPEZdzle1TyXYWrpT+Bn/wgUTG0SqLtA+QjlIQ19Q==
X-Gm-Gg: AeBDietyFREGEjRa/sPYPghUz4h1EwIX4IH5Pr0hW5VCNKHgPSvaQ2/tDAuNgUpSF1H
	AxAHZFaOD52IZJIfs29d9RNPgjX2UXiDFtMSbPsXZC9h4hN4aCHbrPIqjxzcRmyiSMbGCligcgO
	V9JX5aOYZAuTiCxmR4N5TODmyKj8Yt3fU8rgDf82wpH7IsVibEIGAJ+Ros62M0sf5TXdh/vdxA1
	IcxIajy8JNQpOoiQI4HCJJNTR2jQIDT0XtnqFXsTwE4HCw0YoTKBA05VNVf0ZYNspU6Rn+KpQ6q
	896k9tox+2hF5ZjEBXtA8DfK7RCXgMohkhlaHNdk5xK0sQuThrZb83qwgtawfGVdSh2tBReJSXv
	2g730+ky/s29tTS6xjVbPXTK9hgqjoHtZMdFT2GLrbV/plFKou+iN5g==
X-Received: by 2002:a17:90a:d607:b0:35d:a90d:580e with SMTP id 98e67ed59e1d1-35e428856dfmr18244253a91.23.1776160023434;
        Tue, 14 Apr 2026 02:47:03 -0700 (PDT)
X-Received: by 2002:a17:90a:d607:b0:35d:a90d:580e with SMTP id 98e67ed59e1d1-35e428856dfmr18244215a91.23.1776160022898;
        Tue, 14 Apr 2026 02:47:02 -0700 (PDT)
Received: from [10.206.105.200] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35fc6e78168sm1520481a91.12.2026.04.14.02.46.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 02:47:02 -0700 (PDT)
Message-ID: <9ac01a3a-1ce2-373d-33be-1c10853604c3@oss.qualcomm.com>
Date: Tue, 14 Apr 2026 15:16:53 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 01/11] dt-bindings: media: qcom,glymur-iris: Add glymur
 video codec
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev
References: <20260414-glymur-v1-0-7d3d1cf57b16@oss.qualcomm.com>
 <20260414-glymur-v1-1-7d3d1cf57b16@oss.qualcomm.com>
 <20260414-lush-reindeer-of-storm-bbe918@quoll>
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
In-Reply-To: <20260414-lush-reindeer-of-storm-bbe918@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: vMyoPAa-vWEJIP_7Q99JtYhNCilGTqmV
X-Authority-Analysis: v=2.4 cv=RoH16imK c=1 sm=1 tr=0 ts=69de0d1a cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=J1jT_auZRQXyn7_S9LoA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDA5MSBTYWx0ZWRfX9NkcSKK+8mXr
 tDpOB24gTnt2J52cM23Jpfa+W4gg9lT9XYCH2yH1o4pMb3hW1x7NfayEHDp4MVpAZN/yI3DwGBN
 yUtZhUs9r7r1PiWAH+CI2UW5wW/tTNSFkN2iShPLdl5vChPYwWxz87nNhcXaPxJuwVJ7lIXMbU+
 6q9dFG0MJzGWZvGgfpOL3ejaB6sek7qqWBTqJ9YOTGPxyipuaJs6evnu52ZuX+igTgzeybnVpHc
 cQ5tl+dgcgqPMfqnKTZ9x7yam+PLvm30PKA5unO07prIy5hWTrDCwdJWqxHI3cQ4tjVFqJiNryt
 Dzy4SVYHhlFj622a2DxNnM89J9WjLfFTwoNm5amjKd4K9vrIgsm0zWESeMEI+IBkxC77ElFeTOf
 +Em4osjVJRuevuDYbsqnfh6gFGd27FR6gzZ6moGPCUB/Gdl8CMW6Jxpi0xKI50mh3EWTq5/aVhW
 ByBwf2BoCGGCmyfWg5Q==
X-Proofpoint-GUID: vMyoPAa-vWEJIP_7Q99JtYhNCilGTqmV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_02,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140091


On 4/14/2026 12:55 PM, Krzysztof Kozlowski wrote:
> On Tue, Apr 14, 2026 at 10:29:57AM +0530, Vishnu Reddy wrote:
>> Add device tree binding for the Qualcomm Glymur Iris video codec. Glymur
>> is a new generation of video IP that introduces a dual-core architecture.
>> The second core brings its own power domain, clocks, and reset lines,
>> requiring additional power domains and clocks in the power sequence.
>>
>> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>> ---
>>   .../bindings/media/qcom,glymur-iris.yaml           | 220 +++++++++++++++++++++
>>   include/dt-bindings/media/qcom,glymur-iris.h       |  11 ++
>>   2 files changed, 231 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/media/qcom,glymur-iris.yaml b/Documentation/devicetree/bindings/media/qcom,glymur-iris.yaml
>> new file mode 100644
>> index 000000000000..10ee02cd1a7d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/media/qcom,glymur-iris.yaml
>> @@ -0,0 +1,220 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/media/qcom,glymur-iris.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm Glymur SoC Iris video encoder and decoder
>> +
>> +maintainers:
>> +  - Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>> +
>> +description:
>> +  The Iris video processing unit on Qualcomm Glymur SoC is a video encode and
>> +  decode accelerator.
>> +
>> +properties:
>> +  compatible:
>> +    const: qcom,glymur-iris
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 9
>> +
>> +  clock-names:
>> +    items:
>> +      - const: iface
>> +      - const: core
>> +      - const: vcodec0_core
> iface1 goes here
> core_freerun
> vcodec0_core_freerun
> and the rest, based on sm8750. Or which previous variant did you use as
> the base?
Ack, will use sm8750 as base and I'll update.
Thanks for the suggestion.
>
>> +      - const: iface_ctrl
>> +      - const: core_freerun
>> +      - const: vcodec0_core_freerun
>> +      - const: iface1
>> +      - const: vcodec1_core
>> +      - const: vcodec1_core_freerun
>> +
>> +  dma-coherent: true
>> +
>> +  firmware-name:
>> +    maxItems: 1
>> +
>> +  interconnects:
>> +    maxItems: 2
>> +
>> +  interconnect-names:
>> +    items:
>> +      - const: cpu-cfg
>> +      - const: video-mem
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  iommus:
>> +    maxItems: 4
>> +
>> +  iommu-map:
>> +    maxItems: 1
>> +
>> +  memory-region:
>> +    maxItems: 1
>> +
>> +  operating-points-v2: true
>> +  opp-table:
>> +    type: object
>> +
>> +  power-domains:
>> +    maxItems: 5
>> +
>> +  power-domain-names:
>> +    items:
>> +      - const: venus
>> +      - const: vcodec0
>> +      - const: mxc
>> +      - const: mmcx
>> +      - const: vcodec1
>> +
>> +  resets:
>> +    maxItems: 6
>> +
>> +  reset-names:
>> +    items:
>> +      - const: bus0
> bus1
> core
> vcodec0_core
Ack
>
>> +      - const: bus_ctrl
>
>> +      - const: core
>> +      - const: vcodec0_core
>> +      - const: bus1
>> +      - const: vcodec1_core
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - clock-names
>> +  - dma-coherent
>> +  - interconnects
>> +  - interconnect-names
>> +  - interrupts
>> +  - iommus
>> +  - memory-region
>> +  - power-domains
>> +  - power-domain-names
>> +  - resets
>> +  - reset-names
>> +
>> +unevaluatedProperties: false
> Use existing, most recent code as starting point.
Ack, will use sm8750.
>
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/media/qcom,glymur-iris.h>
>> +    #include <dt-bindings/power/qcom,rpmhpd.h>
>> +
>> +    video-codec@aa00000 {
>> +        compatible = "qcom,glymur-iris";
>> +        reg = <0x0aa00000 0xf0000>;
>> +
>> +        clocks = <&gcc_video_axi0_clk>,
>> +                 <&videocc_mvs0c_clk>,
>> +                 <&videocc_mvs0_clk>,
>> +                 <&gcc_video_axi0c_clk>,
>> +                 <&videocc_mvs0c_freerun_clk>,
>> +                 <&videocc_mvs0_freerun_clk>,
>> +                 <&gcc_video_axi1_clk>,
>> +                 <&videocc_mvs1_clk>,
>> +                 <&videocc_mvs1_freerun_clk>;
>> +        clock-names = "iface",
>> +                      "core",
>> +                      "vcodec0_core",
>> +                      "iface_ctrl",
>> +                      "core_freerun",
>> +                      "vcodec0_core_freerun",
>> +                      "iface1",
>> +                      "vcodec1_core",
>> +                      "vcodec1_core_freerun";
>> +
>> +        dma-coherent;
>> +
>> +        interconnects = <&hsc_noc_master_appss_proc &config_noc_slave_venus_cfg>,
>> +                        <&mmss_noc_master_video &mc_virt_slave_ebi1>;
>> +        interconnect-names = "cpu-cfg",
>> +                             "video-mem";
>> +
>> +        interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
>> +
>> +        iommus = <&apps_smmu 0x1940 0x0>,
>> +                 <&apps_smmu 0x1943 0x0>,
>> +                 <&apps_smmu 0x1944 0x0>,
>> +                 <&apps_smmu 0x19e0 0x0>;
>> +
>> +        iommu-map = <IRIS_FIRMWARE &apps_smmu 0x19e2 0x1>;
>> +
>> +        memory-region = <&video_mem>;
>> +
>> +        operating-points-v2 = <&iris_opp_table>;
>> +
>> +        power-domains = <&videocc_mvs0c_gdsc>,
>> +                        <&videocc_mvs0_gdsc>,
>> +                        <&rpmhpd RPMHPD_MXC>,
>> +                        <&rpmhpd RPMHPD_MMCX>,
>> +                        <&videocc_mvs1_gdsc>;
>> +        power-domain-names = "venus",
>> +                             "vcodec0",
>> +                             "mxc",
>> +                             "mmcx",
>> +                             "vcodec1";
>> +
>> +        resets = <&gcc_video_axi0_clk_ares>,
>> +                 <&gcc_video_axi0c_clk_ares>,
>> +                 <&videocc_mvs0c_freerun_clk_ares>,
>> +                 <&videocc_mvs0_freerun_clk_ares>,
>> +                 <&gcc_video_axi1_clk_ares>,
>> +                 <&videocc_mvs1_freerun_clk_ares>;
>> +        reset-names = "bus0",
>> +                      "bus_ctrl",
>> +                      "core",
>> +                      "vcodec0_core",
>> +                      "bus1",
>> +                      "vcodec1_core";
>> +
>> +        iris_opp_table: opp-table {
>> +            compatible = "operating-points-v2";
>> +
>> +            opp-240000000 {
>> +                opp-hz = /bits/ 64 <240000000 240000000 360000000>;
>> +                required-opps = <&rpmhpd_opp_svs>,
>> +                                <&rpmhpd_opp_low_svs>;
>> +            };
>> +
>> +            opp-338000000 {
>> +                opp-hz = /bits/ 64 <338000000 338000000 507000000>;
>> +                required-opps = <&rpmhpd_opp_svs>,
>> +                                <&rpmhpd_opp_svs>;
>> +            };
>> +
>> +            opp-366000000 {
>> +                opp-hz = /bits/ 64 <366000000 366000000 549000000>;
>> +                required-opps = <&rpmhpd_opp_svs_l1>,
>> +                                <&rpmhpd_opp_svs_l1>;
>> +            };
>> +
>> +            opp-444000000 {
>> +                opp-hz = /bits/ 64 <444000000 444000000 666000000>;
>> +                required-opps = <&rpmhpd_opp_svs_l1>,
>> +                                <&rpmhpd_opp_nom>;
>> +            };
>> +
>> +            opp-533333334 {
>> +                opp-hz = /bits/ 64 <533333334 533333334 800000000>;
>> +                required-opps = <&rpmhpd_opp_svs_l1>,
>> +                                <&rpmhpd_opp_turbo>;
>> +            };
>> +
>> +            opp-655000000 {
>> +                opp-hz = /bits/ 64 <655000000 655000000 982000000>;
>> +                required-opps = <&rpmhpd_opp_nom>,
>> +                                <&rpmhpd_opp_turbo_l1>;
>> +            };
>> +        };
>> +    };
>> diff --git a/include/dt-bindings/media/qcom,glymur-iris.h b/include/dt-bindings/media/qcom,glymur-iris.h
>> new file mode 100644
>> index 000000000000..5766db0b9247
>> --- /dev/null
>> +++ b/include/dt-bindings/media/qcom,glymur-iris.h
>> @@ -0,0 +1,11 @@
>> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
>> +/*
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + */
>> +
>> +#ifndef _DT_BINDINGS_MEDIA_QCOM_GLYMUR_IRIS_H_
>> +#define _DT_BINDINGS_MEDIA_QCOM_GLYMUR_IRIS_H_
>> +
>> +#define IRIS_FIRMWARE	0
> For what is this define? IOMMU map? Binding is quiet about it, so
> probably this should have some prefix to make it obvious.
> IOMMU_? DEV_? What does this define express?

It's a function ID. I'll add prefix like this IOMMU_FID_IRIS_FIRMWARE.

Thanks,
Vishnu Reddy

>
> Best regards,
> Krzysztof
>
