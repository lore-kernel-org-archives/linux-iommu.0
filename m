Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB334C8FFF
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 08:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783328376; cv=none; b=Q4WPjB2DhwwrkC98TqaRfu3IvNGcOfTGNYHqdjXwgbVbL1hKK1qhRqILTToJYnUza4zqKOMypFdZQpo9vn3tY8xyQSmqUMZgwH8T2i8uo3B9Bx6x5jfUjKrPNJu1npafnEWXg7jyJYNL1+mBTUoBP7Ub0O1F/UivkMhxXP81Z8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783328376; c=relaxed/simple;
	bh=VdMEYEfujKlTpTeNpLjtTw6Z44BxQKvYppPb1nAG52w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kpJCeLgfX8oqvV/FSDyQdxgzASL0zb0H2lMDmzflu7K9SZ1jcSdbjdVfhv/m9R9LeA3I9mvKLvlMqttlEoH5h4D/hglXcIhbtoN/7tz56nQF0g2LvBLbe8YNRIrUExejhfKlmsa2ZveT++kpFz8F+zexMG3HbX0sQIq0Ggr+Ca8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Axhgdy3T; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=E/pmJCnP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Axhgdy3T";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E/pmJCnP"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66642DPB3618367
	for <iommu@lists.linux.dev>; Mon, 6 Jul 2026 08:59:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ERl4wTZyWv1vQsjv06YEWQxA6mOQp5u853Smknj5ows=; b=Axhgdy3TrH2DtrJ8
	weETRVwRSctUP3G+Iqa7U//pwX5JnIoG6vEPa5wrZuq0Wy3hmcKd6l8MXeOQj8bu
	WdMq9zkrIgNO66vIBa1vGQF1hlRBin/sFhk5w+wzn8LYN0PL0rD3yWNukq3C2IPI
	CG10qet/6xYlsfT0CyRbbPB5ZfRaXXfThWM7mQ7BnF31txQMtZ6dI/Chd51ZZIRM
	pILhbWV6PNLv3b9rQ8Fdm8Bia+o9612oGW/zVoCNVSAloq7tuMnCDl3YqDTjvPa0
	6vEmuQfc43TMpZTsNxr0OrpJdtW9A+Gv/k31WFpv8Dw/2MVHGEVdiWp3CziEmTEV
	twlSKA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6s64nhn7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 08:59:22 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c21be5bb4so20914871cf.0
        for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 01:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783328362; x=1783933162; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ERl4wTZyWv1vQsjv06YEWQxA6mOQp5u853Smknj5ows=;
        b=E/pmJCnPdNbeKGEPhadD+tOrCPReK2Lh0ZNXahFwRenoc6PjO/c+Fk9vrdretoh05L
         KLdNVa3yjriRkQpBH+UKQ7l/g1v2RErjs5sOOstIb/cbOhJewcurbflDk+noDaJl67kr
         qvIYlAcok5Idml4Q1ph4S4qMWyNv5qdhZZLzR2Tj+pWHLq77jGXEPbr0daAMm84WPWUj
         2OZR6U64Id/8/DGt0bwyfCTdjd7gSF5i6w+lJPRIs4WnfnLtzQZjkOAoI8IBLiYt3WUb
         Ze2DUdENspNw/avl4LbACmprHqpU5Vb/bNE1NPMZSZam34XuWOBkiG6dKku7tDmGk/DE
         8YXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783328362; x=1783933162;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ERl4wTZyWv1vQsjv06YEWQxA6mOQp5u853Smknj5ows=;
        b=RwZeIBVXkw2YKK6yPCcl5+RfKb0KZEIjS4KwMysQHGIoVenofSYEOMj4JNppD5TLLR
         KxdRs3Qz7xvm5OZYAQ2DE03GpzOYoFkFsHT5qwkxi5n1gO6jUJhs0FVMKerwA5Uz80Nf
         Htt72uvirrGlRolLGiMX+CdWm/pckPsUgnbC2oexUFZWRrezQhTUCxTj3NRRbUiFsDpY
         wgWOm5MVmkAqSKPhYeunOF+IoV2TizIHMu6FisLWnDkL1Kc78YcH8INPDjapeSEw4BR3
         P+ldq+AoTgsSCgXXo5Se8zUvPPVxfVvxt/HjUl6V1klkC5OjQUohY5YE/l9Sfbkzdc9F
         wvTQ==
X-Forwarded-Encrypted: i=1; AHgh+RpIC8AhqSQJ40cqk08kHXrl/EdAfBdt4fJ4usnotkgRl2aSSIz9Skc3MTLgodIoEHRQFKAgAA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwPxXb2L+cC9jSxj0GWzCBvrHvNs61lJhwB1+q8RLAM8aVf2JHt
	Aj0L9B6Bfb8/zICIx3Uq27+F49rK3SFVHwIgpQHToOivDdbGH8cQSv90mVNfmNNp+N03Wp1atTq
	qhr0zzxRhMJTlWcrjrq/gFe9Nrqlc2MTIpGahFQaP7iKhk5b2xeL+R1lNCA==
X-Gm-Gg: AfdE7ck1LdQgR3zKgeNUrmEmSdjgML24DObSeFS7lc2UO1keZasG58d85ZOPCGlupnP
	94tgoBK8y17eDhTwD+dg93k5KtAJn60Lu0MqCREx9wdsfecjyN80/1YrLGAJAgIjaIyitME/L+O
	hGTsEYjGU1xOhSJPIC71jn5xcOpD8DFmWQcbOzR5U+eyDmMk9iN9c8mYiep78Ggz7wVo30payCE
	vfWduTmGp/TlreGF2gks+rgTWg2z1xlQ9nwRsLfEGfq64xR/csCwiJwqZQBGNOGgL92XNZSVBys
	xRW180Ydro59/DZG3OqkbwxKcqz7Lbl9tJ3HmAjN+Ik/MvtaxX3ekiXC9dNIFIb/MBKdUIY+OUX
	NE+UPHbLId/pEBKfCu/6BYZzjcC1t4YJnqOc=
X-Received: by 2002:a05:620a:4405:b0:92b:7420:bd58 with SMTP id af79cd13be357-92e99e0f65bmr827907585a.0.1783328362388;
        Mon, 06 Jul 2026 01:59:22 -0700 (PDT)
X-Received: by 2002:a05:620a:4405:b0:92b:7420:bd58 with SMTP id af79cd13be357-92e99e0f65bmr827904985a.0.1783328361880;
        Mon, 06 Jul 2026 01:59:21 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b60550desm702417466b.7.2026.07.06.01.59.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 01:59:21 -0700 (PDT)
Message-ID: <f1d1db6e-068d-4b31-b53a-02bdac9d945e@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 10:59:17 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] drm/msm/a6xx: Add Adreno 722 support
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
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
Cc: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
References: <20260705-eliza-gpu-v1-0-c9f1354dbd29@oss.qualcomm.com>
 <20260705-eliza-gpu-v1-3-c9f1354dbd29@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260705-eliza-gpu-v1-3-c9f1354dbd29@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA5MCBTYWx0ZWRfX6wfGBb6pbmo3
 oFyUaJSLR0mU1jXmNhJCMZEzKJh8V77UJK53X8Fnf3+FbDdm9Fp+bHid/md9A4Hh67Elc+z24A8
 KZGeO7xW0p9IDfo+WyioBhhFqu8zYhBM/NQ36djsTXVkLBGKWqCjIEyGwV7sSPPJoNNQyPb2IDH
 cnQTUx1BJiZco3630QsDLpFpjwS4VnCUK9piZHXzK4gfVCMoFbQv1Y0KEfEz0Q+fJ0N7UZQQ70d
 utyunwgZa88XxhQp6DyBw1IxNEqtWOZc73j/b+ey9mHvkhm6wVU2qKlL9lhSNZ6bBdkZLV4UUPA
 burj45F2gR3Ob46vcTte7wM3v+zxjEOnDjbE2BMJRBBOPFOQDw1OC1U7mhgPSpLskPYxzvE3PPZ
 JJFFsWhRjEDn1brcXYaJsToNLcSWUEic+OWZx9u2VAhP44cTAK0qrD1XT9DUon5YPHe9Iy+Wul3
 YgFYSHoOV5B8BypknMA==
X-Authority-Analysis: v=2.4 cv=VvITxe2n c=1 sm=1 tr=0 ts=6a4b6e6b cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=ErYzCqf3RjAp607u9I4A:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: oqP5S4ptrp8y9Jr2o2X_17r2BG4Htgii
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA5MCBTYWx0ZWRfX2FVby1qaJBR1
 +PIslZNUyJrmoK+mo3UelE4rjPLTCxs20YC7+iWfI5bguLyvhnvCdqYoFJm9JMtA55lNza/qNfG
 JFNSen+fqGGxDYPJMpkUz/ot0LaWu7k=
X-Proofpoint-GUID: oqP5S4ptrp8y9Jr2o2X_17r2BG4Htgii
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060090

On 7/5/26 10:14 AM, Akhil P Oommen wrote:
> From: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
> 
> Add support for Adreno A722, a member of the GEN1 A7xx family. It is
> derived from A730 and shares the same IP-level configurations: HWCG
> registers, protected registers, GBIF CX registers and gmu_cgc_mode.
> Major differences include lower cache/core counts, 1MB GMEM, no
> Concurrent Binning & LPAC support. Some of the peripheral blocks like
> RSCC are from A740 that resulted in updates to RSC layout.
> 
> Add a new entry to the catalog to describe the usual configuration and
> few additional fixup mainly due to missing CB/LPAC features and updated
> RSC layout.
> 
> Signed-off-by: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

[...]

> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -710,7 +710,8 @@ static void a6xx_gmu_rpmh_init(struct a6xx_gmu *gmu)
>  	gmu_write_rscc(gmu, REG_A6XX_RSCC_HIDDEN_TCS_CMD0_DATA + 2, 0);
>  	gmu_write_rscc(gmu, REG_A6XX_RSCC_HIDDEN_TCS_CMD0_ADDR + 2, 0);
>  	gmu_write_rscc(gmu, REG_A6XX_RSCC_HIDDEN_TCS_CMD0_DATA + 4,
> -		       adreno_is_a740_family(adreno_gpu) ? 0x80000021 : 0x80000000);
> +		       (adreno_is_a740_family(adreno_gpu) ||
> +			adreno_is_a722(adreno_gpu)) ? 0x80000021 : 0x80000000);

This is a discrepancy vs kgsl (did you look at gen7_14 instead of
gen7_17? did you test this on device?)

[...]

>  	/* The second spin of A7xx GPUs messed with some register offsets.. */
> -	if (adreno_is_a740_family(adreno_gpu))
> +	if (adreno_is_a740_family(adreno_gpu) || adreno_is_a722(adreno_gpu))
>  		seqmem0_drv0_reg = REG_A7XX_RSCC_SEQ_MEM_0_DRV0_A740;

Likewise

[...]

>  	/* The second spin of A7xx GPUs messed with some register offsets.. */
> -	if (adreno_is_a740_family(adreno_gpu) || adreno_is_a8xx(adreno_gpu))
> +	if (adreno_is_a740_family(adreno_gpu) || adreno_is_a722(adreno_gpu) ||
> +	    adreno_is_a8xx(adreno_gpu))
>  		seqmem_off = 4;

Likewise

>  
>  	/* Make sure there are no outstanding RPMh votes */
> @@ -1100,7 +1104,8 @@ static void a6xx_gmu_rpmh_off(struct a6xx_gmu *gmu)
>  	gmu_poll_timeout_rscc(gmu, REG_A6XX_RSCC_TCS3_DRV0_STATUS + seqmem_off,
>  		val, (val & 1), 100, 1000);
>  
> -	if (!adreno_is_a740_family(adreno_gpu) && !adreno_is_a8xx(adreno_gpu))
> +	if (!adreno_is_a740_family(adreno_gpu) && !adreno_is_a722(adreno_gpu) &&
> +	    !adreno_is_a8xx(adreno_gpu))
>  		return;

Likewise

You also need to if-out concurrent binning for this SKU

Konrad
