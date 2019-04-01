From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3 1/3] iommu: io-pgtable: Add ARM Mali midgard MMU page
 table format
Date: Mon, 1 Apr 2019 20:11:00 +0100
Message-ID: <8d091874-11b0-e348-c4f1-dd1bcfa4bf97@arm.com>
References: <20190401074730.12241-1-robh@kernel.org>
 <20190401074730.12241-2-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190401074730.12241-2-robh@kernel.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>, dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, Lyude Paul <lyude@redhat.com>, Eric Anholt <eric@anholt.net>, Neil Armstrong <narmstrong@baylibre.com>
List-Id: iommu@lists.linux-foundation.org

On 01/04/2019 08:47, Rob Herring wrote:
> ARM Mali midgard GPU is similar to standard 64-bit stage 1 page tables, but
> have a few differences. Add a new format type to represent the format. The
> input address size is 48-bits and the output address size is 40-bits (and
> possibly less?). Note that the later bifrost GPUs follow the standard
> 64-bit stage 1 format.
> 
> The differences in the format compared to 64-bit stage 1 format are:
> 
> The 3rd level page entry bits are 0x1 instead of 0x3 for page entries.
> 
> The access flags are not read-only and unprivileged, but read and write.
> This is similar to stage 2 entries, but the memory attributes field matches
> stage 1 being an index.
> 
> The nG bit is not set by the vendor driver. This one didn't seem to matter,
> but we'll keep it aligned to the vendor driver.
> 
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: iommu@lists.linux-foundation.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Please ack this as I need to apply it to the drm-misc tree. Or we need a
> stable branch with this patch.

With the diff below squashed in to address my outstanding style nits,

Acked-by: Robin Murphy <robin.murphy@arm.com>

I don't foresee any conflicting io-pgtable changes to prevent this going 
via DRM, but I'll leave the final say up to Joerg.

Thanks,
Robin.

----->8-----
diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 98551d0cff59..55ed039da166 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -197,12 +197,13 @@ struct arm_lpae_io_pgtable {

  typedef u64 arm_lpae_iopte;

-static inline bool iopte_leaf(arm_lpae_iopte pte, int l, enum 
io_pgtable_fmt fmt)
+static inline bool iopte_leaf(arm_lpae_iopte pte, int lvl,
+			      enum io_pgtable_fmt fmt)
  {
-	if ((l == (ARM_LPAE_MAX_LEVELS - 1)) && (fmt != ARM_MALI_LPAE))
-		return iopte_type(pte,l) == ARM_LPAE_PTE_TYPE_PAGE;
+	if (lvl == (ARM_LPAE_MAX_LEVELS - 1) && fmt != ARM_MALI_LPAE)
+		return iopte_type(pte, lvl) == ARM_LPAE_PTE_TYPE_PAGE;

-	return iopte_type(pte,l) == ARM_LPAE_PTE_TYPE_BLOCK;
+	return iopte_type(pte, lvl) == ARM_LPAE_PTE_TYPE_BLOCK;
  }

  static arm_lpae_iopte paddr_to_iopte(phys_addr_t paddr,
@@ -310,13 +311,10 @@ static void __arm_lpae_init_pte(struct 
arm_lpae_io_pgtable *data,
  	if (data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_NS)
  		pte |= ARM_LPAE_PTE_NS;

-	if (lvl == ARM_LPAE_MAX_LEVELS - 1) {
-		if (data->iop.fmt == ARM_MALI_LPAE)
-			pte |= ARM_LPAE_PTE_TYPE_BLOCK;
-		else
-			pte |= ARM_LPAE_PTE_TYPE_PAGE;
-	} else
+	if (data->iop.fmt != ARM_MALI_LPAE && lvl != ARM_LPAE_MAX_LEVELS - 1)
  		pte |= ARM_LPAE_PTE_TYPE_BLOCK;
+	else
+		pte |= ARM_LPAE_PTE_TYPE_PAGE;

  	if (data->iop.fmt != ARM_MALI_LPAE)
  		pte |= ARM_LPAE_PTE_AF;
