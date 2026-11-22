Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795342314;
	b=FcFeG8vn20GN70/KqG46Kdmt9oQA5qb/Z/43hGvaL6Covc1285F2Z01vpFGArwa9WLIY
	 hIA6BGHOihyuGPgtZWT31WY02HhT+2HyyeQsNKDnPh6b+pR63XYP6Hfhasx0yl92JtiRx
	 bxwT7kVMpWJCJayBbNyzU7UWhvRJPj55fu6i5kafKBX71VFx/d8PTf15ge5YlhTZTbapa
	 XoK4hXj03icg48Q1WmKVBdwQFcFJbJZqZoZ6Ny7HZNoiQXSgxT4iI5H721uSjnvjGH81O
	 eOk6VRztoci0Jh6DudMh+QIpUGcqHo5yxdfw190nXKX8A1ilfw1rx9AB3jBEAkuZ8CA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795342314;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=DUFGSuQcmGXTXP29qSBzVDw0B0OLNCLEBlu9W81RI20=;
	b=G6g2z8ycuT/XP+Pv2iKHHJsN8irLykGAOPM3WYWM2t3JRMWbssJAPJqm4WV5CMnNW+3D
	 2ztPgwSOVyTJjIeOiZjQ+Cfl6o3XW8UbfcjVp0oFMkdUCGdv+YgF+4Y2dbqshqBoSKlHa
	 7RjokSQwXwQ4B+uxTOsi7FMoKd2ZbaKtoZSsBnUDcKUAczSe6oen6Mi1uZz2HibZD0CzP
	 oXN+MoG9E1Uu8yBoCGVky+jn6QQMTJCZa3ilsSlDeLSTWtmxPxuH84qJdU246eW6B3ZJy
	 H7zEO4OLMU7fh84nX3NKTJpzdd7aa0d/B/KIIZAOk3EhQNFy5hKY320TaX7SPkYWe+A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k4neDRH1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821F0606A320;
	Sun, 22 Nov 2026 10:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k4neDRH1
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795342314;
	b=iBwskpfAiRJWSRoErak97eSGASWza6UsIf9wzI6eO0/HsrPMo/JORfSMfnFesroUiJua
	 oyex9OYTI7G5ROCqAc3kHm8T3Gwq0Z4bQAdAZQhuXGwvE2B5nKEm7ry+JKb/Dm6nZf7SG
	 74R4QjiOTARY3Vu7z8vd8n5G8CtEHOsv50Cy6ZlRDbb8YymAq0t4wf5/j/KqB90IbA1iH
	 XlOyIKK6PSoJdTalkjxeHOY9LGOFA0hzXpqcd96ISUfOOoWbsxhk+7WGMr1shMdN8LTHq
	 k1Ho/UlOU58cBvVUpUaBdoFsfpkn0Rl6z9wnEVHe5Xn8TIrqtxW9wsZKtVYRbbD8uKg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795342314;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=DUFGSuQcmGXTXP29qSBzVDw0B0OLNCLEBlu9W81RI20=;
	b=g4s2CoYZ0HCVSS8S1l6KG0sJvk4Bn3ZeKJBXpqt5iaClPYBmzRCnHD/QCZ/wQyN9+nks
	 VyaIElOvzSgl3DStLEQNMR94/iZLcooISC0dcz50YrCfxCqdD7BF2unhH4kWwrj7xpI6u
	 CbYw1oY3YxtX/UtuBzD89QwkNLYlxWs+LoX8uAzuorK+iL5HUIk3tkkqObBdV0jJmDvXt
	 j+CJzSvjdk25Ia+VL30mIgdccz1gFqBQmpWTLWYkgu+w6xZzybobzvC2KfQbn5zBpubj5
	 REgdtoBVdxp4eZIpt3l4uz48Q+2YXMa3urvXvwbrP/OxC32eKoob7VN8uyl0mXrctdQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id AA41A1F000C0;
	Sun, 22 Nov 2026 10:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795342314;
	bh=DUFGSuQcmGXTXP29qSBzVDw0B0OLNCLEBlu9W81RI20=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=k4neDRH1RSfUCf70KfROzFinXSzg+oPHczgZBJEwAYkQi2wI5XYuCvHbt1HLqRA43
	 R9t/SmrzrIg1dXSkjxx8G3ATn2CzK3V7mNrvLFInCMUrUSxQSELme7AbkXjvtO5OEJ
	 EDPm7nGZU2bowrNBVwlvEgR4b/h0tHw6mZIR8j0BR6K55ahmizit9F3BWnpHskJ1Mh
	 V/ZDE+Y2Kh+mBemwRUmyIglhcWleGSPYGSyYn0QWAvd0uAXjnDkHS+tQj7BthovU0r
	 G1mgM357UFLMrR7QVLe3ZQ2SLZNiVLydwT3doz2iZjzKVZzo2xF1G/ORKlsjCuzpjW
	 BEPDmyvdilO0w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 0B7EA4BFE9;
	Sun, 22 Nov 2026 10:11:53 +0000 (UTC)
From: Suyuan Wang via B4 Relay <devnull+shyckless.gmail.com@kernel.org>
Date: Sun, 22 Nov 2026 10:11:52 +0000
Subject: [PATCH] iommu/qcom: Disable clocks if restoring the secure config
 fails
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261122-qcom-iommu-v1-1-ecb20a28871f@gmail.com>
X-B4-Tracking: v=1; b=H4sIAOe/AmsC/yXMTQ5AMBBA4avIrDXR8RtXEQtqMJIqLSIRd1csv
 8V7FziyTA7K4AJLBzs2s4cMA1BjMw8kuPMGjDCTElGsymjBRutdYJLHqsAO0xTBB4ulns9vVtW
 /3d5OpLb3APf9AM6McwVuAAAA
X-Change-ID: 20261122-qcom-iommu-2473c82d2552
To: joro@8bytes.org, will@kernel.org, robin.clark@oss.qualcomm.com
Cc: iommu@lists.linux.dev, robin.murphy@arm.com, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795342312; l=1475;
 i=shyckless@gmail.com; s=default; h=from:subject:message-id;
 bh=1Eskb3u6fGizPUm16aNFvrkib/eJ2zFG+/IzmSV4X/Y=;
 b=ZOGKdTHhmGOSbeG4MiNOD9O4UG/bQnmgXpNcWMIuhzXL6CbNW60fDSSxuqAPYbf+CxdaRHuqT
 bUCoNBgV+eAA5fWSVT4jLwsfiqxAeW3ig/BT3bfrHFybV/AwxRrQ6hQ
X-Developer-Key: i=shyckless@gmail.com; a=ed25519;
 pk=pMtccVGiWES3bV+7YBFuBclkvq2n2HBHQ5azaBrK2lY=
X-Endpoint-Received: by B4 Relay for shyckless@gmail.com/default with
 auth_id=1498
X-Original-From: Suyuan Wang <shyckless@gmail.com>
Reply-To: shyckless@gmail.com

From: Suyuan Wang <stevewong@hust.edu.cn>

qcom_iommu_resume() enables the clocks and then, for an IOMMU with a
power domain, calls qcom_scm_restore_sec_cfg(). If that call fails, the
error is returned but the clocks stay enabled. The PM core then treats
the device as still suspended, so qcom_iommu_suspend() will not run to
turn them off.

Disable the clocks again when qcom_scm_restore_sec_cfg() fails.

Found with a static analysis tool and checked by hand.

Fixes: 268dd4edb748 ("iommu/qcom: restore IOMMU state if needed")
Cc: stable@vger.kernel.org
Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Suyuan Wang <stevewong@hust.edu.cn>
---
Compile tested on arm64 (W=1). I don't have the hardware.
---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index 96903cd9cfc2..52bcb8cf46b1 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -898,8 +898,11 @@ static int __maybe_unused qcom_iommu_resume(struct device *dev)
 	if (ret < 0)
 		return ret;
 
-	if (dev->pm_domain)
-		return qcom_scm_restore_sec_cfg(qcom_iommu->sec_id, 0);
+	if (dev->pm_domain) {
+		ret = qcom_scm_restore_sec_cfg(qcom_iommu->sec_id, 0);
+		if (ret)
+			clk_bulk_disable_unprepare(CLK_NUM, qcom_iommu->clks);
+	}
 
 	return ret;
 }




