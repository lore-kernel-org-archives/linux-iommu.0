Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703382F3601
	for <iommu@lists.linux.dev>; Wed,  4 Feb 2026 16:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770222754; cv=none; b=Yuz4pB3P5tMvJD2loXJpcoZdSenhcp2TZj5aRNWD6qAh2QDenfiPDzfNfaA1caz1+WjkizamRLnKsOlh16egEvdZRFVwDfNyOC/KGHOIqmInhVrEonYVtdttDDz3yrcVu+7e8cFBfP7SVLTG7qOVFnqneC4xrRPGolNmzjUekRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770222754; c=relaxed/simple;
	bh=tC0iPn0gVF6ar/L5b9qrFh7coBiWmg18UfsKp1j9LYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I4dccXLqOrBy+yxxZ/p8f3TfqCD8jbwkxqhrdTDCmk6qjx33t5+pR2lBv/17v15TY0hOe/iSaBpwGjwhaUGqLkBeNKwrTJrDt3Ad53gLw6biR2baS/rDgDVI1kPdFQhyc37fesWVCWgV9ORx2irfIftHQE+wb88hld3E5xYBhj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B1AEzZ1U; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iNA0xuyp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B1AEzZ1U";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iNA0xuyp"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 614CIOmX1245881
	for <iommu@lists.linux.dev>; Wed, 4 Feb 2026 16:32:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Ot0UHj52m/IAOkUIkudhskal
	lh3JrxoSMHxt2SdBTMM=; b=B1AEzZ1U9pPgEWTPnBotUvorfF4OHQZIz8ESDF2i
	iGWhYvGcDsS17S9D/f9yBZZDHmWo7AQcBa1dH449yO1PBSzvtsBry2y2rLv9rE1M
	VsLvJhuWq7GOQVHT/VAFB+5T9wzMMXk0dAWXH+U3tsO0j6Y5OgqBPhm+ciSJXlme
	D0mXt2T83yUhl0tFEANOTD+6eV7mwwQ3Awr/gWLeMCGBx+HibBpWzyquhuBTBCpq
	ud8UFJCOGoyUjkDTrDLLZFmB1HDDcg60e1O9/N1XF09eBkYONjJgEbbjNAJIX32f
	EOCKp29yLl9MpI1W4Yj4Sa9xBPYdNUj/ayZjrIsB8MCG0Q==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c3ru9b8w1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 04 Feb 2026 16:32:33 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2b71c5826fbso7888768eec.1
        for <iommu@lists.linux.dev>; Wed, 04 Feb 2026 08:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770222753; x=1770827553; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ot0UHj52m/IAOkUIkudhskallh3JrxoSMHxt2SdBTMM=;
        b=iNA0xuypqUDdyvzDt54VIxbkRjBPGaaQqeXypTblfwW3nlBHARMFmDnmThYSCqj3mo
         axeJ5/9/I5d6r5RnlSWIT3nE4/RYFU7sktdYK4xOqW/wqcIiejUi60CxfgdNnyYRh/4U
         9whsIBfX+P6Fl4OPFkAB6Oewa1X6VSAnmK8zzKpjXStujjyls6a0dvSmcNYJrG1aCEP8
         jjxgALuAWWHz7Z+OaoVoHTq6enw8aOZSL7IkdeHqQwI2megQuyFTklVKALbQjSMmgjYd
         CtDHTxHaLSbUQxYV++XCnNPaGjHCZTPp5dF2KHvwZvbu+skJcilKEx8rr0LMmEy7ewxq
         fM5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770222753; x=1770827553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ot0UHj52m/IAOkUIkudhskallh3JrxoSMHxt2SdBTMM=;
        b=eykVRDAe50WzOYyf5raxkKMu9P0nerJB9a8299n39R3QHRAni89FHLYiHo+shDYzdz
         uyc+JwpPhKtCOdEFd2tiO6YYakhxKpdUt6Bv98xKdnivuIUE3M+7RijoV7X98/ugfi0N
         dgXWwG1ZF0F/mAUZXUK4jJqTxBqiLA1+35XjtCqnwTNJ7wfyBnmrWSczwu8IGsN3SXlQ
         UabbdNCpv5fiDcebq7VKlwgUMNuWxqgLGCPhqM9+aRzgxJIZbJpJE9HsTpuMClaTXtzQ
         tZeP/1FXbmjIDJtwPHs327WDihGDgVshnlEwZW/YJVeelVQYlZJDBLS+jLM+u2ZN57Ra
         wRyw==
X-Forwarded-Encrypted: i=1; AJvYcCVaT7U4rQ01cfYO1fRN0hqlc5KAXLIK4nu2IvR7xxMWFlG5ptKQnWhDQ49ZJ2q4YLjAP9YNlQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzFs6itJjY7TNouUi8Ipj44O+iy0VQEpwNS1ZZkMb/F1uZFgUQN
	GIMw9kIb/s+269MpqJdw1Gw/04K7smCCo/0+T0VSE3xDZMqE/k7vJrdBu7KdeUH8RwEAn701bKi
	VCvOJn6e4z2yygGcXGj4e6woipxwDnH4dbMD1ih5Q70bBacbXZqk+6dIrcw==
X-Gm-Gg: AZuq6aKAEFUmBDvlcatFEV2Zz7j1Pz349K9DfMxUGy7gRwarUsCEa+lnIG8u7SNZnLL
	OtNUiMXHg8fVMtoO0q6UhGwp18d1NTf8vBRn57M2B2sZNSGs/Xsg4jE+8RDgAe+kew++tYCMazK
	LBlM60maa4ws6hUs/Dcw7DUTH/+XBhv2JLBl5CVYjA/+j/BVmtJvva0rl5jBdklw3yWPk08+8Lp
	QG2UcaTRl9NDqfABU16uo40ZAEyjvc7ze49mnFMbw6kpTTzBMGAccBg75PJWE7cHZEkybobIK3K
	XvBGdcI5E5DzpGgWJlV9Vcd4auarxpMbxLjuEq0CFl911LxVNEjyMF8q6VAyvUldu41BcODHae1
	LcG6WWuP/NiNvoElYuNQ=
X-Received: by 2002:a05:7301:9f0c:b0:2b8:2748:1337 with SMTP id 5a478bee46e88-2b83291a20emr1556938eec.7.1770222752716;
        Wed, 04 Feb 2026 08:32:32 -0800 (PST)
X-Received: by 2002:a05:7301:9f0c:b0:2b8:2748:1337 with SMTP id 5a478bee46e88-2b83291a20emr1556923eec.7.1770222752116;
        Wed, 04 Feb 2026 08:32:32 -0800 (PST)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b832fe59fasm1711886eec.34.2026.02.04.08.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 08:32:31 -0800 (PST)
Date: Wed, 4 Feb 2026 10:32:30 -0600
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Yaxing Guo <guoyaxing@bosc.ac.cn>
Cc: tjeznach@rivosinc.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, alex@ghiti.fr, iommu@lists.linux.dev,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] iommu/riscv: Skip IRQ count check when using MSI
 interrupts
Message-ID: <2u46b5uue3jbim7u5c5p3oi7pgkq6vv2q7w3bkzvt3iatwredq@35o6g2rbyheb>
References: <20260130065420.16811-1-guoyaxing@bosc.ac.cn>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130065420.16811-1-guoyaxing@bosc.ac.cn>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDEyNiBTYWx0ZWRfX5hKqtFvmkEKR
 9oUEN7Ovdv3OOp/+YiaPGB7qDpYuo1m1sJv8tuSLf1sJOxdGxSL0EDNWyRpTCPo+hgpNG4lQtG+
 SMadCMKQ7NSgO9G12rK+IMzkrev1fXyRgZ10KLVIyOuEmsWPHU/2ZobEny/3IAlagQFohc3B/Qn
 OeNwI1fp4NbtzHRc+Y6jOf8DAjWFUTuFEdUSJL67iSerEbIQIMG1IB1ADZJQ1Iauk+gXEoeN2dm
 ENgm2KVKciOV6md32MJ7lprE+OV/fVbFsh29+/zHL0lceqe/Ih1r+Zzqa0ZAyOA+JZuLn34S2j7
 txRYUyxoQ4p8y1Xx5OMO4/GSfpTvIMLf41Ywfj/fJGi/N61hJSFqaKyFVhkmjpxxbPtLAGkXg0H
 wgx45QdUypTdyefK7Lko23SJn0hwVPrLxWEh85yPhzYuBUcsCUuKK73sJHPgcJ7jkT+o+9nqBeK
 opgIK10LGNJiT7Xpjdg==
X-Authority-Analysis: v=2.4 cv=IJoPywvG c=1 sm=1 tr=0 ts=698374a1 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=cvcws7F5//HeuvjG1O1erQ==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=KTr5YeW84r-woyCYTtQA:9
 a=CjuIK1q_8ugA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: 9FkvoJYuWMvdNctv999VpdZ4ZmEY9tFu
X-Proofpoint-ORIG-GUID: 9FkvoJYuWMvdNctv999VpdZ4ZmEY9tFu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_05,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 impostorscore=0
 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602040126

On Fri, Jan 30, 2026 at 02:54:20PM +0800, Yaxing Guo wrote:
> In RISC-V IOMMU platform devices that use MSI interrupts (indicated by the
> presence of 'msi-parent' in the device tree), there are no wired interrupt
> lines, so calling platform_get_irq_count() returns 0 or -ENXIO, causing the
> driver to fail during probe.
> 
> However, MSI interrupts are allocated dynamically via the MSI subsystem and
> do not appear in the device tree 'interrupts' property. Therefore, the
> driver should not require a non-zero IRQ count when 'msi-parent' is present.
> 
> This patch fixes the bug where probe fails when using MSI interrupts
>  (which do not have an 'interrupts' property in the device tree)..
> 
> Fixes: <d5f88acdd6ff> ("iommu/riscv: Add support for platform msi")
> 
> Signed-off-by: Yaxing Guo <guoyaxing@bosc.ac.cn>
> ---
>  drivers/iommu/riscv/iommu-platform.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/riscv/iommu-platform.c b/drivers/iommu/riscv/iommu-platform.c
> index 83a28c83f991..8f15b06e8499 100644
> --- a/drivers/iommu/riscv/iommu-platform.c
> +++ b/drivers/iommu/riscv/iommu-platform.c
> @@ -68,12 +68,7 @@ static int riscv_iommu_platform_probe(struct platform_device *pdev)
>  	iommu->caps = riscv_iommu_readq(iommu, RISCV_IOMMU_REG_CAPABILITIES);
>  	iommu->fctl = riscv_iommu_readl(iommu, RISCV_IOMMU_REG_FCTL);
>  
> -	iommu->irqs_count = platform_irq_count(pdev);
> -	if (iommu->irqs_count <= 0)
> -		return dev_err_probe(dev, -ENODEV,
> -				     "no IRQ resources provided\n");
> -	if (iommu->irqs_count > RISCV_IOMMU_INTR_COUNT)
> -		iommu->irqs_count = RISCV_IOMMU_INTR_COUNT;
> +	iommu->irqs_count = RISCV_IOMMU_INTR_COUNT;
>  
>  	igs = FIELD_GET(RISCV_IOMMU_CAPABILITIES_IGS, iommu->caps);
>  	switch (igs) {
> @@ -120,6 +115,13 @@ static int riscv_iommu_platform_probe(struct platform_device *pdev)
>  		fallthrough;
>  
>  	case RISCV_IOMMU_CAPABILITIES_IGS_WSI:
> +		iommu->irqs_count = platform_irq_count(pdev);
> +		if (iommu->irqs_count <= 0)
> +			return dev_err_probe(dev, -ENODEV,
> +					     "no IRQ resources provided\n");
> +		if (iommu->irqs_count > RISCV_IOMMU_INTR_COUNT)
> +			iommu->irqs_count = RISCV_IOMMU_INTR_COUNT;
> +
>  		for (vec = 0; vec < iommu->irqs_count; vec++)
>  			iommu->irqs[vec] = platform_get_irq(pdev, vec);
>  
> -- 
> 2.34.1
>

Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>

Thanks,
drew
