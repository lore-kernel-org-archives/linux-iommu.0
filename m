Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBDA3732E
	for <iommu@lists.linux.dev>; Wed,  7 Jun 2023 17:19:32 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 230E0AB6;
	Wed,  7 Jun 2023 10:20:11 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A1B193F71E;
	Wed,  7 Jun 2023 10:19:24 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	hch@infradead.org,
	stable@vger.kernel.org,
	Jason Adriaanse <jason_a69@yahoo.co.uk>
Subject: [PATCH RESEND] PCI: Add function 1 DMA alias quirk for Marvell 88SE9235
Date: Wed,  7 Jun 2023 18:18:47 +0100
Message-Id: <731507e05d70239aec96fcbfab6e65d8ce00edd2.1686157165.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Marvell's own product brief implies the 92xx series are a closely
related family, and sure enough it turns out that 9235 seems to need the
same quirk as the other three, although possibly only when certain ports
are used.

CC: stable@vger.kernel.org
Reported-by: Jason Adriaanse <jason_a69@yahoo.co.uk>
Link: https://lore.kernel.org/linux-iommu/2a699a99-545c-1324-e052-7d2f41fed1ae@yahoo.co.uk/
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

Note that the actual regression which started the thread is a different
matter, wherein a particular combination of parameters which used to put
intel-iommu into passthrough mode now enables full translation instead.

Take #2, hopefully not royally screwing up my email alises this time.
Sorry about that...

 drivers/pci/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index f4e2a88729fd..3186f2c84eab 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4174,6 +4174,8 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9220,
 /* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c49 */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9230,
 			 quirk_dma_func1_alias);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9235,
+			 quirk_dma_func1_alias);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TTI, 0x0642,
 			 quirk_dma_func1_alias);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TTI, 0x0645,
-- 
2.39.2.101.g768bb238c484.dirty

