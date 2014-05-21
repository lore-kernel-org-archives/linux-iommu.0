From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] devicetree: Add generic IOMMU device tree bindings
Date: Wed, 21 May 2014 18:01:06 +0200
Message-ID: <4376848.aihqtRyYDl@wuerfel>
References: <1400242998-437-1-git-send-email-thierry.reding@gmail.com> <11242680.PQytQQqlPJ@wuerfel> <CANEJEGvhEsC9wKqX_pYmOg7LwsQkoN9=jjXJuW0UeEa9XywSPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CANEJEGvhEsC9wKqX_pYmOg7LwsQkoN9=jjXJuW0UeEa9XywSPw@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Grant Grundler <grundler@chromium.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Thierry Reding <thierry.reding@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Linux DeviceTree <devicetree@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Joerg Roedel <joro@8bytes.org>, Stephen Warren <swarren@wwwdotorg.org>, Will Deacon <will.deacon@arm.com>, LKML <linux-kernel@vger.kernel.org>, Marc Zyngier <marc.zyngier@arm.com>, Linux IOMMU <iommu@lists.linux-foundation.org>, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>, linux-tegra@vger.kernel.org, Cho KyongHo <pullip.cho@samsung.com>, Dave Martin <Dave.Martin@arm.com>
List-Id: iommu@lists.linux-foundation.org

On Wednesday 21 May 2014 08:44:42 Grant Grundler wrote:
> On Wed, May 21, 2014 at 2:32 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Wednesday 21 May 2014 11:02:45 Thierry Reding wrote:
> >> On Wed, May 21, 2014 at 10:54:42AM +0200, Arnd Bergmann wrote:
> >>
> >> > Right. As long as we always unmap the buffers from the IOMMU after they
> >> > have stopped being in use, it's very unlikely that even a broken device
> >> > driver causes a DMA into some bus address that happens to be mapped for
> >> > another device.
> >>
> >> I think that if buffers remain mapped in the IOMMU when they have been
> >> deallocated that should be considered a bug.
> 
> There is currently no general requirement to tear down mappings immediately.
> An option to enforce immediate tear down might be useful since I agree
> Virtual Guests sharing host memory through shared physical devices
> will want that. ie there should be no opportunity for a shared device
> to be able to access another guests memory through "stale" (but live)
> DMA mappings. I don't think that's the case but I'd ask someone like
> Alex Williamson for a more certain answer.

I believe powerpc has a boot-time option to enforce the immediate
IOTLB flush, which is very useful for device driver debugging when
something goes wrong with stale DMAs.

> > Obviously you have to maintain the IO page tables correctly.
> 
> To be clear, "Correctly" in this case just means until the IOTLB is
> flushed, the given IOMMU Pdir entries are marked "in use" even though
> the driver has handed "ownership" back to the IOMMU driver.

I don't know what a Pdir is, but I guess strictly speaking we have
to ensure that all IO page table entries that have been unmapped by
a driver are marked as invalid at least by the time the IOTLB is flushed,
plus we have to flush each entry before it gets reused for a different
page.

	Arnd
