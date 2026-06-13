Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9C039B959
	for <iommu@lists.linux.dev>; Sat, 13 Jun 2026 06:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781333931; cv=none; b=pC9yIkQ4Y8QsJw4DFZ9RGLZ5IfztWBTQahJ+J9NRU70mxDwAieecawJPL3A3CPa8UEfzwTLVgTHs7uy6CAr9/AmKTIZUZyprRJNYiyHyc12yFiGRrTtVQ4hNAl+AmmE5/zLNH80m6L8gfePKQDG9/0soMRNBT992f8bFJ+xNx8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781333931; c=relaxed/simple;
	bh=+oC/cphUq61z1tUYe/It2wm8zgDiOcsdp+YquhThWMc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K6qme0wMb0hGCj9zFZZlLSfyqQdwz9JhThfCqZqv/muvoQvdO6WRlTC6LdFeab77gXqdUKmkXCo29KCO2zt7FyWB6eG8aZFXfD8/zl0FW0s23NmiBdsjOULJNYrszx+q/LTMsq4rIZtv7bqQ9y3LQvoj0u0dOsgUrmwXpryaiVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ghx1c80F; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghx1c80F"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-491609cdd8fso7680135e9.2
        for <iommu@lists.linux.dev>; Fri, 12 Jun 2026 23:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781333924; x=1781938724; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6qXDWY05NWH/jJuuAS5m9EpuxlsKXS/Zj0XFrGsO4MM=;
        b=ghx1c80F3LhN83lv5gTlsJWyixxvawZhExNjXLC4OC2EuGXPcaaTBq49y0Zca2zLVS
         u02iuEkl8ewQRQ3wGB6sNlj3u2Zc7V2BPcmVUQSpxYGPHcv6I5MDbshERO2i/sVBInml
         MEJhyRGgxSxRRMkPABwaD4PoD05Ac6E9rN58wH6xskjbUgQFPnQKbAzxKEZRIzKWqiFP
         2M128QxRQmttJDdhRUKC12UlOBsV61vaTXXrw17eaw17KKOVriTdxTcFRqrzGq71o4eC
         4imsDdDoG6zN3X0Y7iuXtRDJAcfZjYWrwqdkAPV66H6oDkp32A4Doy68B4SiRfhsrccK
         hJFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781333924; x=1781938724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6qXDWY05NWH/jJuuAS5m9EpuxlsKXS/Zj0XFrGsO4MM=;
        b=kTZv9pUnWJKzM5l5KS5co+w92Grc/ye8QcDcH1br1WZcpqpyxvKFO0v0a2NMkWLWwE
         wUVEYshsMDNvXsSc5Rz2oQX789lfyXJg3gDqRg3bPbeNsWztb97M1+Ze0p8pwY/snWj6
         +J0oveNexIofvn9f9js7fx0TnTbjUYORfQtvf1AvsVGxGHmeLidJuCrtV7jYTsv2Uqv8
         GCQHH+S68891uakWaXnruiFM+NHF9gm6CuAcUksVA2q33uuGeWKV+EIICdF7yerZ1f7L
         ftsoTrD+b3Vc8anKdfQumCnBj2BLQuZIhNyvxDSKzmcJJx7s2cgVGVwuB0qHBuzU3jm6
         MirQ==
X-Forwarded-Encrypted: i=1; AFNElJ8UbwAVVfxEUKOija+9EJj4foq9t92mSoe/hUdwXVqpbgloQhEOX5ZpkJ5uySDGvO6Ufpt7uw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw8Cou2JTL3Bc/Yavl5p9aLu4wQRTK8tWBeVM46AiAUOKN70mr1
	0a0n3OTeqiCyA6uDMM1QEieDqXcX/LjEKYPS9LCVoCh1ciwfkKl9Qr88
X-Gm-Gg: Acq92OFgqV0v1SE01ba0ALWpqQikCJWVkN4/HjPZLVqAYXKD0RttLYFlSZcxs8iIqmo
	Dp42dexG363EW5RS4XJHQYEI/ocxhZF67Dj9Wt6sDIUAafFe2jz9rA4OtCdHBlIdb0sDkZmUXND
	6zgmAuQ55OJUnT4v2qXdM8QY8d1vZ9nS7hTCYkvuFCewB6qtgNU29d/fsp96dzyf54Qzh+9pv0h
	i4174W5YlPxbioE/admcG96R+L3eDm0Uqy+lSB9+ueNvGYZLgvXuF8mahB8qkZ5YPARbX0ffBCo
	PGW+MTOt36IMqQ8+ogpWD/CBogiPTn6KMg1mVZ2I0A8Jew0rbIgoJhoJx7y8VkBHfd/FMJZ3G9N
	YuVBkS5ey5EttItPBntim9VSeR1MV4D8v4Vwt/c8Bh7fCxzd9UEAzaVL3PDDaC5xLYUL++33MqR
	N+V9I7tb5OZeiVX4SLy87c0SJauSMpSbydam1QvMkP/A==
X-Received: by 2002:a05:600c:46c4:b0:490:b355:9c8c with SMTP id 5b1f17b1804b1-490ec4fbcb7mr81233115e9.23.1781333924116;
        Fri, 12 Jun 2026 23:58:44 -0700 (PDT)
Received: from debian.tailb81abf.ts.net ([2a01:e0a:104a:4d80:14c0:9448:1c38:77df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492202e5cbasm42917705e9.2.2026.06.12.23.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 23:58:43 -0700 (PDT)
From: MidG971 <midgy971@gmail.com>
To: tomeu@tomeuvizoso.net,
	ogabbay@kernel.org,
	heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ulf.hansson@linaro.org
Cc: dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	xxm@rock-chips.com,
	chaoyi.chen@rock-chips.com,
	finley.xiao@rock-chips.com,
	diederik@cknow-tech.com,
	jonas@kwiboo.se,
	Midgy BALON <midgy971@gmail.com>
Subject: [RFC PATCH v4 9/9] pmdomain: rockchip: Add a regulator to the RK3568 NPU power domain
Date: Sat, 13 Jun 2026 09:01:16 +0200
Message-Id: <20260613070116.438906-10-midgy971@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260613070116.438906-1-midgy971@gmail.com>
References: <20260613070116.438906-1-midgy971@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Midgy BALON <midgy971@gmail.com>

The RK3568 NPU rail (vdd_npu) needs to be enabled before the domain is
powered on and disabled after it is powered off. Give DOMAIN_RK3568 a
regulator parameter (like DOMAIN_RK3588 already has) so the NPU domain
can set need_regulator, letting genpd manage the rail wired up as the
domain's domain-supply instead of marking it always-on in DT.

Suggested-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
Signed-off-by: Midgy BALON <midgy971@gmail.com>
---
 drivers/pmdomain/rockchip/pm-domains.c | 36 ++++++++++++++++++--------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index 490bbb1d1d8e8..19db307e3811d 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -138,6 +138,20 @@ struct rockchip_pmu {
 	.active_wakeup = wakeup,			\
 }
 
+#define DOMAIN_M_R(_name, pwr, status, req, idle, ack, wakeup, regulator)	\
+{							\
+	.name = _name,				\
+	.pwr_w_mask = (pwr) << 16,			\
+	.pwr_mask = (pwr),				\
+	.status_mask = (status),			\
+	.req_w_mask = (req) << 16,			\
+	.req_mask = (req),				\
+	.idle_mask = (idle),				\
+	.ack_mask = (ack),				\
+	.active_wakeup = wakeup,			\
+	.need_regulator = regulator,			\
+}
+
 #define DOMAIN_M_G(_name, pwr, status, req, idle, ack, g_mask, wakeup, keepon)	\
 {							\
 	.name = _name,					\
@@ -241,8 +255,8 @@ struct rockchip_pmu {
 #define DOMAIN_RK3562(name, pwr, req, g_mask, mem, wakeup)		\
 	DOMAIN_M_G_SD(name, pwr, pwr, req, req, req, g_mask, mem, wakeup, false)
 
-#define DOMAIN_RK3568(name, pwr, req, wakeup)		\
-	DOMAIN_M(name, pwr, pwr, req, req, req, wakeup)
+#define DOMAIN_RK3568(name, pwr, req, wakeup, regulator)		\
+	DOMAIN_M_R(name, pwr, pwr, req, req, req, wakeup, regulator)
 
 #define DOMAIN_RK3576(name, p_offset, pwr, status, r_status, r_offset, req, idle, g_mask, wakeup)	\
 	DOMAIN_M_O_R_G(name, p_offset, pwr, status, 0, r_status, r_status, r_offset, req, idle, idle, g_mask, wakeup)
@@ -1274,15 +1288,15 @@ static const struct rockchip_domain_info rk3562_pm_domains[] = {
 };
 
 static const struct rockchip_domain_info rk3568_pm_domains[] = {
-	[RK3568_PD_NPU]		= DOMAIN_RK3568("npu",  BIT(1), BIT(2),  false),
-	[RK3568_PD_GPU]		= DOMAIN_RK3568("gpu",  BIT(0), BIT(1),  false),
-	[RK3568_PD_VI]		= DOMAIN_RK3568("vi",   BIT(6), BIT(3),  false),
-	[RK3568_PD_VO]		= DOMAIN_RK3568("vo",   BIT(7), BIT(4),  false),
-	[RK3568_PD_RGA]		= DOMAIN_RK3568("rga",  BIT(5), BIT(5),  false),
-	[RK3568_PD_VPU]		= DOMAIN_RK3568("vpu",  BIT(2), BIT(6),  false),
-	[RK3568_PD_RKVDEC]	= DOMAIN_RK3568("vdec", BIT(4), BIT(8),  false),
-	[RK3568_PD_RKVENC]	= DOMAIN_RK3568("venc", BIT(3), BIT(7),  false),
-	[RK3568_PD_PIPE]	= DOMAIN_RK3568("pipe", BIT(8), BIT(11), false),
+	[RK3568_PD_NPU]		= DOMAIN_RK3568("npu",  BIT(1), BIT(2),  false, true),
+	[RK3568_PD_GPU]		= DOMAIN_RK3568("gpu",  BIT(0), BIT(1),  false, false),
+	[RK3568_PD_VI]		= DOMAIN_RK3568("vi",   BIT(6), BIT(3),  false, false),
+	[RK3568_PD_VO]		= DOMAIN_RK3568("vo",   BIT(7), BIT(4),  false, false),
+	[RK3568_PD_RGA]		= DOMAIN_RK3568("rga",  BIT(5), BIT(5),  false, false),
+	[RK3568_PD_VPU]		= DOMAIN_RK3568("vpu",  BIT(2), BIT(6),  false, false),
+	[RK3568_PD_RKVDEC]	= DOMAIN_RK3568("vdec", BIT(4), BIT(8),  false, false),
+	[RK3568_PD_RKVENC]	= DOMAIN_RK3568("venc", BIT(3), BIT(7),  false, false),
+	[RK3568_PD_PIPE]	= DOMAIN_RK3568("pipe", BIT(8), BIT(11), false, false),
 };
 
 static const struct rockchip_domain_info rk3576_pm_domains[] = {
-- 
2.39.5

