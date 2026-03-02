Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700D536F419
	for <iommu@lists.linux.dev>; Mon,  2 Mar 2026 08:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772440442; cv=none; b=KRoPREhP8zGtWqt/gj8vwkX0M6q3GqfQvOO8CPOuepPHQjtypAy+CjfewXEGU4pl8/SHZp9VTgJBrDrF/kNhnqF723c0nwgJrjtKampK9PAnt4rqk290v4/GtSoy/iI/jy1hnWlsNtZFy7dl0bIviCUlNcCVtt0gzOOQRnzUL98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772440442; c=relaxed/simple;
	bh=txxu2DG9xzQwMmDjiRwRkA+iOAbbQRJVs+CU5TpGi6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EVc36y2CUFnCWk6ilv45cacKhQCdZzSyRt6W0m1kmWuPoh9OE5kUA9F1XpE0pF7W+75Kwp2uJpSyp970qB0QEI5u0HQcETo/hwy53J1iWQY3QjbwW9rPpPcwnREo24aMMrXmUm3yhW3JMhe8Y4rffiZOnRbAKxzxGgUh9x0230Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KHTvc93G; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IzQzqYhp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KHTvc93G";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IzQzqYhp"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6228M5C43223961
	for <iommu@lists.linux.dev>; Mon, 2 Mar 2026 08:34:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kiGzfhiYB9wtCN3D88VauW9OjmRKCIKm/2P5tjv1u1w=; b=KHTvc93GiHjJt2D4
	0m6pEeLM/1N0U/B3a242ftDXzyMebgu6s2qhbJiaacWOxnY7Dyep6gZMMgNZTOjv
	inVNFD5ZTP5oMDZw48i+qeuXlFGdxLDot1h1pO/oNKID6Tof+7JFV2RqsraAZ7VV
	R7G9ty+hum83Vtc3n1OvYw/6ICoDe7yxESCE6LR0KWOjhGg13msz2KQZc0NgDDdo
	ulZD8iFY1XZhkxOozsZapkwLXvqtIP1LK2syRk5hTIDsTDgWCebiDzvUM5f+xBZ1
	U1GH0eve0w+z3+Up+XAUcTpm7ewWi51k80dEcz1MR5JWaRl9hnIaNivUjlObRrDC
	TWrFaA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cn0b1ha65-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 02 Mar 2026 08:33:59 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2adfb6df9d6so269232705ad.1
        for <iommu@lists.linux.dev>; Mon, 02 Mar 2026 00:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772440439; x=1773045239; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kiGzfhiYB9wtCN3D88VauW9OjmRKCIKm/2P5tjv1u1w=;
        b=IzQzqYhpDxJxzdPsTAX1/Ciaq756g/leTJGIGAHMbMKySMIrKdGamqWfD0h20H3JuT
         gADpzYQ4xqE7hkalkZu2pB5PM17Ldm1lIx9FeW+fbMGSm9VMi2hbxwP2zYBY/5k7YsJr
         y4/wi90M1HkhE4Cxhmv9BL6Lx0LWE1um8Uzu3+fE1hKxlBX1z8WOSbxGFFcY/fH6OOHG
         Wb22BOg50PZuOByAlWLAG72jS5grqVuQALRh7sup0JeEnRXoKrwVXzZrCooghjEa5Sp2
         C/z9UpqzVvjq8TDj74p8rTz2wz/SUWl4SYqIiyYpq8BZqtEDtaVozF2r1oMlQW5qACxv
         qzEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772440439; x=1773045239;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kiGzfhiYB9wtCN3D88VauW9OjmRKCIKm/2P5tjv1u1w=;
        b=HisukJsjt5kXdmcobEeWsaXxtzKAw2+5dXpqaW6JS4qT1hDyOl6i9kKe8h/IP0c8AK
         /DnOjJAb2tl47PcByEDtdqEP0XOzP6DuX9Zc0/w3f/tRkxmBQGBGekVsmW4hAFbaw6hh
         cpic6EZSy8B9aPjs+K0KjzlBg/mDG5druObSmccfm0csDw/hy2Rfa4pCzAZxOPmev8J7
         Gj/jcTeqwch52ypOl7RL9EJY6Dhxyg6fXGzgVALu0FpiTzV6Mf7x5FYuupcRtK6HkCGN
         GgJaDVBAqA/FoLnHyM34WpGV/+ITAFZKRUcoPKvwsyeiNEVQ3VH1xen0tFf6gR4bD5oc
         /zCw==
X-Forwarded-Encrypted: i=1; AJvYcCWrv1zLcd2EVq2WofN8YGOMS0dI40QMUDm+UexeEEQv0k6+0Ud7AP4Zi/ALyaO1U74APIh1mA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxLGRJ7CrxGohrKJdkhrqm7ATyKU9HQCiT6ocPxSYn9RNtyyGAS
	IeOczXX0i4lx6gCowmeVZ+elXY8PKqd/z9LxJ2Mx5XK8Q4dY5ceZVnjxT6Csy0qHYsNA4BdfogC
	3ToHEmi7OxbZgMwZwfk7fPQAvA0wSCJVgkpTnVIccB3rbVq3RZENjCYVCjw==
X-Gm-Gg: ATEYQzyjp9ZsoU8vsTqS/BcN1B9wopg63mgXm6hCoORuVd6q65LQFMKBftK+ts8Vlif
	flQVgFdRRWlVOYwNgY3rIbruDmjNKJxZwtkThe4eVKtOil+xLBkMItEUqS9/6W6cegNnNW1EsGN
	uz9qPLbrJQdM96pnIPQ3ZeihVOY7y9jpMpbE5sufp+hgjz/MzkUqnUclO9JiEyE3HKmPOMo9hsa
	XOH9Yo6rkvXhA3c0xP6s+OaAtXv07jR8lZqBo46O+RUZxXEPqXC3VAkuA+2wL3mF49LJ/aOoRzq
	i7Ua5+BgWALwLJj1JivQy5A06NKfAXwZSXMA+j+Uwga4nmauq5hvOWyOQSpTbYW4fp91DcE7zNf
	+cIYpqKfg/8iSq+n68VH3p+yMqltkUGAyUU6lauvupACjpvPc+A==
X-Received: by 2002:a17:902:eb8b:b0:2ae:593c:48fc with SMTP id d9443c01a7336-2ae593c50a1mr6195925ad.53.1772440438894;
        Mon, 02 Mar 2026 00:33:58 -0800 (PST)
X-Received: by 2002:a17:902:eb8b:b0:2ae:593c:48fc with SMTP id d9443c01a7336-2ae593c50a1mr6195665ad.53.1772440438404;
        Mon, 02 Mar 2026 00:33:58 -0800 (PST)
Received: from [10.206.99.28] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6a041asm136014925ad.57.2026.03.02.00.33.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 00:33:57 -0800 (PST)
Message-ID: <f5a1d71a-0a32-4e18-aaa0-bd6dcc9c133b@oss.qualcomm.com>
Date: Mon, 2 Mar 2026 14:03:50 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 07/18] accel/qda: Add DRM accel device registration
 for QDA driver
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
 <20260224-qda-firstpost-v1-7-fe46a9c1a046@oss.qualcomm.com>
 <jjj5b2says6y2sk4lokcxslzcwlsg3gj7rme34lqmhufqc7eam@x256mqlsuvet>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <jjj5b2says6y2sk4lokcxslzcwlsg3gj7rme34lqmhufqc7eam@x256mqlsuvet>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Mxc6MUwlShuSKOD2DKnZWjogbFOp31zY
X-Authority-Analysis: v=2.4 cv=Hol72kTS c=1 sm=1 tr=0 ts=69a54b77 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=TmiqH_r-WPNNxDXjmLoA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: Mxc6MUwlShuSKOD2DKnZWjogbFOp31zY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDA3NCBTYWx0ZWRfX4qNozCNH2cXd
 31+BiXfiogG+/pfWbyREmTLhZKAlp1540MQUFkXsAQaUxGHE1xVy7XIP35l1fJntF2Q3TOmyBK5
 Pr1PWG7/AwmedsCOJ+uVWs0uijkpCfFZnZ0PI28yjqBJtTVJCJL5pBr1h55lGzSAY1n2Ygu/P3Z
 b5uaCNkBSRf8xLF2PF64LuWuT/fVeBOb2O418l45OqXafw+VD/4QxkN8OD3Cc4oBLBZ3l0m2LAs
 6+PPPves6ZGzozKqOw+sJO+gH0Ma85hKU/rNTfsVuQhQE1niU8hceKEikGIRdqdYj1Ui3f/ACJ7
 dMLupoDf/m+0Y1TcmkhAt66H8D6e/wdGLuHaNonUrHaORaJLaItV/k+3FK5LC3FJi7V7uCtsVjU
 ZIOftlqIx/TtRnUpDQGuMK1OYaq0f1H9uA9427GNI4eunN/KrQHZN7Qz8LjF/Ajktb5mx+F4q1K
 XonlAxWQgbaNeAk2Qfw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_02,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020074



On 2/24/2026 3:46 AM, Dmitry Baryshkov wrote:
> On Tue, Feb 24, 2026 at 12:39:01AM +0530, Ekansh Gupta wrote:
>> Add DRM accel integration for the QDA DSP accelerator driver. A new
>> qda_drm_priv structure is introduced to hold per-device DRM state,
>> including a pointer to the memory manager and the parent qda_dev
>> instance. The driver now allocates a drm_device, initializes
>> driver-private state, and registers the device via the DRM accel
>> infrastructure.
>>
>> qda_register_device() performs allocation and registration of the DRM
>> device, while qda_unregister_device() handles device teardown and
>> releases references using drm_dev_unregister() and drm_dev_put().
>> Initialization and teardown paths are updated so DRM resources are
>> allocated after IOMMU/memory-manager setup and cleaned during RPMsg
>> remove.
>>
>> This patch lays the foundation for adding GEM buffer support and IOCTL
>> handling in later patches as part of the compute accelerator interface.
>>
>> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>> ---
>>  drivers/accel/qda/qda_drv.c   | 103 ++++++++++++++++++++++++++++++++++++++++++
>>  drivers/accel/qda/qda_drv.h   |  33 +++++++++++++-
>>  drivers/accel/qda/qda_rpmsg.c |   8 ++++
>>  3 files changed, 142 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/accel/qda/qda_drv.c b/drivers/accel/qda/qda_drv.c
>> index 69132737f964..a9113ec78fa2 100644
>> --- a/drivers/accel/qda/qda_drv.c
>> +++ b/drivers/accel/qda/qda_drv.c
>> @@ -4,9 +4,31 @@
>>  #include <linux/kernel.h>
>>  #include <linux/atomic.h>
>>  #include <linux/slab.h>
>> +#include <drm/drm_accel.h>
>> +#include <drm/drm_drv.h>
>> +#include <drm/drm_file.h>
>> +#include <drm/drm_gem.h>
>> +#include <drm/drm_ioctl.h>
>>  #include "qda_drv.h"
>>  #include "qda_rpmsg.h"
>>  
>> +DEFINE_DRM_ACCEL_FOPS(qda_accel_fops);
>> +
>> +static struct drm_driver qda_drm_driver = {
>> +	.driver_features = DRIVER_COMPUTE_ACCEL,
>> +	.fops			= &qda_accel_fops,
> Strange indentation in the middle. Please drop it.
ack.
>
>> +	.name = DRIVER_NAME,
>> +	.desc = "Qualcomm DSP Accelerator Driver",
>> +};
>> +
>> +static void cleanup_drm_private(struct qda_dev *qdev)
>> +{
>> +	if (qdev->drm_priv) {
>> +		qda_dbg(qdev, "Cleaning up DRM private data\n");
>> +		kfree(qdev->drm_priv);
>> +	}
>> +}
>> +
>>  static void cleanup_iommu_manager(struct qda_dev *qdev)
>>  {
>>  	if (qdev->iommu_mgr) {
>> @@ -24,6 +46,7 @@ static void cleanup_device_resources(struct qda_dev *qdev)
>>  
>>  void qda_deinit_device(struct qda_dev *qdev)
>>  {
>> +	cleanup_drm_private(qdev);
>>  	cleanup_iommu_manager(qdev);
>>  	cleanup_device_resources(qdev);
>>  }
>> @@ -59,6 +82,18 @@ static int init_memory_manager(struct qda_dev *qdev)
>>  	return 0;
>>  }
>>  
>> +static int init_drm_private(struct qda_dev *qdev)
>> +{
>> +	qda_dbg(qdev, "Initializing DRM private data\n");
>> +
>> +	qdev->drm_priv = kzalloc_obj(*qdev->drm_priv, GFP_KERNEL);
>> +	if (!qdev->drm_priv)
>> +		return -ENOMEM;
>> +
>> +	qda_dbg(qdev, "DRM private data initialized successfully\n");
>> +	return 0;
>> +}
>> +
>>  int qda_init_device(struct qda_dev *qdev)
>>  {
>>  	int ret;
>> @@ -71,14 +106,82 @@ int qda_init_device(struct qda_dev *qdev)
>>  		goto err_cleanup_resources;
>>  	}
>>  
>> +	ret = init_drm_private(qdev);
>> +	if (ret) {
>> +		qda_err(qdev, "DRM private data initialization failed: %d\n", ret);
>> +		goto err_cleanup_iommu;
>> +	}
>> +
>>  	qda_dbg(qdev, "QDA device initialized successfully\n");
>>  	return 0;
>>  
>> +err_cleanup_iommu:
>> +	cleanup_iommu_manager(qdev);
>>  err_cleanup_resources:
>>  	cleanup_device_resources(qdev);
>>  	return ret;
>>  }
>>  
>> +static int setup_and_register_drm_device(struct qda_dev *qdev)
>> +{
>> +	struct drm_device *ddev;
>> +	int ret;
>> +
>> +	qda_dbg(qdev, "Setting up and registering DRM device\n");
>> +
>> +	ddev = drm_dev_alloc(&qda_drm_driver, qdev->dev);
> devm_drm_dev_alloc() please. Move this patch to the front of the series,
> making everything else depend on the allocated data structure.
ack.
>
>> +	if (IS_ERR(ddev)) {
>> +		ret = PTR_ERR(ddev);
>> +		qda_err(qdev, "Failed to allocate DRM device: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	qdev->drm_priv->drm_dev = ddev;
>> +	qdev->drm_priv->iommu_mgr = qdev->iommu_mgr;
>> +	qdev->drm_priv->qdev = qdev;
>> +
>> +	ddev->dev_private = qdev->drm_priv;
>> +	qdev->drm_dev = ddev;
>> +
>> +	ret = drm_dev_register(ddev, 0);
>> +	if (ret) {
>> +		qda_err(qdev, "Failed to register DRM device: %d\n", ret);
>> +		drm_dev_put(ddev);
>> +		return ret;
>> +	}
>> +
>> +	qda_dbg(qdev, "DRM device registered successfully\n");
>> +	return 0;
>> +}
>> +
>> +int qda_register_device(struct qda_dev *qdev)
>> +{
>> +	int ret;
>> +
>> +	ret = setup_and_register_drm_device(qdev);
>> +	if (ret) {
>> +		qda_err(qdev, "DRM device setup failed: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	qda_dbg(qdev, "QDA device registered successfully\n");
>> +	return 0;
>> +}
>> +
>> +void qda_unregister_device(struct qda_dev *qdev)
>> +{
>> +	qda_info(qdev, "Unregistering QDA device\n");
>> +
>> +	if (qdev->drm_dev) {
>> +		qda_dbg(qdev, "Unregistering DRM device\n");
>> +		drm_dev_unregister(qdev->drm_dev);
>> +		drm_dev_put(qdev->drm_dev);
>> +		qdev->drm_dev = NULL;
>> +	}
>> +
>> +	qda_dbg(qdev, "QDA device unregistered successfully\n");
>> +}
>> +
>>  static int __init qda_core_init(void)
>>  {
>>  	int ret;
>> diff --git a/drivers/accel/qda/qda_drv.h b/drivers/accel/qda/qda_drv.h
>> index 2cb97e4eafbf..2b80401a3741 100644
>> --- a/drivers/accel/qda/qda_drv.h
>> +++ b/drivers/accel/qda/qda_drv.h
>> @@ -11,13 +11,35 @@
>>  #include <linux/mutex.h>
>>  #include <linux/rpmsg.h>
>>  #include <linux/xarray.h>
>> +#include <drm/drm_drv.h>
>> +#include <drm/drm_file.h>
>> +#include <drm/drm_device.h>
>> +#include <drm/drm_accel.h>
>>  #include "qda_memory_manager.h"
>>  
>>  /* Driver identification */
>>  #define DRIVER_NAME "qda"
>>  
>> +/**
>> + * struct qda_drm_priv - DRM device private data for QDA device
>> + *
>> + * This structure serves as the DRM device private data (stored in dev_private),
>> + * bridging the DRM device context with the QDA device and providing access to
>> + * shared resources like the memory manager during buffer operations.
>> + */
>> +struct qda_drm_priv {
> Shared between what and what? Why do you need a separate structure
> instead of using qda_dev?
This is for channel specific resources which will be used by all processes using the channel. It
should be possible to use qda_dev, I'll try it out and fix this in next version.
>
>> +	/* DRM device structure */
>> +	struct drm_device *drm_dev;
>> +	/* Global memory/IOMMU manager */
>> +	struct qda_memory_manager *iommu_mgr;
>> +	/* Back-pointer to qda_dev */
>> +	struct qda_dev *qdev;
>> +};
>> +
>>  /* struct qda_dev - Main device structure for QDA driver */
>>  struct qda_dev {
>> +	/* DRM device for accelerator interface */
>> +	struct drm_device *drm_dev;
> Drop the pointer here.
I'll modify this based on qda_drm_priv replacement.
>
>>  	/* RPMsg device for communication with remote processor */
>>  	struct rpmsg_device *rpdev;
>>  	/* Underlying device structure */
>> @@ -26,6 +48,8 @@ struct qda_dev {
>>  	struct mutex lock;
>>  	/* IOMMU/memory manager */
>>  	struct qda_memory_manager *iommu_mgr;
>> +	/* DRM device private data */
>> +	struct qda_drm_priv *drm_priv;
>>  	/* Flag indicating device removal in progress */
>>  	atomic_t removing;
>>  	/* Name of the DSP (e.g., "cdsp", "adsp") */
>> @@ -39,8 +63,8 @@ struct qda_dev {
>>   * @qdev: QDA device structure
>>   *
>>   * Returns the most appropriate device structure for logging messages.
>> - * Prefers qdev->dev, or returns NULL if the device is being removed
>> - * or invalid.
>> + * Prefers qdev->dev, falls back to qdev->drm_dev->dev, or returns NULL
>> + * if the device is being removed or invalid.
>>   */
>>  static inline struct device *qda_get_log_device(struct qda_dev *qdev)
>>  {
>> @@ -50,6 +74,9 @@ static inline struct device *qda_get_log_device(struct qda_dev *qdev)
>>  	if (qdev->dev)
>>  		return qdev->dev;
>>  
>> +	if (qdev->drm_dev)
>> +		return qdev->drm_dev->dev;
>> +
>>  	return NULL;
>>  }
>>  
>> @@ -93,5 +120,7 @@ static inline struct device *qda_get_log_device(struct qda_dev *qdev)
>>   */
>>  int qda_init_device(struct qda_dev *qdev);
>>  void qda_deinit_device(struct qda_dev *qdev);
>> +int qda_register_device(struct qda_dev *qdev);
>> +void qda_unregister_device(struct qda_dev *qdev);
>>  
>>  #endif /* __QDA_DRV_H__ */
>> diff --git a/drivers/accel/qda/qda_rpmsg.c b/drivers/accel/qda/qda_rpmsg.c
>> index 5a57384de6a2..b2b44b4d3ca8 100644
>> --- a/drivers/accel/qda/qda_rpmsg.c
>> +++ b/drivers/accel/qda/qda_rpmsg.c
>> @@ -80,6 +80,7 @@ static void qda_rpmsg_remove(struct rpmsg_device *rpdev)
>>  	qdev->rpdev = NULL;
>>  	mutex_unlock(&qdev->lock);
>>  
>> +	qda_unregister_device(qdev);
>>  	qda_unpopulate_child_devices(qdev);
>>  	qda_deinit_device(qdev);
>>  
>> @@ -123,6 +124,13 @@ static int qda_rpmsg_probe(struct rpmsg_device *rpdev)
>>  		return ret;
>>  	}
>>  
>> +	ret = qda_register_device(qdev);
>> +	if (ret) {
>> +		qda_deinit_device(qdev);
>> +		qda_unpopulate_child_devices(qdev);
>> +		return ret;
>> +	}
>> +
>>  	qda_info(qdev, "QDA RPMsg probe completed successfully for %s\n", qdev->dsp_name);
>>  	return 0;
>>  }
>>
>> -- 
>> 2.34.1
>>

