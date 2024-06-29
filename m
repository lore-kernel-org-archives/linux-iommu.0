Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3850F6138
	for <iommu@lists.linux.dev>; Sat, 29 Jun 2024 02:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719626471; cv=none; b=UOk5R/6p7G5aSXKtTAk3oouMikWfiFWOHqFW9E0YN39lXH1dWXIJ4iqqllxplJE3zLp1pIb1LXMgCPti1xOeXC3FxQZIoF5jGAbhZaPDeChd/KaZz/GHvXPYdGsr1dZQYTCv1qJ7oAD6y3BVY2RWgQ4vbgn+VXPFzUTYLyCEwUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719626471; c=relaxed/simple;
	bh=GIXOluhtrpg2CvD0RwEHU48d11ruSL5+0Xnrt02iKEY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qgmsXL9JIGHnvTNkFR5le9WR000HduhAdleiKTE41Lmq8tMtDtPV4K9QYmUA0WSLdqyHUUTzAFJZqifDlA4jI7U4cu2N2Gxcyg5UP7pWhvsrg8ZWBL0bGD7x753qxpp2sIX/QOZhp/+y0UKcvfkbiiLHcwegVyHgWb9ShkwxE6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AfC3UhQU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AfC3UhQU"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45T1MX3g001899;
	Sat, 29 Jun 2024 02:00:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=n2HYd77R9SEQCk1qUqX9Yjmk
	bouHXocypS6wYSptXA4=; b=AfC3UhQUBIAsMqRV4uNPxxP25rmjvpXyWGySPZ2h
	BQ5ibE8MX4tTi609JRFds69An23b8W3smiBv+LORzIf0WbxcMmCqdkmkcS6D1qpK
	Clm+TlnYiulB2FDq/2JjjOnzyhbafY31SqyGD1tLHOuMoDRDSpUkAgBiamcl8Ny1
	WXpFTjHrm12b/ngEf6FMR5K2kWxbM6UvAn0R1HPpFSTnFoUHhVsQPeIo11D2K/Oy
	g8aYBF27CxJ8e+3MZVQjC5BwAXCfQI6kZ0XM+VAI5e5Z3nRhlRLBqnEqlem8oWWS
	FjG/XupTAjHmLfFIaNY+ArjviU7yXfiAnel4zVSRVSv9EQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 400c46hf76-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 29 Jun 2024 02:00:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45T20q8F024074
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 29 Jun 2024 02:00:52 GMT
Received: from hu-akhilpo-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 28 Jun 2024 19:00:44 -0700
Date: Sat, 29 Jun 2024 07:30:41 +0530
From: Akhil P Oommen <quic_akhilpo@quicinc.com>
To: freedreno <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        "OPEN
 FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "Will
 Deacon" <will@kernel.org>
CC: Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Conor Dooley
	<conor+dt@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie
	<airlied@gmail.com>, Joerg Roedel <joro@8bytes.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maxime Ripard
	<mripard@kernel.org>, Rob Herring <robh@kernel.org>,
        Robin Murphy
	<robin.murphy@arm.com>, Sean Paul <sean@poorly.run>,
        Thomas Zimmermann
	<tzimmermann@suse.de>, <iommu@lists.linux.dev>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/5] Support for Adreno X1-85 GPU
Message-ID: <20240629020041.r5dxdpc24swezfja@hu-akhilpo-hyd.qualcomm.com>
References: <20240629015111.264564-1-quic_akhilpo@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240629015111.264564-1-quic_akhilpo@quicinc.com>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Z8AyH3vRZ0kN6fWJmK6ecMzRCNw79Bzd
X-Proofpoint-GUID: Z8AyH3vRZ0kN6fWJmK6ecMzRCNw79Bzd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-28_18,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2406290014

On Sat, Jun 29, 2024 at 07:19:33AM +0530, Akhil P Oommen wrote:
> This series adds support for the Adreno X1-85 GPU found in Qualcomm's
> compute series chipset, Snapdragon X1 Elite (x1e80100). In this new
> naming scheme for Adreno GPU, 'X' stands for compute series, '1' denotes
> 1st generation and '8' & '5' denotes the tier and the SKU which it
> belongs.
> 
> X1-85 has major focus on doubling core clock frequency and bandwidth
> throughput. It has a dedicated collapsible Graphics MX rail (gmxc) to
> power the memories and double the number of data channels to improve
> bandwidth to DDR.
> 
> Mesa has the necessary bits present already to support this GPU. We are
> able to bring up Gnome desktop by hardcoding "0xffff43050a01" as
> chipid. Also, verified glxgears and glmark2. We have plans to add the
> new chipid support to Mesa in next few weeks, but these patches can go in
> right away to get included in v6.11.
> 
> This series is rebased on top of msm-next branch. P3 cherry-picks cleanly on
> qcom/for-next.

A typo here: P5 cherry-picks cleanly on qcom/for-next.

-Akhil
> 
> P1, P2 & P3 for Rob Clark
> P4 for Will Deacon
> P5 for Bjorn to pick up.
> 
> Changes in v2:
> - Minor update to compatible pattern, '[x]' -> 'x'
> - Increased address space size (Rob)
> - Introduced gmu_chipid in a6xx_info (Rob)
> - Improved fallback logic for gmxc (Dmitry)
> - Rebased on top of msm-next
> - Picked a new patch for arm-mmu bindings update
> - Reordered gpu & gmu reg enties to match schema
> 
> Akhil P Oommen (5):
>   dt-bindings: display/msm/gmu: Add Adreno X185 GMU
>   drm/msm/adreno: Add support for X185 GPU
>   drm/msm/adreno: Introduce gmu_chipid for a740 & a750
>   dt-bindings: arm-smmu: Add X1E80100 GPU SMMU
>   arm64: dts: qcom: x1e80100: Add gpu support
> 
>  .../devicetree/bindings/display/msm/gmu.yaml  |   4 +
>  .../devicetree/bindings/iommu/arm,smmu.yaml   |   3 +-
>  arch/arm64/boot/dts/qcom/x1e80100.dtsi        | 195 ++++++++++++++++++
>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c     |  20 ++
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c         |  34 +--
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c         |   2 +-
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.h         |   1 +
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h       |   5 +
>  8 files changed, 239 insertions(+), 25 deletions(-)
> 
> -- 
> 2.45.1
> 
