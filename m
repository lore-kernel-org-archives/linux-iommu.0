Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592C935E948
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 23:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780528288; cv=none; b=muWRSyGcXrSQau+0UujSA2fePNrmjuXcrpPu9t0geW63OgX242slpdtefaDpAdQB8fIUh66zmUbEwVNlwmI/dt/gXT+FPgSDgEhdhthXXy9fu2diOoaKiZY1KnCQakskrp3UBtkBxDKyqJHHXLGO9gC7OzNexs4DhjqNxyGwrww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780528288; c=relaxed/simple;
	bh=x4N9gnbtGQ2OElE49epNC6CC8hqDLA7TD/8NDJGc9v4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwU8akr1YWOtQpjXIzqoZPwA1JMEG7gs/i/noZg3+OXpeNZ2WP2/axf2+1+6rHIdDJC/fFmxYr4ZZdbDcsK+Qkd9kn2YWQPVuTulBNfsdEqXFMgwJ9Z+dgIqhgrR/2R7JZYlqro14/bQttwFhVsAyKa1vr5CGgJ0KV6acB0cfjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PQlAGpWC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EmrWy0Hl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PQlAGpWC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EmrWy0Hl"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 653JTQbJ1740936
	for <iommu@lists.linux.dev>; Wed, 3 Jun 2026 23:11:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pbg2lZIT6IEi/rrQPbwo27yLNtC7VorLPG0nWcQWW8E=; b=PQlAGpWCLoN9iNoO
	/tfLoUmkZP92NidY3Epvt1h04Dvf+S+D9/JqS9E+BgigNus5m3iTZRdZQoI9g1X5
	MiIIC6fbQukvuITzn2r774+rb7L0bAxiA5C+0xZIZjrDrLE3KVI/2XIeDjjPu7s3
	CpZ1xetfksToCsKc4BVbm5gOaDxHjaKJeAPDRbIrhvea/seavCzRr/a9KBn8YjAO
	SzfAoM4kyftsO5bKY3C4nkD2QxtEZcLFYvSJQSz38ix+nmJysZimjp0vFyabYdz0
	3CBHYcgCy84ChAu7d9lst28zXiCUEvnHmdoXo0l4FJr3PND+0MdelNMPdIn/T6Us
	YOQHNA==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejdq7vd7w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 23:11:26 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-6c69c788ce7so50610137.1
        for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 16:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780528285; x=1781133085; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pbg2lZIT6IEi/rrQPbwo27yLNtC7VorLPG0nWcQWW8E=;
        b=EmrWy0HlQkIu3ffd6y3857k9OPOKY+1BYo7GGsb9AcV7IuPKNhdzIlBforRvp4fPjC
         B3a7j7JiBXgPqsqnDvNdKtynlYvXgnHYd9bOJiIcwvVGRuu4+Eg930fpvW6n9kNnGcdu
         rLHk6y0zMQc7qwGxB9o/AOZmfJ9nk17QIaM0nGJ+wMpE4C4nwPUvwOcPjv1P9Na/ZPxg
         VLqW0NqnTUAC9WFzzL5mdpgha8pPwqCDHb0XLDP2CkbduN7iRLp+DlDuZNh0SPVCGef6
         ZKOI2/sxRIIm1pyEbFYDtWwhdgexVQ5HdBZ0TPtF8B1P6F9aSzilsed/W2TTl5PBiVvv
         dOSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780528285; x=1781133085;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pbg2lZIT6IEi/rrQPbwo27yLNtC7VorLPG0nWcQWW8E=;
        b=YmmvU3BVVf94meHHINl7Ru9CER93vp6RxNzWRKI8jJv3LzNqLeRs2bSL916B2P0dVb
         S1C/7ifQedkIH4icYfyYgNXwxIqtjBNae6tavtLQur4JeZo5YSTMcSv5pvtxH+1hvv0k
         W77KxeNS4PUkbnO6afuRdpNPAcIYf7UYcFBQ/svdnNHrNrMuBIszYNe9Ghm4AijUk7oI
         FsSOGAOnH/pDEpPUARIJI8nWYlYOUKPMT4FmzlnjhDn/H2VYgsPfnGvzehx0aI0N2muc
         GGwa2Rl9Ipxik3I0R18ZZu93pKaPhrIhQX+QpGplgGfeNe7dY24Nhmyh+VLUfRh46V+4
         roGQ==
X-Forwarded-Encrypted: i=1; AFNElJ+k9ADrARjdB2qJC6cjc8TDvStKXOIqTo/0B5aOLOaAuJRigQwjbR+RRQnQFJc3Fx0ZUvowUQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwxGeeucJde52Eb1SyAsAdhEYRGeiMdhUGzNpK1imhuYbbAfM6R
	eUcT4XRhb/O0tl7hPQOtj/02o66vPwUaxXihxZUr33IXSGCxKf7jj86Ja8HetIHjKUVVV1TFCtQ
	6p7/RAJy9kEMS6I1RMb1jwKQLy2ol95MWEexNoCX6t05fJ/myawN4m9Vugw==
X-Gm-Gg: Acq92OH/xF3ojDwvmdQv79Q+Dw1ulQnAhf0GJXL28ZX5C+g2goLWUeH9GNrOC1RLrS5
	gBDXtA1KkaL9BAbwqPMWavHB7pZKgud4dhxof8wzKhKebX0T2BYMnUXrm7tdNVCcoci7I7haR+Q
	yg91cczKnc4ZiST4oAG8nOq1ErecRFwseGEdfunCx/RoZ0Ir1hC0zaihk6bnfxOrbvvxlcHGl1z
	j7TWV0BHXXpJU5EaZytqhjy4bjuKJXo2jHbVyrygTjhYHqRgOQ+u1re+EwE0HKZ7QW4Fa11IEuq
	0QjYE8bj0/rJXnHG0DtpAUL2t+nEbS5eEgUF6qZ80GPXTUPMQOtZHrENZVwimBMJgjfuthdvF7d
	5asbGlDZtgSYNI1p4igfSb19FOR+B7jSovwVyZM20y+GkqXriOjhYUaTJpyQ/NGu5WWdWXxLFzr
	/F5qMkNiT4EeMrvdPrTfKMUyyKWNiHMLR7AKhHl1AE2Ega2Q==
X-Received: by 2002:a05:6102:3594:b0:607:4fde:1921 with SMTP id ada2fe7eead31-6ec490c3d34mr2892891137.24.1780528285611;
        Wed, 03 Jun 2026 16:11:25 -0700 (PDT)
X-Received: by 2002:a05:6102:3594:b0:607:4fde:1921 with SMTP id ada2fe7eead31-6ec490c3d34mr2892873137.24.1780528285140;
        Wed, 03 Jun 2026 16:11:25 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b97ab61sm888369e87.45.2026.06.03.16.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 16:11:22 -0700 (PDT)
Date: Thu, 4 Jun 2026 02:11:21 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Nabige Aala <nabige.aala@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 5/5] iommu/arm-smmu: Add qcom,shikra-mdss to Qualcomm
 SMMU client tables
Message-ID: <sfxhpi5tg5x3mm3twxtafwn4v5tkxeyoyackz4g4agjwhlb7yw@752limezj4m4>
References: <20260603-shikra-display-v1-0-aeac1b94faa7@oss.qualcomm.com>
 <20260603-shikra-display-v1-5-aeac1b94faa7@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260603-shikra-display-v1-5-aeac1b94faa7@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDIyNiBTYWx0ZWRfX+2BFVJy5hhoG
 Sf2/u0N1j1nnqEs59C0nnO6h20Tls6cHgLd2znTjN0WtJjggSnVCbrMdjl5d5foSntaAKQFpGFN
 zswYIm51vsvpJ44OAx3pRAuhvPTAC3rNlE6rIRrRsBNUb58FLDwhibNzOMv7f0xTHPDWElAEOgQ
 /OEjs8InRAzmFVrHCg6cs2C/fSS8syf8bwfglqf/bj8uxyD/6PrBlw2n+YsWE4QqM5sau7SBFtu
 aQMACqyJHNS+uUqP+JpmnyGMBOgYhuuxQRYcQxTKGrycHD/cyGIuFfl51P8Mdq7w5ITrsjlxx69
 7wYXxpCRqsWqNgd3YikMg6NdF3Vx5/JWhQAcMB9Guw9A0kHKDEWDX2z7Vf1nu1CZx71WiO8P3Vc
 rtT5pGzVEU5X+3I0KIU2GyLmLKF4/Ax2vKX6dgITGxxfIQsp8EYCmE2Qw6GpsnmAFs8qUwEqOCE
 XOKvrLw5iZgoOnH9fIA==
X-Proofpoint-ORIG-GUID: vR68KjfhoTBvOAPo086EzpoJsFJ33kqU
X-Proofpoint-GUID: vR68KjfhoTBvOAPo086EzpoJsFJ33kqU
X-Authority-Analysis: v=2.4 cv=ccniaHDM c=1 sm=1 tr=0 ts=6a20b49e cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=AKL9z4wCTGGjPT63ffYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030226

On Wed, Jun 03, 2026 at 08:29:30PM +0530, Nabige Aala wrote:
> Register the Shikra MDSS display subsystem in both the SMMU ACTLR
> client table (for TLB prefetch tuning) and the SMMU client match table.
> 
> Shikra MDSS uses qcom,shikra-mdss as its sole compatible string, so
> explicit entries are required — there is no fallback to qcom,qcm2290-mdss
> to fall back on. The prefetch settings mirror qcm2290-mdss
> (PREFETCH_SHALLOW | CPRE | CMTLB) as Shikra shares the same display
> hardware block.
> 
> No entry is needed in qcom_smmu_impl_of_match: Shikra's apps_smmu
> carries qcom,smmu-500 as a fallback and is covered by the catch-all
> entry there.
> 
> Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 3 +++
>  1 file changed, 3 insertions(+)
> 

NAK, use qcm2290 as a fallback. You won't need this patch.

-- 
With best wishes
Dmitry
