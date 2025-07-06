Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11C61D7984
	for <iommu@lists.linux.dev>; Sun,  6 Jul 2025 14:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751811724; cv=none; b=dYtOcvJ3ViyZM1m70XEzD7xgotYmEYKZ/aIuvtehyRju5Bp1YrCiqb8jNuPiY5s+STMJQSMY6r/ko+cbd0XapTtKe8/ADmhmKwphtleDhH3kQGrEtNtYYSgdRND6zFZhNZhMFpboVm2mOw99ZIviLkwVCV3UAcdku5uL7PaPiv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751811724; c=relaxed/simple;
	bh=hGj9ba+WBBvZ9zms61zCDePnwkxudsa8B9DOmH+mpyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cCXCeUufq4z9jTpILJAIWNdWJSIq2Hop8FE7ekPK3eYdEcqehQTu/p9GIS7FtL1FVb+P+kKrIFw6/vCrjRh0IK3zM9+rpqAVY4PiXg1PTGZy4O7CmLCMRS8FDInk6TJNP4RPnY79Bew7GFqOmiWKw64vkuBwUMffUr4Ngx2fhZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DZG1zwTR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DZG1zwTR"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5669ptAm016216
	for <iommu@lists.linux.dev>; Sun, 6 Jul 2025 14:22:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+LR59wvaFC1B+jtg9kXlIKRe6vvfPELWKIv1ziuV/xg=; b=DZG1zwTRrWIo8NW0
	SH7dNDOOY81dG4Haah1W7G5s6GBOxUmt/s7GxQNYDfhqYyGqftftKCN5PYZVkBd5
	eW/2QXQhinMuQhSGlqvitrcR7+3/wr/H8NceFMJlQhSZsHGMs4T58P8Khl8cZ5YR
	JRRTaDYfv7Xjl9T9OUVMyHNoHS6Y38lRdZf9HatRxhAIzegnGiIbL5t/hb6IAmO+
	nt33oMNdKtP3rnCcGBG/q0YMWWlDmr01jTleGo5CDH+NkX9vdCAwiXhAg7BXJVDg
	ewsraXQEi7s6klzhN5KkVsiYrjtsvVjTAou7UNMP2VfxwHItNevWpjm/pwtIClth
	rVj0ww==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47psdqcwyj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 06 Jul 2025 14:22:01 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-235196dfc50so21144115ad.1
        for <iommu@lists.linux.dev>; Sun, 06 Jul 2025 07:22:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751811720; x=1752416520;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+LR59wvaFC1B+jtg9kXlIKRe6vvfPELWKIv1ziuV/xg=;
        b=Rfz6sztm9xqQ4BBYOE5j/KoINNy/l6Hq0ZixWSO0wgVFv4zua/nu6ulfYhAeDNiSQA
         3IMWfrzCzOVoZUTMUhSJ1G+nq3DnCWhgzCRP92afEfAZcLbGeOtG4Gt7ZcaNaYKzThU5
         LxgGV/Kjhwz0BFZsg1dcCLA6NGDUO4N/Rmd6jgEf9ziCMBsd6FzBu8oyPC5HltKllSuD
         fjw9LmNFU7fsAIlTJrjfMaLejHXg2vtafRXN1WZkMTyGy0NkRY3hpdqjuU+NaiqOPNTl
         n1GvRfbbGvvUjMn9SBtzjjULALXYNevSoyLQK3kyx/b9ZYB3ES8nK3P2cRtAwlFD6L1r
         OwOw==
X-Gm-Message-State: AOJu0YysLu73yc2n7ciadaP1YKSGB8/DWhnjWMsM77+cqphzKuNTqENE
	MT9VASdR4PyT+gyWt2CVKDEHW9uCfKxO+b4SHkwZeUuTrMsZT9JXDRF1hb+KYoWJsivwK1aAsS8
	lz6tt0IZiqm0WMP7gDnZT5MJ7/mzBozGGhA9SpJeiAoqvlPAdyg4OR8Z4cg==
X-Gm-Gg: ASbGnct8VxFIkbQhdggNgEqNG0BjMhVi5oPjuRSmGJCp/TIhi7Ey90h1C31KUk+hwBL
	JSl5GLgGHAB2QlQTwVDKV3Wx0RegzTJO1TfxxrzI8r5HmyFfWOqzG4w/gZAte9kOTo+YzsRZs8w
	M2+8O+0aOAqLKh2neDcVwIqhHK/WvobdxfZemNwfcgXSbTKKv99EQ+xPTV8Z4o3DrpktCZPQOVV
	W9P2C/zaCwmP9Kiq+8ntdut6nFAYcyrlq40UVqY6BpEYLXp7D9HsO1JQgDRUaF3Sx4/iyrGUrbN
	L0dxUP8rOE9JuBZbc5YUXDGdIl0MOEagAOvJvrVb2w==
X-Received: by 2002:a17:902:c943:b0:221:751f:cfbe with SMTP id d9443c01a7336-23c8595204cmr167337185ad.19.1751811720122;
        Sun, 06 Jul 2025 07:22:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFO93oCbUuKR455AbSvqBvRYCReXzTUnYblW52a/kTh3+cnV2a1b0uxIXTMZ96Ppo2+XoCvjw==
X-Received: by 2002:a17:902:c943:b0:221:751f:cfbe with SMTP id d9443c01a7336-23c8595204cmr167336735ad.19.1751811719650;
        Sun, 06 Jul 2025 07:21:59 -0700 (PDT)
Received: from [192.168.1.5] ([106.222.234.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8431a4c6sm63428015ad.46.2025.07.06.07.21.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Jul 2025 07:21:59 -0700 (PDT)
Message-ID: <c20a9713-6f8d-4c20-a031-dc448404d073@oss.qualcomm.com>
Date: Sun, 6 Jul 2025 19:51:55 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu/arm-smmu: disable PRR on SM8250
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>
References: <20250705-iommu-fix-prr-v2-1-406fecc37cf8@oss.qualcomm.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250705-iommu-fix-prr-v2-1-406fecc37cf8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ffSty1QF c=1 sm=1 tr=0 ts=686a8689 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=D9rl3thw99EfY5kE3N+1UQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=idnX5w4AHIxaUxQtNqEA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: KRSiwWPzWgTUMar0GNdwfZRDyBrnFJcC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA2MDA5MSBTYWx0ZWRfX94YKnVOIbP1L
 IEdRlcbYMPMtqEJ993UfD7bCG0+snZ0bUFbdL2V17iJMsOdWleVCX9OvGHatcgoTvLXokEqH5Dq
 bm/PdZx2hchBusy7x1P+n1HdqvbIu/zYtZZp2H0NF/AFhAzuXQTbmWpeTVuoqLZTK5szJNZUKl6
 +cFYHeZxDUK1DBiYmj34dtftj3V/Z4Dbh8bOhbmYdNX+oNTUIPTHlLVHf16vVjB8MbYki+WCcIb
 SNfGwImXjE9fj4RngWPzkOZ2YlwPMzqc4InFYO4x3AIfes5t11iBqeEfMtQnTP31WVShsZmHRCx
 I0hRiabWik02q9LT6UNxwwdt4RWoUL3etFvEPCXBrfYb/SUQzqB5Q4AhpLvRCAdpiHcIvJXThwO
 qoSdTSTAVAsEnT1Nt5ptvYjtoLjhZjk/za0yCjedIDt2YDYgt5wVvxVoFUs1oWfXpkCN4RJM
X-Proofpoint-GUID: KRSiwWPzWgTUMar0GNdwfZRDyBrnFJcC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_07,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 clxscore=1011 suspectscore=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507060091

On 7/5/2025 9:38 PM, Dmitry Baryshkov wrote:
> On SM8250 / QRB5165-RB5 using PRR bits resets the device, most likely
> because of the hyp limitations. Disable PRR support on that platform.
> 
> Fixes: 7f2ef1bfc758 ("iommu/arm-smmu: Add support for PRR bit setup")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

Unfortunately, there is no way to detect firmware support for PRR safely
from KMD.

-Akhil.

> ---
> I currently don't have access to other devices from these generations.
> It might be necessary to apply the same workaround to other platforms.
> ---
> Changes in v2:
> - Simplify the workaround as the issue seems to be limited to SM8250
>   only (Rob)
> - Link to v1: https://lore.kernel.org/r/20250705-iommu-fix-prr-v1-1-ef725033651c@oss.qualcomm.com
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index 62874b18f6459ad9a8b0542ab81c24e3e745c53d..53d88646476e9f193a6275d9c3ee3d084c215362 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -355,7 +355,8 @@ static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
>  	priv->set_prr_addr = NULL;
>  
>  	if (of_device_is_compatible(np, "qcom,smmu-500") &&
> -			of_device_is_compatible(np, "qcom,adreno-smmu")) {
> +	    !of_device_is_compatible(np, "qcom,sm8250-smmu-500") &&
> +	    of_device_is_compatible(np, "qcom,adreno-smmu")) {
>  		priv->set_prr_bit = qcom_adreno_smmu_set_prr_bit;
>  		priv->set_prr_addr = qcom_adreno_smmu_set_prr_addr;
>  	}
> 
> ---
> base-commit: 7244e36657076b597ac21d118be9c0b0f15fc622
> change-id: 20250705-iommu-fix-prr-600451b1d304
> 
> Best regards,

