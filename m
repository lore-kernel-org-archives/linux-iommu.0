From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [PATCH 2/2] x86/kvmclock: set_memory_decrypted() takes number of pages
Date: Tue, 22 Jan 2019 19:17:58 -0200
Message-ID: <20190122211758.8317-2-bauerman@linux.ibm.com>
References: <20190122211758.8317-1-bauerman@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190122211758.8317-1-bauerman@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: x86@kernel.org
Cc: kvm@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Tom Lendacky <thomas.lendacky@amd.com>, Ram Pai <linuxram@us.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>
List-Id: iommu@lists.linux-foundation.org

From: Ram Pai <linuxram@us.ibm.com>

set_memory_decrypted() expects the number of PAGE_SIZE pages to decrypt.
kvmclock_init_mem() instead passes number of bytes. This decrypts a huge
number of pages resulting in data corruption.

Fixed it.

[ bauermann: Slightly reworded commit message and added Fixes: tag. ]
Fixes: 6a1cac56f41f ("x86/kvm: Use __bss_decrypted attribute in shared variables")
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 arch/x86/kernel/kvmclock.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Note: Found by code inspection. I don't have a way to test.

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index e811d4d1c824..b5c867dd2c8d 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -251,8 +251,7 @@ static void __init kvmclock_init_mem(void)
 	 * be mapped decrypted.
 	 */
 	if (sev_active()) {
-		r = set_memory_decrypted((unsigned long) hvclock_mem,
-					 1UL << order);
+		r = set_memory_decrypted((unsigned long) hvclock_mem, 1);
 		if (r) {
 			__free_pages(p, order);
 			hvclock_mem = NULL;
