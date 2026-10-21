Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792572370;
	b=j0Qi8RMi09eN0/kZXqrSVylqPUEHNozNDTfBsvI1e8e8QcY2cAA3ZWuDaY2Ikw4MEJZu
	 N4IIm6E3FRYWCSUoSfJcdTP8zSzHZvxNyK2U5b/LTJTYYfqdrbV3Xxn6cQMSpVhH8eb0l
	 iqXQdqwF03Ns8wtwKE9CBhhO5cKayJHiKij7T9qdSS2qpPJrRWXM+pboRFAcKPGFJW5gf
	 LqTsSTTcXuLtlLsIsx5Pl+ChgGqJZlLs1fiKpk7Q3ysLk60IJVPa9ds5Uu+e3E7PkyTDk
	 Ksu5ve/6m1N2c31ZwRLAgR/W5npeKcIJGv46JOZJFlar9oqWgEjduMh01S3OLai8jvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792572370;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 X-Google-Original-From:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=T34/HlSHyjCRDqfk2vimEJ3Pwwh0TycFh3fKBLlyT8Q=;
	b=D+vUj2H5WdBrSjbLTCY4FpnyS5rbaExlR60cdmDBLkQqfWW3iscGG9USwaephuBVWIbt
	 AfSZENoky9xtT46laf6YhdQzBjIiX82AjnZ5kPOyrT8cCjX7B5+kMp04INmk2JFhL497X
	 hXvG6DiucccS45vwd/12L+5wDpr8S3m65g9BZbnLl2FNHSLmmt8hkrh5nHj5nte1H98hh
	 CaRMGWGam1A/dfajrjPJzJVNrfrFTcogLRtuQLodLYsWOqiH9EcG5Fy5B5Sl4wRkL3HI6
	 1bQ/EOKdy9gf4tm2jHcuDu9mvVMEmyDI+22D6JdKPdAmuZLIk5ksOaZglHOqBq26lTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UwC5m0sx;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UuwX5zFU;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E81A606A322
	for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 08:46:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E81A606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UwC5m0sx;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UuwX5zFU
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69L5jOZD3573330
	for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 08:46:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	T34/HlSHyjCRDqfk2vimEJ3Pwwh0TycFh3fKBLlyT8Q=; b=UwC5m0sxAo9CranQ
	I2wU+VQqqlLBpXX/XorF7YaZxJhNq7sUCkB6IfeCqY03U38I6Ef0cVK+uqRM1xch
	w2Vud5soXpT3FMmGLaY7sSMFoSgE4/Qpzure2JdmOyUJrnqz3qRYit2HILj56kb6
	AC/Szb3w3pnZegQYU8U14VCsPWFWOtUEuJO37i3c+20pZqONT7EXW5AQg5LcclX2
	GnrvAhn4vs/brcWWechVCSZGKF0Q2c6Kn8dVlq/Hb2InR/htWIT/oa8H1D8BnndP
	wziW71SPMwPvgOp6Xg+P3b+kLyWQEL9qgw31ow5uvye5iihyITY/RK3N0SON2X6E
	WEna2Q==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hed9hu0an-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 08:46:08 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-366c279b454so984441eec.0
        for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 01:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792572367; x=1793177167; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=T34/HlSHyjCRDqfk2vimEJ3Pwwh0TycFh3fKBLlyT8Q=;
        b=UuwX5zFUrOHcVBiTbt5E/BqJQzeomiu8lTxRV/5UOG1IxyjLl9HRvT5BJO+4Ys848R
         8fTs27U22yd09fc81NC0bNdlxhwIXhFt2htL+4QeYMoR7yQ0ss20aCtrMTJhBM06EloU
         tHTz1fkjqtL+KFPNjNfo/uQnoIbJJdGDr/7cE69Ili/QJTYPxGQKSQ9uo4Kb6Oe2xIPz
         HFb3LjbFKxs1e7KOYijXjgdBtDOiudNdgpU/0s+7zmCW0JbXGME1plppI5gPkQidzJWJ
         WkdUJ1QG8SjWrcxZKSnaNJaZzb/hVtLb4psirt4dpqDKlyWWN5vNGARD4NupCLeeCWN1
         ll1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792572367; x=1793177167;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=T34/HlSHyjCRDqfk2vimEJ3Pwwh0TycFh3fKBLlyT8Q=;
        b=bzmKHEn2menpRYHkKjf8jyDNUJ8+ELU6jUYi0YDhOol3+WgcS1OZYwL2raH5B+p3x9
         +kevT3uQ8YRxZYWrA+Pe0oLTFkGmIgylw5s/eEc/h/o7GgQPy9M4fJZjrU3MdFONSPs3
         LBLkdybtojqZz+8VRzQEgCyGrW5AqWcK50OwxQBnU6mlxe0CEtanWWeMEZBq9kyyPvAv
         TdHYQw+Vo+MWGnKpk5uszWYGufcfT33GFixkg19/v0tw1ik21S/4DwskdamBg7c51o09
         yWqbl583/tn3bDTMwWG0b7fLWS3r5cKplEKQQdRCT+ywJwYv/tIgr5Jo6iUfxzKVj0W7
         BG7A==
X-Forwarded-Encrypted: i=1; AKwUvBxdY77FlRczRz/ZcBahJyapfQGJSJyblG8fLLT7kvc1RJW1rWBEdUuoh3z095B+U8y1RksBYg==@lists.linux.dev
X-Gm-Message-State: AFq9FYJAZwggU/xwGxAOPn5uN8/qnafTZJqcuStc+b4nf9jzwhj+xSG/
	LdGgH1Ll8asOKwcX+mxly1iHwadLH1d1KIOPg/ZUlSlonxiNpj/qf9YsqgB538o7UmiKR3xT7PA
	dyIMBFJKzfdGoM23HIoS4gkrFXqGRmK6Db/eiSfeh9My0Ya6xCG7ZaDDYOQ==
X-Gm-Gg: AYBFou1DEYDJEt6QfvDyaO+TkY2SO25/571ibrREIJdSY3OUZPiJsMZbjM4hClr3Iad
	xO1ZcOU31eeA6Xp+7HptKxgY0QQ1CVLuSLhQ2YsatSR+JziKZMsVqZIsChAvjN9x7D4623gcvWv
	h7ZKpz0LuJxDA+Zw6RY0fmqVKyXch/E5FRWTloQBbjtDWTG7kkBWBghTLhPqJOiyyhq00ImJ2ih
	2gHgdREW4tVFF23V0wFcoBcncrL529aopWJO1hHgBIr7O1PvHewdpfJNrzww6ez7zo+sjlQHk51
	TKCsyU8wmdu+DGcR8Y6a3/WiGQMfTXLGOSw5NbqcGfDFyK8y0AEgX72g8LdUHUNvj4OBVElvBB5
	lzLbwdShXlrVqwYlifMg3uK9cPs4u+DM8Kw==
X-Received: by 2002:a05:7022:eb55:10b0:187:cf46:4c51 with SMTP id a92af1059eb24-190a728a309mr1916591c88.31.1792572367014;
        Wed, 21 Oct 2026 01:46:07 -0700 (PDT)
X-Received: by 2002:a05:7022:eb55:10b0:187:cf46:4c51 with SMTP id a92af1059eb24-190a728a309mr1916523c88.31.1792572366229;
        Wed, 21 Oct 2026 01:46:06 -0700 (PDT)
Received: from [10.204.79.28] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903bd6b7ccsm4271323c88.13.2026.10.21.01.45.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 01:46:05 -0700 (PDT)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
X-Google-Original-From: Jayant Shekhar <jshekhar.shekhar@oss.qualcomm.com>
Message-ID: <ea81fcc1-c7e4-4b80-b65e-f483487bd1a1@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 14:15:53 +0530
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] dt-bindings: display: msm: Add Qualcomm DCP
 bindings
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Philipp Stanner <phasta@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        iommu@lists.linux.dev
References: <20261015-jshekhar-drm-msm-dcp-v1-v1-0-48aad0fe4f72@oss.qualcomm.com>
 <20261015-jshekhar-drm-msm-dcp-v1-v1-1-48aad0fe4f72@oss.qualcomm.com>
 <hprf3vrsveovq3hwcgjrfj6uhmlxlq5u5bx4lkbswgxe476qwz@pacalsdgrjx7>
Content-Language: en-US
In-Reply-To: <hprf3vrsveovq3hwcgjrfj6uhmlxlq5u5bx4lkbswgxe476qwz@pacalsdgrjx7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YuKa1IYX c=1 sm=1 tr=0 ts=6ad87bd0 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=GUqRGlKH2whgtnOLMxAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAzNCBTYWx0ZWRfXyyPrtq+d1caG
 dGL8NRCi23PlLkPpRhZq+TM5psgg6PSQ2Om9r+LRYxtL5HHlMpbRINGGgwK561HCG2qzssgywV1
 hepofkm6FN4goxC3vTpr9RZ8Ren0mm4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAzNCBTYWx0ZWRfX8PvySgc4I5kO
 VclFmQaTZ7ZpP4AtLI2jVq2kb+4Ty23l9kOkYvtfQewgNFEE+kqy0xsqpqAIQHGevZTVijTSFnS
 AF9jfiiDqu868jMuJWV8YH1ipcb25AVbZDL1sMsEiWm3Nrepw2ZZpAHduKAIAp49/COBMq90Io4
 nXmx6cbxsoogV4WJqd8BYJCPvgIJ+oxCu3STv8M9TdLVcJxFdRWPQjYjr8PaTkMjf0u80BRlTKt
 efTuzZijISHfEVTD0UhEH5HpwoDVs5TpWl1o+oUqh2eLIJLI7bbRTH6xTZcfFC4pHTcvtB1Uw0s
 /87PWM4X7G/HY+KXdk+KnllJwnhAp+7wh2wwtlPNDKa0YaRgApQ6cXU+/9TqQYuzg40lf1hqQSN
 bfbsRx42l6l2UNdb4/MSd2bhsRgPQIdqQd1/YYOcLUtR1nOYViDAG/wXpYqpcgMNgcWo9asmUl8
 X9V2dOVeGQc/qg01OYQ==
X-Proofpoint-GUID: 01u0Y9gpZ02-uE80Doqy6vWbZ4f3SfqC
X-Proofpoint-ORIG-GUID: 01u0Y9gpZ02-uE80Doqy6vWbZ4f3SfqC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210034


On 15-10-2026 17:47, Dmitry Baryshkov wrote:
> On Thu, Oct 15, 2026 at 01:08:21PM +0530, Jayant Shekhar wrote:
>> DCP platforms place the display pipeline under firmware control, so Linux
>> cannot discover display resources through direct register access. The DRM
>> driver therefore needs device-tree descriptions of the firmware transport,
>> display topology, IOMMU contexts, and panel connections.
>>
>> Add bindings for the Qualcomm DCP VirtIO display function, including the
>> INTF graph and DSI host outputs. Document the framebuffer IOMMU context,
>> IPCC power-notify mailbox and interrupts, firmware display topology, and
>> firmware-visible IOVA window supplied by the parent VirtIO-MMIO transport.
>>
>> Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
>> Assisted-by: LLM
>> ---
>>   .../bindings/display/msm/qcom,dcp-dsi.yaml         |  75 +++++++++++++
>>   .../bindings/display/msm/qcom,dcp-virtio.yaml      | 113 +++++++++++++++++++
>>   .../devicetree/bindings/display/msm/qcom,dcp.yaml  | 119 +++++++++++++++++++++
>>   3 files changed, 307 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,dcp-dsi.yaml b/Documentation/devicetree/bindings/display/msm/qcom,dcp-dsi.yaml
>> new file mode 100644
>> index 000000000000..f7178c66c09e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/display/msm/qcom,dcp-dsi.yaml
>> @@ -0,0 +1,75 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/display/msm/qcom,dcp-dsi.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm DCP DSI host
>> +
>> +maintainers:
>> +  - Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
>> +
>> +description: |
>> +  A MIPI DSI host exposed by the Qualcomm DCP VirtIO device (see
>> +  qcom,dcp.yaml). DCP is a firmware protocol shared across multiple
>> +  Qualcomm SoCs, not specific to any one of them; Hawi is its first
>> +  platform. The DSI host and its connection to a panel are described
>> +  using the standard DSI controller and OF graph properties.
>> +
>> +allOf:
>> +  - $ref: /schemas/display/dsi-controller.yaml#
>> +
>> +properties:
>> +  reg:
>> +    maxItems: 1
>> +    description: Index of this DSI host among its siblings.
>> +
>> +  status: true
>> +
>> +  ports:
>> +    $ref: /schemas/graph.yaml#/properties/ports
>> +    description: |
>> +      port@0: Input from the DCP virtio device's DPU INTF output port.
>> +      port@1: Output to the attached panel.
>> +    properties:
>> +      port@0:
>> +        $ref: /schemas/graph.yaml#/properties/port
>> +      port@1:
>> +        $ref: /schemas/graph.yaml#/$defs/port-base
>> +        unevaluatedProperties: false
>> +        properties:
>> +          endpoint:
>> +            $ref: /schemas/media/video-interfaces.yaml#
>> +            unevaluatedProperties: false
> Why do we need OF graph here? Would it be enough to link one of the
> ports of the root node with the panel's input?
>
>> +
>> +required:
>> +  - reg
>> +  - ports
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    dcp-subsystem {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        dsi@0 {
>> +            reg = <0>;
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +
>> +            ports {
>> +                #address-cells = <1>;
>> +                #size-cells = <0>;
>> +
>> +                port@0 {
>> +                    reg = <0>;
>> +                    dcp_dsi0_in: endpoint {
>> +                        remote-endpoint = <&dcp_intf1_out>;
>> +                    };
>> +                };
>> +
>> +            };
>> +        };
>> +    };
>> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,dcp-virtio.yaml b/Documentation/devicetree/bindings/display/msm/qcom,dcp-virtio.yaml
>> new file mode 100644
>> index 000000000000..018694310dfb
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/display/msm/qcom,dcp-virtio.yaml
>> @@ -0,0 +1,113 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/display/msm/qcom,dcp-virtio.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm DCP VirtIO host
>> +
>> +maintainers:
>> +  - Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
>> +
>> +description: |
>> +  Qualcomm's DCP VirtIO host provides the generic VirtIO-MMIO transport and
>> +  the host-side IPCC channel used to wake the DCP firmware.
>> +
>> +properties:
>> +  compatible:
>> +    contains:
>> +      const: qcom,dcp-virtio
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  iommus:
>> +    maxItems: 1
>> +
>> +  iommu-ranges:
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +
>> +  interrupts-extended:
>> +    minItems: 2
>> +
>> +  interrupt-names:
>> +    items:
>> +      - const: virtio
>> +      - const: dcp_power_notify_irq
>> +
>> +  dma-coherent: true
>> +
>> +  mboxes:
>> +    maxItems: 1
>> +
>> +  mbox-names:
>> +    const: dcp-power-tx
>> +
>> +  dcp-subsystem:
>> +    $ref: qcom,dcp.yaml#
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts-extended
>> +  - interrupt-names
>> +  - iommus
>> +  - dcp-subsystem
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/mailbox/qcom-ipcc.h>
>> +
>> +    virtio@9be8000 {
>> +        compatible = "qcom,dcp-virtio", "virtio,mmio";
> Is it really compatible with virtio,mmio? Can it be handled completely
> by virtio,mmio?


There are two possible approaches:

Option 1 — Use the standard VirtIO-MMIO parent (preferred)

Keep the parent as:

compatible = "virtio,mmio";
reg = <...>;
interrupts = <...>;
iommus = <...>;
iommu-ranges = <...>;
dma-coherent;

The generic virtio/mmio.yaml binding would be extended only to document 
the generic iommu-ranges property.

The DCP-specific resources would be placed on the virtio,deviceXX child:

dcp-subsystem {
     compatible = "virtio,deviceXX";
     iommus = <...>;
     interrupts-extended = <&ipcc ...>;
     mboxes = <&ipcc ...>;
     mbox-names = "dcp-power-tx";
};

The parent uses the standard VirtIO-MMIO interrupts property. The child 
has one DCP-specific interrupt, so interrupt-names is unnecessary and 
the driver uses interrupt index 0.

Option 2 — Add a Qualcomm-specific VirtIO-MMIO parent binding

Keep a Qualcomm-specific compatible such as:

compatible = "qcom,dcp-virtio", "virtio,mmio";

and extend the parent binding to describe iommu-ranges, the additional 
IPCC interrupt, mailbox, and related DCP resources.

However, this approach duplicates the generic VirtIO-MMIO binding and is 
only justified if the transport requires Qualcomm-specific handling. 
Since the DCP transport is handled completely by the standard 
VirtIO-MMIO driver.

Which one do you prefer?

I will be addressing other comments in v2.


Thanks

Jayant


>> +        reg = <0x09be8000 0x1000>;
>> +        interrupts-extended = <&intc GIC_ESPI 956 IRQ_TYPE_LEVEL_HIGH>,
>> +                              <&ipcc 13 5 IRQ_TYPE_EDGE_RISING>;
>> +        interrupt-names = "virtio", "dcp_power_notify_irq";
> Why do you need names? Can they be dropped in favour of using indices?
>
>> +        iommus = <&apps_smmu 0x15a3 0x0>;
>> +        iommu-ranges = <0x0 0x84000000 0x0 0x04000000>;
>> +        dma-coherent;
>> +        mboxes = <&ipcc 13 5>;
>> +        mbox-names = "dcp-power-tx";
>> +
>> +        dcp-subsystem {
>> +            compatible = "virtio,device34";
>> +            iommus = <&apps_smmu 0x400 0x2>;
>> +
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +
>> +            ports {
>> +                #address-cells = <1>;
>> +                #size-cells = <0>;
>> +
>> +                port@1 {
>> +                    reg = <1>;
>> +                    dcp_intf1_out: endpoint {
>> +                        remote-endpoint = <&dcp_dsi0_in>;
> Can this point directly to the panel_in? What's the point of describing
> internal paths in the DT?
>
>> +                    };
>> +                };
>> +            };
>> +
>> +            dsi@0 {
>> +                reg = <0>;
>> +                #address-cells = <1>;
>> +                #size-cells = <0>;
>> +
>> +                ports {
>> +                    #address-cells = <1>;
>> +                    #size-cells = <0>;
>> +
>> +                    port@0 {
>> +                        reg = <0>;
>> +                        dcp_dsi0_in: endpoint {
>> +                            remote-endpoint = <&dcp_intf1_out>;
>> +                        };
>> +                    };
>> +                };
>> +            };
>> +        };
>> +    };
