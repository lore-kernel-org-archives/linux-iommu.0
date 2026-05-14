Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3480E3AE193
	for <iommu@lists.linux.dev>; Thu, 14 May 2026 12:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778762611; cv=none; b=kLGFKLaV7TcduQs7vc4lmfmywgE7rdYpCAHklqrm0RB0LmqEU+csVRynL+ykojuog8LQHv4niu+D7RXRuVlpeJRcnjCj88moKDSrzn5J5PsPVGxF82m14R4g+YIAAPTqsc78a/DciwQ/wc87zlbjee9S0Rs8NAUpQ+vsiIf75Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778762611; c=relaxed/simple;
	bh=5WxmdUO3QYYjWtLbTWfcSXQWZpK2u4YbsYkn6Q0Qv8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E/olDB7l3B/ROYsU/E1P2KQtlMV68Yh6RnNMVAn/KWVb/S7usJYzqSltqjLYTgjp7sGfb6wmWVUxo3MtEpTVh7xmFpaViulrkrbs3U3V2XXcdH5mvTQkqUPEv8pOe1e4jP56tAnwtoMrfjQuPJLgRcbzDvOVTyL47i2FNQJZhZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WTnpVJrS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CyHnA+iO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WTnpVJrS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CyHnA+iO"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64EBeZqg2261600
	for <iommu@lists.linux.dev>; Thu, 14 May 2026 12:43:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EU8VqILiVkLUPw58TAFmECDvG2KNHo2DCKZDUVw7+FI=; b=WTnpVJrSxdmUwNhd
	6OnwELisSHFfwHwNb57jJAIMiM4R/w+Zisp/JAhJgSHJbksSZTLcRgXos6ymekCV
	La1pdg7stJ8GSN+wKtWR+ONa1eqf41tiNg9suNWeI3Uiio0ugBKLoNWtKrsbKd0m
	2Jo0wJIcXcF0gyr84Kgag3qloKqLV21+lJX1aRSXCAAL1MrD+tPYG1o6FgIfkwP5
	qyQxQ0zEp0oyN4Spc2hI+41KgIfKOhWcueMKjNDbHDIZGx/APouCxSZNz0sRmAgM
	y//yKVb5qRZYteVpEg0upBvCbObqpcYr3X/8QZqzFatGZSKgHBix5fgHzCNJ/vQ5
	hRJvYw==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e563hhtwr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 14 May 2026 12:43:28 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5752affb36bso720854e0c.1
        for <iommu@lists.linux.dev>; Thu, 14 May 2026 05:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778762608; x=1779367408; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EU8VqILiVkLUPw58TAFmECDvG2KNHo2DCKZDUVw7+FI=;
        b=CyHnA+iOJkULTqqVvyXjfZGxFmWB3KidYA7zqb3mE7HWPuhgehAkLxf1ThVexzzOOe
         1vxv/I7JemZak6FgWGZtLAz3CsB4EzBd2Itn5UvXn8CQgb8KrNBLV4lRaM4qHoKAFH+A
         Gz+aJ48XlLeOrit0uessLMtMKLvnu9w3Is6i1n6mm5c+9tmuPymhVYvy3M3erCRke98e
         1+qVI8j+hgO0sgI4jArb0vtQe0p+38NcvMaou2XYxZR69/vKjIJ9FAc7LPki4DK+WF/9
         QVlraWlNLDmvNUeCJ9mHRjtegcpOttKhnzK/AVvvAunrOSWRZZR92dJ3VY99r+bGLfgp
         MtDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778762608; x=1779367408;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EU8VqILiVkLUPw58TAFmECDvG2KNHo2DCKZDUVw7+FI=;
        b=cc0xvOg+0bFtorWfvSt2jQpf0hKTU2OOqstn3BbcxsWZiDp40nq73kLShoqWL6cmER
         +oOynfwfRlGBHXD902cHrJRdUwOxTyBkYvTt7+cvjGPaNMc3sRuOozstkDItCgp3+lWU
         /MC9SsEr78WJCDjE+BlV0H8dKxPnj5olNy7F4xeNZ2Kyup5Zf5qMToufqkEBqkgzScGq
         UVxxQf2FRfChOuCdOkMQ0tU1PELl9rWc3yLXzDgkOP1Ua4Mf5FdWwxB7p1k5akG/vZ1v
         UlKwbeWpC/u5b+vFJxHYi4kmQhWpCmJ9wE57flJeNPuJ8VfsUpvv/h10gLg/3HcrLv0j
         bLXw==
X-Forwarded-Encrypted: i=1; AFNElJ/zC3ed5d6Ws4ecX4JyX5tcuPpMAIhnrg2E2CXAsg2ZdDKWPXWHG7dlz+bH18gQeffqE3UONg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxfWRZcPjtHL7/SWXHgd+3TxZmyvYn1elanGqLA3lk7iH7582w/
	8eJF83b9Lz3XavW6NEcNrENxNQiJl2tlHGHu2Mg9ysKu3Yq6SJyydGPdOks5z7Ei16fGSCUibgk
	lVhUqcYfGW9vIAyFMeYwIyMEiPl7Y6gmJ9urHu0Xk9AzddE6AaurL/IinZA==
X-Gm-Gg: Acq92OF/n7+oAITh1Ryqio7amAqiFEllpUoRYQ232tPA3chuLt50Y/guJxA29/sFc2M
	soS+S54kv2rcrx0fEP+C1BeZftW10cQD3TgMIFhIpFRtzyfFKXbZtR7hD3xHh2riGqcR3m7gQrH
	+P7aCaCxv1e4dhj+7dAk+mw6dnQmxo0m8exLzZbIknC1k/7IUj92Kc0pEjaIldx2Zy+1ud8VZcd
	yX8rZCOYR6Q6lyvQ4Oz8lfb9R5A1IJwU8yqto3ZuIoiQggdTQvfGi8P1FiPeszwXvXiNeL3SF5t
	cSYEFFKJ4RxhTOMsjsXsOd4/M3rgxWAx4Xi6HiXmV0rhHSerR82nFzwS9xF1tyLCJ5GNKdQ1hXZ
	H2QfAtsmqYSJsuxJ99w+R5q+VtTPpvdOQId9h3cQWL09jW1bynEDCkRGDs3UXC2nxVvnEWrVxAT
	nCmeU=
X-Received: by 2002:a05:6102:2255:b0:632:509b:e399 with SMTP id ada2fe7eead31-6377454e62emr1205252137.3.1778762608390;
        Thu, 14 May 2026 05:43:28 -0700 (PDT)
X-Received: by 2002:a05:6102:2255:b0:632:509b:e399 with SMTP id ada2fe7eead31-6377454e62emr1205248137.3.1778762607958;
        Thu, 14 May 2026 05:43:27 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4de6f1dsm86629066b.31.2026.05.14.05.43.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 05:43:26 -0700 (PDT)
Message-ID: <14a2fbfd-97c1-4ba7-aa51-a07134102d3b@oss.qualcomm.com>
Date: Thu, 14 May 2026 14:43:24 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] arm64: dts: qcom: Add GPU support for Kaanapali
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
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
Cc: Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260512-kaana-gpu-dt-v1-0-13e1c07c2050@oss.qualcomm.com>
 <20260512-kaana-gpu-dt-v1-5-13e1c07c2050@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260512-kaana-gpu-dt-v1-5-13e1c07c2050@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: bBRzPTculM3mqRT87pc0RkNA13Gg-auk
X-Proofpoint-ORIG-GUID: bBRzPTculM3mqRT87pc0RkNA13Gg-auk
X-Authority-Analysis: v=2.4 cv=DewnbPtW c=1 sm=1 tr=0 ts=6a05c370 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=pN7wo_Rnn8_v9tKSZuAA:9 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDEyNyBTYWx0ZWRfXyZToOUolaXt/
 ni5cfjDMiPfPGMSK0DgGkcSQ54Ii4VF20xQuv7N0ZkEaYncqOE4cm07cXHEwwDYl34cVLIi3Jyg
 9UeVnh3BpVRYv8qx8HvXwGqY+5W+e7tOfsw4PAVJ71FBjf7ypwI0ZDH0FbPkNDwi1AHcX7okIQc
 /tYla390pzmvCPbPHKHaKtq0EmW7PfREYET+ZrsHO3DGovGo7YwhJ7NF8nN6t1AcOPFZkr/EJ5t
 z3wHajXHMApK5n0ibLwPopo3+Iqe+jQ3wldjgIL071Ds9lUIqMBpeTQ/Ltoqzt+MCGQRiU8VJ6A
 ookYEEPzQvHJAgIzYKKwHoIKcruJLOMn2h+t3x/fUE3PaCz6fnLwl4M8+vOWBIS4M0Ps40xTwpF
 bSXS7Fi1QZHi4/gqZVGLCct58e7Sqbp1PHuf3ycsY2/DwmUU+ObF/7Xd47cUf2/f68I1fFvf/yi
 bGWNm0BtmrF5d5gxzQw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 phishscore=0 spamscore=0 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605140127

On 5/12/26 12:23 AM, Akhil P Oommen wrote:
> Adreno 840 present in Kaanapali SoC is the second generation GPU in
> A8x family. It is based on the new slice architecture with 3 slices,
> higher GMEM/caches etc.
> 
> There is some re-arrangement in the reglist to properly cover maximum
> register region. Other than this, the DT description is mostly similar
> to the existing chipsets except the OPP tables.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

[...]

> +			gpu_opp_table: opp-table {
> +				compatible = "operating-points-v2-adreno",
> +					     "operating-points-v2";
> +
> +				opp-222000000 {
> +					opp-hz = /bits/ 64 <222000000>;
> +					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D2>;
> +					opp-peak-kBps = <2136718>;
> +					opp-supported-hw = <0x0f>;
> +					/* ACD is disabled */
> +				};

The clock plan also has a 160 MHz OPP @ LOWSVS_D3 and there's a couple of
interim OPPs that you have that aren't part of it (but maybe you have
better docs)

Otherwise lgtm but the size of the GPU region and the GMU base look
slightly confusing when I'm comparing them against the reg map

Konrad
