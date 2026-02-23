Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8581E36A03B
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 19:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771873788; cv=none; b=WchS9D9ae54PzH0F7MbkHOM+kaoT/lP1vkh7bRf9UYLwKBViLsm7I3Sq1n5qXsLkAlVaeb5MVgFL/DDLO1AyY32ZPiMoGOLZhRDneZYPdWZJoRRd1bSAMlOEnu6XMkiEUxVrc/sAeNtNHth/LhoRjnoXqvtwlqPxAltOWde1jYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771873788; c=relaxed/simple;
	bh=iLQ8c+Sm/Die53QHNPeJqNsBysDvS6aLmEkWX2M3O8g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rfcbv9/fdjZZIXVSwvCy9loK38jswrS47O7bF07aZT7YnenUZEkAysPmqKTlockaG537B4SxsFewiYxvfKXPf1Fq3cdpZN92QJ6j52t22L+YF/BYYrUTp5T+p5d9N11EAKV+JpMR7Bq3ryGat1mv6s2TqCePAlUccN8V9Dd2Ees=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kG4wmDO4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LWklIsqM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kG4wmDO4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LWklIsqM"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NGFSUs3936387
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 19:09:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MJPcPVRr65YeMFEr02KOUusve8jQFGasCqgJNjYMLUY=; b=kG4wmDO43TdEaah1
	kwFIpoYkIqCc8p+LATPySwod2UV5df+9/oqv80f2xPZlLyZL/yXusCxU389jJsBc
	ZbbT7SrcP8OT/3jRIQzRMpU8PoKAO8JOXMGHHFHGEq6vNqeqgRruSXxWh1yW+sks
	PvgmRZ1/3z/rBosdenfDeZjliUBQjyOZk3XwHpAlEuLlMR+eKEDGIz9+qHlaDFlU
	7jpVvgjmyC+SqFBUQZaxOdwGID8oqptoesxk6hVJ9Q1wt5g6/weVvVNyvH8KdOlq
	YJA4l58cj//HbrZye7jl/1IWU/GWwxZPgTrC7zaxek4+W/x/YY2n/0DOf9MqH06y
	K0Po/w==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cgt8mgjhb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 19:09:45 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ab4de9580dso395854015ad.3
        for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 11:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771873784; x=1772478584; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MJPcPVRr65YeMFEr02KOUusve8jQFGasCqgJNjYMLUY=;
        b=LWklIsqME7p0R3a1+W6GOUcp174cLhTyLaRd3Ei7+CisBAww8ENeuHvk8U9i1tlV99
         HfaPcF204OVkutLxlzG1GLTUrDSpOE0I4xvl+TjfDuTBJoTpW78+z+LmdgMv1So4JxsW
         Cr4vVlcOBp5poNSteCYtUZNsAAH5B5Vlxhqaffxnp4OxA1uapUp2baAmsUEmFY3EcHjQ
         24kug61l9KO56twBVVH2fIzOM80BOK6jC3Dy8UaYq9pSkkzbHkazUK7aJdJSwl1vje3Z
         oC0QdSZcabatmT9NlBQ1Gf2m+M0/Ss0z8X2SalbbmgF0SlENy6lvm/p3NQlslFB/vP9L
         KnQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771873784; x=1772478584;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MJPcPVRr65YeMFEr02KOUusve8jQFGasCqgJNjYMLUY=;
        b=XySUAJf9cU5H7uEX1f74Xi9WB47urErsZ7BMbGVawUEtgWXgvJmavbQqPcm2EdFkNR
         ykYgDdYftuvXljT2S9/tZcL8tINJTUmQFnQUv2QTCa2vzgEjZS0ZsgtAa8WjmNLH1GKB
         48pBUEGTnAb3x2iHrLw/o/15Feuk+pr/87KpIDBrGDhxyTmEZXOrZZNHjUyhRRpsU8rr
         z2qgFMycbuWoy1A5qOcyDHrp7vxdBaEPVqrW8SY6xbKlovQRpqWNT10pMkdXIUoWhL2V
         d+kBYqpw3blZjyUy9Pp1lbEcbqHTDvQK2wME1zPC6JMhP5Cefi6rrQP3YaO2Ml6OMcyX
         Z8tw==
X-Forwarded-Encrypted: i=1; AJvYcCWCHa+euz9t1ucq95Jyh6b3V/RAp90wJcYHd6ClJZkvKOn92HLt7o3eWnWyyrkYczT8fNrJmg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzrRWHx+Wtxhl+TRgav3gY55sB05VhPZc/GcC1OnyBo0JEhofmX
	yFpUFXABIcnFeCupjwSSw3cE8qhXm6mHXkHo2aa84Tgy1DWuSZ10O4VYCc1Qer2hHkP/79LtWV7
	PkRuEj38HNXi3kM6IuWYpzeo6P0DlKAjdVizfGPXIT8I4g/rm/T8WY2t2Gg==
X-Gm-Gg: ATEYQzxL64Dm5NflSNJgDXyqqKp6KJzpxRstTqkvx7aX0gLAwxUrNhLY8OLKr2gqNg9
	gmVdrvffU0S3jYKcmwImJOwj/0IocYU6YFN8kHQGHbIfbxi4hcBLWcgv/NdyEzG0kHer1tolU3n
	r9GkNgvubWFYL4VNWQtMrLPfBQHoQre8jaHcT8Z05co+CAa8gWa+vSHxJ1l6fdTUplqHFnHjkVI
	etwCwv4KfHP9Gx0Lgnh8E3Kw6sUYSMsi2oBu06RNd3StMdAMcE5OnWPNGgFGhUG9qQFAkgFf+3m
	VMXgqW8Gs9dCuodPyB5CA6vRgFGr2q/YtDCicaq3jFSF3nWJDq4LD6ZFYk6pwZtY6JszBEDfvHW
	vkjKBZwf79rZzVP1oPzl9G3Rq6m9Tb5Fd9LFDK4SS18+bKGWbb1EHCQ==
X-Received: by 2002:a17:903:2445:b0:2aa:ecec:a447 with SMTP id d9443c01a7336-2ad74504e77mr105282895ad.36.1771873784188;
        Mon, 23 Feb 2026 11:09:44 -0800 (PST)
X-Received: by 2002:a17:903:2445:b0:2aa:ecec:a447 with SMTP id d9443c01a7336-2ad74504e77mr105282525ad.36.1771873783703;
        Mon, 23 Feb 2026 11:09:43 -0800 (PST)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad74e34e18sm83501505ad.10.2026.02.23.11.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 11:09:42 -0800 (PST)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Date: Tue, 24 Feb 2026 00:38:57 +0530
Subject: [PATCH RFC 03/18] accel/qda: Add RPMsg transport for Qualcomm DSP
 accelerator
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-qda-firstpost-v1-3-fe46a9c1a046@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771873753; l=10008;
 i=ekansh.gupta@oss.qualcomm.com; s=20260223; h=from:subject:message-id;
 bh=iLQ8c+Sm/Die53QHNPeJqNsBysDvS6aLmEkWX2M3O8g=;
 b=ZBLecOZ8SdMNZ1UUQFp4TQ5Efvw9R8lIP8FX7UXoOp+NWgdD2+C0PgFZix6DyqkZ4sVZhzdR6
 j5DF2sxp1K4BUEuwKGYj3zRftFADwXcz/jCBY6b3tdpgazbABOsCbPo
X-Developer-Key: i=ekansh.gupta@oss.qualcomm.com; a=ed25519;
 pk=n0SepARizye+pYjhjg1RA5J+Nq4+IJbyRcBybU+/ERQ=
X-Authority-Analysis: v=2.4 cv=J/unLQnS c=1 sm=1 tr=0 ts=699ca5f9 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=FHHk3UexkictpjMLSY0A:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: boV7n_kUL780mTTbxbBdrgjSVDymkuj6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDE2NiBTYWx0ZWRfX5wTnYA0xcM4N
 JPUM5wa1DT8ts0LyXq459S5IzSfMyJ1wxSOpM6lUl8QpIMxxmiMUtLpwT79isumEGcwSDNVxJKg
 o8jJA3qn4yNC+jJ8c87l0iUnqcsHraWbRPDxMoKhZ+U+QQITMyO9ziXrb6VL559XfSPzhl9xy25
 d3Lx5ssWswU+cYnnyvTAIuL+ltVd3+snNGbWZG7JilpQnBjMcchQ+/Ab42bL5XO3aL4THIjlY34
 TLVvHk9j8hYqKYn+L4idzY0ePaX9vgaTTNJZyLIKSR/YodinrcREFp2Wrd9ai14GgimebmcymbI
 iV5M7nUFxXRRaEbBeOP3qMaXrJnuSn9hOiNHtUO17mKAfH63g0M0rW9u5nkD44+uFGE/e6ha4kJ
 KEYDLE8f0vql/UFj/z8LdSfMOqVzB6+3JGY/8As3lIt8QTAQLlIbyyJeReNz/oiqruRKndHeJef
 kAxYwcL1vYZGp5NWNKg==
X-Proofpoint-GUID: boV7n_kUL780mTTbxbBdrgjSVDymkuj6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_04,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602230166

Extend the Qualcomm DSP accelerator (QDA) driver with an RPMsg-based
transport used to discover and manage DSP instances.

This patch introduces:

- A core qda_dev structure with basic device state (rpmsg device,
  device pointer, lock, removal flag, DSP name).
- Logging helpers that integrate with dev_* when a device is available
  and fall back to pr_* otherwise.
- An RPMsg client driver that binds to the Qualcomm FastRPC service and
  allocates a qda_dev instance using devm_kzalloc().
- Basic device initialization and teardown paths wired into the module
  init/exit.

The RPMsg driver currently sets the DSP name from a "label" property in
the device tree, which will be used by subsequent patches to distinguish
between different DSP domains (e.g. ADSP, CDSP).

Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
---
 drivers/accel/qda/Kconfig     |   1 +
 drivers/accel/qda/Makefile    |   4 +-
 drivers/accel/qda/qda_drv.c   |  41 ++++++++++++++-
 drivers/accel/qda/qda_drv.h   |  91 ++++++++++++++++++++++++++++++++
 drivers/accel/qda/qda_rpmsg.c | 119 ++++++++++++++++++++++++++++++++++++++++++
 drivers/accel/qda/qda_rpmsg.h |  17 ++++++
 6 files changed, 270 insertions(+), 3 deletions(-)

diff --git a/drivers/accel/qda/Kconfig b/drivers/accel/qda/Kconfig
index 3c78ff6189e0..484d21ff1b55 100644
--- a/drivers/accel/qda/Kconfig
+++ b/drivers/accel/qda/Kconfig
@@ -7,6 +7,7 @@ config DRM_ACCEL_QDA
 	tristate "Qualcomm DSP accelerator"
 	depends on DRM_ACCEL
 	depends on ARCH_QCOM || COMPILE_TEST
+	depends on RPMSG
 	help
 	  Enables the DRM-based accelerator driver for Qualcomm's Hexagon DSPs.
 	  This driver provides a standardized interface for offloading computational
diff --git a/drivers/accel/qda/Makefile b/drivers/accel/qda/Makefile
index 573711af1d28..e7f23182589b 100644
--- a/drivers/accel/qda/Makefile
+++ b/drivers/accel/qda/Makefile
@@ -5,4 +5,6 @@
 
 obj-$(CONFIG_DRM_ACCEL_QDA)	:= qda.o
 
-qda-y := qda_drv.o
+qda-y := \
+	qda_drv.o \
+	qda_rpmsg.o \
diff --git a/drivers/accel/qda/qda_drv.c b/drivers/accel/qda/qda_drv.c
index 18b0d3fb1598..389c66a9ad4f 100644
--- a/drivers/accel/qda/qda_drv.c
+++ b/drivers/accel/qda/qda_drv.c
@@ -2,16 +2,53 @@
 // Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
 #include <linux/module.h>
 #include <linux/kernel.h>
+#include <linux/atomic.h>
+#include "qda_drv.h"
+#include "qda_rpmsg.h"
+
+static void cleanup_device_resources(struct qda_dev *qdev)
+{
+	mutex_destroy(&qdev->lock);
+}
+
+void qda_deinit_device(struct qda_dev *qdev)
+{
+	cleanup_device_resources(qdev);
+}
+
+/* Initialize device resources */
+static void init_device_resources(struct qda_dev *qdev)
+{
+	qda_dbg(qdev, "Initializing device resources\n");
+
+	mutex_init(&qdev->lock);
+	atomic_set(&qdev->removing, 0);
+}
+
+int qda_init_device(struct qda_dev *qdev)
+{
+	init_device_resources(qdev);
+
+	qda_dbg(qdev, "QDA device initialized successfully\n");
+	return 0;
+}
 
 static int __init qda_core_init(void)
 {
-	pr_info("QDA: driver initialization complete\n");
+	int ret;
+
+	ret = qda_rpmsg_register();
+	if (ret)
+		return ret;
+
+	qda_info(NULL, "QDA driver initialization complete\n");
 	return 0;
 }
 
 static void __exit qda_core_exit(void)
 {
-	pr_info("QDA: driver exit complete\n");
+	qda_rpmsg_unregister();
+	qda_info(NULL, "QDA driver exit complete\n");
 }
 
 module_init(qda_core_init);
diff --git a/drivers/accel/qda/qda_drv.h b/drivers/accel/qda/qda_drv.h
new file mode 100644
index 000000000000..bec2d31ca1bb
--- /dev/null
+++ b/drivers/accel/qda/qda_drv.h
@@ -0,0 +1,91 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __QDA_DRV_H__
+#define __QDA_DRV_H__
+
+#include <linux/device.h>
+#include <linux/mutex.h>
+#include <linux/rpmsg.h>
+#include <linux/xarray.h>
+
+/* Driver identification */
+#define DRIVER_NAME "qda"
+
+/* struct qda_dev - Main device structure for QDA driver */
+struct qda_dev {
+	/* RPMsg device for communication with remote processor */
+	struct rpmsg_device *rpdev;
+	/* Underlying device structure */
+	struct device *dev;
+	/* Mutex protecting device state */
+	struct mutex lock;
+	/* Flag indicating device removal in progress */
+	atomic_t removing;
+	/* Name of the DSP (e.g., "cdsp", "adsp") */
+	char dsp_name[16];
+};
+
+/**
+ * qda_get_log_device - Get appropriate device for logging
+ * @qdev: QDA device structure
+ *
+ * Returns the most appropriate device structure for logging messages.
+ * Prefers qdev->dev, or returns NULL if the device is being removed
+ * or invalid.
+ */
+static inline struct device *qda_get_log_device(struct qda_dev *qdev)
+{
+	if (!qdev || atomic_read(&qdev->removing))
+		return NULL;
+
+	if (qdev->dev)
+		return qdev->dev;
+
+	return NULL;
+}
+
+/*
+ * Logging macros
+ *
+ * These macros provide consistent logging across the driver with automatic
+ * function name inclusion. They use dev_* functions when a device is available,
+ * falling back to pr_* functions otherwise.
+ */
+
+/* Error logging - always logs and tracks errors */
+#define qda_err(qdev, fmt, ...) do { \
+	struct device *__dev = qda_get_log_device(qdev); \
+	if (__dev) \
+		dev_err(__dev, "[%s] " fmt, __func__, ##__VA_ARGS__); \
+	else \
+		pr_err(DRIVER_NAME ": [%s] " fmt, __func__, ##__VA_ARGS__); \
+} while (0)
+
+/* Info logging - always logs, can be filtered via loglevel */
+#define qda_info(qdev, fmt, ...) do { \
+	struct device *__dev = qda_get_log_device(qdev); \
+	if (__dev) \
+		dev_info(__dev, "[%s] " fmt, __func__, ##__VA_ARGS__); \
+	else \
+		pr_info(DRIVER_NAME ": [%s] " fmt, __func__, ##__VA_ARGS__); \
+} while (0)
+
+/* Debug logging - controlled via dynamic debug (CONFIG_DYNAMIC_DEBUG) */
+#define qda_dbg(qdev, fmt, ...) do { \
+	struct device *__dev = qda_get_log_device(qdev); \
+	if (__dev) \
+		dev_dbg(__dev, "[%s] " fmt, __func__, ##__VA_ARGS__); \
+	else \
+		pr_debug(DRIVER_NAME ": [%s] " fmt, __func__, ##__VA_ARGS__); \
+} while (0)
+
+/*
+ * Core device management functions
+ */
+int qda_init_device(struct qda_dev *qdev);
+void qda_deinit_device(struct qda_dev *qdev);
+
+#endif /* __QDA_DRV_H__ */
diff --git a/drivers/accel/qda/qda_rpmsg.c b/drivers/accel/qda/qda_rpmsg.c
new file mode 100644
index 000000000000..a8b24a99ca13
--- /dev/null
+++ b/drivers/accel/qda/qda_rpmsg.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+#include <linux/module.h>
+#include <linux/rpmsg.h>
+#include <linux/of_platform.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include "qda_drv.h"
+#include "qda_rpmsg.h"
+
+static int qda_rpmsg_init(struct qda_dev *qdev)
+{
+	dev_set_drvdata(&qdev->rpdev->dev, qdev);
+	return 0;
+}
+
+/* Utility function to allocate and initialize qda_dev */
+static struct qda_dev *alloc_and_init_qdev(struct rpmsg_device *rpdev)
+{
+	struct qda_dev *qdev;
+
+	qdev = devm_kzalloc(&rpdev->dev, sizeof(*qdev), GFP_KERNEL);
+	if (!qdev)
+		return ERR_PTR(-ENOMEM);
+
+	qdev->dev = &rpdev->dev;
+	qdev->rpdev = rpdev;
+
+	qda_dbg(qdev, "Allocated and initialized qda_dev\n");
+	return qdev;
+}
+
+static int qda_rpmsg_cb(struct rpmsg_device *rpdev, void *data, int len, void *priv, u32 src)
+{
+	/* Dummy function for rpmsg driver */
+	return 0;
+}
+
+static void qda_rpmsg_remove(struct rpmsg_device *rpdev)
+{
+	struct qda_dev *qdev = dev_get_drvdata(&rpdev->dev);
+
+	qda_info(qdev, "Removing RPMsg device\n");
+
+	atomic_set(&qdev->removing, 1);
+
+	mutex_lock(&qdev->lock);
+	qdev->rpdev = NULL;
+	mutex_unlock(&qdev->lock);
+
+	qda_deinit_device(qdev);
+
+	qda_info(qdev, "RPMsg device removed\n");
+}
+
+static int qda_rpmsg_probe(struct rpmsg_device *rpdev)
+{
+	struct qda_dev *qdev;
+	int ret;
+	const char *label;
+
+	qda_dbg(NULL, "QDA RPMsg probe starting\n");
+
+	qdev = alloc_and_init_qdev(rpdev);
+	if (IS_ERR(qdev))
+		return PTR_ERR(qdev);
+
+	ret = of_property_read_string(rpdev->dev.of_node, "label", &label);
+	if (!ret) {
+		strscpy(qdev->dsp_name, label, sizeof(qdev->dsp_name));
+	} else {
+		qda_info(qdev, "QDA DSP label not found in DT\n");
+		return ret;
+	}
+
+	ret = qda_rpmsg_init(qdev);
+	if (ret) {
+		qda_err(qdev, "RPMsg init failed: %d\n", ret);
+		return ret;
+	}
+
+	ret = qda_init_device(qdev);
+	if (ret)
+		return ret;
+
+	qda_info(qdev, "QDA RPMsg probe completed successfully for %s\n", qdev->dsp_name);
+	return 0;
+}
+
+static const struct of_device_id qda_rpmsg_id_table[] = {
+	{ .compatible = "qcom,fastrpc" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, qda_rpmsg_id_table);
+
+static struct rpmsg_driver qda_rpmsg_driver = {
+	.probe = qda_rpmsg_probe,
+	.remove = qda_rpmsg_remove,
+	.callback = qda_rpmsg_cb,
+	.drv = {
+		.name = "qcom,fastrpc",
+		.of_match_table = qda_rpmsg_id_table,
+	},
+};
+
+int qda_rpmsg_register(void)
+{
+	int ret = register_rpmsg_driver(&qda_rpmsg_driver);
+
+	if (ret)
+		qda_err(NULL, "Failed to register RPMsg driver: %d\n", ret);
+
+	return ret;
+}
+
+void qda_rpmsg_unregister(void)
+{
+	unregister_rpmsg_driver(&qda_rpmsg_driver);
+}
diff --git a/drivers/accel/qda/qda_rpmsg.h b/drivers/accel/qda/qda_rpmsg.h
new file mode 100644
index 000000000000..348827bff255
--- /dev/null
+++ b/drivers/accel/qda/qda_rpmsg.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __QDA_RPMSG_H__
+#define __QDA_RPMSG_H__
+
+#include "qda_drv.h"
+
+/*
+ * Transport layer registration
+ */
+int qda_rpmsg_register(void);
+void qda_rpmsg_unregister(void);
+
+#endif /* __QDA_RPMSG_H__ */

-- 
2.34.1

