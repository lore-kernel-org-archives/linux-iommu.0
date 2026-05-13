Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC383B4EA7
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 18:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778698602; cv=none; b=jxRkjq+y8Pp04JkTjaQgTC2vtpHuRiR5k1k5GavfQ4R2+N6UUurSfceJNnkKN3FhYFuKXVcN9fbXVJzP+1eZFdQ45M3gvX2+K8i3qkPxL2Sf+LiKDUtC+bCODSnstcScwgvjoIlSaHoszivwwG9PynO31/pNIf4bvyFOqY1y6M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778698602; c=relaxed/simple;
	bh=eMaxSssrKXUgRzUyVQt+S4DMHw1WIfhBoG+u9IXyTH4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=i9W7eh7uTHSmzrlIfZFMMHnFk9ADblTU4yvU5PaNs6Txi/1LQwW/1Ymcm0ftWlUL02BRr9Omf2jiaDLV6ArpqUWhXIKs5qFxJuR+7GHDC122OXbuXgviCZPmfe7kMnzAqXeAKy359ud9KLlJcVvKwozQO2J1mCYmOnlugLJrcAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KbX6Gx6n; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Atx5lGbT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KbX6Gx6n";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Atx5lGbT"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DGuhau3996209
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 18:56:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rmVE04cdLbc/FMe/QPBHI2itToGW2Cie+k5fJeV+/zM=; b=KbX6Gx6nu+6oQDtA
	xDpcwi2Ff9kzcz/ugu9TGI9MPdfFCseOoa0iimBOnOnBNdDDadu7n+7LmhqpRRbR
	TZstSP0maQ76ss4V9H79SXzJlXkFIb1s74/iO2rvmpinZYm74lwE83egUnRjU+xD
	km35ucMcbUmA8dxolc1brOxT+I3AS8uPzjzj6+LgpUVwts/j5BoT9sSiKnsF66Al
	cNf5LVQ0Vg0Sbmif3Hiaq23ZUgrlMe4yp8KPSJpel6BBVAEqdN+DqgsPseS1NNrx
	BWc1ZOb1apjHFI6z2WzisMvFRNKVkkrBg4Uep36Z4TMepPykr8Mn6n/mm/FZC9Xc
	Z3qKtw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4w8urgws-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 18:56:39 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c8276c91addso2721306a12.2
        for <iommu@lists.linux.dev>; Wed, 13 May 2026 11:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778698598; x=1779303398; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rmVE04cdLbc/FMe/QPBHI2itToGW2Cie+k5fJeV+/zM=;
        b=Atx5lGbTMA89olJPk4q/mgKv/XfsfWK570TF0nM5yqqzsYdb1AGKMEl05d52QTWaMG
         Ye/Fxofmpq5I8p+GZzzq/Z8qEdO54vbAKGtlsJ3yXwlCMX54lmrtbHKcK8M6TcuUDpxH
         DgmJxJdFNJ4CpDfvAszVBW6/IbcHWekwr9XirhQeTqC5MU3EzUK5Gr7W2wzTuK3t1XLn
         ew0J8ZOgs0ESIqo/pnOdX4F01dohF2QIe4AL6nsrwbQtU67oRuTWtNNPNk+BxJA7TIBV
         QNoTfRv7DJx2XEbuAaOliTAGHizvztvCYn0ZsZsmPor+Wxha/EUDqKwTLmqNjAArUNfE
         Tt2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778698598; x=1779303398;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rmVE04cdLbc/FMe/QPBHI2itToGW2Cie+k5fJeV+/zM=;
        b=LLk0TuLhw4EoWKUcmDIKO4W3Lh2NpG0DceRYbeYMjVRWkbdwX5HoaraezGmwDdXR4N
         GKlUPGGw2q5UKhH+5BVOBP0UVqp3/xZgb5fPvjWvXeAOjQZPr4+0JQymOMXJ1ZY7BDHI
         boCO1/37qGq+0mXzqdQYYqwSfmaqTIXv6MVdr/zlcNp0RHHyDR7grDGn/Q6vTvGd/2/7
         6asP02wgYa/tseawt1sfjVssuIRQLYxObDeJUTV+ohAcQmD03qx8oHbZcrsxMUmUFxN8
         pojwTGw12Wh8T8otsh/BZTNfTCe8kImR9dCAvo2reIdRKR53boihthW4a+iLfcGCrkam
         rDxw==
X-Forwarded-Encrypted: i=1; AFNElJ82HxWug8pm4hNnQRUS4OyVc5WzNa2fYbIR3vqUrjzt1Lp6KYmADjXnPd+9TALdISNXDECssg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw00Fc0x+3A7UCZv0gpnbYTslIdmByOV4opirPCI5VwFaohhr6f
	xmcqvA6u9F0DJ5G7q2SPSu0H+B4fHMgXFIw75O0AJD0MNkoHvjNPKfxxFIDzVTnq0tWmxT3CI7g
	kxodKdOWfqiYcXuVHZNxSbnHXJhDt95wwrj3eD1IrKJZAXG32f0VIGBg2bw==
X-Gm-Gg: Acq92OHnmAAgK/c7sdzfhWvLK0057VhpV4eK47+aKby/aUAZpN7AEsFmBXDyXlpGHTL
	zrTUlErqLIDnQEq6m4Zxdbw3T6rH2h0VAFXCN1HQcR1GfznOy8RAzVuAgYr3aXMoPaIfT5EbrDj
	6bULo8PpW66llRTKHzKsfXagrnYxXO7/Df2gq+eXJViEW4T9/Ix1YV7OkFEIN7CEktotmibClWn
	zWJDiYiXGkAbiYndLdB/gLMm/LlTvgxI36VGU21S3KzesL2PYUtzxUwTRfc9p6Ejm0mgshSWmpw
	L3DVVAzeBDsJhkOvViKazEawECA9rB+hFVKq6wW/OYiBXhi5UXn+ebVoFBxEqCaHbjUHCE1SrpX
	GJRK1Sadz+UjL0i3rphovlvUUPPXD7nvecKwXu/J9PuHhPH3ajYQ/jf4EygNj5Fw=
X-Received: by 2002:a05:6a00:1802:b0:835:4447:69d8 with SMTP id d2e1a72fcca58-83f04290545mr4615028b3a.30.1778698597895;
        Wed, 13 May 2026 11:56:37 -0700 (PDT)
X-Received: by 2002:a05:6a00:1802:b0:835:4447:69d8 with SMTP id d2e1a72fcca58-83f04290545mr4614981b3a.30.1778698597342;
        Wed, 13 May 2026 11:56:37 -0700 (PDT)
Received: from [192.168.0.17] ([49.205.251.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19664712sm273021b3a.12.2026.05.13.11.56.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2026 11:56:36 -0700 (PDT)
Message-ID: <4fa0d2b0-7e66-5841-d4e9-9a3f4ab00576@oss.qualcomm.com>
Date: Thu, 14 May 2026 00:26:26 +0530
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
 <34962003-c54c-a64a-2846-8f741fec5802@oss.qualcomm.com>
 <gc7adzf63sa4g7hsnwwoylv7ddmp2bpfa556gj7r3brzsry2x3@dmmdwsfwbcat>
Content-Language: en-US
In-Reply-To: <gc7adzf63sa4g7hsnwwoylv7ddmp2bpfa556gj7r3brzsry2x3@dmmdwsfwbcat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=WP1PmHsR c=1 sm=1 tr=0 ts=6a04c967 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=UdqKVphAFhxg2bWZaUV5ew==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=D9aC6Ywv3CxFFyY1MIYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: b1J1No9hK03DsZS5AsLnZH6360m04RAb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE4NyBTYWx0ZWRfX4woHBxBn7yjo
 6tSQ/iTAPLCaLVi/4vvH8mzhNNfrzNezuQm28oqWWuO2LvHG3+7nta3NbQoLgq7oPs+9yxcUuu2
 5u26BAP1V3u7rBT9Gxo9yxT1dZ2+9lMHR4ZwHA4cjC7iDTuPP2dv+V6nkoTnViEl0cDTiJUv21N
 6h1aKE02G7CPaQRt/RX35nPbzYYUWxUuzuwYN80H5njLdFM+kHovRk/wnW+NOQ9EqpjBr0FAYrQ
 zYHp7qJ29aajo2+VeVWmoDOkvxmyU/UGRAAevm10qui0FFPBuj8q9svKORvjBauF2tA0Sn3ncyf
 iWLZIgyC4+DKoe/NpPjFtL0kYyso6bHuDY/g9uJetvl4E1Kv86OmAraCjHIthcSL4izntLjtrpT
 wkuhctqFiPEEG96kBV7NFTZyrbaRTUeftI0WP6993S+QuXxs1EkDFP+pPT7dlpji/lMahmivczr
 eN3BINNKF88J3HxnW3w==
X-Proofpoint-ORIG-GUID: b1J1No9hK03DsZS5AsLnZH6360m04RAb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 bulkscore=0 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605130187


On 5/13/2026 7:25 PM, Dmitry Baryshkov wrote:
> On Sat, May 09, 2026 at 10:26:49PM +0530, Vishnu Reddy wrote:
>> On 5/9/2026 12:57 AM, Dmitry Baryshkov wrote:
>>> On Sat, May 09, 2026 at 12:30:02AM +0530, Vishnu Reddy wrote:
>>>> Add iris video codec to glymur SoC, which comes with significantly
>>>> different powering up sequence than previous platforms, thus different
>>>> clocks and resets.
>>>>
>>>> Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>>>> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>>>> ---
>>>>  arch/arm64/boot/dts/qcom/glymur.dtsi | 118 +++++++++++++++++++++++++++++++++++
>>>>  1 file changed, 118 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
>>>> index f23cf81ddb77..c47443174f97 100644
>>>> --- a/arch/arm64/boot/dts/qcom/glymur.dtsi
>>>> +++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
>>>> @@ -13,6 +13,7 @@
>>>>  #include <dt-bindings/interconnect/qcom,glymur-rpmh.h>
>>>>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>>>>  #include <dt-bindings/mailbox/qcom-ipcc.h>
>>>> +#include <dt-bindings/media/qcom,glymur-iris.h>
>>>>  #include <dt-bindings/phy/phy-qcom-qmp.h>
>>>>  #include <dt-bindings/power/qcom,rpmhpd.h>
>>>>  #include <dt-bindings/power/qcom-rpmpd.h>
>>>> @@ -4163,6 +4164,123 @@ usb_mp: usb@a400000 {
>>>>  			status = "disabled";
>>>>  		};
>>>>  
>>>> +		iris: video-codec@aa00000 {
>>>> +			compatible = "qcom,glymur-iris";
>>>> +			reg = <0x0 0xaa00000 0x0 0xf0000>;
>>>> +
>>>> +			clocks = <&gcc GCC_VIDEO_AXI0_CLK>,
>>>> +				 <&videocc VIDEO_CC_MVS0C_CLK>,
>>>> +				 <&videocc VIDEO_CC_MVS0_CLK>,
>>>> +				 <&gcc GCC_VIDEO_AXI0C_CLK>,
>>>> +				 <&videocc VIDEO_CC_MVS0C_FREERUN_CLK>,
>>>> +				 <&videocc VIDEO_CC_MVS0_FREERUN_CLK>,
>>>> +				 <&gcc GCC_VIDEO_AXI1_CLK>,
>>>> +				 <&videocc VIDEO_CC_MVS1_CLK>,
>>>> +				 <&videocc VIDEO_CC_MVS1_FREERUN_CLK>;
>>>> +			clock-names = "iface",
>>>> +				      "core",
>>>> +				      "vcodec0_core",
>>>> +				      "iface1",
>>> I first wrote the comment regarding resets. But the clocks seem to have
>>> the same pattern. It's not just "iface1" clock. It's the clock for one
>>> of the cores. And there is another clock for another core. Please make
>>> that nicely named.
>> In v1, I used iface_ctrl to reflect the clock purpose, but received the
>> feedback [1] to align with the iface1 naming convention used on earlier
>> platforms.
>>
>> [1] https://lore.kernel.org/all/20260414-lush-reindeer-of-storm-bbe918@quoll/
> I'd also dislike the iface_ctrl, it doesn't say anything.
>
> I'd suggest having vcodec0_iface / vcodec1_iface for vcodecs and just
> iface for the core AXI clock.

These changes would also need to be reflected in the DT binding document. The
current names are carried over from earlier platform targets as legacy names,
and in v1 Krzysztof suggested [1] using an earlier series as a base and building
on top of it — so I followed the same approach.
[1] https://lore.kernel.org/all/20260414-lush-reindeer-of-storm-bbe918@quoll/

Krzysztof, do you have any input on renaming these names?

>>>> +				      "core_freerun",
>>>> +				      "vcodec0_core_freerun",
>>>> +				      "iface2",
>>>> +				      "vcodec1_core",
>>>> +				      "vcodec1_core_freerun";
>>>> +
>>>> +			dma-coherent;
>>>> +
>>>> +			interconnects = <&hsc_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
>>>> +					 &config_noc SLAVE_VENUS_CFG QCOM_ICC_TAG_ACTIVE_ONLY>,
>>>> +					<&mmss_noc MASTER_VIDEO QCOM_ICC_TAG_ALWAYS
>>>> +					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
>>>> +			interconnect-names = "cpu-cfg",
>>>> +					     "video-mem";
>>>> +
>>>> +			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
>>>> +
>>>> +			iommus = <&apps_smmu 0x1940 0x0>,
>>>> +				 <&apps_smmu 0x1943 0x0>,
>>>> +				 <&apps_smmu 0x1944 0x0>,
>>>> +				 <&apps_smmu 0x19e0 0x0>;
>>>> +
>>>> +			iommu-map = <IOMMU_FID_IRIS_FIRMWARE &apps_smmu 0x19e2 0x1>;
>>>> +
>>>> +			memory-region = <&video_mem>;
>>>> +
>>>> +			operating-points-v2 = <&iris_opp_table>;
>>>> +
>>>> +			power-domains = <&videocc VIDEO_CC_MVS0C_GDSC>,
>>>> +					<&videocc VIDEO_CC_MVS0_GDSC>,
>>>> +					<&rpmhpd RPMHPD_MXC>,
>>>> +					<&rpmhpd RPMHPD_MMCX>,
>>>> +					<&videocc VIDEO_CC_MVS1_GDSC>;
>>>> +			power-domain-names = "venus",
>>>> +					     "vcodec0",
>>>> +					     "mxc",
>>>> +					     "mmcx",
>>>> +					     "vcodec1";
>>>> +
>>>> +			resets = <&gcc GCC_VIDEO_AXI0_CLK_ARES>,
>>>> +				 <&gcc GCC_VIDEO_AXI0C_CLK_ARES>,
>>>> +				 <&videocc VIDEO_CC_MVS0C_FREERUN_CLK_ARES>,
>>>> +				 <&videocc VIDEO_CC_MVS0_FREERUN_CLK_ARES>,
>>>> +				 <&gcc GCC_VIDEO_AXI1_CLK_ARES>,
>>>> +				 <&videocc VIDEO_CC_MVS1_FREERUN_CLK_ARES>;
>>>> +			reset-names = "bus0",
>>>> +				      "bus1",
>>> The names of the resets suggest that there is single "common" reset and
>>> then one reset per each core.
>> Two resets for controller and two resets for each per vcodec core.
> The same, vcodec0_bus, vcodec1_bus, please.
>
>>>> +				      "core",
>>>> +				      "vcodec0_core",
>>>> +				      "bus2",
>>>> +				      "vcodec1_core";
>>> Are there two codecs? Or are there two cores? Your naming suggests the
>>> former case.
>> Two vcodec cores.
>>
>>>> +
>>>> +			/*
>>>> +			 * IRIS firmware is signed by vendors, only
>>>> +			 * enable on boards where the proper signed firmware
>>>> +			 * is available.
>>>> +			 */
>>>> +			status = "disabled";
>>>> +
>>>> +			iris_opp_table: opp-table {
>>>> +				compatible = "operating-points-v2";
>>>> +
>>>> +				opp-240000000 {
>>>> +					opp-hz = /bits/ 64 <240000000 240000000 360000000>;
>>>> +					required-opps = <&rpmhpd_opp_svs>,
>>>> +							<&rpmhpd_opp_low_svs>;
>>>> +				};
>>>> +
>>>> +				opp-338000000 {
>>>> +					opp-hz = /bits/ 64 <338000000 338000000 507000000>;
>>>> +					required-opps = <&rpmhpd_opp_svs>,
>>>> +							<&rpmhpd_opp_svs>;
>>>> +				};
>>>> +
>>>> +				opp-366000000 {
>>>> +					opp-hz = /bits/ 64 <366000000 366000000 549000000>;
>>>> +					required-opps = <&rpmhpd_opp_svs_l1>,
>>>> +							<&rpmhpd_opp_svs_l1>;
>>>> +				};
>>>> +
>>>> +				opp-444000000 {
>>>> +					opp-hz = /bits/ 64 <444000000 444000000 666000000>;
>>>> +					required-opps = <&rpmhpd_opp_svs_l1>,
>>>> +							<&rpmhpd_opp_nom>;
>>>> +				};
>>>> +
>>>> +				opp-533333334 {
>>>> +					opp-hz = /bits/ 64 <533333334 533333334 800000000>;
>>>> +					required-opps = <&rpmhpd_opp_svs_l1>,
>>>> +							<&rpmhpd_opp_turbo>;
>>>> +				};
>>>> +
>>>> +				opp-655000000 {
>>>> +					opp-hz = /bits/ 64 <655000000 655000000 982000000>;
>>>> +					required-opps = <&rpmhpd_opp_nom>,
>>>> +							<&rpmhpd_opp_turbo_l1>;
>>>> +				};
>>>> +			};
>>>> +		};
>>>> +
>>>>  		mdss: display-subsystem@ae00000 {
>>>>  			compatible = "qcom,glymur-mdss";
>>>>  			reg = <0x0 0x0ae00000 0x0 0x1000>;
>>>>
>>>> -- 
>>>> 2.34.1
>>>>
