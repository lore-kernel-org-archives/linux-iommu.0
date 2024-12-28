Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4999F8633F
	for <iommu@lists.linux.dev>; Sat, 28 Dec 2024 12:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735388562; cv=none; b=JnZwk3jiKt5CFGMT6BA4+yfLqnFeWojHYoQnsYWupG6ui+F9xXli6fiyQTuM+eXymXTWilu6dg63HyH/bs+ptTDBbShSr9/D8gpEUwa1tKGTcQIPRemt06yg3KyiKXrW5hYSzblzj+Gu/usICUgjw5EZyGVtrs/VlYy/+gV7v5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735388562; c=relaxed/simple;
	bh=OBlE4hbr79lCKzOZPXvEmAKmNbV2db84jbjWPr20538=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dISWewGHK5P6vMeYVsBuB+UjeaKwlqQMOUjKPIP2yLCOrpTr2W0WlNv0Xf8Nt4UP7p3dwkuszdMyNUMR98ckdlz7Sos4bGzclorHbQv73lHbmQsmK5RLbKZ51+m7s+7zsrxRzXgjt9HT6RsBf3lh/qstzBsiWlRSOJ7jCOeoFvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=qexrkZEu; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="qexrkZEu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=pg0Uf
	V4prOtW7FOVVRBO2lYE1N8dbmghRAassomDga4=; b=qexrkZEusg4KCK0enN78K
	lKGA/JWbFrg2ilT+tJURad/pplmnwho3fjtHix1oL37TuqTn8j2vaJ0OYdG78hnU
	Xd0RTFUwJ/YSLowBq5j8T2jwhqhK241PfwdVOCb4mXR0gQ/bxdnIXP0glidgIIkg
	rsgUvNnGkCsPffIp6I62Gs=
Received: from ProDesk.. (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3t0tl7W9nUxdCCQ--.1009S5;
	Sat, 28 Dec 2024 20:22:05 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de,
	krzk+dt@kernel.org,
	joro@8bytes.org
Cc: cl@rock-chips.com,
	robh@kernel.org,
	hjc@rock-chips.com,
	vkoul@kernel.org,
	devicetree@vger.kernel.org,
	detlev.casanova@collabora.com,
	cristian.ciocaltea@collabora.com,
	dri-devel@lists.freedesktop.org,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v2 3/8] dt-bindings: display: rockchip: Add rk3576 hdmi controller
Date: Sat, 28 Dec 2024 20:21:46 +0800
Message-ID: <20241228122155.646957-4-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241228122155.646957-1-andyshrk@163.com>
References: <20241228122155.646957-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3t0tl7W9nUxdCCQ--.1009S5
X-Coremail-Antispam: 1Uf129KBjvdXoW7XFW3Kr4UZr1UWF4UKF1ftFb_yoWDXrbEqa
	4xZ3Z8ZFs5Zr1Y9w1DJ397Wws8Ja17KF4kGa1UAF4DJa4kKrZYqr95G343KFykAF17uFyx
	CFn5XrWUG3ZxJjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUndb1UUUUUU==
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqRPDXmdv5wS0uAACsC

From: Andy Yan <andy.yan@rock-chips.com>

RK3576 HDMI TX Controller is very similar to that of RK3588, but
with some control bits for IO and interrupts status scattered across
different GRF.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

(no changes since v1)

 .../bindings/display/rockchip/rockchip,rk3588-dw-hdmi-qp.yaml    | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,rk3588-dw-hdmi-qp.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,rk3588-dw-hdmi-qp.yaml
index d8e761865f27..b838b5ec2dca 100644
--- a/Documentation/devicetree/bindings/display/rockchip/rockchip,rk3588-dw-hdmi-qp.yaml
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,rk3588-dw-hdmi-qp.yaml
@@ -29,6 +29,7 @@ allOf:
 properties:
   compatible:
     enum:
+      - rockchip,rk3576-dw-hdmi-qp
       - rockchip,rk3588-dw-hdmi-qp
 
   reg:
-- 
2.34.1

