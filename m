Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5275913AD03
	for <iommu@lists.linux.dev>; Sat,  9 Nov 2024 11:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731153193; cv=none; b=f6TyTZiPyUZx/WSu/0tQPPdyMP5fU4NCEqPamnoDtDJTLKa6VStsoR+9SxZwINDHhW96C7gm08NqTjdbbZERILh2U/DX8Jld1Qs6k0lXNiuNfj4jeG19RYQVroM9kIdGFJmJ3zKsvfmVp4+q3tNd/7LzM4eG4OF76gwYy/9KqJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731153193; c=relaxed/simple;
	bh=WbO3bwNTbo9CJaITdFuh3lFQvk9b5CAZsrlvd0nPISU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r3TRQJ+zsQ8CrG7mW4MVy8FuZDrtrcaslcuOtvd4D2HhS0Vj2E96jBuRlgpNbuUo/jMqJLzzTzyGUdxGfis+7qQ6C2ijRsfNAWwVCl7+T3x5dA/M9PIm9rRiMgCqDwtu+mYIJXzUaNgN2NAsTbQYyYsRDOniKBBysu8Jf0S04Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ljK6H66X; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ljK6H66X"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A94QeUK003901
	for <iommu@lists.linux.dev>; Sat, 9 Nov 2024 11:53:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WbO3bwNTbo9CJaITdFuh3lFQvk9b5CAZsrlvd0nPISU=; b=ljK6H66Xjg6/l9L5
	msKLXhOB/aHsEyWw+SyAtPdiDrmdJAhQ28YGhSTKoJQtf4p0C8rDC1BA6Y9whRj+
	hEad6Zwc+rPEziO5SypeoWR/kb2EE95u+c1pFEvXmmSg6ihutXg9iaMtPrZzNIy0
	jPu2boRS2nh9zbeSZ1hOcnOLo7h2kxQP7rKOdfhdhOMW8ZWIvXVGpdF8adUYRdUu
	l0gfU8OrIfPtgFLpwoI/tjbFcE7uezjmYBqGh+nXPskqaoR8RrTAd/X385AlN3r9
	t6bjk1NlqgFOk+RH2w6qxzS4UEHh7RI6YBd9jFLZtAyxscsdXnL3WEORzSAjTmcs
	45jZhQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42sytsgjps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sat, 09 Nov 2024 11:53:09 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6d3b1d1d8c1so686446d6.2
        for <iommu@lists.linux.dev>; Sat, 09 Nov 2024 03:53:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731153188; x=1731757988;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WbO3bwNTbo9CJaITdFuh3lFQvk9b5CAZsrlvd0nPISU=;
        b=Uoit7gZ2DuGu6j4UmmqgG+PjgCDzslLyBz+AzP+U2huD5VgzHsAfpzFy5mgYVqSIi7
         zext67u+xzzPkf+Umbc1iq0uTYLmm6A6lEqPhVNW02ajUlWng3Jo0n0tx9R7IT5R5u6/
         LJSgwOAOXQMw0Bw1CKKe3a7v3uH11icy8ng7VfIRTwlZPOPzGlkrlTMH5rhNGU3dg7xx
         O9i7VWzYeOhlNdjxTWdAMU1xfFBJpAjnWHDel4Ok3o0o9fugf27GmWZyhOTn2w7/x+xI
         kg6rMxQatNAdBHjAeqw+87+/iI7MjGeBVfbQYUnpxr7aasFpZmgG6qF7fbCqthDzI2tt
         ThHw==
X-Forwarded-Encrypted: i=1; AJvYcCVimL2GfbhsHNYfBYgdntfyhBNUJYFoyylkgo4TO3hJxLGWWq5gSaPEW6zBQcDo8aCpmntJ9Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxkYU/DIC7T1IFzqWOygy0A7ZJ97EKnevvRDcsuJo4my6Q/jXGq
	aO3p1iUMuYitr9JANDKGNPA2LiIXuk3NLGvgRRJtODtvR3bEtRVb3cjLpRCWr+WzSmxqyl8n0H+
	3w3gFz8VtQvQHH8f/BsR5kbWeV3f3UFeMWhi9JX67j1ePCIFYuNFUKg==
X-Received: by 2002:a05:620a:24d6:b0:7b1:8e09:5122 with SMTP id af79cd13be357-7b331dc1d1amr357302085a.1.1731153188351;
        Sat, 09 Nov 2024 03:53:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHl7UYZzV/NRfxqM1jrH9cTW8r3ctv9OuDpOq1GOlGbjBAVwnStnlfGHEtxjiNYaEuj2o1SYw==
X-Received: by 2002:a05:620a:24d6:b0:7b1:8e09:5122 with SMTP id af79cd13be357-7b331dc1d1amr357300985a.1.1731153188005;
        Sat, 09 Nov 2024 03:53:08 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a48561sm351434366b.48.2024.11.09.03.53.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Nov 2024 03:53:07 -0800 (PST)
Message-ID: <f4a2598f-28be-47f5-9f6c-5cbbf911c3ef@oss.qualcomm.com>
Date: Sat, 9 Nov 2024 12:53:02 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/14] arm64: dts: qcom: Add initial support for
 MSM8917
To: barnabas.czeman@mainlining.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Lee Jones <lee@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, iommu@lists.linux.dev,
        =?UTF-8?Q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
References: <20241107-msm8917-v3-0-6ddc5acd978b@mainlining.org>
 <20241107-msm8917-v3-12-6ddc5acd978b@mainlining.org>
 <0293b1c5-d405-4021-b9c1-205271107350@oss.qualcomm.com>
 <2c5f429d01fc04b2b40251e841bd4f64@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <2c5f429d01fc04b2b40251e841bd4f64@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: asWHCU_Yqorwcar6hYq5BbSj_gq3OJXd
X-Proofpoint-ORIG-GUID: asWHCU_Yqorwcar6hYq5BbSj_gq3OJXd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0
 mlxlogscore=931 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411090101

On 9.11.2024 12:36 PM, barnabas.czeman@mainlining.org wrote:
> On 2024-11-08 18:03, Konrad Dybcio wrote:
>> On 7.11.2024 6:02 PM, Barnabás Czémán wrote:
>>> From: Otto Pflüger <otto.pflueger@abscue.de>
>>>
>>> Add initial support for MSM8917 SoC.
>>>
>>> Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
>>> [reword commit, rebase, fix schema errors]
>>> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
>>> ---

[...]

>>> +                opp-19200000 {
>>> +                    opp-hz = /bits/ 64 <19200000>;
>>> +                };
>>
>> Does the GPU actually function at 19.2 MHz? You can check this by removing
>> all other entries and starting some gpu workload
> Yes

Thanks for confirming, feel free to keep this entry then

Konrad
