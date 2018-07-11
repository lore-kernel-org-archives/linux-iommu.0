From: Olof Johansson <olof@lixom.net>
Subject: [PATCH 2/2] iommu: add sysfs attribyte for domain type
Date: Wed, 11 Jul 2018 13:59:36 -0700
Message-ID: <20180711205936.18614-2-olof@lixom.net>
References: <20180711205936.18614-1-olof@lixom.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180711205936.18614-1-olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>
List-Id: iommu@lists.linux-foundation.org

While we could print it at setup time, this is an easier way to match
each device to their default IOMMU allocation type.

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 drivers/iommu/iommu.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index ab8fc54467e0..53164107620c 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -298,11 +298,39 @@ static ssize_t iommu_group_show_resv_regions(struct iommu_group *group,
 	return (str - buf);
 }
 
+static ssize_t iommu_group_show_type(struct iommu_group *group,
+				     char *buf)
+{
+	char *type = "unknown\n";
+
+	if (group->default_domain) {
+		switch (group->default_domain->type) {
+		case IOMMU_DOMAIN_BLOCKED:
+			type = "blocked\n";
+			break;
+		case IOMMU_DOMAIN_IDENTITY:
+			type = "identity\n";
+			break;
+		case IOMMU_DOMAIN_UNMANAGED:
+			type = "unmanaged\n";
+			break;
+		case IOMMU_DOMAIN_DMA:
+			type = "DMA";
+			break;
+		}
+	}
+	strcpy(buf, type);
+
+	return strlen(type);
+}
+
 static IOMMU_GROUP_ATTR(name, S_IRUGO, iommu_group_show_name, NULL);
 
 static IOMMU_GROUP_ATTR(reserved_regions, 0444,
 			iommu_group_show_resv_regions, NULL);
 
+static IOMMU_GROUP_ATTR(type, 0444, iommu_group_show_type, NULL);
+
 static void iommu_group_release(struct kobject *kobj)
 {
 	struct iommu_group *group = to_iommu_group(kobj);
@@ -384,6 +412,10 @@ struct iommu_group *iommu_group_alloc(void)
 	if (ret)
 		return ERR_PTR(ret);
 
+	ret = iommu_group_create_file(group, &iommu_group_attr_type);
+	if (ret)
+		return ERR_PTR(ret);
+
 	pr_debug("Allocated group %d\n", group->id);
 
 	return group;
-- 
2.11.0
