Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD37E3C198D
	for <iommu@lists.linux.dev>; Mon,  8 Jun 2026 13:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780926648; cv=none; b=KikdM5e12FdTOjdGxyphY1ahhkeWjqAFTrxLHhGl1cOd2PZk8ZMAvtTMF2pnbbLFyyQD/R9kPg6BoU8X7fG+plTTclNdMZ5zQ4VVqDsNqYRasEwWNKYXqRVUihQC2GXbVtMF76SAEj+o+axHJh2wDw30DRkKk4Clbot6dRYTVng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780926648; c=relaxed/simple;
	bh=GQZZ6qdQz5fA+bwrpkuSQu6zpYvLdcO3MGlrQ5xFR78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dozdRJeo6OZ9c48QFFoGZj1VrhGdnR8iaXox9VxpayF0yjIlaliClBkmWSu1gMgaY6wooHV72neOP4kQlmZNff1gM64RZz1t1vZhPdly72Q3tzZyTrG2z605/N3yzusgGICrmjh41Bs5VLqTlBKIblX8Mpgt6N4wY2aeVVG740U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i2qhAemj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NPw7iiHI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i2qhAemj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NPw7iiHI"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658DRT0N3682895
	for <iommu@lists.linux.dev>; Mon, 8 Jun 2026 13:50:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=cNnrFzM56GPx5J4+UEj8Qmmk
	dW/VSFOOyJZ8mOuFa/A=; b=i2qhAemjb10Ek3piQZv/D7JanNvtT9Y0eVk/grdV
	mi+rXCZcEZkSCtzhsFjeJ96cXCIIYR4b0rsP4pP+e8tqD9h1mSVli5DiRBrjLkly
	DAF8g9AyVWvSWDs46Ema/G8l9dI8ZZA+VQkFlSw//hJTG5mXHLRSuw2sVs55Ar27
	LHPTuYgfWUxXc9MMylJfRAjQQetNTIR9em6n1Zlfz+fGZ8P2c+ZRis7wl4PpP423
	6NZPIMKe4q1pMMQ8m23u1ZYTCTU2cQS9aBSMUlZ6AXomUGOEByyBAD83HzBVX0xy
	ETYyG8M7dbvmoYixs4WPBaRfAicH1/r7FP+nRjENsvGWRg==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enx2rraj7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 08 Jun 2026 13:50:43 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-963b4e8cf8cso6318713241.1
        for <iommu@lists.linux.dev>; Mon, 08 Jun 2026 06:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780926643; x=1781531443; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cNnrFzM56GPx5J4+UEj8QmmkdW/VSFOOyJZ8mOuFa/A=;
        b=NPw7iiHIAdFwiHlBKczmuZRf+oYftgoC8ld7JOibxOsZJijSYaxIU3woGCS+6DP1F9
         BoyyDdxUNxc1hEujX6UbNxwcfo+ia16R+E4baGtT7xjR7vq4L+4NlfMC5315ooDwN4bf
         tRxGxkqutAmWwaqYGGrpimsNyHftwJs+MV4E5OWr+PCzl5ruL2YZce3Pu9KuBHMI5E44
         gvlTZvJ5QUHb1We6Ly4Squxa/smj3hXb8oWGwIQRoNOyflJpPZhq8pma9wyKXhPq0Aqz
         a4pmymZxWu55DAXj5aNIQMSV0iPJSiBzjovY1VBlTlYtL/2YtH4KpK2XyEdb7dZ/zi5q
         93sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780926643; x=1781531443;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cNnrFzM56GPx5J4+UEj8QmmkdW/VSFOOyJZ8mOuFa/A=;
        b=OJT8G09PuWDmxvnRK1PKw3P5VU1c8CvAbXCUUAY0j9LgXQC5c5knMzZaMb5PS8Z9Sw
         u8wHMg0Lkt1lCQKaR1yyO87V1Uf31iaKHG1i/yqrBC3cQPs0VG9ER2pcWc/A3a86fXrL
         w95l4aRFhO1TFZvqKFS4pduI15dM8tYoIKE0A9L9b+1u2R/p54epXHdhjEqWj0OdLg4P
         +jBsp0/3DKdlObjZIT2hLxa/nqR6UvjhfR12dcv7jfBlDkIIHvtpfKeaEJY9YIvlUkc3
         czwL7yprIRrKKOETepd3TNbD46CgFRxKCgTDg970hyZfezOV0enyYKjwN+nfkJWGgRFL
         wx1g==
X-Forwarded-Encrypted: i=1; AFNElJ/R9TT9Biul4FyrwxsqIpVewdOitqpakkbfVhgHO0+eF437N+3sMYZ7VMNrruxhaERDlYVPHw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxqgA2E/cqH/GNaXYzXZ80/fPcY9VBvZBQTNQY4VLLMYWnmutO8
	+Bs/jRHpXOmmnmIcIHiT7q18PYT4VZQ9rEARah+twLUhjWRoRYr4U23KgERqOKXOqIP9s17UddY
	N8fjjanK3UPkW837i59e+LSV+WW7nZLGRHUeLxxsCjkqAj7cD14K9Pu02FA==
X-Gm-Gg: Acq92OGxRarIWfLhlg0bgpmwyk85kgVRp0gz5kWKoRTukAxAnWyHJdkJwL0Bj+WFFNx
	+3ayYdukR3oBA5kosF+yepLsRWO6eWxNTqDkrzXrvojak29PblEPF7hNuBIyCyp1/Qmcfkv8N8m
	CaLlkgb4kSHH2+xi31usWyTLl78v6AQG++Mle/vjjkVks3FNf23G6/UpmV4RLUnmCw0UUPUk9o8
	JnPwSywWD2stEgS5vGYXSzq+6lsop19+v9r3Gt8IQXwKihlsDg23z/ZLg28Y8G7oaO7/7alVcul
	ARniSrsBrXsCKUJ85WxbM7eQmm98MU/jn4dkaGzOETYVD8bEGKdAlNhpUukQ6fpWred9Uok78s3
	KtNMCsO/bpIKvvsl6BZVvNDOgSmI+SF5QRDK2J7I7QbcI4IorXV4O5shOA9SrpRyYX/5lMvomZZ
	WOzuDC+UuHmBwszO4ojDop4bhWU33/HEn6EcRtYUQ6vfThEg==
X-Received: by 2002:a67:fb92:0:b0:6d2:1633:1803 with SMTP id ada2fe7eead31-700392f5baemr3677224137.19.1780926642689;
        Mon, 08 Jun 2026 06:50:42 -0700 (PDT)
X-Received: by 2002:a67:fb92:0:b0:6d2:1633:1803 with SMTP id ada2fe7eead31-700392f5baemr3677206137.19.1780926642269;
        Mon, 08 Jun 2026 06:50:42 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b90421dsm3827701e87.30.2026.06.08.06.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 06:50:41 -0700 (PDT)
Date: Mon, 8 Jun 2026 16:50:39 +0300
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
Message-ID: <bkve3vmokuyrn4agsqyzxlqr5wuy5y6urnliqypac3h6lb32hy@tfkjstevqv2y>
References: <20260526-smmu_interconnect_addition-v2-0-2a6d8ca30d63@oss.qualcomm.com>
 <20260526-smmu_interconnect_addition-v2-2-2a6d8ca30d63@oss.qualcomm.com>
 <68aa9591-49e0-4cb7-9a5b-36405efe7094@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68aa9591-49e0-4cb7-9a5b-36405efe7094@oss.qualcomm.com>
X-Proofpoint-GUID: y1s5HeoJjSWjFoP0Ff6kxrHnzQUT-d1Z
X-Proofpoint-ORIG-GUID: y1s5HeoJjSWjFoP0Ff6kxrHnzQUT-d1Z
X-Authority-Analysis: v=2.4 cv=JdqMa0KV c=1 sm=1 tr=0 ts=6a26c8b3 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=NEAV23lmAAAA:8
 a=dk3LCUOL6mBsUDzKOqAA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=CjuIK1q_8ugA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEzMSBTYWx0ZWRfX+IyIX8KC5kcV
 RAhBgoVfjK/5T2yE6oYsgPxolX46oDPSXRo/Q2jdgqZmAW1irQNoTEwlDGZtX0efQO2X3vXXWCA
 Fc3tkrJq4FhMwlTOKY4ibiSqR8ucwcedLh6HU26n1mMq1w6n2H920pJNF93gdXDdYsiztCUiUGv
 +E+O2F+iBPQk0rGIzc8+kYpF73396K9a0cY8DJoKzIb+E3fKzy8dTsnD8Mlq+vkpti8MqX7pQ3d
 H9dPDXANWg+s3bYQLeiRbLgJwpVg9xwWxaxh05/fUR3IMl0JeIegMJt9/Vuu1E1O8Yn76l0pdV6
 onD0MAuRmz4jVjMOK+I1PW+ByjcEzwZZBsPvweDJ8QRIePYh28mqvy3+oVz6k/dxQQ6/KxQDQwo
 mwc6G5jUhZOWiPaaV2VTUhU4+YX43lhIVP84+9ZoeO8dlNEt5kleWlKsCMxBEHLwgO62oZL+itt
 zJ/7WieX5oCyAmCs+cA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080131

On Mon, Jun 08, 2026 at 06:59:34PM +0530, Bibek Kumar Patro wrote:
> 
> ...
> 
> > ---
> >   drivers/iommu/arm/arm-smmu/arm-smmu.c | 57 +++++++++++++++++++++++++++++++++--
> >   drivers/iommu/arm/arm-smmu/arm-smmu.h |  2 ++
> >   2 files changed, 57 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > index 0bd21d206eb3e75c3b9fb1364cdc92e82c5aa499..07c7e44ec6a5bd1488f00f87d859a20495e46601 100644
> > --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > @@ -53,6 +53,11 @@
> >   #define MSI_IOVA_BASE			0x8000000
> >   #define MSI_IOVA_LENGTH			0x100000
> > +/* Interconnect bandwidth vote values for the SMMU register access path */
> > +#define ARM_SMMU_ICC_AVG_BW		0
> > +#define ARM_SMMU_ICC_PEAK_BW_HIGH	1000
> > +#define ARM_SMMU_ICC_PEAK_BW_LOW	0
> > +
> >   static int force_stage;
> >   module_param(force_stage, int, S_IRUGO);
> >   MODULE_PARM_DESC(force_stage,
> > @@ -86,6 +91,36 @@ static inline void arm_smmu_rpm_put(struct arm_smmu_device *smmu)
> >   	}
> >   }
> > +static int arm_smmu_icc_get(struct arm_smmu_device *smmu)
> > +{
> > +	smmu->icc_path = devm_of_icc_get(smmu->dev, NULL);
> > +	if (IS_ERR(smmu->icc_path)) {
> > +		int err = PTR_ERR(smmu->icc_path);
> > +
> > +		if (err == -ENODEV) {
> > +			smmu->icc_path = NULL;
> > +			return 0;
> > +		}
> > +		return dev_err_probe(smmu->dev, err,
> > +				     "failed to get interconnect path\n");
> > +	}
> > +	return 0;
> > +}
> > +
> > +static void arm_smmu_icc_enable(struct arm_smmu_device *smmu)
> > +{
> > +	if (smmu->icc_path)
> > +		WARN_ON(icc_set_bw(smmu->icc_path, ARM_SMMU_ICC_AVG_BW,
> > +				   ARM_SMMU_ICC_PEAK_BW_HIGH));
> > +}
> > +
> > +static void arm_smmu_icc_disable(struct arm_smmu_device *smmu)
> > +{
> > +	if (smmu->icc_path)
> > +		WARN_ON(icc_set_bw(smmu->icc_path, ARM_SMMU_ICC_AVG_BW,
> > +				   ARM_SMMU_ICC_PEAK_BW_LOW));
> > +}
> > +
> >   static void arm_smmu_rpm_use_autosuspend(struct arm_smmu_device *smmu)
> >   {
> >   	/*
> > @@ -2189,6 +2224,17 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
> >   	if (err)
> >   		return err;
> > +	/*
> > +	 * Acquire and vote the interconnect path before accessing any SMMU
> > +	 * registers (including ARM_SMMU_GR0_ID0 in arm_smmu_device_cfg_probe).
> > +	 */
> > +	err = arm_smmu_icc_get(smmu);
> > +	if (err) {
> > +		clk_bulk_disable_unprepare(smmu->num_clks, smmu->clks);
> > +		return err;
> > +	}
> > +	arm_smmu_icc_enable(smmu);
> > +
> >   	err = arm_smmu_device_cfg_probe(smmu);
> >   	if (err)
> >   		return err;
> > @@ -2273,8 +2319,10 @@ static void arm_smmu_device_shutdown(struct platform_device *pdev)
> >   	if (pm_runtime_enabled(smmu->dev))
> >   		pm_runtime_force_suspend(smmu->dev);
> > -	else
> > +	else {
> >   		clk_bulk_disable(smmu->num_clks, smmu->clks);
> > +		arm_smmu_icc_disable(smmu);
> > +	}
> >   	clk_bulk_unprepare(smmu->num_clks, smmu->clks);
> >   }
> > @@ -2294,9 +2342,13 @@ static int __maybe_unused arm_smmu_runtime_resume(struct device *dev)
> >   	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
> >   	int ret;
> > +	arm_smmu_icc_enable(smmu);
> > +
> >   	ret = clk_bulk_enable(smmu->num_clks, smmu->clks);
> > -	if (ret)
> > +	if (ret) {
> > +		arm_smmu_icc_disable(smmu);
> >   		return ret;
> > +	}
> >   	arm_smmu_device_reset(smmu);
> > @@ -2308,6 +2360,7 @@ static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
> >   	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
> >   	clk_bulk_disable(smmu->num_clks, smmu->clks);
> > +	arm_smmu_icc_disable(smmu);
> >   	return 0;
> >   }
> > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> > index 26d2e33cd328b8278888585fc07a31485d9397e2..c00606a416b2f4bb44a35e5d67f6ef801df68e1c 100644
> > --- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
> > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> > @@ -15,6 +15,7 @@
> >   #include <linux/bits.h>
> >   #include <linux/clk.h>
> >   #include <linux/device.h>
> > +#include <linux/interconnect.h>
> >   #include <linux/io-64-nonatomic-hi-lo.h>
> >   #include <linux/io-pgtable.h>
> >   #include <linux/iommu.h>
> > @@ -335,6 +336,7 @@ struct arm_smmu_device {
> >   	int				num_clks;
> >   	unsigned int			*irqs;
> >   	struct clk_bulk_data		*clks;
> > +	struct icc_path			*icc_path;
> >   	spinlock_t			global_sync_lock;
> > 
> 
> Any feedback or concerns on the interconnect voting approach proposed here?
> 
> This helps to address the kernel panic issue [1] reported for one of
> Qualcomm platforms.

Please respond or tend the issues, pointed out by Sashiko.

> 
> [1]: https://github.com/qualcomm-linux/kernel/issues/297
> 
> Thanks,
> Bibek

-- 
With best wishes
Dmitry
