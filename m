Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752C526A0D5
	for <iommu@lists.linux.dev>; Wed,  1 Oct 2025 19:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759348493; cv=none; b=lRVeFv5Mk3H5bR9vSZ7j68sbVZj8wl1fZEnRzyOLb3+B2kVKbDfDHXH0J2lBZp0U4xwHD8cClGXxBg5j/HdVxzlDFvyEbkmejmc2XRgVtU003tiJvatYatWs+FbhyweB8UZa1xhKCVHpJc1dKh7R3rOtUP60cBRE6FVfUmdHeys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759348493; c=relaxed/simple;
	bh=qnUGsAf9QwPxL8kNSHvcwGwC6szSZfsbKOkPF7PNNGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FMayzYDirp+H63lqN1Rxpb2SnJtRwU/hddscbQ8qYA8t0Xl6w/Et/PmpoPACy9/DvCbGK+BcZac1EZsbnZfwSJSlzaHLxwS4ER0ujfJx9H/NCjXbHE1YreywUfE/sBucyLpD19rVhZKK6BsVfJZ6Ckvw7k0rc76HIhuJQODwe1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZGd5f1Br; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZGd5f1Br"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591Ic6FY008486
	for <iommu@lists.linux.dev>; Wed, 1 Oct 2025 19:54:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	brS60HbFUtOuWxvnUIY4WzudlEdGwstrPazqVvcT3+g=; b=ZGd5f1BrVBZ6J0/d
	GYp9HNUCicoqdgxC6Fn4OMf68pMQQnYq5zgVOTJTfA9rCaPc8cIrGVwlCIpNh3qm
	tmm009Me6aoJTVIH91yL/3FWIH5QAyAxwiE44y2kKrxEu58dusLLuIDhjQqhdB64
	i5cZfKsWtyVQqnZq1zrJPnxf+treMgaPlW9mawts3sNw3Ab8hXM/PPxyxat/3h/A
	LQaS8Vo3RTZkoVloD7PfwLYYOHUx6EmaZM/7hyq9apE9NlTeMZvHTV7U5EoilAw1
	7u/rddjgU3YyWt3ydzBg5XvJcv30JWPxbO8m0aTUPMFWvFgFCSw7/Sl2q1Dw13sw
	FCoVwQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49fppr95rc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 01 Oct 2025 19:54:50 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-77f5e6a324fso496465b3a.0
        for <iommu@lists.linux.dev>; Wed, 01 Oct 2025 12:54:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759348489; x=1759953289;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=brS60HbFUtOuWxvnUIY4WzudlEdGwstrPazqVvcT3+g=;
        b=orlkdXjliERUaqFzioW08YOt/GIlgWpQCf6d1HZe2toJA0ZvmE20BAE8oK6n4Dgd/W
         jV2eIsJYMWbMEblFQsuRH359wRBrEQsWzcrH3OaW8YYvvoJfJcwe1uIY73gLgdijaqZ/
         qzVObM6Sjj2h83WJfyG8SLiQAUYr5VChojW0yXkIBNP++jpi+Ap81bvE109NEnKou2+Q
         5XnatElpHDoIdmq6G2YxE8mmH1PaxSVSnL0Lkahr33fu9I0PTGZy9iWOgKnvLnKmxdb9
         xj9SwdO3N9cScWaVUB4E9/nSASbHcx9yT/Cj/imQAnZ5Iyrw9pAI0GHjpczvGWC7JXnV
         9cAA==
X-Forwarded-Encrypted: i=1; AJvYcCVGwpIZbsJ0wlQrjR0DOmAGJpCpuZUSvB50pkIj1wr1Om1dYclN/E9U+9ip3Yclh3c+57qeZg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyXl/mQPXpltbuyPn0jHlOzciicS+TQgvzAbj9HYlsBmeoqZt5a
	QBxMtIh/FM9xY5773YikPAFYns40K8HN7SCFOSdmYX1W+W+zBQYPzZrkLbt6V5Afeuaeb4whd2z
	lp52/v1Ac4ZUGEEnHnTV/CxDs6v7BAF7WxaAfy2ApyAi4o1MXgW30g1vZmQ==
X-Gm-Gg: ASbGncuO5sZquGMU0ePb47wU072+xBqz7XMG+WLPYJraHm5K2P0IKyDtzcqt69SzVVE
	qKpFCB2znzXDEl7J91hGLTfCGqRTNdQAMR9va+OSjbM8wgNxzl3JIwEhSKBKMxwYjz+l8yNp8jY
	rBDi9Su26I+Q4Bn01nw929fimvOWNKjmywBzjfdgLi93M00j0OHunx55fKf5L9ZakeUvQ47S+id
	33zMtXZsmesS8pe5rLveaVlomTxxTVpPlbqwZZVyrH+oxqzx+ukFuQ2Ixbf/VV/wvEmkvhjZ8MG
	jWdL46hSmOQ5M4cnVYdh9Rr2tltKW9ehYkGos+bDLKBwCDC7q7B4l7xgvGLUS7afpcU=
X-Received: by 2002:a05:6a20:258f:b0:2b1:c9dc:6da0 with SMTP id adf61e73a8af0-321dfc7f1b3mr6835298637.46.1759348488848;
        Wed, 01 Oct 2025 12:54:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsIg+XF+b3CzfwLXlkZJJwTtOF3hWxO1NYUBnIl48kRjZPlbxjVEtrqF7B3r6dPLdbru/a4w==
X-Received: by 2002:a05:6a20:258f:b0:2b1:c9dc:6da0 with SMTP id adf61e73a8af0-321dfc7f1b3mr6835273637.46.1759348488399;
        Wed, 01 Oct 2025 12:54:48 -0700 (PDT)
Received: from [192.168.1.9] ([117.211.42.17])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099f729c3sm297566a12.46.2025.10.01.12.54.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 12:54:48 -0700 (PDT)
Message-ID: <82cd8782-b2ee-46ce-9964-e564ab6a0199@oss.qualcomm.com>
Date: Thu, 2 Oct 2025 01:24:36 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/17] drm/msm/adreno: Move adreno_gpu_func to catalogue
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse
 <jordan@cosmicpenguin.net>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org
References: <20250930-kaana-gpu-support-v1-0-73530b0700ed@oss.qualcomm.com>
 <20250930-kaana-gpu-support-v1-6-73530b0700ed@oss.qualcomm.com>
 <cp7djnezyp4whhfqcnsfpes5kxfbyvqvc2ceimdrnrl7s7agyk@z7ozx6oihezd>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <cp7djnezyp4whhfqcnsfpes5kxfbyvqvc2ceimdrnrl7s7agyk@z7ozx6oihezd>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI5MDA4MiBTYWx0ZWRfX/bQjNGnqflmg
 mCmpi6Jzm/ZUjIouW/aW9Niws9dXrXKESHUjrg/3BxH4PsWNm7ChAmMIPbBoHfW8CTvwLJI9z5J
 PF68fXNKCBzGy2Q98zizLcuptxEQGHxQQEtGDuYGL4XWSQq1Eo15Ith4tMqe8H95109MLiEh9Mc
 oGSGvoi22Ia5m/g52qw55zckpTE0yXR2Ea3LpTsf1aLM5QUmRT+BdY17B5CRo3KCXhFzAMaFK0R
 gVeH1L2dxnfHpS+/+s73IE+624JnSik5HsxF7dIblSqFhjpG3HNkpRf0CZ1XC9YQYNNR3i7f30k
 v7bKoILErVDG8m0DdvgXF7NwYdmLCElBkp/50VPtbp8yYA/XE75VJ5GSaf+Xzeve0SluQleK8o2
 U5aLvlpSfnF1FTauz09URm+15w+WWA==
X-Proofpoint-ORIG-GUID: qMFLS95H9nMPM5fAvokfdSebbO8gwXhe
X-Authority-Analysis: v=2.4 cv=GLoF0+NK c=1 sm=1 tr=0 ts=68dd870a cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=paYLq2NZIH8GVbL4gQAG2g==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=Qop4gD_cnJnpb7o7aosA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: qMFLS95H9nMPM5fAvokfdSebbO8gwXhe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_06,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0
 impostorscore=0 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509290082

On 9/30/2025 12:39 PM, Dmitry Baryshkov wrote:
> On Tue, Sep 30, 2025 at 11:18:11AM +0530, Akhil P Oommen wrote:
>> In A6x family (which is a pretty big one), there are separate
>> adreno_func definitions for each sub-generations. To streamline the
>> identification of the correct struct for a gpu, move it to the
>> catalogue and move the gpu_init routine to struct adreno_gpu_funcs.
>>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
>>  drivers/gpu/drm/msm/adreno/a2xx_catalog.c  |   8 +-
>>  drivers/gpu/drm/msm/adreno/a2xx_gpu.c      |  50 +++----
>>  drivers/gpu/drm/msm/adreno/a3xx_catalog.c  |  14 +-
>>  drivers/gpu/drm/msm/adreno/a3xx_gpu.c      |  52 +++----
>>  drivers/gpu/drm/msm/adreno/a4xx_catalog.c  |   8 +-
>>  drivers/gpu/drm/msm/adreno/a4xx_gpu.c      |  54 ++++----
>>  drivers/gpu/drm/msm/adreno/a5xx_catalog.c  |  18 +--
>>  drivers/gpu/drm/msm/adreno/a5xx_gpu.c      |  61 ++++-----
>>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c  |  50 +++----
>>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c      | 209 ++++++++++++++---------------
>>  drivers/gpu/drm/msm/adreno/adreno_device.c |   2 +-
>>  drivers/gpu/drm/msm/adreno/adreno_gpu.h    |  11 +-
>>  12 files changed, 275 insertions(+), 262 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/adreno/a2xx_catalog.c b/drivers/gpu/drm/msm/adreno/a2xx_catalog.c
>> index 5ddd015f930d9a7dd04e2d2035daa0b2f5ff3f27..af3e4cceadd11d4e0ec4ba75f75e405af276cb7e 100644
>> --- a/drivers/gpu/drm/msm/adreno/a2xx_catalog.c
>> +++ b/drivers/gpu/drm/msm/adreno/a2xx_catalog.c
>> @@ -8,6 +8,8 @@
>>  
>>  #include "adreno_gpu.h"
>>  
>> +extern const struct adreno_gpu_funcs a2xx_gpu_funcs;
> 
> Please move these definitions to aNxx_gpu.h (a2xx_gpu.h, etc). LGTM
> otherwise.

This is a special case. These symbols needs to be visible only here.

-Akhil

> 

