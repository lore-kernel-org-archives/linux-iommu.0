Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DF630FC21
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 08:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777363722; cv=none; b=n9hRk7ClQmwNfJu9F58h9G4+WuPAn9I9aF5DMjCwmwNAKNGtN3RDDornLAJ0o1Atmel443F0PVjjWnSfLxO0P5pjwRrB4qO/8J3RwtSvWnJVVVj3X5n8Q4vMMuJDZNjJzpXr/xyBrb0IwZn29uT3lOtP1Wpe12vPhwb6r2bOKkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777363722; c=relaxed/simple;
	bh=JTml0sJEvHCoPx2+7e2IBnyRODquxGMmZxKsUP9MvLY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=qF7RIhHpRiHC6ij4uyFkTqx2PvEE48uKwz+DFGKPUM3pFhsM3pjmT1HSSzth8pXSr2JvE6BgeBIADQ9ZhbpFr/ghc22kc1cQhmk/ysVtU4UwZXEKUyegwq2nzhngtwqJt4RgqDTCCZBoVXxw9ZSMIgAcA9JNqSzt3p2c0Uh1wng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WlKQij8S; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eM8Tl2qf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WlKQij8S";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eM8Tl2qf"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S2mEjU662902
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 08:08:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JTml0sJEvHCoPx2+7e2IBnyRODquxGMmZxKsUP9MvLY=; b=WlKQij8S0tlpwaSO
	1N8mKTGe5H1O52lOrh8HwAaeYcsufyFNNcIorv+KdFUNLiBSiQBNzS7GwtQdlmZC
	e3nBU7TOmAviuumnLZClaHbMliqdhnkpNxQHYvBv3XSMvOl5fSYNfWH+8YdkVblj
	8XCiobRpobU8y/FFR/HJxrc9hk17Nx/n5BrfZHIAIruBSwRA230ESvBkd1B9hEBR
	plQGKdj4RVOxcGLN/tsqn+VjkbadOwtdkBRA5fuPKwEch/GqImViT3mgyfAsEHlg
	vBnU8AB0MWWpBl1NceBVIjuZf35kuNeycOy5aFg0/zJRBZZOUmiHja0bC2MMNnX/
	n/gNcA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtc5n2wxb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 08:08:36 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35e59791605so12130073a91.1
        for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 01:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777363715; x=1777968515; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JTml0sJEvHCoPx2+7e2IBnyRODquxGMmZxKsUP9MvLY=;
        b=eM8Tl2qfH68AUW4XQSif3Wvk+Sp8qj1TEeRUqaEBRVMl1rTZkb82Mg5iqNFRkuL4mL
         GouyL7qlp9iw4mqvKD83YPxjPIp1GARIpfqm7uHAB5itbmaVEuUgSdX2wBIrETlxu9lh
         3TEUBiFVqWcGJuwWdDzYIGQac5al4F5AEIFQqvTwKUaVdWRTHgqc79xbmxOPPdm8WgMr
         8zB7R9NNJuiHIa8Q6S+Fn3K2S4D6TZJtTJQdZwPME2KSsZ11z+3fiLR+OW8Ufy0DZO3T
         3Nh0/d2fK0zNdq25goLzBC1P7dBI1eCzPWuvvf5Xt/x1zpqEBlRWl0lHo/qW2rGyOveP
         FWsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777363715; x=1777968515;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JTml0sJEvHCoPx2+7e2IBnyRODquxGMmZxKsUP9MvLY=;
        b=hXWHN5kNRFKR4YKOLGf5gTUIe3uKiOfV2dtN2jlFBg6tY9z3qpTIeN8rwgAwssiB8o
         S5rtyWE7Lpf/6iF1O+iacpSOar8aHD1jTaspbB23A1MHZKhyQYAaIRTp547UG6DHtKE5
         uVG3Su+LsPOldrfPX0h0DxYk5eD9SM/CIv2MpkE0Io3XoMM2pvAl+DDXTu9WMi3h6D3q
         MZD0iR/FxQpMg+9mbjKRh96gO5xUUvt7GVbmnknXI3pLmkBXJcc9VbGKkp0ECna4vrDD
         n9b+fWrwMkdLuD0XqKZ0rIpE0lLn2mXqB1Z31yyHTYbgCuV3sUj7JbsNi+1R6w/Dwjj3
         Iayg==
X-Forwarded-Encrypted: i=1; AFNElJ+TjIw6M74cZ9P7r7sfj/r/sBKm42EvvIcu0uaLiZZp8j6baNhZlNRlPLwHHFYSxE/Xz36QtA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxD5zAklLIqrNthVan53nOSqEOPuAyBgpCtclultxAsA0VWMDqu
	LHZ0C7HorjCVc1PRLyAngBTZafsAbw5Snj0ZjraSiPduJGGyeuVgbLxt7ch0hvRIDQ4UMyvwPYF
	s1wEKZVh4CIndS9hQsrknybk09hWkVWd/tntEGtgkpApVvV7nGBry4T7T1w==
X-Gm-Gg: AeBDietpAdDD3m47vafUBauLvWwr7beUpXhyMx3iERJbdnGLHFr3XXhsOCzEM+t6kQd
	Xhwq2wVaGxHrzzhs+dRaZIMsmjypAXBezIPAKiwc9eKZEX9OFHncEJ/lQsUmTn7Kf7aivfS8TW/
	r/MtA0yByj7CbfhrTEODR2eAIoqm7dYf/E1VC9nmmQs95CHFYSnBYxjwYi6NMrLVNaH3gzFITtA
	TEUoqU9HGeqvKTmq0zljrlLA8ubNbE7gNrUcBxUYiVkPrQYJBUtoWPWSooo+30H8Qawbh/BZgT8
	TQ6zEtvgOwiSVAYtH3Hb6ce//5VF93GNKrFzaWleKhukqZHhabWExvBkvoLsdykrT9y+UYoA4Xl
	/WlQdw7Z+8Evcx0FBXBHCa+gnSBaKDN+Xp/0Y1yyU5FYNcRGOgaJyokZM8iMFiWoq
X-Received: by 2002:a17:90b:2e88:b0:35d:9c32:6219 with SMTP id 98e67ed59e1d1-36491fda867mr2410772a91.9.1777363715235;
        Tue, 28 Apr 2026 01:08:35 -0700 (PDT)
X-Received: by 2002:a17:90b:2e88:b0:35d:9c32:6219 with SMTP id 98e67ed59e1d1-36491fda867mr2410709a91.9.1777363714720;
        Tue, 28 Apr 2026 01:08:34 -0700 (PDT)
Received: from [10.206.105.200] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36490c4f3edsm976224a91.6.2026.04.28.01.08.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 01:08:33 -0700 (PDT)
Message-ID: <97aa5f18-d1d5-f082-9075-a385255f2e97@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 13:38:25 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Subject: Re: [PATCH v3 02/12] dt-bindings: media: qcom,glymur-iris: Add glymur
 video codec
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, iommu@lists.linux.dev
References: <20260428-glymur-v3-0-8f28930f47d3@oss.qualcomm.com>
 <20260428-glymur-v3-2-8f28930f47d3@oss.qualcomm.com>
 <20260428-nifty-quaint-hoatzin-6de65d@quoll>
Content-Language: en-US
In-Reply-To: <20260428-nifty-quaint-hoatzin-6de65d@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDA3NCBTYWx0ZWRfXz0bNe/byGffA
 2izM8VgREkCk6kzh0wxyOAEVqHmWQza6x/i6wmQwnXkwNtaJdmN7h/xxfYDOYjs//929RFFrJ2c
 9uYsv7oiHAVmUIIDk5yykjt1Tod+4gQS6iZPHb3siy+Qd3raN3LpoKTdtwsdHvgXWs6No82AXjl
 erUVY1SLyBT9ckILFBmQWFSRgcKXda1Hps+MnDveQgy+/O27tlqCb8gcqbuA8Lsk9rSzPrktYlA
 mkATNVO9DXiTwdevy+cBqP6kQUk6l5FCm9LkwJ0yigrCEwykeC7KDZF1/q6yAPgvGV43kTjoz5t
 RPLlL3rL0ORKlsb9EH9XyAyXhi9MDiQ9BZU1FCl2DePy1rLGgf8QvI9XgY5/SvO2SbuoJM8gHXo
 sycRjsip78VXHsIMQ9P/YGSQNmcPoWmAokUwHXuL44WtAn2JAuv61nyTaxHkPvcKE+IDY8FIfqT
 AnS96BHrzjRbiyYu8+w==
X-Proofpoint-GUID: M4ulK0v1rtbkgci7LYlSHm84No0S1-_A
X-Proofpoint-ORIG-GUID: M4ulK0v1rtbkgci7LYlSHm84No0S1-_A
X-Authority-Analysis: v=2.4 cv=ZMfnX37b c=1 sm=1 tr=0 ts=69f06b04 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=HCVpI3b-1_oNncJzd4sA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280074


On 4/28/2026 11:44 AM, Krzysztof Kozlowski wrote:
> On Tue, Apr 28, 2026 at 09:24:08AM +0530, Vishnu Reddy wrote:
>> Add device tree binding for the Qualcomm Glymur Iris video codec. Glymur
>> is a new generation of video IP that introduces a dual-core architecture.
>> The second core brings its own power domain, clocks, and reset lines,
>> requiring additional power domains and clocks in the power sequence.
>>
>> To accommodate glymur clock and power resources requirement, the maxItems
>> constraints in qcom,venus-common.yaml are relaxed. This allows the glymur
> This is a very confusing part of commit msg. You cannot relax the
> constraints. Each device MUST have a specific, fixed constraint. It is
> your task to be sure they are not relaxed.
>
>
>> binding to inherit from the common venus schema without duplicating shared
>> properties.
> That's obvious. Why would new iris device schema not use common venus
> schema? What is different here then that such possibility exists?

Glymur platform has a dual-core video codec architecture (vcodec0 + vcodec1),
requiring 9 clocks and 5 power domains. The stricter maxItems from the
qcom,venus-common.yaml takes precedence, making it impossible to accommodate
glymur requirements without updating the common schema.

The same thing I mentioned in our earlier discussion here,
https://lore.kernel.org/all/6d5516ab-f693-e605-77ad-e3f7d0bf579e@oss.qualcomm.com/

Alternatively, I can drop the $ref and use additionalProperties: false.
Please let me know your preferred approach.

Thanks,
Vishnu Reddy.

> Best regards,
> Krzysztof
>
