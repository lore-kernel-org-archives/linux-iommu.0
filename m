Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1E030E821
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 16:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782231358; cv=none; b=qnGY62tqb8G9HGdfOIYHBEMrdEdh2qznGfffHtuZJCWycRx9MgPVrYYLYTBJZfQigXkK3mPNmF6oPt0fV2p0T1AmqNAcHNm4yy+7LRUCpS5I6MpbS/K1XG6k6h4++lpa+gXRK648QGBHmXlYFipo2Y5b7hdyxpDCc69XlXGPFlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782231358; c=relaxed/simple;
	bh=1mgKP/Cw+MYtYWfmknl77kCg0msl/90xn98lTJ0CA2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RmUprV0eX3GffZ60GOaxgK/cmARSLpW3X7MLZR9BJ3/zFZtj/mba/76SOilHuxn4LSq6fz5Wv+X0ZzKXcCYNjDGeNzByKIMRe3nD42VzqqNbO2+9SW7cajYP6QHj/xl14cwz7/g+DYbzQ//3/jvMw1AYpzGQt5KMUJ4xTCewW1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k9Exqu5/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eNUvT3cY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k9Exqu5/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eNUvT3cY"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBYk2K113501
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 16:15:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JpnShpDWp6cKrywbsJbMpIC2QEMS239oypSj5Z4wF1s=; b=k9Exqu5/dgqKDN1c
	cB/qWC7gXYZY79XSWQifRRTftMGDZWWodL3n24TIuGE5VrtYC2Q7lZirZg+DbP4y
	5fzS0mRaKjCWKkOzyuTOyobPy2nn3CcFHwbqBqCiHUc+ftv1/z/3u6RXEV2J73nI
	jPpWYoo1PyYSHH1r1gSOU+DTPwD3XMDjIPchrFsEGOTw/zUH/53B3uU3NV32JfZz
	Pfc9qL6KBPz1ihpvz1ysvEKiDMrq7UY/Ku4aGnXHRzMaMt9kYEqk7lc8We/GySg3
	2eTPffuOqrJ/7vGKOiBfVcTK4gt8TY2Yz6pGxFSpb6c2sn++q3dJIuLD97Lez24S
	o8MkyQ==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eymnvtfhd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 16:15:51 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7e6027a5761so12742a34.3
        for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 09:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782231351; x=1782836151; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JpnShpDWp6cKrywbsJbMpIC2QEMS239oypSj5Z4wF1s=;
        b=eNUvT3cYZVWEi7cWf6PKD4LHzcxcBSxnkeTcdXEkJzFLFm9AmYGrDkMkv3qvHqdRAR
         GrYXx0wL4x0UhatOYhOln+n3hO/NvkkEMoKm7mOuClAs3qlTQ1akxeddTHIeHxkImQx2
         G+dvV8kpczW7m5N6HsWyeUdRRmMuGk/oyPjfRBX0BVjdhYWsUlF0SOzCAZciaodnkkzj
         9SPyq2vPIsodvcj1C+z96ZM33i23LqogNNjBkCu9b/rpsrAxt7pqPwpKj1ALH1qmtlMt
         EFg5qOH0TqC8mbzeVXLsrpKx8VhG1B449IaO2ImGqH12TGVY2bkqpB5Ue/qIylLqSgUM
         XLLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782231351; x=1782836151;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JpnShpDWp6cKrywbsJbMpIC2QEMS239oypSj5Z4wF1s=;
        b=Wm0SyJn4G5Ib8nIB41zzSHEEEHeBDkvHpNtK7uFw5y02ucqgmCM9B/SGyZZJ65P6kj
         6aC0WoHRjlZfw/kUJrRP9VAy7x/fRTxYZN0LdjiKMFp7UG002Ia1fCGBuy+r7qJ1Nvb1
         xv5aA+tLlCoE14Ly0C5Rnf2nL+eIt7klqAOWdBBtdxlxg9VwPVoeAEI53p0EzjKIjDrj
         9xEwbxtyjaWR2/9TrQefHW+KSdEVI63I/9Y4X9yctH2P/hrUsz+SClfF5hQi1rv2ZW3g
         lwOiBev/T/eG4Oh/QFsFVqBLN2sggCkf3QZeNEOixcV5iITf3Bb62UwO2RkpAC0mgjAA
         /uoA==
X-Forwarded-Encrypted: i=1; AFNElJ+r6+l4GcJQPRVJiv5RulOyJ+yJ2PYfxPBmOesVPzMxLRPWJQCmSziTB3gACSOznU5PclqjOQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy9tulGhW30Hy7KU9I3wk4jNzuYvp+BuErCX4AsCnxPHkggA9JS
	8YKweoYAKYDtTGuAXUiC5Z9xdtAHd1+IMlscPoTmtYQtluOCNmEtckvF2nocCw9sgEihthGZ5RW
	LA+5BInfi0smHuxdFMhCESz8jqWIYkMIM4CmkJDv2VGEQ6oi1nA1AorbLYw==
X-Gm-Gg: AfdE7ckcAZqR1z4jR5ckLJc+MtHu0zYkizhkZG90u3rSjJea4Nu9YvcWVp2tEAIcmDv
	XyMffxIz5WxOZS+zFoLmCJJ1ujE1sUR7jlwPPsCJ6uztJyAOBjAi+w0jzvX6NcusfB2XzvfPRBB
	99597RlZNA/5s2h2/Y1REd+99NHT1W7Tf1GcT3EVacyOdEKlnpngJpK2UHQJ7BuAcbmWBxbHZ09
	785e9C+oalFWV3X2U0P/x9hfjY9VN5TcxI4p291QMl4DMO31aO9jjAZx2DwqBtkblPNu0s1CNDl
	B00K1u6jI9tj/c8wwPiiJxZobRUPtRC9hCCBfhEqStWp53WJ/77zwUdlWvaL8blBrek44RKIcD5
	+Glnm0LjGrkpD6kXrOq6fAEnBSvmmPAaNSlw=
X-Received: by 2002:a05:6830:6d17:b0:7e5:f49b:35b9 with SMTP id 46e09a7af769-7e97084dac5mr2813272a34.0.1782231350926;
        Tue, 23 Jun 2026 09:15:50 -0700 (PDT)
X-Received: by 2002:a05:6830:6d17:b0:7e5:f49b:35b9 with SMTP id 46e09a7af769-7e97084dac5mr2813248a34.0.1782231350491;
        Tue, 23 Jun 2026 09:15:50 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6977b856f92sm4762756a12.11.2026.06.23.09.15.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 09:15:48 -0700 (PDT)
Message-ID: <13ebe945-8e7b-490b-890c-27f775ed6f9b@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 18:15:45 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] iommu/qcom: Publish pgtbl_ops before releasing
 init_mutex
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Will Deacon <will@kernel.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20260623122034.1166295-1-mukesh.ojha@oss.qualcomm.com>
 <20260623122034.1166295-6-mukesh.ojha@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260623122034.1166295-6-mukesh.ojha@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dOWWXuZb c=1 sm=1 tr=0 ts=6a3ab137 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=gOOtitiCZwdyowkBYvIA:9 a=QEXdDO2ut3YA:10
 a=EXS-LbY8YePsIyqnH6vw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDEzMyBTYWx0ZWRfX6kD9g0OZVp0n
 6UCUTLO4dnM0a0+q7ERPmr8TAN93f/029cGRcOwPPpqRbz3tLU9o73k4l7wSYX8kL2h0yYMctc8
 6JfuTrgUcAUmpYFhS2QEpPDt93dkWv4=
X-Proofpoint-ORIG-GUID: ffjd2GJcq0ggSIEukoi4rDA4niRPLtqY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDEzMyBTYWx0ZWRfX4ET/pnbSm/60
 026C/NUJIxb1jz0M/BR0ftkC717ypGMl1Aw3OtfA4DTSybDIjsMa1VTR8U1SnxbMCNrpf+MxMLd
 Ls2Thy7mWRRVJHP9cn5UxEzN2O5RIEqOr+K5BV4hQZcWcQOJ+vGbH4PsdYUG1w3drcmpIPu4wmx
 tCmNAO2safNoWzdgTfzWm/7COioYQOCPiHxj1oO5IJkzfnxnfGLkc//ZXkn1FJKNI6c4xSO0T7u
 8fmUblYEr9az4Q3dey2KB1XM6nUSORiRExyGuQmphTmuRpp5nXs4Uvok4I58psrHhG+unSl9SXf
 c3+vKI16OhjaKfDnAAlYQM5xFNwgn6ANkXTcSa2ZdSftw4EPWma+YX5p/p1HZR0AREqabTH92iT
 Yo4sTD7GuxGFEpDfHMwkadnOSiyYKg==
X-Proofpoint-GUID: ffjd2GJcq0ggSIEukoi4rDA4niRPLtqY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 spamscore=0 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230133

On 6/23/26 2:20 PM, Mukesh Ojha wrote:
> qcom_domain->pgtbl_ops was assigned after mutex_unlock(). Another thread
> calling qcom_iommu_init_domain() would see qcom_domain->iommu already set
> (domain fully initialized) and skip re-initialization under the mutex.
> If it then called qcom_iommu_map() before the first thread set pgtbl_ops,
> it would observe a NULL ops pointer and return -ENODEV for valid mappings.
> 
> Move the assignment to before mutex_unlock() so that once the mutex is
> released the domain is fully visible to concurrent operations.
> 
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> ---
>  drivers/iommu/arm/arm-smmu/qcom_iommu.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> index b6ce85f7f923..40fb0408dc07 100644
> --- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> +++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> @@ -306,13 +306,12 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
>  		ctx->domain = domain;
>  	}
>  
> -	mutex_unlock(&qcom_domain->init_mutex);
> -
>  	/* Publish page table ops for map/unmap */
>  	qcom_domain->pgtbl_ops = pgtbl_ops;
>  
> -	return 0;
> +	mutex_unlock(&qcom_domain->init_mutex);

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

even better, we could probably just wrap this in guard(mutex) now

Konrad
