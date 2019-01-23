From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/intel: quirk to disable DMAR for QM57 igfx
Date: Wed, 23 Jan 2019 17:49:59 +0100
Message-ID: <20190123164959.GF32526@8bytes.org>
References: <154642214920.6261.102817444136744919@jlahtine-desk.ger.corp.intel.com>
 <20190104010626.e6yqdqkmdcqjepke@dcvr>
 <154659116310.4596.13613897418163029789@jlahtine-desk.ger.corp.intel.com>
 <20190118121705.a4usvhnskyblooja@dcvr>
 <20190122103914.msboylvkor5sb5lq@8bytes.org>
 <CAKMK7uEX1T6_yXoq_d4Fs2LiWC_tDaEEXv-hTL=S-_4HEeya7A@mail.gmail.com>
 <20190122110109.x3zoynemdl3ysbsn@8bytes.org>
 <154816850584.8871.13562920355478587539@jlahtine-desk.ger.corp.intel.com>
 <20190122165135.6rkdsxqepvmaoatn@8bytes.org>
 <154825575844.19121.1110495981060533179@jlahtine-desk.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <154825575844.19121.1110495981060533179@jlahtine-desk.ger.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Daniel Vetter <daniel@ffwll.ch>, Eric Wong <e@80x24.org>, David Woodhouse <dwmw2@infradead.org>, David Airlie <airlied@linux.ie>, Jani Nikula <jani.nikula@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel <dri-devel@lists.freedesktop.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Jan 23, 2019 at 05:02:38PM +0200, Joonas Lahtinen wrote:
> We have many reports where just having intel_iommu=on (and using the
> system normally, without any virtualization stuff going on) will cause
> unexplained GPU hangs. For those users, simply switching to
> intel_iommu=igfx_off solves the problems, and the debug often ends
> there.

If you can reproduce problems on your side, then you can try to enable
CONFIG_INTEL_IOMMU_BROKEN_GFX_WA to force the GFX devices into the
identity mapping. We can also add a boot-parameter and workarounds if it
turns out that this is sufficient to make the GFX devices work with
IOMMU enabled.


Regards,

	Joerg
