Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795478560;
	b=JoDBZ4xZkMC3uxHSz/zxMOy1Oe4iy3ClCPGB56zRMY4IjvarUc4tD5aOsACWf/gTy0XB
	 k4IHdS3W4rF7OhCvlf2kpa8PRkKbeThf4htRXttKR6Jz3lm9O9x/Xrl8AalgHkk7psgPT
	 jG8cBGA7FxkpfwxHc3EzpVGCFGPa1vR6xDFYSWlTU0voNb+Ch0qoODy+97adxFnUj82bF
	 QgAaBGU5bT+1mavgEXTph0YEOepKmPl5cjKpAnrE1VZu/irV+Y2dfxEFQxu/ZpfDjlGtg
	 3frlNt574WPM4IuN+0Q1j67gyMUA3EG++2RhBNqyhJfw2I195GxYyTfcNM99LJEYnFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795478560;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=5gChaOh0z9ITaOvavblmd9ddbMFvDx31bGGfhd0xGvs=;
	b=zBRGUPfpKaLCz2PHMRXJe7TLHxDEVheYnniECKbTc2WX/VndVTFOKTCdG6U0dNWujtUj
	 eGdhCoO/ibMUaxgWy+1dYSY3S23bXGufl++l/Mp0jIRDKr9clvOpMrcT6LhG/LIZg1vmc
	 XmLfr465CfmKf0XmyAV41HqWxkrrJlhx1TcJmuWiVzpJD/M6I49fn8iwSxegTW+ZHAolk
	 RdY5UizuoCxzB+1EcX7HUu47RZBuN6F6i8vSNmQ43XMFPnb6BrdOkZFBSpDmZgUD6aZwv
	 FV091cbpk4oj1wqvoHDBqso2mPoXPFQvk7Fl+H5GOrcavsVtAeuNL9AgoP0fLUMuPmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gahingwoo.com;
	spf=pass smtp.mailfrom=gahingwoo.com;
	dkim=pass header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm2 header.b=RkeRQpba;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=vi1A0I+y;
	arc=none smtp.remote-ip=103.168.172.146
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829B9606A327
	for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 00:02:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 829B9606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm2 header.b=RkeRQpba;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=vi1A0I+y
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id BD8D3EC0B27
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 19:02:38 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 23 Nov 2026 19:02:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1795478558; x=
	1795564958; bh=5gChaOh0z9ITaOvavblmd9ddbMFvDx31bGGfhd0xGvs=; b=R
	keRQpba9RkgOemrSCA3iT88C3zxuNxRq4S6qxYstp0yDTj5AvdUqHmp8xu8Y0weB
	xwJnP7ViikslWulxgXmI0xW1Gn/Fm4BTVLHnLovPWk2OR7tPt5cL0v0FwA5MOJ2N
	lS+r//PUr0T+QOah3h87O0s87YItFt5+s3EXEJDB9sGjD/vp9OW2fm+Xk9/mZxAk
	XSDE55L1+8FmMKdROMhqTYAPThghsqdszR/Bc4APK0I0BZLA/TxLPG4S5YmbQqDw
	JiobZDx3mOb2Tcms9CHA276vEQDfXS1V4a/unyUXwSPR+kqfPMFl7+faMYB/AnwV
	GRNnhm08NGtzMcMIPuoIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1795478558; x=1795564958; bh=5
	gChaOh0z9ITaOvavblmd9ddbMFvDx31bGGfhd0xGvs=; b=vi1A0I+y57+7zxVKI
	nYgWbltlV6Vy4UQgaAJZm3rolDl+cFsTViv2Oofh0eL4B0yeq5LqWPzNfDVziVGa
	huKVbWWJvwBErG2ygbubEIgqDfuxvTyiNrBPF7zb78q3ujsIf1oMec06Kn9a//Sd
	IGqrc5hvOOamCFE2DgMCGWjCMyRdtLE3RYOErqcmATvr6XwwhGRqn52v5kiwwBn6
	VNkMK44D1GnmwntYvQicls4YAODVE6nGOehXTR+Tn8/ng407Vs1v4LLmvEiVVvg1
	Tu5KZY2tacmbPYe/Smz+/3HB1M7ebD/r5Oax2Npszl9ZU16wTZuT9GO7Y6RNWt/v
	QWx0A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=gahingwoo.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795478558; d=gahingwoo.com;
	mf=PGdhaGluZ0BnYWhpbmd3b28uY29tPg==;
	rt=PGlvbW11QGxpc3RzLmxpbnV4LmRldj4=;
	s=fm2:rsa-sha256:Va28RRloD+aK+kU1mb0ocBk2Y2K7iIXkwpyi4lFb6bDue9P
	AEvxlqQX66G1uykwx+2LxfSU1qGFmIZvhoKVuNVCHFZ65IuuxqONNrX09DZyfjUA
	LE25/QKG/40DNCf+gGdxwnzWgVxZXME4C6q8CUh5GoQjrWAOIudlNX/vpaEL3naY
	knJTJQ8YiMpUJfOPfkw6QeJrZ3pjItICPdebDv3SIbF7HuKLyjjOkDXxsV0stsEt
	rw3/VBKBnqecuin1cgLcslBg9C3Mb+YEZwTLXZ1tTjTI7YuCQ3ApHbnBqpPdEjAO
	UZaorjTaVo3lQfLkay7fxzhYmnrquHT9atI2TLw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:4DLNUv3hKSFgKh63r4zG2T7E1aUqDV3OIgh1AUUgPrc=:eTUBRs7zg0eoO0cWCyZch7gQr7pX0sDo/lRN9KBnQOU=;
X-ME-Sender: <xms:HtQEay9grY5Wr0B2YrDS90TYNRgl9lqu26u06q-MKptAGyVRhUNQhw>
    <xme:HtQEa9EVAZAjeH2psWd2TgShKgq2Mr7ce89I1FMXCavvX8-_beJTV_JTCeocnoG_A
    W5-iOxlZtTRzMJlyHuaecw8YmO78N6dAB-5fdD8d-Jt1B_PVAUX2Xg1Lw>
X-ME-Received: <xmr:HtQEazmRlUAUBeGpy7AVmEQjhf03xmTLcM0VUcIyUuJFrCxDbLjBzKDypW6daAD33K3CpSFL>
X-ME-Proxy-Cause: dmFkZTEopXBI6f3YcLzHLBBKwCWDCvgpdMsEsqbtaY0TFBoSglyVQDyJHTpiLPV5VpNAfn
    76ljyVF6s0HP1OwHzfC1fK2PNHwmp6cu6W42vhZ0PIDsaRSDz37xW7PsrBls+d9c2VPDBo
    Qfm8IIKjYJzUaCJwuE+ZZ8wVGV6Yd+xS3F7z1l+ytIDllrLiORi9BUdGiqIkBubFBhHkLJ
    NABHm4ykrFX9Ha2/IyljWmCRyAfAVhW46IYxM0SJ023OqYjcemuvbFXF7CD7I2xmXgTGO3
    GBi15t0p7xAar44wNIh0kIT6+hy5nJSoJMWoISB4Zp38sG55e7OK46pg5lV5LzjyvpHUcb
    t03z3/O4gTKzqw0ikN3dBASUxYs6YfqfzHVdFV5e3VhuyTAfHJfsetUaUfLXxIEOqQffQv
    epBduxSGu1BSUqVEC8KOBGgCYIinXDf5RVrTo8rKg3z2GEmBQWkepRP8webOEm7PY3tO3A
    5l6srijHRPoLSmxGY5FArJ2c2awnJCsgPtStr8dkjN6olMqnq160rnm+ZNLs/wWohlkdFW
    mrJbhM9oSnLqlBWWhZbS0ED8rVImG/6KL5Bwn6x1IPUk2BCulJuDBNYDE0LCJv+lELK2HG
    gSYA8TwBvRpPkKl3Lfcoe/UqIyi0vlhG+Qp3oQM1fm3M0SdiDN2I/6XT1xqA
X-ME-Proxy: <xmx:HtQEa0fGU3zG4sTYF78dJEgkWCua7uaWSiUNVj31uV1Mktt54UXHsA>
    <xmx:HtQEaxDIe165WKBNe9fmWhOOBcTpLwLJNFLn9dD-lKlGWVI7r_ACAg>
    <xmx:HtQEazxbWpFkpUnAu17Rk4vCIm6wYfvpPp-SGhbx3NL1DkDnxwGA8Q>
    <xmx:HtQEa5h4qD5SIBM9WW74oFCZYIWDL8r0V0VO4E4m8-QZR2xW_IYUdA>
    <xmx:HtQEazoT_vSN9FwVRDkPClTV2gv8OEGMcW_rICjkzMiSAhZcWTECSMnd>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Nov 2026 19:02:30 -0500 (EST)
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
Subject: [PATCH v18 4/8] accel/rocket: take the core clocks and resets from the devicetree
Date: Tue, 24 Nov 2026 13:01:39 +1300
Message-ID: <82329b6681958350294846c830598ebde29b874a.1795478392.git.gahing@gahingwoo.com>
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

The RK3576 NPU core has six clocks and one reset, the RK3588 core four
clocks and two resets. Take all clocks and resets the core node lists
instead of naming and counting them per SoC; the binding defines them
and dtbs_check enforces it. The driver only uses them all together.

On the RK3588 the resets are now deasserted in devicetree order, srst_a
then srst_h; before it was the reverse.

Suggested-by: Daniel Drake <ddrake@baylibre.com>
Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 drivers/accel/rocket/rocket_core.c | 25 ++++++++++---------------
 drivers/accel/rocket/rocket_core.h | 13 +++----------
 drivers/accel/rocket/rocket_drv.c  |  4 ++--
 3 files changed, 15 insertions(+), 27 deletions(-)

diff --git a/drivers/accel/rocket/rocket_core.c b/drivers/accel/rocket/rocket_core.c
index c1458423cb69..4a7b1fcd7627 100644
--- a/drivers/accel/rocket/rocket_core.c
+++ b/drivers/accel/rocket/rocket_core.c
@@ -21,20 +21,15 @@ int rocket_core_init(struct rocket_core *core)
 	u32 version;
 	int err = 0;
 
-	core->resets[0].id = "srst_a";
-	core->resets[1].id = "srst_h";
-	err = devm_reset_control_bulk_get_exclusive(&pdev->dev, ARRAY_SIZE(core->resets),
-						    core->resets);
-	if (err)
-		return dev_err_probe(dev, err, "failed to get resets for core %d\n", core->index);
+	core->resets = devm_reset_control_array_get_exclusive(dev);
+	if (IS_ERR(core->resets))
+		return dev_err_probe(dev, PTR_ERR(core->resets),
+				     "failed to get resets for core %d\n", core->index);
 
-	core->clks[ROCKET_CLK_ACLK].id = "aclk";
-	core->clks[ROCKET_CLK_HCLK].id = "hclk";
-	core->clks[ROCKET_CLK_NPU].id = "npu";
-	core->clks[ROCKET_CLK_PCLK].id = "pclk";
-	err = devm_clk_bulk_get(dev, ARRAY_SIZE(core->clks), core->clks);
-	if (err)
-		return dev_err_probe(dev, err, "failed to get clocks for core %d\n", core->index);
+	core->num_clks = devm_clk_bulk_get_all(dev, &core->clks);
+	if (core->num_clks < 0)
+		return dev_err_probe(dev, core->num_clks,
+				     "failed to get clocks for core %d\n", core->index);
 
 	core->pc_iomem = devm_platform_ioremap_resource_byname(pdev, "pc");
 	if (IS_ERR(core->pc_iomem))
@@ -106,9 +101,9 @@ void rocket_core_fini(struct rocket_core *core)
 
 void rocket_core_reset(struct rocket_core *core)
 {
-	reset_control_bulk_assert(ARRAY_SIZE(core->resets), core->resets);
+	reset_control_assert(core->resets);
 
 	udelay(10);
 
-	reset_control_bulk_deassert(ARRAY_SIZE(core->resets), core->resets);
+	reset_control_deassert(core->resets);
 }
diff --git a/drivers/accel/rocket/rocket_core.h b/drivers/accel/rocket/rocket_core.h
index 0b7e82ae7ef2..c25a33427b16 100644
--- a/drivers/accel/rocket/rocket_core.h
+++ b/drivers/accel/rocket/rocket_core.h
@@ -27,14 +27,6 @@
 #define rocket_core_writel(core, reg, value) \
 	writel(value, (core)->core_iomem + (REG_CORE_##reg) - REG_CORE_S_STATUS)
 
-enum rocket_clk {
-	ROCKET_CLK_ACLK,
-	ROCKET_CLK_HCLK,
-	ROCKET_CLK_NPU,
-	ROCKET_CLK_PCLK,
-	ROCKET_CLK_MAX,
-};
-
 struct rocket_core {
 	struct device *dev;
 	struct rocket_device *rdev;
@@ -48,8 +40,9 @@ struct rocket_core {
 	void __iomem *pc_iomem;
 	void __iomem *cna_iomem;
 	void __iomem *core_iomem;
-	struct clk_bulk_data clks[ROCKET_CLK_MAX];
-	struct reset_control_bulk_data resets[2];
+	struct clk_bulk_data *clks;
+	int num_clks;
+	struct reset_control *resets;
 
 	struct iommu_group *iommu_group;
 
diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/rocket_drv.c
index e62a20edeca7..b72f4fbd8e29 100644
--- a/drivers/accel/rocket/rocket_drv.c
+++ b/drivers/accel/rocket/rocket_drv.c
@@ -269,7 +269,7 @@ static int rocket_device_runtime_resume(struct device *dev)
 	if (core < 0)
 		return -ENODEV;
 
-	err = clk_bulk_prepare_enable(ARRAY_SIZE(rdev->cores[core].clks), rdev->cores[core].clks);
+	err = clk_bulk_prepare_enable(rdev->cores[core].num_clks, rdev->cores[core].clks);
 	if (err) {
 		dev_err(dev, "failed to enable (%d) clocks for core %d\n", err, core);
 		return err;
@@ -289,7 +289,7 @@ static int rocket_device_runtime_suspend(struct device *dev)
 	if (!rocket_job_is_idle(&rdev->cores[core]))
 		return -EBUSY;
 
-	clk_bulk_disable_unprepare(ARRAY_SIZE(rdev->cores[core].clks), rdev->cores[core].clks);
+	clk_bulk_disable_unprepare(rdev->cores[core].num_clks, rdev->cores[core].clks);
 
 	return 0;
 }
-- 
2.43.0

