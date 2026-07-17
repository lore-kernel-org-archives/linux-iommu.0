Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4633148A8
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 03:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784260118; cv=none; b=JPAlzcviDuugpKPlOy94yvbQEmmJMNaeARGUARaJRvbtvGjohEuNHzynYM1k+B1FITb0Wda3wnArtXPQItI9Ss8KmPr7NVyhyGRT6xkdYHFzgoEuNFMjt1Lpxq9FakzWWtI4AwBsftdK15uXVr3Re/RBuOWnP0dnqyQBSqQLcnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784260118; c=relaxed/simple;
	bh=Sa3wk56MV2g/ndnDgfSJgHE84Rp9SbiopO4rIgP3Ijc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P/y8+hY9HMLqpsSW3MLB4/W7oE9SSLcldqCntztFSieM1bdGBBerBfz9Y811TBKJe4zH4awpe1ecVmu4om6EXjox8vPCwWSnM8XOibHB7SXZhw+By0PoLrkdhXXV3tEVAbdap2LNh6pZZjmMpPPRUkaLG+dTtxy7uKj0iXSB4Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Jqmxyi0B; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bjnfVtc5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Jqmxyi0B";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bjnfVtc5"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66H33rgu607310
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 03:48:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Sa3wk56MV2g/ndnDgfSJgHE84Rp9SbiopO4rIgP3Ijc=; b=Jqmxyi0BoBIbO7SH
	m4Ze+Co4+zLo2mX7ah0CABGEPhAjxVMyzc71vmcub7tF7atTvUJkSB44okuHQQcP
	awn8Iz15DQw4Sj9zMck6wwsJ/Gek6PjVqht7DBltNUJgKWUVQsgDIba344ThT8db
	eu54JqhePGGKoamLY+e8C3vKaEfleJx2mbpS0+vxcmxDGPTqLtRxYgSOSz7C7RH7
	30SGP307HrIG7NGIEcwgV5LKq3apqmMKpcG9lse66cO4HO++QSeAGKUrKo8qb1ms
	arGsRtJvB1OEUvCm7Oz2SbzSxhP8uAm+myA6oV+RBwNrxoY1eA9iaR6m7gh3ojY1
	1BWKCg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feu10cgp5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 03:48:35 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cee894b3d8so71866045ad.2
        for <iommu@lists.linux.dev>; Thu, 16 Jul 2026 20:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784260114; x=1784864914; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Sa3wk56MV2g/ndnDgfSJgHE84Rp9SbiopO4rIgP3Ijc=;
        b=bjnfVtc5hcgQIYZsUwGcyufcIvl4syCWpQCqQSfreeoXVaEwCno/MhEc7L01NLMHSZ
         qoOXjuT6MFI/jPExUb49W91Ku1R7mHTEQYLYTZ7li46dPn58B/PP5Qnd0R5WlWB0lRfI
         u6K6jaBJOheF4DoPomyXGtCyzOhj6EPiELEG3+dEfWdGS8K5RTM+herpCkeNETX1Sj2F
         ZltpZdVv99irHsbt4Evl1BeeBR1f0yySSOJoe06g/udvvv0+pjmWu1xbJ9nWpOSy+Ng5
         OSMsumejWvBrEkrJRYyWH2ULsSrGuqFRdjajwZq3HGg1DS4oSN2wkI248iIe0koMFj18
         zhfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784260114; x=1784864914;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Sa3wk56MV2g/ndnDgfSJgHE84Rp9SbiopO4rIgP3Ijc=;
        b=hT+Rn2UMAwMf7rOnZPECo2vQA4YJptUNsEbB2ldjYajZeP9GA4wPHH+csNWRFox3pT
         XOGoFsJcJBPk2tkkYY7YXmLiLDG34agUuE3Jal3gMrevp2lA6NIfyjiM+6nW1ZysLrAk
         ZriMpgLTIVA+tGZ6/P0WAmxJOYurmpHjoHx1W4sqAvN5n5gNZczZrB45Dv+yqKy7N0Se
         r5kDI2SPS/DwWuuSMaIQCC0nFZ6chwPrdpsezhE1SWuqkJW3IP5xBKRj2mahCJ3GJnqG
         nv/uL2DVwxF/Og/STFGHIbCUNQPvy1ZbfJuUvihegrbCKcyg9iA2Y12Dp3LRBDbIuDCK
         4w7A==
X-Forwarded-Encrypted: i=1; AHgh+RrxIPo0XAFnAfubfe4pHspVJDxyF/OleuWVGp/d5USbPcT4LJmC+QuOShOMQQORs0c0QalioQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyVW5eGTq1cfQ3AP+CwOiRrc24EpN1VT+gwZiKfNRkL+1dI9SMl
	fhGey+mdroYhCp9z71O6GS6TT2LAVgh0rUX5AYR4V3QOwnpPO8EYSSJAkfZIVOh4srAFY9HopRM
	dzcDAtjuwglHsrnKeNc5ztPmXFifXwIiGM2IcVvlQQOamd0Le9Sx6P8xTsg==
X-Gm-Gg: AfdE7cnJcST9Oku3Y1gk5MSmuskafaHnrJYsHOFQdJ+WiyGh+eC52y0dlvy02IF8oli
	B8EFXGSNG15ZK+bgY8+rtgL/5W1ccCTA/mJyynC6DZBKD6YMDacpsJR39u4hNCsf7rTZbK6b8nJ
	K4Loe3XzwBd+IjBGVG2uS71s2xSX8tldASALYWVTTA3zuR11jawQUP0kduA33t3KQqa68x4WO68
	vPykMhcqVW3O83t2yt51/cCBsqp14T18rNeT5BcqWXEyFzhI5r2Oc8fZbeQ1WRIv3iVdqXs0vmk
	ECgCgtbvkQg77BYWGvcNPbhN3mTHGdm1bFCTTx7oAaFtJFAkWAY4w7Dam+VeClL6GaorTdH+xQe
	eDiLQSEEJbB7JyipmNR0CAtLg8S16G10R
X-Received: by 2002:a17:90b:4c48:b0:387:df8f:1402 with SMTP id 98e67ed59e1d1-38e4b57e9aamr785473a91.35.1784260114125;
        Thu, 16 Jul 2026 20:48:34 -0700 (PDT)
X-Received: by 2002:a17:90b:4c48:b0:387:df8f:1402 with SMTP id 98e67ed59e1d1-38e4b57e9aamr785438a91.35.1784260113651;
        Thu, 16 Jul 2026 20:48:33 -0700 (PDT)
Received: from [10.206.105.200] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31429fe4677sm1547122eec.11.2026.07.16.20.48.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2026 20:48:32 -0700 (PDT)
Message-ID: <8ebd304d-b03d-a8cd-2bf5-a45763780098@oss.qualcomm.com>
Date: Fri, 17 Jul 2026 09:18:24 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v9 01/14] dt-bindings: media: qcom,glymur-iris: Add glymur
 video codec
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20260715-glymur-v9-0-8cf2cbe12a07@oss.qualcomm.com>
 <20260715-glymur-v9-1-8cf2cbe12a07@oss.qualcomm.com>
 <20260716-soft-dexterous-adder-badb49@quoll>
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
In-Reply-To: <20260716-soft-dexterous-adder-badb49@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: YzyrlJ3kgDSU1M_RhFYIlfjmyRPqUROR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDAzMiBTYWx0ZWRfXwzmjrn42N9ce
 Vju75bH5SNQCTLwQZZY8HQqW0qD5GHfz2bEaQvi0N+Oi5x/pMwEcP6X0JEUhnKqxa9TIijWWG/v
 5zN0sbmiBysgzqV1Rd+vM8F8h9vS8K2QXDSLZuhX+2aB7o9wNzpn1lu0A06RRb+yhzJuvaxlNiX
 qbZqdtJj9JWP0js/1m73VdvDx5sF0ZOCV6m4CWnfVmRqFaFW4VtGUotkX0C4I5Q5vrI7ai1BUv7
 giD0bZ/tt4b4RYp9oGnp3LCReOk+CsMxW8O7WkQmlwnmdA+nJP9VvLoKYR9JU7c8w17zdl6wDK6
 9VqZhWtX91dszg31Ssh9UsZmIrYKUTBT6Dzsh3lJcphLiDEhxheU7LZnLUbe8bry1n71pf7oOck
 fWKsYFXthvewuWdvfw1ejx1uvpUUGjuETt+OGnuMaSy8QScPUrT1Kg8gH0HIxJlTQUj75irXGhB
 czFPEsesk42WPzQvAXw==
X-Proofpoint-GUID: YzyrlJ3kgDSU1M_RhFYIlfjmyRPqUROR
X-Authority-Analysis: v=2.4 cv=BPODalQG c=1 sm=1 tr=0 ts=6a59a613 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=Mf6ET5Z485SzACLcFDwA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDAzMiBTYWx0ZWRfX5SBuH8F8GO+Y
 hpTVu+gLc5xykeO2TGbaqWLhGJldezSdBlQ3zd2tIQPbFlFhc5wyLsZjDch75ssll9TWThga9j2
 8o5lmgBkj17wYj0mfB9uTB6UgK1I9K0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_01,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170032


On 7/16/2026 1:10 PM, Krzysztof Kozlowski wrote:
> On Wed, Jul 15, 2026 at 07:39:55PM +0530, Vishnu Reddy wrote:
>> Add device tree binding for the Qualcomm Glymur Iris video codec. Glymur
>> is a new generation of video IP that introduces a dual-core architecture.
>> The second core brings its own power domain, clocks, and reset lines,
>> requiring additional power domains and clocks in the power sequence.
>> The current maxItems constraints for clocks and power-domains in the
>> common venus schema were sized for platforms available at the time of
>> authoring. The glymur platform introduces a dual core architecture
>> that requires more clocks and power domains, exceeding these limits.
>> Raise maxItems for clocks, clock-names, power-domains and
>> power-domain-names to accommodate the glymur platform.
>> The glymur platform-specific schema have fixed constraints for these
>> properties, so the common schema only acts as an upper bound.
>>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> You must drop the tag, you changed the binding significantly without any
> doubts.

Ack

> Best regards,
> Krzysztof
>
