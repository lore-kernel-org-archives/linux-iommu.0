Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3218A2FDC42
	for <iommu@lists.linux.dev>; Wed,  5 Nov 2025 09:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762334083; cv=none; b=iXAGsvncPWR6CTd548VLIsZA9PXWsVQ5JiBRMQNe5Yx0fs2ffBCahDsrd1gJX0wF/Q4j/nk/hbOBdvM1kiOJekdKpLcJOnTUKC5rdVL1KtiALsbo6+3iS/p9SuT3Zttg8It7raSWPxAayE9xeBLy9FJruc9wFr1V2dfsjp02yGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762334083; c=relaxed/simple;
	bh=/f6gnPiDQVtkReGCpJUIX4l9kppjz5w+Ypzn6fBJGf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SkXLw5ao47Wt9X+PGxPgkG8LA89j/Z8EueT6669uD1fyqSqhZHMXemUV9P4KUXwXOjFJvsksH0lDbvXwfB7MCKbj7Hl/mYAzHbKgPdJ4IyAf3Dl1VFpkISQbcJ+g5GXseRYszIunq4PqqBr5kd/khtyxDwphb+TGMNBwcjkhjtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IpLjVI8G; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FdymuQNq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IpLjVI8G";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FdymuQNq"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A58Lesw3114829
	for <iommu@lists.linux.dev>; Wed, 5 Nov 2025 09:14:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zB4b3sxSbheBbYOZ0Cg6VV5suwUnxR1Yw3auDzIvZZ0=; b=IpLjVI8GlPRF17Za
	O7tBG1lFcNCsHn51PdUDeedvuu/9c2CLlvdcE/knaIfIGIXhHjrP78xQ/F8KXCOM
	NoFgnrJTXncR+jRs5DxdvY8zbm/GEnwahoOQbBQPbLGClndwEwlpp4inbAhp2uaQ
	5IYHfJkq2I5k2BiioF/A2/HnOfSYhn0G+vI6cAc5nIQF9BMGiieHiwSdiSN74yIw
	BDwY3Gc30Sr9gkQZxx0Zn6iyw82MM5BBfkbDFB31JgPRrjoThzThGvsB6VqGvi7x
	I+EprkI6CqAkyxbiJLbsmkog2BSG6FahM8N2v51IQ+JeBw7CrA3SVBU/zj/E2bMO
	vaxtrw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7sfdsqb4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 05 Nov 2025 09:14:41 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4e8b86d977fso27496301cf.1
        for <iommu@lists.linux.dev>; Wed, 05 Nov 2025 01:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762334080; x=1762938880; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zB4b3sxSbheBbYOZ0Cg6VV5suwUnxR1Yw3auDzIvZZ0=;
        b=FdymuQNqpHmeCsFEo7DjBOdwxP7vB49TToPkX8DXrlaAIYNBqii9Ax9hoL6kdqLs0l
         2xNaWlLdX5pXjleAtEbYDLJCyjOJG7HJ6gBmamVOe5seARLE02Auy8AqMNXET6IzheXK
         vnfpmHOamWXDWkAv3hvqAeCcg2kMD/MyZA+jF/e7fUXHQCX3KVrAafY9GXJV9dNJJ2f2
         3cLr5BWYhiWskwRHP4ZsVFMKcMKQitSmHPKu9A4OS7Vcu7GXfdx7iwnqd6DXaYCuzrAs
         8Rod7+t/VCoJrEIH6cnMOgtvBsMlPj3zeS+qhq4Qdkr67ee0iH7a3l+IR/R4Vefj7jGP
         4tZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762334080; x=1762938880;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zB4b3sxSbheBbYOZ0Cg6VV5suwUnxR1Yw3auDzIvZZ0=;
        b=Uhm7SEAW2+YWMGCPfnvgfb7yh5piUDwVEc0Bpl005AMgd8oWrK+gs2nf+qSY2AA2dq
         usCU6eaCxv/WPvXwoUMfy+l2eFVWfIzpBMHf6xXtzsMcFD9ikt2frdh7uhKw8GdV4Tpd
         ghxJdjrWMIts0TVkOZ62sMkU34TTweMQzpB0obB+4rrWwLHMm3+LeosVtATXtnDH6CAU
         /J4NtckkPynyfyirhaIaTvLhR9o/fhOVQJ79dGGS8Gppu7fc6pYPhxXUcbeIwk+z+cHl
         Emfg6v5ioqP3oYBDsIScyh+W/RYJd4vQ2Xz98XxLP6ppGR6A1c9R5JgZ35qW8fvmpbnP
         9bnA==
X-Gm-Message-State: AOJu0YwpDQuoGXnWjBz/fWeYeYTUmodeWVuH4EpIY4vj9iTVqK1A2PPE
	vTsOUl5MlCBzRqvpe/2HZ/pDWWgUOLTkBK94xN4bwcFvlTU8KX/dWP8Q2NmsrUmQ/sp39mdHvFx
	GHkHlbkieov4q3QQmgBGhM/O5372kt0T7RP7je2NDVkwuzI9fBsTFUFd12w==
X-Gm-Gg: ASbGnct5uIflnfEbYl7rNghke8UHQ9X9r589KW2tZP988IatcMdNeBLaC0m9n3FFaTb
	lKtLdEE9gEGmW6ooAYLXk2d1ZnG6nxqfDz9/QluY+i+T6dAdejgnMGoPAg4uoDfVbDnHK8mn2ee
	cq2c1GTpA/tuYXIfsiC98gkDOjwlNjgE9+owHCN0vp09dJuI3tFAEsn6FRF3NKybZiV2bxxZtZM
	D1lpvWeggTWlecxIKs0di2j/3z69L35G4kGdaxF8om9R9fkJB9Et2onDZi/C8HWOhXeDq8MiEt4
	UdxmguEtikGDh20B+FP0f/QgIGXQ3xpI//ROUHwZtcMjEz+TCIpnkDLU75Qw8IGgVlE/POkLMFl
	s7Ab0r+rpzy9rE7AybO4XlnjlfFNbFFm3LbxPY7C+H4kbMiMirj+QUDlJ
X-Received: by 2002:a05:622a:306:b0:4ed:70bd:d9e2 with SMTP id d75a77b69052e-4ed71b0c0bemr20671671cf.0.1762334080456;
        Wed, 05 Nov 2025 01:14:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmtSI3CAHA+k1D8XrOBNP1lVPWy2EaQ/BbbivT/VBaf8u+Sr4kLRQ8RzgcFfgQj/lftw8C6Q==
X-Received: by 2002:a05:622a:306:b0:4ed:70bd:d9e2 with SMTP id d75a77b69052e-4ed71b0c0bemr20671501cf.0.1762334079984;
        Wed, 05 Nov 2025 01:14:39 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723f6e06e2sm456019866b.40.2025.11.05.01.14.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 01:14:39 -0800 (PST)
Message-ID: <eb596f7a-e13b-4edd-8ee7-05424ea3d9e5@oss.qualcomm.com>
Date: Wed, 5 Nov 2025 10:14:37 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/arm-smmu: add actlr settings for mdss and fastrpc
To: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>,
        robin.clark@oss.qualcomm.com, will@kernel.org, robin.murphy@arm.com,
        joro@8bytes.org, dmitry.baryshkov@oss.qualcomm.com
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251105075307.1658329-1-charan.kalla@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251105075307.1658329-1-charan.kalla@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 7KJtrLncEzAKLW1RGoOpyrQAEiP2shX8
X-Authority-Analysis: v=2.4 cv=MMFtWcZl c=1 sm=1 tr=0 ts=690b1581 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=LtfW4vqWST33oogqdjEA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: 7KJtrLncEzAKLW1RGoOpyrQAEiP2shX8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDA2OCBTYWx0ZWRfX5llfIiS4uCkU
 afVAeEbqxt0/huf/3oOJ4u/nep6ZTbt5O97Yz8C2a9vwdzkSrUZbVVypIC7PUiW+mjLoCSLoIVF
 L+/t7V+opI3036Omcje1PFSDsAwZ0FfNvYR9SYY22eo/5QdEwN7KpeGF0C1EVLBIpsAHu4d67ha
 /sDuRO2zy9iKdKyz0v6MNHR2IlFXtKUxh7g1582hdhMMKmagIuE0TjKCMTCFSmNQH1khWJBzUPJ
 oznrXwciJJsfqA2Q61oAxneKahv2BbFbb0LjCL9P+PnbU2HQsNT7doUcMdosQ53lZgTUs1M7JsC
 Tu95/OEkDalZpMEaWiDI1Cb6aAE750OSWiQ7vTJovH/xV1i64a36j/nVIvEPMeoqBySUWKqQBkg
 5VhvEiLKKKNcdDry1/Ybd53x6QxMjA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_03,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511050068

On 11/5/25 8:53 AM, Charan Teja Kalla wrote:
> Add ACTLR settings for the device nodes with below compatibility
> and is mainly targeted for sa8775p:

The commit subject should mention it's the lemans MDSS specifically
> 1) sa8775p-mdss
> 2) qcom,fastrpc-compute-cb
> 
> As a side note, "qcom,fastrpc" compatibility is already defined but that
> seems inept as the devices that will be attached to the SMMU is going to
> be with "qcom,fastrpc-compute-cb" compat string.

If you say it's a NOP after all, please split the fastrpc change into
a separate commit explaining the issue and removing the wrong entry

> Signed-off-by: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index c21a401c71eb..c76f6076f487 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -47,6 +47,10 @@ static const struct of_device_id qcom_smmu_actlr_client_of_match[] = {
>  			.data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
>  	{ .compatible = "qcom,sm8550-mdss",
>  			.data = (const void *) (PREFETCH_DEFAULT | CMTLB) },
> +	{ .compatible = "qcom,sa8775p-mdss",
> +			.data = (const void *) (PREFETCH_DEFAULT | CMTLB) },

This list should be sorted alphanumerically

> +	{ .compatible = "qcom,fastrpc-compute-cb",
> +			.data = (const void *) (PREFETCH_DEEP | CPRE | CMTLB) },

This will be globally applied to all smmu-v2 targets with fastrpc,
starting from MSM8996 ending at Kaanapali and everything inbetween

Are these settings always valid?

Konrad
