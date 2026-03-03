Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB86396580
	for <iommu@lists.linux.dev>; Tue,  3 Mar 2026 19:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772565400; cv=none; b=hxI8hachiHc45ATFnEKc3l2xkUkPye0wuC3IS8z75j6nNIm6CCaz20LvcLZuEIUhXlI+FIiicttSccyk7kAV8I/R5r4kO9mtjnxEUtNpRwqtfoKCU4EFiA+DITi6sW2udmRSprQ/8iFp4vzoFHgM2MXNRcEX3mpxKZS0UJMDTZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772565400; c=relaxed/simple;
	bh=UBT35nY6GKDuTiVu0BhklVZrCznrQJ6RhL3ZL2qeeC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BgRmUfXZJ2WupS63UKiFwszWfQcgiP0jlK1Cly9mgoQM7HDgWgXcL5hl5g76eGRmIyJMd3ji1uETWTHdoQ2cdx/lnKxDfvzVRLxJB65tfa133dR+awcK7JlBHBdyMMDlQcuVyjfpCmrTSRSXmVfIjfY2wo149h/U4HsdpPoudNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jMV6qzmv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QrknFPVa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jMV6qzmv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QrknFPVa"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 623H0Pes3708671
	for <iommu@lists.linux.dev>; Tue, 3 Mar 2026 19:16:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x7nDgycG81om+0Zg7sH3cMCeC5SiOTz3dDIdtVP2WdE=; b=jMV6qzmv88L4Gclk
	Z0mXv+HV8iC6NeCTEmk8swqIFfwdsbXZsolgxP30irqEM7mMgTPJDC6RMPQiv1jX
	YJJ3cTfKBc1gMXic8P17HCmv0sjUs0V0Nr+Scejq4sOWxo8ggZwZe8GLkiIT+F6H
	4BcgdH4ngc8Uv5ONrcj9w7h5FDtnb89Ng/2r5yLZ45Eaa3mO2ArTnEZPGCGn+kup
	+CnxnQXLRzM0PGN1z3QF7v3MrPpt4cXNQuiv1DLrC8Z2aJXh/GXqitmaSpYG2qhh
	H9rH8g4TkAbpvDap0aSDaesc5tYeDVk59bSJ/RxaRbcCe8YVOIUdkK4VvwmLGQFk
	X+IHfQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cnsjm2s0f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 03 Mar 2026 19:16:38 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-82739095656so2321643b3a.3
        for <iommu@lists.linux.dev>; Tue, 03 Mar 2026 11:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772565398; x=1773170198; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x7nDgycG81om+0Zg7sH3cMCeC5SiOTz3dDIdtVP2WdE=;
        b=QrknFPVaPIHszam/kjh2QDfgQZjgWLtEQMH9sQgPqnRjPhI8mO8IE9QF1MMLdWe4/M
         owGo0B+ZigwaJgcPG9lCe6GgRkY4a+hSkaZl6Bo8N9pG2Fh761UT6zjI3Xo/3dLyz8vy
         yQg6b/CClhQ2MIo6YbtUQH3Fwwk0nLBCdo0nb6oFLWk0p+7l39VtU1vnksshzXnFQ4i3
         NEHgPIYqTFLfgjLd4NBdB92Ws0YxDQvCVwEIEERYjEGxZeFz0fsbDBWw6lgSpF4eBbzT
         P679U+fGthyLT35zrdwS4OrQJYVhlX8iP6SF26tFmn/VBCqopeCJeU1T5GpyhauptFU+
         1uRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772565398; x=1773170198;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x7nDgycG81om+0Zg7sH3cMCeC5SiOTz3dDIdtVP2WdE=;
        b=pZgrnYif3x/XYA4ntjCFh7neW+HKj/Cs9s9rqHolAelmfG/2rrT0ifq2Bk/u3RKKfJ
         NSxCfLwn6bMF8cq4pXMoiz4S0D5SpRythvrP06P01SCfQZMUGTLFv9fZZiRa8lY9NWkR
         Qi850/m4kAAijqPeN/dSyhkHvNQ+70cZaAv2J7lx/twl3quIbCddcuU6uhWAFVVlPDz5
         cHBR8UUNf63mgbTiVf+7PmGqrWPNQBiBmLXxbVh7tWjhlT6d1rUlrx4+EPBCI035k2/X
         SQSw5n3DEd9+VDoS67tuMLQaXv9ghyYh0QaXgvH+edhSOrU0jUcfEFofXStDmtZNxc6j
         rD+g==
X-Forwarded-Encrypted: i=1; AJvYcCWstNsi5XfUN3mlAekuireLAaJhftjI2eXM+mQwE/OApODIc6zgWrL2azkI0CAukC7Md5l52A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwR//YNCk1rkQIF+ptFwuCYxNiVg+dCWwjqYe8mKUJ9g88DOPaq
	fZ35qcacbboHGsEvUPGMxNQ3UmKQKerKcLAgULo1Drh3UdcOEFMGlrfjIKZ9TuGD1tqzTPe/wSx
	NTFGH/twARYcVbAUvDGliB+oMpPRWhjqM5jJUxSaly+BAFrSJFggVViPAzQ==
X-Gm-Gg: ATEYQzxeOm0q/RtFZJYzwge3qJu/8Cmy+FiCK6oFc1t1CRd+U1uHABhd6t/5tyodsuK
	DTiFhzCV2L7zIhS3My/MR5Lknpw7QLki8PwuhI4Noonjm+vzbcpLIbu2lZGLcpl1pmEWhoXs5am
	k0svLKiifB0cn7+CmYYNwu0fFJFOnajGRv0vmnSJ/hOf2n5eqNT39oXTLATpxrKR4koB3tpoRR3
	Iyj12zxEj3BKqkZQhKeClLPoukJFnxxlzm1zVHVeS0b0yeULdkdT7AtCH2gPZMht4eFE0Yz4vlx
	3im59bNKgFPqSbUubNNw3McM3dB7vBe17EBNBXV9oM+RVysIeiQBlOciKN9T+IyEt1Dex3UvkKm
	piNbyYQKIeM6C3z7WR3Rr98p1k4NV73xRzwnXWx29qq9avuauu76owoU=
X-Received: by 2002:a05:6a00:4214:b0:81f:4675:c2a6 with SMTP id d2e1a72fcca58-8274d93b0a7mr15489755b3a.2.1772565397214;
        Tue, 03 Mar 2026 11:16:37 -0800 (PST)
X-Received: by 2002:a05:6a00:4214:b0:81f:4675:c2a6 with SMTP id d2e1a72fcca58-8274d93b0a7mr15489736b3a.2.1772565396593;
        Tue, 03 Mar 2026 11:16:36 -0800 (PST)
Received: from [192.168.0.172] ([49.205.248.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8273a01aa09sm19638827b3a.48.2026.03.03.11.16.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2026 11:16:36 -0800 (PST)
Message-ID: <1dc86b00-9a18-482c-94b1-96692c1dd530@oss.qualcomm.com>
Date: Wed, 4 Mar 2026 00:46:27 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] media: iris: add helper to select context bank
 device
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Hans Verkuil <hverkuil+cisco@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, Bryan O'Donoghue <bryan.odonoghue@linaro.org>
References: <20260227-kaanapali-iris-v2-0-850043ac3933@oss.qualcomm.com>
 <20260227-kaanapali-iris-v2-5-850043ac3933@oss.qualcomm.com>
 <bi3i37ho3ppzlgdx264ohxpcem3nwumjelzckf4x5uzdj5rt7a@2y2jrilmfimj>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <bi3i37ho3ppzlgdx264ohxpcem3nwumjelzckf4x5uzdj5rt7a@2y2jrilmfimj>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: fZWjhoDwxOQAH_WjBxZ2x19tcQy2cDOQ
X-Authority-Analysis: v=2.4 cv=GIUF0+NK c=1 sm=1 tr=0 ts=69a73396 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=KPiuay1jFzAquJblYynD6w==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=zVNvaYjD9Rq9sQCc3cMA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: fZWjhoDwxOQAH_WjBxZ2x19tcQy2cDOQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDE1NiBTYWx0ZWRfX5WmUty2Q6dQz
 T4+7HOYHo2yWUqFmymfOMASyXdgBXHpMEKvFa2U3CyA8d/T33WS1mPUa3ZLdmKw01knXwSq8TXh
 xJshwrPUxLX1+JBKdHgGPHPbO6CDoMGDY3JckAbyLmeY9hpv8ki3vrF8ZSunkn5xZ3Un8l/nULV
 pfvSi2hVGHWx4J/fx9fCDfXgt9XZNeyDbrZDvlNkDGDpYwobnquKmmbo82erDbPlQclS9Dbo3zJ
 pZW/811RF9p7NO5BgqBuFghDngyMwNeNpfxbU4bjqPP5/6/49HgSH6Br2gulgm3gB3ArBMwiV/I
 LYB7kLFlfLAyRFYjItey281wljOKvn6pBZS9lquKv7WAObi5d2L6+gO8gaWV5nreC+87iOIejVK
 0S6tRrD75ONF2xIM0/qmObbF47Kge6QHC6NZEGLQ2AuzXLhaqDcaQahT3CZI+XMM1udQUbapomN
 dsD+elKOADWRkyO+d1A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-03_02,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030156



On 2/28/2026 1:57 AM, Dmitry Baryshkov wrote:
> On Fri, Feb 27, 2026 at 07:41:21PM +0530, Vikash Garodia wrote:
>> Depending on the buffer type (input, output, internal and interface
>> queues), associated context bank is selected, if available. Fallback to
>> parent device for backward compatibility.
>>
>> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>> ---
>>   drivers/media/platform/qcom/iris/iris_buffer.c    |  7 +--
>>   drivers/media/platform/qcom/iris/iris_buffer.h    |  2 +
>>   drivers/media/platform/qcom/iris/iris_hfi_queue.c | 16 +++---
>>   drivers/media/platform/qcom/iris/iris_resources.c | 60 +++++++++++++++++++++++
>>   drivers/media/platform/qcom/iris/iris_resources.h |  2 +
>>   drivers/media/platform/qcom/iris/iris_vidc.c      |  4 +-
>>   6 files changed, 79 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/media/platform/qcom/iris/iris_buffer.c b/drivers/media/platform/qcom/iris/iris_buffer.c
>> index 9151f43bc6b9c2c34c803de4231d1e6de0bec6c4..95962c19c334f08a74c5b7e8ba978ab631a65e9c 100644
>> --- a/drivers/media/platform/qcom/iris/iris_buffer.c
>> +++ b/drivers/media/platform/qcom/iris/iris_buffer.c
>> @@ -335,8 +335,8 @@ void iris_get_internal_buffers(struct iris_inst *inst, u32 plane)
>>   static int iris_create_internal_buffer(struct iris_inst *inst,
>>   				       enum iris_buffer_type buffer_type, u32 index)
>>   {
>> +	struct device *dev = iris_get_cb_dev(inst->core, inst, buffer_type);
>>   	struct iris_buffers *buffers = &inst->buffers[buffer_type];
>> -	struct iris_core *core = inst->core;
>>   	struct iris_buffer *buffer;
>>   
>>   	if (!buffers->size)
>> @@ -352,7 +352,7 @@ static int iris_create_internal_buffer(struct iris_inst *inst,
>>   	buffer->buffer_size = buffers->size;
>>   	buffer->dma_attrs = DMA_ATTR_WRITE_COMBINE | DMA_ATTR_NO_KERNEL_MAPPING;
>>   
>> -	buffer->kvaddr = dma_alloc_attrs(core->dev, buffer->buffer_size,
>> +	buffer->kvaddr = dma_alloc_attrs(dev, buffer->buffer_size,
>>   					 &buffer->device_addr, GFP_KERNEL, buffer->dma_attrs);
>>   	if (!buffer->kvaddr) {
>>   		kfree(buffer);
>> @@ -490,9 +490,10 @@ int iris_queue_internal_buffers(struct iris_inst *inst, u32 plane)
>>   int iris_destroy_internal_buffer(struct iris_inst *inst, struct iris_buffer *buffer)
>>   {
>>   	struct iris_core *core = inst->core;
>> +	struct device *dev = iris_get_cb_dev(core, inst, buffer->type);
>>   
>>   	list_del(&buffer->list);
>> -	dma_free_attrs(core->dev, buffer->buffer_size, buffer->kvaddr,
>> +	dma_free_attrs(dev, buffer->buffer_size, buffer->kvaddr,
>>   		       buffer->device_addr, buffer->dma_attrs);
>>   	kfree(buffer);
>>   
>> diff --git a/drivers/media/platform/qcom/iris/iris_buffer.h b/drivers/media/platform/qcom/iris/iris_buffer.h
>> index 75bb767761824c4c02e0df9b765896cc093be333..9520aa290b44f06ed2004ad89940c19d1c08a3d2 100644
>> --- a/drivers/media/platform/qcom/iris/iris_buffer.h
>> +++ b/drivers/media/platform/qcom/iris/iris_buffer.h
>> @@ -28,6 +28,7 @@ struct iris_inst;
>>    * @BUF_SCRATCH_2: buffer to store encoding context data for HW
>>    * @BUF_VPSS: buffer to store VPSS context data for HW
>>    * @BUF_PARTIAL: buffer for AV1 IBC data
>> + * @BUF_HFI_QUEUE: buffer for hardware firmware interface queue
> 
> Separate commit?

sure, introducing the HFI_QUEUE buffer type can be made into a separate 
patch.

> 
>>    * @BUF_TYPE_MAX: max buffer types
>>    */
>>   enum iris_buffer_type {
>> @@ -44,6 +45,7 @@ enum iris_buffer_type {
>>   	BUF_SCRATCH_2,
>>   	BUF_VPSS,
>>   	BUF_PARTIAL,
>> +	BUF_HFI_QUEUE,
>>   	BUF_TYPE_MAX,
>>   };
>>   
>> diff --git a/drivers/media/platform/qcom/iris/iris_hfi_queue.c b/drivers/media/platform/qcom/iris/iris_hfi_queue.c
>> index b3ed06297953b902d5ea6c452385a88d5431ac66..c1241fb8dc6519020a063cbba87aed665701d7ae 100644
>> --- a/drivers/media/platform/qcom/iris/iris_hfi_queue.c
>> +++ b/drivers/media/platform/qcom/iris/iris_hfi_queue.c
>> @@ -245,25 +245,26 @@ static void iris_hfi_queue_deinit(struct iris_iface_q_info *iface_q)
>>   
>>   int iris_hfi_queues_init(struct iris_core *core)
>>   {
>> +	struct device *dev = iris_get_cb_dev(core, NULL, BUF_HFI_QUEUE);
>>   	struct iris_hfi_queue_table_header *q_tbl_hdr;
>>   	u32 queue_size;
>>   
>>   	/* Iris hardware requires 4K queue alignment */
>>   	queue_size = ALIGN((sizeof(*q_tbl_hdr) + (IFACEQ_QUEUE_SIZE * IFACEQ_NUMQ)), SZ_4K);
>> -	core->iface_q_table_vaddr = dma_alloc_attrs(core->dev, queue_size,
>> +	core->iface_q_table_vaddr = dma_alloc_attrs(dev, queue_size,
>>   						    &core->iface_q_table_daddr,
>>   						    GFP_KERNEL, DMA_ATTR_WRITE_COMBINE);
>>   	if (!core->iface_q_table_vaddr) {
>> -		dev_err(core->dev, "queues alloc and map failed\n");
>> +		dev_err(dev, "queues alloc and map failed\n");
>>   		return -ENOMEM;
>>   	}
>>   
>> -	core->sfr_vaddr = dma_alloc_attrs(core->dev, SFR_SIZE,
>> +	core->sfr_vaddr = dma_alloc_attrs(dev, SFR_SIZE,
>>   					  &core->sfr_daddr,
>>   					  GFP_KERNEL, DMA_ATTR_WRITE_COMBINE);
>>   	if (!core->sfr_vaddr) {
>> -		dev_err(core->dev, "sfr alloc and map failed\n");
>> -		dma_free_attrs(core->dev, sizeof(*q_tbl_hdr), core->iface_q_table_vaddr,
>> +		dev_err(dev, "sfr alloc and map failed\n");
>> +		dma_free_attrs(dev, sizeof(*q_tbl_hdr), core->iface_q_table_vaddr,
>>   			       core->iface_q_table_daddr, DMA_ATTR_WRITE_COMBINE);
>>   		return -ENOMEM;
>>   	}
>> @@ -291,6 +292,7 @@ int iris_hfi_queues_init(struct iris_core *core)
>>   
>>   void iris_hfi_queues_deinit(struct iris_core *core)
>>   {
>> +	struct device *dev = iris_get_cb_dev(core, NULL, BUF_HFI_QUEUE);
>>   	u32 queue_size;
>>   
>>   	if (!core->iface_q_table_vaddr)
>> @@ -300,7 +302,7 @@ void iris_hfi_queues_deinit(struct iris_core *core)
>>   	iris_hfi_queue_deinit(&core->message_queue);
>>   	iris_hfi_queue_deinit(&core->command_queue);
>>   
>> -	dma_free_attrs(core->dev, SFR_SIZE, core->sfr_vaddr,
>> +	dma_free_attrs(dev, SFR_SIZE, core->sfr_vaddr,
>>   		       core->sfr_daddr, DMA_ATTR_WRITE_COMBINE);
>>   
>>   	core->sfr_vaddr = NULL;
>> @@ -309,7 +311,7 @@ void iris_hfi_queues_deinit(struct iris_core *core)
>>   	queue_size = ALIGN(sizeof(struct iris_hfi_queue_table_header) +
>>   		(IFACEQ_QUEUE_SIZE * IFACEQ_NUMQ), SZ_4K);
>>   
>> -	dma_free_attrs(core->dev, queue_size, core->iface_q_table_vaddr,
>> +	dma_free_attrs(dev, queue_size, core->iface_q_table_vaddr,
>>   		       core->iface_q_table_daddr, DMA_ATTR_WRITE_COMBINE);
>>   
>>   	core->iface_q_table_vaddr = NULL;
>> diff --git a/drivers/media/platform/qcom/iris/iris_resources.c b/drivers/media/platform/qcom/iris/iris_resources.c
>> index be58e8620086d0f82c2c2bda29247483f5c56d79..65544cb0fa8fc4b250b0a0be1bb900d74b999d35 100644
>> --- a/drivers/media/platform/qcom/iris/iris_resources.c
>> +++ b/drivers/media/platform/qcom/iris/iris_resources.c
>> @@ -13,6 +13,7 @@
>>   #include <linux/reset.h>
>>   
>>   #include "iris_core.h"
>> +#include "iris_instance.h"
>>   #include "iris_resources.h"
>>   
>>   #define BW_THRESHOLD 50000
>> @@ -177,3 +178,62 @@ int iris_create_child_device_and_map(struct iris_core *core, struct iris_context
>>   
>>   	return 0;
>>   }
>> +
>> +static enum iris_buffer_region iris_get_region(struct iris_inst *inst,
>> +					       enum iris_buffer_type buffer_type)
>> +{
>> +	switch (buffer_type) {
>> +	case BUF_INPUT:
>> +		if (inst && inst->domain == ENCODER)
> 
> Can inst be NULL here?

during queues init/deinit, instances are not created.

> 
>> +			return IRIS_PIXEL_REGION;
>> +		else if (inst && inst->domain == DECODER)
>> +			return IRIS_BITSTREAM_REGION;
> 
> Are there any other possibilities than encoder and decoder?

will simplify it as

if (inst) {
     if (inst->domain == ENCODER)
         return IRIS_PIXEL_REGION;
     else
         return IRIS_BITSTREAM_REGION;
}
> 
>> +		break;
>> +	case BUF_OUTPUT:
>> +		if (inst && inst->domain == ENCODER)
>> +			return IRIS_BITSTREAM_REGION;
>> +		else if (inst && inst->domain == DECODER)
>> +			return IRIS_PIXEL_REGION;
>> +		break;
>> +	case BUF_BIN:
>> +		return IRIS_BITSTREAM_REGION;
>> +	case BUF_DPB:
>> +	case BUF_PARTIAL:
>> +	case BUF_SCRATCH_2:
>> +	case BUF_VPSS:
>> +		return IRIS_PIXEL_REGION;
>> +	case BUF_ARP:
>> +	case BUF_COMV:
>> +	case BUF_HFI_QUEUE:
>> +	case BUF_LINE:
>> +	case BUF_NON_COMV:
>> +	case BUF_PERSIST:
>> +		return IRIS_NON_PIXEL_REGION;
>> +	default:
>> +		return 0;
> 
> dev_err(dev, "unsupported buffer type %x\n", buffer_type)
> return -EINVAL;

these are bit fields, returning -EINVAL would still match some bits and 
can make the logic as true. 0 can be defined as IRIS_UNKNOWN_REGION

> 
>> +	}
>> +
>> +	return 0;
> 
> Drop
> 

Ack

>> +}
>> +
>> +struct device *iris_get_cb_dev(struct iris_core *core, struct iris_inst *inst,
>> +			       enum iris_buffer_type buffer_type)
>> +{
>> +	enum iris_buffer_region region;
>> +	struct device *dev = NULL;
>> +	int i;
>> +
>> +	region = iris_get_region(inst, buffer_type);
>> +
>> +	for (i = 0; i < core->iris_platform_data->cb_data_size; i++) {
>> +		if (core->iris_platform_data->cb_data[i].region & region) {
>> +			dev = core->iris_platform_data->cb_data[i].dev;
>> +			break;
>> +		}
> 
> You really seem to overcomplicate things. Replace array search with the
> indexed array access. Much easier and much better.
> 
> enum iris_buffer_region {
> 	IRIS_PIXEL_REGION,
> 	IRIS_BITSTREAM_REGION,
> 	IRIS_NON_PIXEL_REGION,
> 	// add more when necessary
> 	IRIS_NUM_REGIONS,
> };
> 
> struct iris_core {
> 	struct iris_cb_device cb_devices[IRIS_NUM_REGIONS];
> };
> 
> region = iris_get_region(inst, buffer_type);
> dev = core->cb_devices[region];

all the regions may/may not be present in all SOC

> if (!dev)
> 	dev = core->dev;
> 
> 
>> +	}
>> +
>> +	if (!dev)
>> +		dev = core->dev;
>> +
>> +	return dev;
>> +}
>> diff --git a/drivers/media/platform/qcom/iris/iris_resources.h b/drivers/media/platform/qcom/iris/iris_resources.h
>> index b7efe15facb203eea9ae13d5f0abdcc2ea718b4d..ea31726f1789130fccf6b24540a62b86cb3c36ac 100644
>> --- a/drivers/media/platform/qcom/iris/iris_resources.h
>> +++ b/drivers/media/platform/qcom/iris/iris_resources.h
>> @@ -16,5 +16,7 @@ int iris_set_icc_bw(struct iris_core *core, unsigned long icc_bw);
>>   int iris_disable_unprepare_clock(struct iris_core *core, enum platform_clk_type clk_type);
>>   int iris_prepare_enable_clock(struct iris_core *core, enum platform_clk_type clk_type);
>>   int iris_create_child_device_and_map(struct iris_core *core, struct iris_context_bank *cb);
>> +struct device *iris_get_cb_dev(struct iris_core *core, struct iris_inst *inst,
>> +			       enum iris_buffer_type buffer_type);
>>   
>>   #endif
>> diff --git a/drivers/media/platform/qcom/iris/iris_vidc.c b/drivers/media/platform/qcom/iris/iris_vidc.c
>> index bd38d84c9cc79d15585ed5dd5f905a37521cb6dc..b61d7941d88662f34a9d2ab3b6c5bd9acf4b5df5 100644
>> --- a/drivers/media/platform/qcom/iris/iris_vidc.c
>> +++ b/drivers/media/platform/qcom/iris/iris_vidc.c
>> @@ -107,7 +107,7 @@ iris_m2m_queue_init(void *priv, struct vb2_queue *src_vq, struct vb2_queue *dst_
>>   	src_vq->drv_priv = inst;
>>   	src_vq->buf_struct_size = sizeof(struct iris_buffer);
>>   	src_vq->min_reqbufs_allocation = MIN_BUFFERS;
>> -	src_vq->dev = inst->core->dev;
>> +	src_vq->dev = iris_get_cb_dev(inst->core, inst, BUF_INPUT);
>>   	src_vq->lock = &inst->ctx_q_lock;
>>   	ret = vb2_queue_init(src_vq);
>>   	if (ret)
>> @@ -121,7 +121,7 @@ iris_m2m_queue_init(void *priv, struct vb2_queue *src_vq, struct vb2_queue *dst_
>>   	dst_vq->drv_priv = inst;
>>   	dst_vq->buf_struct_size = sizeof(struct iris_buffer);
>>   	dst_vq->min_reqbufs_allocation = MIN_BUFFERS;
>> -	dst_vq->dev = inst->core->dev;
>> +	dst_vq->dev = iris_get_cb_dev(inst->core, inst, BUF_OUTPUT);
>>   	dst_vq->lock = &inst->ctx_q_lock;
>>   
>>   	return vb2_queue_init(dst_vq);
>>
>> -- 
>> 2.34.1
>>
> 

