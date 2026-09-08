Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EFA4A8FC7;
	Tue,  8 Sep 2026 11:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788867174; cv=none; b=op0ygWinlPmsBwohn90lqKf5lZzugPIPSz8TZRozA5ftadMYrHlfUrEiGhIf2ydna08tzATsyeNmgMEMEETZu8ix/Ntpw8C9opFjZzEjjZT3SN9sJ6djbW46XEUge2SRiVgxm9v7+iGQYBMZbJWccsH67LhsOKq6hT1tpnlqOSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788867174; c=relaxed/simple;
	bh=35hgWuDFJJqbTBxmJnJ57l3+9GRQQ6qZ4Rul2TtgEiA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J/mqQCC2oEnEBl26SvO31EB1CwTQxONVzBnTfiClIJ/h+bEzJ0QGoHvJQLKLMnvcffUj+nMpeQHblpdulAdq/K8EBSA2/D1Z5QXN7M0KX4PG8zWs5Nfg0siMv30DAw8SDrYGojUlCkxafyw//7yJmp120cZz6I7nJf8CHPXECYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iVyJU94Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iVyJU94Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 029B61F00A3A;
	Tue,  8 Sep 2026 11:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788867163;
	bh=T3bfuKnIDLKBYWubE5n0qpIfcywQnWZyol1/WTQ0KNU=;
	h=From:To:Cc:Subject:Date;
	b=iVyJU94ZTzqH5cP7b+nkZZ60NPVtcggewHM3kTKwES92MMlEVdjTJmxSG8FR2YxkO
	 MMz1ZskncIhd9nSNGlCpnM3su7xV1PUNwcDGzmR4s9tNAYQCwnAEx8+QYVwnFhop1y
	 tAdIq+5xvsujlM5nMyiQyxbsHg5NW+Rus29zp/42eukdlgrDzr/Eu/kEqPG7PjpUCc
	 FqhacDVfeHXBng2yUDUoInQNYhnXUFrH8sUgZEwozMmAkSTuML3R3ueah/wpqFP+w2
	 grolg6pPg0CSdkLqRtKORx31+lKc8Pjv64NofWt5yWphPWKWIXKQS/tljsKpONtvSN
	 cNc8HIiHSDvAw==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Mostafa Saleh <smostafa@google.com>,
	Alexander.Deucher@amd.com,
	Thomas.Lendacky@amd.com,
	Vasant.Hegde@amd.com,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Timo Witte <timo.witte@gmail.com>
Subject: [PATCH] x86/mm: Don't force unencrypted DMA for IOMMU-backed devices
Date: Tue,  8 Sep 2026 17:02:32 +0530
Message-ID: <20260908113232.247457-1-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 8277a12d0d60 ("dma-pool: track decrypted atomic pools and select
them via attrs") exposed an issue with force_dma_unencrypted() on
systems using host memory encryption.

force_dma_unencrypted() checks whether the device DMA mask can address
the encryption bit and, if not, requires DMA allocations to use
unencrypted memory. However, this check is not applicable when the
device is using the IOMMU. In that case, the device DMA mask constrains
the IOVA seen by the device, not the backing physical address, so it
does not need to cover the C-bit.

This currently causes dma_alloc_attrs() to set
__DMA_ATTR_ALLOC_CC_SHARED for such devices. iommu_dma_alloc() does not
support that attribute and rejects the allocation, causing DMA
allocations to fail.

Do not force DMA allocations to be unencrypted when the device is using
the IOMMU. This allows the IOMMU to map the encrypted physical pages as
before and avoids incorrectly requesting CC_SHARED allocations.

Fixes: 8277a12d0d60 ("dma-pool: track decrypted atomic pools and select them via attrs")
Reported-by: Timo Witte <timo.witte@gmail.com>
Link: https://lore.kernel.org/all/CANB4YXR7h8V5Xp=MXVZeSdvw9UiriSagp=E+ju5RRDNghoPHLQ@mail.gmail.com
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/x86/mm/mem_encrypt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 912f22ca838f..a349d8d21569 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -13,6 +13,7 @@
 #include <linux/cc_platform.h>
 #include <linux/mem_encrypt.h>
 #include <linux/virtio_anchor.h>
+#include <linux/iommu-dma.h>
 
 #include <asm/sev.h>
 
@@ -30,7 +31,7 @@ bool force_dma_unencrypted(struct device *dev)
 	 * device does not support DMA to addresses that include the
 	 * encryption mask.
 	 */
-	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
+	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT) && !use_dma_iommu(dev)) {
 		u64 dma_enc_mask = DMA_BIT_MASK(__ffs64(sme_me_mask));
 		u64 dma_dev_mask = min_not_zero(dev->coherent_dma_mask,
 						dev->bus_dma_limit);
-- 
2.43.0

