From: Glenn Serre <gserre-43mecJUBy8ZBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v2 1/2] arch/x86: Add CONFIG_IOMMU_DEFAULT_PT for iommu=pt
Date: Mon, 17 Oct 2016 11:13:19 -0700
Message-ID: <f3608ce9-af12-9ac8-7503-1ccd45983ee7@brocade.com>
References: <2ebef311-b346-f3ed-2fca-ce4715b84c9d@brocade.com>
	<6b2c6f0b-cce8-b8f6-37c2-d4cc453bd603@brocade.com>
	<20161004165232.GD2428@localhost.localdomain>
	<04ab568e-8088-cf23-facb-7ef3fecf4bb6@brocade.com>
	<20161004170358.GE2428@localhost.localdomain>
	<ad5f24df-99e3-d9c7-4ca3-ba3de820da8e@brocade.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <ad5f24df-99e3-d9c7-4ca3-ba3de820da8e-43mecJUBy8ZBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Add CONFIG_IOMMU_DEFAULT_PT for iommu=pt

Allow default to iommu=pt without adding to command line.
Add iommu=nopt to turn off default.

The reason we use iommu=pt is to support using the DPDK igb_uio driver,
which we need to do on servers that have an iommu but lack ACS.

Signed-off-by: Glenn Serre <gserre-43mecJUBy8ZBDgjK7y7TUQ@public.gmane.org>
---
  Documentation/kernel-parameters.txt | 3 ++-
  arch/x86/Kconfig                    | 7 +++++++
  arch/x86/kernel/pci-dma.c           | 6 ++++++
  3 files changed, 15 insertions(+), 1 deletion(-)

--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1748,6 +1748,7 @@
  		forcesac
  		soft
  		pt		[x86, IA-64]
+		nopt		[x86]
  		nobypass	[PPC/POWERNV]
  			Disable IOMMU bypass, using IOMMU for PCI devices.

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -882,6 +882,13 @@
  	def_bool y
  	depends on CALGARY_IOMMU || GART_IOMMU || SWIOTLB || AMD_IOMMU

+config IOMMU_DEFAULT_PT
+	def_bool n
+	prompt "Set iommu=pt by default"
+	help
+	  Selecting this option will set iommu passthrough (iommu=pt)
+	  by default.  Use iommu=nopt to override.
+
  config MAXSMP
  	bool "Enable Maximum number of SMP Processors and NUMA Nodes"
  	depends on X86_64 && SMP && DEBUG_KERNEL
--- a/arch/x86/kernel/pci-dma.c
+++ b/arch/x86/kernel/pci-dma.c
@@ -43,7 +43,7 @@
   * useful if a user wants to use an IOMMU only for KVM device assignment to
   * guests and not for driver dma translation.
   */
-int iommu_pass_through __read_mostly;
+int iommu_pass_through __read_mostly = IS_ENABLED(CONFIG_IOMMU_DEFAULT_PT);

  extern struct iommu_table_entry __iommu_table[], __iommu_table_end[];

@@ -196,6 +196,8 @@
  #endif
  		if (!strncmp(p, "pt", 2))
  			iommu_pass_through = 1;
+		if (!strncmp(p, "nopt", 4))
+			iommu_pass_through = 0;

  		gart_parse_options(p);
