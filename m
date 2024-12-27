Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0E31F3D33
	for <iommu@lists.linux.dev>; Fri, 27 Dec 2024 11:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735297825; cv=none; b=jA/8t3Hg+zi2sMTEwZ5TACH2nOtY0cDDCIfiT/3QJRO4HKzkeoc56HUb/Y/Ly0xAUlSULo/XEXwoxWxEriK1O8qH71F07ELrJZTaFw8jnt4FucisTABjxQ1mmiC61R+lVhP3+2BGEukntR3e3RMT5OcYXsZzitiaKhDMwYQOJ+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735297825; c=relaxed/simple;
	bh=CRTcqeTXRyDN3TGUF8oORkuSGchQveTRlcokaVR1eww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JnlFBNK2nLB9yWktgefPMEaq9UIqq39JrG8pdrvDUIc6TwYIybKcwDPd+k6kgxYFVrmNroOvQFJk1NtSfFW+xAcNWGiwxc5azbSxHaU8v7NCcawwHxz4z3fEC9obYEBmPe6oleSTeFRIfc+iFd1o7bruPDuTNeJim8VWvCh1KfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com; spf=pass smtp.mailfrom=linumiz.com; dkim=pass (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b=Tvz/n3Yw; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linumiz.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b="Tvz/n3Yw"
Received: from eig-obgw-5008a.ext.cloudfilter.net ([10.0.29.246])
	by cmsmtp with ESMTPS
	id R46etX9A9xoE1R8D8tking; Fri, 27 Dec 2024 11:08:54 +0000
Received: from md-in-79.webhostbox.net ([43.225.55.182])
	by cmsmtp with ESMTPS
	id R8D5twrpHN0LRR8D7tphSu; Fri, 27 Dec 2024 11:08:53 +0000
X-Authority-Analysis: v=2.4 cv=erfZzJpX c=1 sm=1 tr=0 ts=676e8ac5
 a=LfuyaZh/8e9VOkaVZk0aRw==:117 a=kofhyyBXuK/oEhdxNjf66Q==:17
 a=IkcTkHD0fZMA:10 a=RZcAm9yDv7YA:10 a=-pn6D5nKLtMA:10 a=vU9dKmh3AAAA:8
 a=hmV1tqqUXjKF9vlo9u0A:9 a=QEXdDO2ut3YA:10 a=rsP06fVo5MYu2ilr0aT5:22
 a=ZCPYImcxYIQFgLOT52_G:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
	; s=default; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=obwp4Uet5DlEIt0J2ySMGAkOAswbOhVFXBB3XZ5Jqiw=; b=Tvz/n3Yw2wGJ0JUud95nFYQHIs
	rVGf68hyUTRY7Qz3Ip3Tv1Og27+hofnvSwCpa6LtmD8m8zPqSn/2JoVheI3f5YQscxSdtXt2bPriN
	GHRTzzlITfNkubnYwmGxR+WblyQuTF+y+RSy2zMUww81RXoMEEmOpBxBQ7WI3X9MnlUNMHlXjwnlq
	2wx2YvhFbSKTkXs4k2r/IluQbEVFladmr6VnNrRUdRFwL/U4b/O89isUwquU7xu5Ko0WaogaLR0c7
	uD4egR4hDme3ABUBNGu31xy8EtMAerR2yjPtc6e28jqwl4K5xB1afBFQAwiOCe3NKmTbMusMe38Dj
	toTPB4CQ==;
Received: from [122.165.245.213] (port=50828 helo=[127.0.1.1])
	by md-in-79.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <parthiban@linumiz.com>)
	id 1tR8Cz-000bEK-2u;
	Fri, 27 Dec 2024 16:38:45 +0530
From: Parthiban Nallathambi <parthiban@linumiz.com>
Date: Fri, 27 Dec 2024 16:37:53 +0530
Subject: [PATCH 06/22] dt-bindings: display: sun4i: add a100/a133 tcon lcd
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241227-a133-display-support-v1-6-13b52f71fb14@linumiz.com>
References: <20241227-a133-display-support-v1-0-13b52f71fb14@linumiz.com>
In-Reply-To: <20241227-a133-display-support-v1-0-13b52f71fb14@linumiz.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735297689; l=1081;
 i=parthiban@linumiz.com; s=20241125; h=from:subject:message-id;
 bh=CRTcqeTXRyDN3TGUF8oORkuSGchQveTRlcokaVR1eww=;
 b=cli7oGc0yDB4ocC0xX7gntd9c9v3pTzXHenzFk0VcjzJc+qcHjH9QYS9YxX4U/J00KveIuqIe
 dlUsfLShW0cDpP8eJATwNgBej/CuN4y7YE8oPJaZKfCGNKA8lux4Az1
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
X-Exim-ID: 1tR8Cz-000bEK-2u
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([127.0.1.1]) [122.165.245.213]:50828
X-Source-Auth: parthiban@linumiz.com
X-Email-Count: 195
X-Org: HG=dishared_whb_net_legacy;ORG=directi;
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGFskDY+w/0f8t4p+3rgkCvvzbcUnacS0KbMYtznmmtFpGx9TWvlutUarmPQO3ekgbeNRNUvrewlqjTHqo4/9LpOzgrH6mzH0LBDd7kP7Z5DzyA7cx7c
 ErOMWUnLBLWMWQLWHIrDrZTDQQw8m84f5cjTE4Q14gLjYpplvsx9AxMcG6pSzFG7G1WR8ZXM4h36gUwZPKnRAthUHpKbu4HmRWQ=

A100/A133 has one 18 bit LCD / 2 x LVDS / 1 x DSI. All the controller
shares the same GPIO D block, where LVDS controller can co-exits.

Although 2 LVDS controller is available, there is no document details
for the second. Add compatible for a100 lcd controller.

Signed-off-by: Parthiban Nallathambi <parthiban@linumiz.com>
---
 Documentation/devicetree/bindings/display/allwinner,sun4i-a10-tcon.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/allwinner,sun4i-a10-tcon.yaml b/Documentation/devicetree/bindings/display/allwinner,sun4i-a10-tcon.yaml
index 6d8ae781c230..7ea45a0a2073 100644
--- a/Documentation/devicetree/bindings/display/allwinner,sun4i-a10-tcon.yaml
+++ b/Documentation/devicetree/bindings/display/allwinner,sun4i-a10-tcon.yaml
@@ -35,6 +35,7 @@ properties:
       - const: allwinner,sun9i-a80-tcon-tv
       - const: allwinner,sun20i-d1-tcon-lcd
       - const: allwinner,sun20i-d1-tcon-tv
+      - const: allwinner,sun50i-a100-tcon-lcd
 
       - items:
           - enum:

-- 
2.39.5

