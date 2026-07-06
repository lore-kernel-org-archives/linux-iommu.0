Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA9D3822A8
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 20:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783368382; cv=none; b=n6U7yxS9eO6u9C9mMO7VFLbxRieg0HhY4Wn+NNffKs9n3vKC1fSlwWc2Y8AbiF2f71Y+l1hZLRdMtMXWshiFaAzh4UocHT/0fVPMQNtZK+8GqadMnTm8psO0PsynhxDjPsHTxSMSDmwS67yYDMGCxxuKh0Z+5IrgignO+VfIc/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783368382; c=relaxed/simple;
	bh=l8heLlrrTPYNvH6OlXPMwBbUF/B/QIXvGRy0A8EXBPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TyMcUtJA3r9FAeXN3EF1kVKMju+ak71ciHTVro0b2o28P0Iu++JYuJFf2MVc5QR3AaJfDoO5qS9TOOehwRtYocjkWfevExNadW1basw6YhjD1O1nAl6uYVJ9eq0gY9k5N9LaS6jbXlkImhCoy/+6RAFVyN6Dxx65kL6V/muZeGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A2+sA/pf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LUA78Gzv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A2+sA/pf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LUA78Gzv"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FFB0l958594
	for <iommu@lists.linux.dev>; Mon, 6 Jul 2026 20:06:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Wf1YrJ/RXa7Do+NSaW/+5hNmmnFSR5P/RAWYq4RDJg4=; b=A2+sA/pflXJxmGj9
	59ZriII2fhNp2WN0kzFToRm19PyG1ZzN3ZtAxwpUgIULN/i4b8olLkZucYfJgs9n
	sOH3W3gsdYm1pifuiPBorvFjOIT4YWzjDMPX5chFwUGIKJMYF/vipp7Bj3PlW9Ab
	Wd9+U4wfP23RFtxGBNJCzF/hErbix8L3deUOtvXK9tTCd/1NLObqo/xJ6rrsYGnp
	W0OfZyGPiohlFIowqWLlfwjN7wjQJXAdzAEDDe3OASOZm6ojJHPUiDrWHaiQJNqV
	mkfgSG4xC3pHLYsBvRTUTfOb9S/M6dND7ItLTZnSwktZgkxMrSPgpu8BwcVVWywr
	aAwSCw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88h9b6e7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 20:06:19 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-385d2703b64so156930a91.1
        for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 13:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783368379; x=1783973179; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wf1YrJ/RXa7Do+NSaW/+5hNmmnFSR5P/RAWYq4RDJg4=;
        b=LUA78Gzvscj59BBZlF7+9PzygdWPmpVZBj/Pwb5Jr+b/5HzA1mnNrda55xPksbKDVs
         lAOS5T17MeuqA7x0ZuCrHNWL3XT6oL8dWCwcVfUrLr8eWvK/Vj+zCrcYB9KgkwjV48OK
         GS7lYCwiYv1bS0hl6VB7nt1RKfhOyLymOB1xFB4ycLNZ+Wz2KG0vLhC19pdMmbJhstwS
         jzn45mJ0t5Kfa/XUbp7bfammHWDxk9UpOZ6YEBks4J6qRNXGpFSwS/IUwIpsSkxXl2NX
         6+WoDzZBHAv3Dsn5L+lbYd287RFHhTwZh2wY0WcIzIo0XMw57E7AX0s3A7UI916yoBZ1
         WLYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783368379; x=1783973179;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wf1YrJ/RXa7Do+NSaW/+5hNmmnFSR5P/RAWYq4RDJg4=;
        b=HGMS8LbDUGaQl0b7SxlD8OM/LtxV7jl+Ich2+IDtuQj2B2hfGCMWLkKSIOl38Eps2w
         AXW8PmSSxW/dM0UnUnSmmjYEF+EJln+XUELyzaWDtQP5Ssp/5Sh700xLifT6prDXJ3Ri
         /wxTX8WwavoR9Jw0kKKMZE6s2BI9Y7yNrnaKuNDL2/kYlej/xs2+P23bZfe73NuS8lRI
         oUdK6derXiWjEBZHCMjqNRAQw9Tv8PG3Lq35uHKpZ7cKJ/6PM9+z5HAcNj0/KepWGKfv
         fE+u62fZ1+YNBZNuWojXNZl3WS6auxklbJb+D+38b0vMVolYlhbPpvOBIR3p/juvaY98
         U33w==
X-Forwarded-Encrypted: i=1; AHgh+RoPbJtJy6o2UCRLCwEgriBoEd6SVDKOg0MOU8J2Ztu5Asc3JhQ/2VyUNINsB66rIFw5ldPYPg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx7OFS+A4m4IKa5VYRUDh2aDBxtbhsDwtboSAoPU/4WmQOD9x5Y
	xpeNtFoCJvAcO8uk188gzmqtPv1szYlc1nqCHUBqYXv7SVMKq/ka0QGco1DYgG9LR82P3tRu57q
	eN5zEkO90yvm17VEBa2rC+ehWp5KSBsxP5MDE6E3llRnZYIxkVfOTDU8bTw==
X-Gm-Gg: AfdE7cnu8hDTsedvZe6I3KHxADNv54ouOqckMRdZfmOV8j28O3M0FL9cUTcJoXBe51/
	IGMykV6gIW5puBJApQn3qjn2juuJPAfMTZJXKSFACdT4lsXbuPtU+OORu1bGkEHmDfcgG2O2yAf
	fO8tMB0Xt9YMDcB90L25KouUaKhfoWYpN1tlezbAIFldtKYKE3eUHXGcbuX3l3rcKQDY6V+T6S/
	4NSA7t3va/1ia+S2Adm+hOnSBKsh6C3cccHymk5E7hpxeTaeOEP9TKiZlbqZqlFemnO6MN19kEH
	uRAtxnXX+zvkIK+bd6DIp1STMcjt/eWR/HDXnliwLOwbEqHgGkbqleiIpT3OMsp4YOBmEwLZS8D
	myLZw+OKpkqD9W6k4mie/m9knKzsETUHflXQ=
X-Received: by 2002:a17:90b:2888:b0:35f:bb17:39f with SMTP id 98e67ed59e1d1-38112066822mr17984583a91.1.1783368378558;
        Mon, 06 Jul 2026 13:06:18 -0700 (PDT)
X-Received: by 2002:a17:90b:2888:b0:35f:bb17:39f with SMTP id 98e67ed59e1d1-38112066822mr17984531a91.1.1783368377972;
        Mon, 06 Jul 2026 13:06:17 -0700 (PDT)
Received: from [192.168.1.9] ([106.222.230.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f5982sm47949eec.5.2026.07.06.13.06.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 13:06:17 -0700 (PDT)
Message-ID: <b11cdc41-e88b-4815-9349-453f1bd5f14c@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 01:36:07 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] arm64: dts: qcom: Add GPU support for Kaanapali
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20260705-kaana-gpu-dt-v2-0-6ac53de56314@oss.qualcomm.com>
 <20260705-kaana-gpu-dt-v2-5-6ac53de56314@oss.qualcomm.com>
 <e2b7e03f-911b-41cd-8ac4-044492e2bdbc@oss.qualcomm.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <e2b7e03f-911b-41cd-8ac4-044492e2bdbc@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 3vJvVygXUTTJAR10pMROAZkNfLTtr3t9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIwMiBTYWx0ZWRfXxWme4rICv4Cv
 QShq/fVYufO4e/OjGKwsMgXhFvFg2RkFc6tYku6h7Ck1jJbPZOWQSEPsgXaUoHSs6YEWRF27E9P
 lGf5R8MeX8c0OrlBInD3uCkTUemtp2g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIwMiBTYWx0ZWRfX7ikKUIx0Cing
 Qda6n9r/bjzVLZvBFiTuYPuBmp2lGe1QM6sWm0fQlkSVrrbD4iBsXVKCZzERabC3zBPPGds35X0
 mZwY8yaD3MUy1igJpb7s4r1Rh9lWViDrGYSBezd1qOcYOUnMB1Y+p569KRwoXq0jYvgBq23iwUq
 5VAubVo4JFPxjG/YwETccjXEmIUZFP0xtSzt/Y4L4bGHyZX2PvKjKYoKGKBt+T4WMQMuuGUISh8
 jWT4BsdAGp72SvrVW8Yoje2JnS0elfWIp/E+dPj0fwlS3RN5BDNMkwzlshlbRTitTAz2JIrsyD3
 B0JW8ePQx4na8WbHHbZjHYX8dTYiPKdw/N5GxQyVZ8CnsvUx3FlS4ZVNrepwm9UxzFtz/Orzs70
 g0jaHMQC6v+UVsVD7OLGVfUDNk6EjWNxoD4Q8G1SaVIGBw3ILPqOSEgfZLg/l0kOAMxYbfelOP5
 ++htJ71d3uKtK7TVw2w==
X-Proofpoint-GUID: 3vJvVygXUTTJAR10pMROAZkNfLTtr3t9
X-Authority-Analysis: v=2.4 cv=GulyPE1C c=1 sm=1 tr=0 ts=6a4c0abb cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fsdq8dFr2Uux402FS9br8A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=ZaZH7ke036cbytEKeQwA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060202

On 7/6/2026 3:07 PM, Konrad Dybcio wrote:
> On 7/5/26 10:00 AM, Akhil P Oommen wrote:
>> Adreno 840 present in Kaanapali SoC is the second generation GPU in
>> A8x family. It is based on the new slice architecture with 3 slices,
>> higher GMEM/caches etc.
>>
>> There is some re-arrangement in the reglist to properly cover maximum
>> register region. Other than this, the DT description is mostly similar
>> to the existing chipsets except the OPP tables.
>>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
> 
> [...]
> 
>> +			qcom,gmu = <&gmu>;
>> +			#cooling-cells = <2>;
>> +
>> +			nvmem-cells = <&gpu_speed_bin>;
>> +			nvmem-cell-names = "speed_bin";
> 
> This looks good to me, but I thought that on a8x, we're supposed to use
> the freq limiting register in CX_MISC - is either of them preferred?
> Or are they just hardwired to the same thing by chance

I believe the other register would work, but I don't have a fused hw to
test. OTOH, this is what is commercialized.

Btw, the CX_MISC register is not present in all A8x GPUs, for eg: Pakala.

-Akhil.

> 
> Konrad

