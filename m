Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CAA4BC003
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 23:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780528495; cv=none; b=NxpUtOo+HIQB4TO59INeOG+iaSP2qT2wduXU98as2V9uHS942G71gUdtotifdReCAmIWyPeu65GxrR07JisbKKNL6+dnmLk+d8BQcxNRgdr67bKUuskorYxwiJLNm7BjKJDmTbNIolV9FGmnYTvWoqoOwQdS2F7gtyAuEG7suT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780528495; c=relaxed/simple;
	bh=wlIh7ewMrK39uAMTUXhpkLTuGf2SAbn0ZjgyC9KDupU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nl6dNAdDEbpHHpihXKC4q4iQy53S1ebH563Z+oZiBGhRfsRWLIxqTKrthZlZfmQz/lns9HUvsa8YWCZ3jCjzBEOic2FIpF+cZvj/v2AKL4Nu+izmE+TwZIrbPUT36FRnc5dtv6FdqutyxB/tl/bJyk3xPX7Vt1udNALOkwmnolQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ihtIxLKY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cV+9pAqZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ihtIxLKY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cV+9pAqZ"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 653JTQbU1740936
	for <iommu@lists.linux.dev>; Wed, 3 Jun 2026 23:14:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=2G//XKBrQs0e6JBzYc1oOjln
	PuaY2eGS1/i4qJ/r9ew=; b=ihtIxLKYM6Yo6nNNaTB6zIT3Y8K/AXl9EhQuzt0B
	X9wMI92HrqljgfadLxCHYB6oyWTArtp5Fhovowro6J6UNwrLPWaugGM+/z7wASf5
	tv1WVu+j3LaEgGlI2NPNLOsIk9lF4SeoPjUw5iqMdBfKTdoBXfnvE+wtVR0+tvtj
	oHeGuXedQthK3EbsZg0Ib9v/SUVwJKr2BLeDQ/x1RLolDQfb7ZK8fUqIYqyDkWPz
	2JfcQJ/xXziBD1J0DmNelO1WpFmH+rEN0RoRblzMtvMznp0sGZY2W7gXyaUsGE0C
	6ctllqCJ6WQArQ8JkGEXw2pIYyn8iIGlefvR/JuJo+l30g==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejdq7vdf4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 23:14:53 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5a77f8bdc24so160051e0c.3
        for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 16:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780528492; x=1781133292; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2G//XKBrQs0e6JBzYc1oOjlnPuaY2eGS1/i4qJ/r9ew=;
        b=cV+9pAqZk7oM0xdUoMghpX4zjjkuvbiq7/1+jtPS4Y1jHMLru3+zC6JjUpKtp+OZBa
         H8mj8JmTpKVdqOH2dxjg6P9/9Y6z7q51YX1JRbYTw1LuHBjNPpi5i29LRxrDkJOy1WLd
         H/T6UPh6bzBQn2/dnh3ac8DZFxnTDVPJjJXuObCJCkZ4UPzf89XA6iBVL+iH2xXyQQQU
         giA+c+H96aTvfdp1qjYirZNSWcpTDiq/vB0o5K48O8eZA5wrFUCRP6G6hN4WsOkhaA09
         1mhJxL4bnMWZXFfxWdbwBcX+HEzhWtxbyOAzfGNK10IZT631z/juldrRXcDjX199Hql3
         OAiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780528492; x=1781133292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2G//XKBrQs0e6JBzYc1oOjlnPuaY2eGS1/i4qJ/r9ew=;
        b=YLYQ6kz/ypxAu1LK0yH9qdhMw++AsiXXjT5xQyz/SPTlDIoqWC5ymnxk2fCoFjQdnt
         Fs1+OmrdXDhbOH8iW0ETpLUGkdH7zdsIMPHRKXqlK3lGHXVQ8SUryD6ctGNzvG/h29Py
         mCBu6L8DKw/eZJqFOrR/4jGbfxvP/iNJDlGSyqJ2u4ANj+6G6gaOk1UDX6hLhK6nglAB
         iF+fDwe4vToHZgMO7EjR7vcrmJcUzkCvXaWyJuSk6/XkqNHbE9fZMXRBqJWFdBQ/r8AQ
         tJZ9JDsndgRqLG01RORr25DmKsZDYyVttZoI1uOve9h0hfaifgkhUM54VphePyAWjHzP
         /Klw==
X-Forwarded-Encrypted: i=1; AFNElJ/ou0Wq2HcJxiz3ig6f6S3TRTl4+rxWo7e07Uyd7TZBqcxQuKyZjYc5FhwrxUGBW0rAwHQuKQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy9TV9zLojyEBpBc5nWIUvFrXBKWZ0VXDC0D+mC9toTc+FxaVQE
	JCvbo1KMBUD0Jm7kIFpNghNjr9DiYum8gCMTsutth00Uxc8RZ9F5C0xFgMhmhNxE9QqAbKyLURP
	9gydSXne2oqhPNy0wYEgzNChr2IUdnccfeQZU3abiBmWNRm2CRb/waCoIYNHvaxHa1XDy
X-Gm-Gg: Acq92OHajjIsca49nVcQWmf6ImIzgdujfM4RXYRvAdzHm4iPrBRMW5/kcmAQofjTsje
	2eUdxMA9r+5naEUp918oqZuxIl1qz70BHSF1vVnviSnpOt5oXSXrFYDo8IgGIkgN4MMD82zDMFv
	sJ4fMjYNUjh7z6qZt71xK9CgjoZwWeK0M+05Xv1C6GJ+SQ4h8PlKoyOwO2ngyKmtTTuU9FUURQm
	AHGretJIkoeJFOUV2oIFesAwZG9Jvye7vLo4rOwr8e7ydedISBtuyZtUyOxBCWuxt81cztWdBwZ
	2Tt3fMVRxuEOZAH9kEKPkvgHpEaLm1yHJSSZ2b7JMS1wfjXhhKW4IoaZSBTXYu7Gvbk4MS3ZPVb
	W+UITh5g4aniIoXWj/MzJr8S73sQnlGbJgFI7aXiEUr43/u/LlQP/jlADTP5OI3TjfSi2CRt9yG
	4joxJzI4m+ekxpoDxoBXT9m+0xYiiaO9qFZGmStRzDjtmOsQ==
X-Received: by 2002:a05:6102:5e97:b0:650:9174:32b with SMTP id ada2fe7eead31-6ec53921cb3mr3875123137.1.1780528492345;
        Wed, 03 Jun 2026 16:14:52 -0700 (PDT)
X-Received: by 2002:a05:6102:5e97:b0:650:9174:32b with SMTP id ada2fe7eead31-6ec53921cb3mr3875118137.1.1780528491852;
        Wed, 03 Jun 2026 16:14:51 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b8fc426sm886358e87.26.2026.06.03.16.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 16:14:49 -0700 (PDT)
Date: Thu, 4 Jun 2026 02:14:47 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 01/12] media: iris: Add iris vpu bus support
Message-ID: <4daogr5a6mcuksuszz6io7msh33lut25jxfbltr5qhqij5idhn@ztizw7mf7bhy>
References: <20260603-glymur-v7-0-afaa55d11fe0@oss.qualcomm.com>
 <20260603-glymur-v7-1-afaa55d11fe0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603-glymur-v7-1-afaa55d11fe0@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDIyNiBTYWx0ZWRfX+sV2xvFZJBf5
 j1BP8Zzo/HczUN1UKItL15dTbMs+g+Px1AAHQW2BFK8qOWwsLNmSYh1GfbSkDODk1D9K0usIGGK
 6PAC/YtZFEcktJTRd2LU1g0B18LiwsCp+VS1H2zH/SdrekroGuSx8jvqLoSbBnZwUzq4/E8o0Cg
 13HHuVJN80pnJ/1Ks49UNhOAXCoswbGSzxwhY4OR/pEK4uU8ueIVw1on/AjdvVcWR0oY6GSI+AW
 B2AUxWlLROYPfQr6tNHSRF9gNtZQhOm6zSgTRBedrDmgXag4KZR6kJYnqwht5a7scOlrbK4R1Xw
 ++/Fk8DbQ1ezFGfZiSLAUdxFk1sXGk5yhA4EGFWeyk5OQrWkHPtAF/E/XJ0FyZK6HpS0Wpeka9I
 tM7E/uDLE8SG3mtUtLgSO2fumAZ2hbDESzjfxluHmk109m6aWf7m9s9YsdUEukw7YEBbpzzURSO
 kw6WGGsJ9RpeKDQfZEA==
X-Proofpoint-ORIG-GUID: BXIr2GK_DwM7AFQ6z6A3kaiptOo1duHm
X-Proofpoint-GUID: BXIr2GK_DwM7AFQ6z6A3kaiptOo1duHm
X-Authority-Analysis: v=2.4 cv=ccniaHDM c=1 sm=1 tr=0 ts=6a20b56d cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=iwIdmoSuwSNZiPAV1xIA:9 a=CjuIK1q_8ugA:10 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030226

On Wed, Jun 03, 2026 at 07:48:39PM +0530, Vishnu Reddy wrote:
> From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> 
> On glymur platform, firmware loading needs a separate IOMMU mapping with
> its own stream ID. This stream ID is defined in the device tree with the
> associated firmware function ID in the iommu-map property. To create this
> mapping, a separate child device is needed so the firmware memory can be
> isolated in its own IOMMU context.
> 
> Introduce a new bus called iris-vpu-bus. This creates a dynamic device,
> and its dma_configure() callback calls of_dma_configure_id() with the
> function ID provided by the client to map the corresponding stream ID.
> This sets up a dedicated IOMMU context for the child device.
> 
> Reviewed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> ---
>  MAINTAINERS                                     |  1 +
>  drivers/media/platform/qcom/iris/Kconfig        |  4 ++
>  drivers/media/platform/qcom/iris/Makefile       |  1 +
>  drivers/media/platform/qcom/iris/iris_vpu_bus.c | 61 +++++++++++++++++++++++++
>  include/linux/iris_vpu_bus.h                    | 25 ++++++++++
>  5 files changed, 92 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
