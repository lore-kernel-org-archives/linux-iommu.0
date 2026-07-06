Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8293ED5AE
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 11:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783336043; cv=none; b=WvPrkO0VgCL9wT1WQ6nllfaJM5OsFh51gvaJFgPTyTz/8ZYkdeJ9MVT7rUixHjDTEH3gOkUP3uD00YGK/nxRUR59R1FBE2/DnqM12RZlstcNRAPyi/HPpYgeI2izYxDs/zKHBOgyNLeQnyzKdTrMgUn/0aPji+mDsR2fPkePR6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783336043; c=relaxed/simple;
	bh=GSC20CtzxbmxBVORCMfWhPZFgodoTm+IPeQhXWhdJ8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rDO67w8dr8pu6GTaqBtl1xhzi5WUJXmgPu0wbRgx/kyxovxBq+ndbn+iTg8PQh/7oQ766paNymdFHZa+E+0y7Jn5GJNAs1UFfVpWdafpo5whQaiiyPtZnfcXjByzRGZgqb0u6EnoWg1S0JRd12bZxyBMQdZGP8UeADGlqu1XB7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=psP9WYXz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=H8DlXaEW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="psP9WYXz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H8DlXaEW"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666Ax7IS245535
	for <iommu@lists.linux.dev>; Mon, 6 Jul 2026 11:07:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pBztFgeivDEDVCYAqSb+ojmxplpWHAAOO/i8mhVfjVs=; b=psP9WYXzjA6tVY4c
	e7rvWCUSBKLLxlaKYYldlfSj8q4wfEcWRj8z0GEpzslEP5lCPfkuOd0puPbQnESx
	dpHExnPs3jZUFkF3Qtj6ig3uQDhfh0W5LGqf+KBRZb95RDDco0i3w67KSO+AaKVA
	n1cgehAjkLnlQ//KiQS7HScVSQnbA76/tV75eE5Z7o0INDuV2vgr7DyOqtXFS7qn
	E5O7ExMLndq6u/rPHHfCpi8YSgNdg//4RILbabVAENfoj/nOPHSpNCc/o26wbx24
	s5P8arb22Ut9h7Xjcaw9TwZ3SEgi/xD2yyezhU4wYLHhkhdyHFS+rvennSmICyqv
	8A/g4Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a98g7h9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 11:07:21 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51bf9df2eabso1872631cf.0
        for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 04:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783336040; x=1783940840; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pBztFgeivDEDVCYAqSb+ojmxplpWHAAOO/i8mhVfjVs=;
        b=H8DlXaEWDuO6HbSz9J9ohTSowlA8xihhgk+YFI+HXdO3CJCfPchREj8T0ZErUBmpbm
         Q+rK2ZhnPh+tyMixt0Dz1eil2TBtC+g97LcdmSLjJyGg7TBAVnaF7MErwJUXFoCrwCQz
         KZF/JMyZEV8hGt41KXVgT7nX6Z69e3wXj15kuTGwjt0x2GFvgztrpCPNeKc5tk0FuB+c
         94/L9HLRFC4TaaAxqP3NieV0CXS0PGzCIw4d8xhGUuSihmqOW9XOgi5xf1TpTmnSWyat
         uhklRXO4uNwyTRY+NSUUq9wNinrca8vaNVx9sDevkOcKHgzy91ydUbpE6DcIHj0Jv0Xq
         ka6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783336040; x=1783940840;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pBztFgeivDEDVCYAqSb+ojmxplpWHAAOO/i8mhVfjVs=;
        b=V0oiJt39vl4vBApFC7nAMtc4l6Xz5YdpUv77z2jhB/Da8PIQrcFKer99bF/bh0mYhz
         gb5ypASST7y9wPMeVncspu6p61u0syxjAIfMbbw++41ckMaW1A/OCZvwToFN365nibFI
         Ud47D7kuVfWk2mCDUHSYgiFWzlwQ8/AqKug7TBhGhZRYVDVUi1lkZt5Ge2Pl104ptTW+
         nj5HRzowtfp4e6qrRyxnkxbPtJ/TzTtVnFev/SABBcdUv/iZhcbzWkQwd9GCwhEB1ws8
         XVwMDiSjkNfQKMIxbVvmeQZCsGgNm17zfaQDIsHf9AS9uIvomes4c1Glj908+uz5p3Ny
         8+fQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq0X2/gegcRIpvJgsPxecGKI5crjp4/t0cQp+YnHA45D1tQkxsJ6WvM+Olv10GMk+BDajgIOg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy2/2y/AVKtZGYJ9euAeUjb4tFBu5OVX9QwWjz7QDkOAStEe19c
	ImFELBO1kXokWs4mlZG6LLu5PWwWJ8kYz0a+aUERhgBSxhQsf+TKhSKYpJTW68SxzEFEduGdR5X
	L11DLcHt7Fi4DuZ8JYV3tjwXj9A1SRlCPlJ+EfhGllus922jjAgTcXKY0/A==
X-Gm-Gg: AfdE7cn4QYzj5yihhKvz49p1MkvBy9GT5k8tZ1lZBLaDOH9Fj/ZOAlf0p5KrmWph59P
	6NsRSY5tMexdw1u6dWyegyY1X+MTfeOtQkAzuEohFCxDxRhkBxWRrrfvrqgnx8vBgHibcovamyZ
	lQIHAkRjXCkxGkpM0cjMK3eCA/c5oXSfDU6MfvyVTgHQRhtYmNKuc0mwbEq8TjEtfTEgUOJwxYK
	PVvD7NjX4D6uSuYq9LI2Urs25Qp+oiXrDia/WPMeBum1Bx0EOtwTKWLNO/vVRI7w4jnXlaqGY/A
	BcyyNGeQgHsRGX1zOczL/X6xVwqGQmTpSgs7V9LrByzb6s1gri6mves6wZh9pSvhz8RqJu3lvnz
	DtXA6GH/sq3TjY522CHRemDUyNj0CbD7BUL8=
X-Received: by 2002:a05:622a:347:b0:51c:2101:f0 with SMTP id d75a77b69052e-51c4bda6c05mr97022581cf.2.1783336040111;
        Mon, 06 Jul 2026 04:07:20 -0700 (PDT)
X-Received: by 2002:a05:622a:347:b0:51c:2101:f0 with SMTP id d75a77b69052e-51c4bda6c05mr97022121cf.2.1783336039446;
        Mon, 06 Jul 2026 04:07:19 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b6055039sm720881966b.4.2026.07.06.04.07.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 04:07:18 -0700 (PDT)
Message-ID: <10b0ad51-8766-449c-a51c-979364e6c781@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 13:07:14 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] arm64: dts: qcom: eliza: Add GPU SMMU node
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
References: <20260705-eliza-gpu-v1-0-c9f1354dbd29@oss.qualcomm.com>
 <20260705-eliza-gpu-v1-6-c9f1354dbd29@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260705-eliza-gpu-v1-6-c9f1354dbd29@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=SpigLvO0 c=1 sm=1 tr=0 ts=6a4b8c69 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=UMfccTTTTeY9HYHi3ccA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDExMiBTYWx0ZWRfX9der+4T92CFV
 K2ZbiVaw1f+NWBXDT0QOtMk7rHnJBAzi24Aw+4ajagpSijpwvyrYQD2PwvqKjMB4DUrLJIOSu0Y
 RmkePuYKAHSxrb3vmMrt9flAeb5+4CJ+ztz9FXU5cHoPH65S1hyVAueuD52V5Um26QjGDH9UOeF
 067yimxGVaYwlsr6emn1Huxbq+mToplCEG+GzHRY/uHeGFK63W9hE6xdX8ztolNDICYPlh8KStK
 KAapG5KRkmxw4u7SJOi0dn5CooMd5eJ+dqOZ2iXy9ducGI9IFbh+7mHk2M3yJBepIXL23v9Nf70
 PF7qu9dLBEHYZVpEDn6fLBPoO09NlmFaPO8Wolfz94/BQv/UraOdEUfm5tUKapG8/H15UPwmS3O
 0Cnv4YO4Xk03ypp3kVHlIU6KcwpwAt/Ez7g+2KJ0btiJRo3PcIYDDnWbG3Eks3d5FUj1PahLmiB
 gGD2hYJZq9vxPaFykRw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDExMiBTYWx0ZWRfX8WHOank/vu9C
 Fv2IXfqju0x9azY1a2LfZw7tuQef8oXkSiWw+KZagOIisHBawIytf/y1b6t122Y2xokRpivezo2
 1t4gt3/D6iW0X5CeDFujqQjF9tzrWNg=
X-Proofpoint-GUID: JcLCJ0zuuQjbSHQTjr5o1pKwbH9Ngu_P
X-Proofpoint-ORIG-GUID: JcLCJ0zuuQjbSHQTjr5o1pKwbH9Ngu_P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060112

On 7/5/26 10:14 AM, Akhil P Oommen wrote:
> From: Abel Vesa <abel.vesa@oss.qualcomm.com>
> 
> Add the nodes to describe the GPU SMMU.
> 
> Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/eliza.dtsi | 38 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/eliza.dtsi b/arch/arm64/boot/dts/qcom/eliza.dtsi
> index c5635f22e2a7..e5b8377e6c3a 100644
> --- a/arch/arm64/boot/dts/qcom/eliza.dtsi
> +++ b/arch/arm64/boot/dts/qcom/eliza.dtsi
> @@ -2674,6 +2674,44 @@ mdss_dp0_out: endpoint {
>  			};
>  		};
>  
> +		adreno_smmu: iommu@3da0000 {
> +			compatible = "qcom,eliza-smmu-500", "qcom,adreno-smmu",
> +				     "qcom,smmu-500", "arm,mmu-500";
> +			reg = <0x0 0x03da0000 0x0 0x40000>;
> +			#iommu-cells = <2>;
> +			#global-interrupts = <1>;
> +			interrupts = <GIC_SPI 673 IRQ_TYPE_LEVEL_HIGH>,

674 is the correct globla > +				     <GIC_SPI 677 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 678 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 679 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 680 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 681 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 682 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 683 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 684 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 685 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 686 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 687 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 476 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 574 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 575 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 576 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 577 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 659 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 661 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 664 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 665 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 666 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 668 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 669 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 699 IRQ_TYPE_LEVEL_HIGH>;

This list is not quite correct. It must be sorted by the context index,
to which a given interrupt corresponds to - the driver relies on that
to give you information about where a context fault happens

Moreover, I see that the interrupt sheet has the bug where some
interrupts are offset by 32 from the base vector, and others are offset
by 31 (i.e. the SPI number doesn't equal irq vector - 32) - please find
out which mapping is correct with the right folks

Konrad
