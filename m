Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684B3238C20
	for <iommu@lists.linux.dev>; Fri, 25 Apr 2025 09:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745575083; cv=none; b=XTa+cPpqwCcvw6T/qYFilxbq7FEHm1qFean5U88KImi4KljuEhsSNDlWsoV3NKGCltyV8Zp2MFiNUTipYDqdvgS4zHotSXK/XK6Is1oO6c0qlo68S6QhMHUCZqyuMf92AqWoTRtqWpfuumhGjuTeKV80Ne0wAI+acmz1A50XSus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745575083; c=relaxed/simple;
	bh=Vf/rLd4GFcJ3rfHcTZhJzseE/NW/DuE267IkH38ND9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fU7kBLAryl40Hfo5z92jU89rq+JsCTdWDkiDtlkJffB4lMTwhbnbzjHF8iHj49K9K7DPXbRuD8jzt3AyzL+v79J8lUeVqhqZXn1xVe8vX+zVokbdMPj+j20xAy29A62A5YmS8tagOZCRwDDkZJ1Sxb2pRYj01QbcTZTGbYZoxHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bo60nUk9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bo60nUk9"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53P8TBel018977
	for <iommu@lists.linux.dev>; Fri, 25 Apr 2025 09:58:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Vf/rLd4GFcJ3rfHcTZhJzseE/NW/DuE267IkH38ND9w=; b=bo60nUk9AriZpXIr
	8ljFtmcUnt1uRxZYBxGkQQlsIai1k8jsLguG+AwgraCpok0IcazIBJZjpNR0oJnG
	KvgS0pzEuAGog/4KSHfuQpdLZcO10pZC9b/uUF/Al2RV0NjruLsFzxsnbmG7Pxeu
	3PcJWrNtdoY+T5Oxq+sgEku3XYUqyme3hcVfzq+y469VFQI52PgGyM61PPtWmBkn
	WbIslN6eW1R5FoyNVOSuB1C5h3wS6fo1bXCfzeIlEE12BfWDz+t4D3cRvFV4mLTg
	1ijoB2emkUJJsQ+MaXJjDtnawqSHOjCg55JBOV420CiR2xDzhZitC5GczT/tgQcm
	5ga5zw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh28mar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 25 Apr 2025 09:58:01 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6eeeb7cbd40so3126586d6.3
        for <iommu@lists.linux.dev>; Fri, 25 Apr 2025 02:58:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745575079; x=1746179879;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vf/rLd4GFcJ3rfHcTZhJzseE/NW/DuE267IkH38ND9w=;
        b=Z3Gxx/QhJWJrU6NSN7VXDYJzl0+EoLBv1Dm8BIyZ4nYjYnj1tyv3QvGRBbWP0WXBKQ
         iL6d5W9kmqAAUq2vzLnfe6TJu7FPXF2m+iPWNvRZ8HcckbctrwyEIYdu0VsWS5+/SeVj
         7TM2SYcbJ1HcWnJ/DuuasMl7dogDJLGFAECQYgurUMa6bkGEwFXFVkCefo8QiWtA7sK7
         kWQ8K9C2A15K58Iefi1RBjOtg1e5VDFIH+IBzNnMLLH9zqMzmlS6XpkObVzICbJjbzvG
         8pszNcP+qQSL1y4QjSBqA7aa97GT18pkZGUiIyKLlN5duUh/Fg+E3TdhhOJUK+fELBg7
         bcBA==
X-Forwarded-Encrypted: i=1; AJvYcCWA3bDbyR3+7v5GOG3X0673f68Bzqf9/MDJH5GkusiYpWEsPgggq0Tc6fp5YdfRMpVMwj8Z2Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyzWk9muFuo0ZEJ3ROh7na0D5Wkbqzf8wkS5bTypT05juy2TcR9
	Q7sorp1vXqLV/rLTcfOSKPmfOoCSo2L1UII7Ir8E3glt1sR3O6lO+Ls0jzzlEqTI+FPg8+LRBkf
	fhQ58v2l3dMNjYiUV9iyK/CW/55NsF5UGPTcSk+Jpk7XYkZJfWKKjBg==
X-Gm-Gg: ASbGncsQ7EK3b1R0Gvy+KE8OQeBk7FIi9lirRu3CEjiiAZw0sBz/n2Sjg8VoIi0VOuK
	7bLPZp46Uf9zpt1I7wCQYvpXsqtCKygeOy84EVhuYZL7QojbcZLIT8483ltr0wb3hzHKCyNJCSC
	SmXa3AghqiP8yMqZJOw9DgWWNd/maLHyt4JQoyvKGOL90LwyRmeyGbB5DyQp5y5CLrOtcYGb9RX
	dIGLuWwoH/8QuoUGTRsHd+jRIGyZxu2wk6v3KaeQgBfG2opFDJwkgwOg1W6Tsk41dyrHfmN1gDV
	HhMKd9+n6RD6q5ILG2+jpYX5XsfEL5l/L55KIsgPGXzpVDqdNgHFa11V3/cvEB1c
X-Received: by 2002:a05:6214:27ec:b0:6d8:ae2c:5053 with SMTP id 6a1803df08f44-6f4cba5f634mr10002146d6.9.1745575079779;
        Fri, 25 Apr 2025 02:57:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1aDrr9tIrGOVh+lPKRQPvx999AwcL22qiAWtArNF4QQ88HDa7YW9+wreCLFQKaTgC7b9wGQ==
X-Received: by 2002:a05:6214:27ec:b0:6d8:ae2c:5053 with SMTP id 6a1803df08f44-6f4cba5f634mr10001956d6.9.1745575079389;
        Fri, 25 Apr 2025 02:57:59 -0700 (PDT)
Received: from [192.168.65.5] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f7016f5342sm1032645a12.35.2025.04.25.02.57.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 02:57:58 -0700 (PDT)
Message-ID: <70635d75-03f9-49ea-8098-57cb144fda94@oss.qualcomm.com>
Date: Fri, 25 Apr 2025 11:57:52 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/5] arm64: dts: qcom: Add initial support for MSM8937
To: barnabas.czeman@mainlining.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        =?UTF-8?Q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>,
        Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Adam Skladowski
 <a_skl39@protonmail.com>,
        Sireesh Kodali <sireeshkodali@protonmail.com>,
        Srinivas Kandagatla <srini@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        iommu@lists.linux.dev, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, linux@mainlining.org,
        Dang Huynh <danct12@riseup.net>
References: <20250421-msm8937-v5-0-bf9879ef14d9@mainlining.org>
 <20250421-msm8937-v5-3-bf9879ef14d9@mainlining.org>
 <2e3d94a4-d9e1-429e-9f65-d004c80180e5@oss.qualcomm.com>
 <790a0b7537e0b82b70bc4b32612ecee6@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <790a0b7537e0b82b70bc4b32612ecee6@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=EtLSrTcA c=1 sm=1 tr=0 ts=680b5ca9 cx=c_pps a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=OuZLqq7tAAAA:8 a=bBqXziUQAAAA:8 a=x_pH4qmy28IV03WXGqsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22 a=AKGiAy9iJ-JzxKVHQNES:22 a=BjKv_IHbNJvPKzgot4uq:22
X-Proofpoint-GUID: mFThPLULiCKsMc8AyXRXAqKsanQoEGlT
X-Proofpoint-ORIG-GUID: mFThPLULiCKsMc8AyXRXAqKsanQoEGlT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA3MiBTYWx0ZWRfX89GWBDHlGdkv hkNVbvRtVQcMjK4naZLSZRVWNgJDudFlY5xzs4g166rXO5iqXXwNtGKnaFBMeB+vB0ijhbdlLxV 4uDoInBs6e6OIankAyeCfhFwSVAa7GI0IDkQJ63Ca1kPqdxxrdCnKlxMJVRRFAC1m719572Ni3H
 yhyueYYE0ZvRMfIcMx63VWrRAUopeuuYivFWpyfs5oXksxFTMHaVLRDg1HqZX5gl+GLmV5UJYPo 64m+bbk+YBcmLxCctlEYloEWl2VINMZLoRz4iQuR/k2zCGV/OyO8Ta629upXHTuuVAGnlhJsp7n wFmhRcymXzsKVYA/XTswDMC3TdISUHm1ntfSqgCcvNgxDD9Ah3XSTyoHs00kFTlKSNDuuJ4peOK
 F5AkwylbvZVKMkZL2ELO7LIHFp28kDpYQX539WosEdTX4bDdeABToQUy8m03Hu76O3y6X5ma
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_02,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxscore=0 clxscore=1015 spamscore=0 mlxlogscore=978
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250072

On 4/23/25 4:46 PM, barnabas.czeman@mainlining.org wrote:
> On 2025-04-23 16:03, Konrad Dybcio wrote:
>> On 4/21/25 10:18 PM, Barnabás Czémán wrote:
>>> From: Dang Huynh <danct12@riseup.net>
>>>
>>> Add initial support for MSM8937 SoC.
>>>
>>> Signed-off-by: Dang Huynh <danct12@riseup.net>
>>> Co-developed-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
>>> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
>>> ---

[...]

>>> +            gpu_opp_table: opp-table {
>>> +                compatible = "operating-points-v2";
>>> +
>>> +                opp-19200000 {
>>> +                    opp-hz = /bits/ 64 <19200000>;
>>> +                    opp-supported-hw = <0xff>;
>>
>> The comment from the previous revision still stands
> If i remove opp-supported-hw i will got -22 EINVAL messages and the opp will be not fine.

Right, I have a series pending to improve this situation a bit..

In the meantime, you should be able to define the nvmem cell and
fill in meaningful values for this platform

Konrad
