Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2667C40D59E
	for <iommu@lists.linux.dev>; Tue,  7 Jul 2026 12:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783428243; cv=none; b=mOA/XfEpApDT2B5YLQofeCsYZY//vjcTdzxttt4VqJQxOWJ6sqV7jJRrcAGTcW5pWzpQIy+i6moc3eI7Rpa/dlU9qy7uoPSIZfrYES+Vk+1P5oNLKfRtk0uIaUNzwzuUXqXTzzITbY7pK3D4SqTPw3/E8tzpcAcKhw46uw1ruOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783428243; c=relaxed/simple;
	bh=jj2vRusPH5dQvYdLb63Wzcj6U93bufwVr67iZ8YvRfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L7UA5CwxQXWEgn20D23DvUcqCGKGAAxeWW7p4G628dJPzenHdD5nl8EcbyGJhMwz+AXlNnULQ+AVXbjMPA2YdvVjA55HIpi3B8PPp48Cwf9kqpNe7M/zS5VMPhH3lUOmZcydgs0MQ17Yyb7OYXj+cvrQvZcckDkwZS/6qXDUa+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XD7NvtCv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d0G1HMuf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XD7NvtCv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d0G1HMuf"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 667C8stx3676438
	for <iommu@lists.linux.dev>; Tue, 7 Jul 2026 12:43:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jsF8+lnCV59+0yqeWXdSHV6D3xLFbynXeMN7huNriQ0=; b=XD7NvtCvt+ciicLc
	SFxlsBX3lxxlCeJzhe7+FCQ7sllI9nmp83Wp7Q5Sdw/jmrb5rQBlLklY94ke8uxl
	K6pKpodACkGCwZANRoY/ahbVze0XEd0WNFcHhLwgU45NyWXU71Lmy0HjRcqBT1/2
	3Us/ZWIr7YBgPOnRx+bZ6X4v/YQLBykVEJDkInXoliJRFKkAS5aeKDAGa9+eRVFX
	Pmfneoxro2uCyK3yJpFMhoyo8ImDUV4ajCP+8UxV1LpodyHlMaOY+ojAQ8Y6Gkz+
	jxvu/VCOpPonyiTABDAOLAeapPcB7X82j1ji7/KjywSz0hc9DpPkkJ65jwHRwfOp
	nEXIpg==
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8t15a08q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 07 Jul 2026 12:43:59 +0000 (GMT)
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-6a13e51ee7fso6431796eaf.2
        for <iommu@lists.linux.dev>; Tue, 07 Jul 2026 05:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783428238; x=1784033038; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jsF8+lnCV59+0yqeWXdSHV6D3xLFbynXeMN7huNriQ0=;
        b=d0G1HMufKoDEjDdU7JH7qCZtPtuQNrcSx9/uHj8RD3ItVFik/ekKMlMMOv/RFnqs3b
         wEkKmZbfwTTAnnLz2ylKHejw3GLzXhflGjf8nolT4naaGrkU/1xYZ/zSZmUu51DnYz7v
         Z4DnJT2uF1Clx+UkFQWCxG2YuwZM2rnB2h2Yhgvg66UaID3AseufWIBEhAhnhGZrc9Ba
         hny6O37lsd472WVTWGEeHm8MZs9otBbgQp+7aq7GiCdvspi2j59qGTG+lI8gwsQPtQNW
         6xqeGdRDwwagq9DraTnLv9AYgl6vUclwKSMBUfyL1UvykpsEkKHPWAeKYQ2IIiotV4my
         e2Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783428238; x=1784033038;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jsF8+lnCV59+0yqeWXdSHV6D3xLFbynXeMN7huNriQ0=;
        b=lCSxjJCzd0HZl0OFsS/hBxxRIa/ymfZyn0VwAP1FYtTbV0V42TF2m0NqW0bmbAldc1
         H9cRL3LtLjpvpdtmjYKGIA+pU4pTZqyTBiJI+j7eIKMCa+lHHYxMs2FljtK+Bi44Ouy6
         zbbqXFe9r8w1sb8ssWArzGGZqpTLW1AHhNa3orhZ7L7uADEWfG5bnAhtZ6XKHtOrMlMY
         8bn/eMAhAowxQKMy8dw2TkbZkJ8fJ5ZVAwM9JC654m04ajhTX58MiiefDBZQW9dcdw23
         BUD83bmUoTyGeKoSI98hoW/K9vwcO388uhW2VGnMEcs9JW5E/s5X2Qu14TOSfaKdUkip
         AeuA==
X-Forwarded-Encrypted: i=1; AFNElJ9uIxRSZtQiV1BG1FLPPitsTFDQYmcmidv2a1lneGY9ywFQDqlRXSNt3kj4I7mAUVV6r36FGg==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywc3ueRPbNq3J1Ci8xyeB+lTbUw9j4SuNoTx8i0rnu2+N+9zDPx
	ClVrgJV6J80IuIK+W5NHMKlVHAcalc94DecwXl8N3JaqQZviX3YEEIzcYOsOxvLSSUugc+YnQFQ
	97j3QZ4LS0bheesHaxuthiw4MwBDfXhuMEmPkA/U/nHPPiJkrJgA8KEGiwA==
X-Gm-Gg: AfdE7clSGJy4GmXTtDFmt3syD7ztTpguh6FTaUQ8RQsSscTFneu2QxTAS2UUfK0p7jX
	mmuB6dz7hn0Hei2l3C8pASpV5mqjtDcoZjRpT/wShwEZuwIvZxmA6OYWHwiRnCV0x0Gf2lZL8aD
	nzqsnoi857kQu69o+hq+wxWP+IXbvanMpRPpgpiQGnYuuaPTX98uqlwivKullVmNU2B7uVyPWIR
	VD7dDlVaDg+dayN7jovk5Jnlc5SlDS2tnvXIe3e4+juxKofMINgh3WC4Wx6vYdRESrjisRUVfru
	ryAU//ISmqdDOnYSz+DhgOJzM05ShgQqEf8CGxF82WRpoMDvYxdOmrS7t8zrU2whhRUvEatTl4D
	oo7sGRRRaiaOEJ7qZt4/UlAkdWcV+tA+ESnR8Uvg=
X-Received: by 2002:a05:6820:f004:b0:6a0:f3b5:12a2 with SMTP id 006d021491bc7-6a3553978e6mr3648877eaf.20.1783428237552;
        Tue, 07 Jul 2026 05:43:57 -0700 (PDT)
X-Received: by 2002:a05:6820:f004:b0:6a0:f3b5:12a2 with SMTP id 006d021491bc7-6a3553978e6mr3648859eaf.20.1783428237043;
        Tue, 07 Jul 2026 05:43:57 -0700 (PDT)
Received: from [10.219.56.198] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a31fd2cf7asm8442320eaf.4.2026.07.07.05.43.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 05:43:56 -0700 (PDT)
Message-ID: <8fcdb7be-0bb4-4cf5-b969-6e5b0b516f87@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 18:13:50 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] iommu/arm-smmu: Add interconnect bandwidth voting
 support
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20260706-smmu_interconnect_addition-v3-0-afdca0125a65@oss.qualcomm.com>
 <20260706-smmu_interconnect_addition-v3-2-afdca0125a65@oss.qualcomm.com>
 <lltyynsswbeqdgpl4bqbil5ohgs6v25pvd5cqfuh36nrzgwv7o@u54exappwjes>
Content-Language: en-US
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
In-Reply-To: <lltyynsswbeqdgpl4bqbil5ohgs6v25pvd5cqfuh36nrzgwv7o@u54exappwjes>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: eGUH7TsjdlnnlnTE_YFy0YzZ4C9otbwH
X-Authority-Analysis: v=2.4 cv=HstG3UTS c=1 sm=1 tr=0 ts=6a4cf48f cx=c_pps
 a=lVi5GcDxkcJcfCmEjVJoaw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=RRvI01qy6g1rNRViaBEA:9 a=QEXdDO2ut3YA:10
 a=rBiNkAWo9uy_4UTK5NWh:22
X-Proofpoint-ORIG-GUID: eGUH7TsjdlnnlnTE_YFy0YzZ4C9otbwH
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEyMyBTYWx0ZWRfX5T0uCmh+vse8
 rulz/YTe7bc3easa85PnHvpg+Tk4IkLmb0jZrgFIzWYUeVJlwM2uMJYf8TXGu4SABCX3O/5+4BB
 D7/TQLJNc++MGUhbTSXyYJHRWtdDFLU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEyMyBTYWx0ZWRfX6xF94GmJauoC
 gOmqhWmSX56wfJac6UB/YpivE3UpNVB/7GYQC7Y5YY1ThpoyvPgbcAqtLWP1eVvBq3P3qlkyzQQ
 O4MwPd3P/OowpaGQusCismaHEf+7FnBu5M49l7rGFyBDsX0jJf303VZKiAr3oXVQ68IDuw+a3xq
 tiyYeI5foHLvXr+K5GRpU0SLv6Wq4YOW9HSC/3plUEDkGUAGDyjTdGjub5sW8UMdidOKUKcIl3B
 6LBJiJfeaR6ilpOph0cxZzJUccgRU6U1HUMpxOF69odBa6o3wgG8NUbMVxtIJFDxfrT4KcJarv8
 m0b0RZbwMrUC88DfXmOr5S4zrpkzNdFvF1ltmSXs47NynuiX1d8+zW/zdE/G1d+jDPYzDCaZv6f
 8exRHPnv3yUJyvxNBpxMyDxaq+rPrF7KebQlACkrHO3fRMJae1FWoHnFcjjdQR7O/XOPSnpW0VK
 dggyEtNX2xWLJ1S/ahQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070123



On 7/6/2026 11:10 PM, Dmitry Baryshkov wrote:
> On Mon, Jul 06, 2026 at 10:26:35PM +0530, Bibek Kumar Patro wrote:
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
>>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 55 +++++++++++++++++++++++++++++-
>>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h |  3 ++
>>   drivers/iommu/arm/arm-smmu/arm-smmu.c      | 27 +++++++++++++--
>>   drivers/iommu/arm/arm-smmu/arm-smmu.h      |  2 ++
>>   4 files changed, 84 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> index e2c914fccd6f..5133d3ab023a 100644
>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> @@ -6,6 +6,7 @@
>>   #include <linux/acpi.h>
>>   #include <linux/adreno-smmu-priv.h>
>>   #include <linux/delay.h>
>> +#include <linux/interconnect.h>
>>   #include <linux/of_device.h>
>>   #include <linux/firmware/qcom/qcom_scm.h>
>>   #include <linux/platform_device.h>
>> @@ -607,6 +608,45 @@ static int qcom_sdm845_smmu500_reset(struct arm_smmu_device *smmu)
>>   	return ret;
>>   }
>>   
>> +static int qcom_adreno_smmu_icc_init(struct arm_smmu_device *smmu)
>> +{
>> +	struct qcom_smmu *qsmmu = container_of(smmu, struct qcom_smmu, smmu);
>> +	int err;
>> +
>> +	qsmmu->icc_path = devm_of_icc_get(smmu->dev, NULL);
>> +	if (!IS_ERR(qsmmu->icc_path))
>> +		return 0;
>> +
>> +	err = PTR_ERR(qsmmu->icc_path);
>> +
>> +	if (err == -ENODEV) {
>> +		qsmmu->icc_path = NULL;
>> +		return 0;
>> +	}
>> +	return dev_err_probe(smmu->dev, err,
>> +			     "failed to get interconnect path\n");
>> +}
>> +
>> +static int qcom_adreno_smmu_runtime_resume(struct arm_smmu_device *smmu)
>> +{
>> +	struct qcom_smmu *qsmmu = container_of(smmu, struct qcom_smmu, smmu);
>> +	int ret;
>> +
>> +	ret = icc_set_bw(qsmmu->icc_path, 0, 1);
>> +	WARN_ON_ONCE(ret);
>> +	return ret;
>> +}
>> +
>> +static int qcom_adreno_smmu_runtime_suspend(struct arm_smmu_device *smmu)
>> +{
>> +	struct qcom_smmu *qsmmu = container_of(smmu, struct qcom_smmu, smmu);
>> +	int ret;
>> +
>> +	ret = icc_set_bw(qsmmu->icc_path, 0, 0);
>> +	WARN_ON_ONCE(ret);
>> +	return ret;
>> +}
>> +
>>   static const struct arm_smmu_impl qcom_smmu_v2_impl = {
>>   	.init_context = qcom_smmu_init_context,
>>   	.cfg_probe = qcom_smmu_cfg_probe,
>> @@ -648,6 +688,8 @@ static const struct arm_smmu_impl qcom_adreno_smmu_v2_impl = {
>>   	.alloc_context_bank = qcom_adreno_smmu_alloc_context_bank,
>>   	.write_sctlr = qcom_adreno_smmu_write_sctlr,
>>   	.tlb_sync = qcom_smmu_tlb_sync,
>> +	.runtime_resume = qcom_adreno_smmu_runtime_resume,
>> +	.runtime_suspend = qcom_adreno_smmu_runtime_suspend,
>>   	.context_fault_needs_threaded_irq = true,
>>   };
>>   
>> @@ -658,6 +700,8 @@ static const struct arm_smmu_impl qcom_adreno_smmu_500_impl = {
>>   	.alloc_context_bank = qcom_adreno_smmu_alloc_context_bank,
>>   	.write_sctlr = qcom_adreno_smmu_write_sctlr,
>>   	.tlb_sync = qcom_smmu_tlb_sync,
>> +	.runtime_resume = qcom_adreno_smmu_runtime_resume,
>> +	.runtime_suspend = qcom_adreno_smmu_runtime_suspend,
>>   	.context_fault_needs_threaded_irq = true,
>>   };
>>   
>> @@ -667,11 +711,14 @@ static struct arm_smmu_device *qcom_smmu_create(struct arm_smmu_device *smmu,
>>   	const struct device_node *np = smmu->dev->of_node;
>>   	const struct arm_smmu_impl *impl;
>>   	struct qcom_smmu *qsmmu;
>> +	bool is_adreno_smmu;
>> +	int ret;
>>   
>>   	if (!data)
>>   		return ERR_PTR(-EINVAL);
>>   
>> -	if (np && of_device_is_compatible(np, "qcom,adreno-smmu"))
>> +	is_adreno_smmu = np && of_device_is_compatible(np, "qcom,adreno-smmu");
>> +	if (is_adreno_smmu)
>>   		impl = data->adreno_impl;
>>   	else
>>   		impl = data->impl;
>> @@ -691,6 +738,12 @@ static struct arm_smmu_device *qcom_smmu_create(struct arm_smmu_device *smmu,
>>   	qsmmu->smmu.impl = impl;
>>   	qsmmu->data = data;
>>   
>> +	if (is_adreno_smmu) {
>> +		ret = qcom_adreno_smmu_icc_init(&qsmmu->smmu);
>> +		if (ret)
>> +			return ERR_PTR(ret);
>> +	}
> 
> Move this to a runtime hook to be declared in *data.
> 

Ack, will implement this in next revision.
<Missed to make this a runtime hook as it was not being used
anywhere else outside the current scope of this file.>

>> +
>>   	return &qsmmu->smmu;
>>   }
>>   
>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
>> index 8addd453f5f1..6835b40339ce 100644
>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
>> @@ -6,12 +6,15 @@
>>   #ifndef _ARM_SMMU_QCOM_H
>>   #define _ARM_SMMU_QCOM_H
>>   
>> +#include <linux/interconnect.h>
> 
> Not necessary here. Just forward-declare the struct.
> 

Ack, will take care of this in next revision.

Thanks & regards,
Bibek

>> +
>>   struct qcom_smmu {
>>   	struct arm_smmu_device smmu;
>>   	const struct qcom_smmu_match_data *data;
>>   	bool bypass_quirk;
>>   	u8 bypass_cbndx;
>>   	u32 stall_enabled;
>> +	struct icc_path *icc_path;
>>   };
>>   
>>   enum qcom_smmu_impl_reg_offset {
>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> index 0bd21d206eb3..a27804e15738 100644
>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> @@ -2189,6 +2189,14 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>>   	if (err)
>>   		return err;
>>   
>> +	if (smmu->impl && smmu->impl->runtime_resume) {
>> +		err = smmu->impl->runtime_resume(smmu);
>> +		if (err) {
>> +			clk_bulk_disable_unprepare(smmu->num_clks, smmu->clks);
>> +			return err;
>> +		}
>> +	}
>> +
>>   	err = arm_smmu_device_cfg_probe(smmu);
>>   	if (err)
>>   		return err;
>> @@ -2273,8 +2281,11 @@ static void arm_smmu_device_shutdown(struct platform_device *pdev)
>>   
>>   	if (pm_runtime_enabled(smmu->dev))
>>   		pm_runtime_force_suspend(smmu->dev);
>> -	else
>> +	else {
>>   		clk_bulk_disable(smmu->num_clks, smmu->clks);
>> +		if (smmu->impl && smmu->impl->runtime_suspend)
>> +			smmu->impl->runtime_suspend(smmu);
>> +	}
>>   
>>   	clk_bulk_unprepare(smmu->num_clks, smmu->clks);
>>   }
>> @@ -2294,9 +2305,18 @@ static int __maybe_unused arm_smmu_runtime_resume(struct device *dev)
>>   	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
>>   	int ret;
>>   
>> +	if (smmu->impl && smmu->impl->runtime_resume) {
>> +		ret = smmu->impl->runtime_resume(smmu);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>>   	ret = clk_bulk_enable(smmu->num_clks, smmu->clks);
>> -	if (ret)
>> +	if (ret) {
>> +		if (smmu->impl && smmu->impl->runtime_suspend)
>> +			smmu->impl->runtime_suspend(smmu);
>>   		return ret;
>> +	}
>>   
>>   	arm_smmu_device_reset(smmu);
>>   
>> @@ -2309,6 +2329,9 @@ static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
>>   
>>   	clk_bulk_disable(smmu->num_clks, smmu->clks);
>>   
>> +	if (smmu->impl && smmu->impl->runtime_suspend)
>> +		return smmu->impl->runtime_suspend(smmu);
>> +
>>   	return 0;
>>   }
>>   
>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
>> index 26d2e33cd328..ed08f86cf99d 100644
>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
>> @@ -455,6 +455,8 @@ struct arm_smmu_impl {
>>   	void (*write_s2cr)(struct arm_smmu_device *smmu, int idx);
>>   	void (*write_sctlr)(struct arm_smmu_device *smmu, int idx, u32 reg);
>>   	void (*probe_finalize)(struct arm_smmu_device *smmu, struct device *dev);
>> +	int (*runtime_resume)(struct arm_smmu_device *smmu);
>> +	int (*runtime_suspend)(struct arm_smmu_device *smmu);
>>   };
>>   
>>   #define INVALID_SMENDX			-1
>>
>> -- 
>> 2.34.1
>>
> 

