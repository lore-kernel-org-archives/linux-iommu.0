Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795854622;
	b=Qb7EEwhRQDGTgRwWn9VEpT80yEL2Is7D4hXCu0y/62+2d8RnanC3VWJYdOgtce2POpRK
	 7jApdZE4nZaFEMxPh67HzlTA+/r6I7XiW8fIkgkGGyBA3WkPLkLL74uWdUNgdujU3BmMT
	 BaS0DvogY/GY1ghnnFkU2tfy6yiCY2y7l9e/UVgWV4P+0RupS2miuY7I7gUl45B4oAy16
	 cNCDEKjnfoQNwdifArDf8n3plbjoukUdK8WvMl6VuHHTTUI7EyvizpjsG7C+oobxqyydA
	 DQ7tq4hRQb7pj/p6qQoP/TaZGruaeLbBT0n1KuSsMmILMpfBln9aagoZB63Zh9PjRHg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795854622;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=6Xs2Yaw3Rv/sna20eduxHz1FO7cB7nwgMOoC4joObOI=;
	b=arjPCtQu/JNt2DC6q1KJ4CBNHXEES2gCXGivUD+K/8v3kmBGuktuwwK7KE7NbMiCGb5K
	 SIWV72+1zq/zdd6g1eXZIlXOj/NH7xZZD2qsDCTGeLR8rTHrtzO2ve/g5aLGUXPeTO3wN
	 jeWl4au1rw+92rveM6/LBfQW2pKmfIBTWI7gXdR4j/dROAR3xSzJrVJZRwiqEh5zxKAhq
	 qVEK4V3oKyhiOB5uKVtVL3QOqqxZKkiuo9OGHraU3SNoX9QkZ3rwV0ihvegoVc5KakFeb
	 c8V6jE87d1wmODp81egtlca5qlB8Y8bUj3mghkZ883LVgR9lCcz8r392Vk3bGgIOAng==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WBWT1xak;
	arc=fail smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5261B606A31F;
	Sat, 28 Nov 2026 08:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WBWT1xak
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795854621;
	b=G+l8prINuteL4xFEhTNVuMCmLxVdmDqvfBbi+F2g+2FCZ76eZiAToEB+kRu0zJthClQk
	 Kb7/95gFTGfzNl2n4/wQUClHLIFqXmF+wEQU/pq3gUnb1vyG9Lavsh4B1leG9VIrBWHM0
	 NeeMZS1MIJ+znHD+VA6/qocwoDgY0VbRR2n7SmbhCWAHrjWO3dZPq78mshVMU85LhoKPF
	 JD5JX1HjP0Ox3lcpmwq+pM0tYFmZN+0knYNb99oY008xk21X28DdGjTr1f/kPPDIyG3ad
	 W0wX//LE5DB+M3rROidNN4KG5WecWvVqZQwDUfLU889LOmh+vQSNyW9wjlgYEr32PTA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795854621;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=6Xs2Yaw3Rv/sna20eduxHz1FO7cB7nwgMOoC4joObOI=;
	b=RbW+8LY/owqkAktKfAQLxFi2JGswsdZ7bUXsFqOhSUHefQPHFyhUz1c5QTR/tEQR03fY
	 79tIenPCxPQlqdLvrP3KCw1GZePhz9W/Qxdpw5ri1TLYuyWzYZU7MSs1FIy55TZplkZuM
	 vcKdmDcCuIi9u8zndFenECVKntHWtMEqP+ezUM6QD8R5kSnAMyDHKL7dzLwrRI5e7SdSF
	 ZemJ8/3LsX1cMYaGXy4ih1RE2Smlrh8IDABT2e3MWzcRT9xQsgwJ0iTvUWFTqXS+AqsqB
	 B3wG5ZJSEyv6/IF7//hCt7CaIGpa3ZH8xBulnpxvhhAS5HkAdKSW6qj1uoWCQ8yiGOw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C34521F00899;
	Sat, 28 Nov 2026 08:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795854621;
	bh=6Xs2Yaw3Rv/sna20eduxHz1FO7cB7nwgMOoC4joObOI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=WBWT1xakvp6TOabNVPUBleITFt/5LBvZu14WC5pWgKmjbIewH6FB6kTlScPkLbmjT
	 2OQpSTc8TNO3EGer/zljti1/511kAg8Xhs9Hn/2Izv+uwVyY1eRNq2n0/lQrYUm1VS
	 pCU0ruVbACQ6Oe0kgIiXNY97uddBcCaY033Lw3wbB91SOlYr2lCu5Q5gR56bwlCeHz
	 PyqKxeX7lIkDEREqxt333cDOIARP8IV0ebuoczk3zD1LW95eyvCrvQNNbpOm1SoyvH
	 NxUjnSgjlcsGCKLqTAIYOEezYg49JVshEHylQiGkqqzEd0CbmKh2RNxQG9LVjmit9z
	 ReoG2GZNiUqjQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4F95E4E042;
	Sat, 28 Nov 2026 08:30:08 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Sat, 28 Nov 2026 08:30:08 +0000
Subject: [PATCH v6 2/4] iommu/rockchip: Add rockchip_iommu_restore()
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
Message-Id: <20261128-iep2-v6-2-5f4f10a0dbeb@gmail.com>
References: <20261128-iep2-v6-0-5f4f10a0dbeb@gmail.com>
In-Reply-To: <20261128-iep2-v6-0-5f4f10a0dbeb@gmail.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-rockchip@lists.infradead.org, linux-media@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
 Hans Verkuil <hverkuil@kernel.org>, 
 Nicolas Dufresne <nicolas.dufresne@collabora.com>, 
 Alex Bee <knaerzche@gmail.com>, Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795854607; l=2899;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=eh3M8wWr/iZXtAkts9MsMMEhyAO/8EyRUsXN3kJyTV8=;
 b=+ixln+dh2caPsEfMR8HKdbF8MchW7FqW9HpLyoYmqiHwcWzYBvIYfVo++dOmwrYJvXB28DyWn
 SBUMp/AZSblAwXdn4gUu1/Lc/8dzpyEe6nfzsuQm9rOYeZyVChi/7d8
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

Some masters reset their IOMMU along with themselves. The RK3588 IEP2
does: after its soft reset, paging is off and its DMA is untranslated.

Add a helper to reprogram the IOMMU of such a master, so that its
driver need not attach and detach an empty domain to do it. rkvdec
does the same with rkvdec_iommu_restore().

Acked-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/iommu/rockchip-iommu.c        | 38 +++++++++++++++++++++++++++++++++++
 include/soc/rockchip/rockchip_iommu.h | 17 ++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 21af2f621c76..e16d47d5e689 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -27,6 +27,8 @@
 #include <linux/spinlock.h>
 #include <linux/string_choices.h>
 
+#include <soc/rockchip/rockchip_iommu.h>
+
 #include "iommu-pages.h"
 
 /** MMU register offsets */
@@ -1349,6 +1351,42 @@ static int __maybe_unused rk_iommu_resume(struct device *dev)
 	return rk_iommu_enable(iommu);
 }
 
+/**
+ * rockchip_iommu_restore() - Reprogram the IOMMU of a master after its reset
+ * @dev: master device, runtime active, with no DMA in flight
+ *
+ * Some masters reset their IOMMU with themselves, which turns paging off.
+ * This bypasses the IOMMU group mutex: the caller must own the IOMMU
+ * exclusively and call this right after its own reset.
+ *
+ * Context: may sleep.
+ *
+ * Return: 0 on success or a negative error code.
+ */
+int rockchip_iommu_restore(struct device *dev)
+{
+	struct rk_iommu *iommu;
+	int ret;
+
+	if (!device_iommu_mapped(dev) ||
+	    dev->iommu->iommu_dev->ops != &rk_iommu_ops)
+		return 0;
+
+	iommu = rk_iommu_from_dev(dev);
+	if (!iommu || iommu->domain == &rk_identity_domain)
+		return 0;
+
+	ret = pm_runtime_get_if_in_use(iommu->dev);
+	if (ret <= 0)
+		return ret;
+
+	ret = rk_iommu_enable(iommu);
+	pm_runtime_put(iommu->dev);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(rockchip_iommu_restore);
+
 static const struct dev_pm_ops rk_iommu_pm_ops = {
 	SET_RUNTIME_PM_OPS(rk_iommu_suspend, rk_iommu_resume, NULL)
 	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
diff --git a/include/soc/rockchip/rockchip_iommu.h b/include/soc/rockchip/rockchip_iommu.h
new file mode 100644
index 000000000000..79fdd898a0fc
--- /dev/null
+++ b/include/soc/rockchip/rockchip_iommu.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __SOC_ROCKCHIP_IOMMU_H__
+#define __SOC_ROCKCHIP_IOMMU_H__
+
+struct device;
+
+#ifdef CONFIG_ROCKCHIP_IOMMU
+int rockchip_iommu_restore(struct device *dev);
+#else
+static inline int rockchip_iommu_restore(struct device *dev)
+{
+	return 0;
+}
+#endif
+
+#endif /* __SOC_ROCKCHIP_IOMMU_H__ */

-- 
2.55.0


