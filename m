Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C89C3CAA59
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 05:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780465504; cv=none; b=H9ZycaaVbsJg/2c5n88CKOr1MWG6fue/XssIYQuE6PmKBh/ATU9/qx6LLmWsNXhl0pfDzPov9risMCv0WT3tJNIiJXZieKDTv7xmNadzvmINAJSpeZCr5RJlDQ4kRfCdRdyvl5OTh8WTyF/rMaexbMulLPNMO9vo3D175b+wVVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780465504; c=relaxed/simple;
	bh=CTvSQbKtW8FpaJ7tHjCWQB0GUs6qdPLidJ/+54VFGyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tdYSVhgoZ45cDg/VXnIrMiD78MVHA9zpbW0nV52EIaHj+FdKrJEngZfX45Bh8IhWfLSDl4rRKpNNFcFgmeLbee7aaN+7wjDqoVxGuDKdHRnb8VZXZicXNdIMcv/ueN7nKiVmi9GDhJE3c9Kv/mtoCJxnAWQMWZOO7rkiLmhRsGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nyd0xvc3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fAVtgjcM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nyd0xvc3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fAVtgjcM"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6535WBGe2955407
	for <iommu@lists.linux.dev>; Wed, 3 Jun 2026 05:45:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jD4EFN8Ib2vXd/ldbSvARuiM8o4JnTecmLZxDIIYI3o=; b=nyd0xvc38qGbLOMG
	UfHnb4VdWUp5i29VrqUpHjKTi7OpdukBs4avraR0zi4jlw2chzcBnD5PDoI8DUOj
	WuayLgSxLQ13A8lEroReSxKimfdbUH2JJw8ZLAPm5r+oTsiiYNbMzCb+NaSIZSBd
	mGwFBGBDx/VLUvNMvQS7V8VdoyBFCvWV7oSo6qNnuZXwXAatlGOjhk237ZfMrCRc
	4Y5eOs4JXAgvZDmUWVArjXlHM1yfJfSBol0ciyAFguLOiGv2Hw/MUMcaJAVzTFzK
	lVvF1Y1fVS7LAx3R05M1uYRKt9m+fOQTzD1/BltriPzL4Qoaei9Q7yr5W9R8Gam6
	2JBdhA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejabbru68-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 05:45:01 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2beff6b6e74so76582845ad.1
        for <iommu@lists.linux.dev>; Tue, 02 Jun 2026 22:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780465501; x=1781070301; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jD4EFN8Ib2vXd/ldbSvARuiM8o4JnTecmLZxDIIYI3o=;
        b=fAVtgjcMNGuh3hXzOa1nkdZJKL3yaAai1pwEQS/JMmjalvLWHj7p6Xa0yOK/mv2qqL
         o36vpVkuTE7B8he0aHFCNPm7xNfmxNFqUk0gLXW/niKG2l3fv1LnTGF3rEL6t3jY2mGM
         jQzq352Bsh9o2tG5Jct0kR+qYulb6A+yyzUR8TWSuBWJi+ZtOnwWXcu8iPSLjqMEEBDs
         HUHeOrp/MyNPIOfnrTo+ZWrT6JzfHURLPdFDFgHijFaIbq7QQb3gUy3QZW3ADFbvXW9F
         VV4/h/W+tZt75F31yldzUzvt9PEUL1x3YgpB402fgDQ+fjHf/tsWXtXUQsRe01H/GZ49
         5I3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780465501; x=1781070301;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jD4EFN8Ib2vXd/ldbSvARuiM8o4JnTecmLZxDIIYI3o=;
        b=PCbLxy0GFXNF8bFYy8UYsyt8MsP9HKeBGqGWmpBODOXW1Tusr6sPmbkf0gNdJ3eBMD
         tlWtylzkP1XMUIcdB33rD+FAnx8kT9RIzJN5pYbm92m36g87gX3f4TqjtMHsUwGu6nX+
         6B9Itei96A5p3Q1CeRVyDNowZCHTa2PH7CKXwU03Rd1s+TZoB1mvzKaQvvhZbTavVh5n
         fg/usZc1etqKj7Z92p3JWe/e0XUIRHhejxShqECU5fsSq4a2sAKOzL6GQrzNNEv0gRrC
         yWe+Sxk1I1S1smdvP9DPZrXlCI+s6dN9txDD4k1ONnYXselmGoMSejaEWkcXEoNIbo7f
         ediQ==
X-Forwarded-Encrypted: i=1; AFNElJ8DGP6Nd4pNyRBgPYYTV3tJNYShy8Ni+oYo993ga7RYU/gIcoT0PoTu0CM8QYr4cjh8tkcanw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzv5Tdmp25PM+WfMxx3v3CVgiEltP1a8OIb1QBKE/eSpR+ADbTE
	jSqbOHFkaW6ufCnb5acaPqe7jen2eoW0WF8E+Rlr8IEaFgYLqt044vpsMEOvjkGeK9v+C320VSp
	vFMdLPBI4KUp/ODplw3hV6nw25gq7rm5xDadM52qk11Df9Xqg7N3MpHBYJA==
X-Gm-Gg: Acq92OFvAbEFfH0yMr0IW4F4wGSuOjjKSn80c5w1bkqq7mRIxjMRtOQWTFST9++sEnN
	ehXt5gWfw9lg3g4G2Rv3+acIW5ysV0FJfh0E+PzXabSDys2Vw3DHuWFu93rqn7Iofa525XKymfp
	e4DKqtwvuhevw4Caaezmt7/oMfGT0cmZudKVHp5nr68Y2k7XsOZefLvruj8psmKAJkR+OWQnF0d
	bWvn5UQQNonTT4vq9bXqkz21MwUkr86vvDadmB9Wf+XngIfifat5SNJFjTnfKLSEdsst/KfVqEo
	gB8lL5nZB6V8m3sblPOt0EfUc1vF/fdKQaU8zzWeTKNRPVAZDJIzM3BoxayW8eOB5+TiM8NMkAM
	zqj3s3uXBBMhAd5RsBa+GDSFOXuGRbR2uZNehm6lI2/tqvGLpORfQWpBcujeG
X-Received: by 2002:a17:903:19ef:b0:2c0:ca99:3d73 with SMTP id d9443c01a7336-2c163a28aa4mr20235915ad.8.1780465500692;
        Tue, 02 Jun 2026 22:45:00 -0700 (PDT)
X-Received: by 2002:a17:903:19ef:b0:2c0:ca99:3d73 with SMTP id d9443c01a7336-2c163a28aa4mr20235635ad.8.1780465500059;
        Tue, 02 Jun 2026 22:45:00 -0700 (PDT)
Received: from [10.204.78.54] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e0bbsm11366185ad.50.2026.06.02.22.44.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 22:44:59 -0700 (PDT)
Message-ID: <2e66a50b-f392-4ce3-89d2-997e9fef0e6b@oss.qualcomm.com>
Date: Wed, 3 Jun 2026 11:14:50 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/15] accel/qda: Add memory manager for CB devices
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
 <20260519-qda-series-v1-7-b2d984c297f8@oss.qualcomm.com>
 <sbktzorprxvo5625zkqwjgsaj723xtbsgzyypbnbgdbbxdgnnh@do5rprsx4oxr>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <sbktzorprxvo5625zkqwjgsaj723xtbsgzyypbnbgdbbxdgnnh@do5rprsx4oxr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA1MiBTYWx0ZWRfX6wexZN8GcD6O
 E3fjUJ4MHTYSqSzzrpjaBHMVNvEYzAIcYRGdb8qF7Wd+mbBmVDFE4vgXdTuOXAnpENaU+P9VxSg
 fJizHI9ZpPa9fgM2Xl8db/+JSq5ucEptn5tmKxVniobnvxaFkTnC6wtzjTGolfVaeiVvVjF6OeR
 nAyobPOECRocnF+6Hj+0WxnWyYc/TgOo05OT0UL3eyobgagq9TNozAALXjI+MFuBbL1Ibs5PErE
 IOXBZi78HeY1D/Pvq9uhDj6gQfk1kzYEoBVrMibqeKWDFPYC/TAQkZM3laSqGu81QvSA/f5hudU
 B5MKucbz+TULIKbvv8+s8YFCf3KmcNoYVaGQefnU2xmmzRH84nq0ouDIgDxlRyFkihXHlBPPRBC
 VqQFHoRbCVtGbsL8jYkZHu6SyNBp8StCUWurcAHPZFeXEOovbMRS8ilz83IP6dMwrRonlKomm7C
 NQtHekldODPVlRWWqAg==
X-Authority-Analysis: v=2.4 cv=UqZT8ewB c=1 sm=1 tr=0 ts=6a1fbf5d cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=njyYu5vTmptnp6f7sR4A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: csYC7Lkaoljg3hfRdFUsCrutEamJjAd4
X-Proofpoint-GUID: csYC7Lkaoljg3hfRdFUsCrutEamJjAd4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606030052

On 20-05-2026 19:56, Dmitry Baryshkov wrote:
> On Tue, May 19, 2026 at 11:45:57AM +0530, Ekansh Gupta via B4 Relay wrote:
>> From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>>
>> Introduce the QDA memory manager (qda_memory_manager) to track and
>> manage the IOMMU devices that back each compute context bank (CB).
>>
>> Each CB device registered on the qda-compute-cb bus is assigned a
>> unique ID via an XArray and wrapped in a qda_iommu_device descriptor
> 
> Why do you need an XArray? The number of devices is (more or less)
> fixed. You can use a normal array, allocated in the probe function after
> counting OF children nodes.
Normal array should be fine here, I'll check and remove this.>
>> that records the device pointer and its stream ID. This registry
>> allows the driver to look up the correct IOMMU domain for a given
>> session when mapping DSP buffers.
>>
>> The memory manager is initialised in qda_init_device() before CB
>> devices are populated and torn down in qda_deinit_device() after they
>> are destroyed, ensuring no dangling references remain in the XArray.
>>
>> qda_cb.c is extended with qda_cb_setup_device(), which is called
>> immediately after a CB device is registered on the bus. It allocates
>> a qda_iommu_device, registers it with the memory manager, and stores
>> it as the CB device's driver data so that qda_destroy_cb_device() can
>> retrieve and unregister it during teardown.
>>
>> Assisted-by: Claude:claude-4-6-sonnet
>> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>> ---
>>  drivers/accel/qda/Makefile             |   1 +
>>  drivers/accel/qda/qda_cb.c             |  47 ++++++++++++++
>>  drivers/accel/qda/qda_drv.c            |  34 ++++++++++
>>  drivers/accel/qda/qda_drv.h            |   5 ++
>>  drivers/accel/qda/qda_memory_manager.c | 111 +++++++++++++++++++++++++++++++++
>>  drivers/accel/qda/qda_memory_manager.h |  49 +++++++++++++++
>>  drivers/accel/qda/qda_rpmsg.c          |   7 +++
>>  7 files changed, 254 insertions(+)
>>
>> diff --git a/drivers/accel/qda/Makefile b/drivers/accel/qda/Makefile
>> index 143c9e4e789e..701fad5ffb50 100644
>> --- a/drivers/accel/qda/Makefile
>> +++ b/drivers/accel/qda/Makefile
>> @@ -8,6 +8,7 @@ obj-$(CONFIG_DRM_ACCEL_QDA)	:= qda.o
>>  qda-y := \
>>  	qda_cb.o \
>>  	qda_drv.o \
>> +	qda_memory_manager.o \
>>  	qda_rpmsg.o
>>  
>>  obj-$(CONFIG_DRM_ACCEL_QDA_COMPUTE_BUS) += qda_compute_bus.o
>> diff --git a/drivers/accel/qda/qda_cb.c b/drivers/accel/qda/qda_cb.c
>> index 77caf8438c67..6d540bb0ec7b 100644
>> --- a/drivers/accel/qda/qda_cb.c
>> +++ b/drivers/accel/qda/qda_cb.c
>> @@ -8,11 +8,42 @@
>>  #include <linux/slab.h>
>>  #include <drm/drm_print.h>
>>  #include "qda_drv.h"
>> +#include "qda_memory_manager.h"
>>  #include "qda_cb.h"
>>  
>> +static int qda_cb_setup_device(struct qda_dev *qdev, struct device *cb_dev, u32 sid)
>> +{
>> +	struct qda_iommu_device *iommu_dev;
>> +	int rc;
>> +
>> +	drm_dbg_driver(&qdev->drm_dev, "Setting up CB device %s\n", dev_name(cb_dev));
>> +
>> +	iommu_dev = kzalloc_obj(*iommu_dev);
>> +	if (!iommu_dev)
>> +		return -ENOMEM;
>> +
>> +	iommu_dev->dev = cb_dev;
>> +	iommu_dev->qdev = qdev;
>> +	iommu_dev->sid = sid;
>> +
>> +	rc = qda_memory_manager_register_device(qdev->iommu_mgr, iommu_dev);
>> +	if (rc) {
>> +		drm_err(&qdev->drm_dev, "Failed to register IOMMU device: %d\n", rc);
>> +		kfree(iommu_dev);
>> +		return rc;
>> +	}
>> +
>> +	dev_set_drvdata(cb_dev, iommu_dev);
>> +
>> +	drm_dbg_driver(&qdev->drm_dev, "CB device setup complete - SID: %u\n", sid);
>> +
>> +	return 0;
>> +}
>> +
>>  int qda_create_cb_device(struct qda_dev *qdev, struct device_node *cb_node)
>>  {
>>  	struct device *cb_dev;
>> +	int ret;
>>  	u32 sid = 0;
>>  	char name[64];
>>  	struct qda_cb_dev *entry;
>> @@ -30,6 +61,13 @@ int qda_create_cb_device(struct qda_dev *qdev, struct device_node *cb_node)
>>  		return PTR_ERR(cb_dev);
>>  	}
>>  
>> +	ret = qda_cb_setup_device(qdev, cb_dev, sid);
>> +	if (ret) {
>> +		drm_err(&qdev->drm_dev, "CB device setup failed: %d\n", ret);
>> +		device_unregister(cb_dev);
>> +		return ret;
>> +	}
>> +
>>  	entry = kzalloc_obj(*entry);
>>  	if (!entry) {
>>  		device_unregister(cb_dev);
>> @@ -80,6 +118,7 @@ int qda_cb_populate(struct qda_dev *qdev, struct device_node *parent_node)
>>  void qda_destroy_cb_device(struct device *cb_dev)
>>  {
>>  	struct iommu_group *group;
>> +	struct qda_iommu_device *iommu_dev;
>>  
>>  	if (!cb_dev) {
>>  		pr_debug("qda: NULL CB device passed to destroy\n");
>> @@ -88,6 +127,14 @@ void qda_destroy_cb_device(struct device *cb_dev)
>>  
>>  	dev_dbg(cb_dev, "Destroying CB device %s\n", dev_name(cb_dev));
>>  
>> +	iommu_dev = dev_get_drvdata(cb_dev);
>> +	if (iommu_dev && iommu_dev->qdev && iommu_dev->qdev->iommu_mgr) {
>> +		dev_dbg(cb_dev, "Unregistering IOMMU device for %s\n",
>> +			dev_name(cb_dev));
>> +		qda_memory_manager_unregister_device(iommu_dev->qdev->iommu_mgr,
>> +						     iommu_dev);
>> +	}
>> +
>>  	group = iommu_group_get(cb_dev);
>>  	if (group) {
>>  		dev_dbg(cb_dev, "Removing %s from IOMMU group\n", dev_name(cb_dev));
>> diff --git a/drivers/accel/qda/qda_drv.c b/drivers/accel/qda/qda_drv.c
>> index 6c20d6a2fc47..0ad5d9873d7e 100644
>> --- a/drivers/accel/qda/qda_drv.c
>> +++ b/drivers/accel/qda/qda_drv.c
>> @@ -57,6 +57,40 @@ struct qda_dev *qda_alloc_device(struct device *dev)
>>  	return qdev;
>>  }
>>  
>> +static void cleanup_memory_manager(struct qda_dev *qdev)
> 
> Prefixes...
ack>
>> +{
>> +	if (qdev->iommu_mgr) {
>> +		qda_memory_manager_exit(qdev->iommu_mgr);
>> +		kfree(qdev->iommu_mgr);
>> +		qdev->iommu_mgr = NULL;
>> +	}
>> +}
>> +
>> +static int init_memory_manager(struct qda_dev *qdev)
>> +{
>> +	qdev->iommu_mgr = kzalloc_obj(*qdev->iommu_mgr);
>> +	if (!qdev->iommu_mgr)
>> +		return -ENOMEM;
>> +
>> +	return qda_memory_manager_init(qdev->iommu_mgr);
>> +}
>> +
>> +void qda_deinit_device(struct qda_dev *qdev)
>> +{
>> +	cleanup_memory_manager(qdev);
> 
> Ugh, inline all your one-line wrappers.
ack>
>> +}
>> +
>> +int qda_init_device(struct qda_dev *qdev)
>> +{
>> +	int ret;
>> +
>> +	ret = init_memory_manager(qdev);
>> +	if (ret)
>> +		drm_err(&qdev->drm_dev, "Failed to initialize memory manager: %d\n", ret);
>> +
>> +	return ret;
>> +}
>> +
>>  void qda_unregister_device(struct qda_dev *qdev)
>>  {
>>  	drm_dev_unregister(&qdev->drm_dev);
>> diff --git a/drivers/accel/qda/qda_drv.h b/drivers/accel/qda/qda_drv.h
>> index 2715f378775d..eb089e586b17 100644
>> --- a/drivers/accel/qda/qda_drv.h
>> +++ b/drivers/accel/qda/qda_drv.h
>> @@ -13,6 +13,7 @@
>>  #include <drm/drm_device.h>
>>  #include <drm/drm_drv.h>
>>  #include <drm/drm_file.h>
>> +#include "qda_memory_manager.h"
>>  
>>  /* Driver identification */
>>  #define QDA_DRIVER_NAME "qda"
>> @@ -40,6 +41,8 @@ struct qda_dev {
>>  	struct device *dev;
>>  	/** @cb_devs: Compute context-bank (CB) child devices */
>>  	struct list_head cb_devs;
>> +	/** @iommu_mgr: IOMMU/memory manager instance */
>> +	struct qda_memory_manager *iommu_mgr;
>>  	/** @dsp_name: Name of the DSP domain (e.g. "cdsp", "adsp") */
>>  	const char *dsp_name;
>>  };
>> @@ -59,6 +62,8 @@ static inline struct qda_dev *qda_dev_from_drm(struct drm_device *dev)
>>  struct qda_dev *qda_alloc_device(struct device *dev);
>>  
>>  /* Core device lifecycle */
>> +int qda_init_device(struct qda_dev *qdev);
>> +void qda_deinit_device(struct qda_dev *qdev);
>>  int qda_register_device(struct qda_dev *qdev);
>>  void qda_unregister_device(struct qda_dev *qdev);
>>  
>> diff --git a/drivers/accel/qda/qda_memory_manager.c b/drivers/accel/qda/qda_memory_manager.c
>> new file mode 100644
>> index 000000000000..00a9c0ae4224
>> --- /dev/null
>> +++ b/drivers/accel/qda/qda_memory_manager.c
>> @@ -0,0 +1,111 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +// Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> +
>> +#include <linux/refcount.h>
>> +#include <linux/slab.h>
>> +#include <linux/spinlock.h>
>> +#include <linux/xarray.h>
>> +#include <drm/drm_file.h>
>> +#include "qda_drv.h"
>> +#include "qda_memory_manager.h"
>> +
>> +static void cleanup_all_memory_devices(struct qda_memory_manager *mem_mgr)
>> +{
>> +	unsigned long index;
>> +	void *entry;
>> +
>> +	pr_debug("qda: Starting cleanup of all memory devices\n");
> 
> pr_debug is a third way to debug. Stop it, please.
ack>
>> +
>> +	xa_for_each(&mem_mgr->device_xa, index, entry) {
>> +		struct qda_iommu_device *iommu_dev = entry;
>> +
>> +		pr_debug("qda: Cleaning up device id=%lu\n", index);
>> +
>> +		xa_erase(&mem_mgr->device_xa, index);
>> +		kfree(iommu_dev);
>> +	}
>> +
>> +	pr_debug("qda: Completed cleanup of all memory devices\n");
>> +}
>> +
> 

