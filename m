Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F603B5E19
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 05:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780465915; cv=none; b=cn8/reunjiSkfAeMtIQbAZ4bO+tRUhwB8ilJ29uZkfHIK4an8/7ygoUehv1PaQlztvgJoh8LOsKsUPVLv8tPczPpLK5t636R1qmzBzQIx4ZmB+Rms7xkJyDScWGLdNxjDnPkAl/5xeRc4YgbYhIrV2a1YIp0DudwMAUuNCCK8kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780465915; c=relaxed/simple;
	bh=JU12tekL6GBhR04YvsNYNHGTnRlGN/sSSSIxQh1PeUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tH30OXXzWEmTZYvE/4d3dM7I7ThBrIFD8o7Wovs8GyY1JReczmDXtYGcNMT5g3y9TmAroUyWDZA07SrGvHqSB14g5AlNe6q+gPlQKh6O88oI3ix/anSlVyFgusmrXePElSeVSmJwNaQk+z5uHuTJGhoI0DmlaA3QTkymuMFGgkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gLRejsnA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dpAQmWFo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gLRejsnA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dpAQmWFo"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6535WnXc260527
	for <iommu@lists.linux.dev>; Wed, 3 Jun 2026 05:51:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AoBXmuqEDW/B4n4M1GtYaMi2nefd/8NaLnywKReRnKk=; b=gLRejsnAQCm/y5ik
	ugn0LJwtvecXJpobc9QOcYHsKyVw+1ctVQ18LgKhz/YIJ8x77vwGfOGruVZ5gEz6
	PSY3LGCD/rL1Hrpr5QKxUa0viKgbwk6mSIWn+e/jqfFl4jt9bA+jSSS2Jc0BuH3A
	64KAweYROTEsZ2x7VVaixA1e4+OChDAb/vVr5su+lQxNgVXcW4dSZo51c/lhoi7H
	8GMSAC4i+tsgxdkS+RcNO7Xik29ObYSD5xYQSRNZSLK2jYAOKtjKyUZwvdRy81cY
	Ia63ghCRnpR7QDZpBU/i97wmIe/mD4/sAwW/obIKA1m9GJoUica6Q3apSplGsIEJ
	iTxykw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ehs9vwfg7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 05:51:53 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c0c36f4b76so33914635ad.3
        for <iommu@lists.linux.dev>; Tue, 02 Jun 2026 22:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780465913; x=1781070713; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AoBXmuqEDW/B4n4M1GtYaMi2nefd/8NaLnywKReRnKk=;
        b=dpAQmWFone/MTXvIdaXKphZeJdg+vbzmEDf8eL/WvdE/sf7C0fIRffkBTKqCeOnv+e
         K4vWv7seedQsQ+oWknO5TUb/VWx1CZ8r7/ZdBw1nCabMeALKMO82i9mxE9nQBiPVOh8x
         2QwBx05mjWphysrylPxhklLEEtLmnifCCyV+9Y9zyUTN4j+qyu0KhVO9ZNKzxdrbm26v
         I0ZESCZaslVs2bQE/9Cf+l6ZtnZiYaQaFoRhVI17l/59PSr0eHubksUBmTvi3rIH45xh
         HlGRWiPfrBw7cAVLBQrt95+oNgLlLhY0LC7DxtYVObGlUlIhXeP43unAsCQhps0d+TbN
         pXDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780465913; x=1781070713;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AoBXmuqEDW/B4n4M1GtYaMi2nefd/8NaLnywKReRnKk=;
        b=qZS9q7sB5U+mz5KXIZuMOdfNK/x5vzbLpnBrJgKE/ViXJlw4yUz1tRovNJ/lgigcXW
         4xgrCX2HjfYG5qeVxM56K5vDyNjFPpu1szZm82dfwV/BEYxPVWNR37pu8/7C+aZDiMXq
         v69cD8CkZzRuy0K/xSYhDNZW8i0BAGa1oMZ7S7buEiL1HrjK35S0Nz+AjzxMp61E50ff
         gICbK3Mb5MeGr4edQWmByh93uLfRh7iWU70z9y83l5SgPfxMBR0TJozEcdMTFCQUgpk+
         U0Y0HrlhfXNpqgLGMJampJa76hZ6fUV0iurRPlhdLsnx6dNmVMvBxJCIIpdUkaCn77dv
         KpSg==
X-Forwarded-Encrypted: i=1; AFNElJ9pE4MMgGfpeE2xmIkVmx2HQPi6qQNSKBqsmW6tJ6BFVelaBgJ/Q4vGIHfriCIUhvuFTqYtoA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzunqWukeMudrP5OnMiBYbdlZEvP5dq4imi+zNGd7coDaPK+M1R
	pHoez+PfwEFmx2L0Z7NgGzt12zz4jGxxXeCCCqOVoTxZMyiw8DIe+Qaj44RVyNmegS5vhdss8DW
	OheAVg9xAbb3newQU37lNmUSu3v4QcDNzX1SJfJaneKHFtlBttfdEv/FrLQ==
X-Gm-Gg: Acq92OHTsYIoo1Ny/YjhKa2gpfLDF0FH9t5BJEDS3Sru+3VnU8gsmao1LPXqA4NDKnp
	rATaHTPYXoGYWultEE0FyeAQCOclY64G1IComtkNEIgxZBjTb0MWw8vtgkwRrEmH5gwirFSW5uh
	xmminPSlFfUOr/5Fl/wo7zPxnLafA5kvk5xvE8gSdwZkDhQLqWXQ2eCM0KpsGqfdWvF3scZljb9
	Xui6AZgdl7j4FbL9BBWTtmOv7TSVuamq7pjK9QvvKO5EXQCzR2fKd3BKeaQ8VL4Qgiq24j106q0
	w2401sVQagXW2HBDGvvvVvEDCTE4j5tES2RyDkT3sN/Sczxw4UFx3+jXhXAp9PryW/AKut2mXgG
	9zr+yi2cKV1p2dnYL3pRgm5R6LZMfCwM+za4W5Sp7IUwPe1K47BUw3VPsv4CK
X-Received: by 2002:a17:903:2312:b0:2be:fefc:d5b9 with SMTP id d9443c01a7336-2c163a1352amr20027155ad.5.1780465912924;
        Tue, 02 Jun 2026 22:51:52 -0700 (PDT)
X-Received: by 2002:a17:903:2312:b0:2be:fefc:d5b9 with SMTP id d9443c01a7336-2c163a1352amr20026725ad.5.1780465912431;
        Tue, 02 Jun 2026 22:51:52 -0700 (PDT)
Received: from [10.204.78.54] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16649d2d4sm11280795ad.77.2026.06.02.22.51.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 22:51:51 -0700 (PDT)
Message-ID: <b5c9d149-1a48-4c0d-aa0d-9ad331896f47@oss.qualcomm.com>
Date: Wed, 3 Jun 2026 11:21:43 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/15] accel/qda: Add QUERY IOCTL and QDA UAPI header
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
        Bharath Kumar <quic_bkumar@quicinc.com>,
        Chenna Kesava Raju <quic_chennak@quicinc.com>, srini@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org,
        robin.clark@oss.qualcomm.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
References: <20260519-qda-series-v1-0-b2d984c297f8@oss.qualcomm.com>
 <20260519-qda-series-v1-8-b2d984c297f8@oss.qualcomm.com>
 <m4zo2nkxtl5yeyo7riuata6r5saflmdgqf37cz2g2ezrwhk53m@mnad6bb7n3ik>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <m4zo2nkxtl5yeyo7riuata6r5saflmdgqf37cz2g2ezrwhk53m@mnad6bb7n3ik>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: YDaisGjc9KiCkU1X3KXLMvFkH139P6Bk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA1MyBTYWx0ZWRfX3vppdx/LvN0s
 JJrYvPNsTytz0jKBp0EpPMWMpzFfDCQv2dlVdLj8p6SD9E2CjsP6fQx9SgUiiiWRY4DWryLvGvZ
 yS9idK/WmAc6UoM+IAUVZyzbZD6z3PWcbVp5azODm6ctXKUYG33QAloefDAgG+zZBG/GNCsYjPC
 /tOGvySwAMFYvQjjO9scPDnfE0bTkhbCUNoNq3OzCR5adczFBQOPzI4a4wxSBMcgsYX7uN6pYD5
 19J0ad6E+lAS3z0WLE9z1B4YL08LoFrTz7hM2zsbiOP0ExwoHG8tDTxstYGY+NU3fmWWe9vYpuf
 5gD4iQbP0Qxdfx8PjPt1D3hM0KED73xwj7tFnF6mIlx7SGMWqw19iLNhl1t+Ieal/j4n+FraKYT
 9b0/nydHRi0ecCJhL3rT7oqHOMDGaYeeS8De6dnJs2Brdkrffh4SLrTwX3ktrgNp5NgJmBEBfQD
 zDlFDm/GS3Xv68VYIPg==
X-Authority-Analysis: v=2.4 cv=NYfWEWD4 c=1 sm=1 tr=0 ts=6a1fc0f9 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=-e_ofER35s36BqmFglcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: YDaisGjc9KiCkU1X3KXLMvFkH139P6Bk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030053

On 20-05-2026 19:59, Dmitry Baryshkov wrote:
> On Tue, May 19, 2026 at 11:45:58AM +0530, Ekansh Gupta via B4 Relay wrote:
>> From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>>
>> Introduce the DRM_IOCTL_QDA_QUERY IOCTL, which allows user-space to
>> identify which DSP domain a given /dev/accel/accel* node represents
>> (e.g. "cdsp", "adsp").
>>
>> include/uapi/drm/qda_accel.h
>>   Defines the QDA IOCTL command numbers and the associated data
>>   structures. The header follows the standard DRM UAPI conventions:
>>   __u8/__u32 types, a C++ extern "C" guard, and GPL-2.0-only WITH
>>   Linux-syscall-note licensing.
>>
>> drivers/accel/qda/qda_ioctl.c / qda_ioctl.h
>>   Implements qda_ioctl_query(), which copies the DSP domain name
>>   stored in qda_dev.dsp_name into the user-supplied drm_qda_query
>>   buffer using strscpy().
>>
>> drivers/accel/qda/qda_drv.c
>>   Registers the qda_ioctls[] table with the drm_driver so that the
>>   DRM core dispatches DRM_IOCTL_QDA_QUERY to qda_ioctl_query().
>>
>> Assisted-by: Claude:claude-4-6-sonnet
>> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>> ---
>>  drivers/accel/qda/Makefile    |  1 +
>>  drivers/accel/qda/qda_drv.c   |  8 +++++++
>>  drivers/accel/qda/qda_ioctl.c | 26 +++++++++++++++++++++++
>>  drivers/accel/qda/qda_ioctl.h | 13 ++++++++++++
>>  include/uapi/drm/qda_accel.h  | 49 +++++++++++++++++++++++++++++++++++++++++++
>>  5 files changed, 97 insertions(+)
>>
>> diff --git a/drivers/accel/qda/Makefile b/drivers/accel/qda/Makefile
>> index 701fad5ffb50..b658dad35fee 100644
>> --- a/drivers/accel/qda/Makefile
>> +++ b/drivers/accel/qda/Makefile
>> @@ -8,6 +8,7 @@ obj-$(CONFIG_DRM_ACCEL_QDA)	:= qda.o
>>  qda-y := \
>>  	qda_cb.o \
>>  	qda_drv.o \
>> +	qda_ioctl.o \
>>  	qda_memory_manager.o \
>>  	qda_rpmsg.o
>>  
>> diff --git a/drivers/accel/qda/qda_drv.c b/drivers/accel/qda/qda_drv.c
>> index 0ad5d9873d7e..becd831d10be 100644
>> --- a/drivers/accel/qda/qda_drv.c
>> +++ b/drivers/accel/qda/qda_drv.c
>> @@ -8,8 +8,10 @@
>>  #include <drm/drm_gem.h>
>>  #include <drm/drm_ioctl.h>
>>  #include <drm/drm_print.h>
>> +#include <drm/qda_accel.h>
>>  
>>  #include "qda_drv.h"
>> +#include "qda_ioctl.h"
>>  #include "qda_rpmsg.h"
>>  
>>  static int qda_open(struct drm_device *dev, struct drm_file *file)
>> @@ -36,11 +38,17 @@ static void qda_postclose(struct drm_device *dev, struct drm_file *file)
>>  
>>  DEFINE_DRM_ACCEL_FOPS(qda_accel_fops);
>>  
>> +static const struct drm_ioctl_desc qda_ioctls[] = {
>> +	DRM_IOCTL_DEF_DRV(QDA_QUERY, qda_ioctl_query, 0),
>> +};
>> +
>>  static const struct drm_driver qda_drm_driver = {
>>  	.driver_features = DRIVER_COMPUTE_ACCEL,
>>  	.fops = &qda_accel_fops,
>>  	.open = qda_open,
>>  	.postclose = qda_postclose,
>> +	.ioctls = qda_ioctls,
>> +	.num_ioctls = ARRAY_SIZE(qda_ioctls),
>>  	.name = QDA_DRIVER_NAME,
>>  	.desc = "Qualcomm DSP Accelerator Driver",
>>  };
>> diff --git a/drivers/accel/qda/qda_ioctl.c b/drivers/accel/qda/qda_ioctl.c
>> new file mode 100644
>> index 000000000000..761d3567c33f
>> --- /dev/null
>> +++ b/drivers/accel/qda/qda_ioctl.c
>> @@ -0,0 +1,26 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +// Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> +#include <drm/drm_ioctl.h>
>> +#include <drm/qda_accel.h>
>> +#include "qda_drv.h"
>> +#include "qda_ioctl.h"
>> +
>> +/**
>> + * qda_ioctl_query() - Query DSP device information
>> + * @dev: DRM device structure
>> + * @data: User-space data (struct drm_qda_query)
>> + * @file_priv: DRM file private data
>> + *
>> + * Return: 0 on success, negative error code on failure
>> + */
>> +int qda_ioctl_query(struct drm_device *dev, void *data, struct drm_file *file_priv)
>> +{
>> +	struct drm_qda_query *args = data;
>> +	struct qda_dev *qdev;
>> +
>> +	qdev = qda_dev_from_drm(dev);
>> +
>> +	strscpy(args->dsp_name, qdev->dsp_name, sizeof(args->dsp_name));
>> +
>> +	return 0;
>> +}
>> diff --git a/drivers/accel/qda/qda_ioctl.h b/drivers/accel/qda/qda_ioctl.h
>> new file mode 100644
>> index 000000000000..b8fd536a111f
>> --- /dev/null
>> +++ b/drivers/accel/qda/qda_ioctl.h
>> @@ -0,0 +1,13 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + */
>> +
>> +#ifndef __QDA_IOCTL_H__
>> +#define __QDA_IOCTL_H__
>> +
>> +#include "qda_drv.h"
>> +
>> +int qda_ioctl_query(struct drm_device *dev, void *data, struct drm_file *file_priv);
>> +
>> +#endif /* __QDA_IOCTL_H__ */
>> diff --git a/include/uapi/drm/qda_accel.h b/include/uapi/drm/qda_accel.h
>> new file mode 100644
>> index 000000000000..1971a4263065
>> --- /dev/null
>> +++ b/include/uapi/drm/qda_accel.h
>> @@ -0,0 +1,49 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
>> +/*
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + */
>> +
>> +#ifndef __QDA_ACCEL_H__
>> +#define __QDA_ACCEL_H__
>> +
>> +#include "drm.h"
>> +
>> +#if defined(__cplusplus)
>> +extern "C" {
>> +#endif
>> +
>> +/*
>> + * QDA IOCTL command numbers
>> + *
>> + * These define the command numbers for QDA-specific IOCTLs.
>> + * They are used with DRM_COMMAND_BASE to create the full IOCTL numbers.
>> + */
>> +#define DRM_QDA_QUERY		0x00
>> +
>> +/*
>> + * QDA IOCTL definitions
>> + *
>> + * These macros define the actual IOCTL numbers used by userspace applications.
>> + * They combine the command numbers with DRM_COMMAND_BASE and specify the
>> + * data structure and direction (read/write) for each IOCTL.
>> + */
>> +#define DRM_IOCTL_QDA_QUERY		DRM_IOR(DRM_COMMAND_BASE + DRM_QDA_QUERY, \
>> +					 struct drm_qda_query)
>> +
>> +/**
>> + * struct drm_qda_query - Device information query structure
>> + * @dsp_name: Name of DSP (e.g., "adsp", "cdsp", "cdsp1", "gdsp0", "gdsp1")
>> + *
>> + * This structure is used with DRM_IOCTL_QDA_QUERY to query device type,
>> + * allowing userspace to identify which DSP a device node represents. The
>> + * kernel provides the DSP name directly as a null-terminated string.
>> + */
>> +struct drm_qda_query {
>> +	__u8 dsp_name[16];
> 
> Are you sure that you want to query only the name? No extra options, no
> attributes, no hardware capabilities?
There are plans to extend this ioctl to support DSP capabilities and few
other query options, but as per my understanding, I don't need to add
reserved IOCTLs in drm case and I can extend it in future. Please
correct me if my understanding is wrong and I should add reserved fields.

Copying the statement from the doc[1].
"Note that drm_ioctl() automatically zero-extends structures, hence make
sure you can add more stuff at the end, i.e. don’t put a variable sized
array there."

[1]
https://www.kernel.org/doc/html/v7.0/gpu/drm-uapi.html#ioctl-support-on-device-nodes>

>> +};
>> +
>> +#if defined(__cplusplus)
>> +}
>> +#endif
>> +
>> +#endif /* __QDA_ACCEL_H__ */
>>
>> -- 
>> 2.34.1
>>
>>
> 

