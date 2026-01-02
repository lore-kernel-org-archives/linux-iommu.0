Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410432D0C78
	for <iommu@lists.linux.dev>; Fri,  2 Jan 2026 08:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767342226; cv=none; b=F/uZivYq5Y4W3IlPgdqnfmKE+PQEnGZ79d2zDIP/Ako3ajttexb6U77+fQnNiWyoGBRQLeONjGYQYC3ZO9Qxvz3NfetzmycSYY8mJZtVCDXi8VHfGJZwPR5f5eEg0pord2oCPQQIVPIzYI/1S5d9IT3eRiIGD3rHi3eTHR3n+78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767342226; c=relaxed/simple;
	bh=5+LsnwH8Hhj8QpJaydOA1DdFzaIysrTX2p1YgoGdMbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WrktEzgX0VbNLcdlt+aich5xv6lYb0iDWh3qfSXmZ5uLOk/14JPqC9AsOeL82nTfniBH7L/kRUu6+ZMLSjbcs+fgdIFEPIMMpsSB7497jxeu3gPEAT9NDtI8SEtMIsFW1BH9kD4HR68H2siXXxqgQrvTu85+eLlXdOb+zj8CDVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Xn47xScO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PyU6x5ov; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Xn47xScO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PyU6x5ov"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60288K79445626
	for <iommu@lists.linux.dev>; Fri, 2 Jan 2026 08:23:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t19VCHyA+6puRXgRu5jbgBfiRPrElHIT/LgwB7H22yE=; b=Xn47xScOse4BaMa4
	3eH7/6BvMQ8R6J/7Gg1uBR90aEyXUq6qGDaqYfjIVj9HpVDRdA7Ga3I7anvvXfCA
	/MMXARWayfhQUimWgz0NTx0agEjX1TdJ51X1lIMVaoplDgfjS6ubXn531rp4iv5l
	tp0RegtXfAE3QDFRatuGhcWTt4EHywUPXUY8mcZbNUerY1qmjNk9IRlAEqAyXFTW
	4zqyU9aBHmg+oHs9VoT38unhWVA8mp1sk22AIy5gqUWTts/RGH+1lxmEHbaEVEcD
	TYRrAkz+IzkTuxZ2Z93+enFNXEclHjxGKZEToNH7YyogQUIoOfyL5htJDfDZ/99L
	burjCw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bd76nayuv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 02 Jan 2026 08:23:44 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a09845b7faso177265955ad.3
        for <iommu@lists.linux.dev>; Fri, 02 Jan 2026 00:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767342224; x=1767947024; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t19VCHyA+6puRXgRu5jbgBfiRPrElHIT/LgwB7H22yE=;
        b=PyU6x5ov7Bo+4qNzUc7ao/lM5LK0QzHKWCpoVIvW0q0zZvbp92Nkebp4pacHWesNNF
         NG8ySgH0Gz5MhIYlW1QErPsSL60LsFaKVdq3hOEvDrXGbSwriQJxYsGsiL70xuuLboEX
         VO0/SQvtn2nGbw2r5CJo0xYt8kngzEKrOZ13g8BW3tu3nY5Fs0aXJHTDUMoVnJoQpYaQ
         UqK2zRG7nQ894vUzMaYc/i1bvHV8A7qMIoFHfTesoEOcmSjeCnHMaBcx5Bi2cjcqnJbg
         Js7lJBNGEcVEg6mEWzc8ycOdYR3DQ3NgU6uIdc8xq0I9Szlp7MmNocvCuyaXYE0LHkGV
         sQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767342224; x=1767947024;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t19VCHyA+6puRXgRu5jbgBfiRPrElHIT/LgwB7H22yE=;
        b=RpS6yr7rr1JyaIgTGdXgptmyrOt57NTiC2h9+0j8FcY7fFnd6lVt0RgeLyT8hsLkHk
         pfP2z/7mYaR+YQTx6Li6OAsseV1ItLtcmMpiRF12A8ZFgLEBb888CURfQWKHm6mjMRuJ
         F6N8z+dCK2ny27/+hvuDgB+75myfUrHB6z5LF9AOXmKUVPyEegsjkyT5/ZekHuXZJugY
         0ahEYHawh2GAEjntDkA1dxYOASegPC/FoaLw3AlYCpYPx7tlYk+ai2v818pxyj2xkIJb
         U9G4Lq9TVneRv0EQpF8tusH/euF+ZJzHifTS9h/X58jlzaqQUMagSkiNWDaGR5mHGtme
         vvpg==
X-Gm-Message-State: AOJu0YztARmwLd3AJ54FSVuKHVRX9TYdyxfhEYf65MLHMKbDD9TRjjex
	cMPGeFPAxb08DqkZ7uAS5TYvFmQGImEG9GoJVkWfym/iwswEDEOepcu+q0d9IDS91NQYz2b14B7
	NkTTllOz73TZKYuBEDKr45NwGzC1nuqspM1LFo4MrT6wENVU/3oQh1SkWsg==
X-Gm-Gg: AY/fxX6r9fH1pWk8VQmJjfh5755WFlIkdWIsA91Xvd2wGDrwh+T9NL/tYGkjbyCnf+k
	JkhB3QsytZ3qsU4yw4Ts9XxRE1Rclh5yx82keocFWMrHZ2Afi+fE1VtT2mMxy6phpvzKvrFWH8f
	CtxkSbNTKTrREgBswA3KL8EGJ+JSSL6zpIDAuFAbZ3742QH7KOdKCd8OFvBTZSKa7MqXuQJA9eb
	KBAmik1OfV4VFnDLaYs62lQ6GJKbz+io2jeHcImA2owAbo6h05aSASv7Hvv2MtubTIAI1/GKEqt
	z5NKAfvzMvzGXY0r/Wl5OYmh6dEeMmVV2OuvqZTCyYhmoDcw5Wx9bIcQa/XiJRUU9jsKS1UvDaj
	Vv7mBGPrPTxEpAJ3aH1CUWV5LmW92FOLZNrKu
X-Received: by 2002:a17:903:2306:b0:295:fe17:83e with SMTP id d9443c01a7336-2a2f221ed26mr358799105ad.19.1767342223562;
        Fri, 02 Jan 2026 00:23:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOi+SxzktmVPKzdXAl+fgvR8EFyDqnt9n30EmQADNghpbS6vilTLEme0CFoPHjOzlb7lzAjg==
X-Received: by 2002:a17:903:2306:b0:295:fe17:83e with SMTP id d9443c01a7336-2a2f221ed26mr358798825ad.19.1767342222783;
        Fri, 02 Jan 2026 00:23:42 -0800 (PST)
Received: from [10.219.57.14] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d5ddedsm365065375ad.79.2026.01.02.00.23.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jan 2026 00:23:42 -0800 (PST)
Message-ID: <e0ba7db5-a64f-4845-9d12-fe66d1d5d575@oss.qualcomm.com>
Date: Fri, 2 Jan 2026 13:53:36 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] iommu/arm-smmu-qcom: add actlr settings for mdss on
 Qualcomm platforms
To: konrad.dybcio@oss.qualcomm.com, robin.clark@oss.qualcomm.com,
        dmitry.baryshkov@oss.qualcomm.com, will@kernel.org,
        robin.murphy@arm.com, joro@8bytes.org,
        Bjorn Andersson <andersson@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
References: <20251209052323.1133495-1-bibek.patro@oss.qualcomm.com>
Content-Language: en-US
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
In-Reply-To: <20251209052323.1133495-1-bibek.patro@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAyMDA3NyBTYWx0ZWRfX5+DJ5MTzwzYv
 uzBmXkT86Lxf8qvBTlwVEoHYmI/At3/mKcsdzlUz0pAvWSU7dJNo4fRbsrLt/3Mmqg9vXxDjcVg
 U/kpclAQTGk5pjq4djZBo4p4EHEYDQSL+XPrrC384smd4BBwEg8/58R1FcbTzAR1DpreELb2Eu9
 XCCDJk835XdkQNe+bIHsiwXPh6bYJy1Qi3hDCfCQyXaPQW+MaYuqbTXJpNfY4PTY59Cc7deNG5H
 XeRE/XhJE5J7ACNq4quPX6Xhp2M7GNtuY9YgQ5jVt+5FBAbxAggygElxRqwulvfGqYdktrYXRz4
 FfPT4yb37Rgq0czd9YxJhPYOtsBU3nMcOKQ41jBmaUnniYRawkTQiir7SjBNjSekC4UmQcSDuxD
 /XIVTAvMhprl74+alPy+xD8Yl5zDYlw40auipjLs2NPKvnYdzzH+u9/qLUvwwqyM6iMLU/6Ni2z
 U/BldojP7pdiHwnBs5Q==
X-Proofpoint-ORIG-GUID: nMBzpgygnP9GDKXFoEKBsd440JHjKMkB
X-Authority-Analysis: v=2.4 cv=TdmbdBQh c=1 sm=1 tr=0 ts=69578090 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=IbTvDgxCcU_WzWRXJZAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: nMBzpgygnP9GDKXFoEKBsd440JHjKMkB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-01_07,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601020077

Hi all,

Resurfacing this patch in case it was overlooked due to the holidays and 
Plumbers.
As per Dmitry’s suggestion [1] , I’m sharing the v5 revision, which 
incorporates Bjorn’s feedback on v4.

[1]: 
https://lore.kernel.org/all/CAO9ioeW0fafwRnxvDJ7yHGcQYbgfkfRF1BMTpXpG=8tSKRptdw@mail.gmail.com/#t

Thanks & regards,
Bibek

On 12/9/2025 10:53 AM, bibek.patro@oss.qualcomm.com wrote:
> From: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
> 
> Add ACTLR settings for missing MDSS devices on Qualcomm platforms.
> 
> These are QoS settings and are specific to per SoC thus different
> settings, eg: some have shallow prefetch while others have no
> prefetch.
> 
> Aswell, this prefetch feature is not implemented for all the
> platforms, capturing to those are implemented to the best of my
> knowledge.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
> ---
> Changes from V4:
>   1) Change subject prefix to "iommu/arm-smmu-qcom:"
>   based on the changes. -- Bjorn
> https://lore.kernel.org/all/20251202125447.2102658-1-charan.kalla@oss.qualcomm.com/
> 
> Changes from V3:
>   1) Add actlr setting for missing sc8180x & sm6115.
>   2) Improved commit message.
> https://lore.kernel.org/all/20251124171030.323989-1-charan.kalla@oss.qualcomm.com/
> 
> Changes from V2:
>   1) Add actlr settings for all the mdss devices on Qualcomm platforms.
>   2) Improved the commit message that explain why different ACTLR
>      settings
> https://lore.kernel.org/lkml/20251118171822.3539062-1-charan.kalla@oss.qualcomm.com/#t
> 
> Changes from V1:
>    1) Added actlr setting only for MDSS and dropped for fastrpc. --
> konrad
>    2) ACTLR table is updated per alphanumeric order -- konrad
>    https://lore.kernel.org/all/20251105075307.1658329-1-charan.kalla@oss.qualcomm.com/
> 
>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 26 ++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index 57c097e87613..c6645df97bbc 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -41,12 +41,38 @@ static const struct of_device_id qcom_smmu_actlr_client_of_match[] = {
>   			.data = (const void *) (PREFETCH_DEEP | CPRE | CMTLB) },
>   	{ .compatible = "qcom,fastrpc",
>   			.data = (const void *) (PREFETCH_DEEP | CPRE | CMTLB) },
> +	{ .compatible = "qcom,qcm2290-mdss",
> +			.data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
>   	{ .compatible = "qcom,sc7280-mdss",
>   			.data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
>   	{ .compatible = "qcom,sc7280-venus",
>   			.data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
> +	{ .compatible = "qcom,sc8180x-mdss",
> +			.data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
> +	{ .compatible = "qcom,sc8280xp-mdss",
> +			.data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
> +	{ .compatible = "qcom,sm6115-mdss",
> +			.data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
> +	{ .compatible = "qcom,sm6125-mdss",
> +			.data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
> +	{ .compatible = "qcom,sm6350-mdss",
> +			.data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
> +	{ .compatible = "qcom,sm8150-mdss",
> +			.data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
> +	{ .compatible = "qcom,sm8250-mdss",
> +			.data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
> +	{ .compatible = "qcom,sm8350-mdss",
> +			.data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
> +	{ .compatible = "qcom,sm8450-mdss",
> +			.data = (const void *) (PREFETCH_DEFAULT | CMTLB) },
>   	{ .compatible = "qcom,sm8550-mdss",
>   			.data = (const void *) (PREFETCH_DEFAULT | CMTLB) },
> +	{ .compatible = "qcom,sm8650-mdss",
> +			.data = (const void *) (PREFETCH_DEFAULT | CMTLB) },
> +	{ .compatible = "qcom,sm8750-mdss",
> +			.data = (const void *) (PREFETCH_DEFAULT | CMTLB) },
> +	{ .compatible = "qcom,x1e80100-mdss",
> +			.data = (const void *) (PREFETCH_DEFAULT | CMTLB) },
>   	{ }
>   };
>   

