Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF45336A03B
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 19:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771873832; cv=none; b=b5GxWL5Ngmf+9jr1GEz27tyJUbeB1COHDst45Ws9M+83yMrX+Y1WpcYVCMbpAClYZ3EuoIXmyU8TWOXSEl1b2bxFzWoibehITOgESh4F2PQhCmOY7i+uyOnteJqWrrIHS1tppHlGDra5qffKl5FowEvoBe3GRcM4YzgHnBqyjD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771873832; c=relaxed/simple;
	bh=cPe6XiIaqlleCllXAqlYjNWCbV9gcpzWtKPjZ8WPpf8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BRiUB1USUj8QMbvE74gtQGtZvcI29fHbv4VKwIxLS+kTFcqQ8F0Y3HAvlVrU3xOH0xR8Vg/AaX5QhNOLPvKBp98LhEp0J14eymK0tETrsaN35RKJvfwdF8iUnFV9TRjE/3zx0rAn/wALJbbvAYESwcsVswVzXZQTL1tQ6ybE1eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mr0aOAlt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UxxMYioh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mr0aOAlt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UxxMYioh"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NGvaiR3478743
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 19:10:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4cWM5gPirp6izkRy//rcobyzuJsSsXAsmgnCXnHF9B0=; b=mr0aOAltrI4uJ7Y/
	eX9yHYbh93qOBnF0O2Jqi5e+eWUymu4EHSr+IRSR6gTZxrvMqgHZ6o1FClrysAH3
	pMZrf70/KSN/FcBb2TvAafzdorTIV4pVb4LiUtBBsF0Km8bD0I4tL6M7YTD+PGca
	4CNb3QtHn2c06AyXuTJyxX4vRMNwVn7Hxqo3Hio+v8Wbu7rCaEj44wddHPe6RanH
	GrilYYSFJwxyqM62A14LM/3SDVGNbRisSdICQwZWw3r+AMJwc8gQQsG3/33xl13e
	HPu3/IMadAw3RB4Z9G9QTr+krQ0RRdQjJBoCxtyld2upIJwRwgKRcmHlx4IB8xP8
	jzK1Qg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cgtv9re7h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 19:10:30 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2aad6045810so47849375ad.3
        for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 11:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771873829; x=1772478629; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4cWM5gPirp6izkRy//rcobyzuJsSsXAsmgnCXnHF9B0=;
        b=UxxMYiohQOAcCAVu1NzjGaTKulb8KFhSLxpmRyTf6Et5iAJkZqPVgzllADQm1acfFm
         1+MOHKviS7aCvmo32vcEeNGi/UTPgzIPnFvcZvDcY0BTHohpONR9h4KCedLaQzQoylTX
         j8A7sQeP3/v9D3TCSi9foqKxyaJSCPlysZJFld4XwyGWY9/fyVmT8Ls7F8y4i6oyQzQs
         wMYYk9g80iCKfGl1z3m1YlHYMzyIRmVHMhf8r7WeOsSA8K071m5vCJ7IMC23PWVxu0mC
         rvxCWbwJqSlhjje5cBmUtO7jNA0nRNNHLD28P0ZFFiqmOpV3CZRMG/Gr9xC7mAkCXuM8
         3xBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771873829; x=1772478629;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4cWM5gPirp6izkRy//rcobyzuJsSsXAsmgnCXnHF9B0=;
        b=nMXq8X2iRDlbHe4YyLJ+7jXCmJSRtZ5Ys2yo7f54EGVP6jTAqA6Ve/EvyQ/cPtC45H
         Y9yIWfJ/sGx60yNoKitu5aBHso2TtrwfvSEjMTjgsaGs4VPFabR5ubpwYP7NwErQxXto
         CAv7lnG6jj6pNc5EeQjfkz5X6qYFyCypHBAB+g7oMIzpOuyUDp+7X1mpqw+0LnEUwFVo
         /YgYCE2k1kZSI0NnbWWeaiRwCfK7jCRQ5DymCRwC9uBp1LdCiJmkpmTgLu3W8XcqDN2N
         4qzD+B0LeKXoW1f3MP8UtVbQEZb2dYOVdo60VbC9OcI4FqyXZ+xq71+wsOjT9aYRfq1R
         hTDg==
X-Forwarded-Encrypted: i=1; AJvYcCVrZmgESywEm3B2vvPvo54b0v+UYMtd3mx96hQ0mYAHek7jLYn88WcMex5Fn+KT8GHm8DYomA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwymW8jRM48PzUloAju2f0oVK1RGcFQJXz0dTwZy2DuQK4BBN/Y
	FbrcZvVL03pUuIMd4iaQ0z1uN8F3Waq2nZc/4p9wrLYPCdC+VfM34volHwI/AN9dnvLYu7tM3r/
	+FKWA82O8n6sNjAM7z4+mo0CzQ8s5QkMWnL3eXI7WKdmivigclFxDn7UKtw==
X-Gm-Gg: ATEYQzzrV6+z1VB6xmtcvDdZBiExTdS8raj6eH4cjvzKcjbPnxfZFScbdEcoV8MNI34
	Ab1KiHwnmV4k+6nEFpd7ANLZ42YmxfnwPJdoXFUlIuC63s0OZaOoT9ELuReM9dC1Aw1PM2EOIof
	njMgvOmT+VanXpkdk8014mUmke82DI9KsJHZI1p+ZVhC+CfJhdmWBKiSKkgRlsp+6wrfawb5KwT
	HUxYs3ZRiI+1VCWM0Rny5ip1RTGbO85i7ToXF33QmYdV4/4KpYRs+GLBFR0Q1gZYh8Uzdm2Zsry
	pTqlNdeGECn/CQVCvaJfQezL6V30AVf0rbEhZ7SguEaURZv8B1kRBSFHCXjPLcFLH0ildVkG0v0
	lc/bg7pR/PLtFWW8eQ0MxLGml2BU7xVqLSL8bXZwlcGF0H3v12JiNTw==
X-Received: by 2002:a17:903:2f8c:b0:2a9:451b:422 with SMTP id d9443c01a7336-2ad74439669mr84594615ad.14.1771873829348;
        Mon, 23 Feb 2026 11:10:29 -0800 (PST)
X-Received: by 2002:a17:903:2f8c:b0:2a9:451b:422 with SMTP id d9443c01a7336-2ad74439669mr84594305ad.14.1771873828808;
        Mon, 23 Feb 2026 11:10:28 -0800 (PST)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad74e34e18sm83501505ad.10.2026.02.23.11.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 11:10:28 -0800 (PST)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Date: Tue, 24 Feb 2026 00:39:03 +0530
Subject: [PATCH RFC 09/18] accel/qda: Add QUERY IOCTL and basic QDA UAPI
 header
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-qda-firstpost-v1-9-fe46a9c1a046@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771873753; l=6604;
 i=ekansh.gupta@oss.qualcomm.com; s=20260223; h=from:subject:message-id;
 bh=cPe6XiIaqlleCllXAqlYjNWCbV9gcpzWtKPjZ8WPpf8=;
 b=ZymVL6dioZif6Wgr4wJm47EDwZKmJDJvKkln1f30mqSxFcv/WXANZRzJ6HZOt0B38TaPvWsjI
 2zkyvEL7H+3AOLdSQuIn9G6ImRaRh4RXlXJ9NOWvLTJOVVCdBtH+0mj
X-Developer-Key: i=ekansh.gupta@oss.qualcomm.com; a=ed25519;
 pk=n0SepARizye+pYjhjg1RA5J+Nq4+IJbyRcBybU+/ERQ=
X-Authority-Analysis: v=2.4 cv=Vaf6/Vp9 c=1 sm=1 tr=0 ts=699ca626 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=xFwpPJ--XgJ2TdNcX9IA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDE2NiBTYWx0ZWRfX3z+9Vzqu3zi2
 3u8PCvzO96Us4lOmuwCkp3Cf/xfEHGXU//38myKziUStYeIfSxGDh1yO29X8NSJtYC5RmNjNDRo
 tpD6qlSSTn512ArWyPNP6iqzGNeq2EJbAGBg4CwW8Babj1PoPwS7MgOmI7fLngx07EM2jLDlEZl
 S7ywequAznnNplPsMTS1+izcU7a5pHG2KPJEqzKIvESvZSQl4bjRgJ2K4OQmDnAA+co/V5wIYrm
 zU5luKHqG/Yr3h32e5QTaaQNjoBFF2GFx8hzVnZ7WCMjmMaJGIDXTPm3XBic5GG27TKSmEMJ/G4
 l7n8zDGCLVcKYO4SL9Z/GGeJ6NxQ/miQf9t+oS0BqC+HK9+f3u1+ExRlsKP6u7IfFLz3IwJFzIq
 95/AE1Sng/JNPCPFSPzy8cbNjhLhchpJcf2RcfpR0EtsSM7obwKo03tS2A/k0UFIt1MLrgPcDNI
 KjrhrKCzZJoxymNua1w==
X-Proofpoint-ORIG-GUID: l38FewRKH-_vAUzuiVlUPyaYl1Z8_Cy2
X-Proofpoint-GUID: l38FewRKH-_vAUzuiVlUPyaYl1Z8_Cy2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_04,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 clxscore=1011 spamscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230166

Introduce a basic UAPI for the QDA accelerator driver along with a
DRM IOCTL handler to query DSP device identity. A new UAPI header
include/uapi/drm/qda_accel.h defines DRM_QDA_QUERY, the corresponding
DRM_IOCTL_QDA_QUERY command, and struct drm_qda_query, which contains
a DSP name string.

On the kernel side, qda_ioctl_query() validates the per-file context,
resolves the qda_dev instance from dev->dev_private, and copies the
DSP name from qdev->dsp_name into the query structure. The new
qda_ioctls[] table wires this IOCTL into the QDA DRM driver so
userspace can call it through the standard DRM command interface.

This IOCTL provides a simple and stable way for userspace to discover
which DSP a given QDA device node represents and serves as the first
building block for a richer QDA UAPI in subsequent patches.

Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
---
 drivers/accel/qda/Makefile    |  1 +
 drivers/accel/qda/qda_drv.c   |  9 +++++++++
 drivers/accel/qda/qda_ioctl.c | 45 +++++++++++++++++++++++++++++++++++++++++
 drivers/accel/qda/qda_ioctl.h | 26 ++++++++++++++++++++++++
 include/uapi/drm/qda_accel.h  | 47 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 128 insertions(+)

diff --git a/drivers/accel/qda/Makefile b/drivers/accel/qda/Makefile
index 7e96ddc40a24..f547398e1a72 100644
--- a/drivers/accel/qda/Makefile
+++ b/drivers/accel/qda/Makefile
@@ -10,5 +10,6 @@ qda-y := \
 	qda_rpmsg.o \
 	qda_cb.o \
 	qda_memory_manager.o \
+	qda_ioctl.o \
 
 obj-$(CONFIG_DRM_ACCEL_QDA_COMPUTE_BUS) += qda_compute_bus.o
diff --git a/drivers/accel/qda/qda_drv.c b/drivers/accel/qda/qda_drv.c
index bf95fc782cf8..86758a9cd982 100644
--- a/drivers/accel/qda/qda_drv.c
+++ b/drivers/accel/qda/qda_drv.c
@@ -9,7 +9,10 @@
 #include <drm/drm_file.h>
 #include <drm/drm_gem.h>
 #include <drm/drm_ioctl.h>
+#include <drm/qda_accel.h>
+
 #include "qda_drv.h"
+#include "qda_ioctl.h"
 #include "qda_rpmsg.h"
 
 static struct qda_drm_priv *get_drm_priv_from_device(struct drm_device *dev)
@@ -128,11 +131,17 @@ static void qda_postclose(struct drm_device *dev, struct drm_file *file)
 
 DEFINE_DRM_ACCEL_FOPS(qda_accel_fops);
 
+static const struct drm_ioctl_desc qda_ioctls[] = {
+	DRM_IOCTL_DEF_DRV(QDA_QUERY, qda_ioctl_query, 0),
+};
+
 static struct drm_driver qda_drm_driver = {
 	.driver_features = DRIVER_COMPUTE_ACCEL,
 	.fops			= &qda_accel_fops,
 	.open			= qda_open,
 	.postclose		= qda_postclose,
+	.ioctls = qda_ioctls,
+	.num_ioctls = ARRAY_SIZE(qda_ioctls),
 	.name = DRIVER_NAME,
 	.desc = "Qualcomm DSP Accelerator Driver",
 };
diff --git a/drivers/accel/qda/qda_ioctl.c b/drivers/accel/qda/qda_ioctl.c
new file mode 100644
index 000000000000..9fa73ec2dfce
--- /dev/null
+++ b/drivers/accel/qda/qda_ioctl.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+#include <drm/drm_ioctl.h>
+#include <drm/drm_gem.h>
+#include <drm/qda_accel.h>
+#include "qda_drv.h"
+#include "qda_ioctl.h"
+
+static int qda_validate_and_get_context(struct drm_device *dev, struct drm_file *file_priv,
+					struct qda_dev **qdev, struct qda_user **qda_user)
+{
+	struct qda_drm_priv *drm_priv = dev->dev_private;
+	struct qda_file_priv *qda_file_priv;
+
+	if (!drm_priv)
+		return -EINVAL;
+
+	*qdev = drm_priv->qdev;
+	if (!*qdev)
+		return -EINVAL;
+
+	qda_file_priv = (struct qda_file_priv *)file_priv->driver_priv;
+	if (!qda_file_priv || !qda_file_priv->qda_user)
+		return -EINVAL;
+
+	*qda_user = qda_file_priv->qda_user;
+
+	return 0;
+}
+
+int qda_ioctl_query(struct drm_device *dev, void *data, struct drm_file *file_priv)
+{
+	struct qda_dev *qdev;
+	struct qda_user *qda_user;
+	struct drm_qda_query *args = data;
+	int ret;
+
+	ret = qda_validate_and_get_context(dev, file_priv, &qdev, &qda_user);
+	if (ret)
+		return ret;
+
+	strscpy(args->dsp_name, qdev->dsp_name, sizeof(args->dsp_name));
+
+	return 0;
+}
diff --git a/drivers/accel/qda/qda_ioctl.h b/drivers/accel/qda/qda_ioctl.h
new file mode 100644
index 000000000000..6bf3bcd28c0e
--- /dev/null
+++ b/drivers/accel/qda/qda_ioctl.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef _QDA_IOCTL_H
+#define _QDA_IOCTL_H
+
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <drm/drm_ioctl.h>
+#include "qda_drv.h"
+
+/**
+ * qda_ioctl_query - Query DSP device information and capabilities
+ * @dev: DRM device structure
+ * @data: User-space data containing query parameters and results
+ * @file_priv: DRM file private data
+ *
+ * This IOCTL handler queries information about the DSP device.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int qda_ioctl_query(struct drm_device *dev, void *data, struct drm_file *file_priv);
+
+#endif /* _QDA_IOCTL_H */
diff --git a/include/uapi/drm/qda_accel.h b/include/uapi/drm/qda_accel.h
new file mode 100644
index 000000000000..0aad791c4832
--- /dev/null
+++ b/include/uapi/drm/qda_accel.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __QDA_ACCEL_H__
+#define __QDA_ACCEL_H__
+
+#include "drm.h"
+
+#if defined(__cplusplus)
+extern "C" {
+#endif
+
+/*
+ * QDA IOCTL command numbers
+ *
+ * These define the command numbers for QDA-specific IOCTLs.
+ * They are used with DRM_COMMAND_BASE to create the full IOCTL numbers.
+ */
+#define DRM_QDA_QUERY	0x00
+/*
+ * QDA IOCTL definitions
+ *
+ * These macros define the actual IOCTL numbers used by userspace applications.
+ * They combine the command numbers with DRM_COMMAND_BASE and specify the
+ * data structure and direction (read/write) for each IOCTL.
+ */
+#define DRM_IOCTL_QDA_QUERY	DRM_IOR(DRM_COMMAND_BASE + DRM_QDA_QUERY, struct drm_qda_query)
+
+/**
+ * struct drm_qda_query - Device information query structure
+ * @dsp_name: Name of DSP (e.g., "adsp", "cdsp", "cdsp1", "gdsp0", "gdsp1")
+ *
+ * This structure is used with DRM_IOCTL_QDA_QUERY to query device type,
+ * allowing userspace to identify which DSP a device node represents. The
+ * kernel provides the DSP name directly as a null-terminated string.
+ */
+struct drm_qda_query {
+	__u8 dsp_name[16];
+};
+
+#if defined(__cplusplus)
+}
+#endif
+
+#endif /* __QDA_ACCEL_H__ */

-- 
2.34.1

