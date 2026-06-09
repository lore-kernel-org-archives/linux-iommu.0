Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6263812F6
	for <iommu@lists.linux.dev>; Tue,  9 Jun 2026 14:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781016863; cv=none; b=cZcAlnk17dzLSVqJFfGKBugdK0FR71/Ul/bWzLuJcNUxI4sKhLmu8PZ5FSKB+chKejz2d/X32hWHgNdE+tbpYrIJZVUB1VPumu2u0O2hif7hvF1jYRlkMIojG+ZPiaKQh0tChVABP+VRWvS2LCr2xqBBACm8PIfP5WMFiet4WoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781016863; c=relaxed/simple;
	bh=IFxoY1lnpcuapTUxgGM77p4M9Fy3Hl9fYDv715UCM8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TiuRpdmLV/o7g5nHlzZAQ7vEF2tBUxZsj81H6fTOQCEjQhrn1XK+fqektwAewO3PZinXRqx7GjDtnE2ZjIIsD9489GFx7H+MofD9Nguu9ae4mbp1WvzikCiw2pM/eZqrJIlYRb32VdYYtIEXGNytuKHKPG07HURFW/3f+7kH8f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZhkhebgR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JjpNOBc2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZhkhebgR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JjpNOBc2"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659ClJv32251616
	for <iommu@lists.linux.dev>; Tue, 9 Jun 2026 14:54:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aI77O8CJQYdLvJeOk6wk0XdV8aL27Vmep/f1OBCKYOw=; b=ZhkhebgR2zoqYeo/
	2xws2T09pgVBRSGN6bcoL8wMfMzP0WwjZfjzzjkSaAh/Go0QcwZJYrSn8tpBs1co
	NU70HdWw67A6X7XdoE/5DPUzbs2lEO/5k3Wy3tdvdZIY8RBSHxDd3uFAkBd1eCzV
	tL4E03OFGYuYgR4RBWv9aAGN0OPWZ6tQKKyXcUudwySqx2LuKyR0suWkw6RKRFlc
	xgzkwNBz3+JS3okCWhxNVkXB1PexbSCnycKu0WvHKkPcKpi1hyxt1IxA84dsYxJa
	4CzQ3HAqXsewSED+7RjoaqM3czPIC6TvUNn0ej5wXdT7ZriCSOQtQFSK3fYuG6lA
	KymTlA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epeqghyse-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 09 Jun 2026 14:54:20 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-517741bcc53so15430571cf.1
        for <iommu@lists.linux.dev>; Tue, 09 Jun 2026 07:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781016860; x=1781621660; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aI77O8CJQYdLvJeOk6wk0XdV8aL27Vmep/f1OBCKYOw=;
        b=JjpNOBc2RDT9fkx5RJdl84HKVhH2jgteQr4J8xGShO6lVGYjJoOa5mGSgyUmXgOqcc
         PB3u0CX9ncU/EAGW+bYePzmcFhmMkcvz4wB6pl6+dbHrL8BBUGKXVfkziWI+3D3aTfU6
         FCaSTBEz0S2JYjxgYKiCaHelFJvjl6Ot+dbQeEAK98LRxlRkAdgSc7IyiACY6ByFnlYW
         JGRRC1ejQQHt+LnfnlYOGoqs3wDJFBaINQGftA4LKhVE+icx7CGsVerDP0ECyOEIBUPT
         hfY5j1pHjTy677LoSPYdcd/I9KXwBgtvCXtzRcKmvYXJOuUyS9b7Wuwh2n5VJwMBFv6z
         pN3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781016860; x=1781621660;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aI77O8CJQYdLvJeOk6wk0XdV8aL27Vmep/f1OBCKYOw=;
        b=hpAX6jlv8elUmrlUgld5Z++Isx5MSwjI0yjHF5Vdk6gHsQz8riqRHN9zlOWc985R6T
         L2CYEr0pfjf/cXOrtcUC8O6HkVUh7FW497eqDGKm3xDDJBoZIzlwgpcZIc5NABLuBgmz
         c8kRb+F526Q2+0yb8PDdkD2u/M24h6kWTe25ao5D4D+SKWSunCj71x//FM5vcV7l7Uid
         FOtFrkMr73ksqSBiJAti1ma7pl6OfTVXLUBYZhrcN/lA5peekZ4N+faPgdLsxGGsIzKW
         Xr/lnBhoD4vqJ8Ls3E0xhQkq+BPMkqvpFe92a6n6UhQgnBus/eqv4ECnpN9DuJAsq527
         WxTA==
X-Forwarded-Encrypted: i=1; AFNElJ/F9P/4W9eLKXB1WVZ8z5nTAChKWxtHRzif2IJ2Yer9CJzWEFkMHMlDRGYRG+R0Qo7EsKkbOA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzYAUL5K8jwtTsDfi19OydquRPHMH6VbfshwVNRUHtk48rLc5hx
	cT1rgWOtb1OxN7zQDfpBNZjqJHRANnNyAKrLQDb8Sk6TNqmmiytmkShpyrByzAYxJfvFQ+jL31X
	IPu1FgZGbrqRb2FSMZyEhhge/llRDW2i7NFDENddtoJn+BTTJq1fMRJYl4A==
X-Gm-Gg: Acq92OFOBjn+hVVEta+BjylpNtmtnz8GoLSO23ZXbWc1hYb63on8zXtflRj7qptHkEF
	Cn7npuAjGkQmxHzXiWg9Ph4NxayxgeDlTpZ7U5yELVN9+gBVBRwn2FcWJjn5haMdTRu/sDP+NaD
	tqeX8+qxebTR0jRUYDkufO6QUCQLJBdFquhImkVwhO9Abhmke7Q7z7Jksiu1EvclVWwuiBO/AAi
	D0FNE1pzZLj3gP/pTownUeLQ6XtiOP56hS/3h6A/jzYr+pTJ9Zekvkn9Y1dxpFGP4k1ZQ3SGvrT
	S+nM0I+Ec61ZeZNBjkFVD7dhBRGd8H8edO6rAIBuKEU4Uxwl/G8dSHiLiVOEeuBiD+EC3LnxHfB
	kuB1cLE2FHMrMjuyPflz72IrmTuIZqjQ00noB15j90EYUEs69+oD7mc3Z
X-Received: by 2002:ac8:59cf:0:b0:50d:9138:3322 with SMTP id d75a77b69052e-517ca478a9cmr25292171cf.7.1781016859327;
        Tue, 09 Jun 2026 07:54:19 -0700 (PDT)
X-Received: by 2002:ac8:59cf:0:b0:50d:9138:3322 with SMTP id d75a77b69052e-517ca478a9cmr25291561cf.7.1781016858752;
        Tue, 09 Jun 2026 07:54:18 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf055307a35sm1053926366b.52.2026.06.09.07.54.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 07:54:17 -0700 (PDT)
Message-ID: <604e0428-61b5-42a2-b6ce-a2b071378cbb@oss.qualcomm.com>
Date: Tue, 9 Jun 2026 16:54:14 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] arm64: dts: qcom: glymur: Add GPU cooling
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
References: <20260522-glymur-gpu-dt-v5-0-562c406b210c@oss.qualcomm.com>
 <20260522-glymur-gpu-dt-v5-5-562c406b210c@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260522-glymur-gpu-dt-v5-5-562c406b210c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDE0MiBTYWx0ZWRfX/41eJ5wA2my3
 i+DPAxiY97UBQKUX65x2X86iYCuJQdBU8oqmDjlrbFZqAddIb8S44HB9Zsmk3CKEPeOGBn4hFR+
 NDnB4XRo9bLDwRe17ErzPLK96zP4fCRrCyCMdptnAPrGcJFm9lZVP0t59pBacMcOWR1yx8aGqo5
 I0VClzlZLy4m6wpSgjnBP2yFTwvJo9n+LvnJVabyFJMJYCiLg2fb+wlKBJNfJXu/Gs06TYL8b50
 F9SayXJQ57SP+bYZtLZ2evaYbqPASUJrnoOCE2nHRBJg+JKKNDdOizJp0nowa4T/TdDC/m5+HRe
 kDgDrjs0Onu85usIyjUfszCVMfTuS7bmk9YX0FrmzsnkTvusthBL8PqeTc/nxFQXuIRzXNRH7Tb
 SpUVFYvyx+GaAfv6xdsF4pzDDFiNuEasXLV3wa1x91rlxVkehNC9Vy73i2jo4DI0hy4CaG6nQU4
 QpkA7qZn+gJVKChHGVw==
X-Proofpoint-ORIG-GUID: vZre9C-CW4zBqCU_RX1yGxlGgNIs0bLA
X-Authority-Analysis: v=2.4 cv=KdHidwYD c=1 sm=1 tr=0 ts=6a28291c cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=GwzMoqaa5OBlIbEppCgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: vZre9C-CW4zBqCU_RX1yGxlGgNIs0bLA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090142

On 5/22/26 12:12 PM, Akhil P Oommen wrote:
> From: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
> 
> The GPU does not throttle its speed automatically when it
> reaches high temperatures. Set up GPU cooling by throttling
> the GPU speed when it reaches 95°C.
> 
> Signed-off-by: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
