Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CF5378D64
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 22:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771886174; cv=none; b=O8iPJv44MjglzA3wjahP5/jRQ0Slqe0cVRS46tz1ieuHgiP3jSzkqe6dqi212cvd5qScwWlIcs6EIP4l8sQBPaakNxJo3l3Vv1bMYbvmVWgyOM/mOAq3Xf/r1AakGlKftgX5dYC5NkNL4S1EwHlqgRx4JWKJkc+3Kmbj2T1sYQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771886174; c=relaxed/simple;
	bh=Mz//1H2xyzoItFeXUMt4OcYByC7TS8c+Gl2mWG0R8V8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LIoFBi61r+kQm8JPMGYORq+rOm+y/jKIMz4/DWpQXF3mHQyNTmsx8Zhtpyn8yCU1+w1g0VUCHIeYOyUJeVqqir59MEaZXnjugh6CGSSxs48ydM+F6bilEu5BJ6tHp4EZbUpnq2i/S6+9Lul8UX8XUZpmnfqi1n4ki2rJE8s47/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KLSV95VB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=erf+7HpS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KLSV95VB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="erf+7HpS"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NIH0DS3698250
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 22:36:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=yEs9Z1PemjjoC0qJIiE/gZVS
	cI8Uh11i1ReozZLCUig=; b=KLSV95VBf2LAhbJNYxuD9I+Xe3cRuIoHTi5JDVEe
	ZDgNyUpvcxRNo1qPh8trJcpEFhWyILbJH/eATceg18JkM6nmM22P/3z3LASyJAcc
	J8xrUp5djLlmZj6HMAsYakr/UNLKZHM2M6ZaWb6oAaY03z8tSv1qOv3dy2hJVdIN
	vRVCJzy1N6BA/LODIF2E4XjQoPLB71deuPn2vx/6cV/Q69EiJgvcM/9GM5hg+3h6
	Zphg6GLcqO6ujxcdGV6/kHW4M8RFw5nwIv3aDwjzWWH81L/LNpaVcHKiL6Jm/EQ1
	8JaugrqInqWzL3vdWn1nZJxbpUsZiMnIJUvUAyJOnkJ08Q==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cgn81a48n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 22:36:09 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cb403842b6so4983919085a.1
        for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 14:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771886169; x=1772490969; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yEs9Z1PemjjoC0qJIiE/gZVScI8Uh11i1ReozZLCUig=;
        b=erf+7HpSZ8dcBoKnFgt4/3XxUTZVeKsRZ6qmf+ZbEXMevvOYPIpfyzTF/9P/O+ZgOq
         LUUuzOEkdNc7QZ2Ensfy2FmntgGX9Jp/Qk9C1XPpVVm71k3yW/1/YH5QhcY0GOm/1Sx0
         7gq5wjaqCeHwW5NXXMScAPHsIdv9ZFyLmEipG79bZGpScpPMzBXAY1lk+cn/b6CiLrKh
         b8Yjt/LpH1L07Yjc5J9eiyV7DxW9DjrLeRKaGPLg6gKN2B/70VV9Q+e2Xc+HFM3QM66s
         OhYHl6XsswGbie8F7iu77W2LitBrPmLnSBVnBxw48rQzsP8VoctFI1BsuHOW+NWQITNS
         Kq+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771886169; x=1772490969;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yEs9Z1PemjjoC0qJIiE/gZVScI8Uh11i1ReozZLCUig=;
        b=oYY35LCD6hmpQz3zc1vcgw8Ii1GIqCSM6ZG0KJ9iMoEwk8YIQK8xnLSuShey29Klq/
         P2mlihoZs7bhTK1uqHDxUVhvBIjky99XMSWVwQgDkV4FTRy+2w74wOUwDlQWxKOupQGL
         rmenEWpqON/Ik0CDgVW3vL1CBxyDL8zL7Q3ayPKA+PXIEEP3LI4HtYXdpWMwloxBs6Pd
         +1Z+hSz0kjPe7+uo2ge+PEGo+/RcvsLwG/oSbRjo2LHavIJIPvqn3Mhy3l48RJMKH8Pp
         qXxCA+wYP9aClP9ctFjCVd7Hs9+m3oVTCD/mTDrSI9DqR7KDfEjS57jOOvJLm4NfDEvw
         2ogg==
X-Forwarded-Encrypted: i=1; AJvYcCWEkgxBDsycEzqqnkxDHLHYVKJ6LAHkq4k7nAci/JqeHWoDoZkMZAur9ojz52sBA3QBKI/brw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyuG/+u8hXfqMuGdss/nFLomJ5jrPUXakIo5oJ1HMJzOMsAt8/o
	mufWmfTh9Z/S5xQ4ytYF3ue1Edu2G7CmwrtJ+fVDcigc1LQ5o/hNzcU8yAkKQ2/n3WAz0aDltaK
	sevpx4MnIKdARv87YvpNXKGJGTop4dEQ50Yqbg3jJXdlRxCbVk1AL1qt7Qg==
X-Gm-Gg: AZuq6aKBHj4TuRsxrlpydsitEEoq2/v/h8TLTuj6prdK0q/3atoP0b4ES+G/0KkiAoA
	bTEoGWVgCxgTEJ/gsUam4ih+8fmBUucBKZKAXn9W2pjG1lg9ae/gq/Bny94FJlRHHE4kGVv21fi
	SOOez2wm6jqjJBipWJZ+1V/TQ0BwWIOdHFe2nPv83FH+cFo2D0YHqx9rw3VPf3UsSfHaYFMRcs1
	Q8MhLYboXB9HT3Dm9z4Fimde07YA9/z8B+L5JjXdqr87cbQu8yo9ZsGt24jUgyzQJLBPUkR+3b2
	m/4k8Ag0LtGWZ3oXZHDZTVGrtx3jzj/hIY9Lt1XV7LX/BCBiNRMupBNeWcI1zQeSX0Gq+Yuv9uc
	5XwL5VH9vtPU5H4kzey31ntUZmGniUB3izxqQARR7Gdjwrqql63QgGxbbqrGBlV7XwuJljGnUdT
	BfiW/DJf7z+RhAbFhUFX/2uG2LXoxMmcu2EcY=
X-Received: by 2002:a05:620a:d86:b0:8c6:a5c7:a7ee with SMTP id af79cd13be357-8cb8ca67456mr1315629885a.53.1771886168773;
        Mon, 23 Feb 2026 14:36:08 -0800 (PST)
X-Received: by 2002:a05:620a:d86:b0:8c6:a5c7:a7ee with SMTP id af79cd13be357-8cb8ca67456mr1315624385a.53.1771886168003;
        Mon, 23 Feb 2026 14:36:08 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-389a7878d7csm17093061fa.7.2026.02.23.14.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 14:36:07 -0800 (PST)
Date: Tue, 24 Feb 2026 00:36:05 +0200
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
Subject: Re: [PATCH RFC 10/18] accel/qda: Add DMA-backed GEM objects and
 memory manager integration
Message-ID: <hhy4355j7udb753cbvunbagfqiyhcktipyl2ufw2x24gm2rtam@3x3utkfzjjnw>
References: <20260224-qda-firstpost-v1-0-fe46a9c1a046@oss.qualcomm.com>
 <20260224-qda-firstpost-v1-10-fe46a9c1a046@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224-qda-firstpost-v1-10-fe46a9c1a046@oss.qualcomm.com>
X-Proofpoint-GUID: 0RFUTAnxPwsDFnrMw2LgDqW2QnZ7f6lf
X-Proofpoint-ORIG-GUID: 0RFUTAnxPwsDFnrMw2LgDqW2QnZ7f6lf
X-Authority-Analysis: v=2.4 cv=CbsFJbrl c=1 sm=1 tr=0 ts=699cd659 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=lpSFajXHXQaPWZsiSh4A:9 a=CodIZPt08EU6SVwj:21 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDE5NiBTYWx0ZWRfXyzWyTH5QpOL2
 Mqg7vN0w2xEJSoRptKYNCj8ps45McYgEkNI3+y9lscuihSC7hQLTSnUeCGkBpmecrSu0cMwT/OL
 2SAUmQy/lFoeaaQFLF+Dpc4om5UpglXFevT0fDAnkePImHJrlumGeqCw6D7/Kd0EBWRKqy91MzX
 h82FOXTmWPM7rJhVMURRChIdYbDzbQKJYuUpNYYMjYfuYDKB/3xWzlDi3ryJEX/MV2T1mVEERBX
 TMdZaI6Qe9Lc1hrDkUeeQgLmKR/6hGbZWvS9rUPGnwYtoWvBK18f6DRlvVE6DW0PnMbhcyc7+Ju
 0z3GyhpzcJT3nqrdiQQzv4DW5QVG90UNt40+qQMySyI6cT1Udy2ehuP2BFTTqsmDQhibNl4zkxI
 Jaw1cAMvDC30U6zAVzB56q1/OvL+ElwAImKXWd7lpHlpRNRWqbDGIlQWpg+d4RiT21K8D3UDXkP
 t/Yd5B4HeT3BCDBjRBA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_05,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602230196

On Tue, Feb 24, 2026 at 12:39:04AM +0530, Ekansh Gupta wrote:
> Introduce DMA-backed GEM buffer objects for the QDA accelerator
> driver and integrate them with the existing memory manager and IOMMU
> device abstraction.
> 
> A new qda_gem_obj structure wraps drm_gem_object and tracks the
> kernel virtual address, DMA address, size and owning qda_iommu_device.
> qda_gem_create_object() allocates a GEM object, aligns the requested
> size, and uses qda_memory_manager_alloc() to obtain DMA-coherent
> memory from a per-process IOMMU device. The GEM object implements
> a .mmap callback that validates the VMA offset and calls into
> qda_dma_mmap(), which maps the DMA memory into userspace and sets
> appropriate VMA flags.
> 
> The DMA backend is implemented in qda_memory_dma.c, which allocates
> and frees coherent memory via dma_alloc_coherent() and
> dma_free_coherent(), while storing a SID-prefixed DMA address in
> the GEM object for later use by DSP firmware. The memory manager
> is extended to maintain a mapping from processes to IOMMU devices
> using qda_file_priv and a process_assignment_lock, and provides
> qda_memory_manager_alloc() and qda_memory_manager_free() helpers
> for GEM allocations.

Why are you not using drm_gem_dma_helper?

> 
> This patch lays the groundwork for GEM allocation and mmap IOCTLs
> as well as future PRIME and job submission support for QDA buffers.

Documentation/process/submitting-patches.rst, "This patch"

> 
> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> ---
>  drivers/accel/qda/Makefile             |   2 +
>  drivers/accel/qda/qda_drv.c            |  23 +++-
>  drivers/accel/qda/qda_drv.h            |   7 ++
>  drivers/accel/qda/qda_gem.c            | 187 +++++++++++++++++++++++++++++++
>  drivers/accel/qda/qda_gem.h            |  63 +++++++++++
>  drivers/accel/qda/qda_memory_dma.c     |  91 ++++++++++++++++
>  drivers/accel/qda/qda_memory_dma.h     |  46 ++++++++
>  drivers/accel/qda/qda_memory_manager.c | 194 +++++++++++++++++++++++++++++++++
>  drivers/accel/qda/qda_memory_manager.h |  33 ++++++
>  9 files changed, 645 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/accel/qda/Makefile b/drivers/accel/qda/Makefile
> index f547398e1a72..88c324fa382c 100644
> --- a/drivers/accel/qda/Makefile
> +++ b/drivers/accel/qda/Makefile
> @@ -11,5 +11,7 @@ qda-y := \
>  	qda_cb.o \
>  	qda_memory_manager.o \
>  	qda_ioctl.o \
> +	qda_gem.o \
> +	qda_memory_dma.o \
>  
>  obj-$(CONFIG_DRM_ACCEL_QDA_COMPUTE_BUS) += qda_compute_bus.o
> diff --git a/drivers/accel/qda/qda_drv.c b/drivers/accel/qda/qda_drv.c
> index 86758a9cd982..19798359b14e 100644
> --- a/drivers/accel/qda/qda_drv.c
> +++ b/drivers/accel/qda/qda_drv.c
> @@ -15,7 +15,7 @@
>  #include "qda_ioctl.h"
>  #include "qda_rpmsg.h"
>  
> -static struct qda_drm_priv *get_drm_priv_from_device(struct drm_device *dev)
> +struct qda_drm_priv *get_drm_priv_from_device(struct drm_device *dev)

And this is a namespace leak. Please name all your functions in a
selected style (qda_foo()).

>  {
>  	if (!dev)
>  		return NULL;
> @@ -88,6 +88,7 @@ static int qda_open(struct drm_device *dev, struct drm_file *file)
>  		return -ENOMEM;
>  
>  	qda_file_priv->pid = current->pid;
> +	qda_file_priv->assigned_iommu_dev = NULL; /* Will be assigned on first allocation */

Why?  Also, isn't qda_file_priv zero-filled?

>  
>  	qda_user = alloc_qda_user(qdev);
>  	if (!qda_user) {
> @@ -118,6 +119,26 @@ static void qda_postclose(struct drm_device *dev, struct drm_file *file)
>  
>  	qda_file_priv = (struct qda_file_priv *)file->driver_priv;
>  	if (qda_file_priv) {

Cant it be NULL? When?

> +		if (qda_file_priv->assigned_iommu_dev) {
> +			struct qda_iommu_device *iommu_dev = qda_file_priv->assigned_iommu_dev;
> +			unsigned long flags;
> +
> +			/* Decrement reference count - if it reaches 0, reset PID assignment */
> +			if (refcount_dec_and_test(&iommu_dev->refcount)) {
> +				/* Last reference released - reset PID assignment */
> +				spin_lock_irqsave(&iommu_dev->lock, flags);
> +				iommu_dev->assigned_pid = 0;

This is the part that needs to be discussed in the commit message
instead of a generic description of the patch. What is assigned_pid /
assigned_iommu_dev? Why do they need to be assigned?

> +				iommu_dev->assigned_file_priv = NULL;
> +				spin_unlock_irqrestore(&iommu_dev->lock, flags);
> +
> +				qda_dbg(qdev, "Reset PID assignment for IOMMU device %u (process %d exited)\n",
> +					iommu_dev->id, qda_file_priv->pid);
> +			} else {
> +				qda_dbg(qdev, "Decremented reference for IOMMU device %u from process %d\n",
> +					iommu_dev->id, qda_file_priv->pid);
> +			}
> +		}
> +
>  		qda_user = qda_file_priv->qda_user;
>  		if (qda_user)
>  			free_qda_user(qda_user);
> diff --git a/drivers/accel/qda/qda_drv.h b/drivers/accel/qda/qda_drv.h
> index e0ba37702a86..8a2cd474958b 100644
> --- a/drivers/accel/qda/qda_drv.h
> +++ b/drivers/accel/qda/qda_drv.h
> @@ -33,6 +33,8 @@ struct qda_file_priv {
>  	pid_t pid;
>  	/* Pointer to qda_user structure for backward compatibility */
>  	struct qda_user *qda_user;
> +	/* IOMMU device assigned to this process */
> +	struct qda_iommu_device *assigned_iommu_dev;
>  };
>  
>  /**
> @@ -153,4 +155,9 @@ void qda_deinit_device(struct qda_dev *qdev);
>  int qda_register_device(struct qda_dev *qdev);
>  void qda_unregister_device(struct qda_dev *qdev);
>  
> +/*
> + * Utility function to get DRM private data from DRM device
> + */
> +struct qda_drm_priv *get_drm_priv_from_device(struct drm_device *dev);
> +
>  #endif /* __QDA_DRV_H__ */
> diff --git a/drivers/accel/qda/qda_gem.c b/drivers/accel/qda/qda_gem.c
> new file mode 100644
> index 000000000000..bbd54e2502d3
> --- /dev/null
> +++ b/drivers/accel/qda/qda_gem.c
> @@ -0,0 +1,187 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> +#include <drm/drm_gem.h>
> +#include <drm/drm_prime.h>
> +#include <linux/slab.h>
> +#include <linux/dma-mapping.h>
> +#include "qda_drv.h"
> +#include "qda_gem.h"
> +#include "qda_memory_manager.h"
> +#include "qda_memory_dma.h"
> +
> +static int validate_gem_obj_for_mmap(struct qda_gem_obj *qda_gem_obj)
> +{
> +	if (qda_gem_obj->size == 0) {
> +		qda_err(NULL, "Invalid GEM object size\n");
> +		return -EINVAL;
> +	}
> +	if (!qda_gem_obj->iommu_dev || !qda_gem_obj->iommu_dev->dev) {
> +		qda_err(NULL, "Allocated buffer missing IOMMU device\n");
> +		return -EINVAL;
> +	}
> +	if (!qda_gem_obj->iommu_dev->dev) {
> +		qda_err(NULL, "Allocated buffer missing IOMMU device\n");
> +		return -EINVAL;
> +	}
> +	if (!qda_gem_obj->virt) {
> +		qda_err(NULL, "Allocated buffer missing virtual address\n");
> +		return -EINVAL;
> +	}
> +	if (qda_gem_obj->dma_addr == 0) {
> +		qda_err(NULL, "Allocated buffer missing DMA address\n");
> +		return -EINVAL;
> +	}

Is any of these conditions real?

> +
> +	return 0;
> +}
> +
> +static int validate_vma_offset(struct drm_gem_object *drm_obj, struct vm_area_struct *vma)
> +{
> +	u64 expected_offset = drm_vma_node_offset_addr(&drm_obj->vma_node);
> +	u64 actual_offset = vma->vm_pgoff << PAGE_SHIFT;
> +
> +	if (actual_offset != expected_offset) {

What??

> +		qda_err(NULL, "VMA offset mismatch: expected=0x%llx, actual=0x%llx\n",
> +			expected_offset, actual_offset);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static void setup_vma_flags(struct vm_area_struct *vma)
> +{
> +	vm_flags_set(vma, VM_DONTEXPAND);
> +	vm_flags_set(vma, VM_DONTDUMP);
> +}
> +
> +void qda_gem_free_object(struct drm_gem_object *gem_obj)
> +{
> +	struct qda_gem_obj *qda_gem_obj = to_qda_gem_obj(gem_obj);
> +	struct qda_drm_priv *drm_priv = get_drm_priv_from_device(gem_obj->dev);
> +
> +	if (qda_gem_obj->virt) {
> +		if (drm_priv && drm_priv->iommu_mgr)
> +			qda_memory_manager_free(drm_priv->iommu_mgr, qda_gem_obj);
> +	}
> +
> +	drm_gem_object_release(gem_obj);
> +	kfree(qda_gem_obj);
> +}
> +
> +int qda_gem_mmap_obj(struct drm_gem_object *drm_obj, struct vm_area_struct *vma)
> +{
> +	struct qda_gem_obj *qda_gem_obj = to_qda_gem_obj(drm_obj);
> +	int ret;
> +
> +	ret = validate_gem_obj_for_mmap(qda_gem_obj);
> +	if (ret) {
> +		qda_err(NULL, "GEM object validation failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = validate_vma_offset(drm_obj, vma);
> +	if (ret) {
> +		qda_err(NULL, "VMA offset validation failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Reset vm_pgoff for DMA mmap */
> +	vma->vm_pgoff = 0;
> +
> +	ret = qda_dma_mmap(qda_gem_obj, vma);
> +
> +	if (ret == 0) {
> +		setup_vma_flags(vma);
> +		qda_dbg(NULL, "GEM object mapped successfully\n");
> +	} else {
> +		qda_err(NULL, "GEM object mmap failed: %d\n", ret);
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct drm_gem_object_funcs qda_gem_object_funcs = {
> +	.free = qda_gem_free_object,
> +	.mmap = qda_gem_mmap_obj,
> +};
> +
> +struct qda_gem_obj *qda_gem_alloc_object(struct drm_device *drm_dev, size_t aligned_size)
> +{
> +	struct qda_gem_obj *qda_gem_obj;
> +	int ret;
> +
> +	qda_gem_obj = kzalloc_obj(*qda_gem_obj, GFP_KERNEL);
> +	if (!qda_gem_obj)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ret = drm_gem_object_init(drm_dev, &qda_gem_obj->base, aligned_size);
> +	if (ret) {
> +		qda_err(NULL, "Failed to initialize GEM object: %d\n", ret);
> +		kfree(qda_gem_obj);
> +		return ERR_PTR(ret);
> +	}
> +
> +	qda_gem_obj->base.funcs = &qda_gem_object_funcs;
> +	qda_gem_obj->size = aligned_size;
> +
> +	qda_dbg(NULL, "Allocated GEM object size=%zu\n", aligned_size);
> +	return qda_gem_obj;
> +}
> +
> +void qda_gem_cleanup_object(struct qda_gem_obj *qda_gem_obj)
> +{
> +	drm_gem_object_release(&qda_gem_obj->base);
> +	kfree(qda_gem_obj);
> +}
> +
> +struct drm_gem_object *qda_gem_lookup_object(struct drm_file *file_priv, u32 handle)
> +{
> +	struct drm_gem_object *gem_obj;
> +
> +	gem_obj = drm_gem_object_lookup(file_priv, handle);
> +	if (!gem_obj)
> +		return ERR_PTR(-ENOENT);
> +
> +	return gem_obj;
> +}
> +
> +int qda_gem_create_handle(struct drm_file *file_priv, struct drm_gem_object *gem_obj, u32 *handle)
> +{
> +	int ret;
> +
> +	ret = drm_gem_handle_create(file_priv, gem_obj, handle);
> +	drm_gem_object_put(gem_obj);
> +
> +	return ret;
> +}
> +
> +struct drm_gem_object *qda_gem_create_object(struct drm_device *drm_dev,
> +					     struct qda_memory_manager *iommu_mgr, size_t size,
> +					     struct drm_file *file_priv)
> +{
> +	struct qda_gem_obj *qda_gem_obj;
> +	size_t aligned_size;
> +	int ret;
> +
> +	if (size == 0) {
> +		qda_err(NULL, "Invalid size for GEM object creation\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	aligned_size = PAGE_ALIGN(size);
> +
> +	qda_gem_obj = qda_gem_alloc_object(drm_dev, aligned_size);
> +	if (IS_ERR(qda_gem_obj))
> +		return (struct drm_gem_object *)qda_gem_obj;
> +
> +	ret = qda_memory_manager_alloc(iommu_mgr, qda_gem_obj, file_priv);
> +	if (ret) {
> +		qda_err(NULL, "Memory manager allocation failed: %d\n", ret);
> +		qda_gem_cleanup_object(qda_gem_obj);
> +		return ERR_PTR(ret);
> +	}
> +
> +	qda_dbg(NULL, "GEM object created successfully size=%zu\n", aligned_size);
> +	return &qda_gem_obj->base;
> +}
> diff --git a/drivers/accel/qda/qda_gem.h b/drivers/accel/qda/qda_gem.h
> new file mode 100644
> index 000000000000..caae9cda5363
> --- /dev/null
> +++ b/drivers/accel/qda/qda_gem.h
> @@ -0,0 +1,63 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +#ifndef _QDA_GEM_H
> +#define _QDA_GEM_H
> +
> +#include <linux/xarray.h>
> +#include <drm/drm_device.h>
> +#include <drm/drm_gem.h>
> +#include <linux/dma-mapping.h>
> +
> +/* Forward declarations */
> +struct qda_memory_manager;
> +struct qda_iommu_device;
> +
> +/**
> + * struct qda_gem_obj - QDA GEM buffer object
> + *
> + * This structure represents a GEM buffer object that can be either
> + * allocated by the driver or imported from another driver via dma-buf.
> + */
> +struct qda_gem_obj {
> +	/* DRM GEM object base structure */
> +	struct drm_gem_object base;
> +	/* Kernel virtual address of allocated memory */
> +	void *virt;
> +	/* DMA address for allocated buffers */
> +	dma_addr_t dma_addr;
> +	/* Size of the buffer in bytes */
> +	size_t size;
> +	/* IOMMU device that performed the allocation */
> +	struct qda_iommu_device *iommu_dev;
> +};
> +
> +/*
> + * Helper macro to cast a drm_gem_object to qda_gem_obj
> + */
> +#define to_qda_gem_obj(gem_obj) container_of(gem_obj, struct qda_gem_obj, base)
> +
> +/*
> + * GEM object lifecycle management
> + */
> +struct drm_gem_object *qda_gem_create_object(struct drm_device *drm_dev,
> +					     struct qda_memory_manager *iommu_mgr,
> +					     size_t size, struct drm_file *file_priv);
> +void qda_gem_free_object(struct drm_gem_object *gem_obj);
> +int qda_gem_mmap_obj(struct drm_gem_object *gem_obj, struct vm_area_struct *vma);
> +
> +/*
> + * Helper functions for GEM object allocation and cleanup
> + * These are used internally and by the PRIME import code
> + */
> +struct qda_gem_obj *qda_gem_alloc_object(struct drm_device *drm_dev, size_t aligned_size);
> +void qda_gem_cleanup_object(struct qda_gem_obj *qda_gem_obj);
> +
> +/*
> + * Utility functions for GEM operations
> + */
> +struct drm_gem_object *qda_gem_lookup_object(struct drm_file *file_priv, u32 handle);
> +int qda_gem_create_handle(struct drm_file *file_priv, struct drm_gem_object *gem_obj, u32 *handle);
> +
> +#endif /* _QDA_GEM_H */
> diff --git a/drivers/accel/qda/qda_memory_dma.c b/drivers/accel/qda/qda_memory_dma.c
> new file mode 100644
> index 000000000000..ffdd5423c88c
> --- /dev/null
> +++ b/drivers/accel/qda/qda_memory_dma.c
> @@ -0,0 +1,91 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> +#include <linux/slab.h>
> +#include <linux/dma-mapping.h>
> +#include "qda_drv.h"
> +#include "qda_memory_dma.h"
> +
> +static dma_addr_t get_actual_dma_addr(struct qda_gem_obj *gem_obj)
> +{
> +	return gem_obj->dma_addr - ((u64)gem_obj->iommu_dev->sid << 32);
> +}
> +
> +static void setup_gem_object(struct qda_gem_obj *gem_obj, void *virt,
> +			     dma_addr_t dma_addr, struct qda_iommu_device *iommu_dev)
> +{
> +	gem_obj->virt = virt;
> +	gem_obj->dma_addr = dma_addr;
> +	gem_obj->iommu_dev = iommu_dev;
> +}
> +
> +static void cleanup_gem_object_fields(struct qda_gem_obj *gem_obj)
> +{
> +	gem_obj->virt = NULL;
> +	gem_obj->dma_addr = 0;
> +	gem_obj->iommu_dev = NULL;
> +}
> +
> +int qda_dma_alloc(struct qda_iommu_device *iommu_dev,
> +		  struct qda_gem_obj *gem_obj, size_t size)
> +{
> +	void *virt;
> +	dma_addr_t dma_addr;
> +
> +	if (!iommu_dev || !iommu_dev->dev) {
> +		qda_err(NULL, "Invalid iommu_dev or device for DMA allocation\n");
> +		return -EINVAL;
> +	}
> +
> +	virt = dma_alloc_coherent(iommu_dev->dev, size, &dma_addr, GFP_KERNEL);
> +	if (!virt)
> +		return -ENOMEM;
> +
> +	dma_addr += ((u64)iommu_dev->sid << 32);
> +
> +	qda_dbg(NULL, "DMA address with SID prefix: 0x%llx (sid=%u)\n",
> +		(u64)dma_addr, iommu_dev->sid);
> +
> +	setup_gem_object(gem_obj, virt, dma_addr, iommu_dev);
> +
> +	return 0;
> +}
> +
> +void qda_dma_free(struct qda_gem_obj *gem_obj)
> +{
> +	if (!gem_obj || !gem_obj->iommu_dev) {
> +		qda_dbg(NULL, "Invalid gem_obj or iommu_dev for DMA free\n");
> +		return;
> +	}
> +
> +	qda_dbg(NULL, "DMA freeing: size=%zu, device_id=%u, dma_addr=0x%llx\n",
> +		gem_obj->size, gem_obj->iommu_dev->id, gem_obj->dma_addr);
> +
> +	dma_free_coherent(gem_obj->iommu_dev->dev, gem_obj->size,
> +			  gem_obj->virt, get_actual_dma_addr(gem_obj));
> +
> +	cleanup_gem_object_fields(gem_obj);
> +}
> +
> +int qda_dma_mmap(struct qda_gem_obj *gem_obj, struct vm_area_struct *vma)
> +{
> +	struct qda_iommu_device *iommu_dev;
> +	int ret;
> +
> +	if (!gem_obj || !gem_obj->virt || !gem_obj->iommu_dev || !gem_obj->iommu_dev->dev) {
> +		qda_err(NULL, "Invalid parameters for DMA mmap\n");
> +		return -EINVAL;
> +	}
> +
> +	iommu_dev = gem_obj->iommu_dev;
> +
> +	ret = dma_mmap_coherent(iommu_dev->dev, vma, gem_obj->virt,
> +				get_actual_dma_addr(gem_obj), gem_obj->size);
> +
> +	if (ret)
> +		qda_err(NULL, "DMA mmap failed: size=%zu, device_id=%u, ret=%d\n",
> +			gem_obj->size, iommu_dev->id, ret);

if (ret) {
	qda_err();
	return ret;
	// or goto err_foo;
}

return 0;


> +	else
> +		qda_dbg(NULL, "DMA mmap successful: size=%zu\n", gem_obj->size);

It feels like the driver is over-verbose if debugging is enabled.

> +
> +	return ret;
> +}
> diff --git a/drivers/accel/qda/qda_memory_dma.h b/drivers/accel/qda/qda_memory_dma.h
> new file mode 100644
> index 000000000000..79b3c4053a82
> --- /dev/null
> +++ b/drivers/accel/qda/qda_memory_dma.h
> @@ -0,0 +1,46 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#ifndef _QDA_MEMORY_DMA_H
> +#define _QDA_MEMORY_DMA_H
> +
> +#include <linux/dma-mapping.h>
> +#include "qda_memory_manager.h"
> +
> +/**
> + * qda_dma_alloc() - Allocate DMA coherent memory for a GEM object
> + * @iommu_dev: Pointer to the QDA IOMMU device structure
> + * @gem_obj: Pointer to GEM object to allocate memory for
> + * @size: Size of memory to allocate in bytes
> + *
> + * Allocates DMA-coherent memory and sets up the GEM object with the
> + * allocated memory details including virtual and DMA addresses.
> + *
> + * Return: 0 on success, negative error code on failure
> + */

Move the kerneldoc from the headers to the driver code, otherwise they
are mostly ignored by the automatic validators.

> +int qda_dma_alloc(struct qda_iommu_device *iommu_dev,
> +		  struct qda_gem_obj *gem_obj, size_t size);
> +
> +/**
> + * qda_dma_free() - Free DMA coherent memory for a GEM object
> + * @gem_obj: Pointer to GEM object to free memory for
> + *
> + * Frees DMA-coherent memory previously allocated for the GEM object
> + * and cleans up the GEM object fields.
> + */
> +void qda_dma_free(struct qda_gem_obj *gem_obj);
> +
> +/**
> + * qda_dma_mmap() - Map DMA memory into userspace
> + * @gem_obj: Pointer to GEM object containing DMA memory
> + * @vma: Virtual memory area to map into
> + *
> + * Maps DMA-coherent memory into userspace virtual address space.
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +int qda_dma_mmap(struct qda_gem_obj *gem_obj, struct vm_area_struct *vma);
> +
> +#endif /* _QDA_MEMORY_DMA_H */
> diff --git a/drivers/accel/qda/qda_memory_manager.c b/drivers/accel/qda/qda_memory_manager.c
> index b4c7047a89d4..e225667557ee 100644
> --- a/drivers/accel/qda/qda_memory_manager.c
> +++ b/drivers/accel/qda/qda_memory_manager.c
> @@ -6,8 +6,11 @@
>  #include <linux/spinlock.h>
>  #include <linux/workqueue.h>
>  #include <linux/xarray.h>
> +#include <drm/drm_file.h>
>  #include "qda_drv.h"
> +#include "qda_gem.h"
>  #include "qda_memory_manager.h"
> +#include "qda_memory_dma.h"
>  
>  static void cleanup_all_memory_devices(struct qda_memory_manager *mem_mgr)
>  {
> @@ -55,6 +58,8 @@ static void init_iommu_device_fields(struct qda_iommu_device *iommu_dev,
>  	spin_lock_init(&iommu_dev->lock);
>  	refcount_set(&iommu_dev->refcount, 0);
>  	INIT_WORK(&iommu_dev->remove_work, qda_memory_manager_remove_work);
> +	iommu_dev->assigned_pid = 0;
> +	iommu_dev->assigned_file_priv = NULL;
>  }
>  
>  static int allocate_device_id(struct qda_memory_manager *mem_mgr,
> @@ -78,6 +83,194 @@ static int allocate_device_id(struct qda_memory_manager *mem_mgr,
>  	return ret;
>  }
>  
> +static struct qda_iommu_device *find_device_for_pid(struct qda_memory_manager *mem_mgr,
> +						    pid_t pid)
> +{
> +	unsigned long index;
> +	void *entry;
> +	struct qda_iommu_device *found_dev = NULL;
> +	unsigned long flags;
> +
> +	xa_lock(&mem_mgr->device_xa);
> +	xa_for_each(&mem_mgr->device_xa, index, entry) {
> +		struct qda_iommu_device *iommu_dev = entry;
> +
> +		spin_lock_irqsave(&iommu_dev->lock, flags);
> +		if (iommu_dev->assigned_pid == pid) {
> +			found_dev = iommu_dev;
> +			refcount_inc(&found_dev->refcount);
> +			qda_dbg(NULL, "Reusing device id=%u for PID=%d (refcount=%u)\n",
> +				found_dev->id, pid, refcount_read(&found_dev->refcount));

And what if there are two different FastRPC sessions within the same
PID?

> +			spin_unlock_irqrestore(&iommu_dev->lock, flags);
> +			break;
> +		}
> +		spin_unlock_irqrestore(&iommu_dev->lock, flags);
> +	}
> +	xa_unlock(&mem_mgr->device_xa);
> +
> +	return found_dev;
> +}
> +
> +static struct qda_iommu_device *assign_available_device_to_pid(struct qda_memory_manager *mem_mgr,
> +							       pid_t pid,
> +							       struct drm_file *file_priv)
> +{
> +	unsigned long index;
> +	void *entry;
> +	struct qda_iommu_device *selected_dev = NULL;
> +	unsigned long flags;
> +
> +	xa_lock(&mem_mgr->device_xa);
> +	xa_for_each(&mem_mgr->device_xa, index, entry) {
> +		struct qda_iommu_device *iommu_dev = entry;
> +
> +		spin_lock_irqsave(&iommu_dev->lock, flags);
> +		if (iommu_dev->assigned_pid == 0) {
> +			iommu_dev->assigned_pid = pid;
> +			iommu_dev->assigned_file_priv = file_priv;
> +			selected_dev = iommu_dev;
> +			refcount_set(&selected_dev->refcount, 1);
> +			qda_dbg(NULL, "Assigned device id=%u to PID=%d\n",
> +				selected_dev->id, pid);
> +			spin_unlock_irqrestore(&iommu_dev->lock, flags);
> +			break;
> +		}
> +		spin_unlock_irqrestore(&iommu_dev->lock, flags);
> +	}
> +	xa_unlock(&mem_mgr->device_xa);
> +
> +	return selected_dev;
> +}
> +
> +static struct qda_iommu_device *get_process_iommu_device(struct qda_memory_manager *mem_mgr,
> +							 struct drm_file *file_priv)
> +{
> +	struct qda_file_priv *qda_priv;
> +
> +	if (!file_priv || !file_priv->driver_priv)
> +		return NULL;
> +
> +	qda_priv = (struct qda_file_priv *)file_priv->driver_priv;
> +	return qda_priv->assigned_iommu_dev;
> +}
> +
> +static int qda_memory_manager_assign_device(struct qda_memory_manager *mem_mgr,
> +					    struct drm_file *file_priv)
> +{
> +	struct qda_file_priv *qda_priv;
> +	struct qda_iommu_device *selected_dev = NULL;
> +	int ret = 0;
> +	pid_t current_pid;
> +
> +	if (!file_priv || !file_priv->driver_priv) {
> +		qda_err(NULL, "Invalid file_priv or driver_priv\n");
> +		return -EINVAL;
> +	}
> +
> +	qda_priv = (struct qda_file_priv *)file_priv->driver_priv;
> +	current_pid = qda_priv->pid;
> +
> +	mutex_lock(&mem_mgr->process_assignment_lock);
> +
> +	if (qda_priv->assigned_iommu_dev) {
> +		qda_dbg(NULL, "PID=%d already has device id=%u assigned\n",
> +			current_pid, qda_priv->assigned_iommu_dev->id);
> +		ret = 0;
> +		goto unlock_and_return;
> +	}
> +
> +	selected_dev = find_device_for_pid(mem_mgr, current_pid);
> +
> +	if (selected_dev) {
> +		qda_priv->assigned_iommu_dev = selected_dev;
> +		goto unlock_and_return;
> +	}
> +
> +	selected_dev = assign_available_device_to_pid(mem_mgr, current_pid, file_priv);
> +
> +	if (!selected_dev) {
> +		qda_err(NULL, "No available device for PID=%d\n", current_pid);
> +		ret = -ENOMEM;
> +		goto unlock_and_return;
> +	}
> +
> +	qda_priv->assigned_iommu_dev = selected_dev;
> +
> +unlock_and_return:
> +	mutex_unlock(&mem_mgr->process_assignment_lock);
> +	return ret;
> +}
> +
> +static struct qda_iommu_device *get_or_assign_iommu_device(struct qda_memory_manager *mem_mgr,
> +							   struct drm_file *file_priv,
> +							   size_t size)
> +{
> +	struct qda_iommu_device *iommu_dev;
> +	int ret;
> +
> +	iommu_dev = get_process_iommu_device(mem_mgr, file_priv);
> +	if (iommu_dev)
> +		return iommu_dev;
> +
> +	ret = qda_memory_manager_assign_device(mem_mgr, file_priv);
> +	if (ret)
> +		return NULL;
> +
> +	iommu_dev = get_process_iommu_device(mem_mgr, file_priv);
> +	if (iommu_dev)
> +		return iommu_dev;
> +
> +	return NULL;
> +}
> +
> +int qda_memory_manager_alloc(struct qda_memory_manager *mem_mgr, struct qda_gem_obj *gem_obj,
> +			     struct drm_file *file_priv)
> +{
> +	struct qda_iommu_device *selected_dev;
> +	size_t size;
> +	int ret;
> +
> +	if (!mem_mgr || !gem_obj || !file_priv) {
> +		qda_err(NULL, "Invalid parameters for memory allocation\n");
> +		return -EINVAL;
> +	}
> +
> +	size = gem_obj->size;
> +	if (size == 0) {
> +		qda_err(NULL, "Invalid allocation size: 0\n");
> +		return -EINVAL;
> +	}
> +
> +	selected_dev = get_or_assign_iommu_device(mem_mgr, file_priv, size);
> +
> +	if (!selected_dev) {
> +		qda_err(NULL, "Failed to get/assign device for allocation (size=%zu)\n", size);
> +		return -ENOMEM;
> +	}
> +
> +	ret = qda_dma_alloc(selected_dev, gem_obj, size);
> +
> +	if (ret) {
> +		qda_err(NULL, "Allocation failed: size=%zu, device_id=%u, ret=%d\n",
> +			size, selected_dev->id, ret);
> +		return ret;
> +	}
> +
> +	qda_dbg(NULL, "Successfully allocated: size=%zu, device_id=%u, dma_addr=0x%llx\n",
> +		size, selected_dev->id, gem_obj->dma_addr);
> +	return 0;
> +}
> +
> +void qda_memory_manager_free(struct qda_memory_manager *mem_mgr, struct qda_gem_obj *gem_obj)
> +{
> +	if (!gem_obj || !gem_obj->iommu_dev) {
> +		qda_dbg(NULL, "Invalid gem_obj or iommu_dev for free\n");
> +		return;
> +	}
> +
> +	qda_dma_free(gem_obj);
> +}
> +
>  int qda_memory_manager_register_device(struct qda_memory_manager *mem_mgr,
>  				       struct qda_iommu_device *iommu_dev)
>  {
> @@ -134,6 +327,7 @@ int qda_memory_manager_init(struct qda_memory_manager *mem_mgr)
>  
>  	xa_init_flags(&mem_mgr->device_xa, XA_FLAGS_ALLOC);
>  	atomic_set(&mem_mgr->next_id, 0);
> +	mutex_init(&mem_mgr->process_assignment_lock);
>  	mem_mgr->wq = create_workqueue("memory_manager_wq");
>  	if (!mem_mgr->wq) {
>  		qda_err(NULL, "Failed to create memory manager workqueue\n");
> diff --git a/drivers/accel/qda/qda_memory_manager.h b/drivers/accel/qda/qda_memory_manager.h
> index 3bf4cd529909..bac44284ef98 100644
> --- a/drivers/accel/qda/qda_memory_manager.h
> +++ b/drivers/accel/qda/qda_memory_manager.h
> @@ -11,6 +11,8 @@
>  #include <linux/spinlock.h>
>  #include <linux/workqueue.h>
>  #include <linux/xarray.h>
> +#include <drm/drm_file.h>
> +#include "qda_gem.h"
>  
>  /**
>   * struct qda_iommu_device - IOMMU device instance for memory management
> @@ -35,6 +37,10 @@ struct qda_iommu_device {
>  	u32 sid;
>  	/* Pointer to parent memory manager */
>  	struct qda_memory_manager *manager;
> +	/* Process ID of the process assigned to this device */
> +	pid_t assigned_pid;
> +	/* DRM file private data for the assigned process */
> +	struct drm_file *assigned_file_priv;
>  };
>  
>  /**
> @@ -51,6 +57,8 @@ struct qda_memory_manager {
>  	atomic_t next_id;
>  	/* Workqueue for asynchronous device operations */
>  	struct workqueue_struct *wq;
> +	/* Mutex protecting process-to-device assignments */
> +	struct mutex process_assignment_lock;
>  };
>  
>  /**
> @@ -98,4 +106,29 @@ int qda_memory_manager_register_device(struct qda_memory_manager *mem_mgr,
>  void qda_memory_manager_unregister_device(struct qda_memory_manager *mem_mgr,
>  					  struct qda_iommu_device *iommu_dev);
>  
> +/**
> + * qda_memory_manager_alloc() - Allocate memory for a GEM object
> + * @mem_mgr: Pointer to memory manager
> + * @gem_obj: Pointer to GEM object to allocate memory for
> + * @file_priv: DRM file private data for process association
> + *
> + * Allocates memory for the specified GEM object using an appropriate IOMMU
> + * device. The allocation is associated with the calling process via
> + * file_priv.
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +int qda_memory_manager_alloc(struct qda_memory_manager *mem_mgr, struct qda_gem_obj *gem_obj,
> +			     struct drm_file *file_priv);
> +
> +/**
> + * qda_memory_manager_free() - Free memory for a GEM object
> + * @mem_mgr: Pointer to memory manager
> + * @gem_obj: Pointer to GEM object to free memory for
> + *
> + * Releases memory previously allocated for the specified GEM object and
> + * removes any associated IOMMU mappings.
> + */
> +void qda_memory_manager_free(struct qda_memory_manager *mem_mgr, struct qda_gem_obj *gem_obj);
> +
>  #endif /* _QDA_MEMORY_MANAGER_H */
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
