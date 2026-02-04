Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D954348479
	for <iommu@lists.linux.dev>; Wed,  4 Feb 2026 17:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770225608; cv=none; b=n5JVgAj33NFhjOfUFLQqWcMgCQcw5pQFKBTJUE63unYCZ3cEg78lFViksbaD9OvCq4mbVU7TUwj0nbrHqnBz9cfJS27tIREj0NuBqkbl7DZz6jVzN6Fz8Lx7HP8YE1+pNsmhC5C8uNBaBF2g2cw2en7hOFpCEWVDHQEv1EEi2sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770225608; c=relaxed/simple;
	bh=EMpRL583vOWVeU4W0hEVRiaRUtKRmUWLFzWTRy4Ou08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFARDeB0wMzFOhu2n/dAPw9uwUMr1Uy3xT6eoz5K/9D7L4NWzMkcXnM1w4X3wLEUa36NDw4btdikd5X1MptUq3k5+gVxUVJnZxl97Q1sh+Rpn5wePxp8mxtDKD8ldEV/T2UnXxr0l5kKVsbef7f5XNPl/sxlllV/LTUBCyVWPxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RFXJtpQs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bkIB9U2L; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RFXJtpQs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bkIB9U2L"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 614CIaYT200240
	for <iommu@lists.linux.dev>; Wed, 4 Feb 2026 17:20:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=VqbAWXuLedjCbn8BYtmfIasp
	H5UsLnVKguhalwtG8iU=; b=RFXJtpQsyEAGCCdZN+tDGI9L+WnvNuqSXFUPk8L9
	lcAV8QvF1PnH9HeHklAPrbDeLaVkFNPfY8c3UgGUI4EC0yeA03RXXmCLgORfy3hL
	KVcJ1zFrs5V+FeyD/jJZtLCaSnblXlrD/e2iMwaTWQ6/lZmbkG2kbAbSB/OchxCI
	rAwqTIFgW1q162Z0LnS9X+2XxBK6yJHYZIqcYsrFbSulI6tRip2YEyjIv508+M/C
	rSXjno9CW8ddAYdTBezoBmT2oNQlpPOMcuxD5OZGgKECkqFnWF3VdjpbrdiIBtQ6
	Hd2zFwgYsoabBkf4R4ISsr6e6dIDNZ41PO5UT6mM/Ohciw==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c3yp5a75h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 04 Feb 2026 17:20:07 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-124ac76ea5bso849607c88.0
        for <iommu@lists.linux.dev>; Wed, 04 Feb 2026 09:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770225606; x=1770830406; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VqbAWXuLedjCbn8BYtmfIaspH5UsLnVKguhalwtG8iU=;
        b=bkIB9U2L6cQFvNOx81nh6v5YpJWOiOHDwVkRyze0rzvnvbEWc6GejHF7sITxugCNWm
         Ra1PQrSBadeL7yqgHIp7bhooitFvb6Vd/TMwCFEuVFFvPhzBuzjbSyEn59e6dHwluoIt
         HLH3wxEDt5RGk04q5/1PRNhN3JUec6zlo7Br6x0aisTPVENtbdNBbrKmmnn2pOsPueu8
         eQuo0Mr1VkjNp+cP+5DZY4cfB00Q+JdHiiYCuYSrMvzMbImNWemPf2FBdGTDJS9sfV1M
         PPkznz4H7ydjN3k5ZBAL1p53DTdebIPj4Cb91CBYEc+VKrBhLnwA/5bgIuTjHBfeUebG
         PctQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770225606; x=1770830406;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VqbAWXuLedjCbn8BYtmfIaspH5UsLnVKguhalwtG8iU=;
        b=mXRZnWjK6ufqwzQVZAqq89/F4CvKVW/X8bs73OaOidlyw2ykp6pNQXEvgK4bUESRnk
         AvZeUJjq//1lxuURfbggFXjL00/19d4kp35ztc4kEiOLaFoWzljNZiwY21UiApLiEWdx
         reCdQ1ZMKmsmxajuN2W/14MJhzkcGtbH6RdMOGjq6ytRrNuLZnQI4OH2Clx0KGPnxhKI
         KDGqubWGs+naPOyjDYZ6ckfsqGD/m4ZxEsmaGwuUUOb6VNPakN2aeiBwoaNPGhfwaQxQ
         zdkhyyJWQCv17nvN89QL9kvDa7aGYmZcOsBwyuBAZgRwq7an2GZ1Syqa383rr/TKHxDE
         PTJA==
X-Forwarded-Encrypted: i=1; AJvYcCWSSwaUpXCVXP3/rLazSKqiZX7tY0V+dt4Q3Kk0yiabaDUVmq6ECyHzQz8HIDw6gsX40NH3rw==@lists.linux.dev
X-Gm-Message-State: AOJu0YybSGB2Ht28w+5ZyPedWG1RdIQZR9wxPN+Gl8lTFWXirvB9xBdy
	atrDL4JdP/1MvQoQaZHuzeQAphFC8j9XqCuaAmZrPMyJGPnYeQm6rURGMyfHkEfDTnzu7eeotPo
	As2Hm0738U1i7+1kHg4RIczS1wXoSVNNLqZ/TbODxbwVGBtYTaZ+0K5yQhg==
X-Gm-Gg: AZuq6aLLmDv0XHMNZDWMnDP2XXKbl1HD/NioRmBEH1fgVuenCb+a1shUZgE8Db7tUrG
	0C0AzqNjGwYiCb2Wrsb9591LqJGtfNm/crVLwTm5TeAaYWThN5DylRdTitcD+IK3AkXnjXhS9q/
	8HBOzbxzSDxbeD2jpFAj220C8zVcHWS4BB/wMJyXfAYkMSK81qnncyLqDgM5/EcwAu9FZTp4KNX
	YSqJLZgvdyBrQ8IzQ4UjbYcMCN9825BhnGH9Fwez3Z61AVJun0wAGRlSKEHyXGjV+1UzqwL4W+j
	QUX58jm3WzFXut5P54NYqKKFnDWBZ9BvrtPyab0pqdjFp3rjULwqMpGzHL+eut/he8nHKaghai5
	uscMdk5uMs9ZCUALXrNY=
X-Received: by 2002:a05:7022:69a2:b0:119:e569:fb96 with SMTP id a92af1059eb24-126f4771f0amr1691818c88.5.1770225606321;
        Wed, 04 Feb 2026 09:20:06 -0800 (PST)
X-Received: by 2002:a05:7022:69a2:b0:119:e569:fb96 with SMTP id a92af1059eb24-126f4771f0amr1691793c88.5.1770225605519;
        Wed, 04 Feb 2026 09:20:05 -0800 (PST)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-126f4e107b4sm2433926c88.7.2026.02.04.09.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 09:20:05 -0800 (PST)
Date: Wed, 4 Feb 2026 11:20:03 -0600
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Lv Zheng <lv.zheng@linux.spacemit.com>
Cc: Tomasz Jeznach <tjeznach@rivosinc.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>, Jingyu Li <joey.li@spacemit.com>,
        Zhijian Chen <zhijian@spacemit.com>, iommu@lists.linux.dev,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        spacemit@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/8] iommu/riscv: Fix WSI mode IRQ number handling
Message-ID: <2ueryrki7uzpjn6rbqz7scy46sjhw76jjilddz2naslz3eyfdp@ycwf42eaw5yy>
References: <cover.1769562575.git.lv.zheng@spacemit.com>
 <cover.1770195980.git.lv.zheng@linux.spacemit.com>
 <F77F878EF7C59BD3+a9078997d97dacd05d1271a5390dfd08a402b325.1770195980.git.lv.zheng@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F77F878EF7C59BD3+a9078997d97dacd05d1271a5390dfd08a402b325.1770195980.git.lv.zheng@linux.spacemit.com>
X-Proofpoint-ORIG-GUID: 0HxEXCz6E1yL270NpB0HyC0n1OpPxA9I
X-Authority-Analysis: v=2.4 cv=cquWUl4i c=1 sm=1 tr=0 ts=69837fc7 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=cvcws7F5//HeuvjG1O1erQ==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=lv0vYI88AAAA:8 a=vzWCA-T3srDMkzUxSWUA:9
 a=CjuIK1q_8ugA:10 a=vBUdepa8ALXHeOFLBtFW:22 a=9qqun4PRrEabIEPCFt1_:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDEzMiBTYWx0ZWRfXza5TM4O12YFg
 oFIMGNCQjqhtpwwHPND3JSB2dA7pUW2QspwpWShaPJczcl2Dr2k29zcCbAfAyg7aeN3ymro0pM9
 iKanEmq59tRgSbm2SKdMhsYE5VVdnRhQsHc9WDy30TXUaHOZjFl2roGg4sqGlfdJSr9ExciDOqU
 AtW89NiH1GKrI9ZsOHICYrhcYDwn30cFA+1hTpFcchCDur3PURRyesLP5j3Vu84Vnrv2S6SVpqN
 uoMIXbkDdKLV79vdkdTcsUDbUbrUjL3Lmi5rGOc502IZ1nkH3TydBC9xOEBCzo70dSI12qdK8K4
 bToFAiCEdqqQFcGYoCUjjisFdBOGr3FK2UcTaUy63MyMeF44AJl4AIgVwCrXr+mb50/kqJl8Skc
 TP1IZJgCi4VvhWDpTTO0gek92ZxFhGN5uurPE8OjKfQiS6EUJcOga5q5TzX1JQV/xf6FMPZfnSJ
 IBXnYyHYv9b5Us1bugg==
X-Proofpoint-GUID: 0HxEXCz6E1yL270NpB0HyC0n1OpPxA9I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_06,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 clxscore=1015 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602040132

On Wed, Feb 04, 2026 at 05:08:52PM +0800, Lv Zheng wrote:
> From: Jingyu Li <joey.li@spacemit.com>
> 
> In WSI mode, ICVEC doesn't exist, thus reading it returns 0, which
> causes IOMMU driver to fail to find IRQ numbers from device tree
> IRQ arrary. The issue is fixed by applying icvec indexes of WSI IRQs.

ICVEC always exists, however it may be hardwired to zero when an
implementation only supports a single vector. But, that has nothing
to do with whether wired interrupts or MSIs are used.

If ICVEC on this IOMMU is always reading as zero, even when 0xf is
written to it first, then it should be interpreted as there only
being a single vector (or that the IOMMU's ICVEC is broken, if the
number of sources is known to be more).

> 
> Signed-off-by: Jingyu Li <joey.li@spacemit.com>
> Signed-off-by: Lv Zheng <lv.zheng@linux.spacemit.com>
> ---
>  drivers/iommu/riscv/iommu.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index d9429097a2b5..26630979473b 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -1593,11 +1593,26 @@ static int riscv_iommu_init_check(struct riscv_iommu_device *iommu)
>  		       FIELD_PREP(RISCV_IOMMU_ICVEC_PMIV, 3 % iommu->irqs_count);
>  	riscv_iommu_writeq(iommu, RISCV_IOMMU_REG_ICVEC, iommu->icvec);
>  	iommu->icvec = riscv_iommu_readq(iommu, RISCV_IOMMU_REG_ICVEC);
> -	if (max(max(FIELD_GET(RISCV_IOMMU_ICVEC_CIV, iommu->icvec),
> -		    FIELD_GET(RISCV_IOMMU_ICVEC_FIV, iommu->icvec)),
> -		max(FIELD_GET(RISCV_IOMMU_ICVEC_PIV, iommu->icvec),
> -		    FIELD_GET(RISCV_IOMMU_ICVEC_PMIV, iommu->icvec))) >= iommu->irqs_count)
> -		return -EINVAL;
> +	/*
> +	 * In WSI mode, ICVEC may read as zero. Only validate if using MSI.
> +	 * Check if FCTL.WSI is set to determine interrupt mode.
> +	 */
> +	if (!(iommu->fctl & RISCV_IOMMU_FCTL_WSI)) {

The behavior of ICVEC does not depend on FCTL.WSI

> +		if (max(max(FIELD_GET(RISCV_IOMMU_ICVEC_CIV, iommu->icvec),
> +			    FIELD_GET(RISCV_IOMMU_ICVEC_FIV, iommu->icvec)),
> +			max(FIELD_GET(RISCV_IOMMU_ICVEC_PIV, iommu->icvec),
> +			    FIELD_GET(RISCV_IOMMU_ICVEC_PMIV, iommu->icvec))) >= iommu->irqs_count)
> +			return -EINVAL;
> +	} else {
> +		/*
> +		 * WSI mode: ICVEC is not used. Set to identity mapping for
> +		 * riscv_iommu_queue_vec() to work correctly.
> +		 */
> +		iommu->icvec = FIELD_PREP(RISCV_IOMMU_ICVEC_CIV, 0) |
> +			       FIELD_PREP(RISCV_IOMMU_ICVEC_FIV, 1) |
> +			       FIELD_PREP(RISCV_IOMMU_ICVEC_PIV, 2) |
> +			       FIELD_PREP(RISCV_IOMMU_ICVEC_PMIV, 3);

It's certainly not correct to set iommu->icvec to anything that can't be
written to the IOMMU's WARL ICVEC fields and read back again.

Thanks,
drew
