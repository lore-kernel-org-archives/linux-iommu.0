Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F7B2FF659
	for <iommu@lists.linux.dev>; Mon, 25 Aug 2025 15:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756136104; cv=none; b=n+YUfvdTimElU2rwnzMFjWFC64Nq+i12pFq+HGAfIn8HJPKY4AZo8uGNj0kI3mw7iUPJmWVz+1BOGdYV19TbdGvfljQkm+lu9H2UzygZiX9Vo5KfHJh0ILQaCYqTMaUs7u/S+E1Ij6L3SwuAmmottrILxbgWRWLYd8WcwD2xkoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756136104; c=relaxed/simple;
	bh=VZpxXp1Jtzbp9ZUOGZItTruBz4DIlQiezPNirCtZH9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m08FgINXHN+UoxLOYtclikij59YFIvqLMkR9sGWWRjXXEbLMGunBlRF9hi62nuMkUitbYGa+QZtCrcXjJhTnNGXk5b3uXQ1fT2swLCdoSVXaqBoKfIbizjJATQT+Xl1mIrKhwLoC15WO3eE3zyKGnxBrpTbIXokIayaPaIFnPBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=j/08ylrY; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="j/08ylrY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756136100;
	bh=VZpxXp1Jtzbp9ZUOGZItTruBz4DIlQiezPNirCtZH9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j/08ylrY+Db2hGxduhX/mwuJ5EBmKAmUt0Q49EXbG7FDU+NOcfyxrCVEpQYhh5D/C
	 Ho6+3mamprwWtZXSR01Rns/vw0UB10PC4l1LPBL1ZFZ7d08p2985ZvRdDu+iqD5aWI
	 uxNZN4puOsukeSzwx+te86y6/BRmc23Q9/lx644Wod5/yiurkRcsyfpt8twggNa9vf
	 90Jhv1X1AJpJlnkQ01M19wBLKuc7xKaB0tWjG6a29C7pgOuCXPsm5MtX+8YsJU0bKB
	 xWNuEi8FUSkdIOgVL/1/Umdq9nnIvAg0UzPdwBiW+W2vKE9HH+58KIU8FCjWmsX6xi
	 an4zfzCyerTjw==
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:f39:d9a9:8ef1:f69a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9260F17E0A28;
	Mon, 25 Aug 2025 17:34:59 +0200 (CEST)
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	nicolas.dufresne@collabora.com,
	jgg@ziepe.ca,
	p.zabel@pengutronix.de,
	mchehab@kernel.org
Cc: iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	kernel@collabora.com,
	linux-media@vger.kernel.org,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v7 6/6] arm64: defconfig: enable Verisilicon IOMMU
Date: Mon, 25 Aug 2025 17:34:45 +0200
Message-ID: <20250825153450.150071-7-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250825153450.150071-1-benjamin.gaignard@collabora.com>
References: <20250825153450.150071-1-benjamin.gaignard@collabora.com>
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
index 58f87d09366c..04547bcc904b 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1470,6 +1470,7 @@ CONFIG_ARM_SMMU=y
 CONFIG_ARM_SMMU_V3=y
 CONFIG_MTK_IOMMU=y
 CONFIG_QCOM_IOMMU=y
+CONFIG_VSI_IOMMU=m
 CONFIG_REMOTEPROC=y
 CONFIG_IMX_REMOTEPROC=y
 CONFIG_MTK_SCP=m
-- 
2.43.0

