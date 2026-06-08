Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7923CC7CC
	for <iommu@lists.linux.dev>; Mon,  8 Jun 2026 13:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780927077; cv=none; b=QdkQKE+4qK5YDSZ8OTKVHQI5iTTD6jFOp2RZQAVOuIJVE/9KHJSQYVQjuaQDbzK3DOiWY/m5l8BlEX8dG2Tg9o7JnQjzmv1z0/bNafs07R9xt5H53Z2awBnJzk1QxLQQKtuq5BTM/l9Fz+8Xf8xhJTOo9Ccha1M95+H1zGBvywE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780927077; c=relaxed/simple;
	bh=2iG4kOLG80lHNE6HN05CA2qQtIYYO+IFPRLCITgJYKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ao70RxayNtLCMfFZU9ne/g6fl1yLkfNAjYnXpq0X7ziy7hCxf/TN1kPFQpTOw6IajU/I1zbr9N04nbDbh6aIrKAQUuOJl3k4j5RAgoJkTVgGCe3hZ8CYm6nCVUr/8jpyUURMOp3ytLWMEefVkFw9yD9Pse9E8g68bZZ20irvLzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WUFTxF/c; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hEoJvBcr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WUFTxF/c";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hEoJvBcr"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658DR6Jw3336180
	for <iommu@lists.linux.dev>; Mon, 8 Jun 2026 13:57:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=8cPA997XuE0awkGepna6I5ww
	w79fUhweZMaYVACJLoU=; b=WUFTxF/cBaRxHKYXcYN/1Q0/mU2fDC0l+9YpuUW0
	Fo1iwLMnUV0E35L8ARdTo5f0jb6sqlHJx2aV+375s7XORA/9/gmz8pHq2s0y51ey
	IWy0vVxk89vcAL0M0rBrW81qeZN6yAuCgU1UrW88wULZYtRzVGVCS+/ywUbb5jjR
	uiBM/bWx2XcrXelhI1nQpYgsjvpZj1njuneRDN5PSfwWg1H2RitPOwlrxJcrwCQA
	AZfv94gauqHTaK9U161ueHLvPBgOXbWBlZ64ndbfvL8cHVz4NhyfogDIRTF6yieM
	vTdPFwKw190P5uykNJfCnR3XZmJW4Xd+4+AdaemUc2gk4g==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enun40yxm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 08 Jun 2026 13:57:55 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-963b11561bbso1748097241.0
        for <iommu@lists.linux.dev>; Mon, 08 Jun 2026 06:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780927074; x=1781531874; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8cPA997XuE0awkGepna6I5www79fUhweZMaYVACJLoU=;
        b=hEoJvBcrvZnvzUs5SPCBPvpSJYHuAyIUIZqeDcyj15O6lLFJGsPGG8PgbeuJi4Du1+
         6zhL/ammbiSUrRLsIjc9eSneoBQKU7TCD5tM8JeMl0Bescb+O/RuOJGMbFf+L0BaaBvr
         UcjeVXlfBKoEd/EGRy+ZlmIR8qbDVXwCNvzLxTsoHOET894/zIpPIBVFo1S8oYy6nkp3
         LpcJK0t0I8QkNzKR5gwleOSPCOCLDZEwxmhc3dMmeMJ/3IeKAsxirEg+HanUBnl2zi0e
         LumBxyKxLMzgvxtNubIhnukcr7urzYdnsjI9CgEmqodh/yahzcpS1d2Rolg1mhvATY5E
         u6vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780927074; x=1781531874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8cPA997XuE0awkGepna6I5www79fUhweZMaYVACJLoU=;
        b=N3GOgNJoHZc4mnK17jP9MezT8EQlX5m29jQ8A/jJ8esmDe073wLyHiifAnUqovP428
         9AmzuaNihoXn7241IMGprQA/0ZSGP0PIIDLKNl8GWz5yaYlJKO+XrGnuEdWqELy+3vfm
         CAvBqvp61vQQ7IG+LGdAz57U12Y1tlGQQV5bpdAfJvD/82C8dQ0+8DbPFuUVB70NArTa
         GFQVkmZ0b1rdDAyYMrjtZ8W9sQeX4S7mfg8Km4u1SMyg/8cNI+JS2xG1yIlZ1nAs9ovr
         hER7qUdhWihGHjrxc17uFE/QJP/ZYyVzGo+KBqTuj7kQjV8xQjZEisd0xyGP8TRXMhXK
         5dUw==
X-Forwarded-Encrypted: i=1; AFNElJ/yzH+4wxfwptak51FypZEbVv036MxwCjB4sglO3BOg3hU8LM4YoY6Hw3SSO28NIpWYsEgwkg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwU0DUDEon625oPaCzI0U2hzJf2Vkkuih/1bMZ0NxWfcefZhid2
	kX3X4XzdyJUc36xX5CfXUPl5+xn5g0TriEYe1JuPa9Nxf/KA2o4OIkjKHr8JnKHYbW3zHfSpcZb
	/58cIyVnmfDk0TAlK9zHA1GvJPIfYM4pMF7O2h1SB027/E2s9n/WJJbmxn4fewPV4TFuf
X-Gm-Gg: Acq92OEaU7xp+kp5WmJr2SlRTG1LAzOrgRd4D0hUrrmi8a+/GYvvZUfP9LnyrEVpJ27
	YistrQ86c06+etPNaph9k+sFH99nRb33YHsVePekMLuPFlerx5GjxLfVY2b9nwVrGDc4iPNiGOV
	xZ7b/rWjWKlj6xm+zwRnht0lIZhGhYHV51LI54K9Ty4i72MOe13fGrpjyjoAUtwN4ZSEuDqblB+
	esq9XK9yHXQRBDTSMVrRipp9ivh7pY71fl0PfP5TCY64Gm37HE1rPb82y+k78YpWsgBLkNuH3wi
	IAEzmhi8TN7yS7A6SxtDcsTHbk1nchTg8/Ou2seKPMn5tyY+sBXfh1So4QXdRR69no3akSj0akN
	qK8c8jnl8Ll52mrsheRsAoZpumA3xal77VLGwgWRDZZylc4CcJDvLEBMzIX4akT5cVPGWNN+GNn
	512JIy1f5wcBCj/ZMkmQVeZQRLvgag1zr0t+Gan5EL2jrqsQ==
X-Received: by 2002:a05:6102:c03:b0:6ef:dd26:e2c3 with SMTP id ada2fe7eead31-6feffcf11e1mr7169175137.24.1780927074479;
        Mon, 08 Jun 2026 06:57:54 -0700 (PDT)
X-Received: by 2002:a05:6102:c03:b0:6ef:dd26:e2c3 with SMTP id ada2fe7eead31-6feffcf11e1mr7169160137.24.1780927074019;
        Mon, 08 Jun 2026 06:57:54 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b8ed2adsm3867106e87.1.2026.06.08.06.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 06:57:52 -0700 (PDT)
Date: Mon, 8 Jun 2026 16:57:51 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 3/6] arm64: dts: qcom: kodiak: Add GEM_NOC
 interconnect for adreno SMMU
Message-ID: <p4xnrkcpbufkkbv4kq5civbt6hiwv3warrz7jiyinsfkihfedh@jfa7sgyzot6j>
References: <20260526-smmu_interconnect_addition-v2-0-2a6d8ca30d63@oss.qualcomm.com>
 <20260526-smmu_interconnect_addition-v2-3-2a6d8ca30d63@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526-smmu_interconnect_addition-v2-3-2a6d8ca30d63@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEzMiBTYWx0ZWRfXxSJH6H2UGaWY
 vUMnem6AGo2VQ+AzVGWMWISbe+7u32MF2iAUXX0WhyG6U1K0xis+3GEllmlGgufQrWxCERiOsts
 t14IWbbVcX1lmOuP5b8aUyzHL0ePzaSVetaYtSwn4Vt3IOlPSnGNQh8mtIbag11pYohmAyphkg+
 7LKGILH03ajS7qsv8gyF/oArrG2fP2zAyj/E+BBaPoQBjoCgcFbYahDYcGi0QLXCd4XCk+xkAPj
 b1fMaamN43bmwHNuY0GmfIjtWFF6iCg1FNJ48C2UlBpMlHEmmTDqsQq/xM823HLE+21IutWQ6sN
 Weogt/AkUKf8v8R3J9SHYdanjPA8zC7cXiIRSGHtXmR3iTKIkeLJ7f+w5pJ24zSsQ2SqLdvr+st
 m3L1xJXEaiOQcsngGj96k4kl42mLZCIKdEN4Fl+SGzkevqczPyOmdrAUldInnorVhcYWxwFkoCt
 IVqjO0o/lxzfrSmpBTg==
X-Proofpoint-ORIG-GUID: J3ydJS3Zo6eBPjWiycGQ7iMf5qk190yt
X-Authority-Analysis: v=2.4 cv=ZY4t8MVA c=1 sm=1 tr=0 ts=6a26ca63 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=LVq_GggcSHk3DsAf1gkA:9 a=CjuIK1q_8ugA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-GUID: J3ydJS3Zo6eBPjWiycGQ7iMf5qk190yt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080132

On Tue, May 26, 2026 at 08:12:04PM +0530, Bibek Kumar Patro wrote:
> On Kodiak platforms, the Adreno SMMU requires a bandwidth vote on
> the GEM_NOC path (MASTER_GPU_TCU -> SLAVE_EBI1) before its registers
> are accessible. Without this vote, the SMMU may become unreachable,
> leading to intermittent probe failures and runtime issues.
> 
> Add the required interconnect to ensure reliable register access.

Does it only concern the GPU SMMU? What about the APPS SMMU? Should it
be voting on other interconnects too? I guess so, because currently I
see that TBUs vote for various interconnects. BTW: should apps_smmu also
vote on the power domains?

> 
> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/kodiak.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/qcom/kodiak.dtsi
> index fa540d8c2615dc02d941eb16bc7253204c2750bd..eefa4b836a81374ff437ab4bbcbc3fecc1590ab6 100644
> --- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
> +++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
> @@ -3386,6 +3386,8 @@ adreno_smmu: iommu@3da0000 {
>  
>  			power-domains = <&gpucc GPU_CC_CX_GDSC>;
>  			dma-coherent;
> +			interconnects = <&gem_noc MASTER_GPU_TCU QCOM_ICC_TAG_ALWAYS
> +					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
>  		};
>  
>  		gfx_0_tbu: tbu@3dd9000 {
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
