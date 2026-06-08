Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493953C4B78
	for <iommu@lists.linux.dev>; Mon,  8 Jun 2026 13:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780926916; cv=none; b=UUlmX3zwDf1sOiAPLaOXl7LQEn7+ceSFNFkCwRwhx/eHatoGg5C4kj7Alev/awtSiKWZ663MQHOYYWtG2CVJ2/D3qWj93zX3aCfowUaxwR02R+Xmgz5g6G4bs03F0gZm7NBVpeY21Smtp869GT9aK1BCUhky5ph2Ph8FKgPujiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780926916; c=relaxed/simple;
	bh=DxpEN7Qq0/TPMmz8T9HJznAY2mONEoG4Yh1I+6Oy1qM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TNw79hIhr6blR9ga3iULsycvnWqsiLHXN9PoPu7vsujzi/OzoCvtfnu106FSP2MxQRL6Wvb9w2rzcPCVUOHHjseVbD9+jsYLTJCpxrPBcdnRQWiO8LnFlUZUibJgzYpkzkDOUKYtTSLF1tVD+e+Aq7Nns3j/UwFMfmQSTDAwrLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Zh7cKoXi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QJTRIHpG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Zh7cKoXi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QJTRIHpG"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658DR4S63336090
	for <iommu@lists.linux.dev>; Mon, 8 Jun 2026 13:55:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=hjuk1KpG4DK4R94Jw4NYgXvu
	SWpQTUimOywC/vaPeSw=; b=Zh7cKoXiEuMFEPo8ZkqoCcmFe398OW17QCwiCAzh
	fbA9Ab/+aHiu1NC2P4DgdzlBl/CNlt/5mx77Jjt4E4H5FS4LgPzdI/l+26Ku1Gmx
	I7AbFXxVl2oZKY4UVyNhpJz7twU6okEpevB299J7/6lj9IrIbJ9zRJLWbfwKSpUi
	Nt4guGHM4of6S3OgI60F+uXNrnds0RW+kqboQi+QdkRwVl6F3zPkVgowir7ZpyqR
	72HRymWWvVQH8Yb1V137HL4CSAa9q0TOJG8Rn7JHSNW/cRZgylE8JHR8c7HaggNJ
	o8XWpR81VvPto07HMVD6fwYr0E3ferpDDw4NM7x+Z8uI3A==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enun40yja-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 08 Jun 2026 13:55:13 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-9638fe9399dso1792958241.3
        for <iommu@lists.linux.dev>; Mon, 08 Jun 2026 06:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780926912; x=1781531712; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hjuk1KpG4DK4R94Jw4NYgXvuSWpQTUimOywC/vaPeSw=;
        b=QJTRIHpGnoWCkTsA2SAvXD3rdIEWorIc8aQ9EPrViXuQQyAJXuW0kDPkOXg6GAvnCT
         vIrEXL8wGzZ2NDXlYSgb3W3auOrgfH3gsmqWcCEkT2dsoIAZMoOIw1j4hGAoAnuRfPUk
         nPcr+OqxQNd2aPAg0DqAunxdCLZMyYnlC19sDDLTm4DxY0LD2zal7EKYH1C994lM+bWC
         4bmpPiKvdj71TiMfU2wVRPpFyl3SbvB2M3GLVcfF4iwRxk6YX1f7csd6EPXCHvisWM5h
         CL9qo+yE7jInRXJUOvFywAScVByTjtC9Ftwf8BSZx7+kk0yL3Wp1nF1MCS/NnBBEfWET
         i18g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780926912; x=1781531712;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hjuk1KpG4DK4R94Jw4NYgXvuSWpQTUimOywC/vaPeSw=;
        b=fpNWsdmxdYVPzJq+PIRVgLaoNKXod3FsmCeNjaxwrlBnj7eWSFd3aKym3MgE6b8aeI
         Do5mwXvE97uN2jlphFr+1wjJY6+dsmKsLNg9ReBmfOnjd0WHPpZhQIMMJW0tKw/8DPkl
         v83fbDzqhfyjDemgHgZExN4RBRr3SI6LV2A4U9gKhmyyynx7v3MkL0MiLlNpnqB9RpZK
         rM+ULwLFYevnK86UzM452AyA3oSfskeJeh0wvJtQkJVsLv8SLB/PoDIknK7TUdznCfLa
         8wMhumvAc0rwsvyFjILgkUPazJTEBQ6FWU46ezspywQHQvZGkzlrJDoJwt/5OFYyffhF
         E25w==
X-Forwarded-Encrypted: i=1; AFNElJ9MRsSSexo1JH9bMaeXIqjGypZFKnFDBrny/bsAwlf191mBjCFGMo2LtT6lL+CW5ZqDU6BjEQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzHs9z2ZlB5RtlQ1iaZeWe+35UwcPX4nXU5Woc4atjef08+Yrfv
	BKxdtK51zHTXlkC64N0ghJvMlL/TyhPUze61xVp/6JP7O4BCKKUSCnrZDDKo2lCa2XqgJ4LXvbS
	2oFytda8fYUMP/xUvtLfe1OluSl6fXIRGHJUZEMnBeIAbODmEkPSKrarPZQ==
X-Gm-Gg: Acq92OGOUY0TL7HJte5T2pOmvl/bFy4JbZB36GGKjl+HoKnyWxq7ytBp/ZopVIMQMaz
	neOGncCrUZKizKP92maG9Cipxo5Cba4raFhOvAUnnl7HGtn4569eSSlyM4jrbuImhQ5VZeRfoWg
	dsvmj5O1QSlOmtikjrmXFNwAXvP578CYCnsEXBrXFgl3Ju6TLnhHq02PwfGsdcMU4b9F5zCHyj6
	+6218h4pOFH62N+2uhPX8rpc/d0g4VwPDiJbsDz94EXSwXFgiY+Ze1a/3mNxpqsM9Yl5hmHd9nV
	135q4M5FCBkyCugrsMR0rUYetS1rnbfu/zfFzkY+k5t3Bifv69e/00qtTl08CIhm/aFxYuwd95x
	D5uzltEz11Dn3YKElmnzqUrW8/t16RxNFvuaSvOg+lZChGD6LOhOMpuysf2Txo06l/tbiJAHTq+
	QgfgI+q4W7jCSRC1NWgTaDRhloJag7ohRBAGCJ5QhgtrORNg==
X-Received: by 2002:a05:6102:32d5:b0:633:1b2e:e574 with SMTP id ada2fe7eead31-6ff0300f0b8mr6715655137.29.1780926912476;
        Mon, 08 Jun 2026 06:55:12 -0700 (PDT)
X-Received: by 2002:a05:6102:32d5:b0:633:1b2e:e574 with SMTP id ada2fe7eead31-6ff0300f0b8mr6715640137.29.1780926911952;
        Mon, 08 Jun 2026 06:55:11 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-396ac2be29fsm45071611fa.21.2026.06.08.06.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 06:55:10 -0700 (PDT)
Date: Mon, 8 Jun 2026 16:55:09 +0300
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
Subject: Re: [PATCH v2 2/6] iommu/arm-smmu: Add interconnect bandwidth voting
 support
Message-ID: <7xfxlxfqjcqdzl6gckaoyy2ioefglc7bgi66yv5khrbl6fi2zc@ivtiukdaj4jv>
References: <20260526-smmu_interconnect_addition-v2-0-2a6d8ca30d63@oss.qualcomm.com>
 <20260526-smmu_interconnect_addition-v2-2-2a6d8ca30d63@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526-smmu_interconnect_addition-v2-2-2a6d8ca30d63@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEzMiBTYWx0ZWRfX/J3NzjbJHcGN
 53jDchJPNaJ8wYacKodRSV6OSZtNk0TyhMkhUIB3oxPbyDZe8SagSHsvISH9Wpti7b/kRMGUYBl
 3SJC4mDYvMzw2fEkvGcToAMsVxFFgE3vrZtMGcCB7mWxVbvCM7LADOrFY0copK1RqmVufHAEiEH
 y3oPc+BDKXzS2qzuZhdYPG6uAQfdD1rwVZVUVW2V79eEmkUw4gFEo8zGo44UCFijXfXv9Y1dCbW
 xjAdAinwH0/BQxgKhYv4IV5h66Yxw25DKItL8+pL3NXde4NVAxn3UjfD0iU8yu12WcoXBDC9NCg
 +9Kg+N6RxNRYMNGcELkvaQMKI+kKoOGaA+KlE75mHg5f3pdI2Px/U50zGu3ewshcp2+gvtH7y90
 qaDhdtYSWepRQ61qZlryl7F5V/irJ6sto5gAqVOGN2ba3hpV5v2eGi1lFq2hsIAXdSTXquDbhpd
 wOyfku3CeL4xLWVEHgg==
X-Proofpoint-ORIG-GUID: W2F6z0usJVgD4Ai4EoANTHtwykZJI6C3
X-Authority-Analysis: v=2.4 cv=ZY4t8MVA c=1 sm=1 tr=0 ts=6a26c9c1 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=6LyoA_EE4LLIN3d-eQgA:9 a=CjuIK1q_8ugA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-GUID: W2F6z0usJVgD4Ai4EoANTHtwykZJI6C3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080132

On Tue, May 26, 2026 at 08:12:03PM +0530, Bibek Kumar Patro wrote:
> On some SoCs the SMMU registers require an active interconnect
> bandwidth vote to be accessible. While other clients typically
> satisfy this requirement implicitly, certain corner cases (e.g.
> during sleep/wakeup transitions) can leave the SMMU without a
> vote, causing intermittent register access failures.
> 
> Add support for an optional interconnect path to the arm-smmu
> driver and vote for bandwidth while the SMMU is active. The path
> is acquired from DT if present and ignored otherwise.
> 
> The bandwidth vote is enabled before accessing SMMU registers
> during probe and runtime resume, and released during runtime
> suspend and on error paths.
> 
> Generally, from an architectural perspective, GEM_NOC and DDR are
> expected to have an active vote whenever the adreno_smmu block is
> powered on. In most common use cases, this requirement is implicitly
> satisfied because other GPU-related clients (for example, the GMU
> device) already hold a GEM_NOC vote when adreno_smmu is enabled.
> 
> However, there are certain corner cases, such as during sleep/wakeup
> transitions, where the GEM_NOC vote can be removed before adreno_smmu
> is powered down. If adreno_smmu is then accessed while the interconnect
> vote is missing, it can lead to the observed failures. Because of the
> precise ordering involved, this scenario is difficult to reproduce
> consistently.
> (also GDSC is involved in adreno usecases can have an independent vote)
> 
> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu.c | 57 +++++++++++++++++++++++++++++++++--
>  drivers/iommu/arm/arm-smmu/arm-smmu.h |  2 ++
>  2 files changed, 57 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index 0bd21d206eb3e75c3b9fb1364cdc92e82c5aa499..07c7e44ec6a5bd1488f00f87d859a20495e46601 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -53,6 +53,11 @@
>  #define MSI_IOVA_BASE			0x8000000
>  #define MSI_IOVA_LENGTH			0x100000
>  
> +/* Interconnect bandwidth vote values for the SMMU register access path */
> +#define ARM_SMMU_ICC_AVG_BW		0
> +#define ARM_SMMU_ICC_PEAK_BW_HIGH	1000

totally random numbers, which might be different for non-Qualcomm platform.

> +#define ARM_SMMU_ICC_PEAK_BW_LOW	0
> +
>  static int force_stage;
>  module_param(force_stage, int, S_IRUGO);
>  MODULE_PARM_DESC(force_stage,
> @@ -86,6 +91,36 @@ static inline void arm_smmu_rpm_put(struct arm_smmu_device *smmu)
>  	}
>  }
>  
> +static int arm_smmu_icc_get(struct arm_smmu_device *smmu)
> +{
> +	smmu->icc_path = devm_of_icc_get(smmu->dev, NULL);

Is there always only one bus / path in question?

> +	if (IS_ERR(smmu->icc_path)) {

if (!IS_ERR(smmu->icc_path))
	return 0;

int err = PTR_ERR();
if (err == -ENODEV) {
	icc_path = NULL;
	return 0;
}

return dev_err_probe();


> +		int err = PTR_ERR(smmu->icc_path);
> +
> +		if (err == -ENODEV) {
> +			smmu->icc_path = NULL;
> +			return 0;
> +		}
> +		return dev_err_probe(smmu->dev, err,
> +				     "failed to get interconnect path\n");
> +	}
> +	return 0;
> +}
> +
> +static void arm_smmu_icc_enable(struct arm_smmu_device *smmu)
> +{
> +	if (smmu->icc_path)

Drop the if.

> +		WARN_ON(icc_set_bw(smmu->icc_path, ARM_SMMU_ICC_AVG_BW,
> +				   ARM_SMMU_ICC_PEAK_BW_HIGH));

WARN_ON_ONCE()?

Pass the error to the caller.


> +}
> +
> +static void arm_smmu_icc_disable(struct arm_smmu_device *smmu)
> +{
> +	if (smmu->icc_path)

Drop the if.

> +		WARN_ON(icc_set_bw(smmu->icc_path, ARM_SMMU_ICC_AVG_BW,
> +				   ARM_SMMU_ICC_PEAK_BW_LOW));

Pass the error to the caller.

> +}
> +
>  static void arm_smmu_rpm_use_autosuspend(struct arm_smmu_device *smmu)
>  {
>  	/*
> @@ -2189,6 +2224,17 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>  	if (err)
>  		return err;
>  
> +	/*
> +	 * Acquire and vote the interconnect path before accessing any SMMU
> +	 * registers (including ARM_SMMU_GR0_ID0 in arm_smmu_device_cfg_probe).
> +	 */
> +	err = arm_smmu_icc_get(smmu);
> +	if (err) {
> +		clk_bulk_disable_unprepare(smmu->num_clks, smmu->clks);
> +		return err;
> +	}
> +	arm_smmu_icc_enable(smmu);

Handle the error.

> +
>  	err = arm_smmu_device_cfg_probe(smmu);
>  	if (err)
>  		return err;
> @@ -2273,8 +2319,10 @@ static void arm_smmu_device_shutdown(struct platform_device *pdev)
>  
>  	if (pm_runtime_enabled(smmu->dev))
>  		pm_runtime_force_suspend(smmu->dev);
> -	else
> +	else {
>  		clk_bulk_disable(smmu->num_clks, smmu->clks);
> +		arm_smmu_icc_disable(smmu);

Handle the error.

etc.

> +	}
>  
>  	clk_bulk_unprepare(smmu->num_clks, smmu->clks);
>  }

-- 
With best wishes
Dmitry
