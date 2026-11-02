Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793624593;
	b=usCQ4Ea0YXOQZtDjUYcG8WLoB2kxwBEsN3f0lhvDUH8AzCZwiRtXg1SgQGSNOOy2qitz
	 eoHtvmfQsIyp3oHMX/4uSN/3w6kGeG8Bk8PczmBkrOJY2023SnAaVvwfNzjiC3HmXz/Cq
	 mTXdrorvVsWexGD4nel3nHBpGii8/QZMC0wYENGE2zEhKYuTe4BFcrabrfdA2qBRn90Wr
	 UAfIFq72Vm5qLZ/cyOHSvinNJl9rt1kEySrjOks5EXPKt2k0yThSx1g3Q+9znwIZkOpD/
	 0xLpaJchEmOKdPqH1/oMlo0KUuI4WtsfJzjWOi4vlDwGN44E53axQWvt9zaOjyj16Bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793624593;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=rwDvCUcycop1taBMmQpXpaVGTG1WRnAIuw6p85hHgWM=;
	b=yWD+irW6+8AH/M1qcO2jWv3NvvsyS/qiiSUowV0L0ooWzYdyAw2JiLN53R1L81ZAE+cW
	 QYO3GkBiwxKBmhF7bCznya6lW/anWVd1Q5GtoqD5EtgLCzvWn8r8WmTrRxYwj92LJsvhY
	 TPmv3BESoLrgUfsyNopnCiKHW9yqIwT7xPkdaJ5iou/37FqrVv6aIDtHNyUu2TCTcAUEF
	 qORKvw0qiYpzNDJwbDZIdvTk3t7BF3sGDTYqHB/0h6GCJrbDGhAaQehkVTz6k9Mxl72NO
	 dRel7/CDPpXsXIbfBr5cyb809I8MSeC+lZ/EWe3TfB8ycUFA/heXRpXggI8B9G1ss5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YwYVjH4Z;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MZ9ibgxu;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8196660A261E
	for <iommu@lists.linux.dev>; Mon,  2 Nov 2026 13:03:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8196660A261E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YwYVjH4Z;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MZ9ibgxu
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2D0BGE781675
	for <iommu@lists.linux.dev>; Mon, 2 Nov 2026 13:03:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rwDvCUcycop1taBMmQpXpaVGTG1WRnAIuw6p85hHgWM=; b=YwYVjH4ZysaBu8l4
	1s0nZo+iGjK+TUj4pKtuAYIgm2/oTd9cAZnCEL4/aJ3SCEY/bVs/r34GqFyhhDtp
	kE+HM4nuJAUnHGyB1n0J6SXPgq3yzYIdLSmt/DkJ+T1gC3BQsG47UfIs3rTpJOM/
	5jAQL7jqFSR/0nSwD+nc1UirHLDAlQtXcr9FWk1GfPinRIlawK7MsGKhEwfmUKSA
	dAQdl2CwFaleNszRvUFQjup3/S7IZXIVMB32ZADWZkIdtm1tNMWBpVv7KNKXSm+C
	C/KpfRer8MJDWFk9C1SwR1VPXBBjMbiiFOBvmgiq/yB2NbTHWtqUEGocwvSR6aWE
	Q2ddTg==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpqmvrvqd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 02 Nov 2026 13:03:11 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5c9e0f047a6so83415e0c.3
        for <iommu@lists.linux.dev>; Mon, 02 Nov 2026 05:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793624590; x=1794229390; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rwDvCUcycop1taBMmQpXpaVGTG1WRnAIuw6p85hHgWM=;
        b=MZ9ibgxukjsSfniGlMyh8Od9GYhxPV2+tJWneEdxQhHrl93jNfx0K38ZejZXuf1oxU
         5gukIz15JCgB1B7bqsF4XzSGNb/uKapObWE5xQCzQbtQOVgFqYEdkN0el51wEU0RKWP2
         Rr2TCXoeqvX+ohennkrdnineS35fsIB2G4gwQiy9fOEsiu1sGj7inztZw5Kh3VL3FADK
         V7EFQIpFJZJGk2JimEsEB1Uw24YlaICkSDXH5UCAiVVdWxz9fu97z2jgDVabXXGPiyNP
         RNN34rmmJ0j14JGuBwyzEKe1Uy3CDmsfUo5P7QXMFjXFS6bzPvDaOtwKftNkD/HYTVlM
         u3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793624590; x=1794229390;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rwDvCUcycop1taBMmQpXpaVGTG1WRnAIuw6p85hHgWM=;
        b=KRC1t13Td021zBB90+8lGPfi3HX4I/+oqMsDfmX3gJYMyhFEjg8ahbaEadzp8+Q6Ap
         i7Id2J64CxJBBCA8yWQj6MRV8mRUPHl4z4KKddSixv8Ilk5i/TXSQQy7VCEAtYPwam6x
         E/0XTlvMaTuE0Ar10YwWZ6t703+SiTuw6MQt95v7CdDeUNfGa0PcbixkiP3XYsP08loA
         gzoj8Ka84jZM+/r+MvVobnd7yI7wekxJLqtoKCBzqDsLBtpOqIB0+8u6/Qt+uOPBZ2sZ
         7BIr3z17T8+Ns5y9RWXsvQXRu9z9T30yKoUWEEoe3LRj93LtHt9bU1K6QppV3oAzz+jt
         vz8Q==
X-Gm-Message-State: APuU4Z8IR30ZRxw/58fSwkDuntztBdyTBCv5ijhfjZjOcSP9K57Jl32c
	GqNNuYSA9i9xic5Nc7wvr8c1vIeBJJzyfo5F+TfzccPQCe/r/Fa1TMwo3l+wrmczCL8YRrq8LLI
	ZbB4dLOFsYuyg1cyCg59+vA54jiuEp5goIuv8nmvCxtnDj25A5Kn6SA7agg==
X-Gm-Gg: AYBFou0iT7nKXARwAhOmvF8hLAy5pT618LajkVbj4Io3mXljK8spUdz8LdxfDhNijNX
	pH/JaNhiwzjA7yJpc7gUsRxRRcWF3VFzrLczz2ol6dSgcEiVucULryh2IMFQoSvHceR6vBZ0dWE
	ytREpYNVfP9OBOys/F3e4GfNmaMmDF8eWBkktOwv/SJWO2/GcAovHsZVTmBiCOQ4l7BJeefd9Ah
	TCeUeA6M16I9Yava2L9qoRsp/66PiwuddyB1mruTjuZRtOh1HZeRO1EJKvmBVZRFZvJlouW6j+V
	6JWMzglFdqlbQXSllu2wFb2rtqUoKBQl/5UktuMp7ekPllfQrAHJMU3P3N2WS5STsBofeuvTxgq
	/YRAUMNlMVpZm+SME4RnMOx2b7U4XRg+FKCS3giiTRWVAv6dtFn/MKVaCmKLVKOikyATkB5M=
X-Received: by 2002:ac5:c7c6:0:b0:5ea:d67f:fd39 with SMTP id 71dfb90a1353d-5ec68998269mr4388746e0c.5.1793624590374;
        Mon, 02 Nov 2026 05:03:10 -0800 (PST)
X-Received: by 2002:ac5:c7c6:0:b0:5ea:d67f:fd39 with SMTP id 71dfb90a1353d-5ec68998269mr4388694e0c.5.1793624589652;
        Mon, 02 Nov 2026 05:03:09 -0800 (PST)
Received: from [192.168.226.248] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfe072d19csm1698389e87.40.2026.11.02.05.03.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 05:03:08 -0800 (PST)
Message-ID: <14d63775-3024-47fa-a495-60351c31e6eb@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 14:03:03 +0100
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 09/14] drm/msm: initialize LPAC ring
To: Anna Maniscalco <anna.maniscalco2000@gmail.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org
References: <20261029-descriptive-name-lpac-upstream-v2-0-a21a5c850961@gmail.com>
 <20261029-descriptive-name-lpac-upstream-v2-9-a21a5c850961@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261029-descriptive-name-lpac-upstream-v2-9-a21a5c850961@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TMDQ2Fla c=1 sm=1 tr=0 ts=6ae88a0f cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=pGLkceISAAAA:8 a=km2EZEuaMOR48S9SEsUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-GUID: mo1Gado5FOzCEfXRbwi03ZymT7pJoT_H
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA1MSBTYWx0ZWRfXx74+4PLubyKL
 ky92SD1aTpywMkci1iHP4fVczv0PuoF24754x7qFQdIj2wxmHExKreeFaLShBDwXDcRPOPq/dx9
 UwxJY4M+5Uah2vtiGOog060LBvsHHFE=
X-Proofpoint-ORIG-GUID: mo1Gado5FOzCEfXRbwi03ZymT7pJoT_H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA1MSBTYWx0ZWRfXz812iKOHjJHF
 0VO/dD2ydIXhjnncBT0P5LlNCqV71AN6+Sd9iWBiNYrItC7lHVzUMjlKJVFqd/YYcG6UfJ/njLM
 baTgyyWrqA8cPRtRUvjGGpe+eaYGzh0gFM8muG35cFaPkVBxT1GG4DTn0C/hiwIzZoCG36qoFuw
 bXi+UVlqScMxPZ0kIg4qRas0NT/IepMMVWlFkXCNIQdRjk0x99fUr+qKbIn87FpeWhh2ZeA39Pn
 ykazzl1nWA8sUbcQnWF7Rqj9IuIAKi6NFiFEjyqa4Wumuo9S1jD1nrTnwKRE1S0Lg2foOSkThkp
 9L0YEl29BZCao8pujvWiPDtCI5s8duDKEJC52PhaN6FuHoZcuEOwuIbJGtP6vrOu5/++k7HKokx
 UsOC008snzvO6ACEOxb8MbI7X3vMkPG9VSy8X1+lfuP7ZUfNbu8B+Crh8YgL3sfi0HhUXPcwGcZ
 y5E9a84AKr/ecD/E1Aw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-11-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020051

On 10/29/26 2:52 PM, Anna Maniscalco wrote:
> Program all the register needed to start up LPAC and send initialization
> sequence.
> 
> Additionally, now that the LPAC ring is live, make the code aware of it.
> 
> Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
> ---

[...]

> +	/* *Don't* send a power up reg list for concurrent binning (TODO) */

Here's what my robot came up with

human tldr: missing the listed registers from a750_ifpc_reglist_regs[]
and a7xx_pwrup_reglist_regs[]

LLM:

The strongest IFPC-specific suspect is that LPAC setup is not
fully restored after IFPC. The series enables LPAC on gen70900
(Adreno 750), which already has ADRENO_QUIRK_IFPC. When LPAC is active,
patch 09 programs several GX registers in hw_init(), but adds only
CP_LPAC_PROTECT_CNTL to the A750 IFPC restore list.

The missing registers are:
- UCHE_DEBUG_CNTL_1 (bit 30)
- CP_LPAC_CHICKEN_DBG
- SP_CHICKEN_BITS_2
- SP_LPAC_CHICKEN_BITS_2

A likely fix is to include those LPAC registers in the A750 IFPC
restore list and the applicable general power-up list, so their
initialized values survive collapse. The KGSL code in this checkout
has a similar pattern: it conditionally adds LPAC chicken-bit registers
to the Gen7 IFPC list when LPAC is enabled (adreno_gen7.c:652–660).

Konrad
