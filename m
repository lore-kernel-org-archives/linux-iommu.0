Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC1B3F23CA
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 12:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777378635; cv=none; b=PqOI+RI3UlgMBFhrjRa8nLwy9bcE3l5r9TmKlVZwb4JyQyAbDMPg3L9f1brpD3/WXH/3135MYiKxBRTmhsjXmiFfeZfT4oNZm7V6+5RJikSN6QDhc+uOLBnLL9wl2CHpRZkRBc0fApraqIUj6lIvDwtI551F5o/KqKAMP2nxbsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777378635; c=relaxed/simple;
	bh=kM56ejo5gQ6HGoBQsJpChux9jZ3rBKCnxv23GmTAmSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dRXemR8BRV/VgA4ngoeRgkBw7PsyvuKIMj76X+PeqKBC5A8A/H8ZVTPVCLgbIcb6SnniqqIjzVXhRvzFgw2YpYvKLPVHggpirlIrkRBgJYNvpdXBgM3xOcN+9JHx/hVTnpI36OWn/U/x8xUgPbldlkXGWHTrF8Nf0ElSD3fEh6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QlJqfC/V; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dALDHFe2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QlJqfC/V";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dALDHFe2"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S7vhsR1744712
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 12:17:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kM56ejo5gQ6HGoBQsJpChux9jZ3rBKCnxv23GmTAmSo=; b=QlJqfC/V5tchW8uC
	Cs2apDV9Yk9hxjrYUvsr29xsmR7A1r3znXY0ozNeCbeY7t9VB2IwJAJBTq9CmuiG
	LMRglGB5hcP0pdXdJsNmMmn2Mky77MGfAdLq5YS/oF1fe1cCAOx1wxVaPWYdCyXe
	IZHm4WDmSaKlcgG2QDtCwcaS2GOJvkp1PTHCvJT7L7nTY71ZzVco7kY9P8HC8Kh4
	mQ5bEWq3jKObZDwSL/aU4yZT7PClPSzmWfPucPAHOfMGnf3fwAgRw99xvO+z2Jdp
	P2slcM8THAeZJdzcNKxmHbIn1hdE26cRPo2hHg7qjinOUmuXirwTXQ8084W5NuYV
	EGBLsA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtryd90xu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 12:17:05 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b250d3699aso225540575ad.2
        for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 05:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777378625; x=1777983425; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kM56ejo5gQ6HGoBQsJpChux9jZ3rBKCnxv23GmTAmSo=;
        b=dALDHFe2Zarc28J1s21OaVk/gnSyohznr31h8Ya5yhTjas+d+pAc3Ej/0VAUTvjvmR
         uTgJ/HsRLgJNlUAcI3SndfUL3Jhxae/K2pX5J21DXlNFE1ef6+xu3WwILNR5X8riBY2J
         i1Cy+i8GRSMayc+A6xJHeHvUHUYQcKsP+J673TvKVK+Gb1muS5uXhz1XJBUeiTI1KAxm
         VL32nGGYk5N6Qp77kjaNfQQaN222CdewEvd37RihcW0HQuTZ502mZd82jDmATZWvLh8M
         eX10BqjA8j/qXQ5WWFBD6PFdgY/xXLEjoA9kNj1LWnwlMjmU42lYUYb1q8BrpTG6b4kO
         qcFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777378625; x=1777983425;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kM56ejo5gQ6HGoBQsJpChux9jZ3rBKCnxv23GmTAmSo=;
        b=ZKwcVLl8MS/ATJZCuUY37Up7Kx82tfDCiM1NSiCLq4P6R/MvxxEyL1q80fr6KgM9vZ
         IdJqEmOKsBoIR7SIrlg0G1AW/lwC1G4LKmCbWv5ivANFvlGMR7pTzGWKagdZnQZMQXcC
         HiLvGz9RrWo3qmU6mqLu+7oEJz2EU3WqPe3b+LrL19otAbtk9reaYxFbqAa+W43oBA1+
         JRDxrZ9auvJEl5O/W7+x7mxvNlVqwj4VgE2TpvBV9Q6UUe0VjaUN/DDEUgyO0OIxy62y
         X7m3qq+Fhz6CwsnM9CR6CGKuAwDT+5qiGwHEmixNW51ft9hK+ewlwNhlVLd8jQogy4LT
         X+fw==
X-Forwarded-Encrypted: i=1; AFNElJ9dde0W8WamvKFBus3NHEzHINlwSID4hK+mNf7TEMgjIxcEjUZ6kJ/pU7htcCHsmMEGkIA7Aw==@lists.linux.dev
X-Gm-Message-State: AOJu0YziO6+E2rToSzxiaY6ov7zsi6sKc6y++s/k5dIVyDqh8BtU0rkU
	KHXzzETo986B3VqrRHcOzoLFcN2U9K0Jxp20sJ9VTlbMtIUrRlvNBpTA0ACqBNaxfFPNtnWeLiQ
	2OhxTYFHaNS8ycJZIC6NM9VrYaoyy1IloayqK+upvUONss/BPaoVDWPofPQ==
X-Gm-Gg: AeBDiesr/D1zBjeznf0I6nbfE7YZQwmtPBy5uRKPinuWvDF11AyJ+9mIXxn1jyqpdIJ
	pegb6q7UTDOxnqkY+qkO1+tKbBQ7cCi1ONo/i/MWl3craZqHZ1JPovBS0YZSVZaoFx0jKuupLUD
	icLWSY7WnVBxM2kD3UaIa3GgLmlG/oVZ5SeOazTqkie/kbdgkKgVZQ3pNsrJkqGMZZZUD13pDv+
	WUbMP8v4cklusPpK4Tz0pigJu+USlUu3LLp4umld6GoBtoCmy+aOjQivjWc1jJrz4aJiniTJGu+
	Bop69nXS2SUQwpZi1/xjA099VOziZLdBw3h49GgGylWT7+1MBSOQOk5sVtALEX1agJ3HLjB8IWl
	pFrAjS58TeB0wP0Xj2hiv9t/i1K+zFJ/YzivOU5uq/QnLZyafs7b2E1a2aWi6q+9D
X-Received: by 2002:a17:903:388f:b0:2b2:4a9a:b168 with SMTP id d9443c01a7336-2b97c3febaamr28330785ad.11.1777378624742;
        Tue, 28 Apr 2026 05:17:04 -0700 (PDT)
X-Received: by 2002:a17:903:388f:b0:2b2:4a9a:b168 with SMTP id d9443c01a7336-2b97c3febaamr28330335ad.11.1777378624142;
        Tue, 28 Apr 2026 05:17:04 -0700 (PDT)
Received: from [10.206.105.200] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b97aaaf65fsm25666705ad.31.2026.04.28.05.16.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 05:17:03 -0700 (PDT)
Message-ID: <e39df722-3868-60d4-07f3-768d11762e12@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 17:46:55 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 02/12] dt-bindings: media: qcom,glymur-iris: Add glymur
 video codec
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, iommu@lists.linux.dev
References: <20260428-glymur-v3-0-8f28930f47d3@oss.qualcomm.com>
 <20260428-glymur-v3-2-8f28930f47d3@oss.qualcomm.com>
 <20260428-nifty-quaint-hoatzin-6de65d@quoll>
 <97aa5f18-d1d5-f082-9075-a385255f2e97@oss.qualcomm.com>
 <7d775357-c7b1-4cf5-af90-012d1364e773@kernel.org>
 <6ebe28dc-b8a3-db92-0e66-3f0541e23e13@oss.qualcomm.com>
 <1f88a8eb-1725-4e6a-b4f3-287ec538ee7d@kernel.org>
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
In-Reply-To: <1f88a8eb-1725-4e6a-b4f3-287ec538ee7d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: uCPEFGI04th9XzEZ2CQGCLByFXnNr3-Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDExMiBTYWx0ZWRfX/UqxxrOrx4O6
 SfzlzBk5dd9qt6YQ+y65IEgNB3XSiMHwwdDn2iAdwBib3g58Br+cCJVttnGU9t5P8OwP2EJuWdj
 URCOBjW++ca4/N4bYQ4BWUvLibt33VA/nyGm/HIJO9EX4GevAmyNHicJRuyDSALGgLA2SFAk1F0
 AW1SRACtUqUk6+iOVpFw4E3c/LOcSNZ+poIFN+dVYnD0e5NYffSBG0CxPljbUiYxfHvRLBoLuVD
 ro9B37A7ln9kYdQl0AtFDPpeDq6PGsT86I/H490SnY0li/m0RIuslFCx98x5q9B66CpthJ2l0i6
 UOIkblDyH9Wg8fKm5GgXHm9jx3+ow4k2jOHDzl7jV/WHZVonrXp5mI1SUayRisf2Y+FPUD/ZD8y
 3ykHZRyjk0mEmMxAljAqm1y8T1LFYeYk7fe5RpwlxDdJCgfLpEWG95qbdqKPMB4sfcpyJcu9pxj
 +0rBJt/U6VllLhswJ/w==
X-Proofpoint-ORIG-GUID: uCPEFGI04th9XzEZ2CQGCLByFXnNr3-Q
X-Authority-Analysis: v=2.4 cv=cMnQdFeN c=1 sm=1 tr=0 ts=69f0a541 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=IkJjYso2sozc4OUn8SEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_03,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280112


On 4/28/2026 2:48 PM, Krzysztof Kozlowski wrote:
> On 28/04/2026 11:12, Vishnu Reddy wrote:
>> On 4/28/2026 1:58 PM, Krzysztof Kozlowski wrote:
>>> On 28/04/2026 10:08, Vishnu Reddy wrote:
>>>> On 4/28/2026 11:44 AM, Krzysztof Kozlowski wrote:
>>>>> On Tue, Apr 28, 2026 at 09:24:08AM +0530, Vishnu Reddy wrote:
>>>>>> Add device tree binding for the Qualcomm Glymur Iris video codec. Glymur
>>>>>> is a new generation of video IP that introduces a dual-core architecture.
>>>>>> The second core brings its own power domain, clocks, and reset lines,
>>>>>> requiring additional power domains and clocks in the power sequence.
>>>>>>
>>>>>> To accommodate glymur clock and power resources requirement, the maxItems
>>>>>> constraints in qcom,venus-common.yaml are relaxed. This allows the glymur
>>>>> This is a very confusing part of commit msg. You cannot relax the
>>>>> constraints. Each device MUST have a specific, fixed constraint. It is
>>>>> your task to be sure they are not relaxed.
>>>>>
>>>>>
>>>>>> binding to inherit from the common venus schema without duplicating shared
>>>>>> properties.
>>>>> That's obvious. Why would new iris device schema not use common venus
>>>>> schema? What is different here then that such possibility exists?
>>>> Glymur platform has a dual-core video codec architecture (vcodec0 + vcodec1),
>>>> requiring 9 clocks and 5 power domains. The stricter maxItems from the
>>>> qcom,venus-common.yaml takes precedence, making it impossible to accommodate
>>>> glymur requirements without updating the common schema.
>>> But so does every other device, no? So what is different here?
>> The difference is in the resource count relative to what qcom,venus-common.yaml
>> permits. Existing platforms like SM8750 have 6 clocks and 4 power domains,
> So it is EXACTLY the same?
>
> Again, what is different between devices that it should not use common
> schema?
>
>> which fall within the maxItems limits defined in the common schema (clocks: 7,
>> power domains: 4). So for those platforms, referencing qcom,venus-common.yaml
>> via allOf works fine, their resource counts are within range.
>>
>> Glymur dual core architecture (vcodec0 + vcodec1) requires 9 clocks and 5 power
>> domains, both of which exceed the common schema maxItems. Even if
>> qcom,glymur-iris.yaml explicitly defines maxItems: 9 for clocks and maxItems: 5
>> for power domains, the stricter limit from qcom,venus-common.yaml takes the
>> precedence, causing schema validation to fail.
>>
>> Glymur is the first platform where the common schema limits become a hard
>> blocker, unlike all prior platforms that happened to stay within those limits.
> Hard blocker? What? How? you are imagining some problems here which do
> not exist in any other devices, any other IP blocks.
>
> Why is this special and GPU is not? Or display is not? Or anything else?
> Why standard rules of writing bindings do not apply here? What is
> exactly different? Write like this:

The intent is not to treat Glymur as “special” in the sense of resource
count alone. The key difference is architectural:

The existing qcom,venus-common.yaml was originally written with single
Venus/Iris video core and its maxItems for clocks and power domains were
defined accordingly. All existing platforms fit within that assumption,
even if their exact counts differ slightly.

Glymur is a multiple vcodec cores platform, each core requiring its own
set clocks and power domains. This breaks the implicit single-core assumption
encoded in the common schema, which is why the existing maxItems become
insufficient.

I agree that simply relaxing common constraints to fit a single outlier is
might not be ideal and not scalable.

So one another approach to handle this requirement could be to remove the
maxItems entries for clocks and power domains from qcom,venus-common.yaml,
and let each platform specific binding declare its own maxItems. This keeps
the common schema reusable across both single core and multi core platforms.

> "The standard rule of <foo bar> from writing bindings does not apply,
> because <baz fab>.".
>
> Best regards,
> Krzysztof
