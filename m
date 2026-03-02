Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE8C38BF6D
	for <iommu@lists.linux.dev>; Mon,  2 Mar 2026 09:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772442434; cv=none; b=omtYFj30iBl37Gijr9fjAYkkX3SfecrGFLGTX12YjthWYgcq9bTBYcP0wUOUIl6D7Z/yEwADYmxpmxqtUpowABNjtyHoKtKFqbF6jMPtrJT0G0cHODZwh6hAxcUwaPsNqc+DSwbohYtCb4xNA8lW2cC2gv/O26t9pRH499VAWh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772442434; c=relaxed/simple;
	bh=3DYGcwhIywuMuVcxgzn8mDrQQkH6d0xAwzusa7ndpj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mjt3PxADjyILAZwF2P1UGV1Heotebvpyleth7WBBBbyB9DQG7HzeASqfyxIlQmakb834b1KeutzwURh9tMS+ONfvl0WgsKKrAHKAUCQ71O2FaTn2XQsOt7kzE4aFyyi9KNtvkoCWDGhqDSCa7ZRgwyHA9VadyqP75RfUUOc7l90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KxEzbdGC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XFBti45e; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KxEzbdGC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XFBti45e"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62294ak53753087
	for <iommu@lists.linux.dev>; Mon, 2 Mar 2026 09:07:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kXwg+e8w3nJ4trgH31uq0Czj0o2II8vsG1Y2JNLZRpM=; b=KxEzbdGCs4hAdRn4
	vsYCcuDDN+XEaSmt5f3FIsF1ze23z72sfGKzX+E92H/HfsKiVVmq/fDrNZZ03m0s
	x8JmTmx60LFfn7HIQ5BxWKFfp3cYkt1aE/B5hfHfFF3eIPQVtMV/uN9Sejb55VV8
	2JYNilAlhSQHpf8WrYvjxrhsYehGM3CQdd/QbHNDMe482Btm2Uz+Uxm2EbenrDgi
	ngK93U9CD2xEggZoMGI9bD4i9FSYZHe2Uqbxok9z4zKS0vKCBqXBFZXnMnoS2z1j
	A8fQNOLa5d92YUwXaADpaAOnk5QDWtx96q2gHnq52vUcKlAnLz8kwAL9phBi4JJz
	05OKyQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cn7kq80jj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 02 Mar 2026 09:07:12 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-35842aa350fso22199768a91.0
        for <iommu@lists.linux.dev>; Mon, 02 Mar 2026 01:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772442431; x=1773047231; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kXwg+e8w3nJ4trgH31uq0Czj0o2II8vsG1Y2JNLZRpM=;
        b=XFBti45enj1Is1s/Q9C5QwoADRkuT+dhSZVOKE4L+jdJBE7t7XdLLZdUcnJFXaAzsS
         IqZnP5JncGuynwYl56dF3OaN/LSI4eNJFkWBXPzx7KWtSzaBFWoLNLDkPUkD2SxMc9kP
         oMg3PJZFiMwStq/Ffpdu0Uxqp/EQE1J0HTl4e0I4jhnHXIdmeS6FNkmVG/0Ngl4+wys9
         0y8oA5oxWe48+HPBUtOR3h1gxitsrZdOSX4eHujBIRPVc5rFUWZS1pdheJiJkzrNYe0A
         6E4nBBSXGLiOeZqhKhL2w+xpt2NrdMntNEB4mQyCyxgglEVCp8ri1Bdf6cp6MBRlxJxq
         PhnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772442431; x=1773047231;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kXwg+e8w3nJ4trgH31uq0Czj0o2II8vsG1Y2JNLZRpM=;
        b=wS/0Ux2EITvTNE3r1kV3fn/H0RzCvVs4163pe/cWVbG+ZGsqcvOdgaAlZVJlmJPJK8
         da5KkOg9Cd3rV7qzDQcNjNTndLQigdzvjfaQiomGsTCegULnJTb9YZGyhqnk8iUYkz4E
         EN5Du8TlGmVfZLRiKeIUm7lucEVUwjfUfcYoX9/oVcuUSpxIDXyrSHj4Hgbh1INXHmH1
         ZuL0IdGqdDTIBecVnuB4F2IBA9M3AReQVTxzv2CFLsBXKBTYWnWTmv7j1OE0ja9yfqjm
         A8A5T+1oFCydBmzCgI69vP3JMiFyMQnQsZ7a0o/583RvEP7+J7FgPTcqeUB6NZPriLWd
         E8WQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbMvKe/HRFZJqBrpsS9vFq0zEWRNSC4IJSJOAtTanxSiV8PRSiIPVHPQ5+R5hvwyThANYNuw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxIscYfF7EGMsrUwuVr/8FtSxPRzgvSLLmaSDpwIWpGtlWFgINN
	cNsJ8olvNxZ52T8pTVqWyw+ZJFRhDldX4z8Fk4OfowOP2ZuEKW2uXtytmjPtfxUppbwS1aNEPWh
	Ie2ypG/5kmh48o1tn8rYfpqRKaVQdpwzSxa78FOBZ6xJYp3WTiJLGF/Lnng==
X-Gm-Gg: ATEYQzy1NKZQ4eIP166WbvG38/duHgqqgUtf4VCrczgQ5w9KtznrMJlkopDigLpvJLA
	hk8uTk8ajYt4Nj60QVrTASL+ZK10lQ/zsC5gpU6jbwcXV2jNu908J7idrAW0mo3AxS1LmgW9uGv
	/l/x3QDXZZCxhW3i+WwXT48w4KlvHtfNhHTqJp/BgHjhsQjzhAwnQwRh8ZQKXzBVBQt7S3WMjM8
	GL+EG5DlQ3i2AzVSAwFklSvGrWurcJZfaZ+lXygwFlC2QOFj0Nvy0RHJCNfemoo0tq/bA5Tqwpt
	LJWvR0U3r1cW0s5/jcccYP8PZ61aAQ0grwd254ENSccWdRx+AURh2k3MSPIDdvu73lI4hqV1day
	Ig0KvI+zPnrHgiGQf43ht76R4h5FS20nMX1gUGucVXn9FmfNJnQ==
X-Received: by 2002:a17:90b:2507:b0:359:8230:abcc with SMTP id 98e67ed59e1d1-3598230ace5mr3362787a91.8.1772442431310;
        Mon, 02 Mar 2026 01:07:11 -0800 (PST)
X-Received: by 2002:a17:90b:2507:b0:359:8230:abcc with SMTP id 98e67ed59e1d1-3598230ace5mr3362753a91.8.1772442430727;
        Mon, 02 Mar 2026 01:07:10 -0800 (PST)
Received: from [10.206.99.28] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3593ddd737fsm17419480a91.13.2026.03.02.01.07.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 01:07:10 -0800 (PST)
Message-ID: <741c681d-b496-4dff-be2b-06dbe13acb21@oss.qualcomm.com>
Date: Mon, 2 Mar 2026 14:37:02 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 11/18] accel/qda: Add GEM_CREATE and GEM_MMAP_OFFSET
 IOCTLs
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Bharath Kumar <quic_bkumar@quicinc.com>,
        Chenna Kesava Raju <quic_chennak@quicinc.com>
References: <20260224-qda-firstpost-v1-0-fe46a9c1a046@oss.qualcomm.com>
 <20260224-qda-firstpost-v1-11-fe46a9c1a046@oss.qualcomm.com>
 <mkrwav44qxt66ojxvs2mh5jsjqirrm4sk653uglha3cjefevk6@fobon6vj7fhr>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <mkrwav44qxt66ojxvs2mh5jsjqirrm4sk653uglha3cjefevk6@fobon6vj7fhr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: x-m4NU3zXI3iAoADbXBmEh-UC5jrlMtL
X-Proofpoint-GUID: x-m4NU3zXI3iAoADbXBmEh-UC5jrlMtL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDA3OCBTYWx0ZWRfX3+b9l9fOzHDq
 hS3MARe7C/lvjrhWTWEI6N0kopmfsa9uLf05Nu0C/SC3qPU2Ut1V9hubu7HxK2vDNN+9X5FZ/cg
 JwZNSzGMIv1Wh7DDcRcbxWPa6WogFG/yNx0YHwzw9mWUuwel0Ai8z9YBP/Z2neeO3u5nAz4HeKT
 76rSH0Esnc31Sw4WSEd4t8GlOjBuBLFLA1mymVkPz7KGQrC2El0n5Oic/KjwASqF+mAnOeY68Sn
 P5kme8MXmNtZ67evrR8/kq74N8OytWGTg1HhNINW9zBu/n3pAPRARZKJYFxEsYSBwtOEMiJzIpi
 teTmDZaIFDM2ybIToT/vNtTcK5ESuzlt89h/xhWhVczxJ7lGu+VGVyK/Mjh8SFvvRnskjFoue4S
 Lesa48Wwtht+cN4lHhdjY/Kex45uJmvyO/KA08jGahO2kJC5z7MD9Avw9VXH4y3r1nMOnFLwde6
 fLzNSv6pXPwuPRj1dMw==
X-Authority-Analysis: v=2.4 cv=GLkF0+NK c=1 sm=1 tr=0 ts=69a55340 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=AnjHHbesreVsCw1LpdIA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_02,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 spamscore=0 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020078



On 2/24/2026 4:09 AM, Dmitry Baryshkov wrote:
> On Tue, Feb 24, 2026 at 12:39:05AM +0530, Ekansh Gupta wrote:
>> Add two GEM-related IOCTLs for the QDA accelerator driver and hook
>> them into the DRM accel driver. DRM_IOCTL_QDA_GEM_CREATE allocates
>> a DMA-backed GEM buffer object via qda_gem_create_object() and
>> returns a GEM handle to userspace, while
>> DRM_IOCTL_QDA_GEM_MMAP_OFFSET returns a valid mmap offset for a
>> given GEM handle using drm_gem_create_mmap_offset() and the
>> vma_node in the GEM object.
>>
>> The QDA driver is updated to advertise DRIVER_GEM in its
>> driver_features, and the new IOCTLs are wired through the QDA
>> GEM and memory-manager backend. These IOCTLs allow userspace to
>> allocate buffers and map them into its address space as a first
>> step toward full compute buffer management and integration with
>> DSP workloads.
>>
>> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>> ---
>>  drivers/accel/qda/qda_drv.c   |  5 ++++-
>>  drivers/accel/qda/qda_gem.h   | 30 ++++++++++++++++++++++++++++++
>>  drivers/accel/qda/qda_ioctl.c | 35 +++++++++++++++++++++++++++++++++++
>>  include/uapi/drm/qda_accel.h  | 36 ++++++++++++++++++++++++++++++++++++
>>  4 files changed, 105 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/accel/qda/qda_drv.c b/drivers/accel/qda/qda_drv.c
>> index 19798359b14e..0dd0e2bb2c0f 100644
>> --- a/drivers/accel/qda/qda_drv.c
>> +++ b/drivers/accel/qda/qda_drv.c
>> @@ -12,6 +12,7 @@
>>  #include <drm/qda_accel.h>
>>  
>>  #include "qda_drv.h"
>> +#include "qda_gem.h"
>>  #include "qda_ioctl.h"
>>  #include "qda_rpmsg.h"
>>  
>> @@ -154,10 +155,12 @@ DEFINE_DRM_ACCEL_FOPS(qda_accel_fops);
>>  
>>  static const struct drm_ioctl_desc qda_ioctls[] = {
>>  	DRM_IOCTL_DEF_DRV(QDA_QUERY, qda_ioctl_query, 0),
>> +	DRM_IOCTL_DEF_DRV(QDA_GEM_CREATE, qda_ioctl_gem_create, 0),
>> +	DRM_IOCTL_DEF_DRV(QDA_GEM_MMAP_OFFSET, qda_ioctl_gem_mmap_offset, 0),
>>  };
>>  
>>  static struct drm_driver qda_drm_driver = {
>> -	.driver_features = DRIVER_COMPUTE_ACCEL,
>> +	.driver_features = DRIVER_GEM | DRIVER_COMPUTE_ACCEL,
>>  	.fops			= &qda_accel_fops,
>>  	.open			= qda_open,
>>  	.postclose		= qda_postclose,
>> diff --git a/drivers/accel/qda/qda_gem.h b/drivers/accel/qda/qda_gem.h
>> index caae9cda5363..cbd5d0a58fa4 100644
>> --- a/drivers/accel/qda/qda_gem.h
>> +++ b/drivers/accel/qda/qda_gem.h
>> @@ -47,6 +47,36 @@ struct drm_gem_object *qda_gem_create_object(struct drm_device *drm_dev,
>>  void qda_gem_free_object(struct drm_gem_object *gem_obj);
>>  int qda_gem_mmap_obj(struct drm_gem_object *gem_obj, struct vm_area_struct *vma);
>>  
>> +/*
>> + * GEM IOCTL handlers
>> + */
>> +
>> +/**
>> + * qda_ioctl_gem_create - Create a GEM buffer object
>> + * @dev: DRM device structure
>> + * @data: User-space data containing buffer creation parameters
>> + * @file_priv: DRM file private data
>> + *
>> + * This IOCTL handler creates a new GEM buffer object with the specified
>> + * size and returns a handle to the created buffer.
>> + *
>> + * Return: 0 on success, negative error code on failure
>> + */
>> +int qda_ioctl_gem_create(struct drm_device *dev, void *data, struct drm_file *file_priv);
>> +
>> +/**
>> + * qda_ioctl_gem_mmap_offset - Get mmap offset for a GEM buffer object
>> + * @dev: DRM device structure
>> + * @data: User-space data containing buffer handle and offset result
>> + * @file_priv: DRM file private data
>> + *
>> + * This IOCTL handler retrieves the mmap offset for a GEM buffer object,
>> + * which can be used to map the buffer into user-space memory.
>> + *
>> + * Return: 0 on success, negative error code on failure
>> + */
>> +int qda_ioctl_gem_mmap_offset(struct drm_device *dev, void *data, struct drm_file *file_priv);
>> +
>>  /*
>>   * Helper functions for GEM object allocation and cleanup
>>   * These are used internally and by the PRIME import code
>> diff --git a/drivers/accel/qda/qda_ioctl.c b/drivers/accel/qda/qda_ioctl.c
>> index 9fa73ec2dfce..ef3c9c691cb7 100644
>> --- a/drivers/accel/qda/qda_ioctl.c
>> +++ b/drivers/accel/qda/qda_ioctl.c
>> @@ -43,3 +43,38 @@ int qda_ioctl_query(struct drm_device *dev, void *data, struct drm_file *file_pr
>>  
>>  	return 0;
>>  }
>> +
>> +int qda_ioctl_gem_create(struct drm_device *dev, void *data, struct drm_file *file_priv)
>> +{
>> +	struct drm_qda_gem_create *args = data;
>> +	struct drm_gem_object *gem_obj;
>> +	struct qda_drm_priv *drm_priv;
>> +
>> +	drm_priv = get_drm_priv_from_device(dev);
>> +	if (!drm_priv || !drm_priv->iommu_mgr)
>> +		return -EINVAL;
>> +
>> +	gem_obj = qda_gem_create_object(dev, drm_priv->iommu_mgr, args->size, file_priv);
>> +	if (IS_ERR(gem_obj))
>> +		return PTR_ERR(gem_obj);
>> +
>> +	return qda_gem_create_handle(file_priv, gem_obj, &args->handle);
>> +}
>> +
>> +int qda_ioctl_gem_mmap_offset(struct drm_device *dev, void *data, struct drm_file *file_priv)
>> +{
>> +	struct drm_qda_gem_mmap_offset *args = data;
>> +	struct drm_gem_object *gem_obj;
>> +	int ret;
>> +
>> +	gem_obj = qda_gem_lookup_object(file_priv, args->handle);
>> +	if (IS_ERR(gem_obj))
>> +		return PTR_ERR(gem_obj);
>> +
>> +	ret = drm_gem_create_mmap_offset(gem_obj);
>> +	if (ret == 0)
>> +		args->offset = drm_vma_node_offset_addr(&gem_obj->vma_node);
>> +
>> +	drm_gem_object_put(gem_obj);
>> +	return ret;
>> +}
>> diff --git a/include/uapi/drm/qda_accel.h b/include/uapi/drm/qda_accel.h
>> index 0aad791c4832..ed24a7f5637e 100644
>> --- a/include/uapi/drm/qda_accel.h
>> +++ b/include/uapi/drm/qda_accel.h
>> @@ -19,6 +19,8 @@ extern "C" {
>>   * They are used with DRM_COMMAND_BASE to create the full IOCTL numbers.
>>   */
>>  #define DRM_QDA_QUERY	0x00
>> +#define DRM_QDA_GEM_CREATE		0x01
>> +#define DRM_QDA_GEM_MMAP_OFFSET	0x02
>>  /*
>>   * QDA IOCTL definitions
>>   *
>> @@ -27,6 +29,10 @@ extern "C" {
>>   * data structure and direction (read/write) for each IOCTL.
>>   */
>>  #define DRM_IOCTL_QDA_QUERY	DRM_IOR(DRM_COMMAND_BASE + DRM_QDA_QUERY, struct drm_qda_query)
>> +#define DRM_IOCTL_QDA_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_QDA_GEM_CREATE, \
>> +						 struct drm_qda_gem_create)
>> +#define DRM_IOCTL_QDA_GEM_MMAP_OFFSET	DRM_IOWR(DRM_COMMAND_BASE + DRM_QDA_GEM_MMAP_OFFSET, \
>> +						 struct drm_qda_gem_mmap_offset)
>>  
>>  /**
>>   * struct drm_qda_query - Device information query structure
>> @@ -40,6 +46,36 @@ struct drm_qda_query {
>>  	__u8 dsp_name[16];
>>  };
>>  
>> +/**
>> + * struct drm_qda_gem_create - GEM buffer object creation parameters
>> + * @size: Size of the GEM object to create in bytes (input)
>> + * @handle: Allocated GEM handle (output)
>> + *
>> + * This structure is used with DRM_IOCTL_QDA_GEM_CREATE to allocate
>> + * a new GEM buffer object.
>> + */
>> +struct drm_qda_gem_create {
>> +	__u32 handle;
>> +	__u32 pad;
>> +	__u64 size;
> If you put size before handle, you would not need padding.
ack
>
>> +};
>> +
>> +/**
>> + * struct drm_qda_gem_mmap_offset - GEM object mmap offset query
>> + * @handle: GEM handle (input)
>> + * @pad: Padding for 64-bit alignment
>> + * @offset: mmap offset for the GEM object (output)
>> + *
>> + * This structure is used with DRM_IOCTL_QDA_GEM_MMAP_OFFSET to retrieve
>> + * the mmap offset that can be used with mmap() to map the GEM object into
>> + * user space.
>> + */
>> +struct drm_qda_gem_mmap_offset {
>> +	__u32 handle;
>> +	__u32 pad;
>> +	__u64 offset;
> I'm really not a fan of the pad field in the middle of the structure.
ack
>
>> +};
>> +
>>  #if defined(__cplusplus)
>>  }
>>  #endif
>>
>> -- 
>> 2.34.1
>>

