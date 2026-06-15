Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7A73EB0F2
	for <iommu@lists.linux.dev>; Mon, 15 Jun 2026 13:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781528841; cv=none; b=ouhlkJh80qg7jWL2j+z4yxYB1zNefIDKNWXX6UovWQypIMndRYk8iOFO8ZVijBh5/isBQgR2BjMO7q02ZTfQ9AhABrorfR/eWr6nPFBQyx5434gbJEK/zP4lUo2HXnIipTcgxZcWXtt4Uh2p+3nfeN3wGoOaBMf2Euuj/B2XcX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781528841; c=relaxed/simple;
	bh=mM80Ae8XxnzS51Dw4Pw58HMVr5lZn9bOwL/mMk9poQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HQ/taXEHWq7jkfdSica26tgyvaGUgbKIlYcxTmpVFY7XGIIf23n7PuVVMDtrJklTVa+jlL7OvAOtrcsj45enBKokSs74Xx/UPnL7XDiBEbaDWuh+pBtpb9oEeQSz5JAvl31lQcuAkb9CUFv/6JA34cUeLYyPB7AtRNHBAGEBPW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k2NnFh8O; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RwTLMdKt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k2NnFh8O";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RwTLMdKt"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FCbhXO568171
	for <iommu@lists.linux.dev>; Mon, 15 Jun 2026 13:07:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HvxVu7ZMj0GrNYVnvEx5o+aB0JEz3pjwUB8+jM1GNAE=; b=k2NnFh8OTE87IxoX
	b/yqlUzI6TGw5uqop0QKf2e8vEKKI3wI9Zf4QbFK6n4wJgBORCv0KyBBZ4kU1GVT
	sj++RiR35ktuXs4SxZ4JGm4gXyGXFn0kZqL7F6wd34eaznVEwTfp5Tcim/UAKlMf
	xth0XqvsvdYNODjm6FgT5cIHw3naQ6IBgZdoE+KMlPvOr2zcP7dAyMsWURP4uArf
	y03G5nwbEuoi0hWdojyAA9buhKBcqPmKwA1stx3KMUwH4pcGleWeCfZMXJLdaLPD
	vnFYhroCkcRegNCDnvd9LJ1eX1BrDYVMoSEVAz1zu5b5s8JJlifQgpldjI0wqGZ2
	cLli9w==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etgvhg94x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 15 Jun 2026 13:07:18 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-842208d5b0eso2696885b3a.3
        for <iommu@lists.linux.dev>; Mon, 15 Jun 2026 06:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781528838; x=1782133638; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HvxVu7ZMj0GrNYVnvEx5o+aB0JEz3pjwUB8+jM1GNAE=;
        b=RwTLMdKtCkieULYUPpG87aHYjGU+8WB8vtPFNhTttnPCeLjZBUfv6o0aq36G+c/0It
         2SJpiNhmyFmav82MN3d2sce1mZ401ApfXBZD8QAMZ7ec2IiVXxo2HVomoVnkLSssdbJ5
         P9k3sMHyb/dg/jDNVQLpIIV3E0wg8mUC1Zfe4WnsRMG6EW05mlxiQDqCiHq3yT3b64mY
         nSkFqpLp9pBEd1GveS4/mlhkDJW8P1Sf5p/bogK3T1k4+cz3aQP0SPr+UtG8ub2I9SlB
         30BJ3InMp6ft78okwDBBN8lyawlhz/OKjbEsAWb71VN8mNlQMzkHbhwpfSNyCI50jEC9
         gYeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781528838; x=1782133638;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HvxVu7ZMj0GrNYVnvEx5o+aB0JEz3pjwUB8+jM1GNAE=;
        b=gqhvB3dSfO0zCdDsanEucDiYMadCjb656i20pRbaCC0nojlimQZ64WZfHuwK6xUAiO
         q4TLLZ+stpKSFAyGa631viTuPZ4hbG/rVIwPMrPzhSvIe58Pf2/J50hIUUWDUVtRx//I
         /4htH8qnx6ZlzFkZDHTY2vYKPxeRKf9U/WLHL+s8XV1zGPej/ZnAO3Ihvp+26Duzi2rJ
         oV026G3TGPtwibKSiER4eXPblEWX6Eg4D72N3YxSMNfw1jpHoZwATBvPC1l9YvyMzQje
         +YKqISd336xZGeFlGDSJAstYr1aTu47XyTWi4NcoHLBqa6nJboqzXMasPz2ewkfQFdtz
         v5iQ==
X-Forwarded-Encrypted: i=1; AFNElJ9CVgw+esjaPY6WbwZwbrgkdAxBnCEASkokxaJDvXBLgkVLYORa4zyMMIHK6pUv80dm+kWCBw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz8NUOS7wsiihKW40N+abur8+wH0UWaBJvJh/iuzQ9O5IoqtkgV
	fTD9wLayU1HNODjqIUCyWciVUcUHs5IwEQymkXiXCjX3hfaNBLiM8T2moV6zP821BBagg62AfBZ
	WrEXBBsa2P1+B+CbOoHPFTnXoS4VuEW/5oDAKkjNGtFHUeW7gw5P13NsxrA==
X-Gm-Gg: Acq92OHxj+Igg9ADj0SA/CYbAng2M67leqYocm4mWQGT840eSYN8pL0nMnMR/Wl/SeW
	jBzeo6zK/WqpUu8UYwd/AJMZN6g8c2kdNb/IkW765AOeQhQDEJL5H6UX82m2Vr3LY7auPe0lMDu
	SSUVZWLJjogTj/T+nwI32DisDq6/+8qg87Ns1AXbEwvYlRYTRJ9N3mXorKRzrFlTPKO47aiAfmP
	cww3tvkgp4DsHCpMvXhg4pEpQplLD2t3Yvh1PTnqALqBQWckrgXuJhrE1h9t8IBatDItwWhrlZw
	g80YCY9o8lzeXDCnlDqd5bc20eA0xQvP0SchtZue8bTOx1VtAoY+D8ELDlNhjmWE/+ShLqnuE9m
	kPpI9uRip7VDlkwqrIM80Zwu+VqFr4aEWo0UR/qdQgfjjTlveuA==
X-Received: by 2002:a05:6a00:4fc7:b0:842:54c1:8e15 with SMTP id d2e1a72fcca58-8434ce42058mr15689262b3a.29.1781528837806;
        Mon, 15 Jun 2026 06:07:17 -0700 (PDT)
X-Received: by 2002:a05:6a00:4fc7:b0:842:54c1:8e15 with SMTP id d2e1a72fcca58-8434ce42058mr15689210b3a.29.1781528837300;
        Mon, 15 Jun 2026 06:07:17 -0700 (PDT)
Received: from [10.219.57.228] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b04808dsm10116612b3a.52.2026.06.15.06.07.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 06:07:16 -0700 (PDT)
Message-ID: <d25f24ca-5bb3-4276-ac8f-8340e8fb4ce8@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 18:36:51 +0530
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
 <7xfxlxfqjcqdzl6gckaoyy2ioefglc7bgi66yv5khrbl6fi2zc@ivtiukdaj4jv>
Content-Language: en-US
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
In-Reply-To: <7xfxlxfqjcqdzl6gckaoyy2ioefglc7bgi66yv5khrbl6fi2zc@ivtiukdaj4jv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDEzOCBTYWx0ZWRfX6tfMgc7QhVB6
 Bs2VRJc/lN0GaeeiI29y6mntPIhzkUkFCBNoZii823fSORvPrZuuEtgcginRgqoqNqQhXXi6/hO
 97dBF23XwHHV87IL+/Ld4WgGU+uWu04=
X-Authority-Analysis: v=2.4 cv=Zqnd7d7G c=1 sm=1 tr=0 ts=6a2ff906 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=fh4Lr3tRg7ETXUjdBf0A:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: DkRPkKjjfZJtl8GYfWLS5ZmLXwWuROVW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDEzOCBTYWx0ZWRfX4AZKRbVJ4fQu
 ocpkkjqq2fpKCfO2nS/U7yyQqbpkcgWr6qPGum/lWJ8BptFSudYAbZd+r10fMV2C5v4SpIHOyWU
 dgMJWXt46Jq64lSsh5guzEMBzu2se9UwfadhJf6v5Q/8GI0TGDN4z0zirS6hNDeRZkUp6pXX3eF
 5Md7Ym5wT5YMKSZfZ3UN+2tDSnwBQuCI+zd9khj8dTqKz7dKQZr60JF35k16dPnWkJbbNw5swdl
 nPqpcjmF+sx+7ZZqgRUE64etjyNlw7443UM7/cEa4Eeno0G0nB8DRRgrOGXPyun2IrFsFRj6NUK
 rOLOqI1R4A2lHQrLrOQD186bpVIKbjpvfVVn/5Sj3SyJeSjnxH+Sd2xUSD/pl2FkF4mM5ld+DkG
 E4ss5ZfiLm0zR9wZpSYhBtYMxXUIf51kaAcjMt37xAiXK6MEKDWyZqwzQQgYRUk7qg6mnGeM6pj
 Bdis0qBeDqKw++D//Eg==
X-Proofpoint-ORIG-GUID: DkRPkKjjfZJtl8GYfWLS5ZmLXwWuROVW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_03,2026-06-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 clxscore=1015 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150138



On 6/8/2026 7:25 PM, Dmitry Baryshkov wrote:
> On Tue, May 26, 2026 at 08:12:03PM +0530, Bibek Kumar Patro wrote:
>> On some SoCs the SMMU registers require an active interconnect
>> bandwidth vote to be accessible. While other clients typically
>> satisfy this requirement implicitly, certain corner cases (e.g.
>> during sleep/wakeup transitions) can leave the SMMU without a
>> vote, causing intermittent register access failures.
>>
>> Add support for an optional interconnect path to the arm-smmu
>> driver and vote for bandwidth while the SMMU is active. The path
>> is acquired from DT if present and ignored otherwise.
>>
>> The bandwidth vote is enabled before accessing SMMU registers
>> during probe and runtime resume, and released during runtime
>> suspend and on error paths.
>>
>> Generally, from an architectural perspective, GEM_NOC and DDR are
>> expected to have an active vote whenever the adreno_smmu block is
>> powered on. In most common use cases, this requirement is implicitly
>> satisfied because other GPU-related clients (for example, the GMU
>> device) already hold a GEM_NOC vote when adreno_smmu is enabled.
>>
>> However, there are certain corner cases, such as during sleep/wakeup
>> transitions, where the GEM_NOC vote can be removed before adreno_smmu
>> is powered down. If adreno_smmu is then accessed while the interconnect
>> vote is missing, it can lead to the observed failures. Because of the
>> precise ordering involved, this scenario is difficult to reproduce
>> consistently.
>> (also GDSC is involved in adreno usecases can have an independent vote)
>>
>> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
>> ---
>>   drivers/iommu/arm/arm-smmu/arm-smmu.c | 57 +++++++++++++++++++++++++++++++++--
>>   drivers/iommu/arm/arm-smmu/arm-smmu.h |  2 ++
>>   2 files changed, 57 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> index 0bd21d206eb3e75c3b9fb1364cdc92e82c5aa499..07c7e44ec6a5bd1488f00f87d859a20495e46601 100644
>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> @@ -53,6 +53,11 @@
>>   #define MSI_IOVA_BASE			0x8000000
>>   #define MSI_IOVA_LENGTH			0x100000
>>   
>> +/* Interconnect bandwidth vote values for the SMMU register access path */
>> +#define ARM_SMMU_ICC_AVG_BW		0
>> +#define ARM_SMMU_ICC_PEAK_BW_HIGH	1000
> 
> totally random numbers, which might be different for non-Qualcomm platform.
> 

Ideally, any non-zero value would be enough to keep the path active.
Here 1 Would be enough to keep the path active, but might be too small 
to reliably keep the bus active.
Other is UINT_MAX, which will reliably keep the bus active but might 
cause a power penalty.

#define ARM_SMMU_ICC_PEAK_BW_HIGH	UINT_MAX

seems to be suitable here to reliably keep the bus active by BCM
for both Qualcomm and non-Qualcomm platforms (with some power penalty).

LMK, if you feel otherwise.


>> +#define ARM_SMMU_ICC_PEAK_BW_LOW	0
>> +
>>   static int force_stage;
>>   module_param(force_stage, int, S_IRUGO);
>>   MODULE_PARM_DESC(force_stage,
>> @@ -86,6 +91,36 @@ static inline void arm_smmu_rpm_put(struct arm_smmu_device *smmu)
>>   	}
>>   }
>>   
>> +static int arm_smmu_icc_get(struct arm_smmu_device *smmu)
>> +{
>> +	smmu->icc_path = devm_of_icc_get(smmu->dev, NULL);
> 
> Is there always only one bus / path in question?
> 
>> +	if (IS_ERR(smmu->icc_path)) {
> 
> if (!IS_ERR(smmu->icc_path))
> 	return 0;
> 
> int err = PTR_ERR();
> if (err == -ENODEV) {
> 	icc_path = NULL;
> 	return 0;
> }
> 
> return dev_err_probe();
> 
> 
>> +		int err = PTR_ERR(smmu->icc_path);
>> +
>> +		if (err == -ENODEV) {
>> +			smmu->icc_path = NULL;
>> +			return 0;
>> +		}
>> +		return dev_err_probe(smmu->dev, err,
>> +				     "failed to get interconnect path\n");
>> +	}
>> +	return 0;
>> +}
>> +
>> +static void arm_smmu_icc_enable(struct arm_smmu_device *smmu)
>> +{
>> +	if (smmu->icc_path)
> 
> Drop the if.
> 

Ack, will address it in next revision

>> +		WARN_ON(icc_set_bw(smmu->icc_path, ARM_SMMU_ICC_AVG_BW,
>> +				   ARM_SMMU_ICC_PEAK_BW_HIGH));
> 
> WARN_ON_ONCE()?
> 
> Pass the error to the caller.
> 
> 

Ack, would be better to pass. Thanks for pointing this.

>> +}
>> +
>> +static void arm_smmu_icc_disable(struct arm_smmu_device *smmu)
>> +{
>> +	if (smmu->icc_path)
> 
> Drop the if.
> 

Ack.

>> +		WARN_ON(icc_set_bw(smmu->icc_path, ARM_SMMU_ICC_AVG_BW,
>> +				   ARM_SMMU_ICC_PEAK_BW_LOW));
> 
> Pass the error to the caller.
> 

Ack.

>> +}
>> +
>>   static void arm_smmu_rpm_use_autosuspend(struct arm_smmu_device *smmu)
>>   {
>>   	/*
>> @@ -2189,6 +2224,17 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>>   	if (err)
>>   		return err;
>>   
>> +	/*
>> +	 * Acquire and vote the interconnect path before accessing any SMMU
>> +	 * registers (including ARM_SMMU_GR0_ID0 in arm_smmu_device_cfg_probe).
>> +	 */
>> +	err = arm_smmu_icc_get(smmu);
>> +	if (err) {
>> +		clk_bulk_disable_unprepare(smmu->num_clks, smmu->clks);
>> +		return err;
>> +	}
>> +	arm_smmu_icc_enable(smmu);
> 
> Handle the error.
> 

Ack, will address this in next revision. to disable the clocks here as well.

+       err = arm_smmu_icc_enable(smmu);
+       if (err) {
+               clk_bulk_disable_unprepare(smmu->num_clks, smmu->clks);
+               return err;
+       }

>> +
>>   	err = arm_smmu_device_cfg_probe(smmu);
>>   	if (err)
>>   		return err;
>> @@ -2273,8 +2319,10 @@ static void arm_smmu_device_shutdown(struct platform_device *pdev)
>>   
>>   	if (pm_runtime_enabled(smmu->dev))
>>   		pm_runtime_force_suspend(smmu->dev);
>> -	else
>> +	else {
>>   		clk_bulk_disable(smmu->num_clks, smmu->clks);
>> +		arm_smmu_icc_disable(smmu);
> 
> Handle the error.
> 
> etc.
> 

Ack, will address the if(), and error handling suggestion in next iteration.

Thanks & regards,
Bibek

>> +	}
>>   
>>   	clk_bulk_unprepare(smmu->num_clks, smmu->clks);
>>   }
> 

