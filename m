From: Lianbo Jiang <lijiang@redhat.com>
Subject: [PATCH 4/5 V5] Adjust some permanent mappings in unencrypted ways for kdump when SME is enabled.
Date: Mon,  2 Jul 2018 15:26:38 +0800
Message-ID: <20180702072639.10110-5-lijiang@redhat.com>
References: <20180702072639.10110-1-lijiang@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180702072639.10110-1-lijiang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, ebiederm@xmission.com, joro@8bytes.org, thomas.lendacky@amd.com, dyoung@redhat.com, kexec@lists.infradead.org, iommu@lists.linux-foundation.org, bhe@redhat.com
List-Id: iommu@lists.linux-foundation.org

For kdump, the acpi table and dmi table will need to be remapped in
unencrypted ways during early init, they have just a simple wrapper
around early_memremap(), but the early_memremap() remaps the memory
in encrypted ways by default when SME is enabled, so we put some logic
into the early_memremap_pgprot_adjust(), which will have an opportunity
to adjust it.

Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
---
 arch/x86/mm/ioremap.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index e01e6c6..3c1c8c4 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -689,8 +689,17 @@ pgprot_t __init early_memremap_pgprot_adjust(resource_size_t phys_addr,
 	encrypted_prot = true;
 
 	if (sme_active()) {
+		/*
+		 * In kdump mode, the acpi table and dmi table will need to
+		 * be remapped in unencrypted ways during early init when
+		 * SME is enabled. They have just a simple wrapper around
+		 * early_memremap(), but the early_memremap() remaps the
+		 * memory in encrypted ways by default when SME is enabled,
+		 * so we must adjust it.
+		 */
 		if (early_memremap_is_setup_data(phys_addr, size) ||
-		    memremap_is_efi_data(phys_addr, size))
+		    memremap_is_efi_data(phys_addr, size) ||
+		    is_kdump_kernel())
 			encrypted_prot = false;
 	}
 
-- 
2.9.5
