Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793161047;
	b=uxQmlRx3+sTFtkD0Z1bDGajsmPdI7lmoNkwCXH+rOG8X9cyhXVYlbj3vyPXyAABbOwaS
	 Qx9GgOjkKWxYc78/KhBbKo5cw0nxDg+LgHlwKroB/tGDx/Pc66Z0cL131pZ4kNexY9kfy
	 Wu2GECvr3uH20ZwldW8JqH9h/x3nEx4+vBILmOPosGErzuk0YaoxBW5+YrwNMdasou3ct
	 Kw4oWU1GzhtFU/2r62OZTt7Ka8wIiq5M5TWCitPu/uQDYoG6S+BTbqOQY6iIOa7QchY3c
	 Ofw824ifCrM59YGMMhOeB0zIlXJM2PuFxMP+ZLz2vFWikeqfdUJ7fei3dHSCuDEvt0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793161047;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vsYzKlYUxjQ8b2ns7gpXlBY/1SUDj1EiftmKZurRAuk=;
	b=nkXoMTeaDKV7EwjLZzOQ4f4I1JabjurpWja3ogyY6p3pRN2VIw4jSe3QmFq3bsFL2/Mr
	 9lAa1RW8pSeG4il8DJChvVIe4mwhCVtc5obKCih9zMbycbf8VPTyBqnW5v1UfylEq92PG
	 GafxepsBP04BsVKj7FhQeD+zbP7XcmgsnPrNn0UYK/S9eXq0RevE5n8dFFwoqKG+hM874
	 waKhQEIzgCA4pjKm54qZqm3QF/91VpV1ai9BlYgm7h2PUGqkLBDXYLqrpWYMgILva4USt
	 NJY3rH8T9AD4mYAIsKLhhd5hFhh8b9Lei/km8yE3C8dIHAi8eEr0dJJLmaHAeHSoR8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b="idlv/G6r";
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347FF606A31A
	for <iommu@lists.linux.dev>; Wed, 28 Oct 2026 04:17:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 347FF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=idlv/G6r
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ab752f6244so595722a91.2
        for <iommu@lists.linux.dev>; Tue, 27 Oct 2026 21:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793161046; x=1793765846; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vsYzKlYUxjQ8b2ns7gpXlBY/1SUDj1EiftmKZurRAuk=;
        b=idlv/G6rb7ZFEeyVHHZpLwpinBT97Nfl3askqJqCvXOIKPBpMGTGfLgU8png74FT+N
         8j6cALYWWVti7M+OkhiALaUhjXKLMIXguAN9gU6kJNThRlW9coK2cqeOAO28XqHde/DR
         ZWUTN4b2oppdE8GsC3dsvsNBdI5oOHY2GZ/To=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793161046; x=1793765846;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vsYzKlYUxjQ8b2ns7gpXlBY/1SUDj1EiftmKZurRAuk=;
        b=c7QGHwEEc5lScY/B8/R6CH1bSnMK7BuPjE08AiickCyIUYNdmou8Z50pnkSeytC4YX
         D7zzcWw+VZASChOV7t0ZW1/s831CR8iSi0c+YB2HV7YXJWpr74I+JOwCxGCilOf95E/b
         dseRyVvxkPvVL2eUpXjjQ7Cygs+p+4RQlN/71xfnchzvu5XEMqZ30ncDbwO660PavfaU
         j3rCfBhwGc9CoVku0Intf+4T7PhtEC57S9vBR7YdlPM7DIk0UzVcEL2q3pKiNROPGy7p
         Nv1ubX4M9/TMS7LrC0iKIoHHdw2Tmw5Rs0Q/x4op6s+eB7MfTxICSySaIgZg/3dxk05B
         zg+w==
X-Forwarded-Encrypted: i=1; AKwUvByuNqyehhJA0i4JnA/vkMm6ofWaX4jD7szGNHPcPnfXWOvG9dqGp1UnaWPbgUKZUBIiCNP42w==@lists.linux.dev
X-Gm-Message-State: AFq9FYJJtm8XfxvQL1i9UH9MGGsu+omDxylks4qlC4ZSJwfP6Tb/G9qS
	UOfqzuEVyVp/ovQ7at8g1we5KMDxGXdC9JWfnEWnpO0/Y9j07dzmDElvndDmMvwcQQ==
X-Gm-Gg: AYBFou0E5ZNPMhLZgdBEQfN6JFJXLt5y3KtGkz7DfbxaK+qzybcy+zHDYRzg2scXVbd
	1A7iU+PSql/9rWQmZ+kV7jlV1dvUnbROD32TD1VvbmFL47mBXojVWmrxr/A1731s++ZiIfksl1T
	nsjG8b4hQ7O+Hj4i3nNj6kSOknzjcZVX8rp4sMCKgzJFPmAD3LIp7vhQ4feCB0ZZkHn6QD5lPvW
	XVu0a0pYy4Lo60PBtnA2gPo6tP8wnSt41+hmZ5SlpXGworgVDncbdv1mCOLDFX5b2b/AcYVTOut
	J98xUxAe3wiknVs7Kg0m+RkMVb5HcEKibnyKDxzCmjoytT11kcS3kWGDomA6MNIDYzseW+D6cHM
	qSEG0ROS2vD+IgDqVkrHMjTdXSK8qWTR7tGU0+dYmJHIzLVQHThFWSNyKYMd470tM/MT9PGPHBd
	M+Q37ROdV7Y5mW+7ejrnzBxkApPnRxfJT5ineu9Cp3OSNHC31fFBSUefJ0LANiWeHM1oF/9S5Dm
	AqcjAMiVQKVYyWcoQo5+ASBC73i35Gf0JQOjOJGVN+GoXDPRpGhzAeHGFnBYsYInQVkPk4Yv3BZ
	42POHS9hVeb9WHclHbZq1W0cY8/WpYFOMGsRV/WAAEe7DGDNayzWaykZuzSMrSfoYm4K+zuCl1Z
	BRiMUeKg6c/q6
X-Received: by 2002:a17:90b:3b8c:b0:3ac:d79f:8229 with SMTP id 98e67ed59e1d1-3ae58145332mr944428a91.61.1793161046607;
        Tue, 27 Oct 2026 21:17:26 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:203d:7:56ed:2655:ea09:addc])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae5a586662sm969836a91.14.2026.10.27.21.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 21:17:25 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Yong Wu <yong.wu@mediatek.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	iommu@lists.linux.dev,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] iommu/mediatek: Track first resume with a dedicated boolean flag
Date: Wed, 28 Oct 2026 12:16:50 +0800
Message-ID: <20261028041651.3201911-1-wenst@chromium.org>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
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

In mtk_iommu_runtime_resume(), the driver checks `!reg->wr_len_ctrl` to
detect the initial runtime resume before mtk_iommu_runtime_suspend() has
saved the hardware registers.

As described in commit 35c1b48d27da ("iommu/mediatek: Add
REG_MMU_WR_LEN_CTRL register definition"), `REG_MMU_WR_LEN_CTRL` has a
non-zero hardware reset default (containing the default write command
threshold and throttle-disable bits) and mtk_iommu_hw_init() only clears
`F_MMU_WR_THROT_DIS_MASK`. While checking `!reg->wr_len_ctrl` therefore
works in practice, relying on an implicit hardware register default to
track runtime PM state is obscure and easy to misread.

Add a dedicated `has_resumed` flag to `struct mtk_iommu_data` to track
whether the first runtime resume has completed directly.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/iommu/mtk_iommu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index b52e16b06760..3be1edd30861 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -260,6 +260,7 @@ struct mtk_iommu_data {
 	struct mtk_iommu_suspend_reg	reg;
 	struct iommu_group		*m4u_group[MTK_IOMMU_GROUP_MAX];
 	bool                            enable_4GB;
+	bool				has_resumed;
 
 	struct iommu_device		iommu;
 	const struct mtk_iommu_plat_data *plat_data;
@@ -1529,8 +1530,10 @@ static int __maybe_unused mtk_iommu_runtime_resume(struct device *dev)
 	 * Uppon first resume, only enable the clk and return, since the values of the
 	 * registers are not yet set.
 	 */
-	if (!reg->wr_len_ctrl)
+	if (!data->has_resumed) {
+		data->has_resumed = true;
 		return 0;
+	}
 
 	base = data->bank[i].base;
 	writel_relaxed(reg->wr_len_ctrl, base + REG_MMU_WR_LEN_CTRL);
-- 
2.56.0.307.g5fe7bd680c-goog

