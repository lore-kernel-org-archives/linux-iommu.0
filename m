Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D7727EFFA
	for <iommu@lists.linux.dev>; Tue, 11 Nov 2025 07:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762847784; cv=none; b=DgIrC2GWLI1oxyk6RJdWFELyioyQad0L4lX5ByRG5AN6Lzt0443X05WIT/kKHPh2KDr0uu/ljpUt1ZkWNk9BqSUPsFpkuIu5c2sXzfjdSi6zh6x5u/koEC45Wr14jFCmSzlgKfjv3Ei1y1svfk5KqmE7HqrhqwdnucH+Cl3BVjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762847784; c=relaxed/simple;
	bh=J9dHV+srVdCfKZ5lu2pApTYLFYdNVofhwohGyFX+2uk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TsvnzH7ozXJoykVIfInlIuUCrj+N2Nf90T0q2J8chcUwG0TK8CvzF5xq9Nq2UZ64S20z+zwZpAsCzHzvmU8YJCjAv68Mj6O9MlTM98LhvOm9dmbLmoU1BAks2C2xfCQwX5GNxT1xbE4cYwnvtm41oNG4jla6HXUiG/M46y4Huyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dGini1GH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HxvSz7Ge; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dGini1GH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HxvSz7Ge"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AB7FPx5411227
	for <iommu@lists.linux.dev>; Tue, 11 Nov 2025 07:56:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9goTM/XMiiNX86aLJBJ8fJF1NxfmrSk55ouvKAkbHtc=; b=dGini1GHVtbvFhXN
	MA2eDCyeQ+fpiiBRaF6XXD4lSAnejs6QZlN4xGYbzweuC3TWIXE2ZADR8NchmrVe
	K2Cq4t7KmqkcAo4HMFXZL4zqo7oSVVbORLv/IGBPDkDjPulbMK43/BOSNk0bYlDl
	F+C4fNonshs42PPEWlnX3i1T+FVH9tiEH82gJbuo01+Gndn1uxDv5AKlLAx81Q+b
	I9XcvsRg94cyIqfT/afxLZ96ONeq5XVSwyVPQIWU1bEs09U6GyDLVCIAKk6gHbmB
	QLr0Ev4MrH5NGPxfvA0ZxI3eY3t1DYUY1oFaGqcNtlA64p9tiIRWhWrzw/k5T4Mg
	duVNwQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abppu1m46-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 11 Nov 2025 07:56:20 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-29806c42760so55722005ad.2
        for <iommu@lists.linux.dev>; Mon, 10 Nov 2025 23:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762847780; x=1763452580; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9goTM/XMiiNX86aLJBJ8fJF1NxfmrSk55ouvKAkbHtc=;
        b=HxvSz7Ge0/ItPThsNQZnQPHhwILb/OKjk4xUpfaJ2xD5JEBOUFY5+Sz+oXrNPUL1OT
         T/L3/eYckQIvTt3jnlhiwS7ZaqXpEeqtuHrrjTay6Un0f2E3jsFUlDygP2IsQZg1fvgG
         GhTL6cBe+cVyWLhgo9bwDdpkONMVrtOLrcGll+zYPIPWOT5OL3ERCgnu7kufvb7ZKAMQ
         1/37ccF/LeUkvjeexoSIRCVMTs4/G0W9cUXY8r1pcGHxSucWbuppJOm83tRukJw4zyeW
         zTyiJcmkfzk+MsXo6okvtuXxniD5h1YmYRsvTL8Lp1TVTMH969Y4TI4CmEutpbjr8vAL
         NIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762847780; x=1763452580;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9goTM/XMiiNX86aLJBJ8fJF1NxfmrSk55ouvKAkbHtc=;
        b=vie25khiLc1JrCO9WhQsY0QhiOfc/cgPKnCIGpXUJYiCAHNC4Jqiyg8y8Y8+eu//Vw
         cTT/ehhDzSPeRSz+J8DoHZX26bNbPPv2z1fGr/Erjgt0k6qQveV3vsParHzbHEmer/7r
         HGNql8gI+3mcnuMu1Ib3BzFJuXodiV2uULro0//0uYpbR8OTYtBQ6zxuWKHlhKAkc3Q3
         LZYhpNz5h7unX5kOUhfHPYgGZ86da1aO5W3YYSFymoJNzuUXt1vAxoSrEmhzdIIU4Abg
         t+rhkHwIcA0HZV3xrqowISsPwewKr2EiqbKZK5tJTYHkZyD2d9LkH8D453TqmUrxCyvi
         rKxg==
X-Gm-Message-State: AOJu0YxPkAwzSfRagVb3WApnmmhO3Gb6UXwSw9u/6oI4NvXVpYysmj5L
	dnYO3CDzbhho4+0+dhEI6ezN5TP07YxM1n8AFc5aTnkmNWnRZlED34yKxUrR/zUbYwOAOIovY3A
	Z3qciGPEIIG1uDjRauXfxf/tkBrrjj4CNRs4bJZp2ZvEuSGCkI8aKYvTjcg==
X-Gm-Gg: ASbGncsyj/s8hznzyx8sVLCiW/2KllScd7HJDEMYpzt8Rf0YlqyLvhkuMDjZxxHdL0v
	wqQE1lhLOQmsrThgx3UDka2iFE3gWOA9LwuPeJYbP8O1W6ydQfFQc6zt6FJd/xUNjAA93s52w/K
	+iq3LS8+StcAUNiIzJMedBQBXhnxRo+zJ/1bYtk04dQCNM28z6skYOuarXcAbRG+4gccADEsKjn
	jErbMpeNiWL/NYFNFkIY9y1EjXneZGxzyW/Xz0HvpkdV+K0lcCZPy+7ByPNu8X4wgdtGKr2qXwc
	typU3zewNtH2I2YrVzxwCIFDvtZZGmzL9WLNWAygzyn9EPeArtBFlRTDey2vTdKOuJ9F9m7ym1m
	XJq5fLLpuCOHr5WxqVzZd07Sl20A=
X-Received: by 2002:a17:902:f64f:b0:298:1156:acd5 with SMTP id d9443c01a7336-2981156ad51mr97475535ad.39.1762847779859;
        Mon, 10 Nov 2025 23:56:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6hrGKFsEODF67hPKuu/GXPSRhYuLLhxF+PyTk/xwREJ4g4uK32OyhVOg7l+TWL2LTnadutw==
X-Received: by 2002:a17:902:f64f:b0:298:1156:acd5 with SMTP id d9443c01a7336-2981156ad51mr97475195ad.39.1762847779368;
        Mon, 10 Nov 2025 23:56:19 -0800 (PST)
Received: from [10.219.56.14] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5c6b3sm169109865ad.24.2025.11.10.23.56.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 23:56:18 -0800 (PST)
Message-ID: <fbd49b9e-5198-4825-a601-cf2b446f1150@oss.qualcomm.com>
Date: Tue, 11 Nov 2025 13:26:13 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/arm-smmu: add actlr settings for mdss and fastrpc
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        robin.clark@oss.qualcomm.com, will@kernel.org, robin.murphy@arm.com,
        joro@8bytes.org, dmitry.baryshkov@oss.qualcomm.com
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251105075307.1658329-1-charan.kalla@oss.qualcomm.com>
 <eb596f7a-e13b-4edd-8ee7-05424ea3d9e5@oss.qualcomm.com>
Content-Language: en-US
From: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
In-Reply-To: <eb596f7a-e13b-4edd-8ee7-05424ea3d9e5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=TNVIilla c=1 sm=1 tr=0 ts=6912ec24 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=K3xFcsKITfcsgejFPk0A:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: uVr3eEuyGSNe_SonQHsp51yQhKQdHXKb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDA2MSBTYWx0ZWRfXz62CCPhlTNW/
 NfL/1pOeAYt2PqtlGY3Njp2OlaumI4tU4MTNTsFxm27tHahDe53XZnCYechabwdZkCXGkVXSbIp
 dCFtHjrhQBT3WFYyeSC2fVybtZQq/nbonwpL6NDQfnjU4pP0VjpFjq4X8TWzhF9rGAYW3OdfaUv
 nldBN+gaGE9dIXt2VauywJU3pKvf0aZSzEzM36JQNdUip7dMUGmZhrhDe9x2D01vfVkwB9+09/E
 7ihR+Fqck7GoUpa3JPz+2vwZAGcd5ZPTjRVCd4CPyR3U+WNpp72lplng75Q/sS8pVsX0DRhTVP3
 PxdC3VdaXgECEa+w3R79RCarxqfNsxbDwhkxcj502Sz4yxCiVKT0RQ03SZ50ZiHUG9Jze9ixFYr
 DhE4lswr6Y/VqTvg2tkU+nBp1Ob6XA==
X-Proofpoint-GUID: uVr3eEuyGSNe_SonQHsp51yQhKQdHXKb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_01,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 phishscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511110061



On 11/5/2025 2:44 PM, Konrad Dybcio wrote:
>> Add ACTLR settings for the device nodes with below compatibility
>> and is mainly targeted for sa8775p:
> The commit subject should mention it's the lemans MDSS specifically
>> 1) sa8775p-mdss
>> 2) qcom,fastrpc-compute-cb
>>
>> As a side note, "qcom,fastrpc" compatibility is already defined but that
>> seems inept as the devices that will be attached to the SMMU is going to
>> be with "qcom,fastrpc-compute-cb" compat string.
> If you say it's a NOP after all, please split the fastrpc change into
> a separate commit explaining the issue and removing the wrong entry
> 
>> Signed-off-by: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
>> ---
>>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> index c21a401c71eb..c76f6076f487 100644
>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> @@ -47,6 +47,10 @@ static const struct of_device_id qcom_smmu_actlr_client_of_match[] = {
>>  			.data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
>>  	{ .compatible = "qcom,sm8550-mdss",
>>  			.data = (const void *) (PREFETCH_DEFAULT | CMTLB) },
>> +	{ .compatible = "qcom,sa8775p-mdss",
>> +			.data = (const void *) (PREFETCH_DEFAULT | CMTLB) },
> This list should be sorted alphanumerically
> 
>> +	{ .compatible = "qcom,fastrpc-compute-cb",
>> +			.data = (const void *) (PREFETCH_DEEP | CPRE | CMTLB) },
> This will be globally applied to all smmu-v2 targets with fastrpc,
> starting from MSM8996 ending at Kaanapali and everything inbetween
> 
> Are these settings always valid?
Let me separate out patches for mdss and w/ more details for fastrpc.

Thanks,
Charan

