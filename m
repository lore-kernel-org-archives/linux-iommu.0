Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794464044;
	b=DN9s5zEG3ociodwHDtEWtNd+Dx6LjxLJA+emZDCTjHCvuqvqpRVZAanYWkeVhUoreWJc
	 affM2RQ9ViGX6UXwnNmus06cDScXgD/fqntYiSECuj/4tOUPy/G7sms1Kme07DZPHwg8E
	 3x/fE8MyURUFWtiOiAOWbMa57JTkshEjFf9tLqhi1jay+ghxZXnZX+zwku8QtjmkXWhfP
	 7c5VvvuicU80yEQwFWsbkyW1GJVvNisqPlyhELIkumEHmTmjOdB41a99XoSe4rye8xJVK
	 GA4lfBjyZHogZ4JK+ak/zuqeyZMgGDXmFkxxN4Hm0JGUY1IWQqi3ppTzT3rHdSvu0vA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794464044;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-Proofpoint-Reinject:
	 X-QCInternal:X-QCInternal:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=/osIbHmFt4J7QJbFux8V6dVqtquVgZjnHNZgBl0VYa8=;
	b=hKP772bsZgFC+kiGM4m+hN+I46XTqhtnU0Cfi4SHqdgzDttxBmN6kE7l+HthuQY+aloS
	 EwkYg3Lyjd1mCcIxNjt3idbYV6RPG4cRJmjQOECTAjd+eXDRF5Zfl1eVHjY/qTJsCIvCZ
	 f+uDrnDGiWxzjoxO0krtL5/dwHiW1JUTj2/aA/aByyk5ySs1xQgksN1E+CZYJ+PF2cOtw
	 glowbI083Aruj9RxROV1W/pf3Ad0Vcv1aGIX4AVBcIoP0tBk9SCVmRXW80AFuOD9+gOYc
	 uINrIse9TmxcTXoYJbIulK0B0LNnjkuyrfz6JMaFEwwetGIOisgb+BB7WImoZi5tmjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DDNgAmZO;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A28606A31C;
	Thu, 12 Nov 2026 06:14:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43A28606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DDNgAmZO
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC4m0ws3893195;
	Thu, 12 Nov 2026 06:13:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=/osIbHmFt4J7QJbFux8V6dVq
	tquVgZjnHNZgBl0VYa8=; b=DDNgAmZOpqUl43zoX6MNTLLFqeYiyo5XBuvIRvP4
	wg/ZlQ6pICc+5TomMXJ04YQT2BTmrAIVUPKGTlMf2BuAxtMg8rv7swEpT7ZSqG07
	+C5Far7hNnBPumcPQAKLUsoqsm4/6+AVcI36vuGvgzNOdpHK1MUkjFnNZ9227A2U
	bBqmlaUQQJN6RYMJRJ5xv0AJ380QKB9GbqcijfrNnXjqhK3sxDNUlJ9n0Xr3Oi/2
	NAm3zwNYiLLkl5dEiYz/GWOc8czLkY5sSFauqtiL7rh3vkxKxgosPI9oRNU0yDI7
	PgIZiqLXpmcPq1F30rhMHf1ybpYxnxL6fPXmhjrwWkFJgw==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw6re08dp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 06:13:52 +0000 (GMT)
Received: from pps.filterd (apblrppmta01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC6DnNZ1791902;
	Thu, 12 Nov 2026 06:13:49 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-bibekkum-hyd.qualcomm.com [10.147.243.199])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 6AC6Dnvf1791896
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 06:13:49 +0000 (GMT)
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 4253010)
	id E10B75FA; Thu, 12 Nov 2026 11:43:47 +0530 (+0530)
Date: Thu, 12 Nov 2026 11:43:47 +0530
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, iommu@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: arm-smmu-qcom: Skip fault-info reads when
 suspended
Message-ID: <20261112061347.oxh6qg6i53v3ixuj@hu-bibekkum-hyd.qualcomm.com>
References: <20260912-priv_call_runtime_handlers-v1-1-fc0c3a17523f@oss.qualcomm.com>
 <fe22fb3d-77dd-4b34-9dd8-aafe11f36988@arm.com>
 <20260915125758.ekt323jhwsiis6bp@hu-bibekkum-hyd.qualcomm.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260915125758.ekt323jhwsiis6bp@hu-bibekkum-hyd.qualcomm.com>
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-ORIG-GUID: 5NLhUop60S9Wfdljujw7SLVCY7yQ6pEr
X-Proofpoint-GUID: 5NLhUop60S9Wfdljujw7SLVCY7yQ6pEr
X-Authority-Analysis: v=2.4 cv=NJhAaE6g c=1 sm=1 tr=0 ts=6af55921 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=NEAV23lmAAAA:8 a=w0EGknLvMgiScxiyWWQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAyNCBTYWx0ZWRfX0R3T51rCWELb
 p0Kt9an0W42Xbs2FWx/zvKA6Mf6DOEJ/4dNXNUcm/zC5til49DCPKbv238r1i6X+4rq6OBZq2d9
 exB2GKKss3h7XmrTLOlIB9YHi8MG6Jc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAyNCBTYWx0ZWRfX+sygBQtJCrN5
 e26yJtUcz9gBpeb57qAum/J15+kI0mM/jq7Nv16cNrC+iD/UYL3LSfXDLjnaaEr5VEDU8EFtM4i
 E525jeXXb0hDtVGEB6gyA+6M7qgYuPYuA9LC52OK2X0rokAYSWlDa8IPRDd7T5gRRHlEVpJK9We
 9MhDAqpqG8d2+vwcbisnCI794yS+ynJVgjj6h6sfigJkrfuw2kWa5wsKxUodTELxrr2wmiYx4yg
 jH9gclZPRhR7aBnlxMWdgdSnwsFjSXu9oqxJ8W1oi8zABSdGkk/29gNcUWQymIo5SFRsAQLH4vB
 tcc0tyzPchijI5C0jWUuOHvmHK+SII0hcAp074wg0infxOfH0Nfh4VW9Vo09YOsUz+oIR+FlubY
 69ZdaoV6dbs8rPFwu2fRH0IXByjdHqYF8Xfo1zc9nfRrOkeEnXZ9z2VwZJhs63SHprr80h63xU4
 /Y/uTK4O/rGD9uSY87w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 clxscore=1011
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120024

On Sep 15, Bibek Kumar Patro wrote:
>On Sep 14, Robin Murphy wrote:
>>On 11/09/2026 11:25 pm, Bibek Kumar Patro wrote:
>>>qcom_adreno_smmu_get_fault_info() accesses SMMU registers without
>>>holding a runtime PM reference. A fault is raised while the SMMU is
>>>active, but the GPU may drop its power vote before the threaded fault
>>>handler reaches the callback, allowing the SMMU to runtime suspend.
>>>
>>>Accessing the SMMU registers after suspend has started is unsafe and
>>>may cause subsequent register accesses during runtime resume to fail
>>>with a NoC error and an asynchronous SError.
>>
>>But hang on, if I'm following the code correctly, the callchain would be:
>>
>>arm_smmu_context_fault
>> report_iommu_fault
>>   msm_gpu_fault_handler
>>    qcom_adreno_smmu_get_fault_info
>>
>>and from here we still need to return to arm_smmu_context_fault() to 
>>clear the FSR, so surely that still has the same problem in itself?
>>
>
>Ah, yes this path also should have the same problem for GPU smmu.
>But I am carrying [1] in my workspace [2] for testing currently.
>So haven't encountered the same yet. We might need to address [1]
>also as part of this thread. wdyt?
>
>[1]: https://lore.kernel.org/all/20260313-smmu-rpm-v2-1-8c2236b402b0@oss.qualcomm.com/
>[2]: https://github.com/qualcomm-linux/kernel/blame/aff7542c319ede2037eeee316f20c2429062c08a/drivers/iommu/arm/arm-smmu/arm-smmu.c#L500
>

Hi Robin,

Do you have any concerns or suggestions on this patch?
lmk incase needed, I can resend the rebased version for both
current and [1] patch.
[1]: https://lore.kernel.org/all/20260313-smmu-rpm-v2-1-8c2236b402b0@oss.qualcomm.com/

Thanks & regards,
Bibek

>Thanks & regards,
>Bibek
>
>>Thanks,
>>Robin.
>>
>>>Use pm_runtime_get_if_active() to keep the SMMU active while collecting
>>>the fault information, and skip the register reads if suspend has
>>>already started.
>>>
>>>Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
>>>---
>>>qcom_adreno_smmu_get_fault_info() accesses SMMU registers without
>>>holding a runtime PM reference. A fault is raised while the SMMU is
>>>active, but the GPU may drop its power vote before the threaded fault
>>>handler reaches the callback, allowing the SMMU to runtime suspend.
>>>
>>>The failure sequence:
>>>
>>>  GPU context fault
>>>          |
>>>          v
>>>  qcom_adreno_smmu_get_fault_info()
>>>          |
>>>          | GPU drops its power vote
>>>          | SMMU starts runtime suspend
>>>          v
>>>  SMMU register access without an active RPM reference
>>>          |
>>>          v
>>>  later Adreno PRR private-interface operation
>>>          |
>>>          v
>>>  pm_runtime_resume_and_get()
>>>          |
>>>          v
>>>  arm_smmu_runtime_resume()
>>>          |
>>>          v
>>>  arm_smmu_device_reset()
>>>          |
>>>          v
>>>  SMMU register access
>>>          |
>>>          v
>>>  NoC error / asynchronous SError
>>>
>>>Use pm_runtime_get_if_active() to keep the SMMU active while collecting
>>>the fault information. If suspend has already started, skip the register
>>>reads instead of accessing the SMMU while it is being powered down.
>>>---
>>> drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 14 ++++++++++++++
>>> 1 file changed, 14 insertions(+)
>>>
>>>diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>index 795e8ec7e8fa..b1787a4ba0d3 100644
>>>--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>@@ -129,6 +129,18 @@ static void qcom_adreno_smmu_get_fault_info(const void *cookie,
>>> 	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
>>> 	struct arm_smmu_device *smmu = smmu_domain->smmu;
>>>+	/*
>>>+	 * A fault can only fire while the SMMU is active (GPU is issuing
>>>+	 * transactions). Use get_if_active so that if by a rare race the
>>>+	 * device has already suspended, we skip the register reads rather
>>>+	 * than triggering a cold resume which would call device_reset and
>>>+	 * destroy the fault state we are trying to capture.
>>>+	 */
>>>+	if (pm_runtime_get_if_active(smmu->dev) <= 0) {
>>>+		dev_warn(smmu->dev, "get_fault_info: device not active, skipping\n");
>>>+		return;
>>>+	}
>>>+
>>> 	info->fsr = arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SMMU_CB_FSR);
>>> 	info->fsynr0 = arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SMMU_CB_FSYNR0);
>>> 	info->fsynr1 = arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SMMU_CB_FSYNR1);
>>>@@ -136,6 +148,8 @@ static void qcom_adreno_smmu_get_fault_info(const void *cookie,
>>> 	info->cbfrsynra = arm_smmu_gr1_read(smmu, ARM_SMMU_GR1_CBFRSYNRA(cfg->cbndx));
>>> 	info->ttbr0 = arm_smmu_cb_readq(smmu, cfg->cbndx, ARM_SMMU_CB_TTBR0);
>>> 	info->contextidr = arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SMMU_CB_CONTEXTIDR);
>>>+
>>>+	pm_runtime_put_autosuspend(smmu->dev);
>>> }
>>> static void qcom_adreno_smmu_set_stall(const void *cookie, bool enabled)
>>>
>>>---
>>>base-commit: f61bb3920fa8cb44b84d32e0fa9fbaab4eb00c80
>>>change-id: 20260912-priv_call_runtime_handlers-7f3547544040
>>>
>>>Best regards,
>>>--
>>>Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
>>>
>>
