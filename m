Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F6321D3CC
	for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 14:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763388554; cv=none; b=Pu19+00p253LvoGt97qaNKUanoe2qLDIyWAwN1tcVsI7HWNlssNOzVp3bENOqzwv/cenBRdNOAbfdLx5AqbBGkmRomtShjHmIlaZ/wSEeUdikf3paADVp6ma7Xd4g5KH9wtuHZQHDAfZHa+1kILux2BrDD5pBWeOd1xQVMH5RHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763388554; c=relaxed/simple;
	bh=iWP9KkEiIxGDhZLl3mYX9omLsm9axPKeKxjvh8gmgc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jIZEBeE/KA2MdDFeO12SGw8F3hSreus1TEVXjTdHQar+Pfk/pzSMTEN1r8725nuLeEiHOhLu+nVYYy6HtizG2q4mAAWsLjwqC/JO0OYC/p1SIjBZhUYMXAWjwr2o7us/IC5/+rtlVEiE8W8lo5N/pu7J3e1Lr+ohw7sC2JwP6hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fSa2HpyV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gxEbTGZT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fSa2HpyV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gxEbTGZT"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AHAC3pS3571532
	for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 14:09:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wYgunParh+JDc5/YCj+ahicQ6jsPzzbMC9cx0xBw+FE=; b=fSa2HpyVbEXyR5hs
	AUWWxsv+gPGVSCo4FW/z8Q0Z5Eimecl3OR0XXpW8dsYFPKyHvu/+W/bsFJ7R2wYE
	yE7xU5SMzPHOY0ife6MRwRqvPrVeVVPYpEs5B8mpA3Kac4OdYqdG1WF8Mgy+dx22
	L09YKmI5RpAtS6q1ugXdSg7b9+kWjbSjeYMNeD7NsLRlGqq/Q5+4JmbqR5uyI92d
	2yb0J8hx6WDz47JuY8WXKiAUexjO09H9IeKnAaLM7SDtBFAwhRIhtwAikacAmms6
	kAu6pjtK6ERfamox+wbyXsNm5l9ITldnyUb4NfOCBpKEMskvjfonOlezx7BqZtov
	zKuykg==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ag1rbrms7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 14:09:11 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5595ecf10deso309184e0c.3
        for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 06:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763388550; x=1763993350; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wYgunParh+JDc5/YCj+ahicQ6jsPzzbMC9cx0xBw+FE=;
        b=gxEbTGZTRV8WxjTEKEMDtmPL6WqUnyg1sZIcCstSsFrldLInklZf7TGWKJ/+bRjdkd
         UVPJNVfZE1jPo2Ufl+Q7yy+s6FT//a89ypYDPCqcTZeFNJxEVBpKIRm7IAiI/BfetN/m
         IIpjvXibMF1zEnaA64NXae2z/CtYoeuRfpRGrSsF1uUvBsC2hBjVyLFaFfCq68YusrQy
         Dx/F89y0nJUMLj6ij98cTU4JpHXdG2vrXRW8gfBP9wjnzZF2OsaOJ/D+udriwsfEYaGa
         wYsmN1zfgwbk8Ei9YvHO6f1nNFJ8U99VRHIBqfCCsPsxmH6ghlK9dCgMH1sK1p1iQIzQ
         9x+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763388550; x=1763993350;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wYgunParh+JDc5/YCj+ahicQ6jsPzzbMC9cx0xBw+FE=;
        b=qKjhrcW9xYB3608OVS/cTE5zAyYxSbqTOCwp4wT5nw3KjrsEZB5WcZyoyVxbVZi9my
         5V7zPWQEaIv7yD3eZITjzUQ7lHveauXe+zBM9GaMubSrwV9T6JlztzHRoITtCrdiun85
         Tic8UngTLGL2G/VCZr8mJiZdNqpBXlea6bcV2aX16AjKkawumRIMrhIDVzK6FXJPaei1
         jHVW7kmoUpJy07aFZhH2L7/1iYBy+1HXe7Xu8zjxWpOJS7amVq3Qtm+h0tQrkhpIq2pw
         rLC7SmMf5fXvnKHPux1WhYFJhBNxiOnHQ38YQWSwuvs2yFStTMtL+r+FxjxhU912+TIl
         GOsw==
X-Forwarded-Encrypted: i=1; AJvYcCWBZUzswi/XWml7iz30Cr7PA/iZRJ/VUniLPkKpU7FR1v5oasK6okbG/FMb2lF5kLGqqnZvpg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzMdwaKGGJw9b8ZO00D64M2yYcxgyH1WO5cn49de2EcpEqV7nVo
	KEw67K+0zBUDL7EU1gclc8bV1tHgvhzbUZoUqi9ERz3rHxTFWvcuGOVdnPmj347l4XgWxg/ZrsE
	LshGTC+/EPTnpv4ypDEQB9F5bcgx1BwkZNyWSJcfcTs9UMXzZsOmHrwDJRg==
X-Gm-Gg: ASbGnct60+33mfFsbeCgBG9k+lx1JAUXpcpoQ4lb7jowppXGrcCvkfjTt85rwFZA+1h
	zA3NNr2TgVnBVE04M6ASvSxZI4BOPKT4FzivVX7PIKKFCKXCXdx0lpQw4aZM8fC1M+u6lUNhoV5
	r8S/aTWmb2qNDkyXqopXRuuUShS7TkRuacoUQGbNcjmadhRn2QP2LiJbPqgktLxLvF8OGK3gp2O
	iGVa0WRtzH7343fRzcrBECyqVDWYmTEyUnDNZ1+fuxW9DKBvMalKpWVDpkivnRu3i1ATfk087n3
	JUWH5eJmKdyQJCw+dkZOey6JKffPK1d/4qF39/5lTTJrHWO/lCfA0wPtqZjVkehtNKOfk9MGi05
	mbhXwkzSyRxHmRGdXa3MTQazYt6ezUgYzsQ1zPxcW0Fc6zPVcrwQTb8kB
X-Received: by 2002:ac5:c818:0:b0:55b:ac1:d05f with SMTP id 71dfb90a1353d-55b1e8e656bmr1323562e0c.0.1763388550465;
        Mon, 17 Nov 2025 06:09:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFEn28HG0q377MHRpAVge77qxO8f44ujFbyC1+LqHPUCbNQVUi80/RIfFpD8JZBIKQiQvtEgA==
X-Received: by 2002:ac5:c818:0:b0:55b:ac1:d05f with SMTP id 71dfb90a1353d-55b1e8e656bmr1323540e0c.0.1763388549969;
        Mon, 17 Nov 2025 06:09:09 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6433a3f961bsm10439343a12.14.2025.11.17.06.09.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Nov 2025 06:09:09 -0800 (PST)
Message-ID: <eeda046b-cea1-4c57-86b9-217482568b0f@oss.qualcomm.com>
Date: Mon, 17 Nov 2025 15:09:05 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/20] drm/msm/a8xx: Add support for A8x GMU
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
References: <20251114-kaana-gpu-support-v3-0-92300c7ec8ff@oss.qualcomm.com>
 <20251114-kaana-gpu-support-v3-10-92300c7ec8ff@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251114-kaana-gpu-support-v3-10-92300c7ec8ff@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: quNJzmPhCgeEzz-FHf2KlGIxIX0WwJ4Z
X-Proofpoint-ORIG-GUID: quNJzmPhCgeEzz-FHf2KlGIxIX0WwJ4Z
X-Authority-Analysis: v=2.4 cv=FPAWBuos c=1 sm=1 tr=0 ts=691b2c87 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=N-Earc09p0J-wu5tJXsA:9
 a=QEXdDO2ut3YA:10 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE3MDEyMCBTYWx0ZWRfX0j4HXQ+M6QgS
 DFOAzFQ/nSX9/Kg1YDTKDaR8ZvWZDhd7RKYNPwUuBO5RPEFid4iVuPYrxCD5Wv016YdS7ORjZXQ
 0RGmsK8L1Ex0SYszL1Q4UqFltDp/ctKZr710vDtoxVfbY4gluIBJ9VY28SR1prO88S1KhY4pZS6
 tmyNKaVQpbqVFn+whrDPWmBP55MfFIi9gf17tjfSF9rbJxUWk5LFVksOgRQ/AINAOUEO4CAp8C5
 yQnFJE/9OOm4z93oy3MIhGVOoZMGf4XrLDvKOA/YRE3JkrgpuCELtGRmdpkgdgjzD9yWU+GJsIM
 ARBhnv7iMnz9qcOOjuBQc77iAWegRbBQWRQkAYeTHPYFNED2j7QdQNtZ5hwZoYnAXcFW0YQj2pH
 d4Ku99PXOLLfQPOxI3abIZrEMbwNjQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_03,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511170120

On 11/14/25 12:29 AM, Akhil P Oommen wrote:
> A8x GMU configuration are very similar to A7x. Unfortunately, there are
> minor shuffling in the register offsets in the GMU CX register region.
> Apart from that, there is a new HFI message support to pass table like
> data. This patch adds support for  perf table using this new HFI
> message.
> 
> Apart from that, there is a minor rework in a6xx_gmu_rpmh_arc_votes_init()
> to simplify handling of MxG to MxA fallback along with the additional
> calculations for the new dependency vote.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
