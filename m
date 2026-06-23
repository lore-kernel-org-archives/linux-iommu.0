Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1B93624C8
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 11:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782212573; cv=none; b=AAO5nFYtIHiRwmv5DORuSj+9N/M1HUYYHWmpE2Zv4C3Xm2HeAhU1SH9tR0F5NzdwUj+bwOVOprPCMYyUYOnHcfz46tuFpN2FmksdvoylcTCoDnsFR9yb7cypeEdheKoEQ5taM9v1eSNwbg+x6hkqv9o4VYw1q3gco8SFomIhXso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782212573; c=relaxed/simple;
	bh=ZoZVHIcb20ztaVZGDCK46IymHjRjY+Yi4pkPjRPyYng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZLnxMZS0oJDewUNkuQIL2uBCwW0B35z7ARireJJiKqOrKz2YWrtzdusMK9Naxng/ska8xMf4k+KI+NtxEer9yEcxz//bQCWMYpyFIKODk+REOykL2aQPFPCrKfGRVw+qHM08jF6ExLiLbbeFnABOspn9fdh06a5N5P7Jr2503Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iZvUU46G; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NrMcSaQy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iZvUU46G";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NrMcSaQy"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NAsBCY3578585
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 11:02:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/3Bur5W8WIf69VnzHiI+arDhtZRA4HK1lbpmUhai2O4=; b=iZvUU46GibMAwNkz
	AoK7VQzXe+5QNe2NDKKB/mgDiLZOo5GlZXwA/ce67JAiyVLIDN4WwaqOHLLQYnab
	vBvCZ3Q57JQwnF3JshLMTYyR5HF5NGIzzMJR8TWC0N3NYhPMFUx2EqA7l1FU9dU/
	pE/LJoxOVj7x+BnGbz8TfH44/R/DMg7zLiyMOoQRA32bUDzWZk5OtUyWaNw3eKYU
	NgJRdeZH158uWFnqlLx8WmF415Gz2na1sFuj6vDNC8UOplKUTMJStLdbfZlvJDV/
	I5V3KoTsvE4S1ZFmAaijS5B02SRmfvlhsOw6zr0k2+KJfCEwCdUBW0vIlHeZVjAe
	fnjmFA==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eyppygn6k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 11:02:51 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-7297b2a8689so346326137.2
        for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 04:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782212570; x=1782817370; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/3Bur5W8WIf69VnzHiI+arDhtZRA4HK1lbpmUhai2O4=;
        b=NrMcSaQySxHESnmTQpQeerWHqdkkY/zB8K3o2oJlIc2txWpSzLIQ/irBztbVd18hw1
         5yzPK7UMyCdlCbuepyAdY3dl82psC/U6ljzyL6TwdpH7y45MmMzIA1z4L2QReq1MZeig
         Uoeqv0ZewlJnsOJf3Is2lnvC9ECO8hfUmvMsKOnP9ySglh5sy4sXHG9p+VZe9seIAkoT
         cx146gqOYdxT53eGl2fBTBjV9pGeAdTZzugSLsz8MQSs2j0QR0OO0x5Zbafagy2MzxN0
         JK92psXKltAZcK1vLNMHl8yrPSkqM7mPASGsBvMvXYgoOKJvfR0P9x/YpL1D5qawwy4k
         xTUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782212570; x=1782817370;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/3Bur5W8WIf69VnzHiI+arDhtZRA4HK1lbpmUhai2O4=;
        b=Fm4FGv3SdUjH8MohSd1HxcAAwEobBmbCV8SmbF75FeAiGkMfEuHUSiHFD2VIInwlgK
         lMyynxQW9NabWPkecuw8NCUz1tZujIyiT+4xniasUIpE5hdjLYoR0LyOgwIa2oQz+tDP
         v9EylW8VVCfRm8uB57nnYXXkk8OmN43WDCnNWDdOz4e5Y//Pq5tNQCpJKuawRV24xqbA
         /dOvF5bxjhcJ7Bp809Gi2UBLaCg66bMdHGwbqoKp6HE0JnVNaZem+RxFM98er8zbX9tg
         NLMR6lVt09H5Qkrkoiu5NUPnom3AJJEb9sfubCv//F+TjqoWrt4QDBoHqVe3pwMZc5dB
         hBxA==
X-Forwarded-Encrypted: i=1; AFNElJ82VXrrfpo512Pvc98umJRoluzU/jyno2QIXCEapGn7DFYHv8z/IBcIAyNg408G8akZ9Fk1RA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzz6h7xbPdXAHDXfL6Hh4BwwiIQnbour9TvYD/iQui7U7XFaKk5
	6DWEz1y31hbuzMY2z1VzWaWWuYuYRDiC6TsI1//3Dgwn8IVZxKTiQupS815jPOqIvcInlhhe+DO
	6cgMnS0VWDMu/UbxTpED4ExRupfD6zQyM3CIpUngAfWlD29C039ZcRTH1KA==
X-Gm-Gg: AfdE7cnD0IxW6ID/VbCH+Ldj8OkigmoJDOPa0Lj0zBAwKofgpMdvYhtINI2moMLIR3q
	vfrPl1i/mBFgHXcE0xY7SHdVchAYGFCgLlus1/mdCbclpBWErceq4AxQepZ74Pc+m1A2Q1HAAXz
	wxQtfh36rnZH9HFS+t0Ag3IEXNaALwd1v2pFEgoEuf1RI/JrnEMrhhBO49mSiDB8hOb4TkUaUQG
	L2Xw6pPhfnFLGrKNXG5vo95RD6qMqPFhiUPktZtR9qAzTgQJOGDxaRxFhQGTsy26PgxoS2jF+uK
	wz5B4Ksif+Gn4eElKef2JFRpPmvl6U0mxeOVRzDxQmwd8fOOQiSKzYCtqcz5b0gPcFzZxwnvxLI
	4dj5kNJOOR/W4aSkehTnBYsrlQEFT7Nzz1x8=
X-Received: by 2002:a05:6102:3f14:b0:720:2ba:5299 with SMTP id ada2fe7eead31-72f3ac9650cmr1080744137.6.1782212570270;
        Tue, 23 Jun 2026 04:02:50 -0700 (PDT)
X-Received: by 2002:a05:6102:3f14:b0:720:2ba:5299 with SMTP id ada2fe7eead31-72f3ac9650cmr1080720137.6.1782212569762;
        Tue, 23 Jun 2026 04:02:49 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c5e498cedsm491816166b.4.2026.06.23.04.02.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 04:02:48 -0700 (PDT)
Message-ID: <e1e492ab-884e-442b-8410-cc100c54fd5f@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 13:02:41 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] arm64: dts: qcom: sm8450: Remove unneeded reserved
 memory nodes
To: esteuwu@proton.me, Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org
References: <20260622-sm8450-qol-v1-0-37e2ee8df9da@proton.me>
 <20260622-sm8450-qol-v1-2-37e2ee8df9da@proton.me>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260622-sm8450-qol-v1-2-37e2ee8df9da@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA4OSBTYWx0ZWRfXzUDtEKH/FeVa
 WEjpfA2Gs5BiRTdcFsedrGE8Ju4LzSM4xX5ngw5IpeTTCWLUb04VllYk/Nlj3GWpS9gn8AFN5XF
 4r2bd4f/7geUMQwIN97J1C7wXctSBtnTwl74bd5knEeAns6N+zbor1iarOPkf2jXra+H02IUVGR
 CNvQ/x1RDNlS+6EeRU61FI55j6qJHA3ylZPut6OkzVu92ZNkpFXnYgHiGFtMhfo26fmp2jzuxqr
 yzu84V27eNKPVYxZI3Qmfp5rlKfs4py9KGCMzQKMqIE3GFPj11LDDaR8VffChvy1djuKf5km9uM
 7IZZ5JAQDVWM2kvZJCY63mZq6ufgOET8dm11zXXtJhx9lFZR9rPntyTBOvEhDlJ4OYm4yO8BliP
 CIT4+tEGsqF46hnwfANRrRjHIyWWkQ1z/pVDBwqEjlT9kmKc4jVwS3oRqPz11e4eRzJxWR7W7tg
 MXnC0/lAkmQNA9pG9vg==
X-Proofpoint-GUID: fdBo0RunAoGO5tHzsCRDlRlhvzqFciu7
X-Authority-Analysis: v=2.4 cv=dvfrzVg4 c=1 sm=1 tr=0 ts=6a3a67db cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=dk325V_gTbMn8ZHce38A:9 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA4OSBTYWx0ZWRfXx9/t7+G4ZGBQ
 50npyxrIgz802Fc69c9oeCoQUccyZ1kHR6GEzPmp6AoCcS64yaG8V97cpwnCAHE0BujhGiZuzC9
 H4iILP1UjD8aw+cDUmvrOP2L5YJzFzk=
X-Proofpoint-ORIG-GUID: fdBo0RunAoGO5tHzsCRDlRlhvzqFciu7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230089

On 6/23/26 2:54 AM, Esteban Urrutia via B4 Relay wrote:
> From: Esteban Urrutia <esteuwu@proton.me>
> 
> These nodes are not present on downstream device trees and only take
> memory away from the AP.
> No crashes occur without these nodes, so remove them.
> 
> Signed-off-by: Esteban Urrutia <esteuwu@proton.me>
> ---
>  arch/arm64/boot/dts/qcom/sm8450.dtsi | 15 ---------------
>  1 file changed, 15 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index 56cb6e959e4e..e34e3c05bf74 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -752,11 +752,6 @@ oem_vm_mem: memory@bb000000 {
>  			no-map;
>  		};
>  
> -		mte_mem: memory@c0000000 {
> -			reg = <0x0 0xc0000000 0x0 0x20000000>;
> -			no-map;
> -		};

This is mentioned in the memory map description, but is not part
of it.

I booted up a 8450 HDK and it doesn't even have MTE, so it's
probably valid

> -
>  		qheebsp_reserved_mem: memory@e0000000 {
>  			reg = <0x0 0xe0000000 0x0 0x600000>;
>  			no-map;
> @@ -806,16 +801,6 @@ qtee_mem: memory@e9b00000 {
>  			reg = <0x0 0xe9b00000 0x0 0x500000>;
>  			no-map;
>  		};
> -
> -		trusted_apps_mem: memory@ea000000 {
> -			reg = <0x0 0xea000000 0x0 0x3900000>;
> -			no-map;
> -		};
> -
> -		trusted_apps_ext_mem: memory@ed900000 {
> -			reg = <0x0 0xed900000 0x0 0x3b00000>;
> -			no-map;
> -		};

These exist in the memory map, but I'd guess they may be unused if
you don't load any trusted apps

Konrad
