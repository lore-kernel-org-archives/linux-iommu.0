Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DEC30AD1E
	for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 11:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762945207; cv=none; b=UVyD0PWOf37DAJP/KAGfWCgDXtkrWxA3AL4VTnhT+TgHcsC89K0gMwqe8+LUJVfyAmF0HqtYFQ0XsI/dNzL19Nv5abPKp3R2ebpXXWDau6Hr9XDEsFMm+z62lBS+YO8pUIkX5hOqtWhvHtV/c65ZyEuCCmj5GbClLczAD2m9/W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762945207; c=relaxed/simple;
	bh=TFLc54SJ3hznOHqg5xQKimGAc2d0SPS0o0jmHMIaXiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qDpJgCeI0INInltoaRDpcT13KQBBd5MeOFHyri06d0SijHCyiAhEz+k4WEEN7YHTLQmUMPIgsMn6AOOn3x/6lgRgbkcXsLIU3+QZIusInd6sy1qmhMD/AhNc5sw05pVktpZwbdbM0SJSGCVjcMSQFiG4XnyJlaDq/7nTG7W6iAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BWkNdcEX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GSTuVJPD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BWkNdcEX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GSTuVJPD"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AC9X0xY1001747
	for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 11:00:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TFLc54SJ3hznOHqg5xQKimGAc2d0SPS0o0jmHMIaXiY=; b=BWkNdcEXNbmvdMhA
	wpqPJkQIh0O7Alnurz09elQuFC8wHmaYte3OrEOvcuVvv0YZPVFbtFjqzJ8UkdeP
	r0G6J0q6z6O5tIE8eGuaJRg++Nzc7WFYSdyugY0BuMIkAQ6EAc99Aoyo5cbJZysH
	PiVwgKicNQgqwflDNDOU01bQjh4F/DKBHnuOO2pkjUP7BuvW16oh998Mg2Ub2usL
	wHIq4COTTLFZ0xtsyny0pPn5EUIsXc4Pc/JoBnVEs5QHUWC5VZVJfdOBP4ukokAE
	J76PP3DU1jQfLO3q5kzE/JWjklHmSVzA8xRomrLaZ0VpEWIix6ANU53NCDGKwsg5
	Vf0nRw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acqq20atm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 11:00:04 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b227a71fc6so25069185a.0
        for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 03:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762945204; x=1763550004; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TFLc54SJ3hznOHqg5xQKimGAc2d0SPS0o0jmHMIaXiY=;
        b=GSTuVJPDNr2hMydLuc194NLGpG2iWE6cxcNv7zlNqLvqcbvycTA0UxwMNu+8ubKIrS
         xEpwo3qO6a52HQdgcQTAfWEQREJ42IIWoVpZsO/iICyxiojRM+mSIo0/FKheUazYVXkM
         Hmx5djmqgPAuLSwnuQaybzd5L6a3D7F1X/74CVYOGwT53eRZg3anOQRvIrc2Lpv6/K4d
         rIGGcB9sz8sQo4ZpwUJyB3oNI/6SDqhblA52unBI05NRJI6+yDeI8Dz7vnomOhXDhYZP
         bwEwwIBtwYGSHgibwzUBJgRKHKYCHemG2hSpOcyIRRT2OJmipQZxlrp2l0AjkYiU5MpK
         /H/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762945204; x=1763550004;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TFLc54SJ3hznOHqg5xQKimGAc2d0SPS0o0jmHMIaXiY=;
        b=pmY0poviCOqRdXVCnML/M8/xbQ/u5DmEnZ0RZNu8/nhr9m1ZvS/01OplyaM04kem1y
         aEpfjF8j8KOqEhA7l+cnfuur3GEDS55EjnhSTv4og1S5yXC8yRunhz8hjBGm53MD5Dqt
         du7FYqFnCP5pj2kE+xT/lQYuAckSGIYPW6GUHRtviTsfC7YeQd0t18Le++DmJDwwzmuW
         5jyaEyxQlF6Uw7IjjxTZ/QbRGzYvarGapYxsuB/oQNUVjdfBP7/wnN77sjpOu43kr7rj
         KNf323D5M575irmfR0s0GxmkWZAz+fEooVvRbzotSwKLYFiXpbrNeqepaTC3rPomK5Ig
         3iiA==
X-Forwarded-Encrypted: i=1; AJvYcCX5QXOt9ZTSIXVkBKqPFiIonr65CpzwMvwvQ4MAtLF9rwaLUo+xwdmU9MTPvDzHCfbcfXCF6w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyAFizDu4EaFbfzEQB1VXr87WraoEPDC8UseaoinU24aNY7zIk+
	yVpPVehBESvHi62zjGhfQI1mdrc4FWMmG3pst+NRrZZcEaysJ8bQpZ+et70pjNLlHSp8g+NgILp
	5eMr//FMJoxxPTWOhiJ5rBgaxg6nlGW/dKXs1+GY9eQiJPTbcpU/W0iAr1w==
X-Gm-Gg: ASbGncsdzFPZplYRyaoyIbTSoEQ6pKO3baQF/c9maw0w3z3AbPvVDxBJfU2ZhmFtIqs
	zmuqKNzIYJNqnWCXjlconlsJssprMMYqRxVPoT0x1Xl2xluLztNt8XFsTX6fRJqQu00Y3TkWCQ+
	0PqXszhuS4IHgdtf0wl0gNGbaXlVhA+Nr2WD/vBxa3BKZMuzWUWGFSWHOAmi1s/46fUX/14pl//
	qntsj0kohP1UytrOM6yTyvxz8fcVOgnefHVAgULYoKGsmkgmSxdhO+KtTtlU1BUuA67DxQNFlph
	z0kAHbHDBOjFA3nWa2T8WL2o7pYy34EQ3SzMM8G92s7hk5d8oGswTRdJAdz0SW8/VTYsZ9oAwLN
	VY/R9+AWr4ojAzG7fKk++ahNWV4SkhRySuv81bu05vmX6ANTooiNi+PKN
X-Received: by 2002:a05:620a:2892:b0:8aa:8473:42cc with SMTP id af79cd13be357-8b29b8490a1mr202775185a.13.1762945204239;
        Wed, 12 Nov 2025 03:00:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFICFl1Bei4gFTCtGVVbdiZWnf2m+A7V9QinbX3AbPXIfmcfEzvl/LVm4b+p5mwxeUaPgchNw==
X-Received: by 2002:a05:620a:2892:b0:8aa:8473:42cc with SMTP id af79cd13be357-8b29b8490a1mr202770885a.13.1762945203662;
        Wed, 12 Nov 2025 03:00:03 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f713959sm15601265a12.5.2025.11.12.02.59.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 03:00:00 -0800 (PST)
Message-ID: <dd32a5e0-1dd1-484d-8fb7-8f6c506c8c83@oss.qualcomm.com>
Date: Wed, 12 Nov 2025 11:59:56 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/21] drm/msm/a6xx: Improve MX rail fallback in RPMH
 vote init
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
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
        Thomas Zimmermann <tzimmermann@suse.de>,
        Connor Abbott <cwabbott0@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org
References: <20251110-kaana-gpu-support-v2-0-bef18acd5e94@oss.qualcomm.com>
 <20251110-kaana-gpu-support-v2-11-bef18acd5e94@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251110-kaana-gpu-support-v2-11-bef18acd5e94@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=EbHFgfmC c=1 sm=1 tr=0 ts=691468b4 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=sL9_24WXM6ABxRF1V6wA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: 3YR-KxfDsdEFMcS1zhZSSK0jUZ0kvYpL
X-Proofpoint-GUID: 3YR-KxfDsdEFMcS1zhZSSK0jUZ0kvYpL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDA4NyBTYWx0ZWRfXxy7GuVHdlo8A
 PG5U+dh6qvnKiNCjKK+w5PRYX58nJJ/+y2a8Y6GcAAvgvsvw8V2FCnfgobYY4b8cNEtjwZC5BI9
 VQTRV8J9QP6HaTkl4S8tqDe2DXBediwj0VorM+MT/eXWy/Wt1Dd75oDofdvKeyCPp5eAAzJflx2
 +T5znom1f42A7zxX/glVHbLNPzic2cXgb5znUQ/EUNovwBgcDS63d0VSRMW/nWIW0afPQt3pa1X
 ye+QP7leSLKJB0XxEjxvlR1NR1VBPYe3+nNBKFrbLZmNNC/+pb2j6qv99bW52nCOi23bVTTL4g9
 aGGIPCQVd64LBJHmLltRz9zzw/a+bJER8NyMP82jdF2lv30hW4VtkDmA+oEsNTEn8uV7EcFUIGt
 6JXDs1ofDKazN3Kr9Sb1uynpUWMygg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 adultscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120087

On 11/10/25 5:37 PM, Akhil P Oommen wrote:
> Current logic assumes that the voltage corners in both MxG and MxA are
> always same. This is not true for recent targets. So, rework the rpmh init
> sequence to probe and calculate the votes with the respective rails, ie,
> GX rails should use MxG as secondary rail and Cx rail should use MxA as
> the secondary rail.

Is GMU always on Mx*A* and never Mx*C*?

Konrad
