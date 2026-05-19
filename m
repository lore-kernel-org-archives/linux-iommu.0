Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610883BCD15;
	Tue, 19 May 2026 20:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779223024; cv=none; b=SRCDyCDz+7ZEOx7Che6UJjjjuBP4+nAUFjcGw+Le0tTRmTHBeHXz7cNXDjesejJ1nYeewBlWHh670AYqAVeq8ehUzvt/32BOjYyWG9tp8TTHOOYByz7LKJDZiTD/ujHN6OkxoocG1IrxbuXyQsBOdcKuLcyVPtaVDfigeMKa2nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779223024; c=relaxed/simple;
	bh=qZJTgKVtNi/+QdikBfpBlq5LVYUeOItBCQ6IBhpwd9M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q+PP29OJ66eV+YcNBTtH0cIBBzuwvlUU5QEpC23wXdI4XAosF2pkn+mAu2/a71VsCWkg2WErdxMxCCFc4gC+kpzqQHtcKwrVUsBJmC+7JGDUBU+6ovC+p7RhepojYgqGHau9tKmoeicXk0rkbImehsi2luDX7leBzW9/E7ON2fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8uoHQNt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8uoHQNt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B3C91F000E9;
	Tue, 19 May 2026 20:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779223023;
	bh=ClyVU23OpRSvt4yjlOrmDjqwTZ/gmwEQquXeHmKVDS0=;
	h=From:To:Cc:Subject:Date;
	b=Y8uoHQNtBWm6HuiQbHXHQyrzVSDsHGLd8FPZUW4olGNaKEWSrL+EheDxXr0iedF8i
	 XOIAJAkb4yte7qooEbaSWyPTuFxYwiWqYmLgO/TZr60tpYi/CE1b8SSi20MvNYQ7BR
	 A1ZyiS5crkHwG93IaXFSMa4XVF4eVx4P0umsgOLpn5zMKu1boRm5qs9O/FVBN9ABbR
	 nOTx04bJl8pC8vhjomrg3CYcQnIxvOFRFFF5UP7xasT88i3Rtg45fgBz7vUowzJuaN
	 KorKxyG/WalPsICnoUtaSJnOcMxjFikdGfCeJCb2Fg11mPo+cJvuNXkC6d5hz4K5r5
	 /dQmgp9sgYCRw==
From: Arnd Bergmann <arnd@kernel.org>
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommu: vsi: avoid -Wformat-security warning
Date: Tue, 19 May 2026 22:36:51 +0200
Message-Id: <20260519203658.1341889-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

When -Wformat-security is enabled, it catches a call to
iommu_device_sysfs_add() that passes a string variable in
place of a format:

drivers/iommu/vsi-iommu.c: In function 'vsi_iommu_probe':
drivers/iommu/vsi-iommu.c:717:9: error: format not a string literal and no format arguments [-Werror=format-security]
  717 |         err = iommu_device_sysfs_add(&iommu->iommu, dev, NULL, dev_name(dev));
      |         ^~~

Pass this indirectly using "%s" as the format instead.

Fixes: 917ace84b770 ("iommu: Add verisilicon IOMMU driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/iommu/vsi-iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/vsi-iommu.c b/drivers/iommu/vsi-iommu.c
index 5d0721bd2c7a..23913720d484 100644
--- a/drivers/iommu/vsi-iommu.c
+++ b/drivers/iommu/vsi-iommu.c
@@ -714,7 +714,8 @@ static int vsi_iommu_probe(struct platform_device *pdev)
 	pm_runtime_use_autosuspend(dev);
 	pm_runtime_enable(dev);
 
-	err = iommu_device_sysfs_add(&iommu->iommu, dev, NULL, dev_name(dev));
+	err = iommu_device_sysfs_add(&iommu->iommu, dev, NULL, "%s",
+				     dev_name(dev));
 	if (err)
 		goto err_runtime_disable;
 
-- 
2.39.5

