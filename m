Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4342345CCD
	for <iommu@lists.linux.dev>; Mon,  2 Mar 2026 08:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772439068; cv=none; b=IH/YXR0eayVkbQgwCTK2L7evq47Zm3F6XUilFBrObG1A5TamX7cHlXmpzfNMAetaDkcgM1/+L98V/w3BVEsrKMrw1J+SFk5LOMx3WNUfOK9reo0lu1IFzojbuWSmNAVAfg64rPrti50Z4mjlOnPP4VoymsCeArOyNSJPVKm9fhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772439068; c=relaxed/simple;
	bh=rv4MpTWLbVDrRZnGJ1y2PRJZKISGnzYKDx8X9nLiGok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g9N71FUVruT8jdvqIc7W/X1HzgzyutEPmt1SHezABp8NI19hfbCV0wk5l8o6PbAiadXE6pf7qEQks2MUIHaFqslXD6Wjyp5Tx4xqiIUIz5t1z//UzeDet1u8Keqh2e8skYrQOO/Z3TemZrrw+VIeaXy77n9JTxl+LPAjd3tqJ0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dLrAYbxi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VqF6LILW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dLrAYbxi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VqF6LILW"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62287Ka02258101
	for <iommu@lists.linux.dev>; Mon, 2 Mar 2026 08:11:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bKT2lOHVdbNkn4L+PlCSmA7nngbFfRJNo82IaP0zHDw=; b=dLrAYbxiNF7vvyK6
	SfLrKjq/5QhEdzKtiOGJpMAlUBmgBnsdvHRVnNL6SarLJwCyNmn2PP2Dw6paW7zr
	nYo8fH0aEF0W53Am0NrRUBvhOqD8oho/YUpKHCEjib21BnW14LFX8FbQNhx+SLtQ
	53xSK6zvSZ7Q0xXzdi+75hhBBSjUD983ojc0cMzriV2YOs3fN20pqBvGMZnf58nL
	tXNEmLWU1FUMJZSSKbat+DF+Kzh8ZnPDXzhiW+BeJTPhi4KgX5SjXoyd012GKB0q
	S8h5N4QoyNJfPq+WrGMcR+Ut7+9zhun+dskiYvyshBjzsTjpwGzwNjJiWbJ8A7En
	vOa7zg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cksfd4m80-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 02 Mar 2026 08:11:02 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ae4f27033cso8633755ad.3
        for <iommu@lists.linux.dev>; Mon, 02 Mar 2026 00:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772439061; x=1773043861; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bKT2lOHVdbNkn4L+PlCSmA7nngbFfRJNo82IaP0zHDw=;
        b=VqF6LILWMR2S2XPjf6koQTL8S4wd0kR5QKh47IV+bBmaFTlGPUDcYSZpv98LVJC3as
         4bnxAeiPsOCaIX1j1zzyZazLoPl8uEkQNLKP2fk61Ss3ApN078vcgVv7aDDXK5UZ7ayt
         BPtHFEyOfj4qa9CZXIGBnD3JAnzPAv1yF/b2POsCtxo/nhpqukAZMSNnPkjDsNSY95g5
         uWi3llAiNKrfrLKM4cRoWJdi07hBA2vHfY4a+5AhXDfYEip55YYoM2fJiy9QJ+7pPYCI
         761DoyPK5iWo1GPpzIjzqf2vnFm5fN/HsS38FhrzQMwQP9lBqPQfkAXQ2Fc7ikeY4fbe
         MxVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772439061; x=1773043861;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bKT2lOHVdbNkn4L+PlCSmA7nngbFfRJNo82IaP0zHDw=;
        b=K/RZmIjeZCYMrmP7Q0W+rjD7xBmgN/R6KyNwlrVnm56jGIzkaSwKzJL8FVjdYbs/Xa
         kaJA9KpiCYLONCJBVupV6x91vJYceNrqHSU6+82STsCv1HwhWaJiza7GJ4FjZOOWrEyN
         yxeowlD0wy1+a29y/0a//eqbxubSo74kF4n32lnCJRxyjqZBWx+FAV59o+1jbkuC0v3e
         dFi1b65bnozEMNLd6sd2pMvSuG3Ho2o/Dwi9a3ul2Cdxvo6vpy8kUtfKTTOTbtX43XQy
         orDsoTPqxgQ2DXCokJ1kHyY64hOhR6P5TO3YooBaWek1tW/AWILYbncGuBgnL7TUg6vW
         oYtA==
X-Forwarded-Encrypted: i=1; AJvYcCUzNhBgL6WL5tlUPj77lRHjvdJCgjRwSg8Gx8gPbzB0F/nE+xoRJW5rfBOTJ3bZPsvCnlsaRg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzoV07enGM2JrebvyxCIk1HMq/0jZnlX7DzNlc7gdbAK5R28JTU
	2MfvfnieQT69FYQygG1Zv9XT0GhvBN8Fx/rSrN88d1cvuVg7+YuvwU2nQgK3YfXoPV/zvJWtPUC
	abIUg8pYvE/t88gvC/2yFnU5G5MVb8AZiaioUNmYCnslHposA4WTWFkc0jw==
X-Gm-Gg: ATEYQzwv1KW7vKQPuGF7Wl+aFY5rMhORTMMmskyqwIPR0kMalTAUSmuY7dimn8AYD30
	g6Ce6oznK1aUWLl3AnKYkDxegaxKhSTlG7DN9HHXAoRP/chg0nzpCk6DJdHK1h05qGmjg0yoc3V
	k1OAHEKdvLZHUpDFqPLysVoFT9FjO5BZ812Z5jin+Jgry7fQpRFl5SUdKYTQSxPlv9Xz1MUT66h
	4b1jRt/RpNZHfZP6dsFneryuq+gmHdjHNJKd7Plqqqk/zL6p34hbuTLsKL4MuIc5RGQYSv479p6
	JRRnJX1PRaEgZEE48vRvPZRUYtuuimwCT2rvS7a1WyrvkstatcJOp76WPQ6iB24QMcbbBEwcZCD
	G3No82eCAscE3vOLSjdllopjDVUaBu7FC3MoSmzNvHrWG0A09TA==
X-Received: by 2002:a17:902:ea02:b0:2ad:c527:e9fd with SMTP id d9443c01a7336-2ae2e4b5a34mr128338515ad.41.1772439061403;
        Mon, 02 Mar 2026 00:11:01 -0800 (PST)
X-Received: by 2002:a17:902:ea02:b0:2ad:c527:e9fd with SMTP id d9443c01a7336-2ae2e4b5a34mr128338135ad.41.1772439060858;
        Mon, 02 Mar 2026 00:11:00 -0800 (PST)
Received: from [10.206.99.28] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae45e07626sm51334055ad.39.2026.03.02.00.10.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 00:11:00 -0800 (PST)
Message-ID: <0e38e009-8097-4a66-b04f-95468b731b6d@oss.qualcomm.com>
Date: Mon, 2 Mar 2026 13:40:52 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 05/18] accel/qda: Create compute CB devices on QDA
 compute bus
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
 <20260224-qda-firstpost-v1-5-fe46a9c1a046@oss.qualcomm.com>
 <x3s26yr7oy2dokp4plsp67yndr7o4ps6nuj7i4zjze77ifljux@ap537se6npfg>
 <57937a68-7f22-4ca1-8980-0be12cf06c66@oss.qualcomm.com>
 <3y6rn5ujkdbc6cd2ooq7gobjvokwwrey2xoj4d3h2pavi7r5k6@rrc6bbmutz73>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <3y6rn5ujkdbc6cd2ooq7gobjvokwwrey2xoj4d3h2pavi7r5k6@rrc6bbmutz73>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: mnUcgz4XkErDov7yhNTBiXthMBRkQ5iS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDA3MCBTYWx0ZWRfX5jlTZqJuijXl
 6CywqyQmdgA3a4hs6Bu9oPpGtp4CNQCoKUGztY0jY/JDOgUGXJscgkxiTIOb6Ook1NJ5Cq/GAvu
 3+vGpC1TsMfS+CpuqYksu9g9nKOVECn0hDBgAX9a6kv1cbKNSlyVR+43ZdwW7Y1hG1k1qh5GLUq
 XSetPyyisLq6Xk4xCgYvZ+PNDxFWq1Rmq1pxzaNAsY/nCppP1uaJS08ntMgxlSbrhspEY4OK1SC
 OVv3BX7FNY0g3oNrGR85AXxYWLiOAnddPbAWPJNNE2Cn07oS64SgBgLiu7gHPvyEU/CMuvgmW3e
 V5xy//VNqM9NdlFbSt4RMJkjzKMLtrOkWiM0EmTl0EGUJ5vEAnsA/CUyiRcJ2wBqkgKMkwBtWMG
 etduPIhtzKCzp3TudZNfRK5960y1aivvC//tGNQKCFg1OY71lxVLPouyFfstHIOm7UBBLJiQAcu
 og8b4C/8L8c5N19mVQA==
X-Authority-Analysis: v=2.4 cv=HKDO14tv c=1 sm=1 tr=0 ts=69a54616 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=ze67pjzAHjlU0Io9_bMA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: mnUcgz4XkErDov7yhNTBiXthMBRkQ5iS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_02,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 spamscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020070



On 2/26/2026 4:16 PM, Dmitry Baryshkov wrote:
> On Thu, Feb 26, 2026 at 02:08:57PM +0530, Ekansh Gupta wrote:
>>
>> On 2/24/2026 4:19 AM, Dmitry Baryshkov wrote:
>>> On Tue, Feb 24, 2026 at 12:38:59AM +0530, Ekansh Gupta wrote:
>>>> Add support for creating compute context-bank (CB) devices under
>>>> the QDA compute bus based on child nodes of the FastRPC RPMsg
>>>> device tree node. Each DT child with compatible
>>>> "qcom,fastrpc-compute-cb" is turned into a QDA-owned struct
>>>> device on qda_cb_bus_type.
>>>>
>>>> A new qda_cb_dev structure and cb_devs list in qda_dev track these
>>>> CB devices. qda_populate_child_devices() walks the DT children
>>>> during QDA RPMsg probe, creates CB devices, configures their DMA
>>>> and IOMMU settings using of_dma_configure(), and associates a SID
>>>> from the "reg" property when present.
>>>>
>>>> On RPMsg remove, qda_unpopulate_child_devices() tears down all CB
>>>> devices, removing them from their IOMMU groups if present and
>>>> unregistering the devices. This prepares the ground for using CB
>>>> devices as IOMMU endpoints for DSP compute workloads in later
>>>> patches.
>>> Are we loosing the nsessions support?
>> Yes, it's not part of this series. I'll try bringing that as well.
>>>> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>>>> ---
>>>>  drivers/accel/qda/Makefile    |   1 +
>>>>  drivers/accel/qda/qda_cb.c    | 150 ++++++++++++++++++++++++++++++++++++++++++
>>>>  drivers/accel/qda/qda_cb.h    |  26 ++++++++
>>>>  drivers/accel/qda/qda_drv.h   |   3 +
>>>>  drivers/accel/qda/qda_rpmsg.c |  40 +++++++++++
>>>>  5 files changed, 220 insertions(+)
>>>>
>>>> diff --git a/drivers/accel/qda/Makefile b/drivers/accel/qda/Makefile
>>>> index 242684ef1af7..4aded20b6bc2 100644
>>>> --- a/drivers/accel/qda/Makefile
>>>> +++ b/drivers/accel/qda/Makefile
>>>> @@ -8,5 +8,6 @@ obj-$(CONFIG_DRM_ACCEL_QDA)	:= qda.o
>>>>  qda-y := \
>>>>  	qda_drv.o \
>>>>  	qda_rpmsg.o \
>>>> +	qda_cb.o \
>>>>  
>>>>  obj-$(CONFIG_DRM_ACCEL_QDA_COMPUTE_BUS) += qda_compute_bus.o
>>>> diff --git a/drivers/accel/qda/qda_cb.c b/drivers/accel/qda/qda_cb.c
>>>> new file mode 100644
>>>> index 000000000000..77a2d8cae076
>>>> --- /dev/null
>>>> +++ b/drivers/accel/qda/qda_cb.c
>>>> @@ -0,0 +1,150 @@
>>>> +// SPDX-License-Identifier: GPL-2.0-only
>>>> +// Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>>>> +#include <linux/dma-mapping.h>
>>>> +#include <linux/device.h>
>>>> +#include <linux/of.h>
>>>> +#include <linux/of_device.h>
>>>> +#include <linux/iommu.h>
>>>> +#include <linux/slab.h>
>>>> +#include "qda_drv.h"
>>>> +#include "qda_cb.h"
>>>> +
>>>> +static void qda_cb_dev_release(struct device *dev)
>>>> +{
>>>> +	kfree(dev);
>>> Do you need to put the reference on the OF node?
>> Reference put is happening as part of qda_destroy_cb_device.
> This way: you have a (small) window where of_node is already put (and
> might be gone), but the pointer is not NULL. The of_node should be put
> only when device is no longer accessible from the rest of the system, in
> release function.
I'll move put to release function to avoid suggested scenario. Thanks.
>
>

