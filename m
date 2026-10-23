Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792743040;
	b=rbfVBfs0BLpaDkc1IC2j8ketK8DCQK5cxDrvN18uVgpCoCh26zMEIzYaAyRGu2xNh3tt
	 wQT8LCJvt7UZB5qy0w0g1obXC/fWjBXdizf7/KBhjHU9NPbIIq4lxwuRsjQ39mitZlacG
	 ayyltemfklyUhLS+UXquE8EdpmIUWnAc707zlS6JMEh6crIRgISQaB6zI4wcOuvfxRW/9
	 L4/YBV2HqmTr7FmiBA8tEgUbHQi3ZaVCGoB09QpYXdV3BXE80OIxvlEf7O5WjKL19cVUq
	 L49KnX9T3ZZ2UgbTNUgngWS4JFHENilmlc5gwTAlzlHV8eBPfemlIIQFibD72ufqtzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792743040;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 X-Google-Original-From:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Qt1u1PGQnVLwLZKEH+hp9Dtkn1RKbERmxA8BWP6q4N8=;
	b=Cf5G1Nrg5jVNCF5E0cfFZB98xVu14BzVFLYUREY4hMOXO6VXecPNfzsH/1yvaR1402Ba
	 D/thR5lCdCQJcc/Agkud/aguWuTFUHfwEnP2mydPHONDEtBcXdQ6N/+/pvhpWWg1ZIgSD
	 a31R2/7eCFdXot6VGMU9n1s5sW9dWdjgi04KFNoxOI7afC+1gWqhuIsYO7e1RLx58s9+G
	 kcfYDig4O3rPGr1iuQaSxAf0nSAN+QlWu3Gqy+VROcbiaLLNp9coBjZymT07XIIZSXJAg
	 9rqPFnVp03O5kcs8Ct/la1f+mXtDaJ0SjFx7i2R+6z7D26M6jhoHuIT3W9oth5FVMOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=U7fHBr2Z;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cNuDci96;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16E0606A31F
	for <iommu@lists.linux.dev>; Fri, 23 Oct 2026 08:10:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B16E0606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=U7fHBr2Z;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cNuDci96
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7FLZR3167844
	for <iommu@lists.linux.dev>; Fri, 23 Oct 2026 08:10:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Qt1u1PGQnVLwLZKEH+hp9Dtkn1RKbERmxA8BWP6q4N8=; b=U7fHBr2Zzr5BzR0l
	GZ4p+H51nKm9WVAQPxZtK5Fxkawu2eyIUw8uq1dLaEEiMmoXZzBSEOt1Ca9eoWJh
	Lmldut7xSV7XBgCfpN1LqCL+BlRp56ZaYaSsa4GwxE5GF1t7f/hD6UuuO/Nb3+Ie
	pzBPhe/0u5Dl7/AVXrCPWXw/OJQQoSxrCbRu2YwIGvD6Eh/ZW3w29qV+5Ex5n93u
	V0Ekb2Macw7YJI7/WfuTkPsM2grc2qboRWV1y9a+c6TX6khVSg8MVWZxO16ccf14
	DwWONyUX847Rs1JDb87TeUaYuMA/se/zirkPxWskU8S8qCLB8g+30G4DDdGoCCK/
	zHAsZw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmpamxa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 23 Oct 2026 08:10:38 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-39de4e72b33so972393a91.2
        for <iommu@lists.linux.dev>; Fri, 23 Oct 2026 01:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792743038; x=1793347838; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Qt1u1PGQnVLwLZKEH+hp9Dtkn1RKbERmxA8BWP6q4N8=;
        b=cNuDci96oe8C9ISlYTBlwStyPN5PchI1FYXL2GODcFcQMU4NwmrW4q97BZHTTwl1cv
         1fIZ6V8Rzjqsr2aWnsVAUt4zuyX/Ep5SFyBdZRH9j3HtCjNXZCxYrAQdYLBNP283A+8f
         5LKGQpXN+q93Kmf0IflozbEHifKysz5snsQwgh3bthcywMdIwJdA1JX5AIHnMSRCzn68
         A7BobuE5VEL51/Q96algTP3IhkTDhmDnfEn6Lm3P8qTcERcy8LnSlZZUULPmB0opZMYU
         JUXSmDMXYORJq6UyCHhb9s+6He6oogfrGXcqDd1h5vpDoqtatOY5Zr8Z3nHpmRkee40x
         akmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792743038; x=1793347838;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Qt1u1PGQnVLwLZKEH+hp9Dtkn1RKbERmxA8BWP6q4N8=;
        b=Z5MHachNcho3usLEHzTXdU90rJbiFMmSK+PXlILOlRxTGjX0d5TzP0SJqXllOcuw7s
         xIwxqQc8O7fMV9n9IspA0z8qe4WhpbTzVWtFc5LYxfonnvzuUNfUXDm/mFg3pbXnlev3
         lhV1LaZ5F3uo5hdjbGttmvms76VQd7oGYPQM75LgBysY1Iq+Q+oFyY/DqRn8HDl2QTeR
         uxrAdUByI9n/Ux1TZCOs9Ng1w2j9xVdFGulY9QvlPkXxRIDbae9z3xNElglceBRvkExX
         O/jKmluRjrvRktBHuSur1CobI1oflw8Kq9apP8WLzigwovNLiSUaJvwDlRlkk/vMiF6T
         bqPg==
X-Forwarded-Encrypted: i=1; AKwUvBxnAo7L6fo0sHWPCdNIwxS5/WpjkHLDq8FXc9ignsMy1VO764hVsq8QnA+KNAZ25q6DdvlM3w==@lists.linux.dev
X-Gm-Message-State: AFq9FYKvQ4/+AOJvEl4zVTl56WPMdOgF/r6Q/8Id4XkcWE913bdAUsfh
	iRwOt5SZT+8btG4ANqFyA4bIdFENasnPx94S47toIaVzNn/aFWk9UzglQcgGNeTwnKmTGYVIvk9
	NDrRwFsN0/e7ppaw0eTm4acpKv6rWtKMbdgWJ7K2BS+TFH9rDjpVYTojRtg==
X-Gm-Gg: AYBFou1L4JImpxprogrEEXL0edRaj+DKa99FJtEFxkt7jBtycvudxeyZ1g1r5CN65g2
	FSwsAPNzbS3/KVL17KaIzM0BaePj+DQRndSX9dwv55IaXvuhcEBVhOgoaj+uZe+zWr9+u2uzFVa
	T51RLlsnOG3YwAJfUkBG/b8GA7CZy/257Ux77MJB4x1/N2NY7EMlSedNtFt4zx7ErBQbZc0ZEeU
	LpsGJI01VQ02S6vW9hijUj6JACS2cTtsquS+k6sBxDSGlBEJQa78YOXI3/IbbXtEG4jH+Rf0/fN
	dBwRAGsBBlNK7Px3CzAGe27lt3/IK4FPvHYiR7sfuM93r6GFsBNkfjEmfEQU15FU+QJQQ8n6Ft7
	zgYK5nnHR5dYHOPuSoz6yCrZ7v/07H2Hxag==
X-Received: by 2002:a17:90a:dfc3:b0:3ac:97e3:7389 with SMTP id 98e67ed59e1d1-3adce072ca9mr1162590a91.44.1792743038050;
        Fri, 23 Oct 2026 01:10:38 -0700 (PDT)
X-Received: by 2002:a17:90a:dfc3:b0:3ac:97e3:7389 with SMTP id 98e67ed59e1d1-3adce072ca9mr1162541a91.44.1792743037308;
        Fri, 23 Oct 2026 01:10:37 -0700 (PDT)
Received: from [10.204.79.28] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adcb0a11fbsm2517749a91.4.2026.10.23.01.10.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2026 01:10:36 -0700 (PDT)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
X-Google-Original-From: Jayant Shekhar <jshekhar.shekhar@oss.qualcomm.com>
Message-ID: <ae967eb1-cc54-4733-9e89-bc375e1cbfd6@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 13:40:25 +0530
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
To: Krzysztof Kozlowski <krzk@kernel.org>,
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
 <20261015-heavy-clam-of-sunshine-8fe831@quoll>
Content-Language: en-US
In-Reply-To: <20261015-heavy-clam-of-sunshine-8fe831@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzMiBTYWx0ZWRfX55LDDoIWHPgM
 dfLbf2Z/HcMsTOgw5gVzjqcyPTwnBoUTmH2RNqcG/kPvR+4tm0vHxPk/heXcKNPzNcrqM/ukc/7
 L/0hChlfUCWUft8xpO4ojBWmB3fpYIo=
X-Proofpoint-GUID: 3LwgRhuUpgY6ROVdDHrCCfxOoO4LHt0j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzMiBTYWx0ZWRfX6OhkqP4tQVh1
 GFPZAZCWWFAgkZMiSqdDTf0Pv2q2sebK/8sow9lK8XtiCP1tx52PObAHK0uc10mM5Qpa/uw65DM
 KScr7HJQQOMr9J0/v6Jf7cB1WwQcTIDRXJMudbGSW6rjA0eVdZLmGUMO+Hdig60s6x96duxW50Z
 Jekn6+v8J0Dr4MfbVRXQJRzuOaq+Xnl1nblmeJ6RY83Lz6Wpchomh+qr+WCXy+79JUi330gufsM
 n9f6A5TryglGEe+Eh3iFthd/QPln/ANFPCRtyBr+WSbYUJfvcIMrEt/zq/0cYCThroZ5tVeYNT8
 nAFrRZWfyv/wUhLyxf4w1GTI86yvF7GadK6YO971Lh33kEZlgdVoPpK5zLScGcN0PaAz63gNR1U
 JNBd3CHDuapB+J9RoI0zx4u1SPWhd9AhW4tI4xSZAX9C9PNWs0t9imzI7Y+EuSlluA731ugtS19
 efgEm6Swdtx0BcRYRTA==
X-Proofpoint-ORIG-GUID: 3LwgRhuUpgY6ROVdDHrCCfxOoO4LHt0j
X-Authority-Analysis: v=2.4 cv=BdBNQbt2 c=1 sm=1 tr=0 ts=6adb167e cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=P-IC7800AAAA:8 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=CvYCOFMdU_owP9l6gQwA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22 a=d3PnA9EDa4IxuAV0gXij:22
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230032


On 15-10-2026 16:20, Krzysztof Kozlowski wrote:
> On Thu, Oct 15, 2026 at 01:08:21PM +0530, Jayant Shekhar wrote:
>> DCP platforms place the display pipeline under firmware control, so Linux
>> cannot discover display resources through direct register access. The DRM
>> driver therefore needs device-tree descriptions of the firmware transport,
>> display topology, IOMMU contexts, and panel connections.
> Due to dependencies this cannot be tested, so limited review.
>
> A nit, subject: drop second/last, redundant "bindings". The
> "dt-bindings" prefix is already stating that these are bindings.
> See also:
> https://elixir.bootlin.com/linux/v7.1-rc7/source/Documentation/devicetree/bindings/submitting-patches.rst#L23
>

Thanks, will fix this in v2.


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
> I see slop, I finished here. Mind this maintainers summit words - if you
> use AI, you must use good one, not the shloppy slop.


Will remove this in v2.

Thanks

Jayant


> Best regards,
> Krzysztof
