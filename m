Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175DF30EF95
	for <iommu@lists.linux.dev>; Thu,  9 Apr 2026 01:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775699302; cv=none; b=IwLnNZRNsB59PCW3zGH9K+rUYtrviwIOBSGAcLlwEEzZtJYUue02IlP3SwB/PN5FOnQQFcabfeCp9qqyYmTT8VD6PuyufC+m/ywObYSV4KZWVX4PIDRJVYRzIRvn7E5jNiSNKfGI9KalwDRksTLhiP7yQ1S5sq4NCSBmvITqxQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775699302; c=relaxed/simple;
	bh=h2g+t7AN4N1GKP25VhqaDWa8HerYbLPv8k2KeftW8f8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M/f3zya8y0wtzTeul+EiJMBXGPGrvyQ4ry22RGG/rvfOVUoZPDZyxg7kQrylztsnNpZrYaXxVzzZNHJP48U4xBhxrmPlk5OCfI5B7G9WYuy1ZdolXTQ04rgm8HPCbli4WRjBGyIA6awmv2AmWj9Qbpy6J9Hxb810bJ0uL+nG01I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HN6dFC1O; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=A5j8Ey3H; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HN6dFC1O";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A5j8Ey3H"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 638L2CWA3716150
	for <iommu@lists.linux.dev>; Thu, 9 Apr 2026 01:48:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bMVy6z35ZLJhTi82Sl8QaK6YUF4LfLQ2EPx4PMUuZ6w=; b=HN6dFC1OsTG9YN8K
	yt19jf0A0AOyT/MnpEHNnWQc5WjjmzsoRs2Eulnj73Zx2EXQiXLncqExanNwQ6KD
	da7dckIQA089LbKqe5u6MgsArFFg/Z6rwJjLqUprfmMYoACltzIvQLAOJNWXTNQt
	/X5XQEKSLG8uhhklJN4g5S5StNbr9dgm+wrjyDqCS1cTi0AIzofC/loEXXik8rem
	OaumlHwlO3bE68qpPWUbchcC3AXRNUIeFdFeBEGydv82YJ9pJle8g0K1CKWXK6oN
	EBQviGacDr1Yk/t0ZdKXhKahGHfdhLVsla+uVIxLhAs8a+DVdwrY9J0XFrzplagl
	7ffR1A==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddt749u32-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 09 Apr 2026 01:48:20 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50b4031b86dso16419241cf.0
        for <iommu@lists.linux.dev>; Wed, 08 Apr 2026 18:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775699299; x=1776304099; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bMVy6z35ZLJhTi82Sl8QaK6YUF4LfLQ2EPx4PMUuZ6w=;
        b=A5j8Ey3HKL8sM4NxwXbJxRNg+qiyoaLPe6Iv4WhRsYL+6P7UXwPjY4TK7yV3uCOA3E
         /r7x/enROmvHBVPHMwxMM5LXUFYICIq9liIJUOCsg1PRT42PD7XE6SY+8hrl6rsCs8DN
         NETeoFJV5OB4XviknHt7XgfKg6kSij2U6UNTMljOIGw0SRXbLJMkOiH8BEwp0lFIam0G
         34MG5NzcRjQoMQz67lceDAfoKrKWT2MiaV7H8A+vO2VHaiVWWJXwlyAsyvfHX/wKrYsl
         wMO3SDbG62e6hzSPvCYQrcapQOsxv/xSAa0a3JXmy6IQclQf8HYEVtyaEXOPs9TnANGl
         AiWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775699299; x=1776304099;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bMVy6z35ZLJhTi82Sl8QaK6YUF4LfLQ2EPx4PMUuZ6w=;
        b=AHLPeGd+Y1SIAuWiIE+NBglr9y6sD4T4whCoW77YAqzcEcYvtYhY+LK2D/eig2DIOz
         ef9kQDpyLBlEFAUvTQgiPQEYSAH0VtUu61+xpYC7SLBPIQPF/8tus2m131FYKbsWh3/B
         UKuJwaTuc8V7YHHqwE5P2Rhs/J/G8LS1Zsrv1CRMWXbou4zguxbzl4ECys4xiFbZT6A2
         btW/pCiWGvcbNh+vvY97+gi38kuYmXtykpOGPjGyE0j5hlDjvViPg2zGY3zb3x2tsPfh
         mxKo0J/CNrGtpGmAtnhWft/mKpnbDnxoIQKyNRy4NLnVNCU/RVb1KJw19dMHiQSOwSpz
         2rdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVH1CyMy/vDqeSYcJHg9B5U89OSFRxks4mwftD85z4bYbwY4rROzWkCU9wICE189d40iZLIA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwK6/cFEXj2CoP1eah9o79MztiS1yaIsDlIYLbv2py2Sg3A2DG5
	DDdV85W14fUiDP6lQQC0vZ3TJVs+v47DkR3mFu2/dmjGsTsid4MOTJNwqUtoP30XkiMtUkLJbpX
	FJJROH89Ncgg5CSMcpdWuBzXJvCNYl6vpwSlokJ62dso1MCkWYcJanF9FWg==
X-Gm-Gg: AeBDietawbEjEt0lkuHpJb7xP2tzooNsw/4/FZyAhGtu23vMJ3etn24kJFBrB/Aw9PN
	r0X6vFLqJ6Ybrk7OAS9fdLHZjWYU13vkPYMjshP67AbAcIxUqeGERfXGI6LBHPLMg0tb+Fx+QLc
	Nsvnvkgrt196qoD7STwR5WXKVKQUlf+a5pKVfaowXXXWAWeZksv5a8LTeGpQbi+ZCzwzioVisRe
	EaGVf1BJgUQKns9+ktm1B049wbdL0M0qlRWptuk0AJ3MXP7D1AKscoWbA7m/IvEZOgsAio5VAvr
	hyBAnXa43jy1iLMQJVe8krgxp2KFvyTWPknWRrcQpDDLDuoL6I3doEq3vg0Vz2Uk+OvteBARRF7
	vAJmvWmS2rs6i9tWi6Kq19Z0TDWEhzYGqCRz0hDgZhKhvNZDNfUtUL2FYrlfbiG909ae3UG2sy6
	8D5CmkR2R47D7ctnlJrAsSwobyaVu0Ej/CpdY=
X-Received: by 2002:a05:622a:4a86:b0:50b:4522:d0a0 with SMTP id d75a77b69052e-50dc2222918mr25894551cf.34.1775699298691;
        Wed, 08 Apr 2026 18:48:18 -0700 (PDT)
X-Received: by 2002:a05:622a:4a86:b0:50b:4522:d0a0 with SMTP id d75a77b69052e-50dc2222918mr25894331cf.34.1775699298204;
        Wed, 08 Apr 2026 18:48:18 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2c6ccc9bcsm5055295e87.57.2026.04.08.18.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 18:48:16 -0700 (PDT)
Date: Thu, 9 Apr 2026 04:48:14 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: bibek.patro@oss.qualcomm.com
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
        Dmitry Baryshkov <lumag@kernel.org>, iommu@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, srinivas.kandagatla@oss.qualcomm.com
Subject: Re: [PATCH] iommu/arm-smmu-qcom: Fix fastrpc compatible string in
 ACTLR client match table
Message-ID: <5npqhtczzsxxgxbs5mxjk3bvtypcd6cytec2wlsvykjbmg3zkh@cx6axr72b6uw>
References: <20260408130825.3268733-1-bibek.patro@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260408130825.3268733-1-bibek.patro@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=TL51jVla c=1 sm=1 tr=0 ts=69d70564 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=3yG1jlHAEcHsLBmebVcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: qx8NtSFjuoOIcsyHKKShVJU5M_7uvxmg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDAxNCBTYWx0ZWRfX3c931CV1J0Dz
 UJLDOiH7F5fHT27hW8FVgz+bEL7s4Zr8dTWehsGJwmO1N+kdebARxO0229U/Ld1b5thyGYV3Rtj
 Kh2ugRSbq2uoh12rrIUizvm5rl4mAqjP/uflMU5kVPzCR5AJuzyZJrHEvMWsU0ZtiJZlEmVb08j
 oaynSNHBSipii2NGmDRkbzrpSTThQQlREjLrJNzLCKsrmVs0bBpnsewPygioipMVw9cuLuHpcFB
 2hx0UGTpUrAZBlbiAMKbNIBrB8pcf1enrgrkr2+eT8uQxAI4ffxiv2td6PHjYGN8cjcDK+/NyYL
 mXkHiDpY9s+kgtPX2vIDxM4EUxFXCc6AsopmqXpguGbfg/zXBYtXt9zC+pSFO8KHA73dwAl7mYY
 gRKEtBRYif0o9HOz9/bwj4sbhoYZ/L1rf8uLlFuXxnwe0R5URMufAuNjrXywt7gdk9i7ruhkptH
 Ri1hhxzHNK+X2+h3yUA==
X-Proofpoint-GUID: qx8NtSFjuoOIcsyHKKShVJU5M_7uvxmg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_07,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 adultscore=0
 spamscore=0 suspectscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604090014

On Wed, Apr 08, 2026 at 06:38:25PM +0530, bibek.patro@oss.qualcomm.com wrote:
> From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
> 
> The qcom_smmu_actlr_client_of_match table contained "qcom,fastrpc" as
> the compatible string for applying ACTLR prefetch settings to FastRPC
> devices. However, "qcom,fastrpc" is the compatible string for the parent
> rpmsg channel node, which is not an IOMMU client — it carries no
> "iommus" property in the device tree and is never attached to an SMMU
> context bank.
> 
> The actual IOMMU clients are the compute context bank (CB) child nodes,
> which use the compatible string "qcom,fastrpc-compute-cb". These nodes
> carry the "iommus" property and are probed by fastrpc_cb_driver via
> fastrpc_cb_probe(), which sets up the DMA mask and IOMMU mappings for
> each FastRPC session. The device tree structure is:
> 
>   fastrpc {
>       compatible = "qcom,fastrpc";        /* rpmsg channel, no iommus */
>       ...
>       compute-cb@3 {
>           compatible = "qcom,fastrpc-compute-cb";
>           iommus = <&apps_smmu 0x1823 0x0>;  /* actual IOMMU client */
>       };
>   };
> 
> Since qcom_smmu_set_actlr_dev() calls of_match_device() against the
> device being attached to the SMMU context bank, the "qcom,fastrpc"
> entry was never matching any device. As a result, the ACTLR prefetch
> settings (PREFETCH_DEEP | CPRE | CMTLB) were silently never applied
> for FastRPC compute context banks.
> 
> Fix this by replacing "qcom,fastrpc" with "qcom,fastrpc-compute-cb"
> in the match table so that the ACTLR settings are correctly applied
> to the compute CB devices that are the true IOMMU clients.
> 
> Assisted-by: Anthropic:claude-4-6-sonnet
> Fixes: 3e35c3e725de ("iommu/arm-smmu: Add ACTLR data and support for qcom_smmu_500")
> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
> ---
> 
> While there is an ongoing discussion [1] on how to differentiate ACTLR
> prefetch settings between compute DSP and audio DSP fastrpc devices, it
> is necessary to first fix the compatible string to "qcom,fastrpc-compute-cb".
> Both compute DSP and audio DSP fastrpc nodes use this compatible string,
> so both will receive the ACTLR settings after this fix. However, for
> audio DSP devices the effect remains the same as the current
> state since they do not actively use prefetch — the write is effectively
> a NOP for them. The fix is meaningful for compute DSP devices, which
> actively use prefetch and were previously being silently skipped.
> 
> [1]: https://lore.kernel.org/all/9b4c895a-c822-40e6-bb92-8fdcd09c82d3@oss.qualcomm.com/
> 
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
