Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC3F3A1E67
	for <iommu@lists.linux.dev>; Tue, 13 Oct 2026 08:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791881679; cv=none; b=W4YwNb7bvP4p42pC3rEWmwwtk68XOnfZRDC5GF8O9+Pe6HV81oXceOUIwBE1swUaeuSaE8MnZAvRVcXXwi2PzCCLCsyJBqcTlJYQk5MTQErmHInHc2ED8w+Tu2ZtC0V9QTVgWIRG9BSxrlazJ9S2X4ktIDrpV143XxDDyjaFZ+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791881679; c=relaxed/simple;
	bh=RRf0QNgtNhxs+QIpsqcDuxMucwHO76f+rh6FFGEKfZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SgZhggPg5QVSyglzh5xo6Vs355x5HumeZxlIwhaoQzLRRaQ/OdQeIrK+XlV3yb3Kq7CqO/14K+izkPko5OWdwppsNoEt1bt+pSBE/pS64eElBgDvusOQdxqG9yVD2rYZuZa/QVFaqOfYpmefrFC7Yxz6zmiN4GCDVA1cVcNpVZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jQFw8Fw7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=elBOZWtW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jQFw8Fw7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="elBOZWtW"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D3xCuD3475956
	for <iommu@lists.linux.dev>; Tue, 13 Oct 2026 08:54:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7f2hNXCavRHTd0MsRhfBFPNTvN4Mh7PPmelvArEONJ8=; b=jQFw8Fw7Ma/RCxZc
	9cASf6SF6yXQruiLVtJvjcjJourUetkScclTHVlo51gLdP3t0tpW96OnM2du2pwJ
	xJez3lWwdoG2vJUdVx+sO1xBzDiAZPF4eUaVe865752JzJ5owkL7iBRTih3Y6lry
	R/Mg2ru2c2GoqL0IQbIQsQ87zKLfEkGWR9Y8RZJPtKgTnvE+Ch9NgB5Lry59xw8d
	okwPYTS2BsGbFWYbbJqE9zyB/c+xnk4jIxofjA4d6oIolTx2dG9nkSZCEi4ZJ674
	klrPchZ315kCsAz3lOdAHdDomuKPfwLchCkpMuPlfZBHh0ayPR8PhJT+veY8xmv9
	XaFzTA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9d7j9416-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 13 Oct 2026 08:54:37 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93cc40759b2so612621585a.1
        for <iommu@lists.linux.dev>; Tue, 13 Oct 2026 01:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791881676; x=1792486476; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7f2hNXCavRHTd0MsRhfBFPNTvN4Mh7PPmelvArEONJ8=;
        b=elBOZWtWPUUGJxHn/Yen7HqsC0cUhAl9YWW/rCwbzzXV5su846tPZQ5rRjWJ3Tz7dc
         KPRdXhWlQWefyEmJt66MzrCaiubGsmhX8FWnJ83NBSXdl7PVeLf1IHPOQEjXwJR5den9
         xPQ54Cfeyu5XiE0D1+4SI+WfQOMX39NTqOp85MO9/XrPwaJem+Sx/sJrd7Ux9j7fmnjb
         J9H/x3C9GNX8ZXh8gc2VvUUacfSSsQxSGEnpDK8NLXUvBun9dRe197M3LK8NFR8jFNxl
         KHi/gsqUmWb3OMEfpHMS2tGvgrCdWanCWCEy32GmYUjeQPOwC/2v/HrWryQNQzfgQIcg
         Qz/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791881676; x=1792486476;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7f2hNXCavRHTd0MsRhfBFPNTvN4Mh7PPmelvArEONJ8=;
        b=nqeN7hs5X9e20Lkcdk5nhpPp5R/egsoSxvgPgEazegQkUIA2LMVIj2QZNHFDMnGseT
         gDmk4omAiCxMdHEbIs/dnW8670Hi8eNRrGpg/VHkWW+oC7ZcwpXMI1APRP+FIfQlaEdl
         IUqFO7kOTf//OP06t7HDiaTJfZeScyXDIgIwXkej3wfcGEnpxL3tqMTEyVSKAD2XGL73
         rere5qAFiBPmexBBDwaPWmvxehvG3NqAa6Hiu3m1x8CJIMPP4LKB9ZFtiRy1dnZn3slQ
         dyP6LDhyxT8aYP+JwIPnLbgTpBUHmlZidN5p737I60VnMlOE0gZZtPm0hInYXTZ1mfQB
         i1Dw==
X-Forwarded-Encrypted: i=1; AKwUvBw4u03gNzy/nU5ydC67J0WdV0iOpDF7jGsclhjij18MUVa6saVlKk0UgPbVLjZkebKz2W0Peg==@lists.linux.dev
X-Gm-Message-State: AFq9FYKa0gWOezTb9YKoUGMkYBsMkzEfit120wKjFGaJWCJQy9TBAPO0
	YwrXgm9lRnISC3UzFTsl6dz0uSQGuJDICypgdUB0ZKxP4MPND7x7U7k58n/w0FDrNYmfknME3PA
	SZNQXcETFg9+1DkSKbvN1nct3XubX9xQxc7XX4vhrwOmwubOuVnjycP5JIQ==
X-Gm-Gg: AYBFou2KH3GCZJoej4GMjL9KhLsJOJDacOGHrnibcHg40eN0ZPCw7Wji80yzA0d7x3q
	PLP34uVcOUrfv/iGmg88GsAUVlUblXRT6+a/7V/9mkNaa+AuDwATpqzrxzz/ZEMwBd8P3FptaQj
	tUQdEx6ZWTe2om7qz+NdGrH0sAbydJ/MwliioNob//aXJbSpPMAKhjl55YHCh/gLVi44VvebdaY
	Lfv2DXvQR3NKdC4ZWrFGVN/hgIuCQK+7P3hoiYQhvhu5dJPSxYk3VbMftcQUTuYnPnBm9Bi8Sd9
	xW7Am2MFXM8kFQYv/HqLIZ3J4VNKTWkCLe53n3Q3fhA5mSkm3nccSreR39nBQwce0xM/V50Vrah
	FISdGZ7xvjDLYe9/V6zxp07t1RvGvk1NCmDiT/yvsyzznzgUQ7dP/nKJf3If1HA==
X-Received: by 2002:a05:620a:19a2:b0:934:ab73:ac53 with SMTP id af79cd13be357-93ebcc1186emr1872340185a.0.1791881675678;
        Tue, 13 Oct 2026 01:54:35 -0700 (PDT)
X-Received: by 2002:a05:620a:19a2:b0:934:ab73:ac53 with SMTP id af79cd13be357-93ebcc1186emr1872336085a.0.1791881675017;
        Tue, 13 Oct 2026 01:54:35 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7? ([2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18be97d1esm554068365e9.8.2026.10.13.01.54.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 01:54:34 -0700 (PDT)
Message-ID: <46521411-fd68-4ead-a487-f2277a1d1d8c@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 10:54:31 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/7] Add Initial Support For MSM8952, Add General
 Mobile Shamrock
To: muzafferkadir@mainlining.org, Srinivas Kandagatla <srini@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Kees Cook <kees@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli"
 <gpiccoli@igalia.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Heidelberg <david@ixit.cz>, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-pm@vger.kernel.org, linux-input@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20261011-msm8952-initial-support-v5-0-1857074992ec@mainlining.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20261011-msm8952-initial-support-v5-0-1857074992ec@mainlining.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: K-y0zRz-eYGop1C7D1ws3V6AqwKo3Z1I
X-Proofpoint-ORIG-GUID: K-y0zRz-eYGop1C7D1ws3V6AqwKo3Z1I
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAzNSBTYWx0ZWRfX7C6I3GxR154c
 cGW+p8NyeV9GFmp4fd76w4bZccN3BbdqO7LJdmLNMK++Jq90u40XOJWbL3EAEXVN4J8vP4EEYw2
 YdC3ILfWyjDiuwPdbepM8OM/CKgRnsM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAzNSBTYWx0ZWRfX5J+7EvD38qFz
 dAGrLUcPZTV2X7rLcig9WuCUbWttTjdinICQsKUM5ZW4cuSDJSHvwFiV9s/NlcytD3dXeSzp2wj
 tOHahx3G9McihGPeVnEl1xtNr5yqNwHtdvvBgmo2a5eC+fuX5v4oAXXbCf2dNclcaBwu02bYCKg
 UxItaLxCxjTpvem8p/nKxrikSC2tZLe/8gfZAlizzZGUhSCzJPEJdApLZnW0ciGUix+BbJrTV3j
 oZM6/bDvgwe7kAWEVJ4+ILZEr7FAWh/eY1OiI41vKVc+7ymo+SYlJY0+RhamynZiuLfQwi+mmQe
 YKx4uNWvBdgZoTccISpOcMZqA0eUiQ+9XLYex6MLcKfTC8QKn4WkdoZeQA3Ckwc14rGVHfqM1Y9
 a5wZcht0ENgMHtoadDumNBdM19YLqJ9SplRh16tnq3BNi3Lce4d6e8sAU36t7y373ZJZ6AgpAcM
 gH4AyofFexCeSbV2x3Q==
X-Authority-Analysis: v=2.4 cv=PMGaavqC c=1 sm=1 tr=0 ts=6acdf1cd cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=OuZLqq7tAAAA:8 a=H-LwI_JyRwchcv6U7CIA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130035

On 10/11/26 18:51, Muzaffer Kadir via B4 Relay wrote:
> MSM8952 is a SoC with 8 core cpu and Adreno 405 gpu.
> 
> Ported without uart connection. ramoops and usb
> mainly used to debug.
> USB is not enabled in this series because it
> depends on the not yet upstreamed (and not developed by me)
> pmi8950_smbcharger.
> 
> General Mobile shamrock display panel driver
> is generated using MSM8916's mdss dsi panel
> driver generator and tested with it. I didn't
> include it.
> 
> Pinctrl driver was submitted and merged here:
> https://lore.kernel.org/all/20260907-msm8952-pinctrl-v5-0-9a2d8d72ffdb@mainlining.org/
> 
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
> ---

Applied, patch 3 & 4

Thanks

