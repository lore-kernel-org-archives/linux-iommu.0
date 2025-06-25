Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1131D25F980
	for <iommu@lists.linux.dev>; Wed, 25 Jun 2025 11:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750852615; cv=none; b=FyZ6vaP0bhqmm0Ui+NaPIFHOuqKrYJdw5WBNBHkIQx3pZ3/OK9MCsIgVkIykw0okXCEqv38EWL2QfHf/mHjd5OY+H547wy1lQYjkmsElKQZBmpim8rgURjHRkmfjjyqr0vj410e1a1FSHn2tPK95x5kO9RnOp7+XU03YJzexJJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750852615; c=relaxed/simple;
	bh=BVCdK3npxOuJY1EA2b0sv4BUq030Q9+u3iWzgAMxjkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KByIUHegNK9/o03PtJFk2w1XDSSvQ0pDRd13mHLnzmosmdve6EaI4keqNXsUdaBFHopu3pfq3BUmsteA0lFqLbYG0dDWpwWAIeWfkH5+Uyd11Cz8nabv6LxivbIgWHGTdIhUd6mHLdmrY7FjcFsIhizIVKawji+x+Dq/H0BmiMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gcAy36CW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gcAy36CW"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55PAgewA002957
	for <iommu@lists.linux.dev>; Wed, 25 Jun 2025 11:56:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qtf2LIek4hpLZ54vWooJjQr0lr5Bw40aXqP1yVThXvQ=; b=gcAy36CWTbjZXPo4
	LTSwKhbDedrFZlz2r+vLYTqGQbV/ntVaxiyCSbTWhGgbB4wiL4cFf4RcpxTeukyW
	Z0lUSg7KCMvc5YZyB20FRHLHELnUuDX76MW+Ff5cAnAtskiBNIMufa1fhKxduvjW
	gHpIWW9JY4YOBptfCCSpG9K90osox1ZM/Rb66n+jwJ+O8q2kAZwvwE0hdKiM8oL/
	VGI6Ao8ka2NnGxon+VNonHGnDYpVqFSwKr68tZ6/5EK1kwAgXj8RxJdBKOJdo+gt
	OfsE4gxhBaJrm38QaywRixi3s9AUIk36u4Y/mgV3Q8tLahgjHdQcgtNZuTHthVAz
	pnNLrQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ec269ye8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 25 Jun 2025 11:56:53 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7d0979c176eso155062185a.1
        for <iommu@lists.linux.dev>; Wed, 25 Jun 2025 04:56:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750852612; x=1751457412;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qtf2LIek4hpLZ54vWooJjQr0lr5Bw40aXqP1yVThXvQ=;
        b=Q5gcnJTxuROqOcYPL8fBuo31R8vfc+TZJQAX44I+2Jek/Sru+hYyJgTQ55s97p7VCD
         AYImAcynZwsHYi8q13sY5BpuVSkGWKNGobwRJjgfgz7WVGKc3qzqfhWy+fwnSo2XzaPc
         J2zJ+2ib5xE3v6PSZqgOK9YQ8sSi74zoIo8kmefwDS8H0AIlSJ+uMzRmS7pzzu3C5f+c
         OWHjrUIBXwIP7HfxsRNMiC3iTWTPRYMZ1TWpwN6lnFNLnFY9Lj6uBMLA6RbWSZwgwe0r
         H0M7hdjs9jGRfAxbQ4kW4Z7o52ZhRV5DkOYaoXLjz4Y4yn2z7Mk9m+cdHgNu4CkEh+Hj
         6LzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeAeQbPNCPHJpNXS1Rj1FIoH0NkuRtwrq5f81PuMugJIe1phKmrsMJcCvaUW8R/2QNULi2dQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxiHsiYyUEDd3N/3wpUS08umYSZGCF6Ymr1tNhBW59fQcj64TwU
	Bk26LrEsQeBLRtsa/gcSkXVTCGiXTp4SlHVnBENDcyeXNlgNp1IwoJ3+XLjE3WQao+1oYKhIkyJ
	a9EeYQ8K6lF+FQFpv3P6brH7+i72KOvftUwWbZ6RfO6whZoUHyEipYBayJw==
X-Gm-Gg: ASbGncs12SKdcBNdigGtMb3/uzxlgOjbJ6kqMvuPq18Ipfm0dcOPAccQk/TCErIPRoF
	K9Cw42iXrm6mOVmkQd/laNh7pdXFDvzwNnQJpb7ODnG4Yrsl+uYjG9FJC3NhgLqtb8hHLpQ11RI
	tF96KfEk/R+fDpsZvJiNnzP2qrT6HD2GWtsyT4i7a0LX/62QKXZFiRQK6S0fjsqdcDF2ZjdFVvG
	gPQB4Vw3/WiNjTqlIieXUIQ5Ovfa8VeUGWA1qAvZ985myQRRNaeEP6W3geTGewNgvsxdgxlPU09
	Rng0STaWIufO2l4tisF0kyFaHwxKbgheF1W/6z0WSqjHX5QE0pKAxbuI0GoLPBjlQOS8Ttoiqb7
	Jfdg=
X-Received: by 2002:a05:620a:2949:b0:7cd:4bd2:6d5a with SMTP id af79cd13be357-7d4296db1e0mr156157585a.5.1750852611662;
        Wed, 25 Jun 2025 04:56:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbNAdmHcL/ohxdpxrFhw+P+cQf12Kd+1+opwn8szOOQKrMRERAl3ZBXjt2J5pp3lvClg9lMA==
X-Received: by 2002:a05:620a:2949:b0:7cd:4bd2:6d5a with SMTP id af79cd13be357-7d4296db1e0mr156154785a.5.1750852611039;
        Wed, 25 Jun 2025 04:56:51 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c2f4842e9sm2431839a12.61.2025.06.25.04.56.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jun 2025 04:56:50 -0700 (PDT)
Message-ID: <b98d305b-247f-415b-8675-50d073452feb@oss.qualcomm.com>
Date: Wed, 25 Jun 2025 13:56:46 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] Various dt-bindings for SM7635 and The Fairphone
 (Gen. 6) addition
To: Luca Weiss <luca.weiss@fairphone.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>,
        Thomas Gleixner
 <tglx@linutronix.de>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-mmc@vger.kernel.org
References: <20250625-sm7635-fp6-initial-v1-0-d9cd322eac1b@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250625-sm7635-fp6-initial-v1-0-d9cd322eac1b@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDA4OCBTYWx0ZWRfX04OefvgYHIxN
 WdqLdQCnYbA0UluNC3zmbBgZ5uwnplXnfV0+duwAPbIJZvcsYU4cGxDIiLCzLyHHeExyNZaaTuR
 FiaV5MUmn5h0GfvavuOa3iAjf0kgpOhl9+JH7dIC2rP+7JAQyltCRLghZshxduQxmxDeoKfT0Te
 XwsXrEIJE6coxLSm/d2QQeDadW/qz0xlVMd/6VJYcPFR0E+yCIMg2DhOdKGA/pp6yrae94mMg24
 6upGY436O0ftNdY19EY2nTZBcYTWV47iP0Hqdq9Yjhxv971tKFJ/gaDg1ipHBi4s7daFfv7jvxW
 YXDMwTqr0W2azR2zjGPf8pkaDTcADByqYZB2o3ceHn7IxcpgrpyocICWwygolKtp2VTjiagDOfV
 NcRyUxpQZlfuSu9lqwUrHoSlyMXcu8hDr7DlM1voO7a+95LEXmfN4yMax/nvGlvNBV5Gjb1f
X-Authority-Analysis: v=2.4 cv=XPQwSRhE c=1 sm=1 tr=0 ts=685be405 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=6H0WHjuAAAAA:8 a=PtzdWR5wS_Xl21Jse7IA:9
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 a=zZCYzV9kfG8A:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-GUID: hPnyj9qb0WYuN3yCzIRYK-rRD17XfXO6
X-Proofpoint-ORIG-GUID: hPnyj9qb0WYuN3yCzIRYK-rRD17XfXO6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_03,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 suspectscore=0 mlxscore=0
 spamscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 priorityscore=1501 adultscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506250088

On 6/25/25 11:22 AM, Luca Weiss wrote:
> Document various bits of the SM7635 SoC in the dt-bindings, which don't
> really need any other changes.
> 
> Then we can add the dtsi for the SM7635 SoC and finally add a dts for
> the newly announced The Fairphone (Gen. 6) smartphone.
> 
> Dependencies:
> * The dt-bindings should not have any dependencies on any other patches.
> * The qcom dts bits depend on most other SM7635 patchsets I have sent in
>   conjuction with this one. The exact ones are specified in the b4 deps.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---

DT/subsystem maintainers, please hold off a day or two with picking up
these dt-bindings oneliners, we're having some internal naming discussions
and want to avoid potential big revert-redo patch sprees, I'll try to
post a decision whether we're good to go with these ASAP

Konrad
