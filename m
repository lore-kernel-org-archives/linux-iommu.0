Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365423B47DC
	for <iommu@lists.linux.dev>; Thu, 26 Mar 2026 14:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774536301; cv=none; b=jMV/mJTteUZVB0YhJNEYZKe1Q/6x+dZAbLbNTEXIJxBVfPTn9nlKzZl6P5xWne4gK96ApqpHA3QWSSMs/Fvh5KBENrTMyoZ+ZdDvRtnFwD1+EL3FE0iAKNI+7QES9x5YAUjNbnkPNTUQ4QdF8y90Ky4Gp0upgTub21ZNuhjDJnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774536301; c=relaxed/simple;
	bh=7tZNwGErMrOfbLpTgish7SItK2MaT/iMhodb15sRf+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UfrZqJ3eFMu4wR6CY3KouEaNktJYQpYOlGHm0knp5UgHbc90S2lyuwHi0+FN9povh9irR0f35PpujZul+H2RCc6T6fIFIcYPVtriGrSqPBsA24kAAQcfDMBpHu5WgWdBhJTqIbJW0FwwLjgHRKoQFLQa71bJYF1gd2xnieqdohY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CiXxK5JK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Xhfhzv/d; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CiXxK5JK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Xhfhzv/d"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62Q8Rtrl3957917
	for <iommu@lists.linux.dev>; Thu, 26 Mar 2026 14:44:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=uxtqX+2Sa+UgYY4ebLPGhmky
	vZPNVWpsla1fGk5MZhE=; b=CiXxK5JKF3OZ14GuzJBbr6yE4ihdaDxZi3L+BtkJ
	5bpxKgnkUa2J75IBzbac6Hq5Qg/+towG1O0Oei5EFBNZFjIC61WcIJT7aouhvVp6
	2iDSxlf2nsycoqXTYgjbCChKPYs6oAKO5eRUNIqY7BqNMyopLPEmsxGvktp29iZA
	OsIl+ayBqzKLT9BtGH2Ws+RAI9fNly23HJcvVaW1R4GjdFi0VVrl/l2FEmwKoU2p
	7d7NGoNVi7MZnbFI03tM/6riy9vgYrtDVi22wt8f0dKDkHHsvRFRBpZue80g971C
	8Yxwq0uAoZ4v2bOW6UlJ56Krl2aUl5V9NsOWrTNwz1+Txw==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d4tjajm01-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 26 Mar 2026 14:44:59 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-12776bebeb3so4666517c88.1
        for <iommu@lists.linux.dev>; Thu, 26 Mar 2026 07:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774536298; x=1775141098; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uxtqX+2Sa+UgYY4ebLPGhmkyvZPNVWpsla1fGk5MZhE=;
        b=Xhfhzv/dV1EBEwKO1SO3VRBxoWeklEim/86YE7n3dYY81xYBuwW1QuCY7lGHzs84nX
         ub2goF3x681RHI8yvoqN3Zd3sxZ1cPjNgLx5r80un2kZfMvUaBYB+HP+7qvHzCeT2XWP
         Ih/D4miLh4F9kAauC3fSasK24PfZYFxVv9nnbog7KNqm223P/NZuXGMRz1hlFm+yIymm
         iUsDNM4LJuYvBdbeu4kOTWo1BUaR1Sfa3D4qc4hkZyiHBts9oaMMRn9sqUPPKnjSQZWh
         5T6M1eQt6OApGReoYGIEdzNobxasm7on5Hr0eU05oTWI2eygP+0jEFy1rxTy8T7RGdaV
         2HIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774536298; x=1775141098;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uxtqX+2Sa+UgYY4ebLPGhmkyvZPNVWpsla1fGk5MZhE=;
        b=BSnBosGOvYspZLqN55KmDLvgJRJ3ejajZ5x1vHaJc4x1zO3il00y0JriRF0gjwIivK
         lO1aCVTdZI7KHblDwkuCGKwj12CtnpvNdQugnPWMzdhuH1PjrBFFOyPhVg9xD8i53EJC
         dIufnzfOTaMQq6tP1gnMwcqZuDiI/Z3+ljMjtYzYvSbrWsw0/gLMTejhZ8NyxW6Ep8UI
         sd19XOnLS1WxZpnNkkMWCmvlkGX2dGr9LGHtreDOK1ReXS5ljFw2cB84n35Br/RILlAx
         fyY+4qUt9u+JHwAPhq6tBGy7Oj6WPSqg2gmidgp3a824wKUx5tK8za4Wdhi78EZGUr9H
         6p5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVzzUeuIH9keR13R6aAxk4w9s0EnuE3hVt8akjWzFXVBbGDqihi/TVIKM7K0jxVYmmQXE9d2w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz1SyQ12E0ZZFQCvNVZF4QsUwWDfplxMF2NCjVkEuLESUc6VHl6
	RQZTUxjcWIudRkztLMQy0xct0iQx5nOKE9VMe7OXX1R3QuqeFKxjxQlq3K0wdu5ek5GqhrLLInP
	aEj6ZnUoyT9YYQgFWveqmvA3Zc/Jjd4n2FOrnN5mypzNvegB28esKcFoAGA==
X-Gm-Gg: ATEYQzyCvjt7oLpK7LbedIl6rwNq5VOlFMOrOn/yAKHeWZiTAPav6Qh9/RbSJTA9l+I
	1rYu8BoSgPeuENHzQhwBTSYZm00Ya2VHBMLweUVFYJsYraDIf3APN9HcZfoprGL/Y1CX601f/f3
	xsp5TAB369GZvWjSARdavemZrjgK+u5pBISYx1wTpI3vkfF2I63DpSmY0Z+ldEQod8GdesFCIAg
	cfAkGNmDa0tEkNNXlgd3UxaaRvhr9ywWR4kl2LDb4XVzpqukCJKuxL6BJheMXJu99QEoUp6F51i
	ubT6fNgukTg/k5gVxBrZLj85toRU8AncQ/6r33xzVUQjGNzMbgBwO0NuUkRkz/nzMviISg8w9Vt
	AoLD1zkN+sZ4du+NVhe4P1Y49kQVrxPU=
X-Received: by 2002:a05:7022:2394:b0:12a:6e97:c1f5 with SMTP id a92af1059eb24-12a96e54c0cmr4783459c88.14.1774536297986;
        Thu, 26 Mar 2026 07:44:57 -0700 (PDT)
X-Received: by 2002:a05:7022:2394:b0:12a:6e97:c1f5 with SMTP id a92af1059eb24-12a96e54c0cmr4783434c88.14.1774536297347;
        Thu, 26 Mar 2026 07:44:57 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c16ec2690bsm3084357eec.5.2026.03.26.07.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 07:44:57 -0700 (PDT)
Date: Thu, 26 Mar 2026 09:44:55 -0500
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Ethan Tidmore <ethantidmore06@gmail.com>
Cc: Tomasz Jeznach <tjeznach@rivosinc.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Robin Murphy <robin.murphy@arm.com>, Alexandre Ghiti <alex@ghiti.fr>,
        Yaxing Guo <guoyaxing@bosc.ac.cn>, iommu@lists.linux.dev,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/riscv: Fix signedness bug
Message-ID: <st2exabag2oomhcxuebxjuo6d4qojy6eppipzlhy5l3fhbihqo@opus37hw4x2r>
References: <20260319182644.1082740-1-ethantidmore06@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319182644.1082740-1-ethantidmore06@gmail.com>
X-Proofpoint-ORIG-GUID: SwcowCtTcbySk0vVomGhlLLIeaOLAmVy
X-Authority-Analysis: v=2.4 cv=Nr3cssdJ c=1 sm=1 tr=0 ts=69c5466b cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=cvcws7F5//HeuvjG1O1erQ==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=DlB8HGOmtVza6BL2xfcA:9 a=CjuIK1q_8ugA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-GUID: SwcowCtTcbySk0vVomGhlLLIeaOLAmVy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDEwNCBTYWx0ZWRfX90chivCTxnhv
 gbBqmp1BKMok2Iyk2PylydyiSWYyh1EdXJus1gAetMDnnEriZ43ko5RK1+c/fBI7u6doHX2NP/d
 aG1KwTPwZ7iCQswTivIbaVzw1ny+k2G2y11yEZa6IiaE/QI7f36F7S706o5LDvTkiphNcZ4Mn4X
 ExSJmWiNdiJEjc27uFEj6L6y73BAgUQ8tJEHxWpkFOg3Jb+YzSrcG9FD+r1U0xtRyhssAO54Db6
 iEOce9CQkbnlbQlz0NJipg0u1fHnu3h4P2xRFm6YyoPOP3eIKkexEak6TeylOkobQMqTP4LjMyi
 hQO9+/TWukgSa3dz0M8b/Tw1b6H1U3QKD3FlbNszqYHFG/z+ObH9WRNmwrq4AqdeUlGZQE0aIZR
 sB0JKF1yuOAmYRZA6ZYmpbU5ZnrFX4haTT8VbKTc8mi/b2FZvYzTPg1taf/3OcyGrKBEShg98cH
 Ntm8gv2dHUxI+IvDvYg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 impostorscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260104

On Thu, Mar 19, 2026 at 01:26:44PM -0500, Ethan Tidmore wrote:
> The function platform_irq_count() returns negative error codes and
> iommu->irqs_count is an unsigned integer, so the check
> (iommu->irqs_count <= 0) is always impossible.
> 
> Make the return value of platform_irq_count() be assigned to ret, check
> for error, and then assign iommu->irqs_count to ret.
> 
> Detected by Smatch:
> drivers/iommu/riscv/iommu-platform.c:119 riscv_iommu_platform_probe() warn:
> 'iommu->irqs_count' unsigned <= 0
> 
> Fixes: 7217cee35aadb ("iommu/riscv: Skip IRQ count check when using MSI interrupts")

This isn't the correct fixes tag. It should be

Fixes: 5c0ebbd3c6c6 ("iommu/riscv: Add RISC-V IOMMU platform device driver")

> Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
> ---
>  drivers/iommu/riscv/iommu-platform.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/riscv/iommu-platform.c b/drivers/iommu/riscv/iommu-platform.c
> index 8f15b06e8499..399ba8fe1b3e 100644
> --- a/drivers/iommu/riscv/iommu-platform.c
> +++ b/drivers/iommu/riscv/iommu-platform.c
> @@ -115,10 +115,13 @@ static int riscv_iommu_platform_probe(struct platform_device *pdev)
>  		fallthrough;
>  
>  	case RISCV_IOMMU_CAPABILITIES_IGS_WSI:
> -		iommu->irqs_count = platform_irq_count(pdev);
> -		if (iommu->irqs_count <= 0)
> +		ret = platform_irq_count(pdev);
> +		if (ret <= 0)
>  			return dev_err_probe(dev, -ENODEV,
>  					     "no IRQ resources provided\n");
> +
> +		iommu->irqs_count = ret;
> +
>  		if (iommu->irqs_count > RISCV_IOMMU_INTR_COUNT)
>  			iommu->irqs_count = RISCV_IOMMU_INTR_COUNT;
>  
> -- 
> 2.53.0
>

Otherwise,

Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
