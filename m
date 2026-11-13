Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794588036;
	b=RESgciV8jGjDSpTm7USzxkZIeAyMKm+AkSynaxFholVPy0gTmIXTEJgLm+qF+DqPxHXH
	 Jpv8dj+pPjrBbvWDZe552FI5e0QqDE3FEXFz3VqFIlcUQS52Yp1NBh7xwgiHSuYg3PEJi
	 freR4volJ7kNI5QMv17zSEFiMgt7+vwYBLdh34Ov0rBoj5Zs5XfQIC7EzW3cOX61baDGW
	 agrMtGNoTYNnB3x+ZsrDnaL76PZVI8Rw6eF0nVt3+o4Nw2TJAtNopK3PKMUFZX7ZGAJ9F
	 o2/rg4fahiUlurOrOul3xywHXUosLxPhYu1eaHfuHL4l9i+NbDMlKCIohXWY1hdMyjA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794588036;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=duaSgK5diYqNhsVVmsc0RbAG9oAaNnkgjzWifl8mDlg=;
	b=hJRfeStYpYrlL8cyyZQnUG4qSrlLC21Qu8qRFypmfkwZ/QwXlhWeKf28UeKNjc2VvK/o
	 vNRT7GwKZMakOA8y7jdzoa16+zupcZjPb9oXLOboAJcEennWmSw3BzXDm4o2PDUC9vwDR
	 Gt1XO2F7AQRSZ/EyFqSsV8RV5vp3ZhalEc0aP9USe6N+YwqW71WzCCCbxxEBQAV3KrmgO
	 9JlIFe6r3rQ7HGv9Pr6QDY+uKEe52gbn50LgXfeFy+IBYYytuSpPcYd+yhq1zhkq0w7C1
	 IDlwfGt5x7whOXZAkFkco/TUyJcqVnlxwdI9GVD7W7oR+0g+8xS2lCFnAagdH+fEvCQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aOpfZLNA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E824D606E21E;
	Fri, 13 Nov 2026 16:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aOpfZLNA
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794588035;
	b=qrAU3FLkhEyPBnaNKdTSnecs8bkj4iMGBqXvLxNN+MDkMhnUd238VkzzIpszASOmrLIb
	 UEmQliIyqNXJjUiTbprSOQxRTnZ9biad/prvE01tHUkCZNCyU0fMsHQH3VIz0evSCEP1w
	 lp5Ea0cE/vpoa0Xe6HiGAKAhmpiOD1fDCJx+TSxDu8XikeFOcwLsXQW7ZIT21X77wzpOf
	 roARRTs8JqNUhEGjm/Rn2U07JPgyyQFL2xbL5RO+BR2Xihr3CkXj5tLM9QupkdupemkHa
	 uvw8AdJZPc6I/TSVz1/1u7Yd6N1/EU37ROv48cHCteUucKMHUegQ3JpZ2JsB9v+5bCg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794588035;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=duaSgK5diYqNhsVVmsc0RbAG9oAaNnkgjzWifl8mDlg=;
	b=16xPJOTpoONspMCw7SLyChltXW7T+iCNY9TpGVHGv7bfsqdAQ5ka9GCa5unDxX4kRn7n
	 P16U1Rp3sa+Z/bf6rXIcmr8Sfu28tsIPyK1CoCE56k+CIkll+Me8ZUKmpo+68HeI4eR1j
	 kp5QnGTT0+/QyUcl+7H/c1JNQoSmyvWld51Uql1H7YqPPnbTSdqUBQhIGoSNzqQSSg741
	 MzDA8BdFZxbWsS1VGTY3jvaUHylGoz6/Iw287eToL93HzpzYVQm8pRntdPi0IJknN1pHL
	 3m0pwBd07nC3ALVb+xalcXPwJdJ2z8INeA1tmqsvc98E6ZrF14XYf06bcyA/hAPZofA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 44BDC1F000C6;
	Fri, 13 Nov 2026 16:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794588035;
	bh=duaSgK5diYqNhsVVmsc0RbAG9oAaNnkgjzWifl8mDlg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=aOpfZLNAqPDgdsVQLWfibmOde6PcXaMcHCp8aPXc4VDsLgYbyCTM4OXgvSTUgdbtH
	 UFXwokyuCOlH6zdeH6Cq7dYy90anJAx9Dg+c8usbwiPUcGxC0wDFZ4vuNCsuXTo5Y9
	 Dqiwy9kMJ3jUs348qa1Dch/9A6FKN4djpYOB4JqjIFaOYXog2do7XN/WUegkplO9Tu
	 tQ3s1g2INnMyHF5MIYMTW9Ag6+HRYwbm9z3jQoKvNAJrPJ8GT3Z7lQk/8plmod81ie
	 DvgV6hKcA4v/zKOlLvVI5qxN2BfjdXFBhoyWJLGa/3kFZGuujOGg6KyXpT4QdFsKhF
	 eOcJMzBXrWZQg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C9760499DB;
	Fri, 13 Nov 2026 16:40:32 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 16:40:33 +0000
Subject: [PATCH v3 02/12] media: verisilicon: Check the match data in
 hantro_probe()
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
Message-Id: <20261113-hantro-robust-v3-2-82383c722ad2@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794588032; l=2017;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=USarBI/8QLSUU7n4QQXOd3oICBoakGw0nlmY2gPzpAo=;
 b=VHn9biPtTSPgjKSK+LlZtbRsJG7aomHpah4FtXX6wvlrtziNtNDasva9saf6Y9Yd21xb7URUY
 Kjqx/X9W7idCWs6uQxrP6bjU0Ed9vIN+cDEtGVVGMiPaQ5Mq44mzyFX
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

A device bound through driver_override may have no OF match, and
hantro_probe() then dereferences a NULL match. Use
device_get_match_data() and fail with -ENODEV without match data.

Fixes: 775fec69008d ("media: add Rockchip VPU JPEG encoder driver")
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/media/platform/verisilicon/hantro_drv.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
index 26e5d5547466..e86eb943d16a 100644
--- a/drivers/media/platform/verisilicon/hantro_drv.c
+++ b/drivers/media/platform/verisilicon/hantro_drv.c
@@ -17,6 +17,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/videodev2.h>
 #include <linux/workqueue.h>
@@ -1071,7 +1072,6 @@ static struct v4l2_m2m_dev *hantro_get_v4l2_m2m_dev(struct hantro_dev *vpu)
 
 static int hantro_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *match;
 	struct hantro_dev *vpu;
 	int num_bases;
 	int i, ret;
@@ -1085,8 +1085,9 @@ static int hantro_probe(struct platform_device *pdev)
 	mutex_init(&vpu->vpu_mutex);
 	spin_lock_init(&vpu->irqlock);
 
-	match = of_match_node(of_hantro_match, pdev->dev.of_node);
-	vpu->variant = match->data;
+	vpu->variant = device_get_match_data(&pdev->dev);
+	if (!vpu->variant)
+		return -ENODEV;
 
 	ret = hantro_disable_multicore(vpu);
 	if (ret)
@@ -1098,8 +1099,7 @@ static int hantro_probe(struct platform_device *pdev)
 	 * nxp,imx8mq-vpu-g1 or nxp,imx8mq-vpu-g2 instead.
 	 */
 	if (of_device_is_compatible(pdev->dev.of_node, "nxp,imx8mq-vpu"))
-		dev_warn(&pdev->dev, "%s compatible is deprecated\n",
-			 match->compatible);
+		dev_warn(&pdev->dev, "nxp,imx8mq-vpu compatible is deprecated\n");
 
 	INIT_DELAYED_WORK(&vpu->watchdog_work, hantro_watchdog);
 

-- 
2.55.0


