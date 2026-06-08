Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC3740963C
	for <iommu@lists.linux.dev>; Mon,  8 Jun 2026 14:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780929827; cv=none; b=ISKM1fe7g+1N4Tu6Z3ePnFrUKAWNvhddNIzQdLOD8wXS/L/s5eeyidPf0b8/+QvCBpsit8ujxFIZGpohkjhjS5BiPG9mjcu+mBGdM8ekoZaJOK6QwYbjQK1OK/Y7cB8a3B82cfqsYgPDTWg7CdzP1VUjaJARumHgb0t0nR5EE78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780929827; c=relaxed/simple;
	bh=0Ks124g6UDmOjYuZFGg5VXudv4ts64373wIMh9BAh8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YAPgGzaTwVCt2gXsTBkvoroKR7wvj5JflMbgKhZr6K1NyZ1Bns0rfz1yhypy9PT19RJFS3klK7paxXivQ9KstgKLJyGaq/8wteM/OmxVx0uQNZYjlSwfxEm1oFGysZR3dB3b7F7HJWp5hHXO91Q0fogeMflz34D45uFQHWVNQvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F7L5qxQH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PfqnUuvn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F7L5qxQH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PfqnUuvn"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658EY5Tw3490324
	for <iommu@lists.linux.dev>; Mon, 8 Jun 2026 14:43:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	I5rvouy0LA0qv0H/lcd4HWDbQ7WITv9x2aTO/Bk6nOo=; b=F7L5qxQHsRm61SUJ
	NnokikmxUR5WaZizasytm9Lk8FXczfnV9dL/1b+eK9d/fss9KWtNfJxcRAePv/QT
	Vv/jSMPZRYTIgh52JeXt8uSA8cQVP8zJVECmJOja+c/rdUKnjEfxK3d536KwTp8v
	yTYPj1GpdAYfoNzeowmlMGMhcnqBVGz4chAtpiLQ0IzztKGWacd8CH4I14DlhiTm
	8BZcUB0iGsX6Ov4WYECyNBxGj2BAZmLT+9/x0XF0ykCr/wUlD3qiUWkPPOiqv+kf
	1t0X5wj0wobR/nqvIb9pJleTVnGQ8tNxubAMj5BTinBkn0rMReFBhQ6fABUkMpOV
	xPRrQA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enun417s0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 08 Jun 2026 14:43:43 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-36b982ec27aso3228007a91.1
        for <iommu@lists.linux.dev>; Mon, 08 Jun 2026 07:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780929823; x=1781534623; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I5rvouy0LA0qv0H/lcd4HWDbQ7WITv9x2aTO/Bk6nOo=;
        b=PfqnUuvnf1ACju0KXkGFgdaGWDQvq+IJh36pM55T47mdEALEhBiAwdE4A4ZKkSrikL
         HISv74J/AV+D1bwkYlxs4Z2WYt2IVo5L6PBniNK3KNTNflSsxACZzzfA0du1O3oyHhQu
         NaZMQ0dHgcSDPJ6lUSJHPGSeGx37OHA7XgHjsz60PMkJ4fCDk1yIEN0HodqnFg9EjWME
         cV1s+e2ha9gcKayBYNCtYofB6l+QABIuldPirg5fVPF3mYO/7sSdw7/syawlq4PS/G/u
         gsk+ePjIFo7bSqF1iM+99uxK/PQj8SiZylBiW5163mH/O5E+ML/0Qz3HAInv9rKbLwMt
         8ATg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780929823; x=1781534623;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I5rvouy0LA0qv0H/lcd4HWDbQ7WITv9x2aTO/Bk6nOo=;
        b=SSZ4BjD05BlD5DVURmNvcnsQPjBGCkLo5Qzn3fLY7A+sLdU23RNAcR0vNjSuNWq//D
         YDCwT1G+HUu9gRYO7o+4JXBZwr6Z48F2JtEBHAqFfZEi5CBTnMryL+nnpCscRlzgQkGe
         g7Yu1y/eWWKXyc78YbTwTMWccLxiSAJTc4Qk4BlywkiTBWmHLwkuMIix18bWqw+8YiXu
         AVjuRxMHl8nEyj9iLK04L/8b1b80Mx7hrEiwofI7UTV/sN47E0rIIijoXPS8IwvUfB3k
         4xy/lTOo7RdspH2NmhGZ58DQ0X/zagXjtvcNsQ/DfKpHPQLRgjypsHlhcYX5ufDm5VhG
         rELQ==
X-Forwarded-Encrypted: i=1; AFNElJ91QWEHk4lbQ5PWqY3VXbTc/AL4Rw3R9voPCnGhuoxL13LhkRcvQoSZCWpe997dgyVqBAzn6Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy+3kjQqlWJMnJ6hiFpH8SGMSt4LgIXhA89oDrWUXuWFXlF/yIP
	KLBmYqcuqm9SYhGV2Lz0dKHS/h3GWDkISLz4KXKoYrf1zAK5nvaSnKUoy5FuwNWBhy4uutiO+kh
	ivZnTqqXfFZyty3zljs8/6eEltjQJWqUD8kLs1AJYnZLJHvVAZ0iQsxAjBQ==
X-Gm-Gg: Acq92OHLdE8ojaxzDztpHL0VKxdtzhH162o8QGwD1n1TZYRQnCodA47Y9CPdxzmMkds
	XDksRuFjgO1++zuSR7HORHRCy/h00Cub8GrVqJ50XESCrLi7pMqT82bnMvD7YTcwSvsQkeNvYVW
	MsbGZSMco9zP3hIfkkmG1/B8UqkkK7iZxl8CP4a8h9lS/74hHGgGlR6eGXBInkW15ENv6ugpYuv
	ui55UHfLLEWikLnpLHSGGYx4b4ijCQ6hzVtWMhz/Z1p4exMJOA+wYuZt8AG+9sOUbgnEAMNMMKH
	Yc2GrDpls1raXWtQjMhgSwgULeSci5iaFEe6Y+HMqIu9dp58otxGz9gu3WMglJZbpbpwJi9mpAK
	j9KLwouZcGboAytw5Z7GK7nCRR8pEclOqi7eH+wgbXgBwsrf/5FDObhZJdAVT
X-Received: by 2002:a17:90b:180a:b0:36a:7da3:266b with SMTP id 98e67ed59e1d1-370f0c54d08mr16715120a91.21.1780929822988;
        Mon, 08 Jun 2026 07:43:42 -0700 (PDT)
X-Received: by 2002:a17:90b:180a:b0:36a:7da3:266b with SMTP id 98e67ed59e1d1-370f0c54d08mr16715093a91.21.1780929822496;
        Mon, 08 Jun 2026 07:43:42 -0700 (PDT)
Received: from [10.219.56.113] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6bf827f1sm19620137a91.3.2026.06.08.07.43.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 07:43:42 -0700 (PDT)
Message-ID: <a3523574-8eaf-452f-8126-db17892d5b40@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 20:13:36 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] iommu/arm-smmu: Add interconnect bandwidth voting
 support
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20260526-smmu_interconnect_addition-v2-0-2a6d8ca30d63@oss.qualcomm.com>
 <20260526-smmu_interconnect_addition-v2-2-2a6d8ca30d63@oss.qualcomm.com>
 <68aa9591-49e0-4cb7-9a5b-36405efe7094@oss.qualcomm.com>
 <bkve3vmokuyrn4agsqyzxlqr5wuy5y6urnliqypac3h6lb32hy@tfkjstevqv2y>
Content-Language: en-US
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
In-Reply-To: <bkve3vmokuyrn4agsqyzxlqr5wuy5y6urnliqypac3h6lb32hy@tfkjstevqv2y>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE0MCBTYWx0ZWRfXyhvhMWGY61st
 ZzthBp+PaZKxXNysPHQVM55wu5gvPFrEfB0RW9bBRd6bKmyDkZcR6XN4KFPCw+vqXe/Pv7XlrbJ
 BDVWBy686disM0q3s635mPde3nBVpFqE9duN1laB+pqmx0zQIoAOT0pop77IqD60vHFx6wpux3g
 6BPoMImFQ8IMvns7abARkECHk+ulPCG6CPxISCENP/DeV+sEnNiW16FetJ39gbG9GLA5mbSkMcm
 mnph5JjPiCsdXNagyY+H7H5REzBopytBMTNqmmvREyzD1ga09YBE8psNyFewFBGnm18Usq7FhJq
 hNCSZDTcDkL2g9aO5YWDIv3j0/DcTG8qESKBb3zT087LsbEWh5CdjtSURXaKNqL4AqXayH3PHQ6
 HVGx+3YkXSUoSh9Kmv8AB27/C48KaAj2kaRFKykE0T6FHmWW13CeaaglcxOcBOfbLL57aVEAnBy
 gu5M0Kl1axZnXim2msg==
X-Proofpoint-ORIG-GUID: sCxwFbDlYNTcuwSJGfUrLFXgbSc9sul-
X-Authority-Analysis: v=2.4 cv=ZY4t8MVA c=1 sm=1 tr=0 ts=6a26d51f cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=NEAV23lmAAAA:8 a=ow02GMYoO05H5sz-MT4A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: sCxwFbDlYNTcuwSJGfUrLFXgbSc9sul-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080140



On 6/8/2026 7:20 PM, Dmitry Baryshkov wrote:
> On Mon, Jun 08, 2026 at 06:59:34PM +0530, Bibek Kumar Patro wrote:
>>
>> ...
>>
>>> ---
>>>    drivers/iommu/arm/arm-smmu/arm-smmu.c | 57 +++++++++++++++++++++++++++++++++--
>>>    drivers/iommu/arm/arm-smmu/arm-smmu.h |  2 ++
>>>    2 files changed, 57 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>>> index 0bd21d206eb3e75c3b9fb1364cdc92e82c5aa499..07c7e44ec6a5bd1488f00f87d859a20495e46601 100644
>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>>> @@ -53,6 +53,11 @@
>>>    #define MSI_IOVA_BASE			0x8000000
>>>    #define MSI_IOVA_LENGTH			0x100000
>>> +/* Interconnect bandwidth vote values for the SMMU register access path */
>>> +#define ARM_SMMU_ICC_AVG_BW		0
>>> +#define ARM_SMMU_ICC_PEAK_BW_HIGH	1000
>>> +#define ARM_SMMU_ICC_PEAK_BW_LOW	0
>>> +
>>>    static int force_stage;
>>>    module_param(force_stage, int, S_IRUGO);
>>>    MODULE_PARM_DESC(force_stage,
>>> @@ -86,6 +91,36 @@ static inline void arm_smmu_rpm_put(struct arm_smmu_device *smmu)
>>>    	}
>>>    }
>>> +static int arm_smmu_icc_get(struct arm_smmu_device *smmu)
>>> +{
>>> +	smmu->icc_path = devm_of_icc_get(smmu->dev, NULL);
>>> +	if (IS_ERR(smmu->icc_path)) {
>>> +		int err = PTR_ERR(smmu->icc_path);
>>> +
>>> +		if (err == -ENODEV) {
>>> +			smmu->icc_path = NULL;
>>> +			return 0;
>>> +		}
>>> +		return dev_err_probe(smmu->dev, err,
>>> +				     "failed to get interconnect path\n");
>>> +	}
>>> +	return 0;
>>> +}
>>> +
>>> +static void arm_smmu_icc_enable(struct arm_smmu_device *smmu)
>>> +{
>>> +	if (smmu->icc_path)
>>> +		WARN_ON(icc_set_bw(smmu->icc_path, ARM_SMMU_ICC_AVG_BW,
>>> +				   ARM_SMMU_ICC_PEAK_BW_HIGH));
>>> +}
>>> +
>>> +static void arm_smmu_icc_disable(struct arm_smmu_device *smmu)
>>> +{
>>> +	if (smmu->icc_path)
>>> +		WARN_ON(icc_set_bw(smmu->icc_path, ARM_SMMU_ICC_AVG_BW,
>>> +				   ARM_SMMU_ICC_PEAK_BW_LOW));
>>> +}
>>> +
>>>    static void arm_smmu_rpm_use_autosuspend(struct arm_smmu_device *smmu)
>>>    {
>>>    	/*
>>> @@ -2189,6 +2224,17 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>>>    	if (err)
>>>    		return err;
>>> +	/*
>>> +	 * Acquire and vote the interconnect path before accessing any SMMU
>>> +	 * registers (including ARM_SMMU_GR0_ID0 in arm_smmu_device_cfg_probe).
>>> +	 */
>>> +	err = arm_smmu_icc_get(smmu);
>>> +	if (err) {
>>> +		clk_bulk_disable_unprepare(smmu->num_clks, smmu->clks);
>>> +		return err;
>>> +	}
>>> +	arm_smmu_icc_enable(smmu);
>>> +
>>>    	err = arm_smmu_device_cfg_probe(smmu);
>>>    	if (err)
>>>    		return err;
>>> @@ -2273,8 +2319,10 @@ static void arm_smmu_device_shutdown(struct platform_device *pdev)
>>>    	if (pm_runtime_enabled(smmu->dev))
>>>    		pm_runtime_force_suspend(smmu->dev);
>>> -	else
>>> +	else {
>>>    		clk_bulk_disable(smmu->num_clks, smmu->clks);
>>> +		arm_smmu_icc_disable(smmu);
>>> +	}
>>>    	clk_bulk_unprepare(smmu->num_clks, smmu->clks);
>>>    }
>>> @@ -2294,9 +2342,13 @@ static int __maybe_unused arm_smmu_runtime_resume(struct device *dev)
>>>    	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
>>>    	int ret;
>>> +	arm_smmu_icc_enable(smmu);
>>> +
>>>    	ret = clk_bulk_enable(smmu->num_clks, smmu->clks);
>>> -	if (ret)
>>> +	if (ret) {
>>> +		arm_smmu_icc_disable(smmu);
>>>    		return ret;
>>> +	}
>>>    	arm_smmu_device_reset(smmu);
>>> @@ -2308,6 +2360,7 @@ static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
>>>    	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
>>>    	clk_bulk_disable(smmu->num_clks, smmu->clks);
>>> +	arm_smmu_icc_disable(smmu);
>>>    	return 0;
>>>    }
>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
>>> index 26d2e33cd328b8278888585fc07a31485d9397e2..c00606a416b2f4bb44a35e5d67f6ef801df68e1c 100644
>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
>>> @@ -15,6 +15,7 @@
>>>    #include <linux/bits.h>
>>>    #include <linux/clk.h>
>>>    #include <linux/device.h>
>>> +#include <linux/interconnect.h>
>>>    #include <linux/io-64-nonatomic-hi-lo.h>
>>>    #include <linux/io-pgtable.h>
>>>    #include <linux/iommu.h>
>>> @@ -335,6 +336,7 @@ struct arm_smmu_device {
>>>    	int				num_clks;
>>>    	unsigned int			*irqs;
>>>    	struct clk_bulk_data		*clks;
>>> +	struct icc_path			*icc_path;
>>>    	spinlock_t			global_sync_lock;
>>>
>>
>> Any feedback or concerns on the interconnect voting approach proposed here?
>>
>> This helps to address the kernel panic issue [1] reported for one of
>> Qualcomm platforms.
> 
> Please respond or tend the issues, pointed out by Sashiko.
> 

Sure, I have addressed and replied to the Sashiko warnings on v1,
I'll check on the fresh warnings on V2 along with your suggestions on 
this patch.
< I was wondering if it's needed to respond to Sashiko comments earlier 
or silently address the relevant ones,
so thanks for confirming this as well :) >

Thanks,
Bibek

>>
>> [1]: https://github.com/qualcomm-linux/kernel/issues/297
>>
>> Thanks,
>> Bibek
> 

