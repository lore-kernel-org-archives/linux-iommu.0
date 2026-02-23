Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0536736B046
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 19:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771873825; cv=none; b=qu0bMwcEUwK0niUQQeq4uoBs69IjFu0OBmUzAIp3bQVF+uxforfHpyaWuLzM9Iuwak00GTkOyYVRfJVeiv3GYXSupYVSSh/Bc6hvEhm50iX36czo5ekzzeUfRbiiH9wZBrfaki4h+XPpwmkBzIOW5t7R5aXjDM9DCXiJfx/09ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771873825; c=relaxed/simple;
	bh=6EHrB7O8xO1KO3JeXaSJmhEvz4UF48aY+wHefteIn5o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pRrFoYAsOkeIZaLuchFv2BibE+N8FOoK696FdVy+Yrljr5l67B78sDvYQfp09h27l5b2IsKq5gIyK82Z6yWHIxv26OSqVgvgRG0Xo3C2h3G016tKG541hOL4ARwHYUSw4puAcNXZdW4l2mcXTxKVef0QiEAt43LZIFJ9rp0Nb5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mWUZysgp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XEzgwSza; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mWUZysgp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XEzgwSza"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NId7A3322207
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 19:10:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VGtqCA2sSEGVBfxM2+pOtYGJuWhGvcLCkjQcUGRaoOk=; b=mWUZysgpZBnQX/2G
	wuG7JAfjNH9xkMP2RD774Ch7eQXXEEW6DfNmwI/9kicOHEhE19zCZxZmUcBH7R+I
	9/NK0RB+ZeuScc97Z/gXQLpe6J0bI2VTyxZbvCLyjQ0uB+SRcmH5Lub7h/CMjK7E
	Ys43tdgyPA0x89FJOtZJr2VQNIjcj0s6jBlNrfRtlxnzVtfc0lglwOQA8uFgggJF
	4XFg/0kBYW52B3t/sjYGv1wnZZnX5wgZUQrkUerqMNNTknAyy0Nr1/qJwo0/uIpi
	N7/lr9IgLGiqdxcPUqkWSaNUCc/qA4KwA/wuZqAUgB2s0yaz/HQehzulI6Y8jxld
	+g+sgw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cgn8y1m62-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 19:10:23 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a92a3f5de9so25837655ad.2
        for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 11:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771873822; x=1772478622; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VGtqCA2sSEGVBfxM2+pOtYGJuWhGvcLCkjQcUGRaoOk=;
        b=XEzgwSzayBRo0FaYHMyEBw1QaBU2IXQEoqWSxjR9kVzLLZOkttnLtongqk4sIK3//B
         6DwWIyGoqgTAasD39DvevlpRa5dfIXqEXXk50jAnf3KqK+pCP+Aa4VzCKR9OTpwoVew/
         Pm6//rU2zoSVmPJW6uZdRWuiowhwN4iuV+5tpInDum/P4Z+2LB+gZhyBb48EHV804aFY
         WMZOCLH0nA24yKZwvkkw43GNm4rSLCsyvlJmPvw6eoTYwX+vsWIGw/PWBfk1eObYNDrK
         rNbDXPfKfJDsAIBnNwzEdaLH0xE5DW5On6wwYDGRFzpB9vkOBlnHGBY3sf5kZ5S1qglI
         KnyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771873822; x=1772478622;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VGtqCA2sSEGVBfxM2+pOtYGJuWhGvcLCkjQcUGRaoOk=;
        b=xAY6D5e59aVEEvT3I8uQTejM7powUZrTInieQVK5EivaM8Rpni9ZVhZV4pDz8fngu5
         sQ/oiOsFF5lMqvN932th/SPQ9fAPc82iyvK34i8DIsjuDZ8xgGO8o29sPYscI8Xz2LRV
         nsnw9s+feqLo1A/a07rgSpicDO2BTqRlW9BKQoi8GdGOhAE9aQG6UZ7r4RFLzv73IlGi
         1wplpVJ1YYLKk6/DuHIQVxbT2Xql1f2Wx+Y8xl/0TRRFyiwN6H/GaXMvC3B3BZUnexfy
         AxpuhuiF+roLUCKdzjVmasgdMF2AQhIS4a8x6Sr8hnoTHzX5vI4CpLjuU6/X9mlciE+x
         eq5A==
X-Forwarded-Encrypted: i=1; AJvYcCVSa81BIEXLC5nL6SwJZHP19W9vEwxwiKs1TanbRc1GtKsl8MSFPF3jwQkWqW+Pe/fmcEIBkA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw4NHnvnJDUShMwszZVEuhvjzKBMckyVoAL+ViVD+0248qSfAd/
	37uG0ZYkwTfV0nhWxLaE6T3ZPNEg9iwm610JQHVY+AsobNU+6TqA2bErAVuEvCurC9TWCEn1q14
	lmBRG1AExmmKck0dE4eDzyiOhhYDDNPATa4ZnAeuCtSOwpO9mGvjPCOPDZg==
X-Gm-Gg: ATEYQzxH11uiFcvQurASvKCzxjL2YJPK+sUOcP7+V2lVQohhVksE+HBdoc/Hvlco+ja
	pU63g5mtfGNtqm5HJd4r6bNcdjLHymwjaPQM/lwKu1TIqYXsu5/4ClzFOWeM1Rh/LRN8NAHWo9U
	Ijxfm7XZ9Hgws5793SXs05Zx0BuFfwuhxUxh+ZqzjNjVWMsqe+3r7TgaUc6Cpky9BEDPAvNgFCC
	T2HfcVLoOqb3+mB05sAv9Tq3AwCpRjKzOBcmIs69ZSNgeWaIdvvSHpSt0Beqsj7CvA6h0IZ9xLQ
	fmMAZJ8fFEMyKDdzg0B2963kDbinqQDSvyROJAISGixJGSrD2/6XZicx7jmkaC2JLlsZ17LnkUg
	dxIR9YcdAfolvfGUPifJOKfRrBpG7/7XZ+zruPU0hTj21v5tpaT1JyQ==
X-Received: by 2002:a17:903:246:b0:2a2:d2e7:1601 with SMTP id d9443c01a7336-2ad74541768mr90428495ad.48.1771873822023;
        Mon, 23 Feb 2026 11:10:22 -0800 (PST)
X-Received: by 2002:a17:903:246:b0:2a2:d2e7:1601 with SMTP id d9443c01a7336-2ad74541768mr90428265ad.48.1771873821476;
        Mon, 23 Feb 2026 11:10:21 -0800 (PST)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad74e34e18sm83501505ad.10.2026.02.23.11.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 11:10:20 -0800 (PST)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Date: Tue, 24 Feb 2026 00:39:02 +0530
Subject: [PATCH RFC 08/18] accel/qda: Add per-file DRM context and
 open/close handling
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-qda-firstpost-v1-8-fe46a9c1a046@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771873753; l=6299;
 i=ekansh.gupta@oss.qualcomm.com; s=20260223; h=from:subject:message-id;
 bh=6EHrB7O8xO1KO3JeXaSJmhEvz4UF48aY+wHefteIn5o=;
 b=PQoJ0WQ74WdOsWKY6SUsnfL5qbidltdPL4pFBld3IPPhdFunIRAZUD0aVWSiqeKX4Q+C1O8us
 HJ7xauW+RB+CD3tKcCU67VQ4JDbx2VlgLnYZovthqbqOs1Z9EiYO/B8
X-Developer-Key: i=ekansh.gupta@oss.qualcomm.com; a=ed25519;
 pk=n0SepARizye+pYjhjg1RA5J+Nq4+IJbyRcBybU+/ERQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDE2NiBTYWx0ZWRfX+cz+6pobZg8q
 nY0qLIVZ0tmQvc+ubyoXfzhNAEcgc/brlLAlMKXWQVdutzj49mScwsXS7S0or2xVnjZduI16ZB/
 ReXVnUMpRZp/UNqxUGXFxV/wELX+q5EL1wcWF6cP84q0V19RVlNg9ZGuzaWx2EKSocn5kiyM6PS
 kXNagkSxvqZuQc24Ke8hpSzswz3htwGMf81lVCisfZ58onNSbXITuKRE6jE3xnyAG3t64pjbT7+
 ZFnlisamDHZ0niV65YeR2T/bmKc0dt1IUp/++OfrVhB/JyIQKVI6fBY+5YkQILJvFz6+ujqQpwe
 X4jmxkZbWEBmcoo3OlZqSAuXvwX7UwMJ3V2xamI7H7EzOBjicu1rZZ7JlNMijrXhrcZMTv7tvHj
 TBicRqu5ragdt5hoa99/7VY5fEih8Tv0DLe+DYJGBDJSCDdMgZLjbjttqUsdruvCUvUEMHRIz9J
 3Nk12LdwjnOrY+bXM4g==
X-Authority-Analysis: v=2.4 cv=edYwvrEH c=1 sm=1 tr=0 ts=699ca61f cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=eDbiE4MX-y_Gg5q49BQA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: ngHixVZg5AsYIOFQI-njFUz93Zp6kZCu
X-Proofpoint-ORIG-GUID: ngHixVZg5AsYIOFQI-njFUz93Zp6kZCu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_04,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 phishscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230166

Introduce per-file and per-user context for the QDA DRM accelerator
driver. A new qda_file_priv structure is stored in file->driver_priv
for each open file descriptor, and a qda_user object is allocated per
client with a unique client_id generated from an atomic counter in
qda_dev.

The DRM driver now provides qda_open() and qda_postclose() callbacks.
qda_open() resolves the qda_dev from the drm_device, allocates the
qda_file_priv and qda_user structures, and attaches them to the DRM
file. qda_postclose() tears down the per-file context and frees the
qda_user object when the file is closed.

This prepares the QDA driver to track per-process state for future
features such as per-client memory mappings, job submission contexts,
and access control over DSP compute resources.

Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
---
 drivers/accel/qda/qda_drv.c | 117 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/accel/qda/qda_drv.h |  30 ++++++++++++
 2 files changed, 147 insertions(+)

diff --git a/drivers/accel/qda/qda_drv.c b/drivers/accel/qda/qda_drv.c
index a9113ec78fa2..bf95fc782cf8 100644
--- a/drivers/accel/qda/qda_drv.c
+++ b/drivers/accel/qda/qda_drv.c
@@ -12,11 +12,127 @@
 #include "qda_drv.h"
 #include "qda_rpmsg.h"
 
+static struct qda_drm_priv *get_drm_priv_from_device(struct drm_device *dev)
+{
+	if (!dev)
+		return NULL;
+
+	return (struct qda_drm_priv *)dev->dev_private;
+}
+
+static struct qda_dev *get_qdev_from_drm_device(struct drm_device *dev)
+{
+	struct qda_drm_priv *drm_priv;
+
+	if (!dev) {
+		qda_dbg(NULL, "Invalid drm_device\n");
+		return NULL;
+	}
+
+	drm_priv = get_drm_priv_from_device(dev);
+	if (!drm_priv) {
+		qda_dbg(NULL, "No drm_priv in dev_private\n");
+		return NULL;
+	}
+
+	return drm_priv->qdev;
+}
+
+static struct qda_user *alloc_qda_user(struct qda_dev *qdev)
+{
+	struct qda_user *qda_user;
+
+	qda_user = kzalloc_obj(*qda_user, GFP_KERNEL);
+	if (!qda_user)
+		return NULL;
+
+	qda_user->client_id = atomic_inc_return(&qdev->client_id_counter);
+	qda_user->qda_dev = qdev;
+
+	qda_dbg(qdev, "Allocated qda_user with client_id=%u\n", qda_user->client_id);
+	return qda_user;
+}
+
+static void free_qda_user(struct qda_user *qda_user)
+{
+	if (!qda_user)
+		return;
+
+	qda_dbg(qda_user->qda_dev, "Freeing qda_user client_id=%u\n", qda_user->client_id);
+
+	kfree(qda_user);
+}
+
+static int qda_open(struct drm_device *dev, struct drm_file *file)
+{
+	struct qda_user *qda_user;
+	struct qda_file_priv *qda_file_priv;
+	struct qda_dev *qdev;
+
+	if (!file) {
+		qda_dbg(NULL, "Invalid file pointer\n");
+		return -EINVAL;
+	}
+
+	qdev = get_qdev_from_drm_device(dev);
+	if (!qdev) {
+		qda_dbg(NULL, "Failed to get qdev from drm_device\n");
+		return -EINVAL;
+	}
+
+	qda_file_priv = kzalloc(sizeof(*qda_file_priv), GFP_KERNEL);
+	if (!qda_file_priv)
+		return -ENOMEM;
+
+	qda_file_priv->pid = current->pid;
+
+	qda_user = alloc_qda_user(qdev);
+	if (!qda_user) {
+		qda_dbg(qdev, "Failed to allocate qda_user\n");
+		kfree(qda_file_priv);
+		return -ENOMEM;
+	}
+
+	file->driver_priv = qda_file_priv;
+	qda_file_priv->qda_user = qda_user;
+
+	qda_dbg(qdev, "Device opened successfully for PID %d\n", current->pid);
+
+	return 0;
+}
+
+static void qda_postclose(struct drm_device *dev, struct drm_file *file)
+{
+	struct qda_dev *qdev;
+	struct qda_file_priv *qda_file_priv;
+	struct qda_user *qda_user;
+
+	qdev = get_qdev_from_drm_device(dev);
+	if (!qdev || atomic_read(&qdev->removing)) {
+		qda_dbg(NULL, "Device unavailable or removing\n");
+		return;
+	}
+
+	qda_file_priv = (struct qda_file_priv *)file->driver_priv;
+	if (qda_file_priv) {
+		qda_user = qda_file_priv->qda_user;
+		if (qda_user)
+			free_qda_user(qda_user);
+
+		kfree(qda_file_priv);
+		file->driver_priv = NULL;
+	}
+
+	qda_dbg(qdev, "Device closed for PID %d\n", current->pid);
+}
+
 DEFINE_DRM_ACCEL_FOPS(qda_accel_fops);
 
 static struct drm_driver qda_drm_driver = {
 	.driver_features = DRIVER_COMPUTE_ACCEL,
 	.fops			= &qda_accel_fops,
+	.open			= qda_open,
+	.postclose		= qda_postclose,
 	.name = DRIVER_NAME,
 	.desc = "Qualcomm DSP Accelerator Driver",
 };
@@ -58,6 +174,7 @@ static void init_device_resources(struct qda_dev *qdev)
 
 	mutex_init(&qdev->lock);
 	atomic_set(&qdev->removing, 0);
+	atomic_set(&qdev->client_id_counter, 0);
 }
 
 static int init_memory_manager(struct qda_dev *qdev)
diff --git a/drivers/accel/qda/qda_drv.h b/drivers/accel/qda/qda_drv.h
index 2b80401a3741..e0ba37702a86 100644
--- a/drivers/accel/qda/qda_drv.h
+++ b/drivers/accel/qda/qda_drv.h
@@ -10,6 +10,7 @@
 #include <linux/list.h>
 #include <linux/mutex.h>
 #include <linux/rpmsg.h>
+#include <linux/types.h>
 #include <linux/xarray.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_file.h>
@@ -20,6 +21,33 @@
 /* Driver identification */
 #define DRIVER_NAME "qda"
 
+/**
+ * struct qda_file_priv - Per-process private data for DRM file
+ *
+ * This structure tracks per-process state for each open file descriptor.
+ * It maintains the IOMMU device assignment and links to the legacy qda_user
+ * structure for compatibility with existing code.
+ */
+struct qda_file_priv {
+	/* Process ID for tracking */
+	pid_t pid;
+	/* Pointer to qda_user structure for backward compatibility */
+	struct qda_user *qda_user;
+};
+
+/**
+ * struct qda_user - Per-user context for remote processor interaction
+ *
+ * This structure maintains per-user state for interactions with the
+ * remote processor, including memory mappings and pending operations.
+ */
+struct qda_user {
+	/* Unique client identifier */
+	u32 client_id;
+	/* Back-pointer to device structure */
+	struct qda_dev *qda_dev;
+};
+
 /**
  * struct qda_drm_priv - DRM device private data for QDA device
  *
@@ -52,6 +80,8 @@ struct qda_dev {
 	struct qda_drm_priv *drm_priv;
 	/* Flag indicating device removal in progress */
 	atomic_t removing;
+	/* Atomic counter for generating unique client IDs */
+	atomic_t client_id_counter;
 	/* Name of the DSP (e.g., "cdsp", "adsp") */
 	char dsp_name[16];
 	/* Compute context-bank (CB) child devices */

-- 
2.34.1

