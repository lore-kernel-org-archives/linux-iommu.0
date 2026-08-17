Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2783B3C1B
	for <iommu@lists.linux.dev>; Mon, 17 Aug 2026 06:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786949563; cv=none; b=LWPukER2iXj4HypLYMWX0NjKA+8ReV2gAxCtCUYjO4fdmO1PPDUdRa4UYg98g0lyxUskjxUOzZis+8exI/V6sUWn2A1qdNa+2/NALL5TKcO/zBGLELi8Pq6xPL/4f93JEPxq4wKgh8wba5uGYECZ74u1U0Mnq4h6XeC4eBhJ5nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786949563; c=relaxed/simple;
	bh=yIVHWpmpue7JH9fPpIClnmCzbb9QXKZYSOjH+vcWCJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kiltmSGOPPnInOCKMiTt0Qyee+8bkEp9xGLM14nEfaiD5xkLgR4Q9+dLXijEBq2AKgU2S04ndaiFAfN1pgpGvbWy+zefYVB5j9NYLCg+Aby7NkfIQGYMPcviFGg7WbZk/WIrqy3G1Err+KJqHtkoyfiQ2k3lOGGPmuvdiLyfixc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VyvxB4hm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LASqhi0R; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VyvxB4hm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LASqhi0R"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67GLEY1f3308300
	for <iommu@lists.linux.dev>; Mon, 17 Aug 2026 06:52:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Ka8mIyw8X4rRBycNGAQC25Zs
	LU2GjsEt1aqcnQAe8a0=; b=VyvxB4hmXqtUmFbsCK9Tk+LlKIpR+TImY2YHgoDL
	Y5BVDzO7KOP2RoQ4x0q7pBl+jd250b05a5QFvjv6BmqaiwwssZp+e78JGd3E8mYA
	Eu3CE77STRlv+T0dA3h3S30SSar14jSKh00WUKtco4Jui2QGlmhtuNCXoh+d/Sy7
	TWGbVxkTT93VyhJqWHnWeQi6ewHtmURyS26zzun06+wfSvuQA7/B+ntc4b5YmQti
	4HVwDbWCaRb23RDxar8NkRxxP2DLjjHrBckzrNhkBhs+w9P3qnoBa6ysoH6Zzg3S
	lExRcPYnjB06Nqq1SxmKwtYYU3lNBu8v6k4qUtu1t7Zyog==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghq5m4c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 17 Aug 2026 06:52:39 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-933023a5980so525281185a.3
        for <iommu@lists.linux.dev>; Sun, 16 Aug 2026 23:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786949559; x=1787554359; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ka8mIyw8X4rRBycNGAQC25ZsLU2GjsEt1aqcnQAe8a0=;
        b=LASqhi0RMtfGdHNttkhC6ojZIFWLBdMpSIQpEfZjMmo2qk+G3cbHpG+JtsOAIpaWmP
         X3/U6ZbXc33gn4yFXBfM19U3Q+NcsH0eWEiNnbphoor2Rm168nTluUK5OZobO0ON/tVO
         0IqMQtFNkZUJAjEA4zYjCu6R9neEzaypOeCSglAlAjIejTRU+k2+wM4O6WdDV24CQCnd
         v9+WHBZ7syv6rrfgW0tGlnz1IzmSH2NSSUw8I3Ugd8bJlhcOUO4WIqBR3S86pG12qrOn
         AIEo6Ax3j28axbwRBeg38ewoFyX0xfs8GufKeui55PLHdvnGckr77YhP9DOm9ZOY17J1
         RTkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786949559; x=1787554359;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ka8mIyw8X4rRBycNGAQC25ZsLU2GjsEt1aqcnQAe8a0=;
        b=GP4D0PrdEtiTYg0+XQ6W68WWPnRJOFwc+DFJGUs2XIvhpaAuaUVHnGrWZBK/fYG50H
         jvu/IFAgWUKacu/eJ61JbJvYAbPYe72Z/PMQsw0hlBZngERvIUNfzuH4bYznzA/zQDJi
         O30BOakLzsgaEVr19gh8ba5Eqr3WVrFd1y4giEINXwIE1LAAGB808eASZ21nqcGMtQPr
         WhMdkjHh7I055tmo7YLM8+FYWt1mpI6a/IKI0u1jo8qT3qVnqu2gV2SUz0BsL0KIrgRV
         x3/hlxt9UjOZSCQATT4ZXZvX7ml/8uPw7T60pPqLSiYxsipj9N14bU46kRBIbelXFVfX
         pFfg==
X-Forwarded-Encrypted: i=1; AHgh+Rp2bbV9Jvk2eNbmt0hHGawdZKLwh7Mey4HXuJiU+o30qXqn0ZtThLsy95UcUb5KPFmzeAIV4g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzHpQa+jlEmuJ8kPGhBnlGKLY3BHKNZY44eJpJSUdtdahXbZAiw
	ysCkvEFogNKhBWpnUV0PqMaf0uVFwc1NlYw1uJ/tGm/c1e1DiveotQJZhqmnfdGRSUR8dzMNqnl
	o1XUilaZJ8S/SAO57KI/TZZn8JWtDDaI/Z3uMrgSKlwe0H/Z9EvoTc3ozNQ==
X-Gm-Gg: AR+sD10AM6R5wdUtm5E34KSvP+lrGG01YvzAEm2/lPiCbjfqG0Pdo0go0IVx3fSznMW
	otKfT5uuR9tS6afDBOpT+sjhC3o9PgwjFwyvUpwBFfBD+yff/JT0lkkUxA2fTyW4qZHsX/5bRTI
	/LRGuO4Dz7CgqNcE8H8wk2nFyv9XhMz03zF1SPX2MN+TCb4bAAtaH2Llvnr61kyQyvPm++XdcD/
	HnpWMYiowfw4NyV7JGYIPAbdW+j3KIEa+WkBY7PEB8Jm+tuQS7Hi5tYF1daOuy+1vNtLbjDs2t5
	HWJNabdtrxuzaercCMS4ZnfqDPufhqQ315WAeTiDSvJpbkJ0fCPgHlGO1yK9xPPlET6vgLUP9U6
	M6+EmbvS+NDON3mSnJHIS4T63FlpglJdrm6p8ICumvFSN6XGwM+13jRhQvDzmrKFieVwf7v8/kB
	bpYh0ZVl0brgTr
X-Received: by 2002:a05:620a:8215:b0:934:a2f0:33c1 with SMTP id af79cd13be357-936d235d4e0mr1735228185a.33.1786949558706;
        Sun, 16 Aug 2026 23:52:38 -0700 (PDT)
X-Received: by 2002:a05:620a:8215:b0:934:a2f0:33c1 with SMTP id af79cd13be357-936d235d4e0mr1735223185a.33.1786949558027;
        Sun, 16 Aug 2026 23:52:38 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a16b1f23dbsm1912601fa.39.2026.08.16.23.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 23:52:36 -0700 (PDT)
Date: Mon, 17 Aug 2026 09:52:33 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Bharath Kumar <quic_bkumar@quicinc.com>,
        Chenna Kesava Raju <quic_chennak@quicinc.com>,
        srinivas.kandagatla@oss.qualcomm.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, llvm@lists.linux.dev,
        iommu@lists.linux.dev, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v2 07/15] accel/qda: Add memory manager for CB devices
Message-ID: <wt2pdo3m3nlhvyofuvbsqnvggywx75ucs65vjt3dzrxkrpgztz@xwwlhq2iuiun>
References: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
 <20260817-qda-v2-v2-7-69a02e9090d4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817-qda-v2-v2-7-69a02e9090d4@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA1MCBTYWx0ZWRfX+kl97DtuOXko
 c7k1yvnQJa7k3Wn7SwjRu4TF+LgNtXn6juHidRtPrnzjuJMW7JlDzEjMeo45l/FTHa3saeRyxRu
 C3vs9Wp7xRQ51liXFs6fmdtvyMtVQUyK5ubf6p543LGV2Lfr7ZqeAR6prrxik12fiTIc2IIZhL4
 yN1onbgi9n7tqkCp0rgBz4ssHQJcdz4pY6CylXNTlmvY81q7J2KAaNk6377lpO6l/QKpNjqS511
 FXx+2WNbkIYZsG/oodF8b7UCzGvzZfIp0Y54tc1YeMHnCTijnQLFb6zO6JzqVjdLyfjGQnS5Qxv
 ws6gy54aJ4U4hV+NSHIzUKXw/Dsw6bkPHm4F1kYlhgXEXU7h7ZnhEKofhbQruGjso4H/w8JBah6
 Y9bMUQLljqA5yuNmQmMsJF6Qn4BlcuhR1PCCMfErvwYhPAh3OHt3XoMDGUBBBQeNsCeOCentZ3p
 vmmn4+w3fgiOJ7GJQ8Q==
X-Proofpoint-ORIG-GUID: sCdjBj1D8ICiSqzFLAMreBbbs1C_UTAC
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA1MCBTYWx0ZWRfXydyJKwSmlNNF
 9emv2oJoCPxL8YTXgFVSZns9Y3r6gO9cT8mWCJVge2pzJOfgI3i1Sa/ctBh141Jg5sYhbFX99PF
 IzSrJduxypOSUNw9NvcAEQaAa6jUEmA=
X-Proofpoint-GUID: sCdjBj1D8ICiSqzFLAMreBbbs1C_UTAC
X-Authority-Analysis: v=2.4 cv=dvHrzVg4 c=1 sm=1 tr=0 ts=6a82afb7 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=k3pNtizIBdZJHqWcwIQA:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170050

On Mon, Aug 17, 2026 at 10:17:42AM +0530, Ekansh Gupta wrote:
> Introduce the QDA memory manager (qda_memory_manager) to track the
> IOMMU devices that back each compute context bank (CB).
> 
> Each CB device registered on the qda-compute-cb bus is wrapped in a
> qda_iommu_device descriptor recording the device pointer and its stream
> ID, and stored in the memory manager's registry. Later patches use this
> registry to resolve the IOMMU device a session should allocate from.
> 
> The registry is a plain array sized to the number of
> "qcom,fastrpc-compute-cb" nodes present in the device tree: the RPMsg
> probe counts those nodes and passes the count to qda_init_device(),
> which allocates the array in qda_memory_manager_init(). The memory
> manager is created before CB devices are populated and destroyed after
> they are torn down, so no dangling descriptors remain.
> 
> qda_cb_setup_device() is called immediately after a CB device is
> registered on the bus: it allocates the descriptor, registers it with
> the memory manager, and stores it as the CB device's driver data so
> that qda_destroy_cb_device() can unregister and free it during teardown.
> 
> Assisted-by: Claude:claude-sonnet-5
> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> ---
> Changes in v2:
> - Replace the XArray with a plain array sized to the device tree's CB
>   node count instead of a fixed 16-entry table (Dmitry Baryshkov)
> - Fold the init_memory_manager()/cleanup_memory_manager() wrappers into
>   qda_init_device()/qda_deinit_device() (Dmitry Baryshkov)
> - Drop the pr_debug() calls (Dmitry Baryshkov)
> - Use goto labels to unwind probe failures instead of open-coding the
>   cleanup at each error site (Dmitry Baryshkov)
> ---
>  drivers/accel/qda/Makefile             |  1 +
>  drivers/accel/qda/qda_cb.c             | 39 ++++++++++++++
>  drivers/accel/qda/qda_drv.c            | 26 +++++++++
>  drivers/accel/qda/qda_drv.h            |  5 ++
>  drivers/accel/qda/qda_memory_manager.c | 98 ++++++++++++++++++++++++++++++++++
>  drivers/accel/qda/qda_memory_manager.h | 55 +++++++++++++++++++
>  drivers/accel/qda/qda_rpmsg.c          | 23 +++++++-
>  7 files changed, 246 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/accel/qda/Makefile b/drivers/accel/qda/Makefile
> index 143c9e4e789e..701fad5ffb50 100644
> --- a/drivers/accel/qda/Makefile
> +++ b/drivers/accel/qda/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_DRM_ACCEL_QDA)	:= qda.o
>  qda-y := \
>  	qda_cb.o \
>  	qda_drv.o \
> +	qda_memory_manager.o \
>  	qda_rpmsg.o
>  
>  obj-$(CONFIG_DRM_ACCEL_QDA_COMPUTE_BUS) += qda_compute_bus.o
> diff --git a/drivers/accel/qda/qda_cb.c b/drivers/accel/qda/qda_cb.c
> index 9c5ef32f351e..cd32d6df6318 100644
> --- a/drivers/accel/qda/qda_cb.c
> +++ b/drivers/accel/qda/qda_cb.c
> @@ -8,13 +8,40 @@
>  #include <linux/slab.h>
>  #include <drm/drm_print.h>
>  #include "qda_drv.h"
> +#include "qda_memory_manager.h"
>  #include "qda_cb.h"
>  
> +static int qda_cb_setup_device(struct qda_dev *qdev, struct device *cb_dev, u32 sid)
> +{
> +	struct qda_iommu_device *iommu_dev;
> +	int ret;
> +
> +	iommu_dev = kzalloc_obj(*iommu_dev);
> +	if (!iommu_dev)
> +		return -ENOMEM;
> +
> +	iommu_dev->dev = cb_dev;
> +	iommu_dev->qdev = qdev;
> +	iommu_dev->sid = sid;
> +
> +	ret = qda_memory_manager_register_device(qdev->iommu_mgr, iommu_dev);
> +	if (ret) {
> +		drm_err(&qdev->drm_dev, "Failed to register IOMMU device: %d\n", ret);
> +		kfree(iommu_dev);
> +		return ret;
> +	}
> +
> +	dev_set_drvdata(cb_dev, iommu_dev);
> +
> +	return 0;
> +}
> +
>  int qda_create_cb_device(struct qda_dev *qdev, struct device_node *cb_node)
>  {
>  	struct qda_cb_dev *entry;
>  	struct device *cb_dev;
>  	u32 sid = 0;
> +	int ret;
>  
>  	if (of_property_read_u32(cb_node, "reg", &sid))
>  		drm_info(&qdev->drm_dev, "No stream ID in DT node %pOFn, using 0\n", cb_node);
> @@ -27,6 +54,12 @@ int qda_create_cb_device(struct qda_dev *qdev, struct device_node *cb_node)
>  		return PTR_ERR(cb_dev);
>  	}
>  
> +	ret = qda_cb_setup_device(qdev, cb_dev, sid);
> +	if (ret) {
> +		device_unregister(cb_dev);
> +		return ret;
> +	}
> +
>  	entry = kzalloc_obj(*entry);
>  	if (!entry) {
>  		qda_destroy_cb_device(cb_dev);
> @@ -74,8 +107,14 @@ int qda_cb_populate(struct qda_dev *qdev, struct device_node *parent_node)
>  
>  void qda_destroy_cb_device(struct device *cb_dev)
>  {
> +	struct qda_iommu_device *iommu_dev;
>  	struct iommu_group *group;
>  
> +	iommu_dev = dev_get_drvdata(cb_dev);
> +	if (iommu_dev && iommu_dev->qdev->iommu_mgr)

Can either of them be NULL?

> +		qda_memory_manager_unregister_device(iommu_dev->qdev->iommu_mgr,
> +						     iommu_dev);
> +
>  	group = iommu_group_get(cb_dev);
>  	if (group) {
>  		iommu_group_remove_device(cb_dev);
> diff --git a/drivers/accel/qda/qda_drv.c b/drivers/accel/qda/qda_drv.c
> index 09b6d5ac390b..fdc909facd95 100644
> --- a/drivers/accel/qda/qda_drv.c
> +++ b/drivers/accel/qda/qda_drv.c
> @@ -56,6 +56,32 @@ struct qda_dev *qda_alloc_device(struct device *dev)
>  	return qdev;
>  }
>  
> +void qda_deinit_device(struct qda_dev *qdev)
> +{
> +	if (qdev->iommu_mgr) {

Why?

> +		qda_memory_manager_exit(qdev->iommu_mgr);
> +		kfree(qdev->iommu_mgr);
> +		qdev->iommu_mgr = NULL;

What for? If it's a teardown path, qdev will be destroyed soon.

> +	}
> +}
> +
> +int qda_init_device(struct qda_dev *qdev, int num_cbs)
> +{
> +	int ret;
> +
> +	qdev->iommu_mgr = kzalloc_obj(*qdev->iommu_mgr);

devm_kzalloc_obj()?

> +	if (!qdev->iommu_mgr)
> +		return -ENOMEM;
> +	ret = qda_memory_manager_init(qdev->iommu_mgr, num_cbs);
> +	if (ret) {
> +		drm_err(&qdev->drm_dev, "Failed to initialize memory manager: %d\n", ret);
> +		kfree(qdev->iommu_mgr);
> +		qdev->iommu_mgr = NULL;

And what is going to read this NULL?

> +	}
> +
> +	return ret;
> +}
> +
>  int qda_register_device(struct qda_dev *qdev)
>  {
>  	int ret;
> diff --git a/drivers/accel/qda/qda_drv.h b/drivers/accel/qda/qda_drv.h
> index 3bd41b9593fa..690a833d732b 100644
> --- a/drivers/accel/qda/qda_drv.h
> +++ b/drivers/accel/qda/qda_drv.h
> @@ -13,6 +13,7 @@
>  #include <drm/drm_device.h>
>  #include <drm/drm_drv.h>
>  #include <drm/drm_file.h>
> +#include "qda_memory_manager.h"
>  
>  /* Driver identification */
>  #define QDA_DRIVER_NAME "qda"
> @@ -40,6 +41,8 @@ struct qda_dev {
>  	struct device *dev;
>  	/** @cb_devs: Compute context-bank (CB) child devices */
>  	struct list_head cb_devs;
> +	/** @iommu_mgr: IOMMU/memory manager instance */
> +	struct qda_memory_manager *iommu_mgr;
>  	/** @dsp_name: Name of the DSP domain (e.g. "cdsp", "adsp") */
>  	const char *dsp_name;
>  };
> @@ -59,6 +62,8 @@ static inline struct qda_dev *qda_dev_from_drm(struct drm_device *dev)
>  struct qda_dev *qda_alloc_device(struct device *dev);
>  
>  /* Core device lifecycle */
> +int qda_init_device(struct qda_dev *qdev, int num_cbs);
> +void qda_deinit_device(struct qda_dev *qdev);
>  int qda_register_device(struct qda_dev *qdev);
>  
>  #endif /* __QDA_DRV_H__ */
> diff --git a/drivers/accel/qda/qda_memory_manager.c b/drivers/accel/qda/qda_memory_manager.c
> new file mode 100644
> index 000000000000..b1a80ee77c35
> --- /dev/null
> +++ b/drivers/accel/qda/qda_memory_manager.c
> @@ -0,0 +1,98 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> +
> +#include <linux/slab.h>
> +#include "qda_drv.h"
> +#include "qda_memory_manager.h"
> +
> +static void cleanup_all_memory_devices(struct qda_memory_manager *mem_mgr)
> +{
> +	int i;
> +
> +	for (i = 0; i < mem_mgr->num_devices; i++) {
> +		struct qda_iommu_device *iommu_dev = mem_mgr->devices[i];
> +
> +		if (!iommu_dev)
> +			continue;
> +
> +		mem_mgr->devices[i] = NULL;
> +		kfree(iommu_dev);
> +	}
> +	mem_mgr->num_devices = 0;

What for?

> +}
> +
> +/**
> + * qda_memory_manager_register_device() - Register an IOMMU device
> + * @mem_mgr: Pointer to memory manager
> + * @iommu_dev: Pointer to IOMMU device to register
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +int qda_memory_manager_register_device(struct qda_memory_manager *mem_mgr,
> +				       struct qda_iommu_device *iommu_dev)
> +{
> +	if (mem_mgr->num_devices >= mem_mgr->max_devices)
> +		return -ENOSPC;
> +
> +	iommu_dev->id = mem_mgr->num_devices;
> +	mem_mgr->devices[mem_mgr->num_devices++] = iommu_dev;
> +
> +	return 0;
> +}
> +
> +/**
> + * qda_memory_manager_unregister_device() - Unregister an IOMMU device
> + * @mem_mgr: Pointer to memory manager
> + * @iommu_dev: Pointer to IOMMU device to unregister
> + *
> + * Removes the device from the registry and frees it.
> + */
> +void qda_memory_manager_unregister_device(struct qda_memory_manager *mem_mgr,
> +					  struct qda_iommu_device *iommu_dev)
> +{
> +	int i;
> +
> +	for (i = 0; i < mem_mgr->num_devices; i++) {
> +		if (mem_mgr->devices[i] == iommu_dev) {
> +			mem_mgr->devices[i] = NULL;
> +			break;
> +		}
> +	}
> +
> +	kfree(iommu_dev);
> +}
> +
> +/**
> + * qda_memory_manager_init() - Initialize the memory manager
> + * @mem_mgr: Pointer to memory manager structure to initialize
> + * @max_devices: Number of IOMMU context bank devices to make room for
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +int qda_memory_manager_init(struct qda_memory_manager *mem_mgr, int max_devices)
> +{
> +	if (max_devices <= 0)
> +		return -EINVAL;
> +
> +	mem_mgr->devices = kcalloc(max_devices, sizeof(*mem_mgr->devices), GFP_KERNEL);
> +	if (!mem_mgr->devices)
> +		return -ENOMEM;
> +
> +	mem_mgr->num_devices = 0;
> +	mem_mgr->max_devices = max_devices;
> +
> +	return 0;
> +}
> +
> +/**
> + * qda_memory_manager_exit() - Clean up the memory manager
> + * @mem_mgr: Pointer to memory manager structure to clean up
> + */
> +void qda_memory_manager_exit(struct qda_memory_manager *mem_mgr)
> +{
> +	cleanup_all_memory_devices(mem_mgr);
> +
> +	kfree(mem_mgr->devices);
> +	mem_mgr->devices = NULL;
> +	mem_mgr->max_devices = 0;
> +}
> diff --git a/drivers/accel/qda/qda_memory_manager.h b/drivers/accel/qda/qda_memory_manager.h
> new file mode 100644
> index 000000000000..7e38c8a18284
> --- /dev/null
> +++ b/drivers/accel/qda/qda_memory_manager.h
> @@ -0,0 +1,55 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#ifndef __QDA_MEMORY_MANAGER_H__
> +#define __QDA_MEMORY_MANAGER_H__
> +
> +#include <linux/device.h>
> +
> +/* Forward declarations */
> +struct qda_dev;
> +
> +/**
> + * struct qda_iommu_device - IOMMU device instance for memory management
> + *
> + * Represents a single IOMMU-enabled device managed by the memory manager.
> + * Each device can be assigned to a specific process session.
> + */
> +struct qda_iommu_device {
> +	/** @dev: Pointer to the underlying device */
> +	struct device *dev;
> +	/** @qdev: Back-pointer to the parent QDA device */
> +	struct qda_dev *qdev;
> +	/** @id: Unique identifier assigned by the memory manager */
> +	u32 id;

What kind of identifier? What is going to use it? I don't see any
readers in this patch, please don't add useless data.

> +	/** @sid: Stream ID for IOMMU transactions */
> +	u32 sid;

Do you need to store it?

> +};
> +
> +/**
> + * struct qda_memory_manager - Central memory management coordinator
> + *
> + * Coordinates memory management across multiple IOMMU devices. Maintains
> + * a registry of devices in an array sized to the number of context banks
> + * described in the device tree.
> + */
> +struct qda_memory_manager {
> +	/** @devices: Array storing registered IOMMU devices */
> +	struct qda_iommu_device **devices;
> +	/** @num_devices: Number of registered IOMMU devices */
> +	int num_devices;

What for? Is devices array to be looped up to num_devices or
max_devices?

> +	/** @max_devices: Capacity of the @devices array */
> +	int max_devices;
> +};
> +
> +int qda_memory_manager_init(struct qda_memory_manager *mem_mgr, int max_devices);
> +void qda_memory_manager_exit(struct qda_memory_manager *mem_mgr);
> +
> +int qda_memory_manager_register_device(struct qda_memory_manager *mem_mgr,
> +				       struct qda_iommu_device *iommu_dev);
> +void qda_memory_manager_unregister_device(struct qda_memory_manager *mem_mgr,
> +					  struct qda_iommu_device *iommu_dev);
> +
> +#endif /* __QDA_MEMORY_MANAGER_H__ */
> diff --git a/drivers/accel/qda/qda_rpmsg.c b/drivers/accel/qda/qda_rpmsg.c
> index 723b3e61bf0a..64bf503106d9 100644
> --- a/drivers/accel/qda/qda_rpmsg.c
> +++ b/drivers/accel/qda/qda_rpmsg.c
> @@ -42,11 +42,25 @@ static void qda_rpmsg_remove(struct rpmsg_device *rpdev)
>  	drm_dev_unplug(&qdev->drm_dev);
>  	qdev->rpdev = NULL;
>  	qda_cb_unpopulate(qdev);
> +	qda_deinit_device(qdev);
> +}
> +
> +static int qda_count_cb_nodes(struct device_node *parent_node)
> +{
> +	struct device_node *child;
> +	int count = 0;
> +
> +	for_each_child_of_node(parent_node, child)
> +		if (of_device_is_compatible(child, "qcom,fastrpc-compute-cb"))
> +			count++;
> +
> +	return count;
>  }
>  
>  static int qda_rpmsg_probe(struct rpmsg_device *rpdev)
>  {
>  	struct qda_dev *qdev;
> +	int num_cbs;
>  	int ret;
>  
>  	qdev = qda_rpmsg_alloc_and_init_qdev(rpdev);
> @@ -59,10 +73,15 @@ static int qda_rpmsg_probe(struct rpmsg_device *rpdev)
>  		return ret;
>  	}
>  
> -	ret = qda_cb_populate(qdev, rpdev->dev.of_node);
> +	num_cbs = qda_count_cb_nodes(rpdev->dev.of_node);
> +	ret = qda_init_device(qdev, num_cbs);
>  	if (ret)
>  		return ret;
>  
> +	ret = qda_cb_populate(qdev, rpdev->dev.of_node);
> +	if (ret)
> +		goto err_deinit;
> +
>  	ret = qda_register_device(qdev);
>  	if (ret)
>  		goto err_unpopulate;
> @@ -71,6 +90,8 @@ static int qda_rpmsg_probe(struct rpmsg_device *rpdev)
>  
>  err_unpopulate:
>  	qda_cb_unpopulate(qdev);
> +err_deinit:
> +	qda_deinit_device(qdev);
>  	return ret;
>  }
>  
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
