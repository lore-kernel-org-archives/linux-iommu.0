Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D5F2DC355
	for <iommu@lists.linux.dev>; Thu, 29 Jan 2026 16:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769702602; cv=none; b=g23ersnq9qEOEurJgRymrQ6F9hQkBwv0OHUaNfeTrgLyypcsPX2rCZSnIQ3S8L7kpLEv72sKui4tX3JTYDZ4wzOWb3PTZJcf/GOH3uGbRh2OaL8dCVGxEo6I/pFtjcmTcODcrtPKbeKPMsRvKAdCk38C3lTuOiRiJekbTA9ramw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769702602; c=relaxed/simple;
	bh=IyivSQaAeplL2DqeJlvEVUsgok3cOG00ws0Eaoas/Os=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tHBErnwJVi4wJRiq4x96wLg0em4g4dVDN+N0bjVcELZdxRkTNq4yjXjvySGxReue94uHLo4aMISpEYNOemhk50XsoBGj55G4Nw14DejTtLIWMR+77NXaqsM6QEc9dFyvv1WJFhy3s7wyyfJIVVKUzLz+4fWhjYSMErhr+uQQogY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P2F18T/Y; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MZOPj6Cl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P2F18T/Y";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MZOPj6Cl"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60TG20rF3733049
	for <iommu@lists.linux.dev>; Thu, 29 Jan 2026 16:03:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IyivSQaAeplL2DqeJlvEVUsgok3cOG00ws0Eaoas/Os=; b=P2F18T/YqLHFu8Zm
	1LDSblnkEZKcsAsv7CmJi6TkTm9fFt4YUo2Hm3L7ng69RmzkvQ+mVdkk1aaO32DT
	pLLueXKsW/S90xgSV9xC0M6OYXzF0rNViwKsT0vKGcGe/ssq9v67e3/f+cHcp3r6
	xcoIcLyf/mvdCNV4x7xjM44dInP4e8pq6QLsv488cZtKg89a1bubnUuSXXQ/rzBF
	QxruK7IAwpaNYIgObg2jjlUMnTLe2ERDBOT94v13y97o6AAhsRGi6Qda8pz0nb0P
	GfKR55zny2Szd5AjwJm8CMxBtkvnxvTnKRxW6Hn2JG6wtWI7JnCN2bBVwxYc5CZK
	+gNfAQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c0aqd80kg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 29 Jan 2026 16:03:19 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8227fdbc51cso673958b3a.1
        for <iommu@lists.linux.dev>; Thu, 29 Jan 2026 08:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769702598; x=1770307398; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IyivSQaAeplL2DqeJlvEVUsgok3cOG00ws0Eaoas/Os=;
        b=MZOPj6Cl4aBoh62kb6aw0w2Q/R4vm81mTIPiSSc+9pktj11e+gZuk8cgCwcrhyoLxn
         +to+5CMOyT/4f87i6NxYeg9DYWTpY79PxhEPuamRLgSgs9MZyd1aDlGXLSZVYpDdE2yu
         HCWXQvfoia8aTeIJaQbqAf9DcohcrR3gzJb7lmOzixmksmrrgDNH3XaxV0fJNegLFdd6
         Y3Jx4YEPWdKlHESbpAscnpLeuicqY1VEKv/CGtm1LpiGkfXSqmWVjc0aByTxB23qEnW/
         /+wPjpppwbjbErdrOgIB3DWpmNKYo68jrh+uy/XrEPtCoWeaE02HEuRGxmOGVcsOaZWQ
         U2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769702598; x=1770307398;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IyivSQaAeplL2DqeJlvEVUsgok3cOG00ws0Eaoas/Os=;
        b=rcCCNeds7J4Qvzc3wWiSZyTEDL9abPLQ1lDLXtx+4FTjJktOkPKWfzZGvDCTZTeI56
         0LOT68bTlCEjj554c7sLvSLal6ktRaBwAEUKCm2yUvQte+jElY11xDNIrXsu+YKC5P/F
         tYtTk1QniLR02v6wqiMMDSkLRZItpX5ay2v4lTDHz1HTbNguMkPMPfjy5ss2s4J1rqcE
         pgA/5uj1wUnFbgE6FAjLuwViRz09asYveTyrDfEdYlm2YkMfEg5a8tF5kyE+0qssn/pq
         QAT6QptF1XBG2Y8WC5B18FuixbpJq6vaHXjHOiyXt8xyK3ZLl1Ze74o3ri9yrokXpRAl
         k16Q==
X-Forwarded-Encrypted: i=1; AJvYcCVeU6pGIYCFQ/sJBV2l0ge4DvLfw2B8E/0Xya5YJPIPCcE3NiBI26XpZrsiAuP/KIMPd2C23g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzEjUnnrCg5477Ln13C5nULGvUick1v3925E8sUIssOQn1zCDvs
	7ujKGuTK3g3IAL9GxA+6epSL7EXOe9n8H7SUEeBKgQ1UmdYEhwleZm+TX1coSBDDlkF4c0qkmFr
	n3pdYBlRRQ7zFmH6HTZoFb4aOCpPgd+9iMGLXxUuS5hJ35x5PCrbxxEkkvw==
X-Gm-Gg: AZuq6aIxqIg2ugvK7DVqDpvrLraC01KE+bO8uW65AkwASUEYBms+R6adIk0ncXsAaiA
	5pN3cXnaSny8nJu173K6kTbP0mo9dpBjXwmqhKViCnE5VSeUToNHXlBPucgb714TEOct5VPUm+n
	xrS1T8MOmFCYD/YlnEEdzDqXcA1WUeKFxF1OlMY1KNO61iQ1Vpf1iPZpXCLpo7PhfCJtuIQiyXd
	p8Mzc1Rt69LASSFu6Oefcb5NUS3m/fZW23zgVai4Y3o3lx6WhwWl39H9KG1Ht03btFH7CRE+47Z
	xrkf/2lzVQWzn0nCvAIuF3tAD17Lo+KT/G64zA1YyWUn/iuFIIeBcw/QcLd8pazVyqsHZJEqBOI
	jdLWFkW1X03ZGFN4ygpO0CRnxJarFMZ7lDU+lPJGUpw==
X-Received: by 2002:a05:6a00:2d97:b0:823:1d05:1660 with SMTP id d2e1a72fcca58-823692b7b4dmr8104923b3a.52.1769702598036;
        Thu, 29 Jan 2026 08:03:18 -0800 (PST)
X-Received: by 2002:a05:6a00:2d97:b0:823:1d05:1660 with SMTP id d2e1a72fcca58-823692b7b4dmr8104882b3a.52.1769702597325;
        Thu, 29 Jan 2026 08:03:17 -0800 (PST)
Received: from [192.168.1.6] ([122.177.240.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379c54d4dsm6776135b3a.67.2026.01.29.08.03.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 08:03:16 -0800 (PST)
Message-ID: <bfa31c3c-f554-43ad-8286-78435e01591a@oss.qualcomm.com>
Date: Thu, 29 Jan 2026 21:33:10 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/arm-smmu: Use pm_runtime in fault handlers
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Connor Abbott <cwabbott0@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>,
        Pranjal Shrivastava <praan@google.com>
References: <20260127-smmu-rpm-v1-1-2ef2f4c85305@oss.qualcomm.com>
 <9fb8f661-a235-4f86-bc10-f80a21a8fa9d@arm.com>
 <00fcbcf2-3f48-410d-88a3-88dc834c1ed7@oss.qualcomm.com>
 <d6bc7f38-b41d-4e89-b484-0e699981b8b4@arm.com>
Content-Language: en-US
From: Prakash Gupta <prakash.gupta@oss.qualcomm.com>
In-Reply-To: <d6bc7f38-b41d-4e89-b484-0e699981b8b4@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: v-XsiJPRz6Y2oHsdp9eahKt6hAYpkmb3
X-Proofpoint-GUID: v-XsiJPRz6Y2oHsdp9eahKt6hAYpkmb3
X-Authority-Analysis: v=2.4 cv=GNAF0+NK c=1 sm=1 tr=0 ts=697b84c7 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=x89J+l3dq0U9VyOkIARB/A==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=sf7T9RYLP084Io81TTEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDExMSBTYWx0ZWRfX1iZsX9VGbdYl
 lgRaPOJYi6lWWLAYwvpI6qk/LrbnZq6K5Fyd5/lsrcTNzAdkSo9M8czM+OpjF6nhPhAkLm/OdDc
 JMFklaul9OqbpYzexrsaDEUgc6H6CbWhfPblw3HQPri6JeKPKuomyRKw9h1f0jBDUmSuK/xGAMC
 RCFJztZ5E6U8JoV9HxX+dIo1ybH2HMUWtngri8OAR6GggGTqS17GNOnXGN2VE7GyzSB9RW9cc67
 cWtp6duWyumFr6l37NNI3CEu+lh1Pfd8cfoqNAZ1Pkw9bkaqCmpvu/zxo5rF6BB/i1a7vWnrPVa
 LCIYoHdBTO4STiDOpNr/PTJ3alXBAY/Ui3s0Jha1df4jHBBPDqGVR2RebtYKRlIgMiqhk96Pqof
 qTOhD06+HDwVNudSiHaA4O7xYMEso/dFoc4nOI2ojqNHHA7J0BjbLZ28+uK5vuUJlVcglkv+tTQ
 vmI49D04tSuK1duZQ6w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601290111


On 1/29/2026 12:14 AM, Robin Murphy wrote:
> [ +Pranjal as this might matter for v3 too... ]
>
> On 28/01/2026 5:56 am, Prakash Gupta wrote:
>>
>> On 1/27/2026 9:35 PM, Robin Murphy wrote:
>>> On 2026-01-27 12:11 pm, Prakash Gupta wrote:
>>>> Commit d4a44f0750bb ("iommu/arm-smmu: Invoke pm_runtime across the
>>>> driver")
>>>> enabled pm_runtime for the arm-smmu device. On systems where the SMMU
>>>> sits in a power domain, all register accesses must be done while the
>>>> device is runtime-resumed to avoid unclocked register reads and
>>>> potential NoC errors.
>>>>
>>>> So far, this has not been an issue for most SMMU clients because
>>>> stall-on-fault is enabled by default. While a translation fault is
>>>> being handled, the SMMU stalls further translations for that context
>>>> bank, so the fault handler would not race with a powered-down
>>>> SMMU.
>>>>
>>>> Adreno SMMU now disables stall-on-fault in the presence of fault
>>>> storms to avoid saturating SMMU resources and hanging the GMU. With
>>>> stall-on-fault disabled, the SMMU can generate faults while its power
>>>> domain may no longer be enabled, which makes unclocked accesses to
>>>> fault-status registers in the SMMU fault handlers possible.
>>>
>>> At face value, that sounds wrong - how does an SMMU generate a fault,
>>> or indeed do anything, when it's powered off? In principle it's
>>> possible that the SMMU might signal an interrupt, and is _then_
>>> suspended (with the interrupt line somehow remaining asserted, so
>>> probably more clock-gated than completely powered down) before the
>>> interrupt hander runs, but we rather assume that we're not going to
>>> have an unhandled hardware IRQ hanging around for longer than the
>>> autosuspend delay.
>>>
>>> So, judging by the diff below, I guess what you really mean is that in
>>> the case of a threaded context IRQ handler, it can take long enough
>>> between handling the hardware IRQ and the thread actually running that
>>> the SMMU may have suspended in between?
>>
>> You are correct that the SMMU cannot generate a fault while powered
>> down. A more accurate description of the race condition is as follows:
>> When stall-on-fault is disabled, the faulting transaction does is
>> terminated. This allows the master (the GPU) to complete its work, drop
>> its power vote for the SMMU, and allow the SMMU to suspend. However, the
>> SMMU fault handler may still be waiting to execute on the CPU.
>> If the SMMU suspends before the handler reads the fault registers, an
>> unclocked access occurs. This scenario is significantly more likely when
>> using threaded IRQs due to the scheduling latency involved. I will
>> update the next iteration to reflect this.
>>
>>>
>>>> Guard the context and global fault handlers with arm_smmu_rpm_get() /
>>>> arm_smmu_rpm_put() so that all SMMU fault register accesses are done
>>>> with the SMMU powered.
>>>>
>>>> Fixes: b13044092c1e ("drm/msm: Temporarily disable stall-on-fault
>>>> after a page fault")
>>>> Co-developed-by: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
>>>> Signed-off-by: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
>>>> Signed-off-by: Prakash Gupta <prakash.gupta@oss.qualcomm.com>
>>>> ---
>>>>    drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c |  5 ++-
>>>>    drivers/iommu/arm/arm-smmu/arm-smmu.c      | 53
>>>> ++++++++++++++++++++++--------
>>>>    2 files changed, 43 insertions(+), 15 deletions(-)
>>>>
>>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>> b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>> index 573085349df3..2d03df72612d 100644
>>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>> @@ -317,6 +317,7 @@ static int qcom_adreno_smmu_init_context(struct
>>>> arm_smmu_domain *smmu_domain,
>>>>        struct arm_smmu_device *smmu = smmu_domain->smmu;
>>>>        struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
>>>>        const struct of_device_id *client_match;
>>>> +    const struct arm_smmu_impl *impl = qsmmu->data->impl;
>>>>        int cbndx = smmu_domain->cfg.cbndx;
>>>>        struct adreno_smmu_priv *priv;
>>>>    @@ -350,10 +351,12 @@ static int
>>>> qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
>>>>        priv->get_ttbr1_cfg = qcom_adreno_smmu_get_ttbr1_cfg;
>>>>        priv->set_ttbr0_cfg = qcom_adreno_smmu_set_ttbr0_cfg;
>>>>        priv->get_fault_info = qcom_adreno_smmu_get_fault_info;
>>>> -    priv->set_stall = qcom_adreno_smmu_set_stall;
>>>>        priv->set_prr_bit = NULL;
>>>>        priv->set_prr_addr = NULL;
>>>>    +    if (impl->context_fault_needs_threaded_irq)
>>>> +        priv->set_stall = qcom_adreno_smmu_set_stall;
>>>> +
>>>>        if (of_device_is_compatible(np, "qcom,smmu-500") &&
>>>>            !of_device_is_compatible(np, "qcom,sm8250-smmu-500") &&
>>>>            of_device_is_compatible(np, "qcom,adreno-smmu")) {
>>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c
>>>> b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>>>> index 5e690cf85ec9..183f12e45b02 100644
>>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
>>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>>>> @@ -462,10 +462,23 @@ static irqreturn_t arm_smmu_context_fault(int
>>>> irq, void *dev)
>>>>        int idx = smmu_domain->cfg.cbndx;
>>>>        int ret;
>>>>    +    if (smmu->impl &&
>>>> smmu->impl->context_fault_needs_threaded_irq) {
>>>
>>> Why is this conditional on being threaded, if the global fault handler
>>> that can never be threaded at all apparently needs it unconditionally?
>> Synchronous runtime PM calls can sleep, which would cause issue if
>> called within a hard IRQ context. This is why I added the conditional
>> check for threaded IRQs.
>> Furthermore, this change only allow the driver to override the
>> stall-on-fault setting when context_fault_needs_threaded_irq is true.
>> Since the unclocked access issue is tied to disabling stall-on-fault,
>> the fix is only logically required for the threaded IRQ path.
>> For the Global Fault handler, which runs in a hard IRQ context, you are
>> right—we cannot safely vote for power there. I will remove the runtime
>> PM call from that section.
>
> Hmm, but then how *do* we actually guarantee that autosuspend doesn't
> happen to kick in and power down the SMMU just as a hardirq handler
> runs, when there's some unexpected event? I fear there's a horrible
> can of worms here... 
>
You are right. To safely handle the race where the device suspends
before the handler runs, we must be able to resume it. Since that
requires sleeping, the hard IRQ handler is insufficient if the device is
not already active.

So, disabling stall-on-fault can only be safely allowed when both the
global and context fault handlers are moved to threaded IRQs. This will
allow us to safely use runtime resume in the handler, ensuring the
device is powered to clear the fault status regardless of when the
suspend occurred.

> Thanks,
> Robin.
