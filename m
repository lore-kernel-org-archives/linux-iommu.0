Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AC51D9A54
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 03:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763005150; cv=none; b=P02/7v2OOvRelhQeIN62QZ8jwgvmJHy1j5khmUeflDp+pfY/6plPujKLzyWSuvlMMbzKhK6hLVDOs4/HvC6RI4KMm+qvuSEiTaHQNpFE816Bj9qJai4UKKwl/UqrWmlmzPYeeIdmpjOWCSNN3Lj06d+D0uIxK2C/ZsHMR4bfgZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763005150; c=relaxed/simple;
	bh=6M1vecMqKiWdmjUo6/b6CpU1SEobhoEpqL15kBJf/kM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AsqDSO3RyjiZuJUuTuw9q4IkOPeyuSdYQQjWAck4lnEcVQ6E9dJsZ72krIK5PRaAqq5ojYmD4M+WBhigOB1NjYNd7JvFPblsTJnSjEQGNUa6KOshWEpw+fb1gnW/F2POeUY6UDrnRT51mLjA4RVTf9Lu44NnNEgT3IkXnMK6Y7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E2ibn0Ny; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KuvguEus; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E2ibn0Ny";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KuvguEus"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AD11E7o2869247
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 03:39:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=V6gfFLOMNYMkWUfdwrHHvmuf
	2M4FWVMTiIkqm7l+1fA=; b=E2ibn0NyZbA3Ts+3iEG8rYsonyqGqBzb7Ro76wZb
	zZI6L5WNFI2zNwHFMTt1D3mIn9JJkfiezHMBwBbUCufUcQ52HHeuYSd1IGIbgy0/
	i15vALVjKL7pBHbSItp4nT4HPtQPzOTuiTWmS2Hahj0/nmRjhSWHhrTIs6FDus2Q
	zUTOp36uw5ratHgr1ZWk47v6meB2RtMc4I6Cr2gKtG160X3rO12oU16zHLyahNMu
	gut8iqAP7KRZaFGftoPYKn9K58Li8a5M9ARctTc6gEhu6JIYX4PR2UfxXw21WY1y
	WnAKCz9A95GPo7BfBo3BIX+rps6T1yMgr1Y9Bf3lr0zBzw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acqurb23u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 03:39:01 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8b23a64f334so146898785a.2
        for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 19:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763005140; x=1763609940; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V6gfFLOMNYMkWUfdwrHHvmuf2M4FWVMTiIkqm7l+1fA=;
        b=KuvguEusE9yUPrPXoCMo5HU6drKPL2/FADVs3PIp0DUpLPghtBY6+X6lhVw6yeUD7Y
         nYZIMBL7+Lpll/OKqhqXTlOKzLnk6LNBG6V3jYZyy4eWA8pVtpVt4UUmRDWpkvbuH2y9
         S9Xw9BYsIFhOJFmnDMFrUY9QEfzELsFAb12tTdXgsweTfpab/BoHmzVfUjLPqUPjPaoS
         FvXDLdxiCpgbuw1U2owsnxt6v5qeoVttVkMBQ+qRDydTwiCxfDusWSCy8EhuquH7zTmA
         IjOtwipdSUzlXfzQd7uuP6inA1LYcsTS63gBJ6xYgt3Ho4ZQfESSXj3i18SlKqLvkW5Y
         QWjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763005140; x=1763609940;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V6gfFLOMNYMkWUfdwrHHvmuf2M4FWVMTiIkqm7l+1fA=;
        b=eSZV/pRb0XGGDGKq13bujqAAa+rz00Z+09pdkSSLej0f2xBlIlFyTGJ6JZEusOU4/P
         c+xF4BzMt/v4qNd2uvVFICAUa8J7mPfFPlXHqfBsHNKtmgV0sstWM/sbb8zqq4XzZRFj
         4csCQ427MDxN3i6DO3JS4oVtyVgNvfIro3+ZMYZ8GUvkgKD2AbWEgPEm7hkT0p6citkr
         kB80OdvvUXA0FnWRti9wmR5EQmAPsQyBvVezhRDSxH9jqibGmBGLrFjD870uTXPG9OuQ
         h7Y26FJQtUiTt2Y49v/PuYFUTogl6XFRxapimAX9zfA4RNp4xUCuCHDwuzE39aZeLTGf
         JUiw==
X-Forwarded-Encrypted: i=1; AJvYcCWmtAacoI4T37QBzOyFIbo9dd/JPOxMTLm3Sh0+pQmloPn8bSKHY/YLOB/pkHOiXNU2ZWi2lQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw3CpGvc2Y3jWV/sfxkxDWXbnkMD35Fe7NZZlWbQbcHnZ4cNCux
	vRjr8oYX+GIhYzhExTHdzXShvoU1HpqIiYRZiKp8sv536iEGNaZ5p3Ab1Xv00Q75lmqSn4XyR3j
	dg5REBoZUHTACBueZAIs+eQ+p1AWTvadhgmRGqSjL98y5AJZz5yhyceZOsw==
X-Gm-Gg: ASbGncsKJjWC0+cZ7UNftA5GnAhNBMV/w5cjuaAg5A5vEyW3dag6v4nA4FUD+ujMMAD
	dymVAjGLfiFlPagPl0rmgKCbRIFgDIknKflzZobqWtJYh0xcPxzIPCAs7kPb7RI8lnd4fzjx6tB
	aE0WPg0ayqKU2r7NE84Pog0eux7y5nlk1BMGvIs3Gwj0fWvUCrr+aEd4hh2PyCSkoFpaJA0NiOh
	YuGXpvPjUOekSE6kpr0B/ZBeavttwmNe2uidMUadb8Ec7Rf0Belprhva9znKBEp/SBl96cSBj3J
	//WVmMJTspbUaAMkaOPplTKigE70lU7YoC6TImEJrmefKflQA7qfO3/X3/fjHTDFULKvPClTAEE
	yLvjktU8RNal+HxlLJW9RAQq8RCqvGMcQrBhxzGKH4f62zfQE3IBRZhg8Fgj30SoraNDrFqqcx7
	8jUfJ8t3aOkAHX
X-Received: by 2002:ad4:5ca6:0:b0:880:541c:8243 with SMTP id 6a1803df08f44-882718ce64cmr59684756d6.1.1763005140616;
        Wed, 12 Nov 2025 19:39:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLs3C0c93KWlGhuQL2zqwisxhLVaS3eXXtyZ+U1XHiyIF0ajQExCpK2eFHj8X6rYEd79M4mA==
X-Received: by 2002:ad4:5ca6:0:b0:880:541c:8243 with SMTP id 6a1803df08f44-882718ce64cmr59684426d6.1.1763005140130;
        Wed, 12 Nov 2025 19:39:00 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-595804057b0sm118302e87.85.2025.11.12.19.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 19:38:58 -0800 (PST)
Date: Thu, 13 Nov 2025 05:38:54 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
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
Subject: Re: [PATCH v2 05/21] drm/msm/adreno: Move adreno_gpu_func to
 catalogue
Message-ID: <os7rpbynyoeolwvbrocx3yrrxzhextx3srywal2i54jj6dw3mw@n6fbt3pzjvj6>
References: <20251110-kaana-gpu-support-v2-0-bef18acd5e94@oss.qualcomm.com>
 <20251110-kaana-gpu-support-v2-5-bef18acd5e94@oss.qualcomm.com>
 <28d62905-c191-4c3a-995e-a4146ffce619@oss.qualcomm.com>
 <12e6f588-e422-4803-ae14-56e5297e564d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12e6f588-e422-4803-ae14-56e5297e564d@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDAyMiBTYWx0ZWRfX2WaznPXZhubW
 2awjjS74j9p9tZMccNEOFW8/Z6ZQ1ucG8wM8Xcjme/XN51WYOKQvXderabhTBg9t993gybb/epX
 /ULJgr2VoE/V6LZWaKtFIN3tJBd5HN5CvcWccZ19FutLvEO0YGdjKPPl9VdkuNVikLDKaSjvsg7
 sU0kYVHlDzAI4of8YAbUPFyNWyv5RYTgnJ5Ul8Ff03qSUVVWbj5NL1yVqfFMFSxb70V1J3pJmH4
 jfNA72VmKUNjhhQldRBO79rFRXblwA3rGLp+9KrmcF9vSaeySW6VXNNj6PhSMOuzWMiWXziBDIH
 hhqngKRDg6635ff0nPzjECrxwPEsPZWV+sGEWh2CDooOr8RE0ihrwQS1ghwiFpZfCB/eGIQMvVi
 td+CFmVsW+alcgg68rTqGztkt4SFWQ==
X-Proofpoint-GUID: Ih7xOKaFOSVJOwSHSph26i8Z0YSYRXAl
X-Authority-Analysis: v=2.4 cv=bbBmkePB c=1 sm=1 tr=0 ts=691552d5 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=CJ44idKeuHZi8Vt8iyEA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: Ih7xOKaFOSVJOwSHSph26i8Z0YSYRXAl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_06,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511130022

On Thu, Nov 13, 2025 at 03:32:51AM +0530, Akhil P Oommen wrote:
> On 11/12/2025 3:52 PM, Konrad Dybcio wrote:
> > On 11/10/25 5:37 PM, Akhil P Oommen wrote:
> >> In A6x family (which is a pretty big one), there are separate
> >> adreno_func definitions for each sub-generations. To streamline the
> >> identification of the correct struct for a gpu, move it to the
> >> catalogue and move the gpu_init routine to struct adreno_gpu_funcs.
> >>
> >> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> >> ---
> > 
> > [...]
> > 
> > 
> >> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> >> index 44df6410bce1..9007a0e82a59 100644
> >> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> >> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> >> @@ -683,7 +683,7 @@ static const struct adreno_info a6xx_gpus[] = {
> > 
> > Somewhere among this diff, a619_holi needs to have gmu_wrapper funcs
> 
> Could you point me to the holi's devicetree? Currently I see only a610
> (sm6115) and a702 (qcm2290) uses gmu_wrapper.

I don't think upstream was ported to SM4350. SM6375 should need the same
hook, but I don't know why Konrad didn't enable GPU on that platform.

> 
> In the driver, adreno_is_a619_holi() checks for both 619 rev id and the
> gmu_wrapper.
> 
> -Akhil
> 
> > instead
> > 
> > Konrad

-- 
With best wishes
Dmitry
