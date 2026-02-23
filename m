Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C6336AB49
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 19:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771873810; cv=none; b=IGSadUeoGYAGCjN2x8wWJgJxbhY1dvGwFGPhQyereXeimjY0mxFC17u0+dvabFFX+31/Q9fRbL9Z7E3MAz1p41BFyZhmOW2E2O0uC56tGIqLq6vu+nWOsb3jQeas+ZZpoO/fwgbR3GoPNqBF03zC2Uxu8enPwslCGdCCw1zFzkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771873810; c=relaxed/simple;
	bh=3kBZtyhokmuPYRReGrvaIxZIaR2I3PyaglpRACcTb1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ByKQJcmvBrTnEHeJRbJUu65E1LI84tMlnX6GUyzDQ9ASKl3zarfb3dRtvUJpltlgB90tBp0nlifadsguWmU4cRAemFImyGAFPDTz72P9uX2RE1Gcm54YLOofykzAwrVJAdKjgt9bFcyHhR1HNUNx+Bq9Ywa4yPc1uNW07N+f41M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MNgA3Wsv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HQHyRrbI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MNgA3Wsv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HQHyRrbI"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NI79pD544020
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 19:10:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wyym32Dn3gZaoe+c/Su8J1kIoickeG4L4tzwbm1ug2g=; b=MNgA3WsvVpwrivjz
	FnfFpMMOlUngFetqV4HQ6BsnznOHlj7hqtMUPyqURzk3B+2YSxdeTF+DV84H3oj6
	XAU25Qos1LGrhecbxIpcP9C8QyqtZggOxOeki5hxYXXQlQxsz2klKw7ujwhkK3/i
	Np2Bfb7S3KzmOFYgsIY8bfrjNcriaxcTh/6Q4TZKJjdbQpiPYPsbbELlBxer/kbP
	guRa2PtHtLWUxgqbfpJDThBYzVYldpyqkZT1/IOqZwy5564O1SD/Ia81T3C9JKNj
	83vbvykeEUQLVuMCvOrbQhAKZcvYVRGxYFXIUMW8/4A96cavjtLO3e4cyP9eQxp7
	DTs60A==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cgn7t9m88-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 19:10:07 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2aae146bab0so48789755ad.0
        for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 11:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771873807; x=1772478607; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wyym32Dn3gZaoe+c/Su8J1kIoickeG4L4tzwbm1ug2g=;
        b=HQHyRrbIC66GR7JRd2c0UNhb0nxbQAVQAKBQ9lfx4Wx/zza6Z0dNytQbOygWffz50P
         eBra+Xd5GfJQwV2vMNUWDLxS3BEygh609wjO6mmvGrUChkqxbpefSQO1mVgE38RhgzFM
         49or8r5UanOfnKAiiRP6Oi2jYORvINsTilfnPtMIv1PjoyvfBqKCMxPi9Rw41mTtiQc/
         lHvzQii3vCaQy4bAoHV96GLuwfXRXlwwDayKj1UL7XzwW+xRDySUAAgJuoLxYoM38NGd
         1qAS0CyidpBfiddx1QJJrPuE5REuP6d13yBnWM+50o8q/c9Hji4PQEEUqQMJ+uvRagzs
         Q0tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771873807; x=1772478607;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wyym32Dn3gZaoe+c/Su8J1kIoickeG4L4tzwbm1ug2g=;
        b=g/Ovf7vOrPSEFENHqemmF9G+EkdN2216okwIFaLrhxv9/xbQwyueJ5ZARvKYfd+wjS
         gz+nkQHmwBn2bTD7DYx/kJ0pfM+EJ7KBMMkxv3e8lLaJQK2BwuLN9HJGQjgqdXvr7KIp
         M/XNztJVC46vgHF6hHMKAbl+KhqhXDZHZBQEoqDAV5DLA4BsMICJdFBDraLJF/jhnJD6
         sTVcOC10uC/sXuHq+NYH7O8dJvSgWA+z4u/t4f5Ez2DCQzd2aM5EbgBjtuli2luDgSdM
         15Yb31vyEPE/D3SVyepRyf4BNzJNJkTk6BUNevB7wm3O6kOUbMphC6TbTpgRkzJ6jAoc
         600g==
X-Forwarded-Encrypted: i=1; AJvYcCWiEbQuN3IFeSh2WxFMR+rcwFaRefoT4QRS6G55WfjCkeSETIdV3VyZ/c+VxVeaM8x6fwHLmA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzcuJiGAb03To4kxT9hNizg38N8TNJMSDh3wjdi/pHTuMG39d57
	jySOMYURZ0mkfceZWPxYccVS9iwUHzqSHfTwSJqa8uufzOlG251DpNSuj/eyRMCIadDvK6uDdh5
	JlLFutold+SJKBHvV2CifAZ8T/RoI1+Y77ah3AlmssvewYNN/n0iyiFQY+w==
X-Gm-Gg: ATEYQzw9jmUTIWgcS4P5FAnpeAJz4bK1dXUAY5hJKYmC0K6zHWuedFv58CQi5aWaC8Z
	fIx/r6kYOP3JYpldYIVhF5yyVP3I2eXQgeZHRKJ6OJGRi2eJTq+GAMIH6N2FPgLoyVMnzMPxBqj
	bIkKfmusExm4ufACBJY5KI4L6h2KwufWnlD3y/jneTwHS6uSwPr4K0GdTM51D9CvzHmPhaYyIJR
	KEmsq1wOvzzJiuG06PHo/GrE5B3t1HQBPoYwpsmeCOZYt9G/NpXeNVvFdQoZPW/dOPA+9n2dKIu
	PE1gb59ZUxMZtAlvhea7XvucXk/Bk+ydnPwS+yQJ3XDJYWBH1B/CCTH5vXqXVxqlVPMXMG36XmF
	nDq/X2KB1tpvDHcx8ym6dCqW/I8AfaoEq2tVVOUOVLCqQ6kF2mDUEGA==
X-Received: by 2002:a17:902:e78b:b0:2aa:d816:e1a4 with SMTP id d9443c01a7336-2ad745166f8mr86848585ad.31.1771873806779;
        Mon, 23 Feb 2026 11:10:06 -0800 (PST)
X-Received: by 2002:a17:902:e78b:b0:2aa:d816:e1a4 with SMTP id d9443c01a7336-2ad745166f8mr86848195ad.31.1771873806068;
        Mon, 23 Feb 2026 11:10:06 -0800 (PST)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad74e34e18sm83501505ad.10.2026.02.23.11.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 11:10:05 -0800 (PST)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Date: Tue, 24 Feb 2026 00:39:00 +0530
Subject: [PATCH RFC 06/18] accel/qda: Add memory manager for CB devices
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-qda-firstpost-v1-6-fe46a9c1a046@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771873753; l=15310;
 i=ekansh.gupta@oss.qualcomm.com; s=20260223; h=from:subject:message-id;
 bh=3kBZtyhokmuPYRReGrvaIxZIaR2I3PyaglpRACcTb1s=;
 b=EXX9+FT56Eo9fbGKjtTPCh3zvnIcVG+dOEY5GnHS4dzlVadJVTWQIiumesOwaCHwRi2S342SV
 sKZyYHidGWKBJSfjLWrICib115ZJKqlkwWb9i4w1xukuMU2ijn3syvL
X-Developer-Key: i=ekansh.gupta@oss.qualcomm.com; a=ed25519;
 pk=n0SepARizye+pYjhjg1RA5J+Nq4+IJbyRcBybU+/ERQ=
X-Authority-Analysis: v=2.4 cv=c5OmgB9l c=1 sm=1 tr=0 ts=699ca610 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=hyiFicGTihEQ1qW0zt8A:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: GU-agCscGrn9D9uTaPztAN52zlRokGTD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDE2NiBTYWx0ZWRfX9sLAxXCt3cvL
 d5dKwamkkGx/wBREko/Yx7ROHUUZFsbGSZWFrc88XvMj7A6MvnwUq5E8E7furDMeXJA+ZL4aSCT
 n1RCSSWE64khaohrEoUXDtQkuwa9CxXQkr41JIOtVGfO6Gh/uhJVtn+mY04xmGG4gTjDX5/d1L7
 UsC6m6XJIVw0aSsWZBzwajs7EBQL/REhTBn31gybnRqvxeKLh5/frghq15KLJPoa+A5eXYLnE1s
 z+yqhAblleFKlG4UfytDfmdhUVpnG8b/8hKRnO6IIPBbnOKzOPjOoM5qFpx2cyali/UM07+uvxU
 Rjs01pA+ekrjDBDfccyhbFHDWZPVSqXi7phdxa6rwwwZ/xlUC0ivqENPmxtYIdy1AQ5SvlDTsiV
 +kcqoiZ+r+jMWkicr+VUxaLwHdddRRP5GTkNaXV3FhKdFpPdrDH2euY/Q4sI0A9+sH41OmiyHVq
 Ezzbdp2ffImIGhKuuLQ==
X-Proofpoint-ORIG-GUID: GU-agCscGrn9D9uTaPztAN52zlRokGTD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_04,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 clxscore=1011 bulkscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230166

Introduce a per-device memory manager for the QDA driver that tracks
IOMMU-capable compute context-bank (CB) devices. Each CB device is
represented by a qda_iommu_device and registered with a central
qda_memory_manager instance owned by qda_dev.

The memory manager maintains an xarray of devices and assigns a
unique ID to each CB. It also provides basic lifetime management
and a workqueue for deferred device removal. qda_cb_setup_device()
now allocates a qda_iommu_device for each CB and registers it with
the memory manager after DMA configuration succeeds.

qda_init_device() is extended to allocate and initialize the memory
manager, while qda_deinit_device() will tear it down in later
patches. This prepares the QDA driver for fine-grained memory and
IOMMU domain management tied to individual CB devices.

Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
---
 drivers/accel/qda/Makefile             |   1 +
 drivers/accel/qda/qda_cb.c             |  32 +++++++
 drivers/accel/qda/qda_drv.c            |  46 ++++++++++
 drivers/accel/qda/qda_drv.h            |   3 +
 drivers/accel/qda/qda_memory_manager.c | 152 +++++++++++++++++++++++++++++++++
 drivers/accel/qda/qda_memory_manager.h | 101 ++++++++++++++++++++++
 6 files changed, 335 insertions(+)

diff --git a/drivers/accel/qda/Makefile b/drivers/accel/qda/Makefile
index 4aded20b6bc2..7e96ddc40a24 100644
--- a/drivers/accel/qda/Makefile
+++ b/drivers/accel/qda/Makefile
@@ -9,5 +9,6 @@ qda-y := \
 	qda_drv.o \
 	qda_rpmsg.o \
 	qda_cb.o \
+	qda_memory_manager.o \
 
 obj-$(CONFIG_DRM_ACCEL_QDA_COMPUTE_BUS) += qda_compute_bus.o
diff --git a/drivers/accel/qda/qda_cb.c b/drivers/accel/qda/qda_cb.c
index 77a2d8cae076..e7b9aaeba9af 100644
--- a/drivers/accel/qda/qda_cb.c
+++ b/drivers/accel/qda/qda_cb.c
@@ -7,6 +7,7 @@
 #include <linux/iommu.h>
 #include <linux/slab.h>
 #include "qda_drv.h"
+#include "qda_memory_manager.h"
 #include "qda_cb.h"
 
 static void qda_cb_dev_release(struct device *dev)
@@ -33,11 +34,16 @@ static int qda_configure_cb_iommu(struct device *cb_dev, struct device_node *cb_
 
 static int qda_cb_setup_device(struct qda_dev *qdev, struct device *cb_dev)
 {
+	struct qda_iommu_device *iommu_dev;
 	int rc;
 	u32 sid, pa_bits = 32;
 
 	qda_dbg(qdev, "Setting up CB device %s\n", dev_name(cb_dev));
 
+	iommu_dev = kzalloc_obj(*iommu_dev, GFP_KERNEL);
+	if (!iommu_dev)
+		return -ENOMEM;
+
 	if (of_property_read_u32(cb_dev->of_node, "reg", &sid)) {
 		qda_dbg(qdev, "No 'reg' property found, defaulting SID to 0\n");
 		sid = 0;
@@ -46,6 +52,18 @@ static int qda_cb_setup_device(struct qda_dev *qdev, struct device *cb_dev)
 	rc = dma_set_mask(cb_dev, DMA_BIT_MASK(pa_bits));
 	if (rc) {
 		qda_err(qdev, "%d bit DMA enable failed: %d\n", pa_bits, rc);
+		kfree(iommu_dev);
+		return rc;
+	}
+
+	iommu_dev->dev = cb_dev;
+	iommu_dev->sid = sid;
+	snprintf(iommu_dev->name, sizeof(iommu_dev->name), "qda_iommu_dev_%u", sid);
+
+	rc = qda_memory_manager_register_device(qdev->iommu_mgr, iommu_dev);
+	if (rc) {
+		qda_err(qdev, "Failed to register IOMMU device: %d\n", rc);
+		kfree(iommu_dev);
 		return rc;
 	}
 
@@ -127,6 +145,8 @@ int qda_create_cb_device(struct qda_dev *qdev, struct device_node *cb_node)
 void qda_destroy_cb_device(struct device *cb_dev)
 {
 	struct iommu_group *group;
+	struct qda_iommu_device *iommu_dev;
+	struct qda_dev *qdev;
 
 	if (!cb_dev) {
 		qda_dbg(NULL, "NULL CB device passed to destroy\n");
@@ -135,6 +155,18 @@ void qda_destroy_cb_device(struct device *cb_dev)
 
 	qda_dbg(NULL, "Destroying CB device %s\n", dev_name(cb_dev));
 
+	iommu_dev = dev_get_drvdata(cb_dev);
+	if (iommu_dev) {
+		if (cb_dev->parent) {
+			qdev = dev_get_drvdata(cb_dev->parent);
+			if (qdev && qdev->iommu_mgr) {
+				qda_dbg(NULL, "Unregistering IOMMU device for %s\n",
+					dev_name(cb_dev));
+				qda_memory_manager_unregister_device(qdev->iommu_mgr, iommu_dev);
+			}
+		}
+	}
+
 	group = iommu_group_get(cb_dev);
 	if (group) {
 		qda_dbg(NULL, "Removing %s from IOMMU group\n", dev_name(cb_dev));
diff --git a/drivers/accel/qda/qda_drv.c b/drivers/accel/qda/qda_drv.c
index 389c66a9ad4f..69132737f964 100644
--- a/drivers/accel/qda/qda_drv.c
+++ b/drivers/accel/qda/qda_drv.c
@@ -3,9 +3,20 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/atomic.h>
+#include <linux/slab.h>
 #include "qda_drv.h"
 #include "qda_rpmsg.h"
 
+static void cleanup_iommu_manager(struct qda_dev *qdev)
+{
+	if (qdev->iommu_mgr) {
+		qda_dbg(qdev, "Cleaning up IOMMU manager\n");
+		qda_memory_manager_exit(qdev->iommu_mgr);
+		kfree(qdev->iommu_mgr);
+		qdev->iommu_mgr = NULL;
+	}
+}
+
 static void cleanup_device_resources(struct qda_dev *qdev)
 {
 	mutex_destroy(&qdev->lock);
@@ -13,6 +24,7 @@ static void cleanup_device_resources(struct qda_dev *qdev)
 
 void qda_deinit_device(struct qda_dev *qdev)
 {
+	cleanup_iommu_manager(qdev);
 	cleanup_device_resources(qdev);
 }
 
@@ -25,12 +37,46 @@ static void init_device_resources(struct qda_dev *qdev)
 	atomic_set(&qdev->removing, 0);
 }
 
+static int init_memory_manager(struct qda_dev *qdev)
+{
+	int ret;
+
+	qda_dbg(qdev, "Initializing IOMMU manager\n");
+
+	qdev->iommu_mgr = kzalloc_obj(*qdev->iommu_mgr, GFP_KERNEL);
+	if (!qdev->iommu_mgr)
+		return -ENOMEM;
+
+	ret = qda_memory_manager_init(qdev->iommu_mgr);
+	if (ret) {
+		qda_err(qdev, "Failed to initialize memory manager: %d\n", ret);
+		kfree(qdev->iommu_mgr);
+		qdev->iommu_mgr = NULL;
+		return ret;
+	}
+
+	qda_dbg(qdev, "IOMMU manager initialized successfully\n");
+	return 0;
+}
+
 int qda_init_device(struct qda_dev *qdev)
 {
+	int ret;
+
 	init_device_resources(qdev);
 
+	ret = init_memory_manager(qdev);
+	if (ret) {
+		qda_err(qdev, "IOMMU manager initialization failed: %d\n", ret);
+		goto err_cleanup_resources;
+	}
+
 	qda_dbg(qdev, "QDA device initialized successfully\n");
 	return 0;
+
+err_cleanup_resources:
+	cleanup_device_resources(qdev);
+	return ret;
 }
 
 static int __init qda_core_init(void)
diff --git a/drivers/accel/qda/qda_drv.h b/drivers/accel/qda/qda_drv.h
index eb732b7d8091..2cb97e4eafbf 100644
--- a/drivers/accel/qda/qda_drv.h
+++ b/drivers/accel/qda/qda_drv.h
@@ -11,6 +11,7 @@
 #include <linux/mutex.h>
 #include <linux/rpmsg.h>
 #include <linux/xarray.h>
+#include "qda_memory_manager.h"
 
 /* Driver identification */
 #define DRIVER_NAME "qda"
@@ -23,6 +24,8 @@ struct qda_dev {
 	struct device *dev;
 	/* Mutex protecting device state */
 	struct mutex lock;
+	/* IOMMU/memory manager */
+	struct qda_memory_manager *iommu_mgr;
 	/* Flag indicating device removal in progress */
 	atomic_t removing;
 	/* Name of the DSP (e.g., "cdsp", "adsp") */
diff --git a/drivers/accel/qda/qda_memory_manager.c b/drivers/accel/qda/qda_memory_manager.c
new file mode 100644
index 000000000000..b4c7047a89d4
--- /dev/null
+++ b/drivers/accel/qda/qda_memory_manager.c
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+
+#include <linux/refcount.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/workqueue.h>
+#include <linux/xarray.h>
+#include "qda_drv.h"
+#include "qda_memory_manager.h"
+
+static void cleanup_all_memory_devices(struct qda_memory_manager *mem_mgr)
+{
+	unsigned long index;
+	void *entry;
+
+	qda_dbg(NULL, "Starting cleanup of all memory devices\n");
+
+	xa_for_each(&mem_mgr->device_xa, index, entry) {
+		struct qda_iommu_device *iommu_dev = entry;
+
+		qda_dbg(NULL, "Cleaning up device id=%lu\n", index);
+
+		xa_erase(&mem_mgr->device_xa, index);
+		kfree(iommu_dev);
+	}
+
+	qda_dbg(NULL, "Completed cleanup of all memory devices\n");
+}
+
+static void qda_memory_manager_remove_work(struct work_struct *work)
+{
+	struct qda_iommu_device *iommu_dev =
+		container_of(work, struct qda_iommu_device, remove_work);
+	struct qda_memory_manager *mem_mgr = iommu_dev->manager;
+
+	qda_dbg(NULL, "Remove work started for device id=%u\n", iommu_dev->id);
+
+	if (!mem_mgr) {
+		qda_dbg(NULL, "No manager for device id=%u\n", iommu_dev->id);
+		kfree(iommu_dev);
+		return;
+	}
+
+	xa_erase(&mem_mgr->device_xa, iommu_dev->id);
+
+	qda_dbg(NULL, "Device id=%u removed successfully\n", iommu_dev->id);
+	kfree(iommu_dev);
+}
+
+static void init_iommu_device_fields(struct qda_iommu_device *iommu_dev,
+				     struct qda_memory_manager *mem_mgr)
+{
+	iommu_dev->manager = mem_mgr;
+	spin_lock_init(&iommu_dev->lock);
+	refcount_set(&iommu_dev->refcount, 0);
+	INIT_WORK(&iommu_dev->remove_work, qda_memory_manager_remove_work);
+}
+
+static int allocate_device_id(struct qda_memory_manager *mem_mgr,
+			      struct qda_iommu_device *iommu_dev, u32 *id)
+{
+	int ret;
+
+	ret = xa_alloc(&mem_mgr->device_xa, id, iommu_dev,
+		       xa_limit_31b, GFP_KERNEL);
+	if (ret) {
+		qda_dbg(NULL, "xa_alloc failed, using atomic counter\n");
+		*id = atomic_inc_return(&mem_mgr->next_id);
+		ret = xa_insert(&mem_mgr->device_xa, *id, iommu_dev, GFP_KERNEL);
+		if (ret) {
+			qda_err(NULL, "Failed to insert device with id=%u: %d\n", *id, ret);
+			return ret;
+		}
+	}
+
+	qda_dbg(NULL, "Allocated device id=%u\n", *id);
+	return ret;
+}
+
+int qda_memory_manager_register_device(struct qda_memory_manager *mem_mgr,
+				       struct qda_iommu_device *iommu_dev)
+{
+	int ret;
+	u32 id;
+
+	if (!mem_mgr || !iommu_dev || !iommu_dev->dev) {
+		qda_err(NULL, "Invalid parameters for device registration\n");
+		return -EINVAL;
+	}
+
+	init_iommu_device_fields(iommu_dev, mem_mgr);
+
+	ret = allocate_device_id(mem_mgr, iommu_dev, &id);
+	if (ret) {
+		qda_err(NULL, "Failed to allocate device ID: %d (sid=%u)\n", ret, iommu_dev->sid);
+		return ret;
+	}
+
+	iommu_dev->id = id;
+
+	qda_dbg(NULL, "Registered device id=%u (sid=%u)\n", id, iommu_dev->sid);
+
+	return 0;
+}
+
+void qda_memory_manager_unregister_device(struct qda_memory_manager *mem_mgr,
+					  struct qda_iommu_device *iommu_dev)
+{
+	if (!mem_mgr || !iommu_dev) {
+		qda_err(NULL, "Attempted to unregister invalid device/manager\n");
+		return;
+	}
+
+	qda_dbg(NULL, "Unregistering device id=%u (refcount=%u)\n", iommu_dev->id,
+		refcount_read(&iommu_dev->refcount));
+
+	if (refcount_read(&iommu_dev->refcount) == 0) {
+		xa_erase(&mem_mgr->device_xa, iommu_dev->id);
+		kfree(iommu_dev);
+		return;
+	}
+
+	if (refcount_dec_and_test(&iommu_dev->refcount)) {
+		qda_info(NULL, "Device id=%u refcount reached zero, queuing removal\n",
+			 iommu_dev->id);
+		queue_work(mem_mgr->wq, &iommu_dev->remove_work);
+	}
+}
+
+int qda_memory_manager_init(struct qda_memory_manager *mem_mgr)
+{
+	qda_dbg(NULL, "Initializing memory manager\n");
+
+	xa_init_flags(&mem_mgr->device_xa, XA_FLAGS_ALLOC);
+	atomic_set(&mem_mgr->next_id, 0);
+	mem_mgr->wq = create_workqueue("memory_manager_wq");
+	if (!mem_mgr->wq) {
+		qda_err(NULL, "Failed to create memory manager workqueue\n");
+		return -ENOMEM;
+	}
+
+	qda_dbg(NULL, "QDA: Memory manager initialized successfully\n");
+	return 0;
+}
+
+void qda_memory_manager_exit(struct qda_memory_manager *mem_mgr)
+{
+	cleanup_all_memory_devices(mem_mgr);
+	destroy_workqueue(mem_mgr->wq);
+	qda_dbg(NULL, "QDA: Memory manager exited\n");
+}
diff --git a/drivers/accel/qda/qda_memory_manager.h b/drivers/accel/qda/qda_memory_manager.h
new file mode 100644
index 000000000000..3bf4cd529909
--- /dev/null
+++ b/drivers/accel/qda/qda_memory_manager.h
@@ -0,0 +1,101 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef _QDA_MEMORY_MANAGER_H
+#define _QDA_MEMORY_MANAGER_H
+
+#include <linux/device.h>
+#include <linux/refcount.h>
+#include <linux/spinlock.h>
+#include <linux/workqueue.h>
+#include <linux/xarray.h>
+
+/**
+ * struct qda_iommu_device - IOMMU device instance for memory management
+ *
+ * This structure represents a single IOMMU-enabled device managed by the
+ * memory manager. Each device can be assigned to a specific process.
+ */
+struct qda_iommu_device {
+	/* Unique identifier for this IOMMU device */
+	u32 id;
+	/* Pointer to the underlying device */
+	struct device *dev;
+	/* Name for the device */
+	char name[32];
+	/* Spinlock protecting concurrent access to device */
+	spinlock_t lock;
+	/* Reference counter for device */
+	refcount_t refcount;
+	/* Work structure for deferred device removal */
+	struct work_struct remove_work;
+	/* Stream ID for IOMMU transactions */
+	u32 sid;
+	/* Pointer to parent memory manager */
+	struct qda_memory_manager *manager;
+};
+
+/**
+ * struct qda_memory_manager - Central memory management coordinator
+ *
+ * This is the top-level structure coordinating memory management across
+ * multiple IOMMU devices. It maintains a registry of devices and backends,
+ * and ensures thread-safe access to shared resources.
+ */
+struct qda_memory_manager {
+	/* XArray storing all registered IOMMU devices */
+	struct xarray device_xa;
+	/* Atomic counter for generating unique device IDs */
+	atomic_t next_id;
+	/* Workqueue for asynchronous device operations */
+	struct workqueue_struct *wq;
+};
+
+/**
+ * qda_memory_manager_init() - Initialize the memory manager
+ * @mem_mgr: Pointer to memory manager structure to initialize
+ *
+ * Initializes the memory manager's internal data structures including
+ * the device registry, workqueue, and synchronization primitives.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int qda_memory_manager_init(struct qda_memory_manager *mem_mgr);
+
+/**
+ * qda_memory_manager_exit() - Clean up the memory manager
+ * @mem_mgr: Pointer to memory manager structure to clean up
+ *
+ * Releases all resources associated with the memory manager, including
+ * unregistering all devices and destroying the workqueue.
+ */
+void qda_memory_manager_exit(struct qda_memory_manager *mem_mgr);
+
+/**
+ * qda_memory_manager_register_device() - Register an IOMMU device
+ * @mem_mgr: Pointer to memory manager
+ * @iommu_dev: Pointer to IOMMU device to register
+ *
+ * Adds a new IOMMU device to the memory manager's registry and initializes
+ * its memory backend. The device becomes available for memory allocation
+ * operations.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int qda_memory_manager_register_device(struct qda_memory_manager *mem_mgr,
+				       struct qda_iommu_device *iommu_dev);
+
+/**
+ * qda_memory_manager_unregister_device() - Unregister an IOMMU device
+ * @mem_mgr: Pointer to memory manager
+ * @iommu_dev: Pointer to IOMMU device to unregister
+ *
+ * Removes an IOMMU device from the memory manager's registry and cleans up
+ * its associated resources. Any remaining memory allocations are freed.
+ */
+void qda_memory_manager_unregister_device(struct qda_memory_manager *mem_mgr,
+					  struct qda_iommu_device *iommu_dev);
+
+#endif /* _QDA_MEMORY_MANAGER_H */

-- 
2.34.1

