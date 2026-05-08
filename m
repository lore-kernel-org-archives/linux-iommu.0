Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024A4368287
	for <iommu@lists.linux.dev>; Fri,  8 May 2026 23:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778284454; cv=none; b=IikFPDkH8h7R1OoEOK/ktCKYQd4VM5QPteaDCUVNX+tssdgh9JZeF7VyDWWBlL+XGE4aZUb2sGgnCwLfZQwXNmL6Okdc3oIXlKRuu3osCuEQApYTJSMYeoYOM/ralBW+KNhnOOTjhTdBeAMnvM4IF/GqpfpggaNLYxLlbgV7teY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778284454; c=relaxed/simple;
	bh=M+irl09BB3lpaeKwpF9y+VIsDUUpMsVxXvjsUgdWUqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fPc8Jz1Q39j1UGCktypXgWbthJu+lCN5ptUQonir+VPOYDJvk29TBFwYtyryN6vekQctltVFaOUCbp+l7zOLCmx4MUPEgNzX29rQijtYULLfdpNtEj/UpTSOh/dd7v0To8YBL9qkxF310SOo5Br+oDe0viIKtMZMHIO/sS22DTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lqAva3Jo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=f1oP6YT0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lqAva3Jo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f1oP6YT0"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 648He040874422
	for <iommu@lists.linux.dev>; Fri, 8 May 2026 23:54:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=U/y3XlxsK17A/ooTr1YrUKH/
	737x87wh9dKRfPzZz/0=; b=lqAva3JoUFBU9P+C0Ml+j8gYnNhFiFc4GcfrBw+P
	1Br3PBFnhgd2J/28iJNuOVg3yzCWJ0yXdoEqmFwWo3vU6y0WUgUmJ5n2ybbYmqCa
	VzEcnExd7j7kcY4CVsobvZ8jD88fjcow8e1rydxfbRHrviHGHn4HATI9XUyLFUkX
	bLbFNs85gQa+70lp0VDf6axj8ajhYDgmLNz86OuN4zyTJ7k9CS9ZZQ5KSq1NpRej
	DUND+xAGgqWKUjBrw1yU6AwD02KR93lWUNyyA7Bih+wMDEMfvJtdifv7V9CB8Qes
	Ypz2qATIOGnilaWGipCM0WMu1RdONUd3kaoPgMQKTEeOFA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1me80yun-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 08 May 2026 23:54:10 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50ff051e189so56609091cf.2
        for <iommu@lists.linux.dev>; Fri, 08 May 2026 16:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778284450; x=1778889250; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U/y3XlxsK17A/ooTr1YrUKH/737x87wh9dKRfPzZz/0=;
        b=f1oP6YT0zViDfzfC9s7uew8rvlrVZaK97IlV9N94I9U/qpm++i+Ng6GrVDGGI3B9uB
         A9Ao4cuMvMzibU2fhYHx9G1m1Np4XUP4HvVmo1FTHWuXj88tuY1nE9QRK+tvTJ2gLVcR
         P2rHG+3OHjsZDkO+JtDtvLF00Ig2mfqbvlYc9jrvB+noGi8RePsqploo10eemFi8B0Nb
         +cpH0si+PrXZ1wbwATo/4gmEsbN7PTsinsbUHl7KA0JLRdK5yFXvinJNSjpQtOsQePkE
         8zO2rJSe6qZK+WyiqgSFSzcnZJbkWduXqVpSNSHem9qV3leMiJ9nSBr7xUo39g0RQ2bY
         lIuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778284450; x=1778889250;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U/y3XlxsK17A/ooTr1YrUKH/737x87wh9dKRfPzZz/0=;
        b=gIf4qSR/7JlnVUELM52rSb93dqO4ulQaRCP4QTp4aJ+RVwZEhspuyMlIDtOgl8gjEM
         dyCQ2NCchvQhlc3UmaOfdOP3qUe8vD3jhDV6X/Z7+/OPN12MAIy2ZB04sZSR9ApQvi6G
         tNVIK0Klsg5n1OZRkM5lFcdDcMqB3rm4C1c1LX9Sv7VQSbBLDmzPrIH3iFT8jplId+Lv
         /REqJpnD+QaZ7idAGZn+C9L2MvrIXCFIUlpeXtEy8DcdCr707gWhG8FAY0jm4DXokq0l
         Qm92jzDFR/BsWzuonE2C3OBv1VnddsC6fHdSSvMfjyJEP7rs+8+XNrFacVFn+BXBVZ7J
         hrIA==
X-Forwarded-Encrypted: i=1; AFNElJ9HavWMXMnZYnqbGbhFEsLJXdKQSpORXlcFoxrxX6sky0xlEBnx+HdcMuOodfiaVu6BIXMxzw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxuWJ+UEIYxG4QFaAIcpAKarMrLRxBnR/tKIxzReodRBCclmD7I
	QF0TOc7LsnqUfjsH+REsM9O8PxLJUuyIMNj3xM3D7DHeJ2h2YRMa8niX6UOalVrPfT1E1O5iSb4
	qitMQbH9r6s05qcYvPsClSqDCnYk6DCzGsYGERl6khJRVFQFdJpYnFX2rYg==
X-Gm-Gg: AeBDievi8X53Ae5x7jspVf99T98HiOcZ11wi+iVVjD1iJt98A88Nbe5x3JyIiSVk2kJ
	eEOpRMlj1NnwSqEV+Yj6U7a6mk8ZMka/FSi80m8mhm3oElqLb0Rsy31pPRkeKDPFbu3d8R0pUEq
	3CUVxR4/5eyLqTDPMW+ZxVgeEFCI9C3sc04fKo6eWEjve18A7UCl9rqu8V5QMo08RV5slNjckbU
	jbXKDfLlD1XB8jPaMUDEXqfJCHptm0U3paXIOL1KBv+TDEfDn2S7XzK56rP+BecCwrU8ZUlpQ3n
	cgw3toZp8u0BPTT7Rgf7UcCo/Oqe33YXp2EDZQo63Cwtm6l9dn1/200IzPw3fQ589PYuXFhAo5q
	ezU4h/9W4ZN5aGTXc80KQ5aU6HpXn410VHKO93q7OO1XAcEFHPloL4uy2v7puTXOMPfEyLgHo37
	RVI9bVqJqWuQH6iWQlbCH7SA/x3Dh84cP+rVQkLtukemMWnQ==
X-Received: by 2002:ac8:7f01:0:b0:50d:8050:a358 with SMTP id d75a77b69052e-51461fcf281mr213549921cf.47.1778284450349;
        Fri, 08 May 2026 16:54:10 -0700 (PDT)
X-Received: by 2002:ac8:7f01:0:b0:50d:8050:a358 with SMTP id d75a77b69052e-51461fcf281mr213549431cf.47.1778284449855;
        Fri, 08 May 2026 16:54:09 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393fa029671sm7049111fa.36.2026.05.08.16.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 16:54:07 -0700 (PDT)
Date: Sat, 9 May 2026 02:54:04 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 14/14] arm64: dts: qcom: glymur-crd: Enable iris video
 codec node
Message-ID: <676tz2xvipbhm25djmbqokfemscjjwwjethvglycvzqqtsf2uj@xlqiuzyqyfax>
References: <20260509-glymur-v5-0-7fbb340c5dbd@oss.qualcomm.com>
 <20260509-glymur-v5-14-7fbb340c5dbd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260509-glymur-v5-14-7fbb340c5dbd@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDIzNiBTYWx0ZWRfX5HFCzcVHQRg2
 RHJlZFcf0lMdV4I3kAU3SzPvMcjFS6y6ZKVBKpCjY4lo0VjDGzH88aIhghfGcz20iYr83mSf75j
 A3FUTSEHHyYip8A549PUIZ8ZtlKX19tX0lIrcZ8fFAWv00kcgcZFngkKTvE66h7tG78ht4uj/+j
 YQxe20aioUZEy0qrmAjYrODLqTVgJaQEUA9v6L160yWhQhKqS06mh1/GyaiMKcRoNTUgTg7dQIh
 ZQKJX1sam3t2K3ndAccM6lH/iXvZUEkQlahjCMGXkrQwHPRfj9Zh5PaME4hk9WwX5aBPlrh3PXT
 hFjwZDMkRTBI/jOd9IJS/j7CDPpBLMv7qmUFGL95H3MBqfx3u7fMjHr+MreKHnmnR3VlIV/QlOO
 vxcdj4nJCBTMPmA2qIUvt7JMNnH5ihhdBkvYcpvInHSCT0RQyOV4EvWtyjdVLmYGmCQIhczSvqU
 ex8fcIkiiuxOOsXuLJA==
X-Authority-Analysis: v=2.4 cv=BsKtB4X5 c=1 sm=1 tr=0 ts=69fe77a3 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=MCItce8SuK6p_Dj8i7MA:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: KOq0esiq61Ai_tzdlxgnTLjd30YBrNIS
X-Proofpoint-ORIG-GUID: KOq0esiq61Ai_tzdlxgnTLjd30YBrNIS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080236

On Sat, May 09, 2026 at 12:30:03AM +0530, Vishnu Reddy wrote:
> The iris hardware block is described in the glymur SoC DTSI, and enabling
> it here allows the media iris driver to probe and use the video codec
> functionality.
> 
> Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/glymur-crd.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
