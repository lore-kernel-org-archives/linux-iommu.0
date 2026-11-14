Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794625597;
	b=QY5yARWcgoblfP6uakJuyhpJYdhVsCQid/ZN7WREZDBiy0iMoB/x3Ybc5/52d3p53Mni
	 3IPEgMIjtEcTQOFO4jLoh/bDIQhS9QP/v0yXEk6iUsTFt4+bKIiYWO1AMU8beZovSGrSj
	 bY7pEMesidNIoWTtbpDa4gC8FRZ39QU6+lA0HMnv6jw0RcazhGLzxMLv11LhcGmTlC7bp
	 fhrvfFtoZiiwaPURwMMPM5VgutbxIm2T7Cs/h8q7Z7GlADBujMllyEv31f6y46N28IR3a
	 FJbUwqbK5ndvHuydz4zCP2dRJ+83WcCHR4EXCmSEtOeu4Cnb4++CHKjmp03dFXBNq8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794625597;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=+LBt2CZx+pYCe+VktFRZGdw09u24nWiEXEs5S39YV9s=;
	b=jN2lqHJi3aMyfqOtsRJ80wc21QNn7fEvAObYpGIregPvnN5t1FimL094WxfZJ8Weg88c
	 DOBxmiOWLI0T7DC6USgxwKsL4WIgu3Ujkc6fX5Uvhq/vsYfI2y5X8VL/JdaZapEReMfZd
	 tFHc77CcB9Fj/3vwqxDS1VpfBM0hsH28hClAxA8N77fYuMhu4wHbmB/ZNbIBU85oRKiui
	 C9Q7D3gmQB3FNy3pzqaip+yL8z0cFjmilRGal26VHYCUExLviHCDuga89rfuaroRuoEr9
	 ucMSE8lD0ioW6mvCmVnZQw6lUvyuqCDU4zzT2hTtf2Cw3dPogwnFb0bFS+BNqf/s1HA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gahingwoo.com;
	spf=pass smtp.mailfrom=gahingwoo.com;
	dkim=pass header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=MpFmoVkf;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=GSo5tdob;
	arc=none smtp.remote-ip=103.168.172.139
Received: from flow-a4-smtp.messagingengine.com (flow-a4-smtp.messagingengine.com [103.168.172.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103DB606A89C
	for <iommu@lists.linux.dev>; Sat, 14 Nov 2026 03:06:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 103DB606A89C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=MpFmoVkf;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=GSo5tdob
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id 6937F1381A48
	for <iommu@lists.linux.dev>; Fri, 13 Nov 2026 22:06:36 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 13 Nov 2026 22:06:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1794625596; x=
	1794632796; bh=+LBt2CZx+pYCe+VktFRZGdw09u24nWiEXEs5S39YV9s=; b=M
	pFmoVkfQu1JGVJTCNhtQqMEwr2liWyEIZoHL5yvbYPPxZwP/v1UovQu/4YzjOb6A
	+qGTcdvwLoaBGX6TY8c3q+4GDjjMLb+ORp2e6N7GFueze+e+w1LEZIb9W4MaqBdZ
	tluvPe9HwMTUClSp8L39OJrkuxSkjVlIuX5ArszZsk7Bgap3o/nb/dFQ30WOCPBy
	2lCyIoU/o9f9KHlaiySJAvIOLlNzr88MHA5QFoyuTSUq4wXYkaoPsjPluC272Mdm
	Ns8GvucNtSYonZuHwGSkOuSY4IpPueF1/k0y96ZCiQR+bWziBsLhkA8UL2b2AwGc
	tI5CjhGktRh0wjCljZ9KQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794625596; x=1794632796; bh=+
	LBt2CZx+pYCe+VktFRZGdw09u24nWiEXEs5S39YV9s=; b=GSo5tdobvfAhOysz3
	4BF6b3zPdMu2r+/9DDrnpE5gePb3kcW3EjLbCs/37NWtWcgPJLlW8wdxPUfYMDsN
	ieu5MBjXH2jJSo2KaqazrBrGvS5Pe/PrUVkmR1JrsFew3I/HSdXhz3VpCiKF2T2a
	FpVWlP6H1liNGXzld/4QG8nLVt4qrrLv2XZwuyYMcHWmI5ft/DiZZ/3JCgZCRI6Q
	Tpt1NseJHQzvUuOGc6iX/9fPnkDerV+9LkHGb/BKN89p4xr7bkjcssGmdDPNsEUr
	/vRyvbjd1d1hYvA6p5sNACFwl2OptJ/QYDniimqqqrS2RBFlyz9t5otFrCtT2PRi
	BWtAA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=gahingwoo.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794625596; d=gahingwoo.com;
	mf=PGdhaGluZ0BnYWhpbmd3b28uY29tPg==;
	rt=PGlvbW11QGxpc3RzLmxpbnV4LmRldj4=;
	s=fm1:rsa-sha256:T/yCSGhFOld9JsqEe2AQFwjtw1w63aCwuV5fKBUMr2iS5KP
	4EW4w8XBc+VEZU23nJZp7NLYlVJaKEME5ZmHncNmovD9N8J8shNQMewDiplWY2tM
	tiGUdCRVqkv9H1ISbFS9rT+J30Mt0RIuvi3ZVdvu1D5NWANMp51iwRXCp7H9baA7
	GLgyi1RZPt+W4f8NTkz1SAiJrR254qX5Ly2Y7kKjrUotqJ6rvHOn6k6R/35qrVX9
	JDcIKCSbWh3Q9RF/yuTgtaXujiek+4mXa9HA7moY6sFZaCvjGpM8xdgJGNE8KHe0
	R1BlSiOopOQO+8P9oao0t6BiM830uHKgjIb6UKw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:XafIFsESyWSCFJ4JxBXyNSLDfMk/cjGExV12Dd3+tVI=:WrX3o+lDD5jTdTR26wtfTgnBfNa8ezWBEE2dZFQ4KSc=;
X-ME-Sender: <xms:PND3amh794LD56q87f8rG2juyPzV7O55k23-4C6KRn3BOzvA7-01Ew>
    <xme:PND3ajd8rvObjVO4nu0WaRfgKSGOd3SBEZXXQneH0K4jnzjijFNe0ARcEgVvoHGR4
    uvMR85eRIqnvf5LFPO2EEqaA_KyDDhQlxjzmaY5B2cYcKAEkY-ltb4u>
X-ME-Received: <xmr:PND3alWYdsRB9ef9UYEv99V3MhUx7UqiCh_ZdL-gd8hpiJHeJ0mylOlHCSDnziYt3ilgzbkm>
X-ME-Proxy-Cause: dmFkZTENh3Cq6bNtRDDqH//naJpK03OGhXB8Cp3eHHX2EpHYf2oBjZ1/43ruyqVDLzR5bI
    q7gV+k53czH7SJj0JMNaMvWBGkaUqaereb01ifHpul1q14DobEKJC2mDvQQE3HzqoOU9gl
    QO0UnCSJOnNpWmY1qWdj/IivEZ+5eJmA8XcRYmqsfPBSZaKqk9zCnQvCGUQuYFJdsYZGP5
    L8zECb373LU+oefpY9jKwOjkFDiU4CWxV3iExHL3zPnpeZwM1wkFJxhm/yJk+2AJ3ju4OO
    RXCknd9xSS299sQU1FiikwzYfEAyF9m0XTBIDoIn2qfRRJDU3uzKkImCFIAQPMS5Q++USP
    923CS5Nb9d9bOFy7Yh3e2DfgrlFTDA+YgZzQFEB14VPk/BfY8zaBCcNePtMsiEsymKDO6c
    W0e6TVNKDzEaqoJ2VAR5RTbrla43R+hyFAL6n9OzOnl/EmCym3tRL9zMVuSbjH+6tCN1ts
    TI9CqErl0Ry8Fkw7U5Prk50r/bH+K5gnse8OO4GGwSatLH16xsvIeclqhA1fHdF+gkT5d5
    PHPEoo529Jt5Rh512efJf7mKQoZlqE1RI9YX0hHLyamkSzDNJ1qGX/f6cwG7VwiWdwcW9X
    8szlPKTYYzpRTRFBfqDls7NX+WJEuVFmwIZsWbwOBibH7dta4PP4F+9NBUrA
X-ME-Proxy: <xmx:PND3alxWDBWWs41Vz3896FLBlfwKaT-ErVWM1MbDMRpNjfhst--mnw>
    <xmx:PND3akDSisRf8kmAG5ziw2CjLA4HYHxJPtkR7eVdFeyfTXS7iTP0YQ>
    <xmx:PND3aj78gBFNfd9oR32HUjCa44iNz1Yy_rySCcy1lyuvWSJ0tzNwew>
    <xmx:PND3ajkPlXi8PZYSg5gSett_1A6PoHDHFEznZnj_FRG0nrxTGzWRUA>
    <xmx:PND3arl3EN4pbEk5SAYd06DE_sYd_ei2A4Vi_zJmZb2QuP6Pyqod2zZ_>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Nov 2026 22:06:27 -0500 (EST)
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
Subject: [PATCH v17 05/12] accel/rocket: factor the completion tail out of the IRQ handler
Date: Sat, 14 Nov 2026 16:05:22 +1300
Message-ID: <d3edc2ee1e2f6e431f3a22fad4466a1a59e053b6.1794615323.git.gahing@gahingwoo.com>
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

Move the part of the IRQ handler that starts the next task or finishes
the current job into rocket_job_next_locked(). This makes the code easier
to follow and does not change behaviour.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
Reviewed-by: Igor Paunovic <royalnet026@gmail.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/accel/rocket/rocket_job.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index 41c723238b2b..68df1596014e 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -367,6 +367,24 @@ static struct dma_fence *rocket_job_run(struct drm_sched_job *sched_job)
 	return ERR_PTR(ret);
 }
 
+static void rocket_job_next_locked(struct rocket_core *core)
+{
+	lockdep_assert_held(&core->job_lock);
+
+	if (!core->in_flight_job)
+		return;
+
+	if (core->in_flight_job->next_task_idx < core->in_flight_job->task_count) {
+		rocket_job_hw_submit(core, core->in_flight_job);
+		return;
+	}
+
+	iommu_detach_group(NULL, iommu_group_get(core->dev));
+	dma_fence_signal(core->in_flight_job->done_fence);
+	pm_runtime_put_autosuspend(core->dev);
+	core->in_flight_job = NULL;
+}
+
 static void rocket_job_handle_irq(struct rocket_core *core)
 {
 	pm_runtime_mark_last_busy(core->dev);
@@ -380,17 +398,7 @@ static void rocket_job_handle_irq(struct rocket_core *core)
 		rocket_pc_writel(core, OPERATION_ENABLE, 0x0);
 		rocket_pc_writel(core, INTERRUPT_CLEAR, 0x1ffff);
 
-		if (core->in_flight_job) {
-			if (core->in_flight_job->next_task_idx < core->in_flight_job->task_count) {
-				rocket_job_hw_submit(core, core->in_flight_job);
-				return;
-			}
-
-			iommu_detach_group(NULL, iommu_group_get(core->dev));
-			dma_fence_signal(core->in_flight_job->done_fence);
-			pm_runtime_put_autosuspend(core->dev);
-			core->in_flight_job = NULL;
-		}
+		rocket_job_next_locked(core);
 	}
 }
 
-- 
2.43.0

