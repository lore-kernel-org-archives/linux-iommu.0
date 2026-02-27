Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AE337D111
	for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 20:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772224034; cv=none; b=TcUXq051MYAsAt510/zc5bQcQoVireQJuyCXoA6CFRmrXinTyFAsNhhemXb5c3WtDb4k4iRQMVcCywimbdC4Qv/pBuM96QG5q4FBRb5Lvfkfio+WCjUl/iElA013euGk3knesZbF+uVf3DDbXkiBDbw+X+N3m9yqxj4NnpRKZjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772224034; c=relaxed/simple;
	bh=G4KSi1rCWXkPvRV3kIAD502G+z9c0C0CCvofQGVx06U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P49kWzlobZYlUpXPOi2aZzxFe4FJ26tgHwQffRS3RYGL6LARoeMfkKKiWcnmt3LtRyH+/xclZ+9DD+Z3HoHsOQTnD+x8BzWH/TjajJBSkbw2qWVxmObJdqAU+0UWlE/o9srRVcF75DW5qxZgyKJ2VmIlnQXBLvYUJisc2GjB7Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NTac3QiW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PW7JVjcq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NTac3QiW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PW7JVjcq"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61RH0T58527615
	for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 20:27:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Pfgjqao86DDOZSnmHv97o8qK
	cw+61F1ZJvRFQWhffrA=; b=NTac3QiW+HLzO1ZZo1KQUYLgdkgTKejcUeuwVoFH
	2LysQX8SkMWLbHO2aRjC2LzRoWX+XrcgY/3azWeaD+/JhQ9rgRY7ZY8APzlnBl6Z
	YaBHFGthn7DiDbWA9v3Y0+Mqq9wvzXzCWna7vWDa0GNvRAtNEZvFKrJ7ST2ajNV0
	T/4DrzvPANb+xhuHU2U/rG+NaB1awV/onmMWTN5BHl4Pm7SW0jKVcXSr6aidcTTd
	H4JqYYo047vXzu++APMoApUlr3D7HFKeo13WTTbvZVRmaEyNXBYeA4jewH02PYRQ
	8Ia+AuKLxV64JIywI+f1SSxRPLfUCUlE5cqtvc+ymGSUFQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cjw23c8ds-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 20:27:12 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cb3fae6f60so2469964385a.1
        for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 12:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772224031; x=1772828831; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pfgjqao86DDOZSnmHv97o8qKcw+61F1ZJvRFQWhffrA=;
        b=PW7JVjcqt10q77k9p7uvRlY9asiNuS5UDyQthzkWkWESYSBd41lNa4DXUL7HUDfUVT
         oByOVJ8dndpabLHyC/788p3Qc/nMqiDMIIt5kgTS7iSs0nfdqV+hqzcIvwWjhPyrRyq0
         wDAy3uupFPYwBKurmLULqmb6kAC8nFHdsAoz3RpCYR8or8SYept1ghMNocz1Vc/96pPZ
         HvnM+7//H8yCuEs995eYaNJqP0+VrgrcAXtqkluXHjWEuY0hUpl1aGKEVhTNtYQOlgPh
         TKt5zZqSbXVApQlvOfHy9HB5x9Rte0UM4/YI6foMpBV32R6seuceS9ISNjk6AXsZ49Mz
         bJdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772224031; x=1772828831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pfgjqao86DDOZSnmHv97o8qKcw+61F1ZJvRFQWhffrA=;
        b=jVryHMhANNWmkmST+mzwKOU5QfoEQiM5VHzxBCDFIiZFYNS7Fb8q6g1DuYWfknAApp
         IONK07klvg+diiKkC4+CxafB4BaGcfpp4Nl6pt+JaJNrVeH8pqfoueU4NWeRLpUUlxCQ
         cLLWsjmhOxuCaGUTvA1WJPS8JPA79wl62bIjCZK3bWEPuSYOYxp0h5jhmXe9jZkwE9nr
         7Dw7Ifh0GMolMczO7tqpZ6Apu7cd+TPJaHZkDBD69Ther7jTNlMsx6zyxGyoEekGc4zJ
         sA+I9I/1rWneeXqxGlFQEu+97GSojYI742fjmVwKDDArigewrmXUcSUBvmEsJ7kG0qs/
         gs4A==
X-Forwarded-Encrypted: i=1; AJvYcCVyTVsa5XjEVI5QYtbbOOOEXk/3eaQUngidClIviwIJyBEVIbRx9L3svKcvyHiVu2RbehjzEQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxkkNvvNqyQFq4jw+sjsanl5BLHpnFDlzRdJ2jt3RUBYyAkyZ91
	tu7j34gY+FIE7avPqonv9F78t6/FMo2cjALdH6zhRswH0h7ruBOUZox/cW2JGMTzFI18Ww1ugPc
	vzh/1OzU3G2Mm5+n352M1WkAZniSewbjql7yFpIZvDs88+PliPqsEPFIxLg==
X-Gm-Gg: ATEYQzzTMGR78qOYHEJ05b5+zzxWbtqfvgHsf3rdm3POnpx9wjXgP292hPjFQzby1zI
	anHocJyAxUYH43y8DvcKgpXwLwiaT8dhzVMnIgvjwsACLaar6RksWZs3mVM0RPXfUSR2N2uXQiX
	4sphT+3dLAm2DqpjgiRkvBizmou91yH9uv2MD/Ol9pfL3gx1EboTvUcX7lQkpryhCXJZc7FZMwj
	u7Tt3cpzPhf97osAJBvjWCsaOsl/WlQFC1KvQt/Z1VzGKSxgauMIMz/mfBDZl3nJ55q4g/ARvoq
	zsVhMuB/deH0S+ZEX9RFJ82AsU9fVRGdJbCp683R2fxpv7+27t4mn7YT5XFgaUxC+DLLEbeVhRO
	orbLnp1YZFcMxLzIaH/Cu4v545nl2DAoEkA8dUrz1fmNsf0n4qdFAlmWdILLuELWLlc3+Id4lvL
	l1Hvb1vMLnpPbI02mfKuO1Tbd+mB66mN+sVys=
X-Received: by 2002:a05:620a:190b:b0:8b2:e17a:17e3 with SMTP id af79cd13be357-8cbbf35268fmr1014786385a.1.1772224031072;
        Fri, 27 Feb 2026 12:27:11 -0800 (PST)
X-Received: by 2002:a05:620a:190b:b0:8b2:e17a:17e3 with SMTP id af79cd13be357-8cbbf35268fmr1014780585a.1.1772224030507;
        Fri, 27 Feb 2026 12:27:10 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a115bce377sm156944e87.15.2026.02.27.12.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 12:27:09 -0800 (PST)
Date: Fri, 27 Feb 2026 22:27:06 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
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
Subject: Re: [PATCH v2 5/7] media: iris: add helper to select context bank
 device
Message-ID: <bi3i37ho3ppzlgdx264ohxpcem3nwumjelzckf4x5uzdj5rt7a@2y2jrilmfimj>
References: <20260227-kaanapali-iris-v2-0-850043ac3933@oss.qualcomm.com>
 <20260227-kaanapali-iris-v2-5-850043ac3933@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227-kaanapali-iris-v2-5-850043ac3933@oss.qualcomm.com>
X-Proofpoint-GUID: kSQ_73qPHK5In1jjwYjA7NOWxUFit7N9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE3OSBTYWx0ZWRfXy+00ZcwrF0PI
 jxF8KKiVaNwwbdd7K9L3bTDG4y7e9oSG2sEHZXXYS0HkpTiP+mOCwYILNcwAB/0rp2AgduzOJ/K
 4yJnzZZx3y8cJNi9Hu0aky/VHKZlgNyrLAVcjzgz/X559Y5ihcmt+aaOpvBYcn4d+plRdwwNDOX
 EHuhMjAV1I/24CpbsozHgFS35cdL/shfPYX6aXlDwxpuo/pJ+nlVr2b9wzw5LL52bq72FSs72Mk
 SMrLnilwYblPje4ABK403l6KtZktGoORYAYv9mc70y29idI7NCRkp5v6II6s2fsG8kBRFBN+HIS
 rjyW15akTxu6buuhUTMbBDbAd8SzXhtC6S2oYXMVJFQaqax7pHE+ZNTD2E/EP0y64Krcvl8jk/P
 X72W924pwmiui3jo+mUEVdue2Lo5i6Fm7aG6Z075UEqp8XDZ9z2uZBvmDBZVtXO2U13SFDJq92z
 EepWxmDW5dD/25yJ7tw==
X-Authority-Analysis: v=2.4 cv=cJHtc1eN c=1 sm=1 tr=0 ts=69a1fe20 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=yAKpaHWEUlDujkGj9tIA:9 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: kSQ_73qPHK5In1jjwYjA7NOWxUFit7N9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_04,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270179

On Fri, Feb 27, 2026 at 07:41:21PM +0530, Vikash Garodia wrote:
> Depending on the buffer type (input, output, internal and interface
> queues), associated context bank is selected, if available. Fallback to
> parent device for backward compatibility.
> 
> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> ---
>  drivers/media/platform/qcom/iris/iris_buffer.c    |  7 +--
>  drivers/media/platform/qcom/iris/iris_buffer.h    |  2 +
>  drivers/media/platform/qcom/iris/iris_hfi_queue.c | 16 +++---
>  drivers/media/platform/qcom/iris/iris_resources.c | 60 +++++++++++++++++++++++
>  drivers/media/platform/qcom/iris/iris_resources.h |  2 +
>  drivers/media/platform/qcom/iris/iris_vidc.c      |  4 +-
>  6 files changed, 79 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_buffer.c b/drivers/media/platform/qcom/iris/iris_buffer.c
> index 9151f43bc6b9c2c34c803de4231d1e6de0bec6c4..95962c19c334f08a74c5b7e8ba978ab631a65e9c 100644
> --- a/drivers/media/platform/qcom/iris/iris_buffer.c
> +++ b/drivers/media/platform/qcom/iris/iris_buffer.c
> @@ -335,8 +335,8 @@ void iris_get_internal_buffers(struct iris_inst *inst, u32 plane)
>  static int iris_create_internal_buffer(struct iris_inst *inst,
>  				       enum iris_buffer_type buffer_type, u32 index)
>  {
> +	struct device *dev = iris_get_cb_dev(inst->core, inst, buffer_type);
>  	struct iris_buffers *buffers = &inst->buffers[buffer_type];
> -	struct iris_core *core = inst->core;
>  	struct iris_buffer *buffer;
>  
>  	if (!buffers->size)
> @@ -352,7 +352,7 @@ static int iris_create_internal_buffer(struct iris_inst *inst,
>  	buffer->buffer_size = buffers->size;
>  	buffer->dma_attrs = DMA_ATTR_WRITE_COMBINE | DMA_ATTR_NO_KERNEL_MAPPING;
>  
> -	buffer->kvaddr = dma_alloc_attrs(core->dev, buffer->buffer_size,
> +	buffer->kvaddr = dma_alloc_attrs(dev, buffer->buffer_size,
>  					 &buffer->device_addr, GFP_KERNEL, buffer->dma_attrs);
>  	if (!buffer->kvaddr) {
>  		kfree(buffer);
> @@ -490,9 +490,10 @@ int iris_queue_internal_buffers(struct iris_inst *inst, u32 plane)
>  int iris_destroy_internal_buffer(struct iris_inst *inst, struct iris_buffer *buffer)
>  {
>  	struct iris_core *core = inst->core;
> +	struct device *dev = iris_get_cb_dev(core, inst, buffer->type);
>  
>  	list_del(&buffer->list);
> -	dma_free_attrs(core->dev, buffer->buffer_size, buffer->kvaddr,
> +	dma_free_attrs(dev, buffer->buffer_size, buffer->kvaddr,
>  		       buffer->device_addr, buffer->dma_attrs);
>  	kfree(buffer);
>  
> diff --git a/drivers/media/platform/qcom/iris/iris_buffer.h b/drivers/media/platform/qcom/iris/iris_buffer.h
> index 75bb767761824c4c02e0df9b765896cc093be333..9520aa290b44f06ed2004ad89940c19d1c08a3d2 100644
> --- a/drivers/media/platform/qcom/iris/iris_buffer.h
> +++ b/drivers/media/platform/qcom/iris/iris_buffer.h
> @@ -28,6 +28,7 @@ struct iris_inst;
>   * @BUF_SCRATCH_2: buffer to store encoding context data for HW
>   * @BUF_VPSS: buffer to store VPSS context data for HW
>   * @BUF_PARTIAL: buffer for AV1 IBC data
> + * @BUF_HFI_QUEUE: buffer for hardware firmware interface queue

Separate commit?

>   * @BUF_TYPE_MAX: max buffer types
>   */
>  enum iris_buffer_type {
> @@ -44,6 +45,7 @@ enum iris_buffer_type {
>  	BUF_SCRATCH_2,
>  	BUF_VPSS,
>  	BUF_PARTIAL,
> +	BUF_HFI_QUEUE,
>  	BUF_TYPE_MAX,
>  };
>  
> diff --git a/drivers/media/platform/qcom/iris/iris_hfi_queue.c b/drivers/media/platform/qcom/iris/iris_hfi_queue.c
> index b3ed06297953b902d5ea6c452385a88d5431ac66..c1241fb8dc6519020a063cbba87aed665701d7ae 100644
> --- a/drivers/media/platform/qcom/iris/iris_hfi_queue.c
> +++ b/drivers/media/platform/qcom/iris/iris_hfi_queue.c
> @@ -245,25 +245,26 @@ static void iris_hfi_queue_deinit(struct iris_iface_q_info *iface_q)
>  
>  int iris_hfi_queues_init(struct iris_core *core)
>  {
> +	struct device *dev = iris_get_cb_dev(core, NULL, BUF_HFI_QUEUE);
>  	struct iris_hfi_queue_table_header *q_tbl_hdr;
>  	u32 queue_size;
>  
>  	/* Iris hardware requires 4K queue alignment */
>  	queue_size = ALIGN((sizeof(*q_tbl_hdr) + (IFACEQ_QUEUE_SIZE * IFACEQ_NUMQ)), SZ_4K);
> -	core->iface_q_table_vaddr = dma_alloc_attrs(core->dev, queue_size,
> +	core->iface_q_table_vaddr = dma_alloc_attrs(dev, queue_size,
>  						    &core->iface_q_table_daddr,
>  						    GFP_KERNEL, DMA_ATTR_WRITE_COMBINE);
>  	if (!core->iface_q_table_vaddr) {
> -		dev_err(core->dev, "queues alloc and map failed\n");
> +		dev_err(dev, "queues alloc and map failed\n");
>  		return -ENOMEM;
>  	}
>  
> -	core->sfr_vaddr = dma_alloc_attrs(core->dev, SFR_SIZE,
> +	core->sfr_vaddr = dma_alloc_attrs(dev, SFR_SIZE,
>  					  &core->sfr_daddr,
>  					  GFP_KERNEL, DMA_ATTR_WRITE_COMBINE);
>  	if (!core->sfr_vaddr) {
> -		dev_err(core->dev, "sfr alloc and map failed\n");
> -		dma_free_attrs(core->dev, sizeof(*q_tbl_hdr), core->iface_q_table_vaddr,
> +		dev_err(dev, "sfr alloc and map failed\n");
> +		dma_free_attrs(dev, sizeof(*q_tbl_hdr), core->iface_q_table_vaddr,
>  			       core->iface_q_table_daddr, DMA_ATTR_WRITE_COMBINE);
>  		return -ENOMEM;
>  	}
> @@ -291,6 +292,7 @@ int iris_hfi_queues_init(struct iris_core *core)
>  
>  void iris_hfi_queues_deinit(struct iris_core *core)
>  {
> +	struct device *dev = iris_get_cb_dev(core, NULL, BUF_HFI_QUEUE);
>  	u32 queue_size;
>  
>  	if (!core->iface_q_table_vaddr)
> @@ -300,7 +302,7 @@ void iris_hfi_queues_deinit(struct iris_core *core)
>  	iris_hfi_queue_deinit(&core->message_queue);
>  	iris_hfi_queue_deinit(&core->command_queue);
>  
> -	dma_free_attrs(core->dev, SFR_SIZE, core->sfr_vaddr,
> +	dma_free_attrs(dev, SFR_SIZE, core->sfr_vaddr,
>  		       core->sfr_daddr, DMA_ATTR_WRITE_COMBINE);
>  
>  	core->sfr_vaddr = NULL;
> @@ -309,7 +311,7 @@ void iris_hfi_queues_deinit(struct iris_core *core)
>  	queue_size = ALIGN(sizeof(struct iris_hfi_queue_table_header) +
>  		(IFACEQ_QUEUE_SIZE * IFACEQ_NUMQ), SZ_4K);
>  
> -	dma_free_attrs(core->dev, queue_size, core->iface_q_table_vaddr,
> +	dma_free_attrs(dev, queue_size, core->iface_q_table_vaddr,
>  		       core->iface_q_table_daddr, DMA_ATTR_WRITE_COMBINE);
>  
>  	core->iface_q_table_vaddr = NULL;
> diff --git a/drivers/media/platform/qcom/iris/iris_resources.c b/drivers/media/platform/qcom/iris/iris_resources.c
> index be58e8620086d0f82c2c2bda29247483f5c56d79..65544cb0fa8fc4b250b0a0be1bb900d74b999d35 100644
> --- a/drivers/media/platform/qcom/iris/iris_resources.c
> +++ b/drivers/media/platform/qcom/iris/iris_resources.c
> @@ -13,6 +13,7 @@
>  #include <linux/reset.h>
>  
>  #include "iris_core.h"
> +#include "iris_instance.h"
>  #include "iris_resources.h"
>  
>  #define BW_THRESHOLD 50000
> @@ -177,3 +178,62 @@ int iris_create_child_device_and_map(struct iris_core *core, struct iris_context
>  
>  	return 0;
>  }
> +
> +static enum iris_buffer_region iris_get_region(struct iris_inst *inst,
> +					       enum iris_buffer_type buffer_type)
> +{
> +	switch (buffer_type) {
> +	case BUF_INPUT:
> +		if (inst && inst->domain == ENCODER)

Can inst be NULL here?

> +			return IRIS_PIXEL_REGION;
> +		else if (inst && inst->domain == DECODER)
> +			return IRIS_BITSTREAM_REGION;

Are there any other possibilities than encoder and decoder?

> +		break;
> +	case BUF_OUTPUT:
> +		if (inst && inst->domain == ENCODER)
> +			return IRIS_BITSTREAM_REGION;
> +		else if (inst && inst->domain == DECODER)
> +			return IRIS_PIXEL_REGION;
> +		break;
> +	case BUF_BIN:
> +		return IRIS_BITSTREAM_REGION;
> +	case BUF_DPB:
> +	case BUF_PARTIAL:
> +	case BUF_SCRATCH_2:
> +	case BUF_VPSS:
> +		return IRIS_PIXEL_REGION;
> +	case BUF_ARP:
> +	case BUF_COMV:
> +	case BUF_HFI_QUEUE:
> +	case BUF_LINE:
> +	case BUF_NON_COMV:
> +	case BUF_PERSIST:
> +		return IRIS_NON_PIXEL_REGION;
> +	default:
> +		return 0;

dev_err(dev, "unsupported buffer type %x\n", buffer_type)
return -EINVAL;

> +	}
> +
> +	return 0;

Drop

> +}
> +
> +struct device *iris_get_cb_dev(struct iris_core *core, struct iris_inst *inst,
> +			       enum iris_buffer_type buffer_type)
> +{
> +	enum iris_buffer_region region;
> +	struct device *dev = NULL;
> +	int i;
> +
> +	region = iris_get_region(inst, buffer_type);
> +
> +	for (i = 0; i < core->iris_platform_data->cb_data_size; i++) {
> +		if (core->iris_platform_data->cb_data[i].region & region) {
> +			dev = core->iris_platform_data->cb_data[i].dev;
> +			break;
> +		}

You really seem to overcomplicate things. Replace array search with the
indexed array access. Much easier and much better.

enum iris_buffer_region {
	IRIS_PIXEL_REGION,
	IRIS_BITSTREAM_REGION,
	IRIS_NON_PIXEL_REGION,
	// add more when necessary
	IRIS_NUM_REGIONS,
};

struct iris_core {
	struct iris_cb_device cb_devices[IRIS_NUM_REGIONS];
};

region = iris_get_region(inst, buffer_type);
dev = core->cb_devices[region];
if (!dev)
	dev = core->dev;


> +	}
> +
> +	if (!dev)
> +		dev = core->dev;
> +
> +	return dev;
> +}
> diff --git a/drivers/media/platform/qcom/iris/iris_resources.h b/drivers/media/platform/qcom/iris/iris_resources.h
> index b7efe15facb203eea9ae13d5f0abdcc2ea718b4d..ea31726f1789130fccf6b24540a62b86cb3c36ac 100644
> --- a/drivers/media/platform/qcom/iris/iris_resources.h
> +++ b/drivers/media/platform/qcom/iris/iris_resources.h
> @@ -16,5 +16,7 @@ int iris_set_icc_bw(struct iris_core *core, unsigned long icc_bw);
>  int iris_disable_unprepare_clock(struct iris_core *core, enum platform_clk_type clk_type);
>  int iris_prepare_enable_clock(struct iris_core *core, enum platform_clk_type clk_type);
>  int iris_create_child_device_and_map(struct iris_core *core, struct iris_context_bank *cb);
> +struct device *iris_get_cb_dev(struct iris_core *core, struct iris_inst *inst,
> +			       enum iris_buffer_type buffer_type);
>  
>  #endif
> diff --git a/drivers/media/platform/qcom/iris/iris_vidc.c b/drivers/media/platform/qcom/iris/iris_vidc.c
> index bd38d84c9cc79d15585ed5dd5f905a37521cb6dc..b61d7941d88662f34a9d2ab3b6c5bd9acf4b5df5 100644
> --- a/drivers/media/platform/qcom/iris/iris_vidc.c
> +++ b/drivers/media/platform/qcom/iris/iris_vidc.c
> @@ -107,7 +107,7 @@ iris_m2m_queue_init(void *priv, struct vb2_queue *src_vq, struct vb2_queue *dst_
>  	src_vq->drv_priv = inst;
>  	src_vq->buf_struct_size = sizeof(struct iris_buffer);
>  	src_vq->min_reqbufs_allocation = MIN_BUFFERS;
> -	src_vq->dev = inst->core->dev;
> +	src_vq->dev = iris_get_cb_dev(inst->core, inst, BUF_INPUT);
>  	src_vq->lock = &inst->ctx_q_lock;
>  	ret = vb2_queue_init(src_vq);
>  	if (ret)
> @@ -121,7 +121,7 @@ iris_m2m_queue_init(void *priv, struct vb2_queue *src_vq, struct vb2_queue *dst_
>  	dst_vq->drv_priv = inst;
>  	dst_vq->buf_struct_size = sizeof(struct iris_buffer);
>  	dst_vq->min_reqbufs_allocation = MIN_BUFFERS;
> -	dst_vq->dev = inst->core->dev;
> +	dst_vq->dev = iris_get_cb_dev(inst->core, inst, BUF_OUTPUT);
>  	dst_vq->lock = &inst->ctx_q_lock;
>  
>  	return vb2_queue_init(dst_vq);
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
