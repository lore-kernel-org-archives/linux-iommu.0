Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53564848AD
	for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 10:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790764407; cv=none; b=KXBPxmGDkFm40YHdoYvskBRYJm6gTVYxeMAbNezPKXCdMCQaqLN0wyPW+qUrrDfCWmhMk1noQ+xy7r/IRSbssqtTWOmwXq9oZJEmw2ZnMtwEU31CGIS01g3xgWAasY0vaqF6G2wyLP9oQDHOWJELOFjLNJ8MhLE4u1oEoekpJMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790764407; c=relaxed/simple;
	bh=p0rtOpqJgYOdzRogUQx4C72rBJ6MZuOxyLFNm8hD7RI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cYXxM3h8yAYbLUVNMrR+BJXqcc3XC72dY2xhrJA+7msgzVhmpGa7XvR07iXws8v2rpL4w290jQQV+sylChOvnpYL8Vt2+NDVKgv3971LhO1uekbRHqwknE0Lcn/zN8kbgdxvftS+Mi/XsQUX1igoDpNdC/fnP61C7MlRFgDXNqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KKp3pkBl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RZ1Qjg15; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KKp3pkBl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RZ1Qjg15"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68U7dVsT2119208
	for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 10:33:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ekqw08WhSNuzNavRYsHvqJW6DtR1r0AaDDdoOSLKqQU=; b=KKp3pkBlG9NMn4o+
	Ie78eIItC5nrJQHzevcTluOiAL9eL+IM2U1fu2POEr0CPh21TWhoOJoh/3q5xDXF
	oGg+oJlL+dI2NFnXoFUUlMSBjBp60SqqKSFox2b2bJbwcfSM5exKxEUmjtRAGLBL
	KhrNGk++ecMx8H7H+ns1IWmdgdFnVfICtwPauN6XY1twkBNf1rQEAFAl/jCjHkat
	Hw76Q3tvDqvnBY9isdhW8J7IrngXZFJEiUzfcInlBymyWWJftxE58SeNLVzsvFhB
	foH8mUZM6lr89VlWNedjUse0YSfwmOyOdW4+7fjcSwA8Yuv7F2QrZw7oPW894TGp
	Z2qUgQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0rhej9cu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 10:33:24 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93bf3eeb42cso84402585a.0
        for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 03:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790764404; x=1791369204; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ekqw08WhSNuzNavRYsHvqJW6DtR1r0AaDDdoOSLKqQU=;
        b=RZ1Qjg15cSa/H9mWlemJdFuKiX8v8Lo4EvSBG1jWkswQPRgb0gxO6x3S9SCxE1xDav
         mT/u8RGxYBCJhJCggJCI8ZiaexhEQ7+ipdxx8d1/AYg4EhX0eCc3TnFQEuXkekGL7YHo
         Oy56lRCygMKEQN5fRa3XT+z63BZ/BJiLnm4429iUy3r+TnNz2mAFcOH2hks3ZFwqCALH
         wki6PYOLfirikhcypUf9FIwyINvzxRLSF8llbH9EBVEj+QCHipBKVlgC5qLfKg+PV0JX
         Vl/IC+sXhefjfoNLf2hazeUUupjc+gKpUhrY2QJlPpTHXTgmVtcMA9wkCsZuHYAi88BD
         8P5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790764404; x=1791369204;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ekqw08WhSNuzNavRYsHvqJW6DtR1r0AaDDdoOSLKqQU=;
        b=pJBKAcr05t1t63EkNyvOFTFh1+j3cfD7XIosbvqNe0jpGhh+m1A/f/VcfClI2iRdNY
         x3EVMWUz7J8wcmi734Xampo6k1oO2pwkHYVXDXNWuyNDuL6XbgRgZgkUY/VoHxOVMcJD
         /GQLQJet5zlXFFMoCSG4Ku7ERhQMTcbgvPQq8JiAydzaftS3WWfeZDfU5/when79bJb7
         vRUxHrk/ifF0V5lcMZeT4I3oKwcubXzA1Rjc5CFZnMlZKGDlsyPsW6I9O8RbiGyi9yHG
         KPBrolbnJgZwzGv6LCqXW12FyxYhhVKOgKxlKqFHXJPNKCOYwKYtFxF5cTXrAS5N6jqD
         4x+w==
X-Forwarded-Encrypted: i=1; AKwUvBwZtcqWapMsv/FblvdLwFphfpxQBppZe/yyGUjt+FAw++mMXwtj0zzp/HsfJ0BPpKx02fy4LQ==@lists.linux.dev
X-Gm-Message-State: AFuF++lz1W10y056bTXS6YSZhYVzEmX4JmyP83HHoFhGpj6LCAx6LJV2
	TR+7/4kA4PXPNkSJlKuNNbwuWpn4J8xDZ7AULTcsDcS2WruB26SK4SznWaok9WkLWbL/YAs0CvQ
	fevmWSj1a/Q4X04ojmkhP2TjE7bzfdnfbaKik7JtyDTJfVT0rR5+ADQR5iQ==
X-Gm-Gg: AYBFou0t+sCed0E9I7uK/+LPv6jqmfQtJn3dZUWZfMuJmYm806wmEIQ6V/Vg2CAa8Tx
	SVbTf2HjFBkiiK4dcXYhJLoiP16nY8lDwrdqunIZCCi09VtB7yTL46zAroS3+4hdoNliwT5k11U
	Nk409j1b+3m8HCa8oZNibLWSN6TzpPVBpS6gU2Fy7/57vdsidMpcxYjO8pCkIeaIwa+KVZPK7jo
	137vlHAK0zJX7W2RPgaGpK+u0hdDN4ctVajwW5dCfnwF5GIoFbEwhLUnj0BpjpOYtzNpgoDA8uD
	cWb+Rw9WVtzMslIVAfdx7uVtVOaiw2MY8OVxRlnJcRLRFgMIwR4fLOI7mG0OxEEfsnWoKjqUVNv
	BxWXTeH3elLHPta9s/f/dWQ==
X-Received: by 2002:a05:620a:84ca:b0:93b:ee2a:b67c with SMTP id af79cd13be357-93ca9756a48mr144984585a.4.1790764403260;
        Wed, 30 Sep 2026 03:33:23 -0700 (PDT)
X-Received: by 2002:a05:620a:84ca:b0:93b:ee2a:b67c with SMTP id af79cd13be357-93ca9756a48mr144978585a.4.1790764402614;
        Wed, 30 Sep 2026 03:33:22 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ae047e9a39sm671766a12.1.2026.09.30.03.33.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 03:33:20 -0700 (PDT)
Message-ID: <3439bb37-0aab-49d4-99af-8c2b22fc4adb@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 12:33:17 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/13] arm64: dts: qcom: monaco: Add Iris context bank
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
 <20260926-vpu_iommu_iova_handling-v5-11-0322ca5dc10c@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260926-vpu_iommu_iova_handling-v5-11-0322ca5dc10c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 50DsafjIbrhxU5N9ZQoHuvghhQTnG5cy
X-Proofpoint-ORIG-GUID: 50DsafjIbrhxU5N9ZQoHuvghhQTnG5cy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA0MSBTYWx0ZWRfXxEshNQvib4xx
 E7TwtQcq1N2D/51OMlbQ3gZNZr6IP5I0z99fIurQNeaWwPVN4z8c+OgTDoofNgYnDnnsnTUxNMl
 9PiV2GAQcAXEjB9yBqoi7rjHoX2f8scHCJFim7M136rwVwo7extcmovqTme/Y3xdGMiOGFNpnHI
 TLhLTAA5QEUBPV+OsFOWE2EPz/k+NBfnednrjpje8nCP6kLs2mGc//9mOrYWkZB8IuzaffT4XpN
 ldnH2DPoNby8MtkurexXDtitH8ahs0VGMxem/YbgUKyX0kPL2GLxfdWE67rQXuNyznw+3A0pNXm
 /ddZy4reyo3XbNtjANl0gyST5f/KvH/qtAcUWN849WG2eVNnqJSTIyAreROXdrlfm+HE0iYGv/R
 8PJXnRjXDbQkmF0N3gW7vHSY0dPstBpvgxjcUJ28u8bl5DG/RilGgfFOs/RRszn+RxpQ/Gk5rEH
 KX2fyKLKxQskHItyjzQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA0MSBTYWx0ZWRfX1qMk+Di10EPp
 4DfNCn8JNR9J37yxTXDf/arQqpR2jhEmCNZcS6/Ji+SBdLnVeKIoK+dznRCJFnmwtQGLBJGByIJ
 1v6SCvk7RBukKHoh5mrw2OYgS6WnmiY=
X-Authority-Analysis: v=2.4 cv=Tu1zFzXh c=1 sm=1 tr=0 ts=6abce574 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=4BULcDCo1EIeXDFKsSoA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300041

On 9/26/26 8:34 AM, Vikash Garodia wrote:
> The VPU issues DMA through several SMMU streams, and the hardware does
> not give every stream the same addressable range. The non-pixel stream
> cannot address the low 600MB of IOVA space, while the pixel stream can
> address the full range:
>     +-----------------------------------------------------------+
>     | non-pixel stream addressable range (600 MB - 3.5 GB)      |
>     | 0x25800000 - 0xe0000000                                   |
>     +-----------------------------------------------------------+
>     | pixel stream addressable range (0 - 3.5 GB)               |
>     | 0x00000000 - 0xe0000000                                   |
>     +-----------------------------------------------------------+

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
