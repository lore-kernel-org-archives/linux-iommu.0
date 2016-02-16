From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v8 3/5] memory: mediatek: Add SMI driver
Date: Tue, 16 Feb 2016 16:20:00 +0000
Message-ID: <20160216162000.GI14509@arm.com>
References: <1453781562-23556-1-git-send-email-yong.wu@mediatek.com>
 <1453781562-23556-4-git-send-email-yong.wu@mediatek.com>
 <56ADE959.2050309@gmail.com>
 <20160216141059.GT18805@8bytes.org>
 <56C340FB.1050607@arm.com>
 <20160216161009.GW18805@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160216161009.GW18805@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, youhua.li@mediatek.com, Thierry Reding <treding@nvidia.com>, devicetree@vger.kernel.org, kendrick.hsu@mediatek.com, Sasha Hauer <kernel@pengutronix.de>, arnd@arndb.de, Tomasz Figa <tfiga@google.com>, Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, pebolle@tiscali.nl, srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Daniel Kurtz <djkurtz@google.com>, p.zabel@pengutronix.de, Lucas Stach <l.stach@pengutronix.de>
List-Id: iommu@lists.linux-foundation.org

On Tue, Feb 16, 2016 at 05:10:09PM +0100, Joerg Roedel wrote:
> On Tue, Feb 16, 2016 at 03:32:11PM +0000, Robin Murphy wrote:
> > On 16/02/16 14:11, Joerg Roedel wrote:
> > >On Sun, Jan 31, 2016 at 12:00:41PM +0100, Matthias Brugger wrote:
> > >>On 26/01/16 05:12, Yong Wu wrote:
> > >>>This patch add SMI(Smart Multimedia Interface) driver. This driver
> > >>>is responsible to enable/disable iommu and control the power domain
> > >>>and clocks of each local arbiter.
> > >>>
> > >>>Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > >>>Tested-by: Philipp Zabel <p.zabel@pengutronix.de>
> > >>>---
> > >>
> > >>Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> > >>
> > >>Joerg would you mind to take this through your branch?
> > >
> > >Hmm, I somehow missed the patch-set, at least I can't find the v8
> > >patches in my inbox.
> > >
> > >Yong, can you please re-send with all Acks and other tags added?
> > 
> > Just to note patch 4 of this series also depends on the v3
> > io-pgtable short-descriptor series posted separately[1] - is that on
> > your radar already or would you like that resent as well?
> 
> No, that was not on my radar, I somehow expected Will to handle this
> series :)

I'm more than happy to bake a branch containing all the page table stuff,
but Yong's stuff depends on it so I'll work with whatever is easiest for
you.

Will
