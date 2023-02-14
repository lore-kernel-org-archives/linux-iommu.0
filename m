Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A9D7E
	for <iommu@lists.linux.dev>; Tue, 14 Feb 2023 03:26:02 +0000 (UTC)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
	s=mail; t=1676345155;
	bh=p4L49mbChSxCQh+1gr3d/qeZBfH3UZf9pKaoK+b7mC0=;
	h=From:Date:Subject:To:Cc:From;
	b=mb/WwRgTL2QhEmlKMLH/u7+r0ezedOvfC4jlXmXwgmwcvhTdUBxkvwn8adUWVVK6T
	 U+OtIjsfhQTKsQm2jACTdTQHMyDgsT8m7BG53uhs+gEzub71sepOtmaYk7QiqTz5ax
	 EbSLc8MLxXuwzXe6Uy5LzuWJ+cpgDEyWJzgcXvQ0=
Date: Tue, 14 Feb 2023 03:25:53 +0000
Subject: [PATCH] iommu: make kobj_type structure constant
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230214-kobj_type-iommu-v1-1-e7392834b9d0@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAED/6mMC/x2NUQqDMBAFryL73UASldJepZSSmKduq4kktbSId
 +/i58xjeBsVZEaha7VRxocLpyhgThV1o4sDFAdhstrW2ppGvZJ/Pt6/RYY0z6u6AAFNHYw+tyS
 VdwXKZxe7Ubq4TpPIJaPn73Fzu+/7HxIrOax2AAAA
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676345153; l=991;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=p4L49mbChSxCQh+1gr3d/qeZBfH3UZf9pKaoK+b7mC0=;
 b=F2OI/YrWuEvRZ0lkOwWMT92t+p6WIJDy0d5wL95cCSpmLS0m3ZM+VI5h3SMG9TT7x5rOxfLhg
 TV3C6uBlrvQAtINdCaBQB5M/Ze90nUb4wHcrmAmSSpElFumXT545O8y
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
the driver core allows the usage of const struct kobj_type.

Take advantage of this to constify the structure definition to prevent
modification at runtime.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/iommu/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 5f6a85aea501..1dd4ec31301d 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -714,7 +714,7 @@ static void iommu_group_release(struct kobject *kobj)
 	kfree(group);
 }
 
-static struct kobj_type iommu_group_ktype = {
+static const struct kobj_type iommu_group_ktype = {
 	.sysfs_ops = &iommu_group_sysfs_ops,
 	.release = iommu_group_release,
 };

---
base-commit: f6feea56f66d34259c4222fa02e8171c4f2673d1
change-id: 20230214-kobj_type-iommu-9eede43d1075

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

