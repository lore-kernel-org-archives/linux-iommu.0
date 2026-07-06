Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC3E3C73CC
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 19:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783367778; cv=none; b=XeWVehVAH0jD0m32I8nTgto+6PEBGDatOPKtDF6H2QUWraOoPyT0yDz96LdQAwqaeTTTim2mPBrgNJftfUnh6zHXmudYKddBXv0uuXK1LOIkjuG6sRul+mHHZGAav5iMnwQCsZDBO9mKA9GLVeXEIBSnnI/24T0f15nxXJm6R9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783367778; c=relaxed/simple;
	bh=CoAvdh4BP4nQuUv2gkyk5lYqdm+uef55MCTt8grpLeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RliGUd2smwVRi0O+TiWpX3gLceBf8x6UM/BuFGeiHJ5KktVpl5ejdycckezgzPQoqcw7Tlph+6urOt+NRTtBCSSW8IEky7rK4IXt883ehkunFCvEaV++xLZEuNepNtiwvhg44f94y4HzgA1OpuhMEpSWtT0cmvk76uczbCUWgpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ST78Cn0C; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kHoRkGeu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ST78Cn0C";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kHoRkGeu"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FsbKC1050508
	for <iommu@lists.linux.dev>; Mon, 6 Jul 2026 19:56:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CVprqCFVdEAD2aWCw5Q12fLKvWtWmKiMoP9O+awDYus=; b=ST78Cn0CaHEAkBgQ
	hRRjEv4Z/xXKv2pMOPJkqYAqsxxiYT8or41dWgrQWnOH9cJiSAgKRORgiMr+lok9
	5tyUYKpaSbfYS4wJTiwDGn9JsKqgBBt8PD6L37SJO1XXQ6gva5mwocEWJqFYDvc0
	ujpTfltzo75l9CEPP7rBpbZQAj/QCeetpwFJ8pdaN1+N3cKJfH8YVq+W8vKza5WL
	Bha+6cda/Q0xM9PkaiwdIU6hXe+Afqo151kx0J3vFMLm9fp+o2IlYBtKOAzYFcG7
	0cWdN2uBMOoZUjYHvGBZtdePiaG3jV1Y7aC1gOPh+jPcdnnYhpcyK3T8k4iNmKGq
	IYfdeQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8fdw1196-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 19:56:15 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c8894570b58so2389191a12.3
        for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 12:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783367775; x=1783972575; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CVprqCFVdEAD2aWCw5Q12fLKvWtWmKiMoP9O+awDYus=;
        b=kHoRkGeuWu5NiCrxnw5LDDsGcxfbwhTV7L14Fw+F3FoT3Y69uij8k28oFhBtTQYDdy
         gsmEXxRTY1k1YdTQW9xIBC6tOJ8GqUj13kMZzLGoKynQ2yx8pnOD8Fy99yx1kNN/uh0j
         sPGIpHvs5YdHxrumCKRgOegw4VRlv163LTJW08gL0u5hE1uHhvZ9MYkljzNe8cjo3q2j
         u/w8TBBwVDI/YGDlw+QSUrxng1jEyYc3iOa1Eaj9DUO+9KtTkd+b+iZ60yV8EYxkswYk
         R3geyhHoBdnxGMqjQeDSgWGS9z0kzYyW7NbBg/B4+Z71mz0syP4RF1+dM2/KSALt9gDV
         e5nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783367775; x=1783972575;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CVprqCFVdEAD2aWCw5Q12fLKvWtWmKiMoP9O+awDYus=;
        b=pMY+76NSTV5ftImlWGMBKnEaGLwfeKd1o+1Ta5asBXcfMOa3QzA8mXd9ZOpBuhcTAs
         w5FLtrLDj+uSMZ/pgO5lTFEekbG5I3Rtmm7zRIT1exwQB2cCawDC+Qa5XegMEhHgu4/o
         wBGGtRHtXxbvetXgrhjN6eZqAdrnxywkjY9mSjOpxoKHPZscSKP9EoHAMDJG/PW3kPVr
         RcZl5Ot4oloAt58xCKsL5pr1E4BrTB3caaqC+7HndJEkaGNAa+SOYEIB5JqmvTU6gfTP
         fu0ETAv0nwxGVIm17ysMBY8vbIlQrGW41kJLw4oEOicNEDGZrHvozz7pylIOmPzVIRqs
         fBpA==
X-Forwarded-Encrypted: i=1; AHgh+Row2qe+8+uvuWfgEErsEdtkKPtQ1kZYvgIJGyR8ZjL0UWuvQrFW7/8RzEiifM/S14eQcBTrqw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzdNbqPnIS0RZX6XKOqyVB298TcGSz1+4j2gMQ1rW9NSQloDMja
	84hqHNLgfj4PP4rmByjiEyDHFc8FsoAAT02OxImdFtaX0SGFUkdwbfJwb+bG/34bKOQOfk17i6T
	u2SaNKLoS2QKSuVswV0fCMk9qp3LTlo3O+PzrZozxNMAIJG4XnrNMhM0vZw==
X-Gm-Gg: AfdE7ckQabCgeKKVx6Ko8b0YuTDspJtmat/yjTxaZJByfjxPjkGfSuwWxE71iUVW3MO
	09+yquRDEA+YrBSVc/uh8pJl/WHYdx7DmOtXN8yegsKvPAek4vL/O8EE8ew/OF6vsGnZdv+WZ2Z
	oToK6mwnoboilAIw4x4uc29xqvjhhuiW2VisN++PRZgSbCNal/lqLufZ3AqOxlzpn3Nz3u5XqyH
	J/gPqTvPqHG07nWiddwtV1a7CtfIeSN1aYLXDdnhQh3EpMGw/NVz0INQOe1F3IiOC6plXRn7FcE
	LN9+4HBCVy+dCArdVHQej0is08w6Bn4f70/erwttaUyEQbBnJOTroT1bUPPXdR/6L5yA/c6Ywk0
	mjSd9KeXlPAzDS7YwmSyqfUSsm67RXlweHd0=
X-Received: by 2002:a05:6a20:5499:b0:3bf:9e25:1a18 with SMTP id adf61e73a8af0-3c08ef55ba0mr2517869637.52.1783367774855;
        Mon, 06 Jul 2026 12:56:14 -0700 (PDT)
X-Received: by 2002:a05:6a20:5499:b0:3bf:9e25:1a18 with SMTP id adf61e73a8af0-3c08ef55ba0mr2517836637.52.1783367774370;
        Mon, 06 Jul 2026 12:56:14 -0700 (PDT)
Received: from [192.168.1.9] ([106.222.230.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b816a42sm90197173eec.9.2026.07.06.12.56.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 12:56:13 -0700 (PDT)
Message-ID: <3dea2be9-7c72-4c5a-865c-139837d294c1@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 01:26:02 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] drm/msm/a6xx: Add Adreno 722 support
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>
References: <20260705-eliza-gpu-v1-0-c9f1354dbd29@oss.qualcomm.com>
 <20260705-eliza-gpu-v1-3-c9f1354dbd29@oss.qualcomm.com>
 <f1d1db6e-068d-4b31-b53a-02bdac9d945e@oss.qualcomm.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <f1d1db6e-068d-4b31-b53a-02bdac9d945e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIwMSBTYWx0ZWRfXy34+CQF1Xhal
 6YnmMDw06u3ConXT8TtzruQNMt/a07MIHdtwWyqDU13AiR94OUy31VO89Q01DjsZOid6h7f+Vx8
 xgIEmaJBUwAjBGxfwzUaxVb3kc08hrU=
X-Proofpoint-ORIG-GUID: 5PNeFKGVqOApb5lC02Ep_NvoLFDwP5Ov
X-Authority-Analysis: v=2.4 cv=EtziaycA c=1 sm=1 tr=0 ts=6a4c085f cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fsdq8dFr2Uux402FS9br8A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=Gg-SMJLLMV3ST4U2SEgA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIwMSBTYWx0ZWRfX4T54EoysRVlC
 e+XaAomweL9Co0AZgul+BakapbylDvFO2K2F3Je87uVU55q0tN8ACa5xjZeqnqPbC66FH1bWI08
 ntcuPH9EepGtjyDcuw6Cdy/V/g2MNrueboW6gUs+OAGDzQXupkNABoFWnAp5gV0A0FOeSdvkeYL
 O7pPRN7dTYj1qGw9/gizvZ9wcp37FD1ttCO40+UwuR/gCVPvfcqbBsEAwFziDnwu6EE7Hy7q2lJ
 91GvbTQ4fJRoS0qBhUxiPnrTLpIkB/FFWxVnslI7Dv8T9/fUpMd3GrX73pM6CN6tPoJvvXV/RIC
 i89hqLQcGYBiqWiNAyn44KQouJl+utMtRAycODgkmrW+EKd/uLyEKgL0o5X73FivZfbgn3oFnRz
 zQzJtmK5B/NFWhjCWaFRdfZHuJCJqkixtNMu06pVho9x9G9rYf2ya0fwXVtmvxv/NFri35rlSDW
 vC7hIdIMHLfjVK+OcIQ==
X-Proofpoint-GUID: 5PNeFKGVqOApb5lC02Ep_NvoLFDwP5Ov
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 adultscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060201

On 7/6/2026 2:29 PM, Konrad Dybcio wrote:
> On 7/5/26 10:14 AM, Akhil P Oommen wrote:
>> From: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
>>
>> Add support for Adreno A722, a member of the GEN1 A7xx family. It is
>> derived from A730 and shares the same IP-level configurations: HWCG
>> registers, protected registers, GBIF CX registers and gmu_cgc_mode.
>> Major differences include lower cache/core counts, 1MB GMEM, no
>> Concurrent Binning & LPAC support. Some of the peripheral blocks like
>> RSCC are from A740 that resulted in updates to RSC layout.
>>
>> Add a new entry to the catalog to describe the usual configuration and
>> few additional fixup mainly due to missing CB/LPAC features and updated
>> RSC layout.
>>
>> Signed-off-by: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
> 
> [...]
> 
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
>> @@ -710,7 +710,8 @@ static void a6xx_gmu_rpmh_init(struct a6xx_gmu *gmu)
>>  	gmu_write_rscc(gmu, REG_A6XX_RSCC_HIDDEN_TCS_CMD0_DATA + 2, 0);
>>  	gmu_write_rscc(gmu, REG_A6XX_RSCC_HIDDEN_TCS_CMD0_ADDR + 2, 0);
>>  	gmu_write_rscc(gmu, REG_A6XX_RSCC_HIDDEN_TCS_CMD0_DATA + 4,
>> -		       adreno_is_a740_family(adreno_gpu) ? 0x80000021 : 0x80000000);
>> +		       (adreno_is_a740_family(adreno_gpu) ||
>> +			adreno_is_a722(adreno_gpu)) ? 0x80000021 : 0x80000000);
> 
> This is a discrepancy vs kgsl (did you look at gen7_14 instead of
> gen7_17? did you test this on device?)

Both 7_17 and 7_14 are same GPU IP. Yes, this was tested on Eliza MTP.	

> 
> [...]
> 
>>  	/* The second spin of A7xx GPUs messed with some register offsets.. */
>> -	if (adreno_is_a740_family(adreno_gpu))
>> +	if (adreno_is_a740_family(adreno_gpu) || adreno_is_a722(adreno_gpu))
>>  		seqmem0_drv0_reg = REG_A7XX_RSCC_SEQ_MEM_0_DRV0_A740;
> 
> Likewise
> 
> [...]
> 
>>  	/* The second spin of A7xx GPUs messed with some register offsets.. */
>> -	if (adreno_is_a740_family(adreno_gpu) || adreno_is_a8xx(adreno_gpu))
>> +	if (adreno_is_a740_family(adreno_gpu) || adreno_is_a722(adreno_gpu) ||
>> +	    adreno_is_a8xx(adreno_gpu))
>>  		seqmem_off = 4;
> 
> Likewise
> 
>>  
>>  	/* Make sure there are no outstanding RPMh votes */
>> @@ -1100,7 +1104,8 @@ static void a6xx_gmu_rpmh_off(struct a6xx_gmu *gmu)
>>  	gmu_poll_timeout_rscc(gmu, REG_A6XX_RSCC_TCS3_DRV0_STATUS + seqmem_off,
>>  		val, (val & 1), 100, 1000);
>>  
>> -	if (!adreno_is_a740_family(adreno_gpu) && !adreno_is_a8xx(adreno_gpu))
>> +	if (!adreno_is_a740_family(adreno_gpu) && !adreno_is_a722(adreno_gpu) &&
>> +	    !adreno_is_a8xx(adreno_gpu))
>>  		return;
> 
> Likewise
> 
> You also need to if-out concurrent binning for this SKU

You mean the PM4 pkts? If yes, fw will skip them as NOP.

-Akhil.
> 
> Konrad

