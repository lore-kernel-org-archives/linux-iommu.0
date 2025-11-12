Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D81A3019A2
	for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 10:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762942973; cv=none; b=dHbG50X77tEQxw3+BGvbyx7PNX9YzEbRavVLyy+opFC3aYl4bVcG7vqs6o9gEZSpbd+62bWt9sKOMgjQAFbY4EFklJFdsBgZxgJuBx5Uu5Cq6LE1zwB3wWtNQ3nsHMXW18cCHTXTirNw1NDcA46oHc8c1X6IfrlTByI9y2OFhU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762942973; c=relaxed/simple;
	bh=dkOkT9HWZuMRwVOPFG80dYooCAaGN2chaqeXAY7vEXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=om3Uvc4un225/02BynGs1orZegU5DIkBvYzAJ0yDM6zp5qzYEa3Ka3G97f9aiq99KExAKKncS+hWNRGVstCBgGNkOUz+RgfPjfpqUXnuFw5cgurtFH7DylzWi9SrEkCNcWHfv1BBpGfiWQYj0mmkfe+LlUP3fNgbtvEpH/4dfeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A3D2P2Im; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=A/hpzS9s; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A3D2P2Im";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A/hpzS9s"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AC9mgsM4053731
	for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 10:22:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5rwAyU0aPBERjod7wgKA1iXuGw5l4SeREMu619RQNrI=; b=A3D2P2ImD5qeuGzo
	jpBbHoHhTWoTnBAVC6dE7Q74dffCYK3d80Avh5EWOL9OPMibphll25jw/a+c2fLK
	C5Xv6OpsbOgjUViRvORZ+CEajalz9Rufz8i3y5mJ2xlMsqWP4CYR0jS6FfxV65Z5
	d867ln9H65q5ZU2XS8q/+NvwyDNLhI9aTeuQXWh7xnlDZOaHMasR3hzUsIAjzWVE
	evSA5abf0Rm28Ey5jE+QIs1WuH5Y0eqCeH35kW5hDrm/kkpjf/WzOU/kUnT+0InI
	kNXy1SsstRtaRY8vrTCrNCkHCRaxLqzO05nSOfn6qD8vBhrVoyDKg2u63Tt/Z4Th
	9sFYBQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acj6v9apd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 10:22:50 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ed6317be8cso2156411cf.0
        for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 02:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762942970; x=1763547770; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5rwAyU0aPBERjod7wgKA1iXuGw5l4SeREMu619RQNrI=;
        b=A/hpzS9s7eOVCUMj9jEpVbY+2zIll3FTI+V7wkZtQHjZcQAcE2Syi9lS64lgRX8yb1
         Oa6izEHHWq0xt07WFbYt7Sqv9qSsJxieeLul+g3/Tazz3+lE0YPvqpRakwcmJ5tRrFje
         7/L28BBnDMLUBsfQM/wp9jdMTGU7hG3QQJjtdkR+4YLMdRzObQ08mzBhK57mW6MFHJSD
         xn2B7QUD3qN/H1JBNbpCkRqMCOzWniJ2MWL/lY2vv4kY6Bd0pikpPJbtUaKgemSJlUBr
         hSC8xMDfzE2wKeRjs+8XYXUmOZrWZdLcPl3UjavkHhFCAARI0ETt3/N699TNMKD0auR6
         GxDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762942970; x=1763547770;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5rwAyU0aPBERjod7wgKA1iXuGw5l4SeREMu619RQNrI=;
        b=UDOz/0/iODlVUlyVJ88480mAE88hdN6h92BdbTq7jrWKd9E+j8/akbTVd1v1FLs/Qa
         zkmuF2FRCg6TXAdviFnCsWIcGC12Bu/9oqsq3twDfJZuMZ73Eetdjx5nbceFEScAvqV0
         Dfg/JrAfj4NDp6IecPtakN9vjIlQt14bN+Di02Bdl2kCBhshh9v+ucz4tN4fItQC9xKJ
         SjXTn+fQnSR/G2dUciPz1gGL7Jh7oZJ9miy9lZLyGR3siRVuPWd9A3/Dlt1HSSJEtRIZ
         vDcCp2uzLvCtIn0lpYUjRpSb5qSAm7L0gGZk6jyzsCKlwOfiLP8M99FAIh5am9mfpcgS
         HESw==
X-Forwarded-Encrypted: i=1; AJvYcCVUGFygGZGToj8mVCyeqaO/Wsrpp/H6cnFR7B8bXVzw+ZljEVwT1U/TZOE4fslwmWb+rp546w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzrYk01iK0ylyz0KfMdo/ZKZmqrGhML/+n+7XPnNCu6oaorOdRI
	cmt2vdNLk9Ymf9xZasC6qzV/tqnHX/NQ1bZI2Vvis3VJ+bvfftAZrYGbXFhOkiP2rVkpU3Tu1Ys
	UCz6GMV4ny3Nvz7pjIwrMPgt96Uoyt9SwAPwP13YjBvp0y0bDv7me9dHyTw==
X-Gm-Gg: ASbGncsqIR+SgNghwPqNzc31neIejImANS58nxUqHvae4zgYVCSLyl1AUmD60N2Bgs7
	cDPRV21vLUup4ba+ATZHaw9LJzpgF+hDSZWQStdnHEl7IY4NzRa+G6vTh1rxMT1iGRi0p51L08f
	6yFOxn4xL6xW7Php3d/hfu9dzCvT/Lpfhg3kLJ3i2Qt11eeelEIO6QR5/JNPTDXNiOxmME8ZkKg
	Sv5QB+Ve1a6pnFSyvooyKSdrV3fgwQg4VhP/1KfSmJRp3neCKBiYrmCc/CDT1Nlqc42nBFfeUZN
	9dQxRPgXv0DC+p8H8n5cNmItxGP8B5sbIZJswraHhJ83V70NE+MkjVXuWJVfSEWJQBICcoIz5gK
	otzixmy01u1DxDxI3cQp0W19UIVTaFjvIs08LRoMcHsX6CYzzpICxK/EO
X-Received: by 2002:a05:622a:d0:b0:4ec:f53b:418e with SMTP id d75a77b69052e-4eddbc6bc3dmr20363161cf.2.1762942969430;
        Wed, 12 Nov 2025 02:22:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGebY4K7Namd6glwHLtMAZE0lf4hL9guGKfOfliFjM5eEuz55Nipc9SN3o1JFfip8JTUrox/Q==
X-Received: by 2002:a05:622a:d0:b0:4ec:f53b:418e with SMTP id d75a77b69052e-4eddbc6bc3dmr20362721cf.2.1762942968808;
        Wed, 12 Nov 2025 02:22:48 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f862bd0sm15744925a12.26.2025.11.12.02.22.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 02:22:48 -0800 (PST)
Message-ID: <28d62905-c191-4c3a-995e-a4146ffce619@oss.qualcomm.com>
Date: Wed, 12 Nov 2025 11:22:44 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/21] drm/msm/adreno: Move adreno_gpu_func to
 catalogue
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
 <20251110-kaana-gpu-support-v2-5-bef18acd5e94@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251110-kaana-gpu-support-v2-5-bef18acd5e94@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: IBuYpem-rT97c8eMRbwYcZOHSHomIanC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDA4MyBTYWx0ZWRfX7qduERhQB17+
 I1DOlAC+Dd9eu+OWgjd/hROJACaZSCbxhIETjC2EHMrWhHdOp9z1XxA9IAJpR9U2XtB7F7asoPa
 Cv4ycui6R+7fe434aefGcFdN9nbDdAKICaa0OPpNe4MBTH0xxxql/y6ewIOtLNK0qbp8odsonuS
 5yqH+7khTvSjH3tWm7GqcvzN5l1qleXvhRm/4YB+KCfmFyU6FPN/SLdZljVBaTGxZXJGxA2Pvaa
 3tkPdm8CG6VOm+y1aKCUCrIYh9Mwuz8+/SOTICOQ4at34W6KqYThPSUVOcBmE0SHCeEvsR0HuNd
 yyOSQSQ2i+vlbL+QcQtPq7ZO2lP7T4Wdb6poXYqHtvokU0vlWHbmiyv8PIgD0uLQwZwVkz4ikwS
 nzMbk0Ya1KCIXl9vKSeJps3IyqwJVg==
X-Authority-Analysis: v=2.4 cv=f8dFxeyM c=1 sm=1 tr=0 ts=69145ffa cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=p7PcLuspDTVbkQel-sEA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: IBuYpem-rT97c8eMRbwYcZOHSHomIanC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120083

On 11/10/25 5:37 PM, Akhil P Oommen wrote:
> In A6x family (which is a pretty big one), there are separate
> adreno_func definitions for each sub-generations. To streamline the
> identification of the correct struct for a gpu, move it to the
> catalogue and move the gpu_init routine to struct adreno_gpu_funcs.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

[...]


> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> index 44df6410bce1..9007a0e82a59 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> @@ -683,7 +683,7 @@ static const struct adreno_info a6xx_gpus[] = {

Somewhere among this diff, a619_holi needs to have gmu_wrapper funcs
instead

Konrad
