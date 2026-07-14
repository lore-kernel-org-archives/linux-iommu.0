Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33ADA37B3E4
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 02:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783996906; cv=none; b=ZI7JCiDuKs37NbafhQ1VCh7jrUk6n085/HKcqFAkFksScjSdSEEcWg6TgLcGDXqzsDD9E1GKY4QdedCu24O/SfsKHZOVXXAJlFAI2pLFKtuWUjkX4xwCN7KlqkEz7+HLO7+KOIR0w1NShGUSoB1tAaVyBUQvZal5yAL4Sha/10w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783996906; c=relaxed/simple;
	bh=u7/E3UNyvuFGqVXa1P/J00vJJ3m9pj1w6magumxlBxI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BHi7SfJPyJRn+wdfW34PczO5BgF2R/ryV/qDkWPm84XwtdKhS19WIP8DeqjPylS9To7YciqFKkYXeujGUHWuY/CnoQyF89bcC19G0SSScGU83vHaffHv4f+ppziIhb5RUkmzVIus2a+g0GY2GMuGzV9FmkWRVseOjyHk+Kv+IEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=SSxE2HlK; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="SSxE2HlK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Sp
	o3/rbAQkDTKNrJAvLcCB8wwOVzYb4MS3DAJlccfRc=; b=SSxE2HlK/8xtT0iNpI
	VVxmT6IwAz2eTf2pdBFPXikWv7iHsdNbmZeblN4DVIb/c4Gb2XX72fjruVuoOAlg
	j+DBD607MYcBtemS1siiSDoNziS7ycO9AwNhL8Lso0Ch3SVPRKUf1uQNQmy4ElIB
	/tDBpI7SbX2rmm1EGtlB6t2Q0=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3P6CpoVVqHiStJg--.9S2;
	Tue, 14 Jul 2026 10:40:42 +0800 (CST)
From: weimin xiong <15927021679@163.com>
To: iommu@lists.linux.dev
Cc: baolu.lu@linux.intel.com,
	dwmw2@infradead.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	xiongweimin <xiongweimin@kylinos.cn>
Subject: [PATCH] iommu/vt-d: fix spelling of guarantees in comment
Date: Tue, 14 Jul 2026 10:40:41 +0800
Message-ID: <20260714024041.186874-1-15927021679@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3P6CpoVVqHiStJg--.9S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JF4kWw1kCrWDAr43KrWkCrg_yoW3uwc_WF
	ZYvFn7Wrn0yFsYvF1jqr9xZFyqvayjgFZ7ua15KrWak3yUXr13WFWkZr45JFykWrs8CF9a
	yryYkr18AFW8WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8dHUDUUUUU==
X-CM-SenderInfo: jprvmjixqsilmxzbiqqrwthudrp/xtbC9AqCC2pVoaq1QAAA32

From: xiongweimin <xiongweimin@kylinos.cn>

Correct "guarentees" to "guarantees" in the hotplug notes.

Signed-off-by: xiongweimin <xiongweimin@kylinos.cn>
---
 drivers/iommu/intel/dmar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 767ec092a..3ecbd54d0 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -47,7 +47,7 @@ struct dmar_res_callback {
 
 /*
  * Assumptions:
- * 1) The hotplug framework guarentees that DMAR unit will be hot-added
+ * 1) The hotplug framework guarantees that DMAR unit will be hot-added
  *    before IO devices managed by that unit.
  * 2) The hotplug framework guarantees that DMAR unit will be hot-removed
  *    after IO devices managed by that unit.
-- 
2.43.0

