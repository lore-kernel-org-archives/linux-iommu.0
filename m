Received: from outbound.baidu.com (mx16.baidu.com [111.202.115.101])
	by smtp.subspace.kernel.org (Postfix) with SMTP id AA65151E431
	for <iommu@lists.linux.dev>; Tue, 22 Sep 2026 09:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.115.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790067663; cv=none; b=caXkqEw8d+rHZyeyGfQyZ5hL+HYfOaLRUwzHuWfm7ss8kraNhcXVVuViTa821h0MeikERhUGIM2CRnoCIBJ0bx1lP058mfdeioLb2ejSL62JZXMAa+TlQ4PWnc9dcJoXGtrZaaKOl2bUHp7GQgk1dg+XTKZ10tifVdb+ajntUlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790067663; c=relaxed/simple;
	bh=WfnbxA312IgvcF2c2+N6gzfeww5EkajWbX9AxAcijbQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SluRyk3dO6qe5Mqg6eHUGspee61eBaqpjosd9bbxJgtNcHrQnxrbKo6mtZ4lZ0VoWD1Jp9/SpSHHzKLGfiRZelz9JWbtbZBBLrZQtvWxKSCR19GqnVF/2LvDr4bbunlPPoiFmpztmOd1vmnhG/XOSz+Cyk605LPKJE50XYYKkQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=n/VlQ/ua; arc=none smtp.client-ip=111.202.115.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="n/VlQ/ua"
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, Will
 Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] iommu/amd: Fix leak of data->entry in irq_remapping_alloc() error path
Date: Tue, 22 Sep 2026 17:00:35 +0800
Message-ID: <20260922090035.1724-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc14.internal.baidu.com (172.31.51.14) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1790067650;
	bh=y+EBRgXIXktsPfT8OlB4nZ+skHnzVC+esNilkjwc1S4=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=n/VlQ/ualqqBBUChOWW85h7pf88vkdVK1BDabbh5AMzkslFbzHnCJderRTn/nas4Z
	 oHATKbHrlKBQIYyak+wNhEdjP7ojvxn9muRt/PXwomrD+bZA81TavvGfIkgz2szQB1
	 x2SZDY4TSMsE5afpbSEDTvbl0sa77JR8+tGriW3fICs534jAHJPix/befT81GtqVWs
	 ZhOgL5a1DjdC7drjgmVl7/j+W7REqYoboBpCZMVkv9mGeWGOT2ndMPdkvHkxhLhZfY
	 3TWJk/1KYfL4S1U8EY7kpAzkvP2hBYp1SgOvmw1N21V6gooC8ps8UqF+AHL/KyMBuv
	 uviYvw1U6uV/Q==

From: Li RongQing <lirongqing@baidu.com>

In irq_remapping_alloc() each per-IRQ iteration allocates two objects:
the amd_ir_data (chip_data) and its data->entry (union irte / struct
irte_ga). The out_free_data error path only freed chip_data via
kfree(irq_data->chip_data), leaking data->entry for every already
initialized IRQ.

Free data->entry alongside data on the error path.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/iommu/amd/iommu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index fd27373..92e93d2 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3906,8 +3906,11 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
 out_free_data:
 	for (i--; i >= 0; i--) {
 		irq_data = irq_domain_get_irq_data(domain, virq + i);
-		if (irq_data)
-			kfree(irq_data->chip_data);
+		if (irq_data && irq_data->chip_data) {
+			data = irq_data->chip_data;
+			kfree(data->entry);
+			kfree(data);
+		}
 	}
 	for (i = 0; i < nr_irqs; i++)
 		free_irte(iommu, devid, index + i);
-- 
2.9.4

