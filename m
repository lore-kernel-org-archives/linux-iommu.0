From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v2 5/5] iommu: Allow default domain type to be set on the
	kernel command line
Date: Fri, 10 Mar 2017 20:49:36 +0000
Message-ID: <1489178976-15353-6-git-send-email-will.deacon@arm.com>
References: <1489178976-15353-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1489178976-15353-1-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The IOMMU core currently initialises the default domain for each group
to IOMMU_DOMAIN_DMA, under the assumption that devices will use
IOMMU-backed DMA ops by default. However, in some cases it is desirable
for the DMA ops to bypass the IOMMU for performance reasons, reserving
use of translation for subsystems such as VFIO that require it for
enforcing device isolation.

Rather than modify each IOMMU driver to provide different semantics for
DMA domains, instead we introduce a command line parameter that can be
used to change the type of the default domain. Passthrough can then be
specified using "iommu.passthrough=1" on the kernel command line.

Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  6 ++++++
 drivers/iommu/iommu.c                           | 17 +++++++++++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 986e44387dad..243895f6872e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1635,6 +1635,12 @@
 		nobypass	[PPC/POWERNV]
 			Disable IOMMU bypass, using IOMMU for PCI devices.
 
+	iommu.passthrough=
+			[ARM64] Configure DMA to bypass the IOMMU by default.
+			Format: { "0" | "1" }
+			0 - Use IOMMU translation for DMA.
+			1 - Bypass the IOMMU for DMA.
+			unset - Use IOMMU translation for DMA.
 
 	io7=		[HW] IO7 for Marvel based alpha systems
 			See comment before marvel_specify_io7 in
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 8ea14f41a979..42a842e3f95f 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -36,6 +36,7 @@
 
 static struct kset *iommu_group_kset;
 static DEFINE_IDA(iommu_group_ida);
+static unsigned int iommu_def_domain_type = IOMMU_DOMAIN_DMA;
 
 struct iommu_callback_data {
 	const struct iommu_ops *ops;
@@ -111,6 +112,18 @@ static int __iommu_attach_group(struct iommu_domain *domain,
 static void __iommu_detach_group(struct iommu_domain *domain,
 				 struct iommu_group *group);
 
+static int __init iommu_set_def_domain_type(char *str)
+{
+	bool pt;
+
+	if (!str || strtobool(str, &pt))
+		return -EINVAL;
+
+	iommu_def_domain_type = pt ? IOMMU_DOMAIN_IDENTITY : IOMMU_DOMAIN_DMA;
+	return 0;
+}
+early_param("iommu.passthrough", iommu_set_def_domain_type);
+
 static ssize_t iommu_group_attr_show(struct kobject *kobj,
 				     struct attribute *__attr, char *buf)
 {
@@ -1014,8 +1027,8 @@ struct iommu_group *iommu_group_get_for_dev(struct device *dev)
 	 * IOMMU driver.
 	 */
 	if (!group->default_domain) {
-		group->default_domain = __iommu_domain_alloc(dev->bus,
-							     IOMMU_DOMAIN_DMA);
+		group->default_domain =
+			__iommu_domain_alloc(dev->bus, iommu_def_domain_type);
 		if (!group->domain)
 			group->domain = group->default_domain;
 	}
-- 
2.1.4
