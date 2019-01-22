From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/intel: quirk to disable DMAR for QM57 igfx
Date: Tue, 22 Jan 2019 17:51:35 +0100
Message-ID: <20190122165135.6rkdsxqepvmaoatn@8bytes.org>
References: <20181227114948.ev4b3jte3ubsc5us@dcvr>
 <154642214920.6261.102817444136744919@jlahtine-desk.ger.corp.intel.com>
 <20190104010626.e6yqdqkmdcqjepke@dcvr>
 <154659116310.4596.13613897418163029789@jlahtine-desk.ger.corp.intel.com>
 <20190118121705.a4usvhnskyblooja@dcvr>
 <20190122103914.msboylvkor5sb5lq@8bytes.org>
 <CAKMK7uEX1T6_yXoq_d4Fs2LiWC_tDaEEXv-hTL=S-_4HEeya7A@mail.gmail.com>
 <20190122110109.x3zoynemdl3ysbsn@8bytes.org>
 <154816850584.8871.13562920355478587539@jlahtine-desk.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <154816850584.8871.13562920355478587539@jlahtine-desk.ger.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Daniel Vetter <daniel@ffwll.ch>, Eric Wong <e@80x24.org>, David Woodhouse <dwmw2@infradead.org>, David Airlie <airlied@linux.ie>, Jani Nikula <jani.nikula@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel <dri-devel@lists.freedesktop.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Jan 22, 2019 at 04:48:26PM +0200, Joonas Lahtinen wrote:
> According to our IOMMU folks there exists some desire to be able to assign
> the iGFX device aka have intel_iommu=on instead of intel_iommu=igfx_off
> due to how the devices might be grouped in IOMMU groups. Even when you
> would not be using the iGFX device.

You can force the igfx device into a SI domain, or does that also
trigger the iommu issues on the chipset?

In any case, if iommu=on breaks these systems I want to make them work
again with opt-out, even at the cost of breaking assignability.

Regards,

	Joerg
