Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0223E95AA
	for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 17:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772042226; cv=none; b=gc/l8NWqEVjYURWBldfn/dcp4c8VUK3MB6yPVtFe+by0wIXNY466QUbJwjgcKHX4Zcvfq+g/5XzHlTLT6FEgin0iUsuSUIE/WOcmu0trfMpFPl6ouOGwNSvEbEQGL71hSDHUL7F6oHkK/wKOUD2i/oL4kMSQaLsx/UwvF0AqCjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772042226; c=relaxed/simple;
	bh=teEJU1kty9uv5hJn5DWv1DC25MgluRijH9zH5ICZN8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RVIm8BU8BpXtwwVSkAf0Q678uwyG461pL+4UwzXlN3AB7Ddub0q9rydY+gF27Iy0uOdTekS0p3g/ZEp6I2l7Pl+PaWGJCGHe/lszEEnj7ScVekcti5yvt44eStdXRwV1Pnxzex474m1x4dYe2hWaFtt3DKdMtrwy+1CVlkBORA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=arfaW0Tf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XLEY4APD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="arfaW0Tf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XLEY4APD"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PB3RaO1512069
	for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 17:57:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mvsIZr9qVQn4O36RmaOABy93+YNGrflCz5PAS8IaKgM=; b=arfaW0TfHpQRAiB3
	YUxT/Mpf4RJwDwolsP9sX29dPvyxychIKRB9uk3QWcvfIvPnf76Au4Ap0J0MtKmp
	Ze9/v68hrjcyQXPrUuBM6LMvUf0y+jhkpgjL3BfNPmM1etkC2bFeEh0xtXHYs3Iw
	KbYZLJ9kKLbzaHkzQ6bCZkaBF1JuEJYxE4aIHwo+TLG5D+2ilhXVbKenaa+9Op6b
	86VmMxFX5qs9EYajYu8sptVauXO6ZYMx5Gtw/gXYrN0GG1MGybh6Uz/fTKUCFeKF
	tc+h+u7qxTLLtxON7DNtQlwXa+TsD3HBcXyEpXIqQMRQ2ynyjb4DUyoBxq1JiH4O
	miUARA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4chyvf196b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 17:57:03 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2aad6045810so70152125ad.3
        for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 09:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772042222; x=1772647022; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mvsIZr9qVQn4O36RmaOABy93+YNGrflCz5PAS8IaKgM=;
        b=XLEY4APDaKm4fcXrMLLFUtXnLC0ZA7Nf3S0wHxYmHeIjtT7k5ICxFhuyzklGvds7yV
         Q9mgSMPWZydRkd1E5lwN4oX9w1hluB2lFa+WZhAjunc2pm+Zyc2Hw7rhlMx8Jk7RaWC5
         j4z5vjX+8uw1Qwh3HwYpNEUSDkpThhBX+QVkPlGhEaDl7pvmqPr0GSe1KDjTjaJ1+XwO
         h3EnVZMPaKPOLenRZ8UzrTBDXpm3x/20mxUXVbTKSA7zSssqlazlFgXT3JbdAgfyOcWz
         6Dvd1iTZubozKB+WtTH87Itz2B11gm4mTL2jKd2uCN7FODn06sVTZ1caArKme4dxCgY1
         E9Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772042222; x=1772647022;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mvsIZr9qVQn4O36RmaOABy93+YNGrflCz5PAS8IaKgM=;
        b=bTaHTykqIhcV4B0mPt5segAPaddDSqzAuYqyPVroq+es9qvdjaLhKsRo+t6tyCWK3e
         VpPqF2LowP791gOzlHRxnx7MB3lDHqBQKT0XE9/QVI+D2ZksCLcznpYmb7Nkqi6D5zhh
         qkvsCuyZmRc1nhsRHNAR9aWXV7Xht4IGue5/pe6opj35M/IHALoezoXFNnOOWxLN07sV
         bsCS41jnXwxh9QL6IKhFpqrYazwueOjQ68FOj/GhmrhsqFxe+0BR1/Q2SGTRFsodBYjv
         Cpaf1a0LXEEfx9EIdj+yx69oAxg4S6b/6YJKYd8z4sqyOZmA5/Y5KqNT++5uED6gzNKY
         pUpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSfwcIK/TgR6MDNAbGZ5t2/H6fhsVz4frxG3N/Q52BdGfjttpiaGmGRXWuE3NqCjek78Gj0Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy8ZE6RHJ38kTlnDh8TK9w6BUYDfWPoLRnWfDAztq953YAFCm1O
	u+DsfD9Ig4ocnpFnQMSYdsnc1PmzjtlHJkyOlgOjORZfHloImQOlchssZAMQ4nlRtFvnYG87RUH
	nEoNn7n9Q6BKI0Vhu3NfDVKQqCXtef96YG4F9tacRVWC+5YsrRxudQJaMqA==
X-Gm-Gg: ATEYQzwrq9qj85STJ0svDU4rUCdaHN6BcRu3cfNViBnpz9aAyhG1uS8nBpYYZ1PNoaI
	30qX9G5nPzgyGziwzm0v04Pdtl63BJMwdwsR/T5j/qhRsm7J23PMj2guQq7pyNmquHuvd0RK/PC
	bz25wyPiAWD1L+zAEaByk1+oN0zci0GS2Xz5BbZahwTkGC3it6aU/fmEovWloB+GSexrYYz2aJ1
	9bZInphMNDxj6CKSBBh7x8OAVVQHTGNh/DgiSlxkr2fzioY0Gizm6XQf9niNTgQEoD4rC25JxKg
	+VbygVGW5Si9K1i+3roSO1SkI5xh6lozdiFYzp/QdUO/GVJju+HJzM0bnXcC8oHL0IntTNSe0TC
	U22U4m1X4cm8wE9mrHTFDWJUSxnJO6jk+clCwmJGIOY2TzZlKW3M=
X-Received: by 2002:a17:902:e80c:b0:2a1:388d:8ef3 with SMTP id d9443c01a7336-2ad7444e7fcmr172411735ad.18.1772042222028;
        Wed, 25 Feb 2026 09:57:02 -0800 (PST)
X-Received: by 2002:a17:902:e80c:b0:2a1:388d:8ef3 with SMTP id d9443c01a7336-2ad7444e7fcmr172411335ad.18.1772042221493;
        Wed, 25 Feb 2026 09:57:01 -0800 (PST)
Received: from [192.168.1.5] ([171.61.227.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad74f5daf5sm135513705ad.24.2026.02.25.09.56.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Feb 2026 09:57:00 -0800 (PST)
Message-ID: <e82443ff-f6c1-4b8e-b573-f4620dd0f17c@oss.qualcomm.com>
Date: Wed, 25 Feb 2026 23:26:52 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 04/18] accel/qda: Add built-in compute CB bus for QDA
 and integrate with IOMMU
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
 <20260224-qda-firstpost-v1-4-fe46a9c1a046@oss.qualcomm.com>
 <ox7jnqkjo3frhbgpp63sse7ram72obihe4qlbbn4z22wbw4szr@7pzoeecdvsyg>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <ox7jnqkjo3frhbgpp63sse7ram72obihe4qlbbn4z22wbw4szr@7pzoeecdvsyg>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: vYVkcCYOQcwhKV24AZHFlbE8ycgBaG8B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDE3MiBTYWx0ZWRfX5SstPGzkV+VC
 gClg0X/ayzDqj/vm+IdFt7+X8Cpp6s4tZJarPuZn8IuC6yWe7Y6U80MruvRWe2RntweSK93Zgms
 vSn9BK1E6BBpmx6a0szRVHgTq6BRQJY3miShSb4Go/nnasjY9a/qG3jZc9u0/OhUcR1La5tJCzn
 NJhysL8S4K6ttNxdMcN8kWu0abGKPb9yBtAupqK2pHrF5bqvpNvKX9NVXqCtVQRb1zakYfVOAkD
 nCvckMyoILEtJCV3OEyCySlAtF2mYeOStZO1IMb9iZzD9AbPtHbiozEwh33DvYgQ8ICJGm0xqR6
 in0UB0DEL/h6BaH4xoeQd38iFVfChgI0tuxUVBVuDpLhgk1u0utVInLFpT8y4JrIlz9TD+Q56bu
 cdZ7sSi/Xzk/IRpR29eYsbrArZRUNosQppvFCmIs+K7nKomd8HUqtteXBogbIpUiiARdgoj2pU7
 vgvgXTG5PeY0QMxnmpw==
X-Proofpoint-GUID: vYVkcCYOQcwhKV24AZHFlbE8ycgBaG8B
X-Authority-Analysis: v=2.4 cv=dZWNHHXe c=1 sm=1 tr=0 ts=699f37ef cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=CLJ8B99oKJtQbdnoKiLypA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=_kSkizocug0RL_Hz-QYA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_02,2026-02-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602250172



On 2/24/2026 4:14 AM, Dmitry Baryshkov wrote:
> On Tue, Feb 24, 2026 at 12:38:58AM +0530, Ekansh Gupta wrote:
>> Introduce a built-in compute context-bank (CB) bus used by the Qualcomm
>> DSP accelerator (QDA) driver to represent DSP CB devices that require
>> IOMMU configuration. This separates the CB bus from the QDA driver and
>> allows QDA to remain a loadable module while the bus is always built-in.
> Why? What is the actual problem that you are trying to solve?
Bus needs to be built-in as it is being used by iommu driver. I'll add more details here.
>
>> A new bool Kconfig symbol DRM_ACCEL_QDA_COMPUTE_BUS is added and is
> Don't describe the patch contents. Please.
Ack.
>
>> selected by the main DRM_ACCEL_QDA driver. The parent accel Makefile is
>> updated to descend into the QDA directory for both built-in and module
>> builds so that the CB bus is compiled into vmlinux while the driver
>> remains modular.
>>
>> The CB bus is registered at postcore_initcall() time and is exposed to
>> the IOMMU core through iommu_buses[] in the same way as the Tegra
>> host1x context-bus. This enables later patches to create CB devices on
>> this bus and obtain IOMMU domains for them.
> Note, there is nothing QDA-specific in this patch. Please explain, why
> the bus is QDA-specific? Can we generalize it?
I needed a custom bus here to use for the compute cb devices for iommu
configurations, I don't see any reason to keep it QDA-specific. The only requirement
is that this should be enabled built in whenever QDA is enabled.

But if I keep it generic, where should this be placed? Should it be accel(or drm?) specific?

>
>> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>> ---
>>  drivers/accel/Makefile              |  1 +
>>  drivers/accel/qda/Kconfig           |  5 +++++
>>  drivers/accel/qda/Makefile          |  2 ++
>>  drivers/accel/qda/qda_compute_bus.c | 23 +++++++++++++++++++++++
>>  drivers/iommu/iommu.c               |  4 ++++
>>  include/linux/qda_compute_bus.h     | 22 ++++++++++++++++++++++
>>  6 files changed, 57 insertions(+)
>>
>> diff --git a/drivers/accel/Makefile b/drivers/accel/Makefile
>> index 58c08dd5f389..9ed843cd293f 100644
>> --- a/drivers/accel/Makefile
>> +++ b/drivers/accel/Makefile
>> @@ -6,4 +6,5 @@ obj-$(CONFIG_DRM_ACCEL_HABANALABS)	+= habanalabs/
>>  obj-$(CONFIG_DRM_ACCEL_IVPU)		+= ivpu/
>>  obj-$(CONFIG_DRM_ACCEL_QAIC)		+= qaic/
>>  obj-$(CONFIG_DRM_ACCEL_QDA)		+= qda/
>> +obj-$(CONFIG_DRM_ACCEL_QDA_COMPUTE_BUS) += qda/
>>  obj-$(CONFIG_DRM_ACCEL_ROCKET)		+= rocket/
>> \ No newline at end of file
>> diff --git a/drivers/accel/qda/Kconfig b/drivers/accel/qda/Kconfig
>> index 484d21ff1b55..ef1fa384efbe 100644
>> --- a/drivers/accel/qda/Kconfig
>> +++ b/drivers/accel/qda/Kconfig
>> @@ -3,11 +3,16 @@
>>  # Qualcomm DSP accelerator driver
>>  #
>>  
>> +
>> +config DRM_ACCEL_QDA_COMPUTE_BUS
>> +	bool
>> +
>>  config DRM_ACCEL_QDA
>>  	tristate "Qualcomm DSP accelerator"
>>  	depends on DRM_ACCEL
>>  	depends on ARCH_QCOM || COMPILE_TEST
>>  	depends on RPMSG
>> +	select DRM_ACCEL_QDA_COMPUTE_BUS
>>  	help
>>  	  Enables the DRM-based accelerator driver for Qualcomm's Hexagon DSPs.
>>  	  This driver provides a standardized interface for offloading computational
>> diff --git a/drivers/accel/qda/Makefile b/drivers/accel/qda/Makefile
>> index e7f23182589b..242684ef1af7 100644
>> --- a/drivers/accel/qda/Makefile
>> +++ b/drivers/accel/qda/Makefile
>> @@ -8,3 +8,5 @@ obj-$(CONFIG_DRM_ACCEL_QDA)	:= qda.o
>>  qda-y := \
>>  	qda_drv.o \
>>  	qda_rpmsg.o \
>> +
>> +obj-$(CONFIG_DRM_ACCEL_QDA_COMPUTE_BUS) += qda_compute_bus.o
>> diff --git a/drivers/accel/qda/qda_compute_bus.c b/drivers/accel/qda/qda_compute_bus.c
>> new file mode 100644
>> index 000000000000..1d9c39948fb5
>> --- /dev/null
>> +++ b/drivers/accel/qda/qda_compute_bus.c
>> @@ -0,0 +1,23 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +// Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> +#include <linux/device.h>
>> +#include <linux/init.h>
>> +
>> +struct bus_type qda_cb_bus_type = {
>> +	.name = "qda-compute-cb",
>> +};
>> +EXPORT_SYMBOL_GPL(qda_cb_bus_type);
>> +
>> +static int __init qda_cb_bus_init(void)
>> +{
>> +	int err;
>> +
>> +	err = bus_register(&qda_cb_bus_type);
>> +	if (err < 0) {
>> +		pr_err("qda-compute-cb bus registration failed: %d\n", err);
>> +		return err;
>> +	}
>> +	return 0;
>> +}
>> +
>> +postcore_initcall(qda_cb_bus_init);
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 4926a43118e6..5dee912686ee 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -33,6 +33,7 @@
>>  #include <trace/events/iommu.h>
>>  #include <linux/sched/mm.h>
>>  #include <linux/msi.h>
>> +#include <linux/qda_compute_bus.h>
>>  #include <uapi/linux/iommufd.h>
>>  
>>  #include "dma-iommu.h"
>> @@ -178,6 +179,9 @@ static const struct bus_type * const iommu_buses[] = {
>>  #ifdef CONFIG_CDX_BUS
>>  	&cdx_bus_type,
>>  #endif
>> +#ifdef CONFIG_DRM_ACCEL_QDA_COMPUTE_BUS
>> +	&qda_cb_bus_type,
>> +#endif
>>  };
>>  
>>  /*
>> diff --git a/include/linux/qda_compute_bus.h b/include/linux/qda_compute_bus.h
>> new file mode 100644
>> index 000000000000..807122d84e3f
>> --- /dev/null
>> +++ b/include/linux/qda_compute_bus.h
>> @@ -0,0 +1,22 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + */
>> +
>> +#ifndef __QDA_COMPUTE_BUS_H__
>> +#define __QDA_COMPUTE_BUS_H__
>> +
>> +#include <linux/device.h>
>> +
>> +/*
>> + * Custom bus type for QDA compute context bank (CB) devices
>> + *
>> + * This bus type is used for manually created CB devices that represent
>> + * IOMMU context banks. The custom bus allows proper IOMMU configuration
>> + * and device management for these virtual devices.
>> + */
>> +#ifdef CONFIG_DRM_ACCEL_QDA_COMPUTE_BUS
>> +extern struct bus_type qda_cb_bus_type;
>> +#endif
>> +
>> +#endif /* __QDA_COMPUTE_BUS_H__ */
>>
>> -- 
>> 2.34.1
>>

