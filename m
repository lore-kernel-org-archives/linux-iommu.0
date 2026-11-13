Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794588036;
	b=QytNYx7Rcu2JH8E3K6u/gZp0q+GF3+urzTXoDIPWCq9F9dukRoYIgOu8kQxM/eLh3TSD
	 wXfRocEEjV+m28G7AdcfaTqtdmzRlWnC/ZPXDdv5TOOKx5OB/gXe3YUmrvxVi8Ch95IFA
	 78RdoErORdVxmnqL7862jzauzj3yP34BsA+37zKOV0bnfuJ9pwpbySYS/bHofJky4GrGY
	 37fCR0mDI6RSbLcgUmTdLkDNiV4Vm6EresdtyAMvsj8uuJ3s1DvEipE5o7Ossz1iOinbd
	 CQv4sAli7M7XxCpWdQZceoP0QUcSv6gbnIdgda2VrgVyTd15Vi6A1CSitIRqW+gBjLw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794588036;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=DxUKnJSoxh5R0Lqzvv32zTimhe+hLNG3ZBbQWBwfczg=;
	b=P2mIH5soM+BJuj8JGY/jKghqDNfS0DJ9nr3Jd6uwrBaXO+8ItD54J4opoMFtbcKKREAx
	 JYOd+U5nryQd/4wvCXIKDPaKdEkE/JPzA0oIjJ8kmLFW+t8zqRPo27sZpR9v4Fx0uIpyP
	 XoRAMu5IFp8SbE237wfnm3GVffJrG9cybB6BaKiI5AQY1uJoUEwnIBFfUDywr2viH8xXe
	 O2rHUuDGkO6MHbo55exC9m+YnapibG0Q8Dp+rsN84P0LA0aLfh5liQTE9ulLRUdC8CBQA
	 SsiAJCg2kqv06LaM245zIXkIzXJqs3AVDQ4HBWc9B6tf4/REQgyF5dAivr4Ncb+t+fw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RIjsIC+X;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EECE606E230;
	Fri, 13 Nov 2026 16:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RIjsIC+X
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794588036;
	b=ej0bCZZMx3s/eMYrZoC6WZAsB0HI3mHxiGSUXjPaJ9qHk20EEYKVv21YzdS3MdX5kdG+
	 AcrtucW5u8uVWmrNXLyrXNHl19Rplr55m3uJv0Mb6wdGr/becxAmgYRFEQvzN8pM2EvRh
	 u8lAbhpv1rg6m56hn0h2PQ3XPK/NHcduqJ8WNeRfBpiCr45MdQtYjYgyvrmdSZI813oqM
	 1BaxMpSkSCxQ0WBkDsbH+u0ZwbjCRkPTfW5t/uWib/D2fjOTVyE/uOhkNgI0sR9yeftLM
	 iO4iIOHAVoNu0PclaYm8RsbUTu6FSnvWwF6JD0b+GjF2qJjIQsSH85ZK1VjTH4hr3Cg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794588036;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=DxUKnJSoxh5R0Lqzvv32zTimhe+hLNG3ZBbQWBwfczg=;
	b=gnWHT76Hgk6oYb62v/M7DR5gpkpHyUX0C+8ccvxtqKi1dogrhcndZ2QWoGib+fMOxUf4
	 jE0uZ+Zqp/G3MsGjzfd2DQPrrkUqs6X5X0otYCVoLHCB6b7HOIFA2PqYdB10D22sCuLwM
	 xN866L2GgEvyvLja5H4PrzmGPTUJU2vfgjy8upCQKu4rTIoqJYMyTjcTDLBCLLf3g0+nK
	 nugiWGR1W8pbGRRKOzDZKO/abqo5nlMQZO5HdXgGZTx0rnnirrdrJqPe5ZkhFFt4MQPhN
	 9lUN/2R7N/tOIZxuayQmJDPRMA7nFWIS17Cykm2IIr7FuJGipcK96vL9ePCSFCeXU2A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 5E73D1F000C8;
	Fri, 13 Nov 2026 16:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794588036;
	bh=DxUKnJSoxh5R0Lqzvv32zTimhe+hLNG3ZBbQWBwfczg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=RIjsIC+XXwPwlP6sgBYp7s2rBD4I2LpgvZ7dzXI08xo/X5RsdFFOxeHkYVSVVJmSU
	 SJ9SrdnKP2N7LXuHmGCpvX5xgvHSijbFRwjPtKRzzSpKDz6wv6+BkGNAvbz/4CQ35X
	 Rk9JP0J/k7MX2K2x8POQzF/IedLy0nf+mPivdTwyN2HsenmBe+2/L9uvk8FV48pxCn
	 zdQQDkL9GR4YPUmbIP6+tsf5x8FsZnH9C8n42aORoCdnz7t6PsTSkPVjXbez7ncuXq
	 G5wBPm9Mn87HsYf/YHxPNq9buLoHKVW8K26PKsmCnEHojspUEqeccQGaHaJuSvjk78
	 LROtvxFmcpDjA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E44FD499DF;
	Fri, 13 Nov 2026 16:40:32 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 16:40:34 +0000
Subject: [PATCH v3 03/12] media: verisilicon: Complete the request when the
 VPU can't resume
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261113-hantro-robust-v3-3-82383c722ad2@gmail.com>
References: <20261113-hantro-robust-v3-0-82383c722ad2@gmail.com>
In-Reply-To: <20261113-hantro-robust-v3-0-82383c722ad2@gmail.com>
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, 
 Andrzej Pietrasiewicz <andrzej.p@collabora.com>, 
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, 
 Hans Verkuil <hverkuil@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>
Cc: linux-media@vger.kernel.org, iommu@lists.linux.dev, 
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Sergei Khomenkov <shomenkow@gmail.com>, 
 Tharit Tangkijwanichakul <tharitt97@gmail.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794588032; l=1356;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=dcuFbBUH76d1uZ1BUVv0QU7AVt7L3akWWbZ+Mrdvg+I=;
 b=YS62kIkVRY6LHDmN/vH4lFvz33jKVGNFKm/SlC2vyNIpKbNOEVMlQ4zjchnMUSOlOD9PgdR/D
 nojFp3hpkZwCWE0o5NH26npE1Kg342s81Ds9ADxyFjTFwHYy7gEZsbN
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

If pm_runtime_resume_and_get() fails, device_run() returns the buffers
without completing the controls of the request, and the request stays
queued forever. Complete them on that path.

Fixes: 7d47b45dc590 ("media: rockchip/vpu: Support the Request API")
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/media/platform/verisilicon/hantro_drv.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
index e86eb943d16a..42822b2b376c 100644
--- a/drivers/media/platform/verisilicon/hantro_drv.c
+++ b/drivers/media/platform/verisilicon/hantro_drv.c
@@ -176,16 +176,20 @@ static void device_run(void *priv)
 	dst = hantro_get_dst_buf(ctx);
 
 	ret = pm_runtime_resume_and_get(vpu->dev);
-	if (ret < 0) {
-		hantro_job_finish_no_pm(ctx, VB2_BUF_STATE_ERROR);
-		return;
-	}
+	if (ret < 0)
+		goto err_cancel_job;
 
 	v4l2_m2m_buf_copy_metadata(src, dst);
 
 	ret = ctx->codec_ops->run(ctx);
 	if (ret)
 		hantro_job_finish(ctx, VB2_BUF_STATE_ERROR);
+
+	return;
+
+err_cancel_job:
+	v4l2_ctrl_request_complete(src->vb2_buf.req_obj.req, &ctx->ctrl_handler);
+	hantro_job_finish_no_pm(ctx, VB2_BUF_STATE_ERROR);
 }
 
 static const struct v4l2_m2m_ops vpu_m2m_ops = {

-- 
2.55.0


