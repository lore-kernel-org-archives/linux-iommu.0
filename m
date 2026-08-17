Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E923290B9
	for <iommu@lists.linux.dev>; Mon, 17 Aug 2026 04:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786942149; cv=none; b=mNNaZd8DxEq8UuXJUtO5Cs7y91brWKWUIvWQPd19KCkq8W0SPj9Q0anUMvBZV0VtJVhIoDW1gta56YE8PqrnW1C2mpE+YmYa9DB+bpZkrfIlx3R6erdiORgRa3LVqU7Saju0YWTZqypToIuZunhRXcBCq4NBKaSvPBkLB9ucB1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786942149; c=relaxed/simple;
	bh=3a40T88Ttftfhd8rY0565omKqH0hQXysBy4bcauR63Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HLBpslHZCFkIrpgbALbj06ZssNhTIr9/RuTq+41OEvl/IJGhA1rszdywRneYNHwwDUzWyymoFCqT9RFheUYnLu2is4OnPDktJihgWDZXP53B9tq4NMzB/EIhtwejIpk3YeAeplUqatLV63n3ivkOgPKU1l1Or5bUVffonGk/OZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WLmRz6qg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q+1p+4bj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WLmRz6qg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q+1p+4bj"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67GLCfHS4058475
	for <iommu@lists.linux.dev>; Mon, 17 Aug 2026 04:49:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xtNZhPRfPIsrhmbaHits7E3dniqDAdMJ7RDyy78PBz0=; b=WLmRz6qgcnHoWMuE
	3IJbBWbdWdt7mRyR2KWpyLzzxaNoykZ0kqBxlPdX7aQkZJ7iEDnSABcUtyA+kdVP
	zo81BaA28l78zxImWb+alfvgcK6G4rY16kslLA67dsEZsDt/J8GXzcP7hIoMRyw5
	B94DLtmdvVD56w+mqjrE6shMd/9/l8AXz4BKSQ/Cpcn5An2bKprt7SjwM9/2Ppph
	yy+TVHU9hPiuaw4bmCr2ylIE2x5+1CtgZIXQICWrXkc/3NDa8M4PJWisSw3cWAv6
	VSDnK6+mRMepNMaOsK4EbUlZaC/sEGwp6QO2TSeyLgvmbcfJ4b5kGlCSznpOv+fF
	MsG+Mg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2hd7w1ys-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 17 Aug 2026 04:49:05 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cb5cc1e139bso2183634a12.3
        for <iommu@lists.linux.dev>; Sun, 16 Aug 2026 21:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786942145; x=1787546945; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xtNZhPRfPIsrhmbaHits7E3dniqDAdMJ7RDyy78PBz0=;
        b=Q+1p+4bjZTYCru2Mt6sfTbHZQPbBPC4cCRPFFjd/6byPru4BhrwtuloiEhjXTM7V9x
         yzDRs6EiPiW9IYkw4K+FJ9fvIyaKlm7blq4miWmNlPr8wpbWmh68Qxr/w7Wk8KBxf+sG
         ewj92RQih+xnk5gEVZvLnnM371T+JK6OTOtcTkICQg3TU9sEIoXDUSE1vnDdrdAhoL2I
         GiR5whgkKovsEBb7MGZX45JkQFWoK/3ti73lN8YP1SfiucUOfsIgAbHi9vyTmA+VLBx8
         rDhfNDV5B45zcg/EHB3Alb5wf99Eh9ldv3Exoo+kmoNPit/8xafRnzssQ8b20MURItae
         mw5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786942145; x=1787546945;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xtNZhPRfPIsrhmbaHits7E3dniqDAdMJ7RDyy78PBz0=;
        b=fAgc6UgyOGjMxY60j0A0MvQqNTYMcNbJwxrZ/47tI3/cU22l+P7Sqj+Bb2QmJOuvGL
         uYy1xlPTdy4V0/0GzP02eXB7th7ym+Pw52J76p1GtmeEjFAMe0Kp8MZuVgX7ya+6Zedt
         cZJfFf5aeDpv71hJv8Z9ZRIVikV8oqD/VmaENNQM95NoCJja2/SwjjeZvmg8YEFvnLl4
         PVffda/pzoQYK86Tx8bU8GGeKcPMdYD/hg5i9ZpyzRCIBLH2yj7SbepBg/eqQeEJeTsA
         4QRzDxfyAP3M/flJpez/yqhQhs11AL+zg1zRo4pIwwnznWDUod+niLQ4TWldnkNO26BF
         I2NQ==
X-Forwarded-Encrypted: i=1; AHgh+RrrI+55j0X4oxiTeGI7Ki3J4BtQfwiGGJIA6TI2wZ5Tj+XjtpqrUOp7271xjUYtl3ue2RJ00Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyX+EdzSQiFscGG0aZVvSdTFoFC6mc4QkSK/apPuqidiTVCXdXy
	rSX3mAC+wL4zQX6QwHS2L+38rfn6rebxlT99mzWHD8ckru+2X03Zg19/R/UcuD+S72iGTT2K7AH
	eiclbV6wdMKCylx8qTQzfd3ny3CdqBCCJuolho1AeVugFfAjWsdCEZIu2tg==
X-Gm-Gg: AR+sD13iEeOWrIfO0DjHkH+kBVXVHROFtLOA6STSTGetOSpxDIPSTdc57/vAjbgNi6T
	c3pIEHPuRNzJfITC7sH/WhrjUHxkoQfUIIYzTcZPn/Qgw7xOsbBAn+PtdsSiDoJgZ38izTwvi+l
	zlf7Gqo1t+XjP1MiE+QbH0PK8xR5u5+W+8uT9WevxVYTYfz03Rb8OkrtTbHeTWagZ0915Dv5aKV
	FhVzkYkDLsmV7aU1MCj4trGrnSCsCWjr6FKwNpCk6W9IBJAxFbsOKgPXAD3whOXWMkP/knItk8X
	1pjk2ufi2kBlALtZw/oGpTs3ENr6zyUb3nd01sUs+/7IMtI/8V5Yq72pr9AFROC+5MY3VTZOLYa
	v7vzOAEmyeMnwQVgj+QQbGdaykM3Yg+sa
X-Received: by 2002:a05:6a00:408b:b0:82f:2b0:2809 with SMTP id d2e1a72fcca58-84fde3651cemr22884366b3a.1.1786942144893;
        Sun, 16 Aug 2026 21:49:04 -0700 (PDT)
X-Received: by 2002:a05:6a00:408b:b0:82f:2b0:2809 with SMTP id d2e1a72fcca58-84fde3651cemr22884318b3a.1.1786942144318;
        Sun, 16 Aug 2026 21:49:04 -0700 (PDT)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8517d046638sm2149250b3a.27.2026.08.16.21.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 21:49:03 -0700 (PDT)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 10:17:44 +0530
Subject: [PATCH v2 09/15] accel/qda: Add DMA-backed GEM objects and memory
 manager integration
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260817-qda-v2-v2-9-69a02e9090d4@oss.qualcomm.com>
References: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
In-Reply-To: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
To: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
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
        =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Bharath Kumar <quic_bkumar@quicinc.com>,
        Chenna Kesava Raju <quic_chennak@quicinc.com>,
        srinivas.kandagatla@oss.qualcomm.com,
        dmitry.baryshkov@oss.qualcomm.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, llvm@lists.linux.dev,
        iommu@lists.linux.dev, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org,
        Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786942058; l=25515;
 i=ekansh.gupta@oss.qualcomm.com; s=20260223; h=from:subject:message-id;
 bh=3a40T88Ttftfhd8rY0565omKqH0hQXysBy4bcauR63Q=;
 b=4mmvzlFYYtEbvgmF05BD7BOcE3myoi7FufemkBr4ZowgZdfm5GxtZYdABZMFFU6AFT8qfGZ/r
 xmO4lYLN4HZBWNsbOhJ5/NDlfg/S7lz///ZaKl3X9RwFIzKlM3tk1Tg
X-Developer-Key: i=ekansh.gupta@oss.qualcomm.com; a=ed25519;
 pk=n0SepARizye+pYjhjg1RA5J+Nq4+IJbyRcBybU+/ERQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDAzMyBTYWx0ZWRfX7K4G+MUYya2m
 BWar84naeHLUDgntj22gjD4PfWjKVJ8N4YWZASJsKlAMLvSqiWCYvKQ+dbnDSCBu+DfIDzZ/w8Z
 Iz6CiDR3N7BZHh4oJ+82uTNmMjJ79GEstCsaj3DgD8+sduPoPSzvOyzHzq8ZZZjHVkFUhuDK6Lr
 be3zk+hiD8egETLT1zQTKNc6EKyqyzk6MxbFBMC/OWpC6OilDVVUteZvS8NDSpSWQQTWgp9f2hP
 9SqVs8N4eQBetIeNIe6digPAxixR+FkqFtEvmpWAKR+RH7qeKyzoUeb3U6AL8WXUZdQLKhH/RCI
 9wAyXSa/tH6za07uEPuHJqkU8QQspDVvUPPDmh6fu2mLTgV+A6K7wlBY9zY58pqfLkVrNQ3GHIl
 WbMyjnv+X4O4ORhuI/gaLbBj8C4ZYgsFv9l+eGENRQbWfzUntzaubmpd/se862gQSCAK+4b0Kkl
 Nk/emszdpotL+MitX0A==
X-Proofpoint-GUID: 202gv4cr_ok791jWU_MeqZvPj13oA54r
X-Authority-Analysis: v=2.4 cv=Ja2Ma0KV c=1 sm=1 tr=0 ts=6a8292c1 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=3AIGk1epJBJNjeN8eX0A:9 a=UoYv2gdXUR36Upsk:21
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: 202gv4cr_ok791jWU_MeqZvPj13oA54r
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDAzMyBTYWx0ZWRfX854s/dE6g367
 GoDHYXU17WE9HlbQVMPvWYiSRxmmzyKBiDbMeB/Bm5bAtyKIbzcyHwlXlpQfaqBssVkjz44MKua
 3F4yKwONO9K/2opMe4p4fYsu+4W81vo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 impostorscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170033

Introduce DMA-coherent buffer management for the QDA driver, wiring
together the GEM subsystem, the IOMMU memory manager, and a DMA
allocation backend.

qda_gem.c / qda_gem.h
  Implements the GEM object lifecycle for QDA buffers. Each buffer is
  represented by a qda_gem_obj which embeds a drm_gem_object and
  carries the kernel virtual address, DMA address, and a pointer to
  the IOMMU device that performed the allocation. The .free callback
  delegates to the memory manager, and the .mmap callback uses
  dma_mmap_coherent() via the DMA backend.

qda_memory_dma.c / qda_memory_dma.h
  DMA coherent allocation backend. qda_dma_alloc() calls
  dma_alloc_coherent() on the CB device and encodes the stream ID
  (SID) in the upper 32 bits of the returned DMA address, following
  the Qualcomm FastRPC convention for IOMMU address space tagging.
  qda_dma_free() strips the SID prefix before calling
  dma_free_coherent().

qda_memory_manager.c
  Adds process-to-device assignment: each DRM file (process) is
  assigned one IOMMU context bank device for the lifetime of the
  session. qda_memory_manager_assign_device() first checks whether
  the process already has a device (reusing it with a refcount
  increment), then falls back to claiming an unassigned device.
  qda_memory_manager_alloc() and qda_memory_manager_free() delegate
  to the DMA backend after resolving the correct CB device for the
  calling process.

qda_drv.c / qda_drv.h
  qda_file_priv gains an assigned_iommu_dev pointer and a pid field.
  The .postclose callback decrements the IOMMU device refcount and
  clears the process assignment when the last reference is dropped.

Assisted-by: Claude:claude-sonnet-5
Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
---
Changes in v2:
- Adapt to the dynamically-sized device array introduced in patch 07
  (kcalloc'd from DT node count, replaces fixed QDA_IOMMU_DEVICES_MAX)
- Protect register/unregister with the process_assignment_lock mutex so
  the device-assignment and device-registration paths are serialised
- No functional changes requested by reviewers on this patch
---
 drivers/accel/qda/Makefile             |   2 +
 drivers/accel/qda/qda_drv.c            |   4 +
 drivers/accel/qda/qda_drv.h            |   4 +
 drivers/accel/qda/qda_gem.c            | 134 ++++++++++++++++++
 drivers/accel/qda/qda_gem.h            |  52 +++++++
 drivers/accel/qda/qda_memory_dma.c     |  82 +++++++++++
 drivers/accel/qda/qda_memory_dma.h     |  17 +++
 drivers/accel/qda/qda_memory_manager.c | 239 ++++++++++++++++++++++++++++++++-
 drivers/accel/qda/qda_memory_manager.h |  30 +++++
 9 files changed, 559 insertions(+), 5 deletions(-)

diff --git a/drivers/accel/qda/Makefile b/drivers/accel/qda/Makefile
index b658dad35fee..a46ddceecfc5 100644
--- a/drivers/accel/qda/Makefile
+++ b/drivers/accel/qda/Makefile
@@ -8,7 +8,9 @@ obj-$(CONFIG_DRM_ACCEL_QDA)	:= qda.o
 qda-y := \
 	qda_cb.o \
 	qda_drv.o \
+	qda_gem.o \
 	qda_ioctl.o \
+	qda_memory_dma.o \
 	qda_memory_manager.o \
 	qda_rpmsg.o
 
diff --git a/drivers/accel/qda/qda_drv.c b/drivers/accel/qda/qda_drv.c
index e1fd8bfa12d7..2b14dab95507 100644
--- a/drivers/accel/qda/qda_drv.c
+++ b/drivers/accel/qda/qda_drv.c
@@ -21,6 +21,7 @@ static int qda_open(struct drm_device *dev, struct drm_file *file)
 	if (!qda_file_priv)
 		return -ENOMEM;
 
+	qda_file_priv->pid = current->pid;
 	qda_file_priv->qda_dev = qda_dev_from_drm(dev);
 	file->driver_priv = qda_file_priv;
 
@@ -31,6 +32,9 @@ static void qda_postclose(struct drm_device *dev, struct drm_file *file)
 {
 	struct qda_file_priv *qda_file_priv = file->driver_priv;
 
+	if (qda_file_priv->assigned_iommu_dev)
+		qda_memory_manager_release_device(qda_file_priv->assigned_iommu_dev);
+
 	kfree(qda_file_priv);
 	file->driver_priv = NULL;
 }
diff --git a/drivers/accel/qda/qda_drv.h b/drivers/accel/qda/qda_drv.h
index 690a833d732b..2fe58f3efec0 100644
--- a/drivers/accel/qda/qda_drv.h
+++ b/drivers/accel/qda/qda_drv.h
@@ -24,6 +24,10 @@
 struct qda_file_priv {
 	/** @qda_dev: Back-pointer to device structure */
 	struct qda_dev *qda_dev;
+	/** @assigned_iommu_dev: IOMMU device assigned to this process */
+	struct qda_iommu_device *assigned_iommu_dev;
+	/** @pid: Process ID for tracking */
+	pid_t pid;
 };
 
 /**
diff --git a/drivers/accel/qda/qda_gem.c b/drivers/accel/qda/qda_gem.c
new file mode 100644
index 000000000000..66e78013a726
--- /dev/null
+++ b/drivers/accel/qda/qda_gem.c
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+#include <drm/drm_gem.h>
+#include <drm/drm_prime.h>
+#include <drm/drm_print.h>
+#include <linux/slab.h>
+#include <linux/dma-mapping.h>
+#include "qda_drv.h"
+#include "qda_gem.h"
+#include "qda_memory_manager.h"
+#include "qda_memory_dma.h"
+
+/**
+ * qda_gem_free_object() - Free a GEM object and its associated resources
+ * @gem_obj: DRM GEM object to free
+ */
+void qda_gem_free_object(struct drm_gem_object *gem_obj)
+{
+	struct qda_gem_obj *qda_gem_obj = to_qda_gem_obj(gem_obj);
+	struct qda_dev *qdev = qda_dev_from_drm(gem_obj->dev);
+
+	if (qda_gem_obj->virt && qdev->iommu_mgr)
+		qda_memory_manager_free(qdev->iommu_mgr, qda_gem_obj);
+
+	drm_gem_object_release(gem_obj);
+	kfree(qda_gem_obj);
+}
+
+/**
+ * qda_gem_mmap_obj() - Map a GEM object into userspace
+ * @drm_obj: DRM GEM object to map
+ * @vma: Virtual memory area to map into
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int qda_gem_mmap_obj(struct drm_gem_object *drm_obj, struct vm_area_struct *vma)
+{
+	struct qda_gem_obj *qda_gem_obj = to_qda_gem_obj(drm_obj);
+	int ret;
+
+	/* The fake offset is only used to find the object, not to index it */
+	vma->vm_pgoff = 0;
+
+	ret = qda_dma_mmap(qda_gem_obj, vma);
+	if (ret)
+		return ret;
+
+	vm_flags_set(vma, VM_DONTEXPAND | VM_DONTDUMP);
+
+	return 0;
+}
+
+static const struct drm_gem_object_funcs qda_gem_object_funcs = {
+	.free = qda_gem_free_object,
+	.mmap = qda_gem_mmap_obj,
+};
+
+/**
+ * qda_gem_alloc_object() - Allocate a new QDA GEM object
+ * @drm_dev: DRM device
+ * @aligned_size: Size of the object in bytes (must be page-aligned)
+ *
+ * Return: Pointer to the new GEM object, or ERR_PTR on failure
+ */
+struct qda_gem_obj *qda_gem_alloc_object(struct drm_device *drm_dev, size_t aligned_size)
+{
+	struct qda_gem_obj *qda_gem_obj;
+	int ret;
+
+	qda_gem_obj = kzalloc_obj(*qda_gem_obj);
+	if (!qda_gem_obj)
+		return ERR_PTR(-ENOMEM);
+
+	ret = drm_gem_object_init(drm_dev, &qda_gem_obj->base, aligned_size);
+	if (ret) {
+		kfree(qda_gem_obj);
+		return ERR_PTR(ret);
+	}
+
+	qda_gem_obj->base.funcs = &qda_gem_object_funcs;
+	qda_gem_obj->size = aligned_size;
+
+	return qda_gem_obj;
+}
+
+void qda_gem_cleanup_object(struct qda_gem_obj *qda_gem_obj)
+{
+	drm_gem_object_release(&qda_gem_obj->base);
+	kfree(qda_gem_obj);
+}
+
+int qda_gem_create_handle(struct drm_file *file_priv, struct drm_gem_object *gem_obj, u32 *handle)
+{
+	int ret;
+
+	ret = drm_gem_handle_create(file_priv, gem_obj, handle);
+	drm_gem_object_put(gem_obj);
+
+	return ret;
+}
+
+/**
+ * qda_gem_create_object() - Allocate and initialize a GEM object with DMA backing
+ * @drm_dev: DRM device
+ * @iommu_mgr: Memory manager to use for DMA allocation
+ * @size: Requested size in bytes
+ * @file_priv: DRM file private data for process association
+ *
+ * Return: Pointer to the base DRM GEM object on success, ERR_PTR on failure
+ */
+struct drm_gem_object *qda_gem_create_object(struct drm_device *drm_dev,
+					     struct qda_memory_manager *iommu_mgr, size_t size,
+					     struct drm_file *file_priv)
+{
+	struct qda_gem_obj *qda_gem_obj;
+	size_t aligned_size;
+	int ret;
+
+	aligned_size = PAGE_ALIGN(size);
+	if (!aligned_size)
+		return ERR_PTR(-EINVAL);
+
+	qda_gem_obj = qda_gem_alloc_object(drm_dev, aligned_size);
+	if (IS_ERR(qda_gem_obj))
+		return ERR_CAST(qda_gem_obj);
+
+	ret = qda_memory_manager_alloc(iommu_mgr, qda_gem_obj, file_priv);
+	if (ret) {
+		qda_gem_cleanup_object(qda_gem_obj);
+		return ERR_PTR(ret);
+	}
+
+	return &qda_gem_obj->base;
+}
diff --git a/drivers/accel/qda/qda_gem.h b/drivers/accel/qda/qda_gem.h
new file mode 100644
index 000000000000..afd7c9b49549
--- /dev/null
+++ b/drivers/accel/qda/qda_gem.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+#ifndef __QDA_GEM_H__
+#define __QDA_GEM_H__
+
+#include <linux/dma-mapping.h>
+#include <drm/drm_device.h>
+#include <drm/drm_gem.h>
+#include "qda_memory_manager.h"
+
+/**
+ * struct qda_gem_obj - QDA GEM buffer object
+ *
+ * Represents a GEM buffer object that can be allocated by the driver
+ * or imported from another driver via DMA-BUF.
+ */
+struct qda_gem_obj {
+	/** @base: DRM GEM object base — must be first member */
+	struct drm_gem_object base;
+	/** @iommu_dev: IOMMU context bank device that performed the allocation */
+	struct qda_iommu_device *iommu_dev;
+	/** @virt: Kernel virtual address of the allocated DMA memory */
+	void *virt;
+	/** @dma_addr: DMA address (with SID encoded in upper 32 bits) */
+	dma_addr_t dma_addr;
+	/** @size: Size of the buffer in bytes */
+	size_t size;
+};
+
+/**
+ * to_qda_gem_obj - Cast a drm_gem_object pointer to qda_gem_obj
+ * @gem_obj: Pointer to the embedded drm_gem_object
+ */
+#define to_qda_gem_obj(gem_obj) container_of(gem_obj, struct qda_gem_obj, base)
+
+/* GEM object lifecycle */
+struct drm_gem_object *qda_gem_create_object(struct drm_device *drm_dev,
+					     struct qda_memory_manager *iommu_mgr,
+					     size_t size, struct drm_file *file_priv);
+void qda_gem_free_object(struct drm_gem_object *gem_obj);
+int qda_gem_mmap_obj(struct drm_gem_object *gem_obj, struct vm_area_struct *vma);
+
+/* Internal helpers (also used by PRIME import) */
+struct qda_gem_obj *qda_gem_alloc_object(struct drm_device *drm_dev, size_t aligned_size);
+void qda_gem_cleanup_object(struct qda_gem_obj *qda_gem_obj);
+
+/* Utility functions */
+int qda_gem_create_handle(struct drm_file *file_priv, struct drm_gem_object *gem_obj, u32 *handle);
+
+#endif /* __QDA_GEM_H__ */
diff --git a/drivers/accel/qda/qda_memory_dma.c b/drivers/accel/qda/qda_memory_dma.c
new file mode 100644
index 000000000000..7072ed8edf0b
--- /dev/null
+++ b/drivers/accel/qda/qda_memory_dma.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+#include <linux/slab.h>
+#include <linux/dma-mapping.h>
+#include "qda_drv.h"
+#include "qda_gem.h"
+#include "qda_memory_dma.h"
+
+/*
+ * The DSP identifies the IOMMU context bank from the upper bits of the address,
+ * so the stream ID is folded into every address handed to it. The DMA API only
+ * ever sees the plain 32-bit address, which is why the context bank devices are
+ * created with a 32-bit DMA mask.
+ */
+static dma_addr_t get_actual_dma_addr(struct qda_gem_obj *gem_obj)
+{
+	return gem_obj->dma_addr - ((u64)gem_obj->iommu_dev->sid << 32);
+}
+
+static void setup_gem_object(struct qda_gem_obj *gem_obj, void *virt,
+			     dma_addr_t dma_addr, struct qda_iommu_device *iommu_dev)
+{
+	gem_obj->virt = virt;
+	gem_obj->dma_addr = dma_addr;
+	gem_obj->iommu_dev = iommu_dev;
+}
+
+static void cleanup_gem_object_fields(struct qda_gem_obj *gem_obj)
+{
+	gem_obj->virt = NULL;
+	gem_obj->dma_addr = 0;
+	gem_obj->iommu_dev = NULL;
+}
+
+/**
+ * qda_dma_alloc() - Allocate DMA coherent memory for a GEM object
+ * @iommu_dev: Pointer to the QDA IOMMU device structure
+ * @gem_obj: Pointer to GEM object to allocate memory for
+ * @size: Size of memory to allocate in bytes
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int qda_dma_alloc(struct qda_iommu_device *iommu_dev,
+		  struct qda_gem_obj *gem_obj, size_t size)
+{
+	dma_addr_t dma_addr;
+	void *virt;
+
+	virt = dma_alloc_coherent(iommu_dev->dev, size, &dma_addr, GFP_KERNEL);
+	if (!virt)
+		return -ENOMEM;
+
+	dma_addr += ((u64)iommu_dev->sid << 32);
+	setup_gem_object(gem_obj, virt, dma_addr, iommu_dev);
+
+	return 0;
+}
+
+/**
+ * qda_dma_free() - Free DMA coherent memory for a GEM object
+ * @gem_obj: Pointer to GEM object to free memory for
+ */
+void qda_dma_free(struct qda_gem_obj *gem_obj)
+{
+	dma_free_coherent(gem_obj->iommu_dev->dev, gem_obj->size,
+			  gem_obj->virt, get_actual_dma_addr(gem_obj));
+
+	cleanup_gem_object_fields(gem_obj);
+}
+
+/**
+ * qda_dma_mmap() - Map DMA memory into userspace
+ * @gem_obj: Pointer to GEM object containing DMA memory
+ * @vma: Virtual memory area to map into
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int qda_dma_mmap(struct qda_gem_obj *gem_obj, struct vm_area_struct *vma)
+{
+	return dma_mmap_coherent(gem_obj->iommu_dev->dev, vma, gem_obj->virt,
+				 get_actual_dma_addr(gem_obj), gem_obj->size);
+}
diff --git a/drivers/accel/qda/qda_memory_dma.h b/drivers/accel/qda/qda_memory_dma.h
new file mode 100644
index 000000000000..99352a99dc33
--- /dev/null
+++ b/drivers/accel/qda/qda_memory_dma.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __QDA_MEMORY_DMA_H__
+#define __QDA_MEMORY_DMA_H__
+
+#include <linux/dma-mapping.h>
+#include "qda_memory_manager.h"
+
+int qda_dma_alloc(struct qda_iommu_device *iommu_dev,
+		  struct qda_gem_obj *gem_obj, size_t size);
+void qda_dma_free(struct qda_gem_obj *gem_obj);
+int qda_dma_mmap(struct qda_gem_obj *gem_obj, struct vm_area_struct *vma);
+
+#endif /* __QDA_MEMORY_DMA_H__ */
diff --git a/drivers/accel/qda/qda_memory_manager.c b/drivers/accel/qda/qda_memory_manager.c
index b1a80ee77c35..d47c7419e11d 100644
--- a/drivers/accel/qda/qda_memory_manager.c
+++ b/drivers/accel/qda/qda_memory_manager.c
@@ -1,14 +1,26 @@
 // SPDX-License-Identifier: GPL-2.0-only
 // Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
 
+#include <linux/refcount.h>
 #include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <drm/drm_file.h>
+#include <drm/drm_print.h>
 #include "qda_drv.h"
+#include "qda_gem.h"
 #include "qda_memory_manager.h"
+#include "qda_memory_dma.h"
+
+static void iommu_device_free(struct kref *ref)
+{
+	kfree(container_of(ref, struct qda_iommu_device, ref));
+}
 
 static void cleanup_all_memory_devices(struct qda_memory_manager *mem_mgr)
 {
 	int i;
 
+	mutex_lock(&mem_mgr->process_assignment_lock);
 	for (i = 0; i < mem_mgr->num_devices; i++) {
 		struct qda_iommu_device *iommu_dev = mem_mgr->devices[i];
 
@@ -16,9 +28,215 @@ static void cleanup_all_memory_devices(struct qda_memory_manager *mem_mgr)
 			continue;
 
 		mem_mgr->devices[i] = NULL;
-		kfree(iommu_dev);
+		kref_put(&iommu_dev->ref, iommu_device_free);
 	}
 	mem_mgr->num_devices = 0;
+	mutex_unlock(&mem_mgr->process_assignment_lock);
+}
+
+static void init_iommu_device_fields(struct qda_iommu_device *iommu_dev)
+{
+	spin_lock_init(&iommu_dev->lock);
+	refcount_set(&iommu_dev->users, 0);
+	kref_init(&iommu_dev->ref);
+	iommu_dev->assigned_pid = 0;
+	iommu_dev->assigned_file_priv = NULL;
+}
+
+static struct qda_iommu_device *find_device_for_pid(struct qda_memory_manager *mem_mgr,
+						    pid_t pid)
+{
+	struct qda_iommu_device *found_dev = NULL;
+	unsigned long flags;
+	int i;
+
+	for (i = 0; i < mem_mgr->num_devices; i++) {
+		struct qda_iommu_device *iommu_dev = mem_mgr->devices[i];
+
+		if (!iommu_dev)
+			continue;
+
+		spin_lock_irqsave(&iommu_dev->lock, flags);
+		if (iommu_dev->assigned_pid == pid) {
+			found_dev = iommu_dev;
+			refcount_inc(&found_dev->users);
+			kref_get(&found_dev->ref);
+			spin_unlock_irqrestore(&iommu_dev->lock, flags);
+			break;
+		}
+		spin_unlock_irqrestore(&iommu_dev->lock, flags);
+	}
+
+	return found_dev;
+}
+
+static struct qda_iommu_device *assign_available_device_to_pid(struct qda_memory_manager *mem_mgr,
+							       pid_t pid,
+							       struct drm_file *file_priv)
+{
+	struct qda_iommu_device *selected_dev = NULL;
+	unsigned long flags;
+	int i;
+
+	for (i = 0; i < mem_mgr->num_devices; i++) {
+		struct qda_iommu_device *iommu_dev = mem_mgr->devices[i];
+
+		if (!iommu_dev)
+			continue;
+
+		spin_lock_irqsave(&iommu_dev->lock, flags);
+		if (iommu_dev->assigned_pid == 0) {
+			iommu_dev->assigned_pid = pid;
+			iommu_dev->assigned_file_priv = file_priv;
+			selected_dev = iommu_dev;
+			refcount_set(&selected_dev->users, 1);
+			kref_get(&selected_dev->ref);
+			spin_unlock_irqrestore(&iommu_dev->lock, flags);
+			break;
+		}
+		spin_unlock_irqrestore(&iommu_dev->lock, flags);
+	}
+
+	return selected_dev;
+}
+
+static struct qda_iommu_device *get_process_iommu_device(struct qda_memory_manager *mem_mgr,
+							 struct drm_file *file_priv)
+{
+	struct qda_file_priv *qda_priv;
+
+	if (!file_priv || !file_priv->driver_priv)
+		return NULL;
+
+	qda_priv = (struct qda_file_priv *)file_priv->driver_priv;
+	return qda_priv->assigned_iommu_dev;
+}
+
+/**
+ * qda_memory_manager_assign_device() - Assign an IOMMU device to a process
+ * @mem_mgr: Pointer to memory manager
+ * @file_priv: DRM file private data for process association
+ *
+ * On success the caller owns a reference on the device and must release it
+ * with qda_memory_manager_release_device().
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int qda_memory_manager_assign_device(struct qda_memory_manager *mem_mgr,
+				     struct drm_file *file_priv)
+{
+	struct qda_file_priv *qda_priv;
+	struct qda_iommu_device *selected_dev = NULL;
+	int ret = 0;
+	pid_t current_pid;
+
+	if (!file_priv || !file_priv->driver_priv)
+		return -EINVAL;
+
+	qda_priv = (struct qda_file_priv *)file_priv->driver_priv;
+	current_pid = qda_priv->pid;
+
+	mutex_lock(&mem_mgr->process_assignment_lock);
+
+	if (qda_priv->assigned_iommu_dev) {
+		ret = 0;
+		goto unlock_and_return;
+	}
+
+	selected_dev = find_device_for_pid(mem_mgr, current_pid);
+
+	if (selected_dev) {
+		qda_priv->assigned_iommu_dev = selected_dev;
+		goto unlock_and_return;
+	}
+
+	selected_dev = assign_available_device_to_pid(mem_mgr, current_pid, file_priv);
+
+	if (!selected_dev) {
+		drm_dbg_driver(file_priv->minor->dev, "No context bank available for PID %d\n",
+			       current_pid);
+		ret = -EBUSY;
+		goto unlock_and_return;
+	}
+
+	qda_priv->assigned_iommu_dev = selected_dev;
+
+unlock_and_return:
+	mutex_unlock(&mem_mgr->process_assignment_lock);
+
+	return ret;
+}
+
+/**
+ * qda_memory_manager_release_device() - Release a process assignment
+ * @iommu_dev: Device previously obtained from qda_memory_manager_assign_device()
+ *
+ * Drops the caller's reference. Once the last process using the device is
+ * gone the assignment is cleared so the device can serve another process.
+ */
+void qda_memory_manager_release_device(struct qda_iommu_device *iommu_dev)
+{
+	unsigned long flags;
+
+	if (refcount_dec_and_test(&iommu_dev->users)) {
+		spin_lock_irqsave(&iommu_dev->lock, flags);
+		iommu_dev->assigned_pid = 0;
+		iommu_dev->assigned_file_priv = NULL;
+		spin_unlock_irqrestore(&iommu_dev->lock, flags);
+	}
+
+	kref_put(&iommu_dev->ref, iommu_device_free);
+}
+
+static struct qda_iommu_device *get_or_assign_iommu_device(struct qda_memory_manager *mem_mgr,
+							   struct drm_file *file_priv)
+{
+	struct qda_iommu_device *iommu_dev;
+	int ret;
+
+	iommu_dev = get_process_iommu_device(mem_mgr, file_priv);
+	if (iommu_dev)
+		return iommu_dev;
+
+	ret = qda_memory_manager_assign_device(mem_mgr, file_priv);
+	if (ret)
+		return NULL;
+
+	iommu_dev = get_process_iommu_device(mem_mgr, file_priv);
+	if (iommu_dev)
+		return iommu_dev;
+
+	return NULL;
+}
+
+/**
+ * qda_memory_manager_alloc() - Allocate memory for a GEM object
+ * @mem_mgr: Pointer to memory manager
+ * @gem_obj: Pointer to GEM object to allocate memory for
+ * @file_priv: DRM file private data for process association
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int qda_memory_manager_alloc(struct qda_memory_manager *mem_mgr, struct qda_gem_obj *gem_obj,
+			     struct drm_file *file_priv)
+{
+	struct qda_iommu_device *selected_dev;
+
+	selected_dev = get_or_assign_iommu_device(mem_mgr, file_priv);
+	if (!selected_dev)
+		return -EBUSY;
+
+	return qda_dma_alloc(selected_dev, gem_obj, gem_obj->size);
+}
+
+/**
+ * qda_memory_manager_free() - Free memory for a GEM object
+ * @mem_mgr: Pointer to memory manager
+ * @gem_obj: Pointer to GEM object to free memory for
+ */
+void qda_memory_manager_free(struct qda_memory_manager *mem_mgr, struct qda_gem_obj *gem_obj)
+{
+	qda_dma_free(gem_obj);
 }
 
 /**
@@ -31,13 +249,21 @@ static void cleanup_all_memory_devices(struct qda_memory_manager *mem_mgr)
 int qda_memory_manager_register_device(struct qda_memory_manager *mem_mgr,
 				       struct qda_iommu_device *iommu_dev)
 {
-	if (mem_mgr->num_devices >= mem_mgr->max_devices)
-		return -ENOSPC;
+	int ret = 0;
 
+	mutex_lock(&mem_mgr->process_assignment_lock);
+	if (mem_mgr->num_devices >= mem_mgr->max_devices) {
+		ret = -ENOSPC;
+		goto out;
+	}
+
+	init_iommu_device_fields(iommu_dev);
 	iommu_dev->id = mem_mgr->num_devices;
 	mem_mgr->devices[mem_mgr->num_devices++] = iommu_dev;
 
-	return 0;
+out:
+	mutex_unlock(&mem_mgr->process_assignment_lock);
+	return ret;
 }
 
 /**
@@ -52,14 +278,16 @@ void qda_memory_manager_unregister_device(struct qda_memory_manager *mem_mgr,
 {
 	int i;
 
+	mutex_lock(&mem_mgr->process_assignment_lock);
 	for (i = 0; i < mem_mgr->num_devices; i++) {
 		if (mem_mgr->devices[i] == iommu_dev) {
 			mem_mgr->devices[i] = NULL;
 			break;
 		}
 	}
+	mutex_unlock(&mem_mgr->process_assignment_lock);
 
-	kfree(iommu_dev);
+	kref_put(&iommu_dev->ref, iommu_device_free);
 }
 
 /**
@@ -80,6 +308,7 @@ int qda_memory_manager_init(struct qda_memory_manager *mem_mgr, int max_devices)
 
 	mem_mgr->num_devices = 0;
 	mem_mgr->max_devices = max_devices;
+	mutex_init(&mem_mgr->process_assignment_lock);
 
 	return 0;
 }
diff --git a/drivers/accel/qda/qda_memory_manager.h b/drivers/accel/qda/qda_memory_manager.h
index 7e38c8a18284..0949c0c213f6 100644
--- a/drivers/accel/qda/qda_memory_manager.h
+++ b/drivers/accel/qda/qda_memory_manager.h
@@ -7,25 +7,44 @@
 #define __QDA_MEMORY_MANAGER_H__
 
 #include <linux/device.h>
+#include <linux/kref.h>
+#include <linux/mutex.h>
+#include <linux/refcount.h>
+#include <linux/spinlock.h>
+#include <drm/drm_file.h>
 
 /* Forward declarations */
 struct qda_dev;
+struct qda_gem_obj;
 
 /**
  * struct qda_iommu_device - IOMMU device instance for memory management
  *
  * Represents a single IOMMU-enabled device managed by the memory manager.
  * Each device can be assigned to a specific process session.
+ *
+ * The object outlives its registration: open files keep a reference through
+ * @ref, so a device can be unregistered while a process still holds it.
  */
 struct qda_iommu_device {
 	/** @dev: Pointer to the underlying device */
 	struct device *dev;
 	/** @qdev: Back-pointer to the parent QDA device */
 	struct qda_dev *qdev;
+	/** @assigned_file_priv: DRM file private data for the assigned process */
+	struct drm_file *assigned_file_priv;
 	/** @id: Unique identifier assigned by the memory manager */
 	u32 id;
 	/** @sid: Stream ID for IOMMU transactions */
 	u32 sid;
+	/** @assigned_pid: Process ID of the process assigned to this device */
+	pid_t assigned_pid;
+	/** @users: Number of open files sharing this device */
+	refcount_t users;
+	/** @ref: Reference count controlling when the object is freed */
+	struct kref ref;
+	/** @lock: Spinlock protecting concurrent access to device */
+	spinlock_t lock;
 };
 
 /**
@@ -42,6 +61,8 @@ struct qda_memory_manager {
 	int num_devices;
 	/** @max_devices: Capacity of the @devices array */
 	int max_devices;
+	/** @process_assignment_lock: Mutex protecting process-to-device assignments */
+	struct mutex process_assignment_lock;
 };
 
 int qda_memory_manager_init(struct qda_memory_manager *mem_mgr, int max_devices);
@@ -51,5 +72,14 @@ int qda_memory_manager_register_device(struct qda_memory_manager *mem_mgr,
 				       struct qda_iommu_device *iommu_dev);
 void qda_memory_manager_unregister_device(struct qda_memory_manager *mem_mgr,
 					  struct qda_iommu_device *iommu_dev);
+int qda_memory_manager_assign_device(struct qda_memory_manager *mem_mgr,
+				     struct drm_file *file_priv);
+void qda_memory_manager_release_device(struct qda_iommu_device *iommu_dev);
+
+int qda_memory_manager_alloc(struct qda_memory_manager *mem_mgr,
+			     struct qda_gem_obj *gem_obj,
+			     struct drm_file *file_priv);
+void qda_memory_manager_free(struct qda_memory_manager *mem_mgr,
+			     struct qda_gem_obj *gem_obj);
 
 #endif /* __QDA_MEMORY_MANAGER_H__ */

-- 
2.34.1

