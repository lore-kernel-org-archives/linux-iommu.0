Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A03429A30E
	for <iommu@lists.linux.dev>; Mon, 23 Jun 2025 15:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750693185; cv=none; b=kVc+T8egTutZyhZQ7WKyOR4w4eBbxRrCbohRyd+0qFh6rmmc7KxNa25/7IpXKV8NhVbdpuzpilJJLsqGBBZuMnOPpsBWaHmT6vH+GuQJwjJOQAjIzn+b/QdgKPceYEjKmzfKaQN/IJt5Vv1jYUcEBBOASv2pEQMCt0oBSAvZy24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750693185; c=relaxed/simple;
	bh=4bDNVFCV1Re2zfChjnEdtk38UjbrX0DDqSN/Fh1aO6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C6xwHoNMagbqGfvJEp1CqQLMChJ60ye2fIjj3duu2l+hr+TRas8qdYPrkKuz9n4n7tbZIq36WftRCm0CqaYu+wwXGUpJ0bwoPU85At09MxIz+BblnQqpgTgaa87fm17foDWanaQj3+zN6qyexSkLJ8fmST265h3o39HkWqLZV9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=pQUPwO3h; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pQUPwO3h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1750693180;
	bh=4bDNVFCV1Re2zfChjnEdtk38UjbrX0DDqSN/Fh1aO6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pQUPwO3h6u5ZEtSj+b5wGM9tiwlaUtD+Yam0kFhTNsaW44MuIvKdLbV7DfbX5wMao
	 zrcliNYkCe3hDalEgve12860WSP04Hlz1/WkNVlciFBRuSJEk7SClOFLOQayY9PqYp
	 /LyDFZulUB8Gm2eZt0Txi49yOVRBZwC3L/myNFfvzLQkrtk4W7mwWh2sCL2oGkxuc1
	 IJsWLbA8ia4WY4ZRfLE7D/1uOoPf/Eb591EHspqmXbX5C8q60JH+P1JFLF7YbwtYZi
	 iviFOiNs4RqwK1g0JWQotQSGzRDVdqU2MOvl0PZpSk1hLCk5m2wc6S1aSSXA5tadiS
	 mdMKUcc5EawsA==
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:d44b:b63b:15ee:9c1d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8A43917E159C;
	Mon, 23 Jun 2025 17:39:39 +0200 (CEST)
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	nicolas.dufresne@collabora.com,
	jgg@ziepe.ca
Cc: iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	kernel@collabora.com,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v4 5/5] arm64: defconfig: enable Verisilicon IOMMU
Date: Mon, 23 Jun 2025 17:39:29 +0200
Message-ID: <20250623153931.158765-6-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250623153931.158765-1-benjamin.gaignard@collabora.com>
References: <20250623153931.158765-1-benjamin.gaignard@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable Verisilicon IOMMU used by RK3588 AV1 hardware codec.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 897fc686e6a9..a5122990ecfa 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1451,6 +1451,7 @@ CONFIG_ARM_SMMU=y
 CONFIG_ARM_SMMU_V3=y
 CONFIG_MTK_IOMMU=y
 CONFIG_QCOM_IOMMU=y
+CONFIG_VSI_IOMMU=m
 CONFIG_REMOTEPROC=y
 CONFIG_IMX_REMOTEPROC=y
 CONFIG_MTK_SCP=m
-- 
2.43.0

