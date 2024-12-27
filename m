Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1311F4268
	for <iommu@lists.linux.dev>; Fri, 27 Dec 2024 13:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735304557; cv=none; b=LFxKzYYgLl79Yue3SC3rjnbreuXHdZrf/kvQ3gVlKP6kNMuH57cNqcixWj25WxGeC6BZuqejvogKGjzm05hUcbb2dzEESgY+EuIyeiPma5guOGyPiJ+3dNXef1F5HBOq+UIBCNZRzgo1mEY16ll/SkEmMF7oNXR/VECjUYBdypw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735304557; c=relaxed/simple;
	bh=OF2xEirt2I4TWCuMHqY/Rfu3fQsoGOZ+4waicM8FC9g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SV0/1T1T4geYMAEvPSoPyggC0o1qPYRLG6GUDTVrx2I2YADy2eoDOufpTKrwbAxPl2oL/i8uG9IsYyfuUVpjPAD+jAqtily0ZJMPc2PcarZfN2wgnT6/4Wcdci4Y+v+lVUJBO3+kws0zfSXbvtR1lbhtgD4QwTdP2w/GUsiA5PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com; spf=pass smtp.mailfrom=linumiz.com; dkim=pass (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b=MhSVMdZp; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linumiz.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b="MhSVMdZp"
Received: from eig-obgw-5008a.ext.cloudfilter.net ([10.0.29.246])
	by cmsmtp with ESMTPS
	id R46etx110jMK7R9z9tMDzB; Fri, 27 Dec 2024 13:02:35 +0000
Received: from md-in-79.webhostbox.net ([43.225.55.182])
	by cmsmtp with ESMTPS
	id R9z7txxaoN0LRR9z8tqe9j; Fri, 27 Dec 2024 13:02:35 +0000
X-Authority-Analysis: v=2.4 cv=erfZzJpX c=1 sm=1 tr=0 ts=676ea56b
 a=LfuyaZh/8e9VOkaVZk0aRw==:117 a=kofhyyBXuK/oEhdxNjf66Q==:17
 a=IkcTkHD0fZMA:10 a=RZcAm9yDv7YA:10 a=-pn6D5nKLtMA:10 a=vU9dKmh3AAAA:8
 a=VANPn-21L8UGAxZ6yr4A:9 a=QEXdDO2ut3YA:10 a=rsP06fVo5MYu2ilr0aT5:22
 a=ZCPYImcxYIQFgLOT52_G:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
	; s=default; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=phv7iVVXVzjakNqDgdbYw7zx5GFmWGAQJh9j37w1dWc=; b=MhSVMdZpGT/3YN6WA4C63drtku
	xRh1qBZik1Oku888v04qGK618IQEgQuB9/zKZ8w3j14+w992UlMoIy0Oivsf2hh3xTNbEDbR7agdE
	lVMDmXiGg0W2Te2a4pez6WA/xXOhwJSJ70aZdU9/3dxyUi238znqXKlQ0PGLVu961nNIa/0eOBYD2
	UX20JxNTEXZyEP5UkVsPBdPjS1T4QSCZoth24Ju7DGc0Brja43/aOqZcylzIWCmGKJHUQ7FXw09dJ
	FK0Uy+tr4Re3cnWisewKBAONwNeX8AEWuVYDbz6rEswtSAZtV1pAdkAuNsD/IDYq/w/3TmpU3r8lx
	ObzPhlBQ==;
Received: from [122.165.245.213] (port=58270 helo=[127.0.1.1])
	by md-in-79.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <parthiban@linumiz.com>)
	id 1tR9yt-002EaQ-0t;
	Fri, 27 Dec 2024 18:32:19 +0530
From: Parthiban Nallathambi <parthiban@linumiz.com>
Date: Fri, 27 Dec 2024 18:31:00 +0530
Subject: [PATCH RESEND 11/22] drm/sun4i: Add support for a100/a133 display
 engine
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241227-a133-display-support-v1-11-abad35b3579c@linumiz.com>
References: <20241227-a133-display-support-v1-0-abad35b3579c@linumiz.com>
In-Reply-To: <20241227-a133-display-support-v1-0-abad35b3579c@linumiz.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Linus Walleij <linus.walleij@linaro.org>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>
Cc: iommu@lists.linux.dev, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-phy@lists.infradead.org, 
 Parthiban Nallathambi <parthiban@linumiz.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735304469; l=915;
 i=parthiban@linumiz.com; s=20241125; h=from:subject:message-id;
 bh=OF2xEirt2I4TWCuMHqY/Rfu3fQsoGOZ+4waicM8FC9g=;
 b=HGHE7FIkhzVXr2bzSYQN/APXLS7hoE7h8PpfzMDLfmskWW0X5xf3aKov2lNS6OvqgImNsDhVF
 IH0y/vmrBKWDHFJoJixEGQPfgnOmBdvk5asMsYb1R93wvAXRQPbPSsE
X-Developer-Key: i=parthiban@linumiz.com; a=ed25519;
 pk=PrcMZ/nwnHbeXNFUFUS833wF3DAX4hziDHEbBp1eNb8=
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - md-in-79.webhostbox.net
X-AntiAbuse: Original Domain - lists.linux.dev
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linumiz.com
X-BWhitelist: no
X-Source-IP: 122.165.245.213
X-Source-L: No
X-Exim-ID: 1tR9yt-002EaQ-0t
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([127.0.1.1]) [122.165.245.213]:58270
X-Source-Auth: parthiban@linumiz.com
X-Email-Count: 328
X-Org: HG=dishared_whb_net_legacy;ORG=directi;
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKm8ssrsSNveli/HvnmO4OSmIYvBdEtN8K4PBHR32uS3IF0EITpCUmdaMzRMYDrCASMOb2MAakli0NIYNdirwzlLVVnn4lIvCk131/lKNyfwsb3SM9CC
 UBgtx5siQx61dE1D+bh6+Qj1QJwQEI4/s/uKuNE9AvJleRzYQBnfR//jIQhZphHKQicapLnb+QbdAuApFhG0gbq8UL7vSkYfSSc=

Display Engine(DE2) in Allwinner A100/A133 has one mixers and tcon.
The routing for mixer0 is through tcon0 and connected to
LVDS/RGB/MIPI-DSI controller.

Signed-off-by: Parthiban Nallathambi <parthiban@linumiz.com>
---
 drivers/gpu/drm/sun4i/sun4i_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index 5eccf58f2e17..e012a6316bba 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -436,6 +436,7 @@ static const struct of_device_id sun4i_drv_of_table[] = {
 	{ .compatible = "allwinner,sun9i-a80-display-engine" },
 	{ .compatible = "allwinner,sun20i-d1-display-engine" },
 	{ .compatible = "allwinner,sun50i-a64-display-engine" },
+	{ .compatible = "allwinner,sun50i-a100-display-engine" },
 	{ .compatible = "allwinner,sun50i-h6-display-engine" },
 	{ }
 };

-- 
2.39.5

