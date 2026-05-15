Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A16438FED
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 09:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778837751; cv=none; b=ejU3t3j/NnV+GTHqW7zGTR8iJbg5Q2pTua1OKc+EXeVv9afEgN8Ev/ZcuxonPAmXLmkjV2wNjl6qK9NJjfijBAT+GK8cWV06VWft3vCVKw4saqg/wtL4P3DuHvCi9prsMqGW0VSk/U/4HLhtwH0bJvbzOJH3KlzA/QwKnKhxYJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778837751; c=relaxed/simple;
	bh=lk0yUUbpT8/U39ivTcsC1egqSJRZIo+BJJ5eGnvW12g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vb1XCWWrvgiY7xmfQsvSoE7Q1dzRc2Z86j80GrXtR/Jwbe6HWzpJb9AYd1lwHaoNMh5GKrA2VF2C3ZbE514hLsGXk4HdpLSkfK0f1Eya2KQpoE23rga4egf/98RSvtYy4AAAO1qEG2iFOjdJMUPzuF2aYbAMDmcMh2Wx9NZb6Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VFteFIgp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Jgp9CEQd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VFteFIgp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Jgp9CEQd"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64F95dGU1714959
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 09:35:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lk0yUUbpT8/U39ivTcsC1egqSJRZIo+BJJ5eGnvW12g=; b=VFteFIgpWTy97Kvi
	MNJD2q+DW11IkDrK+Fv8PrQ9HSJDkcsMwH+aKYt1WY6asyg/UqBiiHbTHjhcMifa
	xD9xbhv92Zpd35M4ZW7kjWYopS4sx8r3vBHuBLc1bblcY9RxMtii4K8dQ/KM4yxV
	XG5sPJVkQpBu8XOEL8dImJTI/xJFjcYicfGxiqljemPPHji5v4O9FwakD627F8IJ
	S7qLbubheLqJf4xid8O95o2czAoOZ/eL2Ih6wIBQZoGWjFOOiSAIUyy9Gaxa+j6o
	dP0FVXoGu2BO82hoBXJBXG2jXZGAxAjtvADCw5KCFfTZcjoZc0Q8bHUnE+u7s+P1
	LmlZdA==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5tyxse73-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 09:35:49 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-634396ec8fdso396371137.0
        for <iommu@lists.linux.dev>; Fri, 15 May 2026 02:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778837748; x=1779442548; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lk0yUUbpT8/U39ivTcsC1egqSJRZIo+BJJ5eGnvW12g=;
        b=Jgp9CEQdup/LHDZti7scvykSXrSRjVV4ChWicC/kMCso81HMlWmkJ6ebU1K5MH5KPd
         5CmaTscYLlXcBr1TzX+mxJG6i4oMd3URsHmEn0Re6QDLHhAfrUb6fGcAikgaVnH407Dk
         Zyzvahj6ike0Rn/JxiLVGukmmtnJRJ/iL6txFnzqlc9Q0WMug2qKK9EXWIi85fQ2ho5T
         0UhpFAghVSC96eBbmG2RmPdctqF8L1351KsT982wwNTk2FXZ4JwbSY94I0fATupRisnZ
         UUnulFypgTdChp36CJE74jZnMmSw+Ksp7dM2uI+nfFJAhSIw9UFtxSHpxcZQ3PSKytnv
         MXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778837748; x=1779442548;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lk0yUUbpT8/U39ivTcsC1egqSJRZIo+BJJ5eGnvW12g=;
        b=f+p44KkNg0Yq/wO5C/JJFrqEYZYU2oWyY0/6XPo3mXucQZRV5JAyHa40oOtD0KmOLI
         lf5NlBIaTP9ZD1XXC6JwGtrrKUIdiQiGmXHoz7qLfBvngMr8RN8d/nbPYBX9F9ayz8ZM
         X0kCLx8I4bqYK0DlQMTJm2u377gMcPSbh/Q3ISLKU4tWZtnvYYr44gN1TvLytTTTvmpD
         Nvg/DLjo2vTfHDSECFvEA1jKqEZGaqiEOzenzcIrEvr0B5KybPwyHV5UDcXcBSee2RLs
         xGIMTBkt8lIdDJ2RrsEzUcoEtcpT3YOWAvHPH0kvYJPGIz78lZIT1BDt4W50Es8oDOG4
         O5kQ==
X-Forwarded-Encrypted: i=1; AFNElJ/nFkzUMELWHd+oo5aJdiNIfZ7EP8OpiXBzTxrBEKmp46Hkslt6gsNLVBpzLtrXFcZ00uX41g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw2zijtoQpfPBlHlBv04gLRkNiallMbv0LBVgicocMueLb3fFvS
	aUoppstNtuJvumXowRJt6bLTh2QTYMvRUz37xwUja1s6O4qCsJfLnW47eJcuECs2e/Rj9H2CxVp
	RzlPwUz/Z5TcHayeuQtkiXMUduPFkFCYYOh9hXo/tpIsNocOQJHO6NE34zQ==
X-Gm-Gg: Acq92OGzRQTWmjPQ+THdDKYYnhMPcas7wIiMbJUiEW+TQelrQcpeXjj9y0nQykp/b7B
	J3xNTLO0nHAw8bc2cQqXH1gmvlpSaj5ZXst/05PmbQn8BHFqDmm3MV+1zXTZLSFxGzOJS3A7oqi
	lTYwR0ByXQbFURuSX1I4Ta/6NI21qX/WL5YK1lDrJtur4orry2lbz2QJ2qlK5KxmQk0XpsR9v2Z
	kNlzfTKTA/eVAXszkFtvxGDgv2y6tCD2RPpk5m8HSs8tsFkWPOhbE8bbVXuclABqy2nf4NI4s0/
	W0wsmPX5l/9uGlHjP9al0wdNzvkDGcllL5nQzsUZfoV/9NC+a1QwHIU1VPy4CRIx9WP7SggRxpV
	V+xDqQxFvIab8V49X4z1jIc0672saTzpxQrQBSvYkOZxm49hiHTvFgFKBSOvUzMwPfdJEuy15Df
	OGbHQ=
X-Received: by 2002:a05:6102:21d6:b0:637:25ea:99c8 with SMTP id ada2fe7eead31-63a3cc0c981mr429427137.1.1778837748268;
        Fri, 15 May 2026 02:35:48 -0700 (PDT)
X-Received: by 2002:a05:6102:21d6:b0:637:25ea:99c8 with SMTP id ada2fe7eead31-63a3cc0c981mr429413137.1.1778837747869;
        Fri, 15 May 2026 02:35:47 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4e5eef9sm195347866b.51.2026.05.15.02.35.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 02:35:46 -0700 (PDT)
Message-ID: <af2a9994-44b1-4945-9c04-4f31c1ff60f9@oss.qualcomm.com>
Date: Fri, 15 May 2026 11:35:42 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] ARM: dts: qcom: Add Samsung Galaxy S4
To: MINETTE Alexandre <contact@alex-min.fr>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Guru Das Srinagesh
 <linux@gurudas.dev>,
        Linus Walleij <linusw@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Kees Cook <kees@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        iommu@lists.linux.dev, phone-devel@vger.kernel.org
References: <20260427-mainline-send-v1-sending-v2-0-dcaa9178007b@alex-min.fr>
 <20260427-mainline-send-v1-sending-v2-8-dcaa9178007b@alex-min.fr>
 <97969bf9-8eb2-4498-90bd-9973fb2bd638@oss.qualcomm.com>
 <edbaf71e-6a47-4294-a8c6-6b356bc336ed@app.fastmail.com>
 <fdca4d01-eb6b-49a6-86e1-b6d582af4ba8@oss.qualcomm.com>
 <bb8353fe-29f6-4902-9c7f-67ef61676f2b@oss.qualcomm.com>
 <1eb77056-0716-49d3-b45f-d51ee5b70618@app.fastmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <1eb77056-0716-49d3-b45f-d51ee5b70618@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dMWWXuZb c=1 sm=1 tr=0 ts=6a06e8f5 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=NJkuH3xNc77H-X9ZbZMA:9 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-ORIG-GUID: gqWRli-MY5TLbmJeUwuT84rcAV3y0c91
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDA5NSBTYWx0ZWRfX9T/5I7vWTf2m
 YRVIvXG8wVhtu3mqwEeQj+B/5ab1bkgrAniZ1nTN8L9uWRTxbcpXNQiKLueJlLF0XSyI38fr30o
 hnan2CkYjDCtanpURbNrvDueJpdEY89wGMcawe2NCLF7HatlpBNXSy5nyJnCYvJAzX7a0N8GI6r
 vhyy5k+aQXkZOO2+vIfFrUC9KZvIEGm2OmhHhCcytvxg6/Bdjh4eZRs74cC9F4r3F01FKw5u5X/
 cO+sB2QVSCA9N3QlVK5uxQI5WfTwyGarEs10CmNTACSXFTJ04CcBsHJMr4Sb2Mb+Up8/hic1dW8
 dSqQ74YSEmbJA5qd5SLpHdCNm+ZRpWPJF/pbPoIF43ZJi4jP6BWVTlET6XXqJzmtz8SjrmOylRk
 +SyEhoWqI+FIGO16OewH303uaWecnkqayACg33GnDtPX8DuqCCZ26mxCKpXptBdEqWquW2jSoCn
 5evOv/Uw0htLhRZklVA==
X-Proofpoint-GUID: gqWRli-MY5TLbmJeUwuT84rcAV3y0c91
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 phishscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150095

On 5/14/26 10:23 PM, MINETTE Alexandre wrote:
> Ah yes, I see. I tried GSBI for both the MUIC/extcon bus and the LED bus,
> but it does not work on my GT-I9505: USB does not enumerate with the MUIC
> on GSBI2, and the LED on GSBI3 times out when setting brightness (-110, with no visble changes).
> So I think these should stay as i2c-gpio like downstream.

Alright, thanks for confirming

Konrad
