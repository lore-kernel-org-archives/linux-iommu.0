Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D00346AE1
	for <iommu@lists.linux.dev>; Sun, 28 Jun 2026 22:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782687235; cv=none; b=TA9LRVxt3mPvS04jZV7yZdVvWLSpaiNZrK39wOzjMW0CZDwpPN8svNyCygzj92R3VnPglotqvqbYK6L8Lf6kMFGlR/wYCLnGmVviUV5oqm3ljDRR8Sy9h4NSjoTIGubZu1ipTf/xmZKIjZnIKOyTpOXXRLeb4W5xTJwKHbgdDWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782687235; c=relaxed/simple;
	bh=OX264gNLBq3yKdzWgzCkw26t0180hmvjKHJeD5hHvOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LCxTBMYNqWjOtph5aiEcIT1+A5ID5I7G1zJduEfk8dxzQ7QXIiBxFG+GvQDB/boV040N+FD9J4m8bNgvto6ha2eRAKpdljSWRe+vKNICrtgPFo9o+Nz1GebnMr+TTiL391eRe6L+ONu4pUdCxOqnvMR6oHQexkuyCjKvmUClE9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OgyRgftV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QbM97ks5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OgyRgftV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QbM97ks5"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65SM9QwJ987045
	for <iommu@lists.linux.dev>; Sun, 28 Jun 2026 22:53:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=DBiYvBC1dJo0dJZFGs5nOgph
	H0zzbBFmjSIO8xEAr8w=; b=OgyRgftVx1LaUcLi7CbJ7X+EZmlttu6Nb5pxO3lb
	bJxsyhC9uxJQ04+QS2kRlpajNDb9m4gH0QjapQJdq2qE6nVwiOB6X0zNtRXWlzma
	vWBJ0+4UJsdlNq9A0a3q/R4DnN9sdF9OTspNoY+YILH/qzGxJ00Asq+jHUwNg0wU
	A8h1FMaS4ZLgpg46LK8NIe5XrA5WME7QOg+ojudFi67tCYWtxW4LeLc4714YbGq0
	mnm4n6UGdIim4r7n11O2Pp4ewPyScXWYY7zA0BUMHc8egGF2VeNj5W48pJ6K0C1N
	QcsyKoyri5JcB30vf4R2Ar6b3SbXVXuDOOV+lwQfu2Cu5A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f26x8kskq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 28 Jun 2026 22:53:52 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92b2ccd7971so473217185a.0
        for <iommu@lists.linux.dev>; Sun, 28 Jun 2026 15:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782687232; x=1783292032; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DBiYvBC1dJo0dJZFGs5nOgphH0zzbBFmjSIO8xEAr8w=;
        b=QbM97ks5/X4keQ7uV4fyi+gbxoqGm4S8pY/wMaZnCYVBA2Pw31i2MH9P5u5XZIxlAK
         fne1sqQk3PCrSASNSaTfphp12vhrjGvAz7C9ClOjxcSQjQI3+4ggE+1CaPiKLltkKyan
         VeIo3edzI58WohWYaORvcGWPMfS5V3AYZwmhsXDwUzss2xfrQuAir81I8nzdEuiR1AHF
         3vONUSYGvP4Q+6hNsiGy2SlAxWj149xhGG96GJjWcf4SqbxkehH/PiUGQixTqrIUEZ8A
         IiwhfgyKZWraapqmdfRmBOuySb45uiHJy7iWp4NWqhoakxDGlqdUeMg2Bprt4kUZAqgi
         tQ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782687232; x=1783292032;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DBiYvBC1dJo0dJZFGs5nOgphH0zzbBFmjSIO8xEAr8w=;
        b=DEmgVqR+BQBBEwN9zQpLWPZxe0FG/AnWEeWd0FutGbiSiS6pf1Rm0+DrXXYPXiEN3y
         RdoxOxh0Ke5ohUFMPXjElE7vjbSaZzjHBvGvmbCi+Rp08vXt4FWQim2oPj2W0vZFu0TS
         1r4Al1wOwsLTEwNoXv5J8TF7l7hS8K1SGtmKQanYCrPr/0b42C+4D3q7fm8LF+gehoum
         kjTfBQIph8pk5ZDjEj8RPZ0aA2Lt5YRSv9N2hoxwgHvjH8CS9JnyaNL/0XFOCpsru0qF
         fkN7SkrFO9XD995Ifg2TK4y08M+TBnkEurhqe0B6xTGLfwoYSmaYyyJlIy1UjLQzGqMj
         0ZHg==
X-Forwarded-Encrypted: i=1; AFNElJ+4ZEakWkZw/qQ8/FJlCvWsucJt2c1iezEpYBnaHehBskQD6PDYqq9u7SulFzkM/WFo8npdVw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywr3I2Y4+9rsrESWCJOaENIQ2LRb9D0Kui2yIJyT5xRTPYuDxh6
	d+WCNoFLc/AnxMV4cwH6mgFaBMCwVqLlAPqlXhbVfq+cSN8UtoYG4wGQRWGURt/rOXTjcZSIECx
	Pa4AKsGLuimJrh0vTNgLsrzSIxX0mIpcCiE19Gmnn87b3lkj+r5oMF9zCsQ==
X-Gm-Gg: AfdE7cn87TISeaadvUJfVoEij2it5GxLftokjRIVJVMddtw2rHh2rtLXSZcaJqY1tDt
	EGQ+a0Wr7pnDlrPl86Og59YNRcet79UUXf2O5/8EIHweBnqfdJgKvnsbo4Qiv3TMTdSfG/K5iNA
	T/KyghpJcP94KAnHD+jBT0YQxXta/GLw+PCBhh3ovW/jFY9xXLtDBqDHhWPhi1ikkrqYn0ATWBM
	NkiBZntYx64C+weIaHn96tpsquK/NYBzRPodlRvSGgA4Uw+L1uoYrWDNhesK9THG1zPSq2lFuhZ
	lWmU1LEG5jfu9GtwFJwKB5zTMfcI5r2sNlTKv9bCFp4p/GTwp9i+3ywjRsEuk9QOu7jAEiiPp9U
	li3rtgojtjl9KkQmo5Ct60JYJ/Hc1sRfiBAp0RreMk1tYio2t1Ww4pBI5rQkWslKlV020RTvuZn
	HHzOXNEokIKrhnD/p/pwtOMsC3
X-Received: by 2002:a05:620a:4405:b0:92c:3086:6d50 with SMTP id af79cd13be357-92c308679b7mr1003114785a.2.1782687232120;
        Sun, 28 Jun 2026 15:53:52 -0700 (PDT)
X-Received: by 2002:a05:620a:4405:b0:92c:3086:6d50 with SMTP id af79cd13be357-92c308679b7mr1003112185a.2.1782687231656;
        Sun, 28 Jun 2026 15:53:51 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39b134fb1f7sm360941fa.5.2026.06.28.15.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 15:53:49 -0700 (PDT)
Date: Mon, 29 Jun 2026 01:53:45 +0300
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
        iommu@lists.linux.dev, Aditya Sherawat <asherawa@qti.qualcomm.com>
Subject: Re: [PATCH v3 7/8] arm64: dts: qcom: shikra-cqs-evk: Enable A704 GPU
Message-ID: <2e7wfaejgbapxhmlxqne4rtxzcuyhijxns5su2kcr6k2do4c7l@3zdmkrtik4iy>
References: <20260628-shikra-gpu-v3-0-9b28a3b167e1@oss.qualcomm.com>
 <20260628-shikra-gpu-v3-7-9b28a3b167e1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260628-shikra-gpu-v3-7-9b28a3b167e1@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI4MDIwNyBTYWx0ZWRfXzoBHKCd3PWjZ
 d63PFnSLTTVZUZ+VP6cvCpfzN6x1GNelpYOeRKaA/X9haqeTXrnTmlbd4cLASpOqOfXxVU2XHFR
 jUTd1SwsH2pnSXGzhOvVvaiWjDBCvxA=
X-Authority-Analysis: v=2.4 cv=D+N37PRj c=1 sm=1 tr=0 ts=6a41a600 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=UQAiW8fk4jwks4S4FoYA:9 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: Ij0_E1b1rzpBl8vspHEeIfZP_wh3Atah
X-Proofpoint-ORIG-GUID: Ij0_E1b1rzpBl8vspHEeIfZP_wh3Atah
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI4MDIwNyBTYWx0ZWRfX8bdzl8XUvUYe
 7wVC2NA94j/HCI87OwpC3JsRqE9i7cX+797gJN5MSrdF3mMlpYiIDKpVpPcnpKJsfhGBVJEWWTQ
 bund4AC9thJW15XoDU3sTJ3eFd9tnt+JIRqAaynhVqMMtjnJk2LeSC8AWcVxdv7qnB3RLQxr1/t
 RXIGWvfqDBS1557l34litVYplEWNCpAvZLpnSFytE9as6zE5hXwiDr2+nrLhmIieW17CToC4e+J
 7nYjpc+RsXFU1flIzc/wHYLCOQ/2hEUeSZMbsN5va0MVaKnkuN1n/Lh/kHj9f4wBkEXOUaOW6+H
 X4z7BmTBWwvgZVhsOZfV3r0bW78d3ci4ari2udmBT4m0iKNA83kgDksH7zzGaAeBtwCcgRb7QS4
 R19sH/rB4JB8K+OGdDhewX+ZPrB8DRrrmbZCVoaA21tlaV2UOslqCsUMMn/JJ9aK7eIN7UgKQD2
 KTRbz7dnSK2jfpmI+dw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-28_06,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606280207

On Sun, Jun 28, 2026 at 11:54:00PM +0530, Akhil P Oommen wrote:
> From: Aditya Sherawat <asherawa@qti.qualcomm.com>
> 
> Enable the A704 GPU and configure its zap-shader firmware on the
> Shikra CQS EVK board.
> 
> Signed-off-by: Aditya Sherawat <asherawa@qti.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
