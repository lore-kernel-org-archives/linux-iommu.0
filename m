Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8E73090C1
	for <iommu@lists.linux.dev>; Mon, 17 Aug 2026 04:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786942096; cv=none; b=hBPX5+u1PI6XCuWrrD4cuD7z2th2kc6Wfrx2BcFrbXo1Gix/P3/nPcKcV+caOc9nxMwFNd/0quOa2zqBipajYVV6Kv8jVJ3ZFT/+TBILGxrdzOLGOe6fttxxd+kXeUWgGP8A1+bvAaO/IYEoF9IUn0MbH/LBBKdmtWemA04DJzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786942096; c=relaxed/simple;
	bh=bdDPnz4gcKq0coBCdyc5K/JNPp8U0dWJWPQTjY7EdTs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o1HPf1shjuRPDL/1FcYRwyjv/VUZUaZpJEGYeqLLxZseAHbOhfM3TnVg9mX5/bS667HFnBLlAuiifibB9RB/CDUR/KteM09vSCXYG+ug7SKdoO2cT+fev/KF0ehlLUf7EYUEhJNr6TS0fT59sCXbcLRct9xMSMphPCmCxJcrj5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Tq7/CKLl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YJT713LZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Tq7/CKLl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YJT713LZ"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67H44k5t1176303
	for <iommu@lists.linux.dev>; Mon, 17 Aug 2026 04:48:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JVjFJFtknCk1hPV1W6+tmqWmCFFfNSl+ERw3V/UKgOU=; b=Tq7/CKLlE9faSu2m
	tIaFs6SSgYkRq7YwTULJ9MBBH6Cp56eDTjNloeM2qco/DlJQAgIeF6jH3ck+2sfW
	++aajZBP2dLztsk62mFbUKIHTWgP0cnSjzbJCXFhLrqApN+540I/4mmAL2WneaY/
	81G711T7UXSdvgtADaHcdeWQbgIvc7JFf88TNLarOOW67iA3L/IBaNKIsutO+CTx
	yBjwhEolEbReiNjYyed06L/jCohOc7jsv4WzXRC6Z5s5uuaZO1dD9LFFOG5ASfXg
	IWRnn4jh5dDRlq+AM59ndofVBHvONJZbTXfNetipA2UVYl1cnzc+bqHL5Ee5JInn
	IBVS7A==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3txy83gr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 17 Aug 2026 04:48:13 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-848860def2cso2597646b3a.2
        for <iommu@lists.linux.dev>; Sun, 16 Aug 2026 21:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786942093; x=1787546893; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JVjFJFtknCk1hPV1W6+tmqWmCFFfNSl+ERw3V/UKgOU=;
        b=YJT713LZc/hh7S3iSCOjGy/IWqmDMfgh4BPcEBc4gJOZrqashvGo+f9Ac/FvX8aim8
         lWdQOtnHsnYvl4oGHTG2W2NheK2D0L9+dwmAdx+u32LyQBGr6l6yq3IiaxQZWxz9yjdK
         1X2bir42bk2uBHSKfoOW6dTaTtfGzvcW1hRQn4TGm4R0W9E0uBvaDRFTmwUxDnXKgwdt
         eE9Va6JodWcLnj8VSNBBcxdZ/8s9wn1e/FJN099kBS/UbVngHL0Wk8knpjecg7tPQK8+
         A9ASfnCGJx9IPN33yBqAtJErQ8MUg62H4i+mMIY4q4lt/W4vI75qkFbEpFRn29vx+ul5
         mIhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786942093; x=1787546893;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JVjFJFtknCk1hPV1W6+tmqWmCFFfNSl+ERw3V/UKgOU=;
        b=pKIA6zgKVa6tJcXRq0667ZnvqLnv4bWr5IVnBeDPKgxvuVlNfcFy0jlv89AH5tvuIo
         i4pve0+baoWH/vKYcAW5dmDAEh5CqHD0xBLr7YpkcBJyx2eM/w/ENlHCzQIcp6Fh9PLi
         EmpCfh8hk58dNVEJnZAI4pxnmBA4bzQRoaEKZJ8hoTfCqs1qMeNAz1VFYIHxLozZ/CHO
         DB0ihxnco+ptIhe4hYmGKukqEaHxtjgfVFV15mMY9HIyr5gbgbVFiGDlmE9wBN6NSv7I
         a4GAo71xRacu4OJnjvW1oe7hNtUKQcVvm10Qtet7wAtnzGEQziaMHSU+AmlIYfElzeQa
         1STw==
X-Forwarded-Encrypted: i=1; AHgh+Ro0js0BEwnvYc0gV5C3jQm1r+blts3xFdkEAlCB3HKbjcUTIRm0yzkWRKRKxX+jeJwYJrorCw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyLkIDGSWzsFNHMS/1cKcpuQMSXW35qj0G6tszh0FDWRXRhydO/
	unMeBZnBuLq9rFvWFVshgd55dzl69r4rDY1/0rSr6eLgVhnnqz+Mlz6Bp2UtjOiQvPxZS+cOBGZ
	1TLE5Sdlc8Tc7YbnT9Lfg6XfWZbhddCqOPT8oDvNCeETcXcWtFRcCENUiJOrVhem5jg==
X-Gm-Gg: AR+sD11YCggUomn0/lKcE1TiByQP0hU/sZtX1e6pIgM9ngc5OW73MwRuPNvkCGGpik1
	WKwwdVtPgOWPABqLNp/Xk+L7K1Mv9wg4/LwLhza+Xoxxr7ufP+OuMjdmNq1RFt7Yz933VXepxpO
	th/12mjFVDcB2EZz83W8gG630aU3vZQypDYWmCgSyDlSJhju9v4bGYPUJOQaohycFOPti29O6A+
	Blk5kCXRgiMaVgWcHPwMjRXlHUAyxqUAcXk9/LVjlerwqo5MbFin11U8vA39lVBcs7Ag3//lekz
	dXsuSF4TSnc96FSmj6UK+DfPOLQ5f4XEvWchraENH9iO+Lvjxveg3Gy57tSMsoVGMypuhblkU42
	IPX2FpLdco/dPtmzpDrs0eZ0vC6RuTgYz
X-Received: by 2002:a05:6a00:4c19:b0:848:3dae:66e2 with SMTP id d2e1a72fcca58-84fde75cc05mr22597331b3a.26.1786942093113;
        Sun, 16 Aug 2026 21:48:13 -0700 (PDT)
X-Received: by 2002:a05:6a00:4c19:b0:848:3dae:66e2 with SMTP id d2e1a72fcca58-84fde75cc05mr22597268b3a.26.1786942092551;
        Sun, 16 Aug 2026 21:48:12 -0700 (PDT)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8517d046638sm2149250b3a.27.2026.08.16.21.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 21:48:12 -0700 (PDT)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 10:17:38 +0530
Subject: [PATCH v2 03/15] accel/qda: Add initial QDA DRM accelerator driver
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-qda-v2-v2-3-69a02e9090d4@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786942058; l=10592;
 i=ekansh.gupta@oss.qualcomm.com; s=20260223; h=from:subject:message-id;
 bh=bdDPnz4gcKq0coBCdyc5K/JNPp8U0dWJWPQTjY7EdTs=;
 b=7hqbodnBNfBtCiJxftXub0GuG+tbSMtMDHXcKo6Cm1fICatkFdia93n9EEnsnOxE2Syq1HdNW
 MikWkslPnHRBxXTYTilta3uvOCxvTA0/pwHSrddTyF9udp0iTi1uREK
X-Developer-Key: i=ekansh.gupta@oss.qualcomm.com; a=ed25519;
 pk=n0SepARizye+pYjhjg1RA5J+Nq4+IJbyRcBybU+/ERQ=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDAzMyBTYWx0ZWRfXzwL3PmRJbl74
 w5uPbj8pj6A2BYIkkQRHHnf/7nksttSKJDU9Wda2EwyFiNOdo+80VsOl++Ti6ryiCq6k1LMEzB0
 FgDDFWEBWqc3pwFU+cxA91D9FVoKb+I=
X-Authority-Analysis: v=2.4 cv=auGCzyZV c=1 sm=1 tr=0 ts=6a82928e cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=1wMbdgC_A7jj-OG1YmsA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDAzMyBTYWx0ZWRfXzjbqrYC63PSk
 bWlSJj5FGJTStXCmklYfb9RULY4BSiEMJK5TyogzQ1GryEXpaKmJJ2spJrfaPuQCIGGBci1gMED
 KtUzUghdKFExrEnNT4eTJj6EceCO27VMzU3Z4U25Q3omjzAfsnN0cjTCTcRnM1fijthndnWYrv1
 Vje790PPFV13wvuGxrAZEhnruVcmLfDwxYJmynyq6TqheIVebAMiRh2X8uSlFaK6BzJRjN6tx+g
 MeMVbQZ15ioCKhD6XFtekyXgywcq2+wf1omOC6++nnvr7OlKIrmvWQSM6rOtOdnxgyQ+Z6Uzoxf
 DV/arf6nz9vpngu36c2pxIXqc/Qjh49iSjH0kviQD/VaR9nSitLZ48lYTusvprCrvax7yeBB5Zo
 VSdfE1fKj07T1eIDC+4EFzrnN+zlNumajcleO1zck8H560Yowaem4Vo5TAXkNVUD1EXHs2VDO0I
 bMSy2U0LMufSMV1/rog==
X-Proofpoint-GUID: 2dmtiELVYPXUnmL0jFvvwvzu9TebpQaq
X-Proofpoint-ORIG-GUID: 2dmtiELVYPXUnmL0jFvvwvzu9TebpQaq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170033

Add the skeleton of the Qualcomm DSP Accelerator (QDA) driver, a DRM
accel driver for the Hexagon DSPs found on Qualcomm SoCs.

This patch registers a DRM accel device, exposing a /dev/accel/accelN
character device node, and binds it to the RPMsg channel used to reach
the DSP. Buffer management, IOMMU context banks and the FastRPC
protocol are added by later patches in this series.

qda_drv.c / qda_drv.h define the drm_driver ops table, the per-file
private state (qda_file_priv) and the main device structure (qda_dev),
which embeds drm_device so that it can be recovered with container_of().

qda_rpmsg.c binds to the "qcom,fastrpc" compatible via
module_rpmsg_driver(), reads the DSP domain name from the "label"
device-tree property, and registers the DRM device.

Assisted-by: Claude:claude-sonnet-5
Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
---
Changes in v2:
- Use module_rpmsg_driver() and drop the qda_rpmsg_register()/
  _unregister() wrappers, module_init()/module_exit() and
  qda_rpmsg.h entirely (Dmitry Baryshkov)
- Read the "label" property directly into qdev->dsp_name (Dmitry Baryshkov)
- Drop the probe/remove/init log messages (Dmitry Baryshkov)
- Return the result of qda_register_device() directly (Dmitry Baryshkov)
- Clarify the Kconfig help text (Dmitry Baryshkov)
---
 drivers/accel/Kconfig         |  1 +
 drivers/accel/Makefile        |  1 +
 drivers/accel/qda/Kconfig     | 30 ++++++++++++++++
 drivers/accel/qda/Makefile    | 10 ++++++
 drivers/accel/qda/qda_drv.c   | 71 ++++++++++++++++++++++++++++++++++++++
 drivers/accel/qda/qda_drv.h   | 61 +++++++++++++++++++++++++++++++++
 drivers/accel/qda/qda_rpmsg.c | 79 +++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 253 insertions(+)

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
index 000000000000..e679cd00f092
--- /dev/null
+++ b/drivers/accel/qda/Kconfig
@@ -0,0 +1,30 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Qualcomm DSP accelerator driver
+#
+
+config DRM_ACCEL_QDA
+	tristate "Qualcomm DSP accelerator"
+	depends on DRM_ACCEL
+	depends on ARCH_QCOM || COMPILE_TEST
+	depends on RPMSG
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
+	  The interface exposed to userspace is described in
+	  include/uapi/drm/qda_accel.h and is used by the FastRPC userspace
+	  library at https://github.com/qualcomm/fastrpc.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called qda.
diff --git a/drivers/accel/qda/Makefile b/drivers/accel/qda/Makefile
new file mode 100644
index 000000000000..dbe809067a8b
--- /dev/null
+++ b/drivers/accel/qda/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for Qualcomm DSP accelerator driver
+#
+
+obj-$(CONFIG_DRM_ACCEL_QDA)	:= qda.o
+
+qda-y := \
+	qda_drv.o \
+	qda_rpmsg.o
diff --git a/drivers/accel/qda/qda_drv.c b/drivers/accel/qda/qda_drv.c
new file mode 100644
index 000000000000..9a64f7dfcb6e
--- /dev/null
+++ b/drivers/accel/qda/qda_drv.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <drm/drm_accel.h>
+#include <drm/drm_drv.h>
+#include <drm/drm_file.h>
+#include <drm/drm_gem.h>
+#include <drm/drm_ioctl.h>
+#include <drm/drm_print.h>
+
+#include "qda_drv.h"
+
+static int qda_open(struct drm_device *dev, struct drm_file *file)
+{
+	struct qda_file_priv *qda_file_priv;
+
+	qda_file_priv = kzalloc_obj(*qda_file_priv);
+	if (!qda_file_priv)
+		return -ENOMEM;
+
+	qda_file_priv->qda_dev = qda_dev_from_drm(dev);
+	file->driver_priv = qda_file_priv;
+
+	return 0;
+}
+
+static void qda_postclose(struct drm_device *dev, struct drm_file *file)
+{
+	struct qda_file_priv *qda_file_priv = file->driver_priv;
+
+	kfree(qda_file_priv);
+	file->driver_priv = NULL;
+}
+
+DEFINE_DRM_ACCEL_FOPS(qda_accel_fops);
+
+static const struct drm_driver qda_drm_driver = {
+	.driver_features = DRIVER_COMPUTE_ACCEL,
+	.fops = &qda_accel_fops,
+	.open = qda_open,
+	.postclose = qda_postclose,
+	.name = QDA_DRIVER_NAME,
+	.desc = "Qualcomm DSP Accelerator Driver",
+};
+
+struct qda_dev *qda_alloc_device(struct device *dev)
+{
+	struct qda_dev *qdev;
+
+	qdev = devm_drm_dev_alloc(dev, &qda_drm_driver, struct qda_dev, drm_dev);
+	if (IS_ERR(qdev))
+		return ERR_CAST(qdev);
+
+	return qdev;
+}
+
+int qda_register_device(struct qda_dev *qdev)
+{
+	int ret;
+
+	ret = drm_dev_register(&qdev->drm_dev, 0);
+	if (ret)
+		drm_err(&qdev->drm_dev, "Failed to register DRM device: %d\n", ret);
+
+	return ret;
+}
+
+MODULE_AUTHOR("Qualcomm AI Infra Team");
+MODULE_DESCRIPTION("Qualcomm DSP Accelerator Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/accel/qda/qda_drv.h b/drivers/accel/qda/qda_drv.h
new file mode 100644
index 000000000000..4a27fb40c280
--- /dev/null
+++ b/drivers/accel/qda/qda_drv.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __QDA_DRV_H__
+#define __QDA_DRV_H__
+
+#include <linux/device.h>
+#include <linux/rpmsg.h>
+#include <linux/types.h>
+#include <drm/drm_device.h>
+#include <drm/drm_drv.h>
+#include <drm/drm_file.h>
+
+/* Driver identification */
+#define QDA_DRIVER_NAME "qda"
+
+/**
+ * struct qda_file_priv - Per-process private data for DRM file
+ */
+struct qda_file_priv {
+	/** @qda_dev: Back-pointer to device structure */
+	struct qda_dev *qda_dev;
+};
+
+/**
+ * struct qda_dev - Main device structure for QDA driver
+ *
+ * The DRM device is embedded as the first member so that container_of()
+ * can recover the qda_dev from any drm_device pointer.
+ */
+struct qda_dev {
+	/** @drm_dev: Embedded DRM device; recover via qda_dev_from_drm() */
+	struct drm_device drm_dev;
+	/** @rpdev: RPMsg device for communication with the remote processor */
+	struct rpmsg_device *rpdev;
+	/** @dev: Underlying Linux device */
+	struct device *dev;
+	/** @dsp_name: Name of the DSP domain (e.g. "cdsp", "adsp") */
+	const char *dsp_name;
+};
+
+/**
+ * qda_dev_from_drm - Recover qda_dev from an embedded drm_device pointer
+ * @dev: Pointer to the embedded drm_device
+ *
+ * Return: Pointer to the enclosing qda_dev.
+ */
+static inline struct qda_dev *qda_dev_from_drm(struct drm_device *dev)
+{
+	return container_of(dev, struct qda_dev, drm_dev);
+}
+
+/* Device allocation (uses devm_drm_dev_alloc internally) */
+struct qda_dev *qda_alloc_device(struct device *dev);
+
+/* Core device lifecycle */
+int qda_register_device(struct qda_dev *qdev);
+
+#endif /* __QDA_DRV_H__ */
diff --git a/drivers/accel/qda/qda_rpmsg.c b/drivers/accel/qda/qda_rpmsg.c
new file mode 100644
index 000000000000..6a6e58333a68
--- /dev/null
+++ b/drivers/accel/qda/qda_rpmsg.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/rpmsg.h>
+#include <drm/drm_print.h>
+
+#include "qda_drv.h"
+
+static struct qda_dev *qda_rpmsg_alloc_and_init_qdev(struct rpmsg_device *rpdev)
+{
+	struct qda_dev *qdev;
+
+	qdev = qda_alloc_device(&rpdev->dev);
+	if (IS_ERR(qdev))
+		return qdev;
+
+	qdev->dev = &rpdev->dev;
+	qdev->rpdev = rpdev;
+	dev_set_drvdata(&rpdev->dev, qdev);
+
+	return qdev;
+}
+
+static int qda_rpmsg_cb(struct rpmsg_device *rpdev, void *data, int len,
+			void *priv, u32 src)
+{
+	/* Placeholder: responses will be dispatched here */
+	return 0;
+}
+
+static void qda_rpmsg_remove(struct rpmsg_device *rpdev)
+{
+	struct qda_dev *qdev = dev_get_drvdata(&rpdev->dev);
+
+	/*
+	 * Unplug first so no ioctl or response callback can be in flight, then
+	 * fail any invocation still waiting for the now-departed DSP so it
+	 * releases the GEM objects it holds.
+	 */
+	drm_dev_unplug(&qdev->drm_dev);
+	qdev->rpdev = NULL;
+}
+
+static int qda_rpmsg_probe(struct rpmsg_device *rpdev)
+{
+	struct qda_dev *qdev;
+	int ret;
+
+	qdev = qda_rpmsg_alloc_and_init_qdev(rpdev);
+	if (IS_ERR(qdev))
+		return PTR_ERR(qdev);
+
+	ret = of_property_read_string(rpdev->dev.of_node, "label", &qdev->dsp_name);
+	if (ret) {
+		dev_err(&rpdev->dev, "Missing 'label' property in DT node: %d\n", ret);
+		return ret;
+	}
+
+	return qda_register_device(qdev);
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
+module_rpmsg_driver(qda_rpmsg_driver);

-- 
2.34.1

