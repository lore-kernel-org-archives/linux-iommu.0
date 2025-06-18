Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9542EBBB3
	for <iommu@lists.linux.dev>; Wed, 18 Jun 2025 14:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750255781; cv=none; b=GmS7Yg5eh13dzIhyRTM44NWlkZHiXhqX4AGArn90NPLZuBn2faLZt0Pqu1ystyYk02Yw/IDSQc47YAqFrfAJYZdlnPgj3xCgJhchnllz8l62W1/KILuyyW5mwlXxh6V3C7t7zN+CzJrdMj+FOX5RetShPX4AaQWDiArmu1Z5+zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750255781; c=relaxed/simple;
	bh=keF4qtNzrgMOTjYFNPm6e0DVoWKRm4eaIoCysbWwg0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hd29lUtspq8P7fEAAFcpY/Bvk3MXXPpF4eUgK7yq2fuJPGNSddNE0t4JsPx5F4ecVrniGiNdG2cKiV7/5Suw8aBMw1IszFrXnRmU655nybE89VN9o/3B/V2GsWx9km5KvbCzxKXqpMeTmh9ChDOoCYW9jOZTRDPllN0o03Z5DxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=GOjyIbuK; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GOjyIbuK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1750255776;
	bh=keF4qtNzrgMOTjYFNPm6e0DVoWKRm4eaIoCysbWwg0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GOjyIbuKXih008ST9b1XsYdBxBz0K1uPl3kiY+oxxU6PHfh8w4xrLOCHpzxBkILTf
	 Nx+5e8gYQZDa6YkHn1z2dWmULH2JHeVtllgoM0/S+27EDnyIj6o8qILOhU0VnuSGx9
	 hyshYy4saA5/ak9Zcx5B7nCMIW7+hRf951YFEGCOAENenX4liiPl7hgTZPVmu5J4cK
	 ll6jDan2SwjZ0+3Qhs1X7Vur04fjIt0S9NY5yIu4vR+yh6XKbj2R5BtSeVw0do0xEV
	 FyDXIX8BeCFx9qymjJn4eW9j8QPxfuo9h8OZ7O08rUDlh6QXgDWHgwVYBQCjIO8CTm
	 ygQPL3A+Lyd7A==
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:45c6:994a:f902:5c74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BE43417E1580;
	Wed, 18 Jun 2025 16:09:35 +0200 (CEST)
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
Subject: [PATCH v2 5/5] arm64: defconfig: enable Verisilicon IOMMU
Date: Wed, 18 Jun 2025 16:09:14 +0200
Message-ID: <20250618140923.97693-6-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250618140923.97693-1-benjamin.gaignard@collabora.com>
References: <20250618140923.97693-1-benjamin.gaignard@collabora.com>
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
index 897fc686e6a9..ad1515f69b4f 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1451,6 +1451,7 @@ CONFIG_ARM_SMMU=y
 CONFIG_ARM_SMMU_V3=y
 CONFIG_MTK_IOMMU=y
 CONFIG_QCOM_IOMMU=y
+CONFIG_VSI_IOMMU=y
 CONFIG_REMOTEPROC=y
 CONFIG_IMX_REMOTEPROC=y
 CONFIG_MTK_SCP=m
-- 
2.43.0

