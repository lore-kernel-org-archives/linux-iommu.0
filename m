Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F79E393DDC
	for <iommu@lists.linux.dev>; Wed, 19 Aug 2026 14:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787150435; cv=none; b=RwBY9ZGZF8cjOvWyp80Flv1B1Y7Xaq4OASZQ9pVOm9mJVnDdvXoSwLB3sT7k/gyE3+8mZCMT33S/NddtgSNpUwZNNcG7rlSzycKT7xIgTNh5I7Mp+0N8pcmWkjx6AePKO+ZQHEgrFZlgelwA5fDb1aWM1ZteiuBT/+FcFtdtcko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787150435; c=relaxed/simple;
	bh=0ycwrCeAk0rnsJPxku5p0isabvTMmEX9tdO40P0aPrk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=udH+WsiELyddLWKhT7ZnL2LAIB93Q7ofh02XW48SoONqgl+Zukhq99GlsXRho9XMIGi45YQRjjsPe/Ne8g9l2BRPnYnaH0hO/dMzj4qgoJrHt7VamykVLlxSY+EboZzE16Py9FrocdR2CAWtOOSNUdripF3qoeF7yAG0THZhz7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S7ymNLZY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=R2VDkQ11; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S7ymNLZY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R2VDkQ11"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JEcYZm392189
	for <iommu@lists.linux.dev>; Wed, 19 Aug 2026 14:40:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YkxApuLR3nH6kHIS/ueeOQIr419fLolFuozcNnUKvXQ=; b=S7ymNLZYY1/ADDbu
	DH1VqoRhEtAuiPXPnGap1L8y7UZ4hNSCxy0yrjSdt0lfRH6bp1r0J1iNK3jti8ta
	uybb6fahSH40TJPtEdI8es8KsaQ5LDJxvckfbdKJPgQ5uYpO2mzLCP3Wjd1FW/9X
	PjulT2/FLQNAmu04Qw5HG6GWZY2h4+z4QqFFwXXY1T3nMtOKrpQBAUEFToMQcCFr
	uaFItHQPYCL2LWwRAORDp0zVhtNvoige3dFKwpfYN4SqGHQDI93vg0TmLHkc/dtc
	PTdS2SHBqkGzhTbxuUJBwa3mI3K35BiuLyUt1D0w/9dNa/aU97TleiLidS6sDuGT
	PNkNeQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfjkver-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 19 Aug 2026 14:40:32 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-52d57d17d6cso2312681cf.3
        for <iommu@lists.linux.dev>; Wed, 19 Aug 2026 07:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787150432; x=1787755232; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YkxApuLR3nH6kHIS/ueeOQIr419fLolFuozcNnUKvXQ=;
        b=R2VDkQ11IxIKyUUgKuLIVTvDL+7BdEjQAWlvMdKSVB9cVvpP4qCmq74PrR+LaAmdsD
         7wpbE9Ln401LjhuHazxnb+hlrjrHotYRzgppVS016C5KHZcZGaeWjuEKARe/qTIbvHu8
         t5CIR6r2JS0C5KCmv+E9m7oB7LmtdCr/60f57rdquEYtHh1PbG2Ly6PxcNO2Jlr/KB9t
         dst4UQrdrqdXjQtipyGfyFckggMJH1mnd1QaYfKW8dPIdqs+icAvNUezATTMUt+dOna7
         9+JR+T33hGD9HIEBLYeqeHQRafGZNyXfHpu2NdFL/Wdzwar3tqw7gIw7s/NztAKOBPcB
         NifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787150432; x=1787755232;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YkxApuLR3nH6kHIS/ueeOQIr419fLolFuozcNnUKvXQ=;
        b=LFLMRr2kEQJaF/XtjRPoTqOMkTFtm0V0f7Ccl58bGEWw0TPt17PMKBvS+XhxhDHxCj
         mE2o6yqTjzWXsVcncRjVIIVBfzcGr+UTVhLg8kqLRteuU6nmXw+H7jQLXZpVaTpGFka4
         BJ3E9m1vzfS3kOj/lcIEhBAQiY8lFbKoIwdSNxvUNEcZ+Ccf0aNzPpwxX2xLoft7rjrm
         DBLoH2KLi0HASnefNojDDUlrqXXxIFQnG2JKGhqR+PUrqG7XHb9UDEZ5zmgB7706Gy11
         w56+Y/8hDh+K362yTFkumDfbJOvD3bSd7IMZP6oIprBTXeDN01PgzU1SO2W+2XWTqv1A
         mujA==
X-Forwarded-Encrypted: i=1; AHgh+RrtdawUob+Z2zAR90ahwjlBwfxJSU5koSORBv+HCr3J0vRH8r9sCB7qx6Dwf7vUyrG/XpbysA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyGtE6cORLN1xFOS9zgiOcOGj2cFBYJhyMN8Jzv1iW5604ZfdG9
	vpnpUhxwEnVNd/cEFzuSqilnteRe7o2KMS89Rtl2njruVEDhOqFW2T2HMH+wG+k6v5s2w3lfMgi
	tk9ig50UXewBKDEzIz+duhHb773V98677qt29AvmuGomKLA8fZHYJjiWOAg==
X-Gm-Gg: AR+sD12R2FgO3P6xovxRUf7p9aKfT68KzJAUnEiY1UgdyMzDUBRMbCq/OyEdOScDJ0P
	YzHdzdmu5+prcQASlYlMmA+cOBmqPa3VrUePvLjoedky7P5w0RzT34rC2tbBncnQHOZ5jEPt9Sg
	a2vvqi3u7MptOVHxXwgA9O3wwP8qFcG5Ryt6HiraStupi69PusFNkrTqf2yIIOZJSgmYt1x7+0l
	OevFSzCCYtJTaKENMQI7c1KwledlWrFIszIEPR4YomqPMpA9SQWOikUitvNWM4vUKwLy3KCTuCr
	Gio8Xu4sh7I7IDP9WxzXerbWVRPxSdDl3RdxXFyZn1Y72cX60e6rfohnY3awYbncHkeFqO1mezs
	qIwT9nZuTAC05+JAUGlbDjzpx
X-Received: by 2002:a05:622a:2cd:b0:52d:9a83:4187 with SMTP id d75a77b69052e-52dd4dcf390mr38628001cf.0.1787150431662;
        Wed, 19 Aug 2026 07:40:31 -0700 (PDT)
X-Received: by 2002:a05:622a:2cd:b0:52d:9a83:4187 with SMTP id d75a77b69052e-52dd4dcf390mr38627581cf.0.1787150431215;
        Wed, 19 Aug 2026 07:40:31 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c243c38b029sm86575866b.47.2026.08.19.07.40.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2026 07:40:30 -0700 (PDT)
Message-ID: <bfb68688-aad7-4eb2-8981-4a4d1f116ce1@oss.qualcomm.com>
Date: Wed, 19 Aug 2026 16:40:27 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/15] accel/qda: Qualcomm DSP Accelerator driver
To: rob.clark@oss.qualcomm.com, Krzysztof Kozlowski <krzk@kernel.org>
Cc: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
        Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Randy Dunlap
 <rdunlap@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling
 <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Bharath Kumar <quic_bkumar@quicinc.com>,
        Chenna Kesava Raju <quic_chennak@quicinc.com>,
        srinivas.kandagatla@oss.qualcomm.com,
        dmitry.baryshkov@oss.qualcomm.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, llvm@lists.linux.dev,
        iommu@lists.linux.dev, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org
References: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
 <3322b42b-3755-45ec-ad55-345125f0d488@kernel.org>
 <10349e29-b583-403f-a89a-9a00c73666bc@oss.qualcomm.com>
 <87dca76c-851e-4cc3-ab91-68949d283b79@kernel.org>
 <CACSVV01eYr6FyA6XBG0xw0yv2dydvTEhcY-WUy07mxM8WwkZcg@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CACSVV01eYr6FyA6XBG0xw0yv2dydvTEhcY-WUy07mxM8WwkZcg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDExNCBTYWx0ZWRfX3q9Nm8iDgOlz
 +JUKOZ5XPuhmbWJ1veIFfPtkSG7Lcd0ebzyxv4xxos0HvqKdsZT8RU1DqJwPUkuyCyLCBNVy+Sf
 LxfyJTISuKYXTyE6CBqh8EMZ+bDKgWo0hLvp8NpImvQzZ9ZQ3XyoanjitiKfA1Bh+CKv0rL3v5j
 qyYfsuTYhPsSHG1rlsPEBNMhmBlGFAASg2QRusXaVc4EE32/vaMkXBIYbTU6a+7ZwDpGF+pfwc3
 zP6znvW88gykrT7QqDQlfiklJm6ULCmeG04W7LZvTZ6H6uJWFaZgLsPotcCO7Pj/n7Bfu1ntaDa
 fUgYa/wNjE2dfbJFW5EA/RXXmo1p/B4ihP7N3J3Ton4ldEDDzyFJawjnD5/sVnXpMX4e0srt8DE
 FiOAFqqGgJH30y3sPbAr2S50uv44/nIrphBWGzg6c4rGlZVJ/FT3w6bMOzRkkODxksvXxYkFsue
 rEolGqdchYYcIELIOiA==
X-Proofpoint-GUID: kTp2Kx2FI8PYGdIIHSc7oDq_1J2rBdFK
X-Proofpoint-ORIG-GUID: kTp2Kx2FI8PYGdIIHSc7oDq_1J2rBdFK
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDExNCBTYWx0ZWRfXzMSfJRMxSy3/
 vtW0ZV7q5bnk3fOAH+f5I3BgXlOvc1QoB4ht6qyheHM2fUGicgqWdiJWAK5TXNJVmqAcBA85U4Z
 C6UtCyNJo5mxs0t0lsryk/xAYeQyw0A=
X-Authority-Analysis: v=2.4 cv=Sb7HsPRu c=1 sm=1 tr=0 ts=6a85c060 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=DxY1U69r6NhVaGGOtf0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_04,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190114

On 8/19/26 4:38 PM, Rob Clark wrote:
> On Wed, Aug 19, 2026 at 7:21 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On 19/08/2026 15:26, Ekansh Gupta wrote:
>>> On 19-08-2026 00:43, Krzysztof Kozlowski wrote:
>>>> On 17/08/2026 06:47, Ekansh Gupta wrote:
>>>>> This patch series introduces the Qualcomm DSP Accelerator (QDA) driver,
>>>>> a DRM-based accelerator driver for Qualcomm DSPs. The driver provides a
>>>>> standardized interface for offloading computational tasks to DSPs found
>>>>> on Qualcomm SoCs, supporting all DSP domains.
>>>>>
>>>>> The QDA driver implements the FastRPC protocol over the DRM accel
>>>>> subsystem. It uses the same device-tree node structure as the existing
>>>>> fastrpc driver in drivers/misc/. The approach for binding the QDA driver
>>>>> to device-tree nodes while coexisting with the fastrpc driver is an open
>>>>> item described below.
>>>>
>>>> No. Grow/replace/improve existing driver instead of coming with a duplicate.
>>>>
>>>> That's a standard upstream requirement, basically given on every
>>>> upstreaming guide.
>>>>
>>>> Please watch old talk from Greg - "I Don’t Want Your Code!".
>>> Posted discussion threads here[1]. Would seek comments from Dmitry,
>>> Srini as well.
>>>
>>> [1]
>>> https://lore.kernel.org/all/3476b5c3-7983-4994-a901-3d7d8bd75255@oss.qualcomm.com/
>>
>> The rest of the comments is still valid even if you did not acknowledge
>> them.
>>
>> Anyway, regarding above - again, watch the talk from Greg.
>>
>> You have ONE driver. Not two.
> 
> Long term, moving to the common driver framework (which did not exist
> when fastrpc was first created) seems like a good thing.  But does
> that not allow for some transition period?  How can we get from here
> to there without otherwise breaking userspace?  Is there some other
> precedent elsewhere in other driver subsystems?
> 
> I suppose drm exposing legacy fbdev on top of drm drivers is _sort of_
> a precedent if you squint a bit?  I'm not really familiar enough to
> say if that would be reasonable/possible in this case.

Also, venus/iris, mdp5/dpu1

Konrad
