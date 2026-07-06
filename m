Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EE52989B0
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 21:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783373833; cv=none; b=CjqwcmgnfNReJHKQEAs2L1q2jIKZrOTs0PcfIZJOhgOshEL/uy75MVcQCilNcfyDV3F7ItFv0b0Gs25HsXJH0Q/K6q+EFaTSTMLt1o3Ka6NLTsHYiYCl+co3vNKcUIS/P1lDxkZJg87GEDBjem0LlGPlAWa16PeEPjfgiQNFwxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783373833; c=relaxed/simple;
	bh=SYSTzYMV9dZlGM6XYUNUNoY3tliyo+BItosKaSVA/LM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R32hQxIWrJWYOm58Vp36DjQu5eYX+IftUag1bgpi3zfyIUAM+AZYMloZ0nFdda0Ks9QtRnvSctD/d4oRx9NxnB7pbOwjVyXsPF8j8cCpBCBX+XzRDvv9EqJkuE+K23dhdhKlEds1KJBQm5auR9iBOR1+ALfzCmKSXl429ZuLkSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n/g9HkW4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IM6ldrXG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n/g9HkW4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IM6ldrXG"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666KDweE1478003
	for <iommu@lists.linux.dev>; Mon, 6 Jul 2026 21:37:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=51ioZRkWsr8YoDDsIq7CqvS9
	RZMTHGeh6Z7fA8LH+6U=; b=n/g9HkW4D60PuJ2NZSWDYc5hRIKJKU8BpfsglSw1
	tgDVNoy5flTOTKVlT92I2uQLIGcVUu2ceQOuCoueRx6rIxt2Q1eoJ27LvZq42NJA
	CsLnVxmG7WgXa1AdD5pCbmD0AsVUpfVNhuyW8ugquMLtNlIHlaFapc45+Ey6Ms76
	Pou+uFpaFih47E7zYwBfx9KzzuBFtU4rQEWG2qgVdzRq/W44hUCVTIhpTMqdVM+S
	/k6TUo3bPIyriitLltZgudduDaZlT2ADkEIglIEwQAlk6VkEm/UBWVYcQWXqNS88
	Z++6Ff3ySp5Kfn7BE5oLSq/bUjeCr8WYcPG1g8veWZv6qg==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88hsbf0j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 21:37:10 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-738b76cfe03so3911695137.2
        for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 14:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783373830; x=1783978630; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=51ioZRkWsr8YoDDsIq7CqvS9RZMTHGeh6Z7fA8LH+6U=;
        b=IM6ldrXGGLQWL8XP7W8GjqBQuG4rY3Yr96nPC864BLBX57FhLn6Ng3Fl7T/JxTXIx/
         rx0K1Gj0pmU0Jl8rG59siECS1eG381FaYuZoXc366OzDaZOvRidNFahDBB+UIdDzah3+
         BYJSh+9f08PnPts3teuhSuv8K0N4OySaToFZH+0hGXUeRPIjiZOx6tDyZAdtr0OU3QCv
         5zT7fWaYPrpiDbUtutS8NJLK7pQho2bqIhyWHAZhO6F5LEmQMhdRXmYNJf2TAU6zFZQ5
         ERUPmuoSlE53ZDSEZ6ZADSYiAHWtnRli+7YaFVxt5IZG43ZiJbpxHoBT7AdRDb/iHScT
         T8kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783373830; x=1783978630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=51ioZRkWsr8YoDDsIq7CqvS9RZMTHGeh6Z7fA8LH+6U=;
        b=rBj7VCdWaSGX4Nhp8Tt24mpvn2zjsIQBN4X8/H0LT08lBvfEDMTzcHdy6nqwwweCCo
         MIfsCXKvd1evf0CxjFWOI1lFbjb13rkQ26FuI57Ad4j67Dzl2tBbNHyRedKgtLOujyov
         hYuUJ5E0b4BbSA8LBabY4/A5qbNk94WhIPIRiOwW04atwuTY1fdepxand74cE421JIds
         pW8VK7W0N0Jk34BuvaAwnJ977FQ3GSKVkjKnw0UIdLnChsi66MsyQKl//dCq2HQMJvOL
         iYbnWP5dsaz7ppahzazAyRYwjKF+2+hgqGNZjgS1vmKByRwzd5dYWUW5JJGuWLiEMdd0
         Vm/A==
X-Forwarded-Encrypted: i=1; AHgh+Rr4BD6QBqaEWW2McJaB6FwdiC7UB/sJ5o/SFX1U2Y3lGkGbXAZGmd0N6aU2Yb7+7gak2MTw4g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxzc+CHI98xQNjwKVq/oKAFAHPR3OjkdMR/GVSgtVOMpd3CVAQ7
	psjhZsAImQwemMENKZRez0bcEOvSQ/GqnVQlIIDcgSWeJwudNQP5Z44z1hkaSILBgKX/+ElDNzj
	Y8jwzZnkGHAcvUZ35pEUtZ395n+pj6ibbpjoTaQNoG6zhDwLfGhZ4l2jh9w==
X-Gm-Gg: AfdE7cmcH990TIXd8PFqjj7BVhhgr+ZCMVwfjGuz5eexssp1pSIkzl1Ieu0evPYgo8/
	lVb7u+CIKgMa9ccs9l4eZB3t7NgVbAt6J9uzJVxH1w4ErAsZhHydeYMgaT+E+9Y3un8G3a1Emvm
	kTnzTreynwmKsr7dkV9T2aobJQwOVkYskx8ek5Z6dcFnv+HlhZH8b2ciu/0NXMgDHYGGq/iS9a6
	AccbSXArBS45FAyjv2MHTreBqPFtzQL6pJDe4xfM31nNcHiGvCvax+YYcxBp8ALcRCF1r88zKXd
	sMIBu1UHl32+bphD6Gu5SE/SbtvAC0MTyLp5O9equ7Hbb3jeXFUgZt2yWJDYD4d4WZ/i3uo7xSj
	HA3Uq2KzQb7FCiwX0MFBQMrB/CtkVgBgCnJ6sEKjKWW5Xa1qy6/2pu6cFH+mNkqGQM4SwLG7QHt
	n6PHaq67SqHzhxmQPpFWeM6SJB
X-Received: by 2002:a05:6102:5e96:b0:726:cd42:d039 with SMTP id ada2fe7eead31-744b7e0bec0mr1289251137.24.1783373829673;
        Mon, 06 Jul 2026 14:37:09 -0700 (PDT)
X-Received: by 2002:a05:6102:5e96:b0:726:cd42:d039 with SMTP id ada2fe7eead31-744b7e0bec0mr1289236137.24.1783373829228;
        Mon, 06 Jul 2026 14:37:09 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aed13c8c3asm3167623e87.82.2026.07.06.14.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 14:37:08 -0700 (PDT)
Date: Tue, 7 Jul 2026 00:37:05 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
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
        "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Subject: Re: [PATCH 2/8] drm/msm/a6xx: Rename GBIF_CX_CONFIG to a A6XX-
 variant register
Message-ID: <hahn2b6uu6bwzuext5jkb34zbs55yerrkfpdfqpd4dgzprywcy@wqcw6w4bkjtk>
References: <20260705-eliza-gpu-v1-0-c9f1354dbd29@oss.qualcomm.com>
 <20260705-eliza-gpu-v1-2-c9f1354dbd29@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260705-eliza-gpu-v1-2-c9f1354dbd29@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: 2Co1x1njE8nRyBveVQt0QmQhBxLIzMH3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIxOCBTYWx0ZWRfX9TWlsA9QspM1
 lvtAVtqYGQDxrdPn9YswKt9pofZQfXJOuyH7OSZpDlk7kkJnx+7It6107yPMn4yudiwThngGosI
 ZF8l/m9Y8Jm3PFYm+ba9x7sGOrmToZOlX9SzVGZeR4FlXX6274f0deWyfXvq1hp3RQ9FpWNldnh
 zkChSIfqw8NrDecO/a5SJQjNdCRj639HByNQ9QVw0ApZfF+geVNJYnX+keP2qqorU3aii0zYDOn
 b6rn6F8N4+B41lCL6FvoT2HeVcAYthf25K2JptllWL9dro8FIT/fsfvzQVZ63OpQreTM28DQ6bt
 cHeM/2EB3UvMPy7Ta7tM8Sunc0nIabaFFNMeWZ+IGs5kv45UbmO+oc3iRJ9L42P/8/0o0xwqQNQ
 /K/KcDdaVyXIxxX90/3JhzGeZXfUJXkOrxkvnaRI2xKwfS7+KVHYDznQZR11vM9CMKao2aLxJ8i
 peGgSSH7tTG4vjLToDg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIxOCBTYWx0ZWRfX76E2dOMwqTzy
 CbyHYYI8ag58SWCWfJWip8LoXohXUywp9tngjbwuc3borSI0MZ6YgD5uIcoWXUGHBsuO17hBYOq
 rvjKckrJ+StExBQGUcNJwJUodjK9P+s=
X-Authority-Analysis: v=2.4 cv=XIwAjwhE c=1 sm=1 tr=0 ts=6a4c2006 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=3yiLn2T9MxZ6V1egYJIA:9 a=CjuIK1q_8ugA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-GUID: 2Co1x1njE8nRyBveVQt0QmQhBxLIzMH3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060218

On Sun, Jul 05, 2026 at 01:44:17PM +0530, Akhil P Oommen wrote:
> The GBIF_CX_CONFIG register exists on GPUs prior to A8XX (it is used on
> A722, for example), so it should be tagged as an A6XX variant to match
> the register spec. Widen its variant range from "A8XX-" to "A6XX-" in the
> register XML and rename the generated macro accordingly at all existing
> usage sites.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c     | 2 +-
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c         | 2 +-
>  drivers/gpu/drm/msm/adreno/a8xx_gpu.c         | 2 +-
>  drivers/gpu/drm/msm/registers/adreno/a6xx.xml | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
