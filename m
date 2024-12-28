Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632C7C8DF
	for <iommu@lists.linux.dev>; Sat, 28 Dec 2024 12:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735388560; cv=none; b=AI+cFfYo7rWzkph10g7D+17zbM+PfFBc9C8ij9gaJVEny81BVO5Us4JGJc0QjfUG3vv0bak9mKB2+4BvLA8JWse7lxQGtymy1TZ9qxmyzTPx5wT/nPxHvGm/stJf8KWRn00oC335DobeVsZvidahOlyqYRhgBBzLLwaWvTX96zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735388560; c=relaxed/simple;
	bh=FmNuaD6MaJEQxkXYNvGq0aPFPQ1l8v6R0pJkcKmSMSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FKfzM0PNlDumbTCbMunR+EaS4msY9+ch0HEcOQ610hQxAFDTy79Uv2OqgyvybcYIPeRgncz0xVirhQU2nWmvdin91RZJpqw26JM5yUuxPGX5gg1QD6WVYARBnAui/ntiA18rqfNsq+R3Ni48EFvRr+wmtiajj1+MTnEXSIOTFqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=kbv58woR; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kbv58woR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=FmSpJ
	+e209IgLZ68tXXKsnh3RVerdeFHGl/h+V8EMEE=; b=kbv58woRhslEWE41zJD4/
	DaaK000dFmsxacFSBISixE1I7kMoZgD9wO/T3qgPYtiyWORbhDqO1whKNILB/TtR
	nVN6tiaJeRlEftaA92cvcSJrMVl+qnXoSInAvkC/iS9Vtp926VxAJwOLbg3/sR4o
	MrItHXwFEgFKBAEN4+2PsE=
Received: from ProDesk.. (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3t0tl7W9nUxdCCQ--.1009S3;
	Sat, 28 Dec 2024 20:22:03 +0800 (CST)
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
Subject: [PATCH v2 1/8] dt-bindings: soc: rockchip: add rk3576 hdptxphy grf syscon
Date: Sat, 28 Dec 2024 20:21:44 +0800
Message-ID: <20241228122155.646957-2-andyshrk@163.com>
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
X-CM-TRANSID:_____wD3t0tl7W9nUxdCCQ--.1009S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gr15tF4DZFy3CF48tF4kXrb_yoWfXFbEka
	4xZ3WUZFs5tr1Fqw1DAa4IkFn8Aas7KrykCF4UAF48CayqkFWkKF95Jw1akr18W3WI9Fyf
	ua1vqrWUGanxJjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU00JPtUUUUU==
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqRPDXmdv5wS0uAAAsA

From: Andy Yan <andy.yan@rock-chips.com>

Add hdptxphy grf syscon compatibles for rk3576.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

---

(no changes since v1)

 Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
index 7eca9e1ad6a3..61f38b68a4a3 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
@@ -23,6 +23,7 @@ properties:
               - rockchip,rk3576-bigcore-grf
               - rockchip,rk3576-cci-grf
               - rockchip,rk3576-gpu-grf
+              - rockchip,rk3576-hdptxphy-grf
               - rockchip,rk3576-litcore-grf
               - rockchip,rk3576-npu-grf
               - rockchip,rk3576-php-grf
-- 
2.34.1

