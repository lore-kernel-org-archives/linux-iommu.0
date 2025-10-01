Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3D6271448
	for <iommu@lists.linux.dev>; Wed,  1 Oct 2025 21:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759353768; cv=none; b=N4zLHu+/roFzniFZCzY2TcN9f6PVU3QndpVDCROFvN+wajNvUXuhffPXJXmVX4p+NhWfNNrdD1Eea7pEHcvHBOtX/rXGIX5YHaFH+GXJAa9lRP9iF8AoTZfiTyRWl3nf+fhiPwIJP0PjkDL/UaIoJkQxzZdm8Ofo4OQZmhKunbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759353768; c=relaxed/simple;
	bh=0feXbIiv5jZYhNGUawVlPDaLEDims5YKYfHLChZrH+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=knfs/+WdFh2zFYWZ1Ixxuk8KHWc1pLXKDGfDN++KGbPv1ZnJuX5UJ1yvwLlTLE6VuaGWt+SVXqaPwFPh+k7asma/p8wbN7UC7RVOIJ555Bt/PlWevf4KtHWtHtMIwNVUA4u9mXhH5sGWALSRPf1h4yBSmOnIheUDrNpCHPgkqbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AEoBOZbY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AEoBOZbY"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591IbxMQ005645
	for <iommu@lists.linux.dev>; Wed, 1 Oct 2025 21:22:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tY1kk2Q5hRz9w3+RRK/dSbVzsoNAtpTZ1wIZRGTLaPE=; b=AEoBOZbY5dwHsaEu
	nCz2fNZKcAZfaYdo5d5ulPVRFWJ8zMZ7Mi2+jxZ1vA7pKIwX64LOdeMVvEmiD8rr
	sIDuv9xRcIAN69afsfe63q4APcIO2rPZE4ANruDmLiGkhcnlLxQlv0q5guwKKpdT
	8E/5BjiSkPiIHgQSXaWF5esBN9iECy0OktYe35tQKHWp+spFR2VCg2UuIy0DOYHJ
	lg6D0+O5lQ8xw2yAfFk6mov6NbrGiJxdlmEvUy9Vth2d2s8r+3W6cZf4dZndVJuY
	lZdnaPHFWzfCQzJe/5uh48ZM9lA1XK4aWdq70vaLqAlFNBPOF9UaA/2fqIiNCT+p
	+1Hnvg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e8pdnp0c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 01 Oct 2025 21:22:45 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b60968d52a1so571879a12.0
        for <iommu@lists.linux.dev>; Wed, 01 Oct 2025 14:22:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759353765; x=1759958565;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tY1kk2Q5hRz9w3+RRK/dSbVzsoNAtpTZ1wIZRGTLaPE=;
        b=S2ojvDY47MeX2vax64iGhEhopVQCEDzPqw6IZFS/ur4l+YjApqufabJARj1wwN2WUu
         YkBqRzB4v6W1VXbhSNPNXVrAO45Be60g4lqU++/jHJMRimZSfJLGuCkIZuMjIOFcuruu
         E4PxIITTSPYM4SiBGbfGtdLzLeWNj32ZtJixAFm5UBb8x0p2YLoR7b038d5/PxsQ199U
         ODKQmkvk1fbf4plxNSoOK6pI1fg2X6l0y7py572OSIjv5YfLWT0JnrJjf33bhkQBZLTl
         6AS/Q8LMTZtC0EyZVBs3eP9Re/FgTu2E1mDjZFfso0tRi3zBfMGM8MAiZl5+XHoKrNkq
         9RWg==
X-Forwarded-Encrypted: i=1; AJvYcCVnuLIgjMICGaNlKYNOPmsO7yV+IE45bv71arhb9S0ioLti6c5P1VQuM7k2ee8vkZ13RINDDg==@lists.linux.dev
X-Gm-Message-State: AOJu0YydPq4g5iEPJ3SUBK9rgkpCg3fb6+DTws7NBe/99VhfyZ56fMMj
	BxCWliys5Ki9ZlROJnIwWP1NqASVeFVk/2UVK/pYURoKCr6dCSKJ4bhktkXBMZSrp6T4WgLapS3
	ncAtv0WHLa5Wk9YPebgYuxiA7dgfNkc+JGwrPeFWprAj/edYIHMyNIOU2IA==
X-Gm-Gg: ASbGncv43JFrmODwuVYL/DVvXOQ1EdCz8AWZurTxTUESBEQzEjCneJ+jOiX0a7GTcd5
	UFNbwUTMrWKWK2MipmiEe+JDMN+IaBDC7+TkWtz97Y39gw/VNteDgdNC5bHdKRLVrslpXSaZQLe
	KAhew5OvI5oiY+GemPlogpq1e395CY3w/P29Yc+49qXcznl/z021sUqXw95LoZi/qEEIuUn5QnM
	gutIvAo7bg9USBadDPK01RsklrAbcCpNsNv7gjP93FBLS9KfFZtMrBLrUrf/5he2bzBiYH0QNBe
	DinqokNdzMfOelj/Kcw694lJq5A4nyiKNnmKP2mB+NMR1UhMmH9XvsHr8MBF8aLEnCg=
X-Received: by 2002:a17:90b:3143:b0:338:26e3:ffb6 with SMTP id 98e67ed59e1d1-339a6f5329fmr5484049a91.26.1759353764862;
        Wed, 01 Oct 2025 14:22:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3J5m7IdAEVQ8YgjK8xPIMo/mwc0iZ4ZB/L76eAW/owdYw7sgKWjOIFg1cMlAzuYnR+gwPtg==
X-Received: by 2002:a17:90b:3143:b0:338:26e3:ffb6 with SMTP id 98e67ed59e1d1-339a6f5329fmr5484006a91.26.1759353764421;
        Wed, 01 Oct 2025 14:22:44 -0700 (PDT)
Received: from [192.168.1.9] ([117.244.71.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339b4f3caf9sm623334a91.13.2025.10.01.14.22.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 14:22:44 -0700 (PDT)
Message-ID: <edb8b0dd-126b-4ed6-8603-119f1fd52baf@oss.qualcomm.com>
Date: Thu, 2 Oct 2025 02:52:35 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 10/17] drm/msm/a6xx: Rebase GMU register offsets
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
 <20250930-kaana-gpu-support-v1-10-73530b0700ed@oss.qualcomm.com>
 <s4no2wy3yskk6l6igtx7h4vopaupc3wkmu7nhpnocv3bbs4hqi@uhie6j7xr2pt>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <s4no2wy3yskk6l6igtx7h4vopaupc3wkmu7nhpnocv3bbs4hqi@uhie6j7xr2pt>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: vTuJe_ZPtiZ--pU7plMXJCgsVI8Gir1R
X-Authority-Analysis: v=2.4 cv=MYZhep/f c=1 sm=1 tr=0 ts=68dd9ba5 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=2kejHg7nZSoTgEpwAwsXNQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=DsFpUOTLdg6Fp_xZM74A:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: vTuJe_ZPtiZ--pU7plMXJCgsVI8Gir1R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzNiBTYWx0ZWRfX45pDS9yOoicF
 hTWTN1ZoZUfo0tFU+Y/w8YnsGmcWlsqY/EZVkLpOJe1f4lmcG6N2qALVYZTDSsBvc0hJ+t5JBNq
 jsKoxv3SVB1tdjRzBHzXl4eDmrfHgZJ5C+T23sAwVPqbUFqOHeg9lTFZCYvPLf05bxQ9EM17XCK
 B9l7BcFdbeX8x/pvPeDFT6TiOl0s6Leg0Wvc0YbzpxhuSW2YcaXP5y6Utr4YVKxu2a8yHakpP6g
 91d41XJRhY0a8p87lqJyR0iQxNmwrip6UqBLTFdXS9x9aYnlh5Kxozzy0VIfMvPYBDdIo0bKt1q
 4cqw5qPNp8IGvz9kKn3jnXmZM5orX502MbFxMTWOhGVk96VqrbN9UNEp/W/R09FNpUdaG7tvCZC
 rhzko7DuEzr0+yI7NaAbyYc19G0EpQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_06,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270036



On 9/30/2025 12:53 PM, Dmitry Baryshkov wrote:
> On Tue, Sep 30, 2025 at 11:18:15AM +0530, Akhil P Oommen wrote:
>> GMU registers are always at a fixed offset from the GPU base address,
>> a consistency maintained at least within a given architecture generation.
>> In A8x family, the base address of the GMU has changed, but the offsets
>> of the gmu registers remain largely the same. To enable reuse of the gmu
> 
> I understand the code, but I think I'd very much prefer to see it in the
> catalog file (with the note on how to calculate it). Reading resources
> for two different devices sounds too strange to be nice. This way you
> can keep the offsets for a6xx / a7xx untouched and just add the non-zero
> offset for a8xx.

It is not clear to me whether the concern is about the calculation part 
or the xml update part.

If it is about the former,I think it is okay as we have confidence on 
the layout of both devices. They are not random platform devices. Also, 
we may have to do something similar for other gpu/gmu reg ranges too to 
conveniently collect a full coredump.

-Akhil

> 
>> code for A8x chipsets, update the gmu register offsets to be relative
>> to the GPU's base address instead of GMU's.
>>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/adreno/a6xx_gmu.c             |  44 +++-
>>   drivers/gpu/drm/msm/adreno/a6xx_gmu.h             |  20 +-
>>   drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml | 248 +++++++++++-----------
>>   3 files changed, 172 insertions(+), 140 deletions(-)
> 

