Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3678A42F6F5
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 21:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783373298; cv=none; b=ntRZNCpEx6ENPh9iFtSVx2PEJwUDG1juhFttcxgUVDl4WH4u4WSNuuB5K8ebORGURiaxCbJxnFfcokoPM6PhiGc82afxOHZlpxJ59p2QMmrjJr/NZ7/yCSM49KGDMvyTrGVdq5Vud0ZXnpmOqha4gAJYTYYbvG4AzGIUlGzXc/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783373298; c=relaxed/simple;
	bh=xBAP7/h4Xm6qU6HLtUx5hvQdnXDTTiKJcKcvQQsAeJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NzV3lWzRppD3qb40aQyxcpEOA6gSgGrY4nh0kQKdTRjaIEr/DwQb7qlLF4rv80wtwN28qdYYUf4Ork5jpWiXlXfbzJp/IuTKu5XXAaTEL1trnIFXat9S4Nsn+GHeK9udaUFxOtUVO/K2vjKEosn+Y61uKAqthDL9hLC+w9LxBcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B6vUTsF+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LsVK7/+R; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B6vUTsF+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LsVK7/+R"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666KEO3D1613962
	for <iommu@lists.linux.dev>; Mon, 6 Jul 2026 21:28:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XVyKUn6Qgeu8Cw9tv/zF53VSVfQF2ch+8IMvAUMaMtg=; b=B6vUTsF+PZo2s8op
	k91yrrH8BFLXGcc1v+dH/Y87y48/xr52B74MZi5C5tje3zjT50YWFG9LgR5OFtoj
	uZrN7jvmayh/z0oeFDCqXT95ZjU7vAfo76FtEQpevDbYtyoExwqDWadJCmmPwgTc
	X+VB1dDee4x4WOaXZ1LWivrvuBv7hagIygLM4VZwgi+L+Zc8stvPbySIbh++poei
	UNgwUeZDOlZ1IgxfltcCPkwhSNd6fQYwfEhuzWUHmZhj//qsu3VpZbg+YQdRF0/v
	XQgqErqLYI0rzGYUWqLwQ8gYh0IDHmtYvPATrhY3u2NOpORD50A8YO+sRN7Z5QAU
	RtbGIw==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88h53bmk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 21:28:15 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-737d34a0dc8so3759639137.1
        for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 14:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783373295; x=1783978095; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XVyKUn6Qgeu8Cw9tv/zF53VSVfQF2ch+8IMvAUMaMtg=;
        b=LsVK7/+RocUajU7pLsAEcUqtnXmzKX+QyuojUSJ4cV28Hfzc/Bfs1OuXd7AYftcMFW
         wXANzGOcwS8q2wQUOniC3avVr2Dl704J+iixL6bwCBFfpBWmo18zSijr8RWBlOCDLNr1
         cU1w3CpLQsbYEG/31QmStPd9thFoR+w6/vKW1FYJ9FRXzHPpT371ZUg9qZMW/uhL9CCA
         Jtd5IErAdyrigGxKRKryVP0OxkKxhEOaGK/57je91Qxyn0nxHWOeWCYrptBdYd8M9Dlg
         AZiYTCUFuZAr7XhyWyBTk5nF4Oiap7MKutxkf7zvYI/HiuVU04J//OwxbqnYHOrtvB0T
         w7Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783373295; x=1783978095;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XVyKUn6Qgeu8Cw9tv/zF53VSVfQF2ch+8IMvAUMaMtg=;
        b=TfL+ssJ3955iWSoyGkoEHeJmC8m5OLddoqgjarRwqHfqlP5ZJyOCNmL/E54SFuUICH
         /epNM/YFSTpwDh9RprILm4RD/0tZu0p24dVVFq+Mj/fUuU2lDYrWS2aonwXzGy8g34wE
         c0kXdBy5DstYZbD3KN/TIs2ZefrAFgWBy7TEbv1uZjbXwOn4GUOGg0wTeBvbBvjbG5bW
         EdDI7UAx7usocDdh8WGRrwiJ5RCRu2A+guy3enegs0LbcK2g628Yz4d+oBloqyRY6lc3
         Te8bZLyUqwr+IBNl+fbnoD9ITZnTyCsN2VZJY1sW6C6RZ8T4aNl4NVgQGs02/6nhuxFM
         Ktfg==
X-Forwarded-Encrypted: i=1; AHgh+RqzSgqzg7uvuQKL+XRBlDBV6CjH09aOqeIZ1AQ8vhworSpWE+imQno260aMdb5GupEM31dldA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwMT6pRGlhsJbfp/ZUkSBu8nf50ReEQM4lCshOds4Yyrcgn8l6k
	dcvVkVW6i7BeNM3FChasOZh+HIOeMDiW+QIi7iJqH88PhZ2Hk/U3lO/2zhnSoAc0CCB9HemXXQT
	FPPCBht2ADMyqIBA20NFAEyOXkhMMllB0V+/QkEtrhzfc7OSITQH3gcI9pg==
X-Gm-Gg: AfdE7clhlV8lw3Fc5zpeyhOhYlEsJpVwQll1SzsqDTyI9wi1A29ibnr64GddX1baQC9
	oxtd9keuxhHPp2SAruf2LyAW7e+urDLkm+l02sfkpsHTD4FXNFVYWA2b6DjrbonnJBYWHrp7TLR
	4kjHnZrKqALrga+5ZxI8LEil+PnuXZzAzPQLxGBfTgLMfsWLapFlFC2+LHHGGV7c/t2HXxsqE/N
	3abUt7vWXG7fgWkU7uNSOVrk/Hlj5USWrIaYxXHiBcBZLBUwgF7aAga1Uk1FFegsXMHKhMz2qbZ
	lDAkvus0awjPE/jwssZEJ94yIxJg7VuHNAK3DEGqannnesw6Q7GD5YW6Rtk+xP5LhHYDuKBIQ0a
	jhwX1k/begJRaeBpYh46fFxXHpaHLFUS82E4zW2lFcKAbrF2l1mMbzeMMFMv4zjniWPqg/cAKtQ
	KX9TlgrQabDgUl2nL76z7CD/+5
X-Received: by 2002:a05:6102:598c:b0:744:a3fd:410a with SMTP id ada2fe7eead31-744b7d6e301mr1160565137.14.1783373295351;
        Mon, 06 Jul 2026 14:28:15 -0700 (PDT)
X-Received: by 2002:a05:6102:598c:b0:744:a3fd:410a with SMTP id ada2fe7eead31-744b7d6e301mr1160536137.14.1783373294919;
        Mon, 06 Jul 2026 14:28:14 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aed13839bbsm3150167e87.35.2026.07.06.14.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 14:28:11 -0700 (PDT)
Date: Tue, 7 Jul 2026 00:28:09 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
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
        Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, Aastha Pandey <aastha.pandey@oss.qualcomm.com>
Subject: Re: [PATCH v5 6/7] arm64: dts: qcom: shikra: Add GPU cooling
Message-ID: <cikq6wyljzdlyuopvxno7fipifzc7f2zc6hs2ligiu5esnljui@5mxhammibgpc>
References: <20260707-shikra-gpu-v5-0-d2f373912d3f@oss.qualcomm.com>
 <20260707-shikra-gpu-v5-6-d2f373912d3f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260707-shikra-gpu-v5-6-d2f373912d3f@oss.qualcomm.com>
X-Proofpoint-GUID: EhefQusG2pcBNnUMI_-3zyHVuBSRy_F0
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIxNyBTYWx0ZWRfXxyInMksnJ0SI
 bqYVbs9ZQN+jetIduu97Xr0Vsdmh+Ucc+f/aI0hZvulMf4xQkognY4IwTEtDT4atZUFJlwBYV/n
 i9G6/Qq8cCjSVjTyLE0JRq/z7DN7Quc=
X-Authority-Analysis: v=2.4 cv=EPU2FVZC c=1 sm=1 tr=0 ts=6a4c1def cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=wZTYHpkevF83xUmX0v8A:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIxNyBTYWx0ZWRfX1Z1UDpCPkZ32
 cgFptCcdyh+lqG55IuuUdgShQM96EDHeItIJZDrsvXAcss0rdRpVuCKGYh/drGhoG+D2paDP9ee
 uPvaBMjJtD2S2vMhEK0NwJ+qbOPDs8dLw+PjhY2mYmJJN4922EDja9s90eIHGum4wR8D/pDUXBA
 i6q/MoYHbHtK8quDK9vfI497axQEb9aYa9XsDfZnGbQtFjqyYnbVlyrEFC0CEb92yhkbWP8U/gv
 EILbzz9b/2tsqvsCkK8Pxtq+eK1YhvM/gX9wkQpYyvzh9HtFIQgoZ30CoMXRzQJ2FT+brveIT1p
 nUT/65HUjVlnXHVmLjtUslHNHF0cdorfvAOYElARs+20vEESpdm3xvUw1gCGg4qEkWgJXppgcEX
 v/e+kFkw7w+bF55srCugfcqv5vi1+WHrxjLNhMAkieog96HeP69fqz27Z2xUdF8EajCA1ug/+kk
 TtOUuKsgPcy7TK555EQ==
X-Proofpoint-ORIG-GUID: EhefQusG2pcBNnUMI_-3zyHVuBSRy_F0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 spamscore=0 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060217

On Tue, Jul 07, 2026 at 02:34:38AM +0530, Akhil P Oommen wrote:
> From: Aastha Pandey <aastha.pandey@oss.qualcomm.com>
> 
> Unlike the CPU, the GPU does not throttle its speed automatically when it
> reaches high temperatures.
> 
> Set up GPU cooling by throttling the GPU speed when reaching 115°C. And
> use a passive polling delay to ensure more than one "passive" thermal
> point is considered when throttling the GPU thermal zones.

I'm not sure I can parse this sentence. How does polling delay affect
number of thermal points to be considered?

> 
> Signed-off-by: Aastha Pandey <aastha.pandey@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/shikra.dtsi | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 

-- 
With best wishes
Dmitry
