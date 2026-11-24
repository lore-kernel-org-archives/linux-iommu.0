Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795478581;
	b=FF64ER6J4F5gBTJThHuiieghGm0iCzrwBlWpiLdTf6n6wDuhMjCS9t/Nrm+9iLy4hF2F
	 GxDijumjR4KcGd2xu5x+nOo8/XJu949EvmL3jCE9maTcXx79bzhMtfU+yvu041UAY2UXP
	 ofyi7pFtveMxNZWlUioLUiblf1F7O01L9y5mPMuyadYByuzq5pDyQB/a/NfSiiiQMwoIh
	 NhdvQPhzMeQIiIAgPONCOkoMsSdWSWuxP/Xvc3c0i5K+6Cw5NKLzAf4Zj0irkP9UfCoxl
	 gc6sVMbyZYmpMb6CUe0TY9P++/SWNN1V2SMi6JnAyZBqwfY58e7QtqfKG8vsHdGuZYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795478581;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=VD4BWCGipe5qWKwF707+XsXhVfaZ7v1dKr7weApmtKY=;
	b=CcrVNmQQaV7902OucAeHnSdpzSAvqb5QGrCeB7YKI7/l8W7JTL3bx/y7PHdUcGOdmEpF
	 q6adxKoK5UO8oE7f8wDVvKbXGDp6gTWy4yF43r4ja7cm94jYp8vK++OV2ALrCcgSVATDO
	 uJfv9yE1Z/JB0VZNTJ3Arcdj6OSSe/+p0nXmZ0TVoKr1zANTpBqfki+0YI3xGta5UvBcP
	 MTp6CClLhj49im/JRsRV76Rr6ljIjPpLG6zBn/I2Oi1VxXsJPrT9efIeFzIoxFmDSCkKF
	 d+WKd+QByx8eyqxYgvMuDVm+j7/9PGQv1rz0QrA7v8fd7svKAJt9AIaDogTo1nijMcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gahingwoo.com;
	spf=pass smtp.mailfrom=gahingwoo.com;
	dkim=pass header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm2 header.b=NppwvFCY;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="V/rBblsh";
	arc=none smtp.remote-ip=103.168.172.159
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C286606A330
	for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 00:03:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C286606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm2 header.b=NppwvFCY;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=V/rBblsh
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 92F2E14003AA
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 19:03:00 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 23 Nov 2026 19:03:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1795478580; x=
	1795564980; bh=VD4BWCGipe5qWKwF707+XsXhVfaZ7v1dKr7weApmtKY=; b=N
	ppwvFCYm7sdTwCgX4DAvKMG0VWkKr+TuAxy52BQ5zDe6igfV3vhHebsWjPNOITd2
	BLCNqUir4uc04IXDhkK2FW1MxcFS+Zv0tCJJS2DVieYlMJcEfXJ3k65LEoTCIW+D
	zpfKa07C6PEGiG5WzdXDk63q6a5rTBIRWu8pjqeLF96kLg7my95m1UoFs4uBp2Yp
	CQd2gSJ0SzxIWGmA+5lNM2ICfdjMIxLOQF5DWx1xKuKizuyHv7FmUkw2pJHzxwSv
	9LaX0wjQQaLcff3nkCx/NfR0uXc02dcHoLbdWSEs46dKXPWk2HPYC5hmcQnU+Luj
	bRlYOnzjimPIZXQt857TA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1795478580; x=1795564980; bh=V
	D4BWCGipe5qWKwF707+XsXhVfaZ7v1dKr7weApmtKY=; b=V/rBblshAaHnPs465
	yWiIIhgNjYtBtJ6NdUbMAlP4crVhT9dGaopc/lg/uXGUFjfTi3bnurrf/e4L0pgO
	Nhi+Nr2Xr7doTnVTblh3XS5WLaQjdhE0OdUeM6uE7Hd4wk0ZbrLvYQYHTTeKl+fP
	Qc75vnB302y+8JirRfLIJgkuYj2LZdzmSK6uM+Vm9/FLAU3auAdhWf2YG+BTzZl8
	3oLPIIA+1JcLyFmaAcGzvYCtA484SydL4jXoUFxG8CarI+qeAYEExja5UAcj7rf1
	xq6Nsi4Kx3Ap78k7VV9t3nf+dBC5SKgVTJMraBUy0PMbI3GBJTf1TM4PgQ87Oo7A
	CK4iw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=gahingwoo.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795478580; d=gahingwoo.com;
	mf=PGdhaGluZ0BnYWhpbmd3b28uY29tPg==;
	rt=PGlvbW11QGxpc3RzLmxpbnV4LmRldj4=;
	s=fm2:rsa-sha256:RRLKsgGVtFQdrjKg6HFDG5eOcK4emdF+op7ZzJP4myBmuti
	ObwQVE6hoFQhQRMNvlDNqkQ+j+N+3i5N4cHlfmBSOQhSgl7LOeLfsHcMJIKKEwej
	eksLGNc/zVjTsJ+z2vwqIkPTi14BZYIUj4VkYgpWGNWxhjRGB7JJ8Dwna/KIcxjG
	O6GM/Kr8BIJmq6gB8G5vxy8nDqH1D2+uEExGa96FLvMaWcRzCHjNPXA6iTLju5wo
	sZfH9ELFvkRasshgJ6EF7rNLTj/Tpir5wA7MxVIrqNNsra5TGQbRA+2ejARRqKTn
	kYZdrL0t6Mcm8v8zRD2rrQcd9OPT7GhgXiOUlyw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:kaiCEA07RQCWzB8KxAasko9Dk1TMgVxTSuOFiYg/uxA=:ZEvZEH0+c8eqFaJpuEOivncm7QGl8npRw6BTOkXsk+A=;
X-ME-Sender: <xms:NNQEa2phHLniJzXM5T53DXhLlyOOa6Kk6GYqGX-Lv24lQjYh5Slr_A>
    <xme:NNQEa_Cdw6gqJ4L2bIWFId1xZYgotNQjthHxYACp-Ed4_y_wDxvlj4TCKbw8tN3Bd
    4e9gaq8uF8zlTLRvwPpyJwYct3SbqzBjPRKVxmlJO3ksVLAA8pvXa9t>
X-ME-Received: <xmr:NNQEa2xgSfA1uNEhVw2MsHPSIv7aP8muq5yntSymHrCH1jMsBLlu52oAZySM54DjAWbIv3l7>
X-ME-Proxy-Cause: dmFkZTFUS31biL804kuGKZfG7Kl9vRZw2I6s1jSqisW9juGEOKIQI3caaZPmnYzTy1IeRs
    ZIjQyo9EsvQ+pFAb6a2GwGsCkpfm64Cpbysmsva7SlxXIZEws7ZWSeirQ+gtHAb3dvMCn3
    jN4Yhede77PyJGzU7k4gLFy4PEqreRe+vthzIbDwJPJS6DmEG3WzVwlJ/3mgZsdy/V2+nR
    tHMjB+HVJArNHdEBrN4tHBv8COLXwrJMgjFYZQqNTaNm34kaQv9FLGr3mFGqI7QkPkKvi3
    O1F5LYuA/j1anXPgXaQLGV7EQ8gZEI2g6oeOWT5ykgLUjRwdgxxnnGXmYni8bqw3vYMoDo
    bQRj4mGBX5IrAwjWQ8i8uZKH4ylV+fIAcEE+fYxeyQ19UsQuaaBUWnwfgXVk4kUR2Lpl1/
    TVOtvHA2xxtoWj/JU2FSXaxntSwIDgmhyiS428yHMed46sJ6eiGooBcKwluksu1ubC+j5V
    yqVeGTz2ruEks/MdPT3yXgRK62i6N6O7bSydUJYzkiWJHLWxI+jpKxtgSP4jRNaAx++eVK
    wNnLViiKctjCWfDxDPrZxUBQKMDqBAPmb6b2PYA94sZ7nNoiIbuIqUZHJBaLarUNNdMHer
    9Jcle4+rUYdJujuTHYnhynQnU6kFfgIFB775VaC+CoHx8KgwSkdCc4GL9Ndw
X-ME-Proxy: <xmx:NNQEa_7QDhV-Iwvu8xszU_XdvzdGDmkoX-8lxZbgA8UYVs8Ln9jQIg>
    <xmx:NNQEa_vBcwTdtHQhtRTS5sJJ5BwxviJBz0zXnpE_kDQMGpPhq0bhrQ>
    <xmx:NNQEa0vmHDW_Luc4IozHEqlp2MsZ5GcsbuFq9kpCBMNRWqudfKwF0Q>
    <xmx:NNQEa_snQfWGOol5ib_7dj-10G3BrNME3TwyF40diBSkDI0ox0en2Q>
    <xmx:NNQEayX83LhfYGHgx3At9CAtSExj3a3G9rFQtqClM48U3I5nZzAvMn9D>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Nov 2026 19:02:51 -0500 (EST)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net,
	heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	p.zabel@pengutronix.de,
	ogabbay@kernel.org,
	zhangqing@rock-chips.com
Cc: ddrake@baylibre.com,
	royalnet026@gmail.com,
	sidong.yang@furiosa.ai,
	ulf.hansson@oss.qualcomm.com,
	abel.vesa@oss.qualcomm.com,
	sebastian.reichel@collabora.com,
	chaoyi.chen@rock-chips.com,
	shawn.lin@rock-chips.com,
	finley.xiao@rock-chips.com,
	diederik@cknow-tech.com,
	alchark@flipper.net,
	leonard@lausen.nl,
	vlwwwwww@gmail.com,
	jeff.hugo@oss.qualcomm.com,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v18 6/8] accel/rocket: add RK3576 NPU (RKNN) support
Date: Tue, 24 Nov 2026 13:01:41 +1300
Message-ID: <c57db6883bb9c977f65d34569f1ed9cb5405bdda.1795478392.git.gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1795478392.git.gahing@gahingwoo.com>
References: <cover.1795478392.git.gahing@gahingwoo.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the RK3576 NPU. Its PC_TASK_CON has a 16-bit task number, with
pp_en, count_clear and last_layer_clear at BIT16, BIT17 and BIT18, as
Chaoyi Chen confirmed:

  https://lore.kernel.org/all/4f300b78-d96d-4d98-8819-dc292b0c9b97@rock-chips.com/

Add it to rocket_registers.h as TASK_CON_RK3576, generated from Mesa's
registers.xml, and use it on the RK3576. Count the cores in rocket_drv.c
against the match table, not only the RK3588 compatible.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 drivers/accel/rocket/rocket_device.c    |  9 +------
 drivers/accel/rocket/rocket_device.h    |  2 +-
 drivers/accel/rocket/rocket_drv.c       | 16 ++++++++++++-
 drivers/accel/rocket/rocket_job.c       | 15 ++++++++----
 drivers/accel/rocket/rocket_registers.h | 32 +++++++++++++++++++++++++
 include/uapi/drm/rocket_accel.h         |  2 ++
 6 files changed, 62 insertions(+), 14 deletions(-)

diff --git a/drivers/accel/rocket/rocket_device.c b/drivers/accel/rocket/rocket_device.c
index 3bceeb2cbedb..3243cb5093ff 100644
--- a/drivers/accel/rocket/rocket_device.c
+++ b/drivers/accel/rocket/rocket_device.c
@@ -6,19 +6,16 @@
 #include <linux/clk.h>
 #include <linux/dma-mapping.h>
 #include <linux/platform_device.h>
-#include <linux/of.h>
 
 #include "rocket_device.h"
 
 struct rocket_device *rocket_device_init(struct platform_device *pdev,
 					 const struct drm_driver *rocket_drm_driver,
-					 u32 hw_version)
+					 unsigned int num_cores, u32 hw_version)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *core_node;
 	struct rocket_device *rdev;
 	struct drm_device *ddev;
-	unsigned int num_cores = 0;
 	int err;
 
 	rdev = devm_drm_dev_alloc(dev, rocket_drm_driver, struct rocket_device, ddev);
@@ -29,10 +26,6 @@ struct rocket_device *rocket_device_init(struct platform_device *pdev,
 	dev_set_drvdata(dev, rdev);
 	rdev->hw_version = hw_version;
 
-	for_each_compatible_node(core_node, NULL, "rockchip,rk3588-rknn-core")
-		if (of_device_is_available(core_node))
-			num_cores++;
-
 	rdev->max_cores = num_cores;
 
 	rdev->cores = devm_kzalloc_objs(dev, *rdev->cores, num_cores);
diff --git a/drivers/accel/rocket/rocket_device.h b/drivers/accel/rocket/rocket_device.h
index 40cabae538bc..b8571750c34b 100644
--- a/drivers/accel/rocket/rocket_device.h
+++ b/drivers/accel/rocket/rocket_device.h
@@ -27,7 +27,7 @@ struct rocket_device {
 
 struct rocket_device *rocket_device_init(struct platform_device *pdev,
 					 const struct drm_driver *rocket_drm_driver,
-					 u32 hw_version);
+					 unsigned int num_cores, u32 hw_version);
 void rocket_device_fini(struct rocket_device *rdev);
 #define to_rocket_device(drm_dev) \
 	((struct rocket_device *)(container_of((drm_dev), struct rocket_device, ddev)))
diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/rocket_drv.c
index 8aa431db5968..da196474a9eb 100644
--- a/drivers/accel/rocket/rocket_drv.c
+++ b/drivers/accel/rocket/rocket_drv.c
@@ -195,6 +195,18 @@ static int rocket_core_hw_index(struct device *dev)
 	return -ENODEV;
 }
 
+static unsigned int rocket_count_cores(struct device *dev)
+{
+	struct device_node *np;
+	unsigned int num_cores = 0;
+
+	for_each_matching_node(np, dev->driver->of_match_table)
+		if (of_device_is_available(np))
+			num_cores++;
+
+	return num_cores;
+}
+
 static int rocket_probe(struct platform_device *pdev)
 {
 	u32 hw_version = (uintptr_t)device_get_match_data(&pdev->dev);
@@ -212,7 +224,8 @@ static int rocket_probe(struct platform_device *pdev)
 		rdev_group = devres_open_group(&drm_dev->dev, NULL, GFP_KERNEL);
 		if (!rdev_group)
 			return -ENOMEM;
-		rdev = rocket_device_init(drm_dev, &rocket_drm_driver, hw_version);
+		rdev = rocket_device_init(drm_dev, &rocket_drm_driver,
+					  rocket_count_cores(&pdev->dev), hw_version);
 		if (IS_ERR(rdev)) {
 			int err = PTR_ERR(rdev);
 
@@ -274,6 +287,7 @@ static void rocket_remove(struct platform_device *pdev)
 
 static const struct of_device_id dt_match[] = {
 	{ .compatible = "rockchip,rk3588-rknn-core", .data = (void *)DRM_ROCKET_HW_RK3588 },
+	{ .compatible = "rockchip,rk3576-rknn-core", .data = (void *)DRM_ROCKET_HW_RK3576 },
 	{}
 };
 MODULE_DEVICE_TABLE(of, dt_match);
diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index eed443c8406d..f6cb7685731a 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -166,10 +166,17 @@ static void rocket_job_hw_submit(struct rocket_core *core, struct rocket_job *jo
 	rocket_pc_writel(core, INTERRUPT_MASK, PC_INTERRUPT_MASK_DPU_0 | PC_INTERRUPT_MASK_DPU_1);
 	rocket_pc_writel(core, INTERRUPT_CLEAR, PC_INTERRUPT_CLEAR_DPU_0 | PC_INTERRUPT_CLEAR_DPU_1);
 
-	rocket_pc_writel(core, TASK_CON, PC_TASK_CON_RESERVED_0(1) |
-					 PC_TASK_CON_TASK_COUNT_CLEAR(1) |
-					 PC_TASK_CON_TASK_NUMBER(1) |
-					 PC_TASK_CON_TASK_PP_EN(1));
+	if (core->rdev->hw_version == DRM_ROCKET_HW_RK3576)
+		rocket_pc_writel(core, TASK_CON_RK3576,
+				 PC_TASK_CON_RK3576_LAST_LAYER_CLEAR(1) |
+				 PC_TASK_CON_RK3576_TASK_COUNT_CLEAR(1) |
+				 PC_TASK_CON_RK3576_TASK_PP_EN(1) |
+				 PC_TASK_CON_RK3576_TASK_NUMBER(1));
+	else
+		rocket_pc_writel(core, TASK_CON, PC_TASK_CON_RESERVED_0(1) |
+						 PC_TASK_CON_TASK_COUNT_CLEAR(1) |
+						 PC_TASK_CON_TASK_NUMBER(1) |
+						 PC_TASK_CON_TASK_PP_EN(1));
 
 	rocket_pc_writel(core, TASK_DMA_BASE_ADDR, PC_TASK_DMA_BASE_ADDR_DMA_BASE_ADDR(0x0));
 
diff --git a/drivers/accel/rocket/rocket_registers.h b/drivers/accel/rocket/rocket_registers.h
index 9aef614c3470..efcbb00d2aa5 100644
--- a/drivers/accel/rocket/rocket_registers.h
+++ b/drivers/accel/rocket/rocket_registers.h
@@ -195,6 +195,38 @@ static inline uint32_t PC_TASK_CON_TASK_NUMBER(uint32_t val)
 	return ((val) << PC_TASK_CON_TASK_NUMBER__SHIFT) & PC_TASK_CON_TASK_NUMBER__MASK;
 }
 
+#define REG_PC_TASK_CON_RK3576					0x00000030
+#define PC_TASK_CON_RK3576_RESERVED_0__MASK			0xfff80000
+#define PC_TASK_CON_RK3576_RESERVED_0__SHIFT			19
+static inline uint32_t PC_TASK_CON_RK3576_RESERVED_0(uint32_t val)
+{
+	return ((val) << PC_TASK_CON_RK3576_RESERVED_0__SHIFT) & PC_TASK_CON_RK3576_RESERVED_0__MASK;
+}
+#define PC_TASK_CON_RK3576_LAST_LAYER_CLEAR__MASK		0x00040000
+#define PC_TASK_CON_RK3576_LAST_LAYER_CLEAR__SHIFT		18
+static inline uint32_t PC_TASK_CON_RK3576_LAST_LAYER_CLEAR(uint32_t val)
+{
+	return ((val) << PC_TASK_CON_RK3576_LAST_LAYER_CLEAR__SHIFT) & PC_TASK_CON_RK3576_LAST_LAYER_CLEAR__MASK;
+}
+#define PC_TASK_CON_RK3576_TASK_COUNT_CLEAR__MASK		0x00020000
+#define PC_TASK_CON_RK3576_TASK_COUNT_CLEAR__SHIFT		17
+static inline uint32_t PC_TASK_CON_RK3576_TASK_COUNT_CLEAR(uint32_t val)
+{
+	return ((val) << PC_TASK_CON_RK3576_TASK_COUNT_CLEAR__SHIFT) & PC_TASK_CON_RK3576_TASK_COUNT_CLEAR__MASK;
+}
+#define PC_TASK_CON_RK3576_TASK_PP_EN__MASK			0x00010000
+#define PC_TASK_CON_RK3576_TASK_PP_EN__SHIFT			16
+static inline uint32_t PC_TASK_CON_RK3576_TASK_PP_EN(uint32_t val)
+{
+	return ((val) << PC_TASK_CON_RK3576_TASK_PP_EN__SHIFT) & PC_TASK_CON_RK3576_TASK_PP_EN__MASK;
+}
+#define PC_TASK_CON_RK3576_TASK_NUMBER__MASK			0x0000ffff
+#define PC_TASK_CON_RK3576_TASK_NUMBER__SHIFT			0
+static inline uint32_t PC_TASK_CON_RK3576_TASK_NUMBER(uint32_t val)
+{
+	return ((val) << PC_TASK_CON_RK3576_TASK_NUMBER__SHIFT) & PC_TASK_CON_RK3576_TASK_NUMBER__MASK;
+}
+
 #define REG_PC_TASK_DMA_BASE_ADDR				0x00000034
 #define PC_TASK_DMA_BASE_ADDR_DMA_BASE_ADDR__MASK		0xfffffff0
 #define PC_TASK_DMA_BASE_ADDR_DMA_BASE_ADDR__SHIFT		4
diff --git a/include/uapi/drm/rocket_accel.h b/include/uapi/drm/rocket_accel.h
index c9271e469231..d1102b30f25a 100644
--- a/include/uapi/drm/rocket_accel.h
+++ b/include/uapi/drm/rocket_accel.h
@@ -199,11 +199,13 @@ enum drm_rocket_param {
 /**
  * enum drm_rocket_hw_version - the NPU, for DRM_ROCKET_PARAM_HW_VERSION
  * @DRM_ROCKET_HW_RK3588: the NPU of the RK3588.
+ * @DRM_ROCKET_HW_RK3576: the NPU of the RK3576.
  *
  * 0 is not used.
  */
 enum drm_rocket_hw_version {
 	DRM_ROCKET_HW_RK3588 = 1,
+	DRM_ROCKET_HW_RK3576 = 2,
 };
 
 /**
-- 
2.43.0

