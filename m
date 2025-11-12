Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4645A2ED86E
	for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 10:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762944968; cv=none; b=OGu05vH7OaHdFqUauGVM+nUa6SiGykLD1hhJItcyVupvliojZA+gzXbDad0X3INZAnvD0Jf1M+kD2ZjgRWzd2G3F4xb4h7zusmG0p6ZdodAXTxjM/7WKs2ksSmOC74jvAEbwEKnRLYxVuHQCHOj2/LTyf92beoX+OoYQqqqTFMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762944968; c=relaxed/simple;
	bh=ZzpEI9WgfiZ5kliVes5Y9Jfc8V8uQhcrISym6yczJ2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ubPCWoDgZMQ29GHqgwzZHHnvH/qbkKKb9dAKjbxwrUYi6MeY6SfYNWCGSVoliRLEQz6SslYOvukjOkpl26qKN0CpJai7aE0zncBZoYLA1olF0Xm4xYp6srxMA6h5u6FL2q1FvponNuhnqKd9nWQOgYGl+qpdCWTjKvQycRs3miQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YlTfbT+T; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bm4wMV5m; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YlTfbT+T";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bm4wMV5m"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AC9hVeM907661
	for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 10:56:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	q7J8baXgxyTkhN2ZdMYqtwC3Hhdgc0z63es0iUEKVbE=; b=YlTfbT+TpP6Q//J2
	88dZBFYjCM7mJWQbvLvCgNBnt79B1djKmdfOGuzl/+iuS3qaHSbgt8nZm9geeWJM
	EwucGUm3IpaplnqdDfeWTdrpoCVvJeAa0SlphjJx/CipbmbNbfOWCvoG9sMatwTH
	tHQ/dxIhZuY1GhAaGECAtuO+JzvLQACttntfzqIZC7a19Cw7Bzvqfd0Re5N1viYa
	OGTENQuDwMfZhdelpH3rWa43UBIvTuMqKThNYEGIjsZjkllXWb++ZOtls0/VL7U2
	NUr1jhbOIGY/esw833NUGvru2Hdy5K62Xkeftl/wTpZSV2SxrX/ssMhfqEsxgAec
	VRvoBA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acqur879j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 10:56:06 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4edaa289e0dso2606221cf.3
        for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 02:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762944965; x=1763549765; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q7J8baXgxyTkhN2ZdMYqtwC3Hhdgc0z63es0iUEKVbE=;
        b=bm4wMV5m4ehuff9rCAVqV63H8wkBW7Ku9rEC2LafDNX9Mb5y+XfaecTkbRDNDpItlO
         FHeZuz2uCafBHmzFZ+nM3/wsBMkZizqp4lL0UD3hg8uykbGbyMKKRuONn/NhkVGSX/be
         nYD7Tr1tuSjoNalCtf2kwZofp2qvGz6+L1ywJGID2lgNANW+5HLk5tMvOPYYrV45UvdI
         OmMoWQaMpeSFU04oe4xaBgGywewQv8LculyiWff3EOjprdGMe0+0VNXjqG0IlmEhQ+TX
         JKA2BQ84H7O2TzUZcPtFZxEbDLkSAhbhGK7lMSHlm5sGpkzTuuYcFWSEInua3DVL71II
         fEKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762944965; x=1763549765;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q7J8baXgxyTkhN2ZdMYqtwC3Hhdgc0z63es0iUEKVbE=;
        b=fL2a139svJqb/LcJ797Pdx1BaWk4O66aJMiOEuzJeY670sFQoSuqXlNpdGUzOPHObG
         Q09vYhmvKPU7bwq76u04njIXFQf/G/u8m5cMQHxmczTkgsloLVBYX90R5NSg6cjN7qJo
         MQqdLnOTceoUqeHjRZIQy8yvwUV4wca1CKPSoE1C1QEN7CGbm7mNELx8tP+ZgK5Yos2q
         9+Qtv1jeraUBy52mvdM3sleGQVcrt/GO+rFFTn0W+cqNBlW92snqWiaTPVjl6hVHEElj
         Km5PQN/gFeJBx7KVCuzCOFQp7CSnRogmV1p8tUlDF+CsuKkNv5SPYy9TK3dIWttVckjb
         tVHA==
X-Forwarded-Encrypted: i=1; AJvYcCX5DecAFLDEzczMA6D2NJYeVisMNnEcw9n/e8HG0MQFURoI4JwLpLPENx5DPo+7yDgb9FXfmQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzVhWmU2IlH3GdOBA7i4KMBhEradagLMRKooV4dKYM/1Ir4Lkfy
	4G89eLMm4fXjLiYi2ZK6DbhCDw/2mp31b7Vty60XjBm+lYPLnHEABXhJnbdtJi7rreq/1A+80Nf
	GLXHprDGVk9kQOABlVvyG3R+YooiMjx2Uszs0FkXAkNLgvSkukKqRht65Iw==
X-Gm-Gg: ASbGncvif/h7RQvB2fHW7w+gREUShpzgzA/5mhIn2qF3GriyLmXt0w3pB+AActvj9w2
	PX3ZX3wdMrjJOPycPx1R6BqQHey5nJ9JSwJcv98eiIw+LcNgjuq+gUEN1TdR/tobMYlrCO1+UTx
	+F9BGQLPIcGcjfBc2jU8JDjt7sjWLwFBWn54o3qr7g2cXBqan6per8VZx3Kf9fNJh5C7NqC3Kp3
	ahfh3FwqoyWsLKnTI6UvRPv1E+SszKh8yiNqkvAbYuB1lSE/gVBVzYFc0yN+vs19ntqMtBTH4a/
	seHzhTgRTgkH2u/uQ4fS73HaxJs+apeenSiGUfBvcIubNJQSIdN38eKdjhUZGTBJ7nG3bl8kQqd
	sXz+9aPlH5J+BxeekhobFF3qOecEim9AxJbf1KibeYutyEmw16onwvCqj
X-Received: by 2002:a05:622a:5d12:b0:4ed:de8b:4436 with SMTP id d75a77b69052e-4edde8b4640mr9664771cf.12.1762944965475;
        Wed, 12 Nov 2025 02:56:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHehnHC4uvc/Oy+HlpbxtFmbNd/Io3lA6JdYlICTyBqU+FS0kyknsLAZ4U0LhGMGqz+5Q6+5A==
X-Received: by 2002:a05:622a:5d12:b0:4ed:de8b:4436 with SMTP id d75a77b69052e-4edde8b4640mr9664541cf.12.1762944965047;
        Wed, 12 Nov 2025 02:56:05 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b73381dd3besm103142666b.43.2025.11.12.02.56.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 02:56:04 -0800 (PST)
Message-ID: <8f1caccc-8a49-4c26-aeb4-f46f81593a30@oss.qualcomm.com>
Date: Wed, 12 Nov 2025 11:56:00 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/21] drm/msm/a6xx: Rebase GMU register offsets
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
 <20251110-kaana-gpu-support-v2-9-bef18acd5e94@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251110-kaana-gpu-support-v2-9-bef18acd5e94@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDA4NyBTYWx0ZWRfX1FbhEc3t2Lsc
 I7UhxvEyTB/GED0QNHUg3VH00Zoy/kkl7XQ6b0xpMfKMkQoX7VhxMu4dxJdkYHrdjPl7wMerhah
 Oe1K/1N5devUO45pwIU5nmu8tsK9T/j7WGgTxZsCPs0vmzSZHZwK4dyZGDm7f5f5emE5X9Wa9RD
 hLa38Zs9HqhHFKKNgTysEmBXJFOA9A040NxJrrnkYv4zma7RaNoQIvxMIzzsRsJlm6UIkgUkny5
 S8wFDr8R71zZNiHonJKoZ1PU2O1sC1k7QW5x9YbBuhwrXsIH7o2Bz7qGS/zlJK+dQ2oce6LutQt
 NdMBBL9kx2lKGcsmhRXltpGizffmnvGtw4aNvqwwPxEDcyLrf/rEP/yzu1Pyn3TGTVZ3hAdqV/d
 3Zh7bjSsoHFu4/yTP6WCAnVJ8Y+2tQ==
X-Proofpoint-GUID: 7lDRgssU5tBSAh0afJc4ivvDfAFpI-1-
X-Authority-Analysis: v=2.4 cv=bbBmkePB c=1 sm=1 tr=0 ts=691467c6 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=LTedVN9yYKzQwah-PCsA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: 7lDRgssU5tBSAh0afJc4ivvDfAFpI-1-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511120087

On 11/10/25 5:37 PM, Akhil P Oommen wrote:
> GMU registers are always at a fixed offset from the GPU base address,
> a consistency maintained at least within a given architecture generation.
> In A8x family, the base address of the GMU has changed, but the offsets
> of the gmu registers remain largely the same. To enable reuse of the gmu
> code for A8x chipsets, update the gmu register offsets to be relative
> to the GPU's base address instead of GMU's.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

The resulting diff is a little convoluted, but I think it generally
does the right thing

[...]

> +static void __iomem *a6xx_gmu_get_mmio(struct platform_device *pdev,
> +		const char *name, resource_size_t *start)
> +{
> +	void __iomem *ret;
> +	struct resource *res = platform_get_resource_byname(pdev,
> +			IORESOURCE_MEM, name);
> +
> +	if (!res) {
> +		DRM_DEV_ERROR(&pdev->dev, "Unable to find the %s registers\n", name);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	ret = ioremap(res->start, resource_size(res));
> +	if (!ret) {
> +		DRM_DEV_ERROR(&pdev->dev, "Unable to map the %s registers\n", name);
> +		return ERR_PTR(-EINVAL);
> +	}

You can use devres here too, devm_platform_get_and_ioremap_resource()

Konrad
