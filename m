Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1084C3DD535
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 12:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779280634; cv=none; b=c7MX0BPYSdmei3rEih8RKjY7+KnuUJxIK/+bgUpT2/9s7jevUqIWILx0+71kKnv9w9Jmy1B21GMYuVpJrGxglQq04QwEqyK1DQDfJb4To6V5k6lA8v0iWr9T2LacPLvsQCUtdwikD1H3CGhZ4CUp0inZkiAsgYUhl4ahUUQi94c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779280634; c=relaxed/simple;
	bh=MLZJQfVxkc3p+wwRG14wvrhVLIjk5+YA93+ABf6M8oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HCRaEKOarlwlRlC4bnn90tADqA8R7s2lyrKQzb/ZVpJjN3uX8oCXqj5gNLbnDh/ZBH0XtiHqPdJJMTi9Jp5UUw5pb59xx2mkOWdhZkHfFb818C6dPr/iPzYpFvXRCcPD+JSyrdoa1nMv5K2ub3pklklQ4rFdKLWsVrud4rP8oQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PE0g9x9E; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EhkpAm+N; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PE0g9x9E";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EhkpAm+N"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K8udkm4115192
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 12:37:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=gn5gBpD04Wh/dxj5O9L+mE/y
	SwSb/e86AAimCDaG5vI=; b=PE0g9x9EkAYAa7NJAkxDINWmBiPkgxAICnjHbadV
	d0bcu3Yz0S2HFEXrXGPsq5yXEY7Bql+xk7t1KZ+mIFUdh8vLGVYXFUDIUIyeLd07
	Qo4/vnRmdiYIm1XKj5Ok5v1xEta8VM23bIV/YhaV08JAigGdtXXCsjg/j35or712
	BSixfUvDTq84m0vW7nsKGFBDamewORYudK/hA1P7r8x5kcq49Kbtk1TN/u4c4Ftm
	4JI7E+ItA4Y5AeryYaXjfE+kbVc3td2r88RHkyArplSZpOxzqpfaukAd4p67qoxd
	w36Y8xubgXMqlwpd46OIk66Cy8FtYYumRDLvLQnNKcFutg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e99w0gt57-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 12:37:12 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-36641fe4aedso9412222a91.1
        for <iommu@lists.linux.dev>; Wed, 20 May 2026 05:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779280631; x=1779885431; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gn5gBpD04Wh/dxj5O9L+mE/ySwSb/e86AAimCDaG5vI=;
        b=EhkpAm+Nv6803IRPh++TZBaNT6YdLt1RxMM17ewE9dtsH4dB6mM5dXZ7+ID3NuX+5V
         YkdnvR0EzgJve5SrDl5rfXP6VQYJPqXtl299wL5Dx/U8RyeBkuMt5neMtztB8T4tA/fa
         wL3A/qwMfwyLkX/eqE4Of1vbf7kfuT211R3+cargIrGGtKc2wQb2hBqJj+YMtDvKHTwG
         a2vj8iUH5xZAJ6TumSWMkclkS9jCrupE1501e7aHkDvcGINiFUJMQa9TqZuDTZVyT23W
         Rz2kVPTsH0/yd3MnYg2lpBe1MVpParHjZlD/bEQMnSpKjHmh7JBzzrTftPX6GMTfQ2It
         f8Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779280631; x=1779885431;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gn5gBpD04Wh/dxj5O9L+mE/ySwSb/e86AAimCDaG5vI=;
        b=F3HVT7G6hmGtgmc9vL7NfkiZfEaH5zICeJIPpQcdW7qAqS9aK8K9QzDOpWlVmLEaT0
         9TcK2mrIbkgBE4uI5MXXMeUmxFKQOj7Rkado3y3URdSp6vf4/Ogx4rESrpTZEAuSjRGo
         fdf24hIJvT1yANKGdI8uaW63RsaiBVS9HbyhIspwEtC/pBR0vQs6lu2kEKFEU4HLhgLj
         RvUBSuQH6JTD9CUXtBeGNfZZeDbrjxUmaYtG5pw0RHo6K7jRnjjXKYN/XBhz6Tup16ep
         bCmCRx+yj27rwL+9pDfSNWpYvTZ7S9cRpRN14lUg++9geK71H9N7c19U2FDi7JRXOtI3
         Rr7A==
X-Forwarded-Encrypted: i=1; AFNElJ+I5EUjj6o9PWj8whk13T3MoXQx6C4Ouv6kzb8TD7darvFgG1S25fyAliBTrvoW5gQqfQVz6g==@lists.linux.dev
X-Gm-Message-State: AOJu0YybJYe5vea/TlCnbKS66d363QyQzjpov3yZ7vwApGxXspB6FPUz
	j8Gh4UWC5mbGFGJ8l0+7zu2f9pCkRBP+qSYH4csQ+XA36LZjdjYWyCr4zOuo/S6T7Pkhlm4P2vH
	j9NnjrzU8mHQZTkVjyR4sR+GmWGpEQB4Yk5k1qDdRnaXREUwu+cdAwyjsQg==
X-Gm-Gg: Acq92OGTQkl7e2qge2Fx62ZzzWwELTyP9ZoI4DP73AbcnCGDen4TL6oegOzAvhLeT4i
	/L6bRK0m/cjgB65bcsKMCA+7NvM8jz7HEkm7DI4aKJMHxUTIFot1Nc7oGv+2s2H0jOCsMh8lSjN
	FP9VopmfW2YxUu1XAr9Hu2gtDCWCerE8iQQX8OcU5LTpY1qvq3FtV1JgTN7W3kPjVfV92ttwy8w
	4lVmRwbTQWybviwOWEsIpO1lGL4WEajtCPJL18qejvuIydlJt1PlVH2yhFfr8x9BzOch+xTwgDS
	FJhSAKki9vjXssxFFL8uX6TTh4Lh9AXBaQNjKfiRAtgwJYeXZYyJPoVNDA0mfa82CvpLaGH9UU4
	kKghGO5627c+r/EePMZFnaRvl/L7xT6OdMTnv73jFjhv35ajQ2zeX/W4FoQM=
X-Received: by 2002:a17:90b:3b4d:b0:35f:ba8e:150d with SMTP id 98e67ed59e1d1-36951b75db7mr22645816a91.14.1779280630928;
        Wed, 20 May 2026 05:37:10 -0700 (PDT)
X-Received: by 2002:a17:90b:3b4d:b0:35f:ba8e:150d with SMTP id 98e67ed59e1d1-36951b75db7mr22645779a91.14.1779280630270;
        Wed, 20 May 2026 05:37:10 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369c5f0eb2bsm9489673a91.7.2026.05.20.05.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 05:37:09 -0700 (PDT)
Date: Wed, 20 May 2026 18:07:03 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Robin Murphy <Robin.Murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: arm-smmu: qcom: Constrain clocks for Hawi
 SoC
Message-ID: <20260520123703.zsf7bt5w54xuaanb@hu-mojha-hyd.qualcomm.com>
References: <20260520073447.2138384-1-mukesh.ojha@oss.qualcomm.com>
 <20260520-evasive-harrier-of-honeydew-06ba84@quoll>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520-evasive-harrier-of-honeydew-06ba84@quoll>
X-Proofpoint-ORIG-GUID: W1O-OkCIDL539C9LHjC3lFJmYvCAkTDh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDEyMiBTYWx0ZWRfX2tGxvQV01lCo
 39mPvx/QDH7mkEyDqunxt/9r0r4qcf43yE1/qVTLKTNEtsxjAcI+IZ7yU/YQQRHOV3UXNgS7x6+
 otm9XgGlrZkQXWOjPevirvEzk4vENbONCDFWBBAD6SbvVFXh9WA/RL8aVyAJQmRdlPYbiYXNV0C
 KISiSLghxahVDP6gnq7s8WlxRP3x0XKb3pyBc2L+Aa320y4Pl0yzSHusxrmyT7jlW3EtfZTxSqf
 xv7LbgOlF7FBaiWuPpFpC8ciCqNjxVqBytRfEG4ycGpK3u72EKgZtVq8lDgpcZtBqttIvbbvw4A
 jtME8+76tMQ21g/4hVjbQxH2vlSW2TtZ1ypPnFxm1LR1vG0Cl8rzenCUzxzlqoAzzKHlHO3XJUi
 PFgriy9lEpMiNHgMjD/XwSuISAuJonecE4KNOLR5CXbR+2Aueasdpifv2DmpHYZPhoLiTpeQDpR
 1WEOkN2pPKROcK0vnGw==
X-Authority-Analysis: v=2.4 cv=RZigzVtv c=1 sm=1 tr=0 ts=6a0daaf8 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=_gGcc725SQTycyyT32wA:9 a=CjuIK1q_8ugA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: W1O-OkCIDL539C9LHjC3lFJmYvCAkTDh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 impostorscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200122

On Wed, May 20, 2026 at 12:57:13PM +0200, Krzysztof Kozlowski wrote:
> On Wed, May 20, 2026 at 01:04:47PM +0530, Mukesh Ojha wrote:
> > The Hawi SoC has two SMMU instances with different clock requirements.
> > The Adreno GPU SMMU uses the qcom,adreno-smmu fallback and requires a
> > single HLOS vote clock, matching the pattern already established for
> > Glymur and SM8750. The Application Processor SMMU (APSS) uses the
> > qcom,smmu-500 fallback and has no controllable clocks.
> > 
> > Add qcom,hawi-smmu-500 to the single-clock constraint block for the
> > Adreno GPU SMMU and to the no-clocks constraint block for the APSS SMMU,
> > following the pattern how it is done for other SoCs.
> 
> If you decided to make a competitive simultaneous work, you could at
> least tell me that.

Well, I covered for one SoC, while you covered for others. I am fine with either one getting picked.

> 
> Best regards,
> Krzysztof
> 
> 

-- 
-Mukesh Ojha
