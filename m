Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5FA29ACFD
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 15:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783350042; cv=none; b=W2aNSbC7jjAxHVNhPF8RN0wp1SGmtUjL6wVXN9+mOX2NOVgyNnPUN8Ws9TJzrGbwt56TuAkMQczNyMlZuMsDyvMYyZrs2fd5WRyyxqJ/CJ2WuytBdLmb8KnqOBh+ezdk0T3fpkK/dJm+BBoW/d4k5h28bFExgthoUQglASar0Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783350042; c=relaxed/simple;
	bh=CippwiaLchZkBp17ScVtGD5Koyw5ydwIvHSD5Nc6vxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TU7BNWy1lCr2+eqg/jYPVudOpeud6xi92YjeuXiYDoYUuj73AUBfXOnkJ5fAv761VUIlI8ZkvolI2D+Jt/D1ZH5BqGwf7XJGxbE+visFuiFTO67QQh7VRdf3Bp2iNC7lSpWIE5bQbTu9Y/MG3GEvTKSsmep1NqSecwM6EZjotlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IF/ut3ah; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KptgpOL1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IF/ut3ah";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KptgpOL1"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666EDsjE810630
	for <iommu@lists.linux.dev>; Mon, 6 Jul 2026 15:00:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=bn9/G/DyutefUg00Snqy1zzU
	39NkJvMT4AS5q8icaWo=; b=IF/ut3ahI8X40Wfyw7vMydD/20TuCbIZ19Z/0afh
	KTEahq8IFTkDK9tb76zcwC0Q9wNWvlKTH43UBxpNFSa/Q4XjVBXMEK7dcrVQhle3
	4FHEE50mrQk5Vo3uszoyFv9/vb0qHu75pm+FycOu6SSkqLMmDq2PGd4AyrBxHklE
	GVS30PqdnWrDeuyMbWZ7a9c8/QrIa6G8QZRy7CMcZ1jeG5X/3LTGoIcwZhlrbFB0
	7kEjJ3pdpmlUl/sXrkEQ4XshqJ3P0iBcJCnGnNRJr0d/qAnLzJatdHXrNBgoo3J2
	pt8CzE8jBlwn08YYTIQWXp9vHfE+KP7tp9sgX5A4gAX8ow==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f891uskrk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 15:00:41 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-737cd7b76ceso466519137.3
        for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 08:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783350040; x=1783954840; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bn9/G/DyutefUg00Snqy1zzU39NkJvMT4AS5q8icaWo=;
        b=KptgpOL1d564H975b0aUYj2jmj8Xx1+phr0k1WDm8lzL8AiW16i+GbDX658xqKew0A
         VrHXO7WlNpEtzSTj4m6+MgwzqWgF0WAurcw96Cnoe94bmP8XkHHYGzrEcuyaGcCFgTcN
         HzoqWu6VDou4YK5YYENPTV0LdPzKD+FMjRFNjSLCzk9CB50V1XHOqJvW/pdfbNTirvAR
         pvVVKZPqNyUvKu//rW7OhgCNryX/cQw3njBBTiw7RoRALjFi0fK6U1WaPQPk35+/DdGm
         Yiupya5KGDEKuqlLj7WHus7TwLEsMKtw/B1NaqUTKi48/LzxZs2IZR2PqJjv+ANUWodB
         s2qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783350040; x=1783954840;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bn9/G/DyutefUg00Snqy1zzU39NkJvMT4AS5q8icaWo=;
        b=smu0Dt9TBvSRFFn75+H+h2Q1/uOz6+8PHJhOEJ4j4BZZIKQ0R+Zb/XEwicCgAf6Jg1
         q3ecXGKn2vHLR6P7S05rtdzQ12IAthQAC9PJBmjrkRaO5f/0Bcl9x7W73hl8mExL+mpo
         Rgj4PAF3DPyRhF9JaEIo49lhwhgs4nhBV/bNVEYpzIABE6IefPIE+kSMB2GsTjqhFX3I
         X0Z1rnCGANOAA8T/TJWiZt07iJOHXEwOmf0dsnhk0bq0nnK2uAwXMrp9AR3y5cm+pwWG
         QiSYNN0ueTay62qLAMBkT45Fkc4ftOKAh+7+0f3a72iflfySaTpgLnoPgJd6k5idr0ea
         gBqw==
X-Forwarded-Encrypted: i=1; AHgh+RouL0mQaDmokbAA1TO9c02LTnANSSqjM7MVpNEafGOhlq+xMWfdJ6iTduyc9ytLvFcrhh004g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyX7Ysjtu8tfgS1aNMO6p5AYqvmNTpSAvbwBF7NJcqFkZU/m2Uw
	UcRwquN2bLcfLnMAD05Xz9bxskm9/u2Vd29b8HsJHRy8yv1mJXSWufduK2fIkG8S65yAc7all2x
	9KKIUpRI2q685bwiZ2HLbgBQzYQrqmNDi3RYmSvLziLc7q9uEOMi18LgF3g==
X-Gm-Gg: AfdE7cmS/wEgWcmNojkP+b1hk6p0XgLxrdeBH1RsWWz1Pd/j/uf/msDj6f7X8S9gkkX
	2tyxaLD9HTcs9M50FCRxgldWz0zb1OpYIk+EpqmhpUyR4iV6LTBfF/VIb5bd/tMP/9wLBZNWHF7
	KdmOy/a098pWEgqmgVbwfjDqjkd3/J/g8WgzyhU93kD40wkVz+DMn6wuc3z+fKlGrRiegegYYRH
	NgTfKDferq+711LUcd8P2f4dv8XjtbEHJTfCgUhWYxcxttvj5HZA2Tb/DGSLdFqGRJOclyayM1w
	9FPztCngBnmWAO6CEaeuvO6KgQPcFBPBGsQ+2HYdcAOk3HU/9vLZHknWJCrrNOT/O1J6C7g/c4H
	gxiZE937me49t4xvh60Lfk9V8gT6kHPTCvTUYCg390ZBuTwrMqIqNAlrFgsGJfJETwokTr90q6P
	32s0bqVMe4yfJDIO/B6YLOERSA
X-Received: by 2002:a05:6102:5ccc:b0:631:4cd8:b6aa with SMTP id ada2fe7eead31-744b7bb690amr470665137.13.1783350039046;
        Mon, 06 Jul 2026 08:00:39 -0700 (PDT)
X-Received: by 2002:a05:6102:5ccc:b0:631:4cd8:b6aa with SMTP id ada2fe7eead31-744b7bb690amr470598137.13.1783350038304;
        Mon, 06 Jul 2026 08:00:38 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aed13c5c11sm2964033e87.77.2026.07.06.08.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 08:00:36 -0700 (PDT)
Date: Mon, 6 Jul 2026 18:00:34 +0300
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
Subject: Re: [PATCH RFC 01/13] iommu: arm-smmu-qcom: Configure lpac device
 with split address space
Message-ID: <5vfdbrk4bu77e7wgutp4h3ilbpjhcxxnwemqiufmtiwoffp4sl@oaonwwouw4qm>
References: <20260705-descriptive-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com>
 <20260705-descriptive-name-lpac-upstream-v1-1-01d50c3e0c99@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260705-descriptive-name-lpac-upstream-v1-1-01d50c3e0c99@gmail.com>
X-Proofpoint-GUID: 8UifbJ3K1rjr5kLihVrm2vs_lm7_9v-L
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE1MiBTYWx0ZWRfX3PFE01CeRNIH
 h71dDMAq/jXJ/P566tQJSX5RE6xgyX46tpW2XV3/bH0zWW2o35qLULOIHCc9ymx1MLUtluv01PZ
 UlX5mBCpzeGxrj5FJ4OZhRhH6XV4+Es=
X-Authority-Analysis: v=2.4 cv=Mo1iLWae c=1 sm=1 tr=0 ts=6a4bc319 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=pGLkceISAAAA:8
 a=lhguFYgXd42DN747EnMA:9 a=CjuIK1q_8ugA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE1MiBTYWx0ZWRfX9C2i9cumy7fC
 Upr3y0Eadt2AjT32p9w5t4fR3Vs4PEJ5IbDRuH+/WNUKOhP7AGX9aeSjE9ZwsQcdX7sOfVhO/oE
 L3UZjk/JlASGFeEep2E5oybnm/cYTgTSkRkWIwVLZAVM4GP4adriqy/6wijUiriMNINe7WsvD6B
 cLqgTqTz4BZDv2mmVhF3xYKsaqGtcJksKJgcgBBQj5wYqtA7D4TnQatl3vVS5Tv125KIW64oGDZ
 UUXSMfnmufbO9oQEMcT9XFhyDys724FKwb35imfLtsetz86vxIRq8xvscCBr427mIaGleMTdUFn
 PZXdLA/+PJ+jlqlt6qIOyVoTKfGS2a8vEpgfLvtEKgyE+h/4+aiJYxynTQtccOekS7ke9BDo0X6
 QQYDMgbkgE5+CDLT7fPLwoD38eEMSj5sJ0DFB3tYUgwhCOeGKuzaBU1xfYYWCRQIoQ1TV+hqY1J
 Jf4BXuMGVykFtBfRWjQ==
X-Proofpoint-ORIG-GUID: 8UifbJ3K1rjr5kLihVrm2vs_lm7_9v-L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060152

On Sun, Jul 05, 2026 at 09:13:35PM +0200, Anna Maniscalco wrote:
> We want the context bank used by LPAC to use split address space just
> like GFX.

Why?

> 
> Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 

-- 
With best wishes
Dmitry
