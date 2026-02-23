Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6669378D64
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 22:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771885257; cv=none; b=BFqMsuOsPtQv4oMwxDzITQG39RpLCW7GloTWjai8j1GCs5qOSrpXfDjNVRSLq5xF4f8E27SlFJpPkYzKJrzE4ah9ACTlq/R6b46SHWfeeQfggTFtVoz9ZLcP9f2lFe8SshOa9xNI3p1rGVOJMM1h9b0u6ZwQv+eN/ZuzDxzsqMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771885257; c=relaxed/simple;
	bh=/58PtBnw2sF8abm1Fbhkt+r6ghRvdKgmeSB3QByvAZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8Zgoe7FAmJWIXfqD8MxstlvnM2Wl6yF/PvqSgVKof/WPgPu4OfE/SXMjGBGLvctMGy+f6Kx+9tCqeDk2+cmGLjWXzeSDqfvsBU6KyAb7otnad168X084vY4HjTQxrJ4l2+IDh2dWllGdrwC0NG8p5oWJcC1vwyKhW/hd143RQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RQ0YBPrm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V6obPIn0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RQ0YBPrm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V6obPIn0"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NK7nv63152071
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 22:20:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=3T4PeH87tzer/BxO3NLS+Z5b
	dStUULU/A8xhL/S5OgM=; b=RQ0YBPrml89hdSmkuGU61ND+Zy4XWqOk0uNe+rgn
	VMA+sel3eLgiankD/ScPOZJecycfE4yhtDcj5MiNI5E7XpkonU4BAlKyiLrVjoCN
	xFNDdP46uZ9rXosaJrJjuoh30rknH9j+ArXXIVKW2LgrUStVxiFf+1mUIrEzXGyA
	sDotFZ477vuagQ+Phq+wb44X9HKID2BygdVZgApjk0l0KPfFLbXeEFmbVMRxXJ7K
	PQhrbfF7qK9TPEYQHn+xxti9f5yli/huUq/6rAq6+Njro0N7Q18cD92HCiQacn+m
	tqSOl2lGrj+d/kkg8f/4AJYTnLvwRPUZ/KWm8wG70ZS48A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cgpj89tmh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 22:20:54 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c70ed6c849so4254902385a.1
        for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 14:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771885254; x=1772490054; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3T4PeH87tzer/BxO3NLS+Z5bdStUULU/A8xhL/S5OgM=;
        b=V6obPIn0QTHUPKS2J52nxQf88+UKxtcEh0s8wIbE3t6nxeVjfQdWwbgPxjRCaoKX4k
         l+dkkA8AzK2HlLyAFiZy8xL4PO+VoIMDbZuUm20h9UpKfM/4msdsFFzyLLcu3KLPr6yt
         KO6FcjPAYDDTNUGbgZUuoH5Z+R9LYA3UNlA6hf1GS0T+QuYmmCpMuD4n9es1kXtqa98w
         NuWFi8BAOv4XBDdZ8zJ/3Ft4sZoPdLZ7kuXm8gx45RUhDU+T1IrMX8pQ7Vo4vtKlo3YB
         Xy2wex2Fhr5w79+xNr1nsSKqIX2HdIn+NQCv+XvTQIHh7R5LpPfACnm1f5yvnHZqJuq3
         EYXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771885254; x=1772490054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3T4PeH87tzer/BxO3NLS+Z5bdStUULU/A8xhL/S5OgM=;
        b=WsNI2KzIZ3qORk0GKzN9jo5XSVlnkAV0XqzpRiKcYCHthMnOMNTFl/oMWiC/oIYdyr
         cG4i0pmWz7rMKdzfk6jLXyQW/KZGReTodVTGnRqEAPNuAWT1CWrvxjwo0aSZlTkztD/6
         u1VKVn/4zhKi4YvaQG3UdPc3dUQUX+8sWp0SLqKcNUYwn0a+VfDuJ8AHnDOZKFlKNsiY
         17CO2UIk68SAlykKc65/++xmWQzqnmUtxFm3Yrnmrzu4J+8tGy75igbFO/Va03g/NoT7
         qeoW5hynsZW5cmcq4WK2X88S6lgZJhvnTRW5ItSpv4vHbQnujMcuC4bdZ3Dh/5A46qzV
         mxrg==
X-Forwarded-Encrypted: i=1; AJvYcCX2S4SZCVhpkdfcB/FmCGcNC55nnOF/tINLCmsSjL+d6PafFX3oIzrBIR5VKwHedr6EmCrVOQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxbjarSgL5h8T3vPBPsvFptg+sd2xjUEzvYRr/mx/c0cheF70Gn
	NKCfIas2/SV9rB0tFyyIIl9Rk5uF4m9jacAtBKKtPFfm+bJ/TSdn2vX96ejT1SkiRf62ETPla7e
	iww0jQQtM2JoPSsM6XJiEK0+RueAOhUkYDwrwIl+fgz/fgpvyHIxtwkRAsg==
X-Gm-Gg: AZuq6aIsfBJn0KASatsBrWnoNx3hu7furh+kDJ9mElcIP+DVKk+n6YEfeN21K1PP0cy
	397128Epap7aZBMmCUbuFDdokevq1AvW+Nl1qnoBtGOxU97sQjZlKrgBZQAjzx0+Z5C7N6IZ8CY
	esdcNswUigcG4k5NJKHC7NrpL790yb0HLHsloNtuqfkk21pnwH/mmOBfcjR47Rv+ryFQtFeogCR
	lhp054XR5tqo7MewbgO6wHprzaKaVacfDVjgvITMfRsBGu78DPLyzThp9ewUl3ClPs/1LGEGn7c
	KQMY13GDWIho78H+435hE9GwcYzLztK5C4SgcMOFlBckQRzBbEkMcfo/3+mR3NLNsQV+4D41JlV
	MiyoBrOzpkiB4qpEBOedH+GQNcdOT0fwHW8pA+4tVNMcjg8zhSzaBAb9A6RE7T8lF5Kv/l4y+YC
	E7/w9lIUkjuA0xZ2SOi6g5yJUsDvUL8B10Mz8=
X-Received: by 2002:a05:620a:7112:b0:8be:e0c4:26ca with SMTP id af79cd13be357-8cb8ca76d0amr1295283385a.61.1771885253887;
        Mon, 23 Feb 2026 14:20:53 -0800 (PST)
X-Received: by 2002:a05:620a:7112:b0:8be:e0c4:26ca with SMTP id af79cd13be357-8cb8ca76d0amr1295279485a.61.1771885253294;
        Mon, 23 Feb 2026 14:20:53 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a0eeb45938sm1797527e87.69.2026.02.23.14.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 14:20:52 -0800 (PST)
Date: Tue, 24 Feb 2026 00:20:50 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Bharath Kumar <quic_bkumar@quicinc.com>,
        Chenna Kesava Raju <quic_chennak@quicinc.com>
Subject: Re: [PATCH RFC 08/18] accel/qda: Add per-file DRM context and
 open/close handling
Message-ID: <rnhqwqtd66fmvmyobhrodzoa7x2etzjjh7xhqrn5hkmibms5cd@ucggzznrx7j6>
References: <20260224-qda-firstpost-v1-0-fe46a9c1a046@oss.qualcomm.com>
 <20260224-qda-firstpost-v1-8-fe46a9c1a046@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224-qda-firstpost-v1-8-fe46a9c1a046@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDE5NCBTYWx0ZWRfX1AS1zZrMNqth
 Yi7vjaYmlzvoe503KVF/xoH2qvhT4VfF2M5VRkqCGsbLOM+m6/gL3g5l+7y5bdAS8Pm7FQVzKdu
 1v1/Y9dXs5UFUta+4dX289CQCZHpv1o/S41wGU0eo928DcCR7Ycd6WLBz9W2XqunHjCceaynjXt
 RVScaMLpZz31yG2p3TTcU0PnB5dCEB/ybPux9Zij+ScQwtFR+AZ/glk7k5jlH9TDR1yCt4whyzx
 mE/AfXxwaDNj9tE0La6Nki42NgtgA/hijmRpXXpna1D0oPQ+V7bqEWAMDWYrtFhHpVhDndRUc1u
 mj3gOXmGjrMdQv5h4w2LkxD9tl7+BI1N1FMHsO+7w1gq/0scdzbp8k6nXSl3HpgjxmuZ571I4Zg
 gJ8hyD2Rl+ciSmmOTEd0mrwQMIzBkrhB4L0LE+GV6ynSYfAnpwgfzErWNVmUq5BvTMMUPxQRCv7
 ZMEFvUKh/IOV2xqA/Zg==
X-Proofpoint-GUID: JIUwaglfDJOuhIQ2Oaptn-TEwh_kruHJ
X-Authority-Analysis: v=2.4 cv=Z5Lh3XRA c=1 sm=1 tr=0 ts=699cd2c6 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=i04C7yyKdwGZ-rgJMjYA:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: JIUwaglfDJOuhIQ2Oaptn-TEwh_kruHJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_05,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230194

On Tue, Feb 24, 2026 at 12:39:02AM +0530, Ekansh Gupta wrote:
> Introduce per-file and per-user context for the QDA DRM accelerator
> driver. A new qda_file_priv structure is stored in file->driver_priv
> for each open file descriptor, and a qda_user object is allocated per
> client with a unique client_id generated from an atomic counter in
> qda_dev.
> 
> The DRM driver now provides qda_open() and qda_postclose() callbacks.
> qda_open() resolves the qda_dev from the drm_device, allocates the
> qda_file_priv and qda_user structures, and attaches them to the DRM
> file. qda_postclose() tears down the per-file context and frees the
> qda_user object when the file is closed.
> 
> This prepares the QDA driver to track per-process state for future
> features such as per-client memory mappings, job submission contexts,
> and access control over DSP compute resources.

Start by describing the problem instead of stuffing it to the end. Can
we use something better suited for this task, like IDR?

> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> ---
>  drivers/accel/qda/qda_drv.c | 117 ++++++++++++++++++++++++++++++++++++++++++++
>  drivers/accel/qda/qda_drv.h |  30 ++++++++++++
>  2 files changed, 147 insertions(+)
> 
> diff --git a/drivers/accel/qda/qda_drv.c b/drivers/accel/qda/qda_drv.c
> index a9113ec78fa2..bf95fc782cf8 100644
> --- a/drivers/accel/qda/qda_drv.c
> +++ b/drivers/accel/qda/qda_drv.c
> @@ -12,11 +12,127 @@
>  #include "qda_drv.h"
>  #include "qda_rpmsg.h"
>  
> +static struct qda_drm_priv *get_drm_priv_from_device(struct drm_device *dev)
> +{
> +	if (!dev)
> +		return NULL;
> +
> +	return (struct qda_drm_priv *)dev->dev_private;
> +}
> +
> +static struct qda_dev *get_qdev_from_drm_device(struct drm_device *dev)
> +{
> +	struct qda_drm_priv *drm_priv;
> +
> +	if (!dev) {
> +		qda_dbg(NULL, "Invalid drm_device\n");
> +		return NULL;
> +	}
> +
> +	drm_priv = get_drm_priv_from_device(dev);
> +	if (!drm_priv) {
> +		qda_dbg(NULL, "No drm_priv in dev_private\n");
> +		return NULL;
> +	}
> +
> +	return drm_priv->qdev;
> +}
> +
> +static struct qda_user *alloc_qda_user(struct qda_dev *qdev)
> +{
> +	struct qda_user *qda_user;
> +
> +	qda_user = kzalloc_obj(*qda_user, GFP_KERNEL);
> +	if (!qda_user)
> +		return NULL;
> +
> +	qda_user->client_id = atomic_inc_return(&qdev->client_id_counter);
> +	qda_user->qda_dev = qdev;
> +
> +	qda_dbg(qdev, "Allocated qda_user with client_id=%u\n", qda_user->client_id);
> +	return qda_user;
> +}
> +
> +static void free_qda_user(struct qda_user *qda_user)
> +{
> +	if (!qda_user)
> +		return;
> +
> +	qda_dbg(qda_user->qda_dev, "Freeing qda_user client_id=%u\n", qda_user->client_id);
> +
> +	kfree(qda_user);
> +}
> +
> +static int qda_open(struct drm_device *dev, struct drm_file *file)
> +{
> +	struct qda_user *qda_user;
> +	struct qda_file_priv *qda_file_priv;
> +	struct qda_dev *qdev;
> +
> +	if (!file) {
> +		qda_dbg(NULL, "Invalid file pointer\n");
> +		return -EINVAL;
> +	}
> +
> +	qdev = get_qdev_from_drm_device(dev);
> +	if (!qdev) {
> +		qda_dbg(NULL, "Failed to get qdev from drm_device\n");
> +		return -EINVAL;
> +	}
> +
> +	qda_file_priv = kzalloc(sizeof(*qda_file_priv), GFP_KERNEL);
> +	if (!qda_file_priv)
> +		return -ENOMEM;
> +
> +	qda_file_priv->pid = current->pid;
> +
> +	qda_user = alloc_qda_user(qdev);
> +	if (!qda_user) {
> +		qda_dbg(qdev, "Failed to allocate qda_user\n");
> +		kfree(qda_file_priv);
> +		return -ENOMEM;
> +	}
> +
> +	file->driver_priv = qda_file_priv;
> +	qda_file_priv->qda_user = qda_user;
> +
> +	qda_dbg(qdev, "Device opened successfully for PID %d\n", current->pid);
> +
> +	return 0;
> +}
> +
> +static void qda_postclose(struct drm_device *dev, struct drm_file *file)
> +{
> +	struct qda_dev *qdev;
> +	struct qda_file_priv *qda_file_priv;
> +	struct qda_user *qda_user;
> +
> +	qdev = get_qdev_from_drm_device(dev);
> +	if (!qdev || atomic_read(&qdev->removing)) {
> +		qda_dbg(NULL, "Device unavailable or removing\n");
> +		return;

Even if it is being removed, no need to free the memory?

> +	}
> +
> +	qda_file_priv = (struct qda_file_priv *)file->driver_priv;
> +	if (qda_file_priv) {
> +		qda_user = qda_file_priv->qda_user;
> +		if (qda_user)
> +			free_qda_user(qda_user);
> +
> +		kfree(qda_file_priv);
> +		file->driver_priv = NULL;
> +	}
> +
> +	qda_dbg(qdev, "Device closed for PID %d\n", current->pid);
> +}
> +
>  DEFINE_DRM_ACCEL_FOPS(qda_accel_fops);
>  
>  static struct drm_driver qda_drm_driver = {
>  	.driver_features = DRIVER_COMPUTE_ACCEL,
>  	.fops			= &qda_accel_fops,
> +	.open			= qda_open,
> +	.postclose		= qda_postclose,
>  	.name = DRIVER_NAME,
>  	.desc = "Qualcomm DSP Accelerator Driver",
>  };
> @@ -58,6 +174,7 @@ static void init_device_resources(struct qda_dev *qdev)
>  
>  	mutex_init(&qdev->lock);
>  	atomic_set(&qdev->removing, 0);
> +	atomic_set(&qdev->client_id_counter, 0);
>  }
>  
>  static int init_memory_manager(struct qda_dev *qdev)
> diff --git a/drivers/accel/qda/qda_drv.h b/drivers/accel/qda/qda_drv.h
> index 2b80401a3741..e0ba37702a86 100644
> --- a/drivers/accel/qda/qda_drv.h
> +++ b/drivers/accel/qda/qda_drv.h
> @@ -10,6 +10,7 @@
>  #include <linux/list.h>
>  #include <linux/mutex.h>
>  #include <linux/rpmsg.h>
> +#include <linux/types.h>
>  #include <linux/xarray.h>
>  #include <drm/drm_drv.h>
>  #include <drm/drm_file.h>
> @@ -20,6 +21,33 @@
>  /* Driver identification */
>  #define DRIVER_NAME "qda"
>  
> +/**
> + * struct qda_file_priv - Per-process private data for DRM file
> + *
> + * This structure tracks per-process state for each open file descriptor.
> + * It maintains the IOMMU device assignment and links to the legacy qda_user
> + * structure for compatibility with existing code.
> + */
> +struct qda_file_priv {
> +	/* Process ID for tracking */
> +	pid_t pid;
> +	/* Pointer to qda_user structure for backward compatibility */
> +	struct qda_user *qda_user;
> +};
> +
> +/**
> + * struct qda_user - Per-user context for remote processor interaction
> + *
> + * This structure maintains per-user state for interactions with the
> + * remote processor, including memory mappings and pending operations.
> + */
> +struct qda_user {
> +	/* Unique client identifier */
> +	u32 client_id;
> +	/* Back-pointer to device structure */
> +	struct qda_dev *qda_dev;
> +};
> +
>  /**
>   * struct qda_drm_priv - DRM device private data for QDA device
>   *
> @@ -52,6 +80,8 @@ struct qda_dev {
>  	struct qda_drm_priv *drm_priv;
>  	/* Flag indicating device removal in progress */
>  	atomic_t removing;
> +	/* Atomic counter for generating unique client IDs */
> +	atomic_t client_id_counter;
>  	/* Name of the DSP (e.g., "cdsp", "adsp") */
>  	char dsp_name[16];
>  	/* Compute context-bank (CB) child devices */
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
