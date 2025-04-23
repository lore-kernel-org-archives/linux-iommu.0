Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAC71A5B87
	for <iommu@lists.linux.dev>; Wed, 23 Apr 2025 13:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745416458; cv=none; b=nnAqKDN/S52gSRPBLI1Trlc4cYj33MsZHJ6THmERbDyWW5prb1o2uH0DRpyd6OcxHh2pQQhCJLH269O0R4WgjRHRH9JnYtIIAXKO4a9yp2kL3VQQn2ypQB+zEuX85u1nsWeLNbJG3usxTeMgcCa5PFKWd5qlc/UPl+v3FW3v76s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745416458; c=relaxed/simple;
	bh=Ph0l8bR+Uh/iYP/SWlhiMjeLVi3TEspfupl8tbIi5Vg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QvyFsogY6I2QknGe4U17AhJjejAzEySXR4PQEKYTPXN87Jy9qtATgSlqn7sLbHiy3j4/aAgH6ppuWceq9xkCp8OvfI8yKHsyPZR/+3RNIO5CyBHuNNw/yJg28s3rYFyaPxb4hWiVIO6d/5PZKaMk0DvOf2suv4IzL6YbfIMBU8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DeLymmwS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DeLymmwS"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53NAkGOA014763
	for <iommu@lists.linux.dev>; Wed, 23 Apr 2025 13:54:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cJX2fb/ffnpa/u3aYJ64X7d+kE1K0IKu9sD+lgBHlKg=; b=DeLymmwSMCbIy49E
	r5QVfafjNeO5exfLzXBvDczdCEQWbWvZ11WkESac/Rq0arZQLUSoJaELhn20+YIZ
	sC+UQfw+/VMJJgLlZanr2oEEhZqyDuTtnboBdB5iMjHldgpGT8ppytlhB/+pckxS
	5BGXW+ki9ikYF7VAuGSy94VON6HvUbcVQaS6BYicOMI+nz+/dPaqOIMt1DD66Uco
	/tJxpKHQvUikXqBi/4DOWR1wK5XlafuCwOIGZ0hRKMymFHxOmTLTnTlK3OsUYoxS
	0ckxiVqN9S7gSTClq+tP/+yjl/eoLxsYVYANw5DfUqrXoT7lVDMSr+/+5VG4KM1d
	7zRTeg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh0ja3p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 23 Apr 2025 13:54:14 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c552802e9fso122989485a.0
        for <iommu@lists.linux.dev>; Wed, 23 Apr 2025 06:54:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745416453; x=1746021253;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cJX2fb/ffnpa/u3aYJ64X7d+kE1K0IKu9sD+lgBHlKg=;
        b=UJ6mPopxYT0rhS/WhCKk7+c0hJ5OuiLagwul9d9tRyqszeMl0qQN7RczfVm4L8VQzP
         i4koujtDqpwjcsY24186gO6pD6/JuuK3emLLZ8PRs9jbPvh0FP/cP1xIJ00dF2N0xdWv
         nZ4XhIeAQOg9ujRrRXSa6zyp4HeK4g5XfIQdBIzr/SCwN8600Oz2G/1hquBPpXaja9b9
         ei4BGfHCiQZBmVKrGWmZszDJsQX3aSZ+7fBrsBwkvfr17NMndY7t2rXirfOiDWj6XgAC
         nUITjhM/vGyEruyeVifGDL38mV6LpT8jyf6+JO7TspLKLuuYXzrzu7TvVEuLVW0OlJTJ
         /b9g==
X-Forwarded-Encrypted: i=1; AJvYcCVZw4JtMweWnOOXkg3yNs8K+Isjb63LqhTkisE4d4kqUJ3V8dGxccJ+9t6aPwGeqOfTNQAlEQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YytqAkpwC8Hz7LPq5gg23L8wkltJyylUvJuI3u/0d5GQILLFPW/
	R1kwUTLPLpFqGL09BH0ee4gBErhHhF7tlhaqczBVcnrlucpkd9/R3pi3Xt0AEq0hg94KBkJsQaN
	2tfPcLETHAyzEfoCLSPKDt819T2ryoCvP9vMQR9NxXG7lb4F3QsbOfA==
X-Gm-Gg: ASbGncvO6phy7g25a0fIhUS5gofDz9kMTItWw1DLhuGEm2Xb8XeQ2f4w9MXpwOx/Nt7
	hmehGnGGu9OG0BSlaGAZnwNJMnBpJT54PfOzmuQvb9mrtp1/h3rBVdOXVnS/SYXZrgyeVQlx0UI
	e+YrPTmK/jgBjGXLtHpXPm+Rp1uXYiwX+2OlbxAUcjkMuSWGtgeiR8HJoqTM5gDrHXGAC+nTDJL
	ttCa6bI8+CI6BXEJrWVPAKgilhhcFo71/ukTG8CasFyNDrQOZM0u/0IPsFd7jLSCgxFRoiiOvN5
	AKyEunNrxVRB0xQ+alASt6i89E1by5fZS2MvZNnRp1uovtjTOuWVf/kZPaUhKZudWDc=
X-Received: by 2002:a05:620a:17a1:b0:7c5:8f37:5eb8 with SMTP id af79cd13be357-7c94d2cdeb6mr185091785a.12.1745416453387;
        Wed, 23 Apr 2025 06:54:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5GSKl5nOJGI1IDLlBzmI6OWMLujvoHpe4eYG3KxeTMc/rjtv7PPTjZDEBvTI5D7TyWEbafg==
X-Received: by 2002:a05:620a:17a1:b0:7c5:8f37:5eb8 with SMTP id af79cd13be357-7c94d2cdeb6mr185087885a.12.1745416452864;
        Wed, 23 Apr 2025 06:54:12 -0700 (PDT)
Received: from [192.168.65.183] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acbbab86f15sm299799566b.76.2025.04.23.06.54.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 06:54:12 -0700 (PDT)
Message-ID: <da5f63ad-3206-436f-9b0f-4e966b817fc3@oss.qualcomm.com>
Date: Wed, 23 Apr 2025 15:54:06 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] arm64: dts: qcom: Add Xiaomi Redmi 3S
To: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>,
        Bjorn Andersson <andersson@kernel.org>,
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
        Srinivas Kandagatla <srini@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, iommu@lists.linux.dev,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux@mainlining.org
References: <20250421-msm8937-v5-0-bf9879ef14d9@mainlining.org>
 <20250421-msm8937-v5-5-bf9879ef14d9@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250421-msm8937-v5-5-bf9879ef14d9@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: rXvLvRQK31M6glpiQUSkekyI1GK_QqRP
X-Authority-Analysis: v=2.4 cv=ftfcZE4f c=1 sm=1 tr=0 ts=6808f106 cx=c_pps a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=OuZLqq7tAAAA:8 a=EUspDBNiAAAA:8 a=VJhJOi4SVWMle1XIrLYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=YF3nxe-81eYA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-GUID: rXvLvRQK31M6glpiQUSkekyI1GK_QqRP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDA5NyBTYWx0ZWRfXyxaO97lb8mIo QTXt+klDh+fk6HJ4/oxRhU2wxt34AUtPYJyLqu1ASyPvQa8BWtLWvp0PWC674WRZ8F+IF7WREhQ Q6fuCf811V+oURa/Usdv6ua6dGP8QWyMrcYdj5BuY8i9meKZ6M6Nhaw92u94q6+UvGftgFSKu9R
 G3wvhzkL0fcnLejd3CJrfkXPmOugOm/XESTdQu/SNje5JCMR4iguUIvF/az6Ac0dkKfnmvukuw2 ZGBt0YpSHCqhBcq209p3SHnmVVBoxc7b9jomj+4hMBa4PkZ+g/noD9QNAXz1xqE+mhDLihMPtjy 2hsTc60XkuSN2mYCJqMToTU7NtOGMkXVssbCnaC/tZQd12i6nmYjbRxT24NFIq+wiBx+bx/xxtG
 VT49mwDuAbuTnSuHoOgNfuA1OWha4vRfJr1MnLxlr8zQXKwT4tantiPcYc5QLJjJfNjNjOsp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-23_08,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=728 lowpriorityscore=0 phishscore=0
 malwarescore=0 impostorscore=0 adultscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504230097

On 4/21/25 10:18 PM, Barnabás Czémán wrote:
> Add initial support for Xiaomi Redmi 3S (land).
> 
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
