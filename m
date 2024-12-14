Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124C91B3949
	for <iommu@lists.linux.dev>; Sat, 14 Dec 2024 22:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734215191; cv=none; b=GJHGTdBCBxgVgVcnbVUiVwtOMEscczizLXMZcDAEH3c1cZss/ZI39zG0WVrtrN7d9WPUbtpjSwjhgwmHM83wDBUxZlf1sPkepDii1n8MD1067pNuuY6OkwbMm8uPgj6fka3u4CqhPTk6YeomrGwKf+9XRf3e+hQVykcOJPE3ZLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734215191; c=relaxed/simple;
	bh=ZrDNWfmtdISpMYkUeSLoudxH2n1f4p59UXdWu7P8JPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kB/RKYaZJO86Gq1csgKMb1BJ0jynsMlh3tfTqnc0gYYr6b+6xRt6ZFNnJvre0zPB1OeDg1u3mxPOBmPEyHbAtvaEpbuVryMPT0mx0s6S716HEF2Jg1+rB6ynHC8M34PMwMUPqPUohr/mlg4I6a/GMhBLWMhKTPhDMHheHQ00Ljs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Lxq3Bxan; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Lxq3Bxan"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BELZHhX008466
	for <iommu@lists.linux.dev>; Sat, 14 Dec 2024 22:26:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s4QqG3p2KHd1ypOB7S0ihhuqmQZvhM442cAt1pqnT+Y=; b=Lxq3Bxancb7SACUk
	clsR9K1LXjuBbocbljgCiNPZPmfeMPSCi7woxM4AQEH4Uv39kos8I81ayn3y0qtl
	KYQ5AFs4sZVqv5LufmzZbklvhTrBvNhi59lD6z+9xTMt05rXLqCaXmXl8f4Jvix2
	px1qjuFECFUiTBkTw8i500HmOHaRUZCuKkMzH5cN0OisWt7ccBN7zlbgo2uKZij2
	J05CVpIHjrv/OguIEO/ZHhvlFiMDddl7EtzBmWG3A5djpcuKPvA2vd0GrUsVi/qA
	4kavjt9e0d7Mi5GHwSLsm8KDBg5WGdUaZBwoflQAKKTgoYecj5CuVaJPmI2FojDi
	1xQiUA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43hbft8ftu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sat, 14 Dec 2024 22:26:28 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-467a437e5feso5672341cf.0
        for <iommu@lists.linux.dev>; Sat, 14 Dec 2024 14:26:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734215188; x=1734819988;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s4QqG3p2KHd1ypOB7S0ihhuqmQZvhM442cAt1pqnT+Y=;
        b=ZnNaIFk70z1AViOYb9k97EbXgvndlvFXgSR6ljYN3KI8fOi5V1nG0rzrhyN3kpm2Z2
         qzUhBPx33l5WCc3b8le9iPM2wC8XD22PVSLuw8tBFkfKLP8k8H0Qsy8/6R5khGVe9xQQ
         hGSlfcURJZFstMMb2x3kIjYIBcN61lr2V9Zb52xPJ8ZyZbtwDyNw8kUnqIcIvALQmOQm
         fzMoQT3mx2rPcZJyGFQdihBYoXDD0/4UCEiPjYstJkF0t+k+My2jANRGsuGN7zGXZqbr
         ADQh08xiHFJ5aOqqPlOwyv+pypp1u956Vx5ULxZFF31CsPSJvzdX3pwLXskUbYuKDtVU
         shVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtWuI6TwQCKb2jcz/6Dx/s4LEcyDvGrWlgRyGxmBO57dNjLJ/ODD4IZdE1pP1KWmmi0jhr+Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyVivp9sUtSe/Xrju7t6HqFd7Kqd3saalLVXtHyzx1J8EqmpnSF
	LUF9BbbiJMHhaKIVfpw0HaNRl82e5gNH+5CUIuguAfL57283ScL5oWF2qEPtBtCPIxgLbi8Chuh
	v26Q5O57f0NCQ9WrK+urJ3STkVA/Lnir+bZ/pvfhvsTqBvXkeSnBt+g==
X-Gm-Gg: ASbGncsM4fkzJZrJsSQv2c+w3ypMV0tKhec1TanYO8PQmSBInD+y6vTe7RJZStGiDC6
	vHEYFPuJ0TRmq+bId1QmWtnwA5zUJYidtov2dpLaVj1t3HOg0rtzkLgQ8a3//uYtMtJBv6c5jjM
	kexx2XOdsQskEFfHu+xBMP1jK3WRZrbgjyMosmlkwAjbRcoDxKPNzc4hjJLXWw+4FFIv78cicSJ
	+bi0c2bqOnV/LCByRkncodmVbQs3g1MwggdM2w7aS4DcJ9jKTzWAHEMh+h2mpemyuMkKQXrV7Ak
	jo51EXITzGzfpgxkMYWz4YnG6IOIjsoFlYk=
X-Received: by 2002:a05:620a:192a:b0:7b6:d252:b4e8 with SMTP id af79cd13be357-7b6fbf088c3mr401377385a.7.1734215188041;
        Sat, 14 Dec 2024 14:26:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHasR3K6p493DFjUDFsgFM7Uolbcjk/4yrc72sMuH+zSyIX6k46ZL84uYVCjvNS7JZ/TSFgJA==
X-Received: by 2002:a05:620a:192a:b0:7b6:d252:b4e8 with SMTP id af79cd13be357-7b6fbf088c3mr401375485a.7.1734215187709;
        Sat, 14 Dec 2024 14:26:27 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab96006b29sm140887466b.28.2024.12.14.14.26.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Dec 2024 14:26:27 -0800 (PST)
Message-ID: <5e33ecd6-1307-47c6-9f57-2f7c98ed1272@oss.qualcomm.com>
Date: Sat, 14 Dec 2024 23:26:25 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 8/8] arm64: dts: qcom: Add Xiaomi Redmi 5A
To: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, iommu@lists.linux.dev
References: <20241211-msm8917-v8-0-197acc042036@mainlining.org>
 <20241211-msm8917-v8-8-197acc042036@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241211-msm8917-v8-8-197acc042036@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: a601FO5-tA3gN_5WyVP0MdkC_i9NwHhm
X-Proofpoint-ORIG-GUID: a601FO5-tA3gN_5WyVP0MdkC_i9NwHhm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 adultscore=0
 suspectscore=0 mlxlogscore=804 phishscore=0 mlxscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412140186

On 11.12.2024 6:59 PM, Barnabás Czémán wrote:
> Add initial support for Xiaomi Redmi 5A (riva).
> 
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
