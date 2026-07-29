Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373EC19DF62
	for <iommu@lists.linux.dev>; Wed, 29 Jul 2026 12:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785327374; cv=none; b=G3l0VTOri89cbrDkgRrWBMz3cyWHgwFpX3ZqOAYqSj3XeqOKcvi32Qm8AhJEufJTZSDOdjvc0Mf9zW4kIHGEr0MVe8A19OB6sy313N0Gf2qbxeY9BpEw2t+AEW1qh4RB8+dIc3UbFsMEkwwZtzT1r9ZMU3UpUo5+RShiNjVKSQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785327374; c=relaxed/simple;
	bh=nGyW3duk+6ZjWguUWIuUGlJV70n/H0euWoTxYXsXVlk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IjehsDqZtb3xeFeEx4cpxVmZTE6gf9a1/6w5JaLFpIIsGPa0vz5kiS/U+011POphjtqf3PA40gddLIi3nfMYo3dCLVFEUtMHF6OR/mvzl+Z/MyUgGDKVhiPwT2u2jayk5pHNNSz33vmMnM/w/EYNwArhEngqee9K03Y9XcCCKB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jGmy5Xin; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JjbUJIJD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jGmy5Xin";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JjbUJIJD"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TBXYsP1218137
	for <iommu@lists.linux.dev>; Wed, 29 Jul 2026 12:16:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pBY6SqO9XgmLQLXW4MSm3F34QI/WpVUcAR/jeWmBW24=; b=jGmy5Xinb2xSD5pU
	kHsjiX+IZWn51oCYB4Ppb1FYqIy/oeen87suhLwu5Sg+VL6rlCk9VM0YMmDBNp+s
	8rzFlH6B/5sJlruWHdm2vF5PJGPQ8g+sqYoI4MMUj+3x6xl5Zurw5jrJN8XR0tPf
	uKFxDzS+xx8CYJi3DGNPHJqCTpqBLbZ6DJfBXRHc1yW8ctg6yOS/yZJc07a//Skj
	O+EVAGfhlavIZQvVKhNQPP83+RoWapp3IBI4F0A5kWHS6hA4sLil7zaWYoBBL36l
	31yCkPRzQT6/H69w88ZwElwuLcmpJxSYPa3x/JekTsGiWqCFJZhVS8EzK0U7uupk
	4wt/Yw==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqgrj05m8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 29 Jul 2026 12:16:11 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7e9e40e60b1so71551a34.0
        for <iommu@lists.linux.dev>; Wed, 29 Jul 2026 05:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785327370; x=1785932170; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pBY6SqO9XgmLQLXW4MSm3F34QI/WpVUcAR/jeWmBW24=;
        b=JjbUJIJDmRBHC24Qks3oMT6GkNWE+xiuTC7f7UT0W1ZBvobbOm+m3CGKJQD/dhSCmE
         h0vs0J4uzeEWCvr1xVN+Z9kq1Rn4qopOMMYivuIIrz12Kr2BCLWGkn7EAmnyqUwbztos
         3cWmzjpqhVWS3/B5YP7MibN9P2U4CrMCxEyZZ7V+srbhpdmm6gJfj/dTA33fg+0DpLo9
         oTF9wmB7IQFl/sQG2sB0ZTlMrusts8mY7pP35EKrJT+jFtgcW1Pa0u2XeId8khUKQsOY
         3znhs4rnigRxD/VQ2zM2GuX3Umj59LlZRX6t1pByb83VjkHBRezNFisaA98aLj8rdHc7
         0JUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785327370; x=1785932170;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pBY6SqO9XgmLQLXW4MSm3F34QI/WpVUcAR/jeWmBW24=;
        b=jsS3TmeXG/MZDe2NKuWy3bEGWrFvjo7kTFLvohDYuMurEH/Uw5diUleUd/k7oQZOAN
         3R58u4wipU5VT5IZiaBBz/S52yv1iYrsI7Gyi7o0cxYT16qgI7rtNIbV+enDdPDrAF0Z
         Zs9dhS6dsSMV7TakblTiKnWtUGuQDCthqmQwa3SSWFu/6JwPKv0rLTScqHBo8LJrrfE2
         QqQewCKRosfqBD9gBLFkVj8yaNBF+mamFVV3F3XRQaMF/TumSuocNye1aXR4Sz+rSrJ6
         HmbiI4Ra3seT2yGSxSxU34ZpsWK6ps0xtmi0jLk10J4iMMx1vU6nHVn8bSl/DSBL2NVz
         bHcA==
X-Forwarded-Encrypted: i=1; AHgh+Rq9O/iHNFL3cm2cpqkQ72hSR1C6MZGFFGntXA/qCHRhpp9hoRec+r16v0nXyDGjRU8eNIjGrQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxm4fmjkHFck20cKT31lD9TBde7NOGrtYPPKFUBeJ2Dcxs+WqQO
	YKygrWmYPL6uDi9x8dxoWweQNx1S3j8rnKRhVny7vcq4pvOrfC4MQKYwRxu/EHJ7lRWcGI3Ix80
	mjQMuc0TNz4dYwlUDc46dDHC1qtUKuS9CqzboNIZyRUs6IXIjdWUbXO3ZXQ==
X-Gm-Gg: AR+sD116A9D6aUMbsCXb1fE0zkdwqRB9QCCb0wD+5s4jx0zlXcEyWLkJ4sFKgNpz+oo
	qRt+FowdiYVKj1JSO0vOSPJAAjOLJt2fwRPVQhjfEjx+Vh9vswToL8rPAT3s1ps8zm6ZW6W7yHw
	6NfKlEM/kwhh27MbGfiDDRvydID5SxewEJi5XsGnEYN4tKkn+gc4FHTSXPh/whHkyVujwNJfaRt
	Wp1GSFbHN81Uvaamwg5d72YsM7OsYQLqFMmz0faTsUJwjXiSqnREk7wDVW6wQgacvMMihLUibkC
	kSXtZb6bOtS7uI2TpT7RdMWisWRxGVmWjw5UAxqhFAusvgomsvgpykm+HGh+oe8wj9pGF9Z2AVH
	R+R67ged2olbiLaQ1vjAvO4ag
X-Received: by 2002:a05:6830:67fb:b0:7dc:c92d:977d with SMTP id 46e09a7af769-7effee11f80mr3116006a34.1.1785327370605;
        Wed, 29 Jul 2026 05:16:10 -0700 (PDT)
X-Received: by 2002:a05:6830:67fb:b0:7dc:c92d:977d with SMTP id 46e09a7af769-7effee11f80mr3115972a34.1.1785327370182;
        Wed, 29 Jul 2026 05:16:10 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a050be3a33sm768977a12.10.2026.07.29.05.16.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 05:16:09 -0700 (PDT)
Message-ID: <0ef4c658-be67-4df5-af56-ba1517700985@oss.qualcomm.com>
Date: Wed, 29 Jul 2026 14:16:05 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] arm64: dts: qcom: eliza: Add GPU cooling
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
References: <20260718-eliza-gpu-v2-0-64379dbebd7a@oss.qualcomm.com>
 <20260718-eliza-gpu-v2-8-64379dbebd7a@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260718-eliza-gpu-v2-8-64379dbebd7a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=RJOD2Yi+ c=1 sm=1 tr=0 ts=6a69ef0b cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=QDjCMyA0A8yHJihhU1wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=EXS-LbY8YePsIyqnH6vw:22
X-Proofpoint-ORIG-GUID: L0u7Crz9U6LNJ0h0-ith4tJ3M6efMGoy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEwMSBTYWx0ZWRfX98XcVIhSrq6q
 Een296e6rRJZTAUZ3WnmRskas2HA5q621k8STkm70thylckTaGLHCImB9p/pb/KvvBPARONzSoK
 PBsvk+x7FeeLa4xoAF7ecbklp8kqzXDbPzc9fqjf+qAbCtH3OFKNNc2jQqVkEA9ec8uEEQODBSy
 Zj6gWOu0ywNbCKd2iSGJVbfqx5QGOA15vybQsQ7r9MTMqEMtuxZORIi1Pcve1WlxA9XVWdjOu38
 gs8wa9qEhQACVbkOjnLaflMrngYL9fJpNcBjgvejVpuDXm+/+hoT2md+it4wVOQhH4u7Tk2HN4z
 DK6i4ZlOiabf4LoGA67umAAecZZYsBPvfRzhqzyF4nOfo1y4GNcY+w/j3KVKYdhAHfMzepIc568
 exwPoY0OjzHGwvUrsK28TwhWJJu70SOgiGih+CTHwPnkeFA7sYbvReLwQqTcgb0ihtUofG/pDju
 tasiJ6nHX+BcBXIu+ew==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEwMSBTYWx0ZWRfXx0HTzDxSs8Dl
 XCB3tYr/vSFQiZA26bYUESCKbnA6cTT70WNen1wMVqpF0su4Sg7QVDHb5nmemUjgt31rYpnCawU
 1pNm9urs3AJMgfRAWgZblbz4tUtI4rs=
X-Proofpoint-GUID: L0u7Crz9U6LNJ0h0-ith4tJ3M6efMGoy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 clxscore=1015 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290101

On 7/17/26 10:41 PM, Akhil P Oommen wrote:
> From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> 
> Unlike the CPU, the GPU does not throttle its speed automatically when it
> reaches high temperatures. Set up GPU cooling by throttling the GPU speed
> when it reaches 95°C.
> 
> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
