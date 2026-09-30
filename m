Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AB3364024
	for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 10:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790764415; cv=none; b=ga82StINyumC8DM5uQ6d2t1nSmp8G8cLO/Vf4lxsBxlAgMfUwOgvycjV8350P5EO5H2d1dTox9LsbZ490q4cMuGdDz0ZEK/Clc33PD2BXnHIRx42JfPX/n5pIN8yWxEc3lpYpq+t5MXBGY3mb8JhZFGmeHok3rshx1cLHnfDxNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790764415; c=relaxed/simple;
	bh=0M0tFS47N7lhZMQSOrqoFXZxMcxobRdsn1g4U2BMiNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qu0e0HF2DgLMC8EtQio2P2lTJ19eHzpZGbi7HiahuTo0fmg6ZG4prKzBZT+QGNsCbLsXmbYmzAwkkSfDmpKv/IewPI6O35V69u5h0pmsGbyppoG6U7j3Kpk3Yzj/0X+GHxyyzJm3z5OYVsUS98aiws0VmdzBun9+v9cWHztr/g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V8udcbDJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HtorwkA+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V8udcbDJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HtorwkA+"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68U97r8S4151896
	for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 10:33:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B2GcS8YJdyPJLvcVPFTZGMq8aLk5heCCS7anZ9DvINg=; b=V8udcbDJH1dR1GmE
	KPLYTwcnqL+aJzbNNSzAcft/PbbAehAai8PuiNN1CMt6pSMEJofITZEiao6jY6t7
	353MfrvlZmqA7vmUm/zuP2qvuRTDegn/nvrYQSM7vhR/CNU+hgY7uFYGwVWL5mBt
	Y8X6I/fVweeICo94DElyFi1JQL9ddCTQ+mtkkq9PfcIZbVWpv9tsa7aRChuMQq4X
	Cv+2tO0luaVqWaxJO84Yl5/rlEBXW8/elP8ajAQpnokEyDRtQftVMTK7jNPlahFm
	g92cJsuMCYPZM2Oc8+aFIWojko9pJ6cmuhTXWuSwQ6xaDYNfnaSMvbGFwjBM78sa
	vZGDvg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0yh80bd1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 10:33:33 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93c9a1cec69so26831785a.1
        for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 03:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790764412; x=1791369212; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B2GcS8YJdyPJLvcVPFTZGMq8aLk5heCCS7anZ9DvINg=;
        b=HtorwkA+urWbgF+jhXdoyPG+ElKytgyk3etUD7uXHyDjP57g9k5UaNopNtC72HJaID
         dDHTG1zMWdcgBbk5pmufC4GGBVwUZpEI5a9NipMFyQzKlCX9X5wnCoJpmHRm210z/RVg
         chqf5KttsMwTBfxSEdn1fzY3GWlNTs+nOslBB0x9guYrKlN3E6rUdeiu8Wct8RFX0GBs
         rjVlIlsIOBVgSfcwxOHNFaeeYln82NqQ/XyJY9zG1/ElF/oUSMYGbZ9S1yV2uQyzycJO
         /k1beCNeBiCcdzSXXiVSx2jl0iyQU/86JtuoUbC4r7wf65+8aX+/3SrHQ9FgcSau2vkZ
         3+8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790764412; x=1791369212;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B2GcS8YJdyPJLvcVPFTZGMq8aLk5heCCS7anZ9DvINg=;
        b=aGOzKUBoUkBIT0GUSTlbVEF3fyDzqJ8xyK+gAgdjPWck8k/GSpW1RPYqRcnMo1QH/B
         Coni5d+rPG8Wv+VgFeuw21scrK75UDe8n2g8UQPcsRkyr2ITOHUHW99BcdXcYm9YLJRE
         ZGgey6BweoznhvsQeWkpemedJ2DGEATeXObuI137L43r4TH+1GMMmSr9+7qgiLyxj679
         /cVFylbs693Ckv1XushyAkKuliG3sju0ff8K2kTHhxlwJwWWNEot4kJCsVcR797opX9q
         o/1bisVbHFzz04k8xHGL8EIzQ80QsNKpZbioGhWkFNcuqHFmLunRuMAGkvbkpD9Op0QM
         wWvg==
X-Forwarded-Encrypted: i=1; AKwUvBwN5Xytsf/xbGI/j1VU059LOiM6ClLI1clO/iECA0VuNCPkmDhPPLoYXgVJEi+tqVQ/Y+obEw==@lists.linux.dev
X-Gm-Message-State: AFuF++m83as9wa0jLo/snbcWuffJHbu6PTD7i1Rr2Cuhaqa4gaWi63+6
	cdV2EjaT9vu1+pcFsPUPbzj2NVrKSWmWvn09zLHFAzYsdwZDjCEVfaFY5Ax7o233NamEpnLPImm
	EBLnHUvRq/48PntQBxoklsZ9OlHYV7InOWA4w/64pILb+XWAsYdNNJlQVUA==
X-Gm-Gg: AYBFou3rLDNiswyg1islnKTVy0odI1nzxzJy5iz7po7GxYjlex/N+4sKSAm8z4I2TpO
	rSa2y7Y803eGTQvtzUvb86D64jFOWPxaVJkdytiZ14nEQcuq7g2GBVmJS0FnV1AjApb9tXPWQG1
	2AqsIYffLHjwD0vbHldwQgkqozl6AnRUwXFy8M+JhZnlkWKEcVhW2SKgiIznJQYGi9DEq1LyRgH
	bpg6luSTAqgqvnfTf1+kH1VLNKQOXv+KdxTbvZ1JcAIS5f27tpwt/6ZyKq7KwY1KhuIgAfKxfA2
	2nV5y19gi716y9tgDhKsUgLOySIwq51s/tWey/OO+hFEJyDL1eLeCMooAHtR4Zw0BjRZ2KL9Jjd
	cd6444EWhrGXU8RH8pYDyig==
X-Received: by 2002:a05:620a:40d0:b0:93c:6a0d:762 with SMTP id af79cd13be357-93ca93365f1mr132044785a.0.1790764412180;
        Wed, 30 Sep 2026 03:33:32 -0700 (PDT)
X-Received: by 2002:a05:620a:40d0:b0:93c:6a0d:762 with SMTP id af79cd13be357-93ca93365f1mr132038785a.0.1790764411558;
        Wed, 30 Sep 2026 03:33:31 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ae047e9a39sm671766a12.1.2026.09.30.03.33.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 03:33:30 -0700 (PDT)
Message-ID: <687c93e7-4ac4-4a97-b139-c1bd257670ca@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 12:33:25 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/13] arm64: dts: qcom: sm8650: Add Iris context bank
 subnodes
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>, iommu@lists.linux.dev,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
References: <20260926-vpu_iommu_iova_handling-v5-0-0322ca5dc10c@oss.qualcomm.com>
 <20260926-vpu_iommu_iova_handling-v5-12-0322ca5dc10c@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260926-vpu_iommu_iova_handling-v5-12-0322ca5dc10c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA0MSBTYWx0ZWRfX5Ityawxk2iJH
 xt+/BlDgsXkn0sfKshGlEpYiJd9lhIbntOPopxng0O4tliwBSL2IBLeq9Y1OMX8SZ5VCwcqfCLr
 EaZaa9hM7E/ApN5JT748BAwDyaCSCv+eRfLqUcV5SC59PQ2bDmAScnIXD92Cf0dSa0sYgasQV0K
 pqw4v/p7mjLkTsr7yxvVnKjXgLFS8FYevSJxIXKbtjFeXD+RV9U+1ejQiCD3lZ9In+i0qQV57SE
 GfpPa24iULnvSIvxGyqCDls0s+Zg+aM9t+v7FTTAaH2r1SR9//E5itsiNviweYyJw9DHX8ciXEz
 Z8/7RNbhMfZdqvggmhQDill4/Ixvfw34NYdmPnDGMoBkpLvE3Eu7nJUaRgjAge/+QQkfistHRBQ
 5+JZXr1W7nM9sFzsCF/ajA0BpGcH0pwP641hDkJ14p9JeZ7id85YRbYy5GtvtCmonUljyTYE53B
 6f9XDoS+ddMI49N0tTw==
X-Proofpoint-ORIG-GUID: 12kHBz3yD0ft7iE8b5dy4aSNRPM8JLcn
X-Authority-Analysis: v=2.4 cv=NedzRGD4 c=1 sm=1 tr=0 ts=6abce57d cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=4BULcDCo1EIeXDFKsSoA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: 12kHBz3yD0ft7iE8b5dy4aSNRPM8JLcn
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA0MSBTYWx0ZWRfX4wNQhzil7uR/
 TcWNUysCpbzrGfjhoozqemAojPUh71j5Bu+Y6Kx2rAgzqh6dkyIh4i9OW8bBLkUQCjUbIKW6E+w
 p440SEzGSCIShozrfw9/RPo+AESyuHM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300041

On 9/26/26 8:34 AM, Vikash Garodia wrote:
> The VPU issues DMA through several SMMU streams, and the hardware does
> not give every stream the same addressable range. The non-pixel stream
> cannot address the low 600MB of IOVA space, while the pixel stream can
> address the full range:
>     +-----------------------------------------------------------+
>     | non-pixel stream addressable range (600 MB - 3.5 GB)      |
>     | 0x25800000 - 0xe0000000                                   |


Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
