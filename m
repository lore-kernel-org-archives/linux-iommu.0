Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A163093A6
	for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 15:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776439260; cv=none; b=EpuuTbHrW5zCsbZeCn8VBSGEsyomtuWArZvE0fsbYs0FORp2sZYdrCORJQ17ySC9XrJ9RUldbur/DzbNe/F542k2FTgV2gogOqKEJr4OepgrRlHkkWEXhW2MClE6LLJAmOPCBUq5MJ4UiQnQIy2WDB6AHNShvDXTi9H2V/MtFAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776439260; c=relaxed/simple;
	bh=a7FauC0ZYkCg/2ybLF4UZWeFA6zFWNZD5fVdS0Gd9lk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=raPDhydqh2nvKDH398GGEu06QdZ6+JkVp1kXmux3U+RHkV4Ok+h83YK0lYvUfG07sOKyJmhuyje9rp/1aCeGR3awANXjNORyf32uYP+P46YDQx8L8FDAmsyMh9WrNOiYFjQPR6jJYZlrF8RzD0LErd7UK8Xf8ZuZ4ykYXUs3hQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HteCryr5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MxSO6iQe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HteCryr5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MxSO6iQe"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63HBitlo727598
	for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 15:20:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Gubb6FwF0cLZ4F1DwUMU+nFt6EIaYftlxW5weLzFAN4=; b=HteCryr5VTxV0t64
	EhewlEN9HXGbRgPtIrVbLpYFrJsvPL+X85hGzLRujIY3OqaPkp2EWZpoYMADM2ET
	RKwIudZNz4PV9UvE3veLy2uP2+d6IOczsMlEWYMJmIZRmJzf3sgNr/jYKYKY3bOB
	+L61QIughYETox6zkkFB98SYLLB8MMn5HuZTwdAEnhbF2rRWzx3X7RS4/KNnN1dF
	GgfGGrdjhQMhVQ9UAvJFsz6u4XU4BDFB5aYHFla+LyyoqALMdBYdvmHz383PeTF+
	CsWNQ/jg9XeAv7P5VtfexFcuhBzqCQ4mqCG09beSHWWSZZXzNH9jxd7dgrFjFJ+z
	cWrxaQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dkfyqsu1g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 15:20:57 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2aad5fec175so11198185ad.2
        for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 08:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776439256; x=1777044056; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Gubb6FwF0cLZ4F1DwUMU+nFt6EIaYftlxW5weLzFAN4=;
        b=MxSO6iQe1qiGWn2w4XVX5rJFgsuiCKD/PGIDH+WIdGJUUnm7D8dduGZina4MEeQfb9
         t79iJxO4CGqRoUEhjW3k1ir4SRI7gEfyD2RkyXnuzN2/4ZK7JhfcbrVMq1Px0ZoJ2PMx
         iVfYo9iKdvwfGX89bs/wU8oBIl1huAhNMUwY5ergUyFeKfdstI927RISlKA2x9vZ1xro
         m6sNfYEQEtkvDo0Sol4GeHbpU2YV+sSOD2mTaD2Hyo3tJE3w1qqvo5JHr4uk95ZXICj/
         tndz96BYf8UGFU/sqK4gmxxE3ZvVUChfqNShlXH4bJtsm6LDCvXlBiXtsQ4NpnDZ/vXy
         Uc+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776439256; x=1777044056;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gubb6FwF0cLZ4F1DwUMU+nFt6EIaYftlxW5weLzFAN4=;
        b=PdimLh8oc1gv/7oTBBW2HslZkNZYvJZEPN5z6riBQVC8prM/uCN9SozlZkvh1vM8uc
         TgHrSg3JVddxYGkbmk5eakj/BOL5gy0ey3U9jCSyATFP+Bn6SLwfk8F2iPl8MPp4+lVb
         YG3VaN9J2AWC8nWzAokHKDAHAwsUmt63IyEznYN2W+by/H48RaM1Sg4l8V87Tm+nRVKb
         bb8Xp9HrNaFOPo1aF3VahdQplak8fOHcR4GFjcnPfBQrfGiVQHVcMhSqdRS+350xMjWN
         MK6mJkJPcP7wZk5qAB16jMalsLs9iiT29gcE4BOiUe/FD51WDhiYpJvnYGhb17lOHNHe
         kxXA==
X-Forwarded-Encrypted: i=1; AFNElJ81h36iDAiCFjnBBP/aEEMXToCm3q7aOROH9csfc4gBcli4e4JtxXs4WCF+eERJQZsPLrfHzg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz4k3FJXk5Ebd/IWscYNlDwy+fc3lBK5st7MmSkhX2+zplWm8pV
	OnrTevEicpLKevyLzBWbMj5SBRF6qKgncw4DFdPST0aPDW0Ld5FBTqRgc6KOeRnNdppSVRVIrQ0
	I/iTCH9LD8uJ1qO7EDDTpKcNOfVx1w3gWPoLgDIZTCB/NHtz/5YP16cFJFg==
X-Gm-Gg: AeBDietSA7DwwcLjO+QTbFWLQuA8dUu/pAuS8KHxaOPIdLhiAOMfYApYuZm1e5epPhr
	+i0oIee5jvf3kPrry3v6SVi5rD/9kzTM56z1h7NMhDDmgwuAKsyWFANEerOjpVH2Fwslx8V28Z1
	8q98fcVNTX0qm3BvhwvqlxMmn+7zJLEgAraRpkERXzqg9fmO9Glo8JqmGwiuO7t8ZFcwXBA2KjF
	3ralbmJgSMSTigkmPXjHO/dNLBfkBVs1C6iFLi276NKO1rLJWGbd8A43ZkXkjwDEXkePi8Hl78Q
	78CrqOWBBioeVFJHAnzpNI27GCox9IuVPfOMxn8deIYTENIthRyM/pRVgMSKrrXfS7o0EkQnBq7
	gnxcxmqkJMAJL9JpjvRKUtKluyZUBnJfQmF1hyQZ+7i3hU8DpJ4I2zCuXAkq/ogxB
X-Received: by 2002:a17:902:8b87:b0:2b0:a980:367c with SMTP id d9443c01a7336-2b5f9eb0513mr25693855ad.2.1776439256233;
        Fri, 17 Apr 2026 08:20:56 -0700 (PDT)
X-Received: by 2002:a17:902:8b87:b0:2b0:a980:367c with SMTP id d9443c01a7336-2b5f9eb0513mr25693395ad.2.1776439255583;
        Fri, 17 Apr 2026 08:20:55 -0700 (PDT)
Received: from [10.206.105.200] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab20c4fsm31121345ad.59.2026.04.17.08.20.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2026 08:20:55 -0700 (PDT)
Message-ID: <72badc70-8a49-1bf6-291b-1dcf245b8991@oss.qualcomm.com>
Date: Fri, 17 Apr 2026 20:50:46 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Subject: Re: [PATCH 05/11] media: iris: Enable Secure PAS support with IOMMU
 managed by Linux
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Cc: Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev
References: <20260414-glymur-v1-0-7d3d1cf57b16@oss.qualcomm.com>
 <20260414-glymur-v1-5-7d3d1cf57b16@oss.qualcomm.com>
 <20260414063128.6ass64wfi7nmtzti@hu-mojha-hyd.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260414063128.6ass64wfi7nmtzti@hu-mojha-hyd.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDE1NSBTYWx0ZWRfX0y/Vi41bnksl
 jyBX1IevhnoWpFtPbIGSm3laBW+F4BrKQb6rDxbDZwN65wfYYcp8RFrB/b9fcPtN6eNGrIow+wv
 idPu0wCnzm9QsJJJkkyRlRqeoCUVCemx7bcPjkhoxRJTdSGMrHoiHOx9JCVe6AsN9ufOBQIgx52
 qw+EWfZyGfz8B+31WedsIVGZyeKt1gCFx+ZpS4/Q0dW4o4Fin+QD5NYhzNaEbCv6/oU0Tr2e1sK
 5D1qQFsTqYeCTgP71Ih/mILlMyuurR74M/RkVxrCLRKp0Y7V1UT71VXMvqowhtv6FiHZtnLiORx
 +3/4If0nnoyt4U0X/wuDuKyrTmrvtkI6IDfO4pRkjEwwoLV8fsQpdJES+iqps+zMeLctuxEbpVU
 JZhdOs5AUyeS3xBZ5J8fod2YfjrUCeouBC8RGZMfXtE/kaY691+4GYA6sysokwO79iPTGmUnRcr
 t7/2jHH6VBtjGRvfNuQ==
X-Authority-Analysis: v=2.4 cv=BZPoFLt2 c=1 sm=1 tr=0 ts=69e24fd9 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=tkXzD9pcQE_IdLLthRAA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: Cnd--4hL1P-xOJd14J4Cs2CIIT4HeeeJ
X-Proofpoint-GUID: Cnd--4hL1P-xOJd14J4Cs2CIIT4HeeeJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604170155


On 4/14/2026 12:01 PM, Mukesh Ojha wrote:
> On Tue, Apr 14, 2026 at 10:30:01AM +0530, Vishnu Reddy wrote:
>> From: Mukesh Ojha<mukesh.ojha@oss.qualcomm.com>
>>
>> Most Qualcomm platforms feature a proprietary hypervisor (such as Gunyah
>> or QHEE), which typically handles IOMMU configuration. This includes
>> mapping memory regions and device memory resources for remote processors
>> by intercepting qcom_scm_pas_auth_and_reset() calls. These mappings are
>> later removed during teardown. Additionally, SHM bridge setup is required
>> to enable memory protection for both remoteproc metadata and its memory
>> regions.
>>
>> When the hypervisor is absent, the operating system must perform these
>> configurations instead.
>>
>> Support for handling IOMMU and SHM setup in the absence of a hypervisor
>> is now in place. Extend the Iris driver to enable this functionality on
>> platforms where IOMMU is managed by Linux (i.e., non-Gunyah, non-QHEE).
>>
>> Additionally, the Iris driver must map the firmware and its required
>> resources to the firmware SID, which is now specified via iommu-map in
>> the device tree.
>>
>> Co-developed-by: Vikash Garodia<vikash.garodia@oss.qualcomm.com>
>> Signed-off-by: Vikash Garodia<vikash.garodia@oss.qualcomm.com>
>> Signed-off-by: Mukesh Ojha<mukesh.ojha@oss.qualcomm.com>
>> Signed-off-by: Vishnu Reddy<busanna.reddy@oss.qualcomm.com>
>> ---
>>   drivers/media/platform/qcom/iris/iris_core.h     |  4 ++
>>   drivers/media/platform/qcom/iris/iris_firmware.c | 71 +++++++++++++++++++++---
>>   2 files changed, 66 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/media/platform/qcom/iris/iris_core.h b/drivers/media/platform/qcom/iris/iris_core.h
>> index fb194c967ad4..aa7abef6f0e0 100644
>> --- a/drivers/media/platform/qcom/iris/iris_core.h
>> +++ b/drivers/media/platform/qcom/iris/iris_core.h
>> @@ -34,6 +34,8 @@ enum domain_type {
>>    * struct iris_core - holds core parameters valid for all instances
>>    *
>>    * @dev: reference to device structure
>> + * @dev_fw: reference to the context bank device used for firmware load
>> + * @ctx_fw: SCM PAS context for authenticated firmware load and shutdown
>>    * @reg_base: IO memory base address
>>    * @irq: iris irq
>>    * @v4l2_dev: a holder for v4l2 device structure
>> @@ -77,6 +79,8 @@ enum domain_type {
>>   
>>   struct iris_core {
>>   	struct device				*dev;
>> +	struct device				*dev_fw;
>> +	struct qcom_scm_pas_context		*ctx_fw;
> fw_dev suits better and ctx_fw is always for firmware, maybe pas_ctx is
> better.

Ack

>>   	void __iomem				*reg_base;
>>   	int					irq;
>>   	struct v4l2_device			v4l2_dev;
>> diff --git a/drivers/media/platform/qcom/iris/iris_firmware.c b/drivers/media/platform/qcom/iris/iris_firmware.c
>> index 5f408024e967..93d77996c83f 100644
>> --- a/drivers/media/platform/qcom/iris/iris_firmware.c
>> +++ b/drivers/media/platform/qcom/iris/iris_firmware.c
>> @@ -5,6 +5,7 @@
>>   
>>   #include <linux/firmware.h>
>>   #include <linux/firmware/qcom/qcom_scm.h>
>> +#include <linux/iommu.h>
>>   #include <linux/of_address.h>
>>   #include <linux/of_reserved_mem.h>
>>   #include <linux/soc/qcom/mdt_loader.h>
>> @@ -13,12 +14,15 @@
>>   #include "iris_firmware.h"
>>   
>>   #define MAX_FIRMWARE_NAME_SIZE	128
>> +#define IRIS_FW_START_ADDR	0
>>   
>>   static int iris_load_fw_to_memory(struct iris_core *core, const char *fw_name)
>>   {
>> +	struct device *dev = core->dev_fw ? core->dev_fw : core->dev;
>>   	u32 pas_id = core->iris_platform_data->pas_id;
>>   	const struct firmware *firmware = NULL;
>> -	struct device *dev = core->dev;
>> +	struct qcom_scm_pas_context *ctx_fw;
>> +	struct iommu_domain *domain;
>>   	struct resource res;
>>   	phys_addr_t mem_phys;
>>   	size_t res_size;
>> @@ -29,13 +33,17 @@ static int iris_load_fw_to_memory(struct iris_core *core, const char *fw_name)
>>   	if (strlen(fw_name) >= MAX_FIRMWARE_NAME_SIZE - 4)
>>   		return -EINVAL;
>>   
>> -	ret = of_reserved_mem_region_to_resource(dev->of_node, 0, &res);
>> +	ret = of_reserved_mem_region_to_resource(core->dev->of_node, 0, &res);
>>   	if (ret)
>>   		return ret;
>>   
>>   	mem_phys = res.start;
>>   	res_size = resource_size(&res);
>>   
>> +	ctx_fw = devm_qcom_scm_pas_context_alloc(dev, pas_id, mem_phys, res_size);
>> +	if (IS_ERR(ctx_fw))
>> +		return PTR_ERR(ctx_fw);
>> +
>>   	ret = request_firmware(&firmware, fw_name, dev);
>>   	if (ret)
>>   		return ret;
>> @@ -52,9 +60,27 @@ static int iris_load_fw_to_memory(struct iris_core *core, const char *fw_name)
>>   		goto err_release_fw;
>>   	}
>>   
>> -	ret = qcom_mdt_load(dev, firmware, fw_name,
>> -			    pas_id, mem_virt, mem_phys, res_size, NULL);
>> +	ctx_fw->use_tzmem = !!core->dev_fw;
>> +	ret = qcom_mdt_pas_load(ctx_fw, firmware, fw_name, mem_virt, NULL);
>> +	if (ret)
>> +		goto err_mem_unmap;
>> +
>> +	if (ctx_fw->use_tzmem) {
>> +		domain = iommu_get_domain_for_dev(core->dev_fw);
>> +		if (!domain) {
>> +			ret = -ENODEV;
>> +			goto err_mem_unmap;
>> +		}
>> +
>> +		ret = iommu_map(domain, IRIS_FW_START_ADDR, mem_phys, res_size,
>> +				IOMMU_READ | IOMMU_WRITE | IOMMU_PRIV, GFP_KERNEL);
>> +		if (ret)
>> +			goto err_mem_unmap;
>> +	}
>>   
>> +	core->ctx_fw = ctx_fw;
>> +
>> +err_mem_unmap:
>>   	memunmap(mem_virt);
>>   err_release_fw:
>>   	release_firmware(firmware);
>> @@ -62,6 +88,19 @@ static int iris_load_fw_to_memory(struct iris_core *core, const char *fw_name)
>>   	return ret;
>>   }
>>   
>> +static void iris_fw_iommu_unmap(struct iris_core *core)
>> +{
>> +	bool use_tzmem = core->ctx_fw->use_tzmem;
>> +	struct iommu_domain *domain;
>> +
>> +	if (!use_tzmem)
>> +		return;
>> +
>> +	domain = iommu_get_domain_for_dev(core->dev_fw);
>> +	if (domain)
>> +		iommu_unmap(domain, IRIS_FW_START_ADDR, core->ctx_fw->mem_size);
>> +}
>> +
>>   int iris_fw_load(struct iris_core *core)
>>   {
>>   	const struct tz_cp_config *cp_config;
>> @@ -79,10 +118,10 @@ int iris_fw_load(struct iris_core *core)
>>   		return -ENOMEM;
>>   	}
>>   
>> -	ret = qcom_scm_pas_auth_and_reset(core->iris_platform_data->pas_id);
>> +	ret = qcom_scm_pas_prepare_and_auth_reset(core->ctx_fw);
>>   	if (ret)  {
>>   		dev_err(core->dev, "auth and reset failed: %d\n", ret);
>> -		return ret;
>> +		goto err_unmap;
>>   	}
>>   
>>   	for (i = 0; i < core->iris_platform_data->tz_cp_config_data_size; i++) {
>> @@ -93,17 +132,31 @@ int iris_fw_load(struct iris_core *core)
>>   						     cp_config->cp_nonpixel_size);
>>   		if (ret) {
>>   			dev_err(core->dev, "qcom_scm_mem_protect_video_var failed: %d\n", ret);
>> -			qcom_scm_pas_shutdown(core->iris_platform_data->pas_id);
>> -			return ret;
>> +			goto err_pas_shutdown;
>>   		}
>>   	}
>>   
>> +	return 0;
>> +
>> +err_pas_shutdown:
>> +	qcom_scm_pas_shutdown(core->ctx_fw->pas_id);
>> +err_unmap:
>> +	iris_fw_iommu_unmap(core);
>> +
>>   	return ret;
>>   }
>>   
>>   int iris_fw_unload(struct iris_core *core)
>>   {
>> -	return qcom_scm_pas_shutdown(core->iris_platform_data->pas_id);
>> +	int ret;
>> +
>> +	ret = qcom_scm_pas_shutdown(core->ctx_fw->pas_id);
>> +	if (ret)
>> +		return ret;
>> +
>> +	iris_fw_iommu_unmap(core);
>> +
>> +	return ret;
>>   }
>>   
>>   int iris_set_hw_state(struct iris_core *core, bool resume)
>>
>> -- 
>> 2.34.1
>>
