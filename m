Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE0F3ECBEC
	for <iommu@lists.linux.dev>; Wed, 25 Mar 2026 15:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774451435; cv=none; b=Psa8REgILyVvCRfBX/uD5hlgMhsVz34h5r2jdLEw1IeyoEjsgpu6TjG6p8P/oPtQvx1eHUPM8rtsrv/EmdNSZEin6PGzv5bucqUFO13XCjwjwujZO/h6j9CB0ccsUT5UOyPEMtRP/EdjEr7aIs/z4PQr/u9/uNNxUjhtnB5rF34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774451435; c=relaxed/simple;
	bh=ZxQippknm3j62I6Jp9U2pT0kpqpuo+x9nwZCCQAspsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dt9Iifuv/V1XMTuSjOCRud5YrEioKMxr5+S9+NytTWLPkVC6gV7wnp8wCfW6LioFzVuPCrT1d6Rlp9vpXFg0uKldXlG+mZVxXRypSqSW3ElZ2dTxKNNLx0wn9tAupQKPym5IzhqeycRA856BhqXZ7wKO1R46npPjBMBNfRmQwDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jXdOQg4y; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AsI8nc8L; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jXdOQg4y";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AsI8nc8L"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PBFw27720345
	for <iommu@lists.linux.dev>; Wed, 25 Mar 2026 15:10:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xtE4+84n9r+ybTVsuVpzR5BgwB77paJIB/iP6lAPjeA=; b=jXdOQg4yOpBTwPC4
	bXol2Jm/1QTPgXiiIsuUowmRLL1+x/GVw8R+9S75/ormqR+rAm34O6a7PM67RlVb
	34m5/h1eWxQ+vhBfT4JZl6/57TdsZmRaERsFvhA8Z4uEC1dLEr4Ms2k8mK88tPsY
	fCw/PYGd6r0Q+r0iTQunb+VPk3QbAGpGAT0KTYWPMkDOgTaIQm9ykXEviTbkY/ng
	jZMymY3BKvhDiixMwxeGB9Hl7r9UbK5KVX4i63Cm+EZ2PbeTt3jBdL+yfhXyJ3iw
	C7ACxl04G5w4zlLLXKGPZBZbyrtDID0bpv8xky9FNAofV42/NAF1BjNDXxo8s3H4
	jlTgPA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d4dm2s38j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 25 Mar 2026 15:10:33 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2adc527eaf5so23686035ad.0
        for <iommu@lists.linux.dev>; Wed, 25 Mar 2026 08:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774451432; x=1775056232; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xtE4+84n9r+ybTVsuVpzR5BgwB77paJIB/iP6lAPjeA=;
        b=AsI8nc8LuJpBhruddq/vt4Swi+ZC1i1UHaFKzvBF+lMWULatxydCBy5zfAONIO49U2
         kFiNYyvmFxV0aHnTfo5QHK/STvTnycjrNaAFWrmNp5RUKusLoooWVdGtmFhUstzlMrIL
         sq9TUdOfSclScY5TpsG4N8mJiL8WgnQFcgVMgRrWOrsPvuqTpNnnR+d7sPsssTrMg4tx
         Gn3tdQHjNEtjdgcHW/iXMz2e1hzWMBvGQH1OX79tlC7e+40dg0tq6b2y7UuFhCADqKKF
         I3sPbD/hU62vvjqJbrHpnqBlmSofEPCywob87/U6vySyF5KZFwuWhQh2YYqm0wHXcDzo
         /EQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774451432; x=1775056232;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xtE4+84n9r+ybTVsuVpzR5BgwB77paJIB/iP6lAPjeA=;
        b=Ge0YKJwspm/f7HIh8ffdLsz1vpqDqltE5i8rn20brbSkidDWOuKh+EYHrjXREZtIQo
         DlXr7TTWc05tjnsNmlkjWZ2HR5LEzoNpbs2ifGqFUTWegh9yAZYpikLuYpwwtZpji0zO
         tfuL55NzBAWsZxveA5gazOauUiMgdTd/mdHI3Em+Qcjo7VoY4e8rUQlXtQGQ8gPJ1bhk
         ZmfC7NnPrfAZl5LVh8h9AKY+7QzaYenvMs4UmLRBCl1I+4xj6DK/KYfNen+4lvEeCDSa
         QweieSpTUijYua45QyEBPSfGyYhrGsFXNPcSMt1ibXyO853yl4ardDqZVZHmMbu8Q7Sa
         YQlw==
X-Forwarded-Encrypted: i=1; AJvYcCVbsDz+ceHiSgMJIXtEwr4S7E0iZPPpvnXDWLWLwZvRPR2oIFyS8IvJNSnk1sP2mvx3U727xg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzMYJYbTsVuP/QiGPxat3iKZxeoQPv4rOyS9V/FqRma3KX4fW4Z
	Jsu1b1Oqx1YEgRkYg/VWWJ6mcTcPmAnG49v1EdGZS5H2HpXjbscxOykd/eadFKOOebIGoVG44Qm
	iVmsZUoCddRJ2aTnwy43OH9WOUvtRR4mTLQ+vzXbN5d1RstHx3sx7LYOHQQ==
X-Gm-Gg: ATEYQzwovroiJ58YhJOKd0+359YuVTr5GUE09B3Zp7nvPgJQWowRi5HtgV2clYWmrtA
	kYQAe8hxHjoPTPqRtb8ISr/Sd1v6i6sEeJld8l+Ifi92iXZW3jv+yp+9PmI1qyFyb2jzBjEbI4l
	Tn0nLjz07karbXAoMIEPrV7Fy+fngBcqs+XSzECFlVxfbU/kG3N+c8f3JSSTzspLIom1oWeioTW
	B4dKBGZ43l6rHct3sB9yW08js6WZMUTWF4AOO6et5dppPQLVUJ/d+JI59fjIQjbtHaxL4LL+CXo
	2rDCwfZ6aXsWNrW8VGpN4DOBCvXO0Sm9nhzi9f0NH71TZ6jwZIoqI+9HrngKLqhIURojGbzJ6Gr
	FQTKUK3gq1+8qPmOXd6uAAtAkxJG3xWL98EZzbQOwuNW2L7VEiNA+XA==
X-Received: by 2002:a17:903:2a8d:b0:2b0:6e8f:8e73 with SMTP id d9443c01a7336-2b0b0b2d665mr46305095ad.44.1774451432471;
        Wed, 25 Mar 2026 08:10:32 -0700 (PDT)
X-Received: by 2002:a17:903:2a8d:b0:2b0:6e8f:8e73 with SMTP id d9443c01a7336-2b0b0b2d665mr46304635ad.44.1774451431825;
        Wed, 25 Mar 2026 08:10:31 -0700 (PDT)
Received: from [10.204.101.77] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc7a9deesm1665755ad.28.2026.03.25.08.10.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 08:10:31 -0700 (PDT)
Message-ID: <bdae0b95-ee88-4398-8690-031803a85a92@oss.qualcomm.com>
Date: Wed, 25 Mar 2026 20:40:23 +0530
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
 <62027e78-4b7a-4b94-a51a-13a9ae77b722@oss.qualcomm.com>
 <5otifv465c7duslmogb5uzaxrh2k3u2ayiylcd6dnz3kc7win5@kltv3fxhtso4>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <5otifv465c7duslmogb5uzaxrh2k3u2ayiylcd6dnz3kc7win5@kltv3fxhtso4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDEwOCBTYWx0ZWRfX0+K/6gPWRAKZ
 WeB6ciwUwx2/YZ146wM6M8/3tRvADg4dqTYaIfuheTG33dqzQ3TjMiXMatBN2Z/C4y/eEIBSnTx
 sJe2YNAVPshsiypR2n/fywb9aI1Avs4acqrc+PmexlFaLjapZmyDBmu604h9Ncg+ptdN92r6mI3
 d4CTjiWdBUtPjv1e2Umfu8VCrJiHIXrG9cN+PMuDNtst01LkKaTBDmjTY1ZPMdwH1aptk6DMPza
 2Re44HZBUlXCQjo+e1jlpF4iRiOwO7/4NmjfqSsJuEKPTpvryKG6jvzpfZu0Mr5hAMzRhHpFAci
 N476Jdg7stSuGWm2SvSg5CiICoARNJkQLtGxmZ3bQRSbrs9hEUJWoaiUzrfHZYAL+7xaVb5xQ/x
 lU0HOT8BCaS+p/yIuQ5H9hDShqQmLRO9Ivk3lKRSQjPDe3I4bkos7fGuxbtpPFSie1XkI6/AoyE
 26EI0sylQOwCGtQkrmA==
X-Proofpoint-GUID: XyC3i-WbBMiYRPraiN9Oc27Iq8mSmUHl
X-Authority-Analysis: v=2.4 cv=Fo0IPmrq c=1 sm=1 tr=0 ts=69c3fae9 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=puI59K64icZz00i_70MA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: XyC3i-WbBMiYRPraiN9Oc27Iq8mSmUHl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_04,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015 spamscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250108


On 3/13/2026 9:10 PM, Dmitry Baryshkov wrote:
> On Fri, Mar 13, 2026 at 08:46:52PM +0530, Vikash Garodia wrote:
>>
>> On 3/13/2026 8:32 PM, Dmitry Baryshkov wrote:
>>> On Fri, Mar 13, 2026 at 06:49:35PM +0530, Vikash Garodia wrote:
>>>> Kaanapali SOC brings in the new generation of video IP i.e iris4. When
>>>> compared to previous generation, iris3x, it has,
>>>> - separate power domains for stream and pixel processing hardware blocks
>>>>     (bse and vpp).
>>>> - additional power domain for apv codec.
>>>> - power domains for individual pipes (VPPx).
>>>> - different clocks and reset lines.
>>>>
>>>> This patch depends on
>>>> https://github.com/devicetree-org/dt-schema/pull/184/changes/d341298d62805bc972dfba691da6b3b62aa3ff15
>>>>
>>>> Nacked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>>>> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>>>> ---
>>>>    .../bindings/media/qcom,kaanapali-iris.yaml        | 254 +++++++++++++++++++++
>>>>    include/dt-bindings/media/qcom,kaanapali-iris.h    |  18 ++
>>>>    2 files changed, 272 insertions(+)
>>>
>>>> +
>>>> +    video-codec@2000000 {
>>>> +        compatible = "qcom,kaanapali-iris";
>>>> +        reg = <0x02000000 0xf0000>;
>>>> +
>>>> +        clocks = <&gcc_video_axi0_clk>,
>>>> +                 <&video_cc_mvs0c_clk>,
>>>> +                 <&video_cc_mvs0_clk>,
>>>> +                 <&gcc_video_axi1_clk>,
>>>> +                 <&video_cc_mvs0c_freerun_clk>,
>>>> +                 <&video_cc_mvs0_freerun_clk>,
>>>> +                 <&video_cc_mvs0b_clk>,
>>>> +                 <&video_cc_mvs0_vpp0_clk>,
>>>> +                 <&video_cc_mvs0_vpp1_clk>,
>>>> +                 <&video_cc_mvs0a_clk>;
>>>> +        clock-names = "iface",
>>>> +                      "core",
>>>> +                      "vcodec0_core",
>>>> +                      "iface1",
>>>> +                      "core_freerun",
>>>> +                      "vcodec0_core_freerun",
>>>> +                      "vcodec_bse",
>>>> +                      "vcodec_vpp0",
>>>> +                      "vcodec_vpp1",
>>>> +                      "vcodec_apv";
>>>> +
>>>> +        dma-coherent;
>>>> +
>>>> +        interconnects = <&gem_noc_master_appss_proc &config_noc_slave_venus_cfg>,
>>>> +                        <&mmss_noc_master_video_mvp &mc_virt_slave_ebi1>;
>>>> +        interconnect-names = "cpu-cfg",
>>>> +                             "video-mem";
>>>> +
>>>> +        interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
>>>> +
>>>> +        iommu-map = <IRIS_BITSTREAM &apps_smmu 0x1944 0x0 0x1>,
>>>> +                    <IRIS_NON_PIXEL &apps_smmu 0x1940 0x0 0x1>,
>>>> +                    <IRIS_NON_PIXEL &apps_smmu 0x1a20 0x0 0x1>,
>>>
>>> It think we still haven't settled on letting iommu-map to have several
>>> entries for a single function.
>>
>> I have described the hardware aspects in the discussion [1], if there is any
>> alternate way to handle this, we can discuss in the same discussion.
> 
> Yes. But how do you plan to merge this? You've split away the patches,
> they don't seem to be listed as dependencies, etc.
> 

1:1 mapping of function ID with stream ID is closing on the reviews. I 
will have to update this patch to represent it in 1:1 mapping.

Once done, this patch can be merged with the dependency marked in this 
patch i.e 
https://github.com/devicetree-org/dt-schema/pull/184/changes/d341298d62805bc972dfba691da6b3b62aa3ff15

>>
>> [1] https://lore.kernel.org/all/21fda4d2-72e1-4e5b-aee0-a799886f53b7@oss.qualcomm.com/
> 

Regards,
Vikash
