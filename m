Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C8E53D0D2
	for <iommu@lists.linux.dev>; Tue, 22 Sep 2026 13:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790082220; cv=none; b=TPoJuZzeCcIk2xyHdIQbFrgimvdHq6HIBlfQcSNUBmcYIxG28xEVVaYQey/t5VFeB390AEldfRGOdjPebs1Qm4TFZEq9nLNczgIBGMkEE/qz0nYxq4y1B/b9PAUDMWZ3RXfsJMRlKYE2tvEa5X+C3k/8vLlV2cjPlTWx2GUDLv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790082220; c=relaxed/simple;
	bh=bxddnFMM40rZJyomJz2B+9UVeiJC1/Kposg8e7UdqeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AXnUrGwZbXrNUWDqV4DSUqFM3Sd0lXtzQ/LUUlz1TSlzPUMakfJ+vtqMKtzDislsM3ZDSEp6wYdGo73QPQZ9oWoZ9vnh+Ui2OACfw+Ltp+THQcDXid6e3NXWzkz+6SGQYnj20klbyfdCdomr04XPhoP8p0FUDN6Ayksx395cnCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ajAwFPjs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EJRvCsXV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ajAwFPjs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EJRvCsXV"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MBPMa0620264
	for <iommu@lists.linux.dev>; Tue, 22 Sep 2026 13:03:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=8/QTObLMZagqKCMz1L71lAYH
	9ufZSbJaeEUf+dsnNk0=; b=ajAwFPjsQRe4rAVQcqrY6nP4OItBpLYKICHCIbfm
	QLhshKjxnxKRRnuJgjQZEEEbYZ97koOLodlsL1Iiz8wXbdY7xwfuR+w8xmedu+qZ
	h2vINZK7Jed0op0dBHIvDEoCmNw6Rbjd/WE53WkzPqNbHc2Bq3fIV3/eHTkFUGBt
	LKMYbZQ61hzxibu494ftwJCE3hxMFFcprdHwM1X18LXfPDxN1+WD6NuscQdjLzSV
	IpYUc17QjgIVy3IClqhlNC48+jHHzLvPbIIn0Zj4DDSZW9YOCTJhIsrYg5LdWSD7
	eQYtvCeO6JXyQI4eHmCKp81yiiDUD+Z80/o1aKdVCuTVhg==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4guha5temn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 22 Sep 2026 13:03:35 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5c83124d530so5335008e0c.2
        for <iommu@lists.linux.dev>; Tue, 22 Sep 2026 06:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790082215; x=1790687015; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8/QTObLMZagqKCMz1L71lAYH9ufZSbJaeEUf+dsnNk0=;
        b=EJRvCsXVVLl2DR9QNR0br02KA+s8MTqR1AXst2ZiFweIPWUoqdsexFxyKr0Cs8Z94J
         iZgFEnwQEXuPUDNsyYgc2h1QkrGxgYe57kucOl9CoMGxvAn4tB6/LOD+LZkXWKkrGDNb
         S99vBI6QiHAjAC6/hA0Rf4mitBhzWk9Jk9Vqlvo02ni84JS3/1My3vHG7+R92AP8dvas
         mVB3eQ80F1MGB5rK5DH0LoCRbN7AUJf/puhRAwi60HVkcYECHi89LTABMzvuIcMuxb36
         /WzJ5ru/iaWWcOQm7qmAsxfEGsw2okxhDHIbd+RcLAUbySL6wUl5UT1gIDuiNYGwCr7Y
         zxtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790082215; x=1790687015;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8/QTObLMZagqKCMz1L71lAYH9ufZSbJaeEUf+dsnNk0=;
        b=KqO54aJgoBdhFW4ZGEgqt7r1ZHfM7NWysQuI2mKptp5iw1nZy63pZpTy9rZcN2HyH1
         8SMdxXtA08/1oeKvnZmMFYGIq8IfKNFERe8p4OibQHOSNXdzEI3wFUonwlWXTz6xCEB2
         A9AJEmhF/yMSYdV9bFBowq71hUgpkmnq3sE0FBiye/WkW5Pq6Qppsmf9kVUjc3cOTqHl
         jtoNzgE5jBt7dfq1SuWYIFNX4NA8cZIFA85Xr17YT9cEipxM3H82pEIkoy7AFpWlskkY
         +pYZeOVgAv6WeTfp6a2cmIoW02TJFa+uA95mGCkB3FSfnUHiaxQE0V2AA0HYalHDQLV2
         WpPw==
X-Forwarded-Encrypted: i=1; AKwUvBzIAMzKfvWciDnoNfvrky/r6crQW6GJg9BOKCt4CnH0ISQ/RyJG6Lnp6NBgmuulZkGRweX43A==@lists.linux.dev
X-Gm-Message-State: AFuF++ka7P4+7d/2HvyJ0DY0c67tOSkpYukpLfgjsHEjtLl3eqp5nZPR
	HrMDd6Ft0sMtNxAdEeGUvegrRF5wSNCqGxLpLCanmNAfXKPadst9NVMKhrGGLlvTdkvq4a/wKvB
	W8EzxScWB++xuQguqQWNeCGnflbwohZr8ZwS0/SAI3mbCdigbgdosCZNy/g==
X-Gm-Gg: AYBFou3Ws+kTO1NdqAuGWaFqCjDtVBXW73MQKTwj+Be5nCkRnoTqieQSuKPE9Afpl9r
	328HwquAjwQHbgvhtezOaSGc3MyscsvM45K+5GZddSMkCS3XK1DZTr7VU8D03TsaWvz5iHRHyxe
	ePsrRzbyIu/EFHHto3VYKagvLkhKkRQroErXgMXceL2txd7Y+OI27n+TLXYRK005MTfEfd3eblt
	r0fPHKtXbXor/3MdICiGdZmN/dTmcJZzhdNqiH0jWmgaILM+FebVCqQrNpEti9sy30F1PUHYTBI
	Tiy6P9zBTQpsJ2Q9uaB9d4e9dFTx3xI26Aqs2osLEMAFRaF3wO5gmXVHMjQ8pnMqIqds6HxNIhP
	cOUGj6hbyyaSHVDVmy1s0OpjqkrMETEda5VJAlXF6fLtofX+RdY9Xa6UM8vLxJVOoYoJvdu5yo8
	GgqVaaf4mgJbhN
X-Received: by 2002:a05:6122:1b8c:b0:5c9:a60b:e5b8 with SMTP id 71dfb90a1353d-5c9b599c8c3mr8828557e0c.17.1790082215145;
        Tue, 22 Sep 2026 06:03:35 -0700 (PDT)
X-Received: by 2002:a05:6122:1b8c:b0:5c9:a60b:e5b8 with SMTP id 71dfb90a1353d-5c9b599c8c3mr8828507e0c.17.1790082214701;
        Tue, 22 Sep 2026 06:03:34 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8d46dfd50sm470532e87.45.2026.09.22.06.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 06:03:33 -0700 (PDT)
Date: Tue, 22 Sep 2026 16:03:31 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 3/9] media: iris: Replace enum-indexed clock and
 power domain tables with per-block structures
Message-ID: <zwqr6biua7ft6fkcgloqucthevvtp4viupyhrloc35lkqo7azh@4o722xibsjmk>
References: <20260917-glymur-v11-0-e0c8bc914742@oss.qualcomm.com>
 <20260917-glymur-v11-3-e0c8bc914742@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917-glymur-v11-3-e0c8bc914742@oss.qualcomm.com>
X-Proofpoint-GUID: pKo12p_96PP7FClYNpvFbUtZFdDfUW0W
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDE4OSBTYWx0ZWRfX2oAm/byvmpAL
 zuAx60udoWdN5IGrVlyeBLPx2IHFIqgYlp7CWQO1Cb6wmAkoiM0FBAZ7ST91L8rvyfU7vHRPCfw
 AHEqYcb0Rn5GzC2jxtaval9alaevNIc=
X-Authority-Analysis: v=2.4 cv=U+4Hnuru c=1 sm=1 tr=0 ts=6ab27ca7 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=cQsnMm6kD37X6GfbhGIA:9 a=CjuIK1q_8ugA:10 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-ORIG-GUID: pKo12p_96PP7FClYNpvFbUtZFdDfUW0W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDE4OSBTYWx0ZWRfX2vxFQfMjAYKK
 swYCRnhW4WBuM/oaf6FQ+L0B5fQ8STAb71vBpHxqUbgT1cPzZwtqrVikk9N2fs7qUoP+iHvIohE
 /5okF4YXkBGE/Ys9zD5+Z3ODYFun0f+1gBRj0hnC2ONgZBmYaUUyOmWRNh3JIZdQAZEYLBaEW5E
 QBUIZ+OR4hQdLqNYLUwyFPKUxm5Q0w65XDwuCLhwYQyvtQdS/Ef6Tj4EO9OSEmSYwK7AOUR0f83
 2Bvno0+JEafSDfg1qvVMmgp7VS7xfnQnUCrdtksfbRYiM4CTuqffNz0KOrF00dnmMVX4HBqZPvJ
 wz5KmE/bnm0bv6alDs5Ny8ruRR14q0NvaYcyHPvy8cXfnxjds9Yh3aDqP4tPQPvulOqeO5KPrJE
 gRLAgKq9G3YW2uXkXOGuZTYQfnGcbjSRnFV+FHUDJ0BGTnYzUWYiyBixboPO8hCkGO+JadYhepW
 DpRf/D5mOofFGNz87Sw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220189

On Thu, Sep 17, 2026 at 10:30:22AM +0530, Vishnu Reddy wrote:
> As new platforms are added, the platform_clk_type and
> platform_pm_domain_type enums keep growing. Every new clock or
> power domain requires a new enum entry, and every enable/disable
> path has to loop through the clock table to find the right clock
> by enum value, adding overhead and boilerplate on each path.
> The enum index space is also shared across all hardware blocks.
> On the Glymur platform, the VPP0 index for VPU4x and the VCODEC1
> index clash, making it error-prone to extend support without
> breaking existing platforms.
> Replace the flat tables and enum-based lookups with
> iris_power_domain, which bundles a power domain device and its
> associated clocks together per hardware block. Platform data
> describes each block via iris_power_domain_data, and the enable
> and disable helpers operate directly on an iris_power_domain
> instance, removing the need for any index lookup at runtime.
> 
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> ---
>  drivers/media/platform/qcom/iris/iris_core.h       |  23 +++-
>  .../platform/qcom/iris/iris_platform_common.h      |  41 ++----
>  .../platform/qcom/iris/iris_platform_sc7280.h      |  28 ++++-
>  .../platform/qcom/iris/iris_platform_sm8250.h      |  26 +++-
>  .../platform/qcom/iris/iris_platform_sm8550.h      |  26 +++-
>  .../platform/qcom/iris/iris_platform_sm8750.h      |  29 +++--
>  .../media/platform/qcom/iris/iris_platform_vpu2.c  |  20 +--
>  .../media/platform/qcom/iris/iris_platform_vpu3x.c |  32 ++---
>  .../platform/qcom/iris/iris_platform_x1p42100.h    |  27 +++-
>  drivers/media/platform/qcom/iris/iris_probe.c      | 137 +++++++++++++++++++--
>  drivers/media/platform/qcom/iris/iris_resources.c  |  81 ++++++------
>  drivers/media/platform/qcom/iris/iris_resources.h  |   8 +-
>  drivers/media/platform/qcom/iris/iris_vpu3x.c      |  37 +-----
>  drivers/media/platform/qcom/iris/iris_vpu4x.c      | 137 +++------------------
>  drivers/media/platform/qcom/iris/iris_vpu_common.c |  98 ++-------------
>  15 files changed, 347 insertions(+), 403 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
