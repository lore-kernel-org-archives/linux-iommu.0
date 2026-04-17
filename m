Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C5934E74B
	for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 13:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776431961; cv=none; b=XaVLJfH8lC07Lo1mYAXZhJdb6hDun9enms4U1vf3IuT2Yn7NntffRd9X8bCN/7wnCuCv/uiSERlBlRplxJcAsFxSidLOwFT+0X3JsNV6c3uw1OtbmF4cWTITkNvWPxXCbjt3S36ngvXjUfbQPxlb435C0FSwtvFxTmyzyJgYRME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776431961; c=relaxed/simple;
	bh=ggu3fcSLSVC/gwdrbugVRpKevQRxWEyEWuPI7XNs4ag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GsUsbGKxH4hgaCviy+i/C9luDvuh7fgh8Gu+1EwkpNOHpkk25n1G01NbYNPgaKboPKE6e61TjNz/1J3SK8ymyNFq5JRIlv0q/xKU8m0zHcjC05usZu7Lf0nbyLBMKcyDShs5HNm9Ic4sNZcHu29weSaMZLpm/JQkezE1InsiS1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZeDMRh1b; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QHOCNdwj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZeDMRh1b";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QHOCNdwj"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63H7afWD1872484
	for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 13:19:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=65UkOtvjXCQohOax2I90x+t/
	26bErWcIiCCRd9m+28w=; b=ZeDMRh1bWX+Thw83zvkx4Cii40X5zHeb0L3A/04L
	wZhwzTVRcOKJS2YLayzImsKvZUGfE1qYFSJSbexWCukq833w0cQm29m07IdJjdId
	d5vAlWXCf0kYnkT42ix8imgM4dI+p3CTjGqaKLGUd+2aUy9cqRJ2qOaK/jEvZh2t
	ZglQlJFW3T0pC2VoEZooeIdnmqrFIQ2tNyWG+gukRibjNiIzbXUOAmJRrLgv8Qkl
	ohS2omqSlclg1Zu5nvGMCt3VvOD9pbpWdBGF3JDUQsMO3KdeJARMq3Dvdzz1cjjN
	U5yqm14mhf8zuBlAYGIRV54COsY1+SyYNqKYHeWqF07fdA==
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dk2knc4vf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 13:19:19 +0000 (GMT)
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-686e8d94970so1134187eaf.1
        for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 06:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776431958; x=1777036758; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=65UkOtvjXCQohOax2I90x+t/26bErWcIiCCRd9m+28w=;
        b=QHOCNdwjb/kFgMGYJnnSWSU3KD3wiWr6ST4E/GKE5nUNm4rxFfTj/cfvShy1aU0w4d
         W0Txs/I+LTEEPIaodU7w6huZkulMjMcJ4yeR1wDWbCToYjcaNh2GkutBQaFyTEvXFzC/
         HoIAUODUAUDZd9u7veFhE0+pQp3YXPEmK65DOzyora3j9xlnWUyw7rAfa4nf2OILMKWQ
         ZxjS0+JXTnULevNyDhNF7omSH2HenquS3k7Ic6AkyLNeRhi3c7gP73s7CqoSM6OPAZkS
         KP6u5qcshgn0wjjTCpPSMAajDoqrw7tDVoSyBXIlENGx/YOso/r9pqBRcSGaIXdqMZt9
         TxuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776431958; x=1777036758;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=65UkOtvjXCQohOax2I90x+t/26bErWcIiCCRd9m+28w=;
        b=prdkiLBDtGjsTOKYpumxc79sYpezCF/kgfT9iD+ufD8VtS9JApmmFg79MVVmZmQjlH
         9EmrL7DFPIdYot19ehadojgoCkSbBO+uJ5XZKC5C5ywtrKCCOuFP0AooQZehq8SIapZ2
         dH/3+5nwazXNO+VGA3PszA4j9F4VcHvUJjdv1k3VxemEOInV8tnXUdulyEk/N5xyE2Rw
         oMAX/CcScvJJG8b/3HpvmLCBcoLlpzI+4KJ6WkJwVxVVptRlaGa2MLvOp4ItTwreCN5u
         OZnj+ELEdvhxpmkp1xRbKKJ4WugJVME8iYlbdj6GE5R/CV8/Jm0dJlNwy2+4UJFZfkQ9
         G27w==
X-Forwarded-Encrypted: i=1; AFNElJ+VGOd+kddyrTB9KsNQ+KeSlS5S2AAsK5+OUjnSIY2WpQwkNIQLRtXFzTyEbd0YToQCDc6qvg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyuk/usjHO+j2xWhUCQ+BUQdRNRZ2atCaxH8ta3Q3k60FYmipot
	HhpSbSZq0EQsh2584O8C2xRUqqdrstOUtiPMlN2woLeCU1D3PIqSbM5gwGJNV+JSW7+TjrnWaEZ
	DVumFAmUTX2thkITGIW2q5mmcNFL3AGBFZssXeTkPiL6z2fRAWoCJ9TlAVQ==
X-Gm-Gg: AeBDievxxHYyqtbb8E8UAmh59AwAq5C2DQKuIbQ7FUO58EGJdWbUe7QlqNYN7cmepvs
	5ET9FtQbRpyZ18ZUarCdRiTEUde1aGXmvJT1FeeGrlNs4G2okDgeqoAGFI/1K9tclrnL0q7gbFn
	rA0x+eKH3iQKBNh0hoGmKo9sgDHiNPWhcFiHHSnSf2GPiOVvyGIuUhM+QrhLlWyjxbyt+H09/XN
	ZgcvxHgiDvWBGeD+o7q1ttfD/C7zudkdA4JZEttRQMybRwCN3VehatBKfchWoTgb8mhsKsZcSyQ
	XFcm+ptDyS+Cbxb+i6w8TMCKZw+1dPvNq2mlN6bAiGI68GLK36khCPutB8xYQxfynsWqQdDTKIZ
	HS6eWC7u379RjNlCIyHNsi2QK4p8TarKJjhBN5A8VnMk4GpKVzsk9epLhfqBqsH+zCKGkvRg+gS
	Qd/df0ngXng3IyQ4Gb+qVFF7o2i/QaICDTM9BM+75pyT9KQQ==
X-Received: by 2002:a05:6820:c85:b0:68d:9ba5:de20 with SMTP id 006d021491bc7-69462e15f9bmr1443906eaf.13.1776431958417;
        Fri, 17 Apr 2026 06:19:18 -0700 (PDT)
X-Received: by 2002:a05:6820:c85:b0:68d:9ba5:de20 with SMTP id 006d021491bc7-69462e15f9bmr1443873eaf.13.1776431957807;
        Fri, 17 Apr 2026 06:19:17 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38ecb740f71sm3559701fa.37.2026.04.17.06.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 06:19:16 -0700 (PDT)
Date: Fri, 17 Apr 2026 16:19:14 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: Will Deacon <will@kernel.org>, Rob Clark <robin.clark@oss.qualcomm.com>,
        Bibek Kumar Patro <quic_bibekkum@quicinc.com>,
        Ninad Naik <quic_ninanaik@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, iommu@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-qcom: Fix fastrpc compatible in ACTLR
 client match table
Message-ID: <yel34g6ugumgqcuhe33pzaaxqvmjcdakdg22wb53oq2snpbb5v@6wfisbcwzyvs>
References: <20260416152652.958229-1-shengchao.guo@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416152652.958229-1-shengchao.guo@oss.qualcomm.com>
X-Proofpoint-GUID: m5L6E3d82thkIlhlw6CMESYFdmeBAYT2
X-Authority-Analysis: v=2.4 cv=XNoAjwhE c=1 sm=1 tr=0 ts=69e23357 cx=c_pps
 a=lVi5GcDxkcJcfCmEjVJoaw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=9JSiRKcJkFx5kB4R2d4A:9 a=CjuIK1q_8ugA:10
 a=rBiNkAWo9uy_4UTK5NWh:22
X-Proofpoint-ORIG-GUID: m5L6E3d82thkIlhlw6CMESYFdmeBAYT2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDEzMSBTYWx0ZWRfXysS1B600xRXX
 6TUCka9EXscocub9Gufo/vXqx0ugKbUhM3N+Je5zkB/Np9HZDaBJpeMDXkTrqkWZ1rj8k6i5l2p
 tdqhdBjNPaQ2hCJg6aMnkzs68c5rQ9Y0RQcJuhqskePOrA32BOnYJ4xeRUsrnsg2BfM25VJwBnO
 Cm9ghKrAjdlORhrsfu0rLjsS1HPlu16C1SmrLQvDz8ZWhuGNavtRiviaU7v0Z0r18AKBEE+vd+f
 Fl6TtJJ/HYbRMHFetGEpbuG5F0W9Uo1IQLz8XRU6XqlhAZ30vtWiHvISIW+aiMrl3POFdrTH2P2
 idxYRWv3QxtxxAbsQ5QqlCR+ENqx0lix2Y0hQgA1w15b7xDqAhCQa3WOIuUC0XZ1KPH7wlGIK8q
 gWEKw/ZIk2nZKK/cAgdo/qLPHJZEiZFyVm2WvmR5HmF1ezdZiRMutaiuTrcoXWAXjpbC6Ykprmg
 TQButHOQW0A8rEKoSdA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604170131

On Thu, Apr 16, 2026 at 11:26:52PM +0800, Shawn Guo wrote:
> The qcom_smmu_actlr_client_of_match table used "qcom,fastrpc" as the
> compatible to configure ACTLR for fastrpc SMMU clients.  However, the
> "qcom,fastrpc" compatible identifies the fastrpc transport (glink)
> device, which does not have an iommus property and thus never attaches
> to the SMMU directly.
> 
> The actual SMMU clients are the per-channel compute context bank (CB)
> devices, which use the "qcom,fastrpc-compute-cb" compatible and each
> carry their own iommus property.  Replace the compatible string so that
> ACTLR prefetch and caching settings are applied to the right devices.
> 
> Fixes: 3e35c3e725de ("iommu/arm-smmu: Add ACTLR data and support for qcom_smmu_500")
> Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>

https://lore.kernel.org/r/20260408130825.3268733-1-bibek.patro@oss.qualcomm.com

> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index edd41b5a3b6a..2d006049dd61 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -39,7 +39,7 @@ static const struct of_device_id qcom_smmu_actlr_client_of_match[] = {
>  			.data = (const void *) (PREFETCH_DEEP | CPRE | CMTLB) },
>  	{ .compatible = "qcom,adreno-smmu",
>  			.data = (const void *) (PREFETCH_DEEP | CPRE | CMTLB) },
> -	{ .compatible = "qcom,fastrpc",
> +	{ .compatible = "qcom,fastrpc-compute-cb",
>  			.data = (const void *) (PREFETCH_DEEP | CPRE | CMTLB) },
>  	{ .compatible = "qcom,qcm2290-mdss",
>  			.data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
