Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF98381B0A
	for <iommu@lists.linux.dev>; Tue,  3 Mar 2026 18:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772561417; cv=none; b=dGLkRyS0k82aIkWGIM0+YJOz60qbQpkZhSrSIHZfh+0s6uY3aPtoluO69fM1mOlZ5Pb6qX+WefNj5pdkLau0gSkehBxGQAXagzUYxnqPDxFA+DnVDWTaHT/Br+zOWH5f+TSpxpirXA9+OAv/BWhRIAcgc2n2czg28kzN6vXnS88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772561417; c=relaxed/simple;
	bh=FFoN68FK2ZgHq38RAJl5rll2EWC7yTlem6G5chWZ5fw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oGIGvhGwRg4QLFiK4vgwSASpfJbt/K61efPnWbC+shq/unXEqM9Yk5ox4wdwtctLS9M5Y6MNiitv+PPLMmNoobMhqW/nodGrmzYAg3qbNNnBEUJdfY5tX8qeY6Uiinru+8KXMuK75gTdacLEpBQ66R9vbd0/tP9GYxd0N17jPpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JGuQZDgK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kDUDfCBu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JGuQZDgK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kDUDfCBu"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 623H0gco1511901
	for <iommu@lists.linux.dev>; Tue, 3 Mar 2026 18:10:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OqKZbzoaKqu/DQPtebCD+srV1gUBvacqae16bbDlquM=; b=JGuQZDgKDJvT3u9Z
	8nj1D3c5fL6gmvVLgNmgo6brJ8C8g6e8N5OaSmMbuxLzzEH0I8b9bMBw7vD2bX7n
	w9WVhkgtxNwAeRplmxBEt/ehUpL1UWJC8TQFuIdk8Dq0VnsEjs+3YhoH/kGL+AZe
	Xnh5CwHq5rwi38/GXCu4RROuY2psQp1vviRIG/iH+nxAYx2O12E3g+8GD7Hb38ZA
	jh+Jsva+1g91dFX2swog539RonY335jmTAJdXS3c92l6K1K0kggK3CkqgehxpZOv
	1jMmf8U6NyocXLYrVRTJ4O4I3BnHfoRkHm4RVuS4B3bRpdfSkGevLwqeoVhHwAiG
	ukmnGQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cnh6uc2k9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 03 Mar 2026 18:10:15 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c6e1d32a128so3562404a12.3
        for <iommu@lists.linux.dev>; Tue, 03 Mar 2026 10:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772561415; x=1773166215; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OqKZbzoaKqu/DQPtebCD+srV1gUBvacqae16bbDlquM=;
        b=kDUDfCBuSpgZnY0yVX1n9Ra8V0PYv19+SdZuZStJs/ubVaol49hgbbn4QtslYWfB8I
         LSa+ho7ETqiM2YD5I1khtQIDmCHeKpf/W/JgeUi80Ke2rgtMwFq8ftf3LO4Idnh4IB7Q
         nno2tsNLH+5m92apstsL7e1Yz1Rl+Eo5gltL05pm4NUAinIkEeLk+7Lq4WzfnwJt1J40
         kJxEaCcj5uJdtVM+7Q12qJUxkYuiNf5XP2simY3ULYTwCUbYAhErAgSshTXqS3oXX3Us
         3Z5V6A9fT4s8JfTJM9bBE9RPk3FTZd8c9qGo9NJ1jAfyo+E/oEtaJE1a1rhlkW63VPyz
         uAMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772561415; x=1773166215;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OqKZbzoaKqu/DQPtebCD+srV1gUBvacqae16bbDlquM=;
        b=vTss2vYL/fxzBerAOhGa3Pa/Y++Mx1qG7WvFR39fJFW5wQH1YMGQSRK15aopjt+3RE
         rpNHZ/b1IhBSal+AgqoDygnSYbjZO7iK4BLdmdu2YZqYCP5vl1TVIouXJvvodqbrBg+J
         Vte5gXbCPIF12/QaBLB3vyxg8CctJZ+1Z31hyFsnMHmKcP2mmwnZZMherHX6N6qJFnVY
         clF3OyNrHL2k2vQwoyoh/Tv2Lvo/RNBJAX89JfpDOfll8Xbow8p8dfnZpHeEpJRxXbRm
         TEISz2gxv7KP8FlnOYGoH7MWm/zmzLjiXhbGPzyixU6sflmwjcoxgD8InEtC/jxuG3/0
         3oqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOE5Br6X/Y3nwTqB7gosApAGzftynWGMY92dhiwJ/ER4C/0bRs/Z1xllqowwQgDSDwJPkT3w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzzZE5tEhuPRaJC18413Xb1C8CHAKrpKDqDVBHuZ8446QpQLglt
	16SrpN1/BTHNvwhNt18ncR8v8UVeFK8qAU1OveAQX5Cob4WDPnQAG3eNkTC2XKr7z7Atbj5u42f
	35fx05blK+ZOBK58gzALPnLqwQ5l3CV/ufU0UCIpuUjjP3c5YLIq2AAnBag==
X-Gm-Gg: ATEYQzxDq9qvxoQGG1xoOme659ISZ10wUvKnRUvzRlWjrLWJmW1bOgkGLjLRSOK2aNK
	WvXoUmcRdD+K/TqFTcseioNiga0TcFhJAxqtM23D9AwjA8iCABPvejZ3GEV0RR6el3dVpnkFlLC
	Bf8P5cc0UrZvd/Pqjwh+/Xy7+z0I8iW9+5QQ7ddBj/4msCNcBp/aUiWVFCt06PPf/nQfAPmObfD
	ig6aaspjQ77dP/leOZzyrnDRQTMnbuaXaH3K7RJBetA8Rb4EBHVMabOpnGHF32k8U3xwBU2dajL
	X5uoG5y2ld8lSyr5aKw7w+Kd8Tz3MWGmVlx9D6x9/UU5G4VrmDIEUcjVhlL5nj21hS7HzPNCL9Q
	FsdTaUzdGP1FBQcFb6lfwELttPEL3Afg6SKWOlTklG2Quui02ufyd2ww=
X-Received: by 2002:a05:6a20:3d06:b0:394:2fbb:bc6b with SMTP id adf61e73a8af0-395c3ac7773mr17211489637.46.1772561414401;
        Tue, 03 Mar 2026 10:10:14 -0800 (PST)
X-Received: by 2002:a05:6a20:3d06:b0:394:2fbb:bc6b with SMTP id adf61e73a8af0-395c3ac7773mr17211445637.46.1772561413784;
        Tue, 03 Mar 2026 10:10:13 -0800 (PST)
Received: from [192.168.0.172] ([49.205.248.49])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa61fcdesm13583925a12.11.2026.03.03.10.10.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2026 10:10:13 -0800 (PST)
Message-ID: <68db6d61-640b-4eef-8ccd-ab2fbcb58427@oss.qualcomm.com>
Date: Tue, 3 Mar 2026 23:40:04 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] media: dt-bindings: qcom-kaanapali-iris: Add
 kaanapali video codec binding
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
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
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, Bryan O'Donoghue <bryan.odonoghue@linaro.org>
References: <20260227-kaanapali-iris-v2-0-850043ac3933@oss.qualcomm.com>
 <20260227-kaanapali-iris-v2-1-850043ac3933@oss.qualcomm.com>
 <4dcbbd06-18eb-46c6-a52c-07a4b17205cd@kernel.org>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <4dcbbd06-18eb-46c6-a52c-07a4b17205cd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDE0NiBTYWx0ZWRfX9XJ7JiNri0Rr
 4RWaIGwqStjC48IyhjyFBX/hCkkdXKly/OzrfpHVxL7ZZg4KFA4UhRFOFjvqXrjvWZ2vSfX1zAp
 hfAfLMcUfkEMvZZnaC8TLwU3Sf1Zh26ReZpT/R5NcTtp/98L76xWnxFDqvLrjmR/oXeKbZ+nYjN
 fsvF4PvVDgftD5pAIQ8iMfkAbvrCIHMhOycuQZabxO4bCkvfjL9BH6ARhS6VkmwrvEYm/TvPMPg
 inMBtrcSKONU7reWFMvadLUZZC++qhGb6CnCFnRWNCSrGA+AQ6j3WH9/CqSj3DIz/jofRaKcofH
 vbgiPyb8A+D43Jp4IQVDedVZTtBj13/5wJjj1A0eUjmRc720hoxdQejSpKnoEYHcEd4wxCIHR7C
 ufTwcnl5hUQHEKh/PA++wpg6wCnas2qWfUg8zhb1v3VvYhz+SNUBsTx5jEr1rUNlHOrg9KBFFC9
 4E26K2Y2xuy/YuW81Iw==
X-Authority-Analysis: v=2.4 cv=MuhfKmae c=1 sm=1 tr=0 ts=69a72407 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=KPiuay1jFzAquJblYynD6w==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=NEAV23lmAAAA:8 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=G49KJ_XMRW11ds8oWG8A:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: U59pA-rIechSS5KGm7t1Nd4Lpt-Mj_1E
X-Proofpoint-GUID: U59pA-rIechSS5KGm7t1Nd4Lpt-Mj_1E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-03_02,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030146


On 2/27/2026 9:20 PM, Krzysztof Kozlowski wrote:
> On 27/02/2026 15:11, Vikash Garodia wrote:
>> Kaanapali SOC brings in the new generation of video IP i.e iris4. When
>> compared to previous generation, iris3x, it has,
>> - separate power domains for stream and pixel processing hardware blocks
>>    (bse and vpp).
>> - additional power domain for apv codec.
>> - power domains for individual pipes (VPPx).
>> - different clocks and reset lines.
>>
>> iommu-map include all the different stream-ids which can be possibly
>> generated by vpu4 hardware as below,
>> bitstream stream from vcodec
>> non-pixel stream from vcodec
>> non-pixel stream from tensilica
>> pixel stream from vcodec
>> secure bitstream stream from vcodec
>> secure non-pixel stream from vcodec
>> secure non-pixel stream from tensilica
>> secure pixel stream from vcodec
>> firmware stream from tensilica (might be handled by the TZ / hyp)
> 
> I cannot really parse above.

I think its better to drop this aspect from commit message, as the patch 
precisely describes them.

> 
>>
>> This patch is depend on the below dt-schema patch.
>> Link: https://github.com/devicetree-org/dt-schema/pull/184/changes/d341298d62805bc972dfba691da6b3b62aa3ff15
>> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>> ---
>>   .../bindings/media/qcom,kaanapali-iris.yaml        | 261 +++++++++++++++++++++
>>   include/dt-bindings/media/qcom,iris.h              |  18 ++
>>   2 files changed, 279 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/media/qcom,kaanapali-iris.yaml b/Documentation/devicetree/bindings/media/qcom,kaanapali-iris.yaml
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..db734c664a0417d8f5ea55b066f63f42583b1c14
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/media/qcom,kaanapali-iris.yaml
>> @@ -0,0 +1,261 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/media/qcom,kaanapali-iris.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm Kaanapali Iris video encoder and decoder
>> +
>> +maintainers:
>> +  - Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>> +  - Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
>> +
>> +description:
>> +  The iris video processing unit is a video encode and decode accelerator
>> +  present on Qualcomm Kaanapali SoC.
>> +
>> +definitions:
>> +  iommu-types:
>> +    items:
>> +      - description: Function ID
>> +      - description: Phandle to IOMMU
>> +      - description: IOMMU stream ID base
>> +      - description: IOMMU stream ID mask
>> +      - description: Number of stream IDs
> 
> You don't need definitions.

Ack, this can be dropped altogether.

> 
>> +
>> +properties:
>> +  compatible:
>> +    const: qcom,kaanapali-iris
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 10
>> +
>> +  clock-names:
>> +    items:
>> +      - const: iface
>> +      - const: core
>> +      - const: vcodec0_core
>> +      - const: iface1
>> +      - const: core_freerun
>> +      - const: vcodec0_core_freerun
>> +      - const: vcodec_bse
>> +      - const: vcodec_vpp0
>> +      - const: vcodec_vpp1
>> +      - const: vcodec_apv
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
>> +  iommu-map:
>> +    description: |
>> +        - bitstream stream from vcodec
>> +        - non-pixel stream from vcodec
>> +        - non-pixel stream from tensilica
>> +        - pixel stream from vcodec
>> +        - secure bitstream stream from vcodec
>> +        - secure non-pixel stream from vcodec
>> +        - secure non-pixel stream from tensilica
>> +        - secure pixel stream from vcodec
>> +        # firmware might be handled by the TZ / hyp
>> +        - firmware stream from tensilica
> 
> Drop description, pointless. How does it help anyhow in writing DTS?
> 
>> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
>> +    items:
>> +      $ref: '#/definitions/iommu-types'
>> +      minItems: 5
>> +    minItems: 8
>> +    maxItems: 9
> 
> This solves nothing from the discussions we had. I re-iterated multiple
> times, plus there were internal threads doing the same, that you need to
> define the items to have strict order.
> 

describing them as a list of items, please review.

iommu-map:
     $ref: /schemas/types.yaml#/definitions/uint32-matrix
     items:
       - description: bitstream stream from vcodec
         items:
           - description: Function ID
           - description: Phandle to IOMMU
           - description: IOMMU stream ID base
           - description: IOMMU stream ID mask
           - description: Number of stream IDs
       - description: non-pixel stream from vcodec
       - description: non-pixel stream from tensilica
       - description: pixel stream from vcodec
       - description: secure bitstream stream from vcodec
       - description: secure non-pixel stream from vcodec
       - description: secure non-pixel stream from tensilica
       - description: secure pixel stream from vcodec
       # firmware might be handled by the TZ / hyp
       - description: firmware stream from tensilica
     minItems: 8


>> +
>> +  memory-region:
>> +    maxItems: 1
>> +
>> +  operating-points-v2: true
>> +  opp-table:
>> +    type: object
>> +
>> +  power-domains:
>> +    maxItems: 7
>> +
>> +  power-domain-names:
>> +    items:
>> +      - const: venus
>> +      - const: vcodec0
>> +      - const: mxc
>> +      - const: mmcx
>> +      - const: vpp0
>> +      - const: vpp1
>> +      - const: apv
>> +
>> +  resets:
>> +    maxItems: 4
>> +
>> +  reset-names:
>> +    items:
>> +      - const: bus0
>> +      - const: bus1
>> +      - const: core
>> +      - const: vcodec0_core
>> +
> 
> I assume you checked and used last SoC order of all the entries here.

yes, order is followed as used in earlier SOC.

> 
> 
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - clock-names
>> +  - dma-coherent
>> +  - interconnects
>> +  - interconnect-names
>> +  - interrupts
>> +  - iommu-map
>> +  - memory-region
>> +  - power-domains
>> +  - power-domain-names
>> +  - resets
>> +  - reset-names
>> +
>> +unevaluatedProperties: false
> 
> additionalprops, see writing schema for explanation.
> 

I do not see this being added in qcom,sm8750-iris.yaml as well. Since 
you made that schema, i generally follow that as reference.

> 
> ...
> 
>> +    };
>> diff --git a/include/dt-bindings/media/qcom,iris.h b/include/dt-bindings/media/qcom,iris.h
> 
> Filename must match binding/compatible. I asked for this multiple times.
> 

in this case, its applicable for other platforms as well. Naming it as 
qcom,kaanapali-iris.h would make it look like kaanapali specific.

>> new file mode 100644
>> index 0000000000000000000000000000000000000000..beb244289466ca938c7e5fe5cf15526f606a3a6c
>> --- /dev/null
>> +++ b/include/dt-bindings/media/qcom,iris.h
>> @@ -0,0 +1,18 @@
>> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
>> +/*
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + */
>> +
>> +#ifndef _DT_BINDINGS_MEDIA_QCOM_IRIS_H
>> +#define _DT_BINDINGS_MEDIA_QCOM_IRIS_H
>> +
>> +/* Function identifiers for iommu-map to attach for the context bank devices */
>> +#define IRIS_BITSTREAM		0x100
>> +#define IRIS_NON_PIXEL		0x101
>> +#define IRIS_PIXEL		0x102
>> +#define IRIS_SECURE_BITSTREAM	0x200
>> +#define IRIS_SECURE_NON_PIXEL	0x201
>> +#define IRIS_SECURE_PIXEL	0x202
>> +#define IRIS_FIRMWARE		0x300
>> +
> 
> Abstract identifiers for ABI start with 0 or 1 and are incremented by 1,
> not 0x100. There are also decimal, not hex.

Ack.

> 
> Best regards,
> Krzysztof

Regards,
Vikash
