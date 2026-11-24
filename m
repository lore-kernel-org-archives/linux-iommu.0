Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795478526;
	b=Waqy8AB28MapZty+OW3yFU0xAococ7c6nes5t33n83p95Pjf2FQN90dOASJiyDvDFdEl
	 iKHg8tzkn8/XcdVQKhLqtI51pqDpoD9A6DaSqJIkRpBF/3EwWhNACuywJSUjk73N8YTSF
	 zFqfYfWEKDm0NUGgdUheNCGmZ9CQPoJ0kdDlv3aA3FdYxJpNbC9DlNVQqiAPqInv+6hkJ
	 9c4B00V+mX3ZWxqyK1xvrYAdlNu+Rg4BMiCobghZGOQNSBmJ4pfVeLCHv3U3AJebxhi9F
	 Gl8/IWSn8OPTbmQbKlFVcik/mA+GlDaTv2IA+KBfkG9PLmnbEVRUchRcNGHw1GFcW9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795478526;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=QNe/5SDa8yukG2m6jZYddNqm/vu0rbFqMlldL9831AM=;
	b=5DmXSsy/dk3/I6G/F09O15UV88cVYlAVI3KNrLnpaudHG8nvdU61GYIinQZb0XbmV870
	 NDgyglUayud+btxZc1bhJjtShzj25NiEx656T5h4biOBicNNSmANqLHpj9m/EghOomryz
	 iTMwkz3Vuz6Pkix87cTcT8k4+piaIoGLOuljEsQ/nKmuRqN/zIb+5GBSkrfTmQQycscTu
	 9rAA7IILRHKWD2eXawwreFBiqePwA5mjJeeCupaGqh6h+aUX6Jag0LIWv4so0fB8jiOHM
	 Axu+oeUSB69yn3n5yNWPOlNLdLB4axW8PiXuyZqwJG9zE72dnEHKK4XFnLpHBLZgqsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gahingwoo.com;
	spf=pass smtp.mailfrom=gahingwoo.com;
	dkim=pass header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm2 header.b=m6djZdrT;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=It3p21u8;
	arc=none smtp.remote-ip=103.168.172.146
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A7D606A322
	for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 00:02:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01A7D606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm2 header.b=m6djZdrT;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=It3p21u8
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 53C0BEC0B27
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 19:02:05 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 23 Nov 2026 19:02:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1795478525; x=
	1795564925; bh=QNe/5SDa8yukG2m6jZYddNqm/vu0rbFqMlldL9831AM=; b=m
	6djZdrTepT9GJITQuRunCKIq5nNzaP4DOF6Zqra7HfCnqFoiZOc38jeg84cm9tVu
	XD9YdD3hTG0LFYUW2hTZyMfC2IIBhBZRe9i6NMtdjmvsgg/TUg1+FQySUKKVwSSi
	CL8+unGOQvKoQq9gvRgEIHiiIDKUNXxxRJf74MaaR2KORi/7x9cfQuY7nXXKvefJ
	796WPHZsgGORIfJKOR9Njnneikx/GtntD9XoGoC0NA9Cucv+wLeznoET6WggWWys
	LRJqyGzWUPIUvCt6JgHU7SLaTafCP7xagSyl2e2vX/kkLG6XtgiCERpWSKmPbXXT
	z8UaRfld+eClgUA7vbK7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1795478525; x=1795564925; bh=Q
	Ne/5SDa8yukG2m6jZYddNqm/vu0rbFqMlldL9831AM=; b=It3p21u8algGgLUSG
	/nhTh0Iz4xEDMQF5YsA94PJeRmEqvtdZ008ZFNW85PhfJgvp7mMYqqz/tdezu7S3
	0ExPcT33Fk9FTNTln+96sAFjSqiN31DT3VkoTpVQOJAU0+rzoUdpz7uIaOFnK5aA
	91KJH9Ev9pb/riPnugLqXwl0ZKDclOW879UUF+gXpk9qRk6s1+Wsy23zo0YFNXPh
	+2KNJ2fwA+xfuUrM3uEXB4RKDzQkE3BQNJnaap0nmhW+LumOP37j3+ALCIfIe5/+
	jURSgE7TE4CqLXf6MVg3tVAoEbhqt76bbR5rCDLy7JyfBEWlLP02TE1hf0WFlNPA
	XJMGQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=gahingwoo.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795478525; d=gahingwoo.com;
	mf=PGdhaGluZ0BnYWhpbmd3b28uY29tPg==;
	rt=PGlvbW11QGxpc3RzLmxpbnV4LmRldj4=;
	s=fm2:rsa-sha256:OGmJgFPShTPX+/rXQFzp4Llmxk/5wRXvuyKeoM8ORDWLfEd
	sescTAtwVpjSBwcF4hEdmLiuI6wJ2/U64ckYU/kYZWqNESJnO+uZT6alLjHg+Jqk
	7VeJeVIPJO5qc8jwxcbIp9Qa1vQc5cq+sjWrqikVrPfXRyQ7a+78AUtvp0PBLvL5
	BJzq7q6r3Rb9FbAcuvesp6SNAAWvpmFYCaHZ4IMxdg8gkIttncEA6XqSl02bXc9R
	sh0KRkbzKY27BYxfxhJwK/PLjZHRG5sTI2STHO3wG/xvHy6VkzoB82ndYOXfN7IR
	HRv5GHuLttjrfRV25aUEVB+FaiExdgdjAZzMBtA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:eczvzy2GepQsZLKGjcBsypigAvj0E71cSF2UCA4RS8E=:aDiDHKKMkKmBNpyHGPv1ZCxaCtw3j0M20aub5oUwSEc=;
X-ME-Sender: <xms:_NMEa2AK1A5xPt9Is4iA_aSAzKHNApTSAqNRXBydDsKuiyiB3WK5YA>
    <xme:_NMEaxws9D2C6fIbTbyT-5oiccgi9uNs2ThzvqTs-tGEJjJTM__61k35Y0KFNabZW
    GAnMD-bfZgYMuhmgQm-WXeuAjq3K7-_e8w7EoWskfeyZqnz72RWPvEO>
X-ME-Received: <xmr:_NMEa-6qBwDbmYSfxUDLr9ClyiE_ZJ2eEsIltWBA99iQh0548hNSs_jFLa8bKnVQ29s8yQdU>
X-ME-Proxy-Cause: dmFkZTGEhlIT9xPRA8308BbHtqEEwMB/QskSvZlBy2+jFJwvtvfCirBVTmQimOCxW6z0/I
    N3fQ54j2uzkfIPiLqru0ODAgPBYDp/gZpGlhkMMOs9hof9ZG9GEOWdivyiuw2bnIONku0f
    WjmY8ul15onHL4eXgbBkYGjVGEM6SHV1iLYZaKVJkdDH3DHIqCHks7YrVY+mw1lm/Lplg4
    vSpMyj3j9q6sOZaTJVZd7ureJCnCjHJkmaDoA65nKLS/dXaLRNB8dxmmJokxzDm7a1gLZe
    vv+kmS5leROp3LsXetZXye6uoB1rh5Trh3ziYwSHciSyu7VL/LnTqx4QcFZ369FhHiPhjH
    8y/UBjCWaBhTCB5liNdc+q9lXpVPa7W3Nw2UkAMPVFhX4oHM0WaT9jQJ8DPnH2AWTpYDuX
    UnddaUwh3waD/j+/3Xx+KaLDKZSGlcdCW+nByxEeuyTW85qBXS1LwAyfw/Kbocvv1kkEIm
    9x+yqUjwQbZ+xvOrLfhpwke55vn4RPe6ZkI89yKVGsPQsh13+lwAJ0rB5OPgsMwkWpwZ+A
    UoNQazl2Ko3PdLSPPSmsAp7xsYfz19bIggB3ci2Vi5eNhrDkIAccELjTw4MlxQXjuCYxAD
    C2x/QmcM1/eGObCJkKlA+OLipX6+ENAJr3JoX4gXEZsWbGm+nt1pjWvNU3zA
X-ME-Proxy: <xmx:_NMEaystdq32Zn1uykRNMllakxCBz6U8uJWGkoC7HF7e3JFnml7vXg>
    <xmx:_NMEa7upsccnwlgynJoXxRsUIRH7Yz7natU_MnfXD0kdYTR1xBW7gQ>
    <xmx:_NMEa6v-blEBvnXKvbuJhXJVPHp4Y583Xd3LCJxM2sZm5hiO_0BGqg>
    <xmx:_NMEa76RQ1jLFwv-Y9hxcY0m-qJO7BoBgeUxVStl_oi13Q_opNn4eQ>
    <xmx:_dMEaz-oNsUT9yld85TnJqvJBET-hdlph5Ijw2-R6dHJrezSVjQUavFC>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Nov 2026 19:01:56 -0500 (EST)
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
Subject: [PATCH v18 1/8] accel/rocket: factor the completion tail out of the IRQ handler
Date: Tue, 24 Nov 2026 13:01:36 +1300
Message-ID: <ae95aed747f543e38e49c3d07fd7fa50382ae803.1795478392.git.gahing@gahingwoo.com>
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

Move the part of the IRQ handler that starts the next task or finishes
the job into rocket_job_next_locked(). No functional change.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
Reviewed-by: Igor Paunovic <royalnet026@gmail.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Sidong Yang <sidong.yang@furiosa.ai> # RK3588, ROCK 5B+
---
 drivers/accel/rocket/rocket_job.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index 4a5c6a425254..eed443c8406d 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -371,6 +371,24 @@ static struct dma_fence *rocket_job_run(struct drm_sched_job *sched_job)
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
+	iommu_detach_group(NULL, core->iommu_group);
+	dma_fence_signal(core->in_flight_job->done_fence);
+	pm_runtime_put_autosuspend(core->dev);
+	core->in_flight_job = NULL;
+}
+
 static void rocket_job_handle_irq(struct rocket_core *core)
 {
 	pm_runtime_mark_last_busy(core->dev);
@@ -384,17 +402,7 @@ static void rocket_job_handle_irq(struct rocket_core *core)
 		rocket_pc_writel(core, OPERATION_ENABLE, 0x0);
 		rocket_pc_writel(core, INTERRUPT_CLEAR, 0x1ffff);
 
-		if (core->in_flight_job) {
-			if (core->in_flight_job->next_task_idx < core->in_flight_job->task_count) {
-				rocket_job_hw_submit(core, core->in_flight_job);
-				return;
-			}
-
-			iommu_detach_group(NULL, core->iommu_group);
-			dma_fence_signal(core->in_flight_job->done_fence);
-			pm_runtime_put_autosuspend(core->dev);
-			core->in_flight_job = NULL;
-		}
+		rocket_job_next_locked(core);
 	}
 }
 
-- 
2.43.0

