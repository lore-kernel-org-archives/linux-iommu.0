Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851D936BCE3
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 19:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771873847; cv=none; b=llAExiN4bL/X8gioO1yQybrWlmE+Rn/nzUgET+1g2PYCN4BzTfBE8d3xCf2/cHhgvsSyCla+gQTkN8Uecklr4KShGt1QtnHQKpMWm6LSfbC92BigEF6dO7VyxdMIGxJRBEzm7WO8l6TxihRyx6/3D6tO7d/wAMDk2d2qPO7XDbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771873847; c=relaxed/simple;
	bh=2RxOxXc9zqZvtJxNIuKIxSb9BnPuUuUrWmkgeMbTfW8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dRtudINRkv1Z/ffOktZWUxGNCfvYKX66NFocDpadmEi5rYatO8uf1/9KihA1OrLEi2x4A9ektx9Amqw3305X2WHXfRyekvsB3gMxRx62/HIR6qa/iinH7BukNywB/v+LgWa9Ofqz5A6ba5jzc/6RyKNcgAhK23XXrOIaMUkO0z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OqkqPx5D; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=c5jlGk5I; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OqkqPx5D";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c5jlGk5I"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NGRLUY1640663
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 19:10:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3cEndrH++ZoozGxCle7RcLV8UVr6wjbisoptDK/+Xp8=; b=OqkqPx5DajaGaPNQ
	9oi4JyZMGMa3uC/V148Ftz8x1qGnU5jAn3Hp0OyelszklsQjRnTYsvyORjcrM5J9
	kM2n5nqoKGR3lemZUd6RdrKRRqFvGW+Q1Ht3tEGVxFO/2U6dEhXf8cn5HZ2X3kXl
	Kkizh3UFar+DJHRqvmO0AMqAGaxwp0V1dX2VUyrwQCIw/4H0tBsl02lEtqFDdgtC
	VthsA6QRlGvoQIhZwQfqW6jdByd9tRb8EMbf3I8v1Q5yINNnEVDs5ZwLyY9LMi9G
	O4Oz+2umASGPUZxESnS87u4K/HjCdhLsQ3y9P+KMc0qpOIZj+mZGE2SJvRACwM8/
	zPRv3g==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cgte8rhg9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 19:10:45 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a7a98ba326so70505615ad.1
        for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 11:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771873844; x=1772478644; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3cEndrH++ZoozGxCle7RcLV8UVr6wjbisoptDK/+Xp8=;
        b=c5jlGk5ISCBG0vC0dgp79LrneO+53MfXqS85azlNbGBm+tI5TobbiYXYHR2PbM8OUi
         xkmoQnNtP6/yU2cFfcIVNsIS8ZGUv8IdnWbuGQNj2LLltqlIE/mJmK0/9iEbu6EknPQn
         odged1PqjNG5xqcGQSAfbw7an42//ZDDVH15JhXlmXwnVd/7cxmYyOnyeJqrHUgEw5Z3
         WjhLFpJlOTRQPyhxqV8RJcUXODBDrNwyGcWnREWWdg+ly+KUhEvTxFPfRj0nOl7iOR+P
         xuNprND57rmi+i8BbAVE8iS9HWo8r6hOOJK16hTjZKAyndRg+ln+Tm7KOs5Xjuo0Lz2d
         n0KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771873844; x=1772478644;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3cEndrH++ZoozGxCle7RcLV8UVr6wjbisoptDK/+Xp8=;
        b=CQcUaG+FtNVckR/iT7Fhu365B0ZTC53npGUIzWkEjyhoxxTfVRJZ4pEWJKU9aBlLlK
         nxlud87TZhG/0K2LkSMReEt0C1x9Gaal6QHAYM1DfgBnzGa/GA0bQWHx9nPd3OWspM18
         bqLDt4Xsss6AqwVvhTvmW2E/efLcdXlQ/MSwsHFTSIs/lGCtRXQZ5/bHcire6uuM9NMD
         nnqgQ0bnNrZC7D3t1EhaNNpUewZbslbf3nzcyNQNnyisAg2ITPtmd38PHUxojyvuW9jz
         gdixBLmje/Qyy13bUxQmc0WSXhWr9JIozqUcagcJwdW7bMPr8hM8e4ZaB82d+sKE6sq+
         ajzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlqLMVJGiIrD06Bc5Q7m9P7ZceMQwWdg4fy/SDlcmQ5Hg8trECrTyeWJ2/7RUyAMsm67qbRw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyUpGowLDK4n1VASVPAa5O4exSFpEj1xqi03+Z92Dn3oa0BUMr8
	luU9L/shIJjwyC5WFWL1yLKh+L8+RRbQ+QA5uEwXyRn1eEEgU/gDVwK01AZHL5abBihvAmXQQ1z
	2JSkxnn19ki4lDjmXu3k1nKUMQnbEHCfgY+MozqhwZrQJbc49epqXpw+wRw==
X-Gm-Gg: ATEYQzzpD6yYTMV8LSf2jDML0TPCWJxG650iOeUbBpSjvA+kTujOfWBUg/Yyqwx6b4B
	uVwM3dHMV37OGq8l2b6Yo8jimFO+g1WlS1xsjp3gkuTmBvkOGt8NY8LJcLghL9OlVgn3IEXEx9d
	zKyP2SRRjedxmeMR2QXT31pfDEsBgYKJDWrQRFXQ4NZzXCNQGU34xAc2H0ay3CV/kXaanBiZk+w
	DbQ1OPiylKWh/+2QYGAGjT92HdGwehE3ZRgMSdgfjS02i3izbu+a3a2Ls5tMcvYbZpuu+5Ej5oG
	Klo8uWOk4xVq6UFe2wPFEZZTxoER4lVE34nFdWk98DBaZTOIwOUuhs908dnvfEetIXwy58UAvvn
	k3vt8EnDWNrTVGlzWxkjhWd1MbnSXuLqyeEwZ3fKRqWcmgLRpHW1vxg==
X-Received: by 2002:a17:903:1107:b0:2a9:320d:285e with SMTP id d9443c01a7336-2ad5f7b8baamr123910645ad.27.1771873844299;
        Mon, 23 Feb 2026 11:10:44 -0800 (PST)
X-Received: by 2002:a17:903:1107:b0:2a9:320d:285e with SMTP id d9443c01a7336-2ad5f7b8baamr123910275ad.27.1771873843731;
        Mon, 23 Feb 2026 11:10:43 -0800 (PST)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad74e34e18sm83501505ad.10.2026.02.23.11.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 11:10:43 -0800 (PST)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Date: Tue, 24 Feb 2026 00:39:05 +0530
Subject: [PATCH RFC 11/18] accel/qda: Add GEM_CREATE and GEM_MMAP_OFFSET
 IOCTLs
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-qda-firstpost-v1-11-fe46a9c1a046@oss.qualcomm.com>
References: <20260224-qda-firstpost-v1-0-fe46a9c1a046@oss.qualcomm.com>
In-Reply-To: <20260224-qda-firstpost-v1-0-fe46a9c1a046@oss.qualcomm.com>
To: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bharath Kumar <quic_bkumar@quicinc.com>,
        Chenna Kesava Raju <quic_chennak@quicinc.com>,
        Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771873753; l=6899;
 i=ekansh.gupta@oss.qualcomm.com; s=20260223; h=from:subject:message-id;
 bh=2RxOxXc9zqZvtJxNIuKIxSb9BnPuUuUrWmkgeMbTfW8=;
 b=OdNLCIrevKeJOr4Sn7iJQ7EA64taPtlHsqOdk0FAznWQBx7+UrSyEBkaxLabf/n4ZADVR797g
 gmHDCtzQkxDCDFwH4r3tYY2PYPpjtmNKwQNMzhCaFXo/sq/VV+FDLok
X-Developer-Key: i=ekansh.gupta@oss.qualcomm.com; a=ed25519;
 pk=n0SepARizye+pYjhjg1RA5J+Nq4+IJbyRcBybU+/ERQ=
X-Proofpoint-ORIG-GUID: l6eLmVDqPN5azxJsT7t-BovXFjwAwvL8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDE2NiBTYWx0ZWRfX67juVMwtDU21
 /YEMeAMwcJ7S0nbFhi9bIyr3LMeKwdZRu7FinwPwGO9Q/Htj1TsyOOj/0MTnt14ZeRlIdUDa1Lb
 GwRqlgUiFgnPGxDEPmDt8gEJWBwm6mzOssz7gcvLbGln0b3DzQeDQ2MlCkIyfqedvHZhWwkZV//
 EYII62f6u/SM8tSHHIXTzzAw7kCl+C0EfXabtQkgkFvxEjH12dBymI5oqJhDZ03OH+E1fmH0y6R
 cA7CoZuqM0ISNshOaRcLJqhLBUV6kDDaVUirMvUMqTQWDFj5aRdHso1Z5hmfLmywZkvjUCFqowB
 zr623+xDkp50sRPOQkJ2hmzanZE93oH0tQtTs3HOgHFKOnkf17FhBmMxcJi5ANgI4ePOIzXKhzO
 MrFBa58D5xv8/c/1uwYsMgvzr2Rq949I3/5lEDBKWeDDocrTMgw8/r1lnng8KIbsINFrHTqOYKT
 t2OX4GoqIoj7rlO9+XQ==
X-Proofpoint-GUID: l6eLmVDqPN5azxJsT7t-BovXFjwAwvL8
X-Authority-Analysis: v=2.4 cv=WqQm8Nfv c=1 sm=1 tr=0 ts=699ca635 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=mxALtX23GHkpHf8IwecA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_04,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230166

Add two GEM-related IOCTLs for the QDA accelerator driver and hook
them into the DRM accel driver. DRM_IOCTL_QDA_GEM_CREATE allocates
a DMA-backed GEM buffer object via qda_gem_create_object() and
returns a GEM handle to userspace, while
DRM_IOCTL_QDA_GEM_MMAP_OFFSET returns a valid mmap offset for a
given GEM handle using drm_gem_create_mmap_offset() and the
vma_node in the GEM object.

The QDA driver is updated to advertise DRIVER_GEM in its
driver_features, and the new IOCTLs are wired through the QDA
GEM and memory-manager backend. These IOCTLs allow userspace to
allocate buffers and map them into its address space as a first
step toward full compute buffer management and integration with
DSP workloads.

Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
---
 drivers/accel/qda/qda_drv.c   |  5 ++++-
 drivers/accel/qda/qda_gem.h   | 30 ++++++++++++++++++++++++++++++
 drivers/accel/qda/qda_ioctl.c | 35 +++++++++++++++++++++++++++++++++++
 include/uapi/drm/qda_accel.h  | 36 ++++++++++++++++++++++++++++++++++++
 4 files changed, 105 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/qda/qda_drv.c b/drivers/accel/qda/qda_drv.c
index 19798359b14e..0dd0e2bb2c0f 100644
--- a/drivers/accel/qda/qda_drv.c
+++ b/drivers/accel/qda/qda_drv.c
@@ -12,6 +12,7 @@
 #include <drm/qda_accel.h>
 
 #include "qda_drv.h"
+#include "qda_gem.h"
 #include "qda_ioctl.h"
 #include "qda_rpmsg.h"
 
@@ -154,10 +155,12 @@ DEFINE_DRM_ACCEL_FOPS(qda_accel_fops);
 
 static const struct drm_ioctl_desc qda_ioctls[] = {
 	DRM_IOCTL_DEF_DRV(QDA_QUERY, qda_ioctl_query, 0),
+	DRM_IOCTL_DEF_DRV(QDA_GEM_CREATE, qda_ioctl_gem_create, 0),
+	DRM_IOCTL_DEF_DRV(QDA_GEM_MMAP_OFFSET, qda_ioctl_gem_mmap_offset, 0),
 };
 
 static struct drm_driver qda_drm_driver = {
-	.driver_features = DRIVER_COMPUTE_ACCEL,
+	.driver_features = DRIVER_GEM | DRIVER_COMPUTE_ACCEL,
 	.fops			= &qda_accel_fops,
 	.open			= qda_open,
 	.postclose		= qda_postclose,
diff --git a/drivers/accel/qda/qda_gem.h b/drivers/accel/qda/qda_gem.h
index caae9cda5363..cbd5d0a58fa4 100644
--- a/drivers/accel/qda/qda_gem.h
+++ b/drivers/accel/qda/qda_gem.h
@@ -47,6 +47,36 @@ struct drm_gem_object *qda_gem_create_object(struct drm_device *drm_dev,
 void qda_gem_free_object(struct drm_gem_object *gem_obj);
 int qda_gem_mmap_obj(struct drm_gem_object *gem_obj, struct vm_area_struct *vma);
 
+/*
+ * GEM IOCTL handlers
+ */
+
+/**
+ * qda_ioctl_gem_create - Create a GEM buffer object
+ * @dev: DRM device structure
+ * @data: User-space data containing buffer creation parameters
+ * @file_priv: DRM file private data
+ *
+ * This IOCTL handler creates a new GEM buffer object with the specified
+ * size and returns a handle to the created buffer.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int qda_ioctl_gem_create(struct drm_device *dev, void *data, struct drm_file *file_priv);
+
+/**
+ * qda_ioctl_gem_mmap_offset - Get mmap offset for a GEM buffer object
+ * @dev: DRM device structure
+ * @data: User-space data containing buffer handle and offset result
+ * @file_priv: DRM file private data
+ *
+ * This IOCTL handler retrieves the mmap offset for a GEM buffer object,
+ * which can be used to map the buffer into user-space memory.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int qda_ioctl_gem_mmap_offset(struct drm_device *dev, void *data, struct drm_file *file_priv);
+
 /*
  * Helper functions for GEM object allocation and cleanup
  * These are used internally and by the PRIME import code
diff --git a/drivers/accel/qda/qda_ioctl.c b/drivers/accel/qda/qda_ioctl.c
index 9fa73ec2dfce..ef3c9c691cb7 100644
--- a/drivers/accel/qda/qda_ioctl.c
+++ b/drivers/accel/qda/qda_ioctl.c
@@ -43,3 +43,38 @@ int qda_ioctl_query(struct drm_device *dev, void *data, struct drm_file *file_pr
 
 	return 0;
 }
+
+int qda_ioctl_gem_create(struct drm_device *dev, void *data, struct drm_file *file_priv)
+{
+	struct drm_qda_gem_create *args = data;
+	struct drm_gem_object *gem_obj;
+	struct qda_drm_priv *drm_priv;
+
+	drm_priv = get_drm_priv_from_device(dev);
+	if (!drm_priv || !drm_priv->iommu_mgr)
+		return -EINVAL;
+
+	gem_obj = qda_gem_create_object(dev, drm_priv->iommu_mgr, args->size, file_priv);
+	if (IS_ERR(gem_obj))
+		return PTR_ERR(gem_obj);
+
+	return qda_gem_create_handle(file_priv, gem_obj, &args->handle);
+}
+
+int qda_ioctl_gem_mmap_offset(struct drm_device *dev, void *data, struct drm_file *file_priv)
+{
+	struct drm_qda_gem_mmap_offset *args = data;
+	struct drm_gem_object *gem_obj;
+	int ret;
+
+	gem_obj = qda_gem_lookup_object(file_priv, args->handle);
+	if (IS_ERR(gem_obj))
+		return PTR_ERR(gem_obj);
+
+	ret = drm_gem_create_mmap_offset(gem_obj);
+	if (ret == 0)
+		args->offset = drm_vma_node_offset_addr(&gem_obj->vma_node);
+
+	drm_gem_object_put(gem_obj);
+	return ret;
+}
diff --git a/include/uapi/drm/qda_accel.h b/include/uapi/drm/qda_accel.h
index 0aad791c4832..ed24a7f5637e 100644
--- a/include/uapi/drm/qda_accel.h
+++ b/include/uapi/drm/qda_accel.h
@@ -19,6 +19,8 @@ extern "C" {
  * They are used with DRM_COMMAND_BASE to create the full IOCTL numbers.
  */
 #define DRM_QDA_QUERY	0x00
+#define DRM_QDA_GEM_CREATE		0x01
+#define DRM_QDA_GEM_MMAP_OFFSET	0x02
 /*
  * QDA IOCTL definitions
  *
@@ -27,6 +29,10 @@ extern "C" {
  * data structure and direction (read/write) for each IOCTL.
  */
 #define DRM_IOCTL_QDA_QUERY	DRM_IOR(DRM_COMMAND_BASE + DRM_QDA_QUERY, struct drm_qda_query)
+#define DRM_IOCTL_QDA_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_QDA_GEM_CREATE, \
+						 struct drm_qda_gem_create)
+#define DRM_IOCTL_QDA_GEM_MMAP_OFFSET	DRM_IOWR(DRM_COMMAND_BASE + DRM_QDA_GEM_MMAP_OFFSET, \
+						 struct drm_qda_gem_mmap_offset)
 
 /**
  * struct drm_qda_query - Device information query structure
@@ -40,6 +46,36 @@ struct drm_qda_query {
 	__u8 dsp_name[16];
 };
 
+/**
+ * struct drm_qda_gem_create - GEM buffer object creation parameters
+ * @size: Size of the GEM object to create in bytes (input)
+ * @handle: Allocated GEM handle (output)
+ *
+ * This structure is used with DRM_IOCTL_QDA_GEM_CREATE to allocate
+ * a new GEM buffer object.
+ */
+struct drm_qda_gem_create {
+	__u32 handle;
+	__u32 pad;
+	__u64 size;
+};
+
+/**
+ * struct drm_qda_gem_mmap_offset - GEM object mmap offset query
+ * @handle: GEM handle (input)
+ * @pad: Padding for 64-bit alignment
+ * @offset: mmap offset for the GEM object (output)
+ *
+ * This structure is used with DRM_IOCTL_QDA_GEM_MMAP_OFFSET to retrieve
+ * the mmap offset that can be used with mmap() to map the GEM object into
+ * user space.
+ */
+struct drm_qda_gem_mmap_offset {
+	__u32 handle;
+	__u32 pad;
+	__u64 offset;
+};
+
 #if defined(__cplusplus)
 }
 #endif

-- 
2.34.1

