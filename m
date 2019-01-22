From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/intel: quirk to disable DMAR for QM57 igfx
Date: Tue, 22 Jan 2019 11:39:14 +0100
Message-ID: <20190122103914.msboylvkor5sb5lq@8bytes.org>
References: <20181227114948.ev4b3jte3ubsc5us@dcvr>
 <154642214920.6261.102817444136744919@jlahtine-desk.ger.corp.intel.com>
 <20190104010626.e6yqdqkmdcqjepke@dcvr>
 <154659116310.4596.13613897418163029789@jlahtine-desk.ger.corp.intel.com>
 <20190118121705.a4usvhnskyblooja@dcvr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190118121705.a4usvhnskyblooja@dcvr>
Sender: linux-kernel-owner@vger.kernel.org
To: Eric Wong <e@80x24.org>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, David Woodhouse <dwmw2@infradead.org>, Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>, Jani Nikula <jani.nikula@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, iommu@lists.linux-foundation.org, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Jan 18, 2019 at 12:17:05PM +0000, Eric Wong wrote:
> @@ -5411,6 +5411,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2e20, quirk_iommu_g4x_gfx);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2e30, quirk_iommu_g4x_gfx);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2e40, quirk_iommu_g4x_gfx);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2e90, quirk_iommu_g4x_gfx);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0044, quirk_iommu_g4x_gfx);
>  
>  static void quirk_iommu_rwbf(struct pci_dev *dev)
>  {
> @@ -5457,7 +5458,6 @@ static void quirk_calpella_no_shadow_gtt(struct pci_dev *dev)
>         }
>  }
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0040, quirk_calpella_no_shadow_gtt);
> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0044, quirk_calpella_no_shadow_gtt);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0062, quirk_calpella_no_shadow_gtt);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x006a, quirk_calpella_no_shadow_gtt);

This seems to make sense to me. Joonas, any comments or objections?

Regards,

	Joerg
