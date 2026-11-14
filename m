Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794625631;
	b=o70GveF9wdYR2xGVEWCRpZ2Mg3uMIkKrhWjSBw7/qZ0Jr1zYXotueMEajOccejEg7nWP
	 mdgh+ThN1wZgfRT2dMhSFz5KEydFRNmJgi+GgYDRG/8FJPTcs2NreTrScxKmSwRaN/a2T
	 xiFcupbPZebYxlPJrFqymg7b33lFwk10p9sqv0ROvWL3YIbjNKqWwhU7Z7k/l4sOu6jee
	 5bWXZsN1Hc+9lxiZ936SuYSRsiQoekFsRlqkfTCoH2/0R8jT3jnHTEuKcykkG9poysy+0
	 HD8Qu8+58wQIIlqhNugID4/A7X8uCM6xGO2yT11osKKYgZThOgo1yL+ziGSYP2O2Klg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794625631;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=iGWIXFPBAskkErhFkKBy4iJxNdoQOpKT8TAJDBnwcSA=;
	b=nXn2t3XRzSmOj68IwdJa2Tip6vSA0tUhDwjxmLdHurQeAYQphPvKEPekQs0PsuMHfXt+
	 SIoR2mh1bxS27b6owIHm32sqH8BpbVCGv3Rb2p9xv4sXJ38ob0ISRorydA2VGciT4PzWi
	 y4QJU+xteyim2NxURXIRq2CEr9nFMp7dx6BbQKZiB6qq7ZKC+1aKpl+SzVXTUMXeMWZEy
	 +koG2MHzzE7YwiR6M9jhVCSi1VjEuRNdCjAFQuC7QyCqKdCvJxXgDrl3D+TOmVzdcQDWo
	 oV27JtR8qIRPi21ISD69EUdvePN6IpsWt6VNuYqqENOj/7otssJWisa5RnnMfjT1VrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gahingwoo.com;
	spf=pass smtp.mailfrom=gahingwoo.com;
	dkim=pass header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=FZGMFB4T;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=56+s65Ft;
	arc=none smtp.remote-ip=103.168.172.139
Received: from flow-a4-smtp.messagingengine.com (flow-a4-smtp.messagingengine.com [103.168.172.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CE0606A338
	for <iommu@lists.linux.dev>; Sat, 14 Nov 2026 03:07:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0CE0606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=FZGMFB4T;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=56+s65Ft
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.phl.internal (Postfix) with ESMTP id 16B5E1381A47
	for <iommu@lists.linux.dev>; Fri, 13 Nov 2026 22:07:10 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 13 Nov 2026 22:07:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1794625629; x=
	1794632829; bh=iGWIXFPBAskkErhFkKBy4iJxNdoQOpKT8TAJDBnwcSA=; b=F
	ZGMFB4TJG7xtiYFo4Hk522Tz/pXGIXgNF3EZtaYoj0kJICfwSCEsieSlXjBGlnqd
	q8w1YzQ5QKEMNBqhNRK3HOkXrgHFwy/GhNXGH9/yFZ6GbKxl31RbQJYWGBf6fRGC
	JVJd70cCUXJy8hXy+ih2R9R0lUUI0BmyhgTpLap0d4CG0TFFN1VDQCCvtvrCWqJN
	84q9mvVVaTHxnDht1iXZcXooovdJIdQTMWR+fxnUieulkUOhhqhQlt/jZm8icjpE
	fLuUCqZaznPeu39dkw04pUVVQQZxMq9yMqEmvO+0ypBC/+QarjflxzhDpt8nl9Mn
	aXlgRZ1XmhB/WR14yWZPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794625629; x=1794632829; bh=i
	GWIXFPBAskkErhFkKBy4iJxNdoQOpKT8TAJDBnwcSA=; b=56+s65FtBOsj2iBOp
	bcoT6NTmYYMd2cIKkw6LjvFGnkQrLiEOwBfXTr/9HK7T3hhtU8SZTabkAgmovtaw
	rC4yNIVqG9lfSbFCqoSDnV9Wyg8Qe3P8hsv6gM+hU4ttaqJKeqUq+5D+oxXiixFs
	HhRu47wsFQMGNT6PiFFER/6OHtk8VpilHvWDUoI9HK3qWYBkB0svRlSxHmq1U15I
	t/jkg5cYOCgtfN88NPYGGnqB5vPxyzjb9NjfoH15iwaVsgJX5qSp22WcXJdvutt1
	lX+8d8uJI41O+A4C7Sx9kTabZ2ZkzIy+z+uK7tZle4Su40yNVZnQLasBCbpajw8U
	vUjbQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=gahingwoo.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794625629; d=gahingwoo.com;
	mf=PGdhaGluZ0BnYWhpbmd3b28uY29tPg==;
	rt=PGlvbW11QGxpc3RzLmxpbnV4LmRldj4=;
	s=fm1:rsa-sha256:mFWD0pTXxjcUnhUB3/2ZKyNb1JFEKjxacOVx1DcQ4GM99BX
	HdxyvJzEYXLkh+nuAyJrQmv/AU2f9FTeAvB/iTg7FcNKqFaXIikJ8sLes0BvRefV
	ZH6/er+wtNh+zMhTo6N7PGUgbx/a6iSRwUOMLtM1gZm/INZJrYIpWZC/v1cG9GE5
	ghdyISFzl6PxHP49DOCflx6XRH8oUxu2U+aP32cDRG3mto3Qllh8ayVYfgXnxfXz
	fdfk6IHIexDtTytylcz6PPXcwlXDPhVV/S3INfmK5IgAsdSrMjA5XCrILu7P/6iu
	S4Y4S+ZgAgu11WgJL6vr4c4sOLQ/oYJPxeh5OPg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:zjek7cGZpIn7UJ/Qd1CE+tQiN0Lcz846LffH7xYq27M=:t4XZljyf4r49w/JA52om5qZZDmnryD7F5+35Gs6wz74=;
X-ME-Sender: <xms:XdD3akv7y4amK4DwtcUqZIOQfDzKiPQ96A6-yJPNd7lwwXBloG4mSA>
    <xme:XdD3at7hUj_Ze6uxtYZAoJ00Suh3GH6MN--C6MFgkaO2z3G9heDTOGDOMadsCuYuQ
    7apJVpm8C4GmFbSJ2TJXSAF8Ekny27IzUhwgbrgSf9rTkelZBXHt1z5>
X-ME-Received: <xmr:XdD3anDqvTTAwuPXBxvhzkQhD-7fxgRNBb7ZQEUywbzvIbkbS0sE9yq5FYvYj-lFev5XjUBZ>
X-ME-Proxy-Cause: dmFkZTENh3Cq6bNtRDDqH//naJpK03OGhXB8Cp3eHHX2EpHYf2oBjZ1/43ruyqVDLzR5bI
    q7gV+k53czH7SJj0JMNaMvWBGkaUqaereb01ifHpul1q14DobEKJC2mDvQQE3HzqoOU9gl
    QO0UnCSJOnNpWmY1qWdj/IivEZ+5eJmA8XcRYmqsfPBSZaKqk9zCnQvCGUQuYFJdsYZGP5
    L8zECb373LU+oefpY9jKwOjkFDiU4CWxV3iExHL3zPnpeZwM1wkFJxhm/yJk+2AJ3ju4OO
    RXCknd9xSS299sQU1FiikwzYfEAyF9m0XTBIDoIn2qfRRJDU3uzKkImCFIAQPMS5Q++UsR
    Pj8WGhog14V2oPv0Cbbor+mzw6PegcxRpm5myXv4LDEhkE1PkXw4sxqyUJNO/+Ym/WoTtY
    tb+wGIzcEdR5gpJ/co3yvFnixhD41GzrC5cwFRLMOkoJNUefiqpzYTvbF89mCOgpXHkcbt
    /SC0IgYaKIaxYmpKCKFIa6XINF/BgHg5SpjhwJdNmQtEtkQyf3c6uXdmAEvJL/O0Mgt6hP
    QQitoEWPB/NvR+jtz/GGnwYE+plZ1G01Db2y81F9XGpwZrv85P5crk/n0P2JQ7Anh//hJX
    XAhJDMWz6XDQ1NvCq46aIxmrDJB3gDVfUyllQ4UGMusM2kK3B9Yu8sPy8rJQ
X-ME-Proxy: <xmx:XdD3atuNEhIGL-RLMV9DqXQuLYStSLCB57ORfDyf-pbwYJqZTbQUqQ>
    <xmx:XdD3alONIGHGzzjoAqtndtXanGV0sVV-ngLB6FW6iv3I0fHANXBGnA>
    <xmx:XdD3alW12DKdSgnpska55ukpVd_c5dGD2jngsXmPMyy8czpNn8au_A>
    <xmx:XdD3agSIbQ4bpjHMTdIqY5wHBADZNtDhLpZg10Rdd9dGgzQEWmDxxQ>
    <xmx:XdD3auVlcDyYiSpXx4E2a3hOfdLwpDAvEbSimxIhGQ5-xJ-sWIuuwURm>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Nov 2026 22:07:00 -0500 (EST)
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
Cc: royalnet026@gmail.com,
	ulf.hansson@oss.qualcomm.com,
	abel.vesa@oss.qualcomm.com,
	sebastian.reichel@collabora.com,
	sidong.yang@furiosa.ai,
	u.kleine-koenig@baylibre.com,
	chaoyi.chen@rock-chips.com,
	shawn.lin@rock-chips.com,
	finley.xiao@rock-chips.com,
	diederik@cknow-tech.com,
	alchark@flipper.net,
	leonard@lausen.nl,
	vlwwwwww@gmail.com,
	jeff.hugo@oss.qualcomm.com,
	rfoss@kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v17 08/12] accel/rocket: select the per-core clock and reset counts from match data
Date: Sat, 14 Nov 2026 16:05:25 +1300
Message-ID: <fcdd7117d3d7fe99ea1658c39b6d1a05428823f4.1794615323.git.gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794615324.git.gahing@gahingwoo.com>
References: <cover.1794615324.git.gahing@gahingwoo.com>
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

The RK3576 and the RK3588 use the same NPU block, but with different
numbers of clocks and resets.

Take the number of clocks and resets for each core from soc_data in the
match data, so the driver uses the right count on each SoC.

The RK3588 keeps four clocks and two resets.

A device without match data fails before any resource is allocated.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 drivers/accel/rocket/rocket_core.c |  8 ++++----
 drivers/accel/rocket/rocket_core.h |  6 ++++++
 drivers/accel/rocket/rocket_drv.c  | 18 +++++++++++++++---
 3 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/accel/rocket/rocket_core.c b/drivers/accel/rocket/rocket_core.c
index c1458423cb69..040272573a72 100644
--- a/drivers/accel/rocket/rocket_core.c
+++ b/drivers/accel/rocket/rocket_core.c
@@ -23,7 +23,7 @@ int rocket_core_init(struct rocket_core *core)
 
 	core->resets[0].id = "srst_a";
 	core->resets[1].id = "srst_h";
-	err = devm_reset_control_bulk_get_exclusive(&pdev->dev, ARRAY_SIZE(core->resets),
+	err = devm_reset_control_bulk_get_exclusive(&pdev->dev, core->soc->num_resets,
 						    core->resets);
 	if (err)
 		return dev_err_probe(dev, err, "failed to get resets for core %d\n", core->index);
@@ -32,7 +32,7 @@ int rocket_core_init(struct rocket_core *core)
 	core->clks[ROCKET_CLK_HCLK].id = "hclk";
 	core->clks[ROCKET_CLK_NPU].id = "npu";
 	core->clks[ROCKET_CLK_PCLK].id = "pclk";
-	err = devm_clk_bulk_get(dev, ARRAY_SIZE(core->clks), core->clks);
+	err = devm_clk_bulk_get(dev, core->soc->num_clks, core->clks);
 	if (err)
 		return dev_err_probe(dev, err, "failed to get clocks for core %d\n", core->index);
 
@@ -106,9 +106,9 @@ void rocket_core_fini(struct rocket_core *core)
 
 void rocket_core_reset(struct rocket_core *core)
 {
-	reset_control_bulk_assert(ARRAY_SIZE(core->resets), core->resets);
+	reset_control_bulk_assert(core->soc->num_resets, core->resets);
 
 	udelay(10);
 
-	reset_control_bulk_deassert(ARRAY_SIZE(core->resets), core->resets);
+	reset_control_bulk_deassert(core->soc->num_resets, core->resets);
 }
diff --git a/drivers/accel/rocket/rocket_core.h b/drivers/accel/rocket/rocket_core.h
index 01a12664566c..05d34e538e36 100644
--- a/drivers/accel/rocket/rocket_core.h
+++ b/drivers/accel/rocket/rocket_core.h
@@ -35,9 +35,15 @@ enum rocket_clk {
 	ROCKET_CLK_MAX,
 };
 
+struct rocket_soc_data {
+	unsigned int num_clks;
+	unsigned int num_resets;
+};
+
 struct rocket_core {
 	struct device *dev;
 	struct rocket_device *rdev;
+	const struct rocket_soc_data *soc;
 	unsigned int index;
 
 	int irq;
diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/rocket_drv.c
index 5d7805c41dc3..1030d8407b78 100644
--- a/drivers/accel/rocket/rocket_drv.c
+++ b/drivers/accel/rocket/rocket_drv.c
@@ -159,8 +159,14 @@ static const struct drm_driver rocket_drm_driver = {
 
 static int rocket_probe(struct platform_device *pdev)
 {
+	const struct rocket_soc_data *soc = of_device_get_match_data(&pdev->dev);
 	int ret;
 
+	if (!soc) {
+		dev_err(&pdev->dev, "no match data for this device\n");
+		return -ENODEV;
+	}
+
 	if (rdev == NULL) {
 		/* First core probing, initialize DRM device. */
 		rdev = rocket_device_init(drm_dev, &rocket_drm_driver);
@@ -179,6 +185,7 @@ static int rocket_probe(struct platform_device *pdev)
 
 	rdev->cores[core].rdev = rdev;
 	rdev->cores[core].dev = &pdev->dev;
+	rdev->cores[core].soc = soc;
 	rdev->cores[core].index = core;
 
 	rdev->num_cores++;
@@ -216,8 +223,13 @@ static void rocket_remove(struct platform_device *pdev)
 	}
 }
 
+static const struct rocket_soc_data rk3588_soc_data = {
+	.num_clks = 4,
+	.num_resets = 2,
+};
+
 static const struct of_device_id dt_match[] = {
-	{ .compatible = "rockchip,rk3588-rknn-core" },
+	{ .compatible = "rockchip,rk3588-rknn-core", .data = &rk3588_soc_data },
 	{}
 };
 MODULE_DEVICE_TABLE(of, dt_match);
@@ -243,7 +255,7 @@ static int rocket_device_runtime_resume(struct device *dev)
 	if (core < 0)
 		return -ENODEV;
 
-	err = clk_bulk_prepare_enable(ARRAY_SIZE(rdev->cores[core].clks), rdev->cores[core].clks);
+	err = clk_bulk_prepare_enable(rdev->cores[core].soc->num_clks, rdev->cores[core].clks);
 	if (err) {
 		dev_err(dev, "failed to enable (%d) clocks for core %d\n", err, core);
 		return err;
@@ -263,7 +275,7 @@ static int rocket_device_runtime_suspend(struct device *dev)
 	if (!rocket_job_is_idle(&rdev->cores[core]))
 		return -EBUSY;
 
-	clk_bulk_disable_unprepare(ARRAY_SIZE(rdev->cores[core].clks), rdev->cores[core].clks);
+	clk_bulk_disable_unprepare(rdev->cores[core].soc->num_clks, rdev->cores[core].clks);
 
 	return 0;
 }
-- 
2.43.0

