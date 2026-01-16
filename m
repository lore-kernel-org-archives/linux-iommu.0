Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95ED2D6E55
	for <iommu@lists.linux.dev>; Fri, 16 Jan 2026 06:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768545153; cv=none; b=D0ixSH3a4ObOMG11SB6tygAOmpt4hO9FbSOxVTO4mS+xdAnOMASpnhFkPWS9fwjjU4r5dpZdf5Vh34BmqAPiouUfaGQI3cs53FQaeYnZfnYK3TZUy0jDWZT+l3mO//0pzLkrgCM0i7F2TIbdFi780Fu9GQzxu7/EhfMUsI6uexA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768545153; c=relaxed/simple;
	bh=cVp6/6R9XQlepJ7QgVMfMH0NCtOW5wKvgip99CTgRIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OUu+G6M6hUX5KMYKjFdpQdZLLS0PdebGIHjBBWphGd2uEe1NE/AXMjU42w7xktX8YIMVW5UnXmKKPNv0fiVMAB1uc/6nmLcVcK/nUR1xx7cVQUHoCZ6/M+5k1OIo9ieFH5SnoRjda2Jq1GxZfE9hxk1dt2YwFZZW5F84gwIbpeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mAcXNIM4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L6o2nV/Y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mAcXNIM4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L6o2nV/Y"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60FMgQHd4015919
	for <iommu@lists.linux.dev>; Fri, 16 Jan 2026 06:32:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	571F6lMjkVoO1c608L9nLhKKPVlPXL7EwfrpN3qqPW4=; b=mAcXNIM4TYrQU45C
	OLpMWgIAf3OjjcC3eqWuyAFpjace0Qm3u69I/YKSPBn1485Af88S7xqY4VUn4+ot
	drghon3/sMW0zvgNiGoPPDPeEh7Yoh+tuE2hzxUXJwcbL916ilxGS57mdPhgmBk2
	fijzSmeoL2EA9L1oqcEUl3uiGMRAoTCn5oEiXoi78rn9/z0Bsc3myUOSA7uLIVSO
	/+K62mgF2DZs6RpAnoQEO35n/oxVrZiTxsJS2htMQsICcglYiM+zZqVlu5IytL5i
	PP7hP7xsu00kVom/GmPvDhudCiCo3LIVxH+jCYfkGi5gy6hwXf1fK323UqKv895x
	47cRdQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bq98y91sx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 16 Jan 2026 06:32:30 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a0dabc192eso17846455ad.0
        for <iommu@lists.linux.dev>; Thu, 15 Jan 2026 22:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768545150; x=1769149950; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=571F6lMjkVoO1c608L9nLhKKPVlPXL7EwfrpN3qqPW4=;
        b=L6o2nV/Ypb5S3x8W/rqQ8S68fhSsYwHoL0ujLd/ZdAA818fJB3NCqrHHqtRk5J100M
         r2ZgE1nLwPmzlm99k+EdcWADZ2RzZ57ylxfMfSAx0a2MySHnLIw/i7fMDmcRmMBgj8CJ
         gU4kYmsCBYWYqj9xl6SoVxQP8z1+EMCgMWTaWfNcEEg9gpzhsGcvd+mjmWATxi38YQ06
         wflea47KXJlWQDrlHR6ErVpUT1tLiGROguXwUoX688b77Q3NAA4ZiVoR/xv73Ej1XafX
         92WEntqAbrSmCoo0MjyyRaOcuPhCnA/Awtndyq8I12qOFCNBANcQz4fwP88W3+pYs0B4
         tHqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768545150; x=1769149950;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=571F6lMjkVoO1c608L9nLhKKPVlPXL7EwfrpN3qqPW4=;
        b=SUYEY+4gf+v/vE7hGe74ffNDAuJFb4KjE0EkUhyfJsFgfJG683LW86NbE59g5eeUiG
         Va7BbKkbW2MnkZIGytzajQLBrYXXM8mHntdY6WLGW6soTpQgRPj8ZrJBVGNRUWqHYb5a
         Kg/sxyfNWG05JM/Xj4sdWvKDypfqv7YiPU10zCLLiq4OdihGgFk40VHsprdeC+ua/BtG
         Mr7S4xIHosIqIPy6V628OOD6MXqFUNufXoUC8tM6GNloMkKz83JOkUfNjxjiSl7EWb6H
         ayelu012+IGQWlru2ScCGF6dmjLwmA9PU6e21drWTx077davpYvJ5R3e51QbiEL8l56a
         7APQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcjgv0pC+Q/6lrDFVdZM0Mfa25LEycrJnsRFcmJaoFKih/655JEAsttEUKS8QtXhmyl9b2Yw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzpAPCVywlC21cEZ/KYeD7tLiGVFfKeJaM7jq8kfPDjm/0xtw0Z
	V8v0Rmk0mhfPwI+X0ACwspBcSO8yf1MZpQ3BhnDOuFkGUmag6pv02h2HS4YPPxMeykdsn/Fj8oa
	mpJNLaqyMlsVtHKDRpJ562GJmHteqLWeKJAo5X8lZr+f/Hel8tHgvow4Z+w==
X-Gm-Gg: AY/fxX4W8ZMDx2mcEmUr/z7s67pBUukuGso7BPG9yReIqYDJdCjPxgDNNg07c6S2YlT
	N4JuaZATOlw2imhdWdtyxhVXcYngKnbscT2+/1zpHlZd0Uvgzzjr8ljcIB8WsU83PW5EXksePHL
	vOZ59VfzrIMhG2FSAWt8X+tqhen+u2toOjrsGSUTed4MbN5Ln2Lzp1xGnYSGRwuxX9GnILxsITG
	3wvBLVMyv+ClpcNoAJzymVEBTvbxSo2pWWqTQ9Tp44fjfozQd7ebd8oRgPWZZCwJzB+VpTSzFKa
	e8kQ0fHmizdowkcZPcLPOZ3w4Ni1bIsIXGqApkEYr6yy57r6gYNKOxfJvMY6GBZ93MkeXDuj/dm
	gmAiS+Kn+m5/xPBpVDQs49YWyWecVNWOQ+kBe
X-Received: by 2002:a17:902:d48c:b0:2a0:e223:f6e6 with SMTP id d9443c01a7336-2a718949652mr14797085ad.46.1768545149683;
        Thu, 15 Jan 2026 22:32:29 -0800 (PST)
X-Received: by 2002:a17:902:d48c:b0:2a0:e223:f6e6 with SMTP id d9443c01a7336-2a718949652mr14796875ad.46.1768545149243;
        Thu, 15 Jan 2026 22:32:29 -0800 (PST)
Received: from [10.219.57.14] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190ab959sm10752865ad.20.2026.01.15.22.32.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 22:32:28 -0800 (PST)
Message-ID: <70e88549-5448-4a06-a20f-ad4395eb7350@oss.qualcomm.com>
Date: Fri, 16 Jan 2026 12:02:23 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/arm-smmu-qcom: Restore ACTLR settings for MDSS on
 sa8775p
To: will@kernel.org
Cc: catalin.marinas@arm.com, charan.kalla@oss.qualcomm.com,
        dmitry.baryshkov@oss.qualcomm.com, iommu@lists.linux.dev,
        joro@8bytes.org, kernel-team@android.com,
        konrad.dybcio@oss.qualcomm.com, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        robin.clark@oss.qualcomm.com, robin.murphy@arm.com
References: <aWDsFoEe7PHQaL9F@willie-the-truck>
 <20260109204551.845959-1-bibek.patro@oss.qualcomm.com>
Content-Language: en-US
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
In-Reply-To: <20260109204551.845959-1-bibek.patro@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=FscIPmrq c=1 sm=1 tr=0 ts=6969db7e cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=x8gyvrLTtEN-rIJzB5wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: ieyudeY3ToJBqcB-1mfIWR63szl1ACJ5
X-Proofpoint-GUID: ieyudeY3ToJBqcB-1mfIWR63szl1ACJ5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDA1MSBTYWx0ZWRfX+d3JklA+9nEZ
 2b5E8AelJQ0pKaos9vd7u4aDhwJ1BGWiIy4ZDyeUkxDzDY7PcM693RSo/yfiX0hXmyJATl90wtO
 +F6HVttccINgRPnNCdyJIRXqu6uhsWkzvkdhi2xDNk/WuLFkh5+6tZA03U6Vaj6sdtpzOxbah9u
 8j7VNsOdKRO/XEKYMwRbTYVRtBc7SBtiSDedEVGASUvPwGkU4C8RNPazsSDHR5Nu0AwNV6u3vFE
 44T0UJyedBI7d8zi7q0d6Xu9b5ilhqAJGa77erCLRfxeTEhtBxZ8fKouG8jWYqFmeTXsrkAaGg2
 dnmTFM+8LE333a8ouzsSh9R+Bps1I+Q9yVYQaa6mpc5U3etOpICgL+utH6k/2uTggvx3AEz/mhB
 J8oAKOX+oPP/rPWBzOftw73Gzho1Uvql5kPXqDMnbT4ZYmsyeh1UVQj4Oppi8CUDfPMLnWVxq5E
 pGaBW/fQ5irL1qrVhzA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_02,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601160051

Hi Will,

Thanks for the clarification in [1].
I’ve sent the follow‑up patch on top, including the explanation in the 
commit message as suggested.
Please lmk if any further adjustment is needed.

https://lore.kernel.org/all/aWDsFoEe7PHQaL9F@willie-the-truck/

Thanks & Regards,
Bibek

On 1/10/2026 2:15 AM, bibek.patro@oss.qualcomm.com wrote:
> From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
> 
> The ACTLR configuration for the sa8775p MDSS client was inadvertently
> dropped while reworking the commit f91879fdf70b ("iommu/arm-smmu-qcom:
> Add actlr settings for mdss on Qualcomm platforms"). Without this
> entry, the sa8775p MDSS block does not receive the intended default
> ACTLR configuration.
> 
> Restore the missing compatible entry so that the platform receives the
> expected behavior.
> 
> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
> ---
>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index 456d5146831e..718d102356d9 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -43,6 +43,8 @@ static const struct of_device_id qcom_smmu_actlr_client_of_match[] = {
>   			.data = (const void *) (PREFETCH_DEEP | CPRE | CMTLB) },
>   	{ .compatible = "qcom,qcm2290-mdss",
>   			.data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
> +	{ .compatible = "qcom,sa8775p-mdss",
> +			.data = (const void *) (PREFETCH_DEFAULT | CMTLB) },
>   	{ .compatible = "qcom,sc7280-mdss",
>   			.data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
>   	{ .compatible = "qcom,sc7280-venus",
> --
> 2.34.1
> 

