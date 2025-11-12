Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2C42E7BAD
	for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 22:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762984984; cv=none; b=ZZGjv1mz0h2jCYxKuxV9hjZxRku/QOwcZdaiym00FhV784KJmMABYf1CaJU7n/choCL/kRZTEA2fSGxpvB9iXcKD4rP0eoGXjG/znFsEam7/+1V0zMH3tDUBsA9GP54ZsIIoQ+JPJHYKNRd0pk3NXFvYI2XdOAeGNRI9WJyAM+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762984984; c=relaxed/simple;
	bh=RkPfHlmwsqwzHclliKqi/Zquq2J/tXBfOO8ELda2TsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OpUXmpZ/JAdtUMlGdZBcbZKs4NbAPRiccLbmA0HkZtGcIWNAHqK1Kn088uSb/hUcF1OKbBbYeoIzKKEQQSuep/BelHe2TAWEtJQE81DRKFjmaejIO+Q1di4A2RcDlGa4BW/Os4Udmfg5h12OgD+SdtwEEWwFAq+vLf0iATBc34k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cHA0o/fh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=II3jtY0m; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cHA0o/fh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="II3jtY0m"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ACH0iij1001732
	for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 22:03:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	d/nTs8LVBJqSn132QZVwYlosV14mCj856uKAHF6W+UI=; b=cHA0o/fht6HtoqNI
	X2cYYYSs6rD1AE66bCG5GhR0LOm9LtO7Mobjpxoyh3U95AlY29yom5E7WGfeb6kW
	UZhdWXha5de685yIUOUFbiGYTJL1cifGUzOVgzEHA8tMX81I2u1DIhyu3vfXk7gf
	PiNBbBzVjBv5J4JD+tvjbGU+6glXD2zrN+SItouNpSIDY2egKFY2EzgIONn0u2Kv
	bO5ih6SjmiIh8J+TftgLVC8WyCxiZiWrXt6albknM9MMXu8nHASqw5x2mx41WUYB
	H9qA70549eBQUyzq6ZtpLH/hCI98INtheCd15AVSEtGZPZJkZQb/jSRiy0CJ9Fo8
	a31FmQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acqq22898-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 22:03:01 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7b89c1ce9cfso90749b3a.2
        for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 14:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762984981; x=1763589781; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d/nTs8LVBJqSn132QZVwYlosV14mCj856uKAHF6W+UI=;
        b=II3jtY0mJF0lg9g72Jr1Co6d7bqwI3sVpYO5DDqmkclPIy4IhMdHPRQyr6xNrXmKFJ
         mZST6XKz3G5KbakDZKg6yvYJTg5tELjC2opHv4f0Iz4hwDfaH7C1MYL3nM88WwD6OZWM
         Z89DnXceaI0kCuuzThoFjMCmLpYcZm0Irl3mJur5BNGD2dZSs8KwJITGn7kjafjS2DK0
         TQCeIoshuV6+Z/E05leq/jmZyN3pi9rI5ENdFQhdkTDRhth7WhqTIFuHBm1sdoRyJMns
         cu6t6m06PzSEvew0ICO1kPQmKixtoReltbmfIzZ7AT/sRBgRGTgcKT2CJX/TgVgjTFCF
         b6Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762984981; x=1763589781;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d/nTs8LVBJqSn132QZVwYlosV14mCj856uKAHF6W+UI=;
        b=cJOs2kkD8Os+SSkQsLD9nZNKhw2PCckLvIICqZe1zOAOmWZO7pNLxliLfaP41hpy9z
         gXP+l2AgBBA+P7AmKGwK/pqafqEagnMoKMHxX/ocHiJhxfRCdMxla/3g5R5Q3sUWfgel
         7BxnqIqbRcOiZbim6k+zb/TF2MC+6GjwrPIVoAFep6DWDez5/Jc0AFBcZ9wq4OsY0MTP
         Yspm68jX6E0uX81G0WrStTM9HfbpPZ4ZQiIhasx5e13iy5dfG66bn9SRyND3+okO3hKt
         h3w3CgWH/+iiaFfcH13c/vI1zOthkjo+h2w/+Xdf9ntp1D0vyD04vhtFPL59jrDTmhxl
         v0kg==
X-Forwarded-Encrypted: i=1; AJvYcCWFQ9htZ2etTFchd/OLy1qtEBL34kHHHef0qnv/gvudbSdCKs7xfUX4888JqtCIy6NbAS3fAw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyP7b4nD6lqlR3TFaN3IuYUPM79I4FQ/GYkWV9+Ng9xXtMkhIos
	uMkrKslmPpv3l+LsdDtE7Zu40SuFqqvVKIl4DTayb5NSwnOpGp0uJd46djA0m7ASw7VoFpFku0O
	0xEid1LQCVvheVL5LcgFkiSCDkvKHen7fp5KS1mGfExFj4uhyExv9Ebx6jg==
X-Gm-Gg: ASbGncu2yO//zJNDslb4cuGRJ+VkMKFms9ta22BuLFudYSjzXJK7Yo4FAOWE6njauhl
	mcRFk9wpARi+o4qD/MtoHk+Krthtxw4wry3i3UrmtaCx3jQx6vrqOi7bu5RBFnmmAdcHNDurlA/
	InWHeaZSRF+3IRm2aE7/pDhthnVI3MDGn0eA+CUsKYaUMUbeVyz5wTOHQC3JPQarJUF2wa/pwDn
	Zjx7Rkv9adXvMfHUipBKn/LXipTB13CGAwIkvW4zY3uqbPVJJk3AR4L+67i/pdPQzf5RCXV6Dw/
	o2PRKbo5HkugbTCf7e5APUwwtUtiTGBCb9g13t8geoGbczfCgjwEUsraq60QOZtyZWDxAH7GtKX
	goD8WWqJ4viE4/VYf2jYVtw==
X-Received: by 2002:a05:6a20:a110:b0:306:2a14:d0d4 with SMTP id adf61e73a8af0-3590b514a27mr5686020637.43.1762984980844;
        Wed, 12 Nov 2025 14:03:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHn1u1Nzkjc6Q6wIjoT4YUJ/liTOuUsOAfbNf14qAseJxfRuSew1Z6BWUptugvCHiHCrtJQpg==
X-Received: by 2002:a05:6a20:a110:b0:306:2a14:d0d4 with SMTP id adf61e73a8af0-3590b514a27mr5685964637.43.1762984980255;
        Wed, 12 Nov 2025 14:03:00 -0800 (PST)
Received: from [192.168.1.5] ([106.222.234.47])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b9250d28c2sm54557b3a.26.2025.11.12.14.02.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 14:02:59 -0800 (PST)
Message-ID: <12e6f588-e422-4803-ae14-56e5297e564d@oss.qualcomm.com>
Date: Thu, 13 Nov 2025 03:32:51 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/21] drm/msm/adreno: Move adreno_gpu_func to
 catalogue
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse
 <jordan@cosmicpenguin.net>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Connor Abbott <cwabbott0@gmail.com>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org
References: <20251110-kaana-gpu-support-v2-0-bef18acd5e94@oss.qualcomm.com>
 <20251110-kaana-gpu-support-v2-5-bef18acd5e94@oss.qualcomm.com>
 <28d62905-c191-4c3a-995e-a4146ffce619@oss.qualcomm.com>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <28d62905-c191-4c3a-995e-a4146ffce619@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=EbHFgfmC c=1 sm=1 tr=0 ts=69150416 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=2IP1oaZ8+KUWsYovLW0HHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=6-R1E5pqECOcxGsB_ukA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: gIKls9YKokQoitIf3GJZqnASquXS3962
X-Proofpoint-GUID: gIKls9YKokQoitIf3GJZqnASquXS3962
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE3NyBTYWx0ZWRfX/beGuCTdP/qA
 8nrVatq7jzMs0zyE4gmOAqJrgqg9CU2eJwRTndMXA1Udd3UQ75i9SvBjgdaczZgs76GFZkc6gjv
 cSa6LMLmuSZLXYCvZM42b8GLABggw1dQiJ5ONAV/WA4fvBZuEkuE9BxiMDxn27O/ZHlaY06NG9i
 D/h9VFUcV8wsv/Hfe+Yf1e0LfN9ak4bPGmBVaGTdWyItHRfP4A/xQH3YTsp7HhVpu8kIbd76rKu
 HVe9lznf4gl7HZuL1HOr7zzsN00Y+L/SCz68YjBoDf05m8aSoOYn4B3FVczSLk/iRJQ1/kNp6j6
 VjuGfLS9qXtSYmLboF0TWGWQj8pfuklfYD4SHPHsCOGnQlo2EHjHqZgukDXPXcLsbb0WfxxrnL8
 Fzfy+PnpIv8BwBYqJjRM52ApOqco7Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_06,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 adultscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120177

On 11/12/2025 3:52 PM, Konrad Dybcio wrote:
> On 11/10/25 5:37 PM, Akhil P Oommen wrote:
>> In A6x family (which is a pretty big one), there are separate
>> adreno_func definitions for each sub-generations. To streamline the
>> identification of the correct struct for a gpu, move it to the
>> catalogue and move the gpu_init routine to struct adreno_gpu_funcs.
>>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
> 
> [...]
> 
> 
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>> index 44df6410bce1..9007a0e82a59 100644
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>> @@ -683,7 +683,7 @@ static const struct adreno_info a6xx_gpus[] = {
> 
> Somewhere among this diff, a619_holi needs to have gmu_wrapper funcs

Could you point me to the holi's devicetree? Currently I see only a610
(sm6115) and a702 (qcm2290) uses gmu_wrapper.

In the driver, adreno_is_a619_holi() checks for both 619 rev id and the
gmu_wrapper.

-Akhil

> instead
> 
> Konrad
