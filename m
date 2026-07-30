Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F96530DEB2
	for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 13:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785419873; cv=none; b=eDdTjuhZ7GxYQM+GXm+9VIWo9APFP9SnO+XgGZdfvxHRVO3rtZmEA1eG+SOMLsZUm73jRroymaFqc40/0jvu5dE1HmnXUlTi0Gdtu3MzHOqsqCIoUz85R6E6UeH8/csOBhFWAXfLEO/Sz0TDiI/jZ5k0522OcxVZTR2khriBmwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785419873; c=relaxed/simple;
	bh=e5VR2mAWuRHBpht12g+236ubPVgK77LV+SumkUR/TvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MLxKYKT+c3fftRqVkqhDQWWmJ/rcY8ObhaJ2PAbhfyi/7C1+6HdV+jR4HoxE7yUR+UiI2U4Kze9FQW+LXUW3d8/0P2O0GY1+ZjT3ts/phPZfNscauPnKZgnvCgCQNwykcw9wjaYk1Ncu0JhCsagHurepKKTu1o6NDLaXR0fba1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iTZIKINY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LMO/ZO74; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iTZIKINY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LMO/ZO74"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UDeYq21228885
	for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 13:57:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dXD32x4UKkxDB6V0sSMv60ZLLDNzi7VhRUUM6/9KUrQ=; b=iTZIKINYXBw5rW1F
	0AQNyPGsB/xxWodIgL7ZH5aZtW6UW+dQXYZlejGZoFK/y8a6YTQTG3elh0ukDGiq
	lZk6EuCJfERrCZesngkrpSNEDsYfHEuQbChd3BhRRYD02fY+Mcpzgf96WKhjhWXq
	O0sfsd7eWQgeDhSAcG/m62MXaeecBTUlV7NmUoq/JPL2cZKFGlaO00LiEny8K5zR
	/2DS7bg0HKCDVL5HbqNROHWzrMnMfCjbJw5xSBj8HSVXD63a3kPfKB2pu9mbO9JA
	oG57cz/v+K8GtfVTBWNVolg05c7yHJ/24RgaxytVSaNW1aOxTV3VGDWjkeOAD/I+
	mTp26g==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr7q3g28h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 13:57:49 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-52845bd815bso3719191cf.0
        for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 06:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785419869; x=1786024669; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dXD32x4UKkxDB6V0sSMv60ZLLDNzi7VhRUUM6/9KUrQ=;
        b=LMO/ZO74xH0UUYR8hB7oPt1YvvRDprA8vLjAGAPLtcexnDO69FcoHw7GUy7d9twjOy
         XkXv/NCZHF0Kpj9xxFEa+8InuKwI7Ld/cPwK0qcNlgVkPEk5sHKAD/BjwTEFox0DUbVH
         wYQXWBA8FGNY19wqpnxtY8NOLf2LMO7K+AlFJEP/d1iVcmcg2LW9u/dJCT3BLyvGl5g9
         78PnWGwJCGrEQv8az6NnDEOLjf55Xrprd8rltjCJJ6KhNG7UCfLm4D+XZvcsPnsAdoP5
         caPWiXZe7OyW+Dijlm/jWqPxrgu3mO0SZwbDLOt7DKjEKIBZFH1OtbS8L2o8n+W8DKJr
         ExmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785419869; x=1786024669;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dXD32x4UKkxDB6V0sSMv60ZLLDNzi7VhRUUM6/9KUrQ=;
        b=HxSNF+l8inYSQYuMqp/SccZuvNZXQkfFKSlIUWZVQ+7OcDMgY+NMErSGR7C06AmdjF
         yFMqI3g8n8r8Qo9ffR7mW/NqcxxYVkvvgeZ9UdmV9PZ0w3g52FcvYDokJ1s2IuwT0QD3
         HS30eOeGh5VRs3X8WOtMcl4SILvlA81nfJrNvghxadStEf6jVQXr83zOlv3LDgbYs5ac
         7qcgdAri+6fXipcrqaDbYIgAKJI8tl7mrUG0CUn1mn8zBa8s5qTdG6dI5UI7WspVbxUI
         DImX8wkBRhw8U+dCYwz+MKRzJ9Obiu8vc518j1FZNvaKJoCHHZJr6qusStI3Vwbl/zpu
         M8AQ==
X-Forwarded-Encrypted: i=1; AHgh+RrIFrIWY4TObvxFgbGkAO6IciQ9jpFaUW3oUHsnnPlWfcp6Mshmrr/EWi/bD05PrhdYFVHlDw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyBcvGqSOiRXYUduLHFIyQBtEds44k1dFHsHkkvRctNRnCrH8Vw
	54srRTeK80MfCwOb83cwlpCav8vgicHxE1GVB4q2DO+f+NokByOxJknz6CkqvrKt3yew3bDVyUe
	74Vp+wyN47+2N0MxXD0oKw/xzUTtVALvzjT0Bm6/NigcOhtfaOZYL8ZqEVw==
X-Gm-Gg: AR+sD11xDSK7PnTa5O2xa/oKLFTHthlAXsdtWXZ4K1UOY/+RhssV0YL/CykbwPG6LXw
	b6QNo3hH6/aZaj+PMiHQlRbwcFQeymrIDlIUp9tmVMFLxSSZQxdyURtUy1Im+WytQL776k6xV41
	fXrsKskLbQC139G5w5GpmxpVttJ2fAVP87JTmaK2DuvUtXOENsfPGgxx5rhKz7rwa4ApVZuQXIr
	ot1dBgKT+//HQQEu0cVQ0svY4mJ3Y0YkCypJqBI4xFRa4E8CSjqkAHpGAezlbI6kYpC9HhiDh8a
	PP79zHvYiGtZz6XcgwZZu6JDBtF7NMxd4NV36DIRyqsK+5jZEzlXo821O5I5uMl959dUNs6dBLh
	1tIBoPGOXEVPF9BiFZQk6Kn9J
X-Received: by 2002:a05:622a:1207:b0:517:5e32:f3ac with SMTP id d75a77b69052e-52b4299d6d8mr5430841cf.0.1785419868403;
        Thu, 30 Jul 2026 06:57:48 -0700 (PDT)
X-Received: by 2002:a05:622a:1207:b0:517:5e32:f3ac with SMTP id d75a77b69052e-52b4299d6d8mr5429911cf.0.1785419867788;
        Thu, 30 Jul 2026 06:57:47 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a07d3831ddsm670344a12.17.2026.07.30.06.57.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 06:57:46 -0700 (PDT)
Message-ID: <c77db81f-9fb8-4803-8efb-078b8cf70fab@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 15:57:42 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] iommu/msm: track a context master per device and
 IOMMU
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        Joerg Roedel <jroedel@suse.de>, Russell King <linux@armlinux.org.uk>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Heiko Stuebner <heiko@sntech.de>
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org
References: <20260730-fix-qcom-smmu-v1-0-b12fa067804e@oss.qualcomm.com>
 <20260730-fix-qcom-smmu-v1-1-b12fa067804e@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260730-fix-qcom-smmu-v1-1-b12fa067804e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEwNiBTYWx0ZWRfXx4L5YmeFu6nd
 zAe0oMGkwyS/3x4cpUIbxgiuKw1Yy8OxEJFsfBAlRvPU2kxmlUqlry0YWnBs4F3eOzSU1LCgz5O
 5/uWhRFsq7PetCnCXzhqH/8zJLN+0jq32yaY95NxeEZ4m2sdbpOK61WeBl5y8lODuNDFSO4ixSy
 yoiM4fMQyjsdlfRpmSbsSdMqpSUUgdkXp+YmpZe1t/0zbWnDbujmNBjmfpsu/Vtg16e8txkDO6Y
 NUN/HxHaMCTh1imRVUjE/xQ1rs63vqmzYQ9eD8FNCwkyiiQV1w4R2uqUasAK7ktBD/ogFWmvWQd
 fsTQGhdf6auvak7JnFCd1JTqOJ/X6tfwHik2DASivIqOT/7EtcN3/rOafoYTOVHl3W342lOKYKH
 /1dodfGtQ7YNtRwGgEao1QCQaa3J+5Tv/jQEwR9B5J77joSq5UjP6xcL4IYwfIur6rVzGAGbA1E
 mgJggJqTPSIPo4BsAag==
X-Proofpoint-GUID: -lARyEhj2jGeAZV6htOMGjUq6bz5ccC7
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEwNiBTYWx0ZWRfX4HL/CNwLuxog
 zbj6eoCX3B5KeS561zPsT7l3GSPTGGQq+ZqfnUc0OGt6TXnzk8SnwZGT53aB3ewwBvz49HFzfpU
 hwT3dEDnsCMFe7oLw2k5BQ1c7ocaz3E=
X-Proofpoint-ORIG-GUID: -lARyEhj2jGeAZV6htOMGjUq6bz5ccC7
X-Authority-Analysis: v=2.4 cv=WuQb99fv c=1 sm=1 tr=0 ts=6a6b585d cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=dmEO2URhNf-i2iSvwFAA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300106

On 7/30/26 3:29 PM, Dmitry Baryshkov wrote:
> insert_iommu_master() decided whether to allocate a struct
> msm_iommu_ctx_dev by testing whether the IOMMU's ctx_list was empty,
> caching the result in dev_iommu_priv, then unconditionally dereferenced
> the master:

[...]

> -			dev_warn(dev, "Stream ID 0x%x repeated; ignoring\n",
> -				 sid);
> +			dev_dbg(dev, "Stream ID 0x%x repeated; ignoring\n",
> +				sid);

Is this intentionally part of the patch?

Konrad
