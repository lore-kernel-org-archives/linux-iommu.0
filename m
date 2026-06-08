Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA6C348C46
	for <iommu@lists.linux.dev>; Mon,  8 Jun 2026 05:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780895681; cv=none; b=gnxMVrwkzN9zTFO+ivgFcfm11ufWNdLxUjBVdoxStATV+aXqlXg/qqQudkFoDnPYRFylBXPrEYPcDCgzs8FSufjag9y7uqiQpCocrZkEbcfU9/RSca6luOOKlX7OL40qWzZJ0akIiHve8TIgaUxt3d9VSu+oxHqxg9YpAspDSrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780895681; c=relaxed/simple;
	bh=eqTMgek8olZX6BTssVvsPxd40M1iYrM7I1ZtIjCzb4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uaG6t58T7CLRKJFsLfmKcvWrZHgKeV1Om68CbZlRTDLpjKnOpZILXEPIscLJjQWW758nKW15J2xBgwAh96PB/JokUaDVKeTD5OYmQ2Y0UP+f+5CvJa7FX//ScaCo4VLcrFcrW+lZDzZwy0kg1AJ8IPH3wNxw8XEM693pBrKKcLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Bo+9GAkH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ijaVFhjK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Bo+9GAkH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ijaVFhjK"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6580EC601535042
	for <iommu@lists.linux.dev>; Mon, 8 Jun 2026 05:14:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	06YKS2t9ahDNR8mpib/s6eXRS8K7e5yjLmLG8WJkTSk=; b=Bo+9GAkH3R1PpgxK
	saJ2dHX62iPorEkfzfK4XOBg/Mg3Pwr/8C/EG9G4QXVHmf8kB967RpcnR/3yCTp0
	fXMST16hMyZrpH/XvN270nmSWNqYapUK4NK/KEwlcnabNN4tKFY5l89LGpC+ky1P
	nLYoadq0uWNQPSw5PMvJoigxQhh/R86vzD6gn+f2zDnyK9VlIkoppZUmKs/NtQbx
	tMbRK75T+AM6nw0YVZe2TsrwcF2ddjOiQIjoTQq8AhOTHLA5NJzJ3ktIfSw9ajPt
	IVlTQVWeqvlyYDSZ34nhGodkPDc3JH2srN3Q1eEW0OaZDBPPa0qxHXUjSxAqsUrM
	RCAMDg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emagre6he-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 08 Jun 2026 05:14:39 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2c0c331eda3so42025845ad.2
        for <iommu@lists.linux.dev>; Sun, 07 Jun 2026 22:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780895678; x=1781500478; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=06YKS2t9ahDNR8mpib/s6eXRS8K7e5yjLmLG8WJkTSk=;
        b=ijaVFhjKQ68/DCNlZ1oB2UVBqksZh4zp/kCOcxTrDyrIwEuIsYeT4BN/QxnLQ4gkcl
         fKhbUDw0142b9v5A85YypLW9nRvnWLxD1dUqn+1MzEZ1KgLG/boqB5hU4b++opKCMeac
         6R0nF+r3mmATBqS5vTAJqiZpPAx5BiDA+gRbL1yXcqcg2uWq2ZpQUb0kLPsjcOtBacS+
         lOZtrG28eRqlVu2S+gJp/LgRgy0LOJsFlFqXq30AgIGq5v5+GlrA0cANiEg2WLLLHV3O
         hDOR7n7kxjAj7GQuCnixMlGdOYxYDJljs29Xo5If+AqvXC+VU4FVY5jQ6YBuwnO++Qd2
         z8DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780895678; x=1781500478;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=06YKS2t9ahDNR8mpib/s6eXRS8K7e5yjLmLG8WJkTSk=;
        b=Eo5ZjHTuARfPWwe8Up2xTXJmZdVDeNa3Uz0aaYHT2lrx/3fUq86igriEVBn6jFH1I2
         mpST7Gfkh5tfWNejIW9RcLdcqwm0WQwbTUl4mKVX/x6ilSxsaGnaoFsAHZWURVhuCcUN
         cXk15/5dgs0pjH2HrMCyVGHpLCJ/xqEWhZfZtelXamrAzUDwtEEJ/OM3hTeZ3VzTna/c
         X7xCZzf6Doj3eqPZNFTczIws7uYXAQaBjBelnFDRCOliy+P33v8AFb0nPMgA5cq36ELK
         5P5olXUPoasMEQxuif9PSED9wtTQlpurWQfMxrOsh2sMI35jeCx5tM/AcxM5MitPxgnf
         JUTQ==
X-Forwarded-Encrypted: i=1; AFNElJ/JbyXo9a74lT7gmZVQ1cwDJ+8yRR735yYMp0mfXBdQ4CdlxcsD3I4Ra5Jc+DT7pnf0MWAr1A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz5yOL6lyNpCUhuwiKPMkNB4MUEXbqZpb4IEAW+/K3qfbGy+gJl
	81TpjA6CghUYExEieDv+IQbR4kfTLmGD2d3bqlXRR8dI2ENFgXSTqwm9MpnrYtqSd/RDaAp+FAs
	73lSZkofbaedTC/gwZFW2dOJzx9eg+MVcChBmM3Lut4my2p7DDDenlIhdfg==
X-Gm-Gg: Acq92OE5+0N5cwmae9lLwTckRKFgasHlirM4tgX0SkT7eUnsGbKYzpO8nHFIDUmR30E
	1wVqYrJ3AvpnfmMXKxglhmoYgVpQL7PJFMsfO7oZ8/KiCCd5UBVpswEs6LpkTjeRWzP3zLl30Lh
	IzSeEjXjZFJ8Wz2VT+FhtGAtkGmxWeXA214P3LncYodAKk0sxYqz4WpUvD4nH6uD6H7iuhB/5CR
	/4tjBvDrgZpvkrZ253aQ3z5CgUqjdQV+lsVlCVZVb/JqAPy1n8rpqkr1+jM1Twn5A8qcOnKuOZb
	nW2bXcBwBrqKg4X1p9QgskSuog/Ulr8extfjwN+YQBt4PzycGaqZZY6l4NlQZdTGchiTF9KBEKk
	iVYkXcM0nQc+ggSD5Rhf6bYJmxYBdwAtlDNS6it9Ok5aW9Xoi6GSs5PqbSLOwJw==
X-Received: by 2002:a17:903:2ac3:b0:2c0:b932:866e with SMTP id d9443c01a7336-2c1e8934f70mr152930945ad.27.1780895678310;
        Sun, 07 Jun 2026 22:14:38 -0700 (PDT)
X-Received: by 2002:a17:903:2ac3:b0:2c0:b932:866e with SMTP id d9443c01a7336-2c1e8934f70mr152930605ad.27.1780895677843;
        Sun, 07 Jun 2026 22:14:37 -0700 (PDT)
Received: from [10.204.79.117] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c1664a67b0sm169055115ad.80.2026.06.07.22.14.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jun 2026 22:14:37 -0700 (PDT)
Message-ID: <dd014e3b-96fa-4019-a1b7-5826a877b87e@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 10:44:28 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/15] accel/qda: Add PRIME DMA-BUF import support
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>
Cc: Bharath Kumar <quic_bkumar@quicinc.com>,
        Chenna Kesava Raju <quic_chennak@quicinc.com>, srini@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, andersson@kernel.org,
        konradybcio@kernel.org, robin.clark@oss.qualcomm.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org
References: <20260519-qda-series-v1-0-b2d984c297f8@oss.qualcomm.com>
 <20260519-qda-series-v1-11-b2d984c297f8@oss.qualcomm.com>
 <3dddb7e8-5837-4038-9823-ce419cb49ec2@amd.com>
 <e465ed15-1568-467b-ac6b-94f903b46776@oss.qualcomm.com>
 <0feaad40-8bde-46c4-a251-07a1bd6ac79d@amd.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <0feaad40-8bde-46c4-a251-07a1bd6ac79d@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA0NSBTYWx0ZWRfX8RLCPZfyXXnf
 w60mvYiAg0jxv3t22emUpklUNZBiHyYzXjP/s+9BkJH9nBdfzsnfTUkXZQARKEGCyT9NBSzRnu8
 oSxhai0+HzcIn0QQLIpqmZHcxlBLbMvv1BLhRiwTZCHCNcr5Gp3qLZtQb8ia85OQfyuqFvqcee+
 7I493gwl2yis/I/KM2EfnMicitHvKT6O8GqjxKriHYlDonfVMjM/fiJiEOZGarQF3M09ViJpQeZ
 Qh/CDAwNxJSSwpYESLJJ+ZR62091NJAzb58AE07wuG81/GO6gPfuqDLA5TPhWDhzoXMr53ZEoKG
 oCnXtwfvaSG3zY/61xRwsCZ6XenYujwlQtPClgw7b1uoDxxruzQelD1umMCiqKU6uaKgqOTl5zy
 gB9pHxNScstEv1Q16Es8+z3FRmtBl/5QzPvNmuoQoFSVp+Wk+nQY9BKzPbeDeiW2lKi79GJ4Vqd
 6oGTPhhPIgW5u7u/Ovg==
X-Authority-Analysis: v=2.4 cv=G/4s1dk5 c=1 sm=1 tr=0 ts=6a264fbf cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=h427B1VOWG0w3MIzYIMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: f3h_zHvxxbQWqQlSPplLUjpF4kKrChtk
X-Proofpoint-GUID: f3h_zHvxxbQWqQlSPplLUjpF4kKrChtk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_01,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080045

On 03-06-2026 19:10, Christian König wrote:
> On 6/3/26 08:11, Ekansh Gupta wrote:
>> On 19-05-2026 12:25, Christian König wrote:
>>> On 5/19/26 08:16, Ekansh Gupta via B4 Relay wrote:
>>>> From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> ...
>>>> +static int qda_memory_manager_map_imported(struct qda_memory_manager *mem_mgr,
>>>> +                                          struct qda_gem_obj *gem_obj,
>>>> +                                          struct qda_iommu_device *iommu_dev)
>>>> +{
>>>> +       struct scatterlist *sg;
>>>> +       dma_addr_t dma_addr;
>>>> +
>>>> +       if (!gem_obj->is_imported || !gem_obj->sgt || !iommu_dev) {
>>>> +               drm_err(gem_obj->base.dev, "Invalid parameters for imported buffer mapping\n");
>>>> +               return -EINVAL;
>>>> +       }
>>>> +
>>>> +       sg = gem_obj->sgt->sgl;
>>>> +       if (!sg) {
>>>> +               drm_err(gem_obj->base.dev, "Invalid scatter-gather list for imported buffer\n");
>>>> +               return -EINVAL;
>>>> +       }
>>>> +
>>>> +       gem_obj->iommu_dev = iommu_dev;
>>>> +
>>>> +       /*
>>>> +        * After dma_buf_map_attachment_unlocked(), sg_dma_address() returns the
>>>> +        * IOMMU virtual address, not the physical address. The IOMMU maps the
>>>> +        * entire buffer as a contiguous range in the IOMMU address space even if
>>>> +        * the underlying physical memory is non-contiguous. Therefore the first
>>>> +        * sg entry's DMA address is the start of the complete contiguous
>>>> +        * IOMMU-mapped range and is sufficient to describe the buffer to the DSP.
>>>> +        */
>>>> +       dma_addr = sg_dma_address(sg);
>>>> +       dma_addr += ((u64)iommu_dev->sid << 32);
>>>> +       gem_obj->dma_addr = dma_addr;
>>>
>>> That handling here is completely broken since it assumes that the exporter maps the buffer as contigious range.
>>>
>>> But that's in no way guaranteed.
>> I'll collect more details and will try to implement this in the right
>> way, maybe by iterating the full sg_table.>
> 
> You could also document explicitly that you can only import contiguous buffers (e.g. DMA-buf heap CMA etc....) and then cleanly reject non contiguous buffers here.
> 
> We have quite a number of drivers/HW with that limitation, so only accepting contiguous buffers is perfectly ok.
> 
> You just can't silently assume that IOMMU would always map the entire buffer as one contiguous range, cause that is certainly not true.
I understand your point Christian, thanks for the suggestion!>
> Regards,
> Christian.
> 
> 
>>> Regards,
>>> Christian.

