Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4CD3AEF57
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 22:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783375232; cv=none; b=Q2FP8bTJmyEW+PREfnFLnRFPrq6A/sxbtSm3BB0gjwQscEAf0hYvnf6DaQLUnv8xBXPQF7BKTyjhzLLh8DwunNCw/tZ2qU/9brC0A0vT3GQ4tf92rcZyUX6s25vab2dlp36MM7eiIC5hYU8vaYSo9Rh28jSsHnmRVdYeA/8wNyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783375232; c=relaxed/simple;
	bh=MR//AUJFpSVzyxokXobc1Pj3ojV9uirrrJFh0I7MFXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h4LPmq0lxzrLfNkKyhxponwu0pb1JVwj3q5KNKYLjq1gh52It3Uojn2uspZjnVKMktwbZBXLw6nxK7hzRR+ogDVwbfb1SXWi6ipdOaiEW/T615uxXnT0RZw7MwkVT1uOCAKGVldC80koTsxEF1Zbt0PAdA51OWUPdweQpOgmcTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nXloEUAu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=It5ZeS4m; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nXloEUAu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="It5ZeS4m"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666KECTl1504997
	for <iommu@lists.linux.dev>; Mon, 6 Jul 2026 22:00:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UJ9CchBYgkba1ighCLzdrX5XHMqvhwflUCwUXgnlH/8=; b=nXloEUAus6N2V2gO
	A1DO4owpicH2FzAcrxJEyykSEBlIYqyCSXQsYFhlOY3ekVtKlmFjCwGDAHl+EtHq
	98SRm2L5V43Ueuu/GmeTDoJd2lQJ/0sjTRpiz+3bYYs5JeZ12/FNmy/jsPMXAU4e
	5PRAEAi+2m/qIJHwvyXpy8ZSI+XeRWvH8HTqvvM4q/WWGD4zqZMtX0K0iQ0ZsUP4
	pfP8AJHTtruE0TAYsG/HSVdadfx0nKINjL++ym6AkwUdSjxH3DKrF7SkqA6tuzs+
	MOo2jrIpOfdwVmlFBHPn0FtH3N+YRp/zYhGUd7828HyJIeeM78i2FOrdk9RdJnt3
	vyGHqw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a98jym5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 22:00:30 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c88ad1558f4so5805355a12.2
        for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 15:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783375230; x=1783980030; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UJ9CchBYgkba1ighCLzdrX5XHMqvhwflUCwUXgnlH/8=;
        b=It5ZeS4m7cAswPaeHlOK4mtdmn0r47PzmIvjqwqONQqtJFnHYxORKydVDGpRmNIFUT
         X3gRGqP3g+CHI6tZnSmsiaOzmmpxVDqLbonsfQ1JOn8bRP9ULSVQcSZZT35pl8WpNDVN
         Ll2J4t7JTr4m0faR19jtZYNHPk/x8VtFChyvxyiMT27pCGGUyywPmmxXPmjdA5kRkmDW
         fdU1k3IgKxlsERhQ+iikkAElnqcgXWZPHDsxwu+gNSdf8ffvYFuZerq98xuIKS1lXCZl
         6se2n8EjKx4HnsPahJ8dGOKm09l3XF+LaU5rZkw1jBJuQm1C2PAOVTMrKACwYBkwWl/x
         yfGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783375230; x=1783980030;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UJ9CchBYgkba1ighCLzdrX5XHMqvhwflUCwUXgnlH/8=;
        b=U/XC0JR8QkIJId9NMSghb7/6wWtOQzi6Hh8BgXeoG0ulet4I5yMyHImj1cBj/U5vRX
         vwNvkx5J2pWkvO8YTrcWwmnjGmMrNHbjUySMc30df21IVtniaLvt8ADic+hfnBq4Toev
         l3Re3EXb/wEJGOMlcTiLrFTLczSJ8XyOjflDU6EzSIWkAayYr4vMlwWYZikE1kd0xShN
         GDT1lb+hmZB/EaQR2eMJqS3NA58d9Zoip+bSbtv9rH5n8BRdb5ArEEc9onlOgDiX+RUR
         fBy3SXe/OnYL/cA9xO1r6rHSS+xja1+PCW77gUWb+bISUmkkr2MXUeFYvVMLMidJYFel
         Ksvw==
X-Forwarded-Encrypted: i=1; AHgh+RqYqluTkgoLfvxJMwIB29gCHtG4LgicjyxJMmT9iBdtkPf1jDMjl9apqS8UyO0GFNgK/csx8w==@lists.linux.dev
X-Gm-Message-State: AOJu0YziLAp7bYAH1JxbKIy15gbZgv/+UUW3SfrWNNorVBvolYrUK/qR
	7cf/VT1+rxfWKe+axxrRxGavNxBJ3GPBPH6FlgJ4xug/FH0WoNbHkddXL2GnuFjLpd2hq1cyOTo
	BKXh+go+0DKzYntX8VR7TcSs0JWfjupuABiq+stNnKjIIM1b/yZmHBLrK+A==
X-Gm-Gg: AfdE7cl7NPsqbPWanMX0hd7DtRAnBssUgriMUk2BQQov+9CEwBG0vMk5qn7kJ/8HkDl
	BFrxt5LVu76YFTz1+FgLYCpOLcR7sIK446iMsW2sT5wubhRbZgRYceqmHEgf9T95sXx4zoFLlHF
	tS63H8VfPWMI8VYYUu2+qEUW42iC6/DkwfaQTlQ6BnXegKBwElXS2g/SF+4Ex0d24jqJ42CXMOV
	yqncxzH/NSvorPrOhcExvDtPgUOdK5OXyRYv9ic7pxJsjvLdoa5y0n2LTLYyVU8f5or10B2rf/z
	X++anO1aT0zGJEFCB3jWXcTFbehHu650eKcq7C3po+K82r9FaNw+sweHT2TccMV9XU87mY6/AYf
	F50cpyr4z6qWj/+krsqJcuxfeweaD3ClVL/I=
X-Received: by 2002:a05:6a20:6a0e:b0:3bf:a0e5:99a5 with SMTP id adf61e73a8af0-3c08ef84c1amr2736394637.47.1783375228969;
        Mon, 06 Jul 2026 15:00:28 -0700 (PDT)
X-Received: by 2002:a05:6a20:6a0e:b0:3bf:a0e5:99a5 with SMTP id adf61e73a8af0-3c08ef84c1amr2736318637.47.1783375228354;
        Mon, 06 Jul 2026 15:00:28 -0700 (PDT)
Received: from [192.168.1.9] ([106.222.230.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659c8665sm693268c88.10.2026.07.06.15.00.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 15:00:27 -0700 (PDT)
Message-ID: <10e4f102-3dc9-4fb9-a6ba-2dfc23a16df3@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 03:30:18 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/13] Enable LPAC on a7xx series GPUs
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Anna Maniscalco <anna.maniscalco2000@gmail.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
        Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, iommu@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
References: <20260705-descriptive-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com>
 <mn7dmfbyt2hnvlb7u2vnxurqef3w45rrjanhkd5ei65sgasfnl@l73s4c6yqxbe>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <mn7dmfbyt2hnvlb7u2vnxurqef3w45rrjanhkd5ei65sgasfnl@l73s4c6yqxbe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=SpigLvO0 c=1 sm=1 tr=0 ts=6a4c257e cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fsdq8dFr2Uux402FS9br8A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=TH67rrwzn_JHXtltAFAA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyMiBTYWx0ZWRfX8P3zMAojbtde
 WROoc25YRVKVu1PJk1QTgOKIb/jgzCqd3G78mtsersAw054boCvlBwfNZ5GbBNa8LeUuGq7b+w0
 M9Dr9A/GTlFXSBMVJAggN+d6timRvTgeWI99oTwnUnDpmZTRYjVjhRxM7/T08B0pXRx4obfFfZ3
 iCRXzOiayg3fkc5WNEK5h970E+h8hw7EkyHBc01iOgjT+bRpqefHl9kOsEBL2MjJ5xCHTZUAdVl
 InMrb+e3j3LJl3M8D7lmYcIH2A+0Xma3b6weC73EX5a38cRQGZinUzo69tTZh/9/4eZNj+cQ2dJ
 LNtUm4CTUQMgepSRbYwO3t0Tm1fOuaAhwf47wMgUGamZEkNKZZin+J5cboHcs409gtEld7HAtlB
 oYMZNoFU1m0YNnSH5H1AXTFVeyhC2ue8Lai1gGRujhn+RpuRHz2Lh9KCCphtrKTxaYmzSjVU8uy
 D7/BCbS1YKzGH/SXiXg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyMiBTYWx0ZWRfX/mWlgu0paD5d
 ExYghbxNYrGCk7PvXPmSaYU466qXyJRHHwD/mdVliM4WiJy4iGFeKuu1JIOuyGn+PXbn8sQz1UK
 3XW0+xVdpkS+rm3hKLEytoSw9aElyLg=
X-Proofpoint-GUID: l8UfT0hoXmWvbsJKD-T04OJCC2p9zvEf
X-Proofpoint-ORIG-GUID: l8UfT0hoXmWvbsJKD-T04OJCC2p9zvEf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060222

On 7/6/2026 8:27 PM, Dmitry Baryshkov wrote:
> On Sun, Jul 05, 2026 at 09:13:34PM +0200, Anna Maniscalco wrote:
>> This series enables LPAC on a7xx GPUs
> 
> What is LPAC? Please explain (or at least expand it once) it here and in
> the first commit goes to each subsystem

Low Priority Async Compute.

-Akhil.

> 
>>
>> Currently hangcheck and recovery are broken as the patches to make them
>> work depend on https://lore.kernel.org/linux-arm-msm/20250911-preemption_aware_hangcheck-v1-0-974819876819@gmail.com/
>>
>> The series also depends on https://lore.kernel.org/linux-arm-msm/177919116291.814652.1720687887970998122.b4-ty@kernel.org/
>> to work correctly.
>>
>> Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
> 

