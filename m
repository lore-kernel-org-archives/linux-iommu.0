Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4A6388E64
	for <iommu@lists.linux.dev>; Thu,  4 Jun 2026 13:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780581054; cv=none; b=m7xH1dKyMiwdO3sC8xu//qsKDgujKVJWky8qdfeni16yFOiIZ9lFUd2EUybYini45UpC+0yfzJGJVR7/TVs/jY/dfn9yJYGKtNnwomept6Pe51nEPPOmJJEbas0VfzjGEfLycnIvijOG+kGAEpsBua0h0FjknBXYBLUtUct/pnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780581054; c=relaxed/simple;
	bh=/jdjsxvL4aeTdyRjLTf+GIij/Stt3VATxC7ctZWpQBE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KXrD0fJIIB4OxhJswCyFCC2oRK3SKhPXitSYrr8A4EztqelRyOJv7SD+PauTVkp1PkmtVjgj8Sujk3AWlWaly/5CG7pNjcO1oKqnxuhOjxFg64SwCxkWq5UU2Ht8j3Gwn9fDzk1OTMPDrfWqIu2wNKe0bH8xMLJi/4wzf0/vbH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aRu6ZexF; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aRu6ZexF"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-395f24a5f2cso6635351fa.2
        for <iommu@lists.linux.dev>; Thu, 04 Jun 2026 06:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780581051; x=1781185851; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mLp8sJf8fzDOqqtj5uwx1QYbggbPxRQslMsoXQj9LcU=;
        b=aRu6ZexFj+pTqZnvon0iiqHRgGLoQBLo2SV6jGY+2/nf6gEvl5CZxtcF1m112mqTJz
         g1j0PSyggFyW5GF4sNLk9Tv4gQiVbt5jypCTzT2e3JLC2wWUzbgbiqffKnSbSKGAJnC0
         7Kr92aKnDVXFazLHWxKCywQ1u4Px6FsKJ2lRiSd8XLaFoJ1ulfEDWpdX1rhPgcXFhg6W
         m9USddfvBvuOkwtleRN+uxKWFGA4E2dFa+TiJG1UDEbjtCHx5S8FJ8mJTwL3onrB9UEN
         b4eWJZ3X4ILeOiyVn3w9QYrpNHDXXcGcmRh/LfVbHs+j2Blhs0dyPRyaLjyAyfPt5R1Y
         YUew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780581051; x=1781185851;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mLp8sJf8fzDOqqtj5uwx1QYbggbPxRQslMsoXQj9LcU=;
        b=oFfMNXqxVL3ze7NhRqIGX4ZeqXS0+8Yo5x8XnQJI+ve8ATk3rdg5YbG7lXMWH7/Q/c
         pfSWadBhZNsge03esJTRz9baITCppoLP2AWmweGPHRhqwsDb6c2SzWqdJ17Mj6hwogcC
         V4I1vRKdsPl+z7AuTcevTStAG8ZjeYRfIp0S84Iiq39dGdheq0Ka3wzuRN0XtPbw22EE
         myMfufTrZTItwdo4UFdBG43he3pbONSl7UZFUZG+DQ/IsHbIWH8lhoM47vienNcXbIa2
         zAgbhdztNH4NsSi8LF8fbX8UUdMR76CU8DqMOzCqg1gxCMqdzpsuUn8zgkysLkGLoZY/
         UWxA==
X-Gm-Message-State: AOJu0YwZz1VBj9wtgweXBsDNje+HYai6IERCXMD2YRzKNb/THfjuBb01
	7uQaYDvTZk+In4rh8PcoJsWEXsdaUyRMVhPZHvBXEI1TED+P3lvD3/BC
X-Gm-Gg: Acq92OEcP9BKnI8Wu0TKoYFaP2JNfoYLGf0PRnT8IH/Os9rErklaWXO1bogG7cmdEM1
	L48g8Ps8DQmt8zvyB3tUHQyt+A6s2Dyb8W0Ja1Q7Th4Q0YKPr3LUu5oTU68tXHZz/slaIxEeIv6
	GvZQsdE+/MmiimlLQiJFp6U2s+KTcN2oIiQucOiv299mn3LfHtDNivD4HEleXL7CfO1MdPh8KrM
	+oSsLspT7oLr7V++h/ckUppP3NaZ9Nl0QvS77ttpBaWex5L87exzAE+/K171Ndsl96QHHY09AVU
	8XBxmhTDGEBckdzCBAVOMa6nR5+k8jF813WyTGZODJWUGpsHydMYOkrcO+GRWAHAD00t+CdXoAW
	h8LYLAk3dJywFiNAZZhe90uktEMSMCyzNCggHgIz7jPsI4wxb+GGZTYXrlDWLwcJSPf3BV2rsyH
	EjepKcP4Lwq4kveojvzY2Ybo/abfFsTu/yDNo2CeO5+7fSFF+HTw==
X-Received: by 2002:a05:651c:2226:b0:38d:e220:8daa with SMTP id 38308e7fff4ca-396af063d37mr26758341fa.3.1780581050660;
        Thu, 04 Jun 2026 06:50:50 -0700 (PDT)
Received: from dschervov-lin.yandex.net ([2a02:6bf:8009:1404:e250:47f1:a6b5:92c5])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-396ac2e9a9esm16038051fa.36.2026.06.04.06.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 06:50:50 -0700 (PDT)
From: Dmitrii Chervov <fary.ru@gmail.com>
To: stable@vger.kernel.org
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com
Subject: [PATCH 6.12] iommu: Skip PASID validation for devices without PASID capability
Date: Thu,  4 Jun 2026 16:47:53 +0300
Message-ID: <20260604134753.57739-1-fary.ru@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tushar Dave <tdave@nvidia.com>

[ Upstream commit b3f6fcd8404f9f92262303369bb877ec5d188a81 ]

Generally PASID support requires ACS settings that usually create
single device groups, but there are some niche cases where we can get
multi-device groups and still have working PASID support. The primary
issue is that PCI switches are not required to treat PASID tagged TLPs
specially so appropriate ACS settings are required to route all TLPs to
the host bridge if PASID is going to work properly.

pci_enable_pasid() does check that each device that will use PASID has
the proper ACS settings to achieve this routing.

However, no-PASID devices can be combined with PASID capable devices
within the same topology using non-uniform ACS settings. In this case
the no-PASID devices may not have strict route to host ACS flags and
end up being grouped with the PASID devices.

This configuration fails to allow use of the PASID within the iommu
core code which wrongly checks if the no-PASID device supports PASID.

Fix this by ignoring no-PASID devices during the PASID validation. They
will never issue a PASID TLP anyhow so they can be ignored.

Fixes: c404f55c26fc ("iommu: Validate the PASID in iommu_attach_device_pasid()")
Cc: stable@vger.kernel.org
Signed-off-by: Tushar Dave <tdave@nvidia.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Link: https://lore.kernel.org/r/20250520011937.3230557-1-tdave@nvidia.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>

[ Refactored to apply cleanly without support attaching PASID to the blocked domain ]
Signed-off-by: Dmitrii Chervov <fary.ru@gmail.com>
---
My greeting to you LTS maintainers! This is my first kernel patch.
I did a manual backport because cherry-pick failed (6.12 LTS did not have
this series: https://lore.kernel.org/all/20241204122928.11987-1-yi.l.liu@intel.com/).
This patch is tremendously helpful for Nvidia Grace servers. Without it
their GPU direct technology did not work.

 kdrivers/iommu/iommu.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 0ad55649e2d0..62e1d6372503 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3341,9 +3341,11 @@ static int __iommu_set_group_pasid(struct iommu_domain *domain,
 	int ret;
 
 	for_each_group_device(group, device) {
-		ret = domain->ops->set_dev_pasid(domain, device->dev, pasid);
-		if (ret)
-			goto err_revert;
+		if (device->dev->iommu->max_pasids > 0) {
+			ret = domain->ops->set_dev_pasid(domain, device->dev, pasid);
+			if (ret)
+				goto err_revert;
+		}
 	}
 
 	return 0;
@@ -3355,7 +3357,8 @@ static int __iommu_set_group_pasid(struct iommu_domain *domain,
 
 		if (device == last_gdev)
 			break;
-		ops->remove_dev_pasid(device->dev, pasid, domain);
+		if (device->dev->iommu->max_pasids > 0)
+			ops->remove_dev_pasid(device->dev, pasid, domain);
 	}
 	return ret;
 }
@@ -3368,8 +3371,10 @@ static void __iommu_remove_group_pasid(struct iommu_group *group,
 	const struct iommu_ops *ops;
 
 	for_each_group_device(group, device) {
-		ops = dev_iommu_ops(device->dev);
-		ops->remove_dev_pasid(device->dev, pasid, domain);
+		if (device->dev->iommu->max_pasids > 0) {
+			ops = dev_iommu_ops(device->dev);
+			ops->remove_dev_pasid(device->dev, pasid, domain);
+		}
 	}
 }
 
@@ -3403,7 +3408,13 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 
 	mutex_lock(&group->mutex);
 	for_each_group_device(group, device) {
-		if (pasid >= device->dev->iommu->max_pasids) {
+		/*
+		 * Skip PASID validation for devices without PASID support
+		 * (max_pasids = 0). These devices cannot issue transactions
+		 * with PASID, so they don't affect group's PASID usage.
+		 */
+		if ((device->dev->iommu->max_pasids > 0) &&
+		    (pasid >= device->dev->iommu->max_pasids)) {
 			ret = -EINVAL;
 			goto out_unlock;
 		}
-- 
2.43.0

