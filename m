Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D720C262D0B
	for <iommu@lists.linux.dev>; Mon,  9 Mar 2026 06:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773039581; cv=none; b=j1aXRrwazsYdPD/TclGpI34FCIShA8X60dAjmJTJuESfQHrsxvmOHV5q9MpMw2q9bvxBB8KR0w9AHK9lPsQsv7uWuhPHgUv0MXyjX2HMGPk1O4eYx+QPBzJPQE2OtJaHd0P3NTlXlEcESThBW9MdtLfF1FKTKklxjMJq/s8cfzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773039581; c=relaxed/simple;
	bh=FvVlZ/Lcen9SEsi9VK8j2x4eoHrMDtIyP/b5GXbxpaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QOl4DmdlHFOf3Z1f2CcgZGXhGeZ2P61/yUA7sxu7cTxHThg2o5p6DVl+SbFi1f+WyZ80Kdri/00DnpK1mfZx96nVO28aEPxNrTScXf4HIKbExzfpASbZ0D3W7XipfI6FuOOKuwwUXJMGxhHqPkHaDWkVeTQ0lo+gEcOJblUfr7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i5QfXdgA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gPNwQzdp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i5QfXdgA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gPNwQzdp"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6294eoqf1587275
	for <iommu@lists.linux.dev>; Mon, 9 Mar 2026 06:59:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G+rVK2qEYMP73XgPEKoeHzVEXgyXmbiGfinl4OV1AfY=; b=i5QfXdgAcg/AgJni
	irNAv/e8dbLAEbvQsR2oIvr8dzvfhC4LlOP5b0CUTzKKvbHMVURDzdsbElcrqk37
	leb3d0XeO+wsZvb4WSyXwVHqYmgLUGuVSXsvUTqfbQsQxrYL5qOoI96G9Sd/6BFb
	1d4IM7k4Cfc0ikPSe8fnxEOzpXFI03B8f3fSK43H3iiPAKvy4sACg/wvTt55A7pt
	3u4Q3kGPEbgcz57stZVWCbucXmDT9odK4Bnl2AN2bzeNenaT0oCZyvSZ9ylxkB+z
	FvwsrcIZS9B9tZgDXowO674ls3TgjKtQRQ7IwMCSo/bnwHIlVK8Ay+idNqfBPxnM
	xRMw6g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4csqcy8c5j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 09 Mar 2026 06:59:39 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ae405e95f5so89162705ad.2
        for <iommu@lists.linux.dev>; Sun, 08 Mar 2026 23:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773039578; x=1773644378; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G+rVK2qEYMP73XgPEKoeHzVEXgyXmbiGfinl4OV1AfY=;
        b=gPNwQzdpKu0wq4C//uzQn1/PMZ0qn1jG2elL3vXXRLR0qYQ60EqBg98xadD+DZ8PCm
         4+y1Lc+2NgJcIFlvq1vMXWGKMnmG8wSgb6QtA6H0YSkqiqpbjCP8zezWeNpju7b+c/EC
         WLaXrHZZjqTN9Lv4p6qvDBlAX0O3bYFErLa11NigDOFR4vQQn7SQtJjrGmRYJnWecNhF
         o++dkbL3Mmot+eMl83SRQ0Q0I1PzZ0xzwaDV14zvffpIvKz/id2ANWMNlxTuQLVyFC++
         QbBQtw5nLWCs93M+ecUME+vsJAgoYhF0Ctvai86KCpgT4QlQ2eWWo3l7VstFePnyRQ6G
         CUCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773039578; x=1773644378;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G+rVK2qEYMP73XgPEKoeHzVEXgyXmbiGfinl4OV1AfY=;
        b=r6nmvXAAyKWT/iY0G8oceNC3NW5yDccNCnQQxNuyHdFnFpApCSguGIhbWCn27IajPP
         UW2aPMhqrnY/V07DJk9aKjH2kYOkwcLAV7Y01RJ1rnfaWBruCzUwFclzMi8L48rW4HF0
         pCkjH3SO4je5l2jrCmX92r3tO4MO8Ln5RIbcHVBcvrGx9KD5EYutFKl63nQsCjglqI03
         8dI+/KWMXrwm3haYj+oyFSBTEp6I99f+huCOlsDV6brTyShRXgneI/MxuY6TcjSwquDz
         QQTylfZ7qEvVDhrXdNs12NVrr3baNk3truJNbRdqa6H/SmHi7mjaA1HEgS6X2VgD/R1r
         2GhA==
X-Forwarded-Encrypted: i=1; AJvYcCVr8aFeneUrRiiMKWLOa8bjeL0k9u+PDq6j+lfakCpSw1BiPqS7FA6g0NdwLpLfsMRFekV5wg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwE1Rb/RBklBoui3kK3YyPUl5etR2gmwjeKi5ZM4dPJ3ZMrqQxG
	QykYXoblwe8ft6BD3xZDBSrbwoss1CLjW0tp0IJYyYqTaUbVg6ga4RNSxFlxLZykxESpKVxs0yJ
	2UdA35Ccpzz8ugSSu+dcutoYeAhWQ941rI3U7d6ZJzC/7yE36X9WSHuT9JQ==
X-Gm-Gg: ATEYQzyaq5D7Mf1eOfElXtFr26zdJsAjbFsS8Jt7gf5csbIPKYpCBtBJlrxL2g7v6ub
	u68TxqR6sbv/t1ZX5CEZf/7EBC62rH1o7UONVpn+7kLdlQfU28vuhfoBDbEhbiVD5AK5CO8C+Bk
	7JqXdgjB7Z5BPHh/RlyBZQMiw6veJzte5t9ci1b3BOuDBO9hW3PY1+k6SxqWrcgW3TMMkyKVEpf
	s2gfaC30gTOxwTUJS4ctXlRqL5oVX/ROTWzm4DfuazGWP9fXIbsXiJ4jsvXCiVGJxrgO4/r/XHJ
	L1XFu1S2x3D6mSWAZitMA6F2RQj+nv+kR795IKGn31sHSRp/T2Hzg9OpYB0E6eJYqYNkT4oGyKN
	HKT7hOykgO8oM1IsgEwnpD5I2EVuYAJCQuJ0csn4F7safBMvbaw==
X-Received: by 2002:a17:902:f651:b0:2ae:61bb:4255 with SMTP id d9443c01a7336-2ae82418927mr109317725ad.11.1773039578325;
        Sun, 08 Mar 2026 23:59:38 -0700 (PDT)
X-Received: by 2002:a17:902:f651:b0:2ae:61bb:4255 with SMTP id d9443c01a7336-2ae82418927mr109317495ad.11.1773039577848;
        Sun, 08 Mar 2026 23:59:37 -0700 (PDT)
Received: from [10.206.99.28] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e5c167sm99741945ad.1.2026.03.08.23.59.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Mar 2026 23:59:37 -0700 (PDT)
Message-ID: <29f9bb45-5c3f-4847-a629-21cef540f38b@oss.qualcomm.com>
Date: Mon, 9 Mar 2026 12:29:29 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 12/18] accel/qda: Add PRIME dma-buf import support
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
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <e87c0c1d-82f1-4a03-9a56-9bf3e03273cf@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDA2MyBTYWx0ZWRfX/hrmA0WrQYtM
 gsccFzoJDGf6kJhTUonUAgcK2CcTWkJNXjjEtqzss8Lr2BsC2gJZz+2KNI+93ePg2gwwDoockM/
 wbyZHAMAoJiUjfoydelZjJMwSWDBBhNB1g6z0BIQtd5jTFdG1LTxFw9rZzaEVH8Nq7Lomfr58+z
 fMWGBkAiK1vqyDKulKODl2CP5nlpxnTUe5SfC6/yNYLn7pynQ+eW3O+bWyZcOqUfMnyOhXrRvVh
 1ub4YuBSChuTbi0d2E7XxiLOvr9p7ffe+XXNwVkXwS5xB1+2ssQPL+D2y8W+OnXld5OSG5iUbbV
 G1/+OFxsYf4SxefXYg/GlhaMXP6eWSFb3c/LFVkofQM8pbXcnXNcvTMztZvdmwc5GnlBn/+SdPx
 FkFFnC2U2EXMdSj9bvWH92fmSuk9ahC8ijCZNN7wZGhEw4rX3KAv4HoN0nSY3viC7CGs9ALiJP+
 6bpOmehiTeJrRyy7auA==
X-Authority-Analysis: v=2.4 cv=QJtlhwLL c=1 sm=1 tr=0 ts=69ae6fdb cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=_EeEMxcBAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=YM0dgK5nqTTLF_VjvEgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=czjwGCTIUPoA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: Fua3BlFroIQf_InZBrAdDpZjtLl4Z8Vz
X-Proofpoint-GUID: Fua3BlFroIQf_InZBrAdDpZjtLl4Z8Vz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_02,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603090063



On 2/24/2026 2:42 PM, Christian König wrote:
> On 2/23/26 20:09, Ekansh Gupta wrote:
>> [Sie erhalten nicht häufig E-Mails von ekansh.gupta@oss.qualcomm.com. Weitere Informationen, warum dies wichtig ist, finden Sie unter https://aka.ms/LearnAboutSenderIdentification ]
>>
>> Add PRIME dma-buf import support for QDA GEM buffer objects and integrate
>> it with the existing per-process memory manager and IOMMU device model.
>>
>> The implementation extends qda_gem_obj to represent imported dma-bufs,
>> including dma_buf references, attachment state, scatter-gather tables
>> and an imported DMA address used for DSP-facing book-keeping. The
>> qda_gem_prime_import() path handles reimports of buffers originally
>> exported by QDA as well as imports of external dma-bufs, attaching them
>> to the assigned IOMMU device
> That is usually an absolutely clear NO-GO for DMA-bufs. Where exactly in the code is that?
dma_buf_attach* to comute-cb iommu devices are critical for DSPs to access the buffer.
This is needed if the buffer is exported by anyone other than QDA(say system heap). If this is not
the correct way, what should be the right way here? On the current fastrpc driver also,
the DMABUF is getting attached with iommu device[1] due to the same requirement.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/misc/fastrpc.c#n779
>
>> and mapping them through the memory manager
>> for DSP access. The GEM free path is updated to unmap and detach
>> imported buffers while preserving the existing behaviour for locally
>> allocated memory.
>>
>> The PRIME fd-to-handle path is implemented in qda_prime_fd_to_handle(),
>> which records the calling drm_file in a driver-private import context
>> before invoking the core DRM helpers. The GEM import callback retrieves
>> this context to ensure that an IOMMU device is assigned to the process
>> and that imported buffers follow the same per-process IOMMU selection
>> rules as natively allocated GEM objects.
>>
>> This patch prepares the driver for interoperable buffer sharing between
>> QDA and other dma-buf capable subsystems while keeping IOMMU mapping and
>> lifetime handling consistent with the existing GEM allocation flow.
>>
>> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> ...
>
>> @@ -15,23 +16,29 @@ static int validate_gem_obj_for_mmap(struct qda_gem_obj *qda_gem_obj)
>>                 qda_err(NULL, "Invalid GEM object size\n");
>>                 return -EINVAL;
>>         }
>> -       if (!qda_gem_obj->iommu_dev || !qda_gem_obj->iommu_dev->dev) {
>> -               qda_err(NULL, "Allocated buffer missing IOMMU device\n");
>> -               return -EINVAL;
>> -       }
>> -       if (!qda_gem_obj->iommu_dev->dev) {
>> -               qda_err(NULL, "Allocated buffer missing IOMMU device\n");
>> -               return -EINVAL;
>> -       }
>> -       if (!qda_gem_obj->virt) {
>> -               qda_err(NULL, "Allocated buffer missing virtual address\n");
>> -               return -EINVAL;
>> -       }
>> -       if (qda_gem_obj->dma_addr == 0) {
>> -               qda_err(NULL, "Allocated buffer missing DMA address\n");
>> -               return -EINVAL;
>> +       if (qda_gem_obj->is_imported) {
> Absolutely clear NAK to that. Imported buffers *can't* be mmaped through the importer!
>
> Userspace needs to mmap() them through the exporter.
>
> If you absolutely have to map them through the importer for uAPI backward compatibility then there is dma_buf_mmap() for that, but this is clearly not the case here.
>
> ...
Okay, the requirement is slightly different here. Any buffer which is not allocated using the
QDA GEM interface needs to be attached to the iommu device for that particular process to
enable DSP for the access. I should not call it `mmap` instead it should be called importing the
buffer to a particular iommu context bank. With this definition, is it fine to keep it this way? Or
should the dma_buf_attach* calls be moved to some other place?
>> +static int qda_memory_manager_map_imported(struct qda_memory_manager *mem_mgr,
>> +                                          struct qda_gem_obj *gem_obj,
>> +                                          struct qda_iommu_device *iommu_dev)
>> +{
>> +       struct scatterlist *sg;
>> +       dma_addr_t dma_addr;
>> +       int ret = 0;
>> +
>> +       if (!gem_obj->is_imported || !gem_obj->sgt || !iommu_dev) {
>> +               qda_err(NULL, "Invalid parameters for imported buffer mapping\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       gem_obj->iommu_dev = iommu_dev;
>> +
>> +       sg = gem_obj->sgt->sgl;
>> +       if (sg) {
>> +               dma_addr = sg_dma_address(sg);
>> +               dma_addr += ((u64)iommu_dev->sid << 32);
>> +
>> +               gem_obj->imported_dma_addr = dma_addr;
> Well that looks like you are only using the first DMA address from the imported sgt. What about the others?
I might have a proper appach for this now, will update in the next spin.
>
> Regards,
> Christian.

