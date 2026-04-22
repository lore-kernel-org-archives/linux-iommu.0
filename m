Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4C5347C6
	for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 00:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776819499; cv=none; b=XmXIYd3u8CTIx2Jhl2FYWu/4HMFBXAIUhZUGd1LhcCBi/faMY6akjj4Oz2VBUC+bwT4RX4cuvE+3KU1fHsZXZZ7ghmxh2IW1x87F25CfEHUW1UQOubBKYKNRxoQUaedCSeO6lPfVepm8mRXGFQSC/tykRq0SPaqAbVcaWQgw7Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776819499; c=relaxed/simple;
	bh=0v/cGg5pUVmJiWfDkY0F4IX9flkWG6/oaecceDVh1Po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MkqEQl3GRQkGnaE9fIlYH/4Q76EezQcVS67vIoiIuuceRk5bs+YPq7o2HKPEo4z+aBAUt+IC5vkZSCGUSnuA4S46DsfLwIuvXC50Impe+8AofRZ5kn9gcBClNW5FgSfshVq6dV1lO2T1dsJAzcQQDYc8I0HlrXTsHQ98OLAcuz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fwhw3Alh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VcROfTkt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fwhw3Alh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VcROfTkt"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63LIZuF4727986
	for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 00:58:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=os7fT3QKhH/Yv1x8DZHj8ydW
	g5CSTjDgo9cQ8O6Q6Ng=; b=fwhw3AlhbUcdovjSX4nEG+a2lO5+IMs6e5hlV8Cj
	1lz/O4wOUJh8UrX8cEVcBJVTHmSW4EPXvCIxoPAfjgDRltKl5D7A7k9FtvyvpJuk
	EECUggnXwJ0lVGFSLx4p+z4NISy8CDD7RMk5sHxyfWAsgC1ATraRfd6nfym1N98c
	PRFVfZDvaTIOIlc5Y2YQVSVQOgjNxAeM8nr2Uuwzi9V3Oqk4OjnjM5Xf4KCTSMBr
	thNlKkzGHcvo6y0vzg4YI9za+V/CF46S07WRBtVGvH7Q5Egq0zppe4zcXJjmOMpo
	nKWwfU89bvaqhE0K0yGC02RvMVmPqECi5fWhu3j7+oHpQw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpenh8yy8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 00:58:15 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50d826ed6f9so25363871cf.1
        for <iommu@lists.linux.dev>; Tue, 21 Apr 2026 17:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776819495; x=1777424295; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=os7fT3QKhH/Yv1x8DZHj8ydWg5CSTjDgo9cQ8O6Q6Ng=;
        b=VcROfTktqkbKrTID6fVRCuGvdXGMLQZVW3iXluIlw4fY57HCIlLRg8YT8itzN7+3fx
         9dxP3RnWPDWynhqhhEmmrKnQpZSo2sp4i8C6ByQYQIVIlJcMPe2+awEQoStzvoyPauG/
         4kzQVbKRuI2rLpn6hhKAgyK9xWNIMi4agmaPxhcweIqFYnYX5dtCD9KNCWYPQLN03PAe
         bUf4810sKf84iuOSeLYJ8ClroLOTlb1wlqu+XtN48jg3A+ZuZPXBClss5enAB5zMbenQ
         TBWBoDqdWMKJrdzHUYCMuc+lYqhlbpXC+GUbEfUrs8S/JKIaQXpDvEBikw6FhVP3xB0h
         ZOxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776819495; x=1777424295;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=os7fT3QKhH/Yv1x8DZHj8ydWg5CSTjDgo9cQ8O6Q6Ng=;
        b=sBRN3WHBnFqdjltETU2nLkMvRuu8EfQvGILdilrsCowwHPQg9p7nYTFWKAKdIOwAsK
         R8FhQQu8O6lWuKeunTh49k0erTcspV+qgYrUMhd4sGKNcFfK8fhDydf23BKEP1+aGRHw
         962b9QDeNCvaVnESsln3asm+OIKzlMPBxdgLEG8tXqIjJrSK1/p+hti/8/iAH93i+pTQ
         KAdzHXn4vbyebngZ7TYlR3mZ5MMUxQv9nTsVqs18jFHxcwEcQ5hJgdQmgbk9A0kefI6n
         3q5ocaROW1pEjsdZSJKGb0GibyrydKx0TSMfdQP+OBDjUX4X6gJIxMfxGbtdtWLUqk2Z
         ENww==
X-Forwarded-Encrypted: i=1; AFNElJ+O6vByo4bW5zGHGVRfHZlYR2pw1FSXxviCgbUXk1Ml8Ia5bF2l10fbnFjsn6liX65Zntalmg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzMhZvM2d7oMKPENJ37zCtP97NB1dNacsBpVhMxmoLcWl4Uq+4S
	Zl0rrWNmNonDy7I95c23+eK2X23loUK5lghvOc3AIvW2jyZmdE131/cLs4Fbjt8HNj9WHei9tyd
	E5bDZYNS/iYRwobILZbjf3Q66sN1cK0v9zuNe9BgASZXx4PiaiOIfE0zP+g==
X-Gm-Gg: AeBDietxJKryN4NaJnztX6oisIF4bq3bvb1iideTN0kVEoPwfHjGii1DGOEpjso2ebO
	ABCxB1Jtl3WHebtK5naXrdyQFGkD3xLOcJVIdte8AWjDkVYn6nIsxXgCixytTEgrTb6CpIaOjyM
	sr+GHMRR3a8tVuNfB6qnwjfrVsSzCEEF5PK9pDPOc2RJ+/qjfGaIF8HpodpHUNK+dUfUTbBRPZU
	H+sR4FVHioA16adkTz0dRLt3VTS/FgF5fHOWEZK6SFgaD0SvjkUU1wc4dxOL0ekHYVQb7obHeF+
	5dkY0EdDsXPGNGwoX5XF8p5vVkljQOQL2Qry7QICZoDBY8dPUCL27t9f+d+67RpWLqn1GGAhiTZ
	qX/huOqgCxiZiC0TrPN7TT83gFiU5cMIk52HvgkPdXBK34jm+HVOjVfEjKkFUDJNA1MeZARaRwb
	yO4L2zd2/vWoLl/z3HolwwlZiZw28ZxGTf0EjFuStqU1OoRw==
X-Received: by 2002:a05:622a:5ce:b0:50d:987c:8174 with SMTP id d75a77b69052e-50e3661c13dmr256709991cf.4.1776819495275;
        Tue, 21 Apr 2026 17:58:15 -0700 (PDT)
X-Received: by 2002:a05:622a:5ce:b0:50d:987c:8174 with SMTP id d75a77b69052e-50e3661c13dmr256709581cf.4.1776819494819;
        Tue, 21 Apr 2026 17:58:14 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a4187e7a3fsm4007411e87.59.2026.04.21.17.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 17:58:13 -0700 (PDT)
Date: Wed, 22 Apr 2026 03:58:12 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: contact@alex-min.fr
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Guru Das Srinagesh <linux@gurudas.dev>,
        Linus Walleij <linusw@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Kees Cook <kees@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        iommu@lists.linux.dev
Subject: Re: [PATCH 6/8] ARM: dts: qcom: apq8064: Fix USB controller clocks
Message-ID: <56tmjiwx3xepxky5nqiwhqvgivgwhnq6bdm5lcvbkydnunrpip@blaaof5fn5s5>
References: <20260421-mainline-send-v1-sending-v1-0-bcb0857724de@alex-min.fr>
 <20260421-mainline-send-v1-sending-v1-6-bcb0857724de@alex-min.fr>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421-mainline-send-v1-sending-v1-6-bcb0857724de@alex-min.fr>
X-Authority-Analysis: v=2.4 cv=HdUkiCE8 c=1 sm=1 tr=0 ts=69e81d27 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=accKExrkbF7l0cSrD3IA:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDAwNyBTYWx0ZWRfX8ZzcppoyKBDO
 ZyP9tuVzRgl1nagl+xzwu1TCClB/90umAu/+nHV4TQH/gwHMgdAXRFe6w1A5FpmM2f95ehW3Uw6
 02uZqiGMuE8ZaK6v7hOFc6FHyCFa9WHJOaWczK/lrv9c8HIY3lhLb+zKbfGPeUHa2W/IsaFLEbz
 7T5cDqCkBGyDIN5dg9fRaEtCjCOKZ/ZPfJ8rmklT9GS+Ms4RUPaI/qQgoIDpzQbUw6zc6xWVToO
 j/ZWdhSeDlrZobWs4C47xNk0bLamNtE5gYZG9hqEN2ukORqNmz8ib9by68VrP6qJmKiqy1XyBcB
 NsVtnSaLq1QY0W5pXJyofGoBBRN4o+svHFPDrxmWXdHrxy9KpTnW/3gaYVMCFWMMnQuoOKOCWIV
 74NgWP+To3zd93ghDuajUFfMSH48wqVCRyW0KJ1+io47Yx0UVj6jeFLXk4jGqEQOnhKGc8sOfXk
 iGKbLCcYP0Fo90PJd+g==
X-Proofpoint-ORIG-GUID: JyjYPuUr94UNJZ2DC7TuxqwCJA0QkHVy
X-Proofpoint-GUID: JyjYPuUr94UNJZ2DC7TuxqwCJA0QkHVy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220007

On Tue, Apr 21, 2026 at 11:45:12AM +0200, Alexandre MINETTE via B4 Relay wrote:
> From: Alexandre MINETTE <contact@alex-min.fr>
> 
> The APQ8064 HS USB controller nodes describe the transceiver clock as
> "core", but the ChipIdea MSM glue expects "core" to be the controller
> fabric clock and "fs" to be the transceiver clock.
> 
> This mismatch can leave the fabric clock disabled while the controller is
> accessed. Some boards may tolerate that if the clock is already enabled
> elsewhere, but it is not a correct description of the hardware.
> 
> Describe the RPM Daytona fabric clock as "core", the AHB clock as
> "iface", and the transceiver clock as "fs" for all APQ8064 HS USB
> controllers. Without this, USB does not probe reliably on Samsung Galaxy
> S4 because the fabric clock remains disabled.
> 
> Signed-off-by: Alexandre MINETTE <contact@alex-min.fr>
> ---
>  arch/arm/boot/dts/qcom/qcom-apq8064.dtsi | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
