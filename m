Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715083F7ABC
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 06:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780467113; cv=none; b=jaiy1lE5qYxSwONGYkP61uDKFKrrAKb1dAaXzNCQTPGA23iKB/dezH0Vxmz5XiUNOgGeXH6JQslTHTJ6zi8XGbE1AlPw49S0S3OUgYeCw/vAuG5/KLibHL+8C5sTVnXGuZXezhJb24b58h0O7tiYOylUpIw7uDAzbkWWgufExvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780467113; c=relaxed/simple;
	bh=x+xY6V7tjmQlFSrHMuO+AKeZ4Lv/+gzDnaNkEGIVBU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BIMElTjgi/zg9fswy5TP+iwJl2r0GyIJraE/E8gRTFu5vTe6+8DFRaJGCl3/EXjzEC6B0XqQaW++yK98Mh9ziWInWn0ExbicXmMlQe3eqzeQA8Yw9q6ecm3okly2O2GTfCdjk5ZYKBHFyOZjaw+kXXjDbz+qJUy28RGG7RRSUP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JdAaWgXr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YhG/mVjZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JdAaWgXr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YhG/mVjZ"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6535W91C2928320
	for <iommu@lists.linux.dev>; Wed, 3 Jun 2026 06:11:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	luPLt7IeAKwK3jkKB/1UtmasXRvyiBRth5AveWxB+Ms=; b=JdAaWgXrM4kzzOdW
	+hvyK0Nd2a7h14xqIuO7Qb/dpoYUdhUpN/IeeODoJCAc6/hHEbMHZdyvjHpLuZ6w
	1J9ujzyak7NdFV8+ki2Iizmy6KIE5HX/KkbequIjnztU6qxVTlUGVVeEQ3dUJGm0
	jUVl2ivojWtYyKruanCrO0na8w7CF2mGxZ0Vnl6puo+Uy7k+ODW9s5lmcsZE79Dy
	ofaBytmAIYguiDp1wmZ7VaCu80/ji9VEnaZ7gDp+gaSdXlOlq7sAslaoelqKS8cV
	cAfTqkIYDmG+oOYIGYiZJNEe8HPjrTpJGVsFG2MiMHRQwilrIg5We+u/b+5+DAks
	du3nLg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejabg0x4s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 06:11:49 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8422ca754d8so3078367b3a.1
        for <iommu@lists.linux.dev>; Tue, 02 Jun 2026 23:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780467109; x=1781071909; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=luPLt7IeAKwK3jkKB/1UtmasXRvyiBRth5AveWxB+Ms=;
        b=YhG/mVjZWqr+k37zSD2mf0dEtY44RZOCDFGYOFAjkSNVIHqhyEkZ07LLedRP0dvJ8Q
         nwfiACl8nqcItSVHBKvt1RXKeLsrJEWG6Yi7wuu71JtmT1a2GwNAU2R0I9KKIM/iz3Dc
         A79XRmTP6sPxo9XB1dE+GSvm8Dq/yG9ekmVKo2ICR/XFlnBtgq0cHosd6Q3hSZkIPzfk
         yu0veEGtQ+A4ZrfeQCHmlmGeghkLfb+OORw86u7SGSglKarRNdn271qZ2ozeo9BlHb3R
         /yVYwOU/4gRCUduHIwXbGVuAbdzPq1oT+JxZjinP7tHqeDUn+U/MuW8IQSLnH5gLQD5C
         /14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780467109; x=1781071909;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=luPLt7IeAKwK3jkKB/1UtmasXRvyiBRth5AveWxB+Ms=;
        b=sH/pXUAW44J2K5uj3YDeLArAGwrW1XD+N3XK2jC0SNjU8COIKQcJs77B0ZV+8ozYK3
         /NSGw1oAaW8RPwf1wEobytFIlN/BD/kF/hh3BNzhNkXJIjPuFGBL6LvIAM8Nt+9AK8o8
         ValGuystN2jOXm3bG6hXq15GFL08RuBaHb8u5NoX0xMgreqTuZ68w7QJVbbxiEIBZIx5
         wtWPkO2zj2n4Tmf3Gwhv2hi9LUKNDprSlaRlknVxDlaHRun8qn29Tj+h6jvhj/GAfD2n
         UPHP1tIK+l9pLrVe9L/f/+K+uEpDVo6vQrOy396E/bvKvRBEtqSJNh+EJ8NGv32NcOQ2
         wPsA==
X-Forwarded-Encrypted: i=1; AFNElJ8C7GNlTdUYH29W/Bk4ZNLwfNzabiSzqWrCPeQXpbYVnLrhEMgecYQJngg2tbdmcn06zsXhMw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxB7ufZOXFH2OQnG8AxAqEubv+B8POtXzd6Mj5VsDd4UnZ5Dlnq
	8KQLEW7rf9ai6Bhp50Rz6dwKLIb6JR9AT6Kdg73eEu7gHTJSK10hWuHMH0djyxZLyIe456kOp9u
	yYZbBhjDsppo8E2oALin7AZzXwtAg5R6h3HMWPmA5vFdFyEnWAqQdCAeYJg==
X-Gm-Gg: Acq92OGEj8jeCK+vfPBUMukHl4q1ApqbbM3cbE1aLjBTf9fn52IZAS4hFmMXFHIMDH2
	mQU4PStVh7l0yRApVTFaqOYMYK63Vd3cW8jisOYqMD9XQDYwzlIu5CdG/6Q4U5hEF6fk44db3q7
	gvMaIdg7836gH8Q3kiLk3pU7oOYrU4DO8S31HSbtmjhKGDpJ9mPPxOmbvFTeg2szCjpx6AhFZcP
	zJPBWY1tSJlPdgHLKeGfkPkNjj7YZ8oOExLirmXFIUOsBxj461CAvGXBYmyAU49Q4f6Icx39rS6
	2g3q01hGZHoTRXxMWJW5ecvvRS7YB+9bRwdG4ID43IDyBWZ5UeljcFpYaZhSARZJHkD7M3NnRQN
	fayY1JayRiuPAtxi5pjloO+k6AjqMqpSHpSIO8zLkm4be1sEMZOnHqyOImp/I
X-Received: by 2002:a05:6a00:429b:b0:842:614e:cc9d with SMTP id d2e1a72fcca58-84284ed9586mr1904598b3a.27.1780467108213;
        Tue, 02 Jun 2026 23:11:48 -0700 (PDT)
X-Received: by 2002:a05:6a00:429b:b0:842:614e:cc9d with SMTP id d2e1a72fcca58-84284ed9586mr1904558b3a.27.1780467107401;
        Tue, 02 Jun 2026 23:11:47 -0700 (PDT)
Received: from [10.204.78.54] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8428288217bsm2013827b3a.37.2026.06.02.23.11.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 23:11:46 -0700 (PDT)
Message-ID: <e465ed15-1568-467b-ac6b-94f903b46776@oss.qualcomm.com>
Date: Wed, 3 Jun 2026 11:41:37 +0530
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
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <3dddb7e8-5837-4038-9823-ce419cb49ec2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Ht8BBLYMj1oOFCE_ON4nEZe6L9wYDWqf
X-Authority-Analysis: v=2.4 cv=Ev3iaycA c=1 sm=1 tr=0 ts=6a1fc5a5 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=Snzw8C_a4kv6Wbo96mEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: Ht8BBLYMj1oOFCE_ON4nEZe6L9wYDWqf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA1NyBTYWx0ZWRfX2FIRclduxknx
 N1U5Wykl8iNYvD0RwixXMsvE4Bf/r5Ie0bM7Qz7DV+RkFHxf3S+n/wvT4uWcDWwLcvxeAJ+C4Nh
 RQKdawcERNCjTX2gBkdyqSjeypW5ErBFRdyX9etIf4yyn6vQf6FEWGMTG5JlCf3MDuqW1+FWe3J
 BksRnddXvVvId/m8dHkHbqvrsAv2bjmjF5x3KHCG/6A/EvHuwJJtkafc2uMuKfdbcjH/mbY/Zr0
 kQQtFqsvzPstG/GYm/SnBcxmHKe30r8Caf6uXbKnatC7uBbxR7n92o0fhOgfUwq3mWog9I8YsWC
 HSqds0fO+SN2ncxZ6rxU7z/eDwg5gSq5UJaW9bVhfv4NDHfCJmPWNb1wbx2leHF0t8bIAtdkBMj
 B22jw4f4ewAltTV1l0oDYOAWUdNzGxo8SVqi2VRnb8i8KTkWgpuLZrebUeK6lreJ3gCfEmHOSbC
 DWbTGsWjGggl8kIxEag==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 suspectscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030057

On 19-05-2026 12:25, Christian König wrote:
> On 5/19/26 08:16, Ekansh Gupta via B4 Relay wrote:
>> From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>>
>> Allow user-space to import DMA-BUF file descriptors from other
>> subsystems (GPU, camera, video) into the QDA driver via the standard
>> DRM PRIME interface.
>>
>> qda_prime.c
>>   Implements qda_gem_prime_import(), which is set as the driver's
>>   .gem_prime_import callback. On import it:
>>   1. Short-circuits self-import: if the dma_buf was exported by this
>>      device and is not itself an import, the existing GEM object is
>>      returned with an incremented reference count.
>>   2. Attaches to the dma_buf and maps it with DMA_BIDIRECTIONAL via
>>      dma_buf_map_attachment_unlocked(), obtaining an sg_table whose
>>      DMA addresses are IOMMU virtual addresses in the CB device's
>>      address space.
>>   3. Calls qda_memory_manager_alloc() to record the IOMMU mapping and
>>      encode the SID in the upper 32 bits of the DMA address, matching
>>      the convention used for natively allocated buffers.
>>
>>   qda_prime_fd_to_handle() wraps drm_gem_prime_fd_to_handle() under
>>   qdev->import_lock, storing the calling file_priv in
>>   qdev->current_import_file_priv so that qda_gem_prime_import() can
>>   retrieve it (the .gem_prime_import callback does not receive
>>   file_priv directly).
>>
>> qda_gem.c
>>   qda_gem_free_object() is extended to handle the imported-buffer
>>   teardown path: unmap the sg_table, detach from the dma_buf, and
>>   release the dma_buf reference.
>>   qda_gem_mmap_obj() rejects mmap requests on imported objects.
>>
>> qda_memory_manager.c
>>   qda_memory_manager_map_imported() records the IOMMU-mapped DMA
>>   address from the first sg entry (the IOMMU maps the buffer as a
>>   contiguous range) and encodes the SID prefix.
> 
> No it doesn't.
I see, it does not guarantee or enforce contiguous IOMMU mapping. I'll
fix the commit text.>
>>   qda_memory_manager_free() skips the DMA free path for imported
>>   buffers since the memory is owned by the exporter.
>>
>> Assisted-by: Claude:claude-4-6-sonnet
>> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>> ---
>>  drivers/accel/qda/Makefile             |   1 +
>>  drivers/accel/qda/qda_drv.c            |  12 ++-
>>  drivers/accel/qda/qda_drv.h            |   4 +
>>  drivers/accel/qda/qda_gem.c            |  25 ++++-
>>  drivers/accel/qda/qda_gem.h            |   8 ++
>>  drivers/accel/qda/qda_memory_manager.c |  47 ++++++++-
>>  drivers/accel/qda/qda_prime.c          | 184 +++++++++++++++++++++++++++++++++
>>  drivers/accel/qda/qda_prime.h          |  18 ++++
>>  8 files changed, 295 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/accel/qda/Makefile b/drivers/accel/qda/Makefile
>> index a46ddceecfc5..fb092e56d7f3 100644
>> --- a/drivers/accel/qda/Makefile
>> +++ b/drivers/accel/qda/Makefile
>> @@ -12,6 +12,7 @@ qda-y := \
>>         qda_ioctl.o \
>>         qda_memory_dma.o \
>>         qda_memory_manager.o \
>> +       qda_prime.o \
>>         qda_rpmsg.o
>>
>>  obj-$(CONFIG_DRM_ACCEL_QDA_COMPUTE_BUS) += qda_compute_bus.o
>> diff --git a/drivers/accel/qda/qda_drv.c b/drivers/accel/qda/qda_drv.c
>> index c9b9e56dcb28..ef8bd573b836 100644
>> --- a/drivers/accel/qda/qda_drv.c
>> +++ b/drivers/accel/qda/qda_drv.c
>> @@ -7,10 +7,12 @@
>>  #include <drm/drm_file.h>
>>  #include <drm/drm_gem.h>
>>  #include <drm/drm_ioctl.h>
>> +#include <drm/drm_prime.h>
>>  #include <drm/drm_print.h>
>>  #include <drm/qda_accel.h>
>>
>>  #include "qda_drv.h"
>> +#include "qda_prime.h"
>>  #include "qda_ioctl.h"
>>  #include "qda_rpmsg.h"
>>
>> @@ -64,6 +66,8 @@ static const struct drm_driver qda_drm_driver = {
>>         .postclose = qda_postclose,
>>         .ioctls = qda_ioctls,
>>         .num_ioctls = ARRAY_SIZE(qda_ioctls),
>> +       .gem_prime_import = qda_gem_prime_import,
>> +       .prime_fd_to_handle = qda_prime_fd_to_handle,
>>         .name = QDA_DRIVER_NAME,
>>         .desc = "Qualcomm DSP Accelerator Driver",
>>  };
>> @@ -100,6 +104,7 @@ static int init_memory_manager(struct qda_dev *qdev)
>>
>>  void qda_deinit_device(struct qda_dev *qdev)
>>  {
>> +       mutex_destroy(&qdev->import_lock);
>>         cleanup_memory_manager(qdev);
>>  }
>>
>> @@ -107,9 +112,14 @@ int qda_init_device(struct qda_dev *qdev)
>>  {
>>         int ret;
>>
>> +       mutex_init(&qdev->import_lock);
>> +       qdev->current_import_file_priv = NULL;
>> +
>>         ret = init_memory_manager(qdev);
>> -       if (ret)
>> +       if (ret) {
>>                 drm_err(&qdev->drm_dev, "Failed to initialize memory manager: %d\n", ret);
>> +               mutex_destroy(&qdev->import_lock);
>> +       }
>>
>>         return ret;
>>  }
>> diff --git a/drivers/accel/qda/qda_drv.h b/drivers/accel/qda/qda_drv.h
>> index 8a7d647ac8fc..96ce4135e2d9 100644
>> --- a/drivers/accel/qda/qda_drv.h
>> +++ b/drivers/accel/qda/qda_drv.h
>> @@ -47,6 +47,10 @@ struct qda_dev {
>>         struct list_head cb_devs;
>>         /** @iommu_mgr: IOMMU/memory manager instance */
>>         struct qda_memory_manager *iommu_mgr;
>> +       /** @import_lock: Lock protecting prime import context */
>> +       struct mutex import_lock;
>> +       /** @current_import_file_priv: Current file_priv during prime import */
>> +       struct drm_file *current_import_file_priv;
>>         /** @dsp_name: Name of the DSP domain (e.g. "cdsp", "adsp") */
>>         const char *dsp_name;
>>  };
>> diff --git a/drivers/accel/qda/qda_gem.c b/drivers/accel/qda/qda_gem.c
>> index 568b3c2e64b7..9e1ac7582d0c 100644
>> --- a/drivers/accel/qda/qda_gem.c
>> +++ b/drivers/accel/qda/qda_gem.c
>> @@ -9,6 +9,7 @@
>>  #include "qda_gem.h"
>>  #include "qda_memory_manager.h"
>>  #include "qda_memory_dma.h"
>> +#include "qda_prime.h"
>>
>>  static void setup_vma_flags(struct vm_area_struct *vma)
>>  {
>> @@ -25,8 +26,20 @@ void qda_gem_free_object(struct drm_gem_object *gem_obj)
>>         struct qda_gem_obj *qda_gem_obj = to_qda_gem_obj(gem_obj);
>>         struct qda_dev *qdev = qda_dev_from_drm(gem_obj->dev);
>>
>> -       if (qda_gem_obj->virt && qdev->iommu_mgr)
>> -               qda_memory_manager_free(qdev->iommu_mgr, qda_gem_obj);
>> +       if (qda_gem_obj->is_imported) {
>> +               if (qda_gem_obj->attachment && qda_gem_obj->sgt)
>> +                       dma_buf_unmap_attachment_unlocked(qda_gem_obj->attachment,
>> +                                                         qda_gem_obj->sgt, DMA_BIDIRECTIONAL);
>> +               if (qda_gem_obj->attachment)
>> +                       dma_buf_detach(qda_gem_obj->dma_buf, qda_gem_obj->attachment);
>> +               if (qda_gem_obj->dma_buf)
>> +                       dma_buf_put(qda_gem_obj->dma_buf);
>> +               if (qda_gem_obj->iommu_dev && qdev->iommu_mgr)
>> +                       qda_memory_manager_free(qdev->iommu_mgr, qda_gem_obj);
>> +       } else {
>> +               if (qda_gem_obj->virt && qdev->iommu_mgr)
>> +                       qda_memory_manager_free(qdev->iommu_mgr, qda_gem_obj);
>> +       }
>>
>>         drm_gem_object_release(gem_obj);
>>         kfree(qda_gem_obj);
>> @@ -44,6 +57,10 @@ int qda_gem_mmap_obj(struct drm_gem_object *drm_obj, struct vm_area_struct *vma)
>>         struct qda_gem_obj *qda_gem_obj = to_qda_gem_obj(drm_obj);
>>         int ret;
>>
>> +       /* Imported dma-buf objects must be mmap'd through the exporter, not the importer */
>> +       if (qda_gem_obj->is_imported)
>> +               return -EINVAL;
>> +
>>         /* Reset vm_pgoff for DMA mmap */
>>         vma->vm_pgoff = 0;
>>
>> @@ -143,6 +160,10 @@ struct drm_gem_object *qda_gem_create_object(struct drm_device *drm_dev,
>>         qda_gem_obj = qda_gem_alloc_object(drm_dev, aligned_size);
>>         if (IS_ERR(qda_gem_obj))
>>                 return ERR_CAST(qda_gem_obj);
>> +       qda_gem_obj->is_imported = false;
>> +       qda_gem_obj->dma_buf = NULL;
>> +       qda_gem_obj->attachment = NULL;
>> +       qda_gem_obj->sgt = NULL;
>>
>>         ret = qda_memory_manager_alloc(iommu_mgr, qda_gem_obj, file_priv);
>>         if (ret) {
>> diff --git a/drivers/accel/qda/qda_gem.h b/drivers/accel/qda/qda_gem.h
>> index bb18f8155aa4..0878f57715f6 100644
>> --- a/drivers/accel/qda/qda_gem.h
>> +++ b/drivers/accel/qda/qda_gem.h
>> @@ -22,12 +22,20 @@ struct qda_gem_obj {
>>         struct drm_gem_object base;
>>         /** @iommu_dev: IOMMU context bank device that performed the allocation */
>>         struct qda_iommu_device *iommu_dev;
>> +       /** @dma_buf: Reference to imported dma_buf */
>> +       struct dma_buf *dma_buf;
>> +       /** @attachment: DMA buf attachment */
>> +       struct dma_buf_attachment *attachment;
>> +       /** @sgt: Scatter-gather table */
>> +       struct sg_table *sgt;
>>         /** @virt: Kernel virtual address of the allocated DMA memory */
>>         void *virt;
>>         /** @dma_addr: DMA address (with SID encoded in upper 32 bits) */
>>         dma_addr_t dma_addr;
>>         /** @size: Size of the buffer in bytes */
>>         size_t size;
>> +       /** @is_imported: True if buffer is imported, false if allocated */
>> +       bool is_imported;
>>  };
>>
>>  /**
>> diff --git a/drivers/accel/qda/qda_memory_manager.c b/drivers/accel/qda/qda_memory_manager.c
>> index 82111275f420..d2aa0e0e65f5 100644
>> --- a/drivers/accel/qda/qda_memory_manager.c
>> +++ b/drivers/accel/qda/qda_memory_manager.c
>> @@ -202,6 +202,41 @@ static struct qda_iommu_device *get_or_assign_iommu_device(struct qda_memory_man
>>         return NULL;
>>  }
>>
>> +static int qda_memory_manager_map_imported(struct qda_memory_manager *mem_mgr,
>> +                                          struct qda_gem_obj *gem_obj,
>> +                                          struct qda_iommu_device *iommu_dev)
>> +{
>> +       struct scatterlist *sg;
>> +       dma_addr_t dma_addr;
>> +
>> +       if (!gem_obj->is_imported || !gem_obj->sgt || !iommu_dev) {
>> +               drm_err(gem_obj->base.dev, "Invalid parameters for imported buffer mapping\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       sg = gem_obj->sgt->sgl;
>> +       if (!sg) {
>> +               drm_err(gem_obj->base.dev, "Invalid scatter-gather list for imported buffer\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       gem_obj->iommu_dev = iommu_dev;
>> +
>> +       /*
>> +        * After dma_buf_map_attachment_unlocked(), sg_dma_address() returns the
>> +        * IOMMU virtual address, not the physical address. The IOMMU maps the
>> +        * entire buffer as a contiguous range in the IOMMU address space even if
>> +        * the underlying physical memory is non-contiguous. Therefore the first
>> +        * sg entry's DMA address is the start of the complete contiguous
>> +        * IOMMU-mapped range and is sufficient to describe the buffer to the DSP.
>> +        */
>> +       dma_addr = sg_dma_address(sg);
>> +       dma_addr += ((u64)iommu_dev->sid << 32);
>> +       gem_obj->dma_addr = dma_addr;
> 
> That handling here is completely broken since it assumes that the exporter maps the buffer as contigious range.
> 
> But that's in no way guaranteed.
I'll collect more details and will try to implement this in the right
way, maybe by iterating the full sg_table.>
> Regards,
> Christian.
> 
>> +
>> +       return 0;
>> +}
>> +
>>  /**
>>   * qda_memory_manager_alloc() - Allocate memory for a GEM object
>>   * @mem_mgr: Pointer to memory manager
>> @@ -237,7 +272,11 @@ int qda_memory_manager_alloc(struct qda_memory_manager *mem_mgr, struct qda_gem_
>>                 return -ENOMEM;
>>         }
>>
>> -       ret = qda_dma_alloc(selected_dev, gem_obj, size);
>> +       if (gem_obj->is_imported)
>> +               ret = qda_memory_manager_map_imported(mem_mgr, gem_obj, selected_dev);
>> +       else
>> +               ret = qda_dma_alloc(selected_dev, gem_obj, size);
>> +
>>         if (ret) {
>>                 drm_err(gem_obj->base.dev, "Allocation failed: size=%zu, device_id=%u, ret=%d\n",
>>                         size, selected_dev->id, ret);
>> @@ -262,6 +301,12 @@ void qda_memory_manager_free(struct qda_memory_manager *mem_mgr, struct qda_gem_
>>                 return;
>>         }
>>
>> +       if (gem_obj->is_imported) {
>> +               drm_dbg_driver(gem_obj->base.dev,
>> +                              "Freed imported buffer tracking (no DMA free needed)\n");
>> +               return;
>> +       }
>> +
>>         qda_dma_free(gem_obj);
>>  }
>>
>> diff --git a/drivers/accel/qda/qda_prime.c b/drivers/accel/qda/qda_prime.c
>> new file mode 100644
>> index 000000000000..acb0ac8c40fd
>> --- /dev/null
>> +++ b/drivers/accel/qda/qda_prime.c
>> @@ -0,0 +1,184 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +// Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> +#include <drm/drm_gem.h>
>> +#include <drm/drm_prime.h>
>> +#include <drm/drm_print.h>
>> +#include <linux/slab.h>
>> +#include <linux/dma-mapping.h>
>> +#include "qda_drv.h"
>> +#include "qda_gem.h"
>> +#include "qda_prime.h"
>> +#include "qda_memory_manager.h"
>> +
>> +static struct drm_gem_object *check_own_buffer(struct drm_device *dev, struct dma_buf *dma_buf)
>> +{
>> +       struct drm_gem_object *existing_gem;
>> +
>> +       /* Only safe to access priv if this dma-buf was exported by this device */
>> +       if (!drm_gem_is_prime_exported_dma_buf(dev, dma_buf))
>> +               return NULL;
>> +
>> +       existing_gem = dma_buf->priv;
>> +       if (existing_gem->dev != dev)
>> +               return NULL;
>> +
>> +       if (to_qda_gem_obj(existing_gem)->is_imported)
>> +               return NULL;
>> +
>> +       drm_gem_object_get(existing_gem);
>> +       return existing_gem;
>> +}
>> +
>> +static struct qda_iommu_device *get_iommu_device_for_import(struct qda_dev *qdev,
>> +                                                           struct drm_file **file_priv_out)
>> +{
>> +       struct drm_file *file_priv;
>> +       struct qda_file_priv *qda_file_priv;
>> +       struct qda_iommu_device *iommu_dev = NULL;
>> +       int ret;
>> +
>> +       file_priv = qdev->current_import_file_priv;
>> +       *file_priv_out = file_priv;
>> +
>> +       if (!file_priv || !file_priv->driver_priv)
>> +               return NULL;
>> +
>> +       qda_file_priv = (struct qda_file_priv *)file_priv->driver_priv;
>> +       iommu_dev = qda_file_priv->assigned_iommu_dev;
>> +
>> +       if (!iommu_dev) {
>> +               ret = qda_memory_manager_assign_device(qdev->iommu_mgr, file_priv);
>> +               if (ret) {
>> +                       drm_err(&qdev->drm_dev, "Failed to assign IOMMU device: %d\n", ret);
>> +                       return NULL;
>> +               }
>> +
>> +               iommu_dev = qda_file_priv->assigned_iommu_dev;
>> +       }
>> +
>> +       return iommu_dev;
>> +}
>> +
>> +static int setup_dma_buf_mapping(struct qda_gem_obj *qda_gem_obj, struct dma_buf *dma_buf,
>> +                                struct device *attach_dev, struct qda_dev *qdev)
>> +{
>> +       struct dma_buf_attachment *attachment;
>> +       struct sg_table *sgt;
>> +       int ret;
>> +
>> +       attachment = dma_buf_attach(dma_buf, attach_dev);
>> +       if (IS_ERR(attachment)) {
>> +               ret = PTR_ERR(attachment);
>> +               drm_err(&qdev->drm_dev, "Failed to attach dma_buf: %d\n", ret);
>> +               return ret;
>> +       }
>> +       qda_gem_obj->attachment = attachment;
>> +
>> +       sgt = dma_buf_map_attachment_unlocked(attachment, DMA_BIDIRECTIONAL);
>> +       if (IS_ERR(sgt)) {
>> +               ret = PTR_ERR(sgt);
>> +               drm_err(&qdev->drm_dev, "Failed to map dma_buf attachment: %d\n", ret);
>> +               dma_buf_detach(dma_buf, attachment);
>> +               return ret;
>> +       }
>> +       qda_gem_obj->sgt = sgt;
>> +
>> +       return 0;
>> +}
>> +
>> +/**
>> + * qda_gem_prime_import() - Import a DMA-BUF as a GEM object
>> + * @dev: DRM device structure
>> + * @dma_buf: DMA-BUF to import
>> + *
>> + * Return: Pointer to the imported GEM object on success, ERR_PTR on failure
>> + */
>> +struct drm_gem_object *qda_gem_prime_import(struct drm_device *dev, struct dma_buf *dma_buf)
>> +{
>> +       struct qda_dev *qdev = qda_dev_from_drm(dev);
>> +       struct qda_gem_obj *qda_gem_obj;
>> +       struct drm_file *file_priv;
>> +       struct qda_iommu_device *iommu_dev;
>> +       struct drm_gem_object *existing_gem;
>> +       size_t aligned_size;
>> +       int ret;
>> +
>> +       if (!qdev->iommu_mgr) {
>> +               drm_err(dev, "Invalid iommu_mgr\n");
>> +               return ERR_PTR(-ENODEV);
>> +       }
>> +
>> +       existing_gem = check_own_buffer(dev, dma_buf);
>> +       if (existing_gem)
>> +               return existing_gem;
>> +
>> +       iommu_dev = get_iommu_device_for_import(qdev, &file_priv);
>> +       if (!iommu_dev || !iommu_dev->dev) {
>> +               drm_err(dev, "No IOMMU device assigned for prime import\n");
>> +               return ERR_PTR(-ENODEV);
>> +       }
>> +
>> +       drm_dbg_driver(dev, "Using IOMMU device %u for prime import\n", iommu_dev->id);
>> +
>> +       aligned_size = PAGE_ALIGN(dma_buf->size);
>> +       qda_gem_obj = qda_gem_alloc_object(dev, aligned_size);
>> +       if (IS_ERR(qda_gem_obj))
>> +               return ERR_CAST(qda_gem_obj);
>> +
>> +       qda_gem_obj->is_imported = true;
>> +       qda_gem_obj->dma_buf = dma_buf;
>> +       qda_gem_obj->virt = NULL;
>> +       qda_gem_obj->iommu_dev = iommu_dev;
>> +
>> +       get_dma_buf(dma_buf);
>> +
>> +       ret = setup_dma_buf_mapping(qda_gem_obj, dma_buf, iommu_dev->dev, qdev);
>> +       if (ret)
>> +               goto err_put_dma_buf;
>> +
>> +       ret = qda_memory_manager_alloc(qdev->iommu_mgr, qda_gem_obj, file_priv);
>> +       if (ret) {
>> +               drm_err(dev, "Failed to allocate IOMMU mapping: %d\n", ret);
>> +               goto err_unmap;
>> +       }
>> +
>> +       drm_dbg_driver(dev, "Prime import completed successfully size=%zu\n", aligned_size);
>> +       return &qda_gem_obj->base;
>> +
>> +err_unmap:
>> +       dma_buf_unmap_attachment_unlocked(qda_gem_obj->attachment,
>> +                                         qda_gem_obj->sgt, DMA_BIDIRECTIONAL);
>> +       dma_buf_detach(dma_buf, qda_gem_obj->attachment);
>> +err_put_dma_buf:
>> +       dma_buf_put(dma_buf);
>> +       qda_gem_cleanup_object(qda_gem_obj);
>> +       return ERR_PTR(ret);
>> +}
>> +
>> +/**
>> + * qda_prime_fd_to_handle() - Convert a PRIME fd to a GEM handle
>> + * @dev: DRM device structure
>> + * @file_priv: DRM file private data
>> + * @prime_fd: File descriptor of the PRIME buffer
>> + * @handle: Output GEM handle
>> + *
>> + * Return: 0 on success, negative error code on failure
>> + */
>> +int qda_prime_fd_to_handle(struct drm_device *dev, struct drm_file *file_priv,
>> +                          int prime_fd, u32 *handle)
>> +{
>> +       struct qda_dev *qdev = qda_dev_from_drm(dev);
>> +       int ret;
>> +
>> +       mutex_lock(&qdev->import_lock);
>> +       qdev->current_import_file_priv = file_priv;
>> +
>> +       ret = drm_gem_prime_fd_to_handle(dev, file_priv, prime_fd, handle);
>> +
>> +       qdev->current_import_file_priv = NULL;
>> +       mutex_unlock(&qdev->import_lock);
>> +
>> +       return ret;
>> +}
>> +
>> +MODULE_IMPORT_NS("DMA_BUF");
>> diff --git a/drivers/accel/qda/qda_prime.h b/drivers/accel/qda/qda_prime.h
>> new file mode 100644
>> index 000000000000..9b3850d54fa7
>> --- /dev/null
>> +++ b/drivers/accel/qda/qda_prime.h
>> @@ -0,0 +1,18 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + */
>> +
>> +#ifndef __QDA_PRIME_H__
>> +#define __QDA_PRIME_H__
>> +
>> +#include <drm/drm_device.h>
>> +#include <drm/drm_file.h>
>> +#include <drm/drm_gem.h>
>> +#include <linux/dma-buf.h>
>> +
>> +struct drm_gem_object *qda_gem_prime_import(struct drm_device *dev, struct dma_buf *dma_buf);
>> +int qda_prime_fd_to_handle(struct drm_device *dev, struct drm_file *file_priv,
>> +                          int prime_fd, u32 *handle);
>> +
>> +#endif /* __QDA_PRIME_H__ */
>>
>> --
>> 2.34.1
>>
>>
> 

