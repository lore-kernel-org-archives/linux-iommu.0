Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A921426B2AD
	for <iommu@lists.linux.dev>; Wed, 29 Jul 2026 15:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785339244; cv=none; b=g0evLD+fj5v8ltNG7KYXSwFQxCalqNL1dGjVug9WL5H82AIfQWiDo4V62YyrL9Eu3Liv3NGFBwGgDdvJShLW9k7pRIS4QBoV8fA5KnOJavGRJ7w98aAric6Y0OU3gjDRLVun2yTW6sUwhcIGjzh6ztiLTMQntk91Bx6HOkCLmpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785339244; c=relaxed/simple;
	bh=uusaHKhdZOOIa+jdubg/4lcDVO9Mun7Egkmmk4lZfXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=akLpxXmYqE3GJqlUg9Hjd5t6u7I6LRZ+bYEp3qYCcGy5929OgxjbXIz6HxFX/clPijWkqeJxeinPgV/kt5wv+CbP09FE2GKM6p+ecBikqnW/99I7z1vbiXJTfvogbPeemGSONmaSUty5Kmvx38WsaADPRqMRIEVB6pQ0NS0bZ6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kwCMMNCN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SJFItXvn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kwCMMNCN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SJFItXvn"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TF2VSe2591758
	for <iommu@lists.linux.dev>; Wed, 29 Jul 2026 15:34:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=QUnH+rERyXcOOevFVTmjG9tv
	hkhekENrGxjVVTyR66s=; b=kwCMMNCNfZnAf8pOQmuZW8mEiYknC552j6RhMaKD
	QXbtrnsTBy7EJkGrp4cS3030eX0kyMc2YW166MHlRYIC1mAUmvq0XDJ06OHyOp7I
	CYMDK4gZXqTeIUAuOEdwc5/eNP2UBCRsPkM8OIKcMMP5ffkc4YZLeZcosdHyuZae
	86elXKl2WFhpzbKu2A6A86zZ8V3csxh0usCmIot+Iv2MdGu0Ew1fQZQT2gqN1EQD
	lR4ZvTPWqoWFWH0u7kJqX2xe0DPwjzXxnuaWENzg6/xXjHZe5bKcaYt6rSykmnaf
	dQDd6YLy1lotbwrf1iTiN7QfniDWmdOvFlpw6GgwyIzMOg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqke08che-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 29 Jul 2026 15:34:03 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c26012cd0so10535681cf.0
        for <iommu@lists.linux.dev>; Wed, 29 Jul 2026 08:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785339242; x=1785944042; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QUnH+rERyXcOOevFVTmjG9tvhkhekENrGxjVVTyR66s=;
        b=SJFItXvnI+vP3maTs5Xdzv9hNAZtfBphSFN7YwuljHJT5r5F1wkPH0oo1HxcOtcSL/
         aaWXjvyfBI7YMP0K/yAsiw2sVNAT4ojLVLa//+UICgw2coeqenLCfVWN98qTZuaJcr5I
         tlQTzb0+RRCFUUstP2lkk0G1NoBbpc3EnQ2x/5FWl//NDShc8o4eZfkD03hVSFWlgT+R
         gSZTCDRqFadEo63EgUhXGWAeDhZw3pPik4GtbLwBiEXEGSCfWTVJtHxgM3RDy5j2Sixe
         qXDGyB50b4WRAgM8u3Kz8gTGfXaPkekQe8vHcHnY+MdmuCrmHbcWrWMZrwnboFsHBnx3
         03QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785339242; x=1785944042;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QUnH+rERyXcOOevFVTmjG9tvhkhekENrGxjVVTyR66s=;
        b=qCFAl2gSkH5tM4BmAmu6xixYN4JfYIb/MGSbC6kj2lqW0UBYID6XIfgdx0iOYyMlxT
         s9IndEiyLlh6itZDapNRe1lnccJks7CgWJYctM+7RqFpDO24ntUjMrBWAkKbo80rVpd9
         lyXDbKb9/4bwXDlL9ID7iMPWVR1+mme+UmNj4K2GAjv+GgIOUGM8yzZ7XaJJgO9AXZrv
         AJ06ev5h2THp9ukwCah6yipb1NyHlEb5qQPay5b4seHz6txA3fGtJ753moNMgoEaKwHg
         ngiK32+HhQIylDKJ30EXHcdst2F+/ax6iaIYmsEPWb0JID8LIxq6m4qgTX0jv2wsxxMJ
         uVTA==
X-Forwarded-Encrypted: i=1; AHgh+RobnF+qCLPWu8ExFtHeBhKgAnysW5h6AI57+wdxpCrEhdEYGKzMcY7k7qH+bXrrOGjFgHY8dQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzQLXS6jzQcOo10KiAQkemsN4aX3C9KlX1n/k4yPHiBmtyr3vn2
	R8WviY/SeJPiGhYGmS4wrqEBfJ66IfiVjGVFoUkOC0ygqFIFttJzbpqVMsKBvTujLg8QFVacVKs
	RW01iAwkOLi+LhCmAzLczWc/9T4J3VLdwscVmbbdDmfqqayNf3I5zFuEJtg==
X-Gm-Gg: AR+sD13fpmdPDZHM3VW/tuqQ8MouoEYaiwosUCFCuyfN7SRay2eqUq9hgT0hoOtPA0s
	oIvFogk81RvFc3iOZiYDrDO3J7TMjUokA9XLkEStzyN1IcoZND6Z8C41/45woPx5MGHWUkGV/0E
	YPwWJE1JrDb8O8+ICrWhg/ZyERUHnAs4oDBM8/H3phT8VRCAa+2Bs395s8NfQb/kZpstOeD1/wg
	bWw0Oc4HRpyiQZfbLK98Ilbl6i7PkOG0vvWxnQgdAOggkUOpDaCqc2X91R1D61/6EkVu7Ie9Pc3
	u3aaplOQL68iUZbBlsukzu8W7L0jvbRQNV649iVlA+jiI0r+/OdOhPHpmtitgqCZB0k2YXXAqUW
	3pVVAKi/hr5gkbSQ=
X-Received: by 2002:ac8:5885:0:b0:51c:640:231f with SMTP id d75a77b69052e-529d70d6591mr71296531cf.45.1785339241907;
        Wed, 29 Jul 2026 08:34:01 -0700 (PDT)
X-Received: by 2002:ac8:5885:0:b0:51c:640:231f with SMTP id d75a77b69052e-529d70d6591mr71295911cf.45.1785339241231;
        Wed, 29 Jul 2026 08:34:01 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.163.114])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6aa3b1csm9218589f8f.1.2026.07.29.08.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 08:34:00 -0700 (PDT)
Date: Wed, 29 Jul 2026 18:33:57 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
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
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v2 7/9] arm64: dts: qcom: eliza: Add GPU nodes
Message-ID: <gpqulnkjhpp3oqin3xouxcyytfpnaw6bckmmutbzdebfmnrdvv@ylnrzbznwwcn>
References: <20260718-eliza-gpu-v2-0-64379dbebd7a@oss.qualcomm.com>
 <20260718-eliza-gpu-v2-7-64379dbebd7a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260718-eliza-gpu-v2-7-64379dbebd7a@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyNSBTYWx0ZWRfX1zmmewWV4WC6
 TzKFvmCCRhf77Yu/hPcnBn91oTI3sXcj30nQuIu7S2xWSRIpY9WS6c4uNWysTiMf6y5B63GvrPy
 jgDGvLdirvs0/pMQ8CuUhdKarXl3VKR6w+BDLvHgAH8Sps11+OS4bkXeRBlLfW9Yk5iSYb0yoEA
 GQylqCVku4vymbcM/RJcCLNuwr2izRQVBovRI4pTi++jkBXkgTAq3Vw60eQBVnC+r8zjq/QTAKE
 /Wjffr7dVTaad1gXw5c0rHteRV62R6vljXlj6NKkWjqsj4EtDtMvJegA7z30TsExfyXUWstWXN6
 iLTC++U/gjB9uzWBSVkgYUwdBaIUhMLHQJ/SwCLeOEtrj/lmRigYLB/c41fh+KWsvioFvZehyft
 HM9OOXpzxAJ8KDJfN5e7gylYM5bWm+HyD1FX17/mRCm1VRTltZgnkHWA1hQqCUocAWNlCSJneYC
 UU/6hzSKNymz8PrTtUA==
X-Proofpoint-GUID: xGneNYbLGc6czXfsJQ85GHFDK4-gbWz0
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyNSBTYWx0ZWRfX0VYWWpbjZGqL
 8mrTrWuK0B/NoVXKfbenb6Bsm4TRZhbAG0RrPCJSuGJbwjBOxsGMwC+9i9PAcgj2frfTrODvFdV
 nj/ADye5BrZN1xjf5da/UvCSjoBwQq4=
X-Authority-Analysis: v=2.4 cv=ONYXGyaB c=1 sm=1 tr=0 ts=6a6a1d6b cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=6dw9+iwJWV8PcCi9M4lOBg==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=LzKdWfoJb4QxxMUDPeAA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: xGneNYbLGc6czXfsJQ85GHFDK4-gbWz0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290125

On 26-07-18 02:11:32, Akhil P Oommen wrote:
> From: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
> 
> Adreno 722 found in Eliza chipset belongs to the A7x GEN1 family. It is
> derived from A730 and shares the same IP-level configurations: HWCG
> registers, protected registers, GBIF CX registers and gmu_cgc_mode.
> Major differences include lower cache/core counts, 1MB GMEM, no
> Concurrent Binning & LPAC support. Some of the peripheral blocks like
> RSCC are from A740 that resulted in updates to RSC layout.
> 
> Add the necessary devicetree nodes to describe this GPU.
> 
> Signed-off-by: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
