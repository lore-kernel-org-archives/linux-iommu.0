Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A3E23CE
	for <iommu@lists.linux.dev>; Tue, 31 Dec 2024 09:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735637544; cv=none; b=CSi2EVeFH83jA3bB+AaiHA40jidZ2rZ21I/tVFCKHEf+BgMZCq+F4gVYkTmzpF+67xO5uGzAu4I9UcsklIqhOiYDiZoUG44y8AFRV/DjA+7J9zLnhG8vKIRFp0C4E+/iMTkxtsReV7GOH4o4Hnz7GGC4LzJGq6eliTpSF5g2aEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735637544; c=relaxed/simple;
	bh=SefbSpWQMhmWbFhTp7LsyjTAVJhDaW25OIX5ECCCxtE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NJfWwx3+ldI+MfXKb20Sy5erHnuA3+bL04Ll4hcRytgmQKsUB9kHzqnUQ7+RLrk9pKhWZ8P+JbbH/WsDVOvuq7YuOFSNoyLv7JSO5xCBRy/g0e1tsR6arDttSvy24Zt+g/5GN12gpSSwQatrmlQfe0Ofu6+ncODT0ySnen67W4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jDRhSSkx; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jDRhSSkx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=gAzC/
	E/F7q/7HFvoRLgpsRSdEdWdl1u9Ms//kuDq2hg=; b=jDRhSSkxqwLJqKUdO1aaW
	F2Ha5TSL4HZSmDvqSh56vNz+ifMFrCHmMwi4nnLetoGB/8qGpuEuGOEMPdMDQ7yR
	erTouyT4rNVc3J0PV+itsShs1DG6LxEi5qen0SzF5Zhbd5zbM1YQoPbvwMTM4Y5d
	uJGrbf32sxWm4ByDyxRqPM=
Received: from ProDesk.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD31yQLunNn0QGeCw--.9208S2;
	Tue, 31 Dec 2024 17:31:59 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: joro@8bytes.org
Cc: heiko@sntech.de,
	krzk+dt@kernel.org,
	robh@kernel.org,
	devicetree@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [RESEND PATCH] dt-bindings: iommu: rockchip: Add Rockchip RK3576
Date: Tue, 31 Dec 2024 17:31:50 +0800
Message-ID: <20241231093154.252595-1-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD31yQLunNn0QGeCw--.9208S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtw1xZFW3uF47Kw4kGw1rWFg_yoWfCFb_C3
	WxZw4UZF4rtrWFvw1qvrWxWrn8G3W2kFn5ZFn8CFn5Ja4qvrWkJF95Jw1Yyr1UGr47uFyS
	9Fn3Wry7XF9xGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbD73PUUUUU==
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbB0h7GXmdzt4U2PQABs4

From: Andy Yan <andy.yan@rock-chips.com>

Just like RK3588, RK3576 is compatible to the existing rk3568
binding.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---

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

