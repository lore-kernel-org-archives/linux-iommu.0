Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6F137F74F
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 15:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773415026; cv=none; b=AC9QjyI3rLHQsHE5PKTfXrLns7zHAwjJs8KB4nvW8cP3UQ8Qc5VVZxNnvoLO8vriSJLKm2uXppCX7JWnMa13X6ZSmJ7e32w+SuQBnzeQ7NXDrSmH0a/HVGWv9FUivVKr2Dy/oESEF9UK21ecPbNHUnDRw2zfeGY1/dM4gWVYnlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773415026; c=relaxed/simple;
	bh=DUcBuDzR8Vt3nmScARMkm9CX8EQAoi9nu6O26gVJJkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=unNpzZSBrImw3eWTMAgqLXyUw2A7+EpIT1R8Humsx0anqTakdT0KaISlVIyaTn85at3cv6DVP8qYD6KyQ2V+YKwZe3BxiFGb//A1s2zeQUWFQoX3jGR6Wxy0VMuDrcY/veesCS2ShL+q9w2nU9gPgEWFfICIxuYSneaaoxW4v8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GC8FSReq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eA7edQh+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GC8FSReq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eA7edQh+"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62DCUxEJ3342929
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 15:17:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	v3eFun+R7DEVcMmqGCgOvog+ta9UM0shehTjUam8d9o=; b=GC8FSReqDP4KXEVA
	kT3T4Jm95n6NHAPATSvGU2N3ykZH2lgZ67lLED6+Kr7x1uLvwNDhy43IfHutxHBj
	TIpAM2/ufzxc6RPbMK0X7NZu4uFz6rtgXSXGHqxm0jEGMMb7BvpZQ09XRUc3K9dF
	PfnRuWu3FGvrt9iD4SCawjNnQvPY7I4dazEhTub17g15pyoWI+wB8toIcxmWdLY6
	s3L0A676DvMNI8gJf85B3wCQiiyxFhNg4uj74+jHe78BJ+mm66qQAE51LW6Hsg4P
	2HorpL4g17CafVhlS5p+CuX6/6X2iID6ZIKN61NKGdGPgLKFrUwav9+HXftEetXZ
	WvqBOQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cus9w5cbp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 15:17:03 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b62da7602a0so1599663a12.2
        for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 08:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773415023; x=1774019823; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v3eFun+R7DEVcMmqGCgOvog+ta9UM0shehTjUam8d9o=;
        b=eA7edQh+ZhHWYCH5F90Jm7TxCEsBcNvQGPYAIJo5qvOKnd1cvTF6J6BBKcWAQYJda9
         HmOfFKhvqO8KGjVJ6l5J97zaD1feCfXscJ5FXMmOKOhlEtkcJSUE+IUmIyhvNjsSxAJT
         8lpUMfgAC8jjsf2BIV9o85fvhM41B7EKHdwnISY9vPFHdvue9TkGG3de3D2ES1F75BEM
         Xv/1cyNhhybn3wwHHeImaYU+qS9DeHBzwmpV4L5vgV+8F/VsF6hQIWybGxXG4I1VOIkw
         LbM1zaskVDJPdXJsPyrVwhwmV0RFR9ur57hPIKhVlblcPsMmMkPRON7aF66LgHNExaD1
         HbNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773415023; x=1774019823;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v3eFun+R7DEVcMmqGCgOvog+ta9UM0shehTjUam8d9o=;
        b=k8p/WywAY73mBexF4tJVNyW024L1FefAGOCcYH+1hC9pPcS5GkGDjFMDt3vMkb58Yj
         ep/u30mRbA6GxRjm9asc+tluldli/CRIQ7tYOHODGuGgi9Nm1EmMXR6S68Q1lbieNOHt
         wLtQXWZ6bnNzgDnyyUjBkC7r86mXRm2Y4S6DBuN47tYJ8W0jq2vu8K5mNK3tbSOzb1BA
         B1sXobLOJI2+DYcXgJsAs9QLaXUBxJJCg2YEKUl16VQHc5EtbQl48ph47OySUy7SHJoE
         0VXXUZXhYkrcSxYIpl9yaD7dBHDQku22/P5+4+m19JGWgfSYNA9ElP6ESsNKjH0sWOw1
         Lp+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUrwsWCPbH/zJlNbjEOwHJEuD/4ORPcGHDDr/WQ2M7lZftrmT8IurPWGvkbumnWM9AFhaOkoA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzP6X3oMgtYUMcOISGI/66Dcfugca47oWD/VUsSyLiE/hDQ84Iv
	30Vq2fIoyt1F3NKLVx/8GZC2Uzvzp8yG3XzM4YM5STYfLJwdjWBVOI7FNaqzEJKtNInGl8ZA4W+
	b8gD15Rm42FHitSeSxcHlDDqheX06LjV1jRTNjO9RCvFtisbf7KDv77Lqig==
X-Gm-Gg: ATEYQzwtwhL5S/10ZxT6gvbwSas0uB01FdVx5NkGfuaCYBHm/eWTToIx2uR0INMEoc/
	XQQSjxgxWxqk2or6yBqGllE4wSlC+9hAvNkiNZZnJWcNrsnFx5GOdEhBZbNJltZNl0dX14I2V5D
	OSpQ4x7JPFzmq5jsJqYk6ZIPXhD8SxnYDrt5YZM0AVv89x/dbTOcMkx1GfcDQCvDJ3dTCU1emDw
	pAvzuTlZIdwWIkwyfg0rywIPPcs/4umLK4Ncs9oX7HUuzAMl8204YbmikgaBEALGOReGiu5Hib8
	O32WNcTavy4jowygOf0xm1pxep2VC77oC4YUhyTHEaVPG60/6NMcbpoKO6LScTHMRYTENorMfD6
	bcE/uBDF3mrMjt/yjw8Kt2FW78EEjhpfKK+ICqy8EFTmXslSmD26yZjdk
X-Received: by 2002:a05:6a21:4cca:b0:398:71f2:59d5 with SMTP id adf61e73a8af0-398ecce998dmr3321270637.42.1773415022672;
        Fri, 13 Mar 2026 08:17:02 -0700 (PDT)
X-Received: by 2002:a05:6a21:4cca:b0:398:71f2:59d5 with SMTP id adf61e73a8af0-398ecce998dmr3321202637.42.1773415022008;
        Fri, 13 Mar 2026 08:17:02 -0700 (PDT)
Received: from [192.168.0.172] ([49.205.254.220])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73ebaa4338sm2047210a12.15.2026.03.13.08.16.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2026 08:17:00 -0700 (PDT)
Message-ID: <62027e78-4b7a-4b94-a51a-13a9ae77b722@oss.qualcomm.com>
Date: Fri, 13 Mar 2026 20:46:52 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] media: dt-bindings: qcom-kaanapali-iris: Add
 kaanapali video codec binding
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
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
References: <20260313-kaanapali-iris-v3-0-9c0d1a67af4b@oss.qualcomm.com>
 <20260313-kaanapali-iris-v3-1-9c0d1a67af4b@oss.qualcomm.com>
 <hfuqu5uwjuh4ie55zwaqqbsflhf5yn55hnjva356nivoq46m2i@o5pkjnfrwycq>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <hfuqu5uwjuh4ie55zwaqqbsflhf5yn55hnjva356nivoq46m2i@o5pkjnfrwycq>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: GyidrNPdRjcazZwiCaaX5vfol03LJ4D8
X-Authority-Analysis: v=2.4 cv=IIIPywvG c=1 sm=1 tr=0 ts=69b42a6f cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=EbT04XG53EGSLiegdi54Hw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=H73U6gjSJfwdDiR_EpgA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDEyMSBTYWx0ZWRfX7kcQxPVhiU/3
 UjXr4QFnVvPTrUTdcxKasYQWpeKuZgzz0L3BMAA3y6o5ysVXDTdqAJD/sCRwjiFpCw9X/Ffp71e
 MkWSH8eZee+DBPbHYuSnfXXKLKZuktsQG2OvfG6shClbd+czmOL5Wxs3xhYQT5d6D0uOGHF639q
 niW960GMMl5kAba7/POWt3N72xN5fWVsA2fD/M+XuCJh5p1zJ6+X/43GkLUFhu1HLeznbI/0zZm
 oTLeTfqOWhFbU9JMIP5lQy6EvAfpAOJJ/8QmB2fN4LPw3UGs89LL3V8KMh1480sbvEX1PhXtfrb
 FOunWgmBoNHlzTMmhJGTR8A6e5E4migxHP4kxwDM59HANtdNtg/EyQaoC75h2OD6eeXK01pRXG7
 KNG5qvK/RDAj9hixpEV2fGhymodF55dA1lX+ooFGngJBtL09OhnlGW4bRGXWIDJiQ6hUEFnJmc2
 wJVgt8dx9h05pL5xiJA==
X-Proofpoint-ORIG-GUID: GyidrNPdRjcazZwiCaaX5vfol03LJ4D8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130121


On 3/13/2026 8:32 PM, Dmitry Baryshkov wrote:
> On Fri, Mar 13, 2026 at 06:49:35PM +0530, Vikash Garodia wrote:
>> Kaanapali SOC brings in the new generation of video IP i.e iris4. When
>> compared to previous generation, iris3x, it has,
>> - separate power domains for stream and pixel processing hardware blocks
>>    (bse and vpp).
>> - additional power domain for apv codec.
>> - power domains for individual pipes (VPPx).
>> - different clocks and reset lines.
>>
>> This patch depends on
>> https://github.com/devicetree-org/dt-schema/pull/184/changes/d341298d62805bc972dfba691da6b3b62aa3ff15
>>
>> Nacked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>> ---
>>   .../bindings/media/qcom,kaanapali-iris.yaml        | 254 +++++++++++++++++++++
>>   include/dt-bindings/media/qcom,kaanapali-iris.h    |  18 ++
>>   2 files changed, 272 insertions(+)
> 
>> +
>> +    video-codec@2000000 {
>> +        compatible = "qcom,kaanapali-iris";
>> +        reg = <0x02000000 0xf0000>;
>> +
>> +        clocks = <&gcc_video_axi0_clk>,
>> +                 <&video_cc_mvs0c_clk>,
>> +                 <&video_cc_mvs0_clk>,
>> +                 <&gcc_video_axi1_clk>,
>> +                 <&video_cc_mvs0c_freerun_clk>,
>> +                 <&video_cc_mvs0_freerun_clk>,
>> +                 <&video_cc_mvs0b_clk>,
>> +                 <&video_cc_mvs0_vpp0_clk>,
>> +                 <&video_cc_mvs0_vpp1_clk>,
>> +                 <&video_cc_mvs0a_clk>;
>> +        clock-names = "iface",
>> +                      "core",
>> +                      "vcodec0_core",
>> +                      "iface1",
>> +                      "core_freerun",
>> +                      "vcodec0_core_freerun",
>> +                      "vcodec_bse",
>> +                      "vcodec_vpp0",
>> +                      "vcodec_vpp1",
>> +                      "vcodec_apv";
>> +
>> +        dma-coherent;
>> +
>> +        interconnects = <&gem_noc_master_appss_proc &config_noc_slave_venus_cfg>,
>> +                        <&mmss_noc_master_video_mvp &mc_virt_slave_ebi1>;
>> +        interconnect-names = "cpu-cfg",
>> +                             "video-mem";
>> +
>> +        interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
>> +
>> +        iommu-map = <IRIS_BITSTREAM &apps_smmu 0x1944 0x0 0x1>,
>> +                    <IRIS_NON_PIXEL &apps_smmu 0x1940 0x0 0x1>,
>> +                    <IRIS_NON_PIXEL &apps_smmu 0x1a20 0x0 0x1>,
> 
> It think we still haven't settled on letting iommu-map to have several
> entries for a single function.

I have described the hardware aspects in the discussion [1], if there is 
any alternate way to handle this, we can discuss in the same discussion.

[1] 
https://lore.kernel.org/all/21fda4d2-72e1-4e5b-aee0-a799886f53b7@oss.qualcomm.com/

> 
>> +                    <IRIS_PIXEL &apps_smmu 0x1943 0x0 0x1>,
>> +                    <IRIS_SECURE_BITSTREAM &apps_smmu 0x1946 0x0 0x1>,
>> +                    <IRIS_SECURE_NON_PIXEL &apps_smmu 0x1941 0x0 0x1>,
>> +                    <IRIS_SECURE_NON_PIXEL &apps_smmu 0x1a21 0x0 0x1>,
>> +                    <IRIS_SECURE_PIXEL &apps_smmu 0x1945 0x0 0x1>,
>> +                    <IRIS_FIRMWARE &apps_smmu 0x1a22 0x0 0x1>;
>> +
>> +        memory-region = <&video_mem>;
>> +
>> +        operating-points-v2 = <&iris_opp_table>;
>> +
>> +        power-domains = <&video_cc_mvs0c_gdsc>,
>> +                        <&video_cc_mvs0_gdsc>,
>> +                        <&rpmhpd RPMHPD_MXC>,
>> +                        <&rpmhpd RPMHPD_MMCX>,
>> +                        <&video_cc_mvs0_vpp0_gdsc>,
>> +                        <&video_cc_mvs0_vpp1_gdsc>,
>> +                        <&video_cc_mvs0a_gdsc>;
>> +        power-domain-names = "venus",
>> +                             "vcodec0",
>> +                             "mxc",
>> +                             "mmcx",
>> +                             "vpp0",
>> +                             "vpp1",
>> +                             "apv";
>> +
>> +        resets = <&gcc_video_axi0_clk_ares>,
>> +                 <&gcc_video_axi1_clk_ares>,
>> +                 <&video_cc_mvs0c_freerun_clk_ares>,
>> +                 <&video_cc_mvs0_freerun_clk_ares>;
>> +        reset-names = "bus0",
>> +                      "bus1",
>> +                      "core",
>> +                      "vcodec0_core";
>> +
>> +        iris_opp_table: opp-table {
>> +            compatible = "operating-points-v2";
>> +
>> +            opp-240000000 {
>> +                opp-hz = /bits/ 64 <240000000 240000000 240000000 360000000>;
>> +                required-opps = <&rpmhpd_opp_low_svs_d1>,
>> +                                <&rpmhpd_opp_low_svs_d1>;
> 
> It's a DT and not the schema question, but please cross-check the OPP
> points here. If I understand Taniya correctly, we should be using
> corners from the PLL type rather than from the video_cc clock plan (they
> differ for some reason). Downstream videocc driver also should have
> correct rail corners for the PLLs.
> 
>> +            };
>> +
> 

