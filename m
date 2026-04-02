Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15E2396B85
	for <iommu@lists.linux.dev>; Thu,  2 Apr 2026 08:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775118973; cv=none; b=uCTG54Sd8lF4FnqzIW7kawZ4KFBmewc6VQcgwq+Qy6+GgNJV4SiW3zTSr6ialuNpi6f8IUreEZK3tVJbj+JIKorDRsVKsZuYhTKcZvPJj73rT1MbiF2mKqhwKQ3WB80YGtR1/I22P9V31zGqTm5KSB7kMv8CUxNtpLPfJcj65L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775118973; c=relaxed/simple;
	bh=efq6KExaXloGlu4W+o6XXI3jit5Ma9jZElLXNdRwpoM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KBxRG1Lub4x3UCFRWV9QsHmP72EsspTvNDQyeqZSqsTkbsHO6FOEIUxC9QWRyqMjcmOrJbmghjpZy4kcmgTQ8sUfz9ez33BwnlwivahbqZ87mrW1bGMuJohPHqZwiQXCueb14bCQYfdcLfhoNlzih5/uL5eSY5LSmYgOT03gj4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RHma4SsO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Fx08YEb1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RHma4SsO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Fx08YEb1"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63276CVJ3955887
	for <iommu@lists.linux.dev>; Thu, 2 Apr 2026 08:36:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nZz3msypn/iPTQp7pBZHHsP/2F3PYJPj/B+Z6Rd1qmE=; b=RHma4SsOd/81yQFQ
	xAx6QCQAEfsXUYd1eiP/9KcSKt05B/8+nzzL65Ik3f6iUQz9+9v40os1eMNUM4Om
	IS9+3uV9M7/lJ0a6VZGq6psD7b30MCA+yw5iTekmwvuLomU4AkZYSi58G9jG5Mpa
	iOp2Y8QzPE972/fofH+xbDT6h1kVAjUtirRtXOJD/iBWVX/JGnpdt+p1fi87apVD
	1BHkr0w3slGvST99Bky9/WwAq3wJu5E2rRTGZuY1HvKgHB9TediDxYiK2oU1nnOM
	VB+ogu469E8DK5gDXnhY4WdZGMdplI6U/29ywBKz1Vr1nrk+2NFbY0oyylNTCK//
	s0HIyQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9aw5j7rr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 02 Apr 2026 08:36:10 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b2489af602so6627915ad.1
        for <iommu@lists.linux.dev>; Thu, 02 Apr 2026 01:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775118970; x=1775723770; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nZz3msypn/iPTQp7pBZHHsP/2F3PYJPj/B+Z6Rd1qmE=;
        b=Fx08YEb1V2qkfyt19LgDUT7Xx/nleYNrPeB6NZ+S9KtQFfce6RU1LUAPXceYC8pF7H
         6YYvwfKEhU+8Jzha8UWSJebCJrAfHHn0XrHmFKgEjooqE7bjYHWz5uA8pUlwoiYKQKVY
         tgZFVg6TR9Bzl8whwDIndQMn9U2XqPjH7RbHAPyArIicdBM2KaHMN1yQVxXTl1ewPAgy
         80/tOjz62cSp1NhqRABa+V1SFwBkFcegE1OZ1cWC9In7aiUyJaWJiBN1CsKaGrQKigWP
         m0U/0/l8G/syG72mxBB0Oaz5XmUyZhEV7VSAraqhVsv6wB2AhUQPLZpiGRH4jEXpdIEA
         6W2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775118970; x=1775723770;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nZz3msypn/iPTQp7pBZHHsP/2F3PYJPj/B+Z6Rd1qmE=;
        b=Kd6knGZzQFOXpXZGJFiRvBIf9UNeZKY0/x/6ukYNnkaPSRXO5rKH/TQJESnc12i3d+
         HBuvwemYfOQObNZgYI0HQdBwEHfcKxvn4x5DinAmMITrPRx9rKqt4cFOh/yA5zZks2pm
         LMG8p1+whv2Q+nT6FqUh65rdwZM4eXy9s2s3KXQE+ifFd9qsupwyYcv7QqzQMqNwV64e
         lkxEhTQTyk/cK9FvCTQiSosXXKjK34GVKC7N0E202dzXOgPjWnXGmumASxceIVIoAnOb
         knkrjiiDeASBUsP/FvJJ+EMbdsNdMTdgnvtw30CrP6KjkqpRXWdSeFlrfsQoNKbRJJ0n
         C3rA==
X-Forwarded-Encrypted: i=1; AJvYcCWivCkPcLd4o7rBedeebEoKJGkU2Usn8o6wx7840E5QCJhbXEdXEpf9nJr4CDhgVWhGDIrWsw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwVgghS073ndWHszuoMOoxob3AnES6peufM4kuPXTruw2+tD/Sd
	yGgboghAcoSZmXb9QK4owCX0zT1Z5c6fxmhFi4+fZgzywIi6gJ7w/QO/dNx9GsKXQmlhay15/q7
	KoRgVfhxJi8SFml3VeNXMTadcCeML6hxw0rDcakXtIm9qMopVt4EM5OR9VQ==
X-Gm-Gg: AeBDieugcmPbYkOhg/lKgAt1aept6Ax0lYSHQojn/WHF4OsV9JoTMHWodsejgv7PJ+D
	vLnT1FZNlgWKcnlMOOZ09e9fSG8ilUOpVv2/J9Qm5oh87paxA65P9uoIqtjEJp4bJzD8L2jJb/J
	hTsPfc/Q6vUCetHMyC7BiyKC2v9kYDvXvVY3Bx1y2pGfGuLU0SwfQtgxHLAG5g+eIscOeKVB6Lr
	zoKve+Y4S0EHNJ88KvKUeeXEFFS6oSWUxBHcBotnBTTCDWCFsX6L1LVvaUSeTngMp+CJFGIqUQI
	wwf0A7yI5EW4SZSL/S3LOGy79I1xDiIb/GL+pgFSOzIoynBVGHiErgBEi5sJG16geWFfnJCOksv
	fn2vOxVFJa4lw7orvOErZdJ06RH4riZH67imxtmgJP7G9jKMKVc3R
X-Received: by 2002:a17:902:db12:b0:2b2:4c30:e6e2 with SMTP id d9443c01a7336-2b277e256c0mr15094725ad.16.1775118969719;
        Thu, 02 Apr 2026 01:36:09 -0700 (PDT)
X-Received: by 2002:a17:902:db12:b0:2b2:4c30:e6e2 with SMTP id d9443c01a7336-2b277e256c0mr15094325ad.16.1775118969177;
        Thu, 02 Apr 2026 01:36:09 -0700 (PDT)
Received: from [192.168.1.14] ([110.225.167.58])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749e2e97sm27595375ad.82.2026.04.02.01.36.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 01:36:08 -0700 (PDT)
Message-ID: <998ce121-e027-441d-a3f4-2f3e41e10830@oss.qualcomm.com>
Date: Thu, 2 Apr 2026 14:06:00 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 12/18] accel/qda: Add PRIME dma-buf import support
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bharath Kumar <quic_bkumar@quicinc.com>,
        Chenna Kesava Raju <quic_chennak@quicinc.com>
References: <20260224-qda-firstpost-v1-0-fe46a9c1a046@oss.qualcomm.com>
 <20260224-qda-firstpost-v1-12-fe46a9c1a046@oss.qualcomm.com>
 <e87c0c1d-82f1-4a03-9a56-9bf3e03273cf@amd.com>
 <29f9bb45-5c3f-4847-a629-21cef540f38b@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <29f9bb45-5c3f-4847-a629-21cef540f38b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Q9jfIo2a c=1 sm=1 tr=0 ts=69ce2a7a cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=GstQyB7T1i92F5dDEt+vJw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=_EeEMxcBAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=yv3-IXtlHroiPP0bXpQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=czjwGCTIUPoA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: TFCDI-k-qcNuTSvDW5DXGrXCtkpXGFwG
X-Proofpoint-ORIG-GUID: TFCDI-k-qcNuTSvDW5DXGrXCtkpXGFwG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA3NiBTYWx0ZWRfXz9wHlXXJnEr0
 /lDoG3UbQNHlICaXcj+4Tg04W+zDUB5W/C7lVpNdyNqmj/mXDfz5nkJsl0gMAcsimrO133x9dSb
 qtLJ9qL0axS3Z6G/FsrnwlZ0KtN+GD74qCPqLBZ0ixp5yLwouAnhCp/CLgYaVHveJR5vqs3IAlv
 Drmsq1img3j+YegEhUSNU/EQgMy+E6zmBuMJAAbQeaCxFxos6fDp3Cau3pvyvWg4E9P7LR48ps2
 XNzWaP97R/84KRsxiwHMAp+H7qyd772V/tSxnvyLHei0kRSIuGz+DgKGTETzhXnLNm1R/1C+hFG
 +WsizLnDuNtjVAs04KTWSZzNynOxaqxTcq6yEJx5vnj4AOZFGZstvh72s0UqDWZ/jEdVFyN4zzN
 /tg2C5qGBZdCjsKrfC5vBa6eeumkZVOzWiD47xzWgpUty+73K5mX+UTKJiNRpanIv76NfVqePtg
 FFW+xpKN+MV0MpVnILA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604020076



On 3/9/2026 12:29 PM, Ekansh Gupta wrote:
>
> On 2/24/2026 2:42 PM, Christian König wrote:
>> On 2/23/26 20:09, Ekansh Gupta wrote:
>>> [Sie erhalten nicht häufig E-Mails von ekansh.gupta@oss.qualcomm.com. Weitere Informationen, warum dies wichtig ist, finden Sie unter https://aka.ms/LearnAboutSenderIdentification ]
>>>
>>> Add PRIME dma-buf import support for QDA GEM buffer objects and integrate
>>> it with the existing per-process memory manager and IOMMU device model.
>>>
>>> The implementation extends qda_gem_obj to represent imported dma-bufs,
>>> including dma_buf references, attachment state, scatter-gather tables
>>> and an imported DMA address used for DSP-facing book-keeping. The
>>> qda_gem_prime_import() path handles reimports of buffers originally
>>> exported by QDA as well as imports of external dma-bufs, attaching them
>>> to the assigned IOMMU device
>> That is usually an absolutely clear NO-GO for DMA-bufs. Where exactly in the code is that?
> dma_buf_attach* to comute-cb iommu devices are critical for DSPs to access the buffer.
> This is needed if the buffer is exported by anyone other than QDA(say system heap). If this is not
> the correct way, what should be the right way here? On the current fastrpc driver also,
> the DMABUF is getting attached with iommu device[1] due to the same requirement.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/misc/fastrpc.c#n779

Hi Christian,

Do you have any suggestions for the shared requirements?

I'm reworking on the next version and currently I don't see any other way
to handle dma_buf_attach* cases.

//Ekansh

>>> and mapping them through the memory manager
>>> for DSP access. The GEM free path is updated to unmap and detach
>>> imported buffers while preserving the existing behaviour for locally
>>> allocated memory.
>>>
>>> The PRIME fd-to-handle path is implemented in qda_prime_fd_to_handle(),
>>> which records the calling drm_file in a driver-private import context
>>> before invoking the core DRM helpers. The GEM import callback retrieves
>>> this context to ensure that an IOMMU device is assigned to the process
>>> and that imported buffers follow the same per-process IOMMU selection
>>> rules as natively allocated GEM objects.
>>>
>>> This patch prepares the driver for interoperable buffer sharing between
>>> QDA and other dma-buf capable subsystems while keeping IOMMU mapping and
>>> lifetime handling consistent with the existing GEM allocation flow.
>>>
>>> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>> ...
>>
>>> @@ -15,23 +16,29 @@ static int validate_gem_obj_for_mmap(struct qda_gem_obj *qda_gem_obj)
>>>                 qda_err(NULL, "Invalid GEM object size\n");
>>>                 return -EINVAL;
>>>         }
>>> -       if (!qda_gem_obj->iommu_dev || !qda_gem_obj->iommu_dev->dev) {
>>> -               qda_err(NULL, "Allocated buffer missing IOMMU device\n");
>>> -               return -EINVAL;
>>> -       }
>>> -       if (!qda_gem_obj->iommu_dev->dev) {
>>> -               qda_err(NULL, "Allocated buffer missing IOMMU device\n");
>>> -               return -EINVAL;
>>> -       }
>>> -       if (!qda_gem_obj->virt) {
>>> -               qda_err(NULL, "Allocated buffer missing virtual address\n");
>>> -               return -EINVAL;
>>> -       }
>>> -       if (qda_gem_obj->dma_addr == 0) {
>>> -               qda_err(NULL, "Allocated buffer missing DMA address\n");
>>> -               return -EINVAL;
>>> +       if (qda_gem_obj->is_imported) {
>> Absolutely clear NAK to that. Imported buffers *can't* be mmaped through the importer!
>>
>> Userspace needs to mmap() them through the exporter.
>>
>> If you absolutely have to map them through the importer for uAPI backward compatibility then there is dma_buf_mmap() for that, but this is clearly not the case here.
>>
>> ...
> Okay, the requirement is slightly different here. Any buffer which is not allocated using the
> QDA GEM interface needs to be attached to the iommu device for that particular process to
> enable DSP for the access. I should not call it `mmap` instead it should be called importing the
> buffer to a particular iommu context bank. With this definition, is it fine to keep it this way? Or
> should the dma_buf_attach* calls be moved to some other place?
>>> +static int qda_memory_manager_map_imported(struct qda_memory_manager *mem_mgr,
>>> +                                          struct qda_gem_obj *gem_obj,
>>> +                                          struct qda_iommu_device *iommu_dev)
>>> +{
>>> +       struct scatterlist *sg;
>>> +       dma_addr_t dma_addr;
>>> +       int ret = 0;
>>> +
>>> +       if (!gem_obj->is_imported || !gem_obj->sgt || !iommu_dev) {
>>> +               qda_err(NULL, "Invalid parameters for imported buffer mapping\n");
>>> +               return -EINVAL;
>>> +       }
>>> +
>>> +       gem_obj->iommu_dev = iommu_dev;
>>> +
>>> +       sg = gem_obj->sgt->sgl;
>>> +       if (sg) {
>>> +               dma_addr = sg_dma_address(sg);
>>> +               dma_addr += ((u64)iommu_dev->sid << 32);
>>> +
>>> +               gem_obj->imported_dma_addr = dma_addr;
>> Well that looks like you are only using the first DMA address from the imported sgt. What about the others?
> I might have a proper appach for this now, will update in the next spin.
>> Regards,
>> Christian.

