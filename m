Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4A25427F3
	for <iommu@lists.linux.dev>; Tue, 22 Sep 2026 12:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790081149; cv=none; b=CtAmSCsP9Kp3BlrXZXwMRacT5TnzNDrfGX0Ata85FtRR/DOBq4K9v4PtTYS8gMKDrJJBqf29kRYaE47MGdt9ql+kky5r/DSQIL96ALBTI2A1Mhrslkw0HJ0g/anzICs6QNuoHV8AIuS2D9uYgWP/NF+41Rcm56MnaQ8I2xdMQSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790081149; c=relaxed/simple;
	bh=teH5ei3MBK+NMl4BXDarhxXz1RAQj80oEkiGD43HreU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JqlNEK77rPsPRQkQx7Dg0PZDq7omzKZVpZLun7ltVlA5EHjyB7ZYEI0Wf/BWBXWaFAAkTl/KZhUu8+WCh1w3r/b0kVYJztR2nabh96hwdy1OH1Tre59pupAGGt5JPftZuMN1HteCZyHxkr8tbA+NwSA3xJSTou99ut3v5FBcMEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GBeoOfbf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Zjx920lg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GBeoOfbf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Zjx920lg"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MBPrcc4078627
	for <iommu@lists.linux.dev>; Tue, 22 Sep 2026 12:45:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=c2oXXnZSchD/J/9BfqsyDFGm
	NEvGeY7Is7L4w+xWaQk=; b=GBeoOfbfqUnEl6W4jGX6cfFGk31pY9sW9+sYL8HU
	1UZeijE3YYgWODKmIfFkoYD5arlMe5XkMx3i85xvlTemN3PNEgQnC/xKMcwaMUvQ
	t+HbZzQSIHlavc8y74o8tocgQiZweVeGKL+dUKMYCWLN1Jp73IPsLw/5dZVIWfIH
	tVzHPx6fipIh4kDy0X6Br/aDgwQnxJ/YNm4wSxPFp3eFTzqpu2UTvkBHAP8MPpI+
	m/8CTY6ysvjBe/XCExRLJdT8m1FGgHGuYKTKxQ0y6RtKPt3ECo4nTrWbSYkuBLUG
	0OCp0t5zzJcFaQe5dtR+kfTnviJ2neYOYjZhinb2OH0V3A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gupbqgxp2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 22 Sep 2026 12:45:46 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e54b6556aso5232551a91.2
        for <iommu@lists.linux.dev>; Tue, 22 Sep 2026 05:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790081145; x=1790685945; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c2oXXnZSchD/J/9BfqsyDFGmNEvGeY7Is7L4w+xWaQk=;
        b=Zjx920lgBCK+8namewH4Vqy26VbbIm9EN20zVGj0yDwwmgd884Grt5L2VLbZeDaMzl
         91XmpgxljU0W7+Hyf4ZURng72c7ysGuQcjUIJao6BOIU2NtOwPHjBci4xDyB/9lp/sl5
         BfBCyv+J18pTuyEF3IE9grvTR+3wKaBZh9NRnkblP1bte6wjiv/NuUQ6VoIMA4gcu3JS
         GsCVHNTZZ9byY11PyRDSk/7XaNb4HJIAqUjh6cbHdyFKSeT8AunCb5nYJoZnidUkhKON
         lB2MWTQNXcMbkNyWJC1tK9v+VOiddWEC2dy928U7hM23EZml+JzbNhK+YVECZfc3CkSl
         yvbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790081145; x=1790685945;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c2oXXnZSchD/J/9BfqsyDFGmNEvGeY7Is7L4w+xWaQk=;
        b=NVz/ynDYpWd6ud5zl/qILjcYwSHtGCqndWWcF2nT+jBkeZOosZK88UjKrNBlWptwgO
         hlI2ahsPOxaNbiszuiksjXVz0Gq5FUfH6RcEa+pc2ImhyCsJ2UPRm6xG112CIfQoPzUM
         ebM7Vr5FEIL0p1dV4IgPG3jhOREWCH9hO58YvtMMXSeQUKl+Q8Oh2GJEYAd7+boUVn/H
         SYffy8k7LkQhYKvNCOrh0toMoZz5qRf7ZJk6aaplZEgNfQsG9naj5XQvwTYe79E3DEyb
         WCPYJCd5NC6udvzfKSsUuwlQU9dtISxIbJMnGoyCCXnrwzX+MCCfI2BypnDjHhRTWdBh
         loFQ==
X-Forwarded-Encrypted: i=1; AKwUvBxjDzNoyQwd1dcxcfUrpWgFPPqVDxJ0wMdzN/wOpqQgM5OBrWXWpLc9YtK3VDqdPpwtB8Wvow==@lists.linux.dev
X-Gm-Message-State: AFuF++m63HKEil/SoSKvJfsozR/N7NopP3gfR7SMGovNDFxhqlGuDFEh
	raCT47ZwNINrUkOs6iwXeSCAXxeavoqFaH8FglLmj2ngi0PlKt7Mb/JnvcBmyzwFfNXDMwUpcvp
	rrC5rVJue9rv9lkOvIG2i/wioHJnwlKo2e6ZtoGUI/uTp9K+jiTvX7Q+uFw==
X-Gm-Gg: AYBFou0TOPiaPpJYWHwrPi3zo7TrhVw/azo9anKYztBadNwEDhKiCE0eGuskzc07WlW
	A/UnPjuUcMoDh7fiQM96oj8J0wkIdAporWJW2VCRO/GnPSdmv/zCresiEaowIpE3nOB8mKMOgv8
	78kPGTEPITC+Yj3UKHGFBDner8x2S+9+PWWj1VcEkdZf+BZNo7rUCtl4XEswiwiKjlhg/nFqS9L
	m81OzfO/FxOGA9kxQItUoGnR67QiQV2UvRhMTo5ntEQs5xDx3vgHnN76QK/ZCoEtm8lq7hTg6GI
	FMhlVUl6BYZut36uZuzZfphe+MjjuWOYCimPxm6ZlJrx1A1ZH3s427Hs1GSBUpF0HJrmm70MPMs
	c+w1SztHArQPbngRJDKX7QBQQyqkaD+aqcU33S1Xu7A==
X-Received: by 2002:a17:90a:bc8:b0:39e:6a7e:ee20 with SMTP id 98e67ed59e1d1-3a073202727mr852146a91.44.1790081145242;
        Tue, 22 Sep 2026 05:45:45 -0700 (PDT)
X-Received: by 2002:a17:90a:bc8:b0:39e:6a7e:ee20 with SMTP id 98e67ed59e1d1-3a073202727mr852079a91.44.1790081143453;
        Tue, 22 Sep 2026 05:45:43 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a06e574b5esm3204533a91.7.2026.09.22.05.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 05:45:43 -0700 (PDT)
Date: Tue, 22 Sep 2026 20:45:33 +0800
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v11 0/9] media: iris: Add support for glymur platform
Message-ID: <arJ4bUn7ZG5y51DA@QCOM-aGQu4IUr3Y>
References: <20260917-glymur-v11-0-e0c8bc914742@oss.qualcomm.com>
 <20260917-dangerous-illegal-honeybee-cf479a@quoll>
 <ad32f584-ea27-4da9-9397-147b887a7d68@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad32f584-ea27-4da9-9397-147b887a7d68@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDE4NSBTYWx0ZWRfXwDaqUjjLy/SB
 bbPgrBrDaC/DEssxTujcEVnOv3yMRE7oyQGfg4bbJuSy3xYGJodufwRsW/LDzuHRxW27+1za6OZ
 VyKvVzfkM7lMtddZObMmPUMzSEE/ONDhs/4E/FeNO6r8VADz4kibc7XlWJDzql5qvfGDn+rtrU5
 +sa2zOuwNnHf0W9tYgv4pNy6LTPWyYLyWIw+N678k7oTowqcSejR17Isn9Ln9r+69oJmhRsazLF
 PffUcgQcOVXTz9vsZu6MmuGIboMKWO47a863NB/drCQWE5XW7mcghPVHakoPD0ruY7nffzomRtK
 k22m18sDXW+ilN8fvSAYY2brTKYgFMbcPTQLbGGKA/T+r5niAey0wPqG8m4DCszY258Xj7onx8X
 08OZl2df35x/hkjmTHRF4v6Cu+awhmxNwMYBldRLMDgL2mbAuoOfrmF3S/ySahn+aiOI0XK6usW
 BDf7uDPq5p3H8ghLZyA==
X-Authority-Analysis: v=2.4 cv=FdaiV5+6 c=1 sm=1 tr=0 ts=6ab2787a cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=s8oyx3DkIhJI7QqzJRcA:9 a=CjuIK1q_8ugA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: 2gCx86aL0hWN0zPKnwcozAkmVRLDLLL4
X-Proofpoint-GUID: 2gCx86aL0hWN0zPKnwcozAkmVRLDLLL4
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDE4NSBTYWx0ZWRfX9OKoC49PvpkP
 Ef8Vi4u3COz0uqr687pUQwt6RdM8jxdF7PQc5QRKBJXH+ER2xwF1Y+jmyobXpfBo9CXnfhJ4BFq
 N6rFrArrJKjhSvHkZCgulTzieGeoKQM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220185

On Thu, Sep 17, 2026 at 09:11:50AM +0200, Krzysztof Kozlowski wrote:
> On 17/09/2026 09:09, Krzysztof Kozlowski wrote:
> > On Thu, Sep 17, 2026 at 10:30:19AM +0530, Vishnu Reddy wrote:
[...]
> >> ---
> >> base-commit: 0d9d0dbf2fddcff5859d623e90ca73c4054276e1
> >> change-id: 20260917-glymur-627d049900e0
> > 
> > Look here:
> > https://lore.kernel.org/all/20260726-glymur-v10-0-de451559e88b@oss.qualcomm.com/
> > change-id: 20260601-glymur-4fcd4d832ecc
> > 
> > so now does this work?
> > 	b4 diff '20260917-glymur-v11-1-e0c8bc914742@oss.qualcomm.com'
> > 
> > No, it does not. You are sending bigger work, multi-version one, part of
> > even bigger work, so please get the process working correct to make
> > reviews easier.
> > 
> 
> And it is getting even better:
> v6 change id was:
> 	change-id: 20260515-glymur-6e69bc258fb0

It's funny that b4 processes the change-id in your replies like review/ack
tag, and so they appear in commit log of every patch that b4 shazam
applies to my branch :) Something like this:

[ commit log ]
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
change-id: 20260601-glymur-4fcd4d832ecc
change-id: 20260515-glymur-6e69bc258fb0

Shawn
