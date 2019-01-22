From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: Re: [PATCH] iommu/intel: quirk to disable DMAR for QM57 igfx
Date: Tue, 22 Jan 2019 16:48:26 +0200
Message-ID: <154816850584.8871.13562920355478587539@jlahtine-desk.ger.corp.intel.com>
References: <20181227114948.ev4b3jte3ubsc5us@dcvr>
 <154642214920.6261.102817444136744919@jlahtine-desk.ger.corp.intel.com>
 <20190104010626.e6yqdqkmdcqjepke@dcvr>
 <154659116310.4596.13613897418163029789@jlahtine-desk.ger.corp.intel.com>
 <20190118121705.a4usvhnskyblooja@dcvr>
 <20190122103914.msboylvkor5sb5lq@8bytes.org>
 <CAKMK7uEX1T6_yXoq_d4Fs2LiWC_tDaEEXv-hTL=S-_4HEeya7A@mail.gmail.com>
 <20190122110109.x3zoynemdl3ysbsn@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190122110109.x3zoynemdl3ysbsn@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Eric Wong <e@80x24.org>, David Woodhouse <dwmw2@infradead.org>, David Airlie <airlied@linux.ie>, Jani Nikula <jani.nikula@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel <dri-devel@lists.freedesktop.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

Quoting Joerg Roedel (2019-01-22 13:01:09)
> Hi Daniel,
> 
> On Tue, Jan 22, 2019 at 11:46:39AM +0100, Daniel Vetter wrote:
> > Note that the string of platforms which have various issues with iommu
> > and igfx is very long, thus far we only disabled it where there's no
> > workaround to stop it from hanging the box, but otherwise left it
> > enabled. So if we make a policy change to also disable it anywhere
> > where it doesn't work well (instead of not at all), there's a pile
> > more platforms to switch.
> 
> I think its best to just disable iommu for the igfx devices on these
> platforms. Can you pick up Eric's patch and extend it with the list of
> affected platforms?

We've been discussing this again more actively since a few months ago,
and the discussion is still ongoing internally.

According to our IOMMU folks there exists some desire to be able to assign
the iGFX device aka have intel_iommu=on instead of intel_iommu=igfx_off
due to how the devices might be grouped in IOMMU groups. Even when you
would not be using the iGFX device.

So for some uses, the fact that the device (group) is assignable seems
to be more important than the iGFX device to be working. I'm afraid
that retroactively disabling the assignment for such an old platform
might break those usage scenarios. By my quick reading of the code,
there's no way for user to turn the iGFX DMAR on once the quirk
disables it.

I guess one solution would be to default to intel_iommu=igfx_off for
platforms that are older than certain threshold. But still allow
user to enable. But that then requires duplicating the PCI ID database
into iommu code.

I don't really have winning moves to present, but I'm open to hearing
how we can avoid more damage than starting to default to intel_iommu=on
did already.

Regards, Joonas

> 
> Thanks,
> 
>         Joerg
