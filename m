Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4800436AB5F
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 19:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771873794; cv=none; b=ly+NvZpO2T8LfZlNOuB3Z+ju8J5dDTSj4t8/AeG/U0dJy/qMFvicezDsY+3Nw3uZk/nZkFVumeOF7Ri1r9RdW+97zQjx1XAKwRMa52ApYyPHeQy9HPuf24hK6/pSzH/ytcj3hBV72hS2bDVjjBaGM5oPw4te5omkhyp819t7ROY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771873794; c=relaxed/simple;
	bh=kVGIvUQYd8fYwcDgOBRxiOF7ByQocRT92vAbYBLm9bM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MQZ7l5E91zZaqi8XvE4RndJw6uK6LIIcwBA5BYjqRwqm8KHxdBOhO+GYDBpcJqdNVxIQZkqaiS9IGJm19VcdEy+DEsS0gYyl6AnesWH4ZlCsq+V+Ugd834iyJmLCpGc6ZB4NQpi7aGHzPfp8E6lW1MU8lqLlasN0ZxM5VU5R9as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RpEkL3VY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FrZmHcnQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RpEkL3VY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FrZmHcnQ"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NH4frN910746
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 19:09:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lsNmoBqASYHT9cEHp6wiIElpPi1KeWEI5rpj2+q1iIA=; b=RpEkL3VYvUKXqlya
	rYKRGcHWELDmVNYUNjnxgaIdhwD3KZgSYGrqLnKFuPWyuvoQM1Xt/tB8z+itdjaL
	hUMX7cRvkVeH1g+D5hG/1D5cI4Ai56L1IOftdKHXVO9Vaazy29/L5DUIYI7z2weP
	jzqBj92+V55qvY8gekJVzOhP4EhUq7Vjl8qBLKzi/7fi5OMOIVIIr1ZybznKDKaJ
	rLqgDg2+tvUKMjunp9+3WWW/IG8ukDYG21pMIKylZ0a0yqugjrbgXAENI4aHIQm+
	YuEhYfWYiDAF1iL+8ObVpGRdMq7Iv4sVPPiO4Y2Q6lpjgmnH0QNyyU2apjaYbDhh
	6QBuwA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cgtyj8d3t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 19:09:52 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a8f8c81d02so57862725ad.2
        for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 11:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771873792; x=1772478592; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lsNmoBqASYHT9cEHp6wiIElpPi1KeWEI5rpj2+q1iIA=;
        b=FrZmHcnQn5KwH0pwE64u7u6Yys2PMDtqFPiNnQ46k6y673p8rlGcMj3mywvBfyU97h
         vw+usCMeIbntk3KUBWvz4j7LonAX0YpV1FIgTAIulpU8JBZZDrDE7G0hBKYaEyyHZdhu
         1hJfweVShAG1jW8blSKNOj4c1mmz8FjuDesq9iX0c3qN5L0Apx0wyIjxhD7xlq+2BoLJ
         8lLxY9GPs4W6t2j5SoMu1Z2arg4b6uT5bhxfxY6+cwHRAhu5CcxPEwVwoiiwM7y3zf/6
         ewxrZkc2ykprJyxb3ZkZgK3/qjaIbzWtB5JXYKqa2JDbRY90aOkmiVsP9qOOAL76fm2Q
         VFlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771873792; x=1772478592;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lsNmoBqASYHT9cEHp6wiIElpPi1KeWEI5rpj2+q1iIA=;
        b=iVZrJp4tb1Sqju/tPxAMrATs3ck/ZFVIdGB5yODWKWC8zf3xjTJPt0G9J0KGULPKys
         X0hr2izybPr+oLgxOgCxzz8eZnAczQ2/LGWRcGS4FpgE9vwUHdQFkJyLCo5U5ZevC/fn
         N+X7cte7LjaDdq5NXHEsywMOHOrN4PYxCU892e/6xAF5SIMh7AaEYrrtPdBYcdQ06Fkr
         I3Srmzo5kZJA1m8dvu2vYX85a8H40OoNUF/hSyOiBXBvMs/xIsuiI98M7gCjb9xRKlwj
         7NuiqNf3eYBh/kpH/H23+B10jvgTVl8mHcfwhrCmfNOmijvD3DDFXgzHfTinSilddUm+
         c07g==
X-Forwarded-Encrypted: i=1; AJvYcCX0fUP/bcmJTS8F3kQrZWiZ1CC6TVwwW4oNXTLKzt7dD9I84Z2dfcE5y1zfLD9CG3eU4rTICQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxMZ2zm+ZPNPOpR2AEWQLHRi8liCAcEsV8t3RqxvikJdL6qVmHg
	lWq+5d/Iw7T+PPKe0yudEGt8PNfwQqqz79dORs0TSvXOgyQHDvm4gBZqMzbeOIAe4PDEcmizgxg
	+EdxQk/MTuCmmhtJlfnisZzlM9L+aOzeBuH4TbKCXfPNSiFdZShIrPbBAeA==
X-Gm-Gg: ATEYQzxts7v4QWBZ9QUVrsA7T9uU2G6Xe7ZmbSHJ4x+w7QHyQxXu0ySRg2/Ib9G4n7h
	+rKI+68P53tLTkQ3ldNn2d7AZaABInnTk5mBQE3aKymyW7TKsFm9CHNOn/uPEjy2Cp5+UXRLFac
	JuLB/VoLBuSyxPIilkY5BpSQ6H5uB+e87NrsiEZhGUDcPQZae+Y9Av+SwwksnUaDS5lxG81zHMi
	5pjPcwf5jdtstWMhVneD0Usw92ZMOKliWZtqawkbM29Ykspg71AkKZASQr8XVbXur1WWr48dfBL
	5MJgDv2IrPkegn5LNbvk0IxiZblnqwxco/2DldwZYsIRrVO4TESGxcJT0pzY8js70PjKHdIwgXA
	YxTRR0JiKZukBcQinbp1HMffCfN+n7jon+XkVcVM1rJ+O4/4SMl1Nlg==
X-Received: by 2002:a17:902:ced0:b0:2a0:d629:903c with SMTP id d9443c01a7336-2ad74516615mr88514315ad.30.1771873791759;
        Mon, 23 Feb 2026 11:09:51 -0800 (PST)
X-Received: by 2002:a17:902:ced0:b0:2a0:d629:903c with SMTP id d9443c01a7336-2ad74516615mr88513935ad.30.1771873791111;
        Mon, 23 Feb 2026 11:09:51 -0800 (PST)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad74e34e18sm83501505ad.10.2026.02.23.11.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 11:09:50 -0800 (PST)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Date: Tue, 24 Feb 2026 00:38:58 +0530
Subject: [PATCH RFC 04/18] accel/qda: Add built-in compute CB bus for QDA
 and integrate with IOMMU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-qda-firstpost-v1-4-fe46a9c1a046@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771873753; l=4943;
 i=ekansh.gupta@oss.qualcomm.com; s=20260223; h=from:subject:message-id;
 bh=kVGIvUQYd8fYwcDgOBRxiOF7ByQocRT92vAbYBLm9bM=;
 b=rUIy5HgCLDRhZVp2IzTGLrvCMsULd21ubbtDKIPuQIn9m/tfFsvEGy2LbREw4uK3leLblRQUp
 ul4rak0R2xhAnwPvhY8PF/SfHK0rFwibTRGVhaul0H1g9UdEczMQ+K5
X-Developer-Key: i=ekansh.gupta@oss.qualcomm.com; a=ed25519;
 pk=n0SepARizye+pYjhjg1RA5J+Nq4+IJbyRcBybU+/ERQ=
X-Authority-Analysis: v=2.4 cv=Jq/8bc4C c=1 sm=1 tr=0 ts=699ca600 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=Rss5_8j3o1z-bWaeIIsA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: iHF3N90ID9p0B8UjAuylMPOhQp2NnGTu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDE2NiBTYWx0ZWRfX/rrrudmahhsz
 juVqhIHWGnz3hlMiSmsoroOWEukCNr4EjAjbMYG/AckeOXV+EqzF58WzMccAEEr+RbwLgWhifDu
 582YRV+RXg5plDjewWGk9cR/zgNOmiGSEZA123ihjZKTUdljAb/IoFcQLKnQldluAq1GdA5sMiR
 xwd6azriFxYvFzMynyXWFqVsrYnV1qU36jPBH5gujHOwtWjFGgTR5fd62pVgz43OQeTbdkMtwQF
 WlaFDzhk4RnovTU5zeqPIW73HsDf+pff8erUuu+oqIPBDxIvg/nv/3x24cR0Hf61a37gtq0lGP7
 bgsFYIASif9H9/x0/0pWLUs2ffMU3315QI1g9Td8Qym7w7Q1AJvuTyLqEt2Y7z7wP1d7rCT815S
 MBLORJqVKshMRHeJ0L6xvK9+ltOhTS3MKckjHaYWIQFxiGDHX1OqypDCbxjNAK6+wH5qoXgAWcD
 Nx5ZcQmfRypGgs+E3Fg==
X-Proofpoint-GUID: iHF3N90ID9p0B8UjAuylMPOhQp2NnGTu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_04,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 adultscore=0 phishscore=0 suspectscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602230166

Introduce a built-in compute context-bank (CB) bus used by the Qualcomm
DSP accelerator (QDA) driver to represent DSP CB devices that require
IOMMU configuration. This separates the CB bus from the QDA driver and
allows QDA to remain a loadable module while the bus is always built-in.

A new bool Kconfig symbol DRM_ACCEL_QDA_COMPUTE_BUS is added and is
selected by the main DRM_ACCEL_QDA driver. The parent accel Makefile is
updated to descend into the QDA directory for both built-in and module
builds so that the CB bus is compiled into vmlinux while the driver
remains modular.

The CB bus is registered at postcore_initcall() time and is exposed to
the IOMMU core through iommu_buses[] in the same way as the Tegra
host1x context-bus. This enables later patches to create CB devices on
this bus and obtain IOMMU domains for them.

Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
---
 drivers/accel/Makefile              |  1 +
 drivers/accel/qda/Kconfig           |  5 +++++
 drivers/accel/qda/Makefile          |  2 ++
 drivers/accel/qda/qda_compute_bus.c | 23 +++++++++++++++++++++++
 drivers/iommu/iommu.c               |  4 ++++
 include/linux/qda_compute_bus.h     | 22 ++++++++++++++++++++++
 6 files changed, 57 insertions(+)

diff --git a/drivers/accel/Makefile b/drivers/accel/Makefile
index 58c08dd5f389..9ed843cd293f 100644
--- a/drivers/accel/Makefile
+++ b/drivers/accel/Makefile
@@ -6,4 +6,5 @@ obj-$(CONFIG_DRM_ACCEL_HABANALABS)	+= habanalabs/
 obj-$(CONFIG_DRM_ACCEL_IVPU)		+= ivpu/
 obj-$(CONFIG_DRM_ACCEL_QAIC)		+= qaic/
 obj-$(CONFIG_DRM_ACCEL_QDA)		+= qda/
+obj-$(CONFIG_DRM_ACCEL_QDA_COMPUTE_BUS) += qda/
 obj-$(CONFIG_DRM_ACCEL_ROCKET)		+= rocket/
\ No newline at end of file
diff --git a/drivers/accel/qda/Kconfig b/drivers/accel/qda/Kconfig
index 484d21ff1b55..ef1fa384efbe 100644
--- a/drivers/accel/qda/Kconfig
+++ b/drivers/accel/qda/Kconfig
@@ -3,11 +3,16 @@
 # Qualcomm DSP accelerator driver
 #
 
+
+config DRM_ACCEL_QDA_COMPUTE_BUS
+	bool
+
 config DRM_ACCEL_QDA
 	tristate "Qualcomm DSP accelerator"
 	depends on DRM_ACCEL
 	depends on ARCH_QCOM || COMPILE_TEST
 	depends on RPMSG
+	select DRM_ACCEL_QDA_COMPUTE_BUS
 	help
 	  Enables the DRM-based accelerator driver for Qualcomm's Hexagon DSPs.
 	  This driver provides a standardized interface for offloading computational
diff --git a/drivers/accel/qda/Makefile b/drivers/accel/qda/Makefile
index e7f23182589b..242684ef1af7 100644
--- a/drivers/accel/qda/Makefile
+++ b/drivers/accel/qda/Makefile
@@ -8,3 +8,5 @@ obj-$(CONFIG_DRM_ACCEL_QDA)	:= qda.o
 qda-y := \
 	qda_drv.o \
 	qda_rpmsg.o \
+
+obj-$(CONFIG_DRM_ACCEL_QDA_COMPUTE_BUS) += qda_compute_bus.o
diff --git a/drivers/accel/qda/qda_compute_bus.c b/drivers/accel/qda/qda_compute_bus.c
new file mode 100644
index 000000000000..1d9c39948fb5
--- /dev/null
+++ b/drivers/accel/qda/qda_compute_bus.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+#include <linux/device.h>
+#include <linux/init.h>
+
+struct bus_type qda_cb_bus_type = {
+	.name = "qda-compute-cb",
+};
+EXPORT_SYMBOL_GPL(qda_cb_bus_type);
+
+static int __init qda_cb_bus_init(void)
+{
+	int err;
+
+	err = bus_register(&qda_cb_bus_type);
+	if (err < 0) {
+		pr_err("qda-compute-cb bus registration failed: %d\n", err);
+		return err;
+	}
+	return 0;
+}
+
+postcore_initcall(qda_cb_bus_init);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 4926a43118e6..5dee912686ee 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -33,6 +33,7 @@
 #include <trace/events/iommu.h>
 #include <linux/sched/mm.h>
 #include <linux/msi.h>
+#include <linux/qda_compute_bus.h>
 #include <uapi/linux/iommufd.h>
 
 #include "dma-iommu.h"
@@ -178,6 +179,9 @@ static const struct bus_type * const iommu_buses[] = {
 #ifdef CONFIG_CDX_BUS
 	&cdx_bus_type,
 #endif
+#ifdef CONFIG_DRM_ACCEL_QDA_COMPUTE_BUS
+	&qda_cb_bus_type,
+#endif
 };
 
 /*
diff --git a/include/linux/qda_compute_bus.h b/include/linux/qda_compute_bus.h
new file mode 100644
index 000000000000..807122d84e3f
--- /dev/null
+++ b/include/linux/qda_compute_bus.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __QDA_COMPUTE_BUS_H__
+#define __QDA_COMPUTE_BUS_H__
+
+#include <linux/device.h>
+
+/*
+ * Custom bus type for QDA compute context bank (CB) devices
+ *
+ * This bus type is used for manually created CB devices that represent
+ * IOMMU context banks. The custom bus allows proper IOMMU configuration
+ * and device management for these virtual devices.
+ */
+#ifdef CONFIG_DRM_ACCEL_QDA_COMPUTE_BUS
+extern struct bus_type qda_cb_bus_type;
+#endif
+
+#endif /* __QDA_COMPUTE_BUS_H__ */

-- 
2.34.1

