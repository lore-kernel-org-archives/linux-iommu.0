Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA2F372ECA
	for <iommu@lists.linux.dev>; Mon,  8 Jun 2026 13:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780925420; cv=none; b=pIhGJN34EWFylwsy68sZJrjZmM5BeadetqLEg1F9YFL1dAxyTMY/zOI8kuDbgntOQwmfn8ouqoANXhxc3B1yhjArQNp5YQ9umufCerP+kdqsBtDtbvpavIQ5T0r5pOXoXQ+AUL/0HT41yHJJJ1bgjUItfjTKgU/hzehWaHn75h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780925420; c=relaxed/simple;
	bh=wU51h2i1j+P7tyeaRqLj4SLZat3sAhChv+NIMaleJU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C6AGvmj7i0ZefNImORjTWsv8iwdrnbLigqrgc8V/JfQr3ibC/6OUvKUKn7vU3/s/QRqRLfL+u/rEnDIJ/X5fzrzZ2XKMjkMOkiG6HkC00ZFl+AMbQu1scKaKe1+Rs3Um6WxuyQl3DGoNFpWCDL0kPX/9ck+djQnXUdJhHGLQZPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Tu0SSTOg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ULUvOpv2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Tu0SSTOg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ULUvOpv2"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658DRBXh3682112
	for <iommu@lists.linux.dev>; Mon, 8 Jun 2026 13:30:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mMpY65sj+dUK6nSVVEKFgaghqYR4p2ChoNTezZ6kJC8=; b=Tu0SSTOgpab62mLt
	zXHYwS1KMRhkkQcivFAU7zeMEHWG8wEN3pnTkOZf5NOf9a/nZr0jw+0+zS3g3xYR
	B7CQK9r92546i2qalbMEZpXS9V/qvPIgWBpHQdH2FYiga0tmQUnarEjiLj2y7o/e
	le4RQiwFKmZ0Kv0W8V7vJH5lZHrNK4eIi3l9P8qBWgNywdOenY6n5KluNyn5L3im
	1d8/6oPW5SM+mAuIePMOB3wmK/FsmgNKdOydY0OSqtw4Ldpv+X7KmpJs3f6F/4zz
	6k4op9tSj/HEGycK98Y0DZ3Z4ozx/+g17T5gMgJIV5xeT52SMCsCaK/QPGygzzVu
	n9T5qA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enx2rr7kw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 08 Jun 2026 13:30:16 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-36d97a4e08fso3958421a91.0
        for <iommu@lists.linux.dev>; Mon, 08 Jun 2026 06:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780925416; x=1781530216; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mMpY65sj+dUK6nSVVEKFgaghqYR4p2ChoNTezZ6kJC8=;
        b=ULUvOpv2uiQ1UyblQc2u1rqxfXgXPII2+FfwsCdYsLkQHtwIJ6ryEo/fVQip7nEVBX
         ukKM8N9KoVUKrxxQXAV1RSXy2BKuBvJOWWK7ZgX8fYpA1quAXQpuiNBdOzOvDjtKPHDb
         JzbepRHf6IYsDrLweGfk8LcuZ3oATcHCtY7XFzx5vSQ4llswxXUagvhQyEWGC/2jimpC
         uVxg3NxVReyNjUXV0pBDq/WZxsQgWB2b7N8r7P/42AUuYWDvz1/ktk4+3GqMznL4BfOx
         3pXcJu1MgaABKuKp1wvZbzffgjPGIRxhPFJrltft2nsi/v6hbPseJTYovDr+SHM/zUEX
         lujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780925416; x=1781530216;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mMpY65sj+dUK6nSVVEKFgaghqYR4p2ChoNTezZ6kJC8=;
        b=mrBvo8I9x/OgM6pemcLkdMijisUxZv7EAKMym3R3EWylxSGaEh7m37ip0O8u/7BzdZ
         oiSpKiQugxpcqw0cl+90sZW3e2L39I5+1RDhiUpROcMz5n3dLwdNN4qXTcqt+5oeKgdD
         vlzrrfJSLMbSLv6heeass3SX6cux9e5fBScC5HUEqb5Ibop+1tOqBYcGekt6dRViHfy6
         US2dXt+WsV2hQvQAcgrllvzOE6OIezpLSkkpOB2KZUEF0/D4NbMjtjpKRqcluAEtl+iK
         P7HTKwlTKjdFuRqDv+FKCpwKlUA3IqH5kUObKARD46Ew3PFfmsPE3IaGBoimBbgFXy1I
         89Ng==
X-Forwarded-Encrypted: i=1; AFNElJ8xoHUM7snFz8lhs4JpEmxr7a3HPXPldTLxYu2isZpko2zY9gcm3v5aIkl4WY5MzB7Af4KRsA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy0edsMl3khQXOTWT0AP7B80+xe1++A3azmHuzo1xV1hrjr7n5P
	XT8tI+iI3lH517rTMJXCsU6Ylr6+INseGndV1SNlfeDYnX0XHZycujN5CCR53s3FVcqJ5d8YgvK
	JYBp9ZiYY3oFvysgCZsxKpxfa+WkdANOBYhnVSpSwGA4jXI0t7VF0P3imMQ==
X-Gm-Gg: Acq92OG0O6FJ+K++X4BpfIeSM9ozPDloju9txF2cePjWprBJTQCgj35PxsOTc5QehCV
	k9FC8X4mz4Y2wv/ZS03uQHclh1lWU/Z21nGhVIEdCzdixQ6eXFFlUHvMO64WmzbUJOwwrIe69W/
	V04Ngy2b6zuNEUmQ1eudHXrZsxwU1Ubef9sPGiGb3UcUSG1U2m95SdobKt6UoQ/Dz7J2TZHSDch
	1jJQwDGbYP9e5LaEyw/2aCr+9u9mU/IUnoWYkVmHokMv3PDJEEalDcohFiQWXZlth23fiTLwGxg
	gQRa/yRZmhR27ZIhKRgaFAYIEB9KXVxdzC6IWSP6/IEz5ZzXGa1HGinMEPIrvtgM84ObpnbLogN
	KL9YhocdkXrqT2M3CS7sj0djW1yMCvZUM0nXrrlk9m7eZC74PprFuZp9Ty+3h
X-Received: by 2002:a17:90b:5747:b0:36b:9798:4f67 with SMTP id 98e67ed59e1d1-370eee03facmr15489638a91.8.1780925415614;
        Mon, 08 Jun 2026 06:30:15 -0700 (PDT)
X-Received: by 2002:a17:90b:5747:b0:36b:9798:4f67 with SMTP id 98e67ed59e1d1-370eee03facmr15489584a91.8.1780925414897;
        Mon, 08 Jun 2026 06:30:14 -0700 (PDT)
Received: from [10.219.56.113] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6bf8284dsm19173198a91.4.2026.06.08.06.30.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 06:30:14 -0700 (PDT)
Message-ID: <68aa9591-49e0-4cb7-9a5b-36405efe7094@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 18:59:34 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] iommu/arm-smmu: Add interconnect bandwidth voting
 support
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20260526-smmu_interconnect_addition-v2-0-2a6d8ca30d63@oss.qualcomm.com>
 <20260526-smmu_interconnect_addition-v2-2-2a6d8ca30d63@oss.qualcomm.com>
Content-Language: en-US
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
In-Reply-To: <20260526-smmu_interconnect_addition-v2-2-2a6d8ca30d63@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Cm4A0fLuHoui-UA0_bK_qash3xHjQU7w
X-Proofpoint-ORIG-GUID: Cm4A0fLuHoui-UA0_bK_qash3xHjQU7w
X-Authority-Analysis: v=2.4 cv=JdqMa0KV c=1 sm=1 tr=0 ts=6a26c3e8 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=NEAV23lmAAAA:8 a=vPN-sUkGHC-xCyVeAx8A:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEyNyBTYWx0ZWRfXyn11hytQJIzw
 bBVgZ6xbGYMQV3/p47GEynlvSwRnQK7RPq2eeOcDkJPZgVBz9wW+eDE0+JImCbCIbRMNyc4Spvb
 vHSYkeX+lLO71Ql+gMn2Go0rx4ECxxzrvzvbMq441XDI5Ixx9BWwJakA3oMZvsnEpKKkWLYoa1n
 sjhmWgrPWidQS80Wp0kFgcFCYm38rKb3Hh7bnDSqSUciGxYQ6jFtmy8JRbk0/Cp6KAL8GICug/b
 Grumu3RRJ7IplIBYmaKsCQrMvcgYhpSFOdD0vYLhAEHLcswqoc2PMMvbYf5fOb6Hj10i/FPwsnT
 B9f3eaUzhkdTVmkQklqYlv5U8t+Xw0MAoIz7OxfYmwmedEZQVfPoM8z3UW0iu7SxHXB6rqqjT7T
 92UetO+uyVyX08FAKP+5IDzSYaPTLThSMC2/hrAnteB6yqyi56Jxcg6uhGvcuBmbEwAibGVHGqz
 MUQ+cTuuuD/T5STTpDA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080127


...

> ---
>   drivers/iommu/arm/arm-smmu/arm-smmu.c | 57 +++++++++++++++++++++++++++++++++--
>   drivers/iommu/arm/arm-smmu/arm-smmu.h |  2 ++
>   2 files changed, 57 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index 0bd21d206eb3e75c3b9fb1364cdc92e82c5aa499..07c7e44ec6a5bd1488f00f87d859a20495e46601 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -53,6 +53,11 @@
>   #define MSI_IOVA_BASE			0x8000000
>   #define MSI_IOVA_LENGTH			0x100000
>   
> +/* Interconnect bandwidth vote values for the SMMU register access path */
> +#define ARM_SMMU_ICC_AVG_BW		0
> +#define ARM_SMMU_ICC_PEAK_BW_HIGH	1000
> +#define ARM_SMMU_ICC_PEAK_BW_LOW	0
> +
>   static int force_stage;
>   module_param(force_stage, int, S_IRUGO);
>   MODULE_PARM_DESC(force_stage,
> @@ -86,6 +91,36 @@ static inline void arm_smmu_rpm_put(struct arm_smmu_device *smmu)
>   	}
>   }
>   
> +static int arm_smmu_icc_get(struct arm_smmu_device *smmu)
> +{
> +	smmu->icc_path = devm_of_icc_get(smmu->dev, NULL);
> +	if (IS_ERR(smmu->icc_path)) {
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
> +		WARN_ON(icc_set_bw(smmu->icc_path, ARM_SMMU_ICC_AVG_BW,
> +				   ARM_SMMU_ICC_PEAK_BW_HIGH));
> +}
> +
> +static void arm_smmu_icc_disable(struct arm_smmu_device *smmu)
> +{
> +	if (smmu->icc_path)
> +		WARN_ON(icc_set_bw(smmu->icc_path, ARM_SMMU_ICC_AVG_BW,
> +				   ARM_SMMU_ICC_PEAK_BW_LOW));
> +}
> +
>   static void arm_smmu_rpm_use_autosuspend(struct arm_smmu_device *smmu)
>   {
>   	/*
> @@ -2189,6 +2224,17 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>   	if (err)
>   		return err;
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
> +
>   	err = arm_smmu_device_cfg_probe(smmu);
>   	if (err)
>   		return err;
> @@ -2273,8 +2319,10 @@ static void arm_smmu_device_shutdown(struct platform_device *pdev)
>   
>   	if (pm_runtime_enabled(smmu->dev))
>   		pm_runtime_force_suspend(smmu->dev);
> -	else
> +	else {
>   		clk_bulk_disable(smmu->num_clks, smmu->clks);
> +		arm_smmu_icc_disable(smmu);
> +	}
>   
>   	clk_bulk_unprepare(smmu->num_clks, smmu->clks);
>   }
> @@ -2294,9 +2342,13 @@ static int __maybe_unused arm_smmu_runtime_resume(struct device *dev)
>   	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
>   	int ret;
>   
> +	arm_smmu_icc_enable(smmu);
> +
>   	ret = clk_bulk_enable(smmu->num_clks, smmu->clks);
> -	if (ret)
> +	if (ret) {
> +		arm_smmu_icc_disable(smmu);
>   		return ret;
> +	}
>   
>   	arm_smmu_device_reset(smmu);
>   
> @@ -2308,6 +2360,7 @@ static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
>   	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
>   
>   	clk_bulk_disable(smmu->num_clks, smmu->clks);
> +	arm_smmu_icc_disable(smmu);
>   
>   	return 0;
>   }
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> index 26d2e33cd328b8278888585fc07a31485d9397e2..c00606a416b2f4bb44a35e5d67f6ef801df68e1c 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> @@ -15,6 +15,7 @@
>   #include <linux/bits.h>
>   #include <linux/clk.h>
>   #include <linux/device.h>
> +#include <linux/interconnect.h>
>   #include <linux/io-64-nonatomic-hi-lo.h>
>   #include <linux/io-pgtable.h>
>   #include <linux/iommu.h>
> @@ -335,6 +336,7 @@ struct arm_smmu_device {
>   	int				num_clks;
>   	unsigned int			*irqs;
>   	struct clk_bulk_data		*clks;
> +	struct icc_path			*icc_path;
>   
>   	spinlock_t			global_sync_lock;
>   
> 

Any feedback or concerns on the interconnect voting approach proposed here?

This helps to address the kernel panic issue [1] reported for one of 
Qualcomm platforms.

[1]: https://github.com/qualcomm-linux/kernel/issues/297

Thanks,
Bibek
