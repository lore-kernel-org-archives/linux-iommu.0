Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4186632B9BB
	for <iommu@lists.linux.dev>; Fri,  5 Dec 2025 13:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764941923; cv=none; b=dFZsJ3dhL10+EN1bvsBB5we9RLKh+xDRPfsN+7F1MhRg5o2RgQwrwW3mS4BMd7WNHBm+rlrGYAnampPCDcPAh0YLOrmex3WyPMYxCx6QzoycJge7UkcHzBNNdQ2RmXspP5EkW2TMJECruUf1pA+KhVaKNiQjCCNebjAoygqILZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764941923; c=relaxed/simple;
	bh=sBcOslpNAjhd6z2z+m80mBFdSUn/RE4DONIPfmuaDVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mjHfwNr5SMCzOdZ1+r9db6Dy9Pg9SO+V8QCsQhvhcAhyQPedObFsqc/nilPjatvTWdTQhx3r764JU1Z5qg/bEtvyiyg7bc6GAiobstD9T5GnCdSOmvWHy7iW0G3qnZBaZY58srWFFE7/LPvHRtDnSf5cbeYpCCG5fDxRBcEA2MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EpOL5MBy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MKVnHgR/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EpOL5MBy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MKVnHgR/"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B5AqiiU3172933
	for <iommu@lists.linux.dev>; Fri, 5 Dec 2025 13:38:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nHjHcUcpbDPcu42f9fAzjin0mYkBgXYv8fj2EHzGDfo=; b=EpOL5MByICEk0tuB
	4ZZDm/bGhp+jVum5iJ0D57NRGq5zIx3Xnp1vAFOfnSpPl6fdd9hDiCl6Mv6qpdyk
	FQtj4YjtcTnmnCImNHaKA7ARRELmeXBlEApjWnqxZjr/GwTkfAlHaSDG+Lonyu5+
	imlMSZz6GH6iOwbTrv8CV8YgyGaoj82Qdk97bEjjWJn+vYWHNtPQilsLlkR6khs0
	yVqpccUocQUsQb2d9ivAnCkTthB7kxRpxfsoXmoQNiHGv8wQ6jBOC/VuDsELp8a8
	zKaVXGNwhDPOGg38b4CG9Xy7ZEIeFJg7lmMz15avMB7SZESOE/d7PjT92DF7MX+j
	PNO4JA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4auptqsprx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 05 Dec 2025 13:38:38 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b25c5dc2c3so43985485a.3
        for <iommu@lists.linux.dev>; Fri, 05 Dec 2025 05:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764941918; x=1765546718; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nHjHcUcpbDPcu42f9fAzjin0mYkBgXYv8fj2EHzGDfo=;
        b=MKVnHgR/nOrmB4EwajI8LzOEK7AefSc4ykzwd1oHlkZZn6FYpy1pP06+i3im0yA3cb
         6w+RL0wobOVpnDlL6CfB0oBAaPYq3tikIFYuLbBbAoilB6+EkduJE9rGNvlrwauD3TB8
         VozTv0S5BgYGbAGTZZ4d9N4Yerz603OAU6K579KDsl0J9phSay4jm7zZ6ZRQAmsDs21s
         1atvIlo6jczLOeCTIYA//0uAP2tn5zd46ECR1AFE+I4Rk7CeVp0eAEK90v3k0KEwG6gt
         Z4YHtzCd67+wqfQ6z9WcrBCM9bF5LGSGar5u9RH7C7CqBEq9+0xRhGcCUTK4GDsjiIAL
         j4FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764941918; x=1765546718;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nHjHcUcpbDPcu42f9fAzjin0mYkBgXYv8fj2EHzGDfo=;
        b=X0fUqsOPPkcKHAPvnAA2SLHqQid8nmX7aLWCSHu8/gbJAke6ggBEGcgHfhR5lytLFR
         DGIMMdlL6WXN3cdes3prjL1ZVzC+s5eYr/fJWvM+ZRvYUi4Gq1zGpX/TdNUGqyn+Z9hJ
         OH5SymTHwhAM1spYMcGIrMPbCYKKGU/SUT3W/mPIix/alhKlxIem+/N1it0Sermdrlw2
         2x5k2IEG9rdaWVOBKSN4DuEwnpGIVXMMcdSEowknj/QVTxX6XvLlx0zAT5B031LSnfEI
         cnwKWr1JNC+O+VJhSEsSzCuFlui5t4GjxqukNqZ0NbwXuoqB7K1BA/crj8j1BloOIOss
         PrgA==
X-Gm-Message-State: AOJu0YzLIrgNGP6XPvhAKUwLC1Zkbrs5y1V3dE4lDccikl5z+miVC5hz
	TU4Br1a6bJG8j3ImtR8g4n3G+HcPfkh/rRESSdfKXDT/AHOChrqyBv3epg1+tpFVpJCYM3D9WLD
	cnfJTwer4UfE/HWPjtGqSNPQ4pKCiyBZs7GKuzvn5YOKK8YbAS79hd7I2vw==
X-Gm-Gg: ASbGncsnebLDiiAn3aTAK982Oo9hblAoWILy0kxr5qRzsPjw2o6Nn0yu33Q/ab9FDYe
	W4dDNt4ZE9lC/94b8s/4h+LtzepmuhRbhXczAcNsH0LnRguJ51eFM6xGR+BkJLoUmBCOg18ucoY
	9U1/ERl9BkmtWM1n82qH42i5exjw3Bqhoyt1ru0+zfzmNTOQqnulr1Y3l8ltCb193gZkleH9W9p
	ZDtC4755xlga2odgQVroqS+49AMuA41SCoc46Ge6ATKIQsJ6oYMNiqL6F0/OylhysYkzv6kXUiA
	lQGmHoC4XiAKyKlJwrfBFCo1e5m28Lu5al/PYa4anNf6xVQyYeQbVJRD8qqQ+YJRd71Jhg6ywn+
	MMsszttkZN78nlMFNDusFPnah9SesOVo7HgXoCUXcO9bLWdWR7Ha208+qaArd4s3zPA==
X-Received: by 2002:a05:620a:7009:b0:891:c59a:a9c0 with SMTP id af79cd13be357-8b5e5b14437mr1084706285a.5.1764941917811;
        Fri, 05 Dec 2025 05:38:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGNEButls6SSRF71W1h3BBOmn6wdrkOJxd6jqEIhpxh4Mw9EtC01v8zGvqbJYoZBgBXtUpdQQ==
X-Received: by 2002:a05:620a:7009:b0:891:c59a:a9c0 with SMTP id af79cd13be357-8b5e5b14437mr1084702585a.5.1764941917287;
        Fri, 05 Dec 2025 05:38:37 -0800 (PST)
Received: from [192.168.119.72] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b79f4498865sm377916366b.17.2025.12.05.05.38.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Dec 2025 05:38:35 -0800 (PST)
Message-ID: <95d5d066-0fd0-4fad-bf83-64deae6b5ce0@oss.qualcomm.com>
Date: Fri, 5 Dec 2025 14:38:33 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4] iommu/arm-smmu: add actlr settings for mdss on
 Qualcomm platforms
To: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>,
        robin.clark@oss.qualcomm.com, dmitry.baryshkov@oss.qualcomm.com,
        will@kernel.org, robin.murphy@arm.com, joro@8bytes.org
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251202125447.2102658-1-charan.kalla@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251202125447.2102658-1-charan.kalla@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: lw0HvO6GI9e8nzf_7dmcSDi8sgTlJEyf
X-Proofpoint-ORIG-GUID: lw0HvO6GI9e8nzf_7dmcSDi8sgTlJEyf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA1MDA5NyBTYWx0ZWRfX4pZdwkEaA6uX
 Zc1eQMY4mI20TFn0cO3gg+kqKkY3n7ImftC0gmgG2TBtcBw2cBvyw1XZ3bWCvtQomVbU53DeJV4
 t8tzBGyxv7t1IN3WNtuavdJ0KSYJ5QJmTVTytKWERIF+b+INSSs6d3+o1iXg+EW6q0DXh5X1Ahc
 782eKK1f65ZEssPrjCl1DtDNZ7EFuEqLvpPJiKkmmilzwXF7xRpwdXuOe++EgTqnO8BWgDVkQQw
 S/uDNa0qn/OeFQSRbpbSId/XOcTVfARd5kwB47oMqvVbXf8gkCcMPH86YSkR/cMeaHxQwF8Thm/
 NExmBwypT9zQZvdtzswxUZeCA63rHbFhF5DfxXi5m6MkaBy26Bx/mo6Fv8URStaCYZJmELb49vY
 bnYhiTJeCKZPMfse/6kV72zx/BEIbg==
X-Authority-Analysis: v=2.4 cv=fKQ0HJae c=1 sm=1 tr=0 ts=6932e05e cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=8Kug02PE9PhwNHeq3GEA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_04,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512050097

On 12/2/25 1:54 PM, Charan Teja Kalla wrote:
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
> Signed-off-by: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
> ---
> Changes from V3:
>  1) Add actlr setting for missing sc8180x & sm6115.

Thanks for digging them all up!

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
