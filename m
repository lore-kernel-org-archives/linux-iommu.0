Received: from bout3.ijzerbout.nl (bout3.ijzerbout.nl [136.144.140.114])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F201FBEA9
	for <iommu@lists.linux.dev>; Wed, 18 Dec 2024 20:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.140.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734552659; cv=none; b=Pm/XM/VEv3A0HaoxuTeO4qvccDW6DpyvRtMts50rkQLcNcJ+z3e4LoX5iENovDX/DI/Zdy0PYgopOMpGxvWiyBU7VOXRDP9Ch4r9sfEIBKkoaLlE/txJx6TekaMqqWi5TUJ+PdEHbYE2aaJjYKJ0s62VvhGOZpdoBjXtz4cZxCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734552659; c=relaxed/simple;
	bh=Ov/wxAiaAAERXrKseLXhMe4eegr6nqgJrnPd5yebYTs=;
	h=From:Date:Subject:To:Cc:Message-Id; b=Cy/BFI0WgcS51vt9V/jTLYxxDZ51ebvbsZU6fYaLTfdT/pyjvCbT2SAEpFOdn76jT2xIPEwVrj0xFdvC9RuQO8/45d/sn05UFJk4sP2YfLvFWrgLMcSsuZTrHvJe+O/ulrq1hXgWDQmz76/huhymy7jAlrr3hTYDSfx61tBpmww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl; spf=none smtp.mailfrom=bout3.ijzerbout.nl; dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b=Zo9JMc8J; arc=none smtp.client-ip=136.144.140.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bout3.ijzerbout.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b="Zo9JMc8J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ijzerbout.nl; s=key;
	t=1734552648; bh=Ov/wxAiaAAERXrKseLXhMe4eegr6nqgJrnPd5yebYTs=;
	h=From:Date:Subject:To:Cc:From;
	b=Zo9JMc8JGSBhXg+allbHKYMJah/OlQgqPdmszMR0E/b/ZFVR7Vo1ovuXJSTULpN84
	 yKY8Yfq7A9UEuIk0E2klBJdFoteiUdtLUKCi/9LE6gXmN/6BeUsFFG1lDK5OL7G6za
	 FvLlJl+c46FTivTyOl8vImpT8JCfO9qpRUVEsmJENy5HxMcXy0O1O5CT+1+T8WX2QB
	 PDRIuoSfi38Fhv0xNVMxwwfegMdYb7CIUaG8gsQ2UWRArQiU4Oe9+d5KOe/BhJDQTM
	 dze08V0ALtuqHWHHxJp3/msVlI7M8wJYfoVNSHtMEIEViFxqbjT9MdKVA1pQ7Y73wy
	 d5Owbzrc6bw320FGyYRxeXH8xdV6VFmFUdPk5sN8MC+qhNOgQRAlJSzKUIWmsASzr5
	 D6BKywSlvsXHbREBlvmHoam0RMNIzJ20+QRASVjLJicQha/9esmf8P3yoK4/LlAt6Z
	 XAXpHbvpss36njc+BmtrcYxfW/HepPetXPIXWJOC+UvSOq4gHw4WMiOFldLtgsh3eB
	 AYM+MScxRsvKz210aAVbvSBQEnmjeTiA0ZFoKPSgsijXXU8C03RSUyzusR4y6imi6Q
	 hrOJ0SJmMaf2Jvr3+nrGwkoULzHUZFkIfeys5ZoGkYft2D/YFNa3mA379gh140XL9h
	 J8W0SwUzeatz0Z+/6ag6Wm6c=
Received: by bout3.ijzerbout.nl (Postfix, from userid 1000)
	id E544818E57E; Wed, 18 Dec 2024 21:10:48 +0100 (CET)
From: Kees Bakker <kees@ijzerbout.nl>
Date: Fri, 15 Nov 2024 19:46:25 +0100
Subject: [PATCH v2] iommu/vt-d: Avoid use of NULL after WARN_ON_ONCE
To: Baolu Lu <baolu.lu@linux.intel.com>,
    iommu@lists.linux.dev,
    Tian Kevin <kevin.tian@intel.com>,
    Joerg Roedel <joro@8bytes.org>,
    Will Deacon <will@kernel.org>,
    Robin Murphy <robin.murphy@arm.com>
Cc: linux-kernel@vger.kernel.org
Message-Id: <20241218201048.E544818E57E@bout3.ijzerbout.nl>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

There is a WARN_ON_ONCE to catch an unlikely situation when
domain_remove_dev_pasid can't find the `pasid`. In case it nevertheless
happens we must avoid using a NULL pointer.

Signed-off-by: Kees Bakker <kees@ijzerbout.nl>
---
 v1 -> v2: change subject to use 'iommu/vt-d:' prefix

 drivers/iommu/intel/iommu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 82ee86d86a93..e933c84faf0b 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4089,13 +4089,14 @@ void domain_remove_dev_pasid(struct iommu_domain *domain,
 			break;
 		}
 	}
-	WARN_ON_ONCE(!dev_pasid);
 	spin_unlock_irqrestore(&dmar_domain->lock, flags);
 
 	cache_tag_unassign_domain(dmar_domain, dev, pasid);
 	domain_detach_iommu(dmar_domain, iommu);
-	intel_iommu_debugfs_remove_dev_pasid(dev_pasid);
-	kfree(dev_pasid);
+	if (!WARN_ON_ONCE(!dev_pasid)) {
+		intel_iommu_debugfs_remove_dev_pasid(dev_pasid);
+		kfree(dev_pasid);
+	}
 }
 
 static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
-- 
2.47.1

