Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D133168F8
	for <iommu@lists.linux.dev>; Mon, 15 Dec 2025 08:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765788842; cv=none; b=rYaoiZfPLxwFy80i6eJphDlPIZ9L118/AkWdwywzQAFPlP1b7AwIrTIoEyxbgBu8DwKmG0elNQn73Vkff5XmV33ndmIfthXPCauzydjBAxb5CM5vPtMzTjvijrUuOefkcl3suPdlr+IdS1xE7+friT5v3j74+IQjvREBYiJnrNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765788842; c=relaxed/simple;
	bh=a4oJ5h8F6+5H21ppQ4zCYLSP4cr9qDHKi8vQVGfWg0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kf+K4Tre6AJht5WCky6397evL/cKLVrBadAHfcTVVfkjchoTOr+6bwxG/6whGuf293qVkF6/qJLATp4uXA/6k+rwVzP3vBm53fwao6HzX5HmoUg3yZMcvwVX6/55C79+gDbrAxLa3EvTI9eVLhzWyw8MTM7T0Sty2gv73aVEmCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RaxHWbRS; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RaxHWbRS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1765788838;
	bh=a4oJ5h8F6+5H21ppQ4zCYLSP4cr9qDHKi8vQVGfWg0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RaxHWbRSswmNgKV7KS4Ai8npfmR0euDswGOgyCcMWV1WsXQegU7ggZuDmQ5G7Hkw1
	 GY1Wc/zXhsvrp9XnnLahAss6RV7pb+ZBFLtReGyK5JzTyb7Z7KpCDaf46eQkviT0d0
	 FfwBKfUB4RmZw2sIqaXmQcgqJ/gWvrESrqVRq0y3Wf1pj++lNUVzXNb6qBCvv3dRxB
	 3yrZZgJSninYhy6apDMT1/Zsp4kjHMC7yhRpoiYxTdCO4fF2b3REzmWR9GYpvsV0Zh
	 SmhH7Va7Pz7QDD3Ctfl6lE1MiucHsKy8dMdalLpdfCeGtYOO3WjH562DnZ8dBPWEdZ
	 wAMDuB/tVl8mA==
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:c17e:135b:5095:83a8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7E66F17E1423;
	Mon, 15 Dec 2025 09:53:57 +0100 (CET)
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	nicolas.dufresne@collabora.com,
	p.zabel@pengutronix.de,
	mchehab@kernel.org
Cc: iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-media@vger.kernel.org,
	kernel@collabora.com,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v10 4/7] MAINTAINERS: Add entry for Verisilicon IOMMU driver
Date: Mon, 15 Dec 2025 09:53:41 +0100
Message-ID: <20251215085349.10155-5-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251215085349.10155-1-benjamin.gaignard@collabora.com>
References: <20251215085349.10155-1-benjamin.gaignard@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add maintainer for Verisilicon iommu driver.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c9e416ba74c6..ca67e5333134 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27296,6 +27296,14 @@ F:	drivers/media/v4l2-core/v4l2-isp.c
 F:	include/media/v4l2-isp.h
 F:	include/uapi/linux/media/v4l2-isp.h
 
+VERISILICON IOMMU DRIVER
+M:	Benjamin Gaignard <benjamin.gaignard@collabora.com>
+L:	iommu@lists.linux.dev
+S:	Maintained
+F:	Documentation/devicetree/bindings/iommu/verisilicon,iommu.yaml
+F:	drivers/iommu/vsi-iommu.c
+F:	include/linux/vsi-iommu.h
+
 VF610 NAND DRIVER
 M:	Stefan Agner <stefan@agner.ch>
 L:	linux-mtd@lists.infradead.org
-- 
2.43.0

