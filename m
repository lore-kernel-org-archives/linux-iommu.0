Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142DB36AB7C
	for <iommu@lists.linux.dev>; Mon, 15 Jun 2026 13:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781529954; cv=none; b=n05hzHYhAsYGpK6PAjvViGTLhG3Dlkee9EEG9pOCq/jZgAXpBOPl1z6zZvNH/+Wt4q6Oza2lfuBPBwwc4+KlMm4SjOCpiJDfdR57Pb//uDBLoV0dM+8EyjWhXQtwkFYd+1c3SFr/UpLhCGeNh/5hdviWHVZ+89WLp950TEv/d5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781529954; c=relaxed/simple;
	bh=3xhHWlD8RQco2IA1KAQxhlJoKB5DW/j70I2e9jXDPe4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qYmbddBuVVvpcUaSg/Su+7xh7k/Aune3iFdOm4tjvb47yXvbRlF5CRYwvkCLkU7kPBG6h2zM88BO/5o8g1cf0a7mtVH+wx8knMqMcOKdHVv70A1NetilUU43RQGywpGB7fWPR7uP/desN7VcDTyo1GaCgt6rHS10FxBcHWZMwMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cBOata2h; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZrgigrMm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cBOata2h";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZrgigrMm"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FCZBmP2712646
	for <iommu@lists.linux.dev>; Mon, 15 Jun 2026 13:25:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8CeFE4vffm7VQHEzk2SuyKKfPfRD48OmgDxEnfneNJE=; b=cBOata2ha3mzT2r4
	NpDWj8zrLNGSUg7IPgZNw0ZxMh6wdFvQ7Lpe2wW1dtVrVuOcnrGTF5DNORb2qj/j
	lhPgBcWvfKnVCNo09tuDB+QlOgNwJrQAAzAQGP+g2S/KIwJG0vrCDRdRterxoSce
	mu6gVgODNhntvCsNyxS7jFeGUw6Nw9UXl38pF5VViGcRYReqGyFK0eVvKw+NXluv
	Sl2VTpTp9xCRqpeWxRA+wz/w/6qg/RVbsihsQNPoCs00flPzB0mwsP/k4kTCV1Sl
	D6eV97jg4mA3A9eQGroeGpbgluG/ftmNzsq0XH0JusyxxIvLkAaj1P39+HjaJ5ns
	NHD68A==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ete9810xm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 15 Jun 2026 13:25:52 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2c2da7fa311so33910065ad.3
        for <iommu@lists.linux.dev>; Mon, 15 Jun 2026 06:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781529951; x=1782134751; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8CeFE4vffm7VQHEzk2SuyKKfPfRD48OmgDxEnfneNJE=;
        b=ZrgigrMmuHcHjKENx20V6ffNmgO4o4zYGDrkTn3RiM88eioCpdZigq+Lkg6h6i01Mo
         njVFKeZufm0nLu/6PR3Hr5gSMMl8scdyjyM9E61DTvAV5a0B3fzBhJ+bNUc/5ke0JpDQ
         DX4scl0fAjX2ovCmUTjgapo9gdLwsIc760lw0ucdIgk3UgT4DLl8Cm1SlyMbDC9xHMFH
         nCtbFLF2ogGqBn7DwKkEHV9ve64DK+mXoS4t7GVG9KkXuTgWcbNTY7rZLCXjZIk8paye
         zATeUYElToB/2XpIyS4iA6N5xNuqhqaoLgKwspWSiTC0/g9B0ZKyYdyxsrlHBY/NEQ7G
         v6Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781529951; x=1782134751;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8CeFE4vffm7VQHEzk2SuyKKfPfRD48OmgDxEnfneNJE=;
        b=KlDxbidO2cHfTEtAknWvS+3ckzEuwjFZsbUH/G+RJlgliBEo9uX46rrSg9mgZZIKvX
         OOnwPhNGlG30Y2dAMxFnBjEM/XeM7WeNNDAYdsJN/g7+P1SwiYsepaymu8Szbpthx1mu
         VmqmmKEYjCp1LryN0qDr+oOzHw/o0vhFzN3rprV5zTDFMVm17uOr1ecg5Wih8EshJUtX
         wFJrk5F2mmCW3Za/RILnEB8ydglf3FjPdwxpjcq53lZ1+GrhZf9+SIVVEI3UQ0yA7XQe
         by1BweELHaPKsgJWNR2UIYSqsRUQW/4zaiViBQA1XeH2rpkJcv+Rv39K4uONtfiFnSFg
         SXqQ==
X-Forwarded-Encrypted: i=1; AFNElJ+ZwpUQr4F9duS6XEMVXvchWAiHRfh+34tRCiA/2ZFkkP+P/y82R8kCYDPOO5nv8LCCXjp7QQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyeKE7zA7uLCBbgAc1JnY5v5IcNTgueSABzzB/7onAVaMAX+C4K
	3plald6bD60/GqqQTR6hV7NctSDKeQt0OEnOa4lJkay+NenlsYl9c2x4vbxFdkBSU/+nXDErnAz
	8zHiL3uhtAv4S4qY1Rt6oks5Ux2mrdI3OiXtuKltH4XJqIWsHKTEcMbdalfZoq8gT9gnn
X-Gm-Gg: Acq92OFxIX1Kzi7lU87U7CGOanoJfwfGxihcExgEpk32LHeD7jWWFUpZZlULpDHTrxd
	3JGq9ZaBw0I7efy2P5bkBx6TcRjzan4QFap47IJSR4VeoX2yURqEsmlkQa+7XGqGyB/zcJdLOxb
	562/OW0m2cvdLONBc3BpQJtyrvoyzIHQADcapFuGLKypZFwPsrRwOcK5wCWUuUxocnHdU97/Mw5
	0Lh/kVhLYIj45FfHszH5qNnn2vjZsT3cpT0fiJ13ALEjK0sHLatx/6l5l+RyN1uKiFtMZo35NQI
	xQvwEEx3n0UFTkAfSM1HgA3+Rgd4R9teDr7l3mzWEL5rFsoJBaUdr7FWLfS2SE/3F9MqLR0ZZXO
	V9Wr6l2nn6kXzOSFmhp/ElBQm9VDrZA0nVcilSHnnkPjTd73kiQ==
X-Received: by 2002:a17:902:d4cf:b0:2bf:77b2:8b2d with SMTP id d9443c01a7336-2c4130100a2mr158666185ad.30.1781529951403;
        Mon, 15 Jun 2026 06:25:51 -0700 (PDT)
X-Received: by 2002:a17:902:d4cf:b0:2bf:77b2:8b2d with SMTP id d9443c01a7336-2c4130100a2mr158665745ad.30.1781529950823;
        Mon, 15 Jun 2026 06:25:50 -0700 (PDT)
Received: from [10.219.57.228] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42f7c58c3sm104350545ad.23.2026.06.15.06.25.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 06:25:50 -0700 (PDT)
Message-ID: <8518a085-b8b7-4ee6-b08c-8dde3971a6f1@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 18:55:45 +0530
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
X-Authority-Analysis: v=2.4 cv=V5tNF+ni c=1 sm=1 tr=0 ts=6a2ffd60 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=he2KC8_JSkmjwAK-aeQA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: LqURxZEtTWYkBNEeio612xLG4Lz1_2_R
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE0MSBTYWx0ZWRfX5/QVdNIzsgaV
 Wj2E26y3sN0VeuMRw2tg/Ozmgnc4DGL84lncYLVNhN/bnUVZlGfCvgle6lhi85xh4ku4E+ucuPl
 stQJ2dod1uJrLGsWnOymslCNi2rubuw=
X-Proofpoint-ORIG-GUID: LqURxZEtTWYkBNEeio612xLG4Lz1_2_R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE0MSBTYWx0ZWRfX89s6uTDyC4VT
 hKamgivE+WehCd/XwksJTb71mnOrc5WR6d7fYM05vLoGqa6xgxGXE4RpRDEolOZCWCoz+rm45+a
 HynsZj5JFwuesJR8/3ojw2En3ey3ovuzDdpRqf3vl4F/+I4WOzdp3QG+SOprhpxQDEEJ65Mv7xi
 dpgd8P1e0EEpldAyFqz8mFJ94wO3zJqbzuD57Ma82r4R56ulLwhEK1y/HXq9yUpJ2dtc5xppyFg
 C1um+fOpEOq/kODKTEoTm6HHcA/2P7Ndngn+3p2Bgi6AMukXPNTunI6rl6ONI6KRJFMAUE3RH0B
 p6/WtT7A2+oFI49X7sTDNpUH4PeBz1zrmSVfhyN3IEcDQ37BXr1Ie/9Xy5dpZe7Uyz6MmN+wXdY
 IPBuVCLphu0Oc95xPYfxXClyuW2A8XA/MgpNtYq3xHG67a3NFZ2ObE6hafzHwCyddaX3a4eqUZx
 2zbaEPpDtycIXioiSgg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_03,2026-06-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150141



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

<Apologies, missed to respond to this query>
Yes for TCU, it needs to only have a vote on GEM_NOC interconnect
while accessing the DDR in downstream path (client->TCU->DDR), which we 
are addressing here.
Hence it's only one icc path in question here.

Thanks & regards,
Bibek

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
>> +		WARN_ON(icc_set_bw(smmu->icc_path, ARM_SMMU_ICC_AVG_BW,
>> +				   ARM_SMMU_ICC_PEAK_BW_HIGH));
> 
> WARN_ON_ONCE()?
> 
> Pass the error to the caller.
> 
> 
>> +}
>> +
>> +static void arm_smmu_icc_disable(struct arm_smmu_device *smmu)
>> +{
>> +	if (smmu->icc_path)
> 
> Drop the if.
> 
>> +		WARN_ON(icc_set_bw(smmu->icc_path, ARM_SMMU_ICC_AVG_BW,
>> +				   ARM_SMMU_ICC_PEAK_BW_LOW));
> 
> Pass the error to the caller.
> 
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
>> +	}
>>   
>>   	clk_bulk_unprepare(smmu->num_clks, smmu->clks);
>>   }
> 

