Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487831E7C2E
	for <iommu@lists.linux.dev>; Wed,  1 Oct 2025 22:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759356205; cv=none; b=q3+6JwuRnGsZL1teddqeoBZ3pfSeRqHJ5HF7LPy+zaEbBJxRrYKcCar06ePiogdKG/JzTxw7WX8P+j4jYmIOd1//xC2lSqQDir4oZd9k3nc6VaaBeUO+k+cGzfIUeMSAD/J577nabF4ANIZhjiY+oe4Gc1Od1T6qONyNb29iIOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759356205; c=relaxed/simple;
	bh=Wk3bDUu2YaivOtdBdtxYhxbK12TT0/NrgvBoRljOs9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hz/x0Yv720+sZ1lDWEjqsSqGe0otJ5c4ohXhMLoqts59ISMMo+sRtYQ9Obpi66g/tVQ4BltnBqAEHFZCE/T/JtH5SSDNoi2pLFyGnnImhG6+TGVMQ9WomzUFDvUpegO0Ci+OLbQ8wDdb10QqDYh1LzapXVNUy0UE65kRM8NovC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZxrmdRFG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZxrmdRFG"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591Ibwnj023424
	for <iommu@lists.linux.dev>; Wed, 1 Oct 2025 22:03:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xujcu6su7xsGlY8taylppAEs36Y3vIRtnieSXdVrg20=; b=ZxrmdRFGxgETCxR2
	KDET9JmODW6PupEOkcuQFKC0hHOo2JvLm5agcGHLLk9DJzxXD7EjI+NocnNB8Trv
	y2qTIXBY7hG+59YyTrpGUWIZ97AwGd1ndFdNiuLQc5sBSRB05yBjZlwemER/JW6f
	eKFSogMw5WY2GSPp91KaR2+EI6k/Itmu4+hUHsMPWrHu9GXR77eRwkdwoALRFDg2
	O6CKJBmMaHUX2nwQdo/33wBAE6Bad6XdNG34oiemZSXvzxneXS8kxAR7dAO5ch5h
	lo8R6+6G/NGLPzpge9CdK4ExhZFhnZhJjhI6Reyfyh/UccS2gA8LhXhfOMqR+op1
	AjMrUQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e977wtrs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 01 Oct 2025 22:03:23 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b5af3efa195so1266859a12.1
        for <iommu@lists.linux.dev>; Wed, 01 Oct 2025 15:03:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759356203; x=1759961003;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xujcu6su7xsGlY8taylppAEs36Y3vIRtnieSXdVrg20=;
        b=GLyXata4d0KsngfYl2ChP7BVwD85Tufl46ET99QLZpdKZgMoD4QWmvlmv5hk+l+amE
         IcMg7o6ah5Nie46AWlftov5ranpnXPAXPsEBgKrKg+2I//iZt27yms4yLv+GG75Wdg4i
         sQ7XT03khqO5ALGm++z+LNIvTFL5oWMTpub6mXz7gJCUbaAmUua6vXwB3tHqsMgQ2Ab+
         Qg5bNuo6+7KgPf1PpQRt9XDQTFWaQAXU2sQkTA65sBg9tBKjixu2MjdPkreGZeKU4NG1
         5Q34s8ArnJWtlvLAz9BGaBRBkyhKemiq4YINMWj7l8qwot1uPBd6vhkLfqU3ICNUmP3t
         MTCw==
X-Forwarded-Encrypted: i=1; AJvYcCUAIHYEbNsmlh99LwAvgfXggCFUpzwR4QE8XqFKxsdu9p0YovmIthI1j1wlKApJ+pUwMioo3w==@lists.linux.dev
X-Gm-Message-State: AOJu0YygW3uLRLZsKChihIFpUwjxKeEEDxLV8mosymE49dPYrnIwocVy
	G+Tz6egoP0LTPhTWGUuN7UJhT2xwy/6h5Oul+hfv0LttcSrJkdfYBtbbInNEErYOHjVZ8R7OuFZ
	aEZwkTUBoQJbhCZn5sJ/2xKBOjaVs7XshD94WsiJ2lk3viw0pu94RdPdcaA==
X-Gm-Gg: ASbGncuEqt0Dwe1faLnUcuVw9O2tdAAqkYoXGUU8SnqAhVutUJdK38PT6yl2LUvNra5
	KVud47oUxiZmVkPuIBXyE0WBHKBvQUIuzrzJEnDJodMSVtw15IKyNLBhARUBKJUFxNqzBnMtddS
	6RqCHJIISDYe0zi3rk4D6YWMxwh32kjTjRp6DqwUr/aplbgj/Laoac9nTiJR+DM0MZN/1hhwbt8
	t43yxXhR9pAtT2CWIK7/BLRZEd97BahRNXgR2JPjUdtR8oyN5CQ1X1RF4zczojr66Y3GcMB096a
	xnFdJ0jo1kabHJc/mO7xM0D8kAZh+ULrrMzoIlr9RTFccegYj6gMBQZ7kxZDTYTD2go=
X-Received: by 2002:a05:6300:614e:b0:243:78a:82cc with SMTP id adf61e73a8af0-32a2529463emr1184503637.25.1759356202693;
        Wed, 01 Oct 2025 15:03:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgxO0FMEt6NCjTbWEVMsMIoIPsAqpPcSGWTogRJlJI3yNWhMaCOEagO+8drQ4c5arKTyjNnA==
X-Received: by 2002:a05:6300:614e:b0:243:78a:82cc with SMTP id adf61e73a8af0-32a2529463emr1184444637.25.1759356201994;
        Wed, 01 Oct 2025 15:03:21 -0700 (PDT)
Received: from [192.168.1.9] ([117.244.71.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01f9ced7sm659664b3a.15.2025.10.01.15.03.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 15:03:21 -0700 (PDT)
Message-ID: <79b54a9a-2f05-4a2e-b9f6-6fe46e2c25cf@oss.qualcomm.com>
Date: Thu, 2 Oct 2025 03:33:12 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 15/17] drm/msm/adreno: Do CX GBIF config before GMU start
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
 <20250930-kaana-gpu-support-v1-15-73530b0700ed@oss.qualcomm.com>
 <ae2ooybajk6mcjggeztumubht6auw5qlhmsdrblikc5ruoxtmm@oj5kvpxithva>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <ae2ooybajk6mcjggeztumubht6auw5qlhmsdrblikc5ruoxtmm@oj5kvpxithva>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 5b3011vG9-CxUpDg8Nm7WC4MsMy107Om
X-Proofpoint-ORIG-GUID: 5b3011vG9-CxUpDg8Nm7WC4MsMy107Om
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDA0MyBTYWx0ZWRfXxiw/U7/aBCu7
 1p0p5xQeTh1Gp60OQvUL4MmiTwRqjCDWRcwHphXFzO15l9rXGyN+3GDb8O9QpwHUoBu3po0k5qz
 MI44VxtO/5BQpxjStK3vOFHHHS7m624YQJc52X9yuQ56s660h9MuE4Mh6xtx0m7aMsP4D0iqbQu
 g42YZHKzjzpLepDUZtigRY/9TReLAAF5yE/LkPGUFysB9pO2X5eYx3TVUAs/+89P34OC/M30Zl5
 OfjrCH+AMtZLQ5+yAhP51YQS1dPGPYdb3Xxb2Lq37JuQ+reFXrPtkUgPr5XR2Fmlq+7j8JQ/oqI
 0mzqJM+JVCCcg1Vv8O74CMAT6UvZrzjzOAgY0V8+bmmU52EmYaPU8IVj7CzxN4LfyVJA9Ok/jyx
 7ohTUUjtpV7pE6TjAPHXtFO7DDrgfg==
X-Authority-Analysis: v=2.4 cv=Sf36t/Ru c=1 sm=1 tr=0 ts=68dda52b cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=2kejHg7nZSoTgEpwAwsXNQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=AweIZ1vEVvbksj7JdV4A:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_06,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270043



On 9/30/2025 1:19 PM, Dmitry Baryshkov wrote:
> On Tue, Sep 30, 2025 at 11:18:20AM +0530, Akhil P Oommen wrote:
>> GMU lies on the CX domain and accesses CX GBIF. So do CX GBIF
>> configurations before GMU wakes up. Also, move these registers to
>> the catalog.
>>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> 
> Fixes tag?

Seems this is not an issue for existing GPUs. So, technically not a 
bugfix. I will update the commit text mentioning this.

-Akhil

> 
>> ---
>>   drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 23 +++++++++++++++++++++++
>>   drivers/gpu/drm/msm/adreno/a6xx_gmu.c     | 12 ++++++++++++
>>   drivers/gpu/drm/msm/adreno/a6xx_gpu.c     | 17 ++++++++++-------
>>   drivers/gpu/drm/msm/adreno/a6xx_gpu.h     |  1 +
>>   drivers/gpu/drm/msm/adreno/a8xx_gpu.c     | 10 +++-------
>>   5 files changed, 49 insertions(+), 14 deletions(-)
>>
> 

