Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559DA346A0C
	for <iommu@lists.linux.dev>; Fri, 18 Sep 2026 06:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789714654; cv=none; b=pZwIw+LZSZfm0pT0bOo+OdBsC5hi8mNaUUtrLwkPjrNZiREkRRHjZu5/cp2GiGXR3gZSc9FnSsufBgbpv5XlvBDclSyydGfa/EBY6KIXHSNdUqnXeCw4Vh8aR7FxHB0bXWVF3o3+VGFIfuRFZRGENQnEp+KaNcCBOu5Bv9pllP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789714654; c=relaxed/simple;
	bh=WmfAZW7sVXMa/GOifNO3h2xf0LgQ8zx7piA8+FgMS9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=owaYq8VvmJsfhG4RiSc9Szgy4+cfqKmtfuPGfH5yz8rYbJQU80qm7zyiyqLN1SRDIc59ZPrId/S/SSp2A3eSDBu9gb7NStLw+D2zU6W8dTwzTRDxqIDGvGt9MhwAB0T8x7QV8RFmnKCtUmwEOFhzvlQA3SRZmpcu+zGhHt9DbBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SuPsA3fL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=W8dLOwkS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SuPsA3fL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W8dLOwkS"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I602OI3304793
	for <iommu@lists.linux.dev>; Fri, 18 Sep 2026 06:57:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	o1FLM+CkV68zd/McNTCIwsQNIBUX6pTcu5N0rHLOGSs=; b=SuPsA3fL4KFS4RdR
	SGRtCc2ecCPNmAl9AWeFSBpXmeVYcikNvk7EcCtwcSYh241UaFUII7FsHpfhtTSS
	aNAEXoCaKortPpQe0Ib/E2cDFVeU/E5Bk3oL35M+t4gLPvEdR89FP6SnjNG8QDgZ
	WgAK2nWRZ1KjWc4hA4Lnpu+P/q2Ek4n4tZoGrxXpamsfN3Q072DT6DmHerVW4BkG
	nqtfVujj/xMYz2p14oe/+kbsBjxQk3lAxeKx6PZ8vKFz+6eg2eoQH83sUay2Ibsv
	RiCWhsrst/etTZuLrRRaLoK9PMNTB2JysXNF7/lbNHamqZXTR4Ai5j1SF3rMY79T
	JCLVgQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grq2kt8a4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 18 Sep 2026 06:57:28 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2db8c152622so4768525ad.2
        for <iommu@lists.linux.dev>; Thu, 17 Sep 2026 23:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789714647; x=1790319447; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=o1FLM+CkV68zd/McNTCIwsQNIBUX6pTcu5N0rHLOGSs=;
        b=W8dLOwkSagfCpg2B/OzqPkMTrV2Mj5YKcSCrxgEiA9tzbAFaYSoikfrLFV1c6CrwML
         CwlFFDyXPAAaaXSvHrVNMUV+NqYNKcrZAqmQzKcztSugPi7kLof+GW60XxwZ8IsKFNCU
         PVRuPc9gS3HYhHm+uRXafXBwd+amfy0b5JC8X55eAODScsacvtYnSGvrjNkHIK7vkKEc
         rqplCg9zd1kgiLAYi0jmyO8AtgwkFRw3C29NcHiBg8SDd78U76otaFkC0jdYadt3FelJ
         M9BGcazi3Ydf/ttBwni05xOdNucdXcvEe1URHApICEjPxvYmbeERGlVMX3XG24tzkVMa
         9o6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789714647; x=1790319447;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o1FLM+CkV68zd/McNTCIwsQNIBUX6pTcu5N0rHLOGSs=;
        b=HpOtx8O1kzjIxLkWSnj90Gem0zxjiOh6jIlVFHsYdkbJrJr2RTKE8ACpOO1Pt+I+xo
         j1lxs1IqFsMdD+6ua6iCKspUnSkK+fwWfcKHYXgs7Q9lRFImEgaI1EjxUm5YmjKuukPf
         J3mf+MTPIQ/5flggk28VE0gxMz7atEx+ir1Zonr5oTmPjlKfMPWRSFaD3kpD3ETQtpUD
         5Qg5PhWGHqPV5li/8SyH5yxh41NdIYM+2ZZytsID5hGqlj/pUwPbvwXlSfhUFjXGz8Rz
         ffCAjdrce12YQWCVFyL7dMEkSsD9ZCTbLjAmuPSbW6eQZtNY2W4s4kyv0UNa2crblBlD
         VaKg==
X-Forwarded-Encrypted: i=1; AKwUvBwOFFrf2JKjdP9AdCxACaND8zr0fFQOLWAqxhyAxvM4t5DBJDoYpQVqrfclfEOHYUAJQ9LHNw==@lists.linux.dev
X-Gm-Message-State: AFuF++l3Np8Kb4pqz84/TtKmDrlLiT1bG1uI+PHhGE/eQDeoYwe3VoQr
	nmbPOL2siSIs8CPJg7WgnawATUJ7nkOCp7V31dosBc8eURQNrYxA9eRJRHb/GylT1ncPrCXxwwG
	qUclKW6S6JozMX/zBiy0dL7pTOHT59d13h1NgCOYVVBxByKefSC5yLJmtuw==
X-Gm-Gg: AYBFou2yPtdaii3UgRsg/FiOLcvietAXwXD0QyS6K7cw/y3UweMimeG+laUkQZ7Uz94
	6NeNzNQ6iBJ9UwneeY/wwg7fX7FNaw68T30VEkqNinWWl++gbmB2+4taVw5GBCYPHD0KLXZOp4G
	vdz/mtT5pW+XCDLd5/UyGqYm6+jaJN2nxlnuIu1r7JxtG7gZEMBiuxn3VQxBfW2a9Vdknwfvs6f
	yDclKv29gWZ8vQr7RXPdo/F31sagOlcIxyW6Iah0gxB6QsnSzAGVvYGhrpxM7rSvlGIoIxsr+jF
	Q7kuVltKSRagre2B2uN2RTFQeAPIrl0m7bke4UheaiEnSUQSK92ARLk9QS3MD1UM9h5hKQ641lO
	zaIo4hO62VciptGHBKRKAf6KMm84aE6vu
X-Received: by 2002:a17:903:19ed:b0:2dd:319:c9ef with SMTP id d9443c01a7336-2ddb1ab3349mr35051005ad.3.1789714647515;
        Thu, 17 Sep 2026 23:57:27 -0700 (PDT)
X-Received: by 2002:a17:903:19ed:b0:2dd:319:c9ef with SMTP id d9443c01a7336-2ddb1ab3349mr35050555ad.3.1789714647078;
        Thu, 17 Sep 2026 23:57:27 -0700 (PDT)
Received: from [10.171.1.18] ([106.221.176.116])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c2890b915sm1950432eec.30.2026.09.17.23.57.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 23:57:25 -0700 (PDT)
Message-ID: <ad600338-dc87-dcc4-f1c9-8cbd53a1dc46@oss.qualcomm.com>
Date: Fri, 18 Sep 2026 12:27:15 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v11 0/9] media: iris: Add support for glymur platform
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20260917-glymur-v11-0-e0c8bc914742@oss.qualcomm.com>
 <20260917-dangerous-illegal-honeybee-cf479a@quoll>
 <ad32f584-ea27-4da9-9397-147b887a7d68@kernel.org>
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
In-Reply-To: <ad32f584-ea27-4da9-9397-147b887a7d68@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDA5MiBTYWx0ZWRfXzhjWdr9jGugJ
 /+X+KQqqkuG9jpqxBU2IMLCcobyLe44SjZyUCn+opseKysHTn28SPa+nxzzlW1xz3Vw/blnp+Ag
 NJ+IicMhV9DzF4JOfhvBHPBu6TEStwob8hBV5UjzSIgzrkuZSYRwKRqTuYkoIZThtqvfskm8kG3
 6ZR3KXWEQzWiiozCeiEL0icip70mJZbrsK35p7qWJkECxJkdGNXxKTUiwoeQSxIKSW9LbAjJOna
 e+HjeWbxhKpD4aK8sPFFEMhW7b6PVW19FrPCf34ZhIBB/S824JmzzXU3TRYisr6EQFvgST3oB5o
 myo5kGDupPxIZVCMTdFruXyTFzgSQjcSe6Bv2VMfk0A16JTHi8M+bJGyULLems2uZRCMrTtk5QS
 qOT0tnoX247ezao6bf15oNJ6e3GnSxlztd4Ls4pc/M36HtwORF5fo506inah7oUFsEOiJjBXMa9
 YhcyGflSBsXF6h8vXDg==
X-Proofpoint-GUID: ZCXAfeHHgaOG47v-JT9vD0wpNhJSfkzK
X-Authority-Analysis: v=2.4 cv=bcD+w+PB c=1 sm=1 tr=0 ts=6aace0d8 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=LX4K7wk6A3+k0W4S2WE0Kw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=7bky9te5nA2tsC3mpIgA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDA5MiBTYWx0ZWRfX9Vrt6k3tJcsL
 WHqPAY/npc4umdsmpCgmLAznQL6C44smEpaBm1mYp493lVAVgfMwz3NLd8RFta/G9RbA5gMovn/
 wiEzaCLtNvol/TOWbvJDw2mBeymtDNs=
X-Proofpoint-ORIG-GUID: ZCXAfeHHgaOG47v-JT9vD0wpNhJSfkzK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180092


On 9/17/2026 12:41 PM, Krzysztof Kozlowski wrote:
> On 17/09/2026 09:09, Krzysztof Kozlowski wrote:
>> On Thu, Sep 17, 2026 at 10:30:19AM +0530, Vishnu Reddy wrote:
>>> ---
>>> Mukesh Ojha (1):
>>>       media: iris: Enable Secure PAS support with IOMMU managed by Linux
>>>
>>> Vishnu Reddy (8):
>>>       dt-bindings: media: qcom,glymur-iris: Add glymur video codec
>>>       media: iris: Replace enum-indexed clock and power domain tables with per-block structures
>>>       media: iris: Add power sequence for glymur
>>>       media: iris: Handle CPU_CS_SCIACMDARG3 register write via program bootup registers hook
>>>       media: iris: Add support to select core for dual core platforms
>>>       media: iris: Add platform data for glymur
>>>       arm64: dts: qcom: glymur: Add iris video node
>>>       arm64: dts: qcom: glymur-crd: Enable iris video codec node
>>>
>>>  .../bindings/media/qcom,glymur-iris.yaml           | 218 +++++++++++++++++++++
>>>  .../bindings/media/qcom,sm8550-iris.yaml           |   6 +
>>>  .../bindings/media/qcom,sm8750-iris.yaml           |   6 +
>>>  .../bindings/media/qcom,venus-common.yaml          |  11 +-
>>>  arch/arm64/boot/dts/qcom/glymur-crd.dtsi           |  10 +
>>>  arch/arm64/boot/dts/qcom/glymur.dtsi               | 120 ++++++++++++
>>>  drivers/media/platform/qcom/iris/Makefile          |   1 +
>>>  drivers/media/platform/qcom/iris/iris_common.c     |  10 +
>>>  drivers/media/platform/qcom/iris/iris_common.h     |   1 +
>>>  drivers/media/platform/qcom/iris/iris_core.h       |  32 ++-
>>>  drivers/media/platform/qcom/iris/iris_firmware.c   |  69 +++++--
>>>  drivers/media/platform/qcom/iris/iris_hfi_common.h |   1 +
>>>  .../platform/qcom/iris/iris_hfi_gen2_command.c     |  19 ++
>>>  .../platform/qcom/iris/iris_hfi_gen2_defines.h     |   1 +
>>>  drivers/media/platform/qcom/iris/iris_instance.h   |   2 +
>>>  .../platform/qcom/iris/iris_platform_common.h      |  46 ++---
>>>  .../platform/qcom/iris/iris_platform_glymur.c      |  78 ++++++++
>>>  .../platform/qcom/iris/iris_platform_glymur.h      |  15 ++
>>>  .../platform/qcom/iris/iris_platform_sc7280.h      |  28 ++-
>>>  .../platform/qcom/iris/iris_platform_sm8250.h      |  26 ++-
>>>  .../platform/qcom/iris/iris_platform_sm8550.h      |  26 ++-
>>>  .../platform/qcom/iris/iris_platform_sm8750.h      |  29 ++-
>>>  .../media/platform/qcom/iris/iris_platform_vpu2.c  |  20 +-
>>>  .../media/platform/qcom/iris/iris_platform_vpu3x.c |  67 ++++---
>>>  .../platform/qcom/iris/iris_platform_x1p42100.h    |  27 ++-
>>>  drivers/media/platform/qcom/iris/iris_power.c      |  20 +-
>>>  drivers/media/platform/qcom/iris/iris_probe.c      | 153 +++++++++++++--
>>>  drivers/media/platform/qcom/iris/iris_resources.c  |  81 ++++----
>>>  drivers/media/platform/qcom/iris/iris_resources.h  |   8 +-
>>>  drivers/media/platform/qcom/iris/iris_utils.c      |  58 ++++--
>>>  drivers/media/platform/qcom/iris/iris_utils.h      |   3 +-
>>>  drivers/media/platform/qcom/iris/iris_vb2.c        |   4 +
>>>  drivers/media/platform/qcom/iris/iris_vidc.c       |   6 +-
>>>  drivers/media/platform/qcom/iris/iris_vpu3x.c      | 216 +++++++++++++++++---
>>>  drivers/media/platform/qcom/iris/iris_vpu4x.c      | 137 ++-----------
>>>  drivers/media/platform/qcom/iris/iris_vpu_common.c | 102 ++--------
>>>  drivers/media/platform/qcom/iris/iris_vpu_common.h |   3 +
>>>  .../platform/qcom/iris/iris_vpu_register_defines.h |  13 ++
>>>  38 files changed, 1229 insertions(+), 444 deletions(-)
>>> ---
>>> base-commit: 0d9d0dbf2fddcff5859d623e90ca73c4054276e1
>>> change-id: 20260917-glymur-627d049900e0
>> Look here:
>> https://lore.kernel.org/all/20260726-glymur-v10-0-de451559e88b@oss.qualcomm.com/
>> change-id: 20260601-glymur-4fcd4d832ecc
>>
>> so now does this work?
>> 	b4 diff '20260917-glymur-v11-1-e0c8bc914742@oss.qualcomm.com'
>>
>> No, it does not. You are sending bigger work, multi-version one, part of
>> even bigger work, so please get the process working correct to make
>> reviews easier.
>>
> And it is getting even better:
> v6 change id was:
> 	change-id: 20260515-glymur-6e69bc258fb0
>
> https://lore.kernel.org/all/20260515-glymur-v6-0-f6a99cb43a24@oss.qualcomm.com/
>
> ???

Thank you for pointing this out. I lost my original workspace and had to
recreate it, which unintentionally changed the Change-ID. I'll make sure
to preserve the same Change-ID in further revisions.

> Best regards,
> Krzysztof
>
