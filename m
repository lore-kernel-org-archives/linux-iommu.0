Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349B98633F
	for <iommu@lists.linux.dev>; Sat, 28 Dec 2024 12:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735388557; cv=none; b=f0PNVh/KnCVrQ1spNuFO3MBsosiMLIezLC5wAM2Pot4VYzDYtw9fdp3J7vjvpIPvof5AbEnPXEjRKfRwpNwqrmeew9/66kh4MHW35crCWx9JSsIqdNzTLscNcXIIgvRBZlPNerlLrvEWj15+Syb97znWWy90N7BUOHLD8zl7YmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735388557; c=relaxed/simple;
	bh=O9LoU+tHjK1cDR81Ekg6fWLyut504a8wQWdZGV/RjBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rDM8CGm5bsEK7C0p6+PcZCqZl3xmSCwye8pj3UW0v+iwxa8pIex/L7cKTvaM+kulbC1hdwWv2puHBoPWQueFY56JRJu+gaUP/mXMFvaJKn42g4eYOsFAA2qdarsX4UXf+sF5ryKllV0w9Qc+QndJa13KSrkgzth48NAlbla8wOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=GLPxYNXE; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="GLPxYNXE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=rj31G
	oEVYZFTUM3sz1kl6VAgTM2nE4Qhup1sZsAcGqw=; b=GLPxYNXE1LAfeIhc4VVVk
	QpaZxPdrCgj625vtYJowhtkiHShka4V8YX8IJbeFjGjG7ZAJp+sko3t98/VY4Jsb
	KtPu4rCeWMiq3INi9q94vfDLgVzfSSGb2jvoXJBerKOgOavslEVnFGtHWp91RgCx
	5oEbzK+6B82wAGJ65gIrf8=
Received: from ProDesk.. (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3t0tl7W9nUxdCCQ--.1009S6;
	Sat, 28 Dec 2024 20:22:06 +0800 (CST)
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
Subject: [PATCH v2 4/8] dt-bindings: iommu: rockchip: Add Rockchip RK3576
Date: Sat, 28 Dec 2024 20:21:47 +0800
Message-ID: <20241228122155.646957-5-andyshrk@163.com>
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
X-CM-TRANSID:_____wD3t0tl7W9nUxdCCQ--.1009S6
X-Coremail-Antispam: 1Uf129KBjvdXoWrtw17Ww4xuF1rWw13GF15urg_yoWfurb_C3
	WxZw45ZF4rtFWFvw1qvrWxWrn8G3W2kFn5ZF98CFs5Ja4qvrWkJF95Gw1Fyr1UGw429FyS
	9Fn3WrW7XF9xGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU015l5UUUUU==
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqRPDXmdv5wS0uAADsD

From: Andy Yan <andy.yan@rock-chips.com>

Just like RK3588, RK3576 iommu is compatible to the existing rk3568.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---

(no changes since v1)

 Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml b/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
index 621dde0e45d8..6ce41d11ff5e 100644
--- a/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
+++ b/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
@@ -25,6 +25,7 @@ properties:
           - rockchip,rk3568-iommu
       - items:
           - enum:
+              - rockchip,rk3576-iommu
               - rockchip,rk3588-iommu
           - const: rockchip,rk3568-iommu
 
-- 
2.34.1

