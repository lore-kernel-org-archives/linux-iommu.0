From: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Subject: [PATCH] iommu: Add config option to set passthrough as default
Date: Fri, 20 Jul 2018 11:02:23 -0700
Message-ID: <20180720180223.29573-1-olof@lixom.net>
References: <20180711205936.18614-1-olof@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180711205936.18614-1-olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This allows the default behavior to be controlled by a kernel config
option instead of changing the commandline for the kernel to include
"iommu.passthrough=on" or "iommu=pt" on machines where this is desired.

Likewise, for machines where this config option is enabled, it can be
disabled at boot time with "iommu.passthrough=off" or "iommu=nopt".

Also corrected iommu=pt documentation for IA-64, since it has no code that
parses iommu= at all.

Signed-off-by: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
---

Chances since v1:
 - Added analogous behavior for Intel/AMD
 - Added iommu=nopt for x86 and updated docs

 Documentation/admin-guide/kernel-parameters.txt |  3 ++-
 arch/x86/kernel/pci-dma.c                       |  8 ++++++++
 drivers/iommu/Kconfig                           | 11 +++++++++++
 drivers/iommu/iommu.c                           |  4 ++++
 4 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index c9dbdf1009f1..4c822aa50f13 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1744,7 +1744,8 @@
 		merge
 		nomerge
 		soft
-		pt		[x86, IA-64]
+		pt		[x86]
+		nopt		[x86]
 		nobypass	[PPC/POWERNV]
 			Disable IOMMU bypass, using IOMMU for PCI devices.
 
diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
index ab5d9dd668d2..0acb135de7fb 100644
--- a/arch/x86/kernel/pci-dma.c
+++ b/arch/x86/kernel/pci-dma.c
@@ -40,8 +40,14 @@ int iommu_detected __read_mostly = 0;
  * devices and allow every device to access to whole physical memory. This is
  * useful if a user wants to use an IOMMU only for KVM device assignment to
  * guests and not for driver dma translation.
+ * It is also possible to disable by default in kernel config, and enable with
+ * iommu=nopt at boot time.
  */
+#ifdef CONFIG_IOMMU_DEFAULT_PASSTHROUGH
+int iommu_pass_through __read_mostly = 1;
+#else
 int iommu_pass_through __read_mostly;
+#endif
 
 extern struct iommu_table_entry __iommu_table[], __iommu_table_end[];
 
@@ -135,6 +141,8 @@ static __init int iommu_setup(char *p)
 #endif
 		if (!strncmp(p, "pt", 2))
 			iommu_pass_through = 1;
+		if (!strncmp(p, "nopt", 4))
+			iommu_pass_through = 0;
 
 		gart_parse_options(p);
 
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 568ae81b0e99..1813319c8342 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -70,6 +70,17 @@ config IOMMU_DEBUGFS
 	  debug/iommu directory, and then populate a subdirectory with
 	  entries as required.
 
+config IOMMU_DEFAULT_PASSTHROUGH
+	bool "IOMMU passthrough by default"
+	depends on IOMMU_API
+        help
+	  Enable passthrough by default, removing the need to pass in
+	  iommu.passthrough=on or iommu=pt through command line. If this
+	  is enabled, you can still disable with iommu.passthrough=off
+	  or iommu=nopt depending on the architecture.
+
+	  If unsure, say N here.
+
 config IOMMU_IOVA
 	tristate
 
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d227b864a109..6f8f59684def 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -36,7 +36,11 @@
 
 static struct kset *iommu_group_kset;
 static DEFINE_IDA(iommu_group_ida);
+#ifdef CONFIG_IOMMU_DEFAULT_PASSTHROUGH
+static unsigned int iommu_def_domain_type = IOMMU_DOMAIN_IDENTITY;
+#else
 static unsigned int iommu_def_domain_type = IOMMU_DOMAIN_DMA;
+#endif
 
 struct iommu_callback_data {
 	const struct iommu_ops *ops;
-- 
2.11.0
