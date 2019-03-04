From: James Sewart <jamessewart@arista.com>
Subject: [PATCH 1/4] iommu: Move iommu_group_create_direct_mappings to after
 device_attach
Date: Mon, 4 Mar 2019 15:45:07 +0000
Message-ID: <17CE1B8C-9E81-4954-8D23-5B2F20A3104F@arista.com>
References: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: Tom Murphy <tmurphy@arista.com>, Dmitry Safonov <dima@arista.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

If an IOMMU driver requires to know which IOMMU a domain is associated
to initialise a domain then it will do so in device_attach, before which
it is not safe to call iommu_ops.

Signed-off-by: James Sewart <jamessewart@arista.com>
---
 drivers/iommu/iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3ed4db334341..1c6ffbb2d20e 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -652,8 +652,6 @@ int iommu_group_add_device(struct iommu_group =
*group, struct device *dev)
=20
 	dev->iommu_group =3D group;
=20
-	iommu_group_create_direct_mappings(group, dev);
-
 	mutex_lock(&group->mutex);
 	list_add_tail(&device->list, &group->devices);
 	if (group->domain)
@@ -662,6 +660,8 @@ int iommu_group_add_device(struct iommu_group =
*group, struct device *dev)
 	if (ret)
 		goto err_put_group;
=20
+	iommu_group_create_direct_mappings(group, dev);
+
 	/* Notify any listeners about change to group. */
 	blocking_notifier_call_chain(&group->notifier,
 				     IOMMU_GROUP_NOTIFY_ADD_DEVICE, =
dev);
--=20
2.17.1
