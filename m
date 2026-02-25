Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA19274B3B
	for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 17:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772039820; cv=none; b=T1sMDRp5wK88M+ifbpYNW4ErLYTZsNwm4YOMmyMLp5oxt0lkSmtRlS7dWRuk+uhW0unAta60kwIpHHA93cmlpOJII4NuwV8ljYdCNwMTyPA3S2s0J9GfCitpVI3BHz2btt87lGKerFfSjnblvcHaI3jAsKxUqz5x2r9JY/WiueU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772039820; c=relaxed/simple;
	bh=kf1VhgEVHDSWqNcgyUIDo+HRqqLO7+Jy/6FcfuBfgYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U2GenyYl+6PddadGNNPiFzlprYaQmm8gidkx2M4OvM/JQ2NJ44ZXZnVJltzBhkdwaBg19SpEjAanoNrB2zdiaOmrqKGBxG42iv1mqXHU8WomXn7oJEt79O50k6pd6WxQ67DG6iISRKwJdXzHYEiXIQ/5pR3LOIfIKd7kY6zR3v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NgTnxjVb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UOaHloSx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NgTnxjVb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UOaHloSx"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PH2K0A3100871
	for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 17:16:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ucOIudrT1HeNKGnFCXAy5PnfmnhZNLc1JNcH6FfXVd0=; b=NgTnxjVbxDx9PZC5
	eGbsvbueGpTBBWMYr+OFoWbIvqGBsXta8czs7u/FZQDW8JT90NymttscOv5eU+k7
	x7NfD+8UKxeEeoYNei4v94NM5qEltXFJKwY7hQ+Y6DJO5cnkYXLuqN1IGuo/D0xz
	XkC77SKISOGHcM3Yb82rHZJ/FsZag32wE1EtFdPBHJAFnPUA347b5wzkNg0GRMaa
	Ak2PQPcQKGBqtHFFKq5SxRg9NIDOQ0TT4UatCNo809L44/hxRZqbj7FxP5FUmWnG
	ghDrbr2nXwT1LfvwWYVDZMv87NHDPzVDZanIg54SU9VvVjcvwrOpImmDxI7aTlu3
	xSyWLQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cj54p8216-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 17:16:57 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-824f7591956so23928942b3a.1
        for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 09:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772039816; x=1772644616; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ucOIudrT1HeNKGnFCXAy5PnfmnhZNLc1JNcH6FfXVd0=;
        b=UOaHloSxMNd9PN1NZzWz54aIIOTlScyYZwyh1as+0vh7o5g9AjbpzQK3UPgOwk4coC
         wsu0Hdd9KmnRciDzcpMm6DPDUEVgtL5qSMn//EyiBk2Y+yXlQt9ga4wWOvL4A+6oSfGr
         chdJOJB+lUewuvHL43Kvikl9YFKmXcrZFPloSoByTPbCf6brGbf+NPvBDrgtj7iXHTKc
         3I/cyO6SY7HfMUvVp13nInk9D7sAKQe4/X1hxSRjGZzWPTVJq0Lzc0TVR+PR0KzCl7fU
         9PK/yXQS4dsliKZVwyQ/EJ/mwgzyi7dYl0HdQNUiC4YVQ+UZeMT23hkueUek3myh1i+z
         IE8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772039816; x=1772644616;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ucOIudrT1HeNKGnFCXAy5PnfmnhZNLc1JNcH6FfXVd0=;
        b=H85jzGUl158DqbVN+UlxZTxNF3RysMV7JmIM5RwZnj2jDtotpYrGY1cpgN263cWOJZ
         d+vT1vUfK2ZroFzD16p01/1kglpVzlIr/4eWQR2AWG5uvl+kPnPo+4iayZXk9yX36ub5
         yzERDgUtKe7nmm2caSDlrPhT3MAE7CF7bXYv6qozCEBxiBvZ+NfMbprEv2D9ZJztz9Yw
         CyxGoO+pq2gR0GyKWRe7GZvIJz2ZLNyzJbowVvJsenrsG1koleyVJHzRMFWjgtAfbTtu
         mmhOlQBZT7hT5Vl3zHoiZE2pXyGXrtks5quAAp9MgueKVNpzuwTUHKbPQhI1RxX6i8Il
         aN4w==
X-Forwarded-Encrypted: i=1; AJvYcCVKrryEo5F+fEJtr1b9vVzsrSkajNEdGVL6Fi5WFytXEgOnzns7MJK6GOS8MLttjngaqrN4Ww==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywdn3loX+9xtp54NHkg/RAiI2V3zeCnuehPXl2wQIXdVjsc8CSO
	425caRsPZUYYB2/iSoZ5t8MHmKWK3vNaegylPjd56LX9pBmZv0KW4oLE9YZbn8GvppiVsKxsC6k
	jo+P82sCcircceTcfqTLjT3/4y1OGm8JWvpCPfoc/+VqvBcC1F/SIamlIGg==
X-Gm-Gg: ATEYQzwYlxUp9dwVzKFJZfhQEfmGCm+ozAod36VoSUyM5h5QEcAjoFzWtInLmI6DIy9
	xZXdqwmaFaUaREJEwx4Qjof2aQ+LQ3MxssWN7dJZzfoZ973hu7VDDqnlVuHtLrodTD391Ls9K6L
	fnHdbFzsVSxyyHUjM06luiYcp23BLftwFmOA0ncdDxpnf1WCzHauvvtQ6upkvavqEEZQtBWz/f2
	QBvSV3G2GPFaqZk8XUk0zeYPfhrlZ/TJT1lwxhH2M5WXlnwcgDCm6uZxJx1Xoy7A8raqHH55wnX
	YqL3d2FHARyyrrekbfIivwTfcphcKcAVkIrhu5G1K+36WhFj9wFsV6Sww4odVLYkixJCy9KBxC3
	n+XhD1vbGxuRLo7qh5EiJqPPfRdyw2bOXWWb/6GvxwSdioYSMFKc=
X-Received: by 2002:a05:6a00:4501:b0:81f:3a83:9756 with SMTP id d2e1a72fcca58-827337897f7mr908978b3a.30.1772039816277;
        Wed, 25 Feb 2026 09:16:56 -0800 (PST)
X-Received: by 2002:a05:6a00:4501:b0:81f:3a83:9756 with SMTP id d2e1a72fcca58-827337897f7mr908946b3a.30.1772039815684;
        Wed, 25 Feb 2026 09:16:55 -0800 (PST)
Received: from [192.168.1.5] ([171.61.227.247])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd86ca41sm15171981b3a.36.2026.02.25.09.16.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Feb 2026 09:16:54 -0800 (PST)
Message-ID: <843e550f-185a-4906-b61d-15c9b34d341f@oss.qualcomm.com>
Date: Wed, 25 Feb 2026 22:46:47 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 03/18] accel/qda: Add RPMsg transport for Qualcomm DSP
 accelerator
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
 <20260224-qda-firstpost-v1-3-fe46a9c1a046@oss.qualcomm.com>
 <tqsdbijgjomrn7fq3sdz7v2axwxqvbccpjh4fmvod4kbrq7pod@af3igw5dx66p>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <tqsdbijgjomrn7fq3sdz7v2axwxqvbccpjh4fmvod4kbrq7pod@af3igw5dx66p>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDE2NSBTYWx0ZWRfX2qFcxm2Odffd
 MxXlflXsuswV2NPhOHnIXJHHG1+aSI3zknTwJcyLL0zynVvVyA0hckWkBLjTCr9/0ZwG3gKX7w3
 IpgLe7YWkY1Brx2D8asXMai21J3gHdI9RtSibVSFU7+kqPCpi8whu0LXPXokBwsvbeuE/Uf/TEW
 kDLuiMOIgB1M2gWK+RUl5wcms7uuhGVPsbvrta2teIjjzrxjfP8OM9IAbUqZAui2+VS8ZjG2DRp
 gexG0pGbcmaS28uIGG69E8O7exoq79p7xopyMyxS1wp2xBEHHsIoJWvA8cz05jClMCs3O19lRuh
 /0Py9eIt5mv/gL9W4rC4Pnz9Ap05Y15gDL9+9BWJpZoK1eErhBd2iwU1h7m6wtqph44YuEIO3NI
 B/8m6Mm+9o7nTb8WQBUyuedscuNOrafMD2G6CEgMparC5/cuziMoNjElELy+QvIYMM2Y4flk8p/
 Y/DZxvwj50JuuMu2Zeg==
X-Proofpoint-GUID: Qpap9dtcPnyrIbhoRPOAzwe1qi5RKmAa
X-Authority-Analysis: v=2.4 cv=I5Bohdgg c=1 sm=1 tr=0 ts=699f2e89 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=CLJ8B99oKJtQbdnoKiLypA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=WvnbiS2QWwUXfDwCy_YA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: Qpap9dtcPnyrIbhoRPOAzwe1qi5RKmAa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_02,2026-02-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 impostorscore=0 phishscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602250165



On 2/24/2026 2:53 AM, Dmitry Baryshkov wrote:
> On Tue, Feb 24, 2026 at 12:38:57AM +0530, Ekansh Gupta wrote:
>> Extend the Qualcomm DSP accelerator (QDA) driver with an RPMsg-based
>> transport used to discover and manage DSP instances.
>>
>> This patch introduces:
>>
>> - A core qda_dev structure with basic device state (rpmsg device,
>>   device pointer, lock, removal flag, DSP name).
>> - Logging helpers that integrate with dev_* when a device is available
>>   and fall back to pr_* otherwise.
>> - An RPMsg client driver that binds to the Qualcomm FastRPC service and
>>   allocates a qda_dev instance using devm_kzalloc().
>> - Basic device initialization and teardown paths wired into the module
>>   init/exit.
>>
>> The RPMsg driver currently sets the DSP name from a "label" property in
>> the device tree, which will be used by subsequent patches to distinguish
>> between different DSP domains (e.g. ADSP, CDSP).
>>
>> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>> ---
>>  drivers/accel/qda/Kconfig     |   1 +
>>  drivers/accel/qda/Makefile    |   4 +-
>>  drivers/accel/qda/qda_drv.c   |  41 ++++++++++++++-
>>  drivers/accel/qda/qda_drv.h   |  91 ++++++++++++++++++++++++++++++++
>>  drivers/accel/qda/qda_rpmsg.c | 119 ++++++++++++++++++++++++++++++++++++++++++
>>  drivers/accel/qda/qda_rpmsg.h |  17 ++++++
>>  6 files changed, 270 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/accel/qda/Kconfig b/drivers/accel/qda/Kconfig
>> index 3c78ff6189e0..484d21ff1b55 100644
>> --- a/drivers/accel/qda/Kconfig
>> +++ b/drivers/accel/qda/Kconfig
>> @@ -7,6 +7,7 @@ config DRM_ACCEL_QDA
>>  	tristate "Qualcomm DSP accelerator"
>>  	depends on DRM_ACCEL
>>  	depends on ARCH_QCOM || COMPILE_TEST
>> +	depends on RPMSG
>>  	help
>>  	  Enables the DRM-based accelerator driver for Qualcomm's Hexagon DSPs.
>>  	  This driver provides a standardized interface for offloading computational
>> diff --git a/drivers/accel/qda/Makefile b/drivers/accel/qda/Makefile
>> index 573711af1d28..e7f23182589b 100644
>> --- a/drivers/accel/qda/Makefile
>> +++ b/drivers/accel/qda/Makefile
>> @@ -5,4 +5,6 @@
>>  
>>  obj-$(CONFIG_DRM_ACCEL_QDA)	:= qda.o
>>  
>> -qda-y := qda_drv.o
>> +qda-y := \
>> +	qda_drv.o \
> Squash these parts into the previous patch.
Ack.
>
>> +	qda_rpmsg.o \
>> diff --git a/drivers/accel/qda/qda_drv.c b/drivers/accel/qda/qda_drv.c
>> index 18b0d3fb1598..389c66a9ad4f 100644
>> --- a/drivers/accel/qda/qda_drv.c
>> +++ b/drivers/accel/qda/qda_drv.c
>> @@ -2,16 +2,53 @@
>>  // Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>>  #include <linux/module.h>
>>  #include <linux/kernel.h>
>> +#include <linux/atomic.h>
>> +#include "qda_drv.h"
>> +#include "qda_rpmsg.h"
>> +
>> +static void cleanup_device_resources(struct qda_dev *qdev)
>> +{
>> +	mutex_destroy(&qdev->lock);
>> +}
>> +
>> +void qda_deinit_device(struct qda_dev *qdev)
>> +{
>> +	cleanup_device_resources(qdev);
>> +}
>> +
>> +/* Initialize device resources */
>> +static void init_device_resources(struct qda_dev *qdev)
>> +{
>> +	qda_dbg(qdev, "Initializing device resources\n");
>> +
>> +	mutex_init(&qdev->lock);
>> +	atomic_set(&qdev->removing, 0);
>> +}
>> +
>> +int qda_init_device(struct qda_dev *qdev)
>> +{
>> +	init_device_resources(qdev);
>> +
>> +	qda_dbg(qdev, "QDA device initialized successfully\n");
>> +	return 0;
>> +}
>>  
>>  static int __init qda_core_init(void)
>>  {
>> -	pr_info("QDA: driver initialization complete\n");
>> +	int ret;
>> +
>> +	ret = qda_rpmsg_register();
>> +	if (ret)
>> +		return ret;
>> +
>> +	qda_info(NULL, "QDA driver initialization complete\n");
>>  	return 0;
>>  }
>>  
>>  static void __exit qda_core_exit(void)
>>  {
>> -	pr_info("QDA: driver exit complete\n");
>> +	qda_rpmsg_unregister();
>> +	qda_info(NULL, "QDA driver exit complete\n");
>>  }
>>  
>>  module_init(qda_core_init);
>> diff --git a/drivers/accel/qda/qda_drv.h b/drivers/accel/qda/qda_drv.h
>> new file mode 100644
>> index 000000000000..bec2d31ca1bb
>> --- /dev/null
>> +++ b/drivers/accel/qda/qda_drv.h
>> @@ -0,0 +1,91 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + */
>> +
>> +#ifndef __QDA_DRV_H__
>> +#define __QDA_DRV_H__
>> +
>> +#include <linux/device.h>
>> +#include <linux/mutex.h>
>> +#include <linux/rpmsg.h>
>> +#include <linux/xarray.h>
>> +
>> +/* Driver identification */
>> +#define DRIVER_NAME "qda"
>> +
>> +/* struct qda_dev - Main device structure for QDA driver */
>> +struct qda_dev {
>> +	/* RPMsg device for communication with remote processor */
>> +	struct rpmsg_device *rpdev;
>> +	/* Underlying device structure */
>> +	struct device *dev;
>> +	/* Mutex protecting device state */
>> +	struct mutex lock;
> Which parts of the state?
This lock is added to ensure proper rpdev before sending message to DSP, now I think
it might not be needed if I can ensure proper checks based on any existing helpers, I'll
check this and remove if it's not needed.
>
>> +	/* Flag indicating device removal in progress */
>> +	atomic_t removing;
> Why do you need it if we have dev->unplugged and drm_dev_enter() /
> drm_dev_exit()?
I'll check the helpers and replace wherever necessary.
>
>> +	/* Name of the DSP (e.g., "cdsp", "adsp") */
>> +	char dsp_name[16];
> Please replace with the pointers to the static array.
ack.
>
>> +};
>> +
>> +/**
>> + * qda_get_log_device - Get appropriate device for logging
>> + * @qdev: QDA device structure
>> + *
>> + * Returns the most appropriate device structure for logging messages.
>> + * Prefers qdev->dev, or returns NULL if the device is being removed
>> + * or invalid.
>> + */
>> +static inline struct device *qda_get_log_device(struct qda_dev *qdev)
>> +{
>> +	if (!qdev || atomic_read(&qdev->removing))
>> +		return NULL;
>> +
>> +	if (qdev->dev)
>> +		return qdev->dev;
>> +
>> +	return NULL;
>> +}
>> +
>> +/*
>> + * Logging macros
>> + *
>> + * These macros provide consistent logging across the driver with automatic
>> + * function name inclusion. They use dev_* functions when a device is available,
>> + * falling back to pr_* functions otherwise.
>> + */
>> +
>> +/* Error logging - always logs and tracks errors */
>> +#define qda_err(qdev, fmt, ...) do { \
>> +	struct device *__dev = qda_get_log_device(qdev); \
>> +	if (__dev) \
>> +		dev_err(__dev, "[%s] " fmt, __func__, ##__VA_ARGS__); \
>> +	else \
>> +		pr_err(DRIVER_NAME ": [%s] " fmt, __func__, ##__VA_ARGS__); \
> What /why? You are under drm, so you can use drm_* helpers instead.
ack.
>
>> +} while (0)
>> +
>> +/* Info logging - always logs, can be filtered via loglevel */
>> +#define qda_info(qdev, fmt, ...) do { \
>> +	struct device *__dev = qda_get_log_device(qdev); \
>> +	if (__dev) \
>> +		dev_info(__dev, "[%s] " fmt, __func__, ##__VA_ARGS__); \
>> +	else \
>> +		pr_info(DRIVER_NAME ": [%s] " fmt, __func__, ##__VA_ARGS__); \
>> +} while (0)
>> +
>> +/* Debug logging - controlled via dynamic debug (CONFIG_DYNAMIC_DEBUG) */
>> +#define qda_dbg(qdev, fmt, ...) do { \
>> +	struct device *__dev = qda_get_log_device(qdev); \
>> +	if (__dev) \
>> +		dev_dbg(__dev, "[%s] " fmt, __func__, ##__VA_ARGS__); \
>> +	else \
>> +		pr_debug(DRIVER_NAME ": [%s] " fmt, __func__, ##__VA_ARGS__); \
>> +} while (0)
>> +
>> +/*
>> + * Core device management functions
>> + */
>> +int qda_init_device(struct qda_dev *qdev);
>> +void qda_deinit_device(struct qda_dev *qdev);
>> +
>> +#endif /* __QDA_DRV_H__ */
>> diff --git a/drivers/accel/qda/qda_rpmsg.c b/drivers/accel/qda/qda_rpmsg.c
>> new file mode 100644
>> index 000000000000..a8b24a99ca13
>> --- /dev/null
>> +++ b/drivers/accel/qda/qda_rpmsg.c
>> @@ -0,0 +1,119 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +// Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> +#include <linux/module.h>
>> +#include <linux/rpmsg.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>> +#include "qda_drv.h"
>> +#include "qda_rpmsg.h"
>> +
>> +static int qda_rpmsg_init(struct qda_dev *qdev)
>> +{
>> +	dev_set_drvdata(&qdev->rpdev->dev, qdev);
>> +	return 0;
>> +}
>> +
>> +/* Utility function to allocate and initialize qda_dev */
>> +static struct qda_dev *alloc_and_init_qdev(struct rpmsg_device *rpdev)
>> +{
>> +	struct qda_dev *qdev;
>> +
>> +	qdev = devm_kzalloc(&rpdev->dev, sizeof(*qdev), GFP_KERNEL);
>> +	if (!qdev)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	qdev->dev = &rpdev->dev;
>> +	qdev->rpdev = rpdev;
>> +
>> +	qda_dbg(qdev, "Allocated and initialized qda_dev\n");
>> +	return qdev;
>> +}
>> +
>> +static int qda_rpmsg_cb(struct rpmsg_device *rpdev, void *data, int len, void *priv, u32 src)
>> +{
>> +	/* Dummy function for rpmsg driver */
>> +	return 0;
>> +}
>> +
>> +static void qda_rpmsg_remove(struct rpmsg_device *rpdev)
>> +{
>> +	struct qda_dev *qdev = dev_get_drvdata(&rpdev->dev);
>> +
>> +	qda_info(qdev, "Removing RPMsg device\n");
>> +
>> +	atomic_set(&qdev->removing, 1);
>> +
>> +	mutex_lock(&qdev->lock);
>> +	qdev->rpdev = NULL;
>> +	mutex_unlock(&qdev->lock);
>> +
>> +	qda_deinit_device(qdev);
>> +
>> +	qda_info(qdev, "RPMsg device removed\n");
>> +}
>> +
>> +static int qda_rpmsg_probe(struct rpmsg_device *rpdev)
>> +{
>> +	struct qda_dev *qdev;
>> +	int ret;
>> +	const char *label;
>> +
>> +	qda_dbg(NULL, "QDA RPMsg probe starting\n");
>> +
>> +	qdev = alloc_and_init_qdev(rpdev);
>> +	if (IS_ERR(qdev))
>> +		return PTR_ERR(qdev);
>> +
>> +	ret = of_property_read_string(rpdev->dev.of_node, "label", &label);
>> +	if (!ret) {
>> +		strscpy(qdev->dsp_name, label, sizeof(qdev->dsp_name));
>> +	} else {
>> +		qda_info(qdev, "QDA DSP label not found in DT\n");
>> +		return ret;
>> +	}
>> +
>> +	ret = qda_rpmsg_init(qdev);
>> +	if (ret) {
>> +		qda_err(qdev, "RPMsg init failed: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	ret = qda_init_device(qdev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	qda_info(qdev, "QDA RPMsg probe completed successfully for %s\n", qdev->dsp_name);
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id qda_rpmsg_id_table[] = {
>> +	{ .compatible = "qcom,fastrpc" },
>> +	{},
>> +};
>> +MODULE_DEVICE_TABLE(of, qda_rpmsg_id_table);
>> +
>> +static struct rpmsg_driver qda_rpmsg_driver = {
>> +	.probe = qda_rpmsg_probe,
>> +	.remove = qda_rpmsg_remove,
>> +	.callback = qda_rpmsg_cb,
>> +	.drv = {
>> +		.name = "qcom,fastrpc",
>> +		.of_match_table = qda_rpmsg_id_table,
>> +	},
>> +};
>> +
>> +int qda_rpmsg_register(void)
>> +{
>> +	int ret = register_rpmsg_driver(&qda_rpmsg_driver);
>> +
>> +	if (ret)
>> +		qda_err(NULL, "Failed to register RPMsg driver: %d\n", ret);
>> +
>> +	return ret;
>> +}
>> +
>> +void qda_rpmsg_unregister(void)
>> +{
>> +	unregister_rpmsg_driver(&qda_rpmsg_driver);
>> +}
>> diff --git a/drivers/accel/qda/qda_rpmsg.h b/drivers/accel/qda/qda_rpmsg.h
>> new file mode 100644
>> index 000000000000..348827bff255
>> --- /dev/null
>> +++ b/drivers/accel/qda/qda_rpmsg.h
>> @@ -0,0 +1,17 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + */
>> +
>> +#ifndef __QDA_RPMSG_H__
>> +#define __QDA_RPMSG_H__
>> +
>> +#include "qda_drv.h"
>> +
>> +/*
>> + * Transport layer registration
>> + */
>> +int qda_rpmsg_register(void);
>> +void qda_rpmsg_unregister(void);
>> +
>> +#endif /* __QDA_RPMSG_H__ */
>>
>> -- 
>> 2.34.1
>>

