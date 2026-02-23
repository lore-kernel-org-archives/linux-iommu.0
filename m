Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D686436AB5F
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 19:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771873780; cv=none; b=IYMBU38BWokLSaEYtpaYhBG0c+M4B5ZrVceDN7fFWTo0GA4z6OwPHNtJNDr1WM1fS37jL2XGiJ8v9V2F+eEANgznlBrmGIelLjRqF8VqMXW1lzSMpqdVBUOOyKm/yXHx6TstjZ1MawbF0fF1hih2slKGjxSkVmuISn24sKEXEEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771873780; c=relaxed/simple;
	bh=Iw0hzhN8TNwgA9xnHeYqChSsZ5/vTjuUaVZUYGjv0iQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hZ8T7YNoS8bwku7BcW2BCpMxUYuvuBnx60ZABKDn2qS+SneCeNnwxZa9c3ax/oMwbdDsqi+uiI1LtAGJnObJmJTaQePU2K9kGyXSKvw8xhTbjKISuEkX4I/HAEmRLpWUwPUgmzyYu1Scg3GnV5JuBRPFMvu+MiUuXtjyM2gj1AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XdNsNsWv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Kk0Wrqg0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XdNsNsWv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Kk0Wrqg0"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NISFom3151787
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 19:09:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	S0JCApWIKIFxtoeFjcHtlOVvzzubuiNTLYafS3Jft1k=; b=XdNsNsWvxZaLB+WO
	1c9je4mRHs9lemIwzNeVaBTfpwvKr7B0M6jAGIFkItnEmwzraStnPI+eLsvh+Xg1
	9tqJOYWOtxI5zGygqqarte6g8YKv1SPyRAjTJDK/H1eUgLiAWwJbOlM+R5ZVO7Gu
	Zlidsi74Xn3WIUeJeLdS6qj+zGxJeuJaICoHVkiD27kVX2tzYfA0ZOwCh1kXu4+5
	JXAy4aZ6r6X+Z6maQBc488mYwlT3XgqPa5XsPeu0Kvlf54tMIfsLd/itCow9x1rM
	D5dq7NJNCG/xoZz2ALOSMmFhUqbSS2og4rxeBOS6jyP69+IusIvhhoGOhRfkNw7B
	1fcYwA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cgpj89bxb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 19:09:37 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2aad5fc5b2fso39177325ad.1
        for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 11:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771873777; x=1772478577; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S0JCApWIKIFxtoeFjcHtlOVvzzubuiNTLYafS3Jft1k=;
        b=Kk0Wrqg0hJ41S2ngTwRRPeQHkXKLLY5H/JGb9PIi/ThoPdorfNlS6w536LKR+8lXRQ
         CXLK84zAnzTtUGfZug7oyWutXbfCU9qhr/K2g5T/0KBiTA7mIhPqbEyanXxSSHR1Iu0j
         WMh2vg2WqNMnB3QHhiQ8bKOFd+QCnXCfPl5brve8hwppPo/ikzKLIcE1O7UsqfxiN34f
         o4xPWcsFyC90vFOLf2sPufBWB9rLyTwVylTtQ9EEieowb9oUzBp8fdme72q/kp2UBTBY
         8PBzsrjmpFm4GM3RThmjXrcAPCL/cRQOL49yV166IqAcSW7YHmBzi6rzmotJL6ksV07v
         jU8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771873777; x=1772478577;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S0JCApWIKIFxtoeFjcHtlOVvzzubuiNTLYafS3Jft1k=;
        b=UgrJNXh6/70jk4Cz/qZcIpk+zRbAzQ9NwIaCv2Yc2LeC+RC5u9BAXnsQN2VfVDD5Iu
         djQn3xPT+Cs5YktOuu5EYq/WMP9SUWnen9BBvObQT0yagM4LFiVWozoQ6tzJ4v85Um2z
         Q8BY5OYSvb9BWk9/2bffuWRW+bW3vPEtYBSkyX46m4FWmac2kCLuMzgM1K6D7njKgkHL
         oOKqrYVXEACQzinOfhkhSrO4hqvqGaMQzf+Go4ZXByeBjQxzcmWS3w3KwO2wcHVv/f8D
         YpaQ6ozbL4mcDBrj9b4yNMkXZFnSDxzpanWMeqNoTy3LQZqK9NQ0MWTESNzg3S8oXRGt
         Cueg==
X-Forwarded-Encrypted: i=1; AJvYcCVBvwBG/B7CJWqz86VSbp+QAdrn+zeTX0VGU6P4H2eR7HCnpSMquiP0LDhYy1ejz9AnyBs3Rg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyTrUMtLQvem7md8cl2vMvp5ZP6MkwaLMFc/EoaQt6WyfDaqLIB
	iUPDQc1KuE/1Tg35dvEsHt0ZVUyM3thP/op8j45eSBcMJFAuzqQgH9YGgpQNj+ufQ4AX48hq4NH
	yLvSgrwq+m44x/43svgiPWuXkbqHCx0cpGZ9c2VHJnKyMXPYZobb7pu6ihQ==
X-Gm-Gg: ATEYQzzqFZSauvTJsHFzVxD1+tCr4Wn7r6upxlVPw/00F0yJqzQgjf3/ZCwAGxLQ7HL
	64SbChMM3QpVx13udam1cwfX0KdOF1T29RcQrQGMGmchj5mKY3ExlQ2PzJWCx2uYaf78g2qpaca
	x2FXOwW/YU1juzO0zz9cdCDvwEGic9EO7SVjfBobUMxpAbpwIbobbjf9Jt1sosyVV4W4LVIy1rx
	qJvxq55HNhh4koUNNEnKr4QXxyRKOInF86Y+5k6+zbd1Nvos9DDwZ6Zx31vJRwr6kn/GRWEpmcI
	AyD+aANHTmlz5YHo+Zt0e3Z+GKCVLnbkcjDK0W2usDcBDBukTMoHVqvouFxSo/pAX/xI6roXtWf
	Uhm3KKG2G4thEyQptBxz1SSGkuWghhy911DlALEdvCHxrN+HWg/tMiw==
X-Received: by 2002:a17:902:ce0c:b0:2aa:dee9:dcf4 with SMTP id d9443c01a7336-2ad7447b9a3mr88580505ad.25.1771873776729;
        Mon, 23 Feb 2026 11:09:36 -0800 (PST)
X-Received: by 2002:a17:902:ce0c:b0:2aa:dee9:dcf4 with SMTP id d9443c01a7336-2ad7447b9a3mr88580215ad.25.1771873776239;
        Mon, 23 Feb 2026 11:09:36 -0800 (PST)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad74e34e18sm83501505ad.10.2026.02.23.11.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 11:09:35 -0800 (PST)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Date: Tue, 24 Feb 2026 00:38:56 +0530
Subject: [PATCH RFC 02/18] accel/qda: Add Qualcomm DSP accelerator driver
 skeleton
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-qda-firstpost-v1-2-fe46a9c1a046@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771873753; l=4540;
 i=ekansh.gupta@oss.qualcomm.com; s=20260223; h=from:subject:message-id;
 bh=Iw0hzhN8TNwgA9xnHeYqChSsZ5/vTjuUaVZUYGjv0iQ=;
 b=6mfusuznwiKRoFz7lqPVV796aoLzrrTOSWeY7E+k/o91H+68GH9DCi4JNH+MgsD4WTZjhKMWZ
 rfXsJyoI0+sBQzXiPtXlgnu8MwGhwyzA7WTUYFVKS2pm+ZpHc4bQxcZ
X-Developer-Key: i=ekansh.gupta@oss.qualcomm.com; a=ed25519;
 pk=n0SepARizye+pYjhjg1RA5J+Nq4+IJbyRcBybU+/ERQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDE2NiBTYWx0ZWRfX+oHyLFNmc47T
 RvsQPrw0q9XsSwShGRsAuCEU/rSvf84fltARFujUjzN9iUgwu8RIOaOM4avi0+yvK5KxSnhwWk+
 IZSwJv9qtDM2veq/6s0OrX2s8bszaPQkYRR4EYBEYOqENCiLckWV9ubSBSfcRL+edEHeWnr1PQL
 bx5c2Tyv7o8QPSlL+4J7LJ1ei6OXKaE/S0E3Tux3+6Jr9fFMK8MqTt6fs9abTr4c29Bpudj9Yji
 0qYHhT0g00guLrN15PWW/HDWen5DW8VSnRoucIk/4KVr4sj37tXsS2lAGFRNkpNIG7IShO0N719
 ZwtTzPgfEyl78XUUEIlGplDlyiWHLeAujaFmJfLnYfovf1wtF9kJ5iXyVeajcA6i9IH08gchzsN
 mJ5dpw2FPiuXAKWkuirLp/prNr0QxBsS63faJPodIFcihidYQqwK6MrIBppDoCOvI5XwlW7MNbB
 0xuVPb5n/JaKmsVtfnw==
X-Proofpoint-GUID: aBk4M9GK0np1rqVFwHXaS4G8SQzGOUcN
X-Authority-Analysis: v=2.4 cv=Z5Lh3XRA c=1 sm=1 tr=0 ts=699ca5f1 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=YXnACfkLeW4vfmpQHhcA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: aBk4M9GK0np1rqVFwHXaS4G8SQzGOUcN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_04,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230166

This patch introduces the initial scaffolding for the Qualcomm DSP
accelerator (QDA) driver under drivers/accel/.
The new Kconfig option DRM_ACCEL_QDA integrates the driver with the
DRM/accel subsystem, and the accel Makefile is updated to build the
driver as a loadable module. A minimal qda_drv.c file is added to
provide basic module_init/module_exit hooks so that the driver can be
built and loaded.

Subsequent patches will add:

- RPMSG-based communication with Qualcomm Hexagon DSPs
- FastRPC integration for userspace offload
- DMA-BUF support and memory management
- GEM, PRIME and IOCTL interfaces for compute job submission

This patch only wires up the basic driver framework and does not yet
provide functional DSP offload capabilities.

Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
---
 drivers/accel/Kconfig       |  1 +
 drivers/accel/Makefile      |  1 +
 drivers/accel/qda/Kconfig   | 29 +++++++++++++++++++++++++++++
 drivers/accel/qda/Makefile  |  8 ++++++++
 drivers/accel/qda/qda_drv.c | 22 ++++++++++++++++++++++
 5 files changed, 61 insertions(+)

diff --git a/drivers/accel/Kconfig b/drivers/accel/Kconfig
index bdf48ccafcf2..74ac0f71bc9d 100644
--- a/drivers/accel/Kconfig
+++ b/drivers/accel/Kconfig
@@ -29,6 +29,7 @@ source "drivers/accel/ethosu/Kconfig"
 source "drivers/accel/habanalabs/Kconfig"
 source "drivers/accel/ivpu/Kconfig"
 source "drivers/accel/qaic/Kconfig"
+source "drivers/accel/qda/Kconfig"
 source "drivers/accel/rocket/Kconfig"
 
 endif
diff --git a/drivers/accel/Makefile b/drivers/accel/Makefile
index 1d3a7251b950..58c08dd5f389 100644
--- a/drivers/accel/Makefile
+++ b/drivers/accel/Makefile
@@ -5,4 +5,5 @@ obj-$(CONFIG_DRM_ACCEL_ARM_ETHOSU)	+= ethosu/
 obj-$(CONFIG_DRM_ACCEL_HABANALABS)	+= habanalabs/
 obj-$(CONFIG_DRM_ACCEL_IVPU)		+= ivpu/
 obj-$(CONFIG_DRM_ACCEL_QAIC)		+= qaic/
+obj-$(CONFIG_DRM_ACCEL_QDA)		+= qda/
 obj-$(CONFIG_DRM_ACCEL_ROCKET)		+= rocket/
\ No newline at end of file
diff --git a/drivers/accel/qda/Kconfig b/drivers/accel/qda/Kconfig
new file mode 100644
index 000000000000..3c78ff6189e0
--- /dev/null
+++ b/drivers/accel/qda/Kconfig
@@ -0,0 +1,29 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Qualcomm DSP accelerator driver
+#
+
+config DRM_ACCEL_QDA
+	tristate "Qualcomm DSP accelerator"
+	depends on DRM_ACCEL
+	depends on ARCH_QCOM || COMPILE_TEST
+	help
+	  Enables the DRM-based accelerator driver for Qualcomm's Hexagon DSPs.
+	  This driver provides a standardized interface for offloading computational
+	  tasks to the DSP, including audio processing, sensor offload, computer
+	  vision, and AI inference workloads.
+
+	  The driver supports all DSP domains (ADSP, CDSP, SDSP, GDSP) and
+	  implements the FastRPC protocol for communication between the application
+	  processor and DSP. It integrates with the Linux kernel's Compute
+	  Accelerators subsystem (drivers/accel/) and provides a modern alternative
+	  to the legacy FastRPC driver found in drivers/misc/.
+
+	  Key features include DMA-BUF interoperability for seamless buffer sharing
+	  with other multimedia subsystems, IOMMU-based memory isolation, and
+	  standard DRM IOCTLs for device management and job submission.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called qda.
diff --git a/drivers/accel/qda/Makefile b/drivers/accel/qda/Makefile
new file mode 100644
index 000000000000..573711af1d28
--- /dev/null
+++ b/drivers/accel/qda/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for Qualcomm DSP accelerator driver
+#
+
+obj-$(CONFIG_DRM_ACCEL_QDA)	:= qda.o
+
+qda-y := qda_drv.o
diff --git a/drivers/accel/qda/qda_drv.c b/drivers/accel/qda/qda_drv.c
new file mode 100644
index 000000000000..18b0d3fb1598
--- /dev/null
+++ b/drivers/accel/qda/qda_drv.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+#include <linux/module.h>
+#include <linux/kernel.h>
+
+static int __init qda_core_init(void)
+{
+	pr_info("QDA: driver initialization complete\n");
+	return 0;
+}
+
+static void __exit qda_core_exit(void)
+{
+	pr_info("QDA: driver exit complete\n");
+}
+
+module_init(qda_core_init);
+module_exit(qda_core_exit);
+
+MODULE_AUTHOR("Qualcomm AI Infra Team");
+MODULE_DESCRIPTION("Qualcomm DSP Accelerator Driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1

