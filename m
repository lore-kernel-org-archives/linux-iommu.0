Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD9D34750D
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 15:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776180189; cv=none; b=gdsmNfnq/JfubArS95wAt8astRN7WqHHayz9T4THxThYdxYP1HF12Fmey7cWYW/wXM3dc+OsFcnpsPSTRuLPGOV++DnSyQGd2dTlfM9hZZhFRsOQKLZiHcBqwtszQzFB6t4ZKHl7ph5vYSCyZvuviTPWLHN440azE+8D0XvHrBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776180189; c=relaxed/simple;
	bh=YVhjTvXHuSPVIRlL0H/IfiEgu8exSYm/iuSPi/1/0QQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tu0fJNgyADXIEt+qr1n2I59ZGpTo5UKaxU9LPHpa0ahER79IfP0mE53rTHjbUQGssl4Qz6ImYVv14f9PqOW6pH/QFSjuoP9yL15lJOXTIvOXGcz2fa31v6l7u6KdkJ/DwziqNRKib5gS6ZH/q3ZbuX6T0UaS1CdMXAXvNEKRutQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D4OR15BY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=i6U+4kFi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D4OR15BY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i6U+4kFi"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63EBl8YY3505282
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 15:23:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=y9wbisI+nGNtkqqokTeJEVlq
	dPP903JLL6TnQpDpxaA=; b=D4OR15BYyfbtWujqwtpPY6qqw1bw8wAatyKjfdd3
	NH6J7SKSFmJaaXHrW92xrOzteWeX0ND6ObId5lIllTGHjInFMGJjqKxik/XFB+t8
	ErOwXQw4IAIvVXF4GHHFERWM5moNG7b9Cjn0UWln8LwOwPywqw+Vt+yXYudFnwzR
	GNKYW+TjzWFeuYkpVcB/gnIAPy+IGO7lbVe7v7yw+M5WcjTZqf7PMrNnoh5/sbAK
	uwLwYn0uNIarkPJe2SFFyyq9DBdno+xefFx0mzfK60m4RsFjFTFe5wywfWY68vIL
	QCoyoZhFH0ktKMYFNNvNuxM/UsgRbp+wjYPzjoZjsi2GHw==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh870kbxj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 15:23:07 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-5f58f90f83aso4418862137.0
        for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 08:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776180187; x=1776784987; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y9wbisI+nGNtkqqokTeJEVlqdPP903JLL6TnQpDpxaA=;
        b=i6U+4kFi+htGKB7TM32DAi/cX2bP8nDSExKd7f+Tqvd+gJldRArqf6nbzhDh/kinJq
         uw4Y7z7lR0jqEw2XOXja7ptT8Sue3BjaP317Pk9Y4y3FtNo+V8YovN04jmUreCWrCMcs
         zcdn4H9fUP8xHwLm3EQLmichqnbgF4ClvI9Urf9VXF2v6JYVvxoWsf9m6P6bzWBg9G+R
         MrRkf1WVjXxeMX8NP4Tbl7ihIEZeaf0QJvS1nzvSnDmwUctXguty/hTA73UsdVo0fUmp
         Bf4FW8CJU545Nt65gEzFjAwufThn3MCcAxO2MVYwU1tuyIJbYF++na4Xeg9O2z9HRPQM
         8H6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776180187; x=1776784987;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y9wbisI+nGNtkqqokTeJEVlqdPP903JLL6TnQpDpxaA=;
        b=GId9ZvKl4uWzbzn0xyWCU7vorsrwlDNjv9ofTBCGyTpbpSysT72wDtSxf9djc3Z8t+
         7DMQoCRuWH1AQYn+yUk0aytlQuDU+rftGqXm0cL2yxry16Z+KZ1vxv9xwtPFxL034nPd
         jU49TypUEykOU2gDyjLZO+ybd4VDSeKRnb8Lc15bWyKS4qpawTP7JpJen+aNqyVbsEpQ
         JsOE6dVm2J0f4Bpt55I1qEGMEKVE8JV7kTDiJ+A9xGwRbIHcId9WLEriNv1VD7Jcmg7o
         VlJYp4wKPMtxVFwxKkfYCS757AoNPGDV03ADpp5n0JREddlaI1NatKbBacqH8nVavNhl
         iycw==
X-Forwarded-Encrypted: i=1; AFNElJ9a/MgCE0xWf1MnklxK+9evC5aJhr/3Z52UyNII0EE2mMBwVSSOSxog2X9bezGiSs7Z3h41Rg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxY1N1vn/XHbd+bOlyjX2s6PcosvjgrObQPX4d8qAcX317pDkm2
	zh5dbJ8LXFNBE/SkpflMgjMcu3/3jDJvmZgKbPtJ7kezWZ/Wja5mT4H8TX8KofzZk3c3AkZ8pFR
	oaTRIK1BRbBm9cEC0F7hz74+wGVybhRUi9pzn8lEu5H2bC3s5n5ZsvcwEoQ==
X-Gm-Gg: AeBDievvbzULcA9Wx/6ztM/M4Nw8zgTeBxjhQMtB9HVXngFT6HrEgxgYGkyBQ/nfbzd
	gZg3V7RWqompJtJH8KTjiYKiTxZxyJuDS8CwqbuZ9e01QQY3dYLsWQzT2gTNeSHdrhv76NUMNeg
	Vj/UT5EXlIz7G2r/PujHy1x6Pqdmt+Fg0r+ngqY1d75sUgAC3EvO0o5wYi7bJlqubft9DeAL5FO
	VjiS1kNjM0agqe0KhZPGvYZBF6zkWbAH0efsVc3A2eATDhabrKOt8nNVKZIA0J2yoHZOQhawA8g
	rNs7rM/vLdzRpwUTOHputhByaEV9Da/YB+yIy56jbCxhIGwcA1JuSrDtatc2tWKvr+n0jH5LHIK
	j5ZRYDk1f9SyAXAad4cquQyqSHSueV9pTtiLgqcEmyxyUzLWhH41DG0Y7al1W9l2v1SHRvcs5NJ
	OrReSljTZ7/GScnYgSDnxjdkik9mL9CzmzyBRQx38rm2qkQw==
X-Received: by 2002:a05:6102:3e04:b0:605:1f22:10f1 with SMTP id ada2fe7eead31-609ff5dbfe9mr9259906137.13.1776180186957;
        Tue, 14 Apr 2026 08:23:06 -0700 (PDT)
X-Received: by 2002:a05:6102:3e04:b0:605:1f22:10f1 with SMTP id ada2fe7eead31-609ff5dbfe9mr9259845137.13.1776180186461;
        Tue, 14 Apr 2026 08:23:06 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38e8467114esm10716141fa.34.2026.04.14.08.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 08:23:05 -0700 (PDT)
Date: Tue, 14 Apr 2026 18:23:03 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH 08/11] media: iris: Add power sequence for Glymur
Message-ID: <7lfcntx7axffy7seg3w2hstomzba2hwnvo4rfb6l7d6ki3z6q7@pt66xxbbvrl6>
References: <20260414-glymur-v1-0-7d3d1cf57b16@oss.qualcomm.com>
 <20260414-glymur-v1-8-7d3d1cf57b16@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414-glymur-v1-8-7d3d1cf57b16@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDE0NCBTYWx0ZWRfXxFiIvU4k/bt+
 u5BiEJh5NVeqJsMt3pdXtPgnL0htrrdi/RHn5xQbEjPdrNVbHmOUz1anNC6j1Emf2FC+eUVCINc
 YWCBmrdyrWNM9Bknsf81gYCRPYX91pDsfloS5hxcSG5I1mnkI1Vp7v3DOJ1QqX3Uzq73R3w/7Yy
 ZTcuppozf97Az1zlw9+Cov/aB8dhkDS2hPGUrz3nAMW2ZsFQBQEa3Z6oHK7IO0e8AWZndhD7Mf/
 1ofmSgaTwfKGlY7qyFO0lebMkcq7phWpwvdy24dT8Jqk8gbHXMnHbgCi9pMpPPdArIXzgZEDwvo
 HmMX1DFinoYHK+HP25OGG0j2dN7Y7uvz2g3Gv9X56G/7kZK4a5ilpZ5/Xi66sVpngMsS3vKkTGz
 4s83pD959jOXurp8wzBXjnKspxoSxRGKSAHn/ARbAbLbqAB00mElDH72Qfcu6pw1/p4N+Tvk/2S
 0lSW1/NBzJzMi/O0d6Q==
X-Proofpoint-ORIG-GUID: kWi9gl1k7UJSv1FfdY7pmIeqfz90Vd0r
X-Proofpoint-GUID: kWi9gl1k7UJSv1FfdY7pmIeqfz90Vd0r
X-Authority-Analysis: v=2.4 cv=btZ8wkai c=1 sm=1 tr=0 ts=69de5bdc cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=57hCUadNtg4o-QVSfuQA:9 a=CjuIK1q_8ugA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140144

On Tue, Apr 14, 2026 at 10:30:04AM +0530, Vishnu Reddy wrote:
> Add power sequence hooks for controller, vcodec and vcodec1. reuse the
> existing code where ever is possible. add vcodec1 power on and off code
> separately which has different power domains and clocks.

You need to describe, what vcodec1 is and what are the requirements. Is
it supposed to be brought up together with the vcodec0 or is it a
separate entity?

> 
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> ---
>  .../platform/qcom/iris/iris_platform_common.h      |   9 ++
>  drivers/media/platform/qcom/iris/iris_vpu3x.c      | 123 +++++++++++++++++++++
>  drivers/media/platform/qcom/iris/iris_vpu_common.h |   1 +
>  .../platform/qcom/iris/iris_vpu_register_defines.h |   7 ++
>  4 files changed, 140 insertions(+)
> 

-- 
With best wishes
Dmitry
