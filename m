Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF903859C3
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 15:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783350291; cv=none; b=QqAbCKBQb56jUH3gro1r3ytp74qQqRZkHg3usDWnqSY8lyiHuhEU8JKHQNtDFzcnWRAHEjJKGpZPJ9h24BTKfauseQrirms9flLcFJyUFz2LoOBoOsLEGlBTBBXBJ1ceCMapLB+F1Nok0Zyj2VGE/Ss89CC02Dat8hVL6INqahI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783350291; c=relaxed/simple;
	bh=X04LUYsxaMNzhkdqZvMTj/P9CJGwCl0lEAN/gR2A8r0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ezb3RbEJT9cJ5erJNz/Fo2/w5NKGtEEFvdTs3snZiYTETgHKGAHJKT/f3lJLzFMAeWgNqRdmY1QAGaSE1W907sp4ktp2naH9lBUlTU2who/GdsCl/lxHJp0Cf3fir0mU7SFsBpjwft3UK8mF/pU4KHq2++afOFfkJB5hXBACaJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AN2GHhtm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Tjq/80XQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AN2GHhtm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Tjq/80XQ"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666EEA5R757498
	for <iommu@lists.linux.dev>; Mon, 6 Jul 2026 15:04:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ca2td9+EyVlsweraoMntmzjY
	hSdPbwsqF8kFzfiyaX4=; b=AN2GHhtmMMxBmwhxImr+fE8YcEtR/M0eVlKUqV66
	oveiQyg3nTu2wZ76otqvpdNWss7noUClU42QGos4EFu7VQ45pPxoEzw+nEbb7gtZ
	ucCyHSsB+Dwx9kIiLWf7SSS9Xn03PlC1Sr3JRro1hzjF/5fC8BR/fXRDI/lFznfm
	an8HJClriUnfgVKmtNWH6tbqL9ARkTzeCVTDiXnHojqMVfDGGz27/RYhPKy1jpD/
	uu/iPvQ/cN+PywxEzBuQG3qJEgH3zcpQ2vRLikbfVNLFUMjjglMMnA0Tkgov8fOi
	qX9PpDojdZEesiY4S09lTIJs6Opw01D8MlDxo05HdA/6EQ==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f87q7hyud-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 15:04:48 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5a83b662fb8so4695167e0c.0
        for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 08:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783350288; x=1783955088; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ca2td9+EyVlsweraoMntmzjYhSdPbwsqF8kFzfiyaX4=;
        b=Tjq/80XQjrMthnmonUeWXGf8WtCJKJFOdci8lT/6jlg6n2GRjgWW0zv7jhPD+EQ2dG
         BH/Z7T+9GrmuCRJv8f5iRSzVnUeqixjFTuux43abXMn/Lx8D947dOLf+FhB/4IadHIEj
         TnlN5/ek77D/5Lnt7DTIzqlnjauyS47iiXL9hYB6O4IHTJd06qyPJyeHiTgBWJ0MAEdK
         kzsZUnFlnkfxIWwBWPINICROMlzU/SrNptdJyu9cAgNPiiwkp7GJd+4Frhb3X55aCYhv
         Vnmyh/mIqaZmwi7hv28DLW63eo4KUVTFtHeiGtcAGo51LHmZHdqFqJmiYamUnwSwoRMz
         hzBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783350288; x=1783955088;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ca2td9+EyVlsweraoMntmzjYhSdPbwsqF8kFzfiyaX4=;
        b=R4yyAXfIqy9KIbQAmQg5cC1a4zAaPZZx51tsChXHAoI747vLmER7ztZJwEM03Jf7lm
         4yg6UEyyHtMMGFXNXtxDIbRdG+vvFqJ5SZ9Mn7az4SEm8AtWEP3AHf3VFGESDSJd9AWL
         9lpruFy2yRSdOOeMTMAp8wCtROmAinzmkIQO5l3Hz034XHOBsa00RdBhJe/TbqIIR888
         +H8ExLxmqCVHH/ECqTa9aL5YY6+x17zllnIIjxmjbivBPISUqIt+1vxKJCG6FJ3yWB3+
         ZMHZMSVQftaK9iuN5n68V6u6Zb0y2viK/8EcBkLlPKeD8w+eQTGOa8bT+rmwI1U04MS/
         +GwA==
X-Forwarded-Encrypted: i=1; AHgh+Ro4MpMVlVpSFdFfzK78VKMjxFwcF/9dkC5sgapGdan8IidC+G0bjb9EUUrz8XYt2zmtBb1E1A==@lists.linux.dev
X-Gm-Message-State: AOJu0YynVIv8OBGFczLXZZqZ5jvVmnM+cCPPMQK9FAFOSSM8V5PhozMU
	35fE8mm2Io6E4qKtpfwglvDMyw/sJqzNqI42rkdAb0koEd9hbedLJCSM+myynJUbmTUWKwr0nWC
	FFCMWe7VPnOwg3gN7DPJau8lrp3stqStUwiVnB83KU+aEmCwInBuSOALpvA==
X-Gm-Gg: AfdE7ckBq4ZPbURohf6FZ6DeqT8htKC4JLQUc/QRAXFfWWRX1iZP+xLHn+D1yrgW2mk
	7qFFI/XFe08gOoR2irM30x3OjDvU417NwnybqhXshEt6kqXwEP2/j4IEPiERWzyqYIZd58lkrdX
	rOT46ZjCe9PL6SjQLFF9yb1HBQtnUCn6dbCuK9d8aKr0cbwzsSk85NtS9u6pFfNRo3fDr6taria
	EhJAJ6kL5kKCxMdkz7XXF4Qu16yszNcdp6KXODxyOHGon8TgUA1zHfGDmoEjxzkYDNIpdJI1Kjg
	cUsyZsz3Dkyb6zsFnqxV6LLep0GpyrN335sDe1dXD/lTZ6IDH7MHlsSqWiqVl1kkdxdRuWhHo6z
	IYmTMC85JOcIThtu0UN9nEQ9wHUER9wVIibvBOhyOl8puzZKbI1Cv+KmeNO0tTZeDl64F1VTTXr
	W6G0k5YtcR/bV9CPqcC21R36Ow
X-Received: by 2002:a05:6122:c89:b0:59e:f727:4bb4 with SMTP id 71dfb90a1353d-5be90771737mr579919e0c.1.1783350288329;
        Mon, 06 Jul 2026 08:04:48 -0700 (PDT)
X-Received: by 2002:a05:6122:c89:b0:59e:f727:4bb4 with SMTP id 71dfb90a1353d-5be90771737mr579889e0c.1.1783350287799;
        Mon, 06 Jul 2026 08:04:47 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39c5e58bee3sm2046451fa.8.2026.07.06.08.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 08:04:46 -0700 (PDT)
Date: Mon, 6 Jul 2026 18:04:44 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
        Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, iommu@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: Re: [PATCH RFC 03/13] drm/msm: look for lpac from dts
Message-ID: <rwohvfbsw2brpxrfg26egu5arwe6g7n2etelo33eegmu5cz65k@3syofuxzsjrc>
References: <20260705-descriptive-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com>
 <20260705-descriptive-name-lpac-upstream-v1-3-01d50c3e0c99@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260705-descriptive-name-lpac-upstream-v1-3-01d50c3e0c99@gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE1MyBTYWx0ZWRfXyW5Z1LNXIZvb
 /O+n07QGW5hxDV6ptTiHy2s8RQBdnJNe0upKg9Evw91psbULXINo5LMePCZjx594JD+AVFXfd41
 adOs6IfkoKb//DwDE4pRNOnFvUgUYhW/f878PEDOCwF3YdfpWELxg8mt+FF9zDzuoR67QqFNgPs
 Zo5lHQlmn63QExPbx57x6s9QDnqV9RXCb/ns0CKHrGVdGeEGE97Xu4G0Hl0JGgy374lKgQKFUWP
 kOwMLA79J7WQ7kE7TXAvpg8gEM+lLkOT/0/I6lDi1WpqX46ZradYQpF4CNco9zZaExs3LBm2+Jq
 0HnlEurOivkrfqebUb2kmFcNGrIwBPfqN9nJcs9XUh0Jy5CujgngAQD+NnI5BChuEnaPWFxG7Ju
 WNgdJ7AGkxt5wTGNgmSenJAjOSjd0iF248u5SdYxdr2O/iZOijGCvjPOwdezmuxq5eJWBd7Vdga
 K0+6dznGkCSi6bByEHg==
X-Proofpoint-ORIG-GUID: 65RjeoCoiLA7qy4BOkOQ7_c_uCNKVhcd
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE1MyBTYWx0ZWRfX1CDW3haivkJS
 D1HMLN0+i8BMFAGDwHcT+0ZOZllOVkJvoO7+W7V5em2u6u9MW1EnWegHyNjEZ8IJBlHO3GhrQm+
 dXXU+xhQLdZsndskukNWz5Ahw6YMOeY=
X-Proofpoint-GUID: 65RjeoCoiLA7qy4BOkOQ7_c_uCNKVhcd
X-Authority-Analysis: v=2.4 cv=f9N4wuyM c=1 sm=1 tr=0 ts=6a4bc411 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=pGLkceISAAAA:8
 a=lS1fCJvthqzCmkgEd28A:9 a=CjuIK1q_8ugA:10 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060153

On Sun, Jul 05, 2026 at 09:13:37PM +0200, Anna Maniscalco wrote:
> In order to associate the SID used by LPAC to it's own domain and
> context bank we need a separate node on the DTS.

Can we use iommu-map instead of adding a new device using the same
addresses? You provide zero explanations, but it seems like you are
trying to separate a part of the GPU into a separate device, but it's
unnecessary.

> 
> Add the code to look up that node on initialization.
> 
> Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
> ---
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 21 ++++++++++++++++++++-
>  drivers/gpu/drm/msm/msm_gpu.h           |  1 +
>  2 files changed, 21 insertions(+), 1 deletion(-)
> 

-- 
With best wishes
Dmitry
