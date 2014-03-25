From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH] iommu/vt-d: Check for NULL pointer in
	dmar_acpi_dev_scope_init() array
Date: Tue, 25 Mar 2014 20:30:15 +0100
Message-ID: <20140325193015.GI13491@8bytes.org>
References: <1395422354-19762-1-git-send-email-David.Woodhouse@intel.com>
	<1395422354-19762-6-git-send-email-David.Woodhouse@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1395422354-19762-6-git-send-email-David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi David,

On Fri, Mar 21, 2014 at 05:18:46PM +0000, David Woodhouse wrote:
> +static int __init dmar_acpi_dev_scope_init(void)
> +{
> +	struct acpi_dmar_andd *andd = (void *)dmar_tbl + sizeof(struct acpi_table_dmar);
> +
> +	while (((unsigned long)andd) <
> +	       ((unsigned long)dmar_tbl) + dmar_tbl->length) {

This is causing a kernel crash on AMD IOMMU systems. I will queue
attached patch on the x86/vt-d to fix the issue. A better solution would
be to not call ir_dev_scope_init() by a rootfs-initcall, but this is
more complicated and better not done that close to the merge-window.
Do you have objections?


	Joerg

>From 0e1ad789087ea3b142ee4a169662db0ec77425ff Mon Sep 17 00:00:00 2001
From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Date: Tue, 25 Mar 2014 20:16:40 +0100
Subject: [PATCH] iommu/vt-d: Check for NULL pointer in dmar_acpi_dev_scope_init()

When ir_dev_scope_init() is called via a rootfs initcall it
will check for irq_remapping_enabled before it calls
(indirectly) into dmar_acpi_dev_scope_init() which uses the
dmar_tbl pointer without any checks.

The AMD IOMMU driver also sets the irq_remapping_enabled
flag which causes the dmar_acpi_dev_scope_init() function to
be called on systems with AMD IOMMU hardware too, causing a
boot-time kernel crash.

Signed-off-by: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
---
 drivers/iommu/dmar.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 56e1c79..e531a2b 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -657,7 +657,12 @@ static void __init dmar_acpi_insert_dev_scope(u8 device_number,
 
 static int __init dmar_acpi_dev_scope_init(void)
 {
-	struct acpi_dmar_andd *andd = (void *)dmar_tbl + sizeof(struct acpi_table_dmar);
+	struct acpi_dmar_andd *andd;
+
+	if (dmar_tbl == NULL)
+		return -ENODEV;
+
+	andd = (void *)dmar_tbl + sizeof(struct acpi_table_dmar);
 
 	while (((unsigned long)andd) <
 	       ((unsigned long)dmar_tbl) + dmar_tbl->length) {
-- 
1.7.9.5
