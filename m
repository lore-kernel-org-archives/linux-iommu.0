Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539F92EE611
	for <iommu@lists.linux.dev>; Sat,  9 May 2026 16:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778345893; cv=none; b=pmJHdJWSg2nWAk8jPVZP47e03QjmdTCZVNxyztsgppMiA7324yo2GamMThl8TyQ5m/KhD2lxplv5x3Cu3SCxuIc7KoB4yvHADHmLvSLSlW4sWncHLIndHL159ylTsHH+sA22Zx5Q5z0fw18IEemqCcteIJ5G4OlvUhH9ppZIpqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778345893; c=relaxed/simple;
	bh=WNTc0OGO2a4taecvbw4qU+LYVnU1uXeaDf9Wyp0bAOE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FPoqH1p+cYjvCeospr8bZp6lAiHruktOufzQ6e2/fGtQyL/EE3zEdqmgDng2sJ3T0yTI3ZzY2H93DYvxwXVmqOCom2/8/tpn/ZPXPUf61HCHHl72yYfC1g7a/LFWgzUhe5Z/ele7V0yQnfHveZz0VAr/LYd3YRyyrhiqozwytz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GGwKaC+2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Jr34Trm/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GGwKaC+2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Jr34Trm/"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6493Poe62089517
	for <iommu@lists.linux.dev>; Sat, 9 May 2026 16:58:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aG81+2i+7FJNAObHDDs20lBo/zkXJ9T+aw/fqgDq/mE=; b=GGwKaC+2k6E2YZ7J
	dtwr1lKS/PsHv+vQ7zpR4RDncYap1jlbTL50665hbiCqZa6LOTAU874d2yCAxRbv
	aSdWaqS+0GL4DihkQ/Uevpa4kpaehth/jG/LIUroyNfqjwvLQvBMYx6abr9PHeY/
	ZpEJJ+yZBvtyNDBoVRCK3NENvSPyYforSwWYwli7+6oUnMn+GSy0BWYb53ly+5Co
	VSK3o1NB0i0yISa/klcRo/Wzz6p9VRzwh6JLQAonXjGN9Bn3We87ss+OvDh5F9AV
	Hy+41KrfSocn4D3r9A+Gana0OBgJanSL8L4ND8wXO6YEVKt4KNqoWYKmfCmg+9Hc
	wrAP6w==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1w0uhb5v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sat, 09 May 2026 16:58:11 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-36629e48023so3265887a91.2
        for <iommu@lists.linux.dev>; Sat, 09 May 2026 09:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778345890; x=1778950690; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aG81+2i+7FJNAObHDDs20lBo/zkXJ9T+aw/fqgDq/mE=;
        b=Jr34Trm/AjYAHKkecqc2vBYOJUqqsEckx69/uRs9ro0RnFgN/LShxX6BBSlBH1j/fj
         ky3vh0GVb4yypFR7uN2+RJxhH4UmUXgmJfLJtAoNfm6DAIR0NdRqPGXmXlXiMZTi5cJv
         uFpS1RdBTBOVK4ayKXQgqULUEZYPmkPQPobsdQXOZzzjuNKLNI89IXCBNL/FCUXjCiUC
         LmWohZ2Pvx8oYt3bSXZwB6NfX+CZ6WoTl+Kzn21f3o193qQTq/GOHgxip19EceC6oZtl
         u59zGu5ruEmdsRgAwqw33x8vu3DKTdlY70mdrVyf2XgIZ3hExZTSjjUOstzDVa2O3w9C
         /0QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778345890; x=1778950690;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aG81+2i+7FJNAObHDDs20lBo/zkXJ9T+aw/fqgDq/mE=;
        b=JDv6wHptH21xUPrHTKS76zmfa3Vs0GyIqEcRc8qJJGE04DRKesHAwE8mtGLLf36PIN
         sAhMD0H9v+Ir4R/dWqjvJNM3Al5/y2hGExMbWKkCjvoBOgh64de4a/EevR8+qpLQ7XVt
         NF07zQfqUW72xsDeglnzJSr4StxbV3MLYhVdUGNb8ndPZhX8I5Q+P36m0asDSWAr0EZk
         +qCbpw8R8zVY80MGVKF68s2kSSzZqau4BbBQZCdwb/uR/0CIUpwLYM5QoJhatz5DayIz
         XtDLFLdA6zZNVlNcde/EB3BrcGhhFhphCdyn47ksjx951rE05NJMfAXJbblLkZVvSf8Z
         uQaQ==
X-Forwarded-Encrypted: i=1; AFNElJ+dvdOXEC4IK066oN+5XC/dapLG7GZ3dr8MplfVHeN8AVxXg1lS8CVDcD0EAwzj/reK6MQm/Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyRz+kbe38Zs/Sd4BFeyKsUR3Ib1QUWIGzA6IHns9wyeImAxCzR
	ksVsoVsJicPNwPRHHMlC63xJK7B/2LiArvlLgvuc6mEGWUY80K1G5bVMvuNhlG9U0KU89CYOzyD
	s9NgefoJg+vinzQsW5M4huDdYD3w2kBe9hnFMQok0CuhbhEk4cEKgveEhvA==
X-Gm-Gg: Acq92OEgWQ4NxNux5Cb2eabGXh3jISgdxk4anTiBqd/PmRovubWxZGlT+jnND0heck0
	qq9/myRLALK67t/bfCDxRVqm3g2z8gjc173fU7a7MKRDBVLRtu9szT7NjYi3ip64mT9qrv8eLOQ
	R5gCx8FOXSCjJE5hCAIJQjX+jwHl3zr/2fRmuoR9VUhY5mKnCro3MfUBcWu5z4/Ke+ehqrf5rCo
	+anwWdvHqeLmjpd4AUdr1zFlGNoO2b6GNmZT7CHZq5WYMymZrBcI39PHRlm8nDnrZgq5yp3pgvG
	h/Ox7iBJ8UE++Qu12lpEKJ18mLYUyLcNrXYMSDLiPXRmvA0pIGfSjygIWDRoIvARe7zmYc9Nlb/
	j7Kz/47icb/oGOCWc+i6XYxUpxOu5BFlxmdEdyIsz67DmTiTuYtA=
X-Received: by 2002:a17:90b:5603:b0:366:479c:59de with SMTP id 98e67ed59e1d1-366479c5db9mr8171396a91.8.1778345890007;
        Sat, 09 May 2026 09:58:10 -0700 (PDT)
X-Received: by 2002:a17:90b:5603:b0:366:479c:59de with SMTP id 98e67ed59e1d1-366479c5db9mr8171370a91.8.1778345889474;
        Sat, 09 May 2026 09:58:09 -0700 (PDT)
Received: from [192.168.0.9] ([49.205.255.40])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e35632sm58541735ad.53.2026.05.09.09.58.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 May 2026 09:58:08 -0700 (PDT)
Message-ID: <34962003-c54c-a64a-2846-8f741fec5802@oss.qualcomm.com>
Date: Sat, 9 May 2026 22:26:49 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Subject: Re: [PATCH v5 13/14] arm64: dts: qcom: glymur: Add iris video node
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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
        Conor Dooley
 <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org
References: <20260509-glymur-v5-0-7fbb340c5dbd@oss.qualcomm.com>
 <20260509-glymur-v5-13-7fbb340c5dbd@oss.qualcomm.com>
 <b36tyrznuwwjiya4lt2ajqbyopnonvubedpofasmzknwjd2mrs@eenc4epvbokm>
Content-Language: en-US
In-Reply-To: <b36tyrznuwwjiya4lt2ajqbyopnonvubedpofasmzknwjd2mrs@eenc4epvbokm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: UdigJ1eW37--plkE45iKoKZicCGelQDp
X-Authority-Analysis: v=2.4 cv=asaCzyZV c=1 sm=1 tr=0 ts=69ff67a3 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=SpcZ+gRb+6o1zy8jT5J+bQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=tcww-dwagKCKl4DpuMYA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: UdigJ1eW37--plkE45iKoKZicCGelQDp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA5MDE4NCBTYWx0ZWRfX1fNxXLuA0P9t
 QdhX3x+UY3rvC39nhhD3k2eXQAdnrj6VPe1cbfbVdh/0doZAnojsET+hiPv2WYYNUJmMvs83tKJ
 IC8ESKanKvzA8I8HVqZUhsD1VArHLKz0RWS0DQ1RhKUDM7nRNW09m28nBiVRJwi8X+mMIYYPkX8
 yIUx42d1rOywQF1WanNPSmuPkf6wP6utIS7+Ivds0ddtZZqn78EKb8zfJVVt0Z3dyIeowqMoCtn
 EP1T+92VantZLLZ5yF/V8ya+OCD1kSALm0vDnv6d27RmeauG6LeaTxM48xmNkoekQrGDsnEPZQV
 VSMBypR0pQ4tJMAZ31POb/K0FJGcqcnR7msLMqAESMn7reDArPqztZFheZqN08T4y93E8mvcHA8
 G456oC/holcVWcg3guKmshhwn3W7xFSM0sRveF+mgfE7Up7nQRrXy+gBs8IVZG4tFHUvAFkPLgK
 /6jClqEH9QwlJ6xOFRg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-09_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605090184


On 5/9/2026 12:57 AM, Dmitry Baryshkov wrote:
> On Sat, May 09, 2026 at 12:30:02AM +0530, Vishnu Reddy wrote:
>> Add iris video codec to glymur SoC, which comes with significantly
>> different powering up sequence than previous platforms, thus different
>> clocks and resets.
>>
>> Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>> ---
>>  arch/arm64/boot/dts/qcom/glymur.dtsi | 118 +++++++++++++++++++++++++++++++++++
>>  1 file changed, 118 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
>> index f23cf81ddb77..c47443174f97 100644
>> --- a/arch/arm64/boot/dts/qcom/glymur.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
>> @@ -13,6 +13,7 @@
>>  #include <dt-bindings/interconnect/qcom,glymur-rpmh.h>
>>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>>  #include <dt-bindings/mailbox/qcom-ipcc.h>
>> +#include <dt-bindings/media/qcom,glymur-iris.h>
>>  #include <dt-bindings/phy/phy-qcom-qmp.h>
>>  #include <dt-bindings/power/qcom,rpmhpd.h>
>>  #include <dt-bindings/power/qcom-rpmpd.h>
>> @@ -4163,6 +4164,123 @@ usb_mp: usb@a400000 {
>>  			status = "disabled";
>>  		};
>>  
>> +		iris: video-codec@aa00000 {
>> +			compatible = "qcom,glymur-iris";
>> +			reg = <0x0 0xaa00000 0x0 0xf0000>;
>> +
>> +			clocks = <&gcc GCC_VIDEO_AXI0_CLK>,
>> +				 <&videocc VIDEO_CC_MVS0C_CLK>,
>> +				 <&videocc VIDEO_CC_MVS0_CLK>,
>> +				 <&gcc GCC_VIDEO_AXI0C_CLK>,
>> +				 <&videocc VIDEO_CC_MVS0C_FREERUN_CLK>,
>> +				 <&videocc VIDEO_CC_MVS0_FREERUN_CLK>,
>> +				 <&gcc GCC_VIDEO_AXI1_CLK>,
>> +				 <&videocc VIDEO_CC_MVS1_CLK>,
>> +				 <&videocc VIDEO_CC_MVS1_FREERUN_CLK>;
>> +			clock-names = "iface",
>> +				      "core",
>> +				      "vcodec0_core",
>> +				      "iface1",
> I first wrote the comment regarding resets. But the clocks seem to have
> the same pattern. It's not just "iface1" clock. It's the clock for one
> of the cores. And there is another clock for another core. Please make
> that nicely named.

In v1, I used iface_ctrl to reflect the clock purpose, but received the
feedback [1] to align with the iface1 naming convention used on earlier
platforms.

[1] https://lore.kernel.org/all/20260414-lush-reindeer-of-storm-bbe918@quoll/

>> +				      "core_freerun",
>> +				      "vcodec0_core_freerun",
>> +				      "iface2",
>> +				      "vcodec1_core",
>> +				      "vcodec1_core_freerun";
>> +
>> +			dma-coherent;
>> +
>> +			interconnects = <&hsc_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
>> +					 &config_noc SLAVE_VENUS_CFG QCOM_ICC_TAG_ACTIVE_ONLY>,
>> +					<&mmss_noc MASTER_VIDEO QCOM_ICC_TAG_ALWAYS
>> +					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
>> +			interconnect-names = "cpu-cfg",
>> +					     "video-mem";
>> +
>> +			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
>> +
>> +			iommus = <&apps_smmu 0x1940 0x0>,
>> +				 <&apps_smmu 0x1943 0x0>,
>> +				 <&apps_smmu 0x1944 0x0>,
>> +				 <&apps_smmu 0x19e0 0x0>;
>> +
>> +			iommu-map = <IOMMU_FID_IRIS_FIRMWARE &apps_smmu 0x19e2 0x1>;
>> +
>> +			memory-region = <&video_mem>;
>> +
>> +			operating-points-v2 = <&iris_opp_table>;
>> +
>> +			power-domains = <&videocc VIDEO_CC_MVS0C_GDSC>,
>> +					<&videocc VIDEO_CC_MVS0_GDSC>,
>> +					<&rpmhpd RPMHPD_MXC>,
>> +					<&rpmhpd RPMHPD_MMCX>,
>> +					<&videocc VIDEO_CC_MVS1_GDSC>;
>> +			power-domain-names = "venus",
>> +					     "vcodec0",
>> +					     "mxc",
>> +					     "mmcx",
>> +					     "vcodec1";
>> +
>> +			resets = <&gcc GCC_VIDEO_AXI0_CLK_ARES>,
>> +				 <&gcc GCC_VIDEO_AXI0C_CLK_ARES>,
>> +				 <&videocc VIDEO_CC_MVS0C_FREERUN_CLK_ARES>,
>> +				 <&videocc VIDEO_CC_MVS0_FREERUN_CLK_ARES>,
>> +				 <&gcc GCC_VIDEO_AXI1_CLK_ARES>,
>> +				 <&videocc VIDEO_CC_MVS1_FREERUN_CLK_ARES>;
>> +			reset-names = "bus0",
>> +				      "bus1",
> The names of the resets suggest that there is single "common" reset and
> then one reset per each core.

Two resets for controller and two resets for each per vcodec core.

>> +				      "core",
>> +				      "vcodec0_core",
>> +				      "bus2",
>> +				      "vcodec1_core";
> Are there two codecs? Or are there two cores? Your naming suggests the
> former case.

Two vcodec cores.

>> +
>> +			/*
>> +			 * IRIS firmware is signed by vendors, only
>> +			 * enable on boards where the proper signed firmware
>> +			 * is available.
>> +			 */
>> +			status = "disabled";
>> +
>> +			iris_opp_table: opp-table {
>> +				compatible = "operating-points-v2";
>> +
>> +				opp-240000000 {
>> +					opp-hz = /bits/ 64 <240000000 240000000 360000000>;
>> +					required-opps = <&rpmhpd_opp_svs>,
>> +							<&rpmhpd_opp_low_svs>;
>> +				};
>> +
>> +				opp-338000000 {
>> +					opp-hz = /bits/ 64 <338000000 338000000 507000000>;
>> +					required-opps = <&rpmhpd_opp_svs>,
>> +							<&rpmhpd_opp_svs>;
>> +				};
>> +
>> +				opp-366000000 {
>> +					opp-hz = /bits/ 64 <366000000 366000000 549000000>;
>> +					required-opps = <&rpmhpd_opp_svs_l1>,
>> +							<&rpmhpd_opp_svs_l1>;
>> +				};
>> +
>> +				opp-444000000 {
>> +					opp-hz = /bits/ 64 <444000000 444000000 666000000>;
>> +					required-opps = <&rpmhpd_opp_svs_l1>,
>> +							<&rpmhpd_opp_nom>;
>> +				};
>> +
>> +				opp-533333334 {
>> +					opp-hz = /bits/ 64 <533333334 533333334 800000000>;
>> +					required-opps = <&rpmhpd_opp_svs_l1>,
>> +							<&rpmhpd_opp_turbo>;
>> +				};
>> +
>> +				opp-655000000 {
>> +					opp-hz = /bits/ 64 <655000000 655000000 982000000>;
>> +					required-opps = <&rpmhpd_opp_nom>,
>> +							<&rpmhpd_opp_turbo_l1>;
>> +				};
>> +			};
>> +		};
>> +
>>  		mdss: display-subsystem@ae00000 {
>>  			compatible = "qcom,glymur-mdss";
>>  			reg = <0x0 0x0ae00000 0x0 0x1000>;
>>
>> -- 
>> 2.34.1
>>
