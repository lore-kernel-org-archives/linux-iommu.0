From: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Subject: [RESEND PATCH] kernel/dma/direct: Do not include SME mask in the DMA
 supported check
Date: Mon, 17 Dec 2018 14:39:16 +0000
Message-ID: <8e875df2cf082ec6eeaf5e713bf9fa987325308d.1545057470.git.thomas.lendacky@amd.com>
References: <20181213225110.6567.69313.stgit@tlendack-t1.amdoffice.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181213225110.6567.69313.stgit@tlendack-t1.amdoffice.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Christoph Hellwig <hch@lst.de>, Alexander Duyck <alexander.duyck@gmail.com>, Robin Murphy <robin.murphy@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Guenter Roeck <linux@roeck-us.net>, Greg KH <gregkh@linuxfoundation.org>
List-Id: iommu@lists.linux-foundation.org

The dma_direct_supported() function intends to check the DMA mask against
specific values. However, the phys_to_dma() function includes the SME
encryption mask, which defeats the intended purpose of the check. This
results in drivers that support less than 48-bit DMA (SME encryption mask
is bit 47) from being able to set the DMA mask successfully when SME is
active, which results in the driver failing to initialize.

Change the function used to check the mask from phys_to_dma() to
__phys_to_dma() so that the SME encryption mask is not part of the check.

Fixes: c1d0af1a1d5d ("kernel/dma/direct: take DMA offset into account in dm=
a_direct_supported")
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 kernel/dma/direct.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 22a12ab..375c77e 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -309,7 +309,12 @@ int dma_direct_supported(struct device *dev, u64 mask)
=20
 	min_mask =3D min_t(u64, min_mask, (max_pfn - 1) << PAGE_SHIFT);
=20
-	return mask >=3D phys_to_dma(dev, min_mask);
+	/*
+	 * This check needs to be against the actual bit mask value, so
+	 * use __phys_to_dma() here so that the SME encryption mask isn't
+	 * part of the check.
+	 */
+	return mask >=3D __phys_to_dma(dev, min_mask);
 }
=20
 int dma_direct_mapping_error(struct device *dev, dma_addr_t dma_addr)
--=20
1.9.1
